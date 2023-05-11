Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1E6FF2B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbjEKNYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbjEKNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:23:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A451D2CC;
        Thu, 11 May 2023 06:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzB0N0pi1D8Onwb+Xt3MbkNTk2njD2ZXY8WW59ANiu7f/uUeKVoz4NDeuy2rPndCsz5ruer3FoYTLCU4pMcPvPdITmo3VYxKdZfMG1Y4+jGyJlaE70xQfFgdJJtPwj6tZ0uuJkgph/WdrEsMjoRfwCHzhYDEzHqvRsRilJno8seyVpwtIm30VpN0+m2SFgYYc/zoe6jtDLm4aWBuNNxwao0ufwE+y3LCaHY73+Vw1yACJpDEM/+IlKaWRFo6caYpjVXWp/c1C3yrKtdQ+KHsGEpfvK/x1tz6EtNQX4bEUmq12HPskV0RGP9p9SZRWau1kpmVACmJvq015/wlfp3EZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT4tNgGNiGKAN5SdvvHFpjuTp7p7ipQ92tQPcWbkDbU=;
 b=cpe06yLvrhD52I9M1jd72YFcA6df/87ZdBGUTKccral/XzmMP4Hgu5EWHddnB4L9eNnTEQWxHywXU2G/y0G4+isZYkCmKdWOCMFBL8rCmixhdhq6djeWalShINznk/TbW8uCRksB83gjinpFkth9RUKWg7MdxMYKif15P5f8yu2PfDp0v+c3jPGVaFzpee8xhCY/ssblBOEU3J83aO+Z4FgI8W60o//0w++7diAMVq6LluWdtqr1thHAv0zKLC4UOtR20fcqGfwTfv2xCTS/OJIpsqLvKOvb92gSSnWjOnZdLE/XwYPRnFegEOeZOKFZuDlfTw05UHiMXfn5P1DLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT4tNgGNiGKAN5SdvvHFpjuTp7p7ipQ92tQPcWbkDbU=;
 b=OrMWS4QC9VvUgtAbvH3KdElnhjRCtKadZ5nT93LMsIAToayjU5Htz6Kozb7GP+Jrvasc0+vBHkTzjJCKEpVDhPPGl09TplPBawjpo/hYGGIFs3DQLRrm+mizkkf7Eo4ZYFfkBagQ2QmONPDByYZdgkAeDJdPJPLoylRnFvtVaorOOxYG1V6eZYEdK/MQrrAnEjqPHK8rNQllsepPRnKI4KHRbx2duNc/J4ErPZBKQqmA3qP6wfsPzimFo3hki69rzmjP42ib8b/EEBwDdBmcv9YvK7JosFMcO7H7+Z0ov1DEvYOvYMMfticgLCpawbv4BisapNC3wyKCZICuq0T/kA==
Received: from DM6PR03CA0014.namprd03.prod.outlook.com (2603:10b6:5:40::27) by
 MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21; Thu, 11 May 2023 13:21:56 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::91) by DM6PR03CA0014.outlook.office365.com
 (2603:10b6:5:40::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 13:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 13:21:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 06:21:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 06:21:42 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 06:21:40 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: [PATCH v4 4/6] dt-bindings: Add support for DRAM MRQ GSCs
Date:   Thu, 11 May 2023 16:20:49 +0300
Message-ID: <20230511132048.1122075-5-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aab27a9-5eb5-4a26-0d5a-08db5222b1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2Nd3yjYapLeojixZTnaAcQhI1/cyt28hWQWCLlBOLTc0cdQ5Ljf/53j3k0DxgbgvsFtVHoajfjL8RYt5rhe3uqGnyCo5qkSduRINGPTq2gPk1AZ6kxz1GfP9uzUQLXUytW4iss4AvaAe4EojUUFcEawJbJtUn5XhiuTDbh1sdWW0E5GObOoBaR09axjJh3kY/xYdXoaoaiDuuu/+VhMVQXfXMopzey+6S2G2lVyk/EGqf3n1bPfQrox/9PxuZqBohcG5kmKF8BKLPXDE66lMDfmHDfY7FPoQ5sO/S+0mpI/t3Whz535twH8TJMp0bkFls+9k8KVRSM2/eqiGTJRWQAhroDdVXj5yqKSTstZXKvXJdLWRmlW5/YQs7b5CjfWZD6Xk6vR+InOzoTHx+ukNDHk6vw8P5z83W2qbY8c4u6bVmR+8ye4Hz5T565J7YmCPcmScDEiN6CJHuBJQpKwUX+JqZLQp6w6JPtMxi5YXJww47QEMo4lmAyBIZ/3RMvVK2+zX4ltEvqZgtphmQVri31SLe/a0wP1GEK2qdxr/g+7vdWGXTOpqGUJtwmKG2/c0q5BQ23kn+f5o01opsS+jU8Li8GiQZYWB3cuGMj68wtiLfKRLSNg2NAzkIqbbAKuqD6HBazXZBIKbKJ0xJ6bvm5nhzwoO17XXS1No9jXAwDBgh35rWF7gFEHuZNc3sdy6KTdKwPhH2IWxYy/ndtXT4jKF+v6cHlWz9veZTFcjxnyb5Q4x5ESHO0N+9iWzHcwwZVQW5lC+7CCeP0TrnI7j5c6VJScx1UVIb/qIFPiytj0cZWeFpbXIBqYK1u20q4H
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(6636002)(40460700003)(2906002)(426003)(2616005)(336012)(41300700001)(47076005)(107886003)(36860700001)(7696005)(70206006)(70586007)(966005)(478600001)(110136005)(26005)(54906003)(8676002)(8936002)(5660300002)(4326008)(316002)(1076003)(186003)(40480700001)(82740400003)(86362001)(82310400005)(356005)(36756003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:21:56.6407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aab27a9-5eb5-4a26-0d5a-08db5222b1c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 .../nvidia,tegra264-bpmp-shmem.yaml           | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
new file mode 100644
index 000000000000..4087459c01db
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
@@ -0,0 +1,47 @@
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
+       #address-cells = <2>;
+       #size-cells = <2>;
+       dram_cpu_bpmp_mail: shmem@f1be0000  {
+           compatible = "nvidia,tegra264-bpmp-shmem";
+           reg = <0x0 0xf1be0000 0x0 0x2000>;
+           no-map;
+       };
+    };
+...
-- 
2.34.1

