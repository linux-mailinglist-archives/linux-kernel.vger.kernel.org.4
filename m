Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104F26D40E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjDCJm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjDCJl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:41:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC41042C;
        Mon,  3 Apr 2023 02:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNdaq1WxjMjCpgxFc2ettnemsPWH8ZgrrsGZ/Fh3FIY5cAdJY5fOxHM7Vy5bRG+9HaCcmPBGqtVP+KDRbIJ8SlDztxNAPqYFPyo7x+YPVpCkPPBv7O0cwOwXRmQnUhELhSytuzc8FVvOR5Ac/V0iaywjMngnR9eqGNiB7ff5x4IsE7VlUBLduSygcyJ9zf6KPRpS/RNH/AOjI7VRnsqK07NsLOeswR4PF6lSfDPhWhTP24Le7KI9k9MR5p+QSPXLRunY2fnx8xjn+R8Imw7afdfZx58tfBB8NUuj8wK8ue9j/d+B8N9c3Vaqp7WjJ1O14EBBCPRFQNhSxwyk61X8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeU+p3mt1VU7rMhuY82PuUn6y2tJIgA6xQikgvhR620=;
 b=IeoLTHAVD/MrtqtK1AuOTG4N5cUs0c+HOMk/IMTtXyO0r9DrY+uaJlVpJVJ2VSzXDMek4bJoBiXsfsEKtEpFe6eFi+STuLVeVhFky3fDC4UPmB4laVup/L7HkIoPY0SkenU89BA4sE0T+oR24dmcG9Jk5zbMAROJoC8++4sNeHtkkm4DlDUQM3ZLXL9HnS0McXs+yPceomi0DV0WncSgvwtf0+bk1nFr7ROmiCZgf6na5qF2gn9JK3S5s4rybizqC/WvDnfOxRfEtgsCeA6/nqeRkEK9mpen5AzO16JQwcKkVuo101pNzumMNmk1lDRcb88ws0Gs8BTB76lsVcvyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeU+p3mt1VU7rMhuY82PuUn6y2tJIgA6xQikgvhR620=;
 b=OnFXkANHIpamgESqdP7nIMNZShFehX2cILUS656ck/oCtcasxxF856rEeDTJYp9sJVgwUdQ/aGv+XFY63q76xXu+ef/ysLlqyfqHVXjK9q2loKHsxrdW1JCQtLWiI84QgZBOgf6hhFS7vS44g5oYlLWE2FtRNP/fCXT0C1ykI/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8595.eurprd04.prod.outlook.com (2603:10a6:20b:426::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:41:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:41:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/4] clk: imx: imx8mp: correct DISP2 pixel clock type
Date:   Mon,  3 Apr 2023 17:46:30 +0800
Message-Id: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7d04a1-22b6-4c57-1c2a-08db34279d30
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xy7M4ZB/EloaxhcL00/+quXQPlMLASQIUtoyh91z/Eo/HecPB05QKef2dT00p8GkGRXCl1qqCvqhC9d6FM+aLPXgk4A9FpMvzBdZSes8IlxMXlEcWSjUFTa7cpNVR0l+Sn2InvQ2MHxP+fXWKdDjNJVuSnQOGeVt3uvYNCNbzWzq3TUCNB6/28U4C3cGb/0rjThual9sLLT2isr5GwEqRyTUE6MxDn4uO9ELlOsviT5aZjx3uC4xt2vDb6vslPyx1LuKJx7Fw3SusFhoS1meWWcdB/FBWKevU+fl4lrZq6w7OMYR6EgQVc/yfcpeHpJYwxA0XmHDKbJnr/iCCB8AqcAkYGL/Bu4yTpKK/NhGLf4/DA8/WvN83SWnJmXy2NDeWomPBxfP6YUiJDyd6MpXvtPZPAF8DfLHJqF5UKklDtEyNN18kjcDLdz3VDqDBAU6r9J1iEO/WSN4xUIc9t096u0dAYGpackZE9Z6KAnLKbdy3PcNb0x2yGDW9thytg7DPC/3ky3omXxZpNRtasVFpa2o2DXM/oTZkp7+R/BRg9jN8D6KuUNs6JIKSuBb/h5ct6pcLOLnpMt8fgmkJRMQcrmuzg19bOHMLe3hmPAzHZq3c7ks3UvsVK2o2lDCrOO1u17B1pixA2KiLQq46SKGpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(478600001)(8936002)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5xq88sq1tuYV0LLXfoZ58kM8hyPMjjkEQun/CP2QWXMCLkeP//beTK76Pfg7?=
 =?us-ascii?Q?k7eiBIqjWY5bEZr0cV73eLJpbObms+AGUkZP6HT4bA5YmEByN2HOP//TRokR?=
 =?us-ascii?Q?BxL79W1GdQjKLmG1sqgGZ4MaWiqrsYvYnduqjsvnCowFi3j8Ymf9WWmpvcC7?=
 =?us-ascii?Q?Nb+LHVOyMnk3iC8UX41oSQF8vxYkIYlBZ9Aau2PtsSsTcmIrOdL03N/H9qKr?=
 =?us-ascii?Q?p6NcqEp7NSDAacnMvMP7QEazQBFe1ODByUf141LBYkle0m5I2mI7Zo5Y7J8Q?=
 =?us-ascii?Q?icVfLeUSsR3hd3NdR86C0UbXXrYxxsy0F4CvQfkWqRM9t710IY/5xs5jrDvo?=
 =?us-ascii?Q?Zb/vvbnroLCkCfZ49EQwCchtAFhbwkXBUu8RIQfp3PSWvljoSUYPd0vUcWPh?=
 =?us-ascii?Q?fI43JJJbNiJB0Oc3j+oU/4t9z6AazItuEK19Zx2ZoYW64aQySFC6tt/iqaHs?=
 =?us-ascii?Q?kU+D5AQrZK8XH/LIkMo3tEfAWldqGeNyMCPLLqm6LMKhcUPlA1B4gUlPa2wi?=
 =?us-ascii?Q?MQdg/SbzjcUeV6bua3gy8WA4t9nOYfeNTEWBgIvcGsiiOeGxO8sslrc7/PG0?=
 =?us-ascii?Q?rjb6fEAbyL5FLmOuZrJKCVugy16DLUIdam1wv2rXgqw5d1++tKMF0rThSnrv?=
 =?us-ascii?Q?dFCasZbnkzn92MQ0RtIrYwTwYLtCGXPwXufUz3bAwxY42R55C+bMbERNcGAe?=
 =?us-ascii?Q?8X1Haso4FnNULNy3YW6jZ/SbGnscTBXLOuqHznOr2Yq8LEqbM7TIzTCmkBiF?=
 =?us-ascii?Q?RrGI01Z7AJXrbx/SBiUs6XbFuUoxm4eti3n6PjOSZiMpX6z2gAPU36jW7QGS?=
 =?us-ascii?Q?kmUGtfYq12/bmSZ4Lr1cI97FRkR5O23qQm72+pgqZQsXuR8Q8a5lK2gFI5hq?=
 =?us-ascii?Q?wkMbKPPuL9WIU/2x8XoCQr9Q8TcTbi3Lhxm/mhB5gF1R5GdfjGAQaPx7Bpxo?=
 =?us-ascii?Q?91NMewWeUlY7ZEZVDpqhXKDZ9MDIqVRj/6iLC2dWtrlWmWrx7hFtZezQwtys?=
 =?us-ascii?Q?fiAqogJ5EMQrKFQFNesDheFxkgqhjeEMZ5j+2k2yp5DbkEUcxtfM2NRc3L5o?=
 =?us-ascii?Q?iVvsoqIcH5ewTkvu9yzMm3bYDAOk+TtJPslXxQAOWL8IIQVhReM2ThjiIiiZ?=
 =?us-ascii?Q?gHqz7c9CT5YjJ+Wi9O9uhk/vlzPmWJR4fGD+Bfob0IlUmIzalz8slRxM81t/?=
 =?us-ascii?Q?0rmmavMSLppGU6BlYwvlj+aepCi1qjpMSNOklHgy2poDHDWmXxJmFGkunXg/?=
 =?us-ascii?Q?u1Hy3uGRhKVcRpHeLvtFpRbSJ+lscaUcnorXO6fDNA/SOQoRzZmr4G+4lxFa?=
 =?us-ascii?Q?i9skXNDwDGerw0xyX+E+OAHqeT0J6JWCRlJ4jiVDteD3o/RwGixOJ9NWCXMH?=
 =?us-ascii?Q?MEhLq9HR5kyHZzOG3waXycvUJFu+8MMVbNp9foInhrV0VXIWArxpx3C7Bia4?=
 =?us-ascii?Q?1ftHPjgeG2yrguIJBY16S/sv3SU5H1XX5e3OR5K+Vxwf065FssPCca5yYNi5?=
 =?us-ascii?Q?B+YHwRXi5jSBXrlKdfUpm4pgt+62n7bYdF2gEAJ4DToORdhsjKIs58kLHmAu?=
 =?us-ascii?Q?uWdu6zaIXjRg84fW4g1Qu16Jjg2+Wq2aq/ndE6IZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7d04a1-22b6-4c57-1c2a-08db34279d30
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:41:35.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmRTQ7PCgHt3oWnlrWIPOx/+8eeMkclw/FNykojt5ccOooUWJxs+zhk99j24miodPwKFOsyXzi8fG6NP23GX3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8595
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

V1-V3:
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

