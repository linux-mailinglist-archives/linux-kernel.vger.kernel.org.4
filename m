Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2684160E26F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiJZNqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiJZNq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:46:26 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2118.outbound.protection.outlook.com [40.107.22.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC7B4D81A;
        Wed, 26 Oct 2022 06:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gv+NOkN6qhdlGs2RvVZ8+8N/nc/onOdSuq1OfsTmboYqK4YFXIAODt7Vp4rW/E4tRK50V6LN8AhBwYWLtIN7S5jS2LTBaneR3t2Fu48QOI9liJIAZVzU8soxZx7MpUyxaiBZt8WorsX+vvuTeRG9kmET9zXbxuMS35+X+t5SXKRolwe7BlGWXuKZYDurOV3kk3vuEWVPPfgnMbMIWRUP7Y15GAbL2vmBIxo0suKR2czhxFf9znlhlFoMC8dkhy7pvspAWZDKDB2Os113v5kGMm5xSCwTYcOXzhSHVm1PAt3Alg8XVM01UR56x9wEXL2Qj6c/hFClun7QPOlIHElwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GevpEYH8wHEFTGv/htXn+Jjo1cuRWgw6ug3SmRabfao=;
 b=nkrw2tSAY+LvglYPBdKfb8FOeEIN9jC7TLKGd9xsJRHWV9S1IpTAJGNI3de8aPKmUz9Db+uG4rVdsneMdJUv9ng9bNuQ8HqacRERoVSy2jeNwcF/Dv4Szn0mZO8ZymXUFzbwhelw6phVLNzIDqhA+2IO7FAE9oM7EiZXbkPgHdO1y7+w7cm4FSgA2OhLdj9o5wU23ejA42a6S1YzcK/+nPcisd3V//fDQ7b3HRgmuCvO7hTF20TYijaLYrtoyZGcoVJJzbu5RmEKhCs2/f8TPb7ANMZ9jKUNDMtG2IU2c77/gZHon1pxvQsExENbPJJuqGbY7vMtfTJnMu/cnyhoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GevpEYH8wHEFTGv/htXn+Jjo1cuRWgw6ug3SmRabfao=;
 b=LDUcrIV/7OG/rfmFgXycWZOe/3AV0GnwY28MCIMdKG8Jap/DBIFnkuvocmm8aPi7yJeqALr5I/8NEThyqgN5Q9eLPNPMo4fZY1eXg3kmeAxQeMsYAL2IaD+cUCYM3BH84MAJXddYYkkp/uGSqP3XJuzvX4OBRw61WWGzuq3t1fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by VE1P190MB0941.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 13:46:04 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 13:46:04 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme
Date:   Wed, 26 Oct 2022 16:45:42 +0300
Message-Id: <20221026134545.7146-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221026134545.7146-1-vadym.kochan@plvision.eu>
References: <20221026134545.7146-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|VE1P190MB0941:EE_
X-MS-Office365-Filtering-Correlation-Id: a62b2d66-7eb5-4d41-2186-08dab7586d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqs1Q73sz8uzV3zPss5butRRh92Fg0x96iZl2w72Jwo6ozwa5UuNeFmGiIJtTYK/tHtyHOxUaGCff18b+nrhFV1abtWxPP65ImdalQIhFkqE8gdybH0Ts9yN4aFRJZv+11Fxm3x/415w4bRdQuWM2C7w+ctr/KM7S+gupLMLoan7SDIqvb6KbtuXP8AVWZWIAoj+xyIAW0XudzyaNk4OkdD9Zwzxnprjwuq0O/UYPw/7jZumxDcwIJCM+SMmw5tKoEBtIMzpgo38xdeJwODV+nJn9MIKMpRetojmoP0EKL8LNQmK6sVd8u9sLS3OceHrqVrt97Dl56sK06THcOFB7buKGgmWzPM1usRazty93Vhxb+2HkqWp7FPXIC3NkeyV5YW8a88x4Cl3NLiNDXT90y6nvMprgkWlQnI3dN0oK/a+Nh32XwS9tz0SuDj2klNVhjy83GNAjC2kl0FZLDwpebWH58TjU6yvSNKozfT0F7CUksBvbJbb2DVHSJl55D7BAhO61GOkr0kw2VT/XFGZLqfW/N2AdZZ9uIXF69Arx9xwQRSXXpHWakP4f5YUnFUd9W9fWHHupgeryhi7b4ku1TrhtmWzbgkOCJYSj3Pl3gjZgNVihKe+WqseMAhBRnc8iNK0rMZWSxB1us6WIU+i1+00tvYPm+mJuEMuK/eLCCWjWXchT5EFPFdk1B544Tmo8Ba160xHlKAUSZdxbWB+VV9yF0y0nX56m/S8XoeeZIVYeHZEhwrCipT4XpxhtB81m4Q9xtf308sh/eEhtnSQu3YRrRDn+A24p3ToI3gUVnjM4CxiB9N/PoXmxGW1HR6j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39830400003)(346002)(376002)(34036004)(396003)(366004)(451199015)(8936002)(66946007)(4326008)(66556008)(8676002)(1076003)(41320700001)(66476007)(921005)(6666004)(38350700002)(110136005)(44832011)(508600001)(86362001)(38100700002)(6486002)(966005)(36756003)(41300700001)(52116002)(2616005)(5660300002)(7416002)(26005)(2906002)(6506007)(186003)(6512007)(316002)(54906003)(30864003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1n8JW9UG8SWvFHAQORWukafDZGSCjPetyCNK1Mu1U4bHhJKWGSJfiHd+GXA?=
 =?us-ascii?Q?UhC8Sh83FKh7Z4jps4P3dvQVXBOqHc9NaMitojgO+hmokHOQxxsYQ8GaopM/?=
 =?us-ascii?Q?97WT8t88uMqMWa6vFy5RZ1pMgk8/38vYDXx1S/AGcUVsVs1mVK2iCf11P64V?=
 =?us-ascii?Q?Pe3o+0qe0yGaun7aA8j+QWFCZK1RrVzWTw/K/bmDnkwOtCt7wG8QXECbsFGG?=
 =?us-ascii?Q?sNMOoIk3evjWW93flwGzFbgISeve3upue/PVxn3grOMJjZMNg59mU3bPGrPk?=
 =?us-ascii?Q?v7ZMb3wZPFdf/Fafc8WlQQceL9qPMZj6VToSZSGq0nj+IjHjWhZu5xhZigPK?=
 =?us-ascii?Q?wNVmuCGNPHeiw9f0zunF39kL79UIFsCDbd0qTr0ICk6ZbzT5ucniXi0RIbBZ?=
 =?us-ascii?Q?PwYTfACLtJwpgEwzcEJ7o8gGgISwOJ/DHFyqD/2BGjC/r0gHNTvglvoubEsR?=
 =?us-ascii?Q?yXqAvsdAK6x0R7Gd3+cdlMhjJqHNGHjtkEZ4hA6rdlUDzP1NEGp1xy1rcQS8?=
 =?us-ascii?Q?ehaKBcHF1j8YumPyLgWuQ49fQk7tjy9590uvjAa/10dgenrQzYIONLNrZjWU?=
 =?us-ascii?Q?XdbVkSVG/b1bAHaMmK+HFaQVbCeD0id8+geSLHQxlhNmhU3xokWokbvvk6Cs?=
 =?us-ascii?Q?SqIhZLw5xyoPlhNg+eQwNWMHeIMAgrw7yQ1z+OyCVHRRnlpMzRJKjIl3Km4z?=
 =?us-ascii?Q?vEgRft/X80bal+qcs31k2B83qhJUZXIOnWrhRXyXQKF0k0f3wdDBaz23NZOy?=
 =?us-ascii?Q?xgeFIdS83UwnMIhdIwVI/GeWD+uNmcOacEgTmuBgWOJJt6PFEE9Lx/lgZRl1?=
 =?us-ascii?Q?wIop2M957N+fuRAlm0PJYxwGXgkJsfed3lTmX6Uqb4HLGC/ikgFKg3SNrrPJ?=
 =?us-ascii?Q?hmYUMaTGSMIUTOwrGDDm3BNdPjnjdbv1OzR77FexPwbdfHkYKgCOXCWOEuD7?=
 =?us-ascii?Q?uiYTJL0tkYC5xfkKhQYStUhEpKX8jgGOPCCfWxTceMLeSKdDr3X5KN1ATe9p?=
 =?us-ascii?Q?JqYO9DF0+QAG7H1ng4RqHWl/he2NnfSYp1yXhtu4hpYbJEeSz/7yUfq85qgz?=
 =?us-ascii?Q?jHfeTtFfl90yDj3qm+5TY/3VrmZ+dSesxZ/WBoPbd2317x1yfRPAwzqgxJ4u?=
 =?us-ascii?Q?V5OcFZuPO1cUPuKhNLVKe6xbBkmbK3/TftXbu7y4FSof/lJa0Jc4gOGN26fz?=
 =?us-ascii?Q?xMFAzvZwRk34qSDHT8z5QPmqbfcCn1LqdDfbqC2tCp8J355H8Kytr17YJoks?=
 =?us-ascii?Q?XJbOoaLKoMjkpyKlGWOv39RAEKEHDsvKfZhTpUrBsLMx/bq8/cC9XTT2yzhT?=
 =?us-ascii?Q?N4Z0QW4HjicbTAOJwNMS5yWu2XU1tsBhL3sUtkL5/IyzyLbtiYqcwJ1dIcLu?=
 =?us-ascii?Q?eAB7FM8aLz0NDnSBUwZPok1xazl46l7kVR0OXG2CvKf7BTyc6aW6+NsYlvTv?=
 =?us-ascii?Q?lNjDmoKCg6rwOkZoA8bMdQpUC5zncFgKZyBSpJ3z0yRvDENSgSSoH5a/RWRp?=
 =?us-ascii?Q?jIfyvflXnLtStLZBhMQS3IBWTE8ajwWr7nggIAVUHk4J2rhaLyCjqFth4y6Y?=
 =?us-ascii?Q?GT/LQsPOVEFooNKACIKYj2xQz2ARAGge16cTPIzDDyvIdPCDHiFQJMgJPhAu?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a62b2d66-7eb5-4d41-2186-08dab7586d29
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 13:46:04.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhDwVrlxB3Vs5EN+duVtLKz2w5ttCXpayvfvoCXKSn6eVOiWIgXLwfwuCHc5CbH4G6yqS9bMYpGdKO/n8hOSmIjzGjkcIj2X8IQx+r6l3nA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the DT binding to a YAML schema to enable the DT validation.

Dropped deprecated compatibles and properties described in txt file.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---

v5:
   1) Get back "label" and "partitions" properties but without
      ref to the "partition.yaml" which was wrongly used.

   2) Add "additionalProperties: false" for nand@ because all possible
      properties are described.

v4:
   1) Remove "label" and "partitions" properties

   2) Use 2 clocks for A7K/8K platform which is a requirement

v3:
  1) Remove txt version from the MAINTAINERS list

  2) Use enum for some of compatible strings

  3) Drop:
        #address-cells
        #size-cells:

     as they are inherited from the nand-controller.yaml

  4) Add restriction to use 2 clocks for A8K SoC

  5) Dropped description for clock-names and extend it with 
     minItems: 1

  6) Drop description for "dmas"

  7) Use "unevalautedProperties: false"

  8) Drop quites from yaml refs.

  9) Use 4-space indentation for the example section

v2:
  1) Fixed warning by yamllint with incorrect indentation for compatible list

 .../bindings/mtd/marvell,nand-controller.yaml | 195 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
 MAINTAINERS                                   |   1 -
 3 files changed, 195 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
new file mode 100644
index 000000000000..544e98ed12bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
@@ -0,0 +1,195 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell NAND Flash Controller (NFC)
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: marvell,armada-8k-nand-controller
+          - const: marvell,armada370-nand-controller
+      - enum:
+          - marvell,armada370-nand-controller
+          - marvell,pxa3xx-nand-controller
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Shall reference the NAND controller clocks, the second one is
+      is only needed for the Armada 7K/8K SoCs
+
+  clock-names:
+    items:
+      - const: core
+      - const: reg
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: rxtx
+
+  marvell,system-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Syscon node that handles NAND controller related registers
+
+patternProperties:
+  "^nand@[0-3]$":
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+
+      nand-rb:
+        minimum: 0
+        maximum: 1
+
+      nand-ecc-strength:
+        enum: [1, 4, 8]
+
+      nand-on-flash-bbt: true
+
+      nand-ecc-mode: true
+
+      nand-ecc-algo:
+        description: |
+          This property is essentially useful when not using hardware ECC.
+          Howerver, it may be added when using hardware ECC for clarification
+          but will be ignored by the driver because ECC mode is chosen depending
+          on the page size and the strength required by the NAND chip.
+          This value may be overwritten with nand-ecc-strength property.
+
+      nand-ecc-step-size:
+        description: |
+          Marvell's NAND flash controller does use fixed strength
+          (1-bit for Hamming, 16-bit for BCH), so the actual step size
+          will shrink or grow in order to fit the required strength.
+          Step sizes are not completely random for all and follow certain
+          patterns described in AN-379, "Marvell SoC NFC ECC".
+
+      label:
+        $ref: /schemas/types.yaml#/definitions/string
+
+      partitions:
+        type: object
+
+      marvell,nand-keep-config:
+        description: |
+          Orders the driver not to take the timings from the core and
+          leaving them completely untouched. Bootloader timings will then
+          be used.
+        $ref: /schemas/types.yaml#/definitions/flag
+
+      marvell,nand-enable-arbiter:
+        description: |
+          To enable the arbiter, all boards blindly used it,
+          this bit was set by the bootloader for many boards and even if
+          it is marked reserved in several datasheets, it might be needed to set
+          it (otherwise it is harmless) so whether or not this property is set,
+          the bit is selected by the driver.
+        $ref: /schemas/types.yaml#/definitions/flag
+        deprecated: true
+
+    additionalProperties: false
+
+    required:
+      - reg
+      - nand-rb
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+allOf:
+  - $ref: nand-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,pxa3xx-nand-controller
+    then:
+      required:
+        - dmas
+        - dma-names
+    else:
+      properties:
+        dmas: false
+        dma-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,armada-8k-nand-controller
+    then:
+      required:
+        - marvell,system-controller
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+
+        clock-names:
+          minItems: 2
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          maxItems: 1
+
+        marvell,system-controller: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    nand_controller: nand-controller@d0000 {
+        compatible = "marvell,armada370-nand-controller";
+        reg = <0xd0000 0x54>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&coredivclk 0>;
+
+        nand@0 {
+            reg = <0>;
+            label = "main-storage";
+            nand-rb = <0>;
+            nand-ecc-mode = "hw";
+            marvell,nand-keep-config;
+            nand-on-flash-bbt;
+            nand-ecc-strength = <4>;
+            nand-ecc-step-size = <512>;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "Rootfs";
+                    reg = <0x00000000 0x40000000>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/marvell-nand.txt b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
deleted file mode 100644
index a2d9a0f2b683..000000000000
--- a/Documentation/devicetree/bindings/mtd/marvell-nand.txt
+++ /dev/null
@@ -1,126 +0,0 @@
-Marvell NAND Flash Controller (NFC)
-
-Required properties:
-- compatible: can be one of the following:
-    * "marvell,armada-8k-nand-controller"
-    * "marvell,armada370-nand-controller"
-    * "marvell,pxa3xx-nand-controller"
-    * "marvell,armada-8k-nand" (deprecated)
-    * "marvell,armada370-nand" (deprecated)
-    * "marvell,pxa3xx-nand" (deprecated)
-  Compatibles marked deprecated support only the old bindings described
-  at the bottom.
-- reg: NAND flash controller memory area.
-- #address-cells: shall be set to 1. Encode the NAND CS.
-- #size-cells: shall be set to 0.
-- interrupts: shall define the NAND controller interrupt.
-- clocks: shall reference the NAND controller clocks, the second one is
-  is only needed for the Armada 7K/8K SoCs
-- clock-names: mandatory if there is a second clock, in this case there
-  should be one clock named "core" and another one named "reg"
-- marvell,system-controller: Set to retrieve the syscon node that handles
-  NAND controller related registers (only required with the
-  "marvell,armada-8k-nand[-controller]" compatibles).
-
-Optional properties:
-- label: see partition.txt. New platforms shall omit this property.
-- dmas: shall reference DMA channel associated to the NAND controller.
-  This property is only used with "marvell,pxa3xx-nand[-controller]"
-  compatible strings.
-- dma-names: shall be "rxtx".
-  This property is only used with "marvell,pxa3xx-nand[-controller]"
-  compatible strings.
-
-Optional children nodes:
-Children nodes represent the available NAND chips.
-
-Required properties:
-- reg: shall contain the native Chip Select ids (0-3).
-- nand-rb: see nand-controller.yaml (0-1).
-
-Optional properties:
-- marvell,nand-keep-config: orders the driver not to take the timings
-  from the core and leaving them completely untouched. Bootloader
-  timings will then be used.
-- label: MTD name.
-- nand-on-flash-bbt: see nand-controller.yaml.
-- nand-ecc-mode: see nand-controller.yaml. Will use hardware ECC if not specified.
-- nand-ecc-algo: see nand-controller.yaml. This property is essentially useful when
-  not using hardware ECC. Howerver, it may be added when using hardware
-  ECC for clarification but will be ignored by the driver because ECC
-  mode is chosen depending on the page size and the strength required by
-  the NAND chip. This value may be overwritten with nand-ecc-strength
-  property.
-- nand-ecc-strength: see nand-controller.yaml.
-- nand-ecc-step-size: see nand-controller.yaml. Marvell's NAND flash controller does
-  use fixed strength (1-bit for Hamming, 16-bit for BCH), so the actual
-  step size will shrink or grow in order to fit the required strength.
-  Step sizes are not completely random for all and follow certain
-  patterns described in AN-379, "Marvell SoC NFC ECC".
-
-See Documentation/devicetree/bindings/mtd/nand-controller.yaml for more details on
-generic bindings.
-
-
-Example:
-nand_controller: nand-controller@d0000 {
-	compatible = "marvell,armada370-nand-controller";
-	reg = <0xd0000 0x54>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&coredivclk 0>;
-
-	nand@0 {
-		reg = <0>;
-		label = "main-storage";
-		nand-rb = <0>;
-		nand-ecc-mode = "hw";
-		marvell,nand-keep-config;
-		nand-on-flash-bbt;
-		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "Rootfs";
-				reg = <0x00000000 0x40000000>;
-			};
-		};
-	};
-};
-
-
-Note on legacy bindings: One can find, in not-updated device trees,
-bindings slightly different than described above with other properties
-described below as well as the partitions node at the root of a so
-called "nand" node (without clear controller/chip separation).
-
-Legacy properties:
-- marvell,nand-enable-arbiter: To enable the arbiter, all boards blindly
-  used it, this bit was set by the bootloader for many boards and even if
-  it is marked reserved in several datasheets, it might be needed to set
-  it (otherwise it is harmless) so whether or not this property is set,
-  the bit is selected by the driver.
-- num-cs: Number of chip-select lines to use, all boards blindly set 1
-  to this and for a reason, other values would have failed. The value of
-  this property is ignored.
-
-Example:
-
-	nand0: nand@43100000 {
-		compatible = "marvell,pxa3xx-nand";
-		reg = <0x43100000 90>;
-		interrupts = <45>;
-		dmas = <&pdma 97 0>;
-		dma-names = "rxtx";
-		#address-cells = <1>;
-		marvell,nand-keep-config;
-		marvell,nand-enable-arbiter;
-		num-cs = <1>;
-		/* Partitions (optional) */
-       };
diff --git a/MAINTAINERS b/MAINTAINERS
index d7d76760ef93..9b165112be3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12344,7 +12344,6 @@ MARVELL NAND CONTROLLER DRIVER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/mtd/marvell-nand.txt
 F:	drivers/mtd/nand/raw/marvell_nand.c
 
 MARVELL OCTEONTX2 PHYSICAL FUNCTION DRIVER
-- 
2.17.1

