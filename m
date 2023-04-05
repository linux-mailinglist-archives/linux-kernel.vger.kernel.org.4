Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7026D7D81
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbjDENQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjDENQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:16:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E67171F;
        Wed,  5 Apr 2023 06:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l65/nPwZ+hhvGZllyNi8bW9x52UtfhnTr6cvDTzSUjC/QLJ4LUGPD4EvZtQmCwCTSEoXHyYzuXRl7rT9SWLpDexTwaXAXx/0uN3XZlZMYeUCfvraa/jRYMV/U2F+nrHl4uMT4jYPJKLE9HWejyyhmzkb5Ir1gcVl4lPMtwEBeZsSkCrxBgUul5TXwUyoGxbCm50iQqtt6g6uzk1D7scOaUzzY4MUPeCd87eGbLXUIrNeyk4yREjC8UrnWCiF15mEkw0NZmDUinlGF9hXznCiVH2Vr/dUXSTuSVyLgQ/c9RAoJztVp6TPFxzfEUkMzMez6SS/7WXtPd4cMM5tVAEHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRYZFeD3LrQ+GobhjYEIOWgRmmAFtkqsmlu8zLleyAM=;
 b=mFRO06jdtiuN0q3A2NddnPAsJpmD6PiC024KR5XJJLSrS+W3aFsjNb8nt42fYdpwLCM+1UKSX+m1RDtDXdI1YP/9DtURmLROrOVMFgSQplbPLqdOxTslI8o/rt6dxPhCFeAXXdU/eqb/fZ3Xrc+P2bQxZboH8tEkYdIqCCIDqsv2oNhRdgIZ9jLMF78BTJ64HUk0mn3KpwDKsINArWC8rz60ftO6Mt4KLzqgxWiQJP9+ZkDiVP9tdI551xNaorve4Um2cxbv6rsbCZU6zK87y2H5WW4Ut+Kp0TTW/dIGrqXtXwa6xjzQA89Xy7n/8LqdpeeO89SeN91kKEkHQCFdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRYZFeD3LrQ+GobhjYEIOWgRmmAFtkqsmlu8zLleyAM=;
 b=kx6PoB32APEXyt/Pg9td4apDDvELJYnT5fnjY5eW1JqGMhoLq9kzVK4/iXc/zYDNdPWbElUOSRCUgTi7VmqMgHaOd5/T4zPYK8Y7HWOsSDwTfKyL2OPYOwQ45QeDTAvQ1oUY4KIzKx2cUqASz6DbnHnM7NZy9m/SlPI7e34gNPpWoCBujqeYkBAfyQty+IAHRRU7KJ7mxRRA76S2oWSxSAwKtbL1gpx4ynFARIHjY7vcJTIznpn2DsYYVmriUIubfIrZDsuKU6CkRRkTPeRHqL/KF+Nu+nRiHROX2B1dW4IQ/V3v+X/1Yrn5enTY40NV9e5aYvC2LwOU1SQoybL5Cw==
Received: from DS7PR03CA0337.namprd03.prod.outlook.com (2603:10b6:8:55::25) by
 MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Wed, 5 Apr 2023 13:16:42 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::43) by DS7PR03CA0337.outlook.office365.com
 (2603:10b6:8:55::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37 via Frontend
 Transport; Wed, 5 Apr 2023 13:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.16 via Frontend Transport; Wed, 5 Apr 2023 13:16:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 06:16:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 5 Apr 2023 06:16:34 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 5 Apr
 2023 06:16:33 -0700
From:   Khalil Blaiech <kblaiech@nvidia.com>
To:     <hdegoede@redhat.com>, <markgross@kernel.org>, <vadimp@nvidia.com>
CC:     <platform-driver-x86@vger.kernel.org>, <davthompson@nvidia.com>,
        <kblaiech@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1 RESEND] platform/mellanox: add firmware reset support
Date:   Wed, 5 Apr 2023 09:16:29 -0400
Message-ID: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|MW3PR12MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: f90ae823-a5ae-4a93-abbf-08db35d7ff42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSJTxNFLx8SepVYb+9a8MPgjJ5fHoJmoZsVL2ejcq8bCfUDBlcIdSEJeb50sJJG8oydQmdHWjaU2feVSoajOK0A4ZyFWhFjUSSbK6i5QkfEVjM6oZeIQlxKhYwYqrkjRk227DdHyRd/tjR9x0nsbEeb6L2SdvkWQFslmSV2j0lFAKiKCZgHTPunRO2ragiNEvyz1+Jdatmoigjhzs2tmZBHu39rvbTJBoiPC0KEF0ujEjZu6rHFfOeV4/HDperrADnSTGJHFrKfArykFuMWujFudYq8D3mCzkEN88mIi/VUPsy/1giOmiGbTQpGXm0SSKpuYpm4gf5XEJayWmL4vS27EIVEQQ97sUHG1VYr+xQJlesb1clmfVE3a0WNgm7H9nTS/Aqe/l0pgq3cuvwaNMo+8XcjimlxI2X4ALBlzg8eESwXgUXCpFVBbUnWAuZQNC72mwYNTz+B/druP3gyfgczQMMadLZfTXCkmZ2LUz8gDeWzHDGoBZIf2AKluMtPV5IYfdcbuarks5t+xghBYtbBPCaP5P+HxaXlb9se4oBMbjuBFhm52xg2MKUQEGRN2gyFkcqZGtHE9UBM5+xLvwd3vjk2FFtGITR8eyhItD9imwmjhPF/8B5thPt4bvjZzPaEplKMZlm82CZ0WUaxOd6z8aH3zue8QsCB7ltNuiNeMDi7PSw/47YogxPJoYPxjgJIgQk/KOGArAJGgeeJLGud/ljCi7ojY55IOEor6njUQ8Fn2ecUlyaB/DtrBk6hP
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(26005)(186003)(6666004)(2616005)(426003)(47076005)(5660300002)(336012)(41300700001)(8936002)(70206006)(8676002)(4326008)(2906002)(110136005)(70586007)(316002)(7696005)(54906003)(40480700001)(478600001)(6636002)(82740400003)(356005)(82310400005)(86362001)(36860700001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 13:16:41.8451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90ae823-a5ae-4a93-abbf-08db35d7ff42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new sysfs to initiate firmware reset in isolation mode.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Khalil Blaiech <kblaiech@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 19 +++++++++++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 1c7a288b59a5..5e41c270195c 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -244,11 +244,29 @@ static ssize_t secure_boot_fuse_state_show(struct device *dev,
 	return buf_len;
 }
 
+static ssize_t fw_reset_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	unsigned long key;
+	int err;
+
+	err = kstrtoul(buf, 16, &key);
+	if (err)
+		return err;
+
+	if (mlxbf_bootctl_smc(MLXBF_BOOTCTL_FW_RESET, key) < 0)
+		return -EINVAL;
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(post_reset_wdog);
 static DEVICE_ATTR_RW(reset_action);
 static DEVICE_ATTR_RW(second_reset_action);
 static DEVICE_ATTR_RO(lifecycle_state);
 static DEVICE_ATTR_RO(secure_boot_fuse_state);
+static DEVICE_ATTR_WO(fw_reset);
 
 static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_post_reset_wdog.attr,
@@ -256,6 +274,7 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_second_reset_action.attr,
 	&dev_attr_lifecycle_state.attr,
 	&dev_attr_secure_boot_fuse_state.attr,
+	&dev_attr_fw_reset.attr,
 	NULL
 };
 
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
index 148fdb43b435..b48243f60a59 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.h
+++ b/drivers/platform/mellanox/mlxbf-bootctl.h
@@ -75,6 +75,12 @@
 
 #define MLXBF_BOOTCTL_GET_DIMM_INFO		0x82000008
 
+/*
+ * Initiate Firmware Reset via TYU. This might be invoked during the reset
+ * flow in isolation mode.
+ */
+#define MLXBF_BOOTCTL_FW_RESET  0x8200000D
+
 /* SMC function IDs for SiP Service queries */
 #define MLXBF_BOOTCTL_SIP_SVC_CALL_COUNT	0x8200ff00
 #define MLXBF_BOOTCTL_SIP_SVC_UID		0x8200ff01
-- 
2.30.1

