Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E624960BDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiJXWnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiJXWnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:43:23 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2102.outbound.protection.outlook.com [40.107.247.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D83B7D7;
        Mon, 24 Oct 2022 14:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OH8vKfiOVHrmRdbmorZPBoqtRf8CicMTvTDfyeo9UIivWQt5hatxvzgO0yBRMpz+ePnNRQszUK8e7Fceb1fwj8BVnW+0+f5OsDz9zQVU042hEyC+pS7LJ8hUW3NjveDxgt+3LVC7exkH8g0qXfqr7cgxAwnQDwWjILa1vOdgVpCJSi/vMcBFrBBW1sQCBGfTLpB+hAyrBy7ub60EBqyeatwGEZDXtrzoCWWu4YEwFHBVAgy4UXCmhhcsXNDhcKsKqphJst9qfRy2ZUgNq93JNiUKprCqVbTO5HQ6ov8JWMqJv8S6lMSTQDPzkdAUn4PosJ17e3sd8g4+Y1UCIJIfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0usoS+MO/+Wl3xKbE1dwzB1TrsMNHFYb2K3K3tbQ05E=;
 b=XeYBQvNoYUW1pcBmowW/CswNn3i1yn4tU97mQOrxHtDLIEdNTgRpBu8fF772SxFj06MB6nHg6d0quxEoGTMkYwA9n4/Korv3PNcZO28wpaiLHV+JjUvorse2mmwjjGyDP5NTfmUcEE7fZwa5SUSzAurVUKN1ZW6kk7/tb1HZIcZr3ixCEf3Zp3wK/UC8lFvBrF1KBIrR3JyBsIwQlxZS6w088cOOWDflb/PbMni3xZo17v1v4Q0IK62s4wWU4N7AS/w7MI6jKhDdNihWikiIjRWdCPrscGsC+scOBTCPMOdjw47dcuWwhbe9eLezISuwzdwAyuZ0PlVCewwHE/nWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0usoS+MO/+Wl3xKbE1dwzB1TrsMNHFYb2K3K3tbQ05E=;
 b=AQyEKj3tyWmYqDmUmSpMT4vg93o5sox/Jq2YYgJjdhYq0FLLE27gdpU84B9tMdOm8XiLtEHbLEGFfpRRhfnHY+ooh3My8dbRYHT3RxTv9BR0zUQog/0eP3zME7vA0er9cciRieAx9fCfBGn3O/VBqdC9bwTEBDtxKlPRRbqV56o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AS1P190MB1798.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 21:02:16 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 21:02:16 +0000
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
Subject: [PATCH v3 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme
Date:   Tue, 25 Oct 2022 00:01:50 +0300
Message-Id: <20221024210153.28852-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221024210153.28852-1-vadym.kochan@plvision.eu>
References: <20221024210153.28852-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AS1P190MB1798:EE_
X-MS-Office365-Filtering-Correlation-Id: 17376c0c-49fc-42f2-f64e-08dab60307d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9OzgRACLAWT/9n2pa22IyjIV6X8RTisc52MCLQ4I3SfxGLjwy9D4ErpVObazG9v5Ln4BRUH6YijHjcNZwGEG7hnmntBNKEFRjPTU75RbHP6zEko48OuazB3VkSVKYSS15gxZLHR3TNiBD+v4WjI+msbVoMjVEek0poGa2OCUVHJATioPPKV51rNsZpsdzDEsCuwHqlHEbMO6yPRuQnSa3+L0Aj3cPaCtiG1oJrj+wTeZtPZGtiXrGAv2GgxOo0guOusgz+kU3La5C5WAie39nYeAen2KVL09L/a32Mx69yJ7H+n9xT5q3KFZZh5f1jdIr3rnzcHoKhY5D3gEHKyoczSxDBqpnlm5PEQtPwdF0tcANNgYLhEqewAC8xLkQFfSvLfV0SLBgMtIftWtlh1Ghg+ytniHsrgeEgbatUEd1HPCjD8vCZ6myNm0FIRCViEBhLmN/NJT5v+BKeGmfjz9YNY8dbZatA7Ijh7n42vLEhU4ZUFlLPdD9pOIZ8QzUGqnSxajPrulrZ4k61PleSCvHnwJzNNfA11XJcpnVg+6WwUeLzGy2apuG25ZU/xCAkad0+i3dAtKw04NIOI/pErElpEzwS+2to6j3b9Yg2qOEjR554745JNUOYXjulVl+Zfo2ygN7llrHNNNyAuDp8gxCCU9j1MJ/MH6orOwuPUJCymjn07JSw91cxHQR13gFyXO6L47wvsCfwdnPJ37UUoo0MonnGlS2MX2lRm1q6nnDDemh3QNAdQ43r7o9U4wEO0TI4Qs1gyyr9G6IwsTtfo2rD19K5A6RcjbMfcJHJUg6HWCWqkUl12pjYfB/8uTWznp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39840400004)(346002)(136003)(34036004)(396003)(376002)(451199015)(4326008)(54906003)(8676002)(66556008)(66476007)(66946007)(921005)(110136005)(316002)(5660300002)(30864003)(7416002)(36756003)(8936002)(41300700001)(6506007)(6512007)(1076003)(52116002)(83380400001)(41320700001)(186003)(2616005)(86362001)(26005)(966005)(6666004)(6486002)(508600001)(38350700002)(38100700002)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aUehvqQM49zhCXk4EQzOUc6ihVUDnKD4snAhk+S+EaA/FWQ61SDTFS/OWwyp?=
 =?us-ascii?Q?F2tTUF5w54Oz4X4InSml+xUhZJBtCKCEWM7Jy6aW3TcheEV4SiQqaEXh0EK0?=
 =?us-ascii?Q?ak+Etvv9TiwE5gEoz0KMsmMt0u4UjsRf1CjHmkkWmTmvfHcdd9eE/F7rPHtc?=
 =?us-ascii?Q?x2R01YrUMa+VrjppSstakJETGudhPpAgJqn2v7g85nh0Jcea7RVKsqOEeFNH?=
 =?us-ascii?Q?Welw+Yw/DGk2CA69vjStK1ReA1QmA5B87727uMPafiXnh+5cisG2/7ywaajp?=
 =?us-ascii?Q?Ji3/DlngSy60734ZBhC21JpVfkYe+ywxOWm/i4Xrn85nAaOmR92A8Bs5+7bd?=
 =?us-ascii?Q?hBD6s1eVMbsVbbu6VBWh4bgYVSpqgCr3/9+YMzi+1CBpQgsgz4iGkUfOusNX?=
 =?us-ascii?Q?UnsWuhBLRNV89cDVDCJ3FNa95GSqBnJH4G9wKbG+i8S9HrD/Aj/3VNLyGzng?=
 =?us-ascii?Q?DpLc+RhuX21kPK+ogeIUV7RoujxdETXfob1uv2huRY767IImwxpzti0c/iov?=
 =?us-ascii?Q?hueVfde/FzTjenqW9leYCE1gnIV7OdERHUScMPVqcZ4CFthmwFJ9L+BFo2IA?=
 =?us-ascii?Q?ttwsowfZ0OgIo2rMxmeXQwRpTl6FC9bKt5h5cXi1gOg1wgUWnVBP0ih3EbKh?=
 =?us-ascii?Q?v7jpGGxRTkTnWkf4IAYuBNf5CKf4LLL2OSTjK2G8XRA1TrAyEEUO58ZJmx6E?=
 =?us-ascii?Q?SmtArYAZoBzp8ibey3LIuUy2Hcwi3ayNi83tvcO6a8YqUWgti3odnBEtjD+w?=
 =?us-ascii?Q?/tdCzSIlGe2MRpmadFzG4QwK1GHidSi2pbccyfuJ5roCoRS1el02XLsptmwu?=
 =?us-ascii?Q?8gF1tc5N8oyZOpHmXGLoQTcYVoWA2HTaH4Oo+n9WX1k6dVlJWwLMAtbOJ5p2?=
 =?us-ascii?Q?l5WkpiY7OVj7nMPWncvPtOay1iz3AZNlinphqWyeoZVVOI+nk0PS8xNDbmHb?=
 =?us-ascii?Q?e5UNwv0ca27+RnI2Jmc9s5kHgEaYNW+NrwcuGRClwe+FeJnl+p19oQihH5vs?=
 =?us-ascii?Q?zl2fVWZFpVKvKFCBGHtI/VQZ4Gf0LmZI0hGlbvppP12h0hCXUOTTN2+YJmYz?=
 =?us-ascii?Q?DRpx3/bbRuAVa220JL6V3PyDOZt40VmgU1Jqs4Bd3E/RvldDJ240LVLlrNCF?=
 =?us-ascii?Q?HXbNNO+s+azu+UmyF/tjwqyivwaw4kH65R/iy1q/k3hEhHzpk/jdR0rdwSrn?=
 =?us-ascii?Q?/W8awSIYREFxQP1YXa6SAQLcrW1OwSVv8O32umOSDGfM9Ui8OBy5ee/N3iU3?=
 =?us-ascii?Q?EiAo7mjLrJ4gjbsmWhh9TOhAx9OcvapLbCqrAdQI8w0qkRUrFJkJl/tjeGsg?=
 =?us-ascii?Q?EAnmmwExIdiBr/xLGc601FpocJWjJ41V5JxO4p0Fem10eKBjDFeqFnWmGuSs?=
 =?us-ascii?Q?CfKH+cqyekh1RFHluj0zapvcyEHoW3fs+aaT3rM+mpk154kBeYvIA++CzGlj?=
 =?us-ascii?Q?Z1CzvVY8gLz51r0Cs+lekRvpvhWDu0dNokxo11TNnR315bqrCN42jIBMi/SR?=
 =?us-ascii?Q?+vacQXOYdY2bypHYxmIbkm44b37xTncs8ihBj8XHuQ7pFwvvhVpqqiQr2LU5?=
 =?us-ascii?Q?MRpX1ILZXkvwm2AIgiFj1dP09KMzKk/1L0rikHprtMQS/kvUWWhprDndGxL9?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 17376c0c-49fc-42f2-f64e-08dab60307d5
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 21:02:16.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/kHe3rNTW8g4XnDUcbZGFSdSWF9/H2/46O5jWJzRxLqKpU3yJI2H+fS8+6O49wzR+VQoWR4zZgzZgX9oh/Z3+YWLzRk8ETqqwHQIiYGGBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

 .../bindings/mtd/marvell,nand-controller.yaml | 189 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ------------
 MAINTAINERS                                   |   1 -
 3 files changed, 189 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
new file mode 100644
index 000000000000..cb20f14d4aea
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
@@ -0,0 +1,189 @@
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
+    minItems: 1
+    maxItems: 2
+    description:
+      Shall reference the NAND controller clocks, the second one is
+      is only needed for the Armada 7K/8K SoCs
+
+  clock-names:
+    minItems: 1
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
+        $ref: /schemas/mtd/partitions/partition.yaml
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
+    unevaluatedProperties: false
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
+    else:
+      properties:
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

