Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C676C3579
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjCUPUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCUPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:20:16 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F1C8694;
        Tue, 21 Mar 2023 08:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8wDSpWAelvCo9u4gdqvl7F9qVan2RhJmdapHMBI4AgF+4VUSlW5VPD0veq/wfctveDsgHRiu/XO6EE6y39E9n8tHpRMSje8T4TMyKv+4oZ4Dk1ktTbx2JmZhIgHjUdQwjqOU9FdziLx00kqkVVm8skPls4gekOFUBMgtRNmaWQPIekhInvmFPyDCstKxj/iJ5RC996SwTr7bNHl3sfrQn0vEhs2DDq56Haj9dniId3NHj2DfOjZS7w6kkD75PxS79bsbJNaU0ToQcjrj1iMBCur9bR469qXY5iW4G2N8q4aFePkk/TNxU4uK4Q6LFL+FJD2pf5uZL6tmjwwKE77hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbEV+XTNDWDhovZ1pgUh5UVARFRluoySO3UdNU69N5I=;
 b=TAX6EIerZ5joeDktYZz0zeeFXxI1GjwnXF3FUftc7wBqF0XIBKJTrzU7nmSLzPg456oXEwGWTaC3IhPF/oN5Lss2g0RTb57IPOxIB4n3gWSXtV2DyHai3ei8xf2nLzT41A6Qp1bNN2VBbZJYpIQEAG355iV2uVUGQgaOSds/tCLCsyPDqReFgEZvPRKtqJR4cZArLRpN0/flsYEOOe6ZkCydobQxnIPf8A/G825RAhgIMck7Ko6+HUTHlHM3/BOl6U/3wSss4XhUU2/cbCsljEbmIfJECX7L7Ji5GLrOjYSxZ9DB0iC/gNZ9u+/W3d9ic050Y+HKMTVDJl0ENvICUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbEV+XTNDWDhovZ1pgUh5UVARFRluoySO3UdNU69N5I=;
 b=NI3QGz21uehJtQu9KmtCzTRCIcuHiqqBqyzc3yy6729QAfzKwwDyVX8gc4xp9TBIS1tWPoFdxHgz/uA+R9aT25psCqiTw+R+BL2fTi8O+mSOQVKEkULZ8fX9m+ezTolQXVJq0U+l0muG+M7gZO87QxxZH4pwm8la9npA/blee2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8819.eurprd04.prod.outlook.com (2603:10a6:20b:42e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:20:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 15:20:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     devicetree@vger.kernel.org, festevam@gmail.com, frank.li@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue bindings
Date:   Tue, 21 Mar 2023 11:19:49 -0400
Message-Id: <20230321151951.2784286-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321151951.2784286-1-Frank.Li@nxp.com>
References: <20230321151951.2784286-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: c58fedf3-ddd6-4a3c-0baf-08db2a1fc445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkykXsbspKUn6M+c2YQM5aVz9chLJdBLXWaRUEd1E42zXAZHvDmov5Cl9Arm7OVNFWyT1Gyy/0cHM8TlxcVgVRytQNBULTu9A5V+J5UjCLN3XQn6IRBXO4R57Ry28wYIuwDKuXrQBrZBpQv9MO6yzgax/PDWrVfpcUV/iZalqlGxwLYYg90+g2AGIrLhMnsdm1W8slUB0W50CtCVUFbVBLdBVcgoCQIHG+hRRXl0eTLSy4fM+/B8T2dNf1zkTmumQkCcinQMvbJChB2NdhFYTuefmlSdyxm9kpdykUCi4G0Jy89GaCVZ7hc94gW9tt0hFeiJkrN/xM2Zx+/GYM/0a2MfDvFS77Gq3mHT9IjF5eqEs9455HUoSWeNxhWFuuipZK+af0oLo4/YhvB1dkyxEPWYVg0iirUuFyYBtR+XCc9+ai5v9si8u82q6U1A3LzQA6PAAvLiCp9DUuloXWVOKM/P48WIEQ84JKAuzRoPAG5FoRhF9zpidQYHCyOFvRu9BchjRnL/k+vZ/QqjYQmOlanGO3pIxWG5nnmLWWQw8eEZTPpZVCrHqfIhKzp8UhiFL7PHBEvkGM2DLMyCJ/zXZKShYF17e8gvorbvLywdwjQm7V5e/y8wEL52eW+bySqK2TFFEJ061T1UlHAIITMXR0JVDZmlvpVyHmkaVydzmPErgyE67eli15MGwfFdPA/QEI/IiU8DRRezgUFJhhmUhZBWKrH+YTYs5ExCjbInH6sQumsJo/frZwDPO5gcvxx0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199018)(8936002)(41300700001)(5660300002)(7416002)(4326008)(86362001)(36756003)(38100700002)(2906002)(38350700002)(6916009)(966005)(6486002)(83380400001)(478600001)(52116002)(6506007)(2616005)(6666004)(186003)(26005)(1076003)(316002)(8676002)(6512007)(66556008)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TebVjJN9sQfD87HmDR4F6l5LU4sr0abH2Fcmp4Ns7uJya6thy0+4c8bJe+8U?=
 =?us-ascii?Q?FG0lrJe9AqUPTdpfGiSqf67qXykp1aAqxpAIQBf1o+9pV8HXUgui97po84r6?=
 =?us-ascii?Q?OS1f3dSUc1IYCHK5HyF2SYZqE4Dv4TKPIEt87zYJ+Uvk3lYpnhX2V2LnTWpj?=
 =?us-ascii?Q?VXynnZ5XxfkyOsWvnqKMqxIBxCKkF7RQKPmPpMndqh/JCdxkTPqPrG8s+X55?=
 =?us-ascii?Q?LuN8EzL8EP+oukzSW+fi2K0/QegXoR/i1t/tcWfBnHZRM5gkTlS94IidwBWQ?=
 =?us-ascii?Q?7uEfOmKejU+ExQIcdjdOMkZtTZkytxOMxQNg8XVQjFziXLc1Tk5YsM9p5Y1a?=
 =?us-ascii?Q?/p87Q81/R+iH4yo12u6TMo2sT88I2/toofC0TP4ORjVp/cUFfQ6fVE29wSWV?=
 =?us-ascii?Q?D5qGezOCamE/cZoc+wbXMimm+y99YNIYfRUkRWSjvuGFPpmZha/D7JvhNOhU?=
 =?us-ascii?Q?pBzEX/7/aYaoISR51SabxkQC3JZtvE/5/5yIfF7h1lbtLQoK4f0sJduIFqB7?=
 =?us-ascii?Q?lKjPXS9vNwbX9cJO0Mgek7kBxtK3HVKK0UYoqFwQb5qHQYzhbFELEEanhn6N?=
 =?us-ascii?Q?Zy0rXU0Fp96cyuaMPzNGkdDADeRbfINZGdChZoAK6YJKbNWBSjdmpx0aU+aO?=
 =?us-ascii?Q?SRgPOphkKtaGjd2Fw+BhLq2D96qh3k47CYwXwjV56JUrnW4W+pvbNAj3i4Vy?=
 =?us-ascii?Q?9vhxdes6i7dqTvSzuDxOVSYaYvUiA9Xs5I6KWk3UudhHncoJgRrxcFCzgDIS?=
 =?us-ascii?Q?HVAcvLAbdAcnUTalzFCfa+xSXgAQE/QAlEKulqqa6J/3BOUjEXHu0TfwyKe3?=
 =?us-ascii?Q?haXviKl5YNZ1UGm6HZxGb7NrOZJsoDZsZ5tOSx8ezAmQcnNBNY40YByusJlx?=
 =?us-ascii?Q?soIfLjf8mzIbpPkPwY7lsGYOf41sHPg2tw8JiNEf3Gt36x4y1jXV+p/PQFQz?=
 =?us-ascii?Q?OMaFm+1T29sMbvByRkBGwGAtNGS1ARWdiIDJKiFuxufUAUw1bXjhI9z6msbe?=
 =?us-ascii?Q?+5z/pIKbcDyYHEvQf//TQtpq+piVOsYu9p8vT+Df3IN7f+y5gwW855sAw5c1?=
 =?us-ascii?Q?T1nSx6Lh/Pcc3Fcw1FebJ8cNasMny2okYiJkAZspBUWntc/QCwIU3ZvbTW8Q?=
 =?us-ascii?Q?ICULRLPwztI3GlUimJxW70foCk7q3yOEkL7yp8epIfDIeyxUIKSvkS5LS6M7?=
 =?us-ascii?Q?yKaaS6MuxkF/Fo9vLr99q0+rlTuk+rt8bMKfmNf/aTt3O+MeTg20Xtq2kRRn?=
 =?us-ascii?Q?Ls5Z3sP2JRMNDG96MsgthzC6yx3scw4acWnr/ToHwIVdn/mf9UA6OPy/jknW?=
 =?us-ascii?Q?6xX5yk35P+nIEBsSgELhhKpRcFmnGxaaDJZm9B+BcwOnuDKmhXZfZblKnW3H?=
 =?us-ascii?Q?xXxADvcReSMSNZBbFEj7Xy/txub8WtVJOXLecBl/EgyVsXPUmvUK0rqB7441?=
 =?us-ascii?Q?cqOslBAROgBFLBqH4jF9omqFKefpQiOfxt8o3xehZI1yCbuaB9Bsg6yy4iaV?=
 =?us-ascii?Q?jrlB+HVsGiONmcO2pQ6EdMygaf9lxqhyJkUix9MNG93JDF+vB6SNpJ5G2FUG?=
 =?us-ascii?Q?hcNMUrRwaAvVEObnxT/R8ZCj1/pJxUvYyKdIqVsz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58fedf3-ddd6-4a3c-0baf-08db2a1fc445
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 15:20:12.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rs6BHFw33oYSKcwMouV1It8ThEkDZK+uUSrz/LpwWHFvnZj9iujgGb2YQ4lMJr0fNog+G8u1mi3T4B14HKwAMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8819
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- Drop two fixed frequency clocks, it is system reset value, no need set now.
If need, futher work/discuss on driver or dts change. It will not block this
basic enablement work.
- Drop lable
- Drop some descriptions
- Reg as second property.

Change from v1 to v2.
- new add binding doc

 .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
new file mode 100644
index 000000000000..d876e3dab608
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fsl,imx8qm-cdns3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP iMX8QM Soc USB Controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8qm-usb3
+
+  reg:
+    items:
+      - description: Register set for iMX USB3 Platform Control
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+  clocks:
+    items:
+      - description: Standby clock. Used during ultra low power states.
+      - description: USB bus clock for usb3 controller.
+      - description: AXI clock for AXI interface.
+      - description: ipg clock for register access.
+      - description: Core clock for usb3 controller.
+
+  clock-names:
+    items:
+      - const: usb3_lpm_clk
+      - const: usb3_bus_clk
+      - const: usb3_aclk
+      - const: usb3_ipg_clk
+      - const: usb3_core_pclk
+
+  assigned-clocks:
+    items:
+      - description: Phandle and clock specifoer of IMX_SC_PM_CLK_MST_BUS.
+
+  assigned-clock-rates:
+    items:
+      - description: Should be in Range 100 - 600 Mhz.
+
+  power-domains:
+    maxItems: 1
+
+# Required child node:
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: cdns,usb3.yaml#
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - clocks
+  - clock-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@5b110000 {
+      compatible = "fsl,imx8qm-usb3";
+      reg = <0x5b110000 0x10000>;
+      ranges;
+      clocks = <&usb3_lpcg IMX_LPCG_CLK_1>,
+               <&usb3_lpcg IMX_LPCG_CLK_0>,
+               <&usb3_lpcg IMX_LPCG_CLK_7>,
+               <&usb3_lpcg IMX_LPCG_CLK_4>,
+               <&usb3_lpcg IMX_LPCG_CLK_5>;
+      clock-names = "usb3_lpm_clk", "usb3_bus_clk", "usb3_aclk",
+                    "usb3_ipg_clk", "usb3_core_pclk";
+      assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
+      assigned-clock-rates = <250000000>;
+      power-domains = <&pd IMX_SC_R_USB_2>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      usb@5b120000 {
+        compatible = "cdns,usb3";
+        reg = <0x5b120000 0x10000>,   /* memory area for OTG/DRD registers */
+              <0x5b130000 0x10000>,   /* memory area for HOST registers */
+              <0x5b140000 0x10000>;   /* memory area for DEVICE registers */
+        reg-names = "otg", "xhci", "dev";
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "host", "peripheral", "otg", "wakeup";
+        phys = <&usb3_phy>;
+        phy-names = "cdns3,usb3-phy";
+      };
+    };
-- 
2.34.1

