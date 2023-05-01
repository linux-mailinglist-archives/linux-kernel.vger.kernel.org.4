Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD96F2C84
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjEADAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjEAC7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:59:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD40172E;
        Sun, 30 Apr 2023 19:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F9E560C79;
        Mon,  1 May 2023 02:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD986C4339E;
        Mon,  1 May 2023 02:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909932;
        bh=V9qfCXiqRnF5svfD+XiUfjcw4V4JRi/RM8set1IjB/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzvnJIO9CEFCEHReAer927BtsY/vPpfha6BlVRyIUcnOjiR70BeKUSZehFPI7fTMJ
         CaWKt1fCXaOGswSIHzsZOjGJJ72t5OCC3wnUeIKgxp3ccjur9gzaKucaZiOueZLH/8
         SpIbdaThPg35KnILWayuGRwAhVMT+aTgODMpJRbznlXSG5P/thlQGpxMOlf+6c6Q9f
         X6tJ3QpyCrtlYTM9/gCs95Pr6z+Qyij8VoQ9w1QF9r+tfWcf7mrh8lV5J72WX/7hJz
         cK3fV+q7RhoZnbBbCrovZkkYgbvVwBq1ruph9RhpbH/gSuCUbVjlyaW/SGmqOBaSSE
         fwqOwceVfVrbw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, yong.zhi@intel.com,
        djrscally@gmail.com, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 35/44] media: ipu3-cio2: support multiple sensors and VCMs with same HID
Date:   Sun, 30 Apr 2023 22:56:23 -0400
Message-Id: <20230501025632.3253067-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025632.3253067-1-sashal@kernel.org>
References: <20230501025632.3253067-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bingbu Cao <bingbu.cao@intel.com>

[ Upstream commit 567f97bd381fd79fa8563808118fc757cb6fa4ff ]

In current cio2-bridge, it is using the hid name to register software
node and software node will create kobject and sysfs entry according to
the node name, if there are multiple sensors and VCMs which are sharing
same HID name, it will cause the software nodes registration failure:

sysfs: cannot create duplicate filename '/kernel/software_nodes/dw9714'
...
Call Trace:
software_node_register_nodes
cio2_bridge_init
...
kobject_add_internal failed for dw9714 with -EEXIST,
don't try to register things with the same name in the same directory.

One solution is appending the sensor link(Mipi Port) in SSDB as suffix
of the node name to fix this problem.

Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 15 +++++++++++----
 drivers/media/pci/intel/ipu3/cio2-bridge.h |  3 ++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index dfefe0d8aa959..45427a3a3a252 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -212,6 +212,7 @@ static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
 						  struct cio2_sensor *sensor)
 {
 	struct software_node *nodes = sensor->swnodes;
+	char vcm_name[ACPI_ID_LEN + 4];
 
 	cio2_bridge_init_swnode_names(sensor);
 
@@ -229,9 +230,13 @@ static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
 						sensor->node_names.endpoint,
 						&nodes[SWNODE_CIO2_PORT],
 						sensor->cio2_properties);
-	if (sensor->ssdb.vcmtype)
-		nodes[SWNODE_VCM] =
-			NODE_VCM(cio2_vcm_types[sensor->ssdb.vcmtype - 1]);
+	if (sensor->ssdb.vcmtype) {
+		/* append ssdb.link to distinguish VCM nodes with same HID */
+		snprintf(vcm_name, sizeof(vcm_name), "%s-%u",
+			 cio2_vcm_types[sensor->ssdb.vcmtype - 1],
+			 sensor->ssdb.link);
+		nodes[SWNODE_VCM] = NODE_VCM(vcm_name);
+	}
 
 	cio2_bridge_init_swnode_group(sensor);
 }
@@ -295,7 +300,6 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		}
 
 		sensor = &bridge->sensors[bridge->n_sensors];
-		strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
 
 		ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
 						   &sensor->ssdb,
@@ -303,6 +307,9 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		if (ret)
 			goto err_put_adev;
 
+		snprintf(sensor->name, sizeof(sensor->name), "%s-%u",
+			 cfg->hid, sensor->ssdb.link);
+
 		if (sensor->ssdb.vcmtype > ARRAY_SIZE(cio2_vcm_types)) {
 			dev_warn(&adev->dev, "Unknown VCM type %d\n",
 				 sensor->ssdb.vcmtype);
diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/pci/intel/ipu3/cio2-bridge.h
index b93b749c65bda..b76ed8a641e20 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.h
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
@@ -113,7 +113,8 @@ struct cio2_sensor_config {
 };
 
 struct cio2_sensor {
-	char name[ACPI_ID_LEN];
+	/* append ssdb.link(u8) in "-%u" format as suffix of HID */
+	char name[ACPI_ID_LEN + 4];
 	struct acpi_device *adev;
 	struct i2c_client *vcm_i2c_client;
 
-- 
2.39.2

