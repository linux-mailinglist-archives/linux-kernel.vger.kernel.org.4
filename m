Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093636D3E9B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjDCIHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjDCIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:07:47 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F110E;
        Mon,  3 Apr 2023 01:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZGN6oeAl6gTkICWjTeixMOXRLAoc54/QdBh+RTqZ86pgPqteb3zASFXt3+TIV8NdbMziCyK6fu0ROufn8AFX7Z9dCa/6/OHNipnD5cnIWlqU4QQpMpPx839gMtI+6uUDHfajMUHMH1AJBXlj4Ubvog9WKuK2xuRWNIJQFkvDd201NzcZMCkDk8WPrG7zFTzhOPwZwGgoaS7INuYxwzQlzDc8ZqytHVvSpFI5V+svAHpObJcSmtk5SCJEMa8WUPIf/YL40CeDqiOJ/YLpFog4hcVlhOZOXBHHfjLt7Hq4yhAcm4xrpxM1R/q6IphmPFOP/AI//ujXbDq4WZK+ToKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6J59jH+LqyNW3TxttpZKS+Cm1FENBgDVFJD7tQnWDw=;
 b=SHuBX/Qv5b/kZmTMObLXjN9661X9TnSKMTr/blUnpddQPqszaOZhb/Gy55W8kxf1xR3ANLCSFI0+KNdRyXAyx5c/SSQVZifQuo02majTPFtSTDhiX4bw5I1F+Ft4hlo0PeYbOvHzAR1afFa9aA9arjZt0ShUt+p1ZUPcZw0+SM9bgD1EdwI+CM6IgDu39Dt5YrZWw/ApkILXfkHpAeIHxmkmgmbTlaV9nDFZwLpVsWee74EqWUJ02KHl4iSkzhLKd5XbZrUSdMzIDC63uEFfLwpsZnr3fpnvEq1UEb3Cgz8jfA8gPo44IU68c8nk4oHnKiLhbeTWbCnG4N+G3CijeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6J59jH+LqyNW3TxttpZKS+Cm1FENBgDVFJD7tQnWDw=;
 b=hU5f2+Z6SBMjqn1TV7D0tLi7Gwr23GSIocy3AJDRcGibwSfa3GMA0XC52BJoZ4AKlTNYmXxwDhLEgt4p7vL5In8urzVU+arwERUPuZvYmwKO8ocIHY7cIKMxklQ9xA5jH3xmbH15g5CR/By3F6GEhNVSpkXgKIMM8pFayVK+cG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8090.eurprd04.prod.outlook.com (2603:10a6:10:240::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 08:07:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:07:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/4] clk: imx: imx8mp: correct DISP2 pixel clock type
Date:   Mon,  3 Apr 2023 16:12:43 +0800
Message-Id: <20230403081246.3194230-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bc8747-5c89-45a1-4aca-08db341a7fbd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tcRKXWlX1t7cJFqsIFxgV+Onlnld4fyI5BGlY8yXui9TeaBP30gwDAW+SOoNCTNKSWO6KXgK8Ki2xEe6f7kbNk+2HVVHXnW0CfBGDMifjJOMklF4KWpJO8ZG9EJibZgZsXAi53xeD4v5hJy6RS9C60s1HzPR/eep38cm1SF5oUWdecypVslLifFvcmFl3lLbgvs1QxzcHEESsdWGHpRHPb8hnRFOMs8vZ8B9jPPB3vvDeVAaHIsEEBSe87hl+wkvcuFMCynAbd4yveOlAqLpNCJeQeYA84w8UkiTioFc0bn3uskpBSrC8DdtqDt7MtHSMTl2O0JfIqcj29RIrnAcwrLDDQjz3iMuzX2iAHLvrZwvcdal78aKP7d1J0BIaDsYsRvVa8v6bpYly/yeQ3XRfRaiVNriBDWItZuh7hCv9wXfxaa0DD1U5fePqoBCks0RHSrjkfUV+97muY7bFCXC+xizCZgg1aMP6+hhoATyHiATiaUB1hx3KKKUEoanvt7J9VSPGW9rRzNxJgQOQAeLg9wun4aP4lYKTOU+dDNb75DYg9N0CRyS3hCEuyoQSJuiF4+nz8S9rdorV/8oXerKpGAR0fDqrUF2Htfgjl6roj+a3AZcyUekndEB7sHjOyYl+UFKuO5lY6ts2LeSfK1kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(316002)(8676002)(66476007)(66556008)(41300700001)(4326008)(66946007)(5660300002)(7416002)(38100700002)(8936002)(38350700002)(478600001)(86362001)(2906002)(6486002)(52116002)(6506007)(6512007)(26005)(1076003)(186003)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?edd1NKhQOUXZr9Zo8qMGcEPa0w7XiO+89lp+K/Vaxw2GtOjCNnLWRMR+SunF?=
 =?us-ascii?Q?HaEFD+kIbU1woBLkHRdOcrqSajPpbENBydm6o/tXlXfCfCvm1++cBJ+9BdzZ?=
 =?us-ascii?Q?vEm6tDzVIqHFaRdLtWKSRYzb/QDw64HnxBjiZTE7+Mv6gA5pz55fwVZkJBCV?=
 =?us-ascii?Q?ZGFRvNMyylAQwFpKoq5ZGGSr0rGaPpZrxcSCY5ICX5UfLTGhcB3/a+jhfhsR?=
 =?us-ascii?Q?PokE4VAniLbiKslZadW+X+eV6yEjviK/5KaVThOm6RlwZTA9WBVVjeeCjwQq?=
 =?us-ascii?Q?co6caYmbHOdB7zTpGwxbTze2dMUDGEztlawOcMCmPsyisHDEkvimUjds9tjb?=
 =?us-ascii?Q?XcBytG+wS+losSBhJvXjo9Mw6D7Wlgr2tC7RdhqqxHcCvjtmnpXO0kZujkPt?=
 =?us-ascii?Q?pC7HX2kmi4GAJsa+X/9TuFpi9XJp5JAVKnpxuhPBZ6fqxtX7ffOpTqd4s/Pk?=
 =?us-ascii?Q?/O8+nq/tbSp3FVYnBp120PAwGK/mW/n7qfCLvAPATsFy1bGcHM9HpTA7Jyqp?=
 =?us-ascii?Q?dgUPyF3T1/EhDLGxdEk4foNVB6RMqR7kbLyVfNXCvwutys1IYF+7YnET6usy?=
 =?us-ascii?Q?AVNCH3Vq53zDXcIO0KSmuGWr6BytvFOhkPi7CEEMz/DQBqj53sr6/IBViV5o?=
 =?us-ascii?Q?Zk2pNxWtkAAplJ1xvrZVskg8d5Oj3zRoAkFJjN5cbYQMgX/1nfOiFljBY6tT?=
 =?us-ascii?Q?qLfrpg6o62F9aDlunKaPuHNRNcZ/3MoeaocUPCpboO2G+lqUThsrVn7ZGvb7?=
 =?us-ascii?Q?9DrMwscyzqW/mUAhWv4qfSlfPskSWUwn42h1kMIlTaG1X7RGwzG0pxW4L+ox?=
 =?us-ascii?Q?sb8wYWcyy5vyVP4I8QeE40OdSl2MwnF+KgNI0Z+AkjnnTqluA/7csGHJcapt?=
 =?us-ascii?Q?ca/zTJ9sdzaKqm63Tl/jo7qUYAu9Wy+ukQ6d9OuClevj1+FQDrM+wwzDvTpn?=
 =?us-ascii?Q?vrJnCzRsiDsQIfC/y1HqCkPPHLYzVrq/n8NGBfCdNXOxLyaMUGTSqQue/aX4?=
 =?us-ascii?Q?mFETdQCQ6oecnGmPXxYeMwESlqBhlis67sjfvXX7MBuRZr4KrAsDf603xEhi?=
 =?us-ascii?Q?mQbjCErhaZ5shoPkOvDUyI8IvLYRNkKee7bN891d1Wh/k9JoI6S7PEvpt7SI?=
 =?us-ascii?Q?EGq1nx/wrcP32J+po1/J9NS8FHeqvjPV4Npd2sEdc7xwV0XvW1LTgceuNOr2?=
 =?us-ascii?Q?b9wmlmZvuB6RWmOByOq6iKjvaWJZO9kxm5BBYSUqRFf/P/gwnqULlmjmU+zM?=
 =?us-ascii?Q?ZqVtg25rfyBP9J+9n1VoEl0Be2qqmK1mBRuKcDPjCncDhGXp0hssTUlJLlfV?=
 =?us-ascii?Q?96o7ZK7FJYV1ZqBvN6RLC9kf2O1M+q7VKpCUhY7luaoiANg8fKfUIB3L2mOD?=
 =?us-ascii?Q?mHfMyrrYodZMeSt+IO1jznYvc5geVALqC0kT5kp0PVx10G3SMhpyDXM99Bc2?=
 =?us-ascii?Q?auwkqa/VgiOFNBPCT0d3f8x+8q9WSj0/N9KQuoAjDzl5YMwhVx5qEuW05+xd?=
 =?us-ascii?Q?UucogUsdwRlzm+RzuUvT2aC0ZkPzehnCzL/PMbalVzwdGLj7OqyykHwiPJPi?=
 =?us-ascii?Q?GA5IfJI0asFs+uRbEJZm3PtxrWKPREFNT/5oXous?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bc8747-5c89-45a1-4aca-08db341a7fbd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:07:42.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTEryKH94hdJ4NKWOhh6G3+F5KN6x9xrudZ/bltp6Lei7tpm9799V9kDprg/suiDVIO6E1N8ufxR9xpFLa2TZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8090
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The MEDIA_DISP2_CLK_ROOT use ccm_ahb_channel, it is bus type.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/clk/imx/clk-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 3253589851ff..4a0f1b739fd4 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -554,7 +554,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb_root", imx8mp_ahb_sels, ccm_base + 0x9000);
 	hws[IMX8MP_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mp_audio_ahb_sels, ccm_base + 0x9100);
 	hws[IMX8MP_CLK_MIPI_DSI_ESC_RX] = imx8m_clk_hw_composite_bus("mipi_dsi_esc_rx", imx8mp_mipi_dsi_esc_rx_sels, ccm_base + 0x9200);
-	hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite("media_disp2_pix", imx8mp_media_disp_pix_sels, ccm_base + 0x9300);
+	hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite_bus("media_disp2_pix", imx8mp_media_disp_pix_sels, ccm_base + 0x9300);
 
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 
-- 
2.37.1

