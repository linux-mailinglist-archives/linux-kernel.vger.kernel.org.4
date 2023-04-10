Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BFE6DCAEE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjDJSqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDJSqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:46:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57611BFF;
        Mon, 10 Apr 2023 11:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELwS8HHMnyEG7DC9iZI7e/beIDb7dC6pCJEJbY+3JrRGoYaJyHKzWMKYD2WcQXsmQJN9m81PJ/UUbTyAQ0peg3ZVGtd4+/iCZbAXp5B3PdVdizTKhp4TmTXp6uFLuIjfcolEPLydOw/UPZa2LzoNdh/ct20H24iXeBD0lfY5kSEVib4/UwtBEyVLTwPXmZ9Wk9R9VnBi9ql7cQl2y3TITQUjkADuccGig07oY8JjqfbT5k4zgtytlbGrrqQVqExvVTBDQRyoq4oxbN8zZ8spu6YpxMd7RoTlCt6AMWC/EDy6XF8KXbbRYZMz1zez8b8uWEFIrHfRJrIsH6RuStRciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=iwbH4S4itCGMaN4vkxH8aPr6MxzCdm5RYFOm8Q+uu0CwOSAscuPD0AjAJkcdkbCiSu1Ruh5f2pEgzZ7hlHBPqOOoHVwVf4+GCTjBMBBJlyGnCL7eDCPsFYwO3FwVOJfCITVPVtBhI6Ow4mv8z2xqyE4i4lJD9mhyan7YJ7wTo2pRQiGnLRciwe1KJmVUPKZaZLJTX5ohs8UbIlrZ++PRUd0C1CTSJ00Rv5ckPGTAsXgw7HoZiLL8JFh/lez+zUYHy2g+cJ33siggFzclAYYqKy/ZTccBuB4ujUXLaYMFovxASsRaaATbeuMTVEh280eIIeVujcsZgotdbwL4ZMDT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=T+/ZnYwBnJlRDlfM7ZYbD+6oEgIneeVPNRPaPbWI7r5C0cCIjAmNkq2V2bI3MXCe9QlO7tedQ/+Jva5IFSBDniQWlVOnlks+Pb9JmUIpgoIG7nrWVGdbaErkcClSegqJGrFHZshtfTWopYlI/EuP++EtDhSAyIrR7VYcUv2Nf+U=
Received: from DM6PR02CA0053.namprd02.prod.outlook.com (2603:10b6:5:177::30)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 10 Apr
 2023 18:45:57 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::f9) by DM6PR02CA0053.outlook.office365.com
 (2603:10b6:5:177::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 18:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Mon, 10 Apr 2023 18:45:57 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:45:53 -0500
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
Subject: [PATCH v13 01/15] dt-bindings: arm: add AMD Pensando boards
Date:   Mon, 10 Apr 2023 11:45:12 -0700
Message-ID: <20230410184526.15990-2-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 9918a30f-d7d7-4fd4-8af7-08db39f3d264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qb7OWIo2fCSUZ+qceUa/P/dp+7xHvWRrGB9k++xPq6YUAYwysgPUunJVbpQlL4ItqU82sah6AH0qrGdyBDFl6PhHrJxZXVdkLdwCUpISYdOdBLWbuTATQSwm3dmy78zKheTYx8hTmloNkdEFUUGst0RjNvNxdEMwMNoLU/ZeHrVp0JFljdHVL9lrlVi8PtSeNNuDs7JbLsYuPzkC7ufHYhIDz0jidCmebMzY6yR0aosOx8IbTV5XAZ2M6CyoRlN84L8grmUz/cpeNbncfEUjMW/lSQhwkjaWDJs8dc5aH/pDmu16vCzOSgc2f00faZh+93ikN5UbbNu1rwRl4U1fgGEIucu4GAhHX9i+Pe1UF29HlTp4M/SIv+cFAIX4dfIA8SJRwGjIacE4MHJXLS+VWAp76Y07dxV4YHjhhhm2vU1WCNivh8BOcecB6sS4b8KDwC7Fdi/FwG6t+q5SvgJi/60sIxjky8dBCZayeJrptEINT1hC/0Emvvq0Uez244nBo+OeoSaWR5LVrzPFRbBAJknyIzPEic8XGzLR6/cMx16G93eWIO58pSSrdlZUuAuf7NrV/u/Bvtch2edpo4G40L2Q2eh9/OKPrhuN61CLacSSKCwQkr7xgCmLjaN+Uee0AY8lHeqD+OWT5MW4arX1wDdB1IaBpkAkDXp5UNRH8mrX/c2E7wkpGbZsjjRirhKJ6MjCqgdR92/2V/3HQ+8eq/yX0SD30l8i7bcYY5dYNroswcJnOW1cGhqosDjqUnrs4CiMiwaXEo0O4gJL0IyU2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(186003)(5660300002)(7406005)(7416002)(16526019)(26005)(70206006)(478600001)(40460700003)(4326008)(70586007)(8676002)(6916009)(36860700001)(966005)(41300700001)(2906002)(8936002)(82740400003)(81166007)(1076003)(6666004)(316002)(54906003)(336012)(82310400005)(36756003)(2616005)(426003)(47076005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:45:57.1916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9918a30f-d7d7-4fd4-8af7-08db39f3d264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for AMD Pensando Elba SoC boards.

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/amd,pensando.yaml | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml

diff --git a/Documentation/devicetree/bindings/arm/amd,pensando.yaml b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
new file mode 100644
index 000000000000..e5c2591834a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/amd,pensando.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Platforms
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+
+      - description: Boards with Pensando Elba SoC
+        items:
+          - enum:
+              - amd,pensando-elba-ortano
+          - const: amd,pensando-elba
+
+additionalProperties: true
+
+...
-- 
2.17.1

