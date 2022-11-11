Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E58624F94
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKKBae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKKBaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:30:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF2561756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668130201; x=1699666201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1K171+GuLTJ4GyHu3bemwaBkNeNhXW7lLDgjVRwStEk=;
  b=ncOoWnyGC8GhPEw6ZCEbD0JgR9OD2aUOVQUa5GmkHSAqTCnCpp5I0zbH
   q86U1dnSBcKj/ySfW46brEfdFEWJkNfA4L9RpkOTE6M0od3Dw8bI1xTFW
   9EUGjoIzC/oonXTxheyhdA0fHFUJKknP2euAREdF+jORFlUHPRg+ASwBt
   sFGRdhG2n00VlR+cZph0EXF5c+zyG5DRH7ZW5Uc6A4RiwnXsyHHhf2A5U
   IC+VpPQuMci0ZlHtIZ32PoAHC4CuK9cCbPPuX7OyBJjlicn3Fik+KMYhX
   /lUlBUY0a+MuM4fLqRtbiSI4+b+6R1n9gIFnxkwneoR2YOmvF0lqCkCxW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294847848"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="294847848"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:30:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780003281"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="780003281"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:58 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 7/7] soundwire: intel: split auxdevice to different file
Date:   Fri, 11 Nov 2022 09:31:34 +0800
Message-Id: <20221111013135.38289-8-yung-chuan.liao@linux.intel.com>
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

The auxdevice layer is completely generic, it should be split from
intel.c which is only geared to the 'cnl' hw_ops now.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/Makefile          |   2 +-
 drivers/soundwire/intel.c           | 657 ---------------------------
 drivers/soundwire/intel.h           |  11 +-
 drivers/soundwire/intel_auxdevice.c | 678 ++++++++++++++++++++++++++++
 drivers/soundwire/intel_auxdevice.h |  18 +
 drivers/soundwire/intel_init.c      |   1 +
 6 files changed, 700 insertions(+), 667 deletions(-)
 create mode 100644 drivers/soundwire/intel_auxdevice.c
 create mode 100644 drivers/soundwire/intel_auxdevice.h

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 986776787b9e..ca97414ada70 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -20,7 +20,7 @@ soundwire-cadence-y := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
 
 #Intel driver
-soundwire-intel-y :=	intel.o intel_init.o dmi-quirks.o
+soundwire-intel-y :=	intel.o intel_auxdevice.o intel_init.o dmi-quirks.o
 obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 
 #Qualcomm driver
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index ea6479b4010d..bc9c50bacc49 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -8,10 +8,7 @@
 #include <linux/acpi.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/auxiliary_bus.h>
 #include <sound/pcm_params.h>
 #include <linux/pm_runtime.h>
 #include <sound/soc.h>
@@ -22,27 +19,6 @@
 #include "bus.h"
 #include "intel.h"
 
-/* IDA min selected to avoid conflicts with HDaudio/iDISP SDI values */
-#define INTEL_DEV_NUM_IDA_MIN           4
-
-#define INTEL_MASTER_SUSPEND_DELAY_MS	3000
-#define INTEL_MASTER_RESET_ITERATIONS	10
-
-/*
- * debug/config flags for the Intel SoundWire Master.
- *
- * Since we may have multiple masters active, we can have up to 8
- * flags reused in each byte, with master0 using the ls-byte, etc.
- */
-
-#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME		BIT(0)
-#define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP		BIT(1)
-#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE	BIT(2)
-#define SDW_INTEL_MASTER_DISABLE_MULTI_LINK		BIT(3)
-
-static int md_flags;
-module_param_named(sdw_md_flags, md_flags, int, 0444);
-MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags (0x0 all off)");
 
 enum intel_pdi_type {
 	INTEL_PDI_IN = 0,
@@ -1445,636 +1421,3 @@ const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
 };
 EXPORT_SYMBOL_NS(sdw_intel_cnl_hw_ops, SOUNDWIRE_INTEL);
 
-static int generic_pre_bank_switch(struct sdw_bus *bus)
-{
-	struct sdw_cdns *cdns = bus_to_cdns(bus);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
-
-	return sdw->link_res->hw_ops->pre_bank_switch(sdw);
-}
-
-static int generic_post_bank_switch(struct sdw_bus *bus)
-{
-	struct sdw_cdns *cdns = bus_to_cdns(bus);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
-
-	return sdw->link_res->hw_ops->post_bank_switch(sdw);
-}
-
-static int sdw_master_read_intel_prop(struct sdw_bus *bus)
-{
-	struct sdw_master_prop *prop = &bus->prop;
-	struct fwnode_handle *link;
-	char name[32];
-	u32 quirk_mask;
-
-	/* Find master handle */
-	snprintf(name, sizeof(name),
-		 "mipi-sdw-link-%d-subproperties", bus->link_id);
-
-	link = device_get_named_child_node(bus->dev, name);
-	if (!link) {
-		dev_err(bus->dev, "Master node %s not found\n", name);
-		return -EIO;
-	}
-
-	fwnode_property_read_u32(link,
-				 "intel-sdw-ip-clock",
-				 &prop->mclk_freq);
-
-	/* the values reported by BIOS are the 2x clock, not the bus clock */
-	prop->mclk_freq /= 2;
-
-	fwnode_property_read_u32(link,
-				 "intel-quirk-mask",
-				 &quirk_mask);
-
-	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
-		prop->hw_disabled = true;
-
-	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
-		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
-
-	return 0;
-}
-
-static int intel_prop_read(struct sdw_bus *bus)
-{
-	/* Initialize with default handler to read all DisCo properties */
-	sdw_master_read_prop(bus);
-
-	/* read Intel-specific properties */
-	sdw_master_read_intel_prop(bus);
-
-	return 0;
-}
-
-static struct sdw_master_ops sdw_intel_ops = {
-	.read_prop = intel_prop_read,
-	.override_adr = sdw_dmi_override_adr,
-	.xfer_msg = cdns_xfer_msg,
-	.xfer_msg_defer = cdns_xfer_msg_defer,
-	.reset_page_addr = cdns_reset_page_addr,
-	.set_bus_conf = cdns_bus_conf,
-	.pre_bank_switch = generic_pre_bank_switch,
-	.post_bank_switch = generic_post_bank_switch,
-	.read_ping_status = cdns_read_ping_status,
-};
-
-/*
- * probe and init (aux_dev_id argument is required by function prototype but not used)
- */
-static int intel_link_probe(struct auxiliary_device *auxdev,
-			    const struct auxiliary_device_id *aux_dev_id)
-
-{
-	struct device *dev = &auxdev->dev;
-	struct sdw_intel_link_dev *ldev = auxiliary_dev_to_sdw_intel_link_dev(auxdev);
-	struct sdw_intel *sdw;
-	struct sdw_cdns *cdns;
-	struct sdw_bus *bus;
-	int ret;
-
-	sdw = devm_kzalloc(dev, sizeof(*sdw), GFP_KERNEL);
-	if (!sdw)
-		return -ENOMEM;
-
-	cdns = &sdw->cdns;
-	bus = &cdns->bus;
-
-	sdw->instance = auxdev->id;
-	sdw->link_res = &ldev->link_res;
-	cdns->dev = dev;
-	cdns->registers = sdw->link_res->registers;
-	cdns->instance = sdw->instance;
-	cdns->msg_count = 0;
-
-	bus->link_id = auxdev->id;
-	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
-	bus->clk_stop_timeout = 1;
-
-	sdw_cdns_probe(cdns);
-
-	/* Set ops */
-	bus->ops = &sdw_intel_ops;
-
-	/* set driver data, accessed by snd_soc_dai_get_drvdata() */
-	auxiliary_set_drvdata(auxdev, cdns);
-
-	/* use generic bandwidth allocation algorithm */
-	sdw->cdns.bus.compute_params = sdw_compute_params;
-
-	/* avoid resuming from pm_runtime suspend if it's not required */
-	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
-
-	ret = sdw_bus_master_add(bus, dev, dev->fwnode);
-	if (ret) {
-		dev_err(dev, "sdw_bus_master_add fail: %d\n", ret);
-		return ret;
-	}
-
-	if (bus->prop.hw_disabled)
-		dev_info(dev,
-			 "SoundWire master %d is disabled, will be ignored\n",
-			 bus->link_id);
-	/*
-	 * Ignore BIOS err_threshold, it's a really bad idea when dealing
-	 * with multiple hardware synchronized links
-	 */
-	bus->prop.err_threshold = 0;
-
-	return 0;
-}
-
-int intel_link_startup(struct auxiliary_device *auxdev)
-{
-	struct device *dev = &auxdev->dev;
-	struct sdw_cdns *cdns = auxiliary_get_drvdata(auxdev);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_bus *bus = &cdns->bus;
-	int link_flags;
-	bool multi_link;
-	u32 clock_stop_quirks;
-	int ret;
-
-	if (bus->prop.hw_disabled) {
-		dev_info(dev,
-			 "SoundWire master %d is disabled, ignoring\n",
-			 sdw->instance);
-		return 0;
-	}
-
-	link_flags = md_flags >> (bus->link_id * 8);
-	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
-	if (!multi_link) {
-		dev_dbg(dev, "Multi-link is disabled\n");
-	} else {
-		/*
-		 * hardware-based synchronization is required regardless
-		 * of the number of segments used by a stream: SSP-based
-		 * synchronization is gated by gsync when the multi-master
-		 * mode is set.
-		 */
-		bus->hw_sync_min_links = 1;
-	}
-	bus->multi_link = multi_link;
-
-	/* Initialize shim, controller */
-	ret = sdw_intel_link_power_up(sdw);
-	if (ret)
-		goto err_init;
-
-	/* Register DAIs */
-	ret = sdw_intel_register_dai(sdw);
-	if (ret) {
-		dev_err(dev, "DAI registration failed: %d\n", ret);
-		goto err_power_up;
-	}
-
-	sdw_intel_debugfs_init(sdw);
-
-	/* start bus */
-	ret = sdw_intel_start_bus(sdw);
-	if (ret) {
-		dev_err(dev, "bus start failed: %d\n", ret);
-		goto err_power_up;
-	}
-
-	/* Enable runtime PM */
-	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME)) {
-		pm_runtime_set_autosuspend_delay(dev,
-						 INTEL_MASTER_SUSPEND_DELAY_MS);
-		pm_runtime_use_autosuspend(dev);
-		pm_runtime_mark_last_busy(dev);
-
-		pm_runtime_set_active(dev);
-		pm_runtime_enable(dev);
-	}
-
-	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
-	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_NOT_ALLOWED) {
-		/*
-		 * To keep the clock running we need to prevent
-		 * pm_runtime suspend from happening by increasing the
-		 * reference count.
-		 * This quirk is specified by the parent PCI device in
-		 * case of specific latency requirements. It will have
-		 * no effect if pm_runtime is disabled by the user via
-		 * a module parameter for testing purposes.
-		 */
-		pm_runtime_get_noresume(dev);
-	}
-
-	/*
-	 * The runtime PM status of Slave devices is "Unsupported"
-	 * until they report as ATTACHED. If they don't, e.g. because
-	 * there are no Slave devices populated or if the power-on is
-	 * delayed or dependent on a power switch, the Master will
-	 * remain active and prevent its parent from suspending.
-	 *
-	 * Conditionally force the pm_runtime core to re-evaluate the
-	 * Master status in the absence of any Slave activity. A quirk
-	 * is provided to e.g. deal with Slaves that may be powered on
-	 * with a delay. A more complete solution would require the
-	 * definition of Master properties.
-	 */
-	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
-		pm_runtime_idle(dev);
-
-	sdw->startup_done = true;
-	return 0;
-
-err_power_up:
-	sdw_intel_link_power_down(sdw);
-err_init:
-	return ret;
-}
-
-static void intel_link_remove(struct auxiliary_device *auxdev)
-{
-	struct sdw_cdns *cdns = auxiliary_get_drvdata(auxdev);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_bus *bus = &cdns->bus;
-
-	/*
-	 * Since pm_runtime is already disabled, we don't decrease
-	 * the refcount when the clock_stop_quirk is
-	 * SDW_INTEL_CLK_STOP_NOT_ALLOWED
-	 */
-	if (!bus->prop.hw_disabled) {
-		sdw_intel_debugfs_exit(sdw);
-		sdw_cdns_enable_interrupt(cdns, false);
-	}
-	sdw_bus_master_delete(bus);
-}
-
-int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
-{
-	struct device *dev = &auxdev->dev;
-	struct sdw_intel *sdw;
-	struct sdw_bus *bus;
-
-	sdw = auxiliary_get_drvdata(auxdev);
-	bus = &sdw->cdns.bus;
-
-	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
-		return 0;
-	}
-
-	if (!sdw_intel_shim_check_wake(sdw))
-		return 0;
-
-	/* disable WAKEEN interrupt ASAP to prevent interrupt flood */
-	sdw_intel_shim_wake(sdw, false);
-
-	/*
-	 * resume the Master, which will generate a bus reset and result in
-	 * Slaves re-attaching and be re-enumerated. The SoundWire physical
-	 * device which generated the wake will trigger an interrupt, which
-	 * will in turn cause the corresponding Linux Slave device to be
-	 * resumed and the Slave codec driver to check the status.
-	 */
-	pm_request_resume(dev);
-
-	return 0;
-}
-
-/*
- * PM calls
- */
-
-static int intel_resume_child_device(struct device *dev, void *data)
-{
-	int ret;
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-
-	if (!slave->probed) {
-		dev_dbg(dev, "skipping device, no probed driver\n");
-		return 0;
-	}
-	if (!slave->dev_num_sticky) {
-		dev_dbg(dev, "skipping device, never detected on bus\n");
-		return 0;
-	}
-
-	ret = pm_request_resume(dev);
-	if (ret < 0)
-		dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
-
-	return ret;
-}
-
-static int __maybe_unused intel_pm_prepare(struct device *dev)
-{
-	struct sdw_cdns *cdns = dev_get_drvdata(dev);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_bus *bus = &cdns->bus;
-	u32 clock_stop_quirks;
-	int ret;
-
-	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
-		return 0;
-	}
-
-	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
-
-	if (pm_runtime_suspended(dev) &&
-	    pm_runtime_suspended(dev->parent) &&
-	    ((clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) ||
-	     !clock_stop_quirks)) {
-		/*
-		 * if we've enabled clock stop, and the parent is suspended, the SHIM registers
-		 * are not accessible and the shim wake cannot be disabled.
-		 * The only solution is to resume the entire bus to full power
-		 */
-
-		/*
-		 * If any operation in this block fails, we keep going since we don't want
-		 * to prevent system suspend from happening and errors should be recoverable
-		 * on resume.
-		 */
-
-		/*
-		 * first resume the device for this link. This will also by construction
-		 * resume the PCI parent device.
-		 */
-		ret = pm_request_resume(dev);
-		if (ret < 0) {
-			dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
-			return 0;
-		}
-
-		/*
-		 * Continue resuming the entire bus (parent + child devices) to exit
-		 * the clock stop mode. If there are no devices connected on this link
-		 * this is a no-op.
-		 * The resume to full power could have been implemented with a .prepare
-		 * step in SoundWire codec drivers. This would however require a lot
-		 * of code to handle an Intel-specific corner case. It is simpler in
-		 * practice to add a loop at the link level.
-		 */
-		ret = device_for_each_child(bus->dev, NULL, intel_resume_child_device);
-
-		if (ret < 0)
-			dev_err(dev, "%s: intel_resume_child_device failed: %d\n", __func__, ret);
-	}
-
-	return 0;
-}
-
-static int __maybe_unused intel_suspend(struct device *dev)
-{
-	struct sdw_cdns *cdns = dev_get_drvdata(dev);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_bus *bus = &cdns->bus;
-	u32 clock_stop_quirks;
-	int ret;
-
-	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
-		return 0;
-	}
-
-	if (pm_runtime_suspended(dev)) {
-		dev_dbg(dev, "pm_runtime status: suspended\n");
-
-		clock_stop_quirks = sdw->link_res->clock_stop_quirks;
-
-		if ((clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) ||
-		    !clock_stop_quirks) {
-
-			if (pm_runtime_suspended(dev->parent)) {
-				/*
-				 * paranoia check: this should not happen with the .prepare
-				 * resume to full power
-				 */
-				dev_err(dev, "%s: invalid config: parent is suspended\n", __func__);
-			} else {
-				sdw_intel_shim_wake(sdw, false);
-			}
-		}
-
-		return 0;
-	}
-
-	ret = sdw_intel_stop_bus(sdw, false);
-	if (ret < 0) {
-		dev_err(dev, "%s: cannot stop bus: %d\n", __func__, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int __maybe_unused intel_suspend_runtime(struct device *dev)
-{
-	struct sdw_cdns *cdns = dev_get_drvdata(dev);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_bus *bus = &cdns->bus;
-	u32 clock_stop_quirks;
-	int ret;
-
-	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
-		return 0;
-	}
-
-	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
-
-	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
-		ret = sdw_intel_stop_bus(sdw, false);
-		if (ret < 0) {
-			dev_err(dev, "%s: cannot stop bus during teardown: %d\n",
-				__func__, ret);
-			return ret;
-		}
-	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET || !clock_stop_quirks) {
-		ret = sdw_intel_stop_bus(sdw, true);
-		if (ret < 0) {
-			dev_err(dev, "%s: cannot stop bus during clock_stop: %d\n",
-				__func__, ret);
-			return ret;
-		}
-	} else {
-		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
-			__func__, clock_stop_quirks);
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static int __maybe_unused intel_resume(struct device *dev)
-{
-	struct sdw_cdns *cdns = dev_get_drvdata(dev);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_bus *bus = &cdns->bus;
-	int link_flags;
-	int ret;
-
-	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
-		return 0;
-	}
-
-	link_flags = md_flags >> (bus->link_id * 8);
-
-	if (pm_runtime_suspended(dev)) {
-		dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
-
-		/* follow required sequence from runtime_pm.rst */
-		pm_runtime_disable(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_mark_last_busy(dev);
-		pm_runtime_enable(dev);
-
-		link_flags = md_flags >> (bus->link_id * 8);
-
-		if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
-			pm_runtime_idle(dev);
-	}
-
-	ret = sdw_intel_link_power_up(sdw);
-	if (ret) {
-		dev_err(dev, "%s failed: %d\n", __func__, ret);
-		return ret;
-	}
-
-	/*
-	 * make sure all Slaves are tagged as UNATTACHED and provide
-	 * reason for reinitialization
-	 */
-	sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
-
-	ret = sdw_intel_start_bus(sdw);
-	if (ret < 0) {
-		dev_err(dev, "cannot start bus during resume\n");
-		sdw_intel_link_power_down(sdw);
-		return ret;
-	}
-
-	/*
-	 * after system resume, the pm_runtime suspend() may kick in
-	 * during the enumeration, before any children device force the
-	 * master device to remain active.  Using pm_runtime_get()
-	 * routines is not really possible, since it'd prevent the
-	 * master from suspending.
-	 * A reasonable compromise is to update the pm_runtime
-	 * counters and delay the pm_runtime suspend by several
-	 * seconds, by when all enumeration should be complete.
-	 */
-	pm_runtime_mark_last_busy(dev);
-
-	return 0;
-}
-
-static int __maybe_unused intel_resume_runtime(struct device *dev)
-{
-	struct sdw_cdns *cdns = dev_get_drvdata(dev);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_bus *bus = &cdns->bus;
-	u32 clock_stop_quirks;
-	int ret;
-
-	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
-		return 0;
-	}
-
-	/* unconditionally disable WAKEEN interrupt */
-	sdw_intel_shim_wake(sdw, false);
-
-	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
-
-	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
-		ret = sdw_intel_link_power_up(sdw);
-		if (ret) {
-			dev_err(dev, "%s: power_up failed after teardown: %d\n", __func__, ret);
-			return ret;
-		}
-
-		/*
-		 * make sure all Slaves are tagged as UNATTACHED and provide
-		 * reason for reinitialization
-		 */
-		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
-
-		ret = sdw_intel_start_bus(sdw);
-		if (ret < 0) {
-			dev_err(dev, "%s: cannot start bus after teardown: %d\n", __func__, ret);
-			sdw_intel_link_power_down(sdw);
-			return ret;
-		}
-
-
-	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
-		ret = sdw_intel_link_power_up(sdw);
-		if (ret) {
-			dev_err(dev, "%s: power_up failed after bus reset: %d\n", __func__, ret);
-			return ret;
-		}
-
-		ret = sdw_intel_start_bus_after_reset(sdw);
-		if (ret < 0) {
-			dev_err(dev, "%s: cannot start bus after reset: %d\n", __func__, ret);
-			sdw_intel_link_power_down(sdw);
-			return ret;
-		}
-	} else if (!clock_stop_quirks) {
-
-		sdw_intel_check_clock_stop(sdw);
-
-		ret = sdw_intel_link_power_up(sdw);
-		if (ret) {
-			dev_err(dev, "%s: power_up failed: %d\n", __func__, ret);
-			return ret;
-		}
-
-		ret = sdw_intel_start_bus_after_clock_stop(sdw);
-		if (ret < 0) {
-			dev_err(dev, "%s: cannot start bus after clock stop: %d\n", __func__, ret);
-			sdw_intel_link_power_down(sdw);
-			return ret;
-		}
-	} else {
-		dev_err(dev, "%s: clock_stop_quirks %x unsupported\n",
-			__func__, clock_stop_quirks);
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static const struct dev_pm_ops intel_pm = {
-	.prepare = intel_pm_prepare,
-	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
-	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
-};
-
-static const struct auxiliary_device_id intel_link_id_table[] = {
-	{ .name = "soundwire_intel.link" },
-	{},
-};
-MODULE_DEVICE_TABLE(auxiliary, intel_link_id_table);
-
-static struct auxiliary_driver sdw_intel_drv = {
-	.probe = intel_link_probe,
-	.remove = intel_link_remove,
-	.driver = {
-		/* auxiliary_driver_register() sets .name to be the modname */
-		.pm = &intel_pm,
-	},
-	.id_table = intel_link_id_table
-};
-module_auxiliary_driver(sdw_intel_drv);
-
-MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION("Intel Soundwire Link Driver");
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 9ac3397757a0..de9883313c8f 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -50,16 +50,9 @@ struct sdw_intel {
 #endif
 };
 
-int intel_link_startup(struct auxiliary_device *auxdev);
-int intel_link_process_wakeen_event(struct auxiliary_device *auxdev);
+#define cdns_to_intel(_cdns) container_of(_cdns, struct sdw_intel, cdns)
 
-struct sdw_intel_link_dev {
-	struct auxiliary_device auxdev;
-	struct sdw_intel_link_res link_res;
-};
-
-#define auxiliary_dev_to_sdw_intel_link_dev(auxiliary_dev) \
-	container_of(auxiliary_dev, struct sdw_intel_link_dev, auxdev)
+#define INTEL_MASTER_RESET_ITERATIONS	10
 
 #define SDW_INTEL_CHECK_OPS(sdw, cb)	((sdw) && (sdw)->link_res && (sdw)->link_res->hw_ops && \
 					 (sdw)->link_res->hw_ops->cb)
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
new file mode 100644
index 000000000000..96c6b2112feb
--- /dev/null
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -0,0 +1,678 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2015-22 Intel Corporation.
+
+/*
+ * Soundwire Intel Manager Driver
+ */
+
+#include <linux/acpi.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/auxiliary_bus.h>
+#include <sound/pcm_params.h>
+#include <linux/pm_runtime.h>
+#include <sound/soc.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_intel.h>
+#include "cadence_master.h"
+#include "bus.h"
+#include "intel.h"
+#include "intel_auxdevice.h"
+
+/* IDA min selected to avoid conflicts with HDaudio/iDISP SDI values */
+#define INTEL_DEV_NUM_IDA_MIN           4
+
+#define INTEL_MASTER_SUSPEND_DELAY_MS	3000
+
+/*
+ * debug/config flags for the Intel SoundWire Master.
+ *
+ * Since we may have multiple masters active, we can have up to 8
+ * flags reused in each byte, with master0 using the ls-byte, etc.
+ */
+
+#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME		BIT(0)
+#define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP		BIT(1)
+#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE	BIT(2)
+#define SDW_INTEL_MASTER_DISABLE_MULTI_LINK		BIT(3)
+
+static int md_flags;
+module_param_named(sdw_md_flags, md_flags, int, 0444);
+MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags (0x0 all off)");
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
+static int sdw_master_read_intel_prop(struct sdw_bus *bus)
+{
+	struct sdw_master_prop *prop = &bus->prop;
+	struct fwnode_handle *link;
+	char name[32];
+	u32 quirk_mask;
+
+	/* Find master handle */
+	snprintf(name, sizeof(name),
+		 "mipi-sdw-link-%d-subproperties", bus->link_id);
+
+	link = device_get_named_child_node(bus->dev, name);
+	if (!link) {
+		dev_err(bus->dev, "Master node %s not found\n", name);
+		return -EIO;
+	}
+
+	fwnode_property_read_u32(link,
+				 "intel-sdw-ip-clock",
+				 &prop->mclk_freq);
+
+	/* the values reported by BIOS are the 2x clock, not the bus clock */
+	prop->mclk_freq /= 2;
+
+	fwnode_property_read_u32(link,
+				 "intel-quirk-mask",
+				 &quirk_mask);
+
+	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
+		prop->hw_disabled = true;
+
+	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
+		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
+
+	return 0;
+}
+
+static int intel_prop_read(struct sdw_bus *bus)
+{
+	/* Initialize with default handler to read all DisCo properties */
+	sdw_master_read_prop(bus);
+
+	/* read Intel-specific properties */
+	sdw_master_read_intel_prop(bus);
+
+	return 0;
+}
+
+static struct sdw_master_ops sdw_intel_ops = {
+	.read_prop = intel_prop_read,
+	.override_adr = sdw_dmi_override_adr,
+	.xfer_msg = cdns_xfer_msg,
+	.xfer_msg_defer = cdns_xfer_msg_defer,
+	.reset_page_addr = cdns_reset_page_addr,
+	.set_bus_conf = cdns_bus_conf,
+	.pre_bank_switch = generic_pre_bank_switch,
+	.post_bank_switch = generic_post_bank_switch,
+	.read_ping_status = cdns_read_ping_status,
+};
+
+/*
+ * probe and init (aux_dev_id argument is required by function prototype but not used)
+ */
+static int intel_link_probe(struct auxiliary_device *auxdev,
+			    const struct auxiliary_device_id *aux_dev_id)
+
+{
+	struct device *dev = &auxdev->dev;
+	struct sdw_intel_link_dev *ldev = auxiliary_dev_to_sdw_intel_link_dev(auxdev);
+	struct sdw_intel *sdw;
+	struct sdw_cdns *cdns;
+	struct sdw_bus *bus;
+	int ret;
+
+	sdw = devm_kzalloc(dev, sizeof(*sdw), GFP_KERNEL);
+	if (!sdw)
+		return -ENOMEM;
+
+	cdns = &sdw->cdns;
+	bus = &cdns->bus;
+
+	sdw->instance = auxdev->id;
+	sdw->link_res = &ldev->link_res;
+	cdns->dev = dev;
+	cdns->registers = sdw->link_res->registers;
+	cdns->instance = sdw->instance;
+	cdns->msg_count = 0;
+
+	bus->link_id = auxdev->id;
+	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
+	bus->clk_stop_timeout = 1;
+
+	sdw_cdns_probe(cdns);
+
+	/* Set ops */
+	bus->ops = &sdw_intel_ops;
+
+	/* set driver data, accessed by snd_soc_dai_get_drvdata() */
+	auxiliary_set_drvdata(auxdev, cdns);
+
+	/* use generic bandwidth allocation algorithm */
+	sdw->cdns.bus.compute_params = sdw_compute_params;
+
+	/* avoid resuming from pm_runtime suspend if it's not required */
+	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
+
+	ret = sdw_bus_master_add(bus, dev, dev->fwnode);
+	if (ret) {
+		dev_err(dev, "sdw_bus_master_add fail: %d\n", ret);
+		return ret;
+	}
+
+	if (bus->prop.hw_disabled)
+		dev_info(dev,
+			 "SoundWire master %d is disabled, will be ignored\n",
+			 bus->link_id);
+	/*
+	 * Ignore BIOS err_threshold, it's a really bad idea when dealing
+	 * with multiple hardware synchronized links
+	 */
+	bus->prop.err_threshold = 0;
+
+	return 0;
+}
+
+int intel_link_startup(struct auxiliary_device *auxdev)
+{
+	struct device *dev = &auxdev->dev;
+	struct sdw_cdns *cdns = auxiliary_get_drvdata(auxdev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	int link_flags;
+	bool multi_link;
+	u32 clock_stop_quirks;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_info(dev,
+			 "SoundWire master %d is disabled, ignoring\n",
+			 sdw->instance);
+		return 0;
+	}
+
+	link_flags = md_flags >> (bus->link_id * 8);
+	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
+	if (!multi_link) {
+		dev_dbg(dev, "Multi-link is disabled\n");
+	} else {
+		/*
+		 * hardware-based synchronization is required regardless
+		 * of the number of segments used by a stream: SSP-based
+		 * synchronization is gated by gsync when the multi-master
+		 * mode is set.
+		 */
+		bus->hw_sync_min_links = 1;
+	}
+	bus->multi_link = multi_link;
+
+	/* Initialize shim, controller */
+	ret = sdw_intel_link_power_up(sdw);
+	if (ret)
+		goto err_init;
+
+	/* Register DAIs */
+	ret = sdw_intel_register_dai(sdw);
+	if (ret) {
+		dev_err(dev, "DAI registration failed: %d\n", ret);
+		goto err_power_up;
+	}
+
+	sdw_intel_debugfs_init(sdw);
+
+	/* start bus */
+	ret = sdw_intel_start_bus(sdw);
+	if (ret) {
+		dev_err(dev, "bus start failed: %d\n", ret);
+		goto err_power_up;
+	}
+
+	/* Enable runtime PM */
+	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME)) {
+		pm_runtime_set_autosuspend_delay(dev,
+						 INTEL_MASTER_SUSPEND_DELAY_MS);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_mark_last_busy(dev);
+
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+
+	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
+	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_NOT_ALLOWED) {
+		/*
+		 * To keep the clock running we need to prevent
+		 * pm_runtime suspend from happening by increasing the
+		 * reference count.
+		 * This quirk is specified by the parent PCI device in
+		 * case of specific latency requirements. It will have
+		 * no effect if pm_runtime is disabled by the user via
+		 * a module parameter for testing purposes.
+		 */
+		pm_runtime_get_noresume(dev);
+	}
+
+	/*
+	 * The runtime PM status of Slave devices is "Unsupported"
+	 * until they report as ATTACHED. If they don't, e.g. because
+	 * there are no Slave devices populated or if the power-on is
+	 * delayed or dependent on a power switch, the Master will
+	 * remain active and prevent its parent from suspending.
+	 *
+	 * Conditionally force the pm_runtime core to re-evaluate the
+	 * Master status in the absence of any Slave activity. A quirk
+	 * is provided to e.g. deal with Slaves that may be powered on
+	 * with a delay. A more complete solution would require the
+	 * definition of Master properties.
+	 */
+	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
+		pm_runtime_idle(dev);
+
+	sdw->startup_done = true;
+	return 0;
+
+err_power_up:
+	sdw_intel_link_power_down(sdw);
+err_init:
+	return ret;
+}
+
+static void intel_link_remove(struct auxiliary_device *auxdev)
+{
+	struct sdw_cdns *cdns = auxiliary_get_drvdata(auxdev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+
+	/*
+	 * Since pm_runtime is already disabled, we don't decrease
+	 * the refcount when the clock_stop_quirk is
+	 * SDW_INTEL_CLK_STOP_NOT_ALLOWED
+	 */
+	if (!bus->prop.hw_disabled) {
+		sdw_intel_debugfs_exit(sdw);
+		sdw_cdns_enable_interrupt(cdns, false);
+	}
+	sdw_bus_master_delete(bus);
+}
+
+int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
+{
+	struct device *dev = &auxdev->dev;
+	struct sdw_intel *sdw;
+	struct sdw_bus *bus;
+
+	sdw = auxiliary_get_drvdata(auxdev);
+	bus = &sdw->cdns.bus;
+
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	if (!sdw_intel_shim_check_wake(sdw))
+		return 0;
+
+	/* disable WAKEEN interrupt ASAP to prevent interrupt flood */
+	sdw_intel_shim_wake(sdw, false);
+
+	/*
+	 * resume the Master, which will generate a bus reset and result in
+	 * Slaves re-attaching and be re-enumerated. The SoundWire physical
+	 * device which generated the wake will trigger an interrupt, which
+	 * will in turn cause the corresponding Linux Slave device to be
+	 * resumed and the Slave codec driver to check the status.
+	 */
+	pm_request_resume(dev);
+
+	return 0;
+}
+
+/*
+ * PM calls
+ */
+
+static int intel_resume_child_device(struct device *dev, void *data)
+{
+	int ret;
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+
+	if (!slave->probed) {
+		dev_dbg(dev, "skipping device, no probed driver\n");
+		return 0;
+	}
+	if (!slave->dev_num_sticky) {
+		dev_dbg(dev, "skipping device, never detected on bus\n");
+		return 0;
+	}
+
+	ret = pm_request_resume(dev);
+	if (ret < 0)
+		dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int __maybe_unused intel_pm_prepare(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	u32 clock_stop_quirks;
+	int ret;
+
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
+
+	if (pm_runtime_suspended(dev) &&
+	    pm_runtime_suspended(dev->parent) &&
+	    ((clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) ||
+	     !clock_stop_quirks)) {
+		/*
+		 * if we've enabled clock stop, and the parent is suspended, the SHIM registers
+		 * are not accessible and the shim wake cannot be disabled.
+		 * The only solution is to resume the entire bus to full power
+		 */
+
+		/*
+		 * If any operation in this block fails, we keep going since we don't want
+		 * to prevent system suspend from happening and errors should be recoverable
+		 * on resume.
+		 */
+
+		/*
+		 * first resume the device for this link. This will also by construction
+		 * resume the PCI parent device.
+		 */
+		ret = pm_request_resume(dev);
+		if (ret < 0) {
+			dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
+			return 0;
+		}
+
+		/*
+		 * Continue resuming the entire bus (parent + child devices) to exit
+		 * the clock stop mode. If there are no devices connected on this link
+		 * this is a no-op.
+		 * The resume to full power could have been implemented with a .prepare
+		 * step in SoundWire codec drivers. This would however require a lot
+		 * of code to handle an Intel-specific corner case. It is simpler in
+		 * practice to add a loop at the link level.
+		 */
+		ret = device_for_each_child(bus->dev, NULL, intel_resume_child_device);
+
+		if (ret < 0)
+			dev_err(dev, "%s: intel_resume_child_device failed: %d\n", __func__, ret);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused intel_suspend(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	u32 clock_stop_quirks;
+	int ret;
+
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	if (pm_runtime_suspended(dev)) {
+		dev_dbg(dev, "pm_runtime status: suspended\n");
+
+		clock_stop_quirks = sdw->link_res->clock_stop_quirks;
+
+		if ((clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) ||
+		    !clock_stop_quirks) {
+
+			if (pm_runtime_suspended(dev->parent)) {
+				/*
+				 * paranoia check: this should not happen with the .prepare
+				 * resume to full power
+				 */
+				dev_err(dev, "%s: invalid config: parent is suspended\n", __func__);
+			} else {
+				sdw_intel_shim_wake(sdw, false);
+			}
+		}
+
+		return 0;
+	}
+
+	ret = sdw_intel_stop_bus(sdw, false);
+	if (ret < 0) {
+		dev_err(dev, "%s: cannot stop bus: %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused intel_suspend_runtime(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	u32 clock_stop_quirks;
+	int ret;
+
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
+
+	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
+		ret = sdw_intel_stop_bus(sdw, false);
+		if (ret < 0) {
+			dev_err(dev, "%s: cannot stop bus during teardown: %d\n",
+				__func__, ret);
+			return ret;
+		}
+	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET || !clock_stop_quirks) {
+		ret = sdw_intel_stop_bus(sdw, true);
+		if (ret < 0) {
+			dev_err(dev, "%s: cannot stop bus during clock_stop: %d\n",
+				__func__, ret);
+			return ret;
+		}
+	} else {
+		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
+			__func__, clock_stop_quirks);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int __maybe_unused intel_resume(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	int link_flags;
+	int ret;
+
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	link_flags = md_flags >> (bus->link_id * 8);
+
+	if (pm_runtime_suspended(dev)) {
+		dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
+
+		/* follow required sequence from runtime_pm.rst */
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_enable(dev);
+
+		link_flags = md_flags >> (bus->link_id * 8);
+
+		if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
+			pm_runtime_idle(dev);
+	}
+
+	ret = sdw_intel_link_power_up(sdw);
+	if (ret) {
+		dev_err(dev, "%s failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/*
+	 * make sure all Slaves are tagged as UNATTACHED and provide
+	 * reason for reinitialization
+	 */
+	sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+
+	ret = sdw_intel_start_bus(sdw);
+	if (ret < 0) {
+		dev_err(dev, "cannot start bus during resume\n");
+		sdw_intel_link_power_down(sdw);
+		return ret;
+	}
+
+	/*
+	 * after system resume, the pm_runtime suspend() may kick in
+	 * during the enumeration, before any children device force the
+	 * master device to remain active.  Using pm_runtime_get()
+	 * routines is not really possible, since it'd prevent the
+	 * master from suspending.
+	 * A reasonable compromise is to update the pm_runtime
+	 * counters and delay the pm_runtime suspend by several
+	 * seconds, by when all enumeration should be complete.
+	 */
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+}
+
+static int __maybe_unused intel_resume_runtime(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	u32 clock_stop_quirks;
+	int ret;
+
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	/* unconditionally disable WAKEEN interrupt */
+	sdw_intel_shim_wake(sdw, false);
+
+	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
+
+	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
+		ret = sdw_intel_link_power_up(sdw);
+		if (ret) {
+			dev_err(dev, "%s: power_up failed after teardown: %d\n", __func__, ret);
+			return ret;
+		}
+
+		/*
+		 * make sure all Slaves are tagged as UNATTACHED and provide
+		 * reason for reinitialization
+		 */
+		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+
+		ret = sdw_intel_start_bus(sdw);
+		if (ret < 0) {
+			dev_err(dev, "%s: cannot start bus after teardown: %d\n", __func__, ret);
+			sdw_intel_link_power_down(sdw);
+			return ret;
+		}
+
+	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
+		ret = sdw_intel_link_power_up(sdw);
+		if (ret) {
+			dev_err(dev, "%s: power_up failed after bus reset: %d\n", __func__, ret);
+			return ret;
+		}
+
+		ret = sdw_intel_start_bus_after_reset(sdw);
+		if (ret < 0) {
+			dev_err(dev, "%s: cannot start bus after reset: %d\n", __func__, ret);
+			sdw_intel_link_power_down(sdw);
+			return ret;
+		}
+	} else if (!clock_stop_quirks) {
+
+		sdw_intel_check_clock_stop(sdw);
+
+		ret = sdw_intel_link_power_up(sdw);
+		if (ret) {
+			dev_err(dev, "%s: power_up failed: %d\n", __func__, ret);
+			return ret;
+		}
+
+		ret = sdw_intel_start_bus_after_clock_stop(sdw);
+		if (ret < 0) {
+			dev_err(dev, "%s: cannot start bus after clock stop: %d\n", __func__, ret);
+			sdw_intel_link_power_down(sdw);
+			return ret;
+		}
+	} else {
+		dev_err(dev, "%s: clock_stop_quirks %x unsupported\n",
+			__func__, clock_stop_quirks);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops intel_pm = {
+	.prepare = intel_pm_prepare,
+	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
+	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
+};
+
+static const struct auxiliary_device_id intel_link_id_table[] = {
+	{ .name = "soundwire_intel.link" },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, intel_link_id_table);
+
+static struct auxiliary_driver sdw_intel_drv = {
+	.probe = intel_link_probe,
+	.remove = intel_link_remove,
+	.driver = {
+		/* auxiliary_driver_register() sets .name to be the modname */
+		.pm = &intel_pm,
+	},
+	.id_table = intel_link_id_table
+};
+module_auxiliary_driver(sdw_intel_drv);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("Intel Soundwire Link Driver");
diff --git a/drivers/soundwire/intel_auxdevice.h b/drivers/soundwire/intel_auxdevice.h
new file mode 100644
index 000000000000..a00ecde95563
--- /dev/null
+++ b/drivers/soundwire/intel_auxdevice.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* Copyright(c) 2015-2022 Intel Corporation. */
+
+#ifndef __SDW_INTEL_AUXDEVICE_H
+#define __SDW_INTEL_AUXDEVICE_H
+
+int intel_link_startup(struct auxiliary_device *auxdev);
+int intel_link_process_wakeen_event(struct auxiliary_device *auxdev);
+
+struct sdw_intel_link_dev {
+	struct auxiliary_device auxdev;
+	struct sdw_intel_link_res link_res;
+};
+
+#define auxiliary_dev_to_sdw_intel_link_dev(auxiliary_dev) \
+	container_of(auxiliary_dev, struct sdw_intel_link_dev, auxdev)
+
+#endif /* __SDW_INTEL_AUXDEVICE_H */
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 1e6d74b3e773..b3a8db7c3b77 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -17,6 +17,7 @@
 #include <linux/soundwire/sdw_intel.h>
 #include "cadence_master.h"
 #include "intel.h"
+#include "intel_auxdevice.h"
 
 static void intel_link_dev_release(struct device *dev)
 {
-- 
2.25.1

