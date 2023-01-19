Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3687E67300A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjASEN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjASD6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:58:41 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19254672F;
        Wed, 18 Jan 2023 19:55:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5gGy8FCYua3da6ZHgWD851ZIkETNUbQO9hAayTQdfHaluzRY/6/H3ciB8EDrA25EmUSWO4+xrvAxugdo5snNXlUeBFMksfsjNolHGeo6i8guooIklbu480Ixc1KsTp1CoCT09t7xYlUdmLo/3lhof/BwZB+aeyIfTXYn0kKxfy4arFT5yHwZWnBh2afMHIJEy3wQ5Vko0IPrK/AZA5UqAcJcMDTF8+jOTQiJTKztMsGluaQpDtxW51XSBWbYUmGUbGfDryzZRduOSrCF+AJwQ9+2FzeCQzfVAWxJGmZd+4dCDH2f7rOtlyv1KhEisg/og3W8Nui/9j9A5uCA8z6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmaGlRv0dSbHKLAvH6Xbn1IwDGJLCQgM3m75kMGlPTg=;
 b=AJ+lcpqg6Stu+7PaWm2aXyeRyTSknXkPua2cEGbRIg30HsWUTBcE3AHmxuwneznO7MPRTI5tbDkF5DPoaIAeaaeeyFxkxcv8WuNQrBMWz/XXDLhKHgUmwmOKVZg+toiT9Yfs81o9TSwpio5XKGWQNW9mGFv7evsjQ9rTxQhwcNNvHUTjfXy440t0UvHBE8QewhVzxu1MWLwxzDCJTr4xBufRIHNvsQOF/l1SV1XZ434f989kQsNalNM0K59y825pWA8TGQ3G/GHystgZFP1mAiJl5Hm6A6gNiDkFhlpIXKXSnYdu1DgY3Qdzrg3eKSJj9UiAr/N/zlTlXlxwK7aq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmaGlRv0dSbHKLAvH6Xbn1IwDGJLCQgM3m75kMGlPTg=;
 b=Dok03kR5ov2EwgHHF+fWNx1SM0M2qurEbogXSuiQ8dc7mZDqgkYMnXQvsAuV5q6NOUsXm/pvaZl920I5sU86j5upOqilVzI4w8uwET1JwqVmQY6/fbFxdIIqKk3N0hw5BHYnI2n4uvc9JPgC1LAFVm+ST8uLJT8H8NW2sxz9Cr8=
Received: from MW4PR04CA0190.namprd04.prod.outlook.com (2603:10b6:303:86::15)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 03:52:36 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::8d) by MW4PR04CA0190.outlook.office365.com
 (2603:10b6:303:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 03:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 03:52:35 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:52:31 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <brad@pensando.io>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <gsomlo@gmail.com>, <gerg@linux-m68k.org>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v9 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando System Resource chip
Date:   Wed, 18 Jan 2023 19:51:27 -0800
Message-ID: <20230119035136.21603-7-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119035136.21603-1-blarson@amd.com>
References: <20230119035136.21603-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0166cb-2001-4a19-45b7-08daf9d099ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYsW0FLrs+mBjjREMszDYW/PzzuKxJEklDrPYmKJunUf8VNQOnfeU6PbtS7qpC/qk8wGz4ProX+enV0LX1lCTS/0zKHegNr7qmC64uw0OFdxwTUhDMewYcbW8z8GZhXTOfWRkw972t7/u2R9P+Tq8VYGUwAm9h8XYjLTqhiX+fH543Pwn4jm1sNiaAmyxeVWvn2GWUJIjOW0sHWUb07YexjxeLejOmQ6KhbgVULjnC2MVenUaJjSXBVRZjHgqBPeXWv/5pXs6yUDtG55PU97qfN4SkNimpkY2jEXCiT/aPhHynJMwC/b3Tl+elT+gD/nYgQ1jFiP4xD6WY0FxboruWBrdJD2+6YLylA1UW+j8ABdqyU0e4nvG+xVdoNsmq170T8aK/5/Zl7rYEuRkITe6/D9AsQR1V+X8hyHwYip23W335tj68bjdhNZD940ZTY483hR6Gfk0juIJUVGz54Fuk4B+RU6Yh/7MZD9nPnAsVxTdMA/zz99kYORgBxx7yZqHYqKrNCOCDscrrUpljK5eAZcvtHQUvePVYP0lQv+992U1EbUPALaofNh39QoB9AKa7ineCI62B4IhC1lz4mb1zIhrgxIy03tmyVVJ/trKLA1LZb+MvbTq6CUxYQs3Dp9QVcq5ehQ61+9VYU7rwOusbwzz6LOVRKSPgT/I0i8SSE33aYKUgZjI+hGmbs2wlNmGMQGfyxlxTut+TMzLB9gA3mfvXM2VWnAOwMVNj6AuXfHYj3yYyK4Vy9KITt0BQg6evp96Sl5ulFa7z+epZYOhQXB3C5Yx8L0iB2sURobT04=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(82740400003)(40460700003)(36756003)(356005)(81166007)(8936002)(7416002)(7406005)(41300700001)(5660300002)(8676002)(6916009)(316002)(70586007)(70206006)(82310400005)(4326008)(2906002)(336012)(426003)(1076003)(40480700001)(47076005)(2616005)(83380400001)(478600001)(966005)(54906003)(26005)(186003)(6666004)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:52:35.5827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0166cb-2001-4a19-45b7-08daf9d099ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AMD Pensando SoC System Resource chip using the
SPI interface.  The device functions are accessed using four
chip-selects.  This device is present for all Pensando SoC designs.

Signed-off-by: Brad Larson <blarson@amd.com>
---

Changes since v6:
- Instead of four nodes, one per chip-select, a single
  node is used with reset-cells in the parent.
- No MFD API is used anymore in the driver so it made
  sense to move this to drivers/spi.
- This driver is common for all Pensando SoC based designs
  so changed the name to pensando-sr.c to not make it Elba
  SoC specific.
- Added property cs for the chip-select number which is used
  by the driver to create /dev/pensr0.<cs> 

---
 .../bindings/spi/amd,pensando-sr.yaml         | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml

diff --git a/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml b/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
new file mode 100644
index 000000000000..8504652f6e19
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/amd,pensando-sr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Resource Controller
+
+description: |
+  AMD Pensando SoC Resource Controller is a set of
+  control/status registers accessed on four chip-selects.
+  This device is present in all Pensando SoC based designs.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - amd,pensando-sr
+
+  reg:
+    minItems: 1
+
+  cs:
+    minItems: 1
+    maxItems: 4
+    description:
+      Device chip select
+
+  '#reset-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - cs
+  - spi-max-frequency
+  - '#reset-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+
+        system-controller@0 {
+            compatible = "amd,pensando-sr";
+            reg = <0>;
+            cs = <0 1 2 3>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            #reset-cells = <1>;
+        };
+    };
+
+...
-- 
2.17.1

