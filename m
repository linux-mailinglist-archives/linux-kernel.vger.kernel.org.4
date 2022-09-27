Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5195EC069
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiI0LEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiI0LEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:04:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588C7B5A4F;
        Tue, 27 Sep 2022 04:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF4i88mVV3XXO1dBKsXHt7XK2ne0zyojaFzpVGJDO5Vdu+99cXqRRDpNncCnPzqXQePR7bbmz/GUrtnShw9BnQeYCysdYa5pZT0DD1o3buxEov0OpTQIfBrdpyaTEqrfuQrngjCNNAumOALMx3wuNwFN0WIMTINcYm2V04w0CuB1nSW9LISkFhiqJan8QI/uH9WVXQ+rhYgKnf0zvOSfxfKwLPy+G3R65NxK+fYWexyJqVJ+k2MnY/kew6QHP3Xrrt0hNqxLnmkWJHeG/zxYOwZFK/mCffV3urxrnyWQ3fRyQt+32Q8Ezz1INsWEXXei1jrJOC57vO8ERzdNrkW8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/PUyqrjsPzbbo9gmRyx6c3ZbDlDcWnWo1dm1VyO4v0=;
 b=LYlwNW60gwtsi8PorHOXN1bSzqippai9SRXNllw4Px3/YZLrjUJTV6KC4oYZulN06SlUJYqtH2EtxrDvzXdNrBVKHlugJun3okGHlMAhMhnI+cwrSM1u31c0jCcrZhiiOQWGuZce2FadBBdfxZmsy6OOpnhYqGmb+H23MwNtPSJIqWcSxusWXKvzeb9NlDHakuGuuEU/lm51NYQL9WJ7zz/WE8nBkaq6UPQuul2JzM80axKyb6T1z0J48I4AX04QnvGVm1iIe6anoqLBF65x2R6jjf5SCY+nh8nbUHI/SQuWiaYeQC3MnYQ+uGsVttoTYF0IZD5TAdNZVXcIrfh6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/PUyqrjsPzbbo9gmRyx6c3ZbDlDcWnWo1dm1VyO4v0=;
 b=dZMwV1wLUxG/6MriNkMUXXBDkcXnVRRRe9dBMUfrvkXnL8Eo/vn5esfU7RakBH7rmrhfNhXebgrrLUh5OPLpnbwG14fqMRYP+OAj1RJGk2HpEDpTr0PapfbX609fQw1C+/+64kIY9pD/pB0JBF/FIQ3uE6xTkfc1y7fVDiY4un8=
Received: from BN0PR04CA0142.namprd04.prod.outlook.com (2603:10b6:408:ed::27)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 11:03:31 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::30) by BN0PR04CA0142.outlook.office365.com
 (2603:10b6:408:ed::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 11:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 11:03:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 06:03:29 -0500
Received: from xhdsneeli40u.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 27 Sep 2022 06:03:26 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <srinivas.neeli@amd.com>, <shubhrajyoti.datta@amd.com>,
        <michal.simek@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <git@amd.com>
Subject: [PATCH 1/3] dt-bindings: watchdog: xlnx,versal-wwdt: Add binding documentation for xilinx window watchdog device
Date:   Tue, 27 Sep 2022 16:32:55 +0530
Message-ID: <20220927110257.41963-2-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927110257.41963-1-srinivas.neeli@amd.com>
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0253b59e-ea48-46dd-5414-08daa077e98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALEuhheAwqDLQbYXtz01ThcE9x+KqIy5KkDHhnU6dLPRc5RHfwV9qCLlWgwcGlcOztIUSwK3zkpRLmybhg73yG+GPqbWPyIaMgd4kjbTU6LzHl5i2BUVPN+sx18/PY6la2RiTeCwmF2gtM9kmw8LnEDEeV0PSUtgfeWSZP4ytJ+M266/uD4V4vZndpqQjI5z2JUb8C0nVchOp8zU65VP+gItwcr6zaJS3AG5QK83EccMECy6rR6BZKDwFNdYzG89QZ62EkSQ2UNZ4MCUiUK45/SJISkUxUysxVVPWrUeYYPTu4Ceh5iZQClPs1++yozWZ3RbLxNaMsSoxpVUJNeOMoPhdkUeFZvC21UTYYP7EAvYJ2mUsHnpyw7IVr/UIq0IA45Do43jA/w6k5DHSUrXzVUpdraZ/pjpFAy6JFwXFuxrDL/oeuwvxlP3Wlf9ZDC3aFlUQBy5JQWPj5PvAxzgVQ/uWoh81W5IpHB518RDpst6WUyDQWOQaRVk+xRNhb9v6VrmbIbn6rpd59n+RjUWLkee4PeNTY1pGr+kSWHsL1pkqPOkVmX7QqWWittm5zsdtnXHLUXsy1ark5LSgm7vY0v9aBDcM+pWVICdxKbmvFVSK7DV8qkW1QhVeSCre/KGhSKzKSikZBJkZI0/U0LukWekeemwVaVEV98ShlCeARvg7FBIUW4uRTvspteOOxOoW88cEvhr+2JR7ChhOCBa5QODVDsKR89bEDquS+7vwca4tretcFHPYe4imdD+IH3M4SDX9k4g6WSmlb5l8FgMu7I0r20gZNs6u44ZRUDr/aNfS98xug9rMb63rB2a3U1ufuyePFBarRa13wI6ooQYYD7zZoaBxANqR8FuT4Liy0TbMVFOwGKzc3Jhr+1L/mhe
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(82310400005)(356005)(2906002)(86362001)(110136005)(54906003)(26005)(6666004)(316002)(81166007)(82740400003)(44832011)(36860700001)(5660300002)(336012)(2616005)(47076005)(83380400001)(186003)(1076003)(426003)(8676002)(41300700001)(40480700001)(478600001)(8936002)(40460700003)(70206006)(70586007)(4326008)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 11:03:30.5692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0253b59e-ea48-46dd-5414-08daa077e98e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the binding of window watchdog device.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 .../bindings/watchdog/xlnx,versal-wwdt.yaml   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
new file mode 100644
index 000000000000..986455efa6f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
@@ -0,0 +1,49 @@
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
+properties:
+  compatible:
+    enum:
+      - xlnx,versal-wwdt-1.0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  timeout-sec: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+        watchdog@fd4d0000 {
+           compatible = "xlnx,versal-wwdt-1.0";
+           reg = <0xfd4d0000 0x10000>;
+           clocks = <&clock25>;
+           timeout-sec = <30>;
+        };
+...
-- 
2.17.1

