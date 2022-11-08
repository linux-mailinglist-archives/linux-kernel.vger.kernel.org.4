Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8362083A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiKHE1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiKHE1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:27:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3EC31DFE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:27:33 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so12296838pjd.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 20:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIIGd8oP3sziwMfS5bjNdlZ83g03MLKO/gH68/ERIKg=;
        b=b8vZnjuKOV19audB3sn+ISPXH+awdfhfeJtmIytlnPM8pImaTJVYKLhIcjrVIvzS1Z
         wUGo6Vsv673ZH3Y73EfasjM3agz4k35iV5TnWXgZ7PazN7aSgcxTWtWe76YjKDSVXTUB
         gKnzifFd8Ophnyb2JGwApkeSmk84zZAVYBcrxfCX9IWhpjfOK6RB9VH5pjj/DXtaN5a5
         82cBYM4KwX5yCXiHpBAK+fUg/yflgOO/EvAty35VlXPH3N05iKf+Lvdb+oR092R+I2oM
         09mvwNYzNCZYLzGWjrV6W8AoN4R+6Cq2J1Ytr4jENHUjHXfEo4aU6GRSS3T2oYx8XIuG
         CJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIIGd8oP3sziwMfS5bjNdlZ83g03MLKO/gH68/ERIKg=;
        b=ULCDLzD+p06GaNsGqLEjp3vjpuKeUp8gD04OgYea1rfYC5jbWt5+Q/NU+ERTAN7leG
         lcp4avWVR9Ea43aBP6HLsTx0jcxxDv6VJE8yIRK8Oz3h+Y3wxuUl0LcHExIQQ61hAMi5
         zu49D2Eexjg/nN4l1uTjXhJwO2yIwbuEaCZJ1JhkbB4IigxWmNJdzncrgLklLas8T5um
         n3XPGG8jq37A+TVBUu5CanqbsPi9f9DM8NJ4dW6wXiH3ND3UD9p2ZzI92I2fX6gZ0gUx
         h3DANeQyeGYDbG6YSzsRJ5gsY491iddf4L90HL12vgsDDVP0Xh4RWkJkbue7z+YAjxwz
         67qA==
X-Gm-Message-State: ACrzQf0PHd3T/rURxHKTdasE26y6Y6046tGicZxmuVXD9LnMJYFdjkVe
        evMXNM5gKrI+qZBAP27In2LS9veG9OQ/dA==
X-Google-Smtp-Source: AMsMyM4Zyf89FLUAoW4CNQByU6fT4GCrJPUd+YcTiXulxLCcqVtH4ZqdfuELixR3ErWYZ9AZnttmYw==
X-Received: by 2002:a17:90a:fc94:b0:213:f73a:86a7 with SMTP id ci20-20020a17090afc9400b00213f73a86a7mr43210065pjb.144.1667881652413;
        Mon, 07 Nov 2022 20:27:32 -0800 (PST)
Received: from localhost.localdomain (118-167-183-234.dynamic-ip.hinet.net. [118.167.183.234])
        by smtp.gmail.com with ESMTPSA id j63-20020a625542000000b005627868e27esm5265945pfb.127.2022.11.07.20.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:27:32 -0800 (PST)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Mac Chiang <mac.chiang@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org
Subject: [PATCH v1 2/2] ASoC: Intel: sof rt5682: remove the duplicate codes
Date:   Tue,  8 Nov 2022 12:27:16 +0800
Message-Id: <20221108042716.2930255-3-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108042716.2930255-1-ajye_huang@compal.corp-partner.google.com>
References: <20221108042716.2930255-1-ajye_huang@compal.corp-partner.google.com>
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

Remove the redundant code to prevent user confuse.

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 0e803c1c2b06..4a2f91249b10 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -867,10 +867,6 @@ static int sof_audio_probe(struct platform_device *pdev)
 	if (acpi_dev_present("RTL5682", NULL, -1))
 		sof_rt5682_quirk |= SOF_RT5682S_HEADPHONE_CODEC_PRESENT;
 
-	/* Detect the headset codec variant to support machines in DMI quirk */
-	if (acpi_dev_present("RTL5682", NULL, -1))
-		sof_rt5682_quirk |= SOF_RT5682S_HEADPHONE_CODEC_PRESENT;
-
 	if (soc_intel_is_byt() || soc_intel_is_cht()) {
 		is_legacy_cpu = 1;
 		dmic_be_num = 0;
-- 
2.25.1

