Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4403C6FDCE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjEJLhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbjEJLhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:37:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9095C3583;
        Wed, 10 May 2023 04:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbs20ZJ0lPYHEIZS9KnE+OkaTRbTeKr6B82E1aREwqDwJ+fF69d+Ti9u48Va/PqZRARLiVp6j9jDFQ2CQfjut7uvu1veA/Zj5214/2uktgSPZNE2ltmB58TXpVQ5zy2BjuAHzydmaFO2/rKEnltrFEZUUsLAQl3chW2FVPoAtAu7k+0xN/BxbLdY6DS3neVfjq9Dv5Okjj9G212H1SnPXD0Ozj0D3DSGNeBmwIoQmQs5b5kMYKfELxJ89Zc4slNIZku6gufXReHutuHote9Dxp0RVmxa94qvCN4gK3k4CwMCDSVXaUkcypnjLS47Hk6bs6mOZmsQiKIyIHgDP1WemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j7JV2ikphB2XzgK0c1NOzn0r6AA+wAlCoYDTgYUuSM=;
 b=bphr7qVOjahngZphfqi1FmOFgdqx1dPt7dlp/+QhzJrAuP4xg7moM27JSLNydstpqpuSOrjiZyAify6vu4AMR8a8nyvJlQcJsnopwMVjDmr17RC8laOi8Ufu9Z+Ve4a/ONte3pWBMbLIc8HT2MPItLKK68DgfH5/yrS41JQC/qYoM4ka6adTmPO1Fz/jyfKlNFHF+9qzhffGRCyechZbu0bXXjm1ac/T2H5MVfizbP74Xt6Udv8wAyfSx4tMW5FSrhaqB2YwOckP+rZ9LgtT4m0wC2+csASMKNNl5C6kwRSHhwtUlbCx284TI8mNW1kF0WtubxpOjvJK9dfHSWde5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j7JV2ikphB2XzgK0c1NOzn0r6AA+wAlCoYDTgYUuSM=;
 b=aygB/K2kMxWhVeDKPHAZjYSz3bLrMtU2PialMRTrC9Rld827O4LFtkriGNFUL5dFoyyUzNX8SOvoE0MHA5Ngre/XpEk/89thv4MPajqgkqEJK7RPRzdt7Gx5JMTNOrw7hNEGnDxr4pvjbJACqgbke6ppgdJnmwHHlSbbR9qkPpCztzvtbf6i96I3IFTbFvy+GoU6QRI8sk/nMVPdkM0jyHZ0KbIT/xXMkaqW8vcbqtkWpGxg81vDZs/g1ikO72YbhiaNJ7sURO4SW4+nomRxyUOFTSqXYq3Qpj6KmT59Bd5kRnLbgVLjpSaeK/MXkamWToT1YVUL8HEHxRuxAz0yVg==
Received: from BN6PR17CA0059.namprd17.prod.outlook.com (2603:10b6:405:75::48)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 11:37:41 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::5f) by BN6PR17CA0059.outlook.office365.com
 (2603:10b6:405:75::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 11:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 11:37:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 04:37:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 04:37:30 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 04:37:28 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: [PATCH v2 4/6] dt-bindings: Add bindings to support DRAM MRQ GSCs
Date:   Wed, 10 May 2023 14:31:32 +0300
Message-ID: <20230510113129.4167493-5-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|BN9PR12MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: c40549c0-5623-4e0f-0d2b-08db514af709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1BCCR1kNmqNFYvuR0v7qCsCdyuCEBjgHgWE0KCfnMhCMYRhYFZLICRqSqprHx3KI0n1HjxONnbRW7pORRoYQ1Po+PSeRJZaWaAOFW0g7CS905ka5vlLfOiO5XWOJPyLW32snGTt5WsFd3h7bQ1LK1PQrv+cKrmoy2UjtcPhQI9nyxc8eRXrdIdlYAVNIPkPsWA9IH8ywUZuUX9642rva89/orz5KXlDDnrHi5iVlaCXBlpSIK3n+JKj2/9JceoBn/aDCK3Evr4wvpf4BMjvDqxzfFS1bDvsPhACnNCaU2gdDmeva5jfnsv72T9BaWOBf3KvX0yDF5KEQr8gzkVFgHHPS9T84ZX8Sa1hbSbmKTfKpjc/NCSGU8HJU20RjXcAAFPzb/qJgSM+JNYg6LLIoJa/Nxi4h0kBXMaDWNuWtTp2Q/1xphfV5unJzS762FXK0TvU013cWxdcLFkUTbQT8zTBcWVEw/n/k5UeN84Y5z7opaytXFEQnf1wbmY6dpEgp18g/SBmSBCFH6+ZIM6uHaXEdDE34aVIqFyF/ZpUOzR8Y05tYxqVvRlOkhoGvr2Tja4zL9vPhBbSe+qW2CuBJl60pym0jtFZ9aaGitsKtaBaYaYQ7hZHD9Ka9gfKOFxt9KrgRe4tmMmhpiiDon/VuuOPz9rl8FSBXncgv4TQe9MzfAe8cIuw5ICUHQ0zdGJyrmp5va1hTfGESdGD8Xy1Cujb4T3jmAPrcW9hF1m83Wg09ZijwZQb4fPwa4oOpLHAcg/Oed8Wz3eb8S4KUd9SzkbkiSWHPUZL6ZHt3uh0l4U=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(36756003)(86362001)(966005)(4326008)(110136005)(54906003)(316002)(7696005)(70206006)(478600001)(6636002)(70586007)(82310400005)(40480700001)(5660300002)(8936002)(41300700001)(8676002)(356005)(7636003)(186003)(2906002)(82740400003)(26005)(36860700001)(107886003)(2616005)(1076003)(426003)(47076005)(336012)(6666004)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:37:41.5021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c40549c0-5623-4e0f-0d2b-08db514af709
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
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

Add bindings for DRAM MRQ GSC support.

Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../nvidia,tegra264-bpmp-shmem.yaml           | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
new file mode 100644
index 000000000000..1f9c2dfbf8c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra CPU-NS - BPMP IPC reserved memory
+
+maintainers:
+  - Peter De Schrijver <pdeschrijver@nvidia.com>
+
+description: |
+  Define a memory region used for communication between CPU-NS and BPMP.
+  Typically this node is created by the bootloader as the physical address
+  has to be known to both CPU-NS and BPMP for correct IPC operation.
+  The memory region is defined using a child node under /reserved-memory.
+  The sub-node is named shmem@<address>.
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: nvidia,tegra264-bpmp-shmem
+
+  reg:
+    description: The physical address and size of the shared SDRAM region
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - no-map
+
+examples:
+  - |
+    reserved-memory {
+       dram_cpu_bpmp_mail: shmem@f1be0000  {
+           compatible = "nvidia,tegra264-bpmp-shmem";
+           reg = <0x0 0xf1be0000 0x0 0x2000>;
+           no-map;
+       };
+    };
+...
-- 
2.34.1

