Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82656A53FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjB1H7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjB1H7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:59:14 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC7F1C7EF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:59:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSD3ErEaGUENUDkXm2e0QJAbjVaIDWZsRUrmHfy2ghzwir/7sJb7cUZbLBB20QN0MRP4L3fdliCMEsl/FeqAqoN1AHPE98FzfoNGkOTzhze2djr3cudQ5KBsevqcPsrPlSP5kTXSpsqH5MEnbi/tzkHX20ampZw9B5/R+VQ0IZKumDgi9+zBCzEaZtWPzzpuW+1oh2EkXZ+gk3nJVo0ZjfGGFMM+DpDh4nOk61puiYvo+555PyqeEzO6JqJKXdsw+zMmYky6mhGHpAtoja3umOJ3elqvO9/K8yqbPsM2yIwOEGkIWMU07ZCUxqbWdiR1KmYMesS18qSSekhNjfiYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X13W4gURt3ng9/eM+Lfji6cjgeDt/3itFcGTiLvmTdc=;
 b=L6Ntac8TP5iAPrKLPCV2MYyG9wB1Rq289QQTUxk6+3FTFPDTWYYV4qEEffh6Y5KnRGkl/H7vAOCK3qfsMibuLMGd5+3WLwNgwoukUMNZ28U/ja3FpqzuD08B2OZNCAXMd2xmynfd7luTD9i/FavMRYFphttGMrkNM8mewarmc4EI4LDiN0Yey3kbbqiE2kEt0nySLfzjpj8d7DnH/iGuWg9xG+aYvDZsm5NlI8neYZgVSnL5Q/qa4w0fkP5mflT8DNN5L3dKT1C3+1yWvw08ggj0qrBGXi0+JsQFXy4Z21hp1h/nPPwkcngXDcJ6pwkxDgJRWvVvOjqsce3DXreFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X13W4gURt3ng9/eM+Lfji6cjgeDt/3itFcGTiLvmTdc=;
 b=an4634RdEOkrNEzYgv45c0QLj+BFVDjrEVxptY+ta9J3tAmzzYt+CObr4xGOby4M4z1H+otIbXNXSCxqXmjVm6nFUM92BTI7V0AANPBrASbEnTA+Xkkf7qOOlKBPgr7UZFNm2YIrkj7jc9myiItSALntuX1a/P8gs+LQmrMHIp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 07:59:10 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 07:59:09 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH 2/6] soc: imx: imx8mp-blk-ctrl: Add MODULE_LICENSE
Date:   Tue, 28 Feb 2023 16:05:28 +0800
Message-Id: <20230228080529.412669-3-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230228080529.412669-1-jindong.yue@nxp.com>
References: <20230228080529.412669-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AM0PR04MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fd14b0-385b-42d0-ff28-08db1961ac19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5Ux5Ab4HUnTpAVvXnR4DNvIa05IHlu+O4x9hfOHZXfvfkVbBpTE8QhTQ2UBJBaw6kdO0SyjiwnVu9Swf5vp86fyoCjsmJ6zXXDbvYtERa9EBeKAhfjHFu5RcctFEFx+Mn9hBg+h90vsizEeiZ8jAHdDNs3NZ2WZql1wReQzn0sroTLyjoOCqY6ohhGUPnJ+oPnkAQIL0FMyLrIiuzRC8wUQv0jycJ3nVsxqH9JwdWsFUKWvOgHrhj+DuuL+B+l0UeUx5VYhAAyALsoV0lhK+HA33xDzWLMQmcmgefShGgL3BBNeKpz7yXR9gkuYQ1chYpw0aBAsf5frqMk6kp1iUF+7mmV5+54HRDf4G1pyFASZKPm0e/csQ/FVsQBxPTlmlkFYMBiJsmO6QO++T+Sd2ppV1bEN/jQu2dTXFtv0hkNYi3OL3lnAicfQ/vTeMcg/Kk/obQpuVx4zBwu/y+oLtHTBWYtvVX4eiuP7s4OsaAyho1FIKV3uzB7DFbUmmho4l95BBswKmjn0f0mJQgkkRKDpeJ+f5RtytRY+KaO6W6K8bfKlRAhyL/Io0WQHogIhEIIMmdNrNUQUh/AVBnFbIvRFNHuew+uZ2cDIuiOWORWMnHt6TCnVCfjxOlD/XF5x+zZeoBNnvOM5p+RL7XgEqGP2AWeBDB0GKMiZlxZvffzc2P8u9xV0BlnYh5QzrISk/f4oxRf7Xp21f84dqX/MBEjku587Ye0dtRM+HNshlbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(2906002)(38100700002)(38350700002)(8936002)(4744005)(41300700001)(44832011)(5660300002)(2616005)(86362001)(52116002)(478600001)(6486002)(6506007)(1076003)(6512007)(6666004)(186003)(8676002)(66556008)(66476007)(66946007)(26005)(316002)(4326008)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lO371yMI3Kl9hBqbXGGQGb14CmO4O75QrsVxB6kJuNFd4YgC019gCjOPE9OE?=
 =?us-ascii?Q?7CA1QrDXi49ms7gIUu1LfnYo94XWBrXfVKYHRvdBPzXxTTEtiWgROeI4dHwD?=
 =?us-ascii?Q?cWQEF0fgB1+hoedqvErgTdP9QfZ/BrpXeoqZBGq5sYyPW8FWFoyUT7BqPBSY?=
 =?us-ascii?Q?dQPsvXZZs1PJPJsLDKIpcbmmZK35Ukymco74Dkxivkop/6K2eTjSoeoSEDXp?=
 =?us-ascii?Q?3pcf4QcwOv/AkrOr+Kl1PJE5lKUWjA1UD+EI/6yaGPJC1SlJTALH1E1EEiJf?=
 =?us-ascii?Q?MO4NzlODN8ha3vVduzFGiGD7dlhs5MUa7w0dtIr1D5txd70jtXarLH0CAVhL?=
 =?us-ascii?Q?xbcbbxb2HSXFTS0sfoLoEMPiFSivnO4BdZPG5B2vCN6TD93FSy5M2BDqesl3?=
 =?us-ascii?Q?WRMlbnCq1iWOBbsNsK0ai7YUk0zyWIwp3YCkNxfTPdpLuOF+eAz2oqnYX4DN?=
 =?us-ascii?Q?sfn2MTX19CZ59/Epp/GnKwPhvqhFilzjiq9wUmK11se1v2+03XJ1l9V0/jjm?=
 =?us-ascii?Q?bqcE03EHNtDJ3yjBOK/Sqg+T17+ltVN+zaX3IrA9oggTtmiAIOBgTsoC7vgb?=
 =?us-ascii?Q?G5PljzPBk1u8M2UR5SeTAfOcDP5tha2czk3Eot+LzrCr3lxDI/dGHp/RFTsw?=
 =?us-ascii?Q?/l1/wxs9UHKVHhroAMEOgVE/JpIADK5UULPzo07K9vIFxmAxSln+qamMTve8?=
 =?us-ascii?Q?mNNUiMnjg7lsq5r8mmXFAglU865Uqdx1unSDgy3fUf1ttoEZ8tP9XLVPvzHz?=
 =?us-ascii?Q?oJ4Q0Cvds/mitLplmvCzVsKBH8Tqirqx5QKYL0o94jWpz9HhquECbtZyb3w2?=
 =?us-ascii?Q?eFWoSTnWYIU5GxQPFf2jDRqsg8iWSJcn2LUWG9kZSD7AkEDn91zc92KcJFh4?=
 =?us-ascii?Q?Lb6Xm6DQSr5H6JTvL3tXkHsG4PR8XT/nUP3SXMtwgZP2yRFmhnl4Qu7rW2NE?=
 =?us-ascii?Q?c10UiUm7d8Cc7w2CG4lHKVKaKLwjq7mDo7sw8uDXuA1op7T4vZiHFznMelZ7?=
 =?us-ascii?Q?oZan5XmEnPJSA4Yuv3d/BhqNGrsnze5+zRN5UMRWAbPkjXjlgyejgJAhKK+T?=
 =?us-ascii?Q?Y0u8Ca/rOOmH/2VGVsVVZ5nRAwa//qnyQ0PeSEFeg6hD3GfyaHd7EVQ3EBZS?=
 =?us-ascii?Q?9ls4nWFfCQpmWe6q7n6jrymnSsQWO9+AuznCtT0uu5X/OH+tMSlxjSkWQtTG?=
 =?us-ascii?Q?ZA4gEOfLps8oMxOznnxd797+rtGQUUx704jO7XCaFbRnoVTe+YdA2N6aeuoA?=
 =?us-ascii?Q?AJOB2AHvtMUCbn/H7WwHR/Kp8sVHzpFHWmXItCSH1WbP1QiL2meWPtncFIdX?=
 =?us-ascii?Q?Ff6IKVeq1AY9bno381wpLd5lLA2XzgOBcRgS1H2OtiMcPuGAdDPsYNIhqNIQ?=
 =?us-ascii?Q?ziyg/0UMd+C691V7SHU3DzvOe9HVtK+nNMDeIkTeLK7Hh72xubZm+RaY0fT7?=
 =?us-ascii?Q?UnkJT0MCmTUTRXg2qGz9X5zRSEEH8PYNpxB+Ud41ZtP3PnydqfXvkCHPDD4x?=
 =?us-ascii?Q?JQO7a4Z4/Fy1vh6mm/LFcj1/hn/rR9RWuhWGpTtoiGgB93lAk2f32G25Lwn8?=
 =?us-ascii?Q?gUxvp8JCdeTXscrIrQYsvnQxInz7X2AhgVKDpecQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fd14b0-385b-42d0-ff28-08db1961ac19
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 07:59:09.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCNqDeuay+HIoy0Acr+2vpNbwg0NAqF7vMYZ/Ux13yUubbwtiLuCzEGkPfp/SbRuPSddJJNc9hnxZrE0EVGJkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058
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
index 33fdf5dfe62b..cd5c41e41807 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -756,3 +756,4 @@ static struct platform_driver imx8mp_blk_ctrl_driver = {
 	},
 };
 module_platform_driver(imx8mp_blk_ctrl_driver);
+MODULE_LICENSE("GPL");
-- 
2.36.0

