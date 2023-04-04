Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC1D6D6975
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjDDQw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDDQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:52:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEDA4ED6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOwOiWiufGy7J0q+VyVW5SxtINPqd8XsRF+A0Nup6dsOKC5eI65egBklQ894f7ZfGIHFoDdXIjuG5s6NIUnorAeIypBqutwlNgSzAgbM0c1nUUv8DA1M5e90KTjHENH/xyZpjhULKUBPUgwiQIyVpcD9s4kNgWB+TE7jwDUgv0YfruQfmFdPQCYj/WWGWoqA0jwDz7OxrMVmFO25LyBrvT3/6gxENKuOnk5vlsyUht19zKKqen1dQ32vGLCMknS5C4CxlcUFPNrbQ/fFsqw4FU9QaUFu0vciGW4GDqSmKzWaQ0oF1uqk618Yv3g1iLj0cgPfhHUY1AQK4NJ8TB92PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRYZFeD3LrQ+GobhjYEIOWgRmmAFtkqsmlu8zLleyAM=;
 b=iHfxB3iRVnVD+GKWYVgaJwEFo3+OQRg6SmToo3JPdOuGXOC0cdxd1VLcnuO2rrRHiAbGsIrY5Fw/samwPKCXUkeAREHDp5QuiqPVAuDOqJIfjJJPBsuGamMq/zyRRRhwKyoLCfXzfKe0fVO+7cQr8o6OwMLRcYsdvcKREPv4bzoI9IPs6G3R7pfG9EO0YUAj2kyPjjn9rpc4cf27Ns6jbfpyq5EOuSqc1FWSzuV5CjSoURJT6xGD9DOUhRtAiSYbAgXB8VoM3lfIuNNE13Oq8tblUetYXPGN0/JhoQOofwzAw7C13a0eQDNidBAiVGSPwekWhC2Tc1Yv+qPLW/zk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRYZFeD3LrQ+GobhjYEIOWgRmmAFtkqsmlu8zLleyAM=;
 b=P0xe42c0fOMnnh/hoKa/Uadic6IPALevsJOQ4I+uAv+RJlueOgL3a0Bbm5zpuX381WPR/Z8FqjHsprod7hqjwYNtuOpPQi+KvZDzRnv9ybrcR31VgZoyTNNXT9YUS5VogjmwuUrafVMWcBrFRj8glD4dvz5u4jINi7Wig8Y/PsEeBogFPKsAktuZNY77wRE0Ge/MeTS74JGwjr/0bDwDS0dbITS+one/Y2sEJSXTbRyQBxusDFlReDC95Fg52XlDm656djYeaX5aJ625B5Se/7BzlQJJlueoVsu/2tJxf8ahlLXyL5QGJuPoLmbjkh4Kdd71AAzzGxNSQIX4DEQlcw==
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Tue, 4 Apr
 2023 16:51:53 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::6c) by DM6PR03CA0020.outlook.office365.com
 (2603:10b6:5:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Tue, 4 Apr 2023 16:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20 via Frontend Transport; Tue, 4 Apr 2023 16:51:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Apr 2023
 09:51:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 4 Apr 2023 09:51:46 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 4 Apr
 2023 09:51:46 -0700
From:   Khalil Blaiech <kblaiech@nvidia.com>
To:     <hdegoede@redhat.com>, <markgross@kernel.org>, <vadimp@nvidia.com>
CC:     <davthompson@nvidia.com>, <kblaiech@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] platform/mellanox: add firmware reset support
Date:   Tue, 4 Apr 2023 12:51:42 -0400
Message-ID: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 21604342-d68d-4e53-83c9-08db352ce4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DtjESAHQXULDd1umHaeReATrHfw8/EkQ2SEEGrTwIj45Du32eZeaVI+FktOk2XmFCxK4Oc96EYXTXhXLkqXvZlzIJVrZ1f/lQpbLqzAhSJ2zjbOI3onfowUqlyUd1X3CaUnfEycfr7kWQou+BxcHhCifKBB9h23TklaXdcSsJoWN5hpoJHyFLldGFuxvzPF2mXmJKdBwe/kYb1fRozQdyIlDglbNfDrnreSSY8/n2HDdTXFcTym+0f9A5JqhcAiQZ+k2MQSV6AdfWbre4WeiMXa0bZSuLEuREPhQuk+AQTcPYUNf0la/OlJtMnKI2lgYu+UO4KivDaEqHw73aK4BqzmV/H+/rpr5Ivvyx1urI9Qdu9rYz8EqMniC2ckHWCKu5nD4xsD0swhS7Jce0NGNUE/CTh7uouZ5gljnmm6JEbeFPdSRuxrP6TqcvnTandoBtFM+4gejkzjK7bTpdKdmGSsehNjBDBR0tMrNsXkdpYx+wzdZQ7W27WhRs67IEri5hiN4ds/gF1bDUCAMZSgQO4jYOu8+vG9STOfWlLk1MSvKzn6v2/OSyjDUCgDxEnPpBwWlQqrxY7qtr4jsXOW7uYmE8zKBRmM6GeKoOECSq986d0s5q8Ysi3hFppRo5iMgcu2R+9BiAJNj0drLft2+eexGOawxuBg9AvM2B+1DAFPjgVUW3x/xrLQLcdv51ByvMzrA3Zv76x9DLW0KPdqRTC0Kg2XY5PagOLeteK6VLZVfBUbdZrHzQbGIYmBY6EK
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(8936002)(82740400003)(4326008)(82310400005)(7636003)(356005)(110136005)(316002)(5660300002)(86362001)(70586007)(54906003)(8676002)(6636002)(70206006)(36860700001)(478600001)(2906002)(47076005)(26005)(7696005)(336012)(426003)(40460700003)(2616005)(40480700001)(186003)(36756003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:51:53.6141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21604342-d68d-4e53-83c9-08db352ce4dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
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

