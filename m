Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C707C6C5AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjCWAH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCWAHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:07:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0992DE74;
        Wed, 22 Mar 2023 17:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHCZ4iiAHOHnQcsImOMYoIe0QYXsxwgMyeynoS7DVOBkZxPtMTscRZg5wnaZ7Ojg3CsgWF5g8BOtHdf+qRhH6Y3Q8HgItz4ecJPOYdkm3g/UTt3cuCmKE2C24rTEl6GzcgmmJsfmOYBrP6uhDk/2EbbaMxI85NeWcvvbFdTb+/5wZFwQu2VRaaxj55eygHyE9duAzg/sE96IH4xAIpZFPaPy+CzUnwYyIjjnRslIOTU7QZYJXOZITPq4NoSMP+DWkYJw5PBrCBx7eti1+b0IEZdVkjORmeBrZFMcZ39S7px1jnSs9VZFiDL7vOJ8RkcI6Tp0TXka8xXfyzwn3OD8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mxYJKqpjySgldzXjTuLsIpVX+HqaTkwLV6V4DvdoCc=;
 b=go+0OC88/3N39qkyQu47zUqAtdklZWUREGYace7p9tpXhJrw3YzF8EysYPKL+/dvyimro4DGQEcZuSWAp3U+LUlE5PiMD52TpZu1+dAjZ/zIpH9u9XR6A5WWWlwefqlik+8N4fZsroJTC1wBlyOO+OOkTZgLdzBfWJBZhti8HL0y3LT6NVfybncxgUFoOO33FJADBWw2SEYqlEiEAc0QE9UnD8BruFg4OFgVY01ip+O9L0xpg3/6UfoBQp/oNDVBt59ZJdFYz6VqTslMRoYgxmgqx/iHlm+UOcs5ytnUjZLExqtxbG1b4uBScAhlmc4E4CllnVK/7yqShQiRxh5qBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mxYJKqpjySgldzXjTuLsIpVX+HqaTkwLV6V4DvdoCc=;
 b=dH8hTsCJG28FIY+HDS7wsJd2Y9D4iwm9oXWob15tPqLGFswhsrNa/rUKoc6uJ7HCgeGoojtEF/Pxfr6u+IDt5+3CpdogP7i1F1jl5WvqQj+dYU1semtTdNND2YbLMj4vnZFMDhRjB3tCnjOPrJ6JXpNX/uZwDU+cMysM2H5tV98=
Received: from BN9PR03CA0368.namprd03.prod.outlook.com (2603:10b6:408:f7::13)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 00:07:44 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::22) by BN9PR03CA0368.outlook.office365.com
 (2603:10b6:408:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 00:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 00:07:44 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:07:41 -0500
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
Subject: [PATCH v12 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Wed, 22 Mar 2023 17:06:44 -0700
Message-ID: <20230323000657.28664-3-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dd06c8-52b9-4cfe-2772-08db2b32a092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMehcjZ+mWXdBVbT6HAkipKaWOMv6ydHrw6EfCev9j5nD/KfTzZ2KlhiQRDSNFxfHopvsu+RSVo3gmu8f5Vh77pVAaRdQPyPSeawyDlkbw6Ww+eYlbZOJ1xSz1ODKinaBWD+RmbK4HK7N9DNMKLa4/p0gXsWMW6iKshFCFfBIJOl6BLNRI8aHeXmcoYOb8RpqxS9OTNsL+/CSEc8mrMLiRyFuX2Sqb1nEEGZGWNW6XH+aZnP5LEk27OjlouzYhb8/xOfwvg+72uiR8cF2NYaO2JaR4bOkbAQgaDTnQjIPGxDVwhnXDh7O2TEf/a2oKVfLtAyDLhZlo21ISQDe6trVC0ICJPE6wn7HtZOiH6EHgWzz52wj8/DNOnZw89IVuvrjdzbW2Nve4tiUZqJhRPBAqIPOGIHVH2+YBni6NFM1ASDsyWyIOaSSHt96J9EFOT3Wzisj7paWs0rQDD0HO6hsZWWkZMl1wFDpA8iX/XLc6D6GDCkc3vVufM6ZZbutzmseRaZcF/qU3pZqVgtpsXQ6x9hyt9lwMm+hLTUKzU4OmZC9b9YGClh/BmEaIYo15BjWlCVIvLcJMXZPfZu+CX8qGD+EQfmUKHoHn7DsQagRu/K/Bm57h6FSRVZ/Bh5YclUrS1G5V5bUdFtfSY7OeiQiEIOyQ/PH2cov3T/kz8GtsKcHJLhdzoayWt0i6IjGqa7RCLeuPNOdTtl18SndzqIkKVnMMTDVLMXxFyNF56Kjh8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(7416002)(7406005)(36860700001)(41300700001)(82310400005)(40480700001)(36756003)(356005)(8936002)(82740400003)(81166007)(40460700003)(2906002)(83380400001)(336012)(478600001)(426003)(47076005)(2616005)(186003)(16526019)(26005)(54906003)(1076003)(8676002)(4326008)(316002)(70586007)(70206006)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:07:44.4880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dd06c8-52b9-4cfe-2772-08db2b32a092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v12_changes:
- Drop 'resets: false' in the amd,pensando-elba-sd4hc else properties. Passed
  dtbs_check and dt_binding_check with both versions.
 
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
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index adacd0535c14..6c40611405a0 100644
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
@@ -120,6 +119,26 @@ required:
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
+        reg:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1

