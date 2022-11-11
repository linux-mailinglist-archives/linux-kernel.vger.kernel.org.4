Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6231A625278
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiKKEZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiKKEZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:25:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF568AC0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668140721; x=1699676721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fudGHXfFeW/SgWmmWXPOO07+6VgSMIOdTVYH/lYOqHI=;
  b=FL4qrxx9wX2oq0IgCm18baKidgMF+z/r4dcBkr2L4OLKCy7MrIZKwMQe
   GGpecj6UMPu7nO3Yt+8lG4h3dXHheh9va4S8dSm4GJcbJRgWVKu7KYCQV
   SPqgTS5OWP64d31mLow75HGsNCNyWDTNeIeJgCVkaHSix7Q//IBQ5ixVU
   Puok7rxt/7YMGNCj6Fqwg1oouCcJosQ7P8HLslUO1nw+DhZLF2dAl0dAM
   q+NL/sunTIYmMg6e2a5ZafD3S21i2Av5SVVF9bp/vvvm397H9ZUtT8zoo
   Azn9e4Mv43lxBuXYxloQ7euoSskJajzg/wMrf+YwOu9AX4a6+YlabJKh+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397816322"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397816322"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588440792"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="588440792"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:19 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 7/8] soundwire: intel_init: remove check on number of links
Date:   Fri, 11 Nov 2022 12:26:52 +0800
Message-Id: <20221111042653.45520-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
References: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The number of links is checked with a chip-dependent helper in the
caller, remove the check in drivers/soundwire/intel_init.c

This change makes intel_init.c hardware-agnostic - which is quite
fitting for a layer that only creates auxiliary devices.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 0df3cdd85793..d6842925de61 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -272,24 +272,12 @@ sdw_intel_startup_controller(struct sdw_intel_ctx *ctx)
 {
 	struct acpi_device *adev = acpi_fetch_acpi_dev(ctx->handle);
 	struct sdw_intel_link_dev *ldev;
-	u32 caps;
 	u32 link_mask;
 	int i;
 
 	if (!adev)
 		return -EINVAL;
 
-	/* Check SNDWLCAP.LCOUNT */
-	caps = ioread32(ctx->mmio_base + ctx->shim_base + SDW_SHIM_LCAP);
-	caps &= SDW_SHIM_LCAP_LCOUNT_MASK;
-
-	/* Check HW supported vs property value */
-	if (caps < ctx->count) {
-		dev_err(&adev->dev,
-			"BIOS master count is larger than hardware capabilities\n");
-		return -EINVAL;
-	}
-
 	if (!ctx->ldev)
 		return -EINVAL;
 
-- 
2.25.1

