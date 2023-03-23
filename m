Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EEB6C5ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCWFbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCWFat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:30:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911C620A11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549436; x=1711085436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yWd/ohEBxlz+ikb3Ien04/YoMLYTHRZPHh64E+lRlNo=;
  b=mq6DzXdhUIrNEC/ox9ZeggoD4KKN60+8KXPNa/f5Gfhmhnh6Oh2W3+Yk
   bgrVlUwU6wP72xzcbabAiYSx2NsVTwuWVP4wMdSUzsGV0uwTGh3S5Yt1G
   NxQipK7rOd1YSvXBIWUIUY2gzQZR2paeDVPTTwpjS1CUJVScqT6Bxjiwn
   o8+5gWrhdrsUai2x7Xa4Sre12FxWH65BIyr+7E2G5I52monNrRaisJqZ/
   1jYlZWDjHyVLdJJtjy/RsxrMeQCCVytkiFjn622gzJlyCBwDhsGlV3iLX
   1cov93almavCTHwVK8OFNx+L/Cu/gYbzSO5W0Z+mlmkzsZUfu2RC0X+r8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779334"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779334"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567025"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567025"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:03 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 06/20] ASoC/soundwire: intel: pass hdac_bus pointer for link management
Date:   Thu, 23 Mar 2023 13:44:38 +0800
Message-Id: <20230323054452.1543233-7-yung-chuan.liao@linux.intel.com>
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

The hdac_bus pointer is used to access the extended link information
and handle power management. Pass it from the SOF driver down to the
auxiliary devices.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.h           | 4 ++++
 drivers/soundwire/intel_init.c      | 2 ++
 include/linux/soundwire/sdw_intel.h | 4 ++++
 sound/soc/sof/intel/hda.c           | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 1b23292bb8be..cf9db4906de4 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -4,6 +4,8 @@
 #ifndef __SDW_INTEL_LOCAL_H
 #define __SDW_INTEL_LOCAL_H
 
+struct hdac_bus;
+
 /**
  * struct sdw_intel_link_res - Soundwire Intel link resource structure,
  * typically populated by the controller driver.
@@ -23,6 +25,7 @@
  * @link_mask: global mask needed for power-up/down sequences
  * @cdns: Cadence master descriptor
  * @list: used to walk-through all masters exposed by the same controller
+ * @hbus: hdac_bus pointer, needed for power management
  */
 struct sdw_intel_link_res {
 	const struct sdw_intel_hw_ops *hw_ops;
@@ -42,6 +45,7 @@ struct sdw_intel_link_res {
 	u32 link_mask;
 	struct sdw_cdns *cdns;
 	struct list_head list;
+	struct hdac_bus *hbus;
 };
 
 struct sdw_intel {
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 43d339c6bcee..c918d2b81cc3 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -84,6 +84,8 @@ static struct sdw_intel_link_dev *intel_link_dev_register(struct sdw_intel_res *
 	link->shim_mask = &ctx->shim_mask;
 	link->link_mask = ctx->link_mask;
 
+	link->hbus = res->hbus;
+
 	/* now follow the two-step init/add sequence */
 	ret = auxiliary_device_init(auxdev);
 	if (ret < 0) {
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 88eb5bf98140..c4281aa06e2e 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -269,6 +269,8 @@ struct sdw_intel_slave_id {
 	struct sdw_slave_id id;
 };
 
+struct hdac_bus;
+
 /**
  * struct sdw_intel_ctx - context allocated by the controller
  * driver probe
@@ -324,6 +326,7 @@ struct sdw_intel_ctx {
  * @shim_base: sdw shim base.
  * @alh_base: sdw alh base.
  * @ext: extended HDaudio link support
+ * @hbus: hdac_bus pointer, needed for power management
  */
 struct sdw_intel_res {
 	const struct sdw_intel_hw_ops *hw_ops;
@@ -339,6 +342,7 @@ struct sdw_intel_res {
 	u32 shim_base;
 	u32 alh_base;
 	bool ext;
+	struct hdac_bus *hbus;
 };
 
 /*
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index db103524be4f..22eba57bb3e6 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -229,6 +229,7 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 	res.ops = &sdw_callback;
 	res.dev = sdev->dev;
 	res.clock_stop_quirks = sdw_clock_stop_quirks;
+	res.hbus = sof_to_bus(sdev);
 
 	/*
 	 * ops and arg fields are not populated for now,
-- 
2.25.1

