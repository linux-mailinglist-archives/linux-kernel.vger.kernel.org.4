Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE46C5BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCWB3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCWB3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8399D272C;
        Wed, 22 Mar 2023 18:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjncYUJfh8ufht0/a0gq14ZdHVZ2IUmqfYNrh5P3q48z4oYPGabq0NO53UQHg79AyNOtrvDGfHL1iqCcwEx3SQtsemMU+4IhOrW4MDt377o3/lRrUqlTwDt+LPt1BQyAfmdoXBTb82Yb8S/WoTLfzB1TCFpH6KBJ2ga1n08PdqQkjyYFD0C9mOBFPRbfrSuYHs0YtIy4lPuIEhcFzGrA7ko2DvwgJUTiLeBZUElRdH7uLC75y5AO743mfO2mLWAKKCBxwisi0r8rE1m4E4124zbzy4csNpfOxrmTCrodrRtpyDwD5uwPN6cxozNB1v3848/+j+yubSOC5Bqu5KqpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXcxWxjWhxhBkMWqcTnUOeQp+YebY9tv93uPQ2Lf9hk=;
 b=C0bWlfUi3lrqKDCP3mK+x3aFBc9VkXIhtNXP8ubCkvfgLKM87kLwISYc8DMchbgFV7x+xlekQK3iYrRkEWehjTdgjkH6J/YQBrJS93FVv7kvI9o7b10i6/5PLPqwSTZnDNBbboSg2WC1sI13ttkpnxPr13EqmsJlM8dyOuekZyqaRZF+pPfkzzEapJfVNecLc0PqY+XQsR+Tij+g/en7I0kKMOuccQcalLYrGg7o53Xp4i/LK/xhuDcaz5ciJXtFukWS/Va5eqo6DT+JKC8VBWh6HWvAy15CxKGPl3OogB4p4+O2Oyq+S4UlmTNW48vFli6MLaRmen0s/vLlaKRu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXcxWxjWhxhBkMWqcTnUOeQp+YebY9tv93uPQ2Lf9hk=;
 b=fHSEFCLVKFSDDY24I1lwvLS8ANcFGtVxEx0fdqgSmaBj+mfTX6jbYaKEzZW/jpfLG4ic8m/vD30GPLqqBaVOqmGvQ4saOQnC2rj6O1vlxSkIQLf3kukPWg5dN2ebkNgQxBWw86Oghsvegyct549DE66WH9wC7iui9w4AQb++GTL6z2hv9zOUWVBosclW3q8IZXHWcWg6IrTJE8szsYJIjm26ckrZTmU2dRM/6xmmrmCF97QSyEQmWF0QAAYC84qFVqVC/l21oCH0zZdnEawFSbQ2kb9m33x/0HaJkCG7jAhveUEEhxEwMhhRWJ/bB9zCLDyx3p8Fi2eHtJaEF1JitA==
Received: from DM6PR06CA0010.namprd06.prod.outlook.com (2603:10b6:5:120::23)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 01:29:40 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::12) by DM6PR06CA0010.outlook.office365.com
 (2603:10b6:5:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 01:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 01:29:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 18:29:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 18:29:33 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 18:29:33 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V4 03/10] dt-bindings: timestamp: Deprecate nvidia,slices property
Date:   Wed, 22 Mar 2023 18:29:22 -0700
Message-ID: <20230323012929.10815-4-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323012929.10815-1-dipenp@nvidia.com>
References: <20230323012929.10815-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7a71cb-309f-43e8-d315-08db2b3e12c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dey7Q0o5XjGuYBrRfW9BTs89/EvicS1Z5cFMBka7IfmnT6JnWZRneEqr2MUoYitU7YyT+cfx0/gp7x54pwDV27NdNjPhTZpVvZ17tCzHkUvV+b8Zw9rlfwFXwNIpKWZunxBGLOHaA96ptQWVxrV9mhYUfBkC0kKmt6xe5ZXuWXPyZnYkP9hCibOP3/AgvTRqQCTdlP0uN/nmvZKPhIdQTEQq3UNGGh9lADjpxTNN6kqlYa/KBjp1lxkspjxV8vDkrzQ6voCt8pgUOqdqp447bc93rgcJdexHtxkzS+dHpWOGeTDMxL46bSylDIjXp48n32+/6fmsThq9fDL+zK+K+H8QJ+R46SYutxzNrdPoEl6dYIo2ypVo6xqGYt8WqbQ6TRIFQkntLjlGeoRglfSYSl3bG6SZU0EeZXOmbNScns71tbdTgWUjH0g6CXPfGRaqUKwM2/8m3uRHJa9/Uvqg0Amkxi52Fo+3Bdnh3ig0J1jKgkKkv5byfHj2VrazIPUcm7x34sFt3Vf2aJMzO7sjrSCcDH7JINR113dvG2iXcQfEcTnPJ0XQZXAnxBQ2OQx2AcGvnMc/s5SZT4vENQpqas5PDYea5OoYG3sX7JA67SYj5RAYK35eGvo4+IT6I2xvJJXPfYEJsnWjbonQ8+G05VzmynMFPB51UlTEAmsZw950G8rg3whipL6+J6RCk1YtxuSVNMRxiY7RFf4xlXY5ZewUO92gzbI9EXqdsGJFHSCa92tgYBBcbbdqzdR5Xzc7wjYvS8csvDHfbtlnkisl3t0xb+h7JbRzqwIz7NwDBq6le86d6GT4BrbXzKGydFBC
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199018)(40470700004)(46966006)(36840700001)(41300700001)(5660300002)(7416002)(8676002)(4326008)(2906002)(40460700003)(36860700001)(82740400003)(356005)(921005)(7636003)(36756003)(86362001)(7696005)(1076003)(107886003)(6666004)(26005)(110136005)(478600001)(70586007)(316002)(8936002)(40480700001)(82310400005)(83380400001)(70206006)(47076005)(426003)(336012)(2616005)(186003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:29:40.4506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7a71cb-309f-43e8-d315-08db2b3e12c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property is not necessary as it is a constant value and can be
hardcoded in the driver code.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 .../timestamp/nvidia,tegra194-hte.yaml        | 43 ++-----------------
 1 file changed, 4 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
index 158dbe58c49f..eafc33e9ae2e 100644
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
@@ -56,46 +59,10 @@ properties:
       mentioned in the nvidia GPIO device tree binding document.
     const: 1
 
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - nvidia,tegra194-gte-aon
-              - nvidia,tegra234-gte-aon
-    then:
-      properties:
-        nvidia,slices:
-          const: 3
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - nvidia,tegra194-gte-lic
-    then:
-      properties:
-        nvidia,slices:
-          const: 11
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - nvidia,tegra234-gte-lic
-    then:
-      properties:
-        nvidia,slices:
-          const: 17
-
 required:
   - compatible
   - reg
   - interrupts
-  - nvidia,slices
   - "#timestamp-cells"
 
 additionalProperties: false
@@ -107,7 +74,6 @@ examples:
               reg = <0xc1e0000 0x10000>;
               interrupts = <0 13 0x4>;
               nvidia,int-threshold = <1>;
-              nvidia,slices = <3>;
               #timestamp-cells = <1>;
     };
 
@@ -117,7 +83,6 @@ examples:
               reg = <0x3aa0000 0x10000>;
               interrupts = <0 11 0x4>;
               nvidia,int-threshold = <1>;
-              nvidia,slices = <11>;
               #timestamp-cells = <1>;
     };
 
-- 
2.17.1

