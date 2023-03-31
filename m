Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203F56D1780
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCaGen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCaGeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:34:31 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB0E191FC;
        Thu, 30 Mar 2023 23:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1N8CdvycLCkZMzLknB92BJLSwkP/MKOww+bXJaWy7PVla/dJDCMT/olF9A/6cciefXQuQ+vSTVyEALL1TUp1OP2h7QYtkFsXRl6BiA0joUFs2eLksmjfJKk7fAJrdfmqoJDHYN7X1DfVKKpbZGPTEYIPi8LGwTOIEBDzyCYnE40TwOaUBf3TwTBLt52+EemPpMXhsBHbQIhxLgqN6LtG6ztD+Nnb1qbIE41wAMPdYEG+uqQLXlXrtY3dIOJ+4dcXMFCi7Hkv5mj231IaRQS3ceHZzg9RZMuycgK0k9kfw6yM+eKueMy3VRF4C4HwyPYUCl3sxSG+s1UEGZ8IpNEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g52e/gArTcO74d8AJAS9yrysCvbKh/YZMc+MCbysIW4=;
 b=YlSwl9OMtcpeU6gA2tHpG7hQAcLvrqMC0XkS/tNmjhNXo2TdcB3081O3aR+b1WaVXqZlVJkebARMkRXnB+rzOkHNm3LJaunKvci5r4f4LM2wD4eQVSaSIWKxRgeOH3vjmn+9v06uBm4b3XKnO32084zM8r3t0oPPuDiFtSHxyuPHLlzyN3OQF1pUWS4Uo9qryVET5y2rwuAPygkSos7etelo3K7Kd9joPui20UFGAfjr5xY7I8Hz8jCfgTQD9Y+9oQqnfRmkbzM4DdxtyoheXcfl2n4q2NLzsBRUdMJ2Yh8qqt1uf82z/pQmHgvs0i8EY2ehz40s0eb1HZOvAAjkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g52e/gArTcO74d8AJAS9yrysCvbKh/YZMc+MCbysIW4=;
 b=K2W9JHqEBcw9zkRzqG9BSt58bgDeMwMmlfTAx/JeD78YmBu1QX5z3DbA2OXJKFLNgbMwTSEzCLLx29ha5mpZxfeyuTk+PkkbfKQ+dN7cJvilS0YiNNoaO1LoIWucgTSx4sPmMXQOx7bsv0Cwjs5Gf5KrBrLdKMl+akB0atQPblg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7356.eurprd04.prod.outlook.com (2603:10a6:102:8d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Fri, 31 Mar
 2023 06:33:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:33:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/5] clk: imx: imx8ulp: Add tpm5 clock as critical gate clock
Date:   Fri, 31 Mar 2023 14:38:13 +0800
Message-Id: <20230331063814.2462059-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
References: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: c03f6511-e737-4f7c-7162-08db31b1e14f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0E35tkqs7n609v8Xt9YPC9wlaDCBTacZyn/6553ChM43m6HyKDsepB66tZS8c7pR78MZaVNGTJX56wMP3TuLbvp7aDx2xFqort6lqFxtNpiNKkZvJOUVPiFDfHiVLIpmWR+4ebp5fZUQ5V6A0nM8Z+VnwSlttuo7cVZuOktMgm4vFL0OaF91rE8UnhDxlD2kPUuwVsGqm3R562+SuxTacc+HDCqrb9gUAslSgEccu1DZDu49HOR+9nS2tbg2RpdENsDVY51mrYyygYXDjrWc78lu2CJsBRETNjaM4JFtOoXX+Hp2yeRvhJgCdlrh4LrIRjgimMNBksBYfcZo/MQh/OqxK72cReEDyLJo2dMXetV5ONMqpazLgwww0cDFDLqDqE7jIHYXb7M2jbcrOBPD0B6bHp4aGE//hjw8Nm7X1HzlzW1MNF5MU/lVsFaUIyBAG+mg9l1DrSza+ZCI1p3gx8QW+xp9GSHTOjqe3FUlOjGGpdh1fwQhNxrgCh7aYZ27msyCAxEjvV+6OnrlwChIjmzkaSBo66yFG+WBDO4aZ3ZE7vkX0xx2esqMw2gg7+QWvg/Onk35sjnOGeDgku1kterkSrht1RBVw5jO7rYMKIhPNZ9DgDUDgvw/ma4L9sXd5MH5yF+flZQxQz2+vRAzoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(38100700002)(5660300002)(8936002)(7416002)(66946007)(41300700001)(38350700002)(4326008)(8676002)(66476007)(66556008)(6486002)(83380400001)(2616005)(54906003)(6512007)(26005)(1076003)(186003)(6666004)(86362001)(6506007)(2906002)(52116002)(478600001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vmMKAfyl7Ypl2gEaAoi/9ASB0HOsnGoLtyV9BrxlEdkq5RevR4N/hEUDUQQJ?=
 =?us-ascii?Q?FrJ1H28iIQ2gEvEbaL+ky2sp0zG89pq2Yfho+tuRHHHp5Ed3nmHHE22yM6zO?=
 =?us-ascii?Q?qvGubE6j7WtTRxfjVNnzQsovGoK3Ts52j5dzAWbWL/Y8boQCVSV5607geshL?=
 =?us-ascii?Q?ylejepSWvkQM/54HozISaNBF7ufj+PNJZrDAwhryOAnp+6gO0/XQZyqJEj/8?=
 =?us-ascii?Q?1ugVVJmnaX7jdK+M3WfXB7Cw5uKINVlLEKAE0wapjS4xOaPi7DCYBMbZm7AE?=
 =?us-ascii?Q?IS3VAfpTjmO0mk4vGsJYsjA3ItduJc6/sSinjSvQTyZ1fR4HVERpUex65XZm?=
 =?us-ascii?Q?MuzPuQcN7LSqKVGQGO7kH1IQFPKhEOqrxJHkqQJ+JzhcxudRzHo887k50etx?=
 =?us-ascii?Q?3OUAQF17tt1yZKA4e+0rFuA+I4tIXT8YFN/2M7Y+5p/wbG7c5MIcX/2snGU5?=
 =?us-ascii?Q?tKReNcz7Y42GyR3FEIHSNzeQcYT83+fktb6YT8rW7kpaMz8rN67p2zB2//uX?=
 =?us-ascii?Q?eMXz6v9gKcMQD/jMGJai0+nsYmx6cWUZ7lXoWW+GalRmizG2lN2IIV995Uyy?=
 =?us-ascii?Q?iXZSfCLZiowK7fmSG7+d/qWS+Vo6w/o4ELS/5aRN/rjB9zPdHHeBtb+3bQE9?=
 =?us-ascii?Q?rUwG1Ftf3jU4Fz82LSeW2Q+frXS+PgVQjer/EoGAFqmgtbcME1B61g3rErBf?=
 =?us-ascii?Q?g4k1XZ597JpSbR8yjvpdQiGfEsDdZMyPMCcRBMvtCGgU7pc2azIKVvsGdc+A?=
 =?us-ascii?Q?oe3GX+GufzKEjj8l8pRxqGnknhjZY9wrcxCqySYTj1KJe4XALCSLta21hdzA?=
 =?us-ascii?Q?N8h+30C5eWI9tQbb99JdrCWfi3sCsuwGw2SassTTeFxMnCeoFjSsLdA4ZwHs?=
 =?us-ascii?Q?sIeaTwzI39AmF6+l05GVD47Rir4CtEE0PEoE/ikM5kq2Gk6CGP3wpKnaZKBg?=
 =?us-ascii?Q?ISzY2RlaxBm47WcUL7vll+i6MaT4buII5bsvlacX3gedJKMUiVkrpKqenW+7?=
 =?us-ascii?Q?GmDYY0IK6ueDCBxPxnOU1PkCUHg21VDDBS8oaULxJ+PRrzfY20+AgSaXFzJ0?=
 =?us-ascii?Q?kbRs9qDKQRHdlCyPS/qBVnPb7xovh6KZKHozfirOoD2/HXrfNqzTmRLgJ/33?=
 =?us-ascii?Q?iYc6OFE33+4DCixCQa9hCCSpsza9TwsHw1L8xPWZfDL3DOypsNcwObLKDGWG?=
 =?us-ascii?Q?r6Dhc7OkTVF/q2Z9vNskrxn/ABRiAnC9jEyft+wgMOzEzdDcZlNVGyujOU9j?=
 =?us-ascii?Q?IohvDvv4iJdV7xv7rc0mHAQpn4qi9sr3vL7y+e2wLMQe0Wb2dCeCfeZgEhOY?=
 =?us-ascii?Q?ZQTIh9fCSN0obfXuFYVjiOkA8RdKmYvd5SGBZ/TIrfiCNvYoH6MtuRzrobru?=
 =?us-ascii?Q?WszSLkGmxTsbTOmlOq7KI9nP87HEevWtpWySjznU+ivFt4vGVoWjhXnO2iz+?=
 =?us-ascii?Q?bIpGEGmtWfF/5DaFExZUWfH1r5+MVCDaFbDhn1ky1xQNDBDuNWmW5Ww/fPEo?=
 =?us-ascii?Q?6RcAnHLO5UJy/9CzrryDvuiy8YtZaecZ3MX/g9aZJ++8MpkEEqHzPoBaL0br?=
 =?us-ascii?Q?R/9mYScuMRkzN4KHIZfbt02RkKLr8k+WiKJGsZJx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03f6511-e737-4f7c-7162-08db31b1e14f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:33:46.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBLGSYH/rkfJm9GMIqeJ/H2xUqbU3JDCeGjV+Jg73P9KnSKVjo4im2VE69QopvuovtISMutNFFDPKqm/AKfKAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7356
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

The TPM5 is used for broadcast timer purpose and registered
with TIMER_OF_DECLARE. As the clock driver is not ready at
that stage, so the TPM5 clock is configured in bootloader(TF-A).
if we just remove the TPM5 clock from linux will introduce a
risk that the TPM5's parent clock will be gated, then lead to
TPM's channel control config can NOT be written into register
successfully.

Due to the above reason, we still need to add the TPM5 clock
into linux clock but register it as a simple critical gate
clock to make sure its parent is always on.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8ulp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
index 0dd48e8159ee..6a8a9e50d826 100644
--- a/drivers/clk/imx/clk-imx8ulp.c
+++ b/drivers/clk/imx/clk-imx8ulp.c
@@ -333,7 +333,6 @@ static int imx8ulp_clk_pcc3_init(struct platform_device *pdev)
 	clks[IMX8ULP_CLK_WDOG4] = imx8ulp_clk_hw_composite("wdog4", pcc3_periph_bus_sels, ARRAY_SIZE(pcc3_periph_bus_sels), true, true, true, base + 0xac, 1);
 	clks[IMX8ULP_CLK_LPIT1] = imx8ulp_clk_hw_composite("lpit1", pcc3_periph_bus_sels, ARRAY_SIZE(pcc3_periph_bus_sels), true, true, true, base + 0xc8, 1);
 	clks[IMX8ULP_CLK_TPM4] = imx8ulp_clk_hw_composite("tpm4", pcc3_periph_bus_sels, ARRAY_SIZE(pcc3_periph_bus_sels), true, true, true, base + 0xcc, 1);
-	clks[IMX8ULP_CLK_TPM5] = imx8ulp_clk_hw_composite("tpm5", pcc3_periph_bus_sels, ARRAY_SIZE(pcc3_periph_bus_sels), true, true, true, base + 0xd0, 1);
 	clks[IMX8ULP_CLK_FLEXIO1] = imx8ulp_clk_hw_composite("flexio1", pcc3_periph_bus_sels, ARRAY_SIZE(pcc3_periph_bus_sels), true, true, true, base + 0xd4, 1);
 	clks[IMX8ULP_CLK_I3C2] = imx8ulp_clk_hw_composite("i3c2", pcc3_periph_bus_sels, ARRAY_SIZE(pcc3_periph_bus_sels), true, true, true, base + 0xd8, 1);
 	clks[IMX8ULP_CLK_LPI2C4] = imx8ulp_clk_hw_composite("lpi2c4", pcc3_periph_bus_sels, ARRAY_SIZE(pcc3_periph_bus_sels), true, true, true, base + 0xdc, 1);
@@ -378,6 +377,7 @@ static int imx8ulp_clk_pcc3_init(struct platform_device *pdev)
 	clks[IMX8ULP_CLK_DMA1_CH31] = imx_clk_hw_gate("pcc_dma1_ch31", "xbar_ad_divplat", base + 0x84, 30);
 	clks[IMX8ULP_CLK_MU0_B] = imx_clk_hw_gate_flags("mu0_b", "xbar_ad_divplat", base + 0x88, 30, CLK_IS_CRITICAL);
 	clks[IMX8ULP_CLK_MU3_A] = imx_clk_hw_gate("mu3_a", "xbar_ad_divplat", base + 0x8c, 30);
+	clks[IMX8ULP_CLK_TPM5] = imx_clk_hw_gate_flags("tpm5", "sosc_div2",  base + 0xd0, 30, CLK_IS_CRITICAL);
 
 	imx_check_clk_hws(clks, clk_data->num);
 
-- 
2.37.1

