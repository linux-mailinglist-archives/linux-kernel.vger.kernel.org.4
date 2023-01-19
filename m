Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8280967300B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjASEPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjASD6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:58:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2846D5C;
        Wed, 18 Jan 2023 19:55:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB61TNvhlUyEK3ngtJ8F91Xj4p+sPG2QmWBiK5zNXb1Qe2iXKQWP8mBiBfGZxRKuq3EGIZR4aEbhAwl1pNb16VVUSyzLLUiaul2bcqKDnMjQlrZnfar0wrpd2HJd7poYpGMmt6Dvq7nTLc0eGI8Atx/LfjxzU50cCljvfFUC5n+fqQ7qQRdeR8Ae0qE5GSbXXTV97ngEjUVg9BsxipUZsuMpBgPfzcOlnicbapQ85EWM32FpkZ7gPbORahoay5si7u0r4bR8uHJXNuc6bGJEA2+tQPTVlfsmSfxFLVlkZCmLoO1tmp2UnBmBAiWbTYcWzxNliLlkUCwOk0XjmE0Tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYpFuG7rsB150mQqKa3m6yy9plhtCt+6ntf6ZKE6kws=;
 b=fQnzgsQLmkWm9rCZcGLrWxywkKwsRSaE0cSiU9O0ZqLQOiuW6Z2mzTglLLn4A4LF7dt5eEcCJqBFZ+7Ai/R3GOQBsMGNI4QV2bvwRypvpk0vRKbMVgN+3Ko+M2KNzKnMVGVY773qPoopsMfEqChUyj2rAcYARwwkUf5eN/ZgGLTPB/wOT+lF6XdRh/sCp7hqUpP4fm8Ga5HVBLzEAsdxme83j1z2ZFHI1yHK5IsFW67h+1d4WZ6yHD6EjYt4nX7G3NYRgU6Ftkb2Urxc30Q0r1jgoxaANJVePeEuTORMv/icNGfxiEU3eU+VWIGAFyi2HoNcd0fx7Xp0rCn4ytyNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYpFuG7rsB150mQqKa3m6yy9plhtCt+6ntf6ZKE6kws=;
 b=mXNIq6XjwNb3UAAXWf/EGDYir0RPwdBry9qwGHD4954Jpt2CZGhim874PfJQBsTfRC0akYefeKZUEdioElPAvdqYWpejpkPL1ob4Cr+3gr7LVxfXCTyh05qiBnr82wVTXPHypIh3tpQfHy5jAzLLhEOvWUP7LC8zX2nDzintlak=
Received: from MW4PR04CA0285.namprd04.prod.outlook.com (2603:10b6:303:89::20)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 03:52:30 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::aa) by MW4PR04CA0285.outlook.office365.com
 (2603:10b6:303:89::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 03:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 03:52:29 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:52:26 -0600
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
Subject: [PATCH v9 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller bindings
Date:   Wed, 18 Jan 2023 19:51:25 -0800
Message-ID: <20230119035136.21603-5-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: d19d78c4-7b59-46e1-b7f4-08daf9d09663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/zMtOhZVHX8t5fDpcrnVfuJNuOfp+vtMJFaPkmUjxGjG9v4dy5S+diRiAkXMb316O5hG0Xoj4uG5ICiOaL77jvqfMPQfVA496wmk0/68hU8vY5Ee2mT/MCQK1+CO1ET+lKjcuG5xuV5etlsOFRM+YO58G6emTRrcipfV05wExqlujKdkeI2uKJjsIRz0x77sjTv+ua3p0n4qNfGVH+liJAaGv+1q+M6wyG8fJ3UjMzXPzdsyVucpQU+T6Q8pFuxwoZyM9yy5cdqF2bFWKids89/MIqoR+LZdbRV14YHECorxRTwQIwwY9V3YUhmp/6wD/WVavaWL4DeUEcpoarvbf/bBHV8arvh+Qti61EAxGycTAT5U7AhtfcfY8ybayxBen6F1/OF1Fy5ZkqZ3XcNX/cv9H2VVkOt+XOJqz0VZJtxRxagBc6fcfbNlUaFKLGYSZZgRphqX04AfVM8oxH0f7x2PC/B4TfNzTJCsbJSB7JSdhJRJhPKZ1hJW9Vgo6yX/JoWsOwd05Z1rvzHIS+pXf6KkUbyKj6FsqJwfCRgYxM+0wEEfgo7BgR8dsbl0cKw+McqPiB7o2imXGFG+3waY/xZCZAlPOZoMgt5/lh3Edkqcu2pSIL4IHatul3m7wYd2f0IXsu/klkRAHs1UdqOaw6Qo4irztbNkkWCz0eZoH50Y8kT7qVrSN4p6/Hz9pAmpw4mW+3fTMdip09q+HRkIufmnq4VK/lmHwQgOILsrsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(316002)(5660300002)(40460700003)(36756003)(478600001)(2906002)(82310400005)(2616005)(426003)(54906003)(47076005)(336012)(81166007)(1076003)(7416002)(7406005)(70206006)(70586007)(4326008)(6916009)(8676002)(40480700001)(82740400003)(36860700001)(356005)(16526019)(186003)(26005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:52:29.6571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d19d78c4-7b59-46e1-b7f4-08daf9d09663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Pensando Elba SoC has integrated the DW APB SPI Controller

Signed-off-by: Brad Larson <blarson@amd.com>
---

Changes since v6:
- Define property amd,pensando-elba-syscon
- Move compatible amd,pensando-elba-spi ahead of baikal,bt1-ssi

---
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index d33b72fabc5d..96b072835de0 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -37,6 +37,18 @@ allOf:
     else:
       required:
         - interrupts
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,pensando-elba-spi
+    then:
+      properties:
+        amd,pensando-elba-syscon:
+          $ref: /schemas/types.yaml#/definitions/phandle-array
+          description: AMD Pensando Elba SoC system controller
+      required:
+        - amd,pensando-elba-syscon
 
 properties:
   compatible:
@@ -63,6 +75,8 @@ properties:
         const: intel,keembay-ssi
       - description: Intel Thunder Bay SPI Controller
         const: intel,thunderbay-ssi
+      - description: AMD Pensando Elba SoC SPI Controller
+        const: amd,pensando-elba-spi
       - description: Baikal-T1 SPI Controller
         const: baikal,bt1-ssi
       - description: Baikal-T1 System Boot SPI Controller
-- 
2.17.1

