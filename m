Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F236DDFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDKPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDKPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:40:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FA3110;
        Tue, 11 Apr 2023 08:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXf330kAeeDKvuPUDxpFF88+ffv3e9H517v59fxYqkiNu1FVGXkAZF6VhzUgNIS/9Cz7g1wD0ZfCLpXAIj2GWX8PiXRBA3FhHtImq8PgiD7q6YpCYMgHdLBUYi7tdcfi3UN1WYFiRt88Fhvez5cSD9d9oACAd9FxRRByfkk37Kj6lLK4zQGyOaByM3cJrLkxMEL7zII24o2x1NTkJrvChry9hdInfqIawCqSk5Pm8kT0LdVMYILChDFEDj8FMWMzVXXLd1pPX/eBSKgCQDlu6ZF2HufbMD+5Fd1qtkFX+Bjn/M6y2mer2OeJ3kOAOuX+Wxk2bylHF49UNZrNaADCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opKMEUV0edBwiV7K40XiGLU11yRhYXmLOrOnnD2ZdG4=;
 b=JteYPEZevkw+zJbHPV3feuFffenxX8y3ViQEp35AGdEKMRADM0ujPHpO/PX3hsbB75JBW3ySMFHBeIIDNc/PlZuXKv5MNycRSHLlzqRMQKotAekeh3+MHjI9zcRNvXjdlTbuXeB0mJtJ457QERMCP5PfPLtNLNz2EMNyMObERFdjM4GTZqFUcyUIKWzw2uM9PLUy4X/fCoc3GB4XSMJOYOaL+MKIQflhK8FCWSa9qRP2Pr7uY7PhnnMqzfEZsBf1apmpiJMcK4lB0wINv7NHsZAKVftvt//7nqSVBbK8QnWTccFhMWcA/jB1dnWnU5GxFYgtp5FdcghFBJrSBakbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opKMEUV0edBwiV7K40XiGLU11yRhYXmLOrOnnD2ZdG4=;
 b=STvMfLNCc16XAasCx97pWl3dKGPgElxiNTAy2vk/jbuGANJ77n2v0Ng+9GrkCGGvtrCI78A7QfBIhO7NC+Jy7u2YPBpFWAqNyzhUIj/UU4BfgKNlvIxvB41FEOUMVv9vmqgO5JdjpvSDfzaljfUznjW7z4xb3eQSSD4En7aa0/X+Y4CwLY3Y4/KJeefRycRoJwa+HpqSquSsFwnqeFud88/ff+trQyO7PwG3xnxQrCxj+aLopbMg9vLHFZErW6ulLRa+sBj11RZsjfZHsbBdQgr1rLa7MI/GqiUmCx2e3AGhGynG4BGilq6PAp3FgzQhlvtageSF6M8iFxP8yxvuwQ==
Received: from BN9PR03CA0618.namprd03.prod.outlook.com (2603:10b6:408:106::23)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 15:40:06 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::64) by BN9PR03CA0618.outlook.office365.com
 (2603:10b6:408:106::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Tue, 11 Apr 2023 15:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 15:40:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 08:39:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Apr
 2023 08:39:52 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 11 Apr
 2023 08:39:52 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Liming Sun <limings@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mlxbf-bootctl: Add sysfs file for BlueField boot fifo
Date:   Tue, 11 Apr 2023 11:39:42 -0400
Message-ID: <52b0b00dacbc4aad3169dd3667d79c85e334783b.1680657571.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|PH0PR12MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d92e50-1f79-4649-1b53-08db3aa3066a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cbwtq/TUUGDqIsrC/EHmJx0hEB7YriMChOMK+evxS9NoEvLAnZic6TaRcb31XoVKUJJvFQkprS+Kob0rGfNRHBRKW6xYOJmcDPy9sjww4oj2NAx0BwpxmcfNzFXQHLGVQ8WNDO0J83mnMgOQcUUEYR6BHCXWIS+ZU0p3cn04+yZsuBfKpdqsAQ0pyAQmbhWAj3SNoeWCAbr8VKhLH1rTNpC5p/sAstLtXWuWXN8/MpXki3ICccHEEykdtRpbdIijp4OzqWDgvh82dk1zb0fXZzHXIh7OINwLAl41WU5GjsMolZw7tcfhJVjfcaZbKZB9Z3chNQv22mINX8+GPdaezXitXcC4gHVnPH3sjkq87p5Ed+vIWhgv/XeiBjOI0RbLA3FHdDeIJdUMcEb9xPvUQNnx32wPFaBceMRLas6eELwq7QrQsjrd5OmiOOHPDWBAqV+XH+sM4tdw4kdiUEDK2AMUj74mPLA8C1kADFmG7EZLmj+H06s0qkvyCOEGckrGyKFVMh5pRLooK78FupSey1nhwWtmTnYJmBphxYJSWq6/mr7EB8R7F1xB8be2z9lCvbFlCjsaTJyDnXaxselNiJTs3AShcRXrRNMlIWgVl+ReEqEwDQ2+JDC+XDCv9YFs5sK5hiZSiIbJV5f+dGkk8OeTvxfay1NMxbzzw4f5TQac5QRfafxSTaeDf7GP5KHQXZU8mXS7UbvLzWw8yh8qxNeJDvZk9eDsdnLtLxpAlIPClVZ36Tp8x1xxAMy4OUmU
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(36756003)(70586007)(54906003)(110136005)(41300700001)(316002)(8676002)(7696005)(4326008)(478600001)(70206006)(426003)(5660300002)(36860700001)(40480700001)(82310400005)(8936002)(47076005)(186003)(356005)(7636003)(82740400003)(6666004)(26005)(336012)(2616005)(2906002)(83380400001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 15:40:06.2723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d92e50-1f79-4649-1b53-08db3aa3066a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds sysfs file for BlueField boot fifo. The boot
fifo is usually used to push boot stream via USB or PCIe. Once
OS is up, it can be reused by applications to read data or
configuration from external host.

Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 .../testing/sysfs-platform-mellanox-bootctl   |  7 ++
 drivers/platform/mellanox/mlxbf-bootctl.c     | 68 +++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
index e79ca22e2f45..9b99a81babb1 100644
--- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
@@ -68,3 +68,10 @@ Description:
 		Wasted   burnt and invalid
 		Invalid  not burnt but marked as valid (error state).
 		=======  ===============================================
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/bootfifo
+Date:		Apr 2023
+KernelVersion:	6.4
+Contact:	"Liming Sun <limings@nvidia.com>"
+Description:
+		The file used to access the BlueField boot fifo.
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 1c7a288b59a5..d4463bb632e1 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
@@ -44,6 +45,10 @@ static const char * const mlxbf_bootctl_lifecycle_states[] = {
 	[3] = "RMA",
 };
 
+/* Mapped pointer for RSH_BOOT_FIFO_DATA and RSH_BOOT_FIFO_COUNT register. */
+static void __iomem *mlxbf_rsh_boot_data;
+static void __iomem *mlxbf_rsh_boot_cnt;
+
 /* ARM SMC call which is atomic and no need for lock. */
 static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
 {
@@ -268,6 +273,45 @@ static const struct acpi_device_id mlxbf_bootctl_acpi_ids[] = {
 
 MODULE_DEVICE_TABLE(acpi, mlxbf_bootctl_acpi_ids);
 
+static ssize_t mlxbf_bootctl_bootfifo_read(struct file *filp,
+					   struct kobject *kobj,
+					   struct bin_attribute *bin_attr,
+					   char *buf, loff_t pos,
+					   size_t count)
+{
+	unsigned long timeout = msecs_to_jiffies(500);
+	unsigned long expire = jiffies + timeout;
+	u64 data, cnt = 0;
+	char *p = buf;
+
+	while (count >= sizeof(data)) {
+		/* Give up reading if no more data within 500ms. */
+		if (!cnt) {
+			cnt = readq(mlxbf_rsh_boot_cnt);
+			if (!cnt) {
+				if (time_after(jiffies, expire))
+					break;
+				usleep_range(10, 50);
+				continue;
+			}
+		}
+
+		data = readq(mlxbf_rsh_boot_data);
+		memcpy(p, &data, sizeof(data));
+		count -= sizeof(data);
+		p += sizeof(data);
+		cnt--;
+		expire = jiffies + timeout;
+	}
+
+	return p - buf;
+}
+
+static struct bin_attribute mlxbf_bootctl_bootfifo_sysfs_attr = {
+	.attr = { .name = "bootfifo", .mode = 0400 },
+	.read = mlxbf_bootctl_bootfifo_read,
+};
+
 static bool mlxbf_bootctl_guid_match(const guid_t *guid,
 				     const struct arm_smccc_res *res)
 {
@@ -285,6 +329,16 @@ static int mlxbf_bootctl_probe(struct platform_device *pdev)
 	guid_t guid;
 	int ret;
 
+	/* Get the resource of the bootfifo data register. */
+	mlxbf_rsh_boot_data = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mlxbf_rsh_boot_data))
+		return PTR_ERR(mlxbf_rsh_boot_data);
+
+	/* Get the resource of the bootfifo counter register. */
+	mlxbf_rsh_boot_cnt = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(mlxbf_rsh_boot_cnt))
+		return PTR_ERR(mlxbf_rsh_boot_cnt);
+
 	/* Ensure we have the UUID we expect for this service. */
 	arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &res);
 	guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);
@@ -302,11 +356,25 @@ static int mlxbf_bootctl_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(&pdev->dev, "Unable to reset the EMMC boot mode\n");
 
+	ret = sysfs_create_bin_file(&pdev->dev.kobj,
+				    &mlxbf_bootctl_bootfifo_sysfs_attr);
+	if (ret)
+		pr_err("Unable to create bootfifo sysfs file, error %d\n", ret);
+
+	return ret;
+}
+
+static int mlxbf_bootctl_remove(struct platform_device *pdev)
+{
+	sysfs_remove_bin_file(&pdev->dev.kobj,
+			      &mlxbf_bootctl_bootfifo_sysfs_attr);
+
 	return 0;
 }
 
 static struct platform_driver mlxbf_bootctl_driver = {
 	.probe = mlxbf_bootctl_probe,
+	.remove = mlxbf_bootctl_remove,
 	.driver = {
 		.name = "mlxbf-bootctl",
 		.dev_groups = mlxbf_bootctl_groups,
-- 
2.30.1

