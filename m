Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0197C687A16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjBBKW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjBBKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:22:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3957719B9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:22:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95787B8258E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D773EC433D2;
        Thu,  2 Feb 2023 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675333373;
        bh=qquQFaEWfR08XHbhtVrLnIslga9ScfKDaL9hdZA2H4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=IT5dN+zpWq7CejGt94SSoFmwzkAO1PfAE9oVNwVK4pMhXeObyrYw1idm4bCrIfuo+
         dbkf60lkFjZgoAnmxLojR4i/06y4btpEvwu9aApRKMt0jKwLfoNH8EpnIa5OOplbUw
         13d28dWpxt5KVGBrN1ElCCSetGxsdo9Qz0AI1byILWRoz0W+oU41W/dpAyjZLIlOvx
         kPsBU776MN/MoBl4Ucnm19/bVsEp1E/Lon0vrYv8kPl3A84Jj061WLaj21/vZDjFFB
         U4eLTmFycUWbiTtLLVLzSnaLcwhcQW3O2+hpgpnupSfj0gFykIyvxBmAXHnWFJXyvi
         C4UMlEL5EVmPA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: fix intel-soundwire link failure
Date:   Thu,  2 Feb 2023 11:22:30 +0100
Message-Id: <20230202102247.806749-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

My randconfig build setup ran into a rare build failure with

CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=y
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=m
CONFIG_SOUNDWIRE=y
CONFIG_SOUNDWIRE_INTEL=m
CONFIG_SND_SOC_SOF_HDA=y
CONFIG_SND_SOC_SOF_INTEL_TGL=y

x86_64-linux-ld: sound/soc/sof/intel/hda.o: in function `hda_init_caps':
hda.c:(.text+0x691): undefined reference to `sdw_intel_cnl_hw_ops'
x86_64-linux-ld: hda.c:(.text+0x6f2): undefined reference to `sdw_intel_probe'
x86_64-linux-ld: sound/soc/sof/intel/hda.o: in function `hda_sdw_startup':
hda.c:(.text+0x1c40): undefined reference to `sdw_intel_startup'
x86_64-linux-ld: sound/soc/sof/intel/hda.o: in function `hda_sdw_process_wakeen':
hda.c:(.text+0x1cb6): undefined reference to `sdw_intel_process_wakeen_event'
x86_64-linux-ld: sound/soc/sof/intel/hda.o: in function `hda_dsp_interrupt_thread':
hda.c:(.text+0x1d67): undefined reference to `sdw_intel_thread'
x86_64-linux-ld: sound/soc/sof/intel/hda.o: in function `hda_dsp_remove':
hda.c:(.text+0x2655): undefined reference to `sdw_intel_exit'

My best understanding is that the definition of
SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE was intended to avoid this
problem, but got it wrong for the SND_SOC_SOF_INTEL_SOUNDWIRE=m case,
where the 'select' is meant to set SOUNDWIRE_INTEL to the value of
SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE rather than the intersection of
SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE and SND_SOC_SOF_INTEL_SOUNDWIRE.

Change the condition to check for SND_SOC_SOF_INTEL_SOUNDWIRE to be a
boolean rather than a tristate expression in order to propagate this
as intended.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I could not figure out if this is a recent regression or if the
problem has existed for a long time and is just really hard to
trigger. I first saw it on linux-next-20230201.
---
 sound/soc/sof/intel/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 36a0e2bf30ff..715ba8a7f2f8 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -322,8 +322,8 @@ config SND_SOC_SOF_HDA_PROBES
 
 config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	tristate
-	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE
-	select SND_INTEL_SOUNDWIRE_ACPI if SND_SOC_SOF_INTEL_SOUNDWIRE
+	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE != n
+	select SND_INTEL_SOUNDWIRE_ACPI if SND_SOC_SOF_INTEL_SOUNDWIRE != n
 
 config SND_SOC_SOF_INTEL_SOUNDWIRE
 	tristate "SOF support for SoundWire"
-- 
2.39.0

