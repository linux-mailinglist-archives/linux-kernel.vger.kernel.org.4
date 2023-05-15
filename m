Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17A702553
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbjEOGu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240241AbjEOGur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:50:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5728E1BE4
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133436; x=1715669436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aAq1nEu0w9jquwDbM8Ql9Dgc92dfowXErHtU9iHqtg8=;
  b=TxaZ0l8wg/g2jE/7zo9RI6M0iFjVo5bXlw3Hveecx4e3ZlwzGMXyZQJ0
   47JjznsyZTyoE1doqL5agoWLlfRVrBnZyDGCwfaHMW+b4lhb2w2iZuubM
   dVztqYchRLcEMcYwgFbQPJ47C6nuwx6zESnyTKCz4XAxzQYBskrIX8RT0
   SnHOtlkaG1obMLVDny7hDjP/gkFEK2CvsFw1Lo4Rsv0NzatosQeX6oMAU
   C7Y/RS4y8Lu4Di6kht2Iid0RKRCEPUKJ65+w/muv6oT2boGhVrsOj6Mg4
   Jx3HmQ65monnG3E6nA5h+L/mrgmfvvgNiKYP1ghy9O0U4Iil0z41IAS5u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966321"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966321"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908635"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908635"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:33 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 06/26] ASoC/soundwire: intel: pass hdac_bus pointer for link management
Date:   Mon, 15 May 2023 15:10:22 +0800
Message-Id: <20230515071042.2038-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Acked-by: Mark Brown <broonie@kernel.org>
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
index 793baf60c78b..4d48f4018617 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -189,6 +189,7 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 	res.ops = &sdw_callback;
 	res.dev = sdev->dev;
 	res.clock_stop_quirks = sdw_clock_stop_quirks;
+	res.hbus = sof_to_bus(sdev);
 
 	/*
 	 * ops and arg fields are not populated for now,
-- 
2.25.1

