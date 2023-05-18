Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F020B7077FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjERCUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjERCUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:20:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718A2139
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684376438; x=1715912438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hC2J1w9UVcDCukApVbW8vB9WSP4jIPusaB43jqHzChY=;
  b=AJB4T5uN14PWcqj0WvIB7OpjEgUDF/0yt2JCx3spssyrX2iW+oetL3Jx
   mihPA7H7CXbbX4bF8Rx4qrvmq6sDKPnEqsaC7sEMy4qpVCDj0RuDbMXzo
   fO6pP3kghw2qaUxcEeCfu+uZ2HwiFyOguvkJznMWiRD3oX/J8A1VUrRjF
   hCViObjJVywdkwbtMPRpuLI3O1WLIAwD/xTAPrseKiktI1OZHOR1E7CFH
   jPYb/2Kh/Zew9wztbgJWUeW/LEkjiDEX/e7yGPLSIgEGfij021dtISQnq
   S+H5ltn8WOQfpdWedssOIk9weZ3S6Q09P07zVjlnZ8tqsOVDiheYx1YH6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="336504781"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="336504781"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:20:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826195226"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="826195226"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:20:36 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 3/3] soundwire: cadence: revisit parity injection
Date:   Thu, 18 May 2023 10:41:19 +0800
Message-Id: <20230518024119.164160-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518024119.164160-1-yung-chuan.liao@linux.intel.com>
References: <20230518024119.164160-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We want to wait for the CONFIG_UPDATE bit to clear before doing
something else.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 58686ae50bbf..0efc1c3bee5f 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -456,9 +456,9 @@ static int cdns_parity_error_injection(void *data, u64 value)
 			CDNS_IP_MCP_CMDCTRL_INSERT_PARITY_ERR);
 
 	/* commit changes */
-	cdns_updatel(cdns, CDNS_MCP_CONFIG_UPDATE,
-		     CDNS_MCP_CONFIG_UPDATE_BIT,
-		     CDNS_MCP_CONFIG_UPDATE_BIT);
+	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE, CDNS_MCP_CONFIG_UPDATE_BIT);
+	if (ret < 0)
+		goto unlock;
 
 	/* do a broadcast dummy read to avoid bus clashes */
 	ret = sdw_bread_no_pm_unlocked(&cdns->bus, 0xf, SDW_SCP_DEVID_0);
@@ -470,16 +470,17 @@ static int cdns_parity_error_injection(void *data, u64 value)
 			0);
 
 	/* commit changes */
-	cdns_updatel(cdns, CDNS_MCP_CONFIG_UPDATE,
-		     CDNS_MCP_CONFIG_UPDATE_BIT,
-		     CDNS_MCP_CONFIG_UPDATE_BIT);
+	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE, CDNS_MCP_CONFIG_UPDATE_BIT);
+	if (ret < 0)
+		goto unlock;
 
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+unlock:
 	/* Continue bus operation with parity error injection disabled */
 	mutex_unlock(&bus->bus_lock);
 
-	/* Userspace changed the hardware state behind the kernel's back */
-	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
-
 	/*
 	 * allow Master device to enter pm_runtime suspend. This may
 	 * also result in Slave devices suspending.
-- 
2.25.1

