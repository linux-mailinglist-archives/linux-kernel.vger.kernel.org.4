Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9713C6CB639
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjC1Fnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjC1Fnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:43:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A491AB;
        Mon, 27 Mar 2023 22:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epVKTDMUzG4Sc1X9nCXgTiKHNpLb6BK2Z6LDx3SaX1yFYVLVx6Bw3Dna1ASBWXFS3QS0X3XQ4ZTdKKKg2EyDY4+Xh7UBZvFs3SBmMERyCK7XSkmtHQYe/WPYXwmKkK45TidNZkT6goCkv3zWsvwUtAJt3I86nDzX9nhBQSQHnQvIY2p12znMhrdR2VwsIoyBhsiXxqJM7CGg5rleDP5qexRB9tyfI7/Ap5GdTTz87RJQ9Bz5TAvBFUiS5w1KB7wC2Cbts0K924WscYX/XVzzg4xyAP50FmdmftwlMyCQtNv5ROmr0byl819ij9T2c4o30QwnGm3Ye4P8WJI9l9nwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43JtJWEGZin2m40R8CskKZFH4kwdiG4MtXej0d9ZAos=;
 b=Vx5xenUde+LlOchkkdjaOHsLGcULvvSB63FDqg49puHnEz35ZBli0HwK/aRUYEJ8vZn7ljfdYC84MY7OYDefrySuCHY7ePnyocsNNm+5Q1J7IkjTu4NC7NFpChqe39jWb8Jjendcy3kEHxkqiCicyRT63AEVCqqPNzeZz6iLouzqpO209/lpMlsRtJkaXU91JqkGQlVtokh+64fnkc7Da7CaLVA0V0NOgWToYDQwQItL42Oio6EtKJ2JbFKy91HtP97+kH1JMKOifRTQeTPUX3uKkbEfPBVZt+DUSgC+9fu9YtbDbivCSCbovFbAl3gCrncxhdiJ+3k7yCwQyZDa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43JtJWEGZin2m40R8CskKZFH4kwdiG4MtXej0d9ZAos=;
 b=V1kvKhjKk8XHhqf60ucmjnpHXRJzeSj/D/aIMUI2rkax9TykEeSiVANJg1ilYD/hxnyrPYYWZg3sUzJxrlG5Z05AxuHGguF122uIilWh/rJvaSxPK836AmXG3JaEJz1MalxSKC6rKfwy2ZR1z0fRD45jj97fAwIJ1iwYInIkicE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8129.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 05:43:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 05:43:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: input: pwm-beeper: convert to dt schema
Date:   Tue, 28 Mar 2023 13:48:33 +0800
Message-Id: <20230328054833.1974942-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eaae7f6-652a-4df8-ae8d-08db2f4f5ab9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxLJEGcE/dOKfh3TjRD2JK/9NzgSedY2mA++fsA70TVW8uvitJ7c3qidPBa01v6N+uqD/w5JTSA6zod8bcrcuEOG063ts4F4GNhJhK3+hLy6ul0hKJbxQilYO6kLmLVm9/hJNoLhafDeaKOfaiaFDmoKi08VqmkbG5QxVk3SPsVzHN71udF5EOhQMjVm5UOvmqum00/pmTibIMC9PrtDJSDCnjV2nZBzpoZnZuznhBv4Ff68ZIpfM7wQEF+9lh3LXAPcvsmQ9Xr2J5vaA7SndW7Gph3xXIBTKbUh9H4jAzEZNl5kdIpGGd8kO5z/1qpEXDXNx4uMxK24m2uJHJ/eIXyBygGB2eX+Z8FnK2GD3T6XhZce2P2DwsK/m4v0ZEUcw3mrMtQVa/jH5P9YNry59kyXHTS6IJrZG8KOwq3pN9MMJom7QNlEwBSo4qv2hb6Nh07O2K5y25fgIHUELsHo+vKXMP5wlM98jNQSQbFC0TA2fGSg8Eep96B6J7ljUl2sQuvrCm/iJ11xME7+VQ5fL0Q0aP2MznPHkVxUOneyRcBGd0M+TO6WxmUUcYV4tpAulJehACsiyP+8WbPa4ZGCd7umgRmcSWHLl07U/7iEzsJ5k+IjA24fqg53rygHJ63SE9nutzxughfWS0xPXzWh5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(8936002)(2906002)(52116002)(38100700002)(478600001)(38350700002)(86362001)(6666004)(6486002)(966005)(316002)(5660300002)(8676002)(4326008)(41300700001)(66556008)(66476007)(66946007)(186003)(26005)(1076003)(6506007)(6512007)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHHNGA6Q4fILbwEOLcdXBxFEZ1p/Nz/IRxIbioZTHrdVI9y2+cFOX6soWdtV?=
 =?us-ascii?Q?Ust/6BpCFqAXwt3lwmBurOJu+c1rz7YcwVmqtvU/LH2bd6ao96eywxBXAJtA?=
 =?us-ascii?Q?8gbebJW6fOp+skr5zYe9aXdGVXx8l81unJmf5kgd8mnYMisu9fXxSdW9zI7H?=
 =?us-ascii?Q?QXy/yuSA/XPzE23mMKd7ArEz1VonOOBQLd4dTkE/Ynh/oXS00QohtuJOc4bG?=
 =?us-ascii?Q?2MXwx5tVjYGGzsgBmYlx026q9ey4ZT+1ZUDSUThOv1KbTgE5EurcupRdRKPD?=
 =?us-ascii?Q?MAg390mARyOa01GN6t/u/nbKrEX0MwdcrQTokeBJDb8w9hnzuA1UKDioZ9DF?=
 =?us-ascii?Q?qM0gLkD47O4z366CNlcTcgvy7Gj0WOAMp0nJjYp0ukvJSQlUmlhzDerjraIi?=
 =?us-ascii?Q?6X6FqIZZy/wzyp8Lk4gdd5nrJAi2TFubtQiJjIJ7AHo/dHrU8JJYLc/5iK9Y?=
 =?us-ascii?Q?oel648Jxs6XHmHTW10n0nmA06ZHk+J1XsdydEFRxw17wAW1fFXPrqHg3RZeL?=
 =?us-ascii?Q?RxCWfWHwJa23J/jshDrZuJt5nAriE46T/4cJax5UMf1FOMtKVdSUVbQkU9tU?=
 =?us-ascii?Q?s7p4M3K88Ajai51j/JgHb1l4SOYS/cOcWPmTz5SiqXlnH1n0nZX991hh51yz?=
 =?us-ascii?Q?1n6w0xBlO1girFXaXAXSapZDBZJcijD4VzVOK7BPC9TVSyb3XnB8PpSsGrHr?=
 =?us-ascii?Q?okdZmMZZOYqZ0E2iBLuE/YEcwz6AHq5oEIRYqUvJMiVbVSCDZsOzlAThig/9?=
 =?us-ascii?Q?5OwvuYeln/ooomG/DdZ/lOsr8992oq8Ogda13CKm1gays5/ND1w7S4cFbDhf?=
 =?us-ascii?Q?Czo+I/8tU9+UvY2kKO892I795Xfu2MvDvJd/g4Kz1ZOZIjr4O7W6d2+JijQ0?=
 =?us-ascii?Q?Wu9GM2uUkRYsKhWsQNIAznKeBATMLXNj15KglgRB2km0XbL8GwzR1GICZYpa?=
 =?us-ascii?Q?lfXRKwKgvvHr8OpOOxuy8k0ePShramogG5zb48iaP8yvl2yrqwhCMz/O14ur?=
 =?us-ascii?Q?7KkR29ozZOPgbqRRCVW6iHjflDSl3VT0mFSWYXl4SOTy5vYYE7uVq2BDw2fR?=
 =?us-ascii?Q?akshB0jbQYny6f/iRvZvWCB8i65M394Jw2HpE/5s5eg5s3URy+96N3KKjBlh?=
 =?us-ascii?Q?c8uIeMZS+dfiiKgdDYs5px8s0WC/JUZaUxd8TziwRh9YBIM7GZqHFqgZ5EVd?=
 =?us-ascii?Q?cwy2Z/o5i8n8i04xJTcjPr6Gwyu+rV5pM5FpNxoGGpYH1RxAB9D8iQk08d/I?=
 =?us-ascii?Q?7dAP0etpGV42oT2Cu34rme8O0Uc10InYkInGAhhR9F4AtCx10AQM935gDEgk?=
 =?us-ascii?Q?+IRN7Wch86LoQKicHrJ90LaBJUsJOtIJHzLtgvts147gZMzuolcZM0cShvd+?=
 =?us-ascii?Q?pJirfXxye2q/3Uv7UG7ZakibF8v1VWpHHFmzh/UCVC/yQeNnzF7ddDL+HQmu?=
 =?us-ascii?Q?IPVbFCjHq7vOTpsOJAZlPGiTw3u4kboRsdQzjHjh3LBwp/C3OWrnKc/CMUEq?=
 =?us-ascii?Q?YNmL7vIptJk0ujUo1LyaeerOqpvunFZ5Pb9bCRyHF36ULx2Fnv5TG8Xx+yhM?=
 =?us-ascii?Q?DZt4X4uPKgJ5YYmTt8DYujjFWYDNIJcfw4TahQbC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaae7f6-652a-4df8-ae8d-08db2f4f5ab9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 05:43:27.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujhXWbGBIyg+l5BoTXmrFaei2nC/DBpa89DngBw3Gd+5dtDVwFFs2a5GHhciAkAkQRQCnJPDZjXEmeGnDBE2Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8129
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert the binding doc to dt schema, and also fixed the
example from fixed-regulator to regulator-fixed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/input/pwm-beeper.txt  | 24 ----------
 .../devicetree/bindings/input/pwm-beeper.yaml | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
 create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
deleted file mode 100644
index 8fc0e48c20db..000000000000
--- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* PWM beeper device tree bindings
-
-Registers a PWM device as beeper.
-
-Required properties:
-- compatible: should be "pwm-beeper"
-- pwms: phandle to the physical PWM device
-
-Optional properties:
-- amp-supply: phandle to a regulator that acts as an amplifier for the beeper
-- beeper-hz:  bell frequency in Hz
-
-Example:
-
-beeper_amp: amplifier {
-	compatible = "fixed-regulator";
-	gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
-};
-
-beeper {
-	compatible = "pwm-beeper";
-	pwms = <&pwm0>;
-	amp-supply = <&beeper_amp>;
-};
diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
new file mode 100644
index 000000000000..1d7cd58d2a8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/pwm-beeper.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM beeper
+
+maintainers:
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+properties:
+  compatible:
+    items:
+      - const: pwm-beeper
+
+  pwms:
+    description: Phandle to the physical PWM device
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  amp-supply:
+    description: Phandle to a regulator that acts as an amplifier for the beeper
+
+  beeper-hz:
+    description: bell frequency in Hz
+    minimum: 1
+    maximum: 255
+
+required:
+  - compatible
+  - pwms
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    beeper_amp: amplifier {
+       compatible = "regulator-fixed";
+       gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+       regulator-name = "beeper_amp";
+    };
+
+    beeper {
+        compatible = "pwm-beeper";
+        pwms = <&pwm0>;
+        amp-supply = <&beeper_amp>;
+    };
-- 
2.37.1

