Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4846E6EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjDRVuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjDRVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:50:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D5512CAD;
        Tue, 18 Apr 2023 14:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNG1dBWwtDuYMKEudd5LQc/mD7lzHj6ozEPpnZ3cGaPrUefciIpb461JNYTuddkNjNTPvNopVjcELWFYjsb7HtsoV8n6AHBVVo/zi+ZN1BvN3ANHukTyn+fXR5IHH6u8BoA7BH7Nm+0i55UOYRgqddGXA7SQoAihiXL2+x4YICQ0csVSR366EPz1ZLuY+h8FkNW/3WjlumE+fSz4nTdgYkr2yUG9AEnL8S4UJjMOI9bAAHeQquR/Ce7RsxD2SCTnoZVpOVmoyb119/cbK91GI4dqxz0xPKsaiWg20TzcLA2JHC1naPzo6J98WMy2rPcdzrGp9uBekQPjX0kgATU1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SiX77mWSYtvvCkRKUITeJVeuptTobeIO2s79YZu8qo=;
 b=m7D6BxViquqtLmqFeMkrlJQxLqa559Xvu5yNi7VEmi39ztxFLKSLsA66sB7poGw7bDlx+R32m0cQaM+b7jg6k2G177BlkVvMrPvgGCAlerd7lDp+iWpbAz5VkIP8m+UjemvEEGCJ81JYe7MBAXdnAvCu87wpU1PHsvrDa1qCHs4mSyGAVxkvorYUmEYifpSjtqbKqtlrsKfJuXCsAS2nlA+JSF5rhUaNQdHLh17tHG9Q6G57ivqzojOE778QG8CbEknhzmaLw3nf7WziruAu4cmjEaAmMDDOOR670CnfeOarrLfPafQ8nZ7iQTL1iXUuNQosCXb/XoqA44Ib+TijYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SiX77mWSYtvvCkRKUITeJVeuptTobeIO2s79YZu8qo=;
 b=qK0LTlUg9SoGpHNG64jGZ454J8ZEVBrDnrULAE8Z/2mfgysbzEqXOcec6s7eTi6gq2dFvFFdEYfsxnc71Dq5kzgCo3mB/dcZZvL8Dh4dC6tfbC+dcg145jZVFaxwcV7eRuUP9c//EcuY/s3rMPZg3Wxu5nZZOrSV68KviX+XIAI=
Received: from DM6PR06CA0013.namprd06.prod.outlook.com (2603:10b6:5:120::26)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 21:49:57 +0000
Received: from DS1PEPF0000E646.namprd02.prod.outlook.com
 (2603:10b6:5:120:cafe::9f) by DM6PR06CA0013.outlook.office365.com
 (2603:10b6:5:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 21:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E646.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.16 via Frontend Transport; Tue, 18 Apr 2023 21:49:57 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 18 Apr 2023 16:49:54 -0500
From:   Brad Larson <blarson@amd.com>
To:     <broonie@kernel.org>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <devicetree@vger.kernel.org>,
        <fancer.lancer@gmail.com>, <gerg@linux-m68k.org>,
        <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>,
        <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: [PATCH v14 03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Tue, 18 Apr 2023 14:49:45 -0700
Message-ID: <20230418214945.54690-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9c7aec03-265f-414e-9a3f-9511f40cbbc0@sirena.org.uk>
References: <9c7aec03-265f-414e-9a3f-9511f40cbbc0@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E646:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e3cfb2-3179-4dcf-67fa-08db4056da4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80iIufSSweYb3cLBXKu1P0RDGKEnPRDQqe5DBW9OgWUdIc96bDi2Q6URTsjEXFMGhxTln2CWnAtyw5hJs931Jg/aDAuFlC8pKjE8LuqnCPVCtq9coyFmTHSxC4cqMx5g9Un/U7cfBQ35aBnVQOwrxndvwzEPdSktE8n7HIyKI7tHXeUG+nsBpJdIh/RcMQMoUPk0Xj+/ZjKlP4G3lcl3LLOM/H+LZaEQauNlIq4IOw4KnOXAdI6ZU3+Jj6IEPwVuUyOhoRTNYCMhrumpttB9xD8tOZoPHQ58Ng0HRohSy1Gfs7z3yZUY12z/n7EkOyxwm04F9gt4t+blIS4UQOKLaFJT1DF7YnFrItarbpXZFrbfZWqquN+y9uqvi8vxELu5+YBfxEfXwNrvR4sUi+sceslvvJi73dumpbZR/6T0h80apTg+Ipk/JC8Q4do6Mb9ZLBCuSYQaUw931Xnr6FyLENmPybZpNt/+yq/cLbNJZrYspwjyzNZNknCRwPOxTdau0n2G/RsZiNmk7eQcYseP8uIWwY6fpNHeUdJGK8K7pRKHFX/55viFRvMIsql+v/nNQqmiQh7h9P7BEh+KLqYplCrIiJFv1LMnUP3w1k94QkphojsdsSFVssRfrcxJ/RoRQEpGUm278+xttOi21u1bO12LkWXh0k0c+uW21iS9/k7ujMJyUeLb2bH5oDxttUDu2rEBlAEfHT5vQ9WpvgRmZ5j/J/9jTULgwMXlf4NCMWI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(316002)(6916009)(54906003)(966005)(70586007)(70206006)(4326008)(40140700001)(36756003)(26005)(1076003)(40460700003)(47076005)(36860700001)(16526019)(356005)(426003)(2616005)(336012)(81166007)(186003)(83380400001)(5660300002)(8936002)(8676002)(82310400005)(41300700001)(6666004)(478600001)(82740400003)(7416002)(2906002)(40480700001)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 21:49:57.5768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e3cfb2-3179-4dcf-67fa-08db4056da4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E646.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

v14 changes:
- Patch series is against rc1, this patch failed to apply to
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
  Rebase this patch to rc7.

v11 changes:
- Removed redundant if/then for amd,pensando-elba-qspi

v10 changes:
- Fix cdns,fifo-depth, only amd,pensando-elba-qspi is 1024 bytes

v9 changes:
- Add 1024 to cdns,fifo-depth property to resolve dtbs_check error

---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index b310069762dd..4f15f9a0cc34 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -46,12 +46,28 @@ allOf:
           maxItems: 2
           items:
             enum: [ qspi, qspi-ocp ]
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
 
 properties:
   compatible:
     oneOf:
       - items:
           - enum:
+              - amd,pensando-elba-qspi
               - ti,k2g-qspi
               - ti,am654-ospi
               - intel,lgm-qspi
@@ -76,8 +92,6 @@ properties:
     description:
       Size of the data FIFO in words.
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 128, 256 ]
-    default: 128
 
   cdns,fifo-width:
     $ref: /schemas/types.yaml#/definitions/uint32

base-commit: 67d5d9f013d6c3829383c08162939cabff14fccc
-- 
2.17.1

