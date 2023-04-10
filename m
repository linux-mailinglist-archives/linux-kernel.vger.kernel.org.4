Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA9B6DCAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjDJSqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDJSqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:46:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A512105;
        Mon, 10 Apr 2023 11:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Belsc2QJB8k+IaVnQHmnMU7wG6R0boAusqbWWToWnwatwgnKsPctvPeGYnpILQVvuHLu8rp0CEd7LXxM+lD/HKsonNvZfJp0NnnjMOOsviJfcaM0Ps6N+eMU88PE/J1cEsLmyJPP+icL6fhqo+XQjZr+5GxyiQqz/BNs1vQPhGsrEkdvl9bHKLtb/22F9pqTexxyPsDQpcDUkA6CxdcBQ1n/1MyJPpnHqaA7qkQJFDfMm/cwa27qRSK0aptRBa8brwUafRCOzJaDgn1gpI4HLEOu+7VkAhjWGOPTnLLMe2+0xo6zIYcht2IpQjvaldBVLsfuXWKOWUidn0Cl7XTp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGfLltmAIQqzvIObwObq7/uo7s7vADyDOQbsdCWDzxU=;
 b=lrtEVh6VxLOIInxL1X06v5eKrSoF6BnhuC1HHOyqNhKV5isPb+qJbE/+womQAu8bZ3UeN9Vl22xfYusn/u63a+/9FSYP/XUuy18HVWlNsrsduiSoG6HxS15WBvgLaJPunMScKifnKAkAT49E6cFKzcYJzg8vWwtIJowcLhWOAaebocxJPSfTKntNvQWdbG6WsE9IJDh+f9nYikozj5yFLx3VyIbMJp8SSIi530FG353rMr1mNdemICg67sHIGVRk5cmtxQy6x9lAhGP53J3+7NMeTfcU8cMAqmJ3vkit0YT/xS8C2HE4GHqxujL81UXFIj9spzVIWarlFvIMPGzakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGfLltmAIQqzvIObwObq7/uo7s7vADyDOQbsdCWDzxU=;
 b=nXRAzTdgjPWREqwxynriW0ppU4ahm0BuFFSmBJqeUZypaFNdKx0xa+odPD4hBAS/7OVcuA9+Vj79KUt/0K0YN2kyEcSJHp2DtCmq8hMOK4rLgDqtC7xLrzF72CIzBMCHwCIPQtty/SnHyrz1uQf0pS6zWObLMltVWRJbCrDIFyY=
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 18:46:06 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::43) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35 via Frontend
 Transport; Mon, 10 Apr 2023 18:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 18:46:06 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:46:03 -0500
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
Subject: [PATCH v13 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Mon, 10 Apr 2023 11:45:13 -0700
Message-ID: <20230410184526.15990-3-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c58a82-3f59-4d80-c35d-08db39f3d7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CvLu8f/TIXHJ5uNvOcY6hOZ8mOqpKiVYOP2+fFg/z9wgXIMJZDUNaUFpK+BFoJy6gJJfF6aqW6/nIx32WFxfYkhvk+SlEBc3UYUIUz/MrfRO/99QQFPh/uxMQRE6Wg/8HYCU89aRmG+Yaf1WHZSbq2czp+5SZxfDcGQHiJh/QeKGzDisQ5oAFgDdH4b+J1xfcofumOjxDWqrYAKvRBwuiLdLNOFtaStdTYtEr0AgwDO6owIfAQllBrAt2RxR6LTTiRFLayNS2qvXH1bvKDrIxBwElkQ8evtNQl/g3y73EwK2lZScUiKx5sADKw0xUIF9LjuTrMJVeIl0wmdoMEwZb7stQpy8+ekSNQWwCNasyyuURBMdq9hpHn0tqs3xUyUi/9doAW+d6gKMLQ+5vaxp4borOiJ/1PTDEjGPgh8EgNoZb0n2Wb3UARHiIxjAM8bwZWLFbmWhe9u3QvE//s1tk/0rWO0cgiYLp5SW8DHQ/VL4hrMPYu3+sKEWW5NZMmTcSoi6Ao/KwQEUuZzr6rsFNO6Cho4zijHNWTN9SlvdaUx0HtslbzIC2lv6AR1/zUoLVuVXuQXOBC81BZBAgWHs64ysKwHW5elHjDfCAFLGugoVAb1nUUFsH7p06ei9/Q1ZgjU8utA6fBKyQHJDlvejgQkoID6/guasgCsabO72bvq3hErlu4twCeIStl8IRMGOQxWgPTzOnX9HDrO6vw5icTGzd9QwatKVPw8YByLbns=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(70206006)(4326008)(54906003)(478600001)(8676002)(70586007)(6916009)(41300700001)(316002)(36756003)(83380400001)(2616005)(426003)(336012)(1076003)(26005)(6666004)(47076005)(8936002)(5660300002)(7416002)(2906002)(7406005)(82310400005)(40480700001)(82740400003)(36860700001)(81166007)(356005)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:46:06.2043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c58a82-3f59-4d80-c35d-08db39f3d7c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables.

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

