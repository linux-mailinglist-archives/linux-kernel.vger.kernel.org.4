Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A5F65B727
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbjABUbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjABUaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:30:17 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C17BCB2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672691416; x=1704227416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JI+WQ+s6ndDirdEdZjDMNLxkK54gtzgsBmmyNW4/rLc=;
  b=eBq2D53wt5s4cTasAXQg0vlZKbEDf0oiT7ZyDYNvuG8D+ASRGS8uXdCt
   nZG7YTcVGPYnxQt/eRqxhNpdaGpL24QXdn+7xhfeZ6+I23HPtOBis7nyT
   D1BK2KYi6KhEDwu7xrxTO8yaMlQF+9ZlTv2ng1gn9ryYQpP2j+vS2x6Co
   ZMsVpSuyUcnXyT6oKvD/GRQraPO4iXkJAUlYIwsU1t7JdfJzxA5SAZ+6I
   NAMgCxTIWNyCrnM97YjhdgMPojdpC8mS6BFucNaXZRxVpfEBk/hqKhZ0D
   nMpxiE4pCn6JLhVctMJwmEJwADuVvMccke0Eh9QgRAIVm51sqRaRf1dCy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301224171"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="301224171"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 12:30:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="796962530"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="796962530"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2023 12:30:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B78B6F4; Mon,  2 Jan 2023 22:30:40 +0200 (EET)
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
Subject: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded acpi_dev_put()
Date:   Mon,  2 Jan 2023 22:30:33 +0200
Message-Id: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 sound/soc/intel/boards/bytcht_cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index 41cec67157b6..9942a2de6f7a 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -253,9 +253,9 @@ static int snd_byt_cht_cx2072x_probe(struct platform_device *pdev)
 	if (adev) {
 		snprintf(codec_name, sizeof(codec_name), "i2c-%s",
 			 acpi_dev_name(adev));
-		put_device(&adev->dev);
 		byt_cht_cx2072x_dais[dai_index].codecs->name = codec_name;
 	}
+	acpi_dev_put(adev);
 
 	/* override platform name, if required */
 	ret = snd_soc_fixup_dai_links_platform_name(&byt_cht_cx2072x_card,
-- 
2.35.1

