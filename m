Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A45B500E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIKQhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIKQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:37:32 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FB31DA43;
        Sun, 11 Sep 2022 09:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M307jJ1SIm8A6YiTFwfkE8HVFbScsfXQCAaUUTyMaPSpSY+7lzX8+pxgaYHWK/LizyXBruXTriD+ocj2kkpIX2sDYAu67BnyszgTvAufSDNsxrMx8c0bUtkao5QA9S9CxwmW/aFag0hmsCLNZp+/1fX2FjZlfPUVQ0GbczWiMk/6Wry6gs9jPeDWniSKxJ1pNaqIHhaeSFNYS6gdRkasl6gFB+fN0i0NbaZHTsbEMToURNFjl/dLLUi3e9exXMS5iX0VawDvdHj/Am2u3UF8D8B2zyqvCEVDDY2tFY/fkhsuA+RSbyw7yHP2E6qumRnlTuWgwAWpOGLl8qrERj5aRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XHg7CVXiSGf5dv5bT3Qa+OvmKE32OCncNupMlzUlQI=;
 b=kdIxWm0B9GRTplOzsH9E1qgmxbKAU/pEC+28plaOFOiEwZLcSG1A0dj0dB6pfoqovoFG7EbVKhX94JA8jxv5CnjRLB2Da+GkQ4T65u/EdKyIHFew6RLgrM6J90yKNxnTlEXHWD9H1wN37y7IFT1NiNevVRBJWLs8Ubyeg/CFPrwuuzK20Z9tUpDwt47Pd1apzCAEuBt8j5RZaDjRYn2IlTUr8kHiQ5uQv/o0mY57nToFJZSOat8S2QR38Ea6q+Egyv5bG2GezPzII8mutvvYtrQgN/NmwmGpwrP3+bifUu7o8OaJkuurI2NercYMwqIpxTn/rDgfqfxr7KtD3lAuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XHg7CVXiSGf5dv5bT3Qa+OvmKE32OCncNupMlzUlQI=;
 b=B0y1CmuchbwrX+8kgoWat6NXI0NtLPiCVSsbagi1l5wvZm2Eu5QdeAYnCzSjPjdiM6yUtuVIDG0RP7V2/alGMuOtRqy3gkLIGG2ipcqzvETbO7w1wLU0Fl04awW0pPLYaMcf7FoaIX9rT4X09pXOHTS+AoxdcnTP3hK/c1/lzs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BLAPR10MB5331.namprd10.prod.outlook.com
 (2603:10b6:208:334::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Sun, 11 Sep
 2022 16:37:28 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::38ee:4bfb:c7b8:72e1]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::38ee:4bfb:c7b8:72e1%7]) with mapi id 15.20.5588.020; Sun, 11 Sep 2022
 16:37:28 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-mips@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 1/1] dt-bindings: phy: ocelot-serdes: convert to YAML
Date:   Sun, 11 Sep 2022 09:37:15 -0700
Message-Id: <20220911163715.4036144-2-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911163715.4036144-1-colin.foster@in-advantage.com>
References: <20220911163715.4036144-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcb696a6-ffae-4f10-7225-08da9413ea2b
X-MS-TrafficTypeDiagnostic: BLAPR10MB5331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VDyO1Kn8zyaLYn6HYFPZcar8VUSyGtpJtYzBr+UMBK+USx3qGT+hhdJIxy2Tvf2pYWYc1fTjNtJddYyD/s6paBcRxWRVuBadZpSp5kc6ZHQzm+ss9QNLCCYVmZWDyxf2NeDDNpBTS7FbgyUbVYuW54RT0gkvP/owjO7X1gYo1lYm/bqK497suWtCar85h9q2aFJPQHhYxtJa0mvGuBH201KYEjqmV3ZRWEJqUrx+L5PMVq/NHKE+d4PZ/PX5JM6ugtOtNpGvPX69X7xPkilJy8iXAdpYOWm9CMpidTINbiEUBJ36mVGrGKA0re133ZzhuTxgO/hpZ3408xiPgt2Af7eHP01I2LinlhZ+rHzOMy61yukWZux2ppe7bFoYEVQA5pftg9vQreX+CKEg1C5pLMwPGH8eIW34h53Q4dx9BwWyCxB/Dw+AFj/avbETbB16YI2ZD4Sqe61JGh2eeXJ+l34ACBBa0468GsGR2JlCGXbM0VeLiHAoaPBecJbQGdj8CTVj6MORiVKgkqRg3YAQCBBP3EPvf8xUnqcUVnHvEpvt/vSXfYQyRzSInUA3poQHpmRfPh9NsbbElvp5u+IrSs/vqDfX3MgwlmUwQKcWY5pHp4CVNg+tSskV8yZFzH6D2pdHsAOZpEH6m3vSTWhGIShQPTf7mmpV6XA6GGKspa6+8X/NdFg4Acqz2T6pDXEDqmeJUozofQ2Iva/qPNlkYtIF7RV+Jet72NInew7vzn0HfBbSHLdcXQVC1SaC440HeYfuuJX5rbtF3QwpwNfmglXr82yErdPhgZM9aYPvpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(396003)(366004)(376002)(346002)(136003)(66946007)(66556008)(4326008)(66476007)(8676002)(6486002)(41300700001)(966005)(316002)(54906003)(86362001)(478600001)(36756003)(8936002)(2906002)(44832011)(7416002)(5660300002)(38100700002)(38350700002)(26005)(6666004)(6512007)(52116002)(83380400001)(186003)(6506007)(1076003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hKXFJp/71/sIjXNrQlWo46KNJIBD7cyBYAye43jEQjpEnGMmut7n1R9Hb/dV?=
 =?us-ascii?Q?RQcpnLQFgi2vEwCyHfP8YwfDiJTOnI1h/9LwrATk9FDTpRcxhlBJDP7Ohd1L?=
 =?us-ascii?Q?S3rqY9SUM7JHlEQ9EW12Dv/HAy+9Fsc0jdcT/kLM1qui1QDoYSg3Mf/EfvBI?=
 =?us-ascii?Q?bBSWilzxBUHopxua46V1jmD3lXT3/iKDEX6Yo1hDi1U7p0wopXwnsI4Rfdtr?=
 =?us-ascii?Q?l1+4AegUp44A/SM3tWWIwAhWzEcnMm0aXmKRorvfzlJQ+xgkFDHQxqbUmgeb?=
 =?us-ascii?Q?G68PKgKed4bYARrNMTEfKpJjkpdYPF9/G9iiO/o21AN3ryl4hQY4l+FVNYVL?=
 =?us-ascii?Q?TpygHwVkHdKI0BkLn5c9jayRNVsijwenCX3oJqeh4FOe9hyriXKE0RBAd3sK?=
 =?us-ascii?Q?z8hq1IHxtILEZsma/rnrlCnE2WkxfpyOa4EpaBR/XPEo89ehqeXdVhJVsSaV?=
 =?us-ascii?Q?lajtwYhwBlvsJbiBa0bF1F4OfFbnxskW1lMBl7zkslA9Sa6wScbP8amk2ywI?=
 =?us-ascii?Q?S0rsQVu0uTelthrJD/B1lShuoG+9UpEScl8RWaxXuMfVRaDRD9pocP35nAZx?=
 =?us-ascii?Q?3lApaGZWe/W6ea0TWN7JLSMnHBgqrQY42ZFkBFyd8bbxEBhsOdErPdZBzUAd?=
 =?us-ascii?Q?XeOOCPngGiQ+4gWQPgORcelbQHpr2LsCmZYTMn9n2UDJPlIOeyWQ6XKQMoiQ?=
 =?us-ascii?Q?MZJFvoYMqfj1Q/K101YpAQv07OOAfniDn3dQ/Bru4tOmMoy6MQwq1GJihiYO?=
 =?us-ascii?Q?kSfXVuA4N0+ngxz8by+SEFOoCCzw+5f9Q7TUe1cgGc1wWURu5Grz1rRAih2C?=
 =?us-ascii?Q?Ywbul4Xyc5fh+l998HLqm1PfCsQQuXx3ym6z2h2NynZqKxWKsH8yE95uWeX8?=
 =?us-ascii?Q?wntOpz3ey5Ylvp38rdB3xRGxQCJl9tOg1HkblrErj+Tl6Ww0OcZoxBIPzpYl?=
 =?us-ascii?Q?/x7NA8dasRkf6ehXRH1usX1RFjGmFBFsQ7mvc3NOem2G82NIUyGh6TJrsb7I?=
 =?us-ascii?Q?ndcxhGBgb+uNpptGvZQzHs7/iflxfh4NsCoQnNxcu0NQ9JtMt7K8ZoTM+Z6/?=
 =?us-ascii?Q?qcx8sTZeMSilR7tSDZYLxfvaS/W17cnPWqs64bXUx+Xlh8po8+MpAnkQ3p3T?=
 =?us-ascii?Q?NEB6Axr+JepF6Jbdm3Kck0CohUU4m1iYfeVzk0Hj8P6pXR/MrsawoIC2KCDi?=
 =?us-ascii?Q?fxLRuu6Yfxihe7I6OMSNqeD87l3CSgP1h2FmFaa+2AA64wIzU9NKUdWeC3v8?=
 =?us-ascii?Q?L7tmKYlGlUhvH7IcDYyJ5zAzMlX2tUUBWrfqkHlMeLpoXNV2QSEEvMbKrHy6?=
 =?us-ascii?Q?/6EsACOJS/uKenLJF2H4ZpP0rkKyuu3Nq3CfcISM4RNA/iZZPeExLXKyZc8D?=
 =?us-ascii?Q?CQZRT0PIlER2Wl+F3KaLU+/ywRPNNn2lLgXVu4+oTRzTSJS2tO9q2wT+RFzp?=
 =?us-ascii?Q?WVJSB6nMZhz6NMMJvGF8oLeCrz1MGEfuZcbAqvj2H/KcG4VQtBcSD2wVyen4?=
 =?us-ascii?Q?/9tfVnoscOPa2+EtjSGIj5Lf0MuNgTxDQl6C8CIeETQBEKciP2GRkq9DQngx?=
 =?us-ascii?Q?qjEygTploTdjNfj9Je5eC1YdjmMDaePu882WYCzrQyNREqCWHleIsSlpXvpO?=
 =?us-ascii?Q?hdu3EUv/Im+tI2CBaK9SF6Q=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb696a6-ffae-4f10-7225-08da9413ea2b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2022 16:37:28.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUkJyHHaWPm32/T25C747EhSZXsYlLcWu58THLdmVJhY2gK/tIXTPxLHpPv4HEkGhrHamYo88mxwx6OpsoUvXKrDvwYEVJgCEoci8TCaw00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5331
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the phy-ocelot-serdes device tree binding to the new YAML format.

Additionally, add the file to MAINTAINERS since the original file didn't
exist.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---

v1 -> v2:
    * new yaml file is now named mscc,vsc7514-serdes.yaml
    * examlpes != examples
    * remove "driver" name from the binding
    * remove ethernet port consumer from the example
    * add additionalProperties: false
    * remove unnecessary, obvious sentence in the description

---
 .../bindings/phy/mscc,vsc7514-serdes.yaml     | 56 +++++++++++++++++++
 .../bindings/phy/phy-ocelot-serdes.txt        | 43 --------------
 MAINTAINERS                                   |  1 +
 3 files changed, 57 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/mscc,vsc7514-serdes.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt

diff --git a/Documentation/devicetree/bindings/phy/mscc,vsc7514-serdes.yaml b/Documentation/devicetree/bindings/phy/mscc,vsc7514-serdes.yaml
new file mode 100644
index 000000000000..3169b873231e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mscc,vsc7514-serdes.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mscc,vsc7514-serdes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsemi Ocelot SerDes muxing
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - UNGLinuxDriver@microchip.com
+
+description: |
+  On Microsemi Ocelot, there is a handful of registers in HSIO address
+  space for setting up the SerDes to switch port muxing.
+
+  A SerDes X can be "muxed" to work with switch port Y or Z for example.
+  One specific SerDes can also be used as a PCIe interface.
+
+  Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
+
+  There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
+  half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
+  10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
+
+  Also, SERDES6G number (aka "macro") 0 is the only interface supporting
+  QSGMII.
+
+  This is a child of the HSIO syscon ("mscc,ocelot-hsio", see
+  Documentation/devicetree/bindings/mips/mscc.txt) on the Microsemi Ocelot.
+
+properties:
+  compatible:
+    enum:
+      - mscc,vsc7514-serdes
+
+  "#phy-cells":
+    const: 2
+    description: |
+      The first number defines the input port to use for a given SerDes macro.
+      The second defines the macro to use. They are defined in
+      dt-bindings/phy/phy-ocelot-serdes.h
+
+required:
+  - compatible
+  - "#phy-cells"
+
+additionalProperties:
+  false
+
+examples:
+  - |
+    serdes: serdes {
+      compatible = "mscc,vsc7514-serdes";
+      #phy-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
deleted file mode 100644
index 332219860187..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-Microsemi Ocelot SerDes muxing driver
--------------------------------------
-
-On Microsemi Ocelot, there is a handful of registers in HSIO address
-space for setting up the SerDes to switch port muxing.
-
-A SerDes X can be "muxed" to work with switch port Y or Z for example.
-One specific SerDes can also be used as a PCIe interface.
-
-Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
-
-There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
-half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
-10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
-
-Also, SERDES6G number (aka "macro") 0 is the only interface supporting
-QSGMII.
-
-This is a child of the HSIO syscon ("mscc,ocelot-hsio", see
-Documentation/devicetree/bindings/mips/mscc.txt) on the Microsemi Ocelot.
-
-Required properties:
-
-- compatible: should be "mscc,vsc7514-serdes"
-- #phy-cells : from the generic phy bindings, must be 2.
-	       The first number defines the input port to use for a given
-	       SerDes macro. The second defines the macro to use. They are
-	       defined in dt-bindings/phy/phy-ocelot-serdes.h
-
-Example:
-
-	serdes: serdes {
-		compatible = "mscc,vsc7514-serdes";
-		#phy-cells = <2>;
-	};
-
-	ethernet {
-		port1 {
-			phy-handle = <&phy_foo>;
-			/* Link SERDES1G_5 to port1 */
-			phys = <&serdes 1 SERDES1G_5>;
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 6705fb8bfd3a..806aba01e0bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13493,6 +13493,7 @@ M:	UNGLinuxDriver@microchip.com
 L:	linux-mips@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/mips/mscc.txt
+F:	Documentation/devicetree/bindings/phy/mscc,vsc7514-serdes.yaml
 F:	Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
 F:	arch/mips/boot/dts/mscc/
 F:	arch/mips/configs/generic/board-ocelot.config
-- 
2.25.1

