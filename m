Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6656A3E37
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjB0JV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjB0JVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:21:30 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A4010A94;
        Mon, 27 Feb 2023 01:20:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmzmDRExqH3jHPl8T5B0OAiFK9NgxzK6X5IdejtHUY/ESoBWG/09Sh/oS9ao/xLjpyrXtNanzjGAqiJDOUgpAgXvBOBo9NkW8MInEq2JtWcjgW+EhOY6MkbcqBci3fokQNcG/KYq6mYJNVmbHU33eaRKdFcqWCGZEC7w7QRdrIL2jbNAHjPVcHPtST5VVqyQ0Of09cWSTd18AZBpRtpuUo1xLKeVLuSVSyKp0dX0aY04NZSz0LwSgZd4ROewf5OAWExyi8NHwymP3pks7QhVUvFuaneoRJTmGXLYyElZP9HMpB8flEQZBzz3tpWt7aA4n3Q2iEu2Zw4QbhdgfmhJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyMFWe+WU6YBlFtA1v37g8GOgrqQoyLOQFqVA6cuZM0=;
 b=NWNs6FzQB2ZC2Z4anNg+NAYy6hDy3nzn8WP/n0N7xPf+T/k+aKvyYwDwM3VhyfvVDeqH0ycalZG6FGkbG32f4jK808y0GEDzDVDxktCExK8lwVOTvayzidGJSIWeO3Od9XpvW8oIyLhcSwjQbQ9pf9kSFECnKy8o16UBLlKqqsD1Su4w1rI59JYvw/BJyI21v7c5cJAfYHcvTsoawpdwJJsOMMf3cxoNukRX9U/YKyaP0MzmNdoWNZ+AK59IGVNZEqwUNjJ74XzgezbEW02PeqXWoZqkMzX+4jc4//E856qRzwZQa9FnSO5vhIVtqUURYOaDCXPXqLdpd5yZVdLG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyMFWe+WU6YBlFtA1v37g8GOgrqQoyLOQFqVA6cuZM0=;
 b=gfsRq57wGlhfnGWPI8/OUjyEfdVjqLsVbVoOI5XTGVHvtbOrnrrX5ueaY82L0ZQIFFOKYeJMH8+kcWiE4t1AcwrROfdy5wP4+arJOd+SWigXeBQmwF0wXaq3EUs9/UJHQUt+xMWT33q7+81egw46XmnhT9YGLVlIHdmoUd5UX5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by AM0PR04MB7138.eurprd04.prod.outlook.com (2603:10a6:208:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 09:20:05 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 09:20:05 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 1/2] ASoC: dt-bindings: wlf,wm8524: Convert to json-schema
Date:   Mon, 27 Feb 2023 17:19:37 +0800
Message-Id: <20230227091938.1671416-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:46::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4222:EE_|AM0PR04MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b87386-38f3-4eee-9dc1-08db18a3cfec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gY2ZD4JVBd/DJVVCBdWs7k0XEWQ6g5AXEdINIzsbsN0DtkKI3YU64Gb4X0pAQGjyRxcbtpjOle0AP1VXBRFk/rcxN1Ihr5H6dSxH/q9nrFHzyemoJ2oFbM8WhPGJrn8mOlEHU4e2+bo7zHoimDWiyDow6PdqQRRSRB9+wVHR0MzEuhMdVChKREa0eIoBUMkVzdpCA/qbEL0b7Avkgf+7eLw1y0jv9Vu7R6bMgHqPOmXctTTroWwAyg49c0HIzTtPQDf6XeSZDJIhQad4RvIJm6Jb4XpUmZhOoI3WtvQIscwtJtRrenAWDU56dY/BaVRWhZ8ON6Qcd8gx/TgL2CFxas9LhqLH9eiMsNFUPaOik+N76l9yMyNwvbqJGx5jToAVLLtpADQb8dMw1y5bTSInNy73vp3KdDpDN3WiNSnf6D9jmwglyEQUFJ86Etl0B8AzsY6rB8y8igBRg5BpkAUCyDBHEyuarnOfPDanXJI0EpxzJT0OkWd8dTkHaGLtI4R7Iyy0ohu3g3jizTrJyaykpd2BBhjQYpNJdvtdZkRzYdTc9MSBZizW+lVf8bz1p969lUm79RD3OSZzeVc0vahxrunvByI0U9C4JO4Mq0Fz7WlCNjjh3snzWCLreNmyqiGqeHSqGbXv+XFp/UA7atcJGoznQIPLf58bSnzyGh212XemvWe6uSm7FqFhO2JlP6PmsWY3Zp29kdpdY780R6TuWENwk4sqVLx4xb62p2xZxBDKES4d4pakZRQBtpfr+UYU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199018)(478600001)(52116002)(6486002)(966005)(2616005)(186003)(1076003)(26005)(316002)(6506007)(6512007)(6666004)(66556008)(66476007)(66946007)(83380400001)(8676002)(4326008)(41300700001)(7416002)(44832011)(5660300002)(8936002)(38350700002)(38100700002)(86362001)(921005)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xU39zIAQSlpwcdR1FCJ40QRwYCVH9DtTYNentoEjDlxUnn/upv2mohyIP6W1?=
 =?us-ascii?Q?JWWPzjnD3yNtbxnzYxG/+KoCyGaVDQWGkG/LQ/PTZtPHTuIkZTGMlQEf/SJ1?=
 =?us-ascii?Q?bCLkcu1v8zkAuMIsWV3YhGixvq6vWawQP/fJmIoYMf+9g0tvvmTCNB/ZiRE8?=
 =?us-ascii?Q?jX6CYwR/4I8FyDM0QHc4Mm//onCD5NrW+nAG72kzt0lf92NV625Dlyd8gI/P?=
 =?us-ascii?Q?pt1wT8NLUO2F7KtYT8hnOmGHAWTeV7c2Xspn6Cw2nsVvnPXBq2JENYQidGzS?=
 =?us-ascii?Q?LQE5TiHmHzxULlzl5GXrSXljvepnxSzhMwexO21PJ+6krQtRmDCPENqmyRMb?=
 =?us-ascii?Q?ZFccrXKO+owGsxW+EXGB5m8ZZj1nj98UEWzspJpz1NzXtQ9WddvFjgFhuS+v?=
 =?us-ascii?Q?K1Wi0m4qqcksGuse+RONPaNGsFBP+bYne+7vVuTl3gE+6qotPAZp1V60FdI7?=
 =?us-ascii?Q?e0Zkr5QZKmKzIknAto1NuXQrpXvXOu9mRcvNd412yfH47gWQAwivM6CEJ1T7?=
 =?us-ascii?Q?QtwnIFSpaYcfNM3bQGsrvblaV8Q84cp1PRW3KQqANfrEnVY4s/EuTkK84M6v?=
 =?us-ascii?Q?yiitiYg8tJjJkJvIpvOTlm/+S9r0/toQRZ5Ibsi8JwH5HjFmb7x5tTBLhHhK?=
 =?us-ascii?Q?0cEMNobPLl7TK7qQEGeT6snnqA9lSqi2AR46RVCKhHUXYddW3HaZc3o/4CMK?=
 =?us-ascii?Q?63iHaBKcuEu81xng8tM6ybsRil9o6cB0+tOwT8S5dJhH3oOiAiFRbw4cnKF2?=
 =?us-ascii?Q?B2zlmkTxsl4D+58o6qoS+9TiWeja+XyEVk6/kaEpFTleE0feYp4Ygp5wRlCz?=
 =?us-ascii?Q?9VaC7Qik51Tl12aOzT93PH+vj1JXoUTdhG01xRS0VTwPAlg1K1yRDkd3zON7?=
 =?us-ascii?Q?UsDpsESy9SuAxvppJCwIGtBghthnd5XyB3RkbymHy2DUDnXA7ZdvtIFxtEe1?=
 =?us-ascii?Q?Vd+iAQ8kXnBH8FplQo99B8V6HaO1D73Wh+7AcCrr+5HNCOkwbeeW/N7YNB41?=
 =?us-ascii?Q?YU11/n0G9G9JOINdqMwbWC7BE94r4CF6lG+wZ0/MsYstqX34nmb8nXAH+9Ba?=
 =?us-ascii?Q?flPZYmnjh9hmcx87EvzxBv/uPLbm8Qo7/hmMEfZpWskVyrVbXfXrHReBfE4q?=
 =?us-ascii?Q?rQr2MS2xxVvBOiPktH4Qu8y43lBogR5aeOiTr6ius5sq2uhlZg77vsT/yd4l?=
 =?us-ascii?Q?JK76h3hcajROk97zmtoOU862//uRFU0e/uDdY0mrVzihU0EQK0NQSke6auVs?=
 =?us-ascii?Q?NG7xPnpafqaDgcSR9ZLc5KFKqCn5TG2qhUA9QrMVbrcVq+xm7heSs9fjB+Vw?=
 =?us-ascii?Q?qo77piK/bNW0pLqkj7lpyU0z+Qjqtxml8gzvp3UQyrv+pj3XdC6ZeUBmh2pw?=
 =?us-ascii?Q?cqJOIiDZ/go6Scp1+elyKR9VDmJylYugGAgsANZuZxVp2pdRG3CEn1+EjyPE?=
 =?us-ascii?Q?MPgTY6xBMdGweNvR7U3F3KGY1p44UW7asN9hHbxSMXAXJ6KENq6PkHiA9ylK?=
 =?us-ascii?Q?3X0usSeJ5WbAu121br0NQ7yB5KkHFrt/xABsBhiSBXbDPOSLe/H++XntzrkF?=
 =?us-ascii?Q?lF8zLIc1QG7ZHQBhNENPzajNFY8yyqXqDEO8UW5W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b87386-38f3-4eee-9dc1-08db18a3cfec
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 09:20:05.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6YVBHLlVTdsVjywyw3eifwBiSs9QMIjxWrseNjeqFBn9vldk+f3OLmhEC5iYrmOrddLYfISVb8r30x2qPBfmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Wolfson WM8524 24-bit 192KHz Stereo DAC device tree
binding documentation to json-schema.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 .../devicetree/bindings/sound/wlf,wm8524.yaml | 40 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8524.txt      | 16 --------
 2 files changed, 40 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8524.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
new file mode 100644
index 000000000000..4d951ece394e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8524.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wolfson WM8524 24-bit 192KHz Stereo DAC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: wlf,wm8524
+
+  "#sound-dai-cells":
+    const: 0
+
+  wlf,mute-gpios:
+    maxItems: 1
+    description:
+      a GPIO spec for the MUTE pin.
+
+required:
+  - compatible
+  - wlf,mute-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    wm8524: codec {
+        compatible = "wlf,wm8524";
+        wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8524.txt b/Documentation/devicetree/bindings/sound/wm8524.txt
deleted file mode 100644
index f6c0c263b135..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8524.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-WM8524 audio CODEC
-
-This device does not use I2C or SPI but a simple Hardware Control Interface.
-
-Required properties:
-
-  - compatible : "wlf,wm8524"
-
-  - wlf,mute-gpios: a GPIO spec for the MUTE pin.
-
-Example:
-
-wm8524: codec {
-	compatible = "wlf,wm8524";
-	wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
-};
-- 
2.25.1

