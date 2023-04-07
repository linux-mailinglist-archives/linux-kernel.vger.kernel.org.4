Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56666DA984
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjDGHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjDGHr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:47:58 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD0A26A;
        Fri,  7 Apr 2023 00:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgSnmO8fGzHd3Nv1SWe6//ZzmpljcA+3gh3t5ufkJZPzVsOEdwIEiGDNQknBZc1IF87mhghppO0YrqtHeukF0e52ljH/nPMTAZ4ZhYkL2+JOT1htidHhuj2cMDCxbxEpktVEdWOa7RzS8R9QPT4R8LfOj4SAm0zIEJUb3iOUzBvbZFimUwB4SACAjPwFiTYbco1CaTc/rqx7vpo5BsNUiM3n+favOz953OHCDQYEDDfz8F9W5RQVyjvdqcNTA+8a/POyzUr38fu6Ykp/6xydDyaR8yNp/A4WKfbZb8IRuJzm2HzQ/dwG9tXek7t3cUGxe+YLGBI4ObUkb5Et+C1p4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frYHkR93JLVcv6wmJHr/DUNO9hVPqU6h5/KS4QoMkmQ=;
 b=Ts1NUHfM4EmDQtra466YmkNwBrESLnjg/M7LXcAmG2MBDDzedi7/8nTS1hARuy+p0f3GzMo5MCDkI4LoPxOkaPju9ivzhsQ/J72H34jrTiS9Av96Ga0tIyq7eNUs50avdIgNoEIzPxtZhbE1CXghBsv65ZXA4tfV7bm4j6VMMyYfMzeZTZBPVYfBwk3zuvJU3jfNHVoDK0XzEgG6Fm/n7obJXvcI5ThmE4N4gIbDykrXFVqfbTCU2FObstUrE8AzyKmQj58PIhKE8r2abQL6gi6YuASZijTGwgaycRZvG5Bi20TPrF43UpnAQGIBpQImSrYNElLhLJzkulHWaDbE8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frYHkR93JLVcv6wmJHr/DUNO9hVPqU6h5/KS4QoMkmQ=;
 b=GyWjHOxnDzY/ZSM9+Y3Y6c2r9OYy1e+Bnzva4ng0wxTPCZdIQYcVkHu60CxLEBJ4+QnY5SdSI9Ty89wNX+1o9Maa3IIJETMsGDvTQKQFdFg891qnvfbKgZxj5tYP7OfFBU6CygjLoeMYvBz8MD+n4ybV9KICWN2BUBqlw77wS00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8348.eurprd04.prod.outlook.com (2603:10a6:10:25c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 07:47:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Fri, 7 Apr 2023
 07:47:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] dt-bindings: input: pwm-beeper: convert to dt schema
Date:   Fri,  7 Apr 2023 15:52:59 +0800
Message-Id: <20230407075259.1593739-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 975cb01a-73f5-4f51-46e6-08db373c64fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDL4iBlLP+aVD1Tca3arQWlzLMShIRuYd1yHUHjz3bsY70jsAm70LUxMoDIC26rIcEQo33h16nZOyW2ozUPgUtHRHnlFRy6a8soe30dMLRsKBkBOT6+vYhEAG10irCJsqPoJjh6CHzzKhu6tUAfJU3+b70Urd893DYa9xa1+BlQjbAAk8IPe9H7l0mmSNca6qiASy3si/5JBqo+bPlFdntFIKvqB9ypey9pQmM/yQuS1yzYH07TcxZlP+Iz6jyUpDk5H8AW4pDolvS3a4fkhCSyPcmv/x6sPx+ohS5oqHdPGaooW/JShn3mUBXT/pxqoJouy2WEleO1SMONkPpfJMcUxiYxqBEUtWTa5ysKZBLDKWIolnSwJY9EXXPc/RZXXSlOt8l4W8hWlyNRtrdKbPbaqAr5cUfKvpzSnkrES55BgE760eNAWldemF7IkRyPsNbv6989vQ3LjlWkJoXNdl5VbBl8nFGAO2yV6sXx/rAhJOmwFs6TpKk88fEmohT8CScsQJJCjuZMOp4V41EUT6XPj/Cj2sgsIY021KUaB+93Clq+4xzl+7u1hQ/+7NlPiW1gN2RbgpRHdQDCnNY5LClqzbRcDKjnhLVka4IbzcTg9BO816kQn1q9ssxbVrQXldTzCWfWFrl/tAr4rw7EPfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(38100700002)(26005)(38350700002)(52116002)(966005)(6486002)(66476007)(66946007)(41300700001)(8676002)(4326008)(66556008)(86362001)(478600001)(316002)(83380400001)(186003)(1076003)(6506007)(6512007)(8936002)(2906002)(5660300002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VtmOlCdoOv6UNOGoVTTMAFg1tJNzesUtigDna8x71vr6AwfWFhdW4aSRJtOE?=
 =?us-ascii?Q?PUWK0mstb7P+kRILGjCnqC6Jc0E9md5YhK/acgGnFX/lIrMJ19FQz9iBU5/F?=
 =?us-ascii?Q?dFl/T5FtU9p3apDQV4wizti5Pcy4HhivRx81R5p6M+6KQ9Ig+jAKcA1ZQjo+?=
 =?us-ascii?Q?5HIdWXwMuPNxDtFRQrqwwdfcI4QDt73paDVv0x1xhJ5axEv1nUDS9cXCxZke?=
 =?us-ascii?Q?YuuDQC0unXh6B8hS9b7vwrzgZRB06AeqkaJ4BFwDBepUw6GaPLIEHkyA9BNd?=
 =?us-ascii?Q?SMDVqCgWZvPoCwCo0Q5OcyvKlw3RIdFYUDiEtfyDAkTcw4C8bvA7JyCr9682?=
 =?us-ascii?Q?OcDyBa03QatEjtsY8w45Wa9K81x6WN4dR4wAq/DxRtM4Z4IVnx/C5kCUVoCu?=
 =?us-ascii?Q?h7i8MxWkFem7nrQeHWFQ5qDGPeSKLzS9E3NLiPKsrGje5NjC52EiA/KZbrIW?=
 =?us-ascii?Q?gjPC1h7KIbZhDiusbqUbM/SxPkJao/noQjZiHljF0o+RiMcHa7uHqQCjRrmu?=
 =?us-ascii?Q?u9iXozhAgaRl8dVWTYwJjlV7EwJ32kXOS8ZEVKzzU1PRPOZJA6VOihWJ2l9n?=
 =?us-ascii?Q?KlGbQTqbspbzK0e5qOYQWC6IKO9KnBtnku1tz0l9uKKWkxab8t4ib9sDLWUR?=
 =?us-ascii?Q?0gAmOHtbSsPJRicIVrGu2gKmyUdERSntbPgbGvCOIGI0b55SITnqjmbl2m4x?=
 =?us-ascii?Q?Q39mgbCeImdMEpURBMwl3ZNuj3gLJzOv3TfQGGDcv2rozH7GdAXwIkpxRmlC?=
 =?us-ascii?Q?ZsDa3gJlY5SMvpYf8mbZvB3gwfCyRLEqj+YL4Vc2IDSAB1OT1/5KTfpgTLMJ?=
 =?us-ascii?Q?ih5+0fmjDZ2HYgrbozZlLxnCq/HDKHUMum6w0O1WwE/ZC+/7rvKvIYfYtsD9?=
 =?us-ascii?Q?hBd3EJiF1B0ByAG40sh19wHmCV2KEvEUfpdaooaDaTs313tvI82ugOeXnCWF?=
 =?us-ascii?Q?NIu/sggzfxfj3VZUAHKdDS0sK588ip9iVM+lSZS7SQvnFZiWw9eT0rcZA5ko?=
 =?us-ascii?Q?Zo0URCnSu6R5+bRaPfQ/yVB16ZnnFOmISHMqYDVTwMnHTKAWGdn8PqzUftyQ?=
 =?us-ascii?Q?BC5gIpsyVh5fipG2Ea0uFmJs9SsU0ri/t9DV0VOuCSmJRa8jZu+bjdNDrfzD?=
 =?us-ascii?Q?NdZyLOCS/4qQHPlfWGW5V2zoLAz9ognw7/Tf2dC0c7cWw07Am5rhrirN8xwJ?=
 =?us-ascii?Q?8NRXwF8t4Zs8QCoGHhz9hPURfM1aVKy3IBupy66RVSS8cCs+0Dv2b9Xw78eU?=
 =?us-ascii?Q?ZB0+75PMNasZXfCVdMcUZuGTY5df85EaUUxgboAYpWEAiSzBHQdCiNBIPjI+?=
 =?us-ascii?Q?yQCmh3MzvlYf78jVh4BJnJL2tGoLlYMPb+LrU14FqAFFF2v2LhWutAcR0a5V?=
 =?us-ascii?Q?Kk1iS2zv+2ZRCMMJb1/lKOgrjczgxzC14Nuu/NCeAhkrKOG5j3KoSfnMvoYd?=
 =?us-ascii?Q?pthDbEku1nD4FgomlpyppabjG6vdGiyLYvYc8ikX5tWR2xoUcWVkxpeB/SNd?=
 =?us-ascii?Q?Y2FY11thlKSIJuZb6bTqdVjQ5BdKs28Gsj8zLEmmcLd7CKixec5pWusm1bWd?=
 =?us-ascii?Q?lBMm8gTZUG7CHkw7NmkIOooZ5Y4NL+P0j7L2G9ZA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975cb01a-73f5-4f51-46e6-08db373c64fc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 07:47:53.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIVJQhbtcPWxZfU/zKk2QPUDM3RcACL34P7PSdY/kq10WQov/wFhucv9nkSH4GgSHM1r/0a8YcptzOffXBc3nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8348
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

 V3:
  Drop description for pwms
  Simplify description for amp-supply
  update beeper-hz range to 10-10000

 V2:
  License update
  Don't need to show providers
  Make example complete
  Decrease beeper hz
  Misc update


 .../devicetree/bindings/input/pwm-beeper.txt  | 24 -----------
 .../devicetree/bindings/input/pwm-beeper.yaml | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 24 deletions(-)
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
index 000000000000..a7611c206989
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+    const: pwm-beeper
+
+  pwms:
+    maxItems: 1
+
+  amp-supply:
+    description: an amplifier for the beeper
+
+  beeper-hz:
+    description: bell frequency in Hz
+    minimum: 10
+    maximum: 10000
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
+    beeper {
+        compatible = "pwm-beeper";
+        pwms = <&pwm0>;
+        amp-supply = <&beeper_amp>;
+        beeper-hz = <1000>;
+    };
-- 
2.37.1

