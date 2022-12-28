Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC0657660
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiL1MXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiL1MWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:22:54 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1DA284
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:22:53 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so8021236pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X91Fnadk2T2IXBmaaCHcqGD55dHXQIcw8hnKRyjWdc=;
        b=8ATAjlMSvH64+WHo5TfeKLy/9iwXrYE8/B0YTdIfYIbO5BQINeQDS9114Ih2LQcH4a
         oXtlbx2wf+omFT99UgiMZHnatKZ4sQfsMymZ+OVOz3wATCMcKeaLSaHFtraywPp7zjNA
         vqiKIK67C9KVKhqT5L2FmmjPnNeH7jaJJfOozT6FOAHxNSRYSYMTasIieCUx+gJQymeF
         GamizVymKLPex/aowlguGu4BSxVkhe75Hrh01m0AAGOVQDplWliLtNdkdzazWdF+xuHA
         bXiAI06dLc+TL1zkSHjg/PT3eipglJY2ffb9YeGdzHK1o0H+GvTYkbQaKJUHgeqneBWH
         PZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9X91Fnadk2T2IXBmaaCHcqGD55dHXQIcw8hnKRyjWdc=;
        b=y2ovjcdDiYcIUPbADrBK9LfNaSqPWFhOqKFXgXfO6ifbvYEYi9JBJ/tWiv0sJ5xyCf
         XkisTaYSQaXVKyEYVDd/kj0nKXQFocbjpOtqPfTOj+udkJx8617SJ+wTufqEzBPZBGoX
         3tNQMtxzQj+re0okKkGa3tKPUkmC6fn1xQhpnWFjpGhtlF95o4jkzk8bXb62XL0oPW9L
         OcG2YQCymFj7SxANqCUZryT7eGaK6U/t7MLtSDp7VgCLzHFcn/kUb/xHa5bpjhX8GIph
         cZvPRxwz2TxA9D8XVovW8TxvD2kcij6ES+ZFqeh+cu1CcwIxnnt/bRsHfyRnCPAORKHG
         FL1g==
X-Gm-Message-State: AFqh2ko7SCTuOwe5I0m5HImvU2XdgPbI6FFTnamntTt24p4KEqZTYbod
        enfKW2VQyZ2q2oXxnu0zSuUz/w==
X-Google-Smtp-Source: AMrXdXt0gVyGT9VaSwJVm9bxkdZzyN9aQyXLpHP3077wingZFW4PqgWXO63Kj2x5OqBxtEC9qIw/cQ==
X-Received: by 2002:a05:6a21:3949:b0:a7:9022:5d5e with SMTP id ac9-20020a056a21394900b000a790225d5emr31532687pzc.2.1672230173418;
        Wed, 28 Dec 2022 04:22:53 -0800 (PST)
Received: from localhost.localdomain (202.60.225.077.static.cyberec.com. [202.60.225.77])
        by smtp.gmail.com with ESMTPSA id h1-20020a056a00000100b0058124f92399sm5236074pfk.219.2022.12.28.04.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 04:22:53 -0800 (PST)
From:   tongjian <tongjian@huaqin.corp-partner.google.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        perex@perex.cz, tiwai@suse.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        jiaxin.yu@mediatek.com, chunxu.li@mediatek.com,
        ajye_huang@compal.corp-partner.google.com,
        tongjian@huaqin.corp-partner.google.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: mediatek: mt8186: support rt5682s_max98360
Date:   Wed, 28 Dec 2022 20:22:29 +0800
Message-Id: <20221228122230.3818533-2-tongjian@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
References: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using the rt5682s codec together with max98360a on
MT8186-MT6366-RT1019-RT5682S machines.

Signed-off-by: tongjian <tongjian@huaqin.corp-partner.google.com>
---
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index 8f77a0bc1dc8..af44e331dae8 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -1083,6 +1083,21 @@ static struct snd_soc_card mt8186_mt6366_rt1019_rt5682s_soc_card = {
 	.num_configs = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_codec_conf),
 };
 
+static struct snd_soc_card mt8186_mt6366_rt5682s_max98360_soc_card = {
+	.name = "mt8186_rt5682s_max98360",
+	.owner = THIS_MODULE,
+	.dai_link = mt8186_mt6366_rt1019_rt5682s_dai_links,
+	.num_links = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_dai_links),
+	.controls = mt8186_mt6366_rt1019_rt5682s_controls,
+	.num_controls = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_controls),
+	.dapm_widgets = mt8186_mt6366_rt1019_rt5682s_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_widgets),
+	.dapm_routes = mt8186_mt6366_rt1019_rt5682s_routes,
+	.num_dapm_routes = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_routes),
+	.codec_conf = mt8186_mt6366_rt1019_rt5682s_codec_conf,
+	.num_configs = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_codec_conf),
+};
+
 static int mt8186_mt6366_rt1019_rt5682s_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
@@ -1232,9 +1247,14 @@ static int mt8186_mt6366_rt1019_rt5682s_dev_probe(struct platform_device *pdev)
 
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id mt8186_mt6366_rt1019_rt5682s_dt_match[] = {
-	{	.compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound",
+	{
+		.compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound",
 		.data = &mt8186_mt6366_rt1019_rt5682s_soc_card,
 	},
+	{
+		.compatible = "mediatek,mt8186-mt6366-rt5682s-max98360-sound",
+		.data = &mt8186_mt6366_rt5682s_max98360_soc_card,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mt8186_mt6366_rt1019_rt5682s_dt_match);
-- 
2.25.1

