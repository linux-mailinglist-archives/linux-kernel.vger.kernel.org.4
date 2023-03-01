Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88946A6CB4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCANAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCANAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:00:13 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA873E60D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:00:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGrPHIvjf1lhBolSTybCjrl9GuRusxB4qcZgYs44Ujl9bkg63ItCvr/iP6HKSi7wiNRuVDKNYE1zxApwPcdph8dxfIrSPaUTmtYkbGS7NuKeB4xiH3N5wITWKc0ZR6P0ERRgRvpGm4lvrnbs+D1oFVrhPqwgSHpFCkc6Q7NBmFB+bB9aS/LND7IZYyqAltosGHljf5i2aVR8XilnTYAT5AKlSttpncguiMM5WIGXIv5WjzRW4EA8b6FxCVV/q9eJ+ui5CQGu1bFJtLOsv3p+OKP7HF3LuOx3ed5CmKctP6Rur2svYS7UpPzdSboZlpZxmyQ8OUGxiEAxQbCCEbxKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOnWzUKrhijvmUwXo4sgRebVbbFhTe5B5WnY6YbVQc4=;
 b=eyMu0CoubkQiisKnEmPy4yu2lVSqQXsqXg7cz60NpyGZoMn8qIKpBazDn4RLmfHGz/Fl4XqQkK3s0x+yAJ1AHkl9r3Gem2sUGcR13Xg4uO/uZ5yIbf+0ckrdbqkCi8y/YBzY9HCE9Z5ukd9S3WrAyvD73q3Fpq52NHNlPi1H/Lz7ICHiiWRucJF2yakjccKF5wz5znM8BTMQKnalZgJ+8j+diGTvylfpst/049+QJkpI8Sk2pn7gGyRkVobA7uYjqjXABhonZunp126vELAkryPRPwKuPKZnNdYVcapqYYzfwZ530t2KtVD1DMoZ1apz1mgGYji2gM5iPQ2W49fQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOnWzUKrhijvmUwXo4sgRebVbbFhTe5B5WnY6YbVQc4=;
 b=MfIFpYFa+v9PsH0XADxpZF5MxUzZJu8YAX7667iuTli3y2tev2tctEFNGLaU7Ck3miyJPywgbf41bMfQxXxKoWPndjEEnuD/IEQrugHBo+nMEN5PHHMWmUNcoyWFTQuGlwKpTj3CCuzishDozaHWcjwgHNkiun6khC1Lo1gAMgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 1 Mar
 2023 12:59:33 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 12:59:32 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, m.felsch@pengutronix.de,
        jindong.yue@nxp.com
Subject: [PATCH v3 3/7] soc: imx: imx8mp-blk-ctrl: Add MODULE_LICENSE
Date:   Wed,  1 Mar 2023 21:05:53 +0800
Message-Id: <20230301130557.3949285-4-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301130557.3949285-1-jindong.yue@nxp.com>
References: <20230301130557.3949285-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS1PR04MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 620450db-c697-40b0-182f-08db1a54cd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hq3lUUBteArjMERGOCyWXYN+S1LoR3A8CrGAdAW7utUK+aoP6asKz35ME5yCHHO9VTN2gdwFZP7XX+7Dgb45jMT2D8WXa7cgJKulq8XRhw8a/FhdRWV3RLa9u8ySxiY7bTjlqv5CkF3z2FA/E4dP09mZx/35K93WTEV2hh+lLCqGNijV4I6LSbp6zetbDfPegNtIRWGZh+xdw5HbAXysDfFICKmXBkz7FYGZVa88mOXVdZ6c9HfGkDxB/cCgp1Q3AL62WX0ySSnpwP02s+9eQbSLi+UkLcy5cVlEi1TgWksf5HY5VISKHzWqFuPPqpKS5IlX8+NAT5CIz2fRYJCHAFV1oWpRUSoBtqJUvjVpYy2NZZToiSxhd5M3jKH1142CNMfFaWF9Iyou4W0vlqoyBruXeEf5VNB03p3KRO3YESxzav7D/DNHd9XQx8WzxFZ31xIwIqi8Zdo2e/I6G3HNCZdVQiHNB+TBP3o/hEv5Q5ChMV+gzS8NxrgAwRenNhV8JAKuViRp5LcnRAfSBWsX2x56AB+BB87byo4973TL2z3Bbc7MdFxousXkPIMBbJ5AQeQD1EG5B9qrYH0D/Tr+sKEtmNGwc2LfVRXZskEHf1ryGx5rbYRYIRh2ZTQT381fL/LGQvBFaEWPW/VBDQkCBQjyZsy+TtU4VP9ZKwCn+0M8fTqQjF29aF9iU0IH2XBfju8W8gQKO03FXiVPw8Q6feo9IEf+d/Hj096QNyPCpP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(4744005)(36756003)(44832011)(2906002)(5660300002)(6666004)(186003)(2616005)(26005)(4326008)(1076003)(38100700002)(38350700002)(66946007)(8676002)(66476007)(316002)(41300700001)(6486002)(6506007)(86362001)(478600001)(6512007)(66556008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DsGqsP+zPwHKXZMuY+HD1cfketTWADRPOrvMunKZkEUoprE+KsXjS4RkqMDz?=
 =?us-ascii?Q?veT2uoQJdQgFzo+BbJ3IUlARcA9BHkfI9HqVqjEhZhwv7Y9ghlpamJeVTzvn?=
 =?us-ascii?Q?A8FtUHwqxpfukVV5/4HGQg4CfmcW4dGYle5D7QHngC+q9LTZmogf7ddt722X?=
 =?us-ascii?Q?ToMKWD/xGq4AjcHys2BalEzQeRwqjweiufjf7EV6Wd6jAQbJcTfF219lSqf8?=
 =?us-ascii?Q?IQt4cBrIQ2gAe2VhU134jciVMGnpHnIGBM6h79bauCVTace2np5NPHgGpn1k?=
 =?us-ascii?Q?+RsdYx+rf43J3bCBVj66fY04opk3g1k+5TQoHaYPtmhKLcRunLnT6FI332LJ?=
 =?us-ascii?Q?aOh6joaok/0w5J4VcvtwiuZM8dNgrVogNVTknJemanaAwQjd+ZqO8wRHRNpn?=
 =?us-ascii?Q?IS42rPHdJHKQsGuEqPRVI4Azm2nWKs9qTRJoxBInN+cBFCRC+G53nZJ3iT5w?=
 =?us-ascii?Q?mi4VQo0T5zj+NtAZq/K6Udm2ZAWBpqj+/+fhLXuPZcW8BGNzqnyxEnT27cCw?=
 =?us-ascii?Q?L0Sm5hRRXFdsJIESEDBobWKlACu3PZxZ8poaWHcqoLIdEq2vg98JHyA/Mguh?=
 =?us-ascii?Q?JSHkX5UNWqf4uqa4Tf4KXydf6kl0bnbmTMK3Clwv0zfg7mTbVpuJwfL0A6Lc?=
 =?us-ascii?Q?v/qGMFh8CogB+BO3nyY5qOZjH3t6RFzvkjDNSDk/yShHHPPNg1TW+s+zZTEm?=
 =?us-ascii?Q?XQsBIH3ml1XDkwFal2u8NmZ91kArEfZF3UFAnAVBFuXVfBL3AD7fE+LxlTMQ?=
 =?us-ascii?Q?/ejqpuVXKRaPC7P5TiUUWgj6kuFL7F08/J62l3wV5pKaLglYje6MNNapmHEA?=
 =?us-ascii?Q?xL40QqAcs0Fr0q3f9AguPKCBIp0GaGVqvq0b6KcKgjCZo9KIdiqb6Rdt9i6D?=
 =?us-ascii?Q?pbSwkmTDEt1I6l1ABn5ztxQxD0hnCZwmjEf5e45R0Frvv0FgAGCQylzvJF4o?=
 =?us-ascii?Q?eTlOjaA03P7UcGhOhcGKmk30+xEfXgokXpuYWUcEXS8B/gU1FZ9NiGhoL9kk?=
 =?us-ascii?Q?GfaS3tjRSb2f5K+ll3ONvgme5JDZKFidttBBFgRQJmxr5XlEPFuhiogERDmY?=
 =?us-ascii?Q?hltey2kOQSwgvpraHcg3BFLGqWQihgBkoqIMgazITLG91FQo+Ui/F7vy48W5?=
 =?us-ascii?Q?VCFwsYZafgI53g0ARtlX+LjidFM24kkby2r1CSEdXgOQCvg9WdXgi2ChIvym?=
 =?us-ascii?Q?4ZMgLMgYVGtrOz+65D4r7PZ9yVc/FY8QqRFCYo0KnLkk03cEx2FE/YJCCi06?=
 =?us-ascii?Q?KR/C6Z/i9ydj6VqYVU/DELqha1hMWnj1NUDTI2zZ/PfyKJ/nndzV/IMYiR7N?=
 =?us-ascii?Q?3n7MkkKUPtuRuPToqploD/thK2xjFSS93Tqn24XolsbVmgrcz8z4aHLBb4iH?=
 =?us-ascii?Q?bHLBNSs4LtGwXO9LxghvXRqBjfvNRxf5bvw5h9e5SVBBIIaDFh9D1ZDYVGFe?=
 =?us-ascii?Q?yvTMU8CiaHjidXatbz37Xd+5V7qLbMXqfmjCIxoZVcGzC7M33Dv2AKvR4Bkl?=
 =?us-ascii?Q?6zisaQgS84EbpZV/ClHzrgNiPrt98AeWc0cyaVZVwaSS3yKVOl3AJrrF/J3o?=
 =?us-ascii?Q?99m6K0B4tF6hLj7eBM1b6GigPBHUHps/u6UY827f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620450db-c697-40b0-182f-08db1a54cd0a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:59:32.7153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGMyXyHF3ENGrAIHM+5vHFGAxWqL21H2y6ViL1EIE0vlW/60asxdP+Fs1V9ZAUAdY5qfKoduE1NM34t4dMtGCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_LICENSE to support building as a module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
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

