Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5F7077FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjERCVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjERCVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:21:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A9C172E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684376509; x=1715912509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5R52rMefrg7AC6InG7PmqTlOvY+GWOInNf87oqgcKqM=;
  b=ZeVA35bO6gQylIKyXe65jsryflX64HGVAXBNrPvFXjSzrHzo7xgGUymR
   yFSRZWyMHd2OmGSfbgBxQ7Bwvbl7Cfu7e+uY/udJybq53Iu3cL6TDwK7M
   +7uwPwdJLKSGuNObzKAw9R7OsMdZ50fMdsGKfmF5kQMmSjLCXIU6ezFTk
   tKrPr5FHkIGbgvKnp/WDr4NFWxwWNkAGquUvPtoYjD9XpHauBWUyGzSws
   R79M+oLDtzBxm0+cG3QjW6hOYXyYtCpgJ0max7+g1uYSD6ZM/RdxLQBfJ
   4kMFIFNL1McY1KCQqzC7DDp85WGvI146t4XeP1H8QsbRaRKwwbM+FDdSL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="341339095"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="341339095"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="876255299"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="876255299"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:21:26 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: intel_bus_common: update error log
Date:   Thu, 18 May 2023 10:42:15 +0800
Message-Id: <20230518024215.164281-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We use __func__ in all calls of sdw_cdns_check_self_clearing_bits(),
except in one case. Likely an editing miss when the code was
refactored.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_bus_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index be0c93106fc8..e5ac3cc7cb79 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -182,8 +182,7 @@ int intel_start_bus_after_clock_stop(struct sdw_intel *sdw)
 		return ret;
 	}
 
-	sdw_cdns_check_self_clearing_bits(cdns, "intel_resume_runtime no_quirks",
-					  true, INTEL_MASTER_RESET_ITERATIONS);
+	sdw_cdns_check_self_clearing_bits(cdns, __func__, true, INTEL_MASTER_RESET_ITERATIONS);
 
 	return 0;
 }
-- 
2.25.1

