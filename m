Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A649E686A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjBAPWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjBAPWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:22:02 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2132.outbound.protection.outlook.com [40.107.247.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637513AAE;
        Wed,  1 Feb 2023 07:21:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huoYRYIfxhTjIcxycCKkQOdBcbTkYZ0DydXRGzyFBDEyLs9juuk2R5GkM0+l3Ykq9sBxQOdkm8ldscPMLNqt+amrCVGa4H/7lj2TxDkZ7HGo4T1tmzJ7H5uNI/7bc55rV3mfoAiH1PWyh3/hLosn3DIoP9M05P7vaUOdaaCjmicPyxFm49daODFOVqDQmsyRauyTskvPbzuDL8Zvvo6mKUoumfE60X/dA6ZNliM8PstE0QyjEkO/qxBTEAFWyPElaQPnNOQv4tSLYVl9zw52IMEiClD4WPsm227uJq/maVZ+Pznxk7l9NmW5GoL5YRrgM79hU5b3r3FsdOK1jBs3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3FvxhoeHgs6ySwdhG6dAKt75icVF7WewSQykfDpa1w=;
 b=WZm7mfs61FqLHIMUR6kdrOh7MCY5lEhsisg2rzHwkrSGLM70IRpqrjWVWUI3MqAGe/IV62kyTS4srfD/AHzrpISOsw10ZMr5HMNSPUUVuCfr/p03xfTJt6NNxaL7s6G4Z3Rt4niOLOv91gxFiRKMS0vNjDhzN8c5WV1zL74QO9R6L1WF/d1oHkMTdSKqv6z1r8TWLJlWz2IEcEnSFBHOoSuyn3uHumyZaK6OqkJshUTvoPLM1gjN5FMCi4cfcXbrpUn7feprDIQhh0+ch/HCCRX3CpcB5DbHxM6rpaDOQ5+lE4ukVKBZT6kGxoCnXf5UHDsgHfxz4gadEOkAafM5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3FvxhoeHgs6ySwdhG6dAKt75icVF7WewSQykfDpa1w=;
 b=aVm71ymeNcecHcdAPZ0wFV86NNYyNJqGlyLdIFHBdFeaTu0+ac4lYvMRtGHlUo/4dNDHjZoZB4qUw71Ko+WlzN5FnGT8CulLRb0MUhpg3uXS8XcfuYjSl6YZ9o4sPO6pAfJ4JKvOKL6ftLOGWWCnN1PCS8fdq2FdiZTU+RXdxJpG8i1L7gYNVvEnnPEf/i8+8ifRhYmMsx0YBOQpXt3Ddxbm1YsiQVg1NYoxiNrh822xKCIENwL1NCmoeewdxiJ32Te+7WmtgaIYhHDBDwHWKQzkl3DO8RKOuUi5HGkK375K0zLs0ovc27/jL1kbkDgfF/YIZFtBYaqjQh52NpKj+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AM9PR03MB7380.eurprd03.prod.outlook.com (2603:10a6:20b:26b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 15:21:32 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 15:21:32 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 1/4] dt-bindings: input: pwm-beeper: Convert txt bindings to yaml
Date:   Wed,  1 Feb 2023 16:21:25 +0100
Message-Id: <20230201152128.614439-2-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201152128.614439-1-manuel.traut@mt.com>
References: <20230201152128.614439-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AM9PR03MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: f425ea3d-be0c-44a8-73b9-08db0467ffb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmul3Mhjrn7j9WB4XdbwQ1zKfTzquW5a39068F5HX9e5CmCO+wxiQPnJ9akJWn7/0WkR5tZs68CruSKI92a/dIhPIbcnV627mKHt+wdFHlUjsVF16faB55yJK8AJ3NSHMtfV94L43IWTxKxZ0GwAaIJ8mwIZIuGmmxB83LY7Pt7iJl0XCOV6RLZfHOuU8X9LeiEc1P8fO9UNpxkzNQMNPTzrMrop7h77n+eKXlQ85CaHAfoHZdDGwrR+JEEIy8fuD0hffK5jKVQtNUUCYetOu55T16vfEQTMNh8zujisYEnvvku1heXAocNl7SzjhoIXcArLW8A6YMfmVM4HaHeVOFinPBR9bTh7tomRApLhXf/IWivvHwmXOD6/3NOu6QYuStP7Epbpq2hoZSGUucC9vZDMadQNQM8KigTufaz0cvLNvFMQhTzVoAnuXhzwhojQkbCXjh4CBRMu1S5OFiw70zKdwsK5KnOup8yK9WDzWY4xponXftWAz6KYx4LkVGBC/jResG/62/P+kp9V3XP2Vc53Qw0FH3voHAsXYqQ2mSiXInzaFUAY8fA/HFqX14Fqi0NMZ9cAenklXxDKWon+dzi4bi3bKhkDnauj9eoWcS7P40limdJvB1FP4W+DZHDfX5jHtBgTnLSpshqHCuXpSo/I/RDdKCaoWmv3s0yekGGec47mVs/JhNW3CEgDxJwEUjoqhMSv5gy+4FJRdrvzzfyVQZ5kZaXYVn35Rv494T8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199018)(38350700002)(38100700002)(54906003)(36756003)(86362001)(5660300002)(4326008)(6916009)(8676002)(8936002)(316002)(66476007)(66946007)(41300700001)(66556008)(44832011)(2616005)(83380400001)(2906002)(966005)(6486002)(52116002)(478600001)(186003)(26005)(6512007)(1076003)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0mOy9B95NrK3m3KpFdvsdFUDNxUeI0MN5Aw6xQq5iDRT1pPu3Eu5ul96fJf?=
 =?us-ascii?Q?1ur3jWtTK0fjdOyqDHZqlKRTFqQcNMMuSDkekZ6Oi4EZKaoiQZPPUnVAlpdw?=
 =?us-ascii?Q?VY4iSftP0FQ7YzQRiBVQu7AB0AiNrWIVMoo1AvfALIjuU/Wm2+IQc5DWHtee?=
 =?us-ascii?Q?rtsQ7F2hlBD74IbRSc7UN3YAqlXLl7wPyU5JoVNfkbpOlrQRK3qGbEOOTYva?=
 =?us-ascii?Q?Nvxq4bMqEimRYgUCMqc0srrEBIyoFKYTXgfif5yhVYLpKTNt5o6IEgVwOkau?=
 =?us-ascii?Q?lErADOVEcNrRYOrGOzzm1exPgOGDvh8yFUVGi3dDYIyRg+NYfndHeEogEzdf?=
 =?us-ascii?Q?CV6O3YzNr5dhBgoQjYJSGmUnBbKozuxS1z0jJRf9xSA4YIWjNT98pGjZxAxk?=
 =?us-ascii?Q?jWt42kE9+jrILxREiOSRADGYO91ZXiY+71nCGcviJOxniL/QLKOfy0/AGb/7?=
 =?us-ascii?Q?6YZgLqPurfQHN82ZgalyDv8MgnfEjYKkhcnqp7dz9TQtJNn/UrsOx2/h/Qvl?=
 =?us-ascii?Q?8NiA3iXrkLC0dB0C9W63ihO8YDt5GcYefQZvRL2V3m/SDGXdfkCrJfFbPJ6s?=
 =?us-ascii?Q?M/qVl+KoroYiqV7UiB54ZKIOc26JnSY5s+riXVjm40P5ywhV2o5oDh5J4FdB?=
 =?us-ascii?Q?c4qv2h1rfQoUfdI3YjlBlFmhnYJcufx7L6SQXXov/LusdvhDJ1KgwOb6O0wO?=
 =?us-ascii?Q?ARIOOUXRDUuV7XOMsdnosHewH9q3reyaZC3IV79ApYHvcSgKesF6JJjgFzPa?=
 =?us-ascii?Q?MpdauAgLEQGWxbYlFZQAXUBgRuYex9Q7SKFJ7zQ7cBWiKMRfZXkvxvRcJWvX?=
 =?us-ascii?Q?M3i7+0TnklHL09gVzd5Qc/T1g645GqHL6QC8QfRmKcENDjCmav2Z87OQ8XW5?=
 =?us-ascii?Q?spb9LdQdHQQP9yyTg6ofUIEx+N93XWiqrL8gE+h/dAS2mhYrJ0VLNKcktDlk?=
 =?us-ascii?Q?ow8/0jYkq+7ZWWCtFMNIKPt1ZdDllcvDyhvDXE7XPRBbsIAVpjHikljtGM5V?=
 =?us-ascii?Q?rU4ltp3WBZDZUWUREGJf9wissuyxIH4SazDlieMvkLkdNE6bDub/GR1i+eq8?=
 =?us-ascii?Q?5osK9u1+FrH/6ZWvmEaH07+b7p/8qO09ffumbWcX+zrT45NzELF4ti5d2opF?=
 =?us-ascii?Q?tPJYrbJOUu3nA20F1KWoUd0bhARWYjdecqofyp7d3s02oeiiaxG/BOOEsqap?=
 =?us-ascii?Q?TTjtVOd+kxaVfAPqrQ2GKtdyGqL+6Yz/FIArePvJg6GBMSHkgeC9l5lapP7q?=
 =?us-ascii?Q?rS21w7HuA+/kKXLkTWVG1GTCjy7YGyPHEXyeediLaTRfEnrVbLA7leNk3OIL?=
 =?us-ascii?Q?hLWT53BU2piIPp23G46M9H3KGQYiI1nHYfwl2EkpY88UlAQTgVFSdwkL+83S?=
 =?us-ascii?Q?AwTrgyqpKYAe97T1E2yAfVx+gxTDYFn/EKk6VWIBdiNisTtz9Z3p33ULrRdT?=
 =?us-ascii?Q?WvSgCNmX7h1NwlXQLu451O365JbQDrnsQEgc19vAqX5ha7D5YMdNoMQoe8n0?=
 =?us-ascii?Q?Kjnw49mXKB8ywv2W4iunoTFU1737yV7s0Q2KTptC0cZZzO/fFP0gIN1Yji5N?=
 =?us-ascii?Q?W+kC0xDtkx5kmkpGuGnoHbZvzHSbNSJIwfBgiYhw?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f425ea3d-be0c-44a8-73b9-08db0467ffb8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:21:32.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybNu4s1h42DvoRFYS5TvxWH2pLfqZ02dU3WP9Hl/w6TAnwOIy37snlfDiOddtk3ry4i1SHr9O1rMunhro9DfKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts txt binding to new YAML format.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/pwm-beeper.txt  | 24 ------------
 .../devicetree/bindings/input/pwm-beeper.yaml | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 24 deletions(-)
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
index 000000000000..1ebc3a46d934
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/pwm-beeper.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM beeper
+
+maintainers:
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
+
+description: Registers a PWM device as beeper.
+
+properties:
+  compatible:
+    const: pwm-beeper
+
+  pwms:
+    maxItems: 1
+
+  amp-supply:
+    description: >
+      regulator that acts as an amplifier for the beeper
+
+  beeper-hz:
+    description: bell frequency in Hz
+
+required:
+  - compatible
+  - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    beeper {
+      compatible = "pwm-beeper";
+      pwms = <&pwm0>;
+    };
-- 
2.39.1

