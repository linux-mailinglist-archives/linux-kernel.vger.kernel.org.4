Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29D36327EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiKUP0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKUP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:26:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA25138;
        Mon, 21 Nov 2022 07:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669044403; x=1700580403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D9tqklG/AuJk+yfcIp6L39SLa6QZ1GCROYNdZojYkW8=;
  b=kW55BdDWuVhdhfGLBvOXIedYNJkiQcdovLac/ni1/VOJxGKTmsc5M7wF
   kww6FQ5YcnAgZbT+aSU8Tn5L7s6ngWTJiNo+d3ZpQRlka8CcdLQ17vEqU
   OWsqxv3DT/8pzKRAmp2k9lVWWHVjpB1iOFBP1Lj2HlHj5yPn/F14eAC1r
   27XFwhxFLQAxtWmi/bLw9e5tSlgKg2wgunJ3tuQ768wvlOwnfGI9r9Pbj
   yeGradjlj/uEJDMrHsdnGwx9af/UBTml7uWrjSqtFYkxF4oiNeWxCTdtt
   WIAe6t+9hubk2iF/+L+nwtVGFchCSlNnH6MzB3lr95SYh7mqvY2fvilXY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="399872888"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="399872888"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 07:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="746949110"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="746949110"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2022 07:26:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2A87510E; Mon, 21 Nov 2022 17:27:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
Subject: [PATCH v2 1/4] media: ipu3-cio2: Don't dereference fwnode handle
Date:   Mon, 21 Nov 2022 17:27:01 +0200
Message-Id: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
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
Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
---
v2: added tags (Heikki, Daniel)

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

