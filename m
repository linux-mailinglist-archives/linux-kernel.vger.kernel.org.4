Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC716FF4FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbjEKOvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbjEKOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:50:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075CD10E70;
        Thu, 11 May 2023 07:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEi5mOIq9YWvqkg0wOB2++B6dqG3IBDKfzvYDOEJjyogitkhlWt6h+3DA55q8NEYa+hjKKHwfM5AmV/RJ/8UdiEACjf6uLuEypGTrmo9FJqZDWzb3Qp3+KkXIj9cxxAo7RXTivxiDyzA8bBMIF+HsR0RNIrUu4mkSibkbvSBWqamXPvYhE2XstkX/FEe0p1Eg2beF6yizeBIRR/cKtiacqW74bf13H18Rb4C3D06EpGVZGeXPAfSQQuEuqQCiK0YDji+5w4yCpiPpgWkQtU4YvKC7zYxCJHh65pK1YOJAQO8wbwxXx8MCveJJ8ZqCH9REyOqKsjU2ia4D5QBgqW38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmvG+OszXZHzemJNGRPs93jE1L40Jv0BvxShAARRZ34=;
 b=NH3vJaTLAV6TZa8I8LL9mni2+57/Qr8lfaMLUIB3cFR5a3jOHnGQcskHfxcSQdPL0PfB9modbjw5Op70Doto9gCNv7y7BPXgXg8/M/c948GNkSXwy6wj6Bj6tvn1uKNYENZt7mtFpfZYACscOsb9CFaE68dR/G2si6WZ91G3LxPnkXp3xXHL4JPxugORIu9AlnaFyVtUeHb12aOzB+EGpkrUdOGfvGPpZbRMF91q0VvRZLScvXYJlappoJ9uH6etWzfNk+kUnxC5xjPzCW9HT2o191StshlGG5S6zj48TXYYeLP7ZZzgOy5Nq9Wasp88POhvQh8zXwmwnz0DtYRFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmvG+OszXZHzemJNGRPs93jE1L40Jv0BvxShAARRZ34=;
 b=cesqiZWeIbBs6okp1RfnPBQ3/xRnG4mkCDSmE321LFVX35OKjKogNTzBmTrB8E6tBAHBbXokjXRAaWTWEpRayrJi+lXO1oWXhSjAm9lnxxT82uk0G1SjdDQqOUUfbM9SNdrtJ3uepN0L2Ib7ES1DY+Od8BdaktYSRdUYfjqU6Z84+S3sZBr7tkpT4gYp/BfnZvadPCpOKzVDsCCv1ii1bNdZO4ThelVTlx9yOlIuhL5/kz0zIYqp82qdywdHpaM1Ddab1ZN8Ij7hpl+xTDG1N3EoxuggWTUk1qYhNh3B4pJf1zdCDFWuX8GJgUgjLUgLIA5g/dyI7dUZVRXMClmu7w==
Received: from BYAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:a02:a8::23)
 by PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 14:49:52 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:a8:cafe::ec) by BYAPR03CA0010.outlook.office365.com
 (2603:10b6:a02:a8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 14:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 14:49:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 07:49:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 11 May 2023 07:49:41 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 07:49:40 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Liming Sun <limings@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] mlxbf-bootctl: Add sysfs file for BlueField boot log
Date:   Thu, 11 May 2023 10:49:24 -0400
Message-ID: <20230511144924.171585-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <1f778872d177146336318cf856a2c0b06870b1b7.1683568762.git.limings@nvidia.com>
References: <1f778872d177146336318cf856a2c0b06870b1b7.1683568762.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|PH0PR12MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb3f968-8e66-4a36-8103-08db522efa17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnhH2PYSqoUyMbnaJfhad42o6ppfjXnZIFa/cGivnYMTwfByHEgrx7QLmMcSyr5qX7GMLECNBFfPQVC6s5KiOfbBa1P21T7bx6CIwPH0zgirWfEH0C644DYoX3K28xspwrXikOWgSTFRAnAcAP6VZrpIbXGNeteJT7wdJesYqDbU+b3isuw6hPKHYO+3ePAVzqWvzeEKIsvJMR+k5NPY16Sj6b86YVcD0UdkO1bYw08A4IU0InlBYtdt/2utDdeMUpV0ZshSf5bj9Jh1mB0WGSMEst5VtTELGxqTFAsfaknixMDbSn36A4drP8PPQ+tOQsJlByfFTbn6BoKzUVMG4zZTHkdk29cCJxjQFzTfODCV8Me5XgafFC49++E2W3iL9K+5EjEF157UBNYpllSluIbNnnlLmjPneA+mBi5ItArTLV3wN/eXP99zmsH+uLwGv/opXllv6CudUBLVYXYF18F+HCPO8p07tZqqx70+0GlhQrvTnHuQBynbZZECdFHzZ4gPpxW7PYAPErR6sZ+Yoxpe9JWcZpaO11u7IqHudlwLH0ZI2JwTyLxQXbHabTC63BnoOe9xOBwHNjsEOHh5xybC4mgzYJVqtkMuhmh3DBiLujVOYbQQZ73pd3hulMkWT/7jmUa+VTrPa3spvFWGC+nPsPLYjAknHEq95B7pNqHP4X1wjDnAew9ypYsc3FfhbONLZpEB1NroODP0oTwLghmUHsFFZI+CyheacDmCHQxaXXLeAvABQhUBtYLGGM//
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(1076003)(26005)(7696005)(5660300002)(40460700003)(40480700001)(8936002)(8676002)(478600001)(86362001)(6666004)(4326008)(70206006)(70586007)(36860700001)(7636003)(82310400005)(110136005)(356005)(82740400003)(54906003)(41300700001)(2906002)(336012)(47076005)(316002)(83380400001)(2616005)(426003)(36756003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 14:49:51.9312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb3f968-8e66-4a36-8103-08db522efa17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
v2->v3:
    Fixes for comments from David:
    - Add MLXBF_RSH_LOG_ASSERT;
    - Use FIELD_PREP generate value in "data";
    - Fix cut-and-paste comments;
    Fixes for comments from Ilpo
    - Use GENMASK_ULL();
    - Use readq_poll_timeout() in mlxbf_rsh_log_sem_lock();
    - No need to cast 'count' to int, keep 'size_t' instead;
    - Use DIV_ROUND_UP;
    - Use min() when calculating 'num' of words to write;
    - Simplify the 'Write message' loop and removed 'len' from
      the loop.
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
 drivers/platform/mellanox/mlxbf-bootctl.c     | 144 +++++++++++++++++-
 2 files changed, 151 insertions(+), 2 deletions(-)

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
index 1bad1d278672..fb9f7815c6cd 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -11,6 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
@@ -45,10 +46,39 @@ static const char * const mlxbf_bootctl_lifecycle_states[] = {
 	[3] = "RMA",
 };
 
+/* Log header format. */
+#define MLXBF_RSH_LOG_TYPE_MASK		GENMASK_ULL(59, 56)
+#define MLXBF_RSH_LOG_LEN_MASK		GENMASK_ULL(54, 48)
+#define MLXBF_RSH_LOG_LEVEL_MASK	GENMASK_ULL(7, 0)
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
+	MLXBF_RSH_LOG_ERR,
+	MLXBF_RSH_LOG_ASSERT
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
@@ -266,12 +296,108 @@ static ssize_t fw_reset_store(struct device *dev,
 	return count;
 }
 
+/* Size(8-byte words) of the log buffer. */
+#define RSH_SCRATCH_BUF_CTL_IDX_MASK	0x7f
+
+/* 100ms timeout */
+#define RSH_SCRATCH_BUF_POLL_TIMEOUT	100000
+
+static int mlxbf_rsh_log_sem_lock(void)
+{
+	unsigned long reg;
+
+	return readq_poll_timeout(mlxbf_rsh_semaphore, reg, !reg, 0,
+				  RSH_SCRATCH_BUF_POLL_TIMEOUT);
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
+	int rc, idx, num, len, level = MLXBF_RSH_LOG_INFO;
+	size_t size = count;
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
+	idx = readq(mlxbf_rsh_scratch_buf_ctl);
+	num = min((int)DIV_ROUND_UP(size, sizeof(u64)),
+		  RSH_SCRATCH_BUF_CTL_IDX_MASK - idx - 1);
+	if (num <= 0)
+		goto done;
+
+	/* Write Header. */
+	data = FIELD_PREP(MLXBF_RSH_LOG_TYPE_MASK, MLXBF_RSH_LOG_TYPE_MSG);
+	data |= FIELD_PREP(MLXBF_RSH_LOG_LEN_MASK, num);
+	data |= FIELD_PREP(MLXBF_RSH_LOG_LEVEL_MASK, level);
+	writeq(data, mlxbf_rsh_scratch_buf_data);
+
+	/* Write message. */
+	for (idx = 0; idx < num && size > 0; idx++) {
+		if (size < sizeof(u64)) {
+			data = 0;
+			memcpy(&data, buf, size);
+			size = 0;
+		} else {
+			memcpy(&data, buf, sizeof(u64));
+			size -= sizeof(u64);
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
@@ -280,6 +406,7 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_lifecycle_state.attr,
 	&dev_attr_secure_boot_fuse_state.attr,
 	&dev_attr_fw_reset.attr,
+	&dev_attr_rsh_log.attr,
 	NULL
 };
 
@@ -345,19 +472,32 @@ static bool mlxbf_bootctl_guid_match(const guid_t *guid,
 static int mlxbf_bootctl_probe(struct platform_device *pdev)
 {
 	struct arm_smccc_res res = { 0 };
+	void __iomem *reg;
 	guid_t guid;
 	int ret;
 
-	/* Get the resource of the bootfifo data register. */
+	/* Map the resource of the bootfifo data register. */
 	mlxbf_rsh_boot_data = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mlxbf_rsh_boot_data))
 		return PTR_ERR(mlxbf_rsh_boot_data);
 
-	/* Get the resource of the bootfifo counter register. */
+	/* Map the resource of the bootfifo counter register. */
 	mlxbf_rsh_boot_cnt = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(mlxbf_rsh_boot_cnt))
 		return PTR_ERR(mlxbf_rsh_boot_cnt);
 
+	/* Map the resource of the rshim semaphore register. */
+	mlxbf_rsh_semaphore = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(mlxbf_rsh_semaphore))
+		return PTR_ERR(mlxbf_rsh_semaphore);
+
+	/* Map the resource of the scratch buffer (log) registers. */
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

