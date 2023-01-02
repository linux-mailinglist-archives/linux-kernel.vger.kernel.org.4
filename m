Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E81C65B71D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjABUaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbjABUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:30:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4C2BE3F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672691388; x=1704227388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XBGxwjOTps8fLgKAqKNuNDLJBvUHEDjGUgWj7WtL0nw=;
  b=DCeeyZDH4SdWQdedMfu6aFwwmmPs3iTaiyT0mF7KX2DLh6C1CSuJBMeU
   yXP3OofJO3bps1Qv0e5lmVrP8UBryO70+hnZ9+c/5Fe/dIE7gPNx6xxF3
   RWmRt7wVhfkMNlOwXea13qeOFBjJ8hkJMc8/zPopFcI3aKVf8oU7H80/i
   8UfqKc8rjKAqo6LZJn4+wUh/nwFmGpLgQWT8jSXjSXYGMuoHTj/EaYULj
   74RBKOXdtKqXJOF1o9YK7NkD8akrNOdozstJkt/EvFCFc+EfeGg1+fpuh
   xJmqMuDA1r7j9uN2BCHnGp++PjkhpKtsPJowuBKnOYo99BD0kEuJk/0jE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="321602403"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="321602403"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 12:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="717889959"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="717889959"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jan 2023 12:29:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3ECC84; Mon,  2 Jan 2023 22:30:16 +0200 (EET)
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
Subject: [PATCH v1 2/6] ASoC: Intel: bytcht_es8316: Drop reference count of ACPI device after use
Date:   Mon,  2 Jan 2023 22:30:10 +0200
Message-Id: <20230102203014.16041-2-andriy.shevchenko@linux.intel.com>
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

Fixes: 3c22a73fb873 ("ASoC: Intel: bytcht_es8316: fix HID handling")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 09d1f0f6d686..df157b01df8b 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -497,21 +497,28 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	if (adev) {
 		snprintf(codec_name, sizeof(codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
-		put_device(&adev->dev);
 		byt_cht_es8316_dais[dai_index].codecs->name = codec_name;
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
 	/* override platform name, if required */
 	byt_cht_es8316_card.dev = dev;
 	platform_name = mach->mach_params.platform;
 
 	ret = snd_soc_fixup_dai_links_platform_name(&byt_cht_es8316_card,
 						    platform_name);
-	if (ret)
+	if (ret) {
+		put_device(codec_dev);
 		return ret;
+	}
 
 	/* Check for BYTCR or other platform and setup quirks */
 	dmi_id = dmi_first_match(byt_cht_es8316_quirk_table);
@@ -539,13 +546,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 	/* get the clock */
 	priv->mclk = devm_clk_get(dev, "pmc_plt_clk_3");
-	if (IS_ERR(priv->mclk))
+	if (IS_ERR(priv->mclk)) {
+		put_device(codec_dev);
 		return dev_err_probe(dev, PTR_ERR(priv->mclk), "clk_get pmc_plt_clk_3 failed\n");
-
-	codec_dev = acpi_get_first_physical_node(adev);
-	if (!codec_dev)
-		return -EPROBE_DEFER;
-	priv->codec_dev = get_device(codec_dev);
+	}
 
 	if (quirk & BYT_CHT_ES8316_JD_INVERTED)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("everest,jack-detect-inverted");
-- 
2.35.1

