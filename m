Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692286C5AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCWAIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCWAIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:08:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF26F2F054;
        Wed, 22 Mar 2023 17:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij5kMFrcXKkM6GQcfa2hWr5QXKzrbT28a8uYtG2oPav6ssphnoh9IEG1/bJM0PCdMr3yyyg3jl6Xikes4p7ViFSt9zqmZt+OJaGNv7AXl2KqZ9+FTBMuHB7DqxxZMGKmL/gOW6Y+sl/oN83avDTj0lOIoMONbl7bCmVvwWokG99WC3lpMEzWI2aTT+tT5h4WQA/T8JoNgFHjvy42K1qSgl0aIQeyofHMzaUsSFsW3R7K8AqkeYNy31kHYoZBqm1yRITatfHY+JddSjhHg5pyJQ/HmIhNxxbwmIg1ndaab8KZEF5QjqFUSaLiM/G8OCcx1LT0TxVK1qZsq9gVGPwY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6heMFDr/vcoXtcG1ihJG6vNQj/gCmyUGL8Ele90UPF0=;
 b=ZErYNw57K5/HTXe8oIeBb2hwy5OXcQasnB/nH2rTBlVDBQ6Rk26DJirmgxslGEKasXd+NFro7PPWKs7qJ9DMrCg3abMjyUYg27SnZnNLn71Va3qAECO2Uqg43P2ZLWE8YekLP3Hjn5xuOUZzurhfpVJoWEYSvcQ1Q7xhP7MOmwCrF9Tv24WNjXG6UqgTykEAqjDq0bw+/MZC6T5YzOcgU0fpSGC7gOEXnrxklwkcIzfohFrtBMZ+wxEU8+HqlJYc7fH7MnywJgXVcf97vfUTabgujeL4Un1LoV2dRCNqU8FOX3R9ciq08LirV2shSUU6kYoPheJWC5nfbbXBuxNLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6heMFDr/vcoXtcG1ihJG6vNQj/gCmyUGL8Ele90UPF0=;
 b=GPsdr984rOgORlctPRVjtA6bc5Y7ML8komplFZlttJ92D+WUP5IRUnf1OkB0r0nCP8LZwfBd8DhDYssZ6A7ubhbQnKonOc/eW4QPwg2YJFxfTcg937uhIgYMIqjGnVyemHk/m4RvRLA/pROZPE5Hq9fSPEt3Vee8J1ROObaMod8=
Received: from BN9PR03CA0264.namprd03.prod.outlook.com (2603:10b6:408:ff::29)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 00:07:57 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::bd) by BN9PR03CA0264.outlook.office365.com
 (2603:10b6:408:ff::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 00:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 00:07:56 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:07:53 -0500
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
Subject: [PATCH v12 03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Wed, 22 Mar 2023 17:06:45 -0700
Message-ID: <20230323000657.28664-4-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfce271-1e87-4686-5c7d-08db2b32a7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNnSXqtiSPtXsdfM5nyexxnVEnIlroh0E7lTcMTZvHzre5i6CoGaDB/0yfWtagON3jozIT07DuL+idNs/V+C5brmXxG98CGAB4flQLF7AAcfjCa7NyS0bePwxutbr3SO4MWPRHSoQI+HR0rCKeGAo1B/7O2Z/zwY4D9evVinXJ6wQ/xqKg9r6so8/z5OfRiAsDizH6/Cf+6oLltbJ58IODCEnjlYK2zCwotsKUAyAfOkXJKBd2LEA9tF4H46hk9g4Hv3a22ZMgQIknMKaiHO09815MHR2N/4z4dGEVAP2ISzkwJgd2uzXBLlTH0FS4O4PRk/lcoFvph44LUxl+uL7wng8Oet7W2a8105CDLDCAlZRPfh514xNGI+Iht3OlhyTuWhphP5VzD6lTX1ETXuKZDr4xnJHj4ZIKINN+4HAVqPwwVgwoF9EblwBZI69hHJCmaQ/6bio90I1OHgDOUoN0y98cyxit8CzlpuVphmpMs7p1ZlJjpET4+/8VKEHmKMP+AKA5IAmh1guS1fbxttP6ygz6C/yRmCKQTQBtCo1am98zUPbtiYlO5eo2knwO3VluDvtaqekrFT0broTo018bjHD8CqRlrt0yM9ZQY+6QGxTOFpyzvwTTjBS6bDw6E+vAJRaa4hmolq1riu2FOaPGhtkI+7qI2ELc+TiviJfjTck7o7k2LgTLbYBWajlduefP8KBheemwb51DCRbzkP94qlQwMgxoOjHn4HUtJXoL0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(8936002)(7406005)(5660300002)(2616005)(41300700001)(16526019)(7416002)(4326008)(70586007)(1076003)(6916009)(82310400005)(186003)(26005)(8676002)(70206006)(316002)(36756003)(54906003)(40140700001)(36860700001)(478600001)(83380400001)(336012)(6666004)(356005)(82740400003)(81166007)(40480700001)(47076005)(426003)(40460700003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:07:56.3358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfce271-1e87-4686-5c7d-08db2b32a7a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the cadence qspi controller compatible for AMD Pensando
Elba SoC boards.  The Elba qspi fifo size is 1024.

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v11 changes:
- Removed redundant if/then for amd,pensando-elba-qspi

v10 changes:
- Fix cdns,fifo-depth, only amd,pensando-elba-qspi is 1024 bytes

v9 changes:
- Add 1024 to cdns,fifo-depth property to resolve dtbs_check error

---
 .../bindings/spi/cdns,qspi-nor.yaml           | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 5c01db128be0..6e67de9da293 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -20,11 +20,28 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,pensando-elba-qspi
+    then:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256, 1024 ]
+          default: 1024
+    else:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256 ]
+          default: 128
+
 properties:
   compatible:
     oneOf:
       - items:
           - enum:
+              - amd,pensando-elba-qspi
               - ti,k2g-qspi
               - ti,am654-ospi
               - intel,lgm-qspi
@@ -48,8 +65,6 @@ properties:
     description:
       Size of the data FIFO in words.
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 128, 256 ]
-    default: 128
 
   cdns,fifo-width:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.17.1

