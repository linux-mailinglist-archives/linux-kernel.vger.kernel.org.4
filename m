Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE76C5AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCWAHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCWAHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:07:38 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E51F2CFF6;
        Wed, 22 Mar 2023 17:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEzTFfa7oDjtxJ25tpVaU5pnKCvlKz8nWiXnXJLSNOOjA/+6zER6XS9rdLC/izE9wHncRIEO3ofYNtCC4fTyRPUXp9Ir6+1o50cNJF4UO3q6xUfjcFlVvuGYGYHSQL+3mzFt4ZnuqtJ+n5XbmOREoUbxt+8cW3+KqcsDwvmrvxL8u5S7n/6toGP6dPjQR/933/rS65cMTE/tDT/384pD0OYyaoVysS+GMj5SxFHdClG0waUGMDZDwGyYe2zqpV76klWtinGGW3/TnGx6gxnv9lk1QC1fNILlXeW2T/rJlBD/9LcVb6UlL2h37hs+4oW72jYy3vStkCD/xHPRy2PVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=P+ug5CIEuG6ltSEVxuimMiFKGSlXvrr3iXNaWdaDBUZA62qqS1US+v2ivJ+qtYFtYqOJxqGO25vwc8SIThnXi8P4/GPsgCqIvEScuW4z94mwlp3iPQl9VCRLwtHJR+3fw65WSMQa0uHIdEQo4ZO+PKgYkhHu9DkNLg+LULrx9IhogsaFBnq8Y9yq5FFttuCQrvk9gWR//uA+wFiOMbJLMTuNYzQh3o1xKP9eMTud5RZqsrkjC+ek6NpcNxi5sDNoIzOSN9q6nfYWU5in5RBospysMNaVwApwRThHY8rGef+YgKweVJneohNF286hsFIuuQbeHVzedfBmyWbPqAnztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=B6ZJQJNbvoHRnyMHq3pBZaH62UL6ykAf3UZIFgtZas2Q7MrhlOfHDo34zNiKnhLZ3/YaJiXsdYaqcfvye6tr9mqjqDzB2jNvKldwEUe+eOfLJ0SjfEFaMqH2/H2maunz02ChorwLang7+RLxMfXBgyDcF82Q+0w8LNhu89tvzoo=
Received: from BN9PR03CA0444.namprd03.prod.outlook.com (2603:10b6:408:113::29)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Thu, 23 Mar
 2023 00:07:31 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::5) by BN9PR03CA0444.outlook.office365.com
 (2603:10b6:408:113::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 00:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 00:07:30 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:07:27 -0500
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
Subject: [PATCH v12 01/15] dt-bindings: arm: add AMD Pensando boards
Date:   Wed, 22 Mar 2023 17:06:43 -0700
Message-ID: <20230323000657.28664-2-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5eca73-086d-452f-ee4c-08db2b329880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuPtHtlvdRCSlVOoYN4EIt44rdluCCX2Kc+ejsL/+J4NrEaY6h1G/P/wwNMMU4UrPxwXLcgvm2wLRAT9dbcXLNR0EOaCpjrKw25F7NH055b7kKK6HWUSvUneUYUJ9fbL7uaK8QLeZQyLEqel9n4akX54DLC9DZX5AcRiqOVnrkE8oWMCXxENAmEkgMXZTq6oCZmoMJpzjq4RBpNIpyYGXigMNL83uw9nPSxeoFK5eedn0JduntzqbmfGwbqdMjbW5felNoRYY9rMTa2CjrALqnlDgSNVlG6W/AFD7H+D1BCkTM502Gdm2gNS/8bPPOpWBQ99gmEWHQYZI7rfHi1pWh6QuhRvt5/NzuzGEbBa5CEATbvAs5zpTEleI9fvmIQjZVPURZbICsqZV9eqjHYfMorPFculXbZHwMu73dSSfALHXhGVtbJCxVaKdk7YZhm1KQ8zcB4QUM4k1Lsor89FVm9rPBOmX+43ZlsjQaaoHXngipN92ARpXO2YnlW+FG82BaorCJg9YmYBwG1uVNNN/JB2lymvj/xDu41OJzTgTp5lgJkdqLKNCEHuGETJJLm4nfpruy6Bl3GUDhWvmIdz3PWUQM+D+OC6nt4KD7n8VqoqNpgktvFqeCm30W7aBa3c9+J72GRR5XEdPqSvTvz8kKyiGSAv1w80omNJTHDXwfh+d4kXr6UHLlB6jcJEwTsrBKy51egh928a9Swztpd26l3Vdbkts/SB3Qes49InO4Mb2E1v4G4rgjM9ORR36q8w8pCeutC+2c6IqMgc32Z9bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(966005)(36860700001)(1076003)(81166007)(47076005)(26005)(82310400005)(6666004)(36756003)(336012)(426003)(41300700001)(82740400003)(16526019)(186003)(356005)(40480700001)(2616005)(40460700003)(2906002)(316002)(6916009)(8676002)(70206006)(70586007)(5660300002)(7416002)(7406005)(8936002)(478600001)(4326008)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:07:30.8596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5eca73-086d-452f-ee4c-08db2b329880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for AMD Pensando Elba SoC boards.

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/amd,pensando.yaml | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml

diff --git a/Documentation/devicetree/bindings/arm/amd,pensando.yaml b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
new file mode 100644
index 000000000000..e5c2591834a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/amd,pensando.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Platforms
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+
+      - description: Boards with Pensando Elba SoC
+        items:
+          - enum:
+              - amd,pensando-elba-ortano
+          - const: amd,pensando-elba
+
+additionalProperties: true
+
+...
-- 
2.17.1

