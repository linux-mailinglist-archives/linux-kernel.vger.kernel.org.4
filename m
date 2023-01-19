Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1820673020
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjASEZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjASEA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:00:58 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB206C573;
        Wed, 18 Jan 2023 19:58:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2yEayzB8sBV7bEPJoBZu4ecE0OQTbx3Na1UO2ABLgCAqxncaBKQrFPfbAlza6I4SfZilSACuIVPl9AJ5kAtSBZq/YL79awOjaVMev9LEsf/UgWyHu03uhFetVSKFuHQihRh5tPC7vYJWmn6Io88mUBBD5tk9FEhDiXUb7OgkUJHrkUQYZH5kZQorunOneDEaD4iRa2HyYVlKj8blODadFPx+QAmKw62S1hjLUqkm0gC/Xjg7YUwM4fQUFnvcEGWwOqmnFWSAMuSShS33zVc7mr4J8D2+IQ1LFxbU+XjMKgGngxA4DnU9H/qOGi3wy4iSOPSDYybJ/KD4ur9EHI6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kudYK68TKVp96VTs/Z2G9y6K9uac1w5PwvTjxWPWhog=;
 b=Kf5pI3t3nlkXubHxfzDqSbrOn3ia2JKEKlHouWJMMcBrlPnnBdyPRzRJfl4EA7L+kv+0paIezyjp3k93sdl/XRd1663L3nA4aT3MXU+aTHlaL30lN3Hv2TiA8iqlaYNxy1CVJ8w8z/HkFxaotfjWBYzl7ehpJ4FThQvm3NdpZfY7kub+aUsFr3i4wR/ZGHuoow5Fj5xu5elHnpbxIMCIA1G0k6+II2cYEAz3eQE2S2A00CtWatSgSdbcr+hXVX7hlB2iizFAG4mdPcc9DRIgu/YITbPw0O8AXRkAH+zdEoNuKlzaFjLP2nqWwEkfeGEJELdN9UU/r4lYZ5khW14rNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kudYK68TKVp96VTs/Z2G9y6K9uac1w5PwvTjxWPWhog=;
 b=osigD3j9YUB4ubjF5HlHbDHTKFCpgQ0urxDSHdTsZA/5XbHN2ed3I3t3KouIKStuskNGrqqc7PHAY5Vqmg1GMrU3NbPIPtASdFUlom6F8eECCHBQHNoVaHCX1PBaCHhE2kNY4UlANi1E0jXN/hiNIyUq9FczdlSGZPPgKF3fXLk=
Received: from MW4PR04CA0280.namprd04.prod.outlook.com (2603:10b6:303:89::15)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 03:52:25 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::8d) by MW4PR04CA0280.outlook.office365.com
 (2603:10b6:303:89::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 03:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 03:52:24 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:52:21 -0600
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
Subject: [PATCH v9 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Wed, 18 Jan 2023 19:51:23 -0800
Message-ID: <20230119035136.21603-3-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: becfc0ee-c9d3-4408-49f4-08daf9d0937e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kb/4GNGYQ1AbgtoqI6D4tgIr+4eLWVL/3KurWmzoma9O2rXcpqGV9EOnyIq0OrZxeNFMsUEjEq7+L+PIoosVdCsGO4hPOPD/PCPqJxGf+5d67ckVcv3foByZHSvst1+J5hZCFfAH1vJW8yT+TqzvXokYPM2GGOPlqDL2dJ+o83+R0oE3hV3U8ALLAotduoZlBL7TpOfkOOla3kv9jxG/yJ3CLk1JFR2av3ohG47BqY9h/XEZskLWqdLsDPlocxGUEzZEhplY2fK7J6kuma9wEgOcqKzSyx8SBSl7pVL0y/vxM8Q8sSq3YHb6OKzIRilgSf6Kml3m0S9TvDgf9BAzBN2fzUOmohEMs/LVqbl5kROiE/nhWOX1wyQ4+FAnGXGad8EHFDICy2jgiXcHlWxpuShtzUFDXR4o4Pmv5GRz8jUu12VGX/u7EVf+iJAgda4rsB0OPtux/Lg2ttRfxK1op8/4bnTP9Mp36ZDaXvT0qNd+nZdGRxofHhzmDKCEf3//Xx7bFl7pjRP4LFpHY2FSido5ZNdvVI2dUsXOu71x3/M0+srRbFBqsOo+8CgU5iymlN8+7eB6HpZ9VTYcL5Uemd+yC0+mGzf/xCBP+CXGJe7r73BbMzm+HUoqOeqsbEgLOHeAgNt8p7C2dcJv9QIwGLTacI9njHTG/93eOx5m0o23PZf13hl19yPTUDbItbSwMXfzujLpNqIXNY3bxwNXQX9QNiRgg33TAxhhoe4O0kI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(36756003)(26005)(1076003)(81166007)(356005)(4326008)(36860700001)(40480700001)(82310400005)(2616005)(16526019)(47076005)(40460700003)(186003)(82740400003)(426003)(336012)(6916009)(54906003)(83380400001)(8676002)(70586007)(7416002)(2906002)(5660300002)(70206006)(7406005)(316002)(41300700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:52:24.7981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: becfc0ee-c9d3-4408-49f4-08daf9d0937e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables.

Signed-off-by: Brad Larson <blarson@amd.com>

---

Changes since v6:
- Add reset-names and resets properties
- Add if/then on property amd,pensando-elba-sd4hc to set reg property
  values for minItems and maxItems

---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 8b1a0fdcb5e3..f7dd6f990f96 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -16,12 +16,14 @@ properties:
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
@@ -111,12 +113,36 @@ properties:
     minimum: 0
     maximum: 0x7f
 
+  reset-names:
+    items:
+      - const: hw
+
+  resets:
+    description:
+      optional. phandle to the system reset controller with line index
+      for mmc hw reset line if exists.
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
 
+if:
+  properties:
+    compatible:
+      const: amd,pensando-elba-sd4hc
+then:
+  properties:
+    reg:
+      minItems: 2
+else:
+  properties:
+    reg:
+      minItems: 1
+      maxItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1

