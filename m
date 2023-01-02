Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B67865B725
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbjABUbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjABUaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:30:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D33BE1C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672691412; x=1704227412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aAfymOW/PhGFtC4itped/S1oIrcSAbEZCmbLAIqF9mc=;
  b=NV7CMRfi5nn1XGhrODdveXeJKeovzp5Uw4MghwfyfhaAUrTk//AbAxg2
   ue5RJqxAzgXf8DAVep8Csfn9L6Pik+zeRNFFjrMfTAyZhqn7X7UpV68r/
   Hd/7I8CiStFpims29zTFPjK7dp31zOuabTWRtE8aPXkhoamRtQBILMKhC
   AwG7DgJljlJ5UNkGeJRLnAk6nJQWdn4Olmp+ckb6Rvm1c4Lrk1n0xCEtp
   X4Ml6c3R6Y3bWKSvVeg9lxVk7TTA2z0vYigekKQF5uFT0omkRxOMMmfGz
   VngUY3L1+z0iSd3FKseHq7Yf9YQvqYCvBV1Zd6K2SnnzVKZAl6FKbk4hI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="322772210"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="322772210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 12:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="686987612"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="686987612"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Jan 2023 12:30:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C64E984; Mon,  2 Jan 2023 22:30:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 2/5] ASoC: Intel: bytcht_da7213: Replace open coded acpi_dev_put()
Date:   Mon,  2 Jan 2023 22:30:34 +0200
Message-Id: <20230102203037.16120-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling put_device(&adev->dev) where adev is a pointer
to an ACPI device, use specific call, i.e. acpi_dev_put().

Also move it out of the conditional to make it more visible in case
some other code will be added which may use that pointer. We need
to keep a reference as long as we use the pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_da7213.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index a0c8f1d3f8ce..a3b0cfab17b0 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -256,9 +256,9 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 	if (adev) {
 		snprintf(codec_name, sizeof(codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
-		put_device(&adev->dev);
 		dailink[dai_index].codecs->name = codec_name;
 	}
+	acpi_dev_put(adev);
 
 	/* override platform name, if required */
 	platform_name = mach->mach_params.platform;
-- 
2.35.1

