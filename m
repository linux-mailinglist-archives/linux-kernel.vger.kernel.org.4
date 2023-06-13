Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9972DCE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbjFMInm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241744AbjFMIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:43:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9955119B9;
        Tue, 13 Jun 2023 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686645803; x=1718181803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W3O3uxSGMpbuvvD324rsE5Fik1eSAul12QMjjMLOUEE=;
  b=mF1o9tLWLtxOgQdh0X4P81FjlIq4LzkOq4qE3yHJtbUtkJ7eYo/XqslV
   WxHmTvsyFEcNVR1a9ziGGJtmAwH5bt39DuXSuAl3jd7teyF+R/tPAeJJZ
   ET97gGo5rum2+jAFz6fG1dKC4PqvMjg2qY50JsVHxoEwGszh+kWCw5vX3
   S7niZruvBCyLDZT0S2cyTYOMlEgJ2oTy70X6mDf+YH+B1eVvzEfkyFvBM
   Xl6bQRGzCMHFS6xjDEiWg2Qc1vkG8sQ2cEWwuhG+DryVtq/DHvVK0pv3S
   VliCCefMqgItAg5dXUDCdr7lOx59Ry4X6Zwaxk6Gm3F8UkANA1mtiqJXC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342959466"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="342959466"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 01:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835798652"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835798652"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2023 01:43:19 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        ilpo.jarvinen@linux.intel.com, pali@kernel.org,
        hdegoede@redhat.com, markgross@kernel.org, fengguang.wu@intel.com,
        dvhart@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] platform/x86/dell/dell-rbtn: Fix resources leaking on error path
Date:   Tue, 13 Jun 2023 11:43:10 +0300
Message-ID: <20230613084310.2775896-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently rbtn_add() in case of failure is leaking resources. Fix this
by adding a proper rollback. Move devm_kzalloc() before rbtn_acquire(),
so it doesn't require rollback in case of failure. While at it, remove
unnecessary assignment of NULL to device->driver_data and unnecessary
whitespace, plus add a break for the default case in a switch.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Fixes: 817a5cdb40c8 ("dell-rbtn: Dell Airplane Mode Switch driver")
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
v2:
 - move devm_kzalloc before rbtn_acquire as suggested

 drivers/platform/x86/dell/dell-rbtn.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index aa0e6c907494..c8fcb537fd65 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -395,16 +395,16 @@ static int rbtn_add(struct acpi_device *device)
 		return -EINVAL;
 	}
 
+	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
+	if (!rbtn_data)
+		return -ENOMEM;
+
 	ret = rbtn_acquire(device, true);
 	if (ret < 0) {
 		dev_err(&device->dev, "Cannot enable device\n");
 		return ret;
 	}
 
-	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
-	if (!rbtn_data)
-		return -ENOMEM;
-
 	rbtn_data->type = type;
 	device->driver_data = rbtn_data;
 
@@ -420,10 +420,12 @@ static int rbtn_add(struct acpi_device *device)
 		break;
 	default:
 		ret = -EINVAL;
+		break;
 	}
+	if (ret)
+		rbtn_acquire(device, false);
 
 	return ret;
-
 }
 
 static void rbtn_remove(struct acpi_device *device)
@@ -442,7 +444,6 @@ static void rbtn_remove(struct acpi_device *device)
 	}
 
 	rbtn_acquire(device, false);
-	device->driver_data = NULL;
 }
 
 static void rbtn_notify(struct acpi_device *device, u32 event)
-- 
2.41.0

