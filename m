Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F156FE007
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbjEJOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbjEJOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:23:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E60735A9;
        Wed, 10 May 2023 07:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLfXIla/OwSTXFNz7Mtk1Pcng/UJDfdUTAD2rizwv+XtxGRFAA5MKIrsmAnOFmcRpRoe5kE+JbFmRIAgHzJ7NOrZYD9XJwG9d8fGYGiteioXORUOoYSYxOqhhjp88GQ4DttvcT8UKP8ZyLwSZ6b1t5ruRVRMxCKZkoLz0Yw92H6G7Tqrhy3KlroM/4MtiX/y/am/ZFtMLfwMmvKaVUh6lZmO9QxTXqe5AUUgHMcDHdAXWv09QvYbmBRtp9ysdWjUhNsOgwYuYQLDjc285LQV0i96yEOtiCqpRUax/yDsYdmz/mlTDyuVvxbDf7sLjql1eeHCr4b6HL+cpxOKc7isOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT4tNgGNiGKAN5SdvvHFpjuTp7p7ipQ92tQPcWbkDbU=;
 b=gS03bPQSpeL2HoDccKiJA2+liv4K10eS0+vqFVq/UG9xhe7eZmFbKR8jH0fMgp3SRDnnFb/QA4CpDLxGHxGLvwQvhiMBeHWP1za6A3dgjRTxvFmDjf8U7KvZSnaOu4ijj0iX6R0vko1ip3Bi8CBUSfWe+k11fHhsHJ+EErpZFEmDARj2NRbeErIlqdNCdV27s2J0zkABtzezr32gCY/kS236sActy/YnJe8QrjNAUm2AKcq5SzZnM0T/4KxNI/vCCUno2jlL5B+MjyWVnkwtc0o1OnXoU/SDJzIzwGe49xJ8Bv7xGPgGWzDxNU2XjQayV17IeIGEkkenOHrQt+SuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT4tNgGNiGKAN5SdvvHFpjuTp7p7ipQ92tQPcWbkDbU=;
 b=tY3s6Pgp9rSkc+dvWlZW9ZEplHHmE6H/9Fs7Rgakv7JoNNiBxzqpjUysyNqKUN/TIKyphMdLuKt4gFYELTOre1TkCJJEX7qyIRJ1XXj/PZp0WSgdr7gjGeSn4Z+KtD1GXitOx6OOZj84ALh7w/gOELUK9etuvRkcpRU4Gl6g8JM/666qoykWy6GOaKg0axtmwlDrMDCFqiXjnciwALAKNuT7QqgpMyLKuq/e4wWpn5Mp/gvUxX+K0CRwJCgS2N6WbyvxU7+TJd2CPMRY/BdvO/i5oQq8NsAsaeRHhendzXB2iH4hS6QEuNdtXJ/C+XTaTJa+aJfTFZsF2AM6PPmImA==
Received: from MW4PR03CA0053.namprd03.prod.outlook.com (2603:10b6:303:8e::28)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Wed, 10 May
 2023 14:23:26 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::34) by MW4PR03CA0053.outlook.office365.com
 (2603:10b6:303:8e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 14:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.19 via Frontend Transport; Wed, 10 May 2023 14:23:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 07:23:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 07:23:16 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 07:23:14 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: [PATCH v3 4/6] dt-bindings: Add bindings to support DRAM MRQ GSCs
Date:   Wed, 10 May 2023 17:22:46 +0300
Message-ID: <20230510142248.183629-5-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510142248.183629-1-pdeschrijver@nvidia.com>
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc222b6-503c-47ff-a6f9-08db51621e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sgrTaIuTf6eGJVbc8UwID3RCrSAZvk9dLGZBwSMPA3Eq+2SAgXMOvOZrtkYxm9FJcKprTNriSj5QAhMC3c5PaD6TfXRQNkJl1eJbX6C1KANoKpGRy68RTrUjmFRWEDRX6uPP0Ko2oZqFGoaioFmN4aEVc9xe9qlnrSudW+wKhcwECHag+J1gNMT3oScVLwebzQOCKmAT6TQRefAG2l5K7deH6IhSdLtZy1FIyhMxre3+FOLaVyPd+1U0RcNvsfg/NykYkookXL9uZifx00A6pRDYb26JGBPvy+T0rASwwz1wz8jTeQqz4+nhlNRiFNUbdOK9SJVxWH+PJ91/0/onIgwwpRlPVbgDlJLRYQRtDeJbXSwYhL6wy/kIPbqCtc4hiMFcffcYxymIEinih1rGomfT589wN3GR3EsCxKuGtFVV1aQDFjk0OnYf3NqJ07mRrlKA5imYop9HSenZI7PipvlzQp3QbV70k37C826K+aDGxwkNacyApGdF5vxwNA2ca+8eXw6lDUCShYCBa8QOBg6kuZrmFMD8bR9Frbjb2slKVYRn9luAlniE4uiDAWygTvkt20AQ8VBXPYHDthQ0TCzxYatMZ+MBcsUutKAab7eI+EP6nH++sZbXfHA7XwthtYCbyKK17A52i9Ia0gdBpk26ntFvUYGUIoWRQ71chg5VhAtBHHiodvN/WIUPKHWHdAX59ZfZlWni3j6dqUllZxllBw2JRaKFiTXrWUbHuANiFC3O0ujlPAiGToQzSTckWMuvXh8UFlIcm6vqEcsJJrVx1tTt5VqNJDZHMEk/qs=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(107886003)(70206006)(70586007)(40460700003)(36860700001)(2616005)(40480700001)(336012)(110136005)(86362001)(7636003)(82740400003)(54906003)(356005)(426003)(26005)(6666004)(7696005)(966005)(1076003)(186003)(478600001)(47076005)(36756003)(2906002)(8936002)(8676002)(82310400005)(316002)(4326008)(6636002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:23:25.9759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc222b6-503c-47ff-a6f9-08db51621e56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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

