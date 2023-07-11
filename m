Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C028274EDCE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGKMNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGKMNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:13:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9851AFB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHqSITSkpzJGS9ODmH8C+uJPpw17wHTP/gzpH76hhJDQzsVPD5HX2ysDQ2h/iQXsq37gtcUmfz+/yzyjEg0dfCMCAR4LIphm/O7IZT33Hhhr6wyIDfMoZRSYVZAnPeauOkEVIUTGffeGBiJcSe3abO55aRW6/xKPBcrJtiGDBjMz9G9fvDdURD/EU+v3DufAehJmaR9E1psuIjrs/x9gcppRg4VYurSNa6ibz0YVYj00IB+gfH92VdSSzOGsHf98Tq0DoETYBiZSNeN17p7IyfVtWpi4NL8vhrgnzX/Ox7+7R9wMVlyVclCnoSIh4oTbexU2ZVeUUxpQeHP9+cjwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fqss42PnPP21qEHNgrOdheUbPFGMd7xrLFr/uvzcko4=;
 b=IHB22xM76ATAAE9aryTYRusoNb1Ol/xvnUy6uMtyH5OkX0slPx7bDlxl6BDyMAF0LmOzj1Prk7Whk8IW03VatKAm+d1EitpTDrycAzexdGrL43aGgOGGP0ZfaH22bKBgC9H+l101Ps3i22ervMyMxMeEfsMPQf7c85oiXpk/VX6SA7s385Va9Gd5hOIus6/6tx44GDFsS3mFcJQvT9sjIa1CEd9/AdSFALiUlyb9NYoR7+ueJdIy5nFNuF8IeCMdTRytkY0luUWX3MZI2u7VEY83crZ9jw0g+phYxnSVQxkD4mah1vUj9o1+rCfVl0ALwnEI1lHD9UUo4zCLNKTGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fqss42PnPP21qEHNgrOdheUbPFGMd7xrLFr/uvzcko4=;
 b=QGjE+1Cey7E10rT8DylQ9IP2ryG9zkX7umKAhsUymkT/3TpCIfyl/HxVattC9p+6Rq+wmlpPz5/cpOxV1/YWqcrp8xP4g4zbBD+NiuqVdw3flqX9kix9Wy3AFkWcpab3JjjfimeXjkB/cB8ChkU7yklrf6qMscxmvtGelDUuTKM=
Received: from MW4PR04CA0294.namprd04.prod.outlook.com (2603:10b6:303:89::29)
 by PH0PR12MB7487.namprd12.prod.outlook.com (2603:10b6:510:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 12:12:53 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::3c) by MW4PR04CA0294.outlook.office365.com
 (2603:10b6:303:89::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 12:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Tue, 11 Jul 2023 12:12:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 07:12:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 07:12:14 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 11 Jul 2023 07:12:07 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH 1/4] cdx: add support for bus enable and disable
Date:   Tue, 11 Jul 2023 17:40:24 +0530
Message-ID: <20230711121027.936487-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230711121027.936487-1-abhijit.gangurde@amd.com>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: c09392b5-5899-45ec-6c70-08db8208273e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGS5KMpjmELtKNj91xnP0v7RErXrdc7hwCkEsaQRJpXAbn+EJ8/nVXp/AUhNRUEaab3DlPhdmSuBF63h/wtzk3h7JQobiXIkxpL1/CLzsXgkSN9JJhcQlHGhc26LOyeC1ixlul2O9EXwy/bk2kjV5xEF/ElZQIN5Jr5snitBl6XtfJgTGUuY8TndfAnsKiDuSzegQ6NNvCLmpuT9MJlW7TcdqjgvF1tM+iC9JDCR+Mz6f9czo30HyV0GUKF5ONMunUAqQTmmZKe25K7tMxrk2RaIGcUlZ9FIGfYdaQK9iOjqb1x1E/4NbGVBStiB1uEe7siKOl4+X6WQ2MCEf/x0Mqbxr3t4IBQkqeRr87/XtUTDS8kQEPdaGxx6vIyw5YDUPbyqtjkfleIiUHnbC2IF+bQCzLLEQKugAaN8DhdgO4cY3mEvUaIx17kF3fGWP0ymZPEqYoLGZPXx4+7ZKZ/r8XRSs/9xKvziFBhxmz3Bt8NcvO3yHH8RF+3bOi+XzHuvzxAxqdm0OTSb8ZLsAu0TE+tuW+x6rv1tnbvm3oO6UKug3Yt4ARkBtTYFwYpPMURe1aBRBkD611Lvnau+MH7VX6g8nK/o4Medo1ge/OSxuMliXnfD47CqLlwRG31jq/n8n1Ar7lLhFuZ3mhUMCLZefD/Rv1t2Z1TUNpHFEN/oaf7pmkB1/khrdMmjTc6t+KZn2TwiRdR+ik7gyFn8B6mQ4JxcHwBd8If/EH7zP+UiojsRb4ivmFYBEB+MirvLfXBWEBmvGzV4iVviTpnKDZ3L4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(2616005)(426003)(47076005)(8936002)(8676002)(6666004)(478600001)(30864003)(54906003)(2906002)(40460700003)(110136005)(82740400003)(40480700001)(36860700001)(316002)(4326008)(83380400001)(36756003)(44832011)(70206006)(70586007)(356005)(86362001)(5660300002)(82310400005)(26005)(81166007)(1076003)(336012)(186003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:12:52.8902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c09392b5-5899-45ec-6c70-08db8208273e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CDX bus needs to be disabled before updating/writing devices
in the FPGA. Once the devices are written, the bus shall be
enabled. This change provides sysfs entry to enable/disable the
CDX bus.

Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cdx | 11 +++++
 drivers/cdx/cdx.c                       | 26 ++++++++++++
 drivers/cdx/controller/cdx_controller.c | 27 +++++++++++++
 drivers/cdx/controller/mc_cdx_pcol.h    | 54 +++++++++++++++++++++++++
 drivers/cdx/controller/mcdi_functions.c | 24 +++++++++++
 drivers/cdx/controller/mcdi_functions.h | 16 ++++++++
 include/linux/cdx/cdx_bus.h             |  6 +++
 7 files changed, 164 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index 7af477f49998..0afa85b3c63b 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -11,6 +11,17 @@ Description:
 
 		  # echo 1 > /sys/bus/cdx/rescan
 
+What:		/sys/bus/cdx/enable
+Date:		July 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Writing y/1/on to this file enables the CDX bus and
+		writing n/0/off disables the bus.
+
+		For example to disable CDX bus::
+
+		  # echo 0 > /sys/bus/cdx/enable
+
 What:		/sys/bus/cdx/devices/.../vendor
 Date:		March 2023
 Contact:	nipun.gupta@amd.com
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d2cad4c670a0..48c493a43491 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -380,6 +380,30 @@ static struct attribute *cdx_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cdx_dev);
 
+static ssize_t enable_store(const struct bus_type *bus,
+			    const char *buf, size_t count)
+{
+	struct cdx_controller *cdx;
+	unsigned long index;
+	bool enable;
+	int ret;
+
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
+	xa_for_each(&cdx_controllers, index, cdx) {
+		if (cdx->enabled == enable)
+			continue;
+
+		ret = cdx->ops->enable(cdx, enable);
+		if (ret)
+			dev_err(cdx->dev, "cdx bus enable/disable failed\n");
+	}
+
+	return count;
+}
+static BUS_ATTR_WO(enable);
+
 static ssize_t rescan_store(const struct bus_type *bus,
 			    const char *buf, size_t count)
 {
@@ -410,6 +434,7 @@ static ssize_t rescan_store(const struct bus_type *bus,
 static BUS_ATTR_WO(rescan);
 
 static struct attribute *cdx_bus_attrs[] = {
+	&bus_attr_enable.attr,
 	&bus_attr_rescan.attr,
 	NULL,
 };
@@ -541,6 +566,7 @@ void cdx_unregister_controller(struct cdx_controller *cdx)
 	if (cdx->id >= MAX_CDX_CONTROLLERS)
 		return;
 
+	cdx->ops->enable(cdx, false);
 	device_for_each_child(cdx->dev, NULL, cdx_unregister_device);
 	xa_erase(&cdx_controllers, cdx->id);
 }
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index dc52f95f8978..ac8081f23cbe 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -45,6 +45,21 @@ void cdx_rpmsg_pre_remove(struct cdx_controller *cdx)
 	cdx_mcdi_wait_for_quiescence(cdx->priv, MCDI_RPC_TIMEOUT);
 }
 
+static int cdx_bus_enable(struct cdx_controller *cdx, bool enable)
+{
+	int ret;
+
+	if (enable)
+		ret = cdx_mcdi_bus_enable(cdx->priv);
+	else
+		ret = cdx_mcdi_bus_disable(cdx->priv);
+
+	if (!ret)
+		cdx->enabled = enable;
+
+	return ret;
+}
+
 static int cdx_configure_device(struct cdx_controller *cdx,
 				u8 bus_num, u8 dev_num,
 				struct cdx_device_config *dev_config)
@@ -80,11 +95,22 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 	for (bus_num = 0; bus_num < num_cdx_bus; bus_num++) {
 		u8 num_cdx_dev;
 
+		ret = cdx_mcdi_bus_enable(cdx_mcdi);
+		if (ret && ret != -EALREADY) {
+			dev_err(cdx->dev,
+				"CDX bus %d enable failed: %d\n", bus_num, ret);
+			continue;
+		}
+
 		/* MCDI FW Read: Fetch the number of devices present */
 		ret = cdx_mcdi_get_num_devs(cdx_mcdi, bus_num);
 		if (ret < 0) {
 			dev_err(cdx->dev,
 				"Get devices on CDX bus %d failed: %d\n", bus_num, ret);
+			ret = cdx_mcdi_bus_disable(cdx_mcdi);
+			if (ret)
+				dev_err(cdx->dev,
+					"CDX bus %d disable failed: %d\n", bus_num, ret);
 			continue;
 		}
 		num_cdx_dev = (u8)ret;
@@ -120,6 +146,7 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 }
 
 static struct cdx_ops cdx_ops = {
+	.enable		= cdx_bus_enable,
 	.scan		= cdx_scan_devices,
 	.dev_configure	= cdx_configure_device,
 };
diff --git a/drivers/cdx/controller/mc_cdx_pcol.h b/drivers/cdx/controller/mc_cdx_pcol.h
index 4ccb7b52951b..2de019406b57 100644
--- a/drivers/cdx/controller/mc_cdx_pcol.h
+++ b/drivers/cdx/controller/mc_cdx_pcol.h
@@ -455,6 +455,60 @@
 #define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID_OFST			84
 #define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID_LEN			4
 
+/***********************************/
+/*
+ * MC_CMD_CDX_BUS_DOWN
+ * Asserting reset on the CDX bus causes all devices on the bus to be quiesced.
+ * DMA bus mastering is disabled and any pending DMA request are flushed. Once
+ * the response is returned, the devices are guaranteed to no longer issue DMA
+ * requests or raise MSI interrupts. Further device MMIO accesses may have
+ * undefined results. While the bus reset is asserted, any of the enumeration
+ * or device configuration MCDIs will fail with EAGAIN. It is only legal to
+ * reload the relevant PL region containing CDX devices if the corresponding CDX
+ * bus is in reset. Depending on the implementation, the firmware may or may
+ * not enforce this restriction and it is up to the caller to make sure this
+ * requirement is satisfied.
+ */
+#define MC_CMD_CDX_BUS_DOWN					0x4
+#define MC_CMD_CDX_BUS_DOWN_MSGSET			0x4
+
+/* MC_CMD_CDX_BUS_DOWN_IN msgrequest */
+#define MC_CMD_CDX_BUS_DOWN_IN_LEN			4
+/* Bus number to put in reset, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_BUS_DOWN_IN_BUS_OFST		0
+#define MC_CMD_CDX_BUS_DOWN_IN_BUS_LEN		4
+
+/*
+ * MC_CMD_CDX_BUS_DOWN_OUT msgresponse: The bus is quiesced, no further
+ * upstream traffic for devices on this bus.
+ */
+#define MC_CMD_CDX_BUS_DOWN_OUT_LEN			0
+
+/***********************************/
+/*
+ * MC_CMD_CDX_BUS_UP
+ * After bus reset is de-asserted, devices are in a state which is functionally
+ * equivalent to each device having been reset with MC_CMD_CDX_DEVICE_RESET. In
+ * other words, device logic is reset in a hardware-specific way, MMIO accesses
+ * are forwarded to the device, DMA bus mastering is disabled and needs to be
+ * re-enabled with MC_CMD_CDX_DEVICE_DMA_ENABLE once the driver is ready to
+ * start servicing DMA. If the underlying number of devices or device resources
+ * changed (e.g. if PL was reloaded) while the bus was in reset, the bus driver
+ * is expected to re-enumerate the bus. Returns EALREADY if the bus was already
+ * up before the call.
+ */
+#define MC_CMD_CDX_BUS_UP					0x5
+#define MC_CMD_CDX_BUS_UP_MSGSET			0x5
+
+/* MC_CMD_CDX_BUS_UP_IN msgrequest */
+#define MC_CMD_CDX_BUS_UP_IN_LEN			4
+/* Bus number to take out of reset, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_BUS_UP_IN_BUS_OFST		0
+#define MC_CMD_CDX_BUS_UP_IN_BUS_LEN		4
+
+/* MC_CMD_CDX_BUS_UP_OUT msgresponse: The bus can now be enumerated. */
+#define MC_CMD_CDX_BUS_UP_OUT_LEN			0
+
 /***********************************/
 /*
  * MC_CMD_CDX_DEVICE_RESET
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 0158f26533dd..400fdc771104 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -124,6 +124,30 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 	return 0;
 }
 
+int cdx_mcdi_bus_enable(struct cdx_mcdi *cdx)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_BUS_UP_IN_LEN);
+	int ret;
+
+	MCDI_SET_DWORD(inbuf, CDX_BUS_UP_IN_BUS, 0);
+	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_BUS_UP, inbuf, sizeof(inbuf),
+			   NULL, 0, NULL);
+
+	return ret;
+}
+
+int cdx_mcdi_bus_disable(struct cdx_mcdi *cdx)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_BUS_DOWN_IN_LEN);
+	int ret;
+
+	MCDI_SET_DWORD(inbuf, CDX_BUS_DOWN_IN_BUS, 0);
+	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_BUS_DOWN, inbuf, sizeof(inbuf),
+			   NULL, 0, NULL);
+
+	return ret;
+}
+
 int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_RESET_IN_LEN);
diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
index 7440ace5539a..6d26b7cdc07c 100644
--- a/drivers/cdx/controller/mcdi_functions.h
+++ b/drivers/cdx/controller/mcdi_functions.h
@@ -47,6 +47,22 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 			    u8 bus_num, u8 dev_num,
 			    struct cdx_dev_params *dev_params);
 
+/**
+ * cdx_mcdi_bus_enable - Enable CDX bus represented by bus_num
+ * @cdx: pointer to MCDI interface.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_bus_enable(struct cdx_mcdi *cdx);
+
+/**
+ * cdx_mcdi_bus_disable - Disable CDX bus represented by bus_num
+ * @cdx: pointer to MCDI interface.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_bus_disable(struct cdx_mcdi *cdx);
+
 /**
  * cdx_mcdi_reset_device - Reset cdx device represented by bus_num:dev_num
  * @cdx: pointer to MCDI interface.
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index bead71b7bc73..5da0634ae4ee 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -28,6 +28,8 @@ struct cdx_device_config {
 	u8 type;
 };
 
+typedef int (*cdx_bus_enable_cb)(struct cdx_controller *cdx, bool enable);
+
 typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
 
 typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
@@ -49,11 +51,13 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
 
 /**
  * struct cdx_ops - Callbacks supported by CDX controller.
+ * @enable: enable or disable bus on the controller
  * @scan: scan the devices on the controller
  * @dev_configure: configuration like reset, master_enable,
  *		   msi_config etc for a CDX device
  */
 struct cdx_ops {
+	cdx_bus_enable_cb enable;
 	cdx_scan_cb scan;
 	cdx_dev_configure_cb dev_configure;
 };
@@ -63,12 +67,14 @@ struct cdx_ops {
  * @dev: Linux device associated with the CDX controller.
  * @priv: private data
  * @id: Controller ID
+ * @enabled: state enabled/disabled
  * @ops: CDX controller ops
  */
 struct cdx_controller {
 	struct device *dev;
 	void *priv;
 	u32 id;
+	bool enabled;
 	struct cdx_ops *ops;
 };
 
-- 
2.25.1

