Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616C45FEC13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJNJuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJNJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:50:28 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E00D18EB;
        Fri, 14 Oct 2022 02:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvjBFcP9ganFehnddqJTVomPInysQdmAOjZscfeHxrQGSajlb/y1nb8PkTZ+BtTm7P6gGivgJEG2oXkW60t/q/N8a+XmzD7jyNgkfgS5ZrfLV+cRlgOlf4F9AzT4xKH3OPVU0jJrx8GxxgT4MrHXcGzCnJ4g/ARGcTzOeGYmVPUWxozV1OR7xR2bwWIkZLMa/EQmO9akPwixqP8vTIQRQEy8adeI/cd/KanEycI/SqdGruXPKfODZAkTPR9VgqQxCSOrfEgtvZgayh7ldLKGobNdbzDBAsIyP1SURHI6MWe4H/WFSYzW5FIdg2kStDN+nvx6gz+0R0/L5UdBH/a/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14m39rJRklmjYL3AUvpkkDBvgiZcRq1ZkHdfvlzthpU=;
 b=VjtC5eltvZmZS/ZR7lYvm+7Thg6nAffK3vMYFbt98U3KMM1yg/x5LrbuquEjVzyFYYOFa+TXKEouj9WqAQXJ28OzRdGlf4NfwLzSj6kq+KFdJF5zWHmYvtikCs8ajXz8lfNdBFt6SBE8RBBtpcjD+RUXq/fFgOXKt7GirUQtAFABWmjyp87txH7FlLEpKalBt+7QvGYGj11uiShD8KgbyiPDWFGg4+YwCet0nlQZPewehOnkRd/QrpQ3DEs5xqkvcL3zAvagWR2pXVktpOHGzLRBimvS19kdeXFRFvJ+A59G5PZCYO9oIu9jnSg+4BUmLsw+Z6zy0er60uAV1UI4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14m39rJRklmjYL3AUvpkkDBvgiZcRq1ZkHdfvlzthpU=;
 b=PsLjK0ySryBGiElxj6tqWP9iu9GW9Wsr+rx0qTjvg1OVR/PI3GNy/cSxdJPghESgWQc6WuLkZ//Ym44NsYZU4ummUd5yUuv++CRQlTAEHv2dzsZSrkMcPraNrY+vDTVgbfXVWwBYYLso2jbc2j6gXM2j0KyP230ulFTqQSC/4I8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 09:50:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 09:50:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert to DT schema
Date:   Fri, 14 Oct 2022 17:51:43 +0800
Message-Id: <20221014095148.2063669-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f20a0d-d74d-4830-2c58-08daadc9831b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+Apm11v1eAdnKoG0W8o81i8BHPUvNxfkY95xbxxmrDXbftuiF8eKrmCssN4flgEySf8BxY6LJC1nIvFlwTcnz53EPwMG6KoAgaMCyY/+GZ3R3qWhwcvjPQYQO+T5B9akKn22p1tP6VLP3wrMVoiqyfqjFWIxLefnjPWU3m3yEqZjXrcYn/KEKzQhKVShWhX3lPG0K2UBNpuOjWOQJhVAeI3t+hga4SBdNpox9JC0UA9DeHJNG1JaPFNW/GSCIYAs2n/Yy/fNSMh68KUM6XhKVJJzvRZv7feC4lDvmawKpLKgvxxiFkA9vMUVOOXEW1Av8Sv+DsId/1i3ub3ZrbCSLITnh8+du0wz9P/Fnm9ob2P7N/coz6cMuqMwEor957JEm6mDKlYvGiad8CG1sLbwWv9ITAiFXiy4bnVmlZcJds2PZE/1cuRk3fpnGnlshFxB/+jaMSWHV2O+ImduEpOKoKfQB/+ZUDY9plrjfKxheo99LV10D9GkhK+sz/ssKwuTtQCBm+Cfv8h9ETgWC+UR7VsO+BPkHHJH0GBwAirGpNZvuDCbknVrPeGl3QDsifdVQhE2kIHOaw1VTkJhR88yiM+y0HgazwU3Vv5u3FjB48nx7s4UAYQwqx1/Bp29CBj3FV7T4LtaXudp3kmg8KzCjSv7gkjn9ap9oEqwzOM0hewzAWFodtD/qz5ZimVs5h/PB8PVukYBRTYq6A71iXP/A4D17AKLcF4bxCyl8R1OlHTYpHPSCYLZEVeo1ejnjbUH4gkDkEQiFEIyTcPmeuzXutN+RdKIsFuWHHoKc7tkyJqm9n8YWIY+TBmrWp0pwp+kXTtdz/f+4emP3YugJgEuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(478600001)(6486002)(38100700002)(38350700002)(316002)(4326008)(7416002)(83380400001)(6512007)(6666004)(8676002)(66556008)(66946007)(41300700001)(86362001)(966005)(26005)(8936002)(1076003)(66476007)(6506007)(5660300002)(186003)(2906002)(52116002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b2hnLRXDXQt5GT4tvsiadYH/uQX/QdRnR9zOzpMmZ93hWaC+Ir3ES61M6u2w?=
 =?us-ascii?Q?S8ymlbgNi3/UlKetHxpbtg9OvhsC1BBUTq9yBvSpaib+/FX9m6ee7Wzkbp5x?=
 =?us-ascii?Q?hBtQTvmBM6yIbawTZBeay1tYxc5D4EN5PkTzGfK+aSFB+rWLJOfP6ZuXLeFk?=
 =?us-ascii?Q?AacX1RqzVVawrv5yzlc2msPr1q2ihwmhocy05v9jhs6kfHReMI/JYbuShIRv?=
 =?us-ascii?Q?2U9bitMaNB64jgVOTU6BiDjDhLsV6DfjVX1PTaE+MlhPljaDDF+7NkW21LwJ?=
 =?us-ascii?Q?lDmbE3dL3sLwTfXQ5EuN+2+fIoWyCY9YRCpk/qZfM2aWJuzfYv6jlhTaopSY?=
 =?us-ascii?Q?mAl0gY+MVaBBl6+6shms+yA/O+nHM2R6wOLf59Mx3Gzkl1ZTUlCnm7eZSPEb?=
 =?us-ascii?Q?TS6ZX+o98k/lAtHHnt80M2KTAyjamJY4CkPG3+A26LL3IXuxO0Tw6E2nxkXt?=
 =?us-ascii?Q?fNG/MKWgl+0waT3Au6WaC8GP+FFtGUp3Pvxl2FeWHqDWVfLDTlY5acVe3v93?=
 =?us-ascii?Q?vCRnDVaEt7FasPJN3dDYgRTdsRSC13UtTkZwXDFPwZvp/C/oWKUEhBZrskKq?=
 =?us-ascii?Q?Cp+X9hh4yScFLHOLhJkOvmfmr8ixPIc1m+r9aDoRhBQMKzmKZWmVwqfC0TZ/?=
 =?us-ascii?Q?kBXVhiDpTWZ/tdDOmIBArzv6O68TjNsFV1V9pvdJtGLCDDUFujUA+5hN7sN/?=
 =?us-ascii?Q?hGmJguo5zIEeMQC8d+T9B6yjThjoOiIfLyg6wpViG5XdrGw38f/dgptsPQrp?=
 =?us-ascii?Q?1C+XBET5nePPWxWzNhvxmRJmaFzuW5G/363LQxnka1T2jHiLJqOO00cyOHUu?=
 =?us-ascii?Q?oKscXUH1XLAuneev3dmGsWhhRxFQnGgqEUYe3PvFPq885O3ACMpIlaxewD3e?=
 =?us-ascii?Q?69E33AYmsdCtfBEWVwmoUTqRqqbWyEjLGEt7vRNGQDFzT8F7PwGAFYpTjtmh?=
 =?us-ascii?Q?RMqNXZVfrP1FnUnAyk/cyNdYUf+cV84wv7Rpf0+KTqeqxzu2MiF+qtVQC0at?=
 =?us-ascii?Q?EHLPMNIp/ZPejudmKsvHrDYX1PLXRi4xvgbpaElNG+4jKnyBo90IDh+gMG/q?=
 =?us-ascii?Q?WR6tGoNKe/6hL8scgubgq+Kgrsf3s0iGLWGFmd+wABRaYgyz6Z/+tre71S8o?=
 =?us-ascii?Q?viI6n52wVzDHv6PBfv+8tRsINYtt5c0LvFPsLaoG6MCKqE+WRyZX5AL5k2UA?=
 =?us-ascii?Q?PFawP7nDufcz2mRxK0/Hkz2DD7JLmInPM4ohrOmYv6MvfXvVCASH3MEax1XL?=
 =?us-ascii?Q?le3x4BeP0Jaldf93cJQZdPgD8vEvyxUQJtVVfzRtQx+YgRMgEb9hhy4zDGaJ?=
 =?us-ascii?Q?rF8t2HxQrTVS5xjzHFyaPRwcTD/N7a5kWWxCUhsBR+3Tjzw2OprtCA9zJf+b?=
 =?us-ascii?Q?65xIT9n8bK2k0hieyDAWbQy49QLs96QZmGkUK+CcZsZ1rWoTGgORahec9ZYQ?=
 =?us-ascii?Q?Ve5Et2IBgsa6P9ahv3aJxGd7puNW4Fm63vaS5+2OIkC+ktoCHSNCW53QWXSZ?=
 =?us-ascii?Q?Lxrbz5A96rRf1pOyliXrCITQvupiuhJs+yhRY67AkWd2xppM33iQhpgXEcQw?=
 =?us-ascii?Q?5FFfkYLsxdvZnKRP+xf7tYsd7yUUCRn4JLRrlWaF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f20a0d-d74d-4830-2c58-08daadc9831b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 09:50:22.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvvC6rvcVKobboHgpZxqGfATLiKl7+IorBxnoc3uCeK/mgaZ+5DX9Bn+QcBzDMF0ZU8BwpoLcidYrm/ckIuLVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert usbmisc-imx to DT schema format.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 52 +++++++++++++++++++
 .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
 2 files changed, 52 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
new file mode 100644
index 000000000000..c83ffb6729b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fsl,usbmisc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX non-core registers
+
+maintainers:
+  - Xu Yang <xu.yang_2@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,imx6q-usbmisc
+          - fsl,imx7ulp-usbmisc
+          - fsl,vf610-usbmisc
+      - items:
+          - enum:
+              - fsl,imx6ul-usbmisc
+              - fsl,imx6sx-usbmisc
+              - fsl,imx7d-usbmisc
+          - const: fsl,imx6q-usbmisc
+      - items:
+          - enum:
+              - fsl,imx7ulp-usbmisc
+          - const: fsl,imx7d-usbmisc
+
+  reg:
+    maxItems: 1
+
+  '#index-cells':
+    const: 1
+    description: Cells used to describe usb controller index.
+
+required:
+  - compatible
+  - reg
+  - '#index-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    usbmisc@2184800 {
+        #index-cells = <1>;
+        compatible = "fsl,imx6q-usbmisc";
+        reg = <0x02184800 0x200>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
deleted file mode 100644
index b796836d2ce7..000000000000
--- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Freescale i.MX non-core registers
-
-Required properties:
-- #index-cells: Cells used to describe usb controller index. Should be <1>
-- compatible: Should be one of below:
-	"fsl,imx6q-usbmisc" for imx6q
-	"fsl,vf610-usbmisc" for Vybrid vf610
-	"fsl,imx6sx-usbmisc" for imx6sx
-	"fsl,imx7d-usbmisc" for imx7d
-	"fsl,imx7ulp-usbmisc" for imx7ulp
-- reg: Should contain registers location and length
-
-Examples:
-usbmisc@2184800 {
-	#index-cells = <1>;
-	compatible = "fsl,imx6q-usbmisc";
-	reg = <0x02184800 0x200>;
-};
-- 
2.37.1

