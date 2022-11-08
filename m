Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A548620686
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiKHCRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiKHCRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:21 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036B2C656;
        Mon,  7 Nov 2022 18:17:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB54fRIlS9RpuqyG8NRZOayp9mm6m0E3KftOo1zTGSBAmSRIGTET5cMh44Lq/n2Z1Zs93zCb3q7Evh9gRLTxouboGpasQC3MuqilzmJJ4WBasuLBBWvsVhrbQfb5f2awGPZRVXV1O6r+AvRo7fedr2n3ZlhmtPaFNSPVYRuzc6w8rQ38WDvIzJtYJJPvKownrZFVAmM1wDxeVdmb4wX7UwU7wBwBUmBvhgJ3ATtWzgp23GEjuPS8YzRdN0pmcPAspFFU5sPtG25EiAsDniKIreoD42vpsXv2/JBl5VDBR3t3aCvwAS6/dSfkHk0eIV4fvuR/JhUQYV6CI2BnmEOEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94TR/gJ3QFYxCbPvYw8g71pvCpJSSj08ePQxdLAnyuQ=;
 b=W2uVw13Ry7Y0Kul+6fDh9/Fsame8opASuO25krd0hKzfucFl8y7w1A1s5DFQ7yxxL+aNOwZzZm4Jaipbqxys2oruolTAIPO2fhjfDPEH5GXDpF8vRivySJjbAq1xqKdv7DTolON1ny6Z37ROahK4hQpH+1Ng+RHvOJt5gMIeDWWGk6eb/mA6vLT18SolPViFi6Nw3AyF450GK93WiodFqxh6/YMoZX/zShmmibh0Bm+K9CidCBTP37Dw5+aSeQf4tIhKrt4iiw2ZNtTU65MJvTimeGsP6LuqihNTzp1A6btFsKPY/Pw/+10e3YJMNmAx2vZaizmzwIKZByRRjpiNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94TR/gJ3QFYxCbPvYw8g71pvCpJSSj08ePQxdLAnyuQ=;
 b=gn1p402PK96thKNb3TAv+wl+NYFG2ZZK/VKLIWTfKdscE0YmwxPH5zSjITHEYBIJKGqX1Z6cb5zvacdQzElbue5maUNhs7H31W9wtGd7+RZeh/DOA14lrLsJGmJdJDEBzM8KXwNxuTcz0mOWJlnwCl/wLTfL2hIwZ1Une3vDJ5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Clark Wang <xiaoning.wang@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V3 03/14] ARM64: dts: imx8mp-evk: add pwm support
Date:   Tue,  8 Nov 2022 10:18:09 +0800
Message-Id: <20221108021820.1854971-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 288b1e82-f2cf-4f10-ee73-08dac12f5a43
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qSYRb4dWMjmg9FugcHgCXa4VoRzz8g4F2izF7ST6JDpnnjyLNHsByuyl3755SoX+/E7JaXgVwnZO2FBAEqFyjhI4qSwa6BCuJKu8kmugCGZRwdcOt5V2v/pvKNC4IDxKYsxsrYDmW77g5ayoB600topzezZekfcxRXWb8HRHICv1GCnXO5wKwMiNjBX/I5h9SNngrSpvWxTvg8q3lOx4Pa5mPi75UtFDXHemDo98PyQCBW0HAM7KqiQIACmXGvcQPAL0T+oWVcittHK9f4TRnlAhrk8gL6GUadKALEZuWXM9E8jscGoqK0/88j7WptlMD9f3l2NXzW0jaKfm9rKrxHeEOr/mK6n6Wc0Bxiv2/QimF1OMH51GoEt7IyEqYXPJjK/rX766owr+WqAzkt10+vDRptK4/89+rtxzWZjl5sR8LeZzh27ncowgTa2UnNaN809Zgr7sC5aMoxX4WrhvQ4Y0C2VhSXMchPAQBltd9B0Thsen0p0leuf8zZ4FAg6cDlvhMXlqFchGSChA6IGC2jlYyfotCjDsNpCuLOxDWm67ZTtjZzlFyIvIWHAY/71nNJMcmzM2dO0CWcRmYIji8hI5ksk/r5JgZCNlul+Hw5JC5OWJik38cJljkSOg8D6RiJysWj81UFvznYwuBJnVUlqsiC1gshdW+JgvWq3jsABt7G+lhTlxIdLoEzcCeL7pWfCnqix7iOnzXP+EkXardQaHINxe+ylRKts/5xdVYVeY6SYU14M6DVGgaquUMXczDt8buYWbI042bY2rOfUqW2592XIcPZZCAIl3r7z7AraMof7HMGxRbE/Xh14lJ+9nErFL+Dh4ARxrkPTLuSPB3zxa1RHc9GjfqNq7FsrRUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(1076003)(5660300002)(8936002)(7416002)(54906003)(41300700001)(6486002)(2906002)(86362001)(478600001)(316002)(8676002)(4326008)(66556008)(66946007)(26005)(186003)(52116002)(2616005)(6512007)(38350700002)(66476007)(6666004)(38100700002)(6506007)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cxbg/E3Tu2A0Dc8UC468JFYZlhXwYHJFmbxKBKrc0z7nwqIKNyNYl1hintNq?=
 =?us-ascii?Q?YMhgYS0Quo7pze2PDHfNFEbuDdYmZXrs3bO6BRwYxOO++z9ElEzlPfPE1zfZ?=
 =?us-ascii?Q?9ShFF/O3AcVprcymi8H/6Up2lw9utc5m1Uu47fmPIkb9P9tmLDRiAUZsaf7L?=
 =?us-ascii?Q?mFh8hQhAXS/otlftkc+kWJAixOuo+TE8OjU2nNuO3kEzdjTsIxozgov1Gl8j?=
 =?us-ascii?Q?nLjcV/u85UEWRpIgc6udxqXrQGfY/Ld/BbjQXxmsk8Q7NHL+Gqf8c+qXxXE/?=
 =?us-ascii?Q?eE3PMWOveWkEDkN/8aZrPmL/UogaGIW7nHNEO8oBCLi9H6VI6Hhpnp9o5GvN?=
 =?us-ascii?Q?Zohj0Hi73TI6eHnYyogMEHfYuxn3J3T26KjMPyhohChPe9u9/UddHQDL6sAg?=
 =?us-ascii?Q?HGsoIGBuj12YqO0X54XOvm744Dav01rLunMmfkb/PGvzDSFgH3ZJDfkOfnII?=
 =?us-ascii?Q?a2JSgppEP27XK15PQodhBXkAD+aga5zKHOLMlzjDZc1SIDdP9/aKvqCr0ziH?=
 =?us-ascii?Q?EpggcvoGY5nXoeWZKdrQV4spfIVBPw1fat6Mm9JWJY4qHWVmBR0h5PnOG49n?=
 =?us-ascii?Q?OoFm538k+Fnv4TxmjP65ft6Fpa5KUM3WLvxu+Iz1YoBe3a3aY0OoYoAyZWkj?=
 =?us-ascii?Q?9DRW9PlLqW5prt7CJw+qghvnEYwgBzr3sGtpETZzVqXdLoJ9mkIfhT/5Gswn?=
 =?us-ascii?Q?mHYgYNrgilVKmBsxe1W5QG4E+AoDlcy2mquGXivyTUiH5JvYubK2RutH/Wae?=
 =?us-ascii?Q?PCTFeQgLzNswBP0jTeADWMBjj/W0ziwf7J8KYbqO5UI1pI+Cx+OFgcN37d5R?=
 =?us-ascii?Q?3s4l7HBJ+nb1kAGVqAYuJzK2zshhtauT5IZuVsrqOpfKbmFkWyZOr62vYMUs?=
 =?us-ascii?Q?PKbl49VIox5YUzdJYrdVkGMNfpoM2fHFRhIhZD2rIbWHox8lI99g8NKJwN7L?=
 =?us-ascii?Q?zcjGQDlk+OQRqicG4DIcuq8Me6TSfw2+vx+bCWLeEvMF1TPetl6hbcr9q2fV?=
 =?us-ascii?Q?EJ6+YId9jyXEJM1f4d3TPKs+87K53C+vXzagx90k2x0ounC7VZAAWdxQ66+j?=
 =?us-ascii?Q?mx6jn3PfvRlslMAZ1QhZRlAyzRgw6smf2IHabg/YOXd/+Ooixl7Q2d7Vlmr4?=
 =?us-ascii?Q?ZWTxGJ0xKuUREkr82baXD0JvSwkqsHQo9fBhbUT7KT2AQoZt6MkVffWjnbV+?=
 =?us-ascii?Q?XO2IsVTVhpfGGf68F1l5KumnZyBdOSRfifdxv7f5MV62sCalf+M58+d8zUfq?=
 =?us-ascii?Q?y/XTzry0SxhGfqltAdJ5AVlacBP38ZrS3stby5Sn8xBxC5O/yXxuS76sj3/h?=
 =?us-ascii?Q?UIfu6uA+suQFmOjqOVCKHcX1trPobtSmLmli8uikjKKllZzwnTwdT6jdkAf5?=
 =?us-ascii?Q?KPFQfzU1G6Fa7EISCSKKc3PZu6sW/UwFh+5L+g/2nPP/7nmJRSO+m0/PtVBR?=
 =?us-ascii?Q?aa7Ro1zMxcsmo9RYPHPaOHgVfQNj35hYUOm13GegxCZH9FT3uqU3COZlIPgM?=
 =?us-ascii?Q?rrEsvoiyNY4fbk/pMkGk4nFwjE63yKiLJmZzdvJteHqwX/h+mT/r8xFmT662?=
 =?us-ascii?Q?S3J9cD/ETyF3F6tjbb9t+uBw3MMHOR409a9jKefa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288b1e82-f2cf-4f10-ee73-08dac12f5a43
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:15.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s502AksiGFNw4TB1AZznZoEbKXF7D38tsjgxbjYyYtSCHVGPt/vzh6x+PA5QikONJ4Gp3MJL5l0Sjt1e9Bb7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clark Wang <xiaoning.wang@nxp.com>

Enable pwm1/2/4 support.
Enable pwm1 on pin GPIO1_IO01 for DSI_BL_PWM
       pwm2 on pin GPIO1_IO11 for LVDS_BL_PWM
       pwm4 on pin SAI5_RXFS for J21-32

Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index b4c1ef2559f2..e323e6f4b7e5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -390,6 +390,24 @@ &pcie {
 	status = "okay";
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -567,6 +585,24 @@ MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
 		>;
 	};
 
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__PWM1_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO11__PWM2_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXFS__PWM4_OUT	0x116
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-- 
2.37.1

