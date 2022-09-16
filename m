Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B075BA6B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiIPGXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIPGX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:23:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5261B74371
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:23:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso19410065pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9WPnJIv68r3eHx97tiSao6RMaGX0K8/r7hr7MDhMuGo=;
        b=Due9kOWjZZPGsq8FRnTRNIvIOkaZFODGtW3UDMmy3OiwDfprjm2XHaCf0WPdabMdaH
         GcbvfNPt+9GGUsRu2Ez80bPVJ3d5qVIHiZlKP9Jw7XgnhjgevlrG+WflR00z6lT1GpVM
         IRcU+Bbw07eKJ3T4IOdZK8CtyqLJ4yppfeRCJnk4NFfWlxLyF7Cvc1Q4o/2P+HxkIvw1
         Hw+8pDpBNMErzfGsQ5sgwzVFldVlNyuquRHlWAKPiEMSDJn+u3AM4xJCo3mT24gzlj+l
         rV3l4/ORauMDdptHccIrRIBXTsv2E1u5roypX5AtIHzwvq+ZWuuiVTw41feuKRE9g2AX
         VQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9WPnJIv68r3eHx97tiSao6RMaGX0K8/r7hr7MDhMuGo=;
        b=VNJMamqH/zHQniV0LLd5aZqTsEimWX6ZUSjtIyDXSKs2w/RsmACUKoZ5D7czJxKEFW
         G/PfJc8PboXhzV1azgc7HVtXoEZn+Z5AKPthCrZQTbD1AXe7PJg9YooR4aU0IfYhRHdL
         ZRiBO112KGuzqBQjpnjeaj8l28CanxeSOV1Qi0NU3iGeDuOmRm7/xZLEGGjLWYn+KByd
         5Wx3jkliZhLLrEUuLphMso9CpyHTGOxYxLyb85IxyY4RdopwEdDk1GlOnRx2YW7dP1hE
         wwWugKX8sb7MWbSN9GfjWyqRMcH2RjmKM58Sw7/dnZEn6TjgX75tNgQeHRWAYTgQnLgA
         WsiQ==
X-Gm-Message-State: ACrzQf1Ia3k7SLaxJbWVhnxbn8hH4pCVtOgc+ZXdvcd/qXnFW9Aspw8a
        YNmkx1zohz8ci9U477PGG7Y=
X-Google-Smtp-Source: AMsMyM5oCsHdiZ80TKLRHXynQhP+KlKYJqa+uIjMCefAmfB6p+7MmQUiXWXM7hGROC6FzVUXYGmkOw==
X-Received: by 2002:a17:902:c941:b0:177:e69a:a517 with SMTP id i1-20020a170902c94100b00177e69aa517mr3301595pla.144.1663309405815;
        Thu, 15 Sep 2022 23:23:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z129-20020a626587000000b00537e1b30793sm13972305pfb.11.2022.09.15.23.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:23:25 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        mac.chiang@intel.com, yong.zhi@intel.com, akihiko.odaki@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: Intel: sof_nau8825: use function devm_kcalloc() instead of devm_kzalloc()
Date:   Fri, 16 Sep 2022 06:23:20 +0000
Message-Id: <20220916062320.153456-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Use 2-factor multiplication argument form devm_kcalloc() instead
of devm_kzalloc().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 sound/soc/intel/boards/sof_nau8825.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
index 8d7e5ba9e516..5585c217f78d 100644
--- a/sound/soc/intel/boards/sof_nau8825.c
+++ b/sound/soc/intel/boards/sof_nau8825.c
@@ -355,10 +355,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 	struct snd_soc_dai_link *links;
 	int i, id = 0;
 
-	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
-			     sof_audio_card_nau8825.num_links, GFP_KERNEL);
-	cpus = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link_component) *
-			     sof_audio_card_nau8825.num_links, GFP_KERNEL);
+	links = devm_kcalloc(dev, sof_audio_card_nau8825.num_links,
+			    sizeof(struct snd_soc_dai_link), GFP_KERNEL);
+	cpus = devm_kcalloc(dev, sof_audio_card_nau8825.num_links,
+			    sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
 	if (!links || !cpus)
 		goto devm_err;
 
@@ -421,9 +421,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 
 	/* HDMI */
 	if (hdmi_num > 0) {
-		idisp_components = devm_kzalloc(dev,
-						sizeof(struct snd_soc_dai_link_component) *
-						hdmi_num, GFP_KERNEL);
+		idisp_components = devm_kcalloc(dev,
+						hdmi_num,
+						sizeof(struct snd_soc_dai_link_component),
+						GFP_KERNEL);
 		if (!idisp_components)
 			goto devm_err;
 	}
-- 
2.25.1
