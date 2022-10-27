Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB7D60F490
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiJ0KLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiJ0KLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:11:08 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D5EA2862;
        Thu, 27 Oct 2022 03:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZTDyEiAerEdEIGiysg6MeF3tHCB8P23hRG/FjoPmsYGnfjrIoNzg6vYP2y5f9BnCB+59z8lMS2dQH4CT0WX6Huxl/e7T8QyTE1vtQTE5/p5vqMg8R/Sau475NVo1ywvpCRac711a5BqA5nsTNhS6V5r/annPn9/7h2Zi1dSNJdZYqf7eRwd6iMAbc11UR5HJp5AFscEP8QWoOHVut2MbC+9EIMXUaK/cjBVrVGAe2BM7rlgGcs0drnjJcZWtJ0L44zc2tAoexHVaEKzkHKXqW0fXF8kl0qHYZ9kIulvrCWUyo2guMQiYnnYA9g75w0OWnn78ZxV5erWjHEbbeuxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIE1Rdy8McrFUlqWR6tNZu974PdiQqqyFo1QeCyMELw=;
 b=kGaiosoJuICeUVl9MjYLmWK3t9w45tDyhMwpA1LdOW/HMUMfFL5aiSeY4qgON650LUY2zXlwYF1nWEFkn3zjzj7CKpqYcutpqKXnDUUGQnKqT0iuCdDvGSjMJ0NwN6lqca8t6X90vBz7jRZ299K9YyrI/tMji74T/5f+eAqdZsjWREcWwMCvmugI9CylqU6umi5h7M4EIrzBUEehq7pCFO6A3XRuyeTQwm9w87sk68X8QKtNYaGta79RpwxyDIE8tHkpUzlPaMCN5j204myqRY3+Miu54mzUa97U/EyQEejz1w/UDe9BJ6kkM9WcR5YDrG4QAYgFDiesYO9Zj3cvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIE1Rdy8McrFUlqWR6tNZu974PdiQqqyFo1QeCyMELw=;
 b=Yg2refz3p+ZILRRhZ0IbCTvnnnGbS0BIiBZh4AG/TAJLq2r/DkIT3lCPl3NbY0Zj++lk2drEb/0cxl+r86xRKgkvE5d0QTAzAceqIyb4U2fU3+R6DCPOSDJol5llxqwCIkt1dqa5GHVvQFWBXzqv8LH6zyKYxxJ4xnqA3wNSTc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6875.eurprd04.prod.outlook.com (2603:10a6:10:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:10:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 10:10:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 4/6] clk: imx93: drop tpm1/3, lpit1/2 clk
Date:   Thu, 27 Oct 2022 18:11:57 +0800
Message-Id: <20221027101159.942843-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221027101159.942843-1-peng.fan@oss.nxp.com>
References: <20221027101159.942843-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a9cca0-1709-4e06-bda7-08dab8038828
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O63r03NnTsxuUoBMyLoasR0YAexviunE8MlgUL2CvUYjqk+YHm2x9rl2SoU2avqX1ljyMDJk3GiR7rBozhB9CMvBeKj80eViJGYrk5M/uZ1xJyLelxg6K4b5wNs0havlEK4MxxcegUwb/nUzq97Zn8Th8WWLFs1Uva5plzqmLW/UtfP81cFQQ3hC3Y3Rj5Var/yzI0jatfe488AGSdd4ILOeJOR61ADXCTghz/179FTnKI2tntJOaHKuHyn9PuDJxaQQmyDSsUdmYdZI4zaSHhB43et8vYwwnXwihq+gq7gUmX5Yt4qcyAc16mKYuOlDBQoyjPUOmcU+0yaw4y7xWBPcMNXJvma5crrMXXpEWvOVrOH+xldL0YAKJcxFpd0XwpstuHH6SevqM+ptq9eCyT6mkxoztAlq4z781R/iuBBbnEl9AJmlZ4jMe0+UCgEVl8yctONNhZEaYj8lPCHPsj3vbg+1ozzYoAxqB5/gxQ6BLdnL7qieVWB1I/wl4s8mQzkWQd2Gh1T+86v3REk2MOIzDcAHdiBJTztryZj/mPm+f4AAbxk/yKI2PeD3j6R35wcRUxiRUwXjVjlTanBFltUwSXDq6zbtWgbqkYMFBJhfXbp9oiJTWsbmdHGYIV/iikwocXncAhGGumkDjbvuTw/jiKQLKvm5yINW+ywc/ibJ7KlA+jr08C7O0xiRB0H947RvcGsiOCHcfkQocSYRRCTA4rbNv9GqbplKaEltS04/VDlcnY/HrOmUP4Zj75GOqudFKq+lmAYJfcwmHOLi1EjKZbcJCFcVK5KbRxjyRnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(66946007)(186003)(2616005)(921005)(83380400001)(38100700002)(38350700002)(2906002)(7416002)(41300700001)(1076003)(52116002)(86362001)(5660300002)(8936002)(478600001)(26005)(6486002)(6512007)(4326008)(66556008)(66476007)(6506007)(54906003)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xxf9TfjgNMBy8cMBRggIUkuO1NdXnKRiwE5+XxfuUdsxgBpVoLxN8KBZN8Mh?=
 =?us-ascii?Q?HGR/2CFotYsSf31K4tUCz8HzkaOKOz1BC8PpJuHWQz4dpN+ap3i0MUIrGPkF?=
 =?us-ascii?Q?W7YjhTxqrBtA4PlgiC3uXL0GcaD0+vfKqXdJBBesKKNrFMxGh7Dg1uNbZE0q?=
 =?us-ascii?Q?pnuIjzd3lX/UI4Nt2mSH77HRPR8jnHno/oTThCXZz2xK03yHOOlM69xrqw7/?=
 =?us-ascii?Q?Dbc0PTDwWg8SJ0Dco1bn+QeEjZB7latELBVLg5cFMaXCtIzfQo4rVZxjLprt?=
 =?us-ascii?Q?wjwFbZSfEesUwHNaTom2gEuA7Buv8gG0OyZiaucHex4J8uHikHoWv1hukvLU?=
 =?us-ascii?Q?Y9C6amdsBhaZX4KBVl3aMcqPewhvmrglfuWfRlMgmIjktDctHi0gOWoG87EM?=
 =?us-ascii?Q?LcR/k6g3zV8eWEECu7yud1vh6wDjvWDINfh0FOFpRy8onTWoQ7sF4w5C05ZG?=
 =?us-ascii?Q?s4BlUxSzs0RaWpa4Oc6iI1Ep1V/1hcKqZnXY36RSZXd5zvNlIDglb/suCoMP?=
 =?us-ascii?Q?rC8UxVVCeTEGWWL3pJ/v8StFYB91nNwBMKk8gooHf159JCD89EIde4rVKj2+?=
 =?us-ascii?Q?swx7fdQGBTb64M8gZn/jIfo6pDRwIOTAIRpG3zi88Bjdium0cVUdsr5aBDjz?=
 =?us-ascii?Q?Mf5tmhRWRKxac26fueAFNiDPWUoQnZszoByQY7Fb1w3ZLULpp0IX/NDMgwHv?=
 =?us-ascii?Q?jiiPvq9hesqe8pwSkX9LyljZKUP16oUvmZfcTA9lnR6zDiqEzdZ3IVR0xkps?=
 =?us-ascii?Q?jW+J2Z5QccPhXSF74EDtW9G0uFS7fPvE9NuapnmPNqa4FSvZzbWAtKZv5vtf?=
 =?us-ascii?Q?OxW0o7p6480WqUveuz/+s3S4f7OJcprwqB4Gl9eh5EPQVAUsM/GQjq7N5qbe?=
 =?us-ascii?Q?GZgibS4WbtWnCOZNFc3NPP5VAA6CgUawB3EyR6wmaB4q698uiAa8CcXPSnTy?=
 =?us-ascii?Q?qKhWCa1KM6yUGtxywDHZswOR3I+CkCqMH5JUy63x3UJmRE1E2F6/Xp38Hg86?=
 =?us-ascii?Q?gT71fGHEVNHTBEfnatdgk0GuYZKzWIXfoqDx/BDn9ixjSSnCAzrqM1AqmDGE?=
 =?us-ascii?Q?9qaJx6v6gqUuA/UVt6RA3ATe9Uccagie306vhxdxyjzEceVS9plhFf5hh3oB?=
 =?us-ascii?Q?6vXfnRn6yDpMhHberlQ28VJLW/GsSuPdlrW/w3ASmwYw+AWg4kRhmg3SAn/i?=
 =?us-ascii?Q?ENw8kErwxbG/YfkJH4PoB1MdD0m50/U3f09dLfCjb5a+aJmSzUBooQPq0QHF?=
 =?us-ascii?Q?JiZAqyMx9E2Q4i+aUTUcxkSFdQ7UlecH0R8I0n/o2nD03S3SSo5QfC+EPDxc?=
 =?us-ascii?Q?h8hIZAbQZfJPZDt9NSckJOwC1uQGs2lUCzeUPgkmfqIG0IsscjhIqesAGOK5?=
 =?us-ascii?Q?cckk5HCSne6Q/ulWD2Z1LStrqJ9A/07w5RfZRvFRQ5EOhevXO3MOzlkNYjmM?=
 =?us-ascii?Q?cAUhbN2D0VB7Dgzj6X7kNq44H47J58Aixr4/LVnsd67UqGR+5JGHvH0HM9Mm?=
 =?us-ascii?Q?AzUWDuV6KQMPsi8MfgjmDyKRDn1JaR4O9lKFmOZyFknX7VnGu6LWUlBst0j5?=
 =?us-ascii?Q?AW8xaDZmW8vXeVaIUElUMohELVXztlyt3pB1NOeM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a9cca0-1709-4e06-bda7-08dab8038828
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 10:10:53.7330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxA+v3aHJDtxc1BypY8vtS8vLOb2lJWIzDb7vDeoWDf3uDTBXNTn89UY3KHZI1FLIdTCPIGGLwjNzABUXafw1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6875
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per Reference Mannual System Clocks Table,
LPIT1 and TPM1 sources from bus_aon_root
LPIT2 and TPM3 sources from bus_wakeup_root

So update driver to reflect that.

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 7fdc30062a46..422ad3c89845 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -64,13 +64,9 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_LPIT1,		"lpit1_root",		0x0600,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_LPIT2,		"lpit2_root",		0x0680,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_LPTMR2,		"lptmr2_root",		0x0780,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_TPM1,		"tpm1_root",		0x0800,	TPM_SEL, },
 	{ IMX93_CLK_TPM2,		"tpm2_root",		0x0880,	TPM_SEL, },
-	{ IMX93_CLK_TPM3,		"tpm3_root",		0x0900,	TPM_SEL, },
 	{ IMX93_CLK_TPM4,		"tpm4_root",		0x0980,	TPM_SEL, },
 	{ IMX93_CLK_TPM5,		"tpm5_root",		0x0a00,	TPM_SEL, },
 	{ IMX93_CLK_TPM6,		"tpm6_root",		0x0a80,	TPM_SEL, },
@@ -177,13 +173,13 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_GPIO4_GATE,		"gpio4",	"bus_wakeup_root",	0x8940, },
 	{ IMX93_CLK_FLEXIO1_GATE,	"flexio1",	"flexio1_root",		0x8980, },
 	{ IMX93_CLK_FLEXIO2_GATE,	"flexio2",	"flexio2_root",		0x89c0, },
-	{ IMX93_CLK_LPIT1_GATE,		"lpit1",	"lpit1_root",		0x8a00, },
-	{ IMX93_CLK_LPIT2_GATE,		"lpit2",	"lpit2_root",		0x8a40, },
+	{ IMX93_CLK_LPIT1_GATE,		"lpit1",	"bus_aon_root",		0x8a00, },
+	{ IMX93_CLK_LPIT2_GATE,		"lpit2",	"bus_wakeup_root",	0x8a40, },
 	{ IMX93_CLK_LPTMR1_GATE,	"lptmr1",	"lptmr1_root",		0x8a80, },
 	{ IMX93_CLK_LPTMR2_GATE,	"lptmr2",	"lptmr2_root",		0x8ac0, },
-	{ IMX93_CLK_TPM1_GATE,		"tpm1",		"tpm1_root",		0x8b00, },
+	{ IMX93_CLK_TPM1_GATE,		"tpm1",		"bus_aon_root",		0x8b00, },
 	{ IMX93_CLK_TPM2_GATE,		"tpm2",		"tpm2_root",		0x8b40, },
-	{ IMX93_CLK_TPM3_GATE,		"tpm3",		"tpm3_root",		0x8b80, },
+	{ IMX93_CLK_TPM3_GATE,		"tpm3",		"bus_wakeup_root",	0x8b80, },
 	{ IMX93_CLK_TPM4_GATE,		"tpm4",		"tpm4_root",		0x8bc0, },
 	{ IMX93_CLK_TPM5_GATE,		"tpm5",		"tpm5_root",		0x8c00, },
 	{ IMX93_CLK_TPM6_GATE,		"tpm6",		"tpm6_root",		0x8c40, },
-- 
2.37.1

