Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BA5667110
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjALLhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjALLgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:36:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3DF101CB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673522919; x=1705058919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9CUFrPQ09yPzbbj4IV4mmL6zJucv2gUZLtx+M2adKnU=;
  b=TpmvVMDAOyFLwEVQbRjWSukeGtX6lwIV/Ver0B5nICbGH/H5yVTExlCe
   BbjMbwU0J4ZvI6G8cLZ+PJloXsKYaCPz5O1M6tmEvQysMyCin8iqw4maL
   kUMHC1agz2c6fkxa5B+TH5xA6/24P6B47JnR+DPWEnKPl39ZNuwJmh7UC
   CEZxK/4x9bmyH9d3ZlVu+vWCQDHQwwhG6ezg0ypZYf/xUhpOC6W1+YEyg
   Om8SRQ5Fp0YA8sPyqa34k4mKhDKLDPoTJW2gtgUH9/fh0PL/zdIVBPeva
   jpXVvNIox3ED9ErABF1OdSjKviuc+JmO4LDOC/NKGH6dIshK2IFsMGHV0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385994966"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="385994966"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 03:28:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="986519420"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="986519420"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jan 2023 03:28:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95AFE330; Thu, 12 Jan 2023 13:28:56 +0200 (EET)
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
Subject: [PATCH v2 4/5] ASoC: Intel: bytcr_wm5102: Drop reference count of ACPI device after use
Date:   Thu, 12 Jan 2023 13:28:51 +0200
Message-Id: <20230112112852.67714-5-andriy.shevchenko@linux.intel.com>
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

Fixes: 9a87fc1e0619 ("ASoC: Intel: bytcr_wm5102: Add machine driver for BYT/WM5102")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_wm5102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index 1669eb3bd80f..c0706537f673 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -411,9 +411,9 @@ static int snd_byt_wm5102_mc_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 	snprintf(codec_name, sizeof(codec_name), "spi-%s", acpi_dev_name(adev));
-	put_device(&adev->dev);
 
 	codec_dev = bus_find_device_by_name(&spi_bus_type, NULL, codec_name);
+	acpi_dev_put(adev);
 	if (!codec_dev)
 		return -EPROBE_DEFER;
 
-- 
2.39.0

