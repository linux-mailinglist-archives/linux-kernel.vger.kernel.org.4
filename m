Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61189620839
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiKHE1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiKHE13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:27:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F528732
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:27:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so12321401pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 20:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSW9LI1yKHWyO/rnwkCvTR08ko1xObHpXEf8aeSwd9Q=;
        b=pfeBoNA5Bh6xN/MiR+jED1WBOTlZp2WlZBpGYpCIyfeCfZBbNQAwtOrh4AttchPHml
         RfZE/HxiOiSjCWyy0lxx/nnktJnXPeWQ/KHIYnmwOUDDoQnZalwDx4q/JW9wm0/53kox
         RYJcYvoUbGX0qjTiqxCiXxwbJ40K1vcXAuykzEmKPGiK2mqLRI3wt33jiuEECHOKTYEq
         76EG5M4vnbW/r1WCoz3yHj7+Y/ENw0UJ6ZxZotxkpQxbBdo83UcmHQzDtTwkjQW/2FVw
         wzCdIhF9HmyKa02ohyFii5485LBRAWrdroLMFLCj1mkvcImFoWiD3m3/DxDetJon3KC6
         d3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSW9LI1yKHWyO/rnwkCvTR08ko1xObHpXEf8aeSwd9Q=;
        b=g1l6Fo34UrPrtWyelqcv11DN6sMhAQBIZv7v82CYlamlv+7ljworblrSWO8F0nqlNx
         XPGKsZWokCS3SAWd4FqRjDJPOCqiSD2jpsj74HQrQn0ax1F/en+EOkg8O+0BNdFKAljh
         GYSllUonBa34cg/6vAkBSbRYQJdFf9vM46JeDfmOWdSVdXzXo8CKTJ1/4BfvkbMuisM+
         21Fo0pUX4sSpIjzUlOKFxLCdVzX75oDRx6Qtj5QTLdkk9lZq33MMZHRK83j0Hyxed37h
         2UmPqpZ0W7dFBY68/GfUfr69nvVg3GGZg+NxWwnu35baFXb0sPhr316OUDGXMWW3c/25
         mfpQ==
X-Gm-Message-State: ACrzQf0H+ZNJpkl3YnQIcIRcsmxHsZkLbMbbhlMIJIH0I0bj1ERqchw/
        G2/Kk+iiPabwbTYLk+ABkWEZG7l4KDkmRg==
X-Google-Smtp-Source: AMsMyM56PM3CirkkXYlb1KJ2cNUYQ4KhOBW2d6yCvBHctuckGdkycrrUSHFuzZha7WaB/bcG/Txxkg==
X-Received: by 2002:a17:902:f651:b0:184:6925:d127 with SMTP id m17-20020a170902f65100b001846925d127mr53388547plg.140.1667881648182;
        Mon, 07 Nov 2022 20:27:28 -0800 (PST)
Received: from localhost.localdomain (118-167-183-234.dynamic-ip.hinet.net. [118.167.183.234])
        by smtp.gmail.com with ESMTPSA id j63-20020a625542000000b005627868e27esm5265945pfb.127.2022.11.07.20.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:27:27 -0800 (PST)
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
Subject: [PATCH v1 1/2] ASoC: Intel: sof_rt5682: add support for ALC5682I-VD with amp rt1019p
Date:   Tue,  8 Nov 2022 12:27:15 +0800
Message-Id: <20221108042716.2930255-2-ajye_huang@compal.corp-partner.google.com>
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

This patch adds the driver data for two rt1019 speaker amplifiers on
SSP1 and ALC5682I-VD on SSP0 for ADL platform.

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 sound/soc/intel/boards/sof_rt5682.c               | 3 +--
 sound/soc/intel/common/soc-acpi-intel-adl-match.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 2358be208c1f..0e803c1c2b06 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -1092,10 +1092,9 @@ static const struct platform_device_id board_ids[] = {
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
 	{
-		.name = "adl_rt1019_rt5682s",
+		.name = "adl_rt1019_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_SSP_CODEC(0) |
-					SOF_RT5682S_HEADPHONE_CODEC_PRESENT |
 					SOF_SPEAKER_AMP_PRESENT |
 					SOF_RT1019_SPEAKER_AMP_PRESENT |
 					SOF_RT5682_SSP_AMP(1) |
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index 9990d5502d26..3ca0a96d94de 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -489,8 +489,8 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.sof_tplg_filename = "sof-adl-max98360a-nau8825.tplg",
 	},
 	{
-		.id = "RTL5682",
-		.drv_name = "adl_rt1019_rt5682s",
+		.comp_ids = &adl_rt5682_rt5682s_hp,
+		.drv_name = "adl_rt1019_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_rt1019p_amp,
 		.sof_tplg_filename = "sof-adl-rt1019-rt5682.tplg",
-- 
2.25.1

