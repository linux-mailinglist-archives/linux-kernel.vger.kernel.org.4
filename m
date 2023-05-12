Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A76700806
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbjELMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbjELM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:29:55 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC271436B;
        Fri, 12 May 2023 05:29:19 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CCOUoq001858;
        Fri, 12 May 2023 07:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=t3MNnAFbWQzjwB495QpxKSNEA8K9SmlTCBdq6Db3TVU=;
 b=hTtawnc76NSkngbmeKbPkHC/GwkQl2ia8c0USPT8aabfOD1Nr9zJZxPlY1TR94Wxu6U8
 x8kPkQ6CenURHvgA2oUeCQAnYT8YeAVCPgsm1HKWBsH1mNWZqoR89NnNHRjRLb/8s+I8
 /oNG9XaWffK499Nb3xZw0cQG5TaSdLH3lFEzRcapdL2iz39qqdWbqc/BgawmA4TNjFEL
 j3LbzB+0ifIDTpuQweOepF71zVkU5euVCyw3qlaf3cvhmQR4vtYExAVGv/ck1ZVe7qvS
 JEZqUpYm5YFZaU4abww61fpjVQZlTx27W5zrk/KsXX/TeDW9rSGUjBrOC/v90haktmDD Aw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7nb5dqx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:28:42 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 07:28:38 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 07:28:38 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6C2AD45;
        Fri, 12 May 2023 12:28:38 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>
CC:     <lgirdwood@gmail.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/10] ASoC: wm_adsp: Update to use new component control notify helepr
Date:   Fri, 12 May 2023 13:28:32 +0100
Message-ID: <20230512122838.243002-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tB5mIqFTRkMofwB4c5GHg0WrWyHyoADa
X-Proofpoint-GUID: tB5mIqFTRkMofwB4c5GHg0WrWyHyoADa
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 216120b68b64b..6270cb2e9395c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -686,8 +686,6 @@ int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name, int type,
 {
 	struct cs_dsp_coeff_ctl *cs_ctl = cs_dsp_get_ctl(&dsp->cs_dsp, name, type, alg);
 	struct wm_coeff_ctl *ctl;
-	struct snd_kcontrol *kcontrol;
-	char ctl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int ret;
 
 	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, buf, len);
@@ -699,23 +697,7 @@ int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name, int type,
 
 	ctl = cs_ctl->priv;
 
-	if (dsp->component->name_prefix)
-		snprintf(ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s %s",
-			 dsp->component->name_prefix, ctl->name);
-	else
-		snprintf(ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s",
-			 ctl->name);
-
-	kcontrol = snd_soc_card_get_kcontrol(dsp->component->card, ctl_name);
-	if (!kcontrol) {
-		adsp_err(dsp, "Can't find kcontrol %s\n", ctl_name);
-		return -EINVAL;
-	}
-
-	snd_ctl_notify(dsp->component->card->snd_card,
-		       SNDRV_CTL_EVENT_MASK_VALUE, &kcontrol->id);
-
-	return 0;
+	return snd_soc_component_notify_control(dsp->component, ctl->name);
 }
 EXPORT_SYMBOL_GPL(wm_adsp_write_ctl);
 
-- 
2.30.2

