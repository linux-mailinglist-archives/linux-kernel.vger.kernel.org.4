Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621006AB55B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCFEJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCFEJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:09:12 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979DCEC49;
        Sun,  5 Mar 2023 20:08:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtezldOKSirVZoV9vZsYTr8Lcc/AVV6TSUwNQJgbS2UVATeuVNmPTVg1hZFrlk7Fmo/6xxHNcLDl3BF5OPdkNS5xivAACgnwyX1/gNOrIzkfyO9zxspSXECKrt61oBcfr1FQ7jmj7j33P6NWAGc8qgOYeeZcPa3Gy3ulr66q9IQHvOq0Phw2yYy8jAh4VPic/2uhHeyKcrDiAgiw7P9fXKU2hrL9gknqbHXINJwDHj0u95kAGPXfYXAvSjhmpKm5wA0g/BVhm0C7Y34sWjvw2brlqDXstcY5ECksHM93B0E43n8OH0u6+EqNReEv2M3Fvz9lPRB7oh0U7jrg/o9JZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yF18aR/PwECZuTfdJUAKekcVDp//sLHq8QBk/IPEas=;
 b=RQY1eTwlLDA06CHhhyAVS2Ey11DG8jwdOBktIEPZA0Rl3jnX8oGR44S9H/SamIP0Q1stUL4j3Ne0dZzi4svUJNpvnWAPW/21AMg79Co70lWv3qp1Yfx/+u//6mhDziMLqyaSwbKbqobwj717JsaOMwRwcflz3coPE9XfYSGCZ5AukQ+LLSIWqs1hDHLx5wJisJ9WtyYYbpxfTIImWuWYL5zxCqpqTQvVLxAvZ5IvPbqHV61f+OjKW/4i5aybgnEFZyGzja7vP241Z8wBLLAk0VVAwzauL1nayQxmE/xfNToa7hR+mvxkFH5qV8sZd1oNEjTiOktt3WAO9KCsjkdxug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yF18aR/PwECZuTfdJUAKekcVDp//sLHq8QBk/IPEas=;
 b=Mo4cnAHrH6+NLPCJWvqFaVVY/pKdiV3zfHN8MwsbK1RQJ9SaDmaLuWtFJEHr/+V89opMyTS/O1g4rTOyjaK2bzl6dd0NdAGJIv/4mU/13KNN7bDH5A9GcGsTyZb2gdYiWP3dnFgmrvnXJe4/jv+1OGBRs2Hwkn4HSpcJvIMxD5A=
Received: from DS7PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:3b8::34)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 04:08:44 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::63) by DS7PR03CA0029.outlook.office365.com
 (2603:10b6:5:3b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 04:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:08:44 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:08:41 -0600
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
Subject: [PATCH v10 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
Date:   Sun, 5 Mar 2023 20:07:28 -0800
Message-ID: <20230306040739.51488-5-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df79922-321d-4a5c-43e3-08db1df87a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAN7z4zbjrNCmaeEix4QKBJt07SPS0r1PGVIibYMVSPcu8JV5OH0rQIrO2Z6cb7gcW0RQ239045YZnyOjOV7JhLOyNHFHL2CKTmrBfP3ix3HkD3Fm+Llk0tZxzcMCpXWajwjPKLldtJy2lBcF9t/svtmFUf8vmZBnTp9gwtAxzOTLbJvtKc3bIXxJluwO7IwV67QpAVVSryi7ODi2G/TdThcuzF/+4uc2QBEUYanjUnJ5KlzcUxaz0Tb4zcwY5Jh+JFz4G6f6yz1ZHwnJ6TCEsS/If86iXqGnA4OQKGiJaK+z2IokAZGFo4aGYhvoQoi4bRz9vuWiCN7I3aYtJW7i6vZ9s+OzdLjWBn05lRdWU4ERqxEAVNR3fsCdte7m4dQAMqNLHdHNG7uHIgEroVpTx3AdunZij+qAoh52vdXSOlPd9wr6dfWFf6Mxou6D/ONgDH2iX3OfXARP5CxxpP/9wantAbiKgU/dml7aa5CIoQ9fXNjva3NPq248o8cVjFIl/Z4EZcUVHeUpBe7D8EGGUe7q8pnGEG3qs1SVtDfRfigsrTr7XtDobiWBD6Pq5dCr5ke9YKDBqjaQb720GQkQ2xAx259mSHCgdPT+lP9JhMEyDzNLINR7u56OyBfEYecmpIZAe65y2YadFaXwOvx8q8LS/ojAnMrDU3vWUUccFtHhXVIZWCiVziAY5rQdt5d1HYdeDt67qNH8GCvA0dw8cNM0lkcitMf0HNs0aItl+4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(54906003)(316002)(83380400001)(82310400005)(2616005)(426003)(47076005)(40480700001)(336012)(356005)(36860700001)(81166007)(82740400003)(36756003)(478600001)(26005)(1076003)(6666004)(186003)(16526019)(40460700003)(7406005)(7416002)(5660300002)(41300700001)(8936002)(2906002)(8676002)(70586007)(70206006)(4326008)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:08:44.5694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df79922-321d-4a5c-43e3-08db1df87a77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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

