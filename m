Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20265CABB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbjADAYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbjADAYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:24:38 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0341E1659E;
        Tue,  3 Jan 2023 16:24:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3XylmOoqvIKzVxJnYEhE1gJUm20y0pkmeqF8kczJFV9JaeW0DQbV26jlq88Xi8eJ3uC0sn+MLulKIUbFC0cZSpdLw9vP+SjI7ioinsoeGh8cE7fdo7zMiDFI4OvpoklKSlO4WocDBE+3xztFnRwI9xlp60MODi8KE/Z5Bl8GlsfwEaM3e807yl++/98zto4pVQs5nRCuqSiUXMK9QE9tvYUmWyi3NdIhafTpdv+Lm/8ixr8fahvoIgFyC5qtEAIWdDSqpLPsRjvUELKzpRTPGX6QAIA5XkKpaOqAgmObM1xKH/psLQeCaN/+6AD5w2EARidu3NAR/WG3rfJq801CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihccjyYLR16yHUHyOzTMWCsE9VR9eEzXSY89IwoKTRs=;
 b=j2sVSEMZVNSP8wqWy2qccfnX7lwm1maJUed82E7fOp/XF2Nq2bmFRmbdPpTjqlBtezwhR41DJtymrmM1HcIvt8aFimTcnQiyjQzhPfVXLOHhUDoR8U4jNO3Rb5VcDKiQRH1zOd1hJAG1zio89b77hLFkKImroPImc3aajpMZsBALaTE7l4AlEs102hUQIqXrwXpKdwRaSxzYupd0WFJ5KEq8jYZXhIAeOxLkrHVMDsayU38iOo04NAXcfwPaTono2ukk9TanHWGBsXwq9PN0NICOc/nn8Zlch7TTDr+dZecfSFnptLUuve1t4QEF/aY/2uH+ITC23Nj5+BedK0nFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihccjyYLR16yHUHyOzTMWCsE9VR9eEzXSY89IwoKTRs=;
 b=Yn0BKOlYz/GvQQFQQa4PdhAbU5+CzaxMghKO2wBzv67akcbyrtpd5/7XMd8ADAkVWgRMHWd6o5n14LbpDxuguxZAbWCS8NZl7gytyapu+riO9xF8SbCWl1WQqVh8PAp2no17010HcOD8PWiUMy0kyJ5eA8me0r/pZGFhBW7fbuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:24:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:24:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V2 1/5] dt-bindings: soc: imx: add IOMUXC GPR support
Date:   Wed,  4 Jan 2023 08:25:41 +0800
Message-Id: <20230104002545.3473598-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
References: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: e77062c2-0d0d-4333-2fb7-08daedea0df6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLAv+/k/g17jBQUzOQKEoOxoTNnafXmuVX+ENObrUZ4pvmDjxUg7smA5H26OYCeLP2A/et7DblCvAi2TIg7I1iV1PYzVas9H8T/mvpBVH6Cj/51a2tAzxhwQr36axapzi+l9KbrFoaTPf+NeWBvi2zOgE+yw6fW41ZGYCmaQwOyRBIKKdkPoz5s8ww7HA4VDK7pRziulpFg0NTn3ggZQwYmeSZWF7pKCEZuLkqvgWah00mg1sdXMD4/XQjHTJ4kQdYSDdXwbwtj7YIeFRw2uLo5XgRltTjn5EHbr6MkfT4mrCYyNqhgj3X2nXgmT39kn/O8ZZ4r3390BtpH+6FqO/C1nVQuhIh98B5ytprr7BT6Ykl/9l1Hp+9ZDe7B6xM7LuDLD8B2zllvFRgL2MMcR5mBxIQC2/URV6T5g3VV4RC3uMIOc1XX41wwW6P8wSm2YeYoQT8VB4s4848SPBiLQbm9McATGJarockSxRagaLCvVX9RrXlqcVNOAvpM3Ew/OvOp0Mn3wKVcc86ss9Em8hgQrPOSx2yg2pGaWwEaCo1XWWVCgxZz4SmakIvE2oq8kYWTqMC24Joqs3hvcVEQPGBXORrUYBbYZ3SAVdfjGDUzQIxaCq6j2yYBrBKCQ7vD4ESsYpQxGJRerU8e5r08PjnKIQD8AJZkXq4AMW2+7aW9GfVs6mVDqzHF47t9e0g0ib7AC+ZceA686UBrb8UTZZpVAMjoc1vWcR8sau5kUCXGvWMy6jNTFzWfMHwNe4fr1ZaZM9/dysWJe8oNNbvFxvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(26005)(186003)(6512007)(1076003)(2616005)(86362001)(38100700002)(38350700002)(54906003)(2906002)(316002)(4326008)(66946007)(41300700001)(8936002)(5660300002)(7416002)(8676002)(66476007)(6666004)(478600001)(66556008)(6486002)(52116002)(6506007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nci5VVL6HOz95wG12YUvkitK+op7z6Yzr6QA2xOA9/ZuaJIb9npUlhgT88cv?=
 =?us-ascii?Q?rGMg2DgdTTOgqZBTUossnZyzsai6LCKlBtT80dz7O2uoYIROA8KZundAWt7n?=
 =?us-ascii?Q?ImD4tZx4zWH+BlGtSNg76kEuP8scFxcgTKTBBY9zTUlf0uRJAeLKowgyQ9aO?=
 =?us-ascii?Q?AcAANE+gQSgBGgXNVaIYh+vQqqKS5wF1IBHrfWtvcth3PnlrMXAblZ9NlpOF?=
 =?us-ascii?Q?WoHmcu4UhWDMXPF7mcc9VIdVnv2PXZEOhUK8Uxq8QC1aZ5qv1CvewnuYnY2/?=
 =?us-ascii?Q?JlEwWS205fABMWCA7ythNZ2g00/LyeW6cYIHSLg9RSAsPGH6CisZDS69mWNm?=
 =?us-ascii?Q?N02Yg8n1DCXJsNlRraOnljpN8fgeRiNAZtna0dy/EDCtD15CTcZ2eMFwHqX8?=
 =?us-ascii?Q?0vBrj/cFV6NcpblwiWiv1EMb40WdUI8nTkFWvArjLgnAB+HGG7nU6EgVq+0G?=
 =?us-ascii?Q?u2OUuN3cuB0qrFt+tASK8UL4Rj4zRY0F4YMnm6xBal0VnyoYyb/8Hw7314PX?=
 =?us-ascii?Q?y4Kd/K7tmTIJn7MkZjuKAbB4s3JUeerLzO5DdCzGq7qU969EOb4tDKt3mS24?=
 =?us-ascii?Q?MOSnSQSd4lZ65Bymh8AAVbWyxebBuMW3I2vwfPYncQbI9XJNLgSt359IldJn?=
 =?us-ascii?Q?cqFkc2TlTwtDetnDmOTlJSr1ZMjsoRj5ejiIzZpymlt0D0iBZ6jIS7GVekQG?=
 =?us-ascii?Q?Cb/zh26gHXwO/wObBb9qsDRNqNijsLE3E1LOO/a3GKUihyIVebIx/i12B2Za?=
 =?us-ascii?Q?jF0sBvev1l5JzGfEmVZgBFgDA5a2Ydl44CLuxoWLml5sbZ4h90CzgLe3e1Cn?=
 =?us-ascii?Q?QK0aOEy2mgdCbxfimP9njKVEtYZ0RymSPGjeKW9lyCxtz6f09l+osfCuzmO1?=
 =?us-ascii?Q?zNnSjDs5skaNRrb3eVf0IeLmeatktaNSYPbJaIZapwD/GP4kwnGOvhdTZhko?=
 =?us-ascii?Q?Ajnot6yt5XGqOqrbv+1PUCg4ZQDDYREojB80wZNZo6fA7CSEqOnq8lCCvFiV?=
 =?us-ascii?Q?0j6CcUteB+astO5K5mS8xKubbosXDzuDeszJfq7kn9/kHHWBAHIuznCZQvFc?=
 =?us-ascii?Q?HF6o8U6GU7RZyKH7HCLmWsZh633EfGis1c4Vn/Qw6BmUS7lf/QpIr7CkNMgx?=
 =?us-ascii?Q?2IqN5Rx5hHdb5WhINpCh+LoCJk3YE+p8HTBadaUs3UkyJiydROo93/NgFAzE?=
 =?us-ascii?Q?PKU/661yNDeMcWIEqPR5J+52FYtBHAX7/wJAyBYyv7NW6gAglWxOurEShdHe?=
 =?us-ascii?Q?hHgjuzmWeenT8HIDk4mrGoO7N05am3wcnYdbQ4PxI/R1HKkR2/yCxTdBISLA?=
 =?us-ascii?Q?6QeC0irQAJpyqNturuIzeEbH6vdtEDZPgFAzFQoEk3O6/8ctvvyvT1bv6RF6?=
 =?us-ascii?Q?oKPODUlJFwz7TMAk1qLDeyn92vMhiJHj/VPnTcM3RFnaSnRIFAvsJL0HEquB?=
 =?us-ascii?Q?bnhUloSglzaj4GoYUM2xtPZ4Wm6rBQ7FDA5YwaSyzzGQcKVUB237iH159y8h?=
 =?us-ascii?Q?07QLKRKpzSIgAe4LwpzE7d+Tk6b89SBIgDLCOAaes3VkIOPw6+nnE0LrGNnF?=
 =?us-ascii?Q?FHu0+Gtld1QKKN3STnwANHI4RPscSxETnqzpUkWK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77062c2-0d0d-4333-2fb7-08daedea0df6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:24:34.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY4GGYnta/OtTP8+yN9C0Lj168cBl8eglNaJGuXjoFx3a7On2zoCyzs6Csz6KOyKLCmern5jcA2gTfFtrKUFRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add binding doc for i.MX IOMUX Controller General Purpose Registers

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml  | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
new file mode 100644
index 000000000000..1da1b758b4ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale IOMUX Controller General Purpose Registers
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description:
+  i.MX Processors have an IOMUXC General Purpose Register group for
+  various System Settings
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,imx8mq-iomuxc-gpr
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - enum:
+              - fsl,imx8mm-iomuxc-gpr
+              - fsl,imx8mn-iomuxc-gpr
+              - fsl,imx8mp-iomuxc-gpr
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  mux-controller:
+    type: object
+    $ref: /schemas/mux/reg-mux.yaml
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  # Pinmux controller node
+  - |
+    iomuxc_gpr: syscon@30340000 {
+        compatible = "fsl,imx8mq-iomuxc-gpr", "syscon", "simple-mfd";
+        reg = <0x30340000 0x10000>;
+
+        mux: mux-controller {
+            compatible = "mmio-mux";
+            #mux-control-cells = <1>;
+            mux-reg-masks = <0x34 0x00000004>; /* MIPI_MUX_SEL */
+        };
+    };
+
+...
-- 
2.37.1

