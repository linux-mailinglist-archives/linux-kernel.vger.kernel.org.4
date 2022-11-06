Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23E61E22C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiKFMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiKFMtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:49:16 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1AD647E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 04:49:15 -0800 (PST)
Received: from ipservice-092-217-068-220.092.217.pools.vodafone-ip.de ([92.217.68.220] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1orf5K-0008Dj-HH; Sun, 06 Nov 2022 13:49:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/9] staging: r8188eu: reorder assignments, clarify the header format
Date:   Sun,  6 Nov 2022 13:48:55 +0100
Message-Id: <20221106124901.720785-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221106124901.720785-1-martin@kaiser.cx>
References: <20221106124901.720785-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder some of the assignments in update_recvframe_attrib_88e.

This should make it a bit easier to understand the format of the header
that is added by the chip's firmware.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index 9a61eef8550b..d1ac2960f1c4 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -66,28 +66,25 @@ void update_recvframe_attrib_88e(struct recv_frame *precvframe, struct recv_stat
 
 	if (pattrib->pkt_rpt_type == NORMAL_RX) {
 		pattrib->pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x00003fff;
+		pattrib->icv_err = (le32_to_cpu(prxstat->rxdw0) >> 15) & 0x1;
 		pattrib->drvinfo_sz = ((le32_to_cpu(prxstat->rxdw0) >> 16) & 0xf) * 8;
-
+		pattrib->encrypt = (u8)((le32_to_cpu(prxstat->rxdw0) >> 20) & 0x7);
+		pattrib->qos = (le32_to_cpu(prxstat->rxdw0) >> 23) & 0x1;
+		pattrib->shift_sz = (le32_to_cpu(prxstat->rxdw0) >> 24) & 0x3;
 		pattrib->physt = (le32_to_cpu(prxstat->rxdw0) >> 26) & 0x1;
-
 		pattrib->bdecrypted = (le32_to_cpu(prxstat->rxdw0) & BIT(27)) ? 0 : 1;
-		pattrib->encrypt = (le32_to_cpu(prxstat->rxdw0) >> 20) & 0x7;
 
-		pattrib->qos = (le32_to_cpu(prxstat->rxdw0) >> 23) & 0x1;
 		pattrib->priority = (le32_to_cpu(prxstat->rxdw1) >> 8) & 0xf;
-
 		pattrib->amsdu = (le32_to_cpu(prxstat->rxdw1) >> 13) & 0x1;
+		pattrib->mdata = (le32_to_cpu(prxstat->rxdw1) >> 26) & 0x1;
+		pattrib->mfrag = (le32_to_cpu(prxstat->rxdw1) >> 27) & 0x1;
 
 		pattrib->seq_num = le32_to_cpu(prxstat->rxdw2) & 0x00000fff;
 		pattrib->frag_num = (le32_to_cpu(prxstat->rxdw2) >> 12) & 0xf;
-		pattrib->mfrag = (le32_to_cpu(prxstat->rxdw1) >> 27) & 0x1;
-		pattrib->mdata = (le32_to_cpu(prxstat->rxdw1) >> 26) & 0x1;
 
 		pattrib->mcs_rate = le32_to_cpu(prxstat->rxdw3) & 0x3f;
 		pattrib->rxht = (le32_to_cpu(prxstat->rxdw3) >> 6) & 0x1;
 
-		pattrib->icv_err = (le32_to_cpu(prxstat->rxdw0) >> 15) & 0x1;
-		pattrib->shift_sz = (le32_to_cpu(prxstat->rxdw0) >> 24) & 0x3;
 	} else if (pattrib->pkt_rpt_type == TX_REPORT1) { /* CCX */
 		pattrib->pkt_len = TX_RPT1_PKT_LEN;
 	} else if (pattrib->pkt_rpt_type == TX_REPORT2) {
-- 
2.30.2

