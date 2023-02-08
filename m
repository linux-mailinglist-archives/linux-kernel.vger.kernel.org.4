Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3D68E4CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 01:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBHAOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 19:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHAOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 19:14:42 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A226B30281
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 16:14:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGox9d3sF78MI3cWwW+ackODsRX6tLj3ueNY2uC8rz9PhjQ3ynnxufMhDRpbixnD6GfLdFxFN5tvW37/SXeHyp0LBhmATgejkbqUWeZ+fQXhYOfyPag0C1n2ajYzqcBRbRpjpuYdlwUAi4/DPZk4tcx7KtR9+0uSo2Ww3Wt3nwDhtn7OHThzKQ8QVYrmp9VvtbvLj7ol8RClzrrLyPvlla+B49hyuUB2UPfqiOsOblhiSG+9lRJwWCXKOG6lDLL131MI+16D87ao56EpmcRWQXzFuRrTAz5ZS4w4Ow31r3qssNg/12h6qex2bf7Hqg1oG4K07ENGMwoAlFqhJD6QfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRYZFeD3LrQ+GobhjYEIOWgRmmAFtkqsmlu8zLleyAM=;
 b=aeQyGnZZF/wt7NAlj1zfJu1iPRAdk6966r7+cY+QG5OVclwj0KgYTYOmKK+gII8eEQc3ZdDxI6Uqmh6uLpWq9cmZhvrLWKHQXHPLjRRVDD5VjHPPXRgYzku3B4TT/Llps0ON3nEBNNUMbUtqEWZCnOc5LbA2mdKAEbw2jx/njZXCMIla4TNUIBgALK0D4gw2p5zlQVpArFrb4xssWy6quobCXWbxwXjLUls+qq5Vj6H4RE2p7LtSH2x6dwzeG+Ukx9Kc8L+bzPhrFGNmuam2YK7acf4GiHX8eFZP3OIAN4d6/AJ2EdpA1I/4VS0TJackotOa8Ge2zRvwrNrQhitwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRYZFeD3LrQ+GobhjYEIOWgRmmAFtkqsmlu8zLleyAM=;
 b=aahgcU22aWKfvMwY357HrTDI8rHElwqIFYAzYoX6XXa0TyReGrn8imvQRWGvOF/XJNVKTJ3P4qIFQ2cH9qYxSmZl0NJsF/Fb5++gv+0ZOUwuipY1NimXiFdlWycShf1qMHAyKLbOF4pLI1hG/F6342+oX21zzY0V7ZJlCFiMBd1p8kYGHHPUtVzZsidpyDNvmFt5pP8MAtGvhpgTG+1yd5CVc66yi8ZdZDS7U8zdScHPcy7xN2Ny5zsN7ovGb3gVQZUuAs9bmUjPHmrOrqh3QlsYwE2fN0d6sYt3CDVWK/uR9FAQh/AWNS0JzvPXfnUMbmNgtYzRFilDdGuxVZn0lA==
Received: from MW4PR04CA0039.namprd04.prod.outlook.com (2603:10b6:303:6a::14)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 00:14:37 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::c6) by MW4PR04CA0039.outlook.office365.com
 (2603:10b6:303:6a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Wed, 8 Feb 2023 00:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 00:14:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 16:14:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 16:14:33 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Tue, 7 Feb
 2023 16:14:32 -0800
From:   Khalil Blaiech <kblaiech@nvidia.com>
To:     <hdegoede@redhat.com>, <markgross@kernel.org>, <vadimp@nvidia.com>
CC:     <davthompson@nvidia.com>, <kblaiech@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] platform/mellanox: add firmware reset support
Date:   Tue, 7 Feb 2023 19:14:14 -0500
Message-ID: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: b9849eab-c420-4ead-0556-08db096976aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxHf9RyTi2H7CxSq4CC46urdeEjED1+m54qXoJMoRCMvcsSDALeV9IplmDCz7HuKE0y1LqIkWy338aIsoodml4Oqw+Zdzarr55E3F3O9NswV0mivv7C08KQ3JnQnQEmdOXGHP1VHaDbusdqGYnFvr1zybi7Man640nqGHXN/VJRvXxx4FwMuy6uSMdi+MkJ+CK1toyOAgvFUarmNdoBY1sytR5ZMEC0rXgXh3hSr4/udHgvKnJzJAjJ6Eb7vz2nlvwX76zJPIB5PwV4hgOy3p0PuIjyxY4ByilzygdLRoxRYX6T2x7hVaSkhQZr/6PYtZmb+YamqQ1U3HrW3cpzuKaAvK6R2bPLMGeLhH30YQF5IwMvx5yLHiZnRLy9tp5NQlN88NFOzGirqA9pOk0cCK2x3fJL80G3Zr5AFmglq9yyABKC6N6gWglWdtmTRTjIDtigzq76QLh00CpV9PRC9Yy71uLMDZm3o7bDdrtqcJv/+WsOrJK1r90X7NFKll7Xf/sjfMR7D/mtZ8b/iVZlGN8KGshMKbPAo/mim5yysD3EDFBBH1CS+srfzPYvLk1cWNI5Bp7T146p/ORhz4M0dzK66ty1i+8W32pnIFFarN0E0AEDSyH64kGbfMLQUoIMbEGMNa0LcdwwCqPqlonNsC5049t6dp2vhyr0CuZo/fBzvvYKL7FFQoLr6Ibg7sJsnRZW37eAOO9pS+IQVZQlPmg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(478600001)(6636002)(54906003)(110136005)(6666004)(7696005)(2616005)(316002)(186003)(26005)(82310400005)(5660300002)(86362001)(36756003)(82740400003)(7636003)(426003)(40480700001)(336012)(40460700003)(47076005)(8676002)(4326008)(70206006)(2906002)(8936002)(70586007)(36860700001)(356005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 00:14:36.9189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9849eab-c420-4ead-0556-08db096976aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

