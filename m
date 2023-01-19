Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55A9673009
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjASEMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjASD5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:57:13 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE8845F54;
        Wed, 18 Jan 2023 19:55:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uv3jHa52bhRoGW7fjTCb3QCVeUINvdCKln1RngY2Vz2aeCdArFZiD/hAcZcSWFBRe2itV1ty6Q4ZcUxgfKQBC0breegnWTeEZysV58/63lmdJaaJ/Y5N0j6y0O5X07x2ipiNFtFaK8NJIqmpfKW6n9/6FlNoQX3+RtdwMcCpmnKpjHKF3g9OWENM8sk/ymO309uG8ugm4haBg8C9xHx3eowyHiND2f+LuKPuUaH9rCso5Phg1fTztgaJk+9MobtNNJy0D4na0wx5Q+q9OWf8cLGGWPSmnXgXYo/y+NQOgpAiUlRt9CyJV15XVGQSj4k6LOd8OhYOJs8kRzFAKrlq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl+NRk1lPPWu1qLYsSSP0N9uQlgD1WldvUdBw1ctCec=;
 b=NgNa63aHmDcp064IL1hpZUYPb1A96eHFv38o/RX34bwNvdVRXmLnfmH4eAZKZ3F0Dgq3SuiReSFA+30Or5WddVjOQx7CGevyEn+BM1M8HtDnFXEe41IeFt/t8zI+vfPRKL0IpBLi0RNpPK9wXRnuDxIpqJeiGoVbSGJ/Z2a7w2kogmj4SRq1FdqS+SCVvQi0WREmR1FlAGwYlmZT1Uo/UPE1sZGJqQn0ZLPXutwWOKWu62n2BvX4ozH6SzB3FliU4BYBLEpmWbkA0j6djj49LrJ+CXO6lYoxnv6YKbqcFfC3k+WnezBgHILad8MpMFMHq+i0YRTDBsvZS0ywuAb8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl+NRk1lPPWu1qLYsSSP0N9uQlgD1WldvUdBw1ctCec=;
 b=CrUvd4LYyXK/rRBRsbLSeWO0REasyswoA0uV0nBrfKaU5ILqF9iblVc4lxheWuVtvkHiNVgQHPGYqtelwQtysGDL7fZaccYNEzVQXGYE14yaUvTk/T6819U0iACGSMD4c5em3lSD4wtDtNsdFNAOWfjZdN+i+l6irvvJTqhvi2g=
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 03:52:17 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::9e) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 03:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 03:52:16 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:52:12 -0600
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
Subject: [PATCH v9 01/15] dt-bindings: arm: add AMD Pensando boards
Date:   Wed, 18 Jan 2023 19:51:22 -0800
Message-ID: <20230119035136.21603-2-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 5004b69c-b4b8-454b-a70c-08daf9d08e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTNqb9h6ziIjtLyFIP6Rqs+WFSdAQnmXqW122n+ONNLueE9eRYqrlQTjsgh7a13S5TiuUFcmmIiLLq3/ARMFtgUrxyfXTmnOFQevW4TyTmxrtE14speDB/fJGl2FSZitWBSTi7cwaIt4gBuT9MHR92dC8WcIdf/4xL3lAX2DeaYIpDTMxnTj/LEEUX/fFHqA47zPr5jw3v+4cYD8R7os9CiozLCpwbto0mDZKFS/seISUBikdN+Qdn/t8WTcn/LUr19io3W1vdISRxs8Iy76SLpcQwH/j4kbUnPPW4100OLoL61j8ITyUIvyNDx8ZMsNGX9JWIoa8T/wlK3URomB8HJnvdS/EVXFI/A2MkBGU84fzxQLFi+60jPWZb7Wpvjbdmtf98BFaqfJTjfsrwrGOHfqKwTnIvYRWW+fJt5qwnNX9W4k+cheHyTtFLrW5vlexIHKK2Fs9kjc10yshyMmW8hmiy3UYoFUHATKA60bc5MY5+c4lCzADw++OCV2XEpXk5iY9I3RpHlkr7bknXhhpdJq9X9+XxMbVLTg0WcCCPX63xZI+Q8UOHEMmzvOOu1QXnRdv9tR37hKYfTBsHAB/k1Lw8NMmjJ3KC/WsLEdLJNJBP/JIaIvkuPcJq2wZbjKSPLyiGE73kIua3NnIrJqpTbLj/N1QOsZPojT8KUNNUo1bJ3dnRUeXx9wSdVV56y/2TGGrboXjq7edqa1m6ZbrUQjXIMUHT/QNSBYk3gBYFA9u544Bp8hyVoDDJtqvosk1VWvQbQgSlL/vzXGLf6p7TuDNC9cKUzvsG24F65TI+0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(2906002)(356005)(70586007)(8676002)(70206006)(4326008)(8936002)(7406005)(5660300002)(7416002)(6916009)(82740400003)(81166007)(36860700001)(966005)(316002)(426003)(40460700003)(54906003)(478600001)(6666004)(82310400005)(40480700001)(41300700001)(2616005)(47076005)(16526019)(336012)(26005)(186003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:52:16.3267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5004b69c-b4b8-454b-a70c-08daf9d08e71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for AMD Pensando Elba SoC boards.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Brad Larson <blarson@amd.com>
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

