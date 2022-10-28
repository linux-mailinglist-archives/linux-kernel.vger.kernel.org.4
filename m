Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01B1610B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJ1HYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1HYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:24:23 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B318D447
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:24:22 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D39791A0CE8;
        Fri, 28 Oct 2022 09:24:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B4841A0CDE;
        Fri, 28 Oct 2022 09:24:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E1F83183486A;
        Fri, 28 Oct 2022 15:24:18 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_xcvr: Add Counter registers
Date:   Fri, 28 Oct 2022 15:03:47 +0800
Message-Id: <1666940627-7611-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These counter registers are part of register list,
add them to complete the register map

- DMAC counter control registers
- Data path Timestamp counter register
- Data path bit counter register
- Data path bit count timestamp register
- Data path bit read timestamp register

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 40 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_xcvr.h | 21 +++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index c043efe4548d..2a6802fb2a8b 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -934,6 +934,14 @@ static const struct reg_default fsl_xcvr_reg_defaults[] = {
 	{ FSL_XCVR_RX_DPTH_CTRL_SET,	0x00002C89 },
 	{ FSL_XCVR_RX_DPTH_CTRL_CLR,	0x00002C89 },
 	{ FSL_XCVR_RX_DPTH_CTRL_TOG,	0x00002C89 },
+	{ FSL_XCVR_RX_DPTH_CNTR_CTRL,	0x00000000 },
+	{ FSL_XCVR_RX_DPTH_CNTR_CTRL_SET, 0x00000000 },
+	{ FSL_XCVR_RX_DPTH_CNTR_CTRL_CLR, 0x00000000 },
+	{ FSL_XCVR_RX_DPTH_CNTR_CTRL_TOG, 0x00000000 },
+	{ FSL_XCVR_RX_DPTH_TSCR, 0x00000000 },
+	{ FSL_XCVR_RX_DPTH_BCR,  0x00000000 },
+	{ FSL_XCVR_RX_DPTH_BCTR, 0x00000000 },
+	{ FSL_XCVR_RX_DPTH_BCRR, 0x00000000 },
 	{ FSL_XCVR_TX_DPTH_CTRL,	0x00000000 },
 	{ FSL_XCVR_TX_DPTH_CTRL_SET,	0x00000000 },
 	{ FSL_XCVR_TX_DPTH_CTRL_CLR,	0x00000000 },
@@ -944,6 +952,14 @@ static const struct reg_default fsl_xcvr_reg_defaults[] = {
 	{ FSL_XCVR_TX_CS_DATA_3,	0x00000000 },
 	{ FSL_XCVR_TX_CS_DATA_4,	0x00000000 },
 	{ FSL_XCVR_TX_CS_DATA_5,	0x00000000 },
+	{ FSL_XCVR_TX_DPTH_CNTR_CTRL,	0x00000000 },
+	{ FSL_XCVR_TX_DPTH_CNTR_CTRL_SET, 0x00000000 },
+	{ FSL_XCVR_TX_DPTH_CNTR_CTRL_CLR, 0x00000000 },
+	{ FSL_XCVR_TX_DPTH_CNTR_CTRL_TOG, 0x00000000 },
+	{ FSL_XCVR_TX_DPTH_TSCR, 0x00000000 },
+	{ FSL_XCVR_TX_DPTH_BCR,	 0x00000000 },
+	{ FSL_XCVR_TX_DPTH_BCTR, 0x00000000 },
+	{ FSL_XCVR_TX_DPTH_BCRR, 0x00000000 },
 	{ FSL_XCVR_DEBUG_REG_0,		0x00000000 },
 	{ FSL_XCVR_DEBUG_REG_1,		0x00000000 },
 };
@@ -975,6 +991,14 @@ static bool fsl_xcvr_readable_reg(struct device *dev, unsigned int reg)
 	case FSL_XCVR_RX_DPTH_CTRL_SET:
 	case FSL_XCVR_RX_DPTH_CTRL_CLR:
 	case FSL_XCVR_RX_DPTH_CTRL_TOG:
+	case FSL_XCVR_RX_DPTH_CNTR_CTRL:
+	case FSL_XCVR_RX_DPTH_CNTR_CTRL_SET:
+	case FSL_XCVR_RX_DPTH_CNTR_CTRL_CLR:
+	case FSL_XCVR_RX_DPTH_CNTR_CTRL_TOG:
+	case FSL_XCVR_RX_DPTH_TSCR:
+	case FSL_XCVR_RX_DPTH_BCR:
+	case FSL_XCVR_RX_DPTH_BCTR:
+	case FSL_XCVR_RX_DPTH_BCRR:
 	case FSL_XCVR_TX_DPTH_CTRL:
 	case FSL_XCVR_TX_DPTH_CTRL_SET:
 	case FSL_XCVR_TX_DPTH_CTRL_CLR:
@@ -985,6 +1009,14 @@ static bool fsl_xcvr_readable_reg(struct device *dev, unsigned int reg)
 	case FSL_XCVR_TX_CS_DATA_3:
 	case FSL_XCVR_TX_CS_DATA_4:
 	case FSL_XCVR_TX_CS_DATA_5:
+	case FSL_XCVR_TX_DPTH_CNTR_CTRL:
+	case FSL_XCVR_TX_DPTH_CNTR_CTRL_SET:
+	case FSL_XCVR_TX_DPTH_CNTR_CTRL_CLR:
+	case FSL_XCVR_TX_DPTH_CNTR_CTRL_TOG:
+	case FSL_XCVR_TX_DPTH_TSCR:
+	case FSL_XCVR_TX_DPTH_BCR:
+	case FSL_XCVR_TX_DPTH_BCTR:
+	case FSL_XCVR_TX_DPTH_BCRR:
 	case FSL_XCVR_DEBUG_REG_0:
 	case FSL_XCVR_DEBUG_REG_1:
 		return true;
@@ -1017,6 +1049,10 @@ static bool fsl_xcvr_writeable_reg(struct device *dev, unsigned int reg)
 	case FSL_XCVR_RX_DPTH_CTRL_SET:
 	case FSL_XCVR_RX_DPTH_CTRL_CLR:
 	case FSL_XCVR_RX_DPTH_CTRL_TOG:
+	case FSL_XCVR_RX_DPTH_CNTR_CTRL:
+	case FSL_XCVR_RX_DPTH_CNTR_CTRL_SET:
+	case FSL_XCVR_RX_DPTH_CNTR_CTRL_CLR:
+	case FSL_XCVR_RX_DPTH_CNTR_CTRL_TOG:
 	case FSL_XCVR_TX_DPTH_CTRL_SET:
 	case FSL_XCVR_TX_DPTH_CTRL_CLR:
 	case FSL_XCVR_TX_DPTH_CTRL_TOG:
@@ -1026,6 +1062,10 @@ static bool fsl_xcvr_writeable_reg(struct device *dev, unsigned int reg)
 	case FSL_XCVR_TX_CS_DATA_3:
 	case FSL_XCVR_TX_CS_DATA_4:
 	case FSL_XCVR_TX_CS_DATA_5:
+	case FSL_XCVR_TX_DPTH_CNTR_CTRL:
+	case FSL_XCVR_TX_DPTH_CNTR_CTRL_SET:
+	case FSL_XCVR_TX_DPTH_CNTR_CTRL_CLR:
+	case FSL_XCVR_TX_DPTH_CNTR_CTRL_TOG:
 		return true;
 	default:
 		return false;
diff --git a/sound/soc/fsl/fsl_xcvr.h b/sound/soc/fsl/fsl_xcvr.h
index 7f2853c60085..4769b0fca21d 100644
--- a/sound/soc/fsl/fsl_xcvr.h
+++ b/sound/soc/fsl/fsl_xcvr.h
@@ -49,6 +49,16 @@
 #define FSL_XCVR_RX_DPTH_CTRL_CLR	0x188
 #define FSL_XCVR_RX_DPTH_CTRL_TOG	0x18c
 
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL	0x1C0
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_SET	0x1C4
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_CLR	0x1C8
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_TOG	0x1CC
+
+#define FSL_XCVR_RX_DPTH_TSCR		0x1D0
+#define FSL_XCVR_RX_DPTH_BCR		0x1D4
+#define FSL_XCVR_RX_DPTH_BCTR		0x1D8
+#define FSL_XCVR_RX_DPTH_BCRR		0x1DC
+
 #define FSL_XCVR_TX_DPTH_CTRL		0x220 /* TX datapath ctrl reg */
 #define FSL_XCVR_TX_DPTH_CTRL_SET	0x224
 #define FSL_XCVR_TX_DPTH_CTRL_CLR	0x228
@@ -59,6 +69,17 @@
 #define FSL_XCVR_TX_CS_DATA_3		0x23C
 #define FSL_XCVR_TX_CS_DATA_4		0x240
 #define FSL_XCVR_TX_CS_DATA_5		0x244
+
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL	0x260
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_SET	0x264
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_CLR	0x268
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_TOG	0x26C
+
+#define FSL_XCVR_TX_DPTH_TSCR		0x270
+#define FSL_XCVR_TX_DPTH_BCR		0x274
+#define FSL_XCVR_TX_DPTH_BCTR		0x278
+#define FSL_XCVR_TX_DPTH_BCRR		0x27C
+
 #define FSL_XCVR_DEBUG_REG_0		0x2E0
 #define FSL_XCVR_DEBUG_REG_1		0x2F0
 
-- 
2.34.1

