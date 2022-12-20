Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609D5652429
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiLTQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiLTQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:04:29 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA61D335;
        Tue, 20 Dec 2022 08:04:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJHmGouuJi3POtbK0lIuotsWoF7p9LeiM/5Dd86uyhfURsfgkTGMEw2GnegAg7KJ2b3XE+b1Q8lf0SN9TN9Dt+fpuZxYeGRNl6pTYB5GmV42bx4ake8LOD65wj3XPxWcONtb7RtZyLdegFQO18HPovii03XDSGvcVlkxBRTmquIvU6kE3BLmL1Uj3cbo+4Bhgclohz93pvsKk7lxaQQIQL6d/OQKcAnq4KmVO7AohGbESdJsLNcK5xoBlLcFrU9M14sSsJ1q1Z5hmRJzbzrUIFFnXpVi8OQLD2MP/nhyqGwR1QA1qK3R+rXsfE6JQr1ipqnPW52Nqcu/iXYCfjeIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Kt5LCU4tu8Bz3aHqOZwJCyMH9HRz8jU5pX7iyG8RdY=;
 b=TohWmtczSH/9FkZy21B1eXOYMMqu29032mQEkGBMu/k13clh9rNK2XUvcHgWHhjFO+ZkG3NuAGK5gNfT0juGlSvlLnlBhAav3fQLrkjKzovo3FSqtGnf3vaK9WjPeEy6zQNGXuNjaXwoG8CVLHxDq6CgzAjiuAVe+dOZw+XHe1SFfdassgFOpQ5EjA/Q6WSSzH3v/N0jVeQzFKH+0ouIcb+xgayG270Q0whV4xYZ5+GOocXt2tkpURGU5sO/EijzgkN5rSmz9/sC2CFkhkadPJn9BKbteNu1CaO3PjzIlfGqWnh+FNuAdzZiZiSUR2qesrfgNN0MIJUbQBLJiHQygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Kt5LCU4tu8Bz3aHqOZwJCyMH9HRz8jU5pX7iyG8RdY=;
 b=aFSvQJ7CJobPG9taVsVmKVob6DNL2Jbjd4IRksUlQotgEI1LbDid91zDtEOjv74dtNYRcpzBw1hUkohg6zN1s45BNDEU7Ym/1LtcZvbe7rzJf3UOixyVpUaUCy1wZKbOMGdyJLo/SzA39geTH0jyM4IucR03Ij34ro45VT49dKl7PDueG5rnQlhxoXAOYUX/x54jzBi/3iB+puEe/mO848be/UrgogddjYcXnVuuknoROdyzwzgqKoIvPyhmNPDdMtZisKQZ21SFbfo0XdcXJiginNws1ImP6RIpD6B860PBP+gIU7CVK9mdz6GUKSaBx4pl2f47QojqHlxh7JEiZw==
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:04:21 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::97) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 16:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 16:04:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 08:04:18 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 08:04:18 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 08:04:14 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v1 05/10] dt-bindings: tegra: add icc ids for dummy MC clients
Date:   Tue, 20 Dec 2022 21:32:35 +0530
Message-ID: <20221220160240.27494-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220160240.27494-1-sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: d58fff73-a042-49a8-79fe-08dae2a3db61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmgvFAdO8uBeJZfWd01cx9nxnNFAzkjy36Gzp/FaGjZqdapa2OMXlzHPm6+Yxy9f+L1eC5dg7y/EXlfjJorLHmhPXRyoDOG5N40FmUw3r5Gvk8r852WT6bC/PUpQigxxlWkDVIII/U1fQJnv/2tT5UUamcta11VCTjnMb8YvyJzeTTSVqVa6ZFvLqzUPhwFAvleyv1mkQ4sIgJHs3VOuv5bmxnAb6Dw0w+Fx34eez7MQHFdXL8zXtkk4OPXq2CJmmrY9I3+AJGZ7VYBksdNqTjQ60InWbROXndGDnIGvGireLdrRIfJhNgv9gU7RbWy708L+/p6FuZ94+l8VyrQz7wYACgSiECvRtaOuOqxBIAWWNiKrgQJGdtPYNmbfRnLSqwjRN9apJKJsiN1sXNfcJQlrsMfSFtx77ZJ3qRxc/jFVccka9kLEDMC9UaYYC+Ns6+NBbYe/FErXNe3giUbuRnlVVPwNWeoo6jSe9K3QX97BjzIElPCz2l6FxGr/gdORgGftpzudBzqCB0n1+ve2Kan/bUPtJMVM09Igm0wvF99ABA+PISf7Q7gk6U+YHSfUTmK7L/spcdupgkAUT5PIGBp4/YJxA97/TRs/rCBs34RnphQdI1tRQrgEL4uMCmqFCKzW9aqPO2bCqo+piGUvXzvgBsjLLc7lI1Y8y1ywunTcbGNsfhtz8bheC1bdu/haQYHCVknokKeHvOe81o74amzXQPtp/AC1j6Px1pKn5tk=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(107886003)(6666004)(426003)(8936002)(47076005)(40480700001)(4744005)(5660300002)(186003)(41300700001)(26005)(2906002)(336012)(36860700001)(316002)(82740400003)(478600001)(54906003)(921005)(7696005)(36756003)(40460700003)(356005)(86362001)(2616005)(1076003)(70586007)(82310400005)(7636003)(70206006)(4326008)(8676002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 16:04:21.3554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d58fff73-a042-49a8-79fe-08dae2a3db61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding ICC id's for dummy software clients representing CCPLEX clusters.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 include/dt-bindings/memory/tegra234-mc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
index 347e55e89a2a..6e60d55491b3 100644
--- a/include/dt-bindings/memory/tegra234-mc.h
+++ b/include/dt-bindings/memory/tegra234-mc.h
@@ -536,4 +536,9 @@
 #define TEGRA234_MEMORY_CLIENT_NVJPG1SRD 0x123
 #define TEGRA234_MEMORY_CLIENT_NVJPG1SWR 0x124
 
+/* ICC ID's for dummy MC clients used to represent CPU Clusters */
+#define TEGRA_ICC_MC_CPU_CLUSTER0       1003
+#define TEGRA_ICC_MC_CPU_CLUSTER1       1004
+#define TEGRA_ICC_MC_CPU_CLUSTER2       1005
+
 #endif
-- 
2.17.1

