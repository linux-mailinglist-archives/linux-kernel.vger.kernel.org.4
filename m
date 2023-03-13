Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6F6B78F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjCMN23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjCMN2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:28:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7116B5C1;
        Mon, 13 Mar 2023 06:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TssO3QNcCqOeCfih9WPO2jVyz99rlZtx0MVwKKnYq8qDQSU0qLX8BGzQhixcBCBeG7wbfCpnNpdEJpGTKi/NBmpYSZ0IUNIhEHVBAZ4sX0kULQutJc6WUxtyB2jTNa+7yBTBxJEIZr2zkyOPskqabewLSmzebURk67gBkPQWVVsVZgbbBq9a5bg0F0hYaWTdZ5tAuUK0W75xUQMR5rJALLIqR4Kvz710liYFgf2WZNpd0hLABsv8CE6ivBpfVL+GZQJQHbybIXiIAiCUm9g/NVpver1wc+9Wb56KEs+0rLeici/OFhTugzpPuzm2SSjeTCjxKBUVvcxwqVogmPUE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0atsDWvY1G7x7R89ffy1DI5WqicybbAZlFiW5sV0Aw=;
 b=CTRndDuNIcUOMqHXg4uPIexp351YAutfp1XB+1frq/0f6tXDRcO2f18YGG/hbPTHZEt/afeKM+IQywVyrsg+1yEN2Iw3YQ/3HNIqmfPh93s2WTt5ZBEOj0pPhFdJ/nOSn+QO0qRVmgajHq1AERxj+vXAbpsiSMtz9YNFEcj8kIPxWpytbJ8U0QTca+cRKq7suA3lB9EQhjE9c/K1A3Wld55s47+jVlT4IWRJSWr9KMGPUoLB3KRknizcTItNeiK9hfS5sC89iqxWw15yks846b2DagaF0lhCI77Hc87gEDg6ecIHVOsoP+vwMPY7w9/1hvxnzXiWqmxrXAgM+LyWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0atsDWvY1G7x7R89ffy1DI5WqicybbAZlFiW5sV0Aw=;
 b=0V79T9IqmFnlKIX5jIarMiArTgyoCqZhprhWq6vN2DrzjDhESvw3UpW3QoMI8M4zeLhVOa4dnv2MaAs/ZhEbautQrFUE5PftGCzTNlNDKQobGTX0kmhBwAaGK7tBzBd78ANAuvIrg5pV2OV9b5ePbBtb5Wb+KPE0r7r+L3Z3Wiw=
Received: from BN8PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:d4::16)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:27:50 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::6e) by BN8PR04CA0042.outlook.office365.com
 (2603:10b6:408:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 13:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 13:27:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 08:27:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 08:27:49 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 13 Mar 2023 08:27:40 -0500
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
        <ndesaulniers@google.com>, <rdunlap@infradead.org>,
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <pablo.cascon@amd.com>,
        <git@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v10 7/7] cdx: add device attributes
Date:   Mon, 13 Mar 2023 18:56:36 +0530
Message-ID: <20230313132636.31850-8-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313132636.31850-1-nipun.gupta@amd.com>
References: <20230313132636.31850-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 79954063-d610-4108-ec84-08db23c6bdf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUAON1QH75MtrM/CxP24ibPQv/Dr5TY8PNz6w+iYkOqWc3ZV7kxjFq32o8kDYfyPFwc6S65XujHs0gdDxX6j//nV6Udl675rWrD1LcCa7inf7/0KVB2/EYSJW8O9AiJFhrabdrPqTxtg4twQRjDMxpf6+qy2scB/0or93NF7+9OslFYz94I5rWQ+Q1x7+oV+IFF9WeHdZ7tZCORcGSgJDoJIAnlbJSMtYJleuXwvTH1LbBYPF+dJDDvqvw+sGnMFr8KDLK87GwbsCnzOw4cEBq3KNbVnUz4wJ3bB2UtTftaeLtpDagY/4DGNaH7KG9ZmTM8Epwn4qVp/o1Qyj/llTkRCt2SXhIgP+AR5riIFCx/MyY6gIJs5phM6vyajS8Wk4689kHqcazxwVqIYh9Dg8vwRBZDkZdhJB8hxk6I1rkpiBQXn27yNHxK1dmEseCYXplCkJUX/tInFAhVX2m3+0L8kc9a8IcozS+UqMWzwMbO5IRPDABUX+NUBEwvWWseduGoVfA3/2zJP8kxOfU40MlYIPuN2cCHgImS68WSQWiE5fPo9NBm4rzKp07pgSrqBcyxJVVEsiihN2spMFF0BC409OjWM1DRSYwvDiLkDfo8wATKrsROaQmmbAO/STzlSjKOZ1SY0y+4KPsN0Z3IudYG4WctwBQ+qTqgyHMH4jKNQRjMsPcrI2tYL++dx+BK67CtQP7414cc1PFKUeA6auNut6z8kfosy5cV0xm1AbYTSZrSTp8tlXcucY1NqfpDx4uZVscGK9dj3kkakusvpC73MWlTlrB1RgshKHsDi43I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(6666004)(83380400001)(82740400003)(110136005)(316002)(81166007)(478600001)(36860700001)(54906003)(82310400005)(40480700001)(8936002)(186003)(8676002)(1076003)(40460700003)(36756003)(26005)(5660300002)(7406005)(426003)(4326008)(7416002)(921005)(356005)(336012)(47076005)(70586007)(70206006)(41300700001)(86362001)(44832011)(2616005)(30864003)(2906002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:27:50.0030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79954063-d610-4108-ec84-08db23c6bdf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cdx |  44 ++++++++
 drivers/cdx/cdx.c                       | 127 ++++++++++++++++++++++++
 drivers/cdx/controller/cdx_controller.c |  18 ++++
 drivers/cdx/controller/mcdi_functions.c |  14 +++
 drivers/cdx/controller/mcdi_functions.h |  11 ++
 include/linux/cdx/cdx_bus.h             |  27 +++++
 6 files changed, 241 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index 43b4e161f226..7af477f49998 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -10,3 +10,47 @@ Description:
 		For example::
 
 		  # echo 1 > /sys/bus/cdx/rescan
+
+What:		/sys/bus/cdx/devices/.../vendor
+Date:		March 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Vendor ID for this CDX device, in hexadecimal. Vendor ID is
+		16 bit identifier which is specific to the device manufacturer.
+		Combination of Vendor ID and Device ID identifies a device.
+
+What:		/sys/bus/cdx/devices/.../device
+Date:		March 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Device ID for this CDX device, in hexadecimal. Device ID is
+		16 bit identifier to identify a device type within the range
+		of a device manufacturer.
+		Combination of Vendor ID and Device ID identifies a device.
+
+What:		/sys/bus/cdx/devices/.../reset
+Date:		March 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Writing y/1/on to this file resets the CDX device.
+		On resetting the device, the corresponding driver is notified
+		twice, once before the device is being reset, and again after
+		the reset has been complete.
+
+		For example::
+
+		  # echo 1 > /sys/bus/cdx/.../reset
+
+What:		/sys/bus/cdx/devices/.../remove
+Date:		March 2023
+Contact:	tarak.reddy@amd.com
+Description:
+		Writing y/1/on to this file removes the corresponding
+		device from the CDX bus. If the device is to be reconfigured
+		reconfigured in the Hardware, the device can be removed, so
+		that the device driver does not access the device while it is
+		being reconfigured.
+
+		For example::
+
+		  # echo 1 > /sys/bus/cdx/devices/.../remove
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 6b162bbb9b25..67c32cb2c006 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -71,6 +71,39 @@
 /* CDX controllers registered with the CDX bus */
 static DEFINE_XARRAY_ALLOC(cdx_controllers);
 
+/**
+ * cdx_dev_reset - Reset a CDX device
+ * @dev: CDX device
+ *
+ * Return: -errno on failure, 0 on success.
+ */
+int cdx_dev_reset(struct device *dev)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config = {0};
+	struct cdx_driver *cdx_drv;
+	int ret;
+
+	cdx_drv = to_cdx_driver(dev->driver);
+	/* Notify driver that device is being reset */
+	if (cdx_drv && cdx_drv->reset_prepare)
+		cdx_drv->reset_prepare(cdx_dev);
+
+	dev_config.type = CDX_DEV_RESET_CONF;
+	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
+				      cdx_dev->dev_num, &dev_config);
+	if (ret)
+		dev_err(dev, "cdx device reset failed\n");
+
+	/* Notify driver that device reset is complete */
+	if (cdx_drv && cdx_drv->reset_done)
+		cdx_drv->reset_done(cdx_dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdx_dev_reset);
+
 /**
  * cdx_unregister_device - Unregister a CDX device
  * @dev: CDX device
@@ -237,6 +270,99 @@ static int cdx_dma_configure(struct device *dev)
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
+	bool val;
+
+	if (kstrtobool(buf, &val) < 0)
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
+	bool val;
+	int ret;
+
+	if (kstrtobool(buf, &val) < 0)
+		return -EINVAL;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = cdx_dev_reset(dev);
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
+	int ret;
+
+	if (WARN_ON(dev->bus != &cdx_bus_type))
+		return -EINVAL;
+
+	ret = driver_set_override(dev, &cdx_dev->driver_override, buf, count);
+	if (ret)
+		return ret;
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
@@ -280,6 +406,7 @@ struct bus_type cdx_bus_type = {
 	.shutdown	= cdx_shutdown,
 	.dma_configure	= cdx_dma_configure,
 	.bus_groups	= cdx_bus_groups,
+	.dev_groups	= cdx_dev_groups,
 };
 EXPORT_SYMBOL_GPL(cdx_bus_type);
 
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index 0d1826980935..dc52f95f8978 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -45,6 +45,23 @@ void cdx_rpmsg_pre_remove(struct cdx_controller *cdx)
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
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static int cdx_scan_devices(struct cdx_controller *cdx)
 {
 	struct cdx_mcdi *cdx_mcdi = cdx->priv;
@@ -104,6 +121,7 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 
 static struct cdx_ops cdx_ops = {
 	.scan		= cdx_scan_devices,
+	.dev_configure	= cdx_configure_device,
 };
 
 static int xlnx_cdx_probe(struct platform_device *pdev)
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 012b52881dd5..0158f26533dd 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -123,3 +123,17 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 
 	return 0;
 }
+
+int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_RESET_IN_LEN);
+	int ret;
+
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_RESET_IN_BUS, bus_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_RESET_IN_DEVICE, dev_num);
+
+	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_RESET, inbuf, sizeof(inbuf),
+			   NULL, 0, NULL);
+
+	return ret;
+}
diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
index 6bf5a4a0778f..7440ace5539a 100644
--- a/drivers/cdx/controller/mcdi_functions.h
+++ b/drivers/cdx/controller/mcdi_functions.h
@@ -47,4 +47,15 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 			    u8 bus_num, u8 dev_num,
 			    struct cdx_dev_params *dev_params);
 
+/**
+ * cdx_mcdi_reset_device - Reset cdx device represented by bus_num:dev_num
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ * @dev_num: Device number.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_reset_device(struct cdx_mcdi *cdx,
+			  u8 bus_num, u8 dev_num);
+
 #endif /* CDX_MCDI_FUNCTIONS_H */
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index d134e0104724..35ef41d8a61a 100644
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
@@ -101,6 +116,8 @@ struct cdx_device {
  * @probe: Function called when a device is added
  * @remove: Function called when a device is removed
  * @shutdown: Function called at shutdown time to quiesce the device
+ * @reset_prepare: Function called before is reset to notify driver
+ * @reset_done: Function called after reset is complete to notify driver
  * @driver_managed_dma: Device driver doesn't use kernel DMA API for DMA.
  *		For most device drivers, no need to care about this flag
  *		as long as all DMAs are handled through the kernel DMA API.
@@ -115,6 +132,8 @@ struct cdx_driver {
 	int (*probe)(struct cdx_device *dev);
 	int (*remove)(struct cdx_device *dev);
 	void (*shutdown)(struct cdx_device *dev);
+	void (*reset_prepare)(struct cdx_device *dev);
+	void (*reset_done)(struct cdx_device *dev);
 	bool driver_managed_dma;
 };
 
@@ -144,4 +163,12 @@ void cdx_driver_unregister(struct cdx_driver *cdx_driver);
 
 extern struct bus_type cdx_bus_type;
 
+/**
+ * cdx_dev_reset - Reset CDX device
+ * @dev: device pointer
+ *
+ * Return: 0 for success, -errno on failure
+ */
+int cdx_dev_reset(struct device *dev);
+
 #endif /* _CDX_BUS_H_ */
-- 
2.17.1

