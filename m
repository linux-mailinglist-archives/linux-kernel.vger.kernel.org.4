Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA37717731
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjEaGxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjEaGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:53:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB39099;
        Tue, 30 May 2023 23:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN//T0QWM2Gi2382OMhF1C3DfoCLvg0xE9ADwQh9VLOQxjcoywLo0SrfPzjDUePYKrbvJPAM/X4t5ZwBT6RZR8xGmHUX69Azy/8hV8Q4LbgD6R5hHfMBpoOJP8AA6e+a6XK9i4ZR6E7MOfqw6yd3CREbt4XtGUmu8v8060m39G404uJgBGOZ77ds5lab0FfytbpPohWCdiSIBvgszZZmouKCSz5e5MZ3B/qrhWlI5sfaTvcMRmgTmRYkYvILk7d8MlxH0AWQxd0FwyxA7SIWTrB/ce1dX+PNa0up4n/IuHt72Ce07ZMw9crHR3vEpbw4NLlQbdgpILgXbx98dlb66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJ2eA4W/EuaYA0Cyvx4JeUeVZvlzrgG/YT23A5Oi+8Y=;
 b=Pe4z5oNuYgf38OCc1208JiNOL+w4qDRxlnN8RY+v7/UQbcVgV+1QZmMRA2CX6zXt58Z9sO4ou/8Vxjwf9aL0o5trjTDR/Z7Q1uiTUAJeIy0SXss8D7KMBBxLi76CeZHBM5293ZK7NItQpjXEUAH/FYaNCkfxqfukU1OKM7HB8dLG1c5XpuRrvfuUt9C3Mj9kfUywFDoATG4adwWQiuh4wJM24hwhdgjkZ7k89VfpXQBDN4QsJ0uHK2c68Xf38UiTfUQcSUNa94KiD5DI7p9c6xZXyePypSV2fcJzyhQEjm0MX7jw8nVaA2+ZGwKPaOLadwuM1mVj6y3hkP1+Ges1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ2eA4W/EuaYA0Cyvx4JeUeVZvlzrgG/YT23A5Oi+8Y=;
 b=KOckvn3pnDhnmZ/vxSJiJ+nwNqVQfrM+wLb67LpeTj5dpy3HJODvXkPPq11fHSzVcxXGJ4omPSXSqFULILmQqGTz8Z1P/Yv3vZIa7bqkRLLzs0AArLbiv5/Gs1DXf7S1F3duE/wEYgsSlTAka9VO+huunVQPBVbQqH2FkyIYxxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 06:52:57 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:52:57 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     ping.bai@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] add pmic pca9451a support
Date:   Wed, 31 May 2023 14:57:21 +0800
Message-Id: <20230531065724.3671795-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|AM0PR04MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a805264-9a87-45fa-16f2-08db61a3aa4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vq+6bJgBF3A9gmUxm8z4u+1J6NOTRLDUEhAvQOvTFkMgU3LLn9rplj+pt2JzQiUTiXJoiOcC5F8nZtlyxAjRIu//hxQhafzc/FcjJolast8SIj+vUSGcg3DTk+oVTzovbBZ/rXg/mTc6Qk7WkWYgykSy87iDuaPRLdC3gbNaVg/xf9Kyed3Shw9s6pezwAS5cgYLslbaIV6lrvPjOcwxsz3GkpZzdfCwsprhrTboZRJ+K0A9UuQjOzcZEWX8RCh+bRuWXoCBZvkpYrvaRBSlT33GnV50FKGu1YuKF3KsMajSbGtDOed0SGbe4Okex2bdSzZDvj7sXMkw2N+yxyoYRhJ1h4JYb5mGB6/+rVoSozQJzxWe53YSQCg9XDPtwRoqfsKTuzuS6ZOeYbz7m1NYKTqxh/vjb/EmwFbRclB2sZSEsqXPt2tPShC1lvqM4/Mm92D/L92uxypGLVZOF5Y9E2Nw/f99L8/i70qgSdqVsvWwd6/lkW04qsRd45B7O9tZBF7foKlIT16kM++G1Zxcjxqvz/4wWLyK5pbEcwwN15YReaiigsFLKxUV3SMR76npCL8sn/saiIjZEyfBLvs54gwgqKgyDGKLycQrdIhhIZ7xrcxLcAt0bSZ4Rne6vSv9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(26005)(1076003)(38350700002)(38100700002)(41300700001)(52116002)(6666004)(6486002)(83380400001)(186003)(6512007)(6506007)(2616005)(478600001)(8676002)(4326008)(66476007)(66946007)(316002)(5660300002)(4744005)(8936002)(86362001)(44832011)(7416002)(66556008)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLGqzuD3f6mSb3BZkexNCw7X1wjFA+vaSn81cPO/oD3v+X/4yz3UzmC9yJfK?=
 =?us-ascii?Q?duE+0NnApp+bfrqCTvAyrzPJ9xKjoRQ6Nsx49WNpaOLwu+L+c2V2ydjqGY+u?=
 =?us-ascii?Q?LfFXWFe/h41MZvnMF11XqD8somd2tp+Y0AAWMB0p5ciEzp/aIyoYNvZIE7n3?=
 =?us-ascii?Q?9u2fu3elUOiwYovNcZ9Dkvlzcw3QhHy5v8Jodr+wJDA26ezjRJaPMryxXEIx?=
 =?us-ascii?Q?2SC54g10Oz1u1pl7pQX2YGqudCMnW7tP/ouZw+Hv384r63OKE14mwwRKj+3Z?=
 =?us-ascii?Q?V30XgJBTwHGN22wgnvIlYBni9GZ50fO5fzd+WsoTyC5yHEpgmUPB4KtrRkQi?=
 =?us-ascii?Q?oadefxq7QNT7bJuSn1eOsfZVK9E4dAiM9T1NUZZtCIto/K/1/84mpjkEI+P4?=
 =?us-ascii?Q?ffB9q30P8NxyQzHHl+9L9hJjP2o81vihIxpl6e4inDjFAndyqj7LWP5mrU4+?=
 =?us-ascii?Q?WYRZLeTZ1z16kaOEBqZUo5BrogC83xNfPykIp4K24zis96TU94enkidAIwC7?=
 =?us-ascii?Q?2009e6cEQKpaVWffhnbm7KU/zB4qzjBQ/ByJ5rkHyiIc0sH9v9rUDDFDl3Jt?=
 =?us-ascii?Q?LdvWXt+toSp/1hRu/aOpE7/RUAuWk9HAMaNB8BgITCXk1LipeD8sIvYiKlC8?=
 =?us-ascii?Q?9FyRe0wzLJNDbMBafi6o9/y5cCwUFpJyQ2O6GRry/pPbmhVMi4W57JbJMAym?=
 =?us-ascii?Q?1uZF71wzL9DrWlXSUauwqmVUrbr3CPCsH6blljzVDEMeFzE7hjTVZ7yvzjII?=
 =?us-ascii?Q?9ndIvd4v021DfwjvAHbDrUj7SevIJHylT7E3A2I/XJcIiCFiWb+BMQ8gI5UD?=
 =?us-ascii?Q?8axv2L+BxoaeYdKunmErNBjkiUwyPSLOp3zm6ROVVu8KtEpUnysDWYyyrR9I?=
 =?us-ascii?Q?nXFrKOkvxxcPq0jCEFuh+qr0nkRtxhpSkAHMX6bfWvQaY0kKabi71gk6K3U9?=
 =?us-ascii?Q?wrFgN9bziAGXFn0S80xLwBIipwfHeh6lIGglGqsIEQkpmxyi8OMSv1mhKv2S?=
 =?us-ascii?Q?mO3wRYTRecsB+4kQWtZ4ATC/fgBRjRk7hnc7urSVKHE5KuPj6HWzXLeIWIDl?=
 =?us-ascii?Q?Om9+uFtjNdrz/dmw5G+VvjwPj0SVjYiAfEh/jMw6p8iNLw0JUwohFvvTWaur?=
 =?us-ascii?Q?FR3MBsL3KtLeEqp34UccbsbKWdI4Ciz3rhQi2GnRFGeqJL2RRQnz3J8SBjv5?=
 =?us-ascii?Q?DFgqnQNpW/w+DVgIORz2Zj8dnnkscRi3fPJxhxfzGaA+1CH2k1zwP7Ph6ezd?=
 =?us-ascii?Q?dkfMDNWpXgDINYy1G+S6h9tF+/ybRG83HgsBVgUaKl2+XuZtGq2BWzBN2i0i?=
 =?us-ascii?Q?ke8BJlasv0GuoA6K2GMmYuU+5xhtBRuhBBu5s6BbvyKTo5yNMezKFH9AMllu?=
 =?us-ascii?Q?/flFJlYCOKktr0XarZQSBp0fvAdx4pCLqy65jf0ZORiFZD1fisJLQ2egJdaP?=
 =?us-ascii?Q?9J8hzNIx4xVphGuZ+Ly5pygVD/O4HR8lAR35ak15ffDI8CxR2caKIyxE/YX8?=
 =?us-ascii?Q?Rr0xB3WpZ/DMWGXgowhbX27X6tWUFp39qKG3izX1r7fZt/7bls/deruIw7Rn?=
 =?us-ascii?Q?McdgYlJy4mwVyJwA+J1oUywDdWcSMGOfDit4SJb3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a805264-9a87-45fa-16f2-08db61a3aa4e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:52:57.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEKMfcHFs5sMH3ub2Ta1zFYevM0cfsQHJsjHWk27Lm+3NbsoegQCyYgnXZuXCGJz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset supports pmic pca9451a.
For the details, please check the patch commit log.

Joy Zou (3):
  dt-bindings: regulator: pca9450: add pca9451a support
  regulator: pca9450: add pca9451a support
  arm64: dts: imx93-11x11-evk: add pca9451a support

 .../regulator/nxp,pca9450-regulator.yaml      |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 111 ++++++++
 drivers/regulator/pca9450-regulator.c         | 262 +++++++++++++++++-
 include/linux/regulator/pca9450.h             |   2 +
 4 files changed, 364 insertions(+), 12 deletions(-)

-- 
2.37.1

