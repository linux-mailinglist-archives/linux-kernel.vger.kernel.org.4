Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440BD65B71E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjABUaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbjABUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:30:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3928BE16
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672691403; x=1704227403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7rKbo4AdxYG+GzOO5clxIrqEj+fvxpX/EkpIQCJnFrg=;
  b=Ty6ewvzK3YNdY+ISZQtcxENPTAfdBo3eTxBNGz8DpKcElYB89bFWbjcT
   twFDhrjILWBkjr1kzp5fQrkgzX0CZNNo/27beiUOslgs8IQloT47mfKUU
   06ITZeNhN2OA/eEsmRHWER6UZ3BXYxTnib/S7MtmBa+U5+KBfhd1qbEY2
   ShcPr4H/6eCu3NFLqZxSRyZy3LGTB6JUqyOMoOcPd1Qfibz9BGRu7SSxI
   gvGiD7MBoR4OsmVMGLKskeIlezpn/TIhV1TevakQAQLscUSPp+IwhSuJu
   d/nZyjeKrK53WnYPHwN8DSaCF/PSdDCzXodJVQdbx7Wr8y3tOHd3JPSy/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="321602411"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="321602411"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 12:29:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="717889964"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="717889964"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jan 2023 12:29:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CC47B162; Mon,  2 Jan 2023 22:30:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/6] ASoC: Intel: bytcr_rt5640: Drop reference count of ACPI device after use
Date:   Mon,  2 Jan 2023 22:30:12 +0200
Message-Id: <20230102203014.16041-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102203014.16041-1-andriy.shevchenko@linux.intel.com>
References: <20230102203014.16041-1-andriy.shevchenko@linux.intel.com>
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

Fixes: a232b96dcece ("ASoC: Intel: bytcr_rt5640: use HID translation util")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4699ca79f3ea..79e0039c79a3 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1636,13 +1636,18 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	if (adev) {
 		snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
-		put_device(&adev->dev);
 		byt_rt5640_dais[dai_index].codecs->name = byt_rt5640_codec_name;
 	} else {
 		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
 		return -ENXIO;
 	}
 
+	codec_dev = acpi_get_first_physical_node(adev);
+	acpi_dev_put(adev);
+	if (!codec_dev)
+		return -EPROBE_DEFER;
+	priv->codec_dev = get_device(codec_dev);
+
 	/*
 	 * swap SSP0 if bytcr is detected
 	 * (will be overridden if DMI quirk is detected)
@@ -1717,11 +1722,6 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		byt_rt5640_quirk = quirk_override;
 	}
 
-	codec_dev = acpi_get_first_physical_node(adev);
-	if (!codec_dev)
-		return -EPROBE_DEFER;
-	priv->codec_dev = get_device(codec_dev);
-
 	if (byt_rt5640_quirk & BYT_RT5640_JD_HP_ELITEP_1000G2) {
 		acpi_dev_add_driver_gpios(ACPI_COMPANION(priv->codec_dev),
 					  byt_rt5640_hp_elitepad_1000g2_gpios);
-- 
2.35.1

