Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA07A6F592A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjECNj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjECNj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:39:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230391A5;
        Wed,  3 May 2023 06:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiQimyOQ7Jj/kYWDiAOUfY4N5haI610ibHUMOAE99VHJ+WN59f+L4PqbBNwUDsCQRwbWoNCGuhD8Jdobw0IGOSb/qV27DCxtZDjPkpMFBPjf9K9kn/pTnr8+VIw9gt4/VbMsaZw4bXpbBPZk8XvoNDHtqgxBsL9tX0PthhwA7e7w7S3VJPS4+XEFX0uQF3ig0SFa2xW4eZ8RC2f5aitQM21G4eHpmpcSuWz+UZQOMvPgEgkXl1eGx/ssXubCqcsESxo0ZeqVBT+dLjOpHkCAKTwGkXLghC4aUlHkdvyBGJzHFI0D7+fZ1ab5hWBRCyb4DZ4AJdQpn4Fosf1wpfioTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJi/nihUqXN73rBq9I/9tBHfzaYbTxwJ4w4e/NAtMaA=;
 b=QMtFRmwvwaAvuJjqL4tL1NjfGn5IkqS57C8RpM+QeTGcSiYHHVEnyVqxcohR+cN4YD41k7db1YGYCkeY7d9FNSMcgxv6OclMYjPI+tj65z0MpeuXTIt1pPDRBXMGaqnrcK4b4YCsc8oC86/UllFj5XG6dvdndqy93AGcY/s46H5mKJ4EXH/CZDs8ecqVqF6cwx19b993wxNJu2eoJH92rpiRe9KZP2hlWP+qR6rgutu/WnAJEw5PpHlyja742w6v5rFXANPI6RpXC76kdBrleocM7tVSH7YNSlPiDdpjRXCfcTZ65kRz85Butsl0IjIWrJSijKnbhPXUJ18TjbtsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJi/nihUqXN73rBq9I/9tBHfzaYbTxwJ4w4e/NAtMaA=;
 b=ilLRTOCNCyM0Vv0oFYprj8W4RnSBh9t9I/jj1S1C66ZSu2kyXA1WXBuhbuqZWnx+MOHt3x8+WQetdMlrFWZtzmS5lxBwb/A+MvqOlgIjHfnQ7UMgZ1pWXyjFbP6CtQp7wd2AhEaTLd/JNpg+iEoCYp0RD59mNlVhm9FoKkNEpXM=
Received: from MW4PR03CA0324.namprd03.prod.outlook.com (2603:10b6:303:dd::29)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 13:39:21 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::a2) by MW4PR03CA0324.outlook.office365.com
 (2603:10b6:303:dd::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 13:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Wed, 3 May 2023 13:39:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 08:39:18 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>,
        <ilias.apalodimas@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH] dt-bindings: usb: Add binding for Microchip usb5744 hub controller
Date:   Wed, 3 May 2023 15:39:15 +0200
Message-ID: <cca068980ae0b902168a9a9b78cab4efb43157a8.1683121150.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0e8ccb-2f5d-4e44-7cee-08db4bdbccb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zYx9iWtCJ8FhbW4VuYcxJW+zQsIjkhmMyu14IaJhHUOsGejvu2sXby3eRdEhahUf6FrgsWLNK0c1xnGNLhY5RzL6bkdapajC3uIjJRY5t7k0kw/nJNBj0Xt9KE/shzwVgZ4me9ukOwU00HcrF6dop6P6uVeX0mTVenXMaJNjGPw0x9rEjFJWqynb9F4BvTQ+bu306fEUKcyXRffvEVihLXisF+zwj611bTbhzAJke4KcWv+mfnKKyupg6KGy16qqV98AQz2Kt0K5kcQEu6oYGcPePnBK/qPQukae6z92xL80BkvUJXVkWZQWgRZt+/2U91lytMnIxV98Q4jRVVqjnux0AGK/ZcXfJ2TOEOT4CRiHTbnq6SUnpG8CtsILWIzUqR289f3G4g3D9HDMlGQ/uH8R5baTwQt04MpQbi2fWYcb54LZWs91vLlFb5RnaJdVx+qaCEac1X5tO3cpQkDEW6tQp3erjXIWwsVfiHIf3OPBQ79QsiqLmgqxiigEq/jKzucVyNxsSRwTrQvLpcNKK6OA5Nfmrh5PM7eSzPRSM/yATwM228CJzQ1bDw/q7TjUC0x3EeCucT72oYfyiUwvXFdKsr9CFIpKFyZKsWCbgTiGeC4Ffng0287zSy7XHCXuHXnux+tH7KRt08aQh3YAvTVt+2mH5H96WK82M1ugyIsnql8d67r3nOyiQ1/QI92E+fMROaGCyEfHXKTrm6/VvYA2+0pjwAck6Teqx9zDC8fSfFT9AMKC22OmkJgH5barj29Obr8rLt2WWpOwKOp4FwwEv0jwKh6cl8hUBk4J48=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(66899021)(4326008)(70206006)(966005)(70586007)(6666004)(478600001)(316002)(110136005)(54906003)(36756003)(86362001)(47076005)(426003)(336012)(26005)(36860700001)(8676002)(8936002)(5660300002)(44832011)(41300700001)(82310400005)(40480700001)(2906002)(82740400003)(16526019)(186003)(81166007)(356005)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 13:39:20.5902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0e8ccb-2f5d-4e44-7cee-08db4bdbccb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip usb5744 is a SS/HS USB 3.0 hub controller with 4 ports.
The binding describes USB related aspects of the USB5744 hub, it as
well cover the option of connecting the controller as an i2c slave.
When i2c interface is connected hub needs to be initialized first.
Hub itself has fixed i2c address 0x2D but hardcoding address is not good
idea because address can be shifted by i2c address translator in the
middle.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

It looks like that usb8041 has also an optional i2c interface which is not
covered. But it is mentioned at commit 40e58a8a7ca6 ("dt-bindings: usb:
Add binding for TI USB8041 hub controller").

i2c-bus name property was suggested by Rob at
https://lore.kernel.org/all/CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com/
and
https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/

the question is if adding address like this is acceptable.
But it must be specified.

Driver will follow based on final dt-binding.

---
 .../bindings/usb/microchip,usb5744.yaml       | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
new file mode 100644
index 000000000000..fafe275a35df
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/microchip,usb5744.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip USB5744 4-port Hub Controller
+
+description:
+  Microchip's USB5744 SmartHubTM IC is a 4 port, SuperSpeed (SS)/Hi-Speed (HS),
+  low power, low pin count configurable and fully compliant with the USB 3.1
+  Gen 1 specification. The USB5744 also supports Full Speed (FS) and Low Speed
+  (LS) USB signaling, offering complete coverage of all defined USB operating
+  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.0
+  controller, so 5 Gbps SuperSpeed data transfers are not affected by slower
+  USB 2.0 traffic.
+
+maintainers:
+  - Piyush Mehta <piyush.mehta@amd.com>
+  - Michal Simek <michal.simek@amd.com>
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    enum:
+      - usb424,5744
+      - usb424,2744
+
+  reg: true
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO controlling the GRST# pin.
+
+  vdd-supply:
+    description:
+      VDD power supply to the hub
+
+  peer-hub:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the peer hub on the controller.
+
+  i2c-bus:
+    maxItems: 1
+    description:
+      phandle of an I2C controller to link usb-hub for usb attach and reset
+      followed by i2c address.
+
+required:
+  - compatible
+  - reg
+  - peer-hub
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+          compatible = "usb424,5744";
+          reg = <1>;
+          peer-hub = <&hub_3_0>;
+          i2c-bus = <&i2c 0x2d>;
+          reset-gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
+        };
+
+        /* 3.0 hub on port 2 */
+        hub_3_0: hub@2 {
+          compatible = "usb424,2744";
+          reg = <2>;
+          peer-hub = <&hub_2_0>;
+          i2c-bus = <&i2c 0x2d>;
+          reset-gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.36.1

