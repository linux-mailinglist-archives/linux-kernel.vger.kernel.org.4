Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272DD731BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbjFOOwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjFOOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:52:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A032110D8;
        Thu, 15 Jun 2023 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686840759; x=1718376759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kCi7DHYNcv6IoROHXZh3QF9cEVVIQC3uWI9Yr69isrA=;
  b=QTHbk0y2cSFWbnqYp1F7tuLYIdXSusxk1TSP/EQkg4ppbOohxP/xhjci
   ZvVvqWYxj8trUL6/e0ZQ9oKsuk8QkOYuHr67fJSkH1Db+a9Ic8Otj8LJF
   K1pULPKjwwOCwly1SQL+lZe79Efxv2G3i7A7gCySsL+aE/i+Z2C/TLVji
   ETSP6QDhLpO1kCj+fgPX1yPoIJF3wgugUxAWq0BxHU6kjY+AZBy9QJx3l
   OxrA1slJehXucNXI6bibE3e4iP5UO9zLyfVh4QKojKlmEW0+XBLZvkY3A
   Jo/lEnDUV09MEZDlQF9L9GqQ+g9+UmbKdS5hYfTtYsZbSDFy6GhpxPTTb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338559714"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="338559714"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 07:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="662823914"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="662823914"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2023 07:52:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1AB8B379; Thu, 15 Jun 2023 17:52:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] of/platform: Propagate firmware node by calling device_set_node()
Date:   Thu, 15 Jun 2023 17:52:43 +0300
Message-Id: <20230615145243.37095-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Insulate of_device_alloc() and of_amba_device_create() from possible
changes to fwnode_handle implementation by using device_set_node()
instead of open-coding dev->dev.fwnode assignments.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/of/platform.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 78ae84187449..051e29b7ad2b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -140,8 +140,8 @@ struct platform_device *of_device_alloc(struct device_node *np,
 		}
 	}
 
-	dev->dev.of_node = of_node_get(np);
-	dev->dev.fwnode = &np->fwnode;
+	/* setup generic device info */
+	device_set_node(&dev->dev, of_fwnode_handle(np));
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
@@ -239,8 +239,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
 
 	/* setup generic device info */
-	dev->dev.of_node = of_node_get(node);
-	dev->dev.fwnode = &node->fwnode;
+	device_set_node(&dev->dev, of_fwnode_handle(node));
 	dev->dev.parent = parent ? : &platform_bus;
 	dev->dev.platform_data = platform_data;
 	if (bus_id)
-- 
2.40.0.1.gaa8946217a0b

