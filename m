Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60843714B50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjE2N7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjE2N7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:59:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD2109;
        Mon, 29 May 2023 06:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1yo7yc1Di92O8pAzQePfuTlokVerB6Jj176rqc9Bfz/eChmgIMQSwshgYtSwm6BTxOSv+kJK3q4LdvPGUryxda3bvbkn1IPRxOHAoYY4hFwc6fGRORfuxjg+aL5vJJoJnSG7X830xEQcTiSowVHHuqn3885tRrNJqc1BdGUr0oTyaLo+tlbKkhOmHsTFtDArFj4l/BCpwqCOhQoO7UqE2C4YxMlE8/2S9iQ5QrFt27H82zoZw+kbey9kkrLwzgt8tapVSj/TvQ0sMEZm2PFcU9ZQ2xFPEU0AtFIrjQY/PAe9cAEpTYGZx39e8wP7c4lQARhTMtaW9y2oA6SJ+i3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN/QAsS+JtVcZgxu0bj0VBx/wYO/cktxS2awxF6uQwg=;
 b=h/ggvNDPT7M24LrQnII/eivqjMUHV7PkMN3di0qd5ek7ajYT4sBigeItId1n6zhoTFqxqiEnGlxJ4lWaPdfS+/l7kdoXzc5SR95cLnEebJGG1sGkkXXAeK9/1Zo9k8WiKzSOmgQBCGDh5sPJdu4yoFbCWheQZ4Iq0g4t2XQOvTJ70Q3NcdtIoLjr5zNBKCFT1TR3afE6ChsBeBGWBgk98g9F/apufl0QJQ/5eHQT1Y9bFf3Uzh/tGhS6hYPYl6n4RBgzmOm9HGyWPo/6R/uT2nX9JSFwm35UqJgdcEkQ+fJZNkbyYZYP4o7NxPv1ladBuRBiC5B6wAL8RD6TVoCfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN/QAsS+JtVcZgxu0bj0VBx/wYO/cktxS2awxF6uQwg=;
 b=GaRsCRsqbkvPrlKQEkt3S487paDeAnxSVBhHejshed9jJwU9OsKPntaiYfVaC6Qgr26dw1M7iS+SiH9+uiWPLXtOOSlvEX3tLZM1WjM4v18tg3Tyd3GYGuM5Tq0hoZ7tqI82nLQxfiMD2Unnm9Fil8CKzHpKQmvYcEs1Atx0MBH2I1hZFWFuWauf/rx6tJzfcfNOgwReA3kKOJ/Li1H0ksyMiUbsbQ3OViAiz5LQ6V5H4LwydTrVC7fHmb2NByA1l/cShrPFjBcHfrecVnSO4GNtNFM7LLLvxvvb7+3nQ7hY5e4KyVEVoGIMrK2bHxwNVus+6qteb4vgyf2L+le9rg==
Received: from DS7PR03CA0169.namprd03.prod.outlook.com (2603:10b6:5:3b2::24)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 13:57:57 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::9e) by DS7PR03CA0169.outlook.office365.com
 (2603:10b6:5:3b2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Mon, 29 May 2023 13:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 13:57:57 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 29 May 2023
 06:57:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 29 May
 2023 06:57:49 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 29 May 2023 06:57:47 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>, <stefank@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 3/5] dt-bindings: reserved-memory: Add support for DRAM MRQ GSCs
Date:   Mon, 29 May 2023 16:50:47 +0300
Message-ID: <20230529135044.2746339-4-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
References: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4418cf-4a07-4561-7738-08db604cb51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1F+w+jB3t4DhQ4QapvMA/RH4DhHYmbUH7cRH0xTThVj48SrGU1sIfMve39HLpBqLECn+wv3bG/EUN2ssUkPutVte28xkwTzI8cYfp7emlYgnw3GpsL6DQ1g8olsh1LcGEdPRigJa83WXNyakQHEESlJxhwyyiS6+dd4PWbPt+DcKFm+8pTXMcHostxeubBlOwm6vnj8qf13Zb04rztiLCHSUsNJR/jxewClrM6NaaJFft9z9vPLPu2Hq2z4VuqeX4COmR5xPBoNz5Ny2Qq0JUvKOdhZY9GQ1C6zFuN6Yk2YetzmYgRgnScT+bjdHWz+NDlMuPpXFZpEBZEfMGqZSoaQX0H9HS8rDV1WgZBEBDJB8UBdHl3QItJ+1bDpkMqfza2TovARVdGtpWu4QrfQXJIdOsZCNEI55tXlofbznf7+nErZaIG0Kp4d8zJ3m/XysVQELxY15tiZt1lgvQIM6BIGhR5oJLwh4UHD1Xqi7b/iJxAf2lJGFH5LXiIUJTld9C2+sc/KTNMLVqTs6g4Ry9/KiDwn4aOfD+n5+AnI5sdcO+mlUqKWgzO4kgtZKV0RvHz80VxpeX1wW4tH6Mm40/OiUl251ABLMgwVKcyD+LdbEerm5gM/BH0gSUcSlk6j4+KW/f1WVZD1jeBVIvKk5/AvqDaP3ns1gZlz4vE2P83XZK6/TG+hCwVkuIx4rePeaifyUpvusMEgxtQAirxCUCSTt9VoKfHUtKbjr7aiDE8TZ/L7oRPibbjwcSgQ5VLEBMWT07IYWJxOqMSB/TSUrOfvpAsO058pDnnaKMCDXrPBGpp8pWZTqbavVjoApW4Kv
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(966005)(36860700001)(47076005)(186003)(26005)(1076003)(41300700001)(2616005)(336012)(426003)(7696005)(110136005)(54906003)(478600001)(40460700003)(70586007)(356005)(4326008)(70206006)(7636003)(40480700001)(82740400003)(316002)(6636002)(7416002)(5660300002)(2906002)(86362001)(82310400005)(8676002)(8936002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 13:57:57.3973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4418cf-4a07-4561-7738-08db604cb51c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for DRAM MRQ GSC support.

Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../nvidia,tegra264-bpmp-shmem.yaml           | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
new file mode 100644
index 000000000000..f9b2f0fdc282
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
+       dram_cpu_bpmp_mail: shmem@f1be0000 {
+           compatible = "nvidia,tegra264-bpmp-shmem";
+           reg = <0x0 0xf1be0000 0x0 0x2000>;
+           no-map;
+       };
+    };
+...
-- 
2.34.1

