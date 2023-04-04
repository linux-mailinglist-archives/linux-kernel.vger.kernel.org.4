Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412886D59AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjDDHbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjDDHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:31:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988AF10D3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:31:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1pjb8g-00088U-N1; Tue, 04 Apr 2023 09:31:34 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1pjb8c-008rdY-LS; Tue, 04 Apr 2023 09:31:30 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1pjb8b-00DJgH-LJ; Tue, 04 Apr 2023 09:31:29 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Robin van der Gracht <robin@protonic.nl>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shuangpeng Bai <sjb7183@psu.edu>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] net: can: j1939: Fix out-of-bounds memory access in j1939_tp_tx_dat_new
Date:   Tue,  4 Apr 2023 09:31:28 +0200
Message-Id: <20230404073128.3173900-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

In the j1939_tp_tx_dat_new function, an out-of-bounds memory access
could occur during the memcpy operation if the size of skb->cb is
larger than the size of struct j1939_sk_buff_cb. This is because the
memcpy operation uses the size of skb->cb, leading to a read beyond
the struct j1939_sk_buff_cb.

To address this issue, we have updated the memcpy operation to use the
size of struct j1939_sk_buff_cb instead of the size of skb->cb. This
ensures that the memcpy operation only reads the memory within the
bounds of struct j1939_sk_buff_cb, preventing out-of-bounds memory
access.

Additionally, a static_assert has been added to check that the size of
skb->cb is greater than or equal to the size of struct j1939_sk_buff_cb.
This ensures that the skb->cb buffer is large enough to hold the
j1939_sk_buff_cb structure.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: Shuangpeng Bai <sjb7183@psu.edu>
Tested-by: Shuangpeng Bai <sjb7183@psu.edu>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fb92c3609e17..fe3df23a2595 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -604,7 +604,10 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
-	memcpy(skb->cb, re_skcb, sizeof(skb->cb));
+	/* skb->cb must be large enough to hold a j1939_sk_buff_cb structure */
+	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(*re_skcb));
+
+	memcpy(skb->cb, re_skcb, sizeof(*re_skcb));
 	skcb = j1939_skb_to_cb(skb);
 	if (swap_src_dst)
 		j1939_skbcb_swap(skcb);
-- 
2.39.2

