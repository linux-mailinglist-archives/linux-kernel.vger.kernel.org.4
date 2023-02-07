Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B420B68E113
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjBGTXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjBGTXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:23:34 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E03722DC7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:23:34 -0800 (PST)
Received: from dslb-178-004-202-208.178.004.pools.vodafone-ip.de ([178.4.202.208] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pPTYt-0002XK-3T; Tue, 07 Feb 2023 20:23:27 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/7] staging: r8188eu: merge do_queue_select into its only caller
Date:   Tue,  7 Feb 2023 20:23:13 +0100
Message-Id: <20230207192319.294203-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230207192319.294203-1-martin@kaiser.cx>
References: <20230207192319.294203-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge do_queue_select into its only caller. It's only a simple assignment.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 18941320e70e..4d6210d89533 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1609,15 +1609,6 @@ u32 rtw_get_ff_hwaddr(struct xmit_frame *pxmitframe)
 	return addr;
 }
 
-static void do_queue_select(struct adapter	*padapter, struct pkt_attrib *pattrib)
-{
-	u8 qsel;
-
-	qsel = pattrib->priority;
-
-	pattrib->qsel = qsel;
-}
-
 /*
  * The main transmit(tx) entry
  *
@@ -1656,7 +1647,7 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 
 	rtw_led_control(padapter, LED_CTL_TX);
 
-	do_queue_select(padapter, &pxmitframe->attrib);
+	pxmitframe->attrib.qsel = pxmitframe->attrib.priority;
 
 	spin_lock_bh(&pxmitpriv->lock);
 	if (xmitframe_enqueue_for_sleeping_sta(padapter, pxmitframe)) {
-- 
2.30.2

