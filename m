Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CF7673024
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjASE0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjASD5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:57:04 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7464DE15;
        Wed, 18 Jan 2023 19:54:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/A2ZM8Rqr4p5ogAQtw3ZT0mELVDSzeTmaUGEdBjIJh+I97EE65Ksf/N3E3y6iNvVDQN/aGKj4swtwym30Mir+vjjy2xpVYqcU5ZNbvFcZhqAyKSu25q9POajcmlxFEG5vUftdbe9o6Z62oIFTSeQqW1TucfEO4wz+2JtG7662PFTii9u6aTF7ZB2gB0uW1X8mGxKapccs7i7606x/bM/zYqyrAYZgNfY6vEHe2jfTJWvvYlKNAoJo2l5GH/dIos3ugp7HyJAsyuunPC2NtP/0GzFqKYZg/1goVDmyyxRCfR0pIiwcBiQmSa1grhSfiu2bvMPXYnNGbknRb46FgrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9zD9oWQnbZ75azYdkubAjDxtGIPkmpxtF5o8raYmT8=;
 b=axOqbXYcHU23d2VpT44q75GRyI0zbHKGbA3guQUlwxK6PGoETLxgP63/wEEEBEbhT+4ABeeUsPE3YsNn++KNAjfOWsUaJ6leFlK7dVorZGVinJwoNKjiDY3y+Di9nOm9+yfCm+S22MtsahgI8VEIVjStoc1pUn4hLuVR47G094+imkcMFCjmThco7jQtxLTJnkCqyuHr5izCYcJY7zyXS3+rzqrROmRVxMbN/jZQSqSyNWDyIFGQ955dRo7DoBl5rHiOhthEJTrBPgaSxFnXWLA9CagL58BvTf7Sd9NgbvzubLy3dqPU4sCFV90hIuWCTlbiY5VkoVRYUmLTnYg3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9zD9oWQnbZ75azYdkubAjDxtGIPkmpxtF5o8raYmT8=;
 b=Os9+Mu+4Qw9kLyqIxKaW8G6Zd+kJX2YU8HdCyWAyeNJokSdQ7k2+Ld/2jITHhwWR6hwOytiJcs6k+J7D+6JIEUaU2iufBw/5EhlgpEwwaOHaNrHiKt24P3jZK3Gwpck6teWTjlFxnTZsvTEKAf+0oRXxk5jImjge+QpLCpXp/f4=
Received: from MW4PR04CA0271.namprd04.prod.outlook.com (2603:10b6:303:89::6)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Thu, 19 Jan
 2023 03:52:27 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::23) by MW4PR04CA0271.outlook.office365.com
 (2603:10b6:303:89::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 03:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 03:52:26 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:52:23 -0600
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
Subject: [PATCH v9 03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Wed, 18 Jan 2023 19:51:24 -0800
Message-ID: <20230119035136.21603-4-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: b603af82-32b6-49e8-d5c6-08daf9d09492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aU4RE+BjMHRSevNOB2MKTVIebEFrFc07yMb/ebeJr+3nPYNwSCSE2KXkEhR6VpnG5pzSakxt0nnw+smu+TR4Ck/4xKQL8sapF0GiNTwM3n9qiT5Az9gzPpuu4PPEK9e7mwGYLVmkzyiMZpK1y5GI7tTBze1TCb4aAHzF0fTRiu7hZILAboWdqQYh9rvcxcvd2r67j2Nf63tybyLPUeVMafacGbBWbrC/YjmgdVXV1NDl6bxverKB/zD9WONENyHgyep8VEe9NIlPoiCDqlNuMxuhWMJfws9v5//mIgT1AnaX2a+ZizG8lpY5r8cOOFPNauWhte/dMeLJf2OxfUQjokcK5bxYmKqRUiDkVIUrj0nuFyVRCuFCImm2d5EEsdVfxRR7EpMHX2YLiaMXvshMc7h7SuHNVIe7HTBctXdFil3V/YJTldSd6n2gIDYGz+0mSGBEaolvPLbB6Eo5m3sTER+N/XLvZF92R+Oauca/EgWjyhVB7R+eSfru0nZbuFGsRkPgxAAeScjQMq1ckGAzPIVbvNGmnWLf7ziCzxtZ1QDUzukOQNniqGNo7klZAsy7LKZorgWHGyf8QjnrsA7yy6sVoSZjxR5fmEqgIN1blfKqU2RqxqiStpnKlVPKbq/gbjgk68/A6VwxeE1a04Pxyo8hoZIHzE/VpbHDp1uRfsS6KRkmn74muE80u75uBUbd1U5F07AXfmQl4CX7qOXuBiTDt6qI3CQpLstiOLff9rE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(16526019)(41300700001)(40460700003)(36756003)(7416002)(7406005)(36860700001)(40140700001)(186003)(26005)(5660300002)(83380400001)(82740400003)(336012)(2616005)(47076005)(1076003)(316002)(478600001)(54906003)(82310400005)(426003)(356005)(70206006)(8676002)(4326008)(6916009)(70586007)(81166007)(40480700001)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:52:26.6105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b603af82-32b6-49e8-d5c6-08daf9d09492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the cadence qspi controller compatible for AMD Pensando
Elba SoC boards.  The Elba qspi fifo size is 1024.

Signed-off-by: Brad Larson <blarson@amd.com>

---

Changes since v6:
- Add 1024 to cdns,fifo-depth property to resolve dtbs_check error

---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 4707294d8f59..a6556854234f 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -20,11 +20,23 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amd,pensando-elba-qspi
+    then:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256, 1024 ]
+          default: 1024
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
@@ -48,7 +60,7 @@ properties:
     description:
       Size of the data FIFO in words.
     $ref: "/schemas/types.yaml#/definitions/uint32"
-    enum: [ 128, 256 ]
+    enum: [ 128, 256, 1024 ]
     default: 128
 
   cdns,fifo-width:
-- 
2.17.1

