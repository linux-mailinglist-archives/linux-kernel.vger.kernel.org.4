Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9086D3EA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjDCIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjDCIIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:08:15 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2041.outbound.protection.outlook.com [40.107.13.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AC449F3;
        Mon,  3 Apr 2023 01:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPTuZdZB87ClcIAi84ppJOqzG8vs6agsJ0i/SHrFSeSUzdqY20wE4LU37hQjgGyFoEzZaUK7SF/B9thYAHHN1unBaa90p+JFKSQQTSyvOPBFuyr1orYsG2ueIYDtOeR0T1Tw/r9Ri1PsJhjZ07EMI8BzFc5FMD7Po+6z0HnXr1yeEZFdP7/QVlsPeHChLsNrvr3JY/fOwpid+uQD44jIwwYUVleAH39acy7geP/e8uSTq6eTN7Z0d99bl0RvQeNpx88wPB1zVzUTLGKi1QUT8A2Kc5Rk00NvCUebvgNkVyaicXtiDmGbMZx9Tsjt37vw3/lygO7iFfSLFGPGmJlDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bin0E3s1mjmaXfsfOxO2a8iuvirnuPMBAYhb9uYz1Oo=;
 b=GFB+vxw+OkMSNBjygW5CUEdFxUO1rLeKBkY2zIhOIxourfJwEGHHsP/6rLoCwHfjNGir0GI5xtRbSl12ZdwU/WN+Plg9ApdjOQK2kYWx/tQ4PtjYZgb6t93HmTJkoG8VExhV6pK5kFauJ5nXtjCHMlfuh4gug1nOeRTtO+1ZDjrIo94FDG7rZH0uksEGzs+W2bMb6BFU3j5l+r5UOQUQrpG+3BsajkgXWA6rdK64A3vvwitNDrDui+hScYsLBtGXvBwHI+w0l+w5AWUB2RjOPbWTUa3oxrDbRgPzpycQT4AcGu6cRNXlkMchQQa+2JeyhR0D7hf976WujBoS9TJnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bin0E3s1mjmaXfsfOxO2a8iuvirnuPMBAYhb9uYz1Oo=;
 b=OxQwXi0LWOsRBAK6rxFq/WY/kVo48KyeAbCRrGLviUAsvoQVbg47ECM3knLou3ehTt0pYSd/8F7SWlVz7urDzE+IyH+xCsi6UK6IF7TxjcwiydQIANwTy+XISO77agt67eclpTTYLQ2nWX44tU1Qo9/Xczz2sVq8PiZID+NkIrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8090.eurprd04.prod.outlook.com (2603:10a6:10:240::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 08:08:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:08:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/4] clk: imx: imx8mp: change the 'nand_usdhc_bus' clock to non-critical
Date:   Mon,  3 Apr 2023 16:12:46 +0800
Message-Id: <20230403081246.3194230-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403081246.3194230-1-peng.fan@oss.nxp.com>
References: <20230403081246.3194230-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa5df57-e985-4fa3-850c-08db341a8a95
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zMCVv3Yprj4U227hgKhsgORqWDBAft47niMfJZiiBszjhCOP+ujKzxDtHzFQwB63CCEETotqEPahePtV2AJkZ1k1wPVH6OjfQC2BRaVevx3/qTDFj/wZebnkOihzkvMdoSfDNjAaxQMldJ3CsiYGJ6DsC8VrR5mz2CBIr9WRuyetgl12DWQ/l+FCKxHJmcHtwalZdeGJGBMy5APHA60qWWsBVmz+CHNT/ruaPVBilmYmQ5okezEZk3S6pkeHr5xZurKnP/gcmIKVVShV7C3bp+0sHNjDa82gNL29vJO2aHXcJhDzgWxWMv7eZ/GJlRUZnnXuznSCUlMcOSRdrAV3GfxSn4WfKZ+MWVHLcdSsE7zrILy6L21MknrURA2WctXxviV0ewRwAbUZ5Fidc0q6RApaxF1RKgrEpMyTI0PtUgBFBFLQ1dJ+RIaK+PWUy0nhtH4y/+p4OjalTIR5qSzExHYp+GeHScGiPLhFNaOrj/j+ZbyudepOyVGRSEINhdXq6NEpwvXSbTcSFEF/OvgJSEBD85PuBd/qR9kojv58Dn1NL5bxBjbbR/L9ZSjpcNGNS198hMhsfj7fmS6dnbYvSTzELqk+l0FPb6ch9T1qVrCPvCIgSJdXXISAfRuFQ7MoNONvP2Z+FzMjpCjISh9VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(316002)(8676002)(66476007)(66556008)(41300700001)(4326008)(66946007)(5660300002)(7416002)(54906003)(38100700002)(8936002)(38350700002)(478600001)(86362001)(2906002)(6486002)(52116002)(6506007)(6512007)(26005)(6666004)(1076003)(186003)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ABoy84zTl1ALjO3QNUcoP+LHRRI2MYjUBr89DzxYfsk7wp79UEvYnJ6Wf7uD?=
 =?us-ascii?Q?9uF7F0X59FxvTIhajOX3HBV5Fh0UKvUuOSQpOwxNxRd4BCTI4fVvk8oALZK7?=
 =?us-ascii?Q?x84vECvBzNXj8jtubO26+tlquYI/DsC1LMUfVQHLjFFve+X5LwzqI4jlTZSG?=
 =?us-ascii?Q?yKPB4XCNEglDRxt6UJbbUnMWwOVOe8kS+/l18e5gNuQOIA5W/MQcJB2QS050?=
 =?us-ascii?Q?UQnzJdowXqpZbnxX0myu1rJySU1DcDv5y2dfoc+NGwH/CtCElZFFmW6Mpa93?=
 =?us-ascii?Q?pokhc4jmYglcgN+t9KVjO1Ykh704BO1eB4XX0/+EhjQ6MMRkWLRube1URAbp?=
 =?us-ascii?Q?eiSln74LRCaF41FFVSeslEpnSvIxgbDsxqi46fiDiy6Y6VTNR/DmdGU2EGIW?=
 =?us-ascii?Q?duNHSc5YrG0KhCJVFRXKjiLQFMJBF/nvsgmIejLcsl5+JFwjmx7SiLUuIcva?=
 =?us-ascii?Q?eoCUc/ESUMXYQV9gwg9IbGPXydSTZNky4FXsURK5ADxSxJx7TZZoSFDiPxfO?=
 =?us-ascii?Q?2YTzc6ZeV7wukxVB654fil7PNrkG9rVKhdF3GoyUxED65Hj8ysfsFmU9HzOh?=
 =?us-ascii?Q?1VnUIq/+NmJkC6+e8wGnClEIBNBaoUqWhMwwsvEye9gWdTqFkptU8iI+xRlI?=
 =?us-ascii?Q?szlbwCzQQN7xveNoDgJtYrEKo/7LswN064cioPJwmA6SklFJBaawF8J/Gbeh?=
 =?us-ascii?Q?UUc/dR8SEaQUJ7QR8j6EdO+/+F0F+jMWvDjV7jqSNfSmQL+Vh6AI8k11f3Oh?=
 =?us-ascii?Q?a1Gt12pKmvHHjtsp7/iPqFipiLHhbIFBgYIynZg0ZEo94oq9/oAsiXIAYiig?=
 =?us-ascii?Q?oUnG4//gCkdOTCurM6uWTF+Sy8Su8XinonkGkOIIMlB40V7f3KFc3YMzGU15?=
 =?us-ascii?Q?mmUlEo5A6hPZ+SWhu39BoGbr95WDNTB/xY84kdAnJW6qnV3m+H1i0IzRgysU?=
 =?us-ascii?Q?Ce7L48G3zs8gHwL+jSRppHLwaOxMnWLZ1skj14vUVm0BdJ//TFSfNG1iaQaS?=
 =?us-ascii?Q?SlF/Aay31xqvz5HkgW10O+ZlL4PCS2/doWRtERofY6EzfejgeNvhuWdWG2Nl?=
 =?us-ascii?Q?04on1oIfNsekzeSSLq1esMiYZeWp0X0rASLD22TRxjGyo/vInNQ3sVI7sPUn?=
 =?us-ascii?Q?Hwfpbon1YOeUJNt/kJATGkC6sKBdHPhYLK3QD3MgeKdLV0DFXahQZfGxyV73?=
 =?us-ascii?Q?vayW77uxfLGIWnjtuLVi0FFpG8aZIS9yIqwLTG7gDGiTdnBdyuMVGIvtOx5Y?=
 =?us-ascii?Q?Lo6qmk/90Njh5ps/i0XLdARrPyTrV/bKAOIv9PZOjr5cYzc3NtdCGxXESdza?=
 =?us-ascii?Q?Laf3odih3ueZzj5BSL90Kw0dcgjsL5JI0wReuq1pJGx+a/5IRJ+FobYnUw+0?=
 =?us-ascii?Q?+A5Mw0gsqH3s51/TvIfHX+1ZtmEdLtQg0BjHwQ3buCBLh4sIuirLBSuUrq4q?=
 =?us-ascii?Q?/Y/1mw2F602xAe3PeyB/WzJirRzaMZGH6R4R4fj97te4PgpF1lBezJue1dyw?=
 =?us-ascii?Q?ZL7/zp7c08r5RseP3wgBL6/JkmPmJ0H3KZcK/qqCao5yvIGWf/0RYgaUOE6+?=
 =?us-ascii?Q?IqB0+wFK7AybwDawDmiYieOLFZcDtq6ETkERn5ov?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa5df57-e985-4fa3-850c-08db341a8a95
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:08:00.4369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sN2KAjz0fJxCilnKhGp+l375V2EulCy0YA7dEFL+JIeqBnPbefIECOX2VDD1CKtX89zcxenHoo7QYBEhUUcCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8090
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The 'nand_usdhc_bus' clock is only need to be enabled when usdhc
or nand module is active, so change it to non-critical clock type.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/clk/imx/clk-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 8dcaeb213277..f26ae8de4cc6 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -538,7 +538,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mp_main_axi_sels, ccm_base + 0x8800);
 	hws[IMX8MP_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mp_enet_axi_sels, ccm_base + 0x8880);
-	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus_critical("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
+	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
 	hws[IMX8MP_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mp_vpu_bus_sels, ccm_base + 0x8980);
 	hws[IMX8MP_CLK_MEDIA_AXI] = imx8m_clk_hw_composite_bus("media_axi", imx8mp_media_axi_sels, ccm_base + 0x8a00);
 	hws[IMX8MP_CLK_MEDIA_APB] = imx8m_clk_hw_composite_bus("media_apb", imx8mp_media_apb_sels, ccm_base + 0x8a80);
-- 
2.37.1

