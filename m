Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A430A6F83F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjEENZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjEENZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:25:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3168F20752;
        Fri,  5 May 2023 06:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLpOvZIZamY83XeEnZb1SnZE7xYXq5uDvMvX38oPLdCjcCi5LKlMhUYTgbCAkAgAtqzYNHxm2cvvQlT4GV6ycvXOfqyVw0rU7bAH6347QdvTf2g+DVntFx6a6tZbp5NxEy9Hfw8uI2IcNChRIY2LhObcttYWm9FbZn4F83XD5Jh/ECKw950xtK/Yi2c9lQ7VsGnUQUenO7zgWRcuwf/jdWg5qhYN45SQ2Brvb8tznKFHvgQMzrYHZGwYzkEXinABymE+ewtq3CADx824w6V1/13YfCVAjJPsC9zSsu4RUDnI0XL5gKiQ5LdouqCWuEOoz8Kb9cN82FwK/7zEnUQddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixQee8tBH5dKHYObYo7rmfWZGP7FyNkve0MkVk8T8WM=;
 b=kBQxAam4VAU5LnMhFMq1tMy08aIMiDorHfBqi1xexc0GwMhpcr5iWFwGdlg//JYjeu1qGXnXhJrnboHnifw5Kn7fMoT+j5St6FbYKFzcHMOLQoDRj6RAxAlNZjnsIA4uUjZc8yUQ/ya8/TvnhhEwSf2MgnihK8Kv+UFXaGwOhP2ZoVUdpvZ48KGPFJa8sUF8wDVCz6DFuOG2hvn5J3AHjFl8nAg+l4LU1+kYlkYEh2PHr5s1B2DOihHyZBC1R+O8rCBzwmDjZXx+E3pQyDDYIrs7N2rV28OaLEYq8GbNF/6l549DjlE3CNwxU1QvJVg0/NzoQW4Sl5EjcvIvd5MD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixQee8tBH5dKHYObYo7rmfWZGP7FyNkve0MkVk8T8WM=;
 b=WgrPrCFyR247fD9561zXv2jPPDTsj7ReS8DYnKmuDGkKakh88etqS1acWet37fhUn4DQMD9zYqC9g6rsVBCLOqYKbknclAypeACP73xTGPPnsN2qwX2oRo5pFpYe+FC9qwjghBIZvfJdDZjPJTgJYHheqq2SLMpa84Itbl214BM=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 13:25:38 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::c2) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 13:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 13:25:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 08:25:34 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>,
        <ilias.apalodimas@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: usb: Add binding for Microchip usb5744 hub controller
Date:   Fri, 5 May 2023 15:25:31 +0200
Message-ID: <dd31f987316fb2739644628b5840a6d447b5a587.1683293125.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e15340-745e-43df-db15-08db4d6c3722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhJm/JzB/AcmiatXfyMZQb/EiUgoVc+fUGkpa/dGLYqIGLZlZVkyU1OwniF+U3jZBWnjoZU52+ED3pqvEynB1CvzyCRFJgDm4UVY0imbR5hsmT6yOFNF1OdDvhCsS8Pp3TjL67iaZtFwoIQWIcx6OQUmM89sq4/I9AP5AqxiZ/lOkChWHi51Mz82Tct+J30JQAzJmr4iro6ImcEsK7K4XoFdslrldjWvlZPchP9tIyUVFzd7iN5vAPMqBc1fOvaxIQkeu6dgHFphJcvih2qVKt6flicJj7xiXtUNvvXckc0C37KNGMg/+kKOTpSYz4sY4MBzOqWR7bYtSGt9R4tQz6Yc/c1e031mRFTWkcA2d2qgyMa6k2iuvwdDCTNP5yDz4AUFoI3cpsYnMZk4r8e2nhb4Q7oqnTVT2w21vtCMBsb27wirO7tDAKU27ei2yw/dyFVgVjJDXqqGHaFy/uLU+dl9bVBll9Oj3DPEjy+gsAuRRRB2OhpcytczLpS8bUbHlf54YNQZIEpBN2iGv9f7f2T1jTSwXH9BRDPuZGn6S1/R74PhLzG22U2yMmQzLpqX3D9bGHIzicZ83EjY6Km3yh3De/3WBTFgAEJRjFY8nsmApS2xw0AbMNnXHSLH0MX+u9qyNI4aFFkWTIveh+ln/frbF2vKeIaUvdEtkucc2FBtUfbEN7ejIwBHpKFynvmkidQpnav+zPibg8yTJk7L++EmzrRWcBceTGIczQL7MJR0vvyeVgW+yjyuVHilWvUTkgM0RWv5colZMYfCCIEt/CXKmO+lS9yzL5HE76AB2eQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(66899021)(8676002)(966005)(426003)(2616005)(336012)(26005)(36756003)(40480700001)(356005)(8936002)(47076005)(44832011)(82310400005)(4326008)(5660300002)(186003)(6666004)(70586007)(41300700001)(70206006)(478600001)(86362001)(82740400003)(316002)(54906003)(110136005)(36860700001)(16526019)(2906002)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 13:25:37.8332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e15340-745e-43df-db15-08db4d6c3722
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Changes in v2:
- fix i2c-bus property
- swap usb2.0/3.0 compatible strings
- fix indentation in example (4 spaces)
- add new i2c node with microchip,usb5744 compatible property

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

$ref: usb-device.yaml# should be also added but have no idea how to wire it
up to be applied only on usb node not i2c one.

---
 .../bindings/usb/microchip,usb5744.yaml       | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
new file mode 100644
index 000000000000..7e0a3472ea95
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
@@ -0,0 +1,110 @@
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
+select:
+  properties:
+    compatible:
+      contains:
+        const: microchip,usb5744
+  required:
+    - compatible
+
+properties:
+  compatible:
+    enum:
+      - usb424,2744
+      - usb424,5744
+      - microchip,usb5744
+
+  reg: true
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - usb424,2744
+              - usb424,5744
+    then:
+      properties:
+        reset-gpios:
+          maxItems: 1
+          description:
+            GPIO controlling the GRST# pin.
+
+        vdd-supply:
+          description:
+            VDD power supply to the hub
+
+        peer-hub:
+          $ref: /schemas/types.yaml#/definitions/phandle
+          description:
+            phandle to the peer hub on the controller.
+
+        i2c-bus:
+          $ref: /schemas/types.yaml#/definitions/phandle
+          description:
+            phandle of an usb hub connected via i2c bus.
+
+      required:
+        - peer-hub
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c: i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        hub: usb-hub@2d {
+            compatible = "microchip,usb5744";
+            reg = <0x2d>;
+        };
+    };
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+            compatible = "usb424,2744";
+            reg = <1>;
+            peer-hub = <&hub_3_0>;
+            i2c-bus = <&hub>;
+            reset-gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
+        };
+
+        /* 3.0 hub on port 2 */
+        hub_3_0: hub@2 {
+            compatible = "usb424,5744";
+            reg = <2>;
+            peer-hub = <&hub_2_0>;
+            i2c-bus = <&hub>;
+            reset-gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.36.1

