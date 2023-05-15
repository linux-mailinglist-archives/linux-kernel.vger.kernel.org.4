Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB67702552
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbjEOGus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbjEOGul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:50:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257C7173F
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133434; x=1715669434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jzpdfZmzNrU6pw0ISN0oU8vFcN6tRPXs+SPemPddfJg=;
  b=VEak6Fosbpog38/D+V1nBYZantSpZ5Qwqi0jt2etvleSDHJNby4e3UBs
   wYwhFwhFe+UQv3GFcLSQYNYU1m4KXKP12jKiTdi0QDL9M5cxl7NBUTdi1
   ccI/l4Z5tPPqBVTBA0NbXH2paphEL3NXLXxWAZItEQlLpeolQYDp8OxC+
   8HNqFNbphcGhWoovsBbbIJDawbvqATH4stiHiTaSReTLkBipLZsJyJy5G
   JFbRGt3BDhMTBwf5oi7TgC8tmyaTI3fIaKCveycUWVF91hj78i1tEtpro
   2NJOrTgHM1cnECRYUUhGhqBfeM08Zb9nF0bn+G7BcNDWWNTgaM0+XY3bx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966308"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966308"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908629"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908629"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:31 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 05/26] soundwire: intel/cadence: set ip_offset at run-time
Date:   Mon, 15 May 2023 15:10:21 +0800
Message-Id: <20230515071042.2038-6-yung-chuan.liao@linux.intel.com>
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

Select relevant ip-offset depending on hardware version. This offset
is used to access MCP_ or IP_MCP_ registers with a fixed offset.

For existing platforms, the offset is exactly zero. Starting with
LunarLake, the offset is 0x4000.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.h  | 2 ++
 drivers/soundwire/intel.h           | 2 ++
 drivers/soundwire/intel_auxdevice.c | 1 +
 drivers/soundwire/intel_init.c      | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 27c56274217f..86a450b1cbda 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -14,6 +14,8 @@
  */
 #define CDNS_MCP_IP_MAX_CMD_LEN		32
 
+#define SDW_CADENCE_MCP_IP_OFFSET	0x4000
+
 /**
  * struct sdw_cdns_pdi: PDI (Physical Data Interface) instance
  *
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 51aa42a5a824..1b23292bb8be 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -10,6 +10,7 @@
  * @hw_ops: platform-specific ops
  * @mmio_base: mmio base of SoundWire registers
  * @registers: Link IO registers base
+ * @ip_offset: offset for MCP_IP registers
  * @shim: Audio shim pointer
  * @shim_vs: Audio vendor-specific shim pointer
  * @alh: ALH (Audio Link Hub) pointer
@@ -28,6 +29,7 @@ struct sdw_intel_link_res {
 
 	void __iomem *mmio_base; /* not strictly needed, useful for debug */
 	void __iomem *registers;
+	u32 ip_offset;
 	void __iomem *shim;
 	void __iomem *shim_vs;
 	void __iomem *alh;
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index b21e86084f7b..fcdf4f2d60e3 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -144,6 +144,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	sdw->link_res = &ldev->link_res;
 	cdns->dev = dev;
 	cdns->registers = sdw->link_res->registers;
+	cdns->ip_offset = sdw->link_res->ip_offset;
 	cdns->instance = sdw->instance;
 	cdns->msg_count = 0;
 
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index e0023af9e0e1..43d339c6bcee 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -66,10 +66,12 @@ static struct sdw_intel_link_dev *intel_link_dev_register(struct sdw_intel_res *
 	if (!res->ext) {
 		link->registers = res->mmio_base + SDW_LINK_BASE
 			+ (SDW_LINK_SIZE * link_id);
+		link->ip_offset = 0;
 		link->shim = res->mmio_base + res->shim_base;
 		link->alh = res->mmio_base + res->alh_base;
 	} else {
 		link->registers = res->mmio_base + SDW_IP_BASE(link_id);
+		link->ip_offset = SDW_CADENCE_MCP_IP_OFFSET;
 		link->shim = res->mmio_base +  SDW_SHIM2_GENERIC_BASE(link_id);
 		link->shim_vs = res->mmio_base + SDW_SHIM2_VS_BASE(link_id);
 	}
-- 
2.25.1

