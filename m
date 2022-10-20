Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A42605BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJTJ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiJTJ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:58:31 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817451CF557;
        Thu, 20 Oct 2022 02:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt9NMQhiv2A8ZVOxxBzm1puu401jSwSUwYlvQBOhkyq+3Iz68cLjXHWFVxXW/1iPVDOJrFmWOPiS/RvHJhDCgAtR075edEt+ez8+WoWNqVejkxCEmdNBdQpXdBoaDF5F5kW0r/gLDR9Ie2ftvuxvaIPdjhzHIxdZy0hBB9TGMi2ER+FG09LkyBethoDsvaMPYXx7OUSdCYEc9o0ndGqIZy4A6Ai6IfGDei8vuk/es0ChZbHW6AyS+1i9FyIkQgZdY5Ok39qIIJWHFWaNJykifbgQH6NciFh7eYNMkfWebXyJKP5kHJbbVhTB730uuQw2rk+q9kXvA5aldIsnA8shqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBXjdRB0++g9Slb/jRrA+HS5bgqM2cbPRvV1kiZgpvg=;
 b=VHcLD6qPqLb0ms57Z17Khw0hi9xL+xvz3gFShGdGdS19aFCsfhS+/XiMljH2ilk9ofpB1DB8NVIn+Fian+mdJsICibzoAzgeW35O72dheZAG24oJMhcoWmVG/MPcvk2DfOh9dJngQ5kjRsb/wSvI5iQtE6BmJQvQ+ujRzJ+EX7RqwR6uUTmI0xhlOd2n4g3fIeRMn+olW/FjeHvtVG470nlAJavLBPcmWxr++5VYO3qaJcshadZdChDL0voGxoqKdDaz2Tdf8QNnVWTI+0LqOBZ1o/k0it3PZKuy7aZemuY363ohPObElTH3evH9iKv058kxveQMAqfIj5N6sL85aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBXjdRB0++g9Slb/jRrA+HS5bgqM2cbPRvV1kiZgpvg=;
 b=JGRFGrTV2GMhV5mkUFLFsbjjsKveGi84c6z7jaEYa4/dehrmuscgxOcJRk8GnW0mkXRLGPJHTKw7LGsuDns/WXIdERsp6cEkTKaRQ0pqOSKpS/mir4VYOUZpdtH74T1wQYpOwacQCDERPY85cy3/egA6l6V9doeNHwyZ0BKKTlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 03/15] arm64: dts: imx8mp-evk: fix BUCK/LDO voltage
Date:   Thu, 20 Oct 2022 17:59:22 +0800
Message-Id: <20221020095934.1659449-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb2123b-e761-4c53-7f34-08dab281a1d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /R7dgCYNAeKxZXCfZcILkx67eZYxT1f55v9Nfzqyhsy2ALJf+95U+a0K/ZfycH2DxkfwyB/YW6wUoRTqcQsH0GiLtFxBiO2KzYGQARH2/d/Z/UxvqeALO1L+cdLVTn7zmdB+4yIASftofZSuiWAx/86YJd8jo+DjgwXNr/81d91dQezewKIZc7pwDt47ey41TMFBPxUldmxdvGVMmQ0HnumfoZGHRhJdgtnAqYHxWFveCSvFe3ZQCLTxLWbrC3pH7PZe+9Nf7rAiwTBE+clNK31wDZDxL4aXmXcFD2vLtZuqqbC+e+5rf+Qov/TvXe0zFDl5bQ/zG0olUY7agORsXCAH5Mw1HwcNjLEwQfO0H3iA7MCBqDdQvJzw1st1nPhDTdZ0x/7ECCK7WoiZS0wsmeR3trpl0SVy+x9SHUlLY4g6Z1F7Eb3/m5/lOOmrz9PqUjHv8GTAEBA9WjajALWxnW7eiQYxTUWCumdgo0DphujXyJKSc2wIJhbDW4fCDlCn8Wu4zD22nRemUb5UDnKj5If8tAV4RzKb34lTZqqpjkaDunQuxlQRhtEZtrLHFC8IaBTmxHeuGEdmmDW3Qz/WvTEvXEAjK37bRzsxlKBu1yTvn5P0gUBMEbV9iF7kEmB3TX3W0oB9Diak4eGxWB/uqa7G6r+COsVxDX5SEvELbcIeui62g8PlgqNPFspv4c//AbqJhp5pMbpEJJWlDEx0YSVEVg3R7qsPp+BCp68fUGXFFusrrYCKMAfUUP01TX3j7cwJh237KZIz9Qh9EXpJ6eMbJ7oSWM9F2JB/IFk/aY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(83380400001)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZqMTFLcXNIemdrRGFwZkpZZUJXK3I4blVmbnhaZ1JLRk5zdWZWNjgrbjBG?=
 =?utf-8?B?R2RwVnJDRkt2YzVTOGo4T0V4bGZHK01GUXI2akRxaGVkeFVwOXdNVC9yUzY5?=
 =?utf-8?B?OTM5UkNmV0lqOTV4QWcwSmNKZmhjbHZwYWJIaDdYUTJyZTV2L285R1I5Z1hN?=
 =?utf-8?B?Vi9UVFhOUWFsbDUvRUpUbGVwVGlpcFhOeXN4SXJMSjEyMzJTOEpTWlhiUkk4?=
 =?utf-8?B?aGpuV3pHMWFyb1NQUlpiZjZPNThIZXNzMzdhV3dSVnJJOXBJZFhzb0lUUUdL?=
 =?utf-8?B?WS9IYmZhWkFnRFZjbVR2dmxMaVNsNXJWN01SamxwMlFHV21ncjF0T3FvRGRL?=
 =?utf-8?B?OCtTZkJvSGN3T01PSUVNVGhmeDNXRngxNjVYVFRqclMzSUFjd3pzV2tnY2Ur?=
 =?utf-8?B?bFVvUE92TXFGK0dnM0RYUzRTVGtFS1FpK045cDF1NHpEbXY2NzZPVXlNVmlP?=
 =?utf-8?B?cXNzOXQzbngvWEtpYUNlcnAyLyt6WTE5YU01N0MzWTNRTlg2UFQvR1Vmekdy?=
 =?utf-8?B?ZWFSekNiOHVQQlBDVS9ZbU85d0RiTWllMXU0K3NRdis5TWFwWHNsYVF6K2xp?=
 =?utf-8?B?Zm9VNUErTzhlK0RiY1JqMEFVY0VIbS9jbC9SV2lKMlRxS3hIclFMd2NYUlQw?=
 =?utf-8?B?Q255OUlSUGE0ajc1TGhMekdKV08ycHFheG9HSVhTVThYWHlJYzR1T0hrKzB4?=
 =?utf-8?B?NEcyb2xlSTRDRHlNRHhrZksxMWtZRjNXZjZDdDRhRnVUOTBrazR1cnRSYXNk?=
 =?utf-8?B?MkZTamFHR2pZbmczc1VzNTlNdVU1S0VuTXRmR21FdkNtK2pPTTBSdHRCWC9U?=
 =?utf-8?B?Tm9oNTJ5TERJN1pvTWN6UlYwMEhZSm1UOWsvaTl1dWk4UmQ3bm9mNjBpUVo2?=
 =?utf-8?B?Rk9Za0F0QmtSNWRCU0xNUWNSb1J1ZUVsZDZrMDVRS1BKRjIvUHlMU3F1VXRr?=
 =?utf-8?B?UlhacWpCZVY0VTZ1VFNOcmFReTJ1TThzNVhoOXZBZEtiT0ZNT3BBbFJXVWdp?=
 =?utf-8?B?V2VnNk5wUEJDM3VycU9PbGt0VmQ2UE0wSGVWMDUyNDVNUU5YdmlCeU12RjhS?=
 =?utf-8?B?OUp1UnRKaDJKSWQwaVM3RmZiTS9mRlloa2Zhb2VJQ2d3Q3VaK0NIbUlLY0pp?=
 =?utf-8?B?REwwVGQ0S2tvUEFvTE5GbUx0dEJLS0czbHArbDJwdDlwbXRnNG5GQUhwRVI2?=
 =?utf-8?B?QlJIWm1JRm10TVB4MGRjZVIvTjVGNVNHTFpsUWFuSXpVL2YrcmdtYlZ2UW5V?=
 =?utf-8?B?dCthbkRHQ0tVUklyQndJeFFSNzdKcGJpWG8xQkQ2blhWTk53ZWRJUEd2VDFt?=
 =?utf-8?B?UjJVR3ZWU0ExYjc5MFc4eDhZOUtTQkJGaVB2TDhCc3JDYzhCMkJQOTlnUTl3?=
 =?utf-8?B?dWR1cTdSS1FrMVc1bXl6QUdZaTRXRlZ0VVZ6ZnIrVDg1aFk3YjhMTUJZV1U1?=
 =?utf-8?B?bFZUeTloWWdhMXJIL2xiTUN6alhjMWlYalpmUnV6MUhETTFNWUhUVWpvam0w?=
 =?utf-8?B?MmROMFVxVjA1VENIeXlKc3gvRzNaVHdpUVVFTUZYSVJXZlNjZ1BoZEZ1ZUsw?=
 =?utf-8?B?NnNjRUc3T1ZHTUVMWGtvbHVnUjlyQXFBcjdBLzRqdno1dEtCVXRNaklReHlU?=
 =?utf-8?B?TVdKa1FmbkpGOEZLNVUwTHQwWkEwTCtkU1FaZER1cTBabzVqUHFGVFl3YzB0?=
 =?utf-8?B?VUZ0Wjl6MnlwRkMrcUpsdnBrLzFXaUtlYXBYbU10MWxUQk5WclREOTRUNGJY?=
 =?utf-8?B?Y2pLV3BRSmZZNmhUZE0ycEk4Skc2Q3FWcHQvYVVWUVpKcjJ5WGxWLy95UDRB?=
 =?utf-8?B?OFNlUlJZNjNQTlo2TFJGRDJMblJMazFBdVVmMHE4NHI1SS9IeURNbVpnZmpU?=
 =?utf-8?B?WEhMdjFTWEQzWkpjdm9QNE9KWFZpQ3Fncml0QUdpeENwREFrTEYxRS9nNnNV?=
 =?utf-8?B?bCtkTjJENXZDZjZkSzhkU3ZoV2dKZUU0ZzFGNy9kTU9Jb3Z0c2IrNDlBNW1S?=
 =?utf-8?B?eGxRUC9pek5wK2UwVzdwLzhMV1EwaksrTzdlV0JPUTRWNjRwNCs4ek5Db3Rw?=
 =?utf-8?B?WTA0Qml2UHprZmE0Z2l5cml5aGtsd05lNmdhajFDZm9xR3VTRi85TXdDZmI1?=
 =?utf-8?Q?o1ObGsFV53N41lFfe03b5eCLG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb2123b-e761-4c53-7f34-08dab281a1d2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:26.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWoxTzXlif+shdGkzDi7ZlMrwls97KSsjZ2i5qHMlgWjBCVYKiD/PWO+DgX2DNGlM1XQMX3h6KjIPAxY1mBECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per PCA9450C datasheet, the voltage range as below:
BUCK1 0.6 - 2.1875
BUCK2 0.6 - 2.1875
BUCK4 0.6 - 3.4
BUCK5 0.6 - 3.4
BUCK6 0.6 - 3.4

LDO1 1.6-1.9, 3.0-3.3
LDO2 0.8 – 1.15
LDO3 0.8 - 3.3
LDO4 0.8 - 3.3
LDO5 1.8 - 3.3

So correct them, and also add LDO[2,4]

Fixes: 5497bc2a2bff ("arm64: dts: imx8mp-evk: Add PMIC device")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 44 +++++++++++++-------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index b4c1ef2559f2..a4cddc5a8620 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -248,8 +248,8 @@ pmic@25 {
 		regulators {
 			BUCK1 {
 				regulator-name = "BUCK1";
-				regulator-min-microvolt = <720000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
@@ -257,8 +257,8 @@ BUCK1 {
 
 			reg_arm: BUCK2 {
 				regulator-name = "BUCK2";
-				regulator-min-microvolt = <720000>;
-				regulator-max-microvolt = <1025000>;
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
@@ -268,40 +268,56 @@ reg_arm: BUCK2 {
 
 			BUCK4 {
 				regulator-name = "BUCK4";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3600000>;
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			BUCK5 {
 				regulator-name = "BUCK5";
-				regulator-min-microvolt = <1650000>;
-				regulator-max-microvolt = <1950000>;
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			BUCK6 {
 				regulator-name = "BUCK6";
-				regulator-min-microvolt = <1045000>;
-				regulator-max-microvolt = <1155000>;
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			LDO1 {
 				regulator-name = "LDO1";
-				regulator-min-microvolt = <1650000>;
-				regulator-max-microvolt = <1950000>;
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1150000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			LDO3 {
 				regulator-name = "LDO3";
-				regulator-min-microvolt = <1710000>;
-				regulator-max-microvolt = <1890000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
-- 
2.37.1

