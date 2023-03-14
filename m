Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21E36B87B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjCNBmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCNBln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FA478C8C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758098; x=1710294098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hzzq3OtEkkrFejYuV+z4cdtj/Bawg/u7wQf4bCyiLzc=;
  b=PqG01Xx5UsS22Ou+ccm5zel+vedWJi+N8A+VAT4nUAcqyXjU07KiXLYr
   cAT0iqX8i0fwl+f4+Id5hoP+VrZVlt8bq3ki7rjGP6OHfYDCleTBYAN5W
   pKm+CFXhYSKEs+WWsNoMc1fuB2f5RUHwNUifcAmwG9yZFHDOFNdJKuXyV
   7DiOO+SC5c4EJslBtAcchMUjR8LpOVF9Zf6wQy4dbkxRwtaHKLAbiUGxk
   lMnrphczwsVZ774DeNEc//O2TG+eTnM0PZHQB0L7ootV3Nl7I+uh69ETf
   ABG1Q0zUg3F44f9jgD9NxZG5dBNwIGAtwFTPmULdVHsemhcrwbde6JZMY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949324"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949324"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327601"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327601"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:36 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 16/16] soundwire: cadence: change access to IP_MCP_CMD_BASE
Date:   Tue, 14 Mar 2023 09:54:10 +0800
Message-Id: <20230314015410.487311-17-yung-chuan.liao@linux.intel.com>
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

The latest Cadence IP moves MCP_CMD_BASE and MCP_CMD_RESP to the
IP_MCP_CMD_BASE and IP_MCP_CMD_RESP registers located in different
area and accessed with a fixed offset.

Unlike other patches, the fields are not renamed to avoid a very
invasive and low-value set of changes.

For existing solutions, this is an iso-functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 5128923f051e..39502bc75712 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -129,8 +129,8 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_MCP_FIFOSTAT			0x7C
 #define CDNS_MCP_RX_FIFO_AVAIL			GENMASK(5, 0)
 
-#define CDNS_MCP_CMD_BASE			0x80
-#define CDNS_MCP_RESP_BASE			0x80
+#define CDNS_IP_MCP_CMD_BASE			0x80 /* IP offset added at run-time */
+#define CDNS_IP_MCP_RESP_BASE			0x80 /* IP offset added at run-time */
 /* FIFO can hold 8 commands */
 #define CDNS_MCP_CMD_LEN			8
 #define CDNS_MCP_CMD_WORD_LEN			0x4
@@ -590,10 +590,10 @@ static void cdns_read_response(struct sdw_cdns *cdns)
 		num_resp = ARRAY_SIZE(cdns->response_buf);
 	}
 
-	cmd_base = CDNS_MCP_CMD_BASE;
+	cmd_base = CDNS_IP_MCP_CMD_BASE;
 
 	for (i = 0; i < num_resp; i++) {
-		cdns->response_buf[i] = cdns_readl(cdns, cmd_base);
+		cdns->response_buf[i] = cdns_ip_readl(cdns, cmd_base);
 		cmd_base += CDNS_MCP_CMD_WORD_LEN;
 	}
 }
@@ -612,7 +612,7 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 		cdns->msg_count = count;
 	}
 
-	base = CDNS_MCP_CMD_BASE;
+	base = CDNS_IP_MCP_CMD_BASE;
 	addr = msg->addr + offset;
 
 	for (i = 0; i < count; i++) {
@@ -625,7 +625,7 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 			data |= msg->buf[i + offset];
 
 		data |= FIELD_PREP(CDNS_MCP_CMD_SSP_TAG, msg->ssp_sync);
-		cdns_writel(cdns, base, data);
+		cdns_ip_writel(cdns, base, data);
 		base += CDNS_MCP_CMD_WORD_LEN;
 	}
 
@@ -673,10 +673,10 @@ cdns_program_scp_addr(struct sdw_cdns *cdns, struct sdw_msg *msg)
 	data[0] |= msg->addr_page1;
 	data[1] |= msg->addr_page2;
 
-	base = CDNS_MCP_CMD_BASE;
-	cdns_writel(cdns, base, data[0]);
+	base = CDNS_IP_MCP_CMD_BASE;
+	cdns_ip_writel(cdns, base, data[0]);
 	base += CDNS_MCP_CMD_WORD_LEN;
-	cdns_writel(cdns, base, data[1]);
+	cdns_ip_writel(cdns, base, data[1]);
 
 	time = wait_for_completion_timeout(&cdns->tx_complete,
 					   msecs_to_jiffies(CDNS_TX_TIMEOUT));
-- 
2.25.1

