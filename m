Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8661E5BA6C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIPGZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIPGZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:25:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED9F786D4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:25:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c24so19435259pgg.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Lzq4OJ9/dH/QCsn/g5d/W3YD36QlPEBSuggjgpZGHHs=;
        b=eoqTrLR7BMXelG9emwzH54nw3MhxYBhb+3nFGdzWo+EDZ/DxFHX64XUYbUUSC0jNxd
         aPX2BylkhergaQZiwf6l9jJA7HUA0kKn4qf1mn/avXiKSks38y+2/lGGyVpfy3MQ7JV8
         rlQ/obuB2sAgsGl9Ig48dvZQ3yWdyrAxwOlClTzsO/dDBpiudqnIG3h5gzlTDRMdkgeZ
         y7qW+T4BZRa6inyJhy6kOh2ST1McDmbFB2KZt2Cq9B3cWb1/FzH53g7Xgi+MGUHStHn0
         k0EyKgVxKbddbGIxCjbbiV5wk2dzIweBDst4Gh74Q2GC39/cWpevTgnRJEsWj29RpNJa
         NHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Lzq4OJ9/dH/QCsn/g5d/W3YD36QlPEBSuggjgpZGHHs=;
        b=WVfWwVam5RaZS4CYmTTcXx5+n2rUFsVJ+pMvn2iOzVTPAb/sslobBa3J2ADDHdLnut
         2SQ+ZXRoIEu+WU/rlvYKkkmYjW9tPvX/JCFb7mKaeZ5GIKKqgdCyuatiF0V7lh5GH7tb
         ziLCChCyPf7lP0ElSdSxTGFOD6Ij3LZWnXjYNDW8sCe2/T9vFFlYVTkFZ04bzz8C8e1L
         PgpN3qaPm1X4KYriycfKSPs63tmjLqurmgmW2PN5maWy2Q0rZDTtpTnHo4acgmHlFWJ2
         k8hgLRJIawJ91+suJp5oPHUYf50pvni38+NWr8QRLoEJtPOTnQnRk7KhUGQPN2iD4TUp
         v8Vg==
X-Gm-Message-State: ACrzQf3Ynd3K/tSgz7+UF18G0sAh0PQAZAIR9j0xvEGLQ0bYpE4O+IMU
        7LUBR//RCyW82mr4TSq7f3I=
X-Google-Smtp-Source: AMsMyM7U+wtd7SRHjO5vUG9xPpBAJYTAmuMoZ86bnGBSTF4BCFRRgjmTaixpyEuxPoJQSvFYofCliA==
X-Received: by 2002:a05:6a00:a82:b0:547:d660:c077 with SMTP id b2-20020a056a000a8200b00547d660c077mr3560740pfl.38.1663309554211;
        Thu, 15 Sep 2022 23:25:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d15-20020a621d0f000000b00540ad46bc1dsm13415992pfd.157.2022.09.15.23.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:25:53 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        brent.lu@intel.com, akihiko.odaki@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: Intel: sof_ssp_amp: use devm_kcalloc() instead of devm_kzalloc()
Date:   Fri, 16 Sep 2022 06:25:49 +0000
Message-Id: <20220916062549.154114-1-ye.xingchen@zte.com.cn>
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
 sound/soc/intel/boards/sof_ssp_amp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/sof_ssp_amp.c b/sound/soc/intel/boards/sof_ssp_amp.c
index 4a762e002ac7..94d25aeb6e7c 100644
--- a/sound/soc/intel/boards/sof_ssp_amp.c
+++ b/sound/soc/intel/boards/sof_ssp_amp.c
@@ -210,10 +210,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 	struct snd_soc_dai_link *links;
 	int i, id = 0;
 
-	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
-					sof_ssp_amp_card.num_links, GFP_KERNEL);
-	cpus = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link_component) *
-					sof_ssp_amp_card.num_links, GFP_KERNEL);
+	links = devm_kcalloc(dev, sof_ssp_amp_card.num_links,
+					sizeof(struct snd_soc_dai_link), GFP_KERNEL);
+	cpus = devm_kcalloc(dev, sof_ssp_amp_card.num_links,
+					sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
 	if (!links || !cpus)
 		return NULL;
 
@@ -306,9 +306,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 	if (sof_ssp_amp_quirk & SOF_HDMI_PLAYBACK_PRESENT) {
 		/* HDMI */
 		if (hdmi_num > 0) {
-			idisp_components = devm_kzalloc(dev,
-					   sizeof(struct snd_soc_dai_link_component) *
-					   hdmi_num, GFP_KERNEL);
+			idisp_components = devm_kcalloc(dev,
+					   hdmi_num,
+					   sizeof(struct snd_soc_dai_link_component),
+					   GFP_KERNEL);
 			if (!idisp_components)
 				goto devm_err;
 		}
-- 
2.25.1
