Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA75C6B87C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjCNBl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCNBll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696C872B10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758097; x=1710294097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wQHje0SaVUOSrY4QPSqRiDq9cs1tJEQsHuQNuafDUnw=;
  b=QFj3vGB08PApW2yDtjIDHO0XA/m30fOpX34woiaKYiwkCF/ngGSZhqHp
   FtXMl6EsmTcAvSvEZTNaZV9EApSTLWqHDOv2DELwJMVTpuUoDvFjVPyO4
   kcBC2nlinndIzhznnTecvbclAKmu8vmykXCwjmMrlm1ZhMoIblXCLqfEZ
   MqvNc4CF9C1W2cipMWEn+dUD/CVv2/0ni0fGXTwILTTfZ/mt+HComW3wX
   WYnCZXpePAN3zZk3xic5sPDTJbPJzvSzW5H00HBYaOCiWxYR/NTyyFIjL
   5ai65oJWoGjjK08uJrtjSn2w1LRyYXh3MLb2l3i32hTO0b5ks83eMAjAF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949315"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949315"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327575"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327575"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:34 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 15/16] soundwire: cadence: split access to IP_MCP_CMDCTRL fields
Date:   Tue, 14 Mar 2023 09:54:09 +0800
Message-Id: <20230314015410.487311-16-yung-chuan.liao@linux.intel.com>
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

The latest Cadence IP splits the MCP_CMDCTRL fields in two registers:
MCP_CMDCTRL and IP_MCP_CMDCTRL. Rename the relevant fields and change
the access methods used for those fields.

In practice we only use the Parity error insertion in IP_CMD_CTRL.

For existing solutions, this is an iso-functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4c82712944b9..5128923f051e 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -54,9 +54,9 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_IP_MCP_CONTROL_CMD_ACCEPT		BIT(1)
 #define CDNS_IP_MCP_CONTROL_BLOCK_WAKEUP	BIT(0)
 
-#define CDNS_MCP_CMDCTRL			0x8
+#define CDNS_IP_MCP_CMDCTRL			0x8 /* IP offset added at run-time */
 
-#define CDNS_MCP_CMDCTRL_INSERT_PARITY_ERR	BIT(2)
+#define CDNS_IP_MCP_CMDCTRL_INSERT_PARITY_ERR	BIT(2)
 
 #define CDNS_MCP_SSPSTAT			0xC
 #define CDNS_MCP_FRAME_SHAPE			0x10
@@ -428,9 +428,9 @@ static int cdns_parity_error_injection(void *data, u64 value)
 	mutex_lock(&bus->bus_lock);
 
 	/* program hardware to inject parity error */
-	cdns_updatel(cdns, CDNS_MCP_CMDCTRL,
-		     CDNS_MCP_CMDCTRL_INSERT_PARITY_ERR,
-		     CDNS_MCP_CMDCTRL_INSERT_PARITY_ERR);
+	cdns_ip_updatel(cdns, CDNS_IP_MCP_CMDCTRL,
+			CDNS_IP_MCP_CMDCTRL_INSERT_PARITY_ERR,
+			CDNS_IP_MCP_CMDCTRL_INSERT_PARITY_ERR);
 
 	/* commit changes */
 	cdns_updatel(cdns, CDNS_MCP_CONFIG_UPDATE,
@@ -442,9 +442,9 @@ static int cdns_parity_error_injection(void *data, u64 value)
 	dev_info(cdns->dev, "parity error injection, read: %d\n", ret);
 
 	/* program hardware to disable parity error */
-	cdns_updatel(cdns, CDNS_MCP_CMDCTRL,
-		     CDNS_MCP_CMDCTRL_INSERT_PARITY_ERR,
-		     0);
+	cdns_ip_updatel(cdns, CDNS_IP_MCP_CMDCTRL,
+			CDNS_IP_MCP_CMDCTRL_INSERT_PARITY_ERR,
+			0);
 
 	/* commit changes */
 	cdns_updatel(cdns, CDNS_MCP_CONFIG_UPDATE,
-- 
2.25.1

