Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5D670080A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbjELMa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbjELM36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:29:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160DC1156E;
        Fri, 12 May 2023 05:29:23 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C5eUj7031128;
        Fri, 12 May 2023 07:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=xB39y6+mJBGWtyhx0qcL2eY8lyrChM7wcWHN+iiEcB4=;
 b=V8BCuMXJ5RwFoMUZRqCT3DxC+nM5xnkqeVkwEifNqk0EtjlPkiPXyFT/b4+S17sXc9hi
 ZBF8aP9ZmNv0schiX4lKkCSVYRDNO94Gn7k8J+YdVCx48vVQ6Zq9CnjXz9tTOiBEiTnB
 UGrsBUPHEhJQ76LeEn/fuQmUxoOFHIrvLE/c2b9gH/63Hw73wN7WWMaIjTFgtAmq2rFs
 hRT1ipWoIl/YhgfX9yOKqZD11nMhDxTAgTCUqYlmofziQyRMV5T/vU3gZY3bjF5/la8g
 08Ul09BJEVizlGJXjIGaCoJwWEP7ls2gGU8TmnrrlAW3FRLC2PcghHDT6InueZth/SGa Hg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7s46b2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:28:39 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 07:28:38 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 12 May 2023 07:28:38 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 44D1915B4;
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
Subject: [PATCH 02/10] ASoC: soc-component: Add notify control helper function
Date:   Fri, 12 May 2023 13:28:30 +0100
Message-ID: <20230512122838.243002-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MUbrGEwGAujydxpQ9MWY7vjI0Bv7nAZ4
X-Proofpoint-GUID: MUbrGEwGAujydxpQ9MWY7vjI0Bv7nAZ4
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

Add a function to allow ASoC drivers to easily notify an ALSA control
change. This function will automatically add any component naming
prefix into the control name.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc-component.h |  4 ++++
 sound/soc/soc-component.c     | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 0814ed1438640..0b47603c9db29 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -454,6 +454,10 @@ int snd_soc_component_force_enable_pin_unlocked(
 	struct snd_soc_component *component,
 	const char *pin);
 
+/* component controls */
+int snd_soc_component_notify_control(struct snd_soc_component *component,
+				     const char * const ctl);
+
 /* component driver ops */
 int snd_soc_component_open(struct snd_soc_component *component,
 			   struct snd_pcm_substream *substream);
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index ff25718ff2e88..4356cc320fea0 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -236,6 +236,28 @@ int snd_soc_component_force_enable_pin_unlocked(
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_force_enable_pin_unlocked);
 
+int snd_soc_component_notify_control(struct snd_soc_component *component,
+				     const char * const ctl)
+{
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	struct snd_kcontrol *kctl;
+
+	if (component->name_prefix)
+		snprintf(name, ARRAY_SIZE(name), "%s %s", component->name_prefix, ctl);
+	else
+		snprintf(name, ARRAY_SIZE(name), "%s", ctl);
+
+	kctl = snd_soc_card_get_kcontrol(component->card, name);
+	if (!kctl)
+		return soc_component_ret(component, -EINVAL);
+
+	snd_ctl_notify(component->card->snd_card,
+		       SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_notify_control);
+
 /**
  * snd_soc_component_set_jack - configure component jack.
  * @component: COMPONENTs
-- 
2.30.2

