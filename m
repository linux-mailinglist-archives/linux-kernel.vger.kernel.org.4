Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39C6DCAF6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjDJSqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDJSqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:46:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D511BD9;
        Mon, 10 Apr 2023 11:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYqlXiWrySCXnG2FRosnwd6T/Y0HWV5mZmr0vZdIjFUbl6jQO3/BKI5V+uuVHDrzHYovcFqumCa5pOiGMeBmzdnXz3oUhFfDTtj9Z48q8u1UyUmbnmto1YdfGmQ/pK5O1cLZutAbDV7lKaYytuHOZvEm2vIGU3oy0c6q6MaZOIl0FAi0x8TqGPbET42C4cw3ExRYJzocGxA7YVZ1zmfBTqH3wtbzwJeGeQkLqVdJKnkmF1oMdxT63h9dFs7gwbC+C+TYck2Caust3x3QS4Hqxp0JuweLUKvI1D9svFuGyKTy49w+BCZYoijU0CbpgfHCJXz8qAdGZmr3/2AXwz46Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6heMFDr/vcoXtcG1ihJG6vNQj/gCmyUGL8Ele90UPF0=;
 b=VGr4AzyreVD80ULGLQbPlAhRG385Jd/sGZWillqmw8ENL02kAxakpZVTGe50g6siAd5qsTWcMTQjy1ASExqqMosiBF/ET9+KHHjsyMBabgwKavkJWR2zYSO8+qdCisIr8zt+G4p6BqjuLYMNVGymz8V9wmI1Mv43WThJHLZpgu9OzB5Wa9lepUKxvUekz2G3HQM9BNjhyWH8+uWHDsOhqnlvDFjS65l7vOjf7fjbP3BzkKCbIxH9PWrtTe0gKh7U7Ije6CcjqA7F47lxvn3xM44o2ge+4yzFdy2lseolplCkpynF7+bKTMISMIDzl70HXfIQnwRQQQ4WUtPJdAaPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6heMFDr/vcoXtcG1ihJG6vNQj/gCmyUGL8Ele90UPF0=;
 b=vK4MYW4dLhLOhwFPgqRujBc3xIcZolJvq+QgbmFXxRonJdnUizXjA1pjH6Fv53VWylKynhtg16YuHscYBub45AkqAoZsJvt8dRN/pDHHJq5CRTrzLieGcfeg3JTSMKzJAQx7mYiGkYDiFaTx9iJKH+60drl1C7ifGthu632bCbo=
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 18:46:18 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::f9) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Mon, 10 Apr 2023 18:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 18:46:17 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:46:13 -0500
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
Subject: [PATCH v13 03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Mon, 10 Apr 2023 11:45:14 -0700
Message-ID: <20230410184526.15990-4-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 232cf6d4-9d3e-4a13-102e-08db39f3de9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXml937w7+sUXHldx2GdYBeGk/iANxCuInXb6XRWQW6ONeqEa8wsMd9V2eu+lvpXJdAam6Tdj3NjkQFkVkEVBhsaL8KEw4+zbCMhW7+uoyFMrrQWFLJqcKb9VHLbNTrAGULdUMFPTXz1Ulou2vLYfz2P2rv9Fpv+RoKni/zaNOL06Bo9lLFgti6pEOYpxSSk8tC1fytdfrjWzDUb/TdzIGGUxIM8rK3zoyWuLnlOCIdhPu+CEMCg1tnerbHC0aq9crdo3tbVp9MD3CLXcVyTWa0YPAYdzSp+13v81OV7AZkhcnpuNKRBf1uPJBhr7hB6aptY+oDOb3tzgsJlFU4s0+axhLlO/owPbc7M6+GDp4/8QT+mRsPljKBNC1U/GbrvYVfhS3bjpeMvcpqjmPOynjUre6k8fiRMl4K08r81u/fTXALXoS0Dz5J871N7yTH4USs+Ii8fI1dDqbv1nf5O1GWY3ac/OYIQT5lxJRO+Lf3cqc7sGqMTSPT/Cnc0Y5V+9dEXBtDJ8G1D/Hj7kg3C0qVy7HpRxzv9CBEriId71wD4ZGvPQdlx5gWNag94Nb1ACt7P/pqXtPjz4guYRf/TBLBm2l2hpJ9JpnLeL47cKd2/HikFFqP5qRXFep3k6+S7fUYVKVZ2sieo/j/pv57vWKCzoWbz9/W5TE40XPgFxShlKiSx5PjTvf0mUqSJjuy/MEyFwg4d73tL7kDkCRJ/v1vZ5/7yUGaJ7cpW0ay/GUY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(316002)(16526019)(1076003)(26005)(186003)(54906003)(7416002)(2906002)(7406005)(70586007)(70206006)(4326008)(6916009)(8936002)(8676002)(41300700001)(82310400005)(5660300002)(81166007)(356005)(82740400003)(40480700001)(36756003)(40460700003)(40140700001)(83380400001)(47076005)(2616005)(426003)(36860700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:46:17.6947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232cf6d4-9d3e-4a13-102e-08db39f3de9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

