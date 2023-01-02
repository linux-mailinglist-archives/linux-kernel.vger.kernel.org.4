Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8242565B720
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbjABUaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjABUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:30:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0353FBE1A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672691403; x=1704227403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jaaT5T3K18xgkyMdPptdmWzbRbrNy2o8GnbiBUb2YQg=;
  b=RFH3Gp0VtnTiD9Zs2wqVbbgn0KECLOPMWXn8EGFAmpIHs6zdDgiEWA4v
   hDCBMrgYr0LQgWx6aTFSXq8QoEwITWHvSzaP/anxbujPQN3H3DZBq2zB8
   eHE1jvjyptzpBWWYZ47pSJHvQ6NjI4nvOkTdpqaNSfD4vuQMvzOsfFWbM
   +AhjpMzqOAZQUXnq/BT14PI0vJGqRUYBi0NTDNSfYzhagK6b50XmW4aaE
   uFa7HxBAGd4e5w3SY9Vo+MJ4KjywSfrvNMz0Dykv1aBA5BbA1oq18f8LK
   M9otb+oQSr7WNZunpwDTbQNha0xZcmineWFtH4L69VHPi6QnzQtyELKyR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="321602419"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="321602419"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 12:29:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="717889962"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="717889962"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jan 2023 12:29:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D6DAF1CA; Mon,  2 Jan 2023 22:30:16 +0200 (EET)
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
Subject: [PATCH v1 5/6] ASoC: Intel: bytcr_wm5102: Drop reference count of ACPI device after use
Date:   Mon,  2 Jan 2023 22:30:13 +0200
Message-Id: <20230102203014.16041-5-andriy.shevchenko@linux.intel.com>
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
2.35.1

