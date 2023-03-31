Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C591B6D18CE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCaHmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCaHmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:42:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF9F11176;
        Fri, 31 Mar 2023 00:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV0qa4GOXqau1BDZHF2kkICwNGfNfKnoIIe6AwF4yZIjAsNmtEJEJ2aELv0vFoToD9RLj6Ru+kylRxGEOEuIgthrh9ax3zQhOoxZD2eSeSdI1V6YJ4beVK27tJuiLZj37CB1fl7SJQr0BA5osQNftdE+iIHHW+pGZHZq4kxIVzA60IcjNv8UL937VNNo1Xa8nRzir4t5VvUAgNNbH9yG3r9f/DU7BlHeSHy1R+cpyfhfLErgiF/04vDZsRLJOq+iRphwft8UwcAjjH8mYE80J/BzkspBn37ZKOT7/3WAfa7yPvdUjgwWS3VQmtaRt3+nqCdv38FKAURWV00BSs3T3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27BS5q/Rq5iIoVGjzHqpdt/WYf8x9MJNDwwz5v7W0Pk=;
 b=a+l//hBmKAxXCGg7Q9qBJvtyseudwpg6aZ6AHfQINL8EpJmS4F8VDJMHRzXJS1L6pGWy6y64m76RGanrt9ufD79srSn6HG2M8jYs7p0pTtwckqkrIHi1IHKYM/bDrKT0jkMkyD1IXeZCEQ5TccldhAkIKULi6f23deEuEbxlxb5ms+I6CT9OSYWH9QCFDxeJgsYZDuO8EV9l5QVOxvr7Kt6ndz01/6zAr2r4deMZ/7IuhAv3B6pJVzE8g8gzzWm1p2Tm/GhcQS7hyPOJEwmNGQF+MQOxcNeC6kkLZfwqSz4sm5TQ1FBzZ6oeVNZmTg++XnGNBGTeG4/khpSV4KcLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27BS5q/Rq5iIoVGjzHqpdt/WYf8x9MJNDwwz5v7W0Pk=;
 b=aYhigJr23vzOrKaikC7VRr+BSIC2+aZm+tlFAoaNIcCwSPZ7PU8/ZhPKwSnSOD698B+Hremfj1GDRfU0bsmg+eHUK6rGQZyj1nYEqfmyM/E0qsOBA+s1koyz5XbuKWb88ajN1rVQIbIcyNlldWIyxNIBDXDAPEM2mB8fzS9QM8s=
Received: from BN9PR03CA0654.namprd03.prod.outlook.com (2603:10b6:408:13b::29)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 07:41:52 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::f1) by BN9PR03CA0654.outlook.office365.com
 (2603:10b6:408:13b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 07:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 07:41:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 02:41:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 02:41:30 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 31 Mar 2023 02:41:26 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <srinivas.neeli@amd.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>, <neelisrinivas18@gmail.com>
Subject: [PATCH V3 2/4] dt-bindings: watchdog: xlnx,versal-wwdt: Add versal watchdog bindings
Date:   Fri, 31 Mar 2023 13:11:15 +0530
Message-ID: <20230331074117.356339-3-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331074117.356339-1-srinivas.neeli@amd.com>
References: <20230331074117.356339-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4ed929-2bb1-4487-6580-08db31bb6484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: URhFkFHmnvzrboJ3Sigpn5xfxsZxiJNXjvoYRlkzfpkNS+lUGmj+krRGtNH+MQ1lEilhbj9/HvPLWvj4ZGI+hbOpYECYQ1ehHNI5Wx8D0xRXK72LBI9jrn4zOPnEtoCmSEtBC7YgfZZapwYZ/sg2FQoIN2C9islyiR8filmmC8TyqycTKDIksKcjZFvLQfZMuMrWcCDbc09+7i4z+//45aLgHZ5wuP9r1ua18Fhj22dzhSVIie/eoSbpybZkNzMR/nP8kVFnrOHm5tpNRQoInedOEvuHHoHVbU35XRz+XWyVyE4zAIV9T5TNLeeYKlV8d5QpCBumrDWoUtsql+XSNuXlRYDYyEWfY2hrb+0GStTmWitZ0e07iSO6jcQjEmamHZkQ6vfLooVvtIvv8H3LyYF97WAinwzMZe5GhI4sWANdHdpV/TYAsx/cqoxpA/ktJIYUQbet0cpEEO6G4mfdj01E2wOBHSZimYp53R1DTEAPF2XX2mafRdA6dfPvJPuCWEa5WHZeFNJ8K962A443VF9px6GXM5Ge3P9KC9SGdGqg+ru/AyjZoZIEn13cK1bhJL9qy2bxcDHxFfPntSEpCWpnsHYvSsQooQupKfLeA0GZjPgjitj+CvEuKvdEQeXQwIyyzpIfArXrq2Wj5ZQPKYldu/saxhKYoedYU3+baEwY0nmdqjVFtdMVIcgklQK7MoR/jZNyHe8/CHWCmsP9qBhOGAbIt+GbJu1uBabF4AAkLGdJdFU+QD3IAJKNyztjnNr+Cq8gXk/bKicRNZiJkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(40460700003)(966005)(8676002)(356005)(70586007)(41300700001)(81166007)(36860700001)(70206006)(2906002)(36756003)(4326008)(86362001)(5660300002)(478600001)(44832011)(8936002)(40480700001)(82310400005)(110136005)(1076003)(26005)(6666004)(54906003)(186003)(316002)(83380400001)(2616005)(47076005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:41:51.7788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4ed929-2bb1-4487-6580-08db31bb6484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Versal watchdog driver uses window watchdog mode. Window watchdog
timer(WWDT) contains closed(first) and open(second) window with
32 bit width. Write to the watchdog timer within predefined window
periods of time. This means a period that is not too soon and
a period that is not too late.

This patch adds devicetree bindings for versal window watchdog device.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
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
index 000000000000..dea1e7c487d3
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
+  Versal watchdog driver uses window watchdog mode. Window watchdog
+  timer(WWDT) contains closed(first) and open(second) window with
+  32 bit width. Write to the watchdog timer within predefined window
+  periods of time. This means a period that is not too soon and a
+  period that is not too late. The WWDT has to be restarted within
+  the open window time. If software tries to restart WWDT outside of
+  the open window time period, it generates a reset.
+
+allOf:
+  - $ref: /schemas/watchdog/watchdog.yaml#
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

