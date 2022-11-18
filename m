Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1062FD8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbiKRTBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbiKRTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:01:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C826233A2;
        Fri, 18 Nov 2022 11:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668798068; x=1700334068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WvZ7SWFh8KHhZL+jsKQNukYdJbXBUPn1qpeTKkRZRVM=;
  b=Ib0lef1dWTXH8EXl5URnBFrezCwDAZkrJqeaXRjaSTcvEHJlbuCY5JKq
   jN9/qUkusoXO/Mc7PqS6U1BNvdD6Exl+fRSJR63Ki2EGFdt0oJ3Gaqr1g
   mnvT9Ghqipa9Yjy+Lq3Q+UFOQpMeEaKKuSrQPbWndUY4nc+GD963gOt3l
   xyMj2D6HEZM3kU00sChj/OjCh1DahdoxgYKMbkx7cNsTxE0IEnUQfuvYP
   DCLIJvdg8LmGuu2J5o0wo9Uh4NVC9dL75hyM06YTrHUpU9qxFfyFD0RrJ
   V21ddroO0wygthtzYBOzK9euXp80zg0jX3HWe+FE0ngCjcH2jCeeB+Mcl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="315028382"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="315028382"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 11:01:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746106506"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="746106506"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2022 11:01:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4968910E; Fri, 18 Nov 2022 21:01:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
Subject: [PATCH v1 1/4] media: ipu3-cio2: Don't dereference fwnode handle
Date:   Fri, 18 Nov 2022 20:56:14 +0200
Message-Id: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
which is a better coding practice.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index df6c94da2f6a..18974a72e94a 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -263,7 +263,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 				      struct cio2_bridge *bridge,
 				      struct pci_dev *cio2)
 {
-	struct fwnode_handle *fwnode;
+	struct fwnode_handle *fwnode, *primary;
 	struct cio2_sensor *sensor;
 	struct acpi_device *adev;
 	acpi_status status;
@@ -322,7 +322,9 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		}
 
 		sensor->adev = acpi_dev_get(adev);
-		adev->fwnode.secondary = fwnode;
+
+		primary = acpi_fwnode_handle(adev);
+		primary->secondary = fwnode;
 
 		cio2_bridge_instantiate_vcm_i2c_client(sensor);
 
-- 
2.35.1

