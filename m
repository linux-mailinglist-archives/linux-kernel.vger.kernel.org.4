Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB096FDD37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjEJLzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjEJLzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:55:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6561725;
        Wed, 10 May 2023 04:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpRo9GZiFB1YvXsup+Sb+cNWdnjvUllL+jwQ05mcaK9YZwqaFQizNVmQ5d89FyrH6f/trJvc4jjOIvGX1At3wyJsdXfcFHd0MPzu8pbR/iW27ERxZwj3Zs8rs4i79WqVoLajCkY+BGg5/HoZjyiUFQsgCQk//aTYNqKVGbDy1XnbXR8mtoC67js8D1Fl4WIWnKeUgmDrF75UX/AotoSU9yju1FMgDeDrXCk7FleSiQFkSIuOVfDdyWtzTsjWsP6NILzbm9Mbimq9satbpI6iMBYWp5WtJu2yrX2+ZhHviV3IYf4BWOcQ0sgVEd2TE5Go2XJDhh6ZJCeWEq06/YvrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4qpuaQmAGLhOj2SeOkgX8cknR2ZiiWM9f9dGqXITk4=;
 b=cBRs06YsMfYL57OPTpjlpqsVnWYlNrsYcTJ4ZAJtMrzkhyY4UzjMIIVQ/l8KK6DetiZyy4yJLXdgIoI0dl5NLG7Y8nbS1Ff5KZCiuBwxNAQfnqP5FaDrDiA8spnLriE/Cunxe8BkdqeuLmVs9QpBRL3+b09R85rUp7ocfdakYHS5tWbu6s5TuvkceAnfuE0ijpOYHZb31nAZW5BCpriVFfWagexwl9/L4o8J8Sh610uFGJUbCo/4WuCPCwDKfcJ9Xd0/7LmEpQF4KTxclmDflc3jW10TZ8SPT7D0kNwdroK0V1lSzvl4uHjHLeUnCEfQlvm16hMq9LRTpn3rI6HmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4qpuaQmAGLhOj2SeOkgX8cknR2ZiiWM9f9dGqXITk4=;
 b=hnlwhjz6OiGLpoDDNr9jqw2p3NFtBzT6+8f5JXi73LmdBBm8sWmzKW79oZKLX8KWsztquABXeJdMX0M+BIohhno79a9R5zCmF7fTd5Ay2hrLuG0mWd3u71x/vfl+1EaCtWzgw5/x7TX/Y3lefV/VEG1giJG+ghU6bRRDqHSvmBeGhfjyJ3k3S6JGAt9nC5TBii2ok+wCUaqXlO20Spz/rcZYKChl1Wa4wehGliKK6nncBj0dv14/binxE/rBPQFlR0pbje42AaxsPdYnBC569PbgGU/2nFkEdqTyy/sDzJMuC4ZQT+ZHpWEPgpYb2tfpjW6/g0OF//GrIwIHBbYUHg==
Received: from DS7PR03CA0221.namprd03.prod.outlook.com (2603:10b6:5:3ba::16)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 11:54:57 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::16) by DS7PR03CA0221.outlook.office365.com
 (2603:10b6:5:3ba::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 11:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 11:54:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 04:54:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 04:54:39 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 10 May
 2023 04:54:38 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Liming Sun <limings@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot log
Date:   Wed, 10 May 2023 07:54:34 -0400
Message-ID: <20230510115434.50166-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <1f778872d177146336318cf856a2c0b06870b1b7.1683568762.git.limings@nvidia.com>
References: <1f778872d177146336318cf856a2c0b06870b1b7.1683568762.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 421cd2ae-b44c-4310-cee4-08db514d6067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iGTRPsRvEtmg7e1IqfyqIYdig09z8mBRaeuXX3gNQv5wDV8eaWf5Dyv6zPE3FG6sBJWkJDh1PRfPDkdVhy7+GWryRtAlN6ZP2tSW1589ukK/6N2xxnu9RIPDmaDpwX7lCuCxGHSCmekvKZkTRvQ1RvyHyTwK/bc3evd230ywiY/da+K/5EsVnfl13BicQJXCjVmonDldrikUzKdTn39k0boJc8L02A9EP01TgV78JYjvrMpNXxrG/ReAjbUWHy2ZoXxI3m8OSKV33VouWdFzUyfe3p5h/BhmwQu41WVg9iLIIGzp2mgoYB8icvDpIPt4yHCMqFUDCbUtUmBKbV0yDRZUoYpn5h/Ld3oRKvhb8uuKJUFL/MsbSSXL5Y3llBs4OJhr/Ocye+u2GRVm8JZ1e8C3lvWVuy5qZz865kk5fGcRk+dPy9g3QRQRtPuXu4w8RTOLMdBmuIvLV9qLjaIvniL5Efa2LwcvGFGhFFsaeqbLuUsq7XtsVJoHr28OWCBw5vwBgtDn0T18l21KlDZzMUKrFU7BfdfeWQ3Pr51rYiqyQSpzUiVu2FkH25mo7KsUT9+R2c25cz9sdlkW9sGzmIADjXAQDwoE/nE9r9V8khJIl2X24OVo2pedvp9VmCr+twp6bB3HlhVd5FNIhWWwHFpZ7sUS42fszQ0ssD1XM3aA/aFp9YqUFJ4NOWkYaE9rP8ZlQF8osQF9+Wyqv6tWZ/m+lQoXu8YV5j3Kkt8kbkbW1ApqSSwK33ji2H32VLS
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(2906002)(82740400003)(7636003)(36756003)(356005)(1076003)(26005)(40460700003)(478600001)(186003)(40480700001)(36860700001)(5660300002)(7696005)(6666004)(82310400005)(4326008)(47076005)(2616005)(41300700001)(426003)(316002)(336012)(83380400001)(110136005)(8676002)(8936002)(54906003)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:54:57.3398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421cd2ae-b44c-4310-cee4-08db514d6067
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds sysfs interface to be used to write into the
boot log which is 1KB HW buffer on BlueField SoC. The same log
buffer is also used by firmware code like ATF/UEFI, and can be
displayed by userspace tools or from external host via USB/PCIe.

Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
---
v1->v2:
    Fixes for comments from Hans:
    - Add more details in Documentation about the log levels;
    - Replace 0x0a with '\n';
    - Solve comment 'Why len + 1, this seems intended to assume some
      separator between prefix'. The change is to remove the '+ 1'
      here to avoid confusion. Yes, it's trying to remove the space
      separator. Since the next block 'Ignore leading spaces' already
      has similar logic, no need for the '+ 1" here.
v1: Initial version.
---
 .../testing/sysfs-platform-mellanox-bootctl   |   9 ++
 drivers/platform/mellanox/mlxbf-bootctl.c     | 141 ++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
index 9b99a81babb1..4c5c02d8f870 100644
--- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
@@ -75,3 +75,12 @@ KernelVersion:	6.4
 Contact:	"Liming Sun <limings@nvidia.com>"
 Description:
 		The file used to access the BlueField boot fifo.
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/rsh_log
+Date:		May 2023
+KernelVersion:	6.4
+Contact:	"Liming Sun <limings@nvidia.com>"
+Description:
+		The file used to write BlueField boot log with the format
+                "[INFO|WARN|ERR|ASSERT ]<msg>". Log level 'INFO' is used by
+                default if not specified.
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 1bad1d278672..e88ce68acb89 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -45,10 +45,38 @@ static const char * const mlxbf_bootctl_lifecycle_states[] = {
 	[3] = "RMA",
 };
 
+/* Log header format. */
+#define MLXBF_RSH_LOG_TYPE_SHIFT	56
+#define MLXBF_RSH_LOG_LEN_SHIFT		48
+#define MLXBF_RSH_LOG_LEVEL_SHIFT	0
+
+/* Log module ID and type (only MSG type in Linux driver for now). */
+#define MLXBF_RSH_LOG_TYPE_MSG		0x04ULL
+
+/* Log ctl/data register offset. */
+#define MLXBF_RSH_SCRATCH_BUF_CTL_OFF	0
+#define MLXBF_RSH_SCRATCH_BUF_DATA_OFF	0x10
+
+/* Log message levels. */
+enum {
+	MLXBF_RSH_LOG_INFO,
+	MLXBF_RSH_LOG_WARN,
+	MLXBF_RSH_LOG_ERR
+};
+
 /* Mapped pointer for RSH_BOOT_FIFO_DATA and RSH_BOOT_FIFO_COUNT register. */
 static void __iomem *mlxbf_rsh_boot_data;
 static void __iomem *mlxbf_rsh_boot_cnt;
 
+/* Mapped pointer for rsh log semaphore/ctrl/data register. */
+static void __iomem *mlxbf_rsh_semaphore;
+static void __iomem *mlxbf_rsh_scratch_buf_ctl;
+static void __iomem *mlxbf_rsh_scratch_buf_data;
+
+/* Rsh log levels. */
+static const char * const mlxbf_rsh_log_level[] = {
+	"INFO", "WARN", "ERR", "ASSERT"};
+
 /* ARM SMC call which is atomic and no need for lock. */
 static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
 {
@@ -266,12 +294,111 @@ static ssize_t fw_reset_store(struct device *dev,
 	return count;
 }
 
+/* Size(8-byte words) of the log buffer. */
+#define RSH_SCRATCH_BUF_CTL_IDX_MASK	0x7f
+
+static int mlxbf_rsh_log_sem_lock(void)
+{
+	unsigned long timeout;
+
+	/* Take the semaphore. */
+	timeout = jiffies + msecs_to_jiffies(100);
+	while (readq(mlxbf_rsh_semaphore)) {
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void mlxbf_rsh_log_sem_unlock(void)
+{
+	writeq(0, mlxbf_rsh_semaphore);
+}
+
+static ssize_t rsh_log_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int rc, idx, num, len, size = (int)count, level = MLXBF_RSH_LOG_INFO;
+	u64 data;
+
+	if (!size)
+		return -EINVAL;
+
+	if (!mlxbf_rsh_semaphore || !mlxbf_rsh_scratch_buf_ctl)
+		return -EOPNOTSUPP;
+
+	/* Ignore line break at the end. */
+	if (buf[size - 1] == '\n')
+		size--;
+
+	/* Check the message prefix. */
+	for (idx = 0; idx < ARRAY_SIZE(mlxbf_rsh_log_level); idx++) {
+		len = strlen(mlxbf_rsh_log_level[idx]);
+		if (len + 1 < size &&
+		    !strncmp(buf, mlxbf_rsh_log_level[idx], len)) {
+			buf += len;
+			size -= len;
+			level = idx;
+			break;
+		}
+	}
+
+	/* Ignore leading spaces. */
+	while (size > 0 && buf[0] == ' ') {
+		size--;
+		buf++;
+	}
+
+	/* Take the semaphore. */
+	rc = mlxbf_rsh_log_sem_lock();
+	if (rc)
+		return rc;
+
+	/* Calculate how many words are available. */
+	num = (size + sizeof(u64) - 1) / sizeof(u64);
+	idx = readq(mlxbf_rsh_scratch_buf_ctl);
+	if (idx + num + 1 >= RSH_SCRATCH_BUF_CTL_IDX_MASK)
+		num = RSH_SCRATCH_BUF_CTL_IDX_MASK - idx - 1;
+	if (num <= 0)
+		goto done;
+
+	/* Write Header. */
+	data = (MLXBF_RSH_LOG_TYPE_MSG << MLXBF_RSH_LOG_TYPE_SHIFT) |
+		((u64)num << MLXBF_RSH_LOG_LEN_SHIFT) |
+		((u64)level << MLXBF_RSH_LOG_LEVEL_SHIFT);
+	writeq(data, mlxbf_rsh_scratch_buf_data);
+
+	/* Write message. */
+	for (idx = 0, len = size; idx < num && len > 0; idx++) {
+		if (len <= sizeof(u64)) {
+			data = 0;
+			memcpy(&data, buf, len);
+			len = 0;
+		} else {
+			memcpy(&data, buf, sizeof(u64));
+			len -= sizeof(u64);
+			buf += sizeof(u64);
+		}
+		writeq(data, mlxbf_rsh_scratch_buf_data);
+	}
+
+done:
+	/* Release the semaphore. */
+	mlxbf_rsh_log_sem_unlock();
+
+	/* Ignore the rest if no more space. */
+	return count;
+}
+
 static DEVICE_ATTR_RW(post_reset_wdog);
 static DEVICE_ATTR_RW(reset_action);
 static DEVICE_ATTR_RW(second_reset_action);
 static DEVICE_ATTR_RO(lifecycle_state);
 static DEVICE_ATTR_RO(secure_boot_fuse_state);
 static DEVICE_ATTR_WO(fw_reset);
+static DEVICE_ATTR_WO(rsh_log);
 
 static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_post_reset_wdog.attr,
@@ -280,6 +407,7 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_lifecycle_state.attr,
 	&dev_attr_secure_boot_fuse_state.attr,
 	&dev_attr_fw_reset.attr,
+	&dev_attr_rsh_log.attr,
 	NULL
 };
 
@@ -345,6 +473,7 @@ static bool mlxbf_bootctl_guid_match(const guid_t *guid,
 static int mlxbf_bootctl_probe(struct platform_device *pdev)
 {
 	struct arm_smccc_res res = { 0 };
+	void __iomem *reg;
 	guid_t guid;
 	int ret;
 
@@ -358,6 +487,18 @@ static int mlxbf_bootctl_probe(struct platform_device *pdev)
 	if (IS_ERR(mlxbf_rsh_boot_cnt))
 		return PTR_ERR(mlxbf_rsh_boot_cnt);
 
+	/* Get the resource of the bootfifo counter register. */
+	mlxbf_rsh_semaphore = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(mlxbf_rsh_semaphore))
+		return PTR_ERR(mlxbf_rsh_semaphore);
+
+	/* Get the resource of the bootfifo counter register. */
+	reg = devm_platform_ioremap_resource(pdev, 3);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+	mlxbf_rsh_scratch_buf_ctl = reg + MLXBF_RSH_SCRATCH_BUF_CTL_OFF;
+	mlxbf_rsh_scratch_buf_data = reg + MLXBF_RSH_SCRATCH_BUF_DATA_OFF;
+
 	/* Ensure we have the UUID we expect for this service. */
 	arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &res);
 	guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);
-- 
2.30.1

