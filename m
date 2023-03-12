Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9BF6B6265
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCLAqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLAqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:46:20 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490703E0B9;
        Sat, 11 Mar 2023 16:45:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf8vaw5zk5r57pF+YyUcPplYeZV3bmdXDZByijTs4N0IW2nKx0xvRz54tRrWda2F5ju4cZdXS3w+8GJeedI9qBUOQ/lfAXsyMtJqlIhsIdSfKe/8aPFb2m4L3azuSwI6ARn54eohpAjSPVuUP5YOxM7CoGdNYRo2xrjj7YnAUQEB1xOjeUtuwh7uwqT668qjqy/43QTh4NWOaUuH0WAxn1E2fwEGbbNw649cWv/42j7e9uTqqOklJWJlRiU1JAJd6HE3Z+KKjh0PWOZm6/f2nPaaE2PTUgpu7QnDbSO0Kb7Hz7mIV4C+F4aB0f9uwqY0/MhtfSQeDkBbmyA1RKdgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ5Jpf1p3ZxiQc/sni8YZT8EIdM+0r26BcbMOk9WPmk=;
 b=ELoUBF626AmGTBC7SkE9Wfx2cQWGHkSiEZ5UrvXu1yow73hN/MGuajK0CviuZ58+WvoOk+5E1m6ae8ObUPPRY61BrO5h9z1dNFcw9FEAL3K+4/3G8bAA3NpUsBs68c/B+AsdYY1ONRJMhF3IP8X6MI2j4OLGNG2Gd0NZpinzrCjsVLh48H9lgF+XBl4cQSg1L6cfq0SFIgfaKPUL/plV8Wf0ZyQUARoWojSchTviUeJvb3eTEEJ+k8DdNauSkYB02mCE6pnVIECx+IkVaVQyCrGMQGG8XDcZ0Yj7RORMXWjtMxrLtwBY8bbshMUjtDVOwnkPkI1pOjgK40y1qMp6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ5Jpf1p3ZxiQc/sni8YZT8EIdM+0r26BcbMOk9WPmk=;
 b=0HcSwOMxjExULaWVDab4llTn9MO39SpAocSBnXD1U/64VBHhp3HxwaRLLw1VOtqQFnX7+tOnFcE6KLfsitHG1xsAkQhA3bhDefZ8IXnMHZG1VAT8mj2s3dsp0+ZYBIS1p9QjfapE/bwCjkbqEzs9T/d1ILPJOLbIdttbjgD0XTs=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.23; Sun, 12 Mar 2023 00:45:35 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::d7) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23 via Frontend
 Transport; Sun, 12 Mar 2023 00:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.20 via Frontend Transport; Sun, 12 Mar 2023 00:45:35 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:45:32 -0600
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
Subject: [PATCH v11 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
Date:   Sat, 11 Mar 2023 16:44:34 -0800
Message-ID: <20230312004445.15913-5-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eef2146-42f8-443d-cfb7-08db229317b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERligMsoxTiOBB2MNX2O2/LieS87IiMwcvZu0lVBuu2Dre0lAFkMkxG/YfIfSLJus3TA43hr7bUB0TrLdI57agH6XXobfmympReZYe3aKUqmnCFcl+hHsh4YdFkDTBgb4sMxC+WBXvErEdTz9KYIv8b6gBz7yUEdSxctpO6uJy0IoK3lcNjuzqKXWZ8JGuVy4G+RbrqB34T3Fcqq6AOnzq+77kR8wefPVD0FdvhnTaqvcMpo21gL4qY7IEWCkAETFHmYwyV/by3BoWi/CKLOgCec7L8I49hf0CWPS+Ssa4tMA2bOCQ2N4lB7rou1K7xWSIQ6mDbMbJSx60z6iHcPFRKA06T6PbZQp++aDzEY/R3PYP8i2/vDL39d40YTP7+hrsXRZ1Ag3uz2Uf2NOjZkZMHE9A/9Xjp62gpd3MrOB0nxdC0hGLiftrP0DWzx+dHgD2YtW6MrkmY3Yhhz8iNJA7sALg/LbWLTL0+Hy4/dqqdmLwwDEHP/mICzbaDGhOXW0lzLJEUsNp5e+TtDr5voa1PNa9vSXtEBhEudp6wFOidQKEU50gxXNMvLISsx4gWyV6513Nn5ljt/NBVP9UxXg/CH8NpAABVlhABFIJrYmBFrBvYX106l2JINK/01vSyMnWp3+v86zAUg9lz18KuJ1Hhf5wo4iV685N608ABk/W6RUIXAxvUHA0XiTwyx8aOrcGOqJQlpd4kkiPIBiyHVwD8OzAbXN5Bt8i6/pBU22Q8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(7416002)(7406005)(5660300002)(8936002)(2906002)(36860700001)(356005)(82740400003)(81166007)(70586007)(8676002)(70206006)(478600001)(4326008)(6916009)(82310400005)(40460700003)(41300700001)(40480700001)(426003)(47076005)(336012)(54906003)(316002)(2616005)(186003)(1076003)(16526019)(26005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:45:35.5538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eef2146-42f8-443d-cfb7-08db229317b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Pensando Elba SoC has integrated the DW APB SPI Controller

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v10 changes:
- Move definition of amd,pensando-elba-syscon into properties
  with a better description
- Add amd,pensando-elba-syscon: false for non elba designs

v9 changes:
- Define property amd,pensando-elba-syscon
- Move compatible amd,pensando-elba-spi ahead of baikal,bt1-ssi

---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index a132b5fc56e0..2383d6497b1e 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -37,6 +37,17 @@ allOf:
     else:
       required:
         - interrupts
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,pensando-elba-spi
+    then:
+      required:
+        - amd,pensando-elba-syscon
+    else:
+      properties:
+        amd,pensando-elba-syscon: false
 
 properties:
   compatible:
@@ -63,6 +74,8 @@ properties:
         const: intel,keembay-ssi
       - description: Intel Thunder Bay SPI Controller
         const: intel,thunderbay-ssi
+      - description: AMD Pensando Elba SoC SPI Controller
+        const: amd,pensando-elba-spi
       - description: Baikal-T1 SPI Controller
         const: baikal,bt1-ssi
       - description: Baikal-T1 System Boot SPI Controller
@@ -136,6 +149,12 @@ properties:
       of the designware controller, and the upper limit is also subject to
       controller configuration.
 
+  amd,pensando-elba-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Block address to control SPI chip-selects.  The Elba SoC
+      does not use ssi.
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
-- 
2.17.1

