Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514AC652D53
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiLUHdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiLUHdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:33:01 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7210520BF8;
        Tue, 20 Dec 2022 23:32:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz9vwhvESFxVvlNb7O+WPBN0Su8iiilTnrgChzNZrOKqm1kfHS7QTJuy3c/dt0xLheP62gbiA5fv7TtXFmP1uLGTddpthNWslok4EocvFQJh3gC80JIOC+3QDsfMSAa/ha+i45FgEhfGd1zgnfykK3bwrD9dw34Zgcru0h/sbJ4VjxEAUw9YIbjNnsF6enSovZytpe6ps5xbxdOsJaE6n9qwYlhqcdrnUgvdcUZD/fAOPoAIamCsLtxgSIprAn4Y1ADcW+wrmiMCLm8EZqL6OXnCkxGHSzeyq9fqZg/iIJ9b0XwA+pXSVWzriUckvGF/lR9AM6OqhpEuIQrsoY4YhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbS7EpSw8QIkH6cGvTL2zZcek1LdYWiWENn+HPs6VKk=;
 b=lw7KEizHedGAK9hv2yn1HhYWSUamrm1w/C+HWP0K/sBGX9+KXmIo2A8rXUKfr+l1jXH4jWz7U0zLGQ27ePMH5upnvaHvIMc6R0jlUZT2GSKtt1zMIZbbVwTLXTewSP8YcYV7WlVU5F1LHiMvYFvddFOmeB66w8x+vOx3oxv34wd2lygCWx7ZR8NsV7ZJg+/fkxnwSouhWqa0ADjz14hl9KABTlwJ2o1tDZcVgKoMXl4lqV8Ir9d16+OihUBNwJYkIDJik8OQ4Sy6za3HcFbzbxbLn+7gtDXIqACpS3HmUfqk8Q6MSk2xzChAg6nkINiiZJarfTCoLVmkRuIEnyEkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbS7EpSw8QIkH6cGvTL2zZcek1LdYWiWENn+HPs6VKk=;
 b=S7lYX3RSsu+ECkIVCj2aIZ2iHmRXCiIQonkilc4MkRaqg5tx7FKWs8AKBFjDKOJZ6G+v9giUIoBQkyWXZJBXcUA/zRYNkQSDY9RwPcQmVo6Psu1CRF4AhuOsLrlJ/NBRqtAUuW2rASe6P4sEehUFvdVi6i3k3XQy2D+a0JBsmRwVR8FISg3+33608FJrjlPP+Y7TmnkVVUTxd3vlQL6L5VacaCQrONT1m7RkabZkmBOkPlKAOVMiFTttHyD4aJwrL6vC4mvopGuyiPt/74fYKZ19b3gska6rzCnL3MJlFQdSkh2F6Dlb7xqFpLqc30FNuCQAbNckJah5jULVTagj5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 07:32:56 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::9028:2d9e:dbd:b5c]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::9028:2d9e:dbd:b5c%7]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 07:32:56 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Date:   Wed, 21 Dec 2022 15:32:31 +0800
Message-Id: <20221221073232.21888-2-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221221073232.21888-1-clin@suse.com>
References: <20221221073232.21888-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::14) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU2PR04MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ad8555-826a-4428-dcc1-08dae3259407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6jrVp+z9u+RDkiCHN7M/7a1vVObc7VLwTiR+14YuHSyhIKOV+unPH84rfdInfo9DlED2uiUInjPa94SHGlS8WNTRnLOh/CmOPwWjk1oik5tt6+yWX36XvptkSep7RsvZQMmcao7tWKW0KJQ/0rLLIQdW2JA011CTkiamt61Yryab5BH8KuiEpEPfX5IbRp3pin7tUsEza+3b9zYHZgiGudemjxkjF43daR5ZonAXtMZypyFNk44SilfZpIu17zryShJmkTUdqVlnAlgXCSe3QTq3qP7eJcJF0Om555X7ksWIKoHKm1jKIz42EibNKxkpgSw2OcWMdMQ6I8OvEkgCpCxop51Zbnc8uu5hV4gEOfDVXfZku7QX8b2FCfMARaiZYGDAclX+HUKtWtbl6kf77UmZT/afP+KGgs4/aojSU8FrqoiCGrFQ+J4u/lrSDJtGxQfmRYgCaQvcq+c4aZTDn+Nomhm76NjwsfAfV4rQROLoQJEqbo8ty+/6yX6c7HfnSx6ziZ1oelaw7fGkYfNx1bkzjFIvwLZ9KJ3E8yWFoYp/phNkql9GOlzSCduf81YM8pG070+IeYt4z5L7VgPFQ9Yn8pcZUhgMsJQABcjeCZebefSdkFVMLBbwuPfpb6g+OPUevCDGFLjWK6fIkG2QPbs6Xh8WyDzqvip3pMNSXJfClce4H3MhiHmhBPGDTy8ioWtoKZdBlmHS0cuo47Usg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(38100700002)(36756003)(6666004)(86362001)(316002)(6512007)(54906003)(478600001)(6486002)(26005)(107886003)(966005)(5660300002)(6506007)(110136005)(8676002)(8936002)(7416002)(186003)(2906002)(66556008)(66946007)(1076003)(41300700001)(66476007)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hinJfejbJs8vNX5/rVmI6i6pdIoCH9se1pDig7YB04QDehdTOhcK30uRz5fy?=
 =?us-ascii?Q?W4unVtE4n5u2ky2qDm9YDyyGq5hxkEQNkzH6Q7vABlAc/7ex9I31ff/RF/qT?=
 =?us-ascii?Q?BB1bl7au4qxt/mDYO1D7N85krtCOxbXQcTY1uwFJjBD+VqK52/AeQEFLcait?=
 =?us-ascii?Q?TxyXlb5fgpxcRTy+Rf8KC/JE+VlmctOxPPvVp9nhWDjBMjrVld40KqkvL0YG?=
 =?us-ascii?Q?LMfwk9jGHdZvN+5wONTGCk/lmzCmHJOXBf5zIN3A70xEYdj6p/busJiq/HI3?=
 =?us-ascii?Q?CwuteWG7KCb5rgEflz4gl0XHx4EN+uOtuUWMx+5XIiejJVz0E3atJk0JRerK?=
 =?us-ascii?Q?N5xySXtrVG6so94+eROXlkKdQShh09CZ5LiAK/i7qMQzDryMcg0Jp7v+xNau?=
 =?us-ascii?Q?EzrM/BZbG4MimvS9kg3T0zQbqYOuO0ZzuavLq1dqK1EEdwyLiDgPujfAOlgP?=
 =?us-ascii?Q?C80P3IBglDwfiCu0/20eHPYvaeZz0+Ux+Bxq7E0pbmKJYCdZp7q9ZAtgJ2Vo?=
 =?us-ascii?Q?jneUqQN8SK/k3eBGpFNte2I4Y/+o+5equ5li/YbpCPOd7ckfN7A/+j9a7EYR?=
 =?us-ascii?Q?16aYio5CSz+i5HpNM0GwB446PrwZ3bhQY/C+j54HM6RzM9+QK7RJ52Qeczlu?=
 =?us-ascii?Q?WYkTg5lysIzcmcOvu4pVbp1LNkiK4vXjzChi5+FRiLMHjE+2jUY1hPKXBMri?=
 =?us-ascii?Q?tXhk9VTN1KOfbZtaWGA0d8k0wbVtq/ihPuqNiy+/tDPOz+zANG73Bj87rnqO?=
 =?us-ascii?Q?UkhXP5Gt0op7v/P7LQ/UUsiYsfxd/Pi9/ZsBs2sP//EJZtQscxoHHbyzft6H?=
 =?us-ascii?Q?gQGaYppfC+og6wU5uFvAkpMXVrQl8jSwSse8KI8QD7btiWx5hcSC2t7Lxdrt?=
 =?us-ascii?Q?x97T0WXkqr9abWgHuq3iYSMqzao8nqhnTX9enV5caHodbq04a1hGBogQgI4n?=
 =?us-ascii?Q?NM1MetkJ4tHpCcKBSSgajd3TTSSAt+AWmWD6KkEQBeNfkmSOb4AgU4D4NOsp?=
 =?us-ascii?Q?DONl6PJtCBKmX3dzzMQyiZMAgfajtcz8Pn5Ee+tevOB67ebP2cf2UJBQGzQ0?=
 =?us-ascii?Q?3DkoQ8hR6/n59AyVEa/DKw94xeQebP5KHjaIz6r/Vv1iVapu1ADdA45sGrTD?=
 =?us-ascii?Q?y+VIqLgKy+5cF3VGMU2et4UMvViLhPQvBR+1O2tuITbj2+AWq969g0lGpN7T?=
 =?us-ascii?Q?QslHHcI2272beCY/GV/ibyFy4mHxohZBdvrsMH+e0JINCJTBmiJP5n02V0dd?=
 =?us-ascii?Q?wulhWkGUtSjxIiHnbdb5I/jfaJN/2QosCJ39ciiKjJAPuDvjndimk7aVngqF?=
 =?us-ascii?Q?9klSSWi5l8oxATR1Z0ttO/TI5MLRfcXexzCpNQ21r5p4nnJN0PwXvaC4KTUR?=
 =?us-ascii?Q?fv7D3uzwC7mfHn2Ur16ylNco0NSqnnKuX0slpy980ZZJRAaIdqGSbtyhf9c4?=
 =?us-ascii?Q?9Dikr9aFYFfkCBfizxv6LLUedE5vJnjy/pof5J+8jqfPHqcbW0BLJ2UaLiQV?=
 =?us-ascii?Q?ybtqnmioKb0unzxWehSLn5pFWnZf/JU3vpEPB6iPZDCOj9bRTtv+ieXRcR1L?=
 =?us-ascii?Q?8T8MdmPFTvkLw732Y9g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ad8555-826a-4428-dcc1-08dae3259407
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 07:32:56.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPII98Jep2Gp8doVuS6j6+bBrBi0oREu9nImQc/T0+Lop0794gTS6dUvia95WtSE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT schema for the pinctrl driver of NXP S32 SoC family.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
Signed-off-by: Chester Lin <clin@suse.com>
---

Changes in v3:
- Remove the minItems from reg because there's no optional item for s32g2.
- List supported properties of pinmux-node and pincfg-node and add more
  descriptions.
- Adjust the location of "required:".
- Fix descriptions and wordings.
- Rename the yaml file to nxp,s32g2-siul2-pinctrl.yaml.

Changes in v2:
- Remove the "nxp,pins" property since it has been moved into the driver.
- Add descriptions for reg entries.
- Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
- Fix schema issues and revise the example.
- Fix the copyright format suggested by NXP.

 .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
new file mode 100644
index 000000000000..1554ce14214a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G2 pin controller
+
+maintainers:
+  - Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
+  - Chester Lin <clin@suse.com>
+
+description: |
+  S32G2 pinmux is implemented in SIUL2 (System Integration Unit Lite2),
+  whose memory map is split into two regions:
+    SIUL2_0 @ 0x4009c000
+    SIUL2_1 @ 0x44010000
+
+  Every SIUL2 region has multiple register types, and here only MSCR and
+  IMCR registers need to be revealed for kernel to configure pinmux.
+
+  Please note that some register indexes are reserved in S32G2, such as
+  MSCR102-MSCR111, MSCR123-MSCR143, IMCR84-IMCR118 and IMCR398-IMCR429.
+
+properties:
+  compatible:
+    enum:
+      - nxp,s32g2-siul2-pinctrl
+
+  reg:
+    description: |
+      A list of MSCR/IMCR register regions to be reserved.
+      - MSCR (Multiplexed Signal Configuration Register)
+        An MSCR register can configure the associated pin as either a GPIO pin
+        or a function output pin depends on the selected signal source.
+      - IMCR (Input Multiplexed Signal Configuration Register)
+        An IMCR register can configure the associated pin as function input
+        pin depends on the selected signal source.
+    items:
+      - description: MSCR registers group 0 in SIUL2_0
+      - description: MSCR registers group 1 in SIUL2_1
+      - description: MSCR registers group 2 in SIUL2_1
+      - description: IMCR registers group 0 in SIUL2_0
+      - description: IMCR registers group 1 in SIUL2_1
+      - description: IMCR registers group 2 in SIUL2_1
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '-grp[0-9]$':
+        type: object
+        allOf:
+          - $ref: pinmux-node.yaml#
+          - $ref: pincfg-node.yaml#
+        description: |
+          Pinctrl node's client devices specify pin muxes using subnodes,
+          which in turn use the standard properties below.
+
+        properties:
+          bias-disable: true
+          bias-high-impedance: true
+          bias-pull-up: true
+          bias-pull-down: true
+          drive-open-drain: true
+          input-enable: true
+          output-enable: true
+
+          pinmux:
+            description: |
+               An integer array for representing pinmux configurations of
+               a device. Each integer consists of a PIN_ID and a 4-bit
+               selected signal source(SSS) as IOMUX setting, which is
+               calculated as: pinmux = (PIN_ID << 4 | SSS)
+
+          slew-rate:
+            description: |
+              0: 208MHz
+              1-3: Reserved
+              4: 166MHz
+              5: 150MHz
+              6: 133MHz
+              7: 83MHz
+            enum: [0, 4, 5, 6, 7]
+
+        additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl@4009c240 {
+        compatible = "nxp,s32g2-siul2-pinctrl";
+
+              /* MSCR0-MSCR101 registers on siul2_0 */
+        reg = <0x4009c240 0x198>,
+              /* MSCR112-MSCR122 registers on siul2_1 */
+              <0x44010400 0x2c>,
+              /* MSCR144-MSCR190 registers on siul2_1 */
+              <0x44010480 0xbc>,
+              /* IMCR0-IMCR83 registers on siul2_0 */
+              <0x4009ca40 0x150>,
+              /* IMCR119-IMCR397 registers on siul2_1 */
+              <0x44010c1c 0x45c>,
+              /* IMCR430-IMCR495 registers on siul2_1 */
+              <0x440110f8 0x108>;
+
+        llce-can0-pins {
+            llce-can0-grp0 {
+                pinmux = <0x2b0>;
+                input-enable;
+                slew-rate = <0>;
+            };
+
+            llce-can0-grp1 {
+                pinmux = <0x2c2>;
+                output-enable;
+                slew-rate = <0>;
+            };
+        };
+    };
+...
-- 
2.37.3

