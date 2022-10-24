Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6F609883
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJXDM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJXDMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:12:37 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527367071;
        Sun, 23 Oct 2022 20:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1nXDEXtH4NYJtameOzPWom6K38YZBEZ4XSXBCezUL9J2gGMne0T1uaY9apmpWQa5doqF8PJcTS2o5jjRlItWCiJGIyE0oykRrXU+d6ZD0nmNF9EAXPD0jv7YAM1dxA/I/zUEeX9zYuoO3MON4t/4AOd1fXQK5Tihn7KiFhw8mzJ4C9FsxOszK2+4PDb6DlpWlSvpLuBYhaBm9mDCwCqTO7eQ63+ZVyC4crcCoy6pmPxK58u6ota6XyfGqK8skwMyJLVtIzN42k/BQ8H3YKzfWzZOxTTg6ruzRAGuOCO4Lg0wjqPBcHJlCw5uhmbIZt0dLwLLNojgSNL3wtxXbD+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2z+72baMHwBNGlbt4Q36BRcCnw1uMi873lFmp+DuCg=;
 b=hTokWg65P3z3awVkr5LU+Ch1rvTKaydBzRG+UrXr8boIVqCw5ht1r5+NHLNnLPJTKPVTPjLHgs1cKm9nixeW+bP/ebVXJPqcPTOahc0DtJ//0VRi7ERp0BC6j+tE+z1mN1SEYk+tN01qWDU8EuA8cEoz/b1alxVrmjQAIldXWsB0wE4z7PjeAaP2W2LXMQplur0BfSSzzWqA/ywLKoaDt9W8d5uZ2/vIIg+OwJsGFJegGrqn746C1D6eyfU2vAbKpv5HS4xZgwZLGGlMXI3Vmn//1twlLzt74mapmw8IpfnyV7P7hYeuJiR1zvS4eabEwISP+lM5DQrFRE3mPBwEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2z+72baMHwBNGlbt4Q36BRcCnw1uMi873lFmp+DuCg=;
 b=GsLvmcsSuVNLBDnuykMSTVAl7YIQ5OolAxvBQc98kMNnZGFB+4pBzh1F3YeHVF3AB2Eu/d00v4lfPXH8lj+nUCPmXx4VzcmBp8Z+e+mOSpGVBfbNk8JCL0czzP1gCvtOoiBJ7Ckkqiggnu8c8yfXATcarzO/PkyEVs23pQ+vnSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 03:12:32 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 03/15] arm64: dts: imx8mp-evk: fix BUCK/LDO voltage
Date:   Mon, 24 Oct 2022 11:13:39 +0800
Message-Id: <20221024031351.4135651-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM9PR04MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6a9e8e-c329-498c-c06e-08dab56d974f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60x8GQiIQH5FflXI+rw0qomao8oJsuoCSOwvWNzXob/EpRzwEIraDrfCzEJoRE/NXWq1SQMAZ570SWssrmgzAxR7DihQzj1toQf/KBBn/0T2zoV2rEi9q4Bi2UiWvAt7Axt/r5wWBdu1Pwv1M5pMN4+4VXVkX5lTDOBOMSIPBe6KpLRTnOMVCEQm8KRr23ZwaY1R1E/ieZYtouZGn1GFujBuhEWqp9KazW0JazO7vu9Rl9x0BwZL3MzbwF9i22xroHTbI1Nu924Tdbu73+YEY5EPyPaQxT99t7MC19oZHLm/ZrPoW71ABueb3IC+7izChh2Mn/tdB/6TiqsLVuL/QPKoyr/881XAzEnYS4tj0L5EV3RhR+sNe5DM1HVlajbfyCuMtqavB52lPJYr7dwHhZCpbMZYethAA3Ruv6bmTw6fsUFCQKedAr3xLtreo9/c1p8nxSRXzUovVCpjmhXbS47AsPJwjiEyZg7Pi1wiARfBYvr3LMEsJTUNbjJo5GjxiGQ0eEvcn0ZczsLCJyvaNj2ndOE+4RCJ4lk/Eh2P5iJcPqurMBnPfGmyyBEmdon8P6YHgHZfVfYZpzTMl3jvIoQR8cK+xdR79V6QQVG2BOjgvMBcdSNDbJc0vWzWfPm6EfvJ4NmpITTjkI5rdRT0Uf+6k+Ci8JfbVqQdMCbMeRgHN/34zyr+3kuJQ9IQXjHKzkvZRC1kX9EG/HqBwOENoQLKPFUo4iFefEBveqpHrOjYG8Mh9jarK+Lg16iW5LG1n8fZ4+iWFCHNJNaSjzs3h8I/mJxX4X5iuzblGVayuJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(41300700001)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(1076003)(186003)(2616005)(6512007)(26005)(6486002)(478600001)(6506007)(38100700002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkRkNjNGVms0b0dOODQ3elRDRlUvNjIwVk5UWmE0N1BKang5SGgrRHBoV3Q3?=
 =?utf-8?B?NG5NZ3RBSGhWT21nWkZEUVp5OEh3Y255SWxIczc4VFMyNG83NG9YY3NoVWtz?=
 =?utf-8?B?alJQRzllTEQvbUMxUk5PUmVaOEFPSUlVNnBmNStJR1o5Y21QdkRtWVZRZWVm?=
 =?utf-8?B?NEY3R1BsS0ZuZWQwRmRGSTRnWEwrbC9UZW1pZEd5WCtrRnI1eC9zNlFrVENO?=
 =?utf-8?B?OWJXRURmWnA1YWR4Z3lmcVdISy9NbFAzZUdqbE85NHlnV3hYZ1JDbnhRVXAz?=
 =?utf-8?B?K0NLM2JHKzZON2prT010RTlmOEpUMW5IQWpSRFprUndockRRVmJlQXpmeUp0?=
 =?utf-8?B?Z1p4SHMraEhOaUh3czdlSGFNMmo1Y2h2QjNoMGllOTkycitSZW5JV2FGWEl4?=
 =?utf-8?B?VG1UMU1jWFlENUFkQUYrNXd3ZldxWmQ1KzI3bkR3cEJ6c2xLMFFKUE0zZ1dW?=
 =?utf-8?B?UEJtWFZOYVk5NnpiampIOU5PYU5iVUhpKzNCYnBUWXlWaVM0K3hUemJMWVhM?=
 =?utf-8?B?elhmNEtzaTBPc0xVTS9zekRQcXZMR2hIN1FNclhKR3VRZnZWd3VITVlLb1Az?=
 =?utf-8?B?YVhIQkIwUFVWK052SzEzRWxYcndPaUhXamhEdGJ2bDYzNUJBQ1MxRjlWU1V5?=
 =?utf-8?B?ckNVaUhESEhyUWJlWkgwNUROZ0tvNXk3cmJrM29Ba1FmeHRzMm5zSitQNTUx?=
 =?utf-8?B?ZFJuZWJUU3k1cTZiSFVPR3B2Z2JHYWQ2RFNxN2p1N2ZZMW9Qd1huaWNPenJm?=
 =?utf-8?B?TS9oS3QvVDJGMVFIRm5IZyt0aVdIeTR6REVUOXFMdVFDUDZHSXhyT2lqVlFU?=
 =?utf-8?B?d3A3bUVPQmlYQVl0UktEV3YyT0FDZTlzWDkySGEzc0RiOGxWQ2Y3Q3NZN0lz?=
 =?utf-8?B?MTVTS3RTdXp4bFJValdFS0FadjcrWE1XT3dqV0FnSVAvcXFEb1kvdzlSTWNC?=
 =?utf-8?B?SmJIdlUwVFJPSG9xMTVmS3F3dnlwUkllZTFaQjBkRFk5NXhuV29qK3VFMGNt?=
 =?utf-8?B?RkxxR0Z3SXFTWDVVZEIvWHRmZU9jQTVpeDNzSjNtZUZKNTQ3QkdBWjVyMkZo?=
 =?utf-8?B?UnB4aFF2MStIT0E5eEFHVk5NVlpGRTVXN1Q5QU5Ha0RnNUgwV1ZDam1lSytJ?=
 =?utf-8?B?c1NHU2lFbFFBY0c2L0xEUDJ0OXFsZ3d4dWJTV3RiMS9STDZUOVR6YkVWZjFs?=
 =?utf-8?B?amEwcllnQXNZcXZOMEw1R2xLMGlzQXY1NytoWlBMUFhINjVqZjFaVHY0emds?=
 =?utf-8?B?MnpVOENBYUsrU2lEMUttSnhobVNDbFFPS0ZKM0wwVXJlTUlGREZXSHZEdkRD?=
 =?utf-8?B?RzZnVktjQTh4VXBpUTBvcHB6eDUwY1dtK2gvU3EvQTlkY0dPVEZMK295NVlq?=
 =?utf-8?B?Q3BuaFExWGlkY2lJcVByc3hhWEViVUNkUm1KSGVJb0tsTXpDeDR1UmI2cnE0?=
 =?utf-8?B?cmtSNHFuRHNIQVhQYkJBbnZRMUtVOUVYMzNvNW9nVk1acko0QURTNFlDZmRp?=
 =?utf-8?B?NEI5NVp3Z0FnTWMydUdlMHo3dHFNN0h0d1U3OWRDZTdZYXRTWnFxN0ljZFdR?=
 =?utf-8?B?Z3pqL3dianIrWTB6SHR6M2ViOCtpWnN2YTY0aUF3TFlUd2szTzJQci9ETGsy?=
 =?utf-8?B?bmMvRUdTOXZ0YTlXamhaN0dLc1ROUUQwYmdMUTRZMC8vQjV6ZzN1T3pTSkh1?=
 =?utf-8?B?Uk1kZW04Q24yR2hKMi82RytuRWViRjJwL2d4UDNFMlZxdFl4NXl3SHVEU1BU?=
 =?utf-8?B?S3RTZFI0WkxMZW4vQ2JUUVI4N054R3ZtRU5LZGp0YS96VGVYc0NpNFBEaDZi?=
 =?utf-8?B?SzdLenZaU2FwTDZ1RnBoZ3RyZTdaNjlkUnMzdnprZ2YzUG1UcFpCcmU5WWI0?=
 =?utf-8?B?aEhpcTc2VE9tT2liZ0djUmpDSDZuaXQvODFNaDB0dFlydzVSYzQxL3U5anAz?=
 =?utf-8?B?amxta3Vnc04wd1BJTWF5T1ZXUTFVYnlPNE4wNE41bHlBNGpkc0hkYVNTd3Ur?=
 =?utf-8?B?MUU4dlpid1B3dTlLa3JGRk1mN0tPQzdEb0F0cXRraTk5amx4RXpKRU9CVFBk?=
 =?utf-8?B?SjI3Y1h0RXYrWnZDY2NDMGpBdk5jOE5RcmpxdXBaZFlPRkp5Zk1sOC8yQjNn?=
 =?utf-8?Q?IbKHjAsg5QC44ew1ei13ubCB8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6a9e8e-c329-498c-c06e-08dab56d974f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:32.2558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMb9a6Z3WKw7DMUDIUvr5Jbd4umU3Q/Lg169Dy4qwrfaxSNChcsdsVCqc7o6OqnEdIKBKLBLU7gYuPIxu5U0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8340
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

Currently we set the board voltage range same as PMIC regulator
range.

Also add LDO[2,4] in this patch

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

