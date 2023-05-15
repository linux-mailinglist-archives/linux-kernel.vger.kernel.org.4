Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D91703C59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245195AbjEOSTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbjEOSSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:18:15 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34AE6192;
        Mon, 15 May 2023 11:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9PaIlkblwBIdW27a/EDzSGUw7lYxzCmvNBCYSWhtnuadUENSQQeirZfHNntYkxlcw+k3qSD9V20/LhcQ8ClJ8oKq4EKj3g63sRfcRyj/of//O2R6TgZUXnyr5F8TKyyPchWSw5l0syDck0nHgv+4fES74EHs4k0TedllOAUW8Hj/MfZwXG+wV/9OujDnKw9dRxmybEqL2H2BmCJRxL/B3ORqYxI/GbiSzeb6Ag88+7EuXIL1n14PRNo/Fas4WPARTC0CP8EmRokBiURspCDLydoOSRt/vHV1GQwRsgNZVwBjggqS2WftYRGDYQpxFffi6EiXFCg8P69Ky/6O5KsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIULXGIP/9zE9qKKh15P7DwPq8RDJ2/MG8LkZS1UI14=;
 b=C7z4aBsJQ/JUB80xjh5pYoIDykULEyimufkW7U2gDzD4chjUQSuN0lKUwzEC7fKK0OwPBHKeJ/9dEx5OELs09lckU9Gphbxyvp0KQwgIOvNCnrVkcPvEJvGkAPSnZGo9LF6uPyeNOkcQ2Sqjb1soknOuNkFcRILbj1yzd5JbXW/tlQPOvbRk+BS0RgX45h/G7YvId8urWOo4oeT8Gx0f6/J5EmMhWdq+UwLhxSCGvO9uvSkDg1hVn4Jvd1VyBYhh5aNLcTT5UrSzyNLTZY8zOTEjCFlak4u61eGjb3yHRasNABRWHnQYZCmaAWj6ZiYNYGTcV8hckkoshUCkClVC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=bestguesspass action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIULXGIP/9zE9qKKh15P7DwPq8RDJ2/MG8LkZS1UI14=;
 b=qrD0LIf7WpvYUsxklMIb1Kr6IMl+rKQdxKUs9CVhJZnTEvguLjSQ9v38SpUHdS10wAqgDCvbqWaI9r4QUHqxrRYszM+5RAIOZ5ZuIJkRhYL0S2Xb3YGrZzhhMGZLyqbEo94O+3DqOKXo6C0Zy3Uy3T7uDBkVmNV+B3p0r9tWU/8=
Received: from MW4PR03CA0029.namprd03.prod.outlook.com (2603:10b6:303:8f::34)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:17:01 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::dc) by MW4PR03CA0029.outlook.office365.com
 (2603:10b6:303:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 18:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 18:17:00 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 15 May 2023 13:16:55 -0500
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
Subject: [PATCH v14 3/8] dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC Controller
Date:   Mon, 15 May 2023 11:16:01 -0700
Message-ID: <20230515181606.65953-4-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 7137c1bb-4e8a-42e8-c313-08db55709385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e81CYaKJQW8SvGKyKnXh0mJBjgnfJq1T1Xxr+fCnV1RjRR3njUzOTaE0I+RwLNmQltAWrFpI8YnpJEehU5ORxE8uEKGxokydOHJamCgOcsIlXXK/k/Y5K/JfUTpucl+nBElDY9LggYzWri6IBPey49A01HESC58ZiGqrWJHdrocWBUnPHIJqRIFRZMSIDb6UlUJSTBbtfcp//M4v2r1H5ru3+ntzzhOc7oRThdhig9XDNo2XIv9kHfBVHupE9bVaij71imP8Kt4lz4Zjn49QRfX53slx/oSUDGTS26CQf8VGuiSRTrhMv7wsndmGIXqwgB04pPWkfO2TqOm4LTPZO49DJKI0dqt701VINe/ec8U9IiZOJYgM7a5BI+W9VZQPufVustM6b1OBVzMsm4jPLA4TgSqNszTKDcQjZlTSDJik45ldItvIcW4Dpl3ewM34fVRnaCqVry+xmgdjFtgFwdyPrN4YpQ7M+0N8GI6Xa/1DAcSwICjkhZMeKXexkrOLGt3iH9By3ATOQgWbCp8Aj5hSARX5n0NSvCwkUL22Qd84ZkO/BAKL15U/csRCV9tNr7iNzkKXpo4/Xai+rqTteArp67f3oB0688bA9wQlPq/zir/2n4Kodv59/VoezOvUl6wzN6XzZTe3/c9Iz2KgDC1OUbU9or5EmlMTBCl/USWNqx/4Hd8sC5skXY7vAnWJsDTTSzZAWvknboJmZW8aVCLbKOG/c7yLv7aYrniCZngWwNIOAjOp06U9u3bbvJ2hz8wxKqHphNFAkzA/aoWy7dvUcaaM4Nj9FszwN+J6YBU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(36756003)(54906003)(316002)(4326008)(6916009)(70206006)(70586007)(966005)(478600001)(426003)(81166007)(82310400005)(40480700001)(5660300002)(8676002)(8936002)(6666004)(2906002)(7406005)(7416002)(356005)(82740400003)(41300700001)(16526019)(2616005)(1076003)(186003)(26005)(36860700001)(83380400001)(336012)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:17:00.1366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7137c1bb-4e8a-42e8-c313-08db55709385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the AMD Pensando Elba SoC Controller which is a SPI connected
device providing a miscellaneous set of essential board control/status
registers.  This device is present in all Pensando SoC based designs.

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v14 changes:
- Change GPL-2.0-only or BSD-2-Clause to GPL-2.0-only OR BSD-2-Clause

v11 changes:
- Fixed the compatible which should have stayed as 'amd,pensando-elba-ctrl',
  the commit message, and the filename
- Reference spi-peripheral-props
- Delete spi-max-frequency
- Remove num-cs from example

v10 changes:
- Property renamed to amd,pensando-ctrl
- Driver is renamed and moved to soc/drivers/amd affecting binding
- Delete cs property, driver handles device node creation from parent num-cs
  fixing schema reg error in a different way

v9 changes:
- Instead of four nodes, one per chip-select, a single
  node is used with reset-cells in the parent.
- No MFD API is used anymore in the driver so it made
  sense to move this to drivers/spi.
- This driver is common for all Pensando SoC based designs
  so changed the name to pensando-sr.c to not make it Elba
  SoC specific.
- Added property cs for the chip-select number which is used
  by the driver to create /dev/pensr0.<cs>

---
 .../soc/amd/amd,pensando-elba-ctrl.yaml       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml
new file mode 100644
index 000000000000..e96978ad1e37
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/amd/amd,pensando-elba-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Controller
+
+description:
+  The AMD Pensando Elba SoC Controller is a SPI connected device with essential
+  control/status registers accessed on chip select 0.  This device is present
+  in all Pensando SoC based designs.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    enum:
+      - amd,pensando-elba-ctrl
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#reset-cells'
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        system-controller@0 {
+            compatible = "amd,pensando-elba-ctrl";
+            reg = <0>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            #reset-cells = <1>;
+        };
+    };
+
+...
-- 
2.17.1

