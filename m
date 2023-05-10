Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A3B6FDCE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbjEJLiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbjEJLh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:37:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9057A7D9E;
        Wed, 10 May 2023 04:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgXlKBMqhAHltmK/nDo4Tg6Kh3RI+vDdWKkL8QOkaBjnbk0B4KiQEBf82WfvaJYP5UZSV4IEPF+l02jmI349CvIiqKoZefIaxV4BpP8zFFRrIxKgq7qRwy9u1Lf6nbDUhi62OiERkPy5acZW26V5aASC67GnV3Peh+NjhrntJcSohF+vHKBMlLoZZOD1/k30/V8XYBk4a6/moPPBWigZvZ7vq8hA067hi52kE0FH/lOXAhSdak0jP0R7x2kRHzceU0Zx+NcgHhDyJsfIBJoMsVWgZgkV+7VWDs/B8Ey7pk77vC9J8+JlzymqPg9nYTwmfuzJf9e8vKTI7ZIRaHX89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLbpQVxDrVejfcTM/lgsnUfRWa0pYoPEX6QosRNCiXo=;
 b=n76v/JW9RypYb2fmk6SNT6mmVgQk6dkre9ug+snHQfwVv4V9Hhm9nbsuFaDMZcX2dVOwLEgSyPF7d631+Bur7k5/qU6T8lD3NqNjOGJ9o36C3R+uG/GcOARqULZ8E/p5DLNJcmSq8/5RprjNiBOtlE0EIpQ2Lm9fzkcJ/X/hnrBtRrUnDI7/kDTUjKAF2TMyk925tDjQWWpn6611A6GAJ/B9D+yD2ChcVN763lVk+Ywvjop8dIYSF89KHHv4ZfZfozK5RB8/wJYLwdJvGdZYpN/Yedwqihms9zIyWhEyj0Pxw6u/1i8qTa3Ha7mJurLpOos0jiSqpV1fIgXpLWP+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLbpQVxDrVejfcTM/lgsnUfRWa0pYoPEX6QosRNCiXo=;
 b=DemyLuAXKD4TZtCbfAePxrhyaqlBfWiEZYQc/33nf5sNzbfuSEDJZpARKS3NEkmKCzwIeB02kYVhYL7PNVTLVHsmiL+W7+A6DrAuzj66staN/JRGmYazQf8UDrFWnjnHxGYt6oKqwvmzF/LvvkKBR+Bjv0gM2msXwnh5WSDPkpGTZEug6YCkCGYveFjph3klonFKsYWgjghBdjZE5WfKTcr0ASkVgm0y8I03XDwCzxexYCzX6vyjRDIiR2Hl02EGRKOUFRUBSauql2Z15EWbxygXKlBUaYtYARA3m/viCisWhelIFv8k4EB6H6xiNBZS2ZccI043IZg0tH4todIy2A==
Received: from BN6PR17CA0055.namprd17.prod.outlook.com (2603:10b6:405:75::44)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 11:37:50 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::af) by BN6PR17CA0055.outlook.office365.com
 (2603:10b6:405:75::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 11:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 11:37:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 04:37:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 04:37:40 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 04:37:38 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: [PATCH v2 5/6] dt-bindings: memory-region property for tegra186-bpmp
Date:   Wed, 10 May 2023 14:31:34 +0300
Message-ID: <20230510113129.4167493-6-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e355ad-7677-4682-adc4-08db514afc55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2LNeSIRkSCZ6tElmX2OlbbPJ1grY9sRkn7aZ/YsfyE75KYJFU077tka78UfKegcvxehWfiX+QaIiBQOYkg7q2bvHTBM+qAKb78HnuBzcjODKXOkdELWyBscjZU99b17SDLHY8oIpKs+GUOItYdPS2H9IgohS6fNhWNcfp8NLRGqESo5uvTZnORS0pQSimm9r1N/ksL92DRJwOWENWz51XNLpDeVdZtyrkrOFXtFE6ni6geq4SvjH4teJkUMlOZ8G1uZ/VPA+fhK6RqTvXU1IlVWJbi+4Ps8Di9xp5v/+Y9bon7RdaBJGt1x9pvRtLwggO+c5FjM9Z8Y8VKgGdq7G+4w8nntTXZYb30QkeaaRm+UBtgIaxDNaa95I5H5t7+Fa32zwjEj+BjO1bd5m9AMc97h9ku/BaUCVTwXhVmQM8kvIcO8jf25Cs18TiP035viH5B2HBlYwPny9JsY4BVnIlqMsrLXfYjuurL4yNPVhGnAQlde3PkiSmZfRYPC3G9Ov95yXDGm7eDDgXXQsu1zM2clHj9h52ckxNohh2BOVLswNVDvV9ZGCMOmYu67XQmApsSODViclpPeSy9e7b3VCgYO3jbI9ynoJApDjHVAANcu249ahLVBb+qujC/uUqa/rX4C0ecxpi6Uq7xG8wnIjiNLS25xPmRRi0dIUY1CSAF4lywIHO/eiOARW4JE8NhtVT8uHRWLqCjTF0DhYl5R7A==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(110136005)(4326008)(70206006)(82740400003)(6636002)(356005)(70586007)(316002)(7636003)(40480700001)(107886003)(336012)(8936002)(426003)(82310400005)(8676002)(47076005)(54906003)(83380400001)(26005)(1076003)(86362001)(41300700001)(5660300002)(36860700001)(478600001)(36756003)(2616005)(6666004)(2906002)(40460700003)(186003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:37:50.4085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e355ad-7677-4682-adc4-08db514afc55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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

Add memory-region property to the tegra186-bpmp binding to support
DRAM MRQ GSCs.

Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../firmware/nvidia,tegra186-bpmp.yaml        | 37 +++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
index 833c07f1685c..f3e02c9d090d 100644
--- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
+++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
@@ -57,8 +57,11 @@ description: |
   "#address-cells" or "#size-cells" property.
 
   The shared memory area for the IPC TX and RX between CPU and BPMP are
-  predefined and work on top of sysram, which is an SRAM inside the
-  chip. See ".../sram/sram.yaml" for the bindings.
+  predefined and work on top of either sysram, which is an SRAM inside the
+  chip, or in normal SDRAM.
+  See ".../sram/sram.yaml" for the bindings for the SRAM case.
+  See "../reserved-memory/nvidia,tegra264-bpmp-shmem.yaml" for bindings for
+  the SDRAM case.
 
 properties:
   compatible:
@@ -81,6 +84,11 @@ properties:
     minItems: 2
     maxItems: 2
 
+  memory-region:
+    description: phandle to reserved memory region used for IPC between
+      CPU-NS and BPMP.
+    maxItems: 1
+
   "#clock-cells":
     const: 1
 
@@ -115,10 +123,15 @@ properties:
 
 additionalProperties: false
 
+oneOf:
+  - required:
+      - memory-region
+  - required:
+      - shmem
+
 required:
   - compatible
   - mboxes
-  - shmem
   - "#clock-cells"
   - "#power-domain-cells"
   - "#reset-cells"
@@ -184,3 +197,21 @@ examples:
             #thermal-sensor-cells = <1>;
         };
     };
+
+  - |
+    #include <dt-bindings/mailbox/tegra186-hsp.h>
+
+    bpmp {
+        compatible = "nvidia,tegra186-bpmp";
+        interconnects = <&mc TEGRA186_MEMORY_CLIENT_BPMPR &emc>,
+                        <&mc TEGRA186_MEMORY_CLIENT_BPMPW &emc>,
+                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAR &emc>,
+                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAW &emc>;
+        interconnect-names = "read", "write", "dma-mem", "dma-write";
+        mboxes = <&hsp_top1 TEGRA_HSP_MBOX_TYPE_DB
+                            TEGRA_HSP_DB_MASTER_BPMP>;
+        memory-region = <&dram_cpu_bpmp_mail>;
+        #clock-cells = <1>;
+        #power-domain-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.34.1

