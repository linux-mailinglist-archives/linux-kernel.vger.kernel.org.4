Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABED700832
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbjELMkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240668AbjELMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:39:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF0D1725;
        Fri, 12 May 2023 05:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDPwukwanD5sEvUh0ggxq8YyNgEm9fMxNZo508+PolLoh5+NJ+WzkfrD1G5lWTohiyTGIyJg1WuEBba+GnIPl8sxIrrH9gYWOF1rpTBfCYq2inQE8k9J3Cod0F1kwK8UAD3f7XgwrUgD0ZOvWCaPv7JnvSqmhQyYjVRxr1tdR3w4p4tN0+i4Sa0oTZymyKKaEA8CJXs6du9AlpB9Jc7MKT82NJmoKqAtMGL7Q9BBmXQ1GxgZac+Cvo1QORYXr0w/MOqyG1jw3UcTL3xDiPAfQJk/Me0JKo/S4hKn/tV90o4MD5hMujA3VI3j9yBnaKYyiyn0UCFD8m7yRF2fpKK4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bOkFOueQhws6bgr8+D1h1FUlH4+SGB9dPXTGMqxx/o=;
 b=QVtBrRh+KKjjez9Wq4uIIbq2x6x9xj9lsaYoJSY/kiUqmdZP+n9oPuRgJ3gQSAR546mZn5BoOFxbxMvqemE8+ZKUe4e5rWuNr2WE6XD7u2H4geCY/Ogz2muzBkDiqYy21bzYg1iuhVTSxAJf0VtBeOg/mCjXZ4tfjaK6Pf2EFCjGEHQsKehadKqoojniK5wA83GCEZodeasTCmHSmWqte14+t7pBROpNpFSTOGyMBp5ZQ0EjILQzD+QGhFBNRyKO/ICHNYX7hdqaE4ZRfOnsiN01L85xt/OoWfrQflpa/IbltA5ohnnIH9YMb35Z66ryK7pgRxwwEnzGaMwALxxh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bOkFOueQhws6bgr8+D1h1FUlH4+SGB9dPXTGMqxx/o=;
 b=5P+Xhb5lPUNiK+RQ/vrffka0oy7f92OLFFIXALhykwvdUkdrdSIGq7kvz9PBI7aWHVcJ+qRtYDnbE2kZPMgUIRCN4zP3FgxeqhAqBOP3R42rY7XayOsfUHeC0+ry5G5zIvtKF+MMi6V/71DQz0sY7x8tbniyEWT2k2+UVQ86+9M=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:42::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.24; Fri, 12 May 2023 12:39:45 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::76) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 12:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Fri, 12 May 2023 12:39:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 07:39:43 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>,
        <ilias.apalodimas@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v4] dt-bindings: usb: Add support for Microchip usb5744 hub controller
Date:   Fri, 12 May 2023 14:39:41 +0200
Message-ID: <067fb163bfe3162c596a6c69c96c43ac78288628.1683895176.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5151; i=michal.simek@amd.com; h=from:subject:message-id; bh=oP54wNAhibe13qT7W9wwha8npToM6aZN2KBnD5K2kNs=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQ4486uj/NtbhTr+F19riYT0ml/UMhllXbevrXv/3xaI O+v2mLREcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACaiMplhfuQMNa0dB24apvNe jzDiONj5/9cGY4b5TpY2R62u8BVsmn4mfvn0PU9ue9f0AgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: f333ee3a-e3c3-4c9e-248d-08db52e5f730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHNdUI0i8pNahghGl1Jo5RGsc4SnxeEdiyEcEHqTSfMyUH0JWuA6koVBdaK+Ssxf2HecxtC6D5wxsaHvPPC+8Rgq8oNKspzZPAmKk9ZlQJin69kQSXihT/mKADTdTL2OEqaeHEwF2myPnMk1RUJfCBMR+wipE9qpJAXqovgXUWbBKRYxt8XwLpiyB861M7YYQtuj14b67Qj89JTIiGa2uqOXe4oqv7Dvr57SCy56gTYVaB2KdZku8PyVPpe3O2quezP+cQmQ2Xnq99nJ81f6sdBC3OpM21lXyXCdoxTo777yOY3lmKfTwyxLhpMwHgC732fi+isWA0UujC6t0W9XWURalKtPNUyvQ+mF0OJ2rafubSe5vgxR7CU3JJ2PkYLFghAUwWr9/VX2f3ajv0hphVuhYclXUCWXOoOPig1TXskZdXAiURGIH8MeGeOiuB/wVRVBLCc+K4KiMFZvUxUTVvmzy06MVyoEdBYF3ndrBMNnhAQleWtqf/17+HKDm+c5pTiS0t8QpePrU2i5MVAUZ7Zo/gu2Am8ZlJ6O42tj/T192cXHBD8CpUWV3ozFdtWSSaHhoJ3SGmFL9UjpgGdeRe9vV5rsfEMCTLgikXsO/wsci0nux2o7uDM2k2Ou3EX0a/mWjY8aLoUaDBOLv0ybQCSfRj+TpG3AIkh5S969lqPgk7UKpjuDBZM3ayY6YftZ9CxeYDK5jWNsqmBZEDXgfIvS3RoPmwLQ/wiUArhb/Dt1V7W0LzZkA+5KglFEKtl2PoIyYi7ajAbRxDylDYVDY8zWVnBisFaL5mvillcL05M9/tgZTfa/xkI9uQsGB74p
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(36756003)(110136005)(54906003)(316002)(70586007)(70206006)(966005)(4326008)(478600001)(336012)(83380400001)(41300700001)(40480700001)(82310400005)(8676002)(5660300002)(8936002)(2906002)(44832011)(7416002)(356005)(82740400003)(81166007)(16526019)(186003)(2616005)(26005)(36860700001)(426003)(47076005)(66899021)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 12:39:45.0391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f333ee3a-e3c3-4c9e-248d-08db52e5f730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
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
Add description for USB related aspects of the USB5744 hub, it as
well cover the option of connecting the controller as an i2c slave.
When i2c interface is connected hub needs to be initialized first.
Hub itself has fixed i2c address 0x2D but hardcoding address is not good
idea because address can be shifted by i2c address translator in the
middle.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v4:
- Exchange allOf and required - requested by Krzysztof

Changes in v3:
- add maxItems to reg property
- remove select and define properties not used for i2c node and required
  for usb
- s/binding/support/ in subject
- reword descripion to remove binding word from commit message
- wire usb-device.yaml for usb hub properties

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
 .../bindings/usb/microchip,usb5744.yaml       | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
new file mode 100644
index 000000000000..ff3a1707ef57
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
@@ -0,0 +1,107 @@
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
+properties:
+  compatible:
+    enum:
+      - usb424,2744
+      - usb424,5744
+      - microchip,usb5744
+
+  reg:
+    maxItems: 1
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
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle of an usb hub connected via i2c bus.
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
+            const: microchip,usb5744
+    then:
+      properties:
+        reset-gpios: false
+        vdd-supply: false
+        peer-hub: false
+        i2c-bus: false
+    else:
+      $ref: /schemas/usb/usb-device.yaml
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

