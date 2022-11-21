Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF106631EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiKUKrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKUKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:46:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10C97991F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669027608; x=1700563608;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CYBGgKZa3V7R4jeaL1Zz2bLgJGSPjHevyvScslfBpTs=;
  b=Imha5nvNdPhP5tKQKxeKkRl+oRiBhWr+afH7Y3E2HsFZfD0y7cfh/QRR
   JpB4F5dmOPl2djo+pmXX6atnkRB5Q3HMeGboUHsOeZDIyfaQLReirQxpB
   kHjVsaTsqAEE7ibhNSwbdtaDlUuOB8EZLmHquI0RLNFqITkbfs2cwZ6T1
   pBrIHDgJwmS0rLRyMMUqUE1lknzu5hIkMQ3S6XL7glJX4+b9xfYZQ+QGJ
   gAeiulbzW0WXLomIK/YL/K7OpxadLchtZQzGvJCLkO2p/OTf4xDptB5TF
   4/ErnQjVZrso1AYVbvUOiMW785xnlV3RQd7FUZIfkcDNKsfqdfmiqttIt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="340387150"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="340387150"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 02:46:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="729964350"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="729964350"
Received: from lili-desktop.bj.intel.com ([10.238.144.122])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 02:46:40 -0800
From:   lili.li@intel.com
To:     tiwai@suse.com, perex@perex.cz, broonie@kernel.org,
        cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: Skylake: Fix Kconfig dependency
Date:   Mon, 21 Nov 2022 18:47:42 +0800
Message-Id: <20221121104742.1007486-1-lili.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lili Li <lili.li@intel.com>

Commit e4746d94d00c ("ASoC: Intel: Skylake: Introduce HDA codec init and
exit routines") introduced HDA codec init routine which depends on SND_HDA.
Select SND_SOC_HDAC_HDA unconditionally to fix following compile error:
ERROR: modpost: "snd_hda_codec_device_init" [sound/soc/intel/skylake/snd-soc-skl.ko] undefined!

Fixes: e4746d94d00c ("ASoC: Intel: Skylake: Introduce HDA codec init and exit routines")
Reviewed-by: Junxiao Chang <junxiao.chang@intel.com>
Suggested-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Lili Li <lili.li@intel.com>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index d2ca710ac3fa..ac799de4f7fd 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -177,7 +177,7 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
 	select SND_HDA_DSP_LOADER
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
-	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
+	select SND_SOC_HDAC_HDA
 	select SND_SOC_ACPI_INTEL_MATCH
 	select SND_INTEL_DSP_CONFIG
 	help
-- 
2.25.1

