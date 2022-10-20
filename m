Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4CC605BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiJTJ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiJTJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:59:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4231D2F4C;
        Thu, 20 Oct 2022 02:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgOWC9blPBsgijFyd63AkWEhJKQpAixWtlBcRf8abxmtfDRa23cpZd3ZbpTol6klqfCcQOKnaocDRrM+YWZSyIjSqYXh2vknRbK4rOHPOw0lrWEs5IkVLMg8m9YfFmQ8w9cSHO+dqgsKEqPwBdyObZacaJx3g/PgEmEfivJOgxsljzWQZ6cHxh1DIxoDZGKdV445OX/sChewenWK95ffQGIDb/GHixMEIUj7UZ850NAJSWBWSCdnenLx/wx/WX7fi7pgktSctfbs6f30u//4fVSDVi4QdlXLflWc26IdseC7pIymkm9BRNcMFpWATC8a1+fSeKOYUOLm3I0VR7v2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYOsrt18wct2kgXVhwyIBoLw4b5idUtkhMkaQEpawBo=;
 b=f3tyt+u4Y808V2H+2bpzCMJTmO5GthQ+7b4xCAdrBetIxSkkP0UtdJ/yXnBhjhWKDC8PGlbiba1yS84CWW1Jr2UXNmKHfKY8kNUJSVp50Al+NtnzxuiyAUxSmhERNA6vyF2lPRV4JVOr//SHPusdrbMya61z9hs0H9hzV5ZngUAvCfKhcytdP+lgC0JOJsk7Dkk54j38S4tG5jAAfcETpmDdCyh1/0EIkmyPUVwWA73gEL8S49FAYScUKd4BF3npas4kb6QNVykOU80CzIKZUCbfGnbFcfYVKW5CHHtgV2zZFVm/5FHyPJL83wCQHw5maJlB49AilmJZPbVcqxAZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYOsrt18wct2kgXVhwyIBoLw4b5idUtkhMkaQEpawBo=;
 b=RWJJAaEDZv6Dwck6kEHrYsyb4oWd/kIFlZPZ5Q3rpvtd/6o5ZHIMSkhZIR7Alr34moYM+QBChyGJoJvWc5O3w2du8MFsY+yn/uPK3S9sy4SFoTnK5kbb14lkbNmM1nY3amYY1yhbfOuO1QO+asgiY14eLlO4NFjXBT0EfRfX+Tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 06/15] arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk
Date:   Thu, 20 Oct 2022 17:59:25 +0800
Message-Id: <20221020095934.1659449-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: a6352586-f731-4d75-7ecf-08dab281a8cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtGGgsn8rr50sJP0FQflSFvg8586aVMIxV0esZ44TuJAiaIaW4rHBEtext3lkcp9nEMnTFyxOSOiRgWVURuxBCM4qVu5xSQHXPmkh12pkxtKn8dKuapDNUHW7aox8Mfc6QG1rt/IvWRKXFaxiSbPTmEZ2bb/WUTX2cSOiU7sq+6Wyi6VMg1dO+Aj1KSS3zolnEgb2jsdmcvOS9sJCqYV6DNFCEENRiIoOgvY3hZbCt3/ADWDkqfODmV/tZ+qcC43n4pxvvuwMLVqvpftZs5N1nTN9VOdv54Rmfop1eDz+/JX6ze/7KAWcTtay2TAqVnDOxf+Jw6/R+MLH3iW/LsauOGwLZpW13Tfa1uBdI3vW2Ii/y5X31nefRRs5M6MMMXi9QFfGnsqKKYdvdI3GcdtWW4JGbZdG3No5KfNcUSpoST6mS6af0lezawv8EMyuOYJkqI3wLVhKGZgFy+iW2jNN+q7mkFl+p4j+5DSHuA1i8Nw/JqQ3nZOM3wqK1dvJbKVVBrAHvVY2ddeerTRJWfmLbziKFy2BlEOBJMm9SE2MXXx8xTt6TQGtCNHA6wF8HlazV9y62Z22to2WpLR+JIhOm9PAUx918y3lbLpDLmciNN0xk/jFez3dIc96vnC+2zAXN9z7adEhhNgE3XycoHn9S6vCeYR0qRBR1E3tASTa06bsoMDnjKKjJH42SxaMPdehzHmk23zG8yPbdg8nIEWe88IYRRVcK9ZeF4rlajUha2t4a3nWYUN1S3ppsV+JnWDAHJKmMu61kqkIimtmICsOJ2n2RCHSzJT3HN17Zy6P9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(54906003)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?neBOzEvtc/DQowvNus9ggqe/m0/i8SQD28wJG62ELho+4T42MpFovAA5S5jc?=
 =?us-ascii?Q?knVzjG/+mxvOzzT1kUUb7KsnWDC+Gdk5ShT1D5O7Kkw/oTWthqSwfqUKelXP?=
 =?us-ascii?Q?aB98JMaRQic7bbXWUlin9EHAXY1tKQfKBDjTAOA2KZAG0sPnOtQjM/yRiHKi?=
 =?us-ascii?Q?JdnkDVNbLa+IyaK+CrRNNBX43gCB/M44D1m+vXossXclt+pMfwVwCgyWej3i?=
 =?us-ascii?Q?7BJxCWgf2XIcNv8xv76ld5cx/cnvaj/0Dn9Yas5PjRKaT3KMQQLuEWbNei5s?=
 =?us-ascii?Q?WB2eB2EF9nIDhJkk6/LKiGRcqR5f/cc/KqUrwkAb8GqF0xMnfqETF1myOtHe?=
 =?us-ascii?Q?R4Q5G2uGOOtbuCv62CoVCg7UfQlm68EqM9/fsvBND6XFx54vDVgtIUhXTClv?=
 =?us-ascii?Q?Lx9usD6F99Rw0XEMATaw8BEL1QsXYlumE0/JX0/Lv9GcohT4EHrBxJxdwIx5?=
 =?us-ascii?Q?/O43nNX84ZMw6ENaKdS4FkJGmYSQICdYhgvyPElOcYL32I2tSGed9F083fkH?=
 =?us-ascii?Q?f+XqwgNCq+OAdytIkF/lpU6m1Vhj8GuMjkc/ogSPYBu/oftvnJuSinRBBhUp?=
 =?us-ascii?Q?IlJyjd59n/fiT0TpFgKWSbESKzKc45YxGU2DiQILLbx8CMVOL1yJKKDVj/kE?=
 =?us-ascii?Q?/Qx8/2fgE3Qs/AKzdkUZd3yJhoy46x/JGiqWqYmLZHB6HrDkh0TinahG/uxP?=
 =?us-ascii?Q?Ns6BFm+r3zolmiMlvWPdnnLrvceKOOVeiXQ1zidxX7Q6xhfbohN66T3mAFaq?=
 =?us-ascii?Q?4diB6Mzv8YJjMtc49GeQ7OSfHMGofJyy92RHrtHpFoRcwJmEjPUP2GDS39af?=
 =?us-ascii?Q?wugSHwgQmiwxGt8vdBspQ7GAG22CQLMz5f447aKjkV7uKsUDmFYfySY1QhQG?=
 =?us-ascii?Q?Qm+97YlGdJirlBHhX+ESyz9CtFjplYdhUcCFq8e/A676fOni2oYmAXd8QIcb?=
 =?us-ascii?Q?j/0NjBFwOp0RZhRlpLL2tvK9Mfwp5Ro4FSsfzWLWMXLRVtyV6ld0JphrvfO7?=
 =?us-ascii?Q?7ZaceQHwJZUl6V2Ij/7IM8k1bz0mmA32tkzjpN18F0wgRIzRDZ7bh280dJYC?=
 =?us-ascii?Q?ogJpQ97KxGf2BQP3vfsjQyJcbgxnMtzehq6M4QFu96mWdsCQIn3juQq4rwUQ?=
 =?us-ascii?Q?U220xd9x+grtSaLgvO6wUA0SmOwXh+WTe9O7v6noELfsIXId3cndOvLJTG1s?=
 =?us-ascii?Q?eJgJL3MJsIda3uEQAx7J+bBaiTBaMzMNcRyJFnNp1wCvA0b5qi70LzO9HSvk?=
 =?us-ascii?Q?6w/dtKSamkZ5cO9UE5WBL4QtBSD8hC50ShdVRRtzx3dfrX09sc2pm9/KfdY/?=
 =?us-ascii?Q?C+QUw8RqFM/vJz062WQjV0+tSX5MoXkNf4zmTvAFkZuCoxvTGVT5bA88KTOS?=
 =?us-ascii?Q?pYhm36DzwQXEMZT9Wek21qkfw37IxsQ1+DaIqNm1HESTmO/eJV5hZzE4TaaI?=
 =?us-ascii?Q?9zmIhggTz2dRNJGRDqss91mLie+mE7b/yTpwY3Z2Mx3HemIh+mOMZxqbxpXL?=
 =?us-ascii?Q?n5HNjIGL2xY4qVABhhkLsrZgbg9nwol3t8qAlqg0Vcy98BTJ7HXob+ZR8Ozp?=
 =?us-ascii?Q?0MJJzcmBLyebN7kblO0mMfO8Nj9foB/4wtyYiYiQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6352586-f731-4d75-7ecf-08dab281a8cf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:37.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xecF0mTSmEKsO/4IDfmtwr8I+e4GCeI46clV6s63eFEae4Bkqcww6bxulEfg86DygD3/DIJKSs07QTpkT1jHaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

enable fspi nor on imx8mp evk dts

Reviewed-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 366f709f8790..f36033b9cebb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -85,6 +85,22 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	flash0: mt25qu256aba@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &A53_0 {
 	cpu-supply = <&reg_arm>;
 };
@@ -585,6 +601,17 @@ MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK           0x1c2
+			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B        0x82
+			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00      0x82
+			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01      0x82
+			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02      0x82
+			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03      0x82
+		>;
+	};
+
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
-- 
2.37.1

