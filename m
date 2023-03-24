Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477976C7E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjCXNCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCXNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:01:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D002C1F930
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:01:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1pfh3H-0001HZ-53; Fri, 24 Mar 2023 14:01:51 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1pfh39-006O5F-EK; Fri, 24 Mar 2023 14:01:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1pfh38-008wqg-My; Fri, 24 Mar 2023 14:01:42 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Robin van der Gracht <robin@protonic.nl>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        syzbot+ee1cd780f69483a8616b@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] can: j1939: prevent deadlock by moving j1939_sk_errqueue()
Date:   Fri, 24 Mar 2023 14:01:41 +0100
Message-Id: <20230324130141.2132787-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit addresses a deadlock situation that can occur in certain
scenarios, such as when running data TP/ETP transfer and subscribing to
the error queue while receiving a net down event. The deadlock involves
locks in the following order:

3
  j1939_session_list_lock ->  active_session_list_lock
  j1939_session_activate
  ...
  j1939_sk_queue_activate_next -> sk_session_queue_lock
  ...
  j1939_xtp_rx_eoma_one

2
  j1939_sk_queue_drop_all  ->  sk_session_queue_lock
  ...
  j1939_sk_netdev_event_netdown -> j1939_socks_lock
  j1939_netdev_notify

1
  j1939_sk_errqueue -> j1939_socks_lock
  __j1939_session_cancel -> active_session_list_lock
  j1939_tp_rxtimer

       CPU0                    CPU1
       ----                    ----
  lock(&priv->active_session_list_lock);
                               lock(&jsk->sk_session_queue_lock);
                               lock(&priv->active_session_list_lock);
  lock(&priv->j1939_socks_lock);

The solution implemented in this commit is to move the
j1939_sk_errqueue() call out of the active_session_list_lock context,
thus preventing the deadlock situation.

Reported-by: syzbot+ee1cd780f69483a8616b@syzkaller.appspotmail.com
Fixes: 5b9272e93f2e ("can: j1939: extend UAPI to notify about RX status")
Co-developed-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fce9b9ebf13f..fb92c3609e17 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1124,8 +1124,6 @@ static void __j1939_session_cancel(struct j1939_session *session,
 
 	if (session->sk)
 		j1939_sk_send_loop_abort(session->sk, session->err);
-	else
-		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
 }
 
 static void j1939_session_cancel(struct j1939_session *session,
@@ -1140,6 +1138,9 @@ static void j1939_session_cancel(struct j1939_session *session,
 	}
 
 	j1939_session_list_unlock(session->priv);
+
+	if (!session->sk)
+		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
 }
 
 static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
@@ -1253,6 +1254,9 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
 		}
 		j1939_session_list_unlock(session->priv);
+
+		if (!session->sk)
+			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
 	}
 
 	j1939_session_put(session);
-- 
2.30.2

