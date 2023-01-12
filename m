Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742A766710B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjALLhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjALLf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:35:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09663E099
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673522910; x=1705058910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhd+WRzaHqmWRkPNRNir7nTbOsn0RTp6sg9bQRKKJuM=;
  b=Q6VkXtGkUr0v2L3z/BGLTeID0BBo7fMFPShPl7HCwZDpQXQoyE7fkw4O
   ZLESLm7M2aiMCG2d4DpvhQ0nDf1BrFRMEoj2x/lAdyQLxnVlCY41ESAE6
   WbsqeOXbxCwUsGI+aSGUq7pyhire3XCIKoGpqalAFSwfziSmsAGm9Dm1n
   CzHPImKZFEs+5/AMXAZbptoMWVljgD3397QNg10OGs0BHUxbi18bUUfB2
   Q9qYsXD3io9bJGjqQe/uI1IN4s240YHNYV6xKyYWhboZ4Fu5ebLp+tFDv
   SqxDXTPVR5rvmWf7cdyMed2sLzqR6nbYuJftr3uYZkOXTJT3xq+S86WC1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="304058541"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="304058541"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 03:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="903164798"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="903164798"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2023 03:28:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A03854E3; Thu, 12 Jan 2023 13:28:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/5] ASoC: Intel: sof_es8336: Drop reference count of ACPI device after use
Date:   Thu, 12 Jan 2023 13:28:52 +0200
Message-Id: <20230112112852.67714-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
References: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theoretically the device might gone if its reference count drops to 0.
This might be the case when we try to find the first physical node of
the ACPI device. We need to keep reference to it until we get a result
of the above mentioned call. Refactor the code to drop the reference
count at the correct place.

While at it, move to acpi_dev_put() as symmetrical call to the
acpi_dev_get_first_match_dev().

Fixes: a164137ce91a ("ASoC: Intel: add machine driver for SOF+ES8336")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/sof_es8336.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index 773e5d1d87d4..894b6610b9e2 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -681,7 +681,6 @@ static int sof_es8336_probe(struct platform_device *pdev)
 	if (adev) {
 		snprintf(codec_name, sizeof(codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
-		put_device(&adev->dev);
 		dai_links[0].codecs->name = codec_name;
 
 		/* also fixup codec dai name if relevant */
@@ -692,16 +691,19 @@ static int sof_es8336_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	ret = snd_soc_fixup_dai_links_platform_name(&sof_es8336_card,
-						    mach->mach_params.platform);
-	if (ret)
-		return ret;
-
 	codec_dev = acpi_get_first_physical_node(adev);
+	acpi_dev_put(adev);
 	if (!codec_dev)
 		return -EPROBE_DEFER;
 	priv->codec_dev = get_device(codec_dev);
 
+	ret = snd_soc_fixup_dai_links_platform_name(&sof_es8336_card,
+						    mach->mach_params.platform);
+	if (ret) {
+		put_device(codec_dev);
+		return ret;
+	}
+
 	if (quirk & SOF_ES8336_JD_INVERTED)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("everest,jack-detect-inverted");
 
-- 
2.39.0

