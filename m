Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1776B625B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCLApr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCLApp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:45:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADAF3D0B0;
        Sat, 11 Mar 2023 16:45:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEAm5tXbXefwqjpyckbJ40K7aniueEGMvIVUhMYMA/bPB4Az5z4KpIF5Ezs8OEwAcX/ssw1cduhUmC54hfSJGNHfbmB28IhDOdZD/LRorZ0QA+t8eJzqWtDpnHGEbwx2ZSgDve1Wo+qvpoq+BeFmcif57cloaRMaynszZqFyRCaNSIHJ6ekXHOPHDmWUjcmzrTYg1Wi5Rot6r9MkVeMDfU/chC58E225v22W3LAQqpA3WBCYFjOstSfHpJPiaH6kmy7YfY45sTH8x0JHq0im2tblHhlzYgeTOmB6+TERboj+rbQxT2bE3t3eS/8Mjn10zrvsbRJgPws3uelBkRtmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxxkSNpbyALd5CL9TnC1zavQ3gq/W90Nja6dE98DxFs=;
 b=Y46h52TYw882FoEHQmL/ZjFccp+euSY9UFCqickU4RByfLkR9XXlO3ziJGeD7M1o6ambrzNzHqkN8GJWGII12rr/h4WU7ZXzWpwwfhWIOoRighsOumSvquHtjnAZld2uXoQ2TJ+HWaHYswAvRtEeCDihndwEe5CxPVkctJjGD/tDqtUlLTWDtk8rJhuBbBITpDixmLDoL1z7DZNEVM5ancxsUf2xd1QfQ3O1/fqxkJeKdgHC9g7rj2C+UxF4KilZQ5FJ2Cd51gnF5xOoipWslNNUS5J0NawxWRMGSCvLPY4EwzAmdjmN35t6s8CXqEhQfO/DGKjVEKbxjNeC99HutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxxkSNpbyALd5CL9TnC1zavQ3gq/W90Nja6dE98DxFs=;
 b=3DwMdD5Sa+qQ53hgtv6fiBwQfaVzkTDlS07R65MFcjuzoDeAd6aXabPAwws7XGy75hCwSY5KclaR96YH7tmARuBsrBqsmptUpooowA2KmwJvLoRmBQBoLy7bZgDsAScOlqJGiSrV5/uOPsjBv8ENPsges0yMD/t7dIcci7wmBFs=
Received: from DM6PR10CA0035.namprd10.prod.outlook.com (2603:10b6:5:60::48) by
 MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Sun, 12 Mar
 2023 00:45:19 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::8b) by DM6PR10CA0035.outlook.office365.com
 (2603:10b6:5:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23 via Frontend
 Transport; Sun, 12 Mar 2023 00:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Sun, 12 Mar 2023 00:45:18 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:45:15 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v11 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Sat, 11 Mar 2023 16:44:32 -0800
Message-ID: <20230312004445.15913-3-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230312004445.15913-1-blarson@amd.com>
References: <20230312004445.15913-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: fa615764-cb66-4861-d3ca-08db22930db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvH4SNvYttqPtBILcZXyXfw0mk+j9MHrdkGVmkF+fpPrExzilNRt9OleNyaqnPn0q2qiI+YJT6ADn/FmJ+uZaXclLZmHYVQg7UZmNBCmcUOC4uqeaAII0ISliWZopRQNaDArgH+yukqyvzm8bHCO9uK1DcLDL69ihcaUJwrJuRX3ooOzeNO9EGMFiEwyL0yygqDs4JprO99M/zuaMm+suByvvDEZKtplNkPyRAKR9scKrcSVbZi2RB0abdOImfSg3d4OP/alB1D+/n3uS3Letyq2sb4tgATF4ObjMMxYIz3SALsG+14ikIl3dp/WQNAtYaxySNfreYpYJZxW67BhkB6xfFRE51iEqjz1t6RCh+bWaHaUQ0x71DOwlO1r+75p5jBKiFZe1h/IlIiLApZv2KLwxA6rouRQWnIOtwpGZ9DIPYitk+AY5k5mlCsTKL5f7VEnrYpIRteoe1Q14cdskGUb3wWXnBXeAfAwa8B+xYZ2Z3LewhH2AI0vwxQMl8f656W3o5K7f37DUT9HlLmfaH223R5RmJXLKHxdSHT8lLIxF83m2Azb2zPZdlsWNBZuiOCrVJCNqolw4Stjv8ub73TQeC+YLXMmhcdbngUnWv9uG4y1f/lgYN1pzVwKYAk01K8evLvdcGxYZHRYs/Wi5arG81L4Pstsf9Zvy5qzcLlFklBjLcIykT409BKXUhyOgjrNafATOKcX75SRHiz3EHlL7kejSFAvOR0YV1fCtSc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(81166007)(82740400003)(83380400001)(40460700003)(36756003)(7416002)(7406005)(5660300002)(40480700001)(70586007)(70206006)(8676002)(8936002)(41300700001)(6916009)(356005)(4326008)(54906003)(36860700001)(316002)(16526019)(82310400005)(478600001)(47076005)(426003)(336012)(2616005)(186003)(26005)(1076003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:45:18.7414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa615764-cb66-4861-d3ca-08db22930db1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v11 changes:
- Remove resets description and reset-names
- Add descriptions for amd,pensando-elba-sd4hc reg items

v10 changes:
- Move reset-names property definition next to existing resets prop
- Move allOf to the bottom and set resets/reset-names required only for pensando
- Fix reg maxItems for existing, must be 1

v9 changes:
- Add reset-names and resets properties
- Add if/then on property amd,pensando-elba-sd4hc to set reg property
  values for minItems and maxItems

---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index adacd0535c14..3c511c02e8a6 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -9,19 +9,18 @@ title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
 maintainers:
   - Masahiro Yamada <yamada.masahiro@socionext.com>
 
-allOf:
-  - $ref: mmc-controller.yaml
-
 properties:
   compatible:
     items:
       - enum:
+          - amd,pensando-elba-sd4hc
           - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -120,6 +119,27 @@ required:
   - interrupts
   - clocks
 
+allOf:
+  - $ref: mmc-controller.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,pensando-elba-sd4hc
+    then:
+      properties:
+        reg:
+          items:
+            - description: Host controller registers
+            - description: Elba byte-lane enable register for writes
+      required:
+        - resets
+    else:
+      properties:
+        resets: false
+        reg:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1

