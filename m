Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FA5E7894
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiIWKoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiIWKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:44:25 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9762E10D64C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:44:24 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 513641A0F2A;
        Fri, 23 Sep 2022 12:44:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0657B1A0F0A;
        Fri, 23 Sep 2022 12:44:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 48DBB181D0CB;
        Fri, 23 Sep 2022 18:44:21 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] Revert "ASoC: fsl_audmix: make clock and output src write only"
Date:   Fri, 23 Sep 2022 18:25:26 +0800
Message-Id: <1663928726-10213-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 944c517b8c838832a166f1c89afbf8724f4a6b49.

There is error after making clock and output src write only

$amixer -c imxaudmix cset numid=1 1
amixer: Cannot read the given element from control sysdefault:3

Which is worse than before, so let's revert the change.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_audmix.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 43857b7a81c9..672148dd4b23 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -199,18 +199,10 @@ static int fsl_audmix_put_out_src(struct snd_kcontrol *kcontrol,
 
 static const struct snd_kcontrol_new fsl_audmix_snd_controls[] = {
 	/* FSL_AUDMIX_CTR controls */
-	{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Mixing Clock Source",
-		.info = snd_soc_info_enum_double,
-		.access = SNDRV_CTL_ELEM_ACCESS_WRITE,
-		.put = fsl_audmix_put_mix_clk_src,
-		.private_value = (unsigned long)&fsl_audmix_enum[0] },
-	{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Output Source",
-		.info = snd_soc_info_enum_double,
-		.access = SNDRV_CTL_ELEM_ACCESS_WRITE,
-		.put = fsl_audmix_put_out_src,
-		.private_value = (unsigned long)&fsl_audmix_enum[1] },
+	SOC_ENUM_EXT("Mixing Clock Source", fsl_audmix_enum[0],
+		     snd_soc_get_enum_double, fsl_audmix_put_mix_clk_src),
+	SOC_ENUM_EXT("Output Source", fsl_audmix_enum[1],
+		     snd_soc_get_enum_double, fsl_audmix_put_out_src),
 	SOC_ENUM("Output Width", fsl_audmix_enum[2]),
 	SOC_ENUM("Frame Rate Diff Error", fsl_audmix_enum[3]),
 	SOC_ENUM("Clock Freq Diff Error", fsl_audmix_enum[4]),
-- 
2.34.1

