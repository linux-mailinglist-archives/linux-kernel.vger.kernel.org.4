Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09B766DF27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjAQNnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAQNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:42:59 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB03B3FB;
        Tue, 17 Jan 2023 05:42:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BL3nj2gcGmQg4KSWz71Y+XpJUcihijwv353vHBB56ofvwQl2REmER2p+3WtRLWxNlqUuazH1Vw71bGPkDb+CzWnnq9MLzDm6DDfrBj0AjN0SNCDsNbNI0GZD6pEuw5B0eRu/UbcvYw417dRty+hKRfybp1sh5jg2W8cptwlcbrD69Q20nSX+bW9V3qTX2A9d61B7jEAV54KYnUYSkgCuH5ms2HL/lZof5Hhh5Em4uIZcehzQz8G3CTb7TMEiGBhHzUECjGI+tjSjwnjmUpYpeds6XQginlh5krovglvFQaEN58ElXHcdQWG4C7GG30C4E3HGiPOB9KLW+JXUTp3ocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up5z3xgYMCh6DNcuWC6HHVnZt/NCk+G1f+0lwgIAnzg=;
 b=N/5WfLeDbdxBEzUWR8LAUBO/XfRwBLC1hN6gJK1OUrLqIdrRA7dmwO8BhPwIks57lhaYGAbKcyv2cL7hhWJ4T1UpDb9KIwGSA103me36xA9ro/5vWSAvRu71x8KGuNWNZHMeb0SK5nReLGkujJQP2SNDU0SIYNEaaXZVb7UWxf65uLjtvMKOCdr9seNliM01PGmnp+tIDFCRBVh7F9Xz4jiLEB37vyZt1lVPI/5QNsmqpbdYvUgcOcmcZt/AtSOborRCye8HTFbzD8sIB7h3zerresxRE0fI6W1Rw8Sc16KgIx9kpe6IfFBTbq8P51ajsN2NVHLlkHBSKoRrSMXu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up5z3xgYMCh6DNcuWC6HHVnZt/NCk+G1f+0lwgIAnzg=;
 b=DSeUL3+6IbkiF/DbrnHzkq5UrA5g5CuBvwhz4C/jPPGdlWYjnWlH9VgTsrk14SX1mFv0ny2vMeKbXsDQj4O/PWSrpUt6nstQQXj27SJdu/7r6jHFDti1M1Yj5nl3F9OO1sk/k49rR/pMas4GPUEwDIl3IfbkKrh5GhfBlbvM1gY=
Received: from DM5PR07CA0115.namprd07.prod.outlook.com (2603:10b6:4:ae::44) by
 MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 13:42:51 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::8e) by DM5PR07CA0115.outlook.office365.com
 (2603:10b6:4:ae::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 13:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 13:42:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:49 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 07:42:42 -0600
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <eric.auger@redhat.com>, <alex.williamson@redhat.com>,
        <cohuck@redhat.com>, <song.bao.hua@hisilicon.com>,
        <mchehab+huawei@kernel.org>, <maz@kernel.org>,
        <f.fainelli@gmail.com>, <jeffrey.l.hugo@gmail.com>,
        <saravanak@google.com>, <Michael.Srba@seznam.cz>,
        <mani@kernel.org>, <yishaih@nvidia.com>, <jgg@ziepe.ca>,
        <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <joro@8bytes.org>, <masahiroy@kernel.org>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH 07/19] bus/cdx: add device attributes
Date:   Tue, 17 Jan 2023 19:11:39 +0530
Message-ID: <20230117134139.1298-8-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117134139.1298-1-nipun.gupta@amd.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 674cfb48-c378-46b2-2cfa-08daf890ba2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbROuPadBV+aWERIJS3SzhO82rSt29v4eO5b/10MapjjC579ySo5qDPsIkwDDFx0OvPAP7LrHzf8oBSHGREV+Df2Gfc3R1BYxWJBczYqkQUTWueiVQvR1uDMhXl5PR+sdFV9LoYyJzE2+JtLcktzXjWIdjyqMQUXmarPK2BFk1pVXmUaQO4bggna2jIUbKXhzXkoZ4p65UEr1JNSj4i8UZDPrnmojNSvstmYrhBQXwUJQSmLpcraqwxuKvhIUHDmg3s31WMOKjQtH24zy0hQ8S0iPC0R0+JiSztPCKlyppgGExbvqnjGyJclbyBKs0C1AbN9tZQP4iMVMR3bR3UU0haBiyX9Otd3ht8Sn1wTmoV0Oxu72NniPKU7x90B3lz28Ulwvw4NViyv9mwRyBJBaVXNuOJXDZPcX5JtIyDLdUIfYyGZtBi7YUpGLZfw57Rsru7beypyC4bNKvSOjuyIHINylxPiriQIRj3NZ4g2PofnaXl/IMhAjBcD/8Syos25O4e/BeFo+KfgDrKXIoZSoZIDHDQc6L/jSeDFCByvJkR83bTOlUKOJZSm/6PiVwbliuCr906u3WD+rmAjZqjHnzQpXfh5eJjWnexe2/y4im7aSz3I+OmZEtTeAOKMI3xMIQIXW7Hm8fx6QKOV9utytP/ijkcLKeeMYAQAP9RGHIumCVSxHQxiIKc54BUxsPxlf7aEZC3Xh9+oDJce83HtoabROQ+cZTozq3JGGbJ93HSRlSBEjER0KGHXwFBpu1ev8EFHSTaTagP1aRD/gRSC+Not6mbVEy1AKnyErzESvJ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(336012)(40460700003)(82310400005)(478600001)(47076005)(83380400001)(36756003)(86362001)(54906003)(4326008)(8676002)(426003)(41300700001)(40480700001)(44832011)(7416002)(5660300002)(186003)(8936002)(26005)(6666004)(70586007)(316002)(1076003)(110136005)(81166007)(921005)(356005)(2906002)(36860700001)(70206006)(82740400003)(2616005)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:42:50.7936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 674cfb48-c378-46b2-2cfa-08daf890ba2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create sysfs entry for CDX devices.

Sysfs entries provided in each of the CDX device detected by
the CDX controller
 - vendor id
 - device id
 - remove
 - reset of the device.
 - driver override

Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cdx     |  34 +++++
 drivers/bus/cdx/cdx.c                       | 144 ++++++++++++++++++++
 drivers/bus/cdx/controller/cdx_controller.c |  19 +++
 drivers/bus/cdx/controller/mcdi_functions.c |  14 ++
 drivers/bus/cdx/controller/mcdi_functions.h |  11 ++
 include/linux/cdx/cdx_bus.h                 |  23 ++++
 6 files changed, 245 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index 8c2425fdb6d9..1e0fdce18cde 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -10,3 +10,37 @@ Description:
                 For example::
 
 		  # echo 1 > /sys/bus/cdx/rescan
+
+What:		/sys/bus/cdx/devices/.../vendor
+Date:		January 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Vendor ID for this CDX device
+
+What:		/sys/bus/cdx/devices/.../device
+Date:		January 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Device ID for this CDX device
+
+What:		/sys/bus/cdx/devices/.../reset
+Date:		January 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Writing a non-zero value to this file would reset the
+		CDX device
+
+                For example::
+
+		  # echo 1 > /sys/bus/cdx/.../reset
+
+What:		/sys/bus/cdx/devices/.../remove
+Date:		January 2023
+Contact:	tarak.reddy@amd.com
+Description:
+		Writing a non-zero value to this file would remove the
+		corrosponding device from the CDX bus
+
+		For example::
+
+		# echo 1 > /sys/bus/cdx/devices/.../remove
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 2737470f08d3..1372d8dcaa4c 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -72,6 +72,38 @@ static DECLARE_BITMAP(cdx_controller_id_map, MAX_CDX_CONTROLLERS);
 /* List of CDX controllers registered with the CDX bus */
 static LIST_HEAD(cdx_controllers);
 
+/**
+ * reset_cdx_device - Reset a CDX device
+ * @dev: CDX device
+ * @data: This is always passed as NULL, and is not used in this API,
+ *	  but is required here as the bus_for_each_dev() API expects
+ *	  the passed function (reset_cdx_device) to have this
+ *	  as an argument.
+ *
+ * @return: -errno on failure, 0 on success.
+ */
+static int reset_cdx_device(struct device *dev, void *data)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+	int ret;
+
+	dev_config.type = CDX_DEV_RESET_CONF;
+	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
+				      cdx_dev->dev_num, &dev_config);
+	if (ret)
+		dev_err(dev, "cdx device reset failed\n");
+
+	return ret;
+}
+
+int cdx_dev_reset(struct device *dev)
+{
+	return reset_cdx_device(dev, NULL);
+}
+EXPORT_SYMBOL_GPL(cdx_dev_reset);
+
 /**
  * cdx_unregister_device - Unregister a CDX device
  * @dev: CDX device
@@ -238,6 +270,117 @@ static int cdx_dma_configure(struct device *dev)
 	return 0;
 }
 
+/* show configuration fields */
+#define cdx_config_attr(field, format_string)	\
+static ssize_t	\
+field##_show(struct device *dev, struct device_attribute *attr, char *buf)	\
+{	\
+	struct cdx_device *cdx_dev = to_cdx_device(dev);	\
+	return sysfs_emit(buf, format_string, cdx_dev->field);	\
+}	\
+static DEVICE_ATTR_RO(field)
+
+cdx_config_attr(vendor, "0x%04x\n");
+cdx_config_attr(device, "0x%04x\n");
+
+static ssize_t remove_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long val = 0;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (!val)
+		return -EINVAL;
+
+	if (device_remove_file_self(dev, attr)) {
+		int ret;
+
+		ret = cdx_unregister_device(dev, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(remove);
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	unsigned long val = 0;
+	int ret = 0;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = reset_cdx_device(dev, NULL);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	const char *old = cdx_dev->driver_override;
+	char *driver_override;
+	char *cp;
+
+	if (WARN_ON(dev->bus != &cdx_bus_type))
+		return -EINVAL;
+
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	driver_override = kstrndup(buf, count, GFP_KERNEL);
+	if (!driver_override)
+		return -ENOMEM;
+
+	cp = strchr(driver_override, '\n');
+	if (cp)
+		*cp = '\0';
+
+	if (strlen(driver_override)) {
+		cdx_dev->driver_override = driver_override;
+	} else {
+		kfree(driver_override);
+		cdx_dev->driver_override = NULL;
+	}
+
+	kfree(old);
+
+	return count;
+}
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+
+	return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+}
+static DEVICE_ATTR_RW(driver_override);
+
+static struct attribute *cdx_dev_attrs[] = {
+	&dev_attr_remove.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_vendor.attr,
+	&dev_attr_device.attr,
+	&dev_attr_driver_override.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(cdx_dev);
+
 static ssize_t rescan_store(struct bus_type *bus,
 			    const char *buf, size_t count)
 {
@@ -280,6 +423,7 @@ struct bus_type cdx_bus_type = {
 	.shutdown	= cdx_shutdown,
 	.dma_configure	= cdx_dma_configure,
 	.bus_groups	= cdx_bus_groups,
+	.dev_groups	= cdx_dev_groups,
 };
 EXPORT_SYMBOL_GPL(cdx_bus_type);
 
diff --git a/drivers/bus/cdx/controller/cdx_controller.c b/drivers/bus/cdx/controller/cdx_controller.c
index b62a6d3b7bd4..dbcd236b360d 100644
--- a/drivers/bus/cdx/controller/cdx_controller.c
+++ b/drivers/bus/cdx/controller/cdx_controller.c
@@ -85,6 +85,24 @@ void cdx_rpmsg_pre_remove(struct cdx_controller *cdx)
 	cdx_mcdi_wait_for_quiescence(cdx->priv, MCDI_RPC_TIMEOUT);
 }
 
+static int cdx_configure_device(struct cdx_controller *cdx,
+				u8 bus_num, u8 dev_num,
+				struct cdx_device_config *dev_config)
+{
+	int ret = 0;
+
+	switch (dev_config->type) {
+	case CDX_DEV_RESET_CONF:
+		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
+		break;
+	default:
+		dev_err(cdx->dev, "Invalid device configuration flag\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static int cdx_scan_devices(struct cdx_controller *cdx)
 {
 	struct cdx_mcdi *cdx_mcdi = cdx->priv;
@@ -144,6 +162,7 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 
 static struct cdx_ops cdx_ops = {
 	.scan		= cdx_scan_devices,
+	.dev_configure	= cdx_configure_device,
 };
 
 static int xlnx_cdx_probe(struct platform_device *pdev)
diff --git a/drivers/bus/cdx/controller/mcdi_functions.c b/drivers/bus/cdx/controller/mcdi_functions.c
index 3940a2c7919c..673b3896411e 100644
--- a/drivers/bus/cdx/controller/mcdi_functions.c
+++ b/drivers/bus/cdx/controller/mcdi_functions.c
@@ -123,3 +123,17 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 
 	return 0;
 }
+
+int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_RESET_IN_LEN);
+	int rc;
+
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_RESET_IN_BUS, bus_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_RESET_IN_DEVICE, dev_num);
+
+	rc = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_RESET, inbuf, sizeof(inbuf),
+			  NULL, 0, NULL);
+
+	return rc;
+}
diff --git a/drivers/bus/cdx/controller/mcdi_functions.h b/drivers/bus/cdx/controller/mcdi_functions.h
index 97dfde18592f..54d6017ab7d1 100644
--- a/drivers/bus/cdx/controller/mcdi_functions.h
+++ b/drivers/bus/cdx/controller/mcdi_functions.h
@@ -47,4 +47,15 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 			    u8 bus_num, u8 dev_num,
 			    struct cdx_dev_params *dev_params);
 
+/**
+ * cdx_mcdi_reset_device - Reset cdx device represented by bus_num:dev_num
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ * @dev_num: Device number.
+ *
+ * @return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_reset_device(struct cdx_mcdi *cdx,
+			  u8 bus_num, u8 dev_num);
+
 #endif /* CDX_MCDI_FUNCTIONS_H */
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index 1d28f11da5e7..9f055739ed30 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -21,8 +21,20 @@
 /* Forward declaration for CDX controller */
 struct cdx_controller;
 
+enum {
+	CDX_DEV_RESET_CONF,
+};
+
+struct cdx_device_config {
+	u8 type;
+};
+
 typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
 
+typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
+				    u8 bus_num, u8 dev_num,
+				    struct cdx_device_config *dev_config);
+
 /**
  * CDX_DEVICE_DRIVER_OVERRIDE - macro used to describe a CDX device with
  *                              override_only flags.
@@ -39,9 +51,12 @@ typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
 /**
  * struct cdx_ops - Callbacks supported by CDX controller.
  * @scan: scan the devices on the controller
+ * @dev_configure: configuration like reset, master_enable,
+ *		   msi_config etc for a CDX device
  */
 struct cdx_ops {
 	cdx_scan_cb scan;
+	cdx_dev_configure_cb dev_configure;
 };
 
 /**
@@ -150,4 +165,12 @@ void cdx_driver_unregister(struct cdx_driver *cdx_driver);
 
 extern struct bus_type cdx_bus_type;
 
+/**
+ * cdx_dev_reset - Reset CDX device
+ * @dev: device pointer
+ *
+ * @return: 0 for success, -errno on failure
+ */
+int cdx_dev_reset(struct device *dev);
+
 #endif /* _CDX_BUS_H_ */
-- 
2.17.1

