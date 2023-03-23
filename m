Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB1D6C5ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCWFbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCWFas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:30:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70F1F5F6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549433; x=1711085433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+/puymD/Mrlt+6NzEm6hJ2HiO/2wdXeQEMmwt5RGD7o=;
  b=eHHtpKfT84MXE09OpuNB3HOIxy7VtUM+rv/RU/GzXkH9GgdFtka+JWBb
   j5saCuQ5Hgt+MugjY9tovrmkzzrFIdai/l+6xGse9+dvYgH/IdCJ9kc+y
   izknRQIwC//+HqssWidyH9mgNEHBeITVA+HV7xyShDe4Ery3MCagGPdqu
   6cYNa0FKktt8xPjQ80/OTTehAxPiDTfd/SzQ9aifgabr6tnmB+poB1se7
   4M3Yo1GJ4Le0Lwtgg/9kbfrvjI5V2lEZNhiblMj2owJ+ZuM8m8BPMzIxH
   PZm0TzkJ+btYobsw27KTa89E7rnEPNNcLjshYW1+q364X3PWq/LNRprJ7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779320"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779320"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567014"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567014"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:00 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 05/20] soundwire: intel/cadence: set ip_offset at run-time
Date:   Thu, 23 Mar 2023 13:44:37 +0800
Message-Id: <20230323054452.1543233-6-yung-chuan.liao@linux.intel.com>
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
index b653734085d9..b0f0bf90640b 100644
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
index 5021be0f4158..b02cef4f4b66 100644
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

