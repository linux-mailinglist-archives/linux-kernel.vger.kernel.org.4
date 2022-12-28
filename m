Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FA86574F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiL1JtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiL1JtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:49:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB722F01B;
        Wed, 28 Dec 2022 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672220942; x=1703756942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jTREtm4c31COf+aa5sKKx8GFXjmF+LQu9JNMP099WX8=;
  b=HdS1jKmvXq0TvE9cgC5E33r9GFweeZB2hFYdTtlcSeCa5L302IhBEKl0
   jYia6dTyhuo//WAsCBT1RERuPH98q29Hrpw9jKROha+7FaZhToR54ZK0f
   dM/ZubpJAePtWVNl9tSSCEc4dvvsUIDQtqClUa20HRKhSgJ936mZx9SlR
   KYlMZLOFb27ZQwI/xr1OM1d07URMJj3h5XBVIAEDao9gvDMpP7KGOLm0V
   fsJ5/3Fi4KCw+9ky02/EWW1qAto7QvPBmlRJIdB7/B9+hjkVszyaKXG19
   Qp3U0+1rDF9FlFnwWPlSHFys4GBCtpToQluBUIHEJ6lfz3K6upwA7r01E
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322823324"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="322823324"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:49:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="685655148"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="685655148"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 28 Dec 2022 01:48:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 38D25159; Wed, 28 Dec 2022 11:49:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <dan.scally@ideasonboard.com>
Subject: [PATCH v3 1/4] media: ipu3-cio2: Don't dereference fwnode handle
Date:   Wed, 28 Dec 2022 11:49:19 +0200
Message-Id: <20221228094922.84119-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221228094922.84119-1-andriy.shevchenko@linux.intel.com>
References: <20221228094922.84119-1-andriy.shevchenko@linux.intel.com>
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
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
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

