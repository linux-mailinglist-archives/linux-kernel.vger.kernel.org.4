Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59F16A65D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCACyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCACy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:54:29 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF972278D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:54:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4d/C3DynbsCjIeNADmzY9qpHOhMczQSWBiXuPw8sKqtsvb81muSxdn+uvRL9vZCRdHvOV2Xgluf+fjSY32Tub8DDc7G6SuqarLkWTLmCZb3NGXJJV/2GRI/Wszgc1em9lHePWaY2rMmwjFh/TbCh4mBJ4pzVLz36nRhR7bdKDJUZzX5uMc7UsMIt/30468tCb94/WWW6IMcdrSEJ5ZrbdeKDxU0PWIY2m0Okhzs8pfHJj8iWUflSNJZtsWxrytnELTbIYL0pPcdXRStjR83pb+NdP73W433CYUZwY2HUfUXyZagCsrZbQVWTlsK9iw733UuL/4hjlPU7lXxJ6ticA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6QxFozc7iqkcudItOb67R3Lq9jbwASL2d6vlsAPwNg=;
 b=bPFxYCJAXTrzXAWsdK87vq+y3DhoMt5bHIaJDXAghdCSSDzcUhIK5dh6DuYY/H5riTr3LeIbfSpLJZDUMHWq57fnG/Hdrh1qnJd+gPxJrerBOh+llhGbN/4n5pzQrSrb1L4cmqNcgKUkq/OXD7P1F8YmRO5hvVitpvK/rJKifjtEDuM2FwuErMd267iG2zeDUdFlCJMVx/W5xWJ0CYCP3M1qcis9lnErXkbO7emt5vpWf/9jDqxIOdEV1AFQgaA7L3HQXQQwOnRkAv3j6PdgEJDdskAvRBZzH4cRGGp/Hks8lsU9ZrESTvAL8wUZ2GI+IpMRe+0W+GRQgrFIjzoYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6QxFozc7iqkcudItOb67R3Lq9jbwASL2d6vlsAPwNg=;
 b=AvfTd7V5qGeJ0xYWsGKww4OaKGV+FEBIL2ZTywjkxiZu7YnYi0jecMu6dnTXw+6GeggNu2RiEkinlkb+DWO+g5Lw74oxVzVnKhj9YH6FSxNPOkUVD4a1DE0KqJKIRuZrB8P8ZwLok6gZNGUkDfCCAQSWv1uN4F8SesOvlz6il1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:54:21 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:54:21 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH v2 3/7] soc: imx: imx8mp-blk-ctrl: Add MODULE_LICENSE
Date:   Wed,  1 Mar 2023 11:00:38 +0800
Message-Id: <20230301030042.2357706-4-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301030042.2357706-1-jindong.yue@nxp.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8a4ffb-e8ec-4bbe-85d5-08db1a0041ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kJoON9Y+Wd/O1Ejfa8y3hhv1GNW+SYEbKFuvpEqcboG0uZEQXQ/w1ZzTbEtycx9UwRwk/AVAqBPEVJAAYLuVG2HAKI4nReDSw3l6VKLpiQTxQj11uc5JQ8urX3n9R4jCVGGSAmfVZYcQBpIZcnMjWp7ot2fzQpVdYbwIC6/PsBk+0nikEKnveGnr/a12vST9pG8bqRTfvkr/YxgBc+nHT0p3luSZgWSYv7pfG6xi4BKhG+1TcG9Zzld2uu3FSanbHYcH8MvbcwyTFfcbQ5DIbNVcF5Yxep6z3wBdntgYCc86KfT8+y1a4PZW3/F+rRDPYgwxuvL3nJ6pstPpB0gOmy3R9wzi7OMoZeJnSAJdkYY82Qb0+9RUa9Nk2ANiom0SruTktwzxBQU6WMEihm/nRi3KYjTNOS6rC4+1Krxbn9ANHAxyRr6P5fXEtmv8RTwtstfLuPOePrtXYacoTRzDTW50PsAlSShHbVBJ/8fvSxoAyIO7YJOTZ7uJlW3ENK8k/J0PLJou0uDn9jWXapSegbXNvHkEFYAg3VK2NgHqjNmJGsdMnLt9jdmTxzX5t0CFUumeZzyn0A4sywv9gXQAkGT9tlqgI55guGLFXO144zMO08dqjTbN1x0imC4S/kHiEpdeMThhTZOcbdWut2D7EXReHYbCP29It4LyYdp/mb8VkB4XV43+1XNtehGOwGQOR1pd1qN5CeSgQfWDsaJKcWk4J9+Von/wWHNmMIW6Hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(316002)(86362001)(41300700001)(6666004)(2616005)(66476007)(8676002)(66946007)(66556008)(4326008)(4744005)(5660300002)(186003)(478600001)(36756003)(44832011)(2906002)(52116002)(6512007)(26005)(1076003)(38100700002)(6506007)(38350700002)(6486002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?or4ESyrPNMSawyF0H4OApqfQhkjBdYVDu0B1rULmF9BzLYwBuIRHIFYVf08O?=
 =?us-ascii?Q?0b1GtL8QyKFW/Ijnt0ff19qULQIpanqMUotxJkPdYT7C6ZlrzVMGwhBlVFGL?=
 =?us-ascii?Q?nbG2uZblZbGfZ3JaGWtwGgda7I9Gv2F2DGMZ/JygBIgIUfQU/0E+j3AIcHhD?=
 =?us-ascii?Q?bDm3H0r4G6fndH6AFQGZeXpotpQwzHmH2VDw7HXzMx7IY7HG6wgErVgYCIdr?=
 =?us-ascii?Q?vaD7XbkiBzK6IRHMc2ExUuzESV36olXCrfcqZsl6oA9j1DENj2/CcSVAO/gB?=
 =?us-ascii?Q?AXR1F7Lo6/bazCocNDNG/XoAka8rQJ6FTZo+2A+4YmvSY1dZUO3zrFlNorNY?=
 =?us-ascii?Q?J0vix6hutmQ7XBmOx439ePK7LwiG6xV7dfzj6hiTN415AHEsbqajdR2hofsX?=
 =?us-ascii?Q?gwqaDjzv/2zKAdr10hy3sj8eSMShIJyk94cGG2kwAeSA/X1htKURcxjKFKcw?=
 =?us-ascii?Q?coWQitOJCJajbVthNpk7RkwdKzgkNIAhQcaXvA0Fn2M1iNscUfYoA/1N/Mj3?=
 =?us-ascii?Q?eB5ZcL6bxPNIqEUHMCnceF4kV0sJsyCbXucrsKuY0ggzt29UtunE2zsm87oQ?=
 =?us-ascii?Q?tF0jlAeElwa/9PAK2VF4mPVUSYUFAfY3jXasjVX382cXkMoS18aq+7nXr9/B?=
 =?us-ascii?Q?VvdYVnM8gAoIwd7jMHnc2Vy2lQ8MEpVbMArrBIRxnX3i89bzSlzQVwSCCIU8?=
 =?us-ascii?Q?9aqcKG8dxH4Yq5q3qzqdLSKqEMMsOvayq+LFrZByK8DurhfEnMA8P7rt3RyI?=
 =?us-ascii?Q?Pv5IOji8jZv4VMUbpnl0p1Ojdx+nwevBXjANl2zcBPnR10zThLCRp/UXgg3i?=
 =?us-ascii?Q?YVgQg/chX12SVsQo6P/zQ8xxuOpwVA2xbt7aSCwy7mRhVuncIDDcO22WKtmX?=
 =?us-ascii?Q?T0M3kUAxITNY92UISaRW4KoioC2Dr5+HM5kM6hEwfttdMVEBJdzat7u8Nf+i?=
 =?us-ascii?Q?x2qCu0aw0PFbKYUNVHhg0BaMMsm+Wcbh4DjY2j1MFPxFP68aU40i3BcJPb2N?=
 =?us-ascii?Q?19OSH8Qsrw0xt33i45De9benmZ7a3XYGSO7wJEAgDTQQnLlgfshqcJn/F6hf?=
 =?us-ascii?Q?OkBaiQKpxQFruDhtCUT+/toDQmvkHGBiVIdPQLj8i7ugpPgK6R90Dk+Zdmki?=
 =?us-ascii?Q?uo4sWv26ASMjMMWcYr2PDuCKp7CaY9xTT1l8BTToY2QX3WNWnDRvhwYjkk4k?=
 =?us-ascii?Q?nCe18ZcAnLwMh0gwi4N+qik7aPNKLG/weMqFMs2OEgjB7STWI3A9WcnCs09v?=
 =?us-ascii?Q?1HsKUn5UvwE5ZBA0Rj/5cGJasNIwD1XKV4gmCiP8Wj1ocdQzOQ9stT8nzji/?=
 =?us-ascii?Q?p7apgr6jbgIsvsgQ8dSEPQ5REsWUanxFpCDkUChR57JEUR3UkQZTOOgTD/aO?=
 =?us-ascii?Q?YGD/dsO2/Oif5Lldqbcg5GR+StWaPWrxvf3RwisIgN+j9p/ldsIIkYACiPJR?=
 =?us-ascii?Q?2YFrhgwz8ZDirhwmkPAMDoqLe+SXL8IGSKE5lpBmhm7/cWdUkWMi1yLMO+4+?=
 =?us-ascii?Q?Dr15Zb7S74IX7jgGbwLDazxthx0i+8rivgEN9Vk+21bBNb0BBQB9dl1TcqWv?=
 =?us-ascii?Q?G8yMIDhkmnHC57JTA4FRp2HNKSOTz6kKgdcHEgnA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8a4ffb-e8ec-4bbe-85d5-08db1a0041ed
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 02:54:21.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G1kHtxIYHI7mI285SP8pnCwT94Z+XiHT8GsfE8y7zQiu7sW5VM4OBWDPKq9peaILmmyplgtlPD4i+tOFTF/ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_LICENSE to support building as a module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index f109c7bd6658..870aecc0202a 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -864,3 +864,4 @@ static struct platform_driver imx8mp_blk_ctrl_driver = {
 	},
 };
 module_platform_driver(imx8mp_blk_ctrl_driver);
+MODULE_LICENSE("GPL");
-- 
2.36.0

