Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4027D6D1844
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCaHPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCaHO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:14:57 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DDFEF8E;
        Fri, 31 Mar 2023 00:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCS/gEB2VG4OBmrCWvXHOlBFRDt11MATJGAQfuFvjWQEu8ZhUTdkzOwtZVgaM+aOikxgJlx3eCUeAPcLgCXtE+uNhzf626PegPniz97B+JstQnBYkeehpvdhqTStHw3EFpMkZPThR/l5OMpB14Hp3tBefe/MGr4WLgo2uKwrSB5e/grYFFuMPCHJDjWvfxwa9FleeYarKTWuVSI/i3Xs2e2VCMUMsiTUuo7E7fwIUfsFdZP4GVSEUJGcQhSQs6LOS4W7ohSqNle3nI4ewkqU1VrAnLsiHhlDWi5NzDOry59kw0Ets+vcJhIbEZIIOjoDoJe+O6/1lbvNXdfgJxValQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMQwoP4yfAMAiSNzTr+vV8Mc99RY4Tr9DgeuHCa/AvI=;
 b=WrQ8hHD9bMApviPF7lSh6Gf0i8xwU7Be2fLzNi0uEoqvJ0X0FV/pLLiDsatL3YaUKKVjFGvHyxMDUcDk8rQKUlXZashDUpYqEE31dENprsBP8FlQTawHXmPe1C2ciqR1TKG6QZYRMI8LPatyifKGRDzL0XSNVXE/j6LBm2ctb2GEZI29YdHlNYo5bJDaWG7xbTNBd5UG/AqBDGlYKXA5/f4WWa+N4CMDE7j6v1J3wLQ9xY7pOo/BcrgrKMFnKcHP/qJ5ReopzgxV1BlGFWnNse9STRLoVKEZtNMwcNxjkj7km3T7hpUskVAE9JKqidPfM6ji7BEOhxtRMdau8CWXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMQwoP4yfAMAiSNzTr+vV8Mc99RY4Tr9DgeuHCa/AvI=;
 b=SAKPvUtXwC/IiPd2Mp5NEwZAgZvegMRu9Yy2OU4c/PS1Fsd3CpgAV+QEVOe+OpimuJ9m44dm0lLSrMx7vqDNoG8BFR7gP1N3latG07NUMXBjuBAv7EAMKOyrTLukyls6Gti8tawk63P8k8Ij7f5hJMbIEg9XDS29pv8OKiGQmyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 07:14:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 07:14:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] clk: imx: imx8mp: correct DISP2 pixel clock type
Date:   Fri, 31 Mar 2023 15:17:59 +0800
Message-Id: <20230331071801.2483686-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c90ac6-f765-4de0-60ff-08db31b79de0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAaOYxxQYmC5IidPPb0v4v8JFpS6kzntQcMCVTbjM/imaMVwB/Bb0YdImX32rj4sSdULsuTx2dGi/Hz/WVFhqHu3VKBt7cp/KYJU1uj4jtczdg7sQEJN+6kKMFa0SmelcVleeKxvFxjHSawouC4BHaaDXLu9GdWRPZ4XtPIZN+TtCDjPtOVRH3WK1hSd1dR67S16mj1isPM6eRXatOoU3ejMj17OsfnURPkXX/Cb4QpFDd+w5iFy++dpj5dEBYypLyr2U6YyF1b9FMERwwaXVPK7LYTAiVdyBPpFK2thE7bT8ceWjd6NGBYRpEWI26XPZO8BcSRYz9tva75j/UJjyPLNfVYF4ewAVOK1o9wy2LwWVd1hTWju6AiY7GU55/730hZn3eO4kywpQkEwXYXKuu6E/2JwePRNgDOI091JA592uaPAi84t5umGzQs9Z9AJYLoHJDDZD6JMXUGgh7pWw2UrVdT2nwSqyqlWp9TL1jXleAgyoincQ28lnCVpSoK4B1Iq7ILy8lrqxx9G0KV2CIlE7qafFV6CXsZqqq4lzHwrJ5l4gnq6G2gQHfKsr0ED5XxvUL0hgtTFVByGugPCdPegiby75QPXZzfXHCIMAUdzCF9LG9UbfrhrEUVDwZCPADxVsu15eh3AiXwMSQNb3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(66476007)(4326008)(66946007)(66556008)(7416002)(5660300002)(38100700002)(38350700002)(316002)(186003)(41300700001)(8936002)(6506007)(2616005)(83380400001)(6512007)(52116002)(478600001)(1076003)(8676002)(6486002)(86362001)(2906002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQVRyt/S54dAur4fPy1UPDdWPW8GYRynWEEKdZhiqfmyZTmN8hrHZLCHC6c6?=
 =?us-ascii?Q?iVNnd224HN+ljZVj5l16DHGFTNTAGf9BVe9SZRq6Ev+IhfMrCpyCI+YKXF7l?=
 =?us-ascii?Q?EQomTPfDIHkSDSRNXec2ymBNAgJJwo/oAOhg1p/Ya3v4bCO47dwrc4HgHAQL?=
 =?us-ascii?Q?by3ZbpUny3yGhPWf0DeOmhznztQb4Qrbyy1HYJkLIGSkDvhROyCQ7eKf89f6?=
 =?us-ascii?Q?8knQ9K1UVgvv7o4npWrR4ywwpfgm+lEOfzL3t+uJ4rIqNjTMOtyIcqHdwosF?=
 =?us-ascii?Q?S/SuBCXlToMWu7fmskzQsgcW8czvVUDDyaO/S7RLiyG2lEyJuOkKdorMZqgX?=
 =?us-ascii?Q?RzBOSGGSFRXMQbsXB+zfGGQ/ao4GedM6mgl961yh//bspe265ET9rppcpfFO?=
 =?us-ascii?Q?alJGqg33bXoLkv1BBAKyCBgHnjH/SHXJqddS2pQwTRX/kRMqvf+PE+5jzQbQ?=
 =?us-ascii?Q?+RfBbvyvKZaPeU+ylJaLZl6eOdY2bsgNQthKYcAzZfs17lY07h8LLkUT9Aho?=
 =?us-ascii?Q?ETJDBGhQiFmzi73tGhSaKDzNxESWB8pMjHzL9XeWeOYAQLNgr2K3aw6zj1po?=
 =?us-ascii?Q?9yQ+r44K6QiiRfWNdpc6Xc5eI9Smr6C2sCM8emu7zSevZSwz88yYIB388AIP?=
 =?us-ascii?Q?jDWh2bcD0yo1RqD8+eSStsE/ynG2iYlPJXGsABUNc+magyiFrOFeYqJczysI?=
 =?us-ascii?Q?xoVvfM0UU1CjvkUy0NtroHIDpjQYGnkjQvcggwBXLXmY3/9NjbxjQm6bX2gK?=
 =?us-ascii?Q?wv9PYQ5BEZQzXridnIf+3L7iqhAzHNxId2ZwRnm/vQj7YwPUkg6NxSSn5u8i?=
 =?us-ascii?Q?o3LbIqLqii+R74Fh2wJl5SQaU4CFBKYd6JtRMu6GAsFsXpNBVVLui2ztnhLV?=
 =?us-ascii?Q?Xc4FH0zxQKanJ18DHCYd8jc273JqqqC4geBNjCYAvvxpvg5eMcsP9SdI7RDQ?=
 =?us-ascii?Q?uyfGWvUnoL4d2dVHHHK0OtDpyr8pceUduXpkh61IehBfjoN4bzX1Iu7Cq+8I?=
 =?us-ascii?Q?RaTw1aGUHxK+WUq4r1tz8HAeCQ8YbMbwfny2m0YDjojTtBcDjNim+TSUc5R0?=
 =?us-ascii?Q?3IRS6+rodSKA1Syxre2OQ5oY8XKn/ecLtjr+M6/zYJP9T08QbfPkW70MlHm7?=
 =?us-ascii?Q?w1eLcchEothLbuEsI4ahLZeDqBD4Eyu2GVM6aaiPwM+160Y/BSz+DFTXUfWD?=
 =?us-ascii?Q?FJT4Wt3wVVZdK8wLbX2p/0/Js3HtinhVey6xbbTRM3dFlQ8oQaP8fPVAiWVz?=
 =?us-ascii?Q?mydXZwk9WNGjni1MfKo294Xf+L/qymnpqeVmy7SxiMyFF5g+M9HXpwoKKaFG?=
 =?us-ascii?Q?4Nglo5+kbgJTSvgy13Q1CWnGjPGerzVdNLRtK6o6FjVXnxkIOPFeKP7MV3Dx?=
 =?us-ascii?Q?lONQLcOxs0apPP+AGJl7UnXjtm41ZWWXevPvemaIYjCbBMhodsZBngqxI0c7?=
 =?us-ascii?Q?uI6zG9ffblSMt22FSDZuJHzQzL3MuaRtmovtH6vRfr+7e2HNeFm8boNJk2dT?=
 =?us-ascii?Q?57I1yyuc0Og2cTQoeGM+w4w+o68/8jUZqaEr+6XiJIoQLafgYfYEYbxeMAoJ?=
 =?us-ascii?Q?C1bOdfEwVrnWoNIPdZNPZTcPUKOXrqUDxM33td75?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c90ac6-f765-4de0-60ff-08db31b79de0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:14:50.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y07O+RQ+SOUQbPfpkAG1lWFAklGupzEX3z96ofvKcb8YMBG1VN8spGdmcX4En5b/DAq7KP7tsxYjNR9Vu6bT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879
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

