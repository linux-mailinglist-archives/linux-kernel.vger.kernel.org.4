Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47198703C55
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbjEOSSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244519AbjEOSSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:18:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E783918CBD;
        Mon, 15 May 2023 11:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGzIV+LZ8XeoE4JMtEwwAgu9N8OIDnOU3DNt6ryWkQVCJ3QNpCQEn4CRRKlgOCJRIpibKv9c9Q4fZtLkff6qGrlwsK2dulI7GOlnZFg3yrh/gpTM8riZzUmb0VEaqbDXrB9zZFpurwkuTqbuwitps04+OxYofmENlIIXYei0ZvLVAvTiqasYmuXeTkt5MVoqL0406vDroEcA9aN6YZNLuhyQt3gSbEKLgj65mwgxVD1CQ0U1en4HETSv/JNSlUuzj1fLBPA8Mzuqp87mje6LQFrQGDbZbshDL7A9GMjw4FMhRxM2qfO27J1eXeFaFd/L0AGot37u/NVYyCzrweh/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdjMsKDGByWg5y66uxdAiyV05I8JTa9IUC2qVwVJNzo=;
 b=kS9R+ztn5rsLwC7UvbDWmJO5gXitIAwjQStqPoLKjRKoMX+GkxdKdUqPt9cs7dTjuM9lodfVRuvAw7biXtbLecR9buQLU+41/l9DPaBPuo2I9bbxvOu6Xx60ut2X2g8tbge/2io2huno0tyRGEl98Vd3pWOvqpUv/PgtUM1KNUSLHVfnpXTJ+p5ZqNdKa1UIpo419gU9MGnLvzGre/GpnjbEfPCbvFn1AgJi7IJlb0mFvSEm+HYQXScYhU9UMvHWkBt73KF5j0DHt5mjEWCRiyqKz9OmDCxfKsJTKc+g1ZR9RH2s+VIZp6PHqEV9wB1vYzH/4l5Hl0EnKKOjPpDGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdjMsKDGByWg5y66uxdAiyV05I8JTa9IUC2qVwVJNzo=;
 b=DUsKMUC8+rUUq2TuJbItV+zWZayAgJ6RXYuUgiiRiW02Eh1uW52FjOGJfBO20Se+XuNzJdPNjo11Hl8vw7qxYJ5YBZsnbyjikIi+fgERG5JlaXZNUulg0MuSm/V2fKgCHc9A7MLhmEV4VsJZVpDYWVdbED1AZ2xzKqp8461fv+o=
Received: from MW4PR03CA0303.namprd03.prod.outlook.com (2603:10b6:303:dd::8)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:16:48 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::37) by MW4PR03CA0303.outlook.office365.com
 (2603:10b6:303:dd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 18:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 18:16:48 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 15 May 2023 13:16:44 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>, <gsomlo@gmail.com>,
        <gerg@linux-m68k.org>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v14 2/8] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Mon, 15 May 2023 11:16:00 -0700
Message-ID: <20230515181606.65953-3-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230515181606.65953-1-blarson@amd.com>
References: <20230515181606.65953-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 299b1ebc-ac28-447b-ca77-08db55708c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTY8uVGAlXOXqXPes3TcLFaQ0nV56ZHZ4MKwAyqf0Qpa/Q325BXDUA3tH+5evvpTF9i0wpAsjSTjz05XnBIWxRsTH1M8gUKnfCWa61vrk3H+VjEYFhQwCPujJSLcIbrmsZQcwohRPYoyozqXZUKghZYmNmgiEXGKOlPHNCH7T2FERrVRh2VRZOGAgXKISQ3kvxenbx2Qlm1yIS7Ek1Qy9Tg8oXAds7AIq7HE/fm9IWuaGubW18+0sd1bb2oNgNyk44Xe8TbLgxOvn1XoVvcFA5iZnoHHr0SzoJ5flqxiZNTC/yWbUq3ZIA9dQu2aPLPqEa7l4hDyHVIv/pREZ8DrA/LgXFxtsG30pgb6zczc7ri26VnKwm76ZQgx8DkYTzcHqQO6i0cZEBUZKl5ckDGZCsJNTVN8KLtHta1c3jms1EQ3DAdnBMATgEHg18sn4myAwx47uXMhKPxJ9c6TcY4qMdjm81+8SFJ+EaDZbimVo2wjo8j/qHgeptAvLBA6U95D7McR9jqhGu0bXP64+OXfkDZ2z6r11gKceI2EVBvsgbZOIsACvGEe00pMpuSA9i74jAKMpLYC08WrIfs9Dp/cafapF1sF9Zhnk7fDU5uRelRWthzB78ISCdsMDg7phjJf2WY5s0aDF7RPiYP1aMOwPwXxij4eEmI7YItCUoeHUbgQK9Yv0FUjpbIUXVqws2svaY1afyD7jEW/VGkaIjE8wcZWTQ4V5b/bg8sxTtuDWs+I4DZFkhFE73uVogtHNzmvVISh/Xdo7kZFcxN7rAwipA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(70586007)(41300700001)(70206006)(47076005)(4326008)(6916009)(82740400003)(6666004)(26005)(82310400005)(1076003)(426003)(356005)(336012)(81166007)(316002)(2616005)(7406005)(7416002)(5660300002)(83380400001)(8676002)(8936002)(2906002)(478600001)(54906003)(40460700003)(40140700001)(186003)(40480700001)(16526019)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:16:48.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 299b1ebc-ac28-447b-ca77-08db55708c65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
- Rebase to 6.4.0-rc1 

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
-- 
2.17.1

