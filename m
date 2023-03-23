Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE46C5EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCWFdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjCWFcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C848632E69
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549501; x=1711085501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3GyCN8p+cJBxO9BTibcqpeTRWzFQliw1LPEGnZdocY=;
  b=VMZ3Wyb/VSSzKrOPiOwT7pc5BwcZQuDv0PoaGz9TZsUpT59uXeQd1sbv
   +7O/tB9b03s6Ss62knNnx4jGubyLTMoUC0WSLFoJvoNpMYWAdN4PPjlgY
   BMN+rAvA44Bqj3K788wDANuL0qKElPpSf+Ezcf8IikZfEb+h3aKEOhI82
   3qisOA14Y/SLxfrl8rIv8ZnRndMeDFZa3j3k7M98I2BFG5Fhe0Cl3Od+8
   ODznk2zSdkrpS5wkgN8RCas8Khhln0ZC3kE+UzjPUlWoJcxWT48GmNY84
   0QXcsUCs1go7QadRFT04IeFFbYS2fPdFmj3BsnzCjwomXfMf8s9LgTiXQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779513"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779513"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567305"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567305"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:39 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 20/20] soundwire: intel_ace2x: add new_peripheral_assigned callback
Date:   Thu, 23 Mar 2023 13:44:52 +0800
Message-Id: <20230323054452.1543233-21-yung-chuan.liao@linux.intel.com>
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

Add the abstraction needed to only program the LSDIID registers for
the HDaudio extended links. It's perfectly fine to program this
register multiple times in case devices lose sync and reattach.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c     | 12 ++++++++++++
 drivers/soundwire/intel_auxdevice.c | 16 ++++++++++++++++
 include/linux/soundwire/sdw_intel.h |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index a12fee8a5bfa..65deb4345354 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -350,6 +350,16 @@ static int intel_register_dai(struct sdw_intel *sdw)
 					       dais, num_dai);
 }
 
+static void intel_program_sdi(struct sdw_intel *sdw, int dev_num)
+{
+	int ret;
+
+	ret = hdac_bus_eml_sdw_set_lsdiid(sdw->link_res->hbus, sdw->instance, dev_num);
+	if (ret < 0)
+		dev_err(sdw->cdns.dev, "%s: could not set lsdiid for link %d %d\n",
+			__func__, sdw->instance, dev_num);
+}
+
 const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 	.debugfs_init = intel_ace2x_debugfs_init,
 	.debugfs_exit = intel_ace2x_debugfs_exit,
@@ -372,6 +382,8 @@ const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 	.sync_go_unlocked = intel_sync_go_unlocked,
 	.sync_go = intel_sync_go,
 	.sync_check_cmdsync_unlocked = intel_check_cmdsync_unlocked,
+
+	.program_sdi = intel_program_sdi,
 };
 EXPORT_SYMBOL_NS(sdw_intel_lnl_hw_ops, SOUNDWIRE_INTEL);
 
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index b02cef4f4b66..6e02782ef211 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -60,6 +60,21 @@ static int generic_post_bank_switch(struct sdw_bus *bus)
 	return sdw->link_res->hw_ops->post_bank_switch(sdw);
 }
 
+static void generic_new_peripheral_assigned(struct sdw_bus *bus, int dev_num)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+
+	/* paranoia check, this should never happen */
+	if (dev_num < INTEL_DEV_NUM_IDA_MIN || dev_num > SDW_MAX_DEVICES)  {
+		dev_err(bus->dev, "%s: invalid dev_num %d\n", __func__, dev_num);
+		return;
+	}
+
+	if (sdw->link_res->hw_ops->program_sdi)
+		sdw->link_res->hw_ops->program_sdi(sdw, dev_num);
+}
+
 static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 {
 	struct sdw_master_prop *prop = &bus->prop;
@@ -117,6 +132,7 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.pre_bank_switch = generic_pre_bank_switch,
 	.post_bank_switch = generic_post_bank_switch,
 	.read_ping_status = cdns_read_ping_status,
+	.new_peripheral_assigned = generic_new_peripheral_assigned,
 };
 
 /*
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index bafc6f2554b0..1a8f32059cd8 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -399,6 +399,7 @@ struct sdw_intel;
  * @sync_go: helper for multi-link synchronization
  * @sync_check_cmdsync_unlocked: helper for multi-link synchronization
  * and bank switch - shim_lock is assumed to be locked at higher level
+ * @program_sdi: helper for codec command/control based on dev_num
  */
 struct sdw_intel_hw_ops {
 	void (*debugfs_init)(struct sdw_intel *sdw);
@@ -425,6 +426,8 @@ struct sdw_intel_hw_ops {
 	int (*sync_go_unlocked)(struct sdw_intel *sdw);
 	int (*sync_go)(struct sdw_intel *sdw);
 	bool (*sync_check_cmdsync_unlocked)(struct sdw_intel *sdw);
+
+	void (*program_sdi)(struct sdw_intel *sdw, int dev_num);
 };
 
 extern const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops;
-- 
2.25.1

