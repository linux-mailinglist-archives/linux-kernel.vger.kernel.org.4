Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A0C62FDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbiKRTBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbiKRTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:01:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AA821893;
        Fri, 18 Nov 2022 11:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668798065; x=1700334065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aq3/ktfxVCsNfWJmCnwfAtRp32P9/TQ7EV+b3b0e5zQ=;
  b=TC70AVf5MoqKCAaXp+pkp22t3jTmXgbZ+c0wsOCqD8rEWDyRpjTN90NE
   GXidDxovqxg2MPnaY1qkujXoDETqyaZs0YydzBUt7VgZEvtiLpd3Le2Q1
   y91rJgD9W2huFyQ7yG3cVuhjqtcndIMMgsYTdseLwsNzhEjsMb4jhT5UD
   MYL5siOX/npmFg2QXiwEJJ2bBw/9REfWXNuIV23MKorrea6Bk2A+CRlVU
   8VX3dVcEpX+XsMnoNu2zkWXzr87jn3DNtI4kJOq3yYScWbNWqXby+pSSl
   Vk9zrFnsf4zhq8Rdkp26tMs8T1ZOmyToy07OuyV8sWUZaHE2i7b0taM9l
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="315028380"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="315028380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 11:01:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746106507"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="746106507"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2022 11:01:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5539284; Fri, 18 Nov 2022 21:01:26 +0200 (EET)
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
Subject: [PATCH v1 2/4] media: ipu3-cio2: Convert to use software_node_register_node_group()
Date:   Fri, 18 Nov 2022 20:56:15 +0200
Message-Id: <20221118185617.33908-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
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

The currently used software_node_register_nodes() is going to
be removed. Prepare driver by switchich to new API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 21 ++++++++++++++++++---
 drivers/media/pci/intel/ipu3/cio2-bridge.h |  5 +++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index 18974a72e94a..dfefe0d8aa95 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -195,6 +195,19 @@ static void cio2_bridge_init_swnode_names(struct cio2_sensor *sensor)
 		 SWNODE_GRAPH_ENDPOINT_NAME_FMT, 0); /* And endpoint 0 */
 }
 
+static void cio2_bridge_init_swnode_group(struct cio2_sensor *sensor)
+{
+	struct software_node *nodes = sensor->swnodes;
+
+	sensor->group[SWNODE_SENSOR_HID] = &nodes[SWNODE_SENSOR_HID];
+	sensor->group[SWNODE_SENSOR_PORT] = &nodes[SWNODE_SENSOR_PORT];
+	sensor->group[SWNODE_SENSOR_ENDPOINT] = &nodes[SWNODE_SENSOR_ENDPOINT];
+	sensor->group[SWNODE_CIO2_PORT] = &nodes[SWNODE_CIO2_PORT];
+	sensor->group[SWNODE_CIO2_ENDPOINT] = &nodes[SWNODE_CIO2_ENDPOINT];
+	if (sensor->ssdb.vcmtype)
+		sensor->group[SWNODE_VCM] =  &nodes[SWNODE_VCM];
+}
+
 static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
 						  struct cio2_sensor *sensor)
 {
@@ -219,6 +232,8 @@ static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
 	if (sensor->ssdb.vcmtype)
 		nodes[SWNODE_VCM] =
 			NODE_VCM(cio2_vcm_types[sensor->ssdb.vcmtype - 1]);
+
+	cio2_bridge_init_swnode_group(sensor);
 }
 
 static void cio2_bridge_instantiate_vcm_i2c_client(struct cio2_sensor *sensor)
@@ -252,7 +267,7 @@ static void cio2_bridge_unregister_sensors(struct cio2_bridge *bridge)
 
 	for (i = 0; i < bridge->n_sensors; i++) {
 		sensor = &bridge->sensors[i];
-		software_node_unregister_nodes(sensor->swnodes);
+		software_node_unregister_node_group(sensor->group);
 		ACPI_FREE(sensor->pld);
 		acpi_dev_put(sensor->adev);
 		i2c_unregister_device(sensor->vcm_i2c_client);
@@ -310,7 +325,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		cio2_bridge_create_fwnode_properties(sensor, bridge, cfg);
 		cio2_bridge_create_connection_swnodes(bridge, sensor);
 
-		ret = software_node_register_nodes(sensor->swnodes);
+		ret = software_node_register_node_group(sensor->group);
 		if (ret)
 			goto err_free_pld;
 
@@ -337,7 +352,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 	return 0;
 
 err_free_swnodes:
-	software_node_unregister_nodes(sensor->swnodes);
+	software_node_unregister_node_group(sensor->group);
 err_free_pld:
 	ACPI_FREE(sensor->pld);
 err_put_adev:
diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/pci/intel/ipu3/cio2-bridge.h
index 4418cbd08208..b93b749c65bd 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.h
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
@@ -117,8 +117,9 @@ struct cio2_sensor {
 	struct acpi_device *adev;
 	struct i2c_client *vcm_i2c_client;
 
-	/* SWNODE_COUNT + 1 for terminating empty node */
-	struct software_node swnodes[SWNODE_COUNT + 1];
+	/* SWNODE_COUNT + 1 for terminating NULL */
+	const struct software_node *group[SWNODE_COUNT + 1];
+	struct software_node swnodes[SWNODE_COUNT];
 	struct cio2_node_names node_names;
 
 	struct cio2_sensor_ssdb ssdb;
-- 
2.35.1

