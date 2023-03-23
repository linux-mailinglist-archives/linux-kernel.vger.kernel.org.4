Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39FC6C5B03
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCWAIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjCWAIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:08:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1DB2E0E5;
        Wed, 22 Mar 2023 17:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkIeaEgrGBqctSx+imMNhtt/8toCZLs8mRxiAdrcoA8CEsDAs2pQTJA3C/yKC9ep5PgUHJlNyYCIPQwvXPbnt0daxTTe3WnUwlqhR5NcZAUgC0AO+HKlp66I648/ISBSG1dTzFUO8lerpKS2pdeyDq+/+SU05m7ciNY7SaNn5STO8pTNckRYWltpZzt6SC/raBNK0kDQgz9fvksWop2KEMdoJ0swP9wRN+tp2dwnWo7nRkMxWiON/HKgWXI+ukI2eyFjiTcBxiWqYmvaXTN7YXSQsu3DW8A2lkbVn5ESe0kq3afao1AXIok4BzjlRTql9hpMN7rkM0vEZy9iU5XCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s85HrBK30oYhm+SLURSRXrLkNTK5QT6HCkbpb+RlMFI=;
 b=BiZphPWsYCKuQlylyaNcXqA02m4VoeaKmBmqO2fzZeZLPMshlKwgEXteercT3DofntQHLT9qol4eJZATCzwNmMHFMqHouV87hVlFsrcfI3ptaqMlBlYbOAh/bW2NI1csdzKBENX128sH2FPyQDR3kRVtFnPJML3unAQ8gNmxeedvWplEeqIZ/5BDtY/bMTfpEbKC8UWAQrk3jQe0V2dNpYYzF+J2ip4qq4B8hQsnY+tyctR5OUjJlUwnzj85tWe6bpdW4WAN512BNmtDb37FEshi6nS0ewn3Zg6IixKSYJQW9A+kz9cS1z6Jtim8qzNX2rCAWj4CaXApdGQPA5c8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s85HrBK30oYhm+SLURSRXrLkNTK5QT6HCkbpb+RlMFI=;
 b=RGSVNOzBwGur8ABgiQX4WZBKruBCm5vc7Kr03dkxIF7coDctIeNfyYq8XX2M5gtqHcQwymg1n7bnjMPxdUqK+0H4CJmb8PUTTnxZMGhTuYOlrzwI7moclS+ZRRD2H2RYl+RRAb/Re8sUpoA6wk/NOOlulK2zOlQK5wZlRrntRPI=
Received: from BN0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:e6::21)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 00:08:06 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::34) by BN0PR03CA0016.outlook.office365.com
 (2603:10b6:408:e6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 00:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 00:08:06 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:08:03 -0500
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
Subject: [PATCH v12 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
Date:   Wed, 22 Mar 2023 17:06:46 -0700
Message-ID: <20230323000657.28664-5-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323000657.28664-1-blarson@amd.com>
References: <20230323000657.28664-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: c99c3b95-55ad-4270-b4ce-08db2b32ada0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F68IvmgllyApPsCBeNVUDDE70/yam4uvtjZST4eg9z4yZ/2yAc0mMGXcznMaum9vFm9UfLuqLWKaL4Kwz0meFpo5Vdxb1SQ9SFmV7VsCvauYP4k07keHAcYgoS2ZQU3Ol92B/AQlSaOZ8c7VjB+90sHcEZw8VDAzia2zBoGhxT77kaHXNtF6XXmTFkf7jZB9/v/PU7a5fQ6ereThw0XnfHANwKMtwTbekGAB7KpuVqrJXdvfv+p8tycX3Tbgso5pwEE/KAA+MfqZMnLiSPwfT/ff0nx01AyTNzen82xsG+B6e/XZW9PYn8eBX6BS5on0+e+19XeVgmunMjsou1KuXDYmL6CO17rNVTNiJPduWeeK4A8eeaERzs1azYTmfBC0N4PbZwiGQVrxw4idoTWIB9FDgPnFvuY7zMfuDiX+5CIvyflWRVYYn3+u79YnoShAvkNtEGUvqmWp47SYyHcAj1nJdknrIc6hzsSUsbT4zidMHMSRSvNHR4lCKP35PWUwTwbo1vbASBFOdFRPScCEYmWOzsEQ3Wv5mOwfcWCYWRZpmzqIyfOUoymaEebBCBfhurvkfQWaAQY8LsG7uU4781QiTtltx2uJlzdjcGM8OVQm80ap6FwbAdpxLpsNOANG7vx+BC+4HTLcXUs+gpwk4XQTDClw22H25OPGMCAr8XZp8Xvgv7ct70qYA0OhY0VvlSwLXK4Mg7sHWcaN83Nw8GEaCBMk9rv2Kym+7ZQkaLc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(82310400005)(40460700003)(40480700001)(36756003)(16526019)(316002)(4326008)(54906003)(6916009)(83380400001)(8676002)(70586007)(356005)(70206006)(186003)(1076003)(2616005)(6666004)(426003)(47076005)(26005)(336012)(8936002)(82740400003)(5660300002)(7406005)(7416002)(478600001)(36860700001)(81166007)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:08:06.3938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99c3b95-55ad-4270-b4ce-08db2b32ada0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

