Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B3F620691
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiKHCR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiKHCRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:40 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF92CE10;
        Mon,  7 Nov 2022 18:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mniGePOuuSrsmQqhPVSK7H9IKy2PI1Wrf8lrihR5bWhjf/jHpxKSxos/Gd9E7Tfh45slk1bAegRle7Tvu3vZhmSdr+qqHDcRzA9SX+nDfmaftGwHZhIGFG8PV9TBsEnu8RVkzAqsZScfhbH4lVQpfo/pFDQ9c2VJKaf7lXRH5ZDP2AXynibc5WwX6kLq3OD2hymeGi48r3tjd97+Puqecv2WkduCQFKFRAtoF9It7lzvSrLD9yG5bjK/tzawT9KPzC2l3AnRWaji4xbQhF9LsVqCCeIMBpVBYrrT557LTljKf2uf40hUY3BRx9uvwoIFxLzl00czWWOPFmzmB794Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooICO2bcvN8ZxEm3I+1oCqyVOu3YHmUmgXvKVeCCiTk=;
 b=lCw6E+oNH1i48wq/7ornDzwvPOAd9dR7r6H6TAQmVSFKd07cJoqPtF7cmX5t9Hy5/cXKdWcKKrMuzLq6AuuWkVaaDBTR8CX3O2gAA0mDxXYyu65jiabh0Gjgo9Semxt76AoxiDu58OmEatz+ZFfktolGEZJPdk4cV3tMvmkfvoDnZn7TXQDThTueaPZE0rw2xUBmCBrv2kZ+hbj3nq9sLBsyfeM/59fjPvmBERkQM+tEbQ0YPlhn2km7zx6fbbfobKVVrTNVMC1XNxyYEmYwB4JoqyPBFNFLzwW/IRBgv5Y2CBuZ8td/pI5OHBuMWM6eHk3Mx1u4Tiw4tkcnG5yhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooICO2bcvN8ZxEm3I+1oCqyVOu3YHmUmgXvKVeCCiTk=;
 b=HKQu7/0A+FUyTS0SYiICZtiZG1jMKukf6m4VnxJREPTq/hxgXNMje1pIYw9NGEeh03OkZfK64mLvT5m2a7zH4NjQakO5V06usGnTrRsY2Y9BQBsdMil8kD7WJXdcfIKlTZtAd2rauvCP7Oyo18NDGWE6MuTiYnIjBG5vV8BkuwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V3 06/14] arm64: dts: imx8mp-evk: enable I2C2 node
Date:   Tue,  8 Nov 2022 10:18:12 +0800
Message-Id: <20221108021820.1854971-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
References: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 422f6c9f-4df3-4bd2-6c2f-08dac12f6426
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQxRj+62L3OyUrZsIHjPaUCTduTlFT5qRtH5cIUy/MsIbfuZWuGxh2cCOGfvWN8a1C7nqyA30XWRKKS2CnrKg/QTBtctpWLKgEqGA2Kg4bZowG0K93zf52s7SWRp7biS9gk/wYdrvT0SbZW7OOIsFoeuzH3MBx1sm392wrVV+dk0+tjA1zYEdiDPW/qTS5TCWY2mfq3Nn0WWoB5CSHa9pXrkUshzWKK8t4a36KGCwQWpCj6de1Zroo4TLYuMCxU+h4lX1M4tFyTWvdgAM7GM00A/2ny9VY0muJSEUWPlqTNQstcGXUww4sUPFe5xWqq6zbtjEJb6pt4kkAebbaJmAAo/+9ngyoBcV6CzjbDN73ir8S70MRJ5GO7lgWJiDzPkiNVmxiebASywkwAwWB3O7/hKW/SH1vs00oUKNGDahEbFhhxh5C90yl+9HmcsANBzSccqFU40YPDxOw5dkjI00Wm1PXBmaJ6CUhaZNq3Di1DdZrx4WtaqJ03bZoGbqaCg0sxd5wdsRwfxP1CJbNCCRNBndW5Gg77VU+A2f2FVaXhGHoOspd9HHX7FRTLcnS+ESQ1i03GPHZfpVMPvGBMb0RjQFTqvWdCdsIrYl7BmKCgRF+foeavpkgVtsBePmIegNAlwQq1pj+X9GeB/tyawb/xjDxD2NZDPJXn5tCeke105TNxrIdm1t+VoRid079RaAGyA3BnSelbEZGAyj34gh0e23360d0TSMagZVIHohIa3NbQ95wPttaIGg+RUMVtQkyZJ2LdAaQc4ZJMqMncybcxKR9Ba6T2BP9TIpmj9KEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(1076003)(5660300002)(8936002)(7416002)(54906003)(41300700001)(6486002)(2906002)(86362001)(478600001)(316002)(8676002)(4326008)(66556008)(66946007)(26005)(186003)(83380400001)(52116002)(2616005)(6512007)(38350700002)(66476007)(6666004)(38100700002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+kRUIjtZx625unz4fXaqfnhQbm8VqaM2bBKV7CxWTNnQFssPC8acGzCZD0/d?=
 =?us-ascii?Q?4y7tV6Wzf0ch5F4frS2koOvPCXMXTYRLYxlPHY442TDpdB3ETKtPUk+BSy7U?=
 =?us-ascii?Q?h/NXeiolgl/Yd+XjsSfJO/RkPslcJLjtux+Ak5WNdomMpmBbmmqcecduCtYY?=
 =?us-ascii?Q?uvKE0ICMHe6tkJReMAWLIMKsqOhxJqdJ8EyUHnrBzDrOL7TnDMZMQYmT8Y86?=
 =?us-ascii?Q?Fp5fQR5OQAyOEKpXcV9YJ0Ug6+fxmwGZzqVJPTaJU0r/7bYMKWrp0Epf6DQY?=
 =?us-ascii?Q?mo1brMTBgUCQL/f/Qr7lG4WOqYuOpfT4y8WrtWDAKYuElrkaHueDeGK5AMk/?=
 =?us-ascii?Q?McYjZcaVkLPdfU9RTAn4tYJe4r+0T5XNbKpdK/TQKd6z9QHT+x01gafjUZpv?=
 =?us-ascii?Q?i4oGyIzIqrIR/+cHWapua/ynA6IaTMIZlpskxeCb3peLOtuwBmOHWVAZcUW2?=
 =?us-ascii?Q?9SQFNRiIcwHHAAuwHyUmVmpu9ebJXb4WWAN/rlDS2CgL5Bw3mIgCncNkaa67?=
 =?us-ascii?Q?PZ1bIe+kYWpmGacqcDTlHaXqvT37AtP5iCD+U0yQIyy3swR8wZkMm9EhJ1bx?=
 =?us-ascii?Q?RPj9bipwv1oWY8bAunjvchJmJeQcy2Lk4w2HUR8yuZbQW34VVlUis7faftwg?=
 =?us-ascii?Q?ZPGPu3JZvsNs7rsAVgLLeQODx26HxnhMMh7pIeJZHuiCNaaDBe0HAnbuQTBk?=
 =?us-ascii?Q?74J9dYJAWRyAO3aRTaANK83aGpcq7w5oYM/OyZUcD2IR6SisUVhO69lYXdUC?=
 =?us-ascii?Q?/iqlfEH4h3VZq9VOKVcrNLope/Hn3LuNcXnfugXTzBg1kOQjGlK3kT/q1EWQ?=
 =?us-ascii?Q?CgD83+ZNLhLMvok6jI+Ple0eBpcn4ApVBnC6xfsgUa0690TsK3bLMtT1oei0?=
 =?us-ascii?Q?xupF9FwfyXIxiD4yjm+SWx/B0oyABb3GMwikwFzwRrSvEJeKOGgrA42zpI1I?=
 =?us-ascii?Q?asgUxHLG3793DlwuIoIzCEf4d6lzjibeAQo3aDPf2GUkOYsYXvjVitYaBTqS?=
 =?us-ascii?Q?D3XjF2lRlFWcPMSDunugcA3af4Hkns9MzlH7QQV6ywdK0ChO1Cfy1M3Dt27F?=
 =?us-ascii?Q?shAz9rdU/UnyFOac2unBtIMW2hU5jM4cxvXqcg0aVwdP4wNiqtYf/p/gcA82?=
 =?us-ascii?Q?+SyZXMSrTZWd2wmez6bzUQ7/yAQHXMdg53JPmNzQftH7k+a92zAb+/n6fzCy?=
 =?us-ascii?Q?Qpch7zbv2sJARHlhAkP7KZj300e7A3BUCu3bADufStgj/mhkl6grwcIV/Vji?=
 =?us-ascii?Q?HSqRjm0R3Ose9B8gX3vI19iCkFnC7PijSwWqTAvLsU3TRZ0dJ7XNPUAMGvNo?=
 =?us-ascii?Q?oGUDAbX5CSZlv42RvEDNzXc1bFo+JIJVM6m77iIn9RQ7ZLfFD20gXqAIsjuu?=
 =?us-ascii?Q?dLyLTFNF4v5NMk0rastJETn2Myo0BDuxpju86ZpR1JJaPk5AcBesaOgAFnWa?=
 =?us-ascii?Q?m5sUmzO98obuB7JCG+iuYFNUaHZ3wgl5b4XJ3z63DVF1YNuuEqME2Lpkf5Id?=
 =?us-ascii?Q?TQbHPg/7WsW3rmo+NznP4y+sg3ZLfBG9kow/wkZ62CVxlHlKWqdYm8sK7UXr?=
 =?us-ascii?Q?Ma6Q0gZNuj7AuKJUqfsiJv+KhzLJ/5Yh5Hc5zIas?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422f6c9f-4df3-4bd2-6c2f-08dac12f6426
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:31.7490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlrDYsBoWzGe3TK/CbATqhnmO5KV1fkfsmM1yQqDEHvEg0hYrreFzCOc1LwY+f66T/3MjRFfpUMc61l3iQv8WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable I2C node for i.MX8MP-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 4164f69a89a6..878d4a752090 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -331,6 +331,13 @@ LDO5 {
 	};
 };
 
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
 &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -589,6 +596,13 @@ MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
-- 
2.37.1

