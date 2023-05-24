Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCE270F4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjEXLBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEXLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:01:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A1B7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:01:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d44b198baso529588b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684926089; x=1687518089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MlhFitbDMZP7hCQbdHVoNuEXl+NL0ZynFialB8QGO0Y=;
        b=hqgqSp8p6fg7qL4ZjMoY2COLrFUlRYy/RquBeTwgV8wDs2/2TSNB26j/fWv3zOXz1X
         B1AA0Oxx4SdBTE7G6P9LvV/AqTgToRdvfvbRoTgOZ3yWookt66AdHwlaHtko7xK2wuf3
         wFWfcYUlYeGGbqA8boIcz3sCNzTzeId4Stvc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684926089; x=1687518089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlhFitbDMZP7hCQbdHVoNuEXl+NL0ZynFialB8QGO0Y=;
        b=BcMCBYcylhG/kaG/XMQjpzo75zPSRcvKaAydftp4gbkhtxQZQYyENa1TRIQm0PCsPk
         SaZFG4yC7GcSfZMOHoOeo2rXdaA4S9Ba09UeJpW1QcBiQRl2dG/GfTVoVC70rWEBce7z
         vNjDr2a+8+d+/z3GNopTinxjDMaLHuVMARAH4NFnpzmpq0ZPB1wTJBtRxNAjZWkc7ZM2
         jBPMMcw7IZ2csK/dWrF7KiPQGI/KJoDIWMMsgReRdW9HitPgnXUIoQ0mfF8ZZOflf0QH
         Coj5PX09uSvOlniqvgTtPlyoNbzrvSiD5xPNdk6wJEKiuKIfPCkXw7vu2sXOmuBHDmnn
         MQAQ==
X-Gm-Message-State: AC+VfDyFd9Vl9s/pqRygFMEWEmRUj9hX9EZSPW1fUdgTnPq6NbdcS88M
        wiO3QYkrRnFWrS3ZXuGL/oXAlA==
X-Google-Smtp-Source: ACHHUZ7TKWb9UWfZXWXmF+S12uaUUjdqdzck6N+WWHPWQssG+IjFKnbU1WolIUCxB0LT/ePGwioTIg==
X-Received: by 2002:a05:6a20:394e:b0:103:e813:77a1 with SMTP id r14-20020a056a20394e00b00103e81377a1mr21068407pzg.15.1684926088996;
        Wed, 24 May 2023 04:01:28 -0700 (PDT)
Received: from localhost (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with UTF8SMTPSA id 10-20020a63060a000000b00502fd70b0bdsm7627969pgg.52.2023.05.24.04.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 04:01:28 -0700 (PDT)
From:   Ying Hsu <yinghsu@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Fix l2cap_disconnect_req deadlock
Date:   Wed, 24 May 2023 11:00:00 +0000
Message-ID: <20230524110119.602679-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L2CAP assumes that the locks conn->chan_lock and chan->lock are
acquired in the order conn->chan_lock, chan->lock to avoid
potential deadlock.
For example, l2sock_shutdown acquires these locks in the order:
  mutex_lock(&conn->chan_lock)
  l2cap_chan_lock(chan)

However, l2cap_disconnect_req acquires chan->lock in
l2cap_get_chan_by_scid first and then acquires conn->chan_lock
before calling l2cap_chan_del. This means that these locks are
acquired in unexpected order, which leads to potential deadlock:
  l2cap_chan_lock(c)
  mutex_lock(&conn->chan_lock)

This patch uses __l2cap_get_chan_by_scid to replace
l2cap_get_chan_by_scid and adjusts the locking order to avoid the
potential deadlock.

Fixes: ("a2a9339e1c9d Bluetooth: L2CAP: Fix use-after-free in l2cap_disconnect_{req,rsp}")
Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
This commit has been tested on a Chromebook device.

Changes in v3:
- Adding the fixes tag.

Changes in v2:
- Adding the prefix "Bluetooth:" to subject line.

 net/bluetooth/l2cap_core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 376b523c7b26..7374e3d046da 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4651,8 +4651,15 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
 
-	chan = l2cap_get_chan_by_scid(conn, dcid);
+	mutex_lock(&conn->chan_lock);
+	chan = __l2cap_get_chan_by_scid(conn, dcid);
+	if (chan) {
+		chan = l2cap_chan_hold_unless_zero(chan);
+		if (chan)
+			l2cap_chan_lock(chan);
+	}
 	if (!chan) {
+		mutex_unlock(&conn->chan_lock);
 		cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid);
 		return 0;
 	}
@@ -4663,14 +4670,13 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	chan->ops->set_shutdown(chan);
 
-	mutex_lock(&conn->chan_lock);
 	l2cap_chan_del(chan, ECONNRESET);
-	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan);
 
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
+	mutex_unlock(&conn->chan_lock);
 
 	return 0;
 }
@@ -4691,25 +4697,32 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
 
-	chan = l2cap_get_chan_by_scid(conn, scid);
+	mutex_lock(&conn->chan_lock);
+	chan = __l2cap_get_chan_by_scid(conn, scid);
+	if (chan) {
+		chan = l2cap_chan_hold_unless_zero(chan);
+		if (chan)
+			l2cap_chan_lock(chan);
+	}
 	if (!chan) {
+		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
 	if (chan->state != BT_DISCONN) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
+		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
-	mutex_lock(&conn->chan_lock);
 	l2cap_chan_del(chan, 0);
-	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan);
 
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
+	mutex_unlock(&conn->chan_lock);
 
 	return 0;
 }
-- 
2.40.1.698.g37aff9b760-goog

