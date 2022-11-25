Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0A638395
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiKYFnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKYFnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:43:03 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB41C1BE88;
        Thu, 24 Nov 2022 21:43:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfsNBynDErtUQUXTRwqfOpowU1Jj6t0PI4p6L4SVwQwWUXrRs7u/G2k12aYQBYPG/1UZMbT/OXxfx5Ur9S6wqtjCS7V8N02BXEArOUJbLbvCUlbjb/o+l+9ILePkEnCImMT3AuQXIHOrbAz9e/hHrAGOk7BAF4/3TcmjJyvx99xZowuEhxyN+sW4gMkCCoChrA0AULJNlS/tgto9wGg9nacwNF+H58ZSin1d/JsNV7cTLdZ9AU4daUzDtFdpSddXLzavvSVUrifU1gnQCHo49f0o3mIP/KF4MsZ0cJNRZNgI6T6sjLxab0QRWCUSf0u/4cpS2wbpX+UKw2fzFZJ9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7Dqr/FDyy4ZhZQgBLuPQvIMlpwgCxwTdGnA4gzrUDw=;
 b=JygeaQeH31hJ31FVJ989wkJDWNO+DyM9J/tcOc7nvrOK4WNe2mEVasPHOn5VOIlvMZipA4rJ59gY6XXEGiKmOL+8O+F3eyOVFbHuWR7aZvsG9ciCC99cxbV6UOiBQqwAF48bErazV1C1bYttlTeANmjG97XYgRKFR3gwXca9/8bAyqUzTmNab+Bcx5ZPLdyigvmrG+08wAlLEG2ELcVVlBmygXl6ox3TuBg5IygyN+CZloDwy+KZvD7bT21SQzjjCA9y+xO1UWDHtxDlJFgjyAt/huWFFHrMQ3HbnbOWcRfeS3DQUqL28Bfm7Bc3Dn7w/wB6hkUL/gy2IvfgVAqPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7Dqr/FDyy4ZhZQgBLuPQvIMlpwgCxwTdGnA4gzrUDw=;
 b=UgT9Q+wmbz3am8Wm/qK5DUTJN/j2t0g7M28UyC3T52LodVu/QnGs588OJqzhxOfwdDEtCkBoBSLhj6TzgJBNLSG1y0OKLaXkooyqfji4wsCrF0yjftx95DFAQ1NTTwioR2E+QqwUvxaeSJwcnFdoPEZYVq3uE9Dy0M3MEYeU+94=
Received: from BN9PR03CA0237.namprd03.prod.outlook.com (2603:10b6:408:f8::32)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 25 Nov
 2022 05:42:58 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::20) by BN9PR03CA0237.outlook.office365.com
 (2603:10b6:408:f8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Fri, 25 Nov 2022 05:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 25 Nov 2022 05:42:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 23:42:57 -0600
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 3/4] dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
Date:   Fri, 25 Nov 2022 11:11:12 +0530
Message-ID: <20221125054113.122833-4-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125054113.122833-1-appana.durga.kedareswara.rao@amd.com>
References: <20221125054113.122833-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f903e60-3ad5-406e-12b6-08dacea7e8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhONuJ5BpiCecfVG8Bic5yR8aj1nqMlvqZjlzsyZzZ20FcSX8lnoZzoUfuNjro5mCkqTCEZ3kiHZsXc8dr7vz5jZEw3EDHKsedh0DwglL19Bj6WfgWf6gS8mLdkNGpx2Yn+YTcmBeJLJzatMBYraZRIsN8VBhJ1PlGdZZGRUQRNYEP8u7ZVCE5NsUpYPHJK54AULNajCBkRYJuI/LohOS/fDE8cYTDfQgP07JAWkABKPrZ7a4XoNQmHKFRadtGQNEjR3xjQRXuXB6wZKMvuEDtd021Q8rafI//8cZWBOIe44RfAU6Bk9ewzDuuu6tw40WarV9Bd8iEizLNcNKMJ06mOmGICKcJR5MIR9jEfYpTxIRm6ZFkF//gkOApsLgJHNZp8QKZnaq5cLP46zN/xavTklxWpH9IO60r+0Npp+sMykGd2rIdAXR88aYrpsC3eOvVop2PL7ADGdiIeEtQ/76okSRLOhIJC/bX3x9JE0a9mWhQAFJLZ/cUNj8Ky7q03FKJLBl0eiiuWydxNmjM4E9XTJRVZmmGGdg8olHybI4P4bwuvTfMT9Q4jsueQ3/VU95g0P+yiCTVWh2eAfCxqKl6GZRigiMDbEEy+x3O9Cl4xC49GyLXYTL0Po71/Ev1CVNi87n2C9vX7NqkYZU28h3jkY49zsiHuT6bNhGKR/EU56SxnV6blo6X+ZUMWcVNpI+6LCXT5fKE7csJREyLHKFBKDx+vSJWUT6UpMapGuZ/TX23sPHdNLSGuykHl/yceZufEYyMzFhVaxOpNXEyP8cD2Jcaw7WmTNkpXUnSzsN4HmRufkEQ6gjW2bXhQftc0w60S/eViJrdtuG7uD1x1Rmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(356005)(478600001)(103116003)(40480700001)(81166007)(921005)(966005)(36756003)(336012)(16526019)(426003)(5660300002)(40460700003)(6666004)(1076003)(83380400001)(26005)(186003)(2616005)(86362001)(36860700001)(47076005)(8936002)(41300700001)(2906002)(82740400003)(70206006)(110136005)(82310400005)(54906003)(8676002)(4326008)(70586007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 05:42:58.4878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f903e60-3ad5-406e-12b6-08dacea7e8b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Triple Modular Redundancy(TMR) Inject core provides functional fault
injection by changing selected MicroBlaze instructions, which provides the
possibility to verify that the TMR subsystem error detection and fault
recovery logic is working properly.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v7:
--> None.
Changes for v6:
--> None.
Changes for v5:
--> None.
Changes for v4:
--> None.
Changes for v3:
--> Added Krzysztof Reviewed by.
Changes for v2:
--> Added minimum and maximum values for xlnx,magic1 property as
suggested by Michal.
--> Fixed 80 char limit in description as suggested by Michal.

 .../bindings/misc/xlnx,tmr-inject.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
new file mode 100644
index 000000000000..1b6020e4ec27
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,tmr-inject.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Triple Modular Redundancy(TMR) Inject IP
+
+maintainers:
+  - Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+
+description: |
+  The Triple Modular Redundancy(TMR) Inject core provides functional fault
+  injection by changing selected MicroBlaze instructions, which provides the
+  possibility to verify that the TMR subsystem error detection and fault
+  recovery logic is working properly.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,tmr-inject-1.0
+
+  reg:
+    maxItems: 1
+
+  xlnx,magic:
+    minimum: 0
+    maximum: 255
+    description: |
+      Magic number, When configured it allows the controller to perform
+      recovery.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - xlnx,magic
+
+additionalProperties: false
+
+examples:
+  - |
+    fault-inject@44a30000 {
+        compatible = "xlnx,tmr-inject-1.0";
+        reg = <0x44a10000 0x10000>;
+        xlnx,magic = <0x46>;
+    };
-- 
2.25.1

