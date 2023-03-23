Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24BC6C5EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCWFbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjCWFaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:30:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB4D22113
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549450; x=1711085450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dypjg8PFg6rfCWgJzAX1z/pRx6Y007Vaip829IVJOYA=;
  b=TZkcS3iwz0QtE1UXsmvdETBnMn9O9224P2UCSI74RqyU57TsrLRQq8u3
   FztCS4JjeZH9pX/YPxBAV7vWIMvU6eZFG/vdsLGPtPruhwnQqlyQZtEAM
   EM7K6xDMciJ5JsJbVLeertTDMjQ2PX/Bj1eEBfQ9weN5ULFZgp4l0p2LE
   aa/vtL2od1xXlXgrD2rfCvmpVVqWOP9EjWCZaZMobZEGQ5ME0ocIipgPy
   Nr7hFk7vC/8nvv7ixBLBx1hyAViScOadI130fsArCbkyApXj5jVxm8wfK
   SYkam1mfdWQqeCWW4kOVYCNI32mTGQYOdhmOZ0Bm0JA/rxUaaN4hab7PG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779384"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779384"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567073"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567073"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:10 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 09/20] soundwire: intel_init: use eml_lock parameter
Date:   Thu, 23 Mar 2023 13:44:41 +0800
Message-Id: <20230323054452.1543233-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Now that the ASoC/SOF/HDAudio parts has retrieved the mutex and set
the parameter, we can use it to share the same synchronization across
the two domains.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index c918d2b81cc3..534c8795e7e8 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -69,18 +69,19 @@ static struct sdw_intel_link_dev *intel_link_dev_register(struct sdw_intel_res *
 		link->ip_offset = 0;
 		link->shim = res->mmio_base + res->shim_base;
 		link->alh = res->mmio_base + res->alh_base;
+		link->shim_lock = &ctx->shim_lock;
 	} else {
 		link->registers = res->mmio_base + SDW_IP_BASE(link_id);
 		link->ip_offset = SDW_CADENCE_MCP_IP_OFFSET;
 		link->shim = res->mmio_base +  SDW_SHIM2_GENERIC_BASE(link_id);
 		link->shim_vs = res->mmio_base + SDW_SHIM2_VS_BASE(link_id);
+		link->shim_lock = res->eml_lock;
 	}
 
 	link->ops = res->ops;
 	link->dev = res->dev;
 
 	link->clock_stop_quirks = res->clock_stop_quirks;
-	link->shim_lock = &ctx->shim_lock;
 	link->shim_mask = &ctx->shim_mask;
 	link->link_mask = ctx->link_mask;
 
-- 
2.25.1

