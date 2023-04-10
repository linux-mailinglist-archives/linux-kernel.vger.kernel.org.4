Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208846DCAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDJSqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjDJSqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:46:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445811FDB;
        Mon, 10 Apr 2023 11:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhmSKe21BPokgN9g76SCmHChrM0yDeh8WW/EMWZG+tpie4KX4Z58mQPd/Ro9wyfWBSjfMh82ji0/tjkTcYQkrS1TliVziZIK2snZTIP2/dvGkAzooVJvm5/44xRkCUchNjEwDYjagqNvkqBaBKDhJ1xSSSHOTM5AHKT06PCAQnWjqjJKCH0wQM+weq+mZStU0jBaXGFq9/QYMhgzB7qaG3Pvl4/cAT5olQnQqiu+lLxLI5+ovQR9kRWZKHqx0YqEn9x7bo+daP6kHigyb4AGwtKblYHpJBAwLksr+OlkqM7VoaNOewiHZm7Op7yTiZJVgNKkLDP/JD8idS5LufVtHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s85HrBK30oYhm+SLURSRXrLkNTK5QT6HCkbpb+RlMFI=;
 b=f39AdSgmN7mi7oqZTbTn9NrPcuGwYhW5SB02BOkCcCwyL1b8eWWRbPRLHPCW52MT4l/fNaLEU0zf4YRvPa6Q1icRuLUJvU8dlc9ot8TxetF7H/RgdbTnaheROLZbxe9YYTUNJLgWi7b79vBK+m1owJcBSu/fIBTcb3oG+Odp6Bv93/ZFxuy2rrachzf1OH+1pKtJ/BmDxdv4OWN2WXIJvuQofVPkJOR5i3sF675VP7ezr44YaPujfwDkCSQNp72RXC4n5x7FWtHlnadgkOYaSwgvrHDGO7K0vDqGlseQV8iWHXcX+Y360l6fGpY0dVTOd5jgzBI+Q5E6szR/1e9UJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s85HrBK30oYhm+SLURSRXrLkNTK5QT6HCkbpb+RlMFI=;
 b=JVV7dq4f+EL8ueHLVEL8oEOqNsDR9ghb8mYF3bgk+tKQ1ETuBFp4AmsHOxDo+HAbduVzEJatjtLuyLefuOBue59bGW/mFEQNX0Q25WqWic2I36Lg8T5hy85SactTZcE05cuIR8awj3mZRuJycpIaXDE2IhzeVWHTFIB7i6BGoSc=
Received: from DM5PR07CA0051.namprd07.prod.outlook.com (2603:10b6:4:ad::16) by
 SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.36; Mon, 10 Apr 2023 18:46:25 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::dc) by DM5PR07CA0051.outlook.office365.com
 (2603:10b6:4:ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Mon, 10 Apr 2023 18:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.26 via Frontend Transport; Mon, 10 Apr 2023 18:46:25 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:46:21 -0500
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
Subject: [PATCH v13 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
Date:   Mon, 10 Apr 2023 11:45:15 -0700
Message-ID: <20230410184526.15990-5-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410184526.15990-1-blarson@amd.com>
References: <20230410184526.15990-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cacab3-1af3-4645-21d1-08db39f3e31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKK9wc2WjMUMLpwIZwNGjLB+kr5xL+/qd72Hsa08Yl8JaVH5P3kgo1wuHgiMDrAh6XcFRTySEUaFA5CyVUQYiB+/B8wo9WmRudHAteHm5t3aByEL0GVbJoHmXTqZrDKOkeKitqksHfzRCKMGM6bc+OJj8IIG13Acko+KaBBYip0kP/KHGMs+5fgyLMxdZs2Lwu2v1Q0yShPSsKrvgQpWK4wYXc7mabAqIK1+y91EUIpl4zg1qq8QNFrFFddkdE0uu+rFZePdtpLZtjz/ML64NHIozDrj5phg7xm4g4qskI7xbv9jRuA1S5zber0yZbVX6TVsBhTsUKTCfn7hwFZQkUJNyhd1O8LiwdUBGPKGN3/cG/uoWHUuiBNbLxSsJ/qN7ThigF5F1qrRzTILxANQlhyWnFDr256K1XOjYZksNY/F5wfEnX5HN9gKzfp2DxqBUNKDtb7Eow2m9AzNjOVRpc6A6ZmSkNKRoGFDVvcvKKiSqjsu5TmbcPUVrziaumUKbJnY6WnNLmUg5O86r7scf4s6ym7AjpAuZrpt25oUOJdcDxGLtkJgZSu9c6+XvFlSVq4P0yVFBQkeIr+W0YC/zK2lyq7qaMUfQHU5F37UaKdW29P8os1wbXucuanQHfzxbygW4XspoyavYCnlNQZo+m0WPQeOJQX2Xb0HtZlpjl6z9MPVG+BKGqMSNkurdGU1cIGSYS/dzbZ9TCd8XpDxDpD49IIqIPgUn7iIP/U2vUk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(6916009)(478600001)(4326008)(54906003)(70206006)(8676002)(316002)(41300700001)(70586007)(36756003)(83380400001)(426003)(2616005)(336012)(1076003)(26005)(6666004)(2906002)(8936002)(7406005)(7416002)(5660300002)(82310400005)(40480700001)(356005)(36860700001)(81166007)(82740400003)(186003)(16526019)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:46:25.2736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cacab3-1af3-4645-21d1-08db39f3e31f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Pensando Elba SoC has integrated the DW APB SPI Controller

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---

v12 changes:
- Correct property amd,pensando-elba-syscon description

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
index a132b5fc56e0..12ca108864c6 100644
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
+    description:
+      Block address to control SPI chip-selects. The Elba SoC system controller
+      provides an interface to override the native DWC SSI CS control.
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
-- 
2.17.1

