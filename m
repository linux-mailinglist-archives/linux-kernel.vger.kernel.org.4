Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8281567909E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjAXGBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjAXGBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:01:25 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8FF114;
        Mon, 23 Jan 2023 22:01:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSL9GikB+kat5EqTknkbQ0J+Ev5Iv7nkDLB5+RZHpPmiu3Mha8vjtnHvotQJHaGxw8GIcfnXpaDvbBPquHKP+Ap7V3cAi4SB89QVYr436FMi2vP6WCeSrSrXlOmPWcdALOglNXJd1KOlL4RoD/wKywy3cRkHrHYIRm8jtlRZJ8L9mrfLPX58/OJv1Se1kBdgJvIj8DMVxCxOprC1o7C+78+CgUBC5WN/79EmeTf8pwtSmCR9t0JIOZBjm/lqBnjplgOf9rZtS1JvE3WTIrtHvT8TgH28mcWP7SSF4SdnJrLznt/AV2K+jwuaAbLIlPlpA73rFpUETCR6wym4l8QvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k24gUXPT/wMoNl01An6v3pWOEB3eK+P+AR91EHF+ZHw=;
 b=FqxeZVkj0RjA1QKiMGs5YS73YN3sFDxQc+wiSiKu9DJ2YW4ln8d/8wcCu+ms8bBv0fintZJaJRO7mSz3jKvHQqHo1CTfJnGeBeGpYkF9NiU9bOxJu4b+XdVffZBMsoooSsW3qNwQm0xMGmQq2RPfIueKUJgLuTXJt5Mmf6YgTEXff7tGd3tG294pnHOTCd189XY1VcbojrwbRSCQHB7KZ9BF55CvprWXnPRKXIZYEoURFNh6f6eaxdU/ExrTAjG4yqITYMvFpKIFDyljw1R8ZbhHi02mtcncY8GqqtdwPEdgpQWFDlcCJKp0TDdXY7d0A6QcNN3oj72TD7RoI+xfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k24gUXPT/wMoNl01An6v3pWOEB3eK+P+AR91EHF+ZHw=;
 b=DlNZzmxhdd+Tk0+Sb+csuo6a4pIyTBBGVebfzTdvA6e58S3HZ0cb7t/qT80LKfaEyY6grc63ZIxBR+hv9V+W+PraS10ekimLZ4X9it5jkOlhzCqZq6ggyyAj5JJpsHEbQp8/g6jRg2HV+PsPCfQmi6Xt9Ac8+CKnjOQ9RqAGQBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PA4PR08MB6175.eurprd08.prod.outlook.com (2603:10a6:102:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 06:01:21 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219%2]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 06:01:21 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH v2 1/2] dt-bindings: media: i2c: add imx415 cmos image sensor
Date:   Tue, 24 Jan 2023 07:01:06 +0100
Message-Id: <20230124060107.3922237-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230124060107.3922237-1-michael.riesch@wolfvision.net>
References: <20230124060107.3922237-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PA4PR08MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: a2740c61-a63b-47de-5947-08dafdd06a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /t+oED/st3N5YQkdnnJBv/tWaOD12Rbkp7foRToxI9rN1Ha9Rq2qahsAK6ZlysIgHJK/5kb9nqfo8YUg1jL6iCs1VN+7H+PaHXmmYsElF1cdxVkiM2cOEBWTjGFqc+3I3dwajdzRZ2aYZx6vzItiseinvYTCFhQGa6OJl3eMuyHQe/E71p0+A0J3ss8/diW9yaSooxWtR6rAr0Q7fVu+BPCFc20T8ndfSsnQaX5O3cKE0Os39zMr91J2Lp7V8Pj10mJ8xoRJEAjAig0PpKWF6J99donAlijDeym/nflGMCv/e8Xoq5xUQA6YxNohdGzMRxzy43dwBY5C+n/0ifqKeLu9isbXwbFG54BqMMrOqBW2i/V5zc2g+8lqYc2JhLl0pLGUXhhhvVRI93+I8dnNGsDaUF/qfgSWq6IanZYFvbCbb8roKa+ilybBeXzWxpCVZ3dL3/p4nHL8dKRnbkG4dDl67aABQl9paSF6eWjGPMFt261Lif1hXFDUz6HG0ZvI2KoOSoawTuPxvYQZuDWsCP49uxnzJpGfsGr/bSt9zHv4/cGVSrxNxFvV/Yaor4vCad6YODdYhTv4TwUJzDng6vFmCjF2YcJyo7ADYRFo6zSTebuBJVSWuwQMrIChAe68mL9LyhVODUbqgyU9tEPAogRCMsWobDsYazobhqoqsPAS3BzA9B8FkVLPY6Xru2EVmVqmK7giDogFYbBHFJcmfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39850400004)(366004)(346002)(451199015)(36756003)(2906002)(8936002)(44832011)(41300700001)(5660300002)(7416002)(86362001)(966005)(66946007)(66476007)(66556008)(52116002)(38100700002)(54906003)(2616005)(8676002)(316002)(6486002)(83380400001)(4326008)(1076003)(478600001)(186003)(6512007)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4TioLWYBQn2UbiJeD7dvoEFSZmTFW1D8Cns06GIwyjvaT6zqBDSNpnhaNQta?=
 =?us-ascii?Q?cc3crWXYW7yR0BoJJ9jCKUbA2Sblc4J0rBa2Dsr+5ZEnmlE3khXJPsg5eDCy?=
 =?us-ascii?Q?yhdhISiiWo5JUEXuerID+kg52eK4E+rUwDRf1ce/V3KiRrTGjZWwwdb8SxPr?=
 =?us-ascii?Q?6kFwHrfKNIzY1GkKuA3Q8B8w5XXib7foQ3E+crOnCayesaPhxSVd1cdlAl+7?=
 =?us-ascii?Q?gazqEU1ix5mbDh8qjaeffNmewWIRNVMwLB2Naf6UeZAZxp+JmpJb62ilzDSD?=
 =?us-ascii?Q?TVDo7DfUycuEusRS/7rX3zNr1/DYH7bE3LkzoxdDtZDOgdsxeA5uGccKLZZo?=
 =?us-ascii?Q?7ZNySfCgaGhdJq53CmwTGbdig8GQtwoc886lJZ+sNbEibKSKy48fnDAXWNKj?=
 =?us-ascii?Q?Xl/JhBL7jbvsb89i1Pb2MxkQRrz69Vp4hBPW9rew5WcNLgLG0Am7m4RbJf+1?=
 =?us-ascii?Q?LJ6KJo7t7vunp6qC3MvOXQcJ49kMF0U5ajGpGMHXf333jYUqfSD6fOa9Obf+?=
 =?us-ascii?Q?fUKvBs3TkiauK5OABm9RIAg87MOjytuGU6K4bcDLpoxzK4ZNacuE+mPAGN3y?=
 =?us-ascii?Q?KhwXANtxg7tOK7BKy3fECFgM8bAqcAVA+q4WB6m3JDHakXVA59Hj0YwVE2CZ?=
 =?us-ascii?Q?P9qq2vXBC8MFSpvlqCXaY7GKHchT5d+RHZlidarphdR8zQ1ubk372uv2R79T?=
 =?us-ascii?Q?Zwc+M+6LyNJjRxucSgrGdPDIJJ//dS02XKYXTo6uton+i/PxWHSgY0o8Kk6x?=
 =?us-ascii?Q?d8FYxnhjl1dWp/PO/6RGfB9ubb/nVubtjBfi+kZnPd/9kZstH9/3wAYTsMGa?=
 =?us-ascii?Q?DCLQK7SVkZAhLd9mrTAi+0wvJW7xPvgE4Ot69qgHwO8iveUbjypSFm3Hwhfz?=
 =?us-ascii?Q?/DvS4DAvaT/AtU0ac2+4VcwrTN7XxQSaCr0kMwRlncECxJoC7zEWPAHI0SQi?=
 =?us-ascii?Q?NSMIdm9AuKDvlLaC8rX08h/YdpdqxRIIwdh5L9I/50aFiPScdunaxYQRQtET?=
 =?us-ascii?Q?ExPhZ1YB57EBXCLy8ifjh/LBAHhUW70JUf1iyhjbI109XRKrHkNCaCg0g7Ps?=
 =?us-ascii?Q?xC3bbhTa7XE+HRC45h3OyGftzzngDRLQOBmH9l8R5sg4/pgcvbjO+0wO+llD?=
 =?us-ascii?Q?BJt4gvjXvltP/8a5imDqOLH7LMsqDbBBmw4T+gZ0rkd29wreHGdmPSMtyWm5?=
 =?us-ascii?Q?mvp88deD6NGvlSlTzcPW9c9+jInOXDHKsv7Ft5jj+A9r5MNE+1fcauaDQLln?=
 =?us-ascii?Q?4lhJQ5JPUhXim8rLCVqOQtzxN8CReAcAjcZBcdqYBzxym9xT0gIpMNOes1Zs?=
 =?us-ascii?Q?eHHncXhwKMUThRr9m8OyEnjkeP8venWR2zO9tX5U9afjZyb3NuA4q1KtbQ6Z?=
 =?us-ascii?Q?nFDLZFkZNkT+YxSiKLgtphXAhySB2KOLqf4PDxWr1dOxL7vaoONnX3XyEKBP?=
 =?us-ascii?Q?EAht1Zar1dLLAmrOp42L3Pbs007IdBZbiYfUCV0mHobRV9SqclpDgHArujIG?=
 =?us-ascii?Q?MRPb03Z5By6gwEoi1KGqaemX1QvJDarURLXq164RQVC6JxHYvNjDqc3FgdKD?=
 =?us-ascii?Q?SoXkbPd8qcVK20gtabZkX0vyy/ItvbB4TsKaFoUePxYdPheOfbNahVJSk/Dq?=
 =?us-ascii?Q?G/McTVmetSs1pWzTeYo6mDixEocNpN5jYPzqJXORdQfRdralcIZh3CdgrIkO?=
 =?us-ascii?Q?ftE6E3tvsTH6A3S5V62BempEkI4=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a2740c61-a63b-47de-5947-08dafdd06a96
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 06:01:21.0837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z97sYnWBjz80A4LFHzMJQ9kfU/PT+G+fAkjHOZlOcVlRGOTjdmhuj05+PQaOltHzBcA9/GJjbqQaE5KUnHWZJQjKvRiXtCOwGIaOmwrPQFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for the Sony IMX415 CMOS image sensor.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
v2:
 - fix reference in port (must be /$defs/port-base)
 - describe data-lanes in more detail
 - remove unexpected property clock-lanes from example
 - sort properties in example alphabetically

 .../bindings/media/i2c/sony,imx415.yaml       | 130 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
new file mode 100644
index 000000000000..104c36b64c09
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/sony,imx415.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony IMX415 CMOS Image Sensor
+
+maintainers:
+  - Michael Riesch <michael.riesch@wolfvision.net>
+
+description: |-
+  The Sony IMX415 is a diagonal 6.4 mm (Type 1/2.8) CMOS active pixel type
+  solid-state image sensor with a square pixel array and 8.46 M effective
+  pixels. This chip operates with analog 2.9 V, digital 1.1 V, and interface
+  1.8 V triple power supply, and has low power consumption.
+  The IMX415 is programmable through I2C interface. The sensor output is
+  available via CSI-2 serial data output (two or four lanes).
+
+allOf:
+  - $ref: ../video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: sony,imx415
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description: Input clock (24 MHz, 27 MHz, 37.125 MHz, 72 MHz or 74.25 MHz)
+    items:
+      - const: inck
+
+  avdd-supply:
+    description: Analog power supply (2.9 V)
+
+  dvdd-supply:
+    description: Digital power supply (1.1 V)
+
+  ovdd-supply:
+    description: Interface power supply (1.8 V)
+
+  reset-gpios:
+    description: Sensor reset (XCLR) GPIO
+    maxItems: 1
+
+  flash-leds: true
+
+  lens-focus: true
+
+  orientation: true
+
+  rotation: true
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            oneOf:
+              - items:
+                  - const: 1
+                  - const: 2
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+
+          link-frequencies: true
+
+        required:
+          - data-lanes
+          - link-frequencies
+
+    required:
+      - endpoint
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - avdd-supply
+  - dvdd-supply
+  - ovdd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imx415: camera-sensor@1a {
+            compatible = "sony,imx415";
+            reg = <0x1a>;
+            avdd-supply = <&vcc2v9_cam>;
+            clocks = <&clock_cam>;
+            clock-names = "inck";
+            dvdd-supply = <&vcc1v1_cam>;
+            lens-focus = <&vcm>;
+            orientation = <2>;
+            ovdd-supply = <&vcc1v8_cam>;
+            reset-gpios = <&gpio_expander 14 GPIO_ACTIVE_LOW>;
+            rotation = <180>;
+
+            port {
+                imx415_ep: endpoint {
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <445500000>;
+                    remote-endpoint = <&mipi_in>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..c9fa893bf649 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19493,6 +19493,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml
 F:	drivers/media/i2c/imx412.c
 
+SONY IMX415 SENSOR DRIVER
+M:	Michael Riesch <michael.riesch@wolfvision.net>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
+
 SONY MEMORYSTICK SUBSYSTEM
 M:	Maxim Levitsky <maximlevitsky@gmail.com>
 M:	Alex Dubov <oakad@yahoo.com>
-- 
2.30.2

