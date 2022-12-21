Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AEF6531A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiLUNZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLUNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:25:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85DE220C7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:25:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F09A617A8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 13:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43971C433D2;
        Wed, 21 Dec 2022 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671629124;
        bh=g6jee0CSun7KRiuaMBv5r2gX/s8rOE47WIb/+eVUIkk=;
        h=From:To:Cc:Subject:Date:From;
        b=IZm8zrCAB7DLTXIG+LDNCZlJg9QAwDos+ye87GjOB85qaA/OiJ8J0Wd0o7BDdgFQr
         yLlf3nxMM0o38dgxPhGUKuVHpEwEWRB5mJRvHUVmw28rrKz41Upr1ULZ2LKTeC1bFz
         wrZVbZMSnsMbF+twTBNaTe7MCnIytkRSJMAc7TFlzjhLe9zr4EZn2we2CYPkZlhgWc
         0tszDwwXUXVHN5fJf+qbC4IGl5wdssHZ4ZBKZQRuO2aSJbmgIUOePswqi1neFB3UtL
         fPlausRsFqh0XX71fkhyLyu4Y2ocv3m7HP9pb9YtTsfEFgQ8VmMiK7r6M59rz5kF1W
         tE+G4QLbMTvMQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Brent Lu <brent.lu@intel.com>, Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        David Lin <CTLIN0@nuvoton.com>,
        Libin Yang <libin.yang@intel.com>,
        Mac Chiang <mac.chiang@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: sof-nau8825: fix module alias overflow
Date:   Wed, 21 Dec 2022 14:24:56 +0100
Message-Id: <20221221132515.2363276-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The maximum name length for a platform_device_id entry is 20 characters
including the trailing NUL byte. The sof_nau8825.c file exceeds that,
which causes an obscure error message:

sound/soc/intel/boards/snd-soc-sof_nau8825.mod.c:35:45: error: illegal character encoding in string literal [-Werror,-Winvalid-source-encoding]
MODULE_ALIAS("platform:adl_max98373_nau8825<U+0018><AA>");
                                                   ^~~~
include/linux/module.h:168:49: note: expanded from macro 'MODULE_ALIAS'
                                                ^~~~~~
include/linux/module.h:165:56: note: expanded from macro 'MODULE_INFO'
                                                       ^~~~
include/linux/moduleparam.h:26:47: note: expanded from macro '__MODULE_INFO'
                = __MODULE_INFO_PREFIX __stringify(tag) "=" info

I could not figure out how to make the module handling robust enough
to handle this better, but as a quick fix, using slightly shorter
names that are still unique avoids the build issue.

Fixes: 8d0872f6239f ("ASoC: Intel: add sof-nau8825 machine driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/intel/boards/sof_nau8825.c              | 8 ++++----
 sound/soc/intel/common/soc-acpi-intel-adl-match.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
index 27880224359d..009a41fbefa1 100644
--- a/sound/soc/intel/boards/sof_nau8825.c
+++ b/sound/soc/intel/boards/sof_nau8825.c
@@ -618,7 +618,7 @@ static const struct platform_device_id board_ids[] = {
 
 	},
 	{
-		.name = "adl_rt1019p_nau8825",
+		.name = "adl_rt1019p_8825",
 		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
 					SOF_RT1019P_SPEAKER_AMP_PRESENT |
@@ -626,7 +626,7 @@ static const struct platform_device_id board_ids[] = {
 					SOF_NAU8825_NUM_HDMIDEV(4)),
 	},
 	{
-		.name = "adl_max98373_nau8825",
+		.name = "adl_max98373_8825",
 		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
 					SOF_MAX98373_SPEAKER_AMP_PRESENT |
@@ -637,7 +637,7 @@ static const struct platform_device_id board_ids[] = {
 	},
 	{
 		/* The limitation of length of char array, shorten the name */
-		.name = "adl_mx98360a_nau8825",
+		.name = "adl_mx98360a_8825",
 		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
 					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
@@ -648,7 +648,7 @@ static const struct platform_device_id board_ids[] = {
 
 	},
 	{
-		.name = "adl_rt1015p_nau8825",
+		.name = "adl_rt1015p_8825",
 		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
 					SOF_RT1015P_SPEAKER_AMP_PRESENT |
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index 60aee56f94bd..1f79fef600ac 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -474,21 +474,21 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	},
 	{
 		.id = "10508825",
-		.drv_name = "adl_rt1019p_nau8825",
+		.drv_name = "adl_rt1019p_8825",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_rt1019p_amp,
 		.sof_tplg_filename = "sof-adl-rt1019-nau8825.tplg",
 	},
 	{
 		.id = "10508825",
-		.drv_name = "adl_max98373_nau8825",
+		.drv_name = "adl_max98373_8825",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98373_amp,
 		.sof_tplg_filename = "sof-adl-max98373-nau8825.tplg",
 	},
 	{
 		.id = "10508825",
-		.drv_name = "adl_mx98360a_nau8825",
+		.drv_name = "adl_mx98360a_8825",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98360a_amp,
 		.sof_tplg_filename = "sof-adl-max98360a-nau8825.tplg",
@@ -502,7 +502,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	},
 	{
 		.id = "10508825",
-		.drv_name = "adl_rt1015p_nau8825",
+		.drv_name = "adl_rt1015p_8825",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_rt1015p_amp,
 		.sof_tplg_filename = "sof-adl-rt1015-nau8825.tplg",
-- 
2.35.1

