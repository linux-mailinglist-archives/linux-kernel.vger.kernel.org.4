Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CC74EDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGKMOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjGKMOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:14:12 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC4C1988
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHzotC7FgV0SZha1rNUVqlsxoWaLebttqJlVh/IkHrpKhKAAfKLetn7lE4OfwV6Kq4d5L3vNhwhF9UTEPAzejjS8TW4xBuW8KZus7WIlnj04ROBH4SLxze+0n3SwjCSIciX0n4UoN1Vm9BeayzsdgArxfKmxpDApSPqYIOw//XFSMw/XhQbqonmFxEZsTLU+VKmFIMmyEyGVA+tVEkdgGeABQ9VxMTNU2GEgxB5Xh8MLcELSxbDluMuvGaWYgNqW3VQrEjQp3ik8WSVleaLfKlEAOfUQyngMc2wcxgJCuKka7fH8aMHXwakz4lm5x2937mXe1djjD/Yp66eM2IE0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saDwYCffsHQy3mOfbWGcaOBQDQNBKsGtove1A0qSKbM=;
 b=G1+cDhSao++LS1MlE4ANn/3LW83uwaP67MM+j0kwE4/nFySTV7skngklYJqB0Ly22pIgmBNsQhWUSL/ul5vPU79eVDNP5NQq6eZZyj2uxKRQKMP4A4fDNtW8AqCFg2tFyqXpxYiDwXs4hVJ0CUADyBygy6e/7QdnoGmEEIMDGwtoWk1Egh5PSJ3POJtWOj0L5Cv7zGhS/ZCOcdix3tzDlW1VeXrqiaEaonizi6F6Kutgksrefax6Zy3jqwHxtLKVIr/m7d765kltI1OLvJ/5hFJ59UFO35ZsJClNs0RRfPBDcknthTcaWTJy0XnwNZekg+8fSi3n2owuxPh2YtuQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saDwYCffsHQy3mOfbWGcaOBQDQNBKsGtove1A0qSKbM=;
 b=z+8o81lPFBM5w2bj857HGGM6/2+V3NrjM5eNW9Zg3e3+h67W2NYs7j8yzpe1b+ie+dQ5TcaacVYJS9SnV1KD+XCzYcLHTTcGndF8yTVuAn38WWWGiVfuPbik8XfvsDZLqcUakQNFCJPR/RsgfHddl3VrCJiAdmbBZFfBDPIUNm8=
Received: from BN0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:e7::14)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 12:13:57 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::f) by BN0PR03CA0039.outlook.office365.com
 (2603:10b6:408:e7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 12:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 12:13:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 07:13:57 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 11 Jul 2023 07:13:49 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH 4/4] cdx: add sysfs for subsystem, class and revision
Date:   Tue, 11 Jul 2023 17:40:27 +0530
Message-ID: <20230711121027.936487-5-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230711121027.936487-1-abhijit.gangurde@amd.com>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a50ef40-d0b1-4202-b390-08db82084db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WlzW+UMLVqc95cknpH0ujlu46vEGmlR2aQ9WTfyGNHt2Ir2Jo0GdmbvuV9Xy6lXtqDan3598J73dwKFJ9oIrxtnSC1L24oS0wEYOGIvKnVAKhpu0WnjuTmosRGzkUvYylebUNLTDIV2qfNy5hCaAtu5Ggfzxlm7Uyhf+9cCW+cIVv047XjuTSIQKzXOkMYXHNu2gdna82lB8v9tQ3ERnOVofXn6quFr9ig83cDCXOQRDyupkJPUiDcutdnpmlmnYYkEmwZ8skqOUFXcvo4oFagtCh2RZc9v4N2oIZpyF3IsmeX4JxuYBsjM0eluOT7QWf86v6oSiLFoTtJToeF3lbieLL/Fe6ktU2kLyCKEgNv3p7Rnmb4mWRyW0qzyjzXyb4oayqDj65SosLJeyOEd7Qw55geFJqYlEvzn0oN2lYmv91i9zLHj07M44eRr10nPmJc+pCS6TVzCVKt/IIKkq8bCbxNNVyZ0EycQZAFDg4W/eFFMCXBKDp4X8MvcrsScosMvW8UlPpZ91zHBtl8d2Q9odVe2wEqbHQj5KmbI9CQo8jyH/nVk8CM6phF6y8Uzpt1K+BRuqM62rrJWHZfM8eVSFaGgrxJsuozSj8vEuU3sk9OED63jFEep5YLV81aOdPkfPwM0MnnQ5scbLuX/uuvEWAkIev5l5i016KqD7zMc4qbMPTuTVq5urIjMhMfKvFbX1Hx2gvq95f6Lp4h6sVAKIvr+G1LX5iuXlPn0HPXFD7lTtmYpbHIoyyGqdSaGZKWynQ9JHYTshdj2XH4qMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(86362001)(82740400003)(40460700003)(40480700001)(36756003)(6666004)(110136005)(54906003)(70586007)(70206006)(356005)(81166007)(36860700001)(1076003)(26005)(186003)(2616005)(478600001)(426003)(316002)(5660300002)(2906002)(8936002)(8676002)(336012)(83380400001)(30864003)(4326008)(44832011)(41300700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:13:57.7756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a50ef40-d0b1-4202-b390-08db82084db6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPU provides subsystem_vendor, subsystem_device, class and revision
info of the device. Use the Subsystem vendor id, device id and class
to match the cdx device. Subsystem vendor and device combination
can be used to identify the card. This identification would be useful
for cdx device driver for card specific operations.

Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cdx | 45 +++++++++++++++++++++++++
 drivers/cdx/cdx.c                       | 29 +++++++++++++++-
 drivers/cdx/cdx.h                       |  8 +++++
 drivers/cdx/controller/mcdi_functions.c |  7 ++++
 include/linux/cdx/cdx_bus.h             | 27 +++++++++++++--
 include/linux/mod_devicetable.h         | 10 ++++++
 scripts/mod/devicetable-offsets.c       |  4 +++
 scripts/mod/file2alias.c                |  8 +++++
 8 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index 6ca47b6442ce..da6459ac8fb2 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -50,6 +50,36 @@ Description:
 		of a device manufacturer.
 		Combination of Vendor ID and Device ID identifies a device.
 
+What:		/sys/bus/cdx/devices/.../subsystem_vendor
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		Subsystem Vendor ID for this CDX device, in hexadecimal.
+		Subsystem Vendor ID is 16 bit identifier specific to the
+		card manufacturer.
+
+What:		/sys/bus/cdx/devices/.../subsystem_device
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		Subsystem Device ID for this CDX device, in hexadecimal
+		Subsystem Device ID is 16 bit identifier specific to the
+		card manufacturer.
+
+What:		/sys/bus/cdx/devices/.../class
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		This file contains the class of the CDX device, in hexadecimal.
+		Class is 24 bit identifier specifies the functionality of the device.
+
+What:		/sys/bus/cdx/devices/.../revision
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		This file contains the revision field of the CDX device, in hexadecimal.
+		Revision is 8 bit revision identifier of the device.
+
 What:		/sys/bus/cdx/devices/.../reset
 Date:		March 2023
 Contact:	nipun.gupta@amd.com
@@ -91,3 +121,18 @@ Contact:	puneet.gupta@amd.com
 Description:
 		The resource binary file contains the content of the memory
 		regions. These files can be m'maped from userspace.
+
+What:		/sys/bus/cdx/devices/.../modalias
+Date:		July 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		This attribute indicates the CDX ID of the device.
+		That is in the format:
+		cdx:vXXXXdXXXXsvXXXXsdXXXXcXXXXXX,
+		where:
+
+		    - vXXXX contains the vendor ID;
+		    - dXXXX contains the device ID;
+		    - svXXXX contains the subsystem vendor ID;
+		    - sdXXXX contains the subsystem device ID;
+		    - cXXXXXX contains the device class.
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 9d568df8e566..e9055baf14bb 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -162,7 +162,10 @@ cdx_match_one_device(const struct cdx_device_id *id,
 {
 	/* Use vendor ID and device ID for matching */
 	if ((id->vendor == CDX_ANY_ID || id->vendor == dev->vendor) &&
-	    (id->device == CDX_ANY_ID || id->device == dev->device))
+	    (id->device == CDX_ANY_ID || id->device == dev->device) &&
+	    (id->subvendor == CDX_ANY_ID || id->subvendor == dev->subsystem_vendor) &&
+	    (id->subdevice == CDX_ANY_ID || id->subdevice == dev->subsystem_device) &&
+	    !((id->class ^ dev->class) & id->class_mask))
 		return id;
 	return NULL;
 }
@@ -308,6 +311,10 @@ static DEVICE_ATTR_RO(field)
 
 cdx_config_attr(vendor, "0x%04x\n");
 cdx_config_attr(device, "0x%04x\n");
+cdx_config_attr(subsystem_vendor, "0x%04x\n");
+cdx_config_attr(subsystem_device, "0x%04x\n");
+cdx_config_attr(revision, "0x%02x\n");
+cdx_config_attr(class, "0x%06x\n");
 
 static ssize_t remove_store(struct device *dev,
 			    struct device_attribute *attr,
@@ -353,6 +360,17 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(reset);
 
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+
+	return sprintf(buf, "cdx:v%04Xd%04Xsv%04Xsd%04Xc%06X\n", cdx_dev->vendor,
+			cdx_dev->device, cdx_dev->subsystem_vendor, cdx_dev->subsystem_device,
+			cdx_dev->class);
+}
+static DEVICE_ATTR_RO(modalias);
+
 static ssize_t driver_override_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
@@ -403,6 +421,11 @@ static struct attribute *cdx_dev_attrs[] = {
 	&dev_attr_reset.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
+	&dev_attr_subsystem_vendor.attr,
+	&dev_attr_subsystem_device.attr,
+	&dev_attr_class.attr,
+	&dev_attr_revision.attr,
+	&dev_attr_modalias.attr,
 	&dev_attr_driver_override.attr,
 	&dev_attr_resource.attr,
 	NULL,
@@ -652,6 +675,10 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 	cdx_dev->req_id = dev_params->req_id;
 	cdx_dev->vendor = dev_params->vendor;
 	cdx_dev->device = dev_params->device;
+	cdx_dev->subsystem_vendor = dev_params->subsys_vendor;
+	cdx_dev->subsystem_device = dev_params->subsys_device;
+	cdx_dev->class = dev_params->class;
+	cdx_dev->revision = dev_params->revision;
 	cdx_dev->bus_num = dev_params->bus_num;
 	cdx_dev->dev_num = dev_params->dev_num;
 	cdx_dev->cdx = dev_params->cdx;
diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
index c436ac7ac86f..d17b5a501e8d 100644
--- a/drivers/cdx/cdx.h
+++ b/drivers/cdx/cdx.h
@@ -16,21 +16,29 @@
  * @parent: Associated CDX controller
  * @vendor: Vendor ID for CDX device
  * @device: Device ID for CDX device
+ * @subsys_vendor: Sub vendor ID for CDX device
+ * @subsys_device: Sub device ID for CDX device
  * @bus_num: Bus number for this CDX device
  * @dev_num: Device number for this device
  * @res: array of MMIO region entries
  * @res_count: number of valid MMIO regions
  * @req_id: Requestor ID associated with CDX device
+ * @class: Class of the CDX Device
+ * @revision: Revision of the CDX device
  */
 struct cdx_dev_params {
 	struct cdx_controller *cdx;
 	u16 vendor;
 	u16 device;
+	u16 subsys_vendor;
+	u16 subsys_device;
 	u8 bus_num;
 	u8 dev_num;
 	struct resource res[MAX_CDX_DEV_RESOURCES];
 	u8 res_count;
 	u32 req_id;
+	u32 class;
+	u8 revision;
 };
 
 /**
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 400fdc771104..a227922a03ca 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -120,6 +120,13 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 
 	dev_params->vendor = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_VENDOR_ID);
 	dev_params->device = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_ID);
+	dev_params->subsys_vendor = MCDI_WORD(outbuf,
+					      CDX_BUS_GET_DEVICE_CONFIG_OUT_SUBSYS_VENDOR_ID);
+	dev_params->subsys_device = MCDI_WORD(outbuf,
+					      CDX_BUS_GET_DEVICE_CONFIG_OUT_SUBSYS_DEVICE_ID);
+	dev_params->class = MCDI_DWORD(outbuf,
+				       CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_CLASS) & 0xFFFFFF;
+	dev_params->revision = MCDI_BYTE(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_REVISION);
 
 	return 0;
 }
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index e93f1cd8ae33..2fa727770d6d 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -36,6 +36,19 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
 				    u8 bus_num, u8 dev_num,
 				    struct cdx_device_config *dev_config);
 
+/**
+ * CDX_DEVICE - macro used to describe a specific CDX device
+ * @vend: the 16 bit CDX Vendor ID
+ * @dev: the 16 bit CDX Device ID
+ *
+ * This macro is used to create a struct cdx_device_id that matches a
+ * specific device. The subvendor and subdevice fields will be set to
+ * CDX_ANY_ID.
+ */
+#define CDX_DEVICE(vend, dev) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = CDX_ANY_ID, .subdevice = CDX_ANY_ID
+
 /**
  * CDX_DEVICE_DRIVER_OVERRIDE - macro used to describe a CDX device with
  *                              override_only flags.
@@ -44,10 +57,12 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
  * @driver_override: the 32 bit CDX Device override_only
  *
  * This macro is used to create a struct cdx_device_id that matches only a
- * driver_override device.
+ * driver_override device. The subvendor and subdevice fields will be set to
+ * CDX_ANY_ID.
  */
 #define CDX_DEVICE_DRIVER_OVERRIDE(vend, dev, driver_override) \
-	.vendor = (vend), .device = (dev), .override_only = (driver_override)
+	.vendor = (vend), .device = (dev), .subvendor = CDX_ANY_ID,\
+	.subdevice = CDX_ANY_ID, .override_only = (driver_override)
 
 /**
  * struct cdx_ops - Callbacks supported by CDX controller.
@@ -84,6 +99,10 @@ struct cdx_controller {
  * @cdx: CDX controller associated with the device
  * @vendor: Vendor ID for CDX device
  * @device: Device ID for CDX device
+ * @subsystem_vendor: Subsystem Vendor ID for CDX device
+ * @subsystem_device: Subsystem Device ID for CDX device
+ * @class: Class for the CDX device
+ * @revision: Revision of the CDX device
  * @bus_num: Bus number for this CDX device
  * @dev_num: Device number for this device
  * @res: array of MMIO region entries
@@ -101,6 +120,10 @@ struct cdx_device {
 	struct cdx_controller *cdx;
 	u16 vendor;
 	u16 device;
+	u16 subsystem_vendor;
+	u16 subsystem_device;
+	u32 class;
+	u8 revision;
 	u8 bus_num;
 	u8 dev_num;
 	struct resource res[MAX_CDX_DEV_RESOURCES];
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index b0678b093cb2..aa3c28781248 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -935,6 +935,12 @@ enum {
  * struct cdx_device_id - CDX device identifier
  * @vendor: Vendor ID
  * @device: Device ID
+ * @subvendor: Subsystem vendor ID (or CDX_ANY_ID)
+ * @subdevice: Subsystem device ID (or CDX_ANY_ID)
+ * @class: Device class
+ *         Most drivers do not need to specify class/class_mask
+ *         as vendor/device is normally sufficient.
+ * @class_mask: Limit which sub-fields of the class field are compared.
  * @override_only: Match only when dev->driver_override is this driver.
  *
  * Type of entries in the "device Id" table for CDX devices supported by
@@ -943,6 +949,10 @@ enum {
 struct cdx_device_id {
 	__u16 vendor;
 	__u16 device;
+	__u16 subvendor;
+	__u16 subdevice;
+	__u32 class;
+	__u32 class_mask;
 	__u32 override_only;
 };
 
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index abe65f8968dd..7a659aa3114a 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -265,6 +265,10 @@ int main(void)
 	DEVID(cdx_device_id);
 	DEVID_FIELD(cdx_device_id, vendor);
 	DEVID_FIELD(cdx_device_id, device);
+	DEVID_FIELD(cdx_device_id, subvendor);
+	DEVID_FIELD(cdx_device_id, subdevice);
+	DEVID_FIELD(cdx_device_id, class);
+	DEVID_FIELD(cdx_device_id, class_mask);
 	DEVID_FIELD(cdx_device_id, override_only);
 
 	return 0;
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 38120f932b0d..abc4781d5db7 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1458,6 +1458,10 @@ static int do_cdx_entry(const char *filename, void *symval,
 {
 	DEF_FIELD(symval, cdx_device_id, vendor);
 	DEF_FIELD(symval, cdx_device_id, device);
+	DEF_FIELD(symval, cdx_device_id, subvendor);
+	DEF_FIELD(symval, cdx_device_id, subdevice);
+	DEF_FIELD(symval, cdx_device_id, class);
+	DEF_FIELD(symval, cdx_device_id, class_mask);
 	DEF_FIELD(symval, cdx_device_id, override_only);
 
 	switch (override_only) {
@@ -1475,6 +1479,10 @@ static int do_cdx_entry(const char *filename, void *symval,
 
 	ADD(alias, "v", vendor != CDX_ANY_ID, vendor);
 	ADD(alias, "d", device != CDX_ANY_ID, device);
+	ADD(alias, "sv", subvendor != CDX_ANY_ID, subvendor);
+	ADD(alias, "sd", subdevice != CDX_ANY_ID, subdevice);
+	ADD(alias, "c", class_mask == 0xFFFFFF, class);
+
 	return 1;
 }
 
-- 
2.25.1

