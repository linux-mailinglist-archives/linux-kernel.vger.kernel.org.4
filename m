Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB266E9092
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjDTKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjDTKnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:43:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C4C5B83;
        Thu, 20 Apr 2023 03:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhSh+VRl+rG3VzqNOGJh7crs6N/cR/WxSZumqjvJMYYXPoNwgvmztjO8mo2CwPis7WmpzbK5wom2C2ID+ugmZPRovqLmT18qhVXug3BfnbaK84OTY59TXsctXTaIylgSSqDQaFdly/8ttIBq7PQ35O7l4gNgFoTrbo6I2qiCtC4S8AUt0IIx7S/lr0Aw8c7iJ2nvX3cgTW6/K1CtdsK/Ltg/HSqh7aJ6ZwVX9RAQ1x5ZdCdlDlIk6Im8RDM2hawkmw2osyD44pKDrOuEUvkDrCj+J/re0fnVxBkcK/ah5mIHGcP8b0NnIZF5Ey1mI30rfQ3z/JzX0j/br+n2xPFaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scHa0iKG2+wX89jGOfXo8F+ytRZ5R3mQYPJuROTvKK4=;
 b=TOZ1CW0NYmrXXDcZ1FlSKqc8rFHm9C/4qBVSEIL+CBdROryBD3yUUk+3zjrcUpjbAs41DadkySdVxonn9D/FqJsIfyHCf5X2n3dbNYPBZ9MCwDU4+5pl79S/oZSb0t0h0cnuUUKWzxX76/DJZhfu4rdAYqj9DUTVtr8/AyxbmMaKcl2ty1V1oLs2eJqkbxKwjMsD0KQw8JKsldq8Mhw+xBn3BK4u8cfzDEj401eDTv7qbJPnJX0tf1KSrJGXUcTGYGbA8eyhpDg9ruF1x7bwOnk/cmXDJEslFYriRyBRQbg404fldgXa+eRVCn26hAvfVDLGrh15+CUzh7X1H7au6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scHa0iKG2+wX89jGOfXo8F+ytRZ5R3mQYPJuROTvKK4=;
 b=F1NT6wIfQ2/wlQt7jJA7JhCEOW4Eo6kw949h0WD5WrnYpCQt5FLzSbS92YnT37Jwa7WEU66jKxcwHmTo+vlAw0SzygRbPg+/sWVLOs+J1OYKQRyA8xiuD8T/DNplgpnFIQjDk9LQ0JUA3bkEphGBri4CSxZtvFQGLWra9iYKwKc=
Received: from MW4PR04CA0033.namprd04.prod.outlook.com (2603:10b6:303:6a::8)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Thu, 20 Apr
 2023 10:42:47 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::bd) by MW4PR04CA0033.outlook.office365.com
 (2603:10b6:303:6a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 10:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 10:42:46 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 05:42:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 03:42:45 -0700
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 20 Apr 2023 05:42:41 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <srinivas.neeli@amd.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>, <neelisrinivas18@gmail.com>
Subject: [PATCH V4 2/4] dt-bindings: watchdog: xlnx,versal-wwdt: Add versal watchdog
Date:   Thu, 20 Apr 2023 16:12:29 +0530
Message-ID: <20230420104231.2243079-3-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420104231.2243079-1-srinivas.neeli@amd.com>
References: <20230420104231.2243079-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdea296-bc01-4c8e-1be6-08db418bfad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1knh167gicW1e4Bn3M9v2Llt6/w37nlZDzf+2UVSjUg6F+l/q6VlpU2dg2ICZhWIF67chQnvtkAV/YnHtLVCcQXOubSwNUpt94h5ICL6WTSZpvlMhBsET6iQuMC7xtaozFom71NrIQEnjTsKGlbv4/yEXjV/B9CQY8r4NlMmxTEHO/BGUNS9okW+r2aPPqVs9UpBMOmKrHPDk4H6uTYps1hFmVLJk2ipu7xhdRKai1lh4RRE9ToUaEvNgFwV9YIEIWLK4QiGHRyYO090dwnKxf4J4oLrfUdF4F6srXVlI9ClP3wCQ7Ycrc8keKdkksuXFDgmFUu4DZU3OKhsfWiyev/gynCRUA5vcuYdqAB0H7egrHEUguAaVGXZNYGztAkPUSsNVpaczaHnTdHOqOfuYQwjurIItMw/8unPCZXyY5qLKO2dn9hzYyfxt9F+6rEP8Szq0aMeTMjtD2Oc1LKQC0EHmup7v2Px+3ZQTihXvKSB/echzAK2RObSzL2omSodM9NOTyxo2BxNt40PHXxIQf4OL87LFeXy1DHFZRSR7AKEWIQeszX9dqIzG9KPFFuTij8mGiAgceAX8D5KxsKbhnYCRFICJIUGxun56kubKATxaBuDrlF0dqfBWvTyjXPtQ9sXcGLlIyQaU+tu/yJqjv9cXTFaXCF0O5oxMIFg5h6Asl+jwVDOhddyoHHoRNgd68ULA8g2LirSP0QNj26/EECY+nt09U6oX4Hl21sbFD+M7eOBZ/nBZ8hMuWOc6TJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(44832011)(36860700001)(2616005)(40460700003)(478600001)(6666004)(82310400005)(966005)(86362001)(26005)(1076003)(36756003)(186003)(40480700001)(336012)(41300700001)(426003)(82740400003)(81166007)(54906003)(356005)(8676002)(8936002)(47076005)(4326008)(83380400001)(70586007)(70206006)(110136005)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 10:42:46.5893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdea296-bc01-4c8e-1be6-08db418bfad3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Versal watchdog IP uses window watchdog mode. Window watchdog
timer(WWDT) contains closed(first) and open(second) window with
32 bit width. Write to the watchdog timer within predefined window
periods of time. This means a period that is not too soon and
a period that is not too late.

Add devicetree bindings for versal window watchdog device.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V4:
- Updated commit subject(removed redundant "bindings").
- Updated commit descriptioni(removed "this patch").
- Updated watchdog.yaml reference to local.
Changes in V3:
- Removed  xlnx,close_percent property.
Changes in V2:
- Added watchdog ref
- Removed timeout-sec property
- Used 4 spaces for example indentation.
---
 .../bindings/watchdog/xlnx,versal-wwdt.yaml   | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
new file mode 100644
index 000000000000..14b069599740
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/xlnx,versal-wwdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal window watchdog timer controller
+
+maintainers:
+  - Neeli Srinivas <srinivas.neeli@amd.com>
+
+description:
+  Versal watchdog intellectual property uses window watchdog mode.
+  Window watchdog timer(WWDT) contains closed(first) and open(second)
+  window with 32 bit width. Write to the watchdog timer within
+  predefined window periods of time. This means a period that is not
+  too soon and a period that is not too late. The WWDT has to be
+  restarted within the open window time. If software tries to restart
+  WWDT outside of the open window time period, it generates a reset.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    enum:
+      - xlnx,versal-wwdt
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@fd4d0000 {
+        compatible = "xlnx,versal-wwdt";
+        reg = <0xfd4d0000 0x10000>;
+        clocks = <&clock25>;
+        timeout-sec = <30>;
+    };
+...
-- 
2.25.1

