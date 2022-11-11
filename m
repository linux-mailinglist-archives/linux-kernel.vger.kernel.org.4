Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F95962526F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiKKEZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiKKEZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:25:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015FB6828E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668140706; x=1699676706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rRCWr54MBfM38aSNFQijVwdAC/iSuunIyJ/8rXD9+Rw=;
  b=EQSYBhSGESzefNchMxwiM4MNyUvQCUKDoEx7lksBkYolNHpwyJhhQDtE
   0KS75tExJivFZI8fsbeSCJ4g8Zry1Cl1gg8S5EJ4oBx8Oz8hd+SC7LBDp
   KfXmJgYCk2Kdkom3DGYp6BNdvgbWmVVCCAOiCVfjgojAGL6inlRQXfawj
   TSBOEsBj00mt4PCKo/J7LPXExCvQMnoJ5BEJjybsJb61bgEXvzW/KnEze
   Apcfoye5n79zR7/B/ZolWkTrD4OVrvPb/M6SHKkLObiRXza/svtQe1+aw
   uxMaNQF16GyFP2hdISNy7/AeShlQ9+XPo6VfGtVupxaCtZoBbQZyN2Bc2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397816275"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397816275"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588440660"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="588440660"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:04 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/8] soundwire: intel_init: remove useless interrupt enablement in interrupt thread
Date:   Fri, 11 Nov 2022 12:26:46 +0800
Message-Id: <20221111042653.45520-2-yung-chuan.liao@linux.intel.com>
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

When the code reaches the SoundWire interrupt thread handling, the
interrupt was enabled already, and there is no code that disables it
-> this is a no-op sequence.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index d091513919df..8bd95c9cbcaf 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -157,7 +157,6 @@ irqreturn_t sdw_intel_thread(int irq, void *dev_id)
 	list_for_each_entry(link, &ctx->link_list, list)
 		sdw_cdns_irq(irq, link->cdns);
 
-	sdw_intel_enable_irq(ctx->mmio_base, true);
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL_NS(sdw_intel_thread, SOUNDWIRE_INTEL_INIT);
-- 
2.25.1

