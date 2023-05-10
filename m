Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6486FE06E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbjEJOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbjEJOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:35:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A83A5B80;
        Wed, 10 May 2023 07:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAI5h7U15JoTBoc4ReMtf/iK4/Ol8gEIHz+Xb+t6lnsrf9rA+21xdnZNeKPK4v6+ekpEhJB29Yt0pfJ8IncJmidn6QWB+mV85ZCpPGrmH+Mz2Mz9mwnR11kwej8tPl+Bw9JnnyTn/e1lbXlr4q8lwfOHVJPzDeqWfbybsLd54medGN2H36c+9k6BoInGMuXWjiO8JaeXcx/ylycqYDbSAgTgYtzJUupd5wj1tHXL63tB3lY9xmb+M61+hkezLwFHPnyDNZeFAXITsAP11vUB0V4Zyz5hsFXBJgZej3LzvW33rW0oYedaKmqO/2JHd0D+UfxJBDDa5dMs8TXTDZaOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OVfepc+5S7aHUrIGHftKWMT2Uky3O/5eSweY4+8DJA=;
 b=jHm1FSxH3Qbi9avBeFP7W7llWEu1Ba31HuUt8n1631zPYIh70N4wmRLeu4F0rAYPp7aALxxNV3Mr2pp4PDS3LeClTTf8X5GsWo7ut8CiMo5pose35O7dqV2Rim9rO3kuFV8bmYWniVsPLS0dsf10EIrxb2vRk85VsuSLTCvI4F+dp/fTp1pqOcXkB3Z6mODcQP1dz5tzoNF2sKkAAz+BXMGyArzY2MDZM7Ap8eNSS/A6QJ5PrL10oGBA7qWjlyCyOwjOUXcpHvzR7f//2K7GM3WdIwhELv+8jipEvfKpDLfgmTNICHNhPzv6JwioTTHjqcyPbMbzGOpacvcEP18img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OVfepc+5S7aHUrIGHftKWMT2Uky3O/5eSweY4+8DJA=;
 b=wPzPB41uJaIOyFK4YGHzSA9BAEAzDqDBTpYf3LH0TgkGNI+FqliCg58wHnlRbpFGz2CRSnzqVdWJQNf6LPsQQiCDJ0g8gaghFOWlnA/QvzPaSndpswpUv5EZFVzpdqwixyrg0BRGgxubtS+103GV9MZjcPcw1eYRNU+DkrNrLxs=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 14:34:54 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::b6) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 14:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 14:34:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 09:34:52 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>,
        <ilias.apalodimas@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v3] dt-bindings: usb: Add support for Microchip usb5744 hub controller
Date:   Wed, 10 May 2023 16:34:49 +0200
Message-ID: <f99d284dc70ca897d3908b1e4c92a9910f350584.1683729282.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5010; i=michal.simek@amd.com; h=from:subject:message-id; bh=oH5jZqIfbvMnj/FFgc/ztd6+XY3RoMi4gK8JM8s3Wq4=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTo1c0bmddbPrTX35jzvayb4Xb7zUyDW2bP3989ULrfs 2/b71PeHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAit34wzNPhZ706qd44x/XT GYVYRzldf26Zewzz3Tr1lbgEjiueepyf4hl68tat/vVZAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: bae35c44-c097-4e62-cc59-08db5163b85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxZxaGReU2VBcMU6LN2qDCbSd6mQ6Xp7o18PAeZZkwFKYlEr4mA66sXcaEqmfUcugl5TPHYAlP+nnYMKD9UpCM4Lansy78Ub7kKeeuawmr51585UdLzLvwgx3ZfbmUJzM0PJHidkov8oihup2/aU5sj7yI5ea6GNZVI8fq5RDA7eARFFxjr6Vf8d0QcBjYu8ESndkDz91bIpLWqk/ZQYtd3wL+PbP2Sq/yK3nmwBv3InCQcl5qnj+JmUPpU7LweFXTzsMsMQRFFCkq0spAsWVnS9PDeQoBr1lDOzi/duO05rLe/W/FsrsvmebyEQjYSLAsg9fWS7nns5IdzEzAa0rTdTKlQhIMK9UqmU7KSd/7FWqKXXxpT5k+aNip/O7RlLAT+t8lRnNVGQR5rpk87FNkxMhtoqPne9A/p8Hj3b1MOeT93El7A3apBaWQFfTcYyFRL9DPpMBeevuGtDaY38+B6iIWf/QtzcUv6qJcHflt9tXx5EjMAP6ZA/yXh7s6DvuBfmS90AvGdTV8/AFIgAz/apnUA6QHzBNzMacB983OYQRJxCQRyhGGbac7NBjYe1NqLWH4N1bXmWrT4iGLdUVkx0pdz5zhJkWTfFMgsZYOHbZFodyjHJz5kpqhmSDf7Hx+2PsRCy1GJbRBPTAWMsgAxt3c/Rr8h9RDvsvMeOhQgmOJNwrI1oBcliy+CFCOPsplBPEKgxAqm8HuBaAGH+ERzEbq20Q4ULnp6y2RzG4vUgrHyyj2fEKuwpkLNKDcp/rY66FRI3oZ+MFADG4bRxo2WayxgxcQatLObfArexXe87sYgyxUIgFbwM7Wa1Q1tP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(70586007)(82310400005)(4326008)(70206006)(66899021)(316002)(36756003)(54906003)(110136005)(86362001)(26005)(40460700003)(186003)(16526019)(40480700001)(5660300002)(8676002)(2616005)(8936002)(2906002)(47076005)(83380400001)(44832011)(426003)(336012)(36860700001)(356005)(81166007)(41300700001)(82740400003)(6666004)(478600001)(966005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:34:53.9511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae35c44-c097-4e62-cc59-08db5163b85d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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
---

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
index 000000000000..408c5bf00cc2
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
+required:
+  - compatible
+  - reg
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

