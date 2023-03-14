Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AFA6B87B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjCNBly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCNBlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790067C3D3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758095; x=1710294095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BsMbslJQaFseT5Cv+EGJHhXHzftwhtvi7GC9ZvR/ymM=;
  b=m1bp2It4vTCpkr56OW22LIEhKVe/skzDlNNDsUKsphbvV5SsIsPK1+sL
   oMIMm/DmTALdgF7mTTjJdv7mupx+0lpEZr5sGsPNFk/121LUjgqnP7V0N
   9JhDjtnNfeyXG32AR3SlLW7XzV/3uiEs7O9JY63qupqvpM+g/znKvg/XA
   h0SsSkoAJEcng/BSALWEGv+j6C4I5tFTgjbHOXnZVT0Bc4DbU8e9mWXrO
   5o3qkfaiOJ4fApW3EUfIst7KnUmfcVJP53XCJv6mRXHKTVfTTqlYp77a4
   Of+EyMqvWH2E0t1zipUFoc6aaA7ccTGchueZHXWBuGf0QtB94gpkp0mpb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949310"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949310"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327558"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327558"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:32 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 14/16] soundwire: cadence: split access to IP_MCP_CONTROL fields
Date:   Tue, 14 Mar 2023 09:54:08 +0800
Message-Id: <20230314015410.487311-15-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The latest Cadence IP splits the MCP_CONTROL fields in two registers:
MCP_CONTROL and IP_MCP_CONTROL. Rename the relevant fields and change
the access methods used for those fields.

For existing solutions, this is an iso-functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 41 ++++++++++++++++++------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index f7499e126404..4c82712944b9 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -41,15 +41,18 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 
 #define CDNS_MCP_CONTROL			0x4
 
-#define CDNS_MCP_CONTROL_RST_DELAY		GENMASK(10, 8)
 #define CDNS_MCP_CONTROL_CMD_RST		BIT(7)
 #define CDNS_MCP_CONTROL_SOFT_RST		BIT(6)
-#define CDNS_MCP_CONTROL_SW_RST			BIT(5)
 #define CDNS_MCP_CONTROL_HW_RST			BIT(4)
-#define CDNS_MCP_CONTROL_CLK_PAUSE		BIT(3)
 #define CDNS_MCP_CONTROL_CLK_STOP_CLR		BIT(2)
-#define CDNS_MCP_CONTROL_CMD_ACCEPT		BIT(1)
-#define CDNS_MCP_CONTROL_BLOCK_WAKEUP		BIT(0)
+
+#define CDNS_IP_MCP_CONTROL			0x4  /* IP offset added at run-time */
+
+#define CDNS_IP_MCP_CONTROL_RST_DELAY		GENMASK(10, 8)
+#define CDNS_IP_MCP_CONTROL_SW_RST		BIT(5)
+#define CDNS_IP_MCP_CONTROL_CLK_PAUSE		BIT(3)
+#define CDNS_IP_MCP_CONTROL_CMD_ACCEPT		BIT(1)
+#define CDNS_IP_MCP_CONTROL_BLOCK_WAKEUP	BIT(0)
 
 #define CDNS_MCP_CMDCTRL			0x8
 
@@ -1050,6 +1053,7 @@ static void cdns_update_slave_status_work(struct work_struct *work)
 void sdw_cdns_check_self_clearing_bits(struct sdw_cdns *cdns, const char *string,
 				       bool initial_delay, int reset_iterations)
 {
+	u32 ip_mcp_control;
 	u32 mcp_control;
 	u32 mcp_config_update;
 	int i;
@@ -1057,6 +1061,12 @@ void sdw_cdns_check_self_clearing_bits(struct sdw_cdns *cdns, const char *string
 	if (initial_delay)
 		usleep_range(1000, 1500);
 
+	ip_mcp_control = cdns_ip_readl(cdns, CDNS_IP_MCP_CONTROL);
+
+	/* the following bits should be cleared immediately */
+	if (ip_mcp_control & CDNS_IP_MCP_CONTROL_SW_RST)
+		dev_err(cdns->dev, "%s failed: IP_MCP_CONTROL_SW_RST is not cleared\n", string);
+
 	mcp_control = cdns_readl(cdns, CDNS_MCP_CONTROL);
 
 	/* the following bits should be cleared immediately */
@@ -1064,10 +1074,9 @@ void sdw_cdns_check_self_clearing_bits(struct sdw_cdns *cdns, const char *string
 		dev_err(cdns->dev, "%s failed: MCP_CONTROL_CMD_RST is not cleared\n", string);
 	if (mcp_control & CDNS_MCP_CONTROL_SOFT_RST)
 		dev_err(cdns->dev, "%s failed: MCP_CONTROL_SOFT_RST is not cleared\n", string);
-	if (mcp_control & CDNS_MCP_CONTROL_SW_RST)
-		dev_err(cdns->dev, "%s failed: MCP_CONTROL_SW_RST is not cleared\n", string);
 	if (mcp_control & CDNS_MCP_CONTROL_CLK_STOP_CLR)
 		dev_err(cdns->dev, "%s failed: MCP_CONTROL_CLK_STOP_CLR is not cleared\n", string);
+
 	mcp_config_update = cdns_readl(cdns, CDNS_MCP_CONFIG_UPDATE);
 	if (mcp_config_update & CDNS_MCP_CONFIG_UPDATE_BIT)
 		dev_err(cdns->dev, "%s failed: MCP_CONFIG_UPDATE_BIT is not cleared\n", string);
@@ -1344,8 +1353,8 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 		     CDNS_MCP_CONTROL_CMD_RST);
 
 	/* Set cmd accept mode */
-	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT,
-		     CDNS_MCP_CONTROL_CMD_ACCEPT);
+	cdns_ip_updatel(cdns, CDNS_IP_MCP_CONTROL, CDNS_IP_MCP_CONTROL_CMD_ACCEPT,
+			CDNS_IP_MCP_CONTROL_CMD_ACCEPT);
 
 	/* Configure mcp config */
 	val = cdns_readl(cdns, CDNS_MCP_CONFIG);
@@ -1606,9 +1615,9 @@ int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
 	 * in clock stop state
 	 */
 	if (block_wake)
-		cdns_updatel(cdns, CDNS_MCP_CONTROL,
-			     CDNS_MCP_CONTROL_BLOCK_WAKEUP,
-			     CDNS_MCP_CONTROL_BLOCK_WAKEUP);
+		cdns_ip_updatel(cdns, CDNS_IP_MCP_CONTROL,
+				CDNS_IP_MCP_CONTROL_BLOCK_WAKEUP,
+				CDNS_IP_MCP_CONTROL_BLOCK_WAKEUP);
 
 	list_for_each_entry(slave, &cdns->bus.slaves, node) {
 		if (slave->status == SDW_SLAVE_ATTACHED ||
@@ -1681,11 +1690,11 @@ int sdw_cdns_clock_restart(struct sdw_cdns *cdns, bool bus_reset)
 		return ret;
 	}
 
-	cdns_updatel(cdns, CDNS_MCP_CONTROL,
-		     CDNS_MCP_CONTROL_BLOCK_WAKEUP, 0);
+	cdns_ip_updatel(cdns, CDNS_IP_MCP_CONTROL,
+			CDNS_IP_MCP_CONTROL_BLOCK_WAKEUP, 0);
 
-	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT,
-		     CDNS_MCP_CONTROL_CMD_ACCEPT);
+	cdns_ip_updatel(cdns, CDNS_IP_MCP_CONTROL, CDNS_IP_MCP_CONTROL_CMD_ACCEPT,
+			CDNS_IP_MCP_CONTROL_CMD_ACCEPT);
 
 	if (!bus_reset) {
 
-- 
2.25.1

