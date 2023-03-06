Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D626A6AB54E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCFEIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCFEId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:08:33 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A55CC00;
        Sun,  5 Mar 2023 20:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdnIXrqSDLyTr/KT1G5jkJ5LRx/TB0zZjpBgtM1pVf0St7awuzaP73V+o/1362b87AKKq/jTpJcvAFwjaTLooPOikVMaOvMhsQM7O3QCBF4hMjsy58k2DJxYY+YSxexc6l9a6auetfzMJpzZZMjxHPi6iBHxFNl+04q80362KDlfcPzP93OuUJMpPklJ2RqM36cQS5eQqrDh01BKUGzhaVUuIuB1cg3BUzxfmNrX8+wvdYrfPwQ4S/AJ6jDPRHTOTlDXN9AkROF3zakgh/khqSFyF4KDiNxlH6GD1RNfM/x/NY7toX6Hf2k3hKu2ItHDI/EbaqsJJM56KNvuOrRhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYZUAjYh7pmZbMVnjkBAbebeSKbUm1KcGtEfgPz3dP8=;
 b=JSppeocawaNi/GmZdEoJRa4XG9xWRIpa66Idf8ymxZltisk2m6cuRyEPu/Msp6ZyMDdmiz+YPyDzrsfKKfQ8x0Rs2C5Qj5cnQNS7bW9LDJhO9mG7FUxrb1RdqeUZfktgonanNgFRnk74qvHBYq+G6XWI4/nFKhRmJ6P/J78Is+feedu3EUPpBW8sXw22ULuHoB98wnFuXJrokf/hbB6pfAkKJ1JaIz+7I1RkYuK0IVXsMM+jyHWxdwuR5ihOSkUyXSR1n14yXEVzxzjnzxmxoWo0ruXs8aewCxj0IO+fyGj217V4FhgAFF/Q92oZbFrsJyvVsSEr0pLDGuE0d/IS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYZUAjYh7pmZbMVnjkBAbebeSKbUm1KcGtEfgPz3dP8=;
 b=MeF7vPWEqNrQUPFzYzPvi7ui2jSt9Opa/QNNu7nZXMhiNW4KmvWoEJd4txnEKL/+qTY5qqbThdyMKTPEsLvWKSDn3OoZSV4FyL0rlkXGqbPl8JS0CsGrLT5LtBi7LIbaOg4BzVKSGskiH2ifIv+cj3+Xonub8UgdQ4DbFvDzO0M=
Received: from DM6PR13CA0064.namprd13.prod.outlook.com (2603:10b6:5:134::41)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 04:08:21 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::2e) by DM6PR13CA0064.outlook.office365.com
 (2603:10b6:5:134::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.14 via Frontend
 Transport; Mon, 6 Mar 2023 04:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:08:21 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:08:17 -0600
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
Subject: [PATCH v10 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Sun, 5 Mar 2023 20:07:26 -0800
Message-ID: <20230306040739.51488-3-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: b413ae53-006c-416a-703b-08db1df86c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zrdLUCawH2fc2WkwLRvsnoeLjBEnF98eMFuWcxFF4LEgavPRVRBEUjNAeywvB8JnmzMddCLjS6zXc7vy1RJtdJ2Pl4CZshTf/Mth9ctrbXKVKfTO9glTWkTyEgZKsBRgVbgFgFYBKtdjp6qdUpVgDh2/M8COm+MbopaZcIT+Y3C1JnGkdAwcqIwVt9kdKM8UPYFrtAwoTXCxSgVsmyqvBe129t9UxpLFKSWzkVqdvcc02HhgH6olMqMyB0JNL9Qr5nYuad/YqpDmpYHByPFP6heWl/ZCoihne5PW72rAsFX6XpyHMuiu9MwmCf5MEu2TQn/YPeMwYCa39NDSMPKxee1oQW1Md/v0926bexhHzS9O3Sh/j3pLvIFbNCY7G6LvvNCIEsh17ROXM0A2cuX2r3KzlHJOt3FZFQZoT3gMkqiTHPfVv+pZJi8E/7eM5OxA10pcBHTu9b+EMag1FFCmQfHHqj9Dc9peNjKM7yCdJtDaxShDg08cnNIP0Tjs7dov3Dgi0Lu9OJDQxiSTu/BXvykvr1owLSQrQTBd65xg6vZpRtzGcXbpJ3xQCxHrFohSjJW7KdnEcWD16a7AAN7wyDkrnAgnjclSzfoFudcS4sRXzndOrsBGuBqLGpWgKO1odWwGmhHTQxBf06lBAY6U+u5VWbMkdw3ncIOoBsLfadnWK5UoOip/PBSo4pnh9waA4rK7eeJDlkMbIucVm8ZzYMN523uGtaxA0CJXZ32KMI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(46966006)(36840700001)(40470700004)(83380400001)(54906003)(70206006)(8676002)(6916009)(4326008)(41300700001)(82310400005)(70586007)(1076003)(26005)(186003)(316002)(16526019)(2616005)(6666004)(336012)(40460700003)(2906002)(356005)(40480700001)(426003)(47076005)(36756003)(478600001)(7416002)(7406005)(81166007)(82740400003)(8936002)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:08:21.2751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b413ae53-006c-416a-703b-08db1df86c92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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

v10 changes:
- Move reset-names property definition next to existing resets prop
- Move allOf to the bottom and set resets/reset-names required only for pensando
- Fix reg maxItems for existing, must be 1

v9 changes:
- Add reset-names and resets properties
- Add if/then on property amd,pensando-elba-sd4hc to set reg property
  values for minItems and maxItems

---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 33 ++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index adacd0535c14..0c4d6d4b2b58 100644
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
@@ -30,8 +29,13 @@ properties:
     maxItems: 1
 
   resets:
+    description: physical line number to hardware reset the mmc
     maxItems: 1
 
+  reset-names:
+    items:
+      - const: hw
+
   # PHY DLL input delays:
   # They are used to delay the data valid window, and align the window to
   # sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
@@ -120,6 +124,27 @@ required:
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
+          minItems: 2
+      required:
+        - reset-names
+        - resets
+    else:
+      properties:
+        reset-names: false
+        resets: false
+        reg:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1

