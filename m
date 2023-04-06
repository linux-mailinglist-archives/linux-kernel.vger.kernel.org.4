Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FC36D9E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbjDFRUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbjDFRTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:19:34 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF97A5D2;
        Thu,  6 Apr 2023 10:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DglYwgTIiAPXuHLLOuj945A1NEE/ugxEW/SCyLLGA098g3Qe5IRyUOlVCmxwEgqo2iCWMJMRnIcxaunuoHp6+3EQxTJ0Hbore+vqLIK5blIl8/+hCY4W4O9PDj7bDfK+xqs/7cseP+j2jQQj83shUBNACPZZWp+9D4YN/QRkvV/ipiYju6sUVO6pMVqWOc8sfNcYt0XGzO0EvqYQ9aX53QRfaGSaAMke72Oxs3/NaJxoXvR5sLb8PIL0zbPdbGAQqSAtEL1MfWJAo0eDqa76SUQmdHpqPcGSie7qOGQIh2V09VYP1Utd3Geikwj0w015dguCnywbGlnH06GIgeIRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03KGcNgzWZAGbU8MTWJAjF5hG5ie98vpsUZywcVmaJg=;
 b=A2eP4y5xsoZRCWjmQ9IFSG6E70Uv0vpHi9eR7IrETOXuxQyZ9d7tIsOHDgy60Q+DUPAMMBQ2O0obnlDoAK37K04jw3v5O7wGYHBczMzNKVeRiOw9beoHHWXCQsq8UL4xzNbrIVQ3ULmcONdbHKT3v7aFj5hc+FnlHGmEPNCy2dl6sXOL3Vq9uuOLm5rLMF3bczAm3NpQVUk6mqn3Eah6XabEFQ/NgSd7QoqiuRyDXK2ndvQhIJE+bgjRNhkVK9buGQYDtxRuOW4Fu1M6fWFMXRgLsShhePCeKPb4h/hqvD9TcvhySt1uMZzsy2uxK1ppDIKGMJDgbpqiHrNwxQzg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03KGcNgzWZAGbU8MTWJAjF5hG5ie98vpsUZywcVmaJg=;
 b=tRz8PS4trFem0MZ2neKwC2ahreWR+71mGJhjA1YFVYCBdEGNn4nHvRUfVp0Wi1i6DCwmK68o/lBD2UIBMyONFFXpvF3+motPV1DNXZhXUJqJQtKwquLu4KsISvyNNzEm1+m18MuyEE4yyB3byTca/nQ3udb3oryq2pIZrPbKZrbCVACcAXlX5yap9XE70T374NYpOMW8XGJiPOxbc1UNl+405r9EmDr+kbPhxq6snd6JMyZtdXu9kq0Q13GSdpBJPPE+yMwq52niLgdpqUL8uhujJVRByrUXSwdjMqACKSUl2ZJKDzr0SGV6b0457ob1OzO5WscH2eJRnGhJQrLxVw==
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 17:18:55 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::7d) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Thu, 6 Apr 2023 17:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.31 via Frontend Transport; Thu, 6 Apr 2023 17:18:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 10:18:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 10:18:40 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 6 Apr 2023 10:18:40 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V5 03/10] dt-bindings: timestamp: Deprecate nvidia,slices property
Date:   Thu, 6 Apr 2023 10:18:30 -0700
Message-ID: <20230406171837.11206-4-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406171837.11206-1-dipenp@nvidia.com>
References: <20230406171837.11206-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a9e8e8-7ebc-46cc-b94b-08db36c3001e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jgixSBNYeA2xTahq5Lo/unGEwEbH/rpNzrYwlsl92G4wkN810IA26NLI5kGVN8KZBfrMxeq/Ccdr/Olb+vni4APpjhxQjzvZCB0rUT2k1Y1QQ92WH5MOdhtvmr9v1+zGfZOrSY2BB1RcU99YvRJlJlo2WCR+2gujCW0uOzUuFoRIpcPXfQh0DM3tUyRDSca8CUh4XKbNFqLGSZ+uQwad5+Rel2eqSGpjeT9S68WLM75pq6DDpfduJfOord13JjvHNYqiFSe1UOH4tOqq/Yxh1MJcbhvNz3B+zAUGwyexPcuygd6Sli6UXBlQmYnh8YiH28wohz7llZxcPv0qDG9obNvms01RNqeQl3/Ys+158R5Brwlmy/CZuxwK+UM5Vw6uGZN632C7hOdsZx3969zkuijVKRiRl3O/PQRTemTjlkuTsV0NzTY1/6KanIzjpuuJnc0/a+u/smUZGgoMth4rgVbOugHTnXhcpcZ+qvOF/mgCn7tuT8duCCy2GkZg4n25zCiBAdYKGE5GXhzKBFb2ITE41wAIKJbUWrvcG/pE/17YVsRg7wcYftKwzEo8b1jgywbANSpvQjySnZ9brJ+2syJzU9mGAVDcOfDq3ahMENSa/9vIXn8bCoO3A9/Ind6wI7rU+e2uiuSLzjhpjXHUMP8Dw6RR4h5X7+QQaErS/f7jAmnxn2XIpmr3pjFacXkGttyx/YMpOVcjnsK1pbaFfljQGpM3r7h1AfvbYJ4u+KJ9ne3VRBa0aR1Nw0jqCSo3Mr4J6sTW4ykV0xM/yU40PPE/mio2IJlOBJmvo3k5GcNx9D4WaERP3hJOqD+j6ts
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(41300700001)(8936002)(8676002)(4326008)(70586007)(70206006)(5660300002)(7416002)(83380400001)(478600001)(110136005)(316002)(7696005)(40460700003)(47076005)(26005)(36756003)(1076003)(40480700001)(186003)(6666004)(2616005)(336012)(426003)(36860700001)(82740400003)(82310400005)(107886003)(7636003)(921005)(356005)(86362001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:18:55.0030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a9e8e8-7ebc-46cc-b94b-08db36c3001e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property is not necessary as it is a constant value and can be
hardcoded in the driver code.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/timestamp/nvidia,tegra194-hte.yaml           | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
index 158dbe58c49f..855dad3f2023 100644
--- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
+++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
@@ -42,10 +42,13 @@ properties:
 
   nvidia,slices:
     $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
     description:
       HTE lines are arranged in 32 bit slice where each bit represents different
       line/signal that it can enable/configure for the timestamp. It is u32
-      property and the value depends on the HTE instance in the chip.
+      property and the value depends on the HTE instance in the chip. The AON
+      GTE instances for both Tegra194 and Tegra234 has 3 slices. The Tegra194
+      LIC instance has 11 slices and Tegra234 LIC has 17 slices.
     enum: [3, 11, 17]
 
   '#timestamp-cells':
@@ -95,7 +98,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - nvidia,slices
   - "#timestamp-cells"
 
 additionalProperties: false
@@ -107,7 +109,6 @@ examples:
               reg = <0xc1e0000 0x10000>;
               interrupts = <0 13 0x4>;
               nvidia,int-threshold = <1>;
-              nvidia,slices = <3>;
               #timestamp-cells = <1>;
     };
 
@@ -117,7 +118,6 @@ examples:
               reg = <0x3aa0000 0x10000>;
               interrupts = <0 11 0x4>;
               nvidia,int-threshold = <1>;
-              nvidia,slices = <11>;
               #timestamp-cells = <1>;
     };
 
-- 
2.17.1

