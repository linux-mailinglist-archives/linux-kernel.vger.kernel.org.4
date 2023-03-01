Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B623A6A6512
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCABxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCABxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:53:33 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E65134312;
        Tue, 28 Feb 2023 17:53:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWcBmZLifuT2wAp/QONwvIRIq20Wgp2EUm1elNlusqDXjrD2g3a3oNeNTSNjdfLPmHaNBu0CW04muOQ0qDleaUHRSPm+ny4v5Urvw7pYi6XhoFtT6P6Zim7su4EEVGpGdw4bH9CpFYnc9l6jsG93zfCM0rduTEHu66qIMKsZ3hLsgeDdFDhVg/g82jdtkUXnSnAfIGHE3n8Af/EkZZAPyVQb5K7U7Ti6lwoc9E/HyH8WG0D9323S+PIRe4ZmGBlEK/qR7Rjw5JqB3TV//5ooH1ugRh856NpsFmLvUQ7evXBt9iRiv9PYJLOWGcJ8RRmk7/u+vvQcuiH0cUN8ZWqaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvoOt9p44kYGu9tXFYS8VqHm4CcSOwbaqkx2i09Heew=;
 b=R/ZS7dedjzIoEay6PefWWCRyWJabAKRL5uQx0Xo/ykiD9vWAOVWmtaPkmRC7JdPpkCSwep0MC9WXedrMJAJHz23x/ysyG523NExtka4A4trTjkCRW5ijdg+iDztzwx880trocVXFiUm9aEEjtRX/9ofETgoxBk+uoWyUUtcdF5YtO+DQdYnlgsqVcXoNRDQQpz15A8iiZWNVIODZb5wQ9Be/vf4p+P96O0ZXU/qsYJ0oj8dFJqvSKjJFDIDaFdbyYfHMXZgLasJv2Bu4p+Y5WJT1SHVvzuujPAKZfNuZYMuXtwb2TxheE6wxialvF4OhiFIHRvzVSwN42XMYmPyrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvoOt9p44kYGu9tXFYS8VqHm4CcSOwbaqkx2i09Heew=;
 b=I7k4NiMSVWaluXC2eXYzut0UESYPIXaCaGEmZx3LKINm0ipGvbxXNYOozmUfB6LYXM7OMbGokWh78BDAFrD7Xa+WBsDlY8H2oyutnssZ2z1Ak/WzYKyl9MhV85LNhG+2yDfJfeIzgVpPQtSUQUp7YIB2Mh+RXauzjevfAPqEwNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:52:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:52:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/9] dt-bindings: crypto: add fsl-sec4-snvs DT schema
Date:   Wed,  1 Mar 2023 09:56:57 +0800
Message-Id: <20230301015702.3388458-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e135365-3ce7-4fb2-10dc-08db19f795ce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vd9hhwsKqOSMUYVMq7aunk8/otJwTdolnPGw/80h2YhHUvLJy2otum8t4QjadW0IWSQIJlO/ESmsxBkQJoQaCdTbjQLqTyJqZfSHBv4t61tC11IE830BSa3jB7un7JtHUPp1w7DVynJrm2R7hYsIskRw/oMVu8TEwPlc0SXnH7aNsDlwQEF58zpvndCpTvYGdGHayA6Dc7oJMQDjkg0cFPM6EWAJ/FtbY66Imzcrofk2MpBds7uHYu/0sSvkVy5EtDS7w2zhBq/y5H1r2xdcFMTmg6dqRxNLddqDFT4EEHRUk7rna19olFVCj8w4JYBSD1ieIY7/fM+JVdRap9F6TNcho2crlHYeSeSYibLYctIwy2i7T3lg7KzAJeO0aLESrZGilngwkoD2LYlBGTakrSIMoOM8BUN1op0JM/OMyvsyr2j0Gny+HYNSfRkQpDj602ywg5Q2VnB3EzHz5OsgDn7TNRsNaCtpjGUdIExeWtUlppJXHnAjM12lXeaE1UgyZSW2f8vYL8rkXAVTJHTzMfNNmKN+7x/r1F1mL5bZbs6S3YdG4ACOKun6ruQ5T6VYXepe85JZOnH+IhgnV0aVlAsRFRotKdzfq2ydrYjqmSFhsPSLoGdPh9wYNTgtZ57MRUtI9LGaZ8MqgeCHBd+D01ieo7tNImUnROJu3llIQbJhn+u2g8bTi7yyzHLE4tO8gZn918jl9xSvqYyiZN885Y4INSbyaKE41vZKV1e+jNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(83380400001)(316002)(6666004)(2906002)(6486002)(966005)(6506007)(478600001)(1076003)(2616005)(52116002)(26005)(186003)(6512007)(86362001)(8936002)(7416002)(41300700001)(66556008)(5660300002)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yj8jaPVpijChcXoVob5I9XmtLP+w10j4x/G8rj8AP/TInBiFTaSk8sNw+Ml7?=
 =?us-ascii?Q?Tg5ULygQVxE4hXp8JVwfiZHhd4eEaMl6r5CtbbZMNUXAY2fvGeQ3GOL6Y06+?=
 =?us-ascii?Q?OwVpXC0pomuxsxHYHtjD803H4vUQYCq5/ot+27BWBL4lJNtcrPU7qu1TQLj2?=
 =?us-ascii?Q?L4/WEz/0BA5VYPsZfvBhi8H5p3gkicPYgsCAsBbpxiMMnzAGUWpBjUR5lp1A?=
 =?us-ascii?Q?SMdrkjLw/idS2xPRFBn9Ojak9meEZwXCtBfObaTtfL/Qu5x79LJFLxPg6raY?=
 =?us-ascii?Q?H1VNRXFV/CaiBDE+LcZP+UErrEfJcCKJjyMxa4vM4AxvABQKf72qAaIpKr/1?=
 =?us-ascii?Q?XNzrMdpsFbpwS+2qEq8VUm4GsmVlzKmopdLBk5emhOsJkIknsJ9AHe8mEUib?=
 =?us-ascii?Q?j/2bt4lbOrg442WZPOqdCLfeQq/Flucmx/UQiCC5T+VPLnjN9hJltwSQtCXW?=
 =?us-ascii?Q?VSjUNjfrrfPX5H9H9mc/HYQEGjhq5Yx5PGUsYT/IsZKwca/93goK1zs1vy5O?=
 =?us-ascii?Q?XNbkg4Xgp5rccDz2+Ms8LvOglbM1EZC5h2WudzrrLRrlCeL74EMIjVUydYZQ?=
 =?us-ascii?Q?LqThjCSVq/ezHpjAg4IdMlG07kkvnU7ADwaX2+mrPZMs+RALd+QJco9lsxAG?=
 =?us-ascii?Q?7yW8pbdzrjoyHqsQTbl7x2fDMabKVobVo2dFc68I2OImSXnKmCrq00Piosp6?=
 =?us-ascii?Q?gpMbK3+/Jbsvzo5rUkAoCvnY8ngyKwVg0hu4UGFrOV3oICovMs1csfLxza0E?=
 =?us-ascii?Q?GIqs/d9Y4LnMSvEnpbBGCkmI85LxwcpU2YoJD1auTPbG2svvc9TgIPQ7iGNG?=
 =?us-ascii?Q?YBK5UQxUYpReqvp7iMhL2vPMczISTb8llyNyzdJfQ06gqz4HCPNTDDG1CP7X?=
 =?us-ascii?Q?1m1IApSgEGhzJ/gBG9Qyw31rkE7hgs4xtIg5C+UXf1pslFFBxwR7SrdGPyZ+?=
 =?us-ascii?Q?KaL0jW9RhYtcD2ZbGC928ou2YA2ZC3V9C1asE5wg5ZBlqQPCfRVA9iihiIZ6?=
 =?us-ascii?Q?kgW+kQ6Ca6J546qoZgMtRoKzN3haFT9jZEFB9Wlhh5vF14w1zv4pWV4d35tC?=
 =?us-ascii?Q?RIVzQE27lkzdKwEOkmVf5VBUEia1mxw67zKv+WopLrR5Q1+H/ubN96qxRP/6?=
 =?us-ascii?Q?4g9BfbftGUteEGa2IsOV6EX1Hc1w02QeNKvQxPgTxKlQ8/ZgY95bDpRO097m?=
 =?us-ascii?Q?93zEiUMQFNfuJxjm1cNM/wLgXwy42zFJtK2p7jq7Z9K8RKIx/lPivrQuzIf5?=
 =?us-ascii?Q?KSDVgfhMgkpMnkds37rUBdolKQte13rVef4F8xkqvID6sj9f+micdowFyjK1?=
 =?us-ascii?Q?e7K6FHsM+4QEBl/Srm3ZERcv0elwGQ/gK4koU3pRNAfPcxU4oGiEewXCSCT0?=
 =?us-ascii?Q?4CgSY4K9Eii0r4P0zrPGvs1fgCIvEiG6RWA+vSq8BwshwcXMdQhlLa7OGxhQ?=
 =?us-ascii?Q?30JCBRkByvAX5OyBBOAEMmz6yGQDtSxrU1V9L5zG98eLglwInuluKF9QE5a7?=
 =?us-ascii?Q?MR90/bDdXt8GGfek5NiMytAYF6jqpOsni+tYjquMX8/79u6C0YDbF+mI99gn?=
 =?us-ascii?Q?4oZ56qbIvgKTeyvyiCu6+FPrykVD5Xz1QJOl4rvJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e135365-3ce7-4fb2-10dc-08db19f795ce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:52:16.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0suuqZKcMawEXm6dcft+S+CGC5Z/6DQgWmkxY1NDW7hUTJuR/0fVHT+ryDNJPy1uuUONAPHxQDGnAFQF2mA/MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert fsl-sec4.txt SNVS RTC and PowerKey to DT schema

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/crypto/fsl-sec4-snvs.yaml        | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
new file mode 100644
index 000000000000..633e70f9b303
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/fsl-sec4-snvs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP SEC4 SNVS Binding
+
+description:
+  CONTENTS
+    -Secure Non-Volatile Storage (SNVS) Node
+    -Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
+
+  Node defines address range and the associated interrupt for the SNVS
+  function.  This function monitors security state information & reports
+  security violations. This also included rtc, system power off and ON/OFF
+  key.
+
+  For more information on SEC4, ref fsl-sec4-crypto.yaml
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,sec-v4.0-mon
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges:
+    description:
+      A standard property. Specifies the physical address range of the SNVS
+      register space.  A triplet that includes the child address, parent
+      address, & length.
+
+  interrupts:
+    description:
+      Specifies the interrupts generated by this device.  The value of the
+      interrupts property consists of one interrupt specifier. The format
+      of the specifier is defined by the binding document describing the
+      node's interrupt parent.
+    minItems: 1
+    maxItems: 2
+
+  snvs-rtc-lp:
+    type: object
+    description:
+      Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node. A SNVS
+      child node that defines SNVS LP RTC.
+
+    properties:
+      compatible:
+        enum:
+          - fsl,sec-v4.0-mon-rtc-lp
+
+      interrupts:
+        minItems: 1
+        maxItems: 2
+
+      regmap:
+        description: This is phandle to the register map node.
+        $ref: /schemas/types.yaml#/definitions/phandle
+
+      offset:
+        description: LP register offset. default it is 0x34.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        items:
+          - const: snvs-rtc
+
+    required:
+      - compatible
+      - interrupts
+      - regmap
+
+  snvs-powerkey:
+    type: object
+    description:
+      The snvs-pwrkey is designed to enable POWER key function which
+      controlled by SNVS ONOFF, the driver can report the status of POWER
+      key and wakeup system if pressed after system suspend.
+
+    properties:
+      compatible:
+        enum:
+          - fsl,sec-v4.0-pwrkey
+
+      interrupts:
+        description: The SNVS ON/OFF interrupt number to the CPU(s).
+        maxItems: 1
+
+      linux,keycode:
+        description: Keycode to emit, KEY_POWER by default.
+        $ref: /schemas/types.yaml#/definitions/int32
+
+      regmap:
+        description: This is phandle to the register map node.
+        $ref: /schemas/types.yaml#/definitions/phandle
+
+      wakeup-source:
+        description: Button can wake-up the system.
+        type: boolean
+
+    required:
+      - compatible
+      - interrupts
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx7d-clock.h>
+    sec_mon: sec_mon@314000 {
+        compatible = "fsl,sec-v4.0-mon", "syscon";
+        reg = <0x314000 0x1000>;
+
+        snvs-rtc-lp {
+            compatible = "fsl,sec-v4.0-mon-rtc-lp";
+            regmap = <&sec_mon>;
+            offset = <0x34>;
+            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clks IMX7D_SNVS_CLK>;
+            clock-names = "snvs-rtc";
+        };
+
+        snvs-powerkey {
+            compatible = "fsl,sec-v4.0-pwrkey";
+            regmap = <&sec_mon>;
+            interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+            linux,keycode = <116>; /* KEY_POWER */
+            wakeup-source;
+        };
+    };
-- 
2.37.1

