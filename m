Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6663E6B87BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCNBlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjCNBlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9651D74329
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758092; x=1710294092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sfcPRhRXNlasOblxff/iVuz7QEMX0M7uX02RWVIo8Q4=;
  b=NoWaqASGTFEwpH0w5jlls4CB61ZwRznfwGsmK94A7qGKK8atNizruwzN
   b3FmTAncOgod5rryt1w83JMJCJPOBxrNihmYU/XPiclp1SQ/PD/8dYbdu
   bx+2gDtnPUA6Xu2PWeJRgYlO+mMzI3b/F1M2cl0kTi3yzstnJ0OAF30At
   lpQxSPrXOQkQu0d13poHZtdwYC/8NRI2YQhJbA7C0lC/2u6jH02kuJlb3
   GHYAWu/IFyAIBnM+UZsx1lAfv/fhoUiKPgfms7uBWLscV4j6JW3od2TMT
   yxra5v1kmk5spIuwomLHk8L9Xlu2SwQoqGn3RJ7Nx0oz8QJ9MhRB/Sdv1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949302"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949302"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327538"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327538"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:30 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 13/16] soundwire: cadence: split access to IP_MCP_CONFIG fields
Date:   Tue, 14 Mar 2023 09:54:07 +0800
Message-Id: <20230314015410.487311-14-yung-chuan.liao@linux.intel.com>
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

The latest Cadence IP splits the MCP_CONFIG fields in two registers:
MCP_CONFIG and IP_MCP_CONFIG. Rename the relevant fields and change
the access methods used for those fields.

For existing solutions, this is an iso-functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 47 +++++++++++++++++-------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4461a7fa4124..f7499e126404 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -27,15 +27,17 @@ module_param_named(cnds_mcp_int_mask, interrupt_mask, int, 0444);
 MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 
 #define CDNS_MCP_CONFIG				0x0
-
-#define CDNS_MCP_CONFIG_MCMD_RETRY		GENMASK(27, 24)
-#define CDNS_MCP_CONFIG_MPREQ_DELAY		GENMASK(20, 16)
-#define CDNS_MCP_CONFIG_MMASTER			BIT(7)
 #define CDNS_MCP_CONFIG_BUS_REL			BIT(6)
-#define CDNS_MCP_CONFIG_SNIFFER			BIT(5)
-#define CDNS_MCP_CONFIG_CMD			BIT(3)
-#define CDNS_MCP_CONFIG_OP			GENMASK(2, 0)
-#define CDNS_MCP_CONFIG_OP_NORMAL		0
+
+#define CDNS_IP_MCP_CONFIG			0x0 /* IP offset added at run-time */
+
+#define CDNS_IP_MCP_CONFIG_MCMD_RETRY		GENMASK(27, 24)
+#define CDNS_IP_MCP_CONFIG_MPREQ_DELAY		GENMASK(20, 16)
+#define CDNS_IP_MCP_CONFIG_MMASTER		BIT(7)
+#define CDNS_IP_MCP_CONFIG_SNIFFER		BIT(5)
+#define CDNS_IP_MCP_CONFIG_CMD			BIT(3)
+#define CDNS_IP_MCP_CONFIG_OP			GENMASK(2, 0)
+#define CDNS_IP_MCP_CONFIG_OP_NORMAL		0
 
 #define CDNS_MCP_CONTROL			0x4
 
@@ -1348,28 +1350,33 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	/* Configure mcp config */
 	val = cdns_readl(cdns, CDNS_MCP_CONFIG);
 
+	/* Disable auto bus release */
+	val &= ~CDNS_MCP_CONFIG_BUS_REL;
+
+	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
+
+	/* Configure IP mcp config */
+	val = cdns_ip_readl(cdns, CDNS_IP_MCP_CONFIG);
+
 	/* enable bus operations with clock and data */
-	val &= ~CDNS_MCP_CONFIG_OP;
-	val |= CDNS_MCP_CONFIG_OP_NORMAL;
+	val &= ~CDNS_IP_MCP_CONFIG_OP;
+	val |= CDNS_IP_MCP_CONFIG_OP_NORMAL;
 
 	/* Set cmd mode for Tx and Rx cmds */
-	val &= ~CDNS_MCP_CONFIG_CMD;
+	val &= ~CDNS_IP_MCP_CONFIG_CMD;
 
 	/* Disable sniffer mode */
-	val &= ~CDNS_MCP_CONFIG_SNIFFER;
-
-	/* Disable auto bus release */
-	val &= ~CDNS_MCP_CONFIG_BUS_REL;
+	val &= ~CDNS_IP_MCP_CONFIG_SNIFFER;
 
 	if (cdns->bus.multi_link)
 		/* Set Multi-master mode to take gsync into account */
-		val |= CDNS_MCP_CONFIG_MMASTER;
+		val |= CDNS_IP_MCP_CONFIG_MMASTER;
 
 	/* leave frame delay to hardware default of 0x1F */
 
 	/* leave command retry to hardware default of 0 */
 
-	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
+	cdns_ip_writel(cdns, CDNS_IP_MCP_CONFIG, val);
 
 	/* changes will be committed later */
 	return 0;
@@ -1683,9 +1690,9 @@ int sdw_cdns_clock_restart(struct sdw_cdns *cdns, bool bus_reset)
 	if (!bus_reset) {
 
 		/* enable bus operations with clock and data */
-		cdns_updatel(cdns, CDNS_MCP_CONFIG,
-			     CDNS_MCP_CONFIG_OP,
-			     CDNS_MCP_CONFIG_OP_NORMAL);
+		cdns_ip_updatel(cdns, CDNS_IP_MCP_CONFIG,
+				CDNS_IP_MCP_CONFIG_OP,
+				CDNS_IP_MCP_CONFIG_OP_NORMAL);
 
 		ret = cdns_config_update(cdns);
 		if (ret < 0) {
-- 
2.25.1

