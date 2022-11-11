Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8C624F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiKKB3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiKKB3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:29:50 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9296174F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668130189; x=1699666189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYiDQPgjBaCQBv2w5jPoqX2GJ5LdaCHQOFIhXNW5cGk=;
  b=cEdxJbt9AoElSDofCPWeTcJAtSr/8+sWJkHmaYL4OZYSDXskiQ65J0DZ
   TIQE4ODHaB0UvE/afL7BxUV2xHiPICGdIwon245ibWfEBH/GvL5IOlo6U
   m9MzqqtcCZrlPsKvF9BAwFTFwOEu54pbszL4dR+3jTAiRPY8sF2mih4T2
   PVyp8sHrq9NFHbE6Spgfw69wdOfXb0a1XNYQSgXnjyedlzqxQxDio3aA2
   3McHIcnqFAEvz0uzIhOqXV1cZMpVgYyZxPPzccpcyYOrfh0L6iH/GYqqi
   LYEUWuERasQ7etCnrAt8+zE2Fsk82mhgDaKTLLFqbs3sRszE1rPvt2WuY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294847802"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="294847802"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780003220"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="780003220"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:47 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 1/7] soundwire: intel: start using hw_ops
Date:   Fri, 11 Nov 2022 09:31:28 +0800
Message-Id: <20221111013135.38289-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
References: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Before introducing new hardware with completely different register
spaces and programming sequences, we need to abstract some of the
existing routines in hw_ops that will be platform-specific. For now we
only use the 'cnl' ops - after the first Intel platform with SoundWire
capabilities.

Rather than one big intrusive patch, hw_ops are introduced in this
patch so show the dependencies between drivers. Follow-up patches will
introduce callbacks for debugfs, power and bus management.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 38 +++++++++++++++++++++++------
 drivers/soundwire/intel.h           |  3 +++
 drivers/soundwire/intel_init.c      |  1 +
 include/linux/soundwire/sdw_intel.h | 15 ++++++++++++
 sound/soc/sof/intel/hda.c           |  2 ++
 5 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index b9cb7e31ddb3..f88319f8ded4 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -745,10 +745,10 @@ static int intel_free_stream(struct sdw_intel *sdw,
  * bank switch routines
  */
 
-static int intel_pre_bank_switch(struct sdw_bus *bus)
+static int intel_pre_bank_switch(struct sdw_intel *sdw)
 {
-	struct sdw_cdns *cdns = bus_to_cdns(bus);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_bus *bus = &cdns->bus;
 
 	/* Write to register only for multi-link */
 	if (!bus->multi_link)
@@ -759,10 +759,10 @@ static int intel_pre_bank_switch(struct sdw_bus *bus)
 	return 0;
 }
 
-static int intel_post_bank_switch(struct sdw_bus *bus)
+static int intel_post_bank_switch(struct sdw_intel *sdw)
 {
-	struct sdw_cdns *cdns = bus_to_cdns(bus);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_bus *bus = &cdns->bus;
 	void __iomem *shim = sdw->link_res->shim;
 	int sync_reg, ret;
 
@@ -1422,6 +1422,28 @@ static int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
 	return 0;
 }
 
+const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
+	.pre_bank_switch = intel_pre_bank_switch,
+	.post_bank_switch = intel_post_bank_switch,
+};
+EXPORT_SYMBOL_NS(sdw_intel_cnl_hw_ops, SOUNDWIRE_INTEL);
+
+static int generic_pre_bank_switch(struct sdw_bus *bus)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+
+	return sdw->link_res->hw_ops->pre_bank_switch(sdw);
+}
+
+static int generic_post_bank_switch(struct sdw_bus *bus)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+
+	return sdw->link_res->hw_ops->post_bank_switch(sdw);
+}
+
 static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 {
 	struct sdw_master_prop *prop = &bus->prop;
@@ -1477,8 +1499,8 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.xfer_msg_defer = cdns_xfer_msg_defer,
 	.reset_page_addr = cdns_reset_page_addr,
 	.set_bus_conf = cdns_bus_conf,
-	.pre_bank_switch = intel_pre_bank_switch,
-	.post_bank_switch = intel_post_bank_switch,
+	.pre_bank_switch = generic_pre_bank_switch,
+	.post_bank_switch = generic_post_bank_switch,
 	.read_ping_status = cdns_read_ping_status,
 };
 
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index cd93a44dba9a..3170df76b411 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -7,6 +7,7 @@
 /**
  * struct sdw_intel_link_res - Soundwire Intel link resource structure,
  * typically populated by the controller driver.
+ * @hw_ops: platform-specific ops
  * @mmio_base: mmio base of SoundWire registers
  * @registers: Link IO registers base
  * @shim: Audio shim pointer
@@ -22,6 +23,8 @@
  * @list: used to walk-through all masters exposed by the same controller
  */
 struct sdw_intel_link_res {
+	const struct sdw_intel_hw_ops *hw_ops;
+
 	void __iomem *mmio_base; /* not strictly needed, useful for debug */
 	void __iomem *registers;
 	void __iomem *shim;
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index d091513919df..1e6d74b3e773 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -60,6 +60,7 @@ static struct sdw_intel_link_dev *intel_link_dev_register(struct sdw_intel_res *
 
 	/* Add link information used in the driver probe */
 	link = &ldev->link_res;
+	link->hw_ops = res->hw_ops;
 	link->mmio_base = res->mmio_base;
 	link->registers = res->mmio_base + SDW_LINK_BASE
 		+ (SDW_LINK_SIZE * link_id);
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 2e9fd91572d4..2dbe34b41ef1 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -233,6 +233,7 @@ struct sdw_intel_ctx {
  * struct sdw_intel_res - Soundwire Intel global resource structure,
  * typically populated by the DSP driver
  *
+ * @hw_ops: abstraction for platform ops
  * @count: link count
  * @mmio_base: mmio base of SoundWire registers
  * @irq: interrupt number
@@ -249,6 +250,7 @@ struct sdw_intel_ctx {
  * @alh_base: sdw alh base.
  */
 struct sdw_intel_res {
+	const struct sdw_intel_hw_ops *hw_ops;
 	int count;
 	void __iomem *mmio_base;
 	int irq;
@@ -292,4 +294,17 @@ irqreturn_t sdw_intel_thread(int irq, void *dev_id);
 
 #define SDW_INTEL_QUIRK_MASK_BUS_DISABLE      BIT(1)
 
+struct sdw_intel;
+
+/* struct intel_sdw_hw_ops - SoundWire ops for Intel platforms.
+ * @pre_bank_switch: helper for bus management
+ * @post_bank_switch: helper for bus management
+ */
+struct sdw_intel_hw_ops {
+	int (*pre_bank_switch)(struct sdw_intel *sdw);
+	int (*post_bank_switch)(struct sdw_intel *sdw);
+};
+
+extern const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops;
+
 #endif
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 1188ec51816b..3d6254489056 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -188,6 +188,7 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 
 	memset(&res, 0, sizeof(res));
 
+	res.hw_ops = &sdw_intel_cnl_hw_ops;
 	res.mmio_base = sdev->bar[HDA_DSP_BAR];
 	res.shim_base = hdev->desc->sdw_shim_base;
 	res.alh_base = hdev->desc->sdw_alh_base;
@@ -1694,3 +1695,4 @@ MODULE_IMPORT_NS(SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 MODULE_IMPORT_NS(SND_SOC_SOF_XTENSA);
 MODULE_IMPORT_NS(SND_INTEL_SOUNDWIRE_ACPI);
 MODULE_IMPORT_NS(SOUNDWIRE_INTEL_INIT);
+MODULE_IMPORT_NS(SOUNDWIRE_INTEL);
-- 
2.25.1

