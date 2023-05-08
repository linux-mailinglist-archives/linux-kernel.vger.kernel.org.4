Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066806FB629
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjEHSCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 14:02:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BEDE5A;
        Mon,  8 May 2023 11:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPNRoQ1QckkmFd5/AWqeMvtJSBGvjlAa26M1IxGJ1PNuAKuPLpEO9Htv0BmuGbLXHoWQiz8DitIa3SKhC0n7yoZIADejj6cPV18ZxOUITCfJujKmyZ0X74AXUWuww8r0/ZVYJCHhhNczBr9x96DGBFD7E5hdlR2YKNMDoMubAE78YiVgnyVi16MoswYV4H2EwxjX61YW7d/8UT7MGrswOKtM0dEJFFdoLrvykZAAZottvtyGI6AcxoXAMDqE1V58O4Tx3/kRq5dmZdQzsvlw8Ljv0tUeMxnJymZJ6bneyzWKGtl7f0BYvtXLFOaedy/4M69qFBir7Yq+5tMWi9syYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ix1G+JhHy2tGqapFWdIij4qMp7W7QaZJZPDLZIqApg=;
 b=lm+ZoNJN16pO5RgDFhBedkpmZ0kfphlg+/4sOo2y3iWzJiEQ9IjYhY5L6aKNCvTBN+HgJT3szf/EcIXEtMbr90uWe5tGEmpnEAGX0RPDEFZeOr+w2OT7sOMyPeqjXjsD172YBeMVLQkZddjqbU0Ghj4/oxKBEAiMuEDG8ZgjQA7fBXDDz48nwBWmJ5c4LorRjI6Pp5QvGikmuuucIHzvhL9ITAE1vnlTXUUEG5n5POkHaavyWVXSlfe2MjrLp7xUesEF8rfqKSoqKpaCnLgh4COJS007B/FMOnVhWVLoSyXqItvBu/VIL8aP+o36r0deMpAgH04edvUVDbqFiWgTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ix1G+JhHy2tGqapFWdIij4qMp7W7QaZJZPDLZIqApg=;
 b=k6M/AXEZUv6SScppBbljoD5QSVZbrUOYdJVIA69vGM5fIhGidJQpVN46/vDer57A4pc6OzJgwSZIX3b7g6EPZZQSsulf/tblSzBcEwYR/i3i/rc88iiAJWW2j2kDlQ1k3O7BT310E1r8JRcBHS0X1+4r7ZGqzywSIaQPskjwFZFGT8q/UVNqKf9Rq9x+8BcBsHc24beSM615WQrz9OdjuLYhO3HrGvSK9WUGyW1LfpvPGpjkjuNkOAjWS1GCK9Lph9CGx5j2Ky54HED/VBfE4sIHxCKPFldfhZsheAF/AXNhPlVZb8CeJIeQUEgRf4dhL6+33OcXbf4h0bQWrmft+A==
Received: from MW4PR03CA0028.namprd03.prod.outlook.com (2603:10b6:303:8f::33)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 18:01:54 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::e6) by MW4PR03CA0028.outlook.office365.com
 (2603:10b6:303:8f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 18:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Mon, 8 May 2023 18:01:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 11:01:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 11:01:38 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 8 May
 2023 11:01:37 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Liming Sun <limings@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mlxbf-bootctl: Add sysfs file for BlueField boot log
Date:   Mon, 8 May 2023 14:01:32 -0400
Message-ID: <1f778872d177146336318cf856a2c0b06870b1b7.1683568762.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 518e62f6-ea0a-4ade-cf8c-08db4fee4ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQdMD0K7NQfAsXnpLQDuwFtPzwCGKVNmyYzLSOR5RtVNGSB2d7484KGdNHx30N+h0c61MDCKfhTmq4xdWlIU2cnUp1YsCT1BLXyv3rRNkjNJj9q6SWPzAlYyPjiD8MGghO9L/qJtPmDkcDm0IzaFmTVXqexB59o7DyqMhSwy9O5YUncWwyIsfO3ZYr19488LkvFwt8wpQMOhzFVUkk8DpO8uIL2Ck0cEsh5JwRkNoC/tmsp/5vlY1Sd44AHekyeHZng7/IKGt4cod+ay3wiCP0dSowpNFOWShPJQSePoV37+XyWmpeLz4fT+uZ6CvjW47DVbzLqdSmPPj+LsBTmTQCQsgZ13tTBcRrxNUjgbLHfGxq7FHGU4Iup89V9zNpKpqoKvwaxz3H/gkfIvZ7YWf9OHki+AvPGFjIswHW1SjmB1TQlBold3ISJcbWqQ2DPxaiRgOQHbKZKnLt7JQlE2Evwvb8fzv5rgRThGAiKJSFSkvXARIrcbxqBwDPMi9D316K8tz+P8vvXNy5JvkXSxul9lh68mCIzmdUj+DLNbH5CLCYYimalo91Q+Var/oLzCnE5SAZJL8PmIAhHVoOqFZElHMCNt3+NdveCdPgpZVOdfgFo2xoCTYOCDoO+KnLtpktTe4YXD3mOGBOVmGoC0GuAL5pvIyfYI4WlbwRyfgHJuwSyygOlYzYaz8vtYHK/uYxdpN8vCYhun4TmxcByIPA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(40460700003)(2906002)(8676002)(8936002)(316002)(86362001)(5660300002)(40480700001)(70206006)(7636003)(356005)(70586007)(41300700001)(82310400005)(4326008)(82740400003)(426003)(47076005)(336012)(83380400001)(186003)(26005)(478600001)(6666004)(2616005)(7696005)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 18:01:54.6614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518e62f6-ea0a-4ade-cf8c-08db4fee4ee5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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
 .../testing/sysfs-platform-mellanox-bootctl   |   7 +
 drivers/platform/mellanox/mlxbf-bootctl.c     | 141 ++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
index 9b99a81babb1..239184db57dd 100644
--- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
@@ -75,3 +75,10 @@ KernelVersion:	6.4
 Contact:	"Liming Sun <limings@nvidia.com>"
 Description:
 		The file used to access the BlueField boot fifo.
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/rsh_log
+Date:		May 2023
+KernelVersion:	6.4
+Contact:	"Liming Sun <limings@nvidia.com>"
+Description:
+		The file used to access the BlueField boot log.
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 1bad1d278672..c02062cb3128 100644
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
+	if (buf[size - 1] == 0xa)
+		size--;
+
+	/* Check the message prefix. */
+	for (idx = 0; idx < ARRAY_SIZE(mlxbf_rsh_log_level); idx++) {
+		len = strlen(mlxbf_rsh_log_level[idx]);
+		if (len + 1 < size &&
+		    !strncmp(buf, mlxbf_rsh_log_level[idx], len)) {
+			buf += len + 1;
+			size -= len + 1;
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

