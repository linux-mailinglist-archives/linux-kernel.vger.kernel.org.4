Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C8D69AC89
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBQNao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjBQNai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:30:38 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7C6ABEC;
        Fri, 17 Feb 2023 05:30:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYI69g++JPutfRqs6ANILHOeBMK+yagysCvTDz7puEa9WrNJ8d6N8YBGpzYOUM2s8/J9Ky+my1xMd0jiIzdxOCpaNI0C8RUR8yoxR9k+Sli/ZTmtdQ//xiHZAyva7Ap589Ukn30lemQlf9VB4j6uFhcuLO1e3mhGzjPqVX7H2odj7juEo0Bx1mUvuJt7g3Q0sjzucAMDdCLwketcWqf+Kv1N0Cac2yvx0Z3hkT6vWTgMhN5zHvdqM9/fJFZIoM4aNfeL1cJp1PHol6ZTdrlrh7WFe6/5xk2UdufXSuCt7GPOoOdX5Vdo0eTvsVdqxIfDf6AK87W1J3VjY6CYTl8alQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nAHv5AQNHML83sq3wE3zw/0b9wKsNHCoupUmFUUxZk=;
 b=eV6xAMlESWrd8VRb4ozdnNfSAdBvqSkNbfaHNqqhN7hm2tCBnMPs3keSRo1YZWpr6/YZzBtsquD273dVgnwt7Dcoi7MRg3N+GbHj1s91V3WFt1rSSdOGSavswDfRZylbNxdQGuNmzG2xZM8xjv1Wzmo+S3PbppAgQk3OcN81VOKl97AxgQ+xGhofxOd9Y3XrKwfI7420cRR0y2fWA/lJ/ofKLsy+LFwDcUOnpnKR0pknzD24lEFQfBf2UV5Ej+ftsFmm3/uDoTI+0PUCEMdVjS1PtYm4VU25pdwel4rr2XOd6Pyw6pnODCWdcpDPS4yAxKQq0aVB/7LTLESqokSl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nAHv5AQNHML83sq3wE3zw/0b9wKsNHCoupUmFUUxZk=;
 b=FJaTVrkxGhh0egyv+QBeKnSmWo8leeuuBEoclvu8PJ9Ux3NrLCvLeDaBRuqb7CthwBkbZcRTw9Wgc84Ee76JMNjq2eDMYoo8M9AF4e7eUQTxyWfG2dHgz7tmd7PAGzQvtGW/AJESEtMaAMnWAf9tsYUSOJB8omQ6/69v8lZTYNs=
Received: from MW4PR04CA0031.namprd04.prod.outlook.com (2603:10b6:303:6a::6)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 13:29:46 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::a7) by MW4PR04CA0031.outlook.office365.com
 (2603:10b6:303:6a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15 via Frontend
 Transport; Fri, 17 Feb 2023 13:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.13 via Frontend Transport; Fri, 17 Feb 2023 13:29:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 07:29:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 05:29:44 -0800
Received: from xhdipdslab49.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Feb 2023 07:29:35 -0600
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v8 7/7] cdx: add device attributes
Date:   Fri, 17 Feb 2023 18:58:30 +0530
Message-ID: <20230217132830.3140439-8-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230217132830.3140439-1-nipun.gupta@amd.com>
References: <20230217132830.3140439-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 558f4d61-6005-4ae7-75f9-08db10eb093d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELOE0sVHD+cMhFGq8Hf6vszlC55CwTeXlbrQ/pH1cVyRnEiIu+Sg5cYdRIesycF8DmKQ0oJSL1KgDQvm81GUOvsOKW61gXePYBDjF66X/SaFt1UHPMoThp2AVF157PdpaXt05JbCPfnH42T3Ly/aYh8EQ+HQAbM2q2qjsJ4yL9aP2pG7ikGMXhAAzGxILKxbiU/SVCb1J5RrtAV6Hzob6vBLm3B+BFDzRhiOOUACBm6LmHQ//XTKbbZ1zk7s5o++SoHHgXfLoF/zlIKclXc2RkjRtToLt++J/WmxmMywuGXQbvqLqIu2q57b3NJvNwB8SkWrFUSJ8/8Yx350hs9W/5OdkWZnuYy0TAWx0WfhSjuu6wofdf6PBAmV4gSxrXYRyJ3gmFnyHFS05s45I/2kHHIRYH/wgrFc9WLaLuZh4z+oFHiQgQl1JizsFF7Bw2Lvd+FKFxsG/I5ML8xZ70/EVXYqZ/Xr7KvacfaWlzBvw4ZIh0EIb6y0OgekOzcJOML3mb2+GkEcRExZPeCC424XuDS82gFx87vQLhAG/bJ/iWnlKg59u2pkXYlyCrtwHOoznmCdJ56uVrGMf1RHEPw8ZnEN7aFKysSNsoTJp6cwJhpSm9CQHiAsHmo5bqkExUcusemdNGTEkaAR0lqWQ1EJcfaxGzGquVV1NgIwQOKot6fjQc+MryryOHSCBqNH1PPk97YHT+KBHDjr9+ynO6+VMqR80uIvJk0y0CcyacVUguz1XzSlbWOvQx31/2Rydo1TgsngF+7r9cl2zDVgIhZ+s5syk0ADpHK4vhP+jKqF3VY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(81166007)(47076005)(86362001)(2616005)(336012)(426003)(83380400001)(5660300002)(41300700001)(36860700001)(30864003)(44832011)(40480700001)(36756003)(70206006)(70586007)(4326008)(82310400005)(8676002)(110136005)(316002)(54906003)(40460700003)(478600001)(7416002)(8936002)(2906002)(921005)(356005)(26005)(82740400003)(1076003)(186003)(6666004)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 13:29:46.0032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 558f4d61-6005-4ae7-75f9-08db10eb093d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cdx |  44 +++++++
 drivers/cdx/cdx.c                       | 145 ++++++++++++++++++++++++
 drivers/cdx/controller/cdx_controller.c |  19 ++++
 drivers/cdx/controller/mcdi_functions.c |  14 +++
 drivers/cdx/controller/mcdi_functions.h |  11 ++
 include/linux/cdx/cdx_bus.h             |  27 +++++
 6 files changed, 260 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index b55248964c9a..ca5a4394286e 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -10,3 +10,47 @@ Description:
 		For example::
 
 		  # echo 1 > /sys/bus/cdx/rescan
+
+What:		/sys/bus/cdx/devices/.../vendor
+Date:		February 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Vendor ID for this CDX device. Vendor ID is 16 bit
+		identifier which is specific to the device manufacturer.
+		Combination of Vendor ID and Device ID identifies a device.
+
+What:		/sys/bus/cdx/devices/.../device
+Date:		February 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Device ID for this CDX device. Device ID is a 16 bit
+		identifier to identify a device type within the range
+		of a device manufacturer.
+		Combination of Vendor ID and Device ID identifies a device.
+
+What:		/sys/bus/cdx/devices/.../reset
+Date:		February 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Writing a non-zero value to this file resets the CDX device.
+		On resetting the device, the corresponding driver is notified
+		twice, once before the device is being reset, and again after
+		the reset has been complete.
+
+		For example::
+
+		  # echo 1 > /sys/bus/cdx/.../reset
+
+What:		/sys/bus/cdx/devices/.../remove
+Date:		February 2023
+Contact:	tarak.reddy@amd.com
+Description:
+		Writing a non-zero value to this file removes the corresponding
+		device from the CDX bus. If the device is to be reconfigured
+		reconfigured in the Hardware, the device can be removed, so
+		that the device driver does not access the device while it is
+		being reconfigured.
+
+		For example::
+
+		  # echo 1 > /sys/bus/cdx/devices/.../remove
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 795770522b01..a5b79e04a8d3 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -72,6 +72,39 @@
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
+	struct cdx_device_config dev_config;
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
@@ -238,6 +271,117 @@ static int cdx_dma_configure(struct device *dev)
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
@@ -280,6 +424,7 @@ struct bus_type cdx_bus_type = {
 	.shutdown	= cdx_shutdown,
 	.dma_configure	= cdx_dma_configure,
 	.bus_groups	= cdx_bus_groups,
+	.dev_groups	= cdx_dev_groups,
 };
 EXPORT_SYMBOL_GPL(cdx_bus_type);
 
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index c40027cc38aa..e442ea9d0b32 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -44,6 +44,24 @@ void cdx_rpmsg_pre_remove(struct cdx_controller *cdx)
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
@@ -103,6 +121,7 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 
 static struct cdx_ops cdx_ops = {
 	.scan		= cdx_scan_devices,
+	.dev_configure	= cdx_configure_device,
 };
 
 static int xlnx_cdx_probe(struct platform_device *pdev)
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 3940a2c7919c..673b3896411e 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
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
2.25.1

