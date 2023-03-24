Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942D16C8007
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjCXOiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjCXOiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:38:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0028623116;
        Fri, 24 Mar 2023 07:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPIm3kP34qvliYnAPjgi2IKSFq1EoI0xO+tt7afHeMut40WEmUPWTJXFwgmpXjUR+SxTd6wd0NSF7lhBJgqMVZofi6LiQaHcqCcUgwA14InduolipVFiyltCPHGMZei07d1bsaVP3BODw43fFxUNmdTxM/HWer1SSff+LitLf+LH5dWHwj7aRQB5zkhVScUwEARsyqY36tqKxnsnQVpLI9/ZqRlx+l4PsHu1x2fcgmgNAAr6SL9N2dvJpMA9WN/KnSzj+c5bf8pLzd7C6j6Ep4ME7OZSp9gIyMbuWU2MuCZLFkC/IoOXqWImbWQyQ2MumMCctUCFllTnLTPbdI8m/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN4oSk/fg6PFOW23zvTHHTxM97j8i0UUQgD086d68p0=;
 b=eKOqjj/NxCf/lVC0cQL35ptJjLDia5pwy5eR1KjjfbAGfixemZYNtWlDxZrM/ROgJmJnjHXkQLDkRg+tQRsEkYzu+Sq6FrZSetorpkSzUe/VgLlI98QPyxHAmtHEnz7NaI+uIuuDcN0Kd394ABeXzPNroqZl8tQ5M0H0aaJD1NHlOG8s0s/J8zADXbxaArsRW4YgTSks1dtn8Cu861yRBYkoSEFGZzsEwMAfIz7acXZlo/CJ+XH57vefHEXfPeH1m3GjSxN68dYZII1+F9Cg+xjJlALICmMmkyYfRPIaRpGQdMu4yiGORYxfqUx507gy2jJsRSCeXu1SDN9UjxPxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN4oSk/fg6PFOW23zvTHHTxM97j8i0UUQgD086d68p0=;
 b=uhY8pVSfxrM8IXC5JnXtJ2/Mjvr9Z/H8F9l8dv3qMH6HqjF4Jek2rDOkdldQEWVJRuzQ24c9zg7q40AvmcQAfvAuI+FHnRDEZTC6Ci5GZILThbQqzpsx1dp42uH7rWKupdMJrhR4p0aPKjjgr9h6d+HHW8If6yOis1SZrDLISKW3CyKNUP1y6f07R8gB88d6hxRuDV6dRm2sPG9SIzps0LpICJ/5rhS14AK0p/KLe6ao77LcJ1mlu32LqFGCa4k0r+yXl5rYS9jY37LdOPgZ4QKrgBk2WEn5iKWAvI8IClkN2EMjmz32qdSDYPzUF11e5zSsopZC6kEQGlJKtNWLMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PAXPR04MB8623.eurprd04.prod.outlook.com (2603:10a6:102:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 14:37:51 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 14:37:50 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v4 4/5] pinctrl: s32cc: Use generic struct data to describe pin function
Date:   Fri, 24 Mar 2023 22:36:25 +0800
Message-Id: <20230324143626.16336-5-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230324143626.16336-1-clin@suse.com>
References: <20230324143626.16336-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::28) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PAXPR04MB8623:EE_
X-MS-Office365-Filtering-Correlation-Id: bd21aa54-b754-4fad-3f6b-08db2c75580f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVDi9jb+COb7rjVctMcfAsvZkyUuUdMHCsAmZQMuqIhQS6bQ1gRuUB9r0X3OJVfmgbn4XkKcRqZPDY/7XDjuTXWmdEhethlqPhe+aCZ718rq6mcj06SrMtC/gnTt4XlTEat4W5Z27hIMjdt6nsbKRH9MG8nfwfj5pGtwC2RW2oM7fjxEWM5tjOS1FtWKKyGRyDAk/fS+AovP5ScyZ3rOOd5ukOvcxUVwR2lk+ntGG0DwYGX8raGU7J1yWaq98nNIiJ0cBoUFIkKfVCCjMToUjFM2BUKBt0bbcX7QXgy94nGHhw76oaVeRWPPTc7VHmSjUViOLfyFRuiA23QDgGnacxeW5C8HyOdqe5bfxKMpw8cFe/7tN+QK9hy7H4P67jsoJzZT6htx49zutFVSXQOaSW8QKoT33QPqLe2xyzZJ7y1b32LGQKI5EJ3iuEoyCDVPKySWr6OAYzaxoCF8mEhCJzlM2CHr3sxdS2Vmce2Pn/H2g1LA6vkxoT7XczuVDUzC1SsfQgMcI94gZgYMGksmFdmEH0g/5w3IAHeP93UFTZBURLPEyL6y4WqBAeFPtH3Wg73bwXA6s53PC5M9OEkfu4azU2iYHDniy/H5ZHmrMnRUIR/vuzIMZZwaY0icswn0OcVwPukzC0ftfMkOoKWc92ph9Hc/FrwUzFeaov9OjHwRzCqIhKlkjSavazmydZ+o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199018)(38100700002)(2906002)(83380400001)(6486002)(478600001)(186003)(2616005)(86362001)(36756003)(110136005)(54906003)(66556008)(8676002)(4326008)(5660300002)(1076003)(66946007)(66476007)(8936002)(107886003)(6506007)(26005)(6512007)(6666004)(316002)(41300700001)(7416002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9SNJ56bAmeNoheMN/U3dPjzXSPwbU3JKpQ28Euq0FTt9HHV8FB4f/HIuT1ZV?=
 =?us-ascii?Q?xCkEUn+kStym/VumMdav8PiFJUhhEEtFNfjkdtFbjsCK7WZ3Jel1DM4veukl?=
 =?us-ascii?Q?OFz/46HBSSqAjimt8wlyPhF93r4IyOIrkCoIef4b3fLrvbqpq1MVxXj3N8kD?=
 =?us-ascii?Q?2uhTyldjk8ZaAigrZWEAwQJRmtXBs7zB+G6shhR/E6MSlDzq2Ac86oEBavOs?=
 =?us-ascii?Q?ug39Qqz5OrGJvg4mpS7xC3GK1Lp2/uGxjsYeaqC7mcUZEvcaxjZTIJ4VSOJa?=
 =?us-ascii?Q?wV9rWaEi/k3e/p9/8WG4lRdAnmwZacfMJTByUEaayCXxwBsQiaOYgJI4L7s3?=
 =?us-ascii?Q?QHpQBYLZXvWGXb6aVQ68Vb/+OZ71/JaulOe/v5cZV0m9KlajPd3+fIqM1b86?=
 =?us-ascii?Q?/HMurfcXeid6gLsT97UyvXlzeIuf5gwIVLXpIWmhtBFRw0p4FrnXb1TFaHTm?=
 =?us-ascii?Q?uixFKFYMLEYg+uu/jBAGnW6wRXwqf8l/OcovH8j3j7xmW/FYokcs0itAyPwH?=
 =?us-ascii?Q?tvZnFXioc4ntT57bBIKqnvp30H5jMVhucF+LTB9mS281lh9IsEKYQJZvNM07?=
 =?us-ascii?Q?Wy1A1Y4IVRHS1LA0Tb7JSm3n4E6m0U6pL4JcGD2KyiunTT190QCfF8rhMFAk?=
 =?us-ascii?Q?hNW3hfddb55/f4XjWxfx5u92V1ENSsQEoL7y3Bl49EnlcEBqb3qAAEKGIX2B?=
 =?us-ascii?Q?epvC+5e14tTiLtOz0InIF+ShYtEVNPGtyRr08Nvj4tS41Jgs+PIvJafTdIR2?=
 =?us-ascii?Q?FQsTPT5tVH71+T+jY9XLBxlB3cdRn8gyrRxoEC6xsHU52PgciThu5HGyY8Pg?=
 =?us-ascii?Q?9HLmiai1+bw8/P5eO5i1P2OOKh5pCn5XlpvIxp4d1uzN2YGTa/3xWAB/mbLb?=
 =?us-ascii?Q?PyJcW3QvFFbK5s0ytftuOMBIzbGtS6eNyar17gc6P174P420sqwM0HKlnUSf?=
 =?us-ascii?Q?r2iY9iq1sFxC39VslvK+ecwDJNHpqZXKla24i3gzddzGVTUkECmWrNllr8hX?=
 =?us-ascii?Q?U10KHs9vAOjJfnhW+SgN8I8Ds4RmbNuP/cC3n9T+Kg7CX6YuQvLYX/qk4+n2?=
 =?us-ascii?Q?zGGKJ9EZffMq92yAM/i+0gcg+2M+GSnaefuK36ujZLDh4RP3xixhwX+YtRkH?=
 =?us-ascii?Q?Iamv+3qhUHQq0FL6wNxHMYvDEsyNGGp769TTByMLuileqrwjg/7C03f6LpEf?=
 =?us-ascii?Q?jqvqPoPxarkfkNHGQPdwppPHocV730ghTAjPbqjndVoWhveApzV4XQHuPgFb?=
 =?us-ascii?Q?LhW74ImGvrx+mrrIpV1sJLTJZL/+rKi6qHwQB4iW3FuK4Xv1/GkprJCloomn?=
 =?us-ascii?Q?FTSB8f/Wc3TwQN21lAOnPpPqP7AE3lG5/kUwIYLMa4YXLBKiDNW7qc353IAO?=
 =?us-ascii?Q?KOe+vqu5c2d64id7JXzpfzSrh5bJLJ0DFjliQgU1a68Ipc/Lax5Prg2pdWzp?=
 =?us-ascii?Q?1olpVEVyBUkeh5/npyxi1IVBFC5M3x+XPCeexa2OA7fN0N4mmFYVMDgkX20g?=
 =?us-ascii?Q?Qde/roW8yS8crugEOKOT7+QgopZ6l+zblIjz6Ac734xC3I2htB7a+GuZrAWX?=
 =?us-ascii?Q?ckS8oJHq5y/eTw0zOEM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd21aa54-b754-4fad-3f6b-08db2c75580f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:37:50.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26+vXZZ0nTDy17eiOUXcItIuS0aGlFyHCZPA9lW3ukcvdWDhhutcQzPaCZaew30U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8623
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace struct s32_pmx_func with generic struct pinfunction since they
have the same data fields.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
(No change since v3)

 drivers/pinctrl/nxp/pinctrl-s32.h   | 14 +-------------
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
index 850cd668f406..2f7aecd462e4 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32.h
+++ b/drivers/pinctrl/nxp/pinctrl-s32.h
@@ -24,18 +24,6 @@ struct s32_pin_group {
 	unsigned int *pin_sss;
 };
 
-/**
- * struct s32_pmx_func - describes S32 pinmux functions
- * @name: the name of this specific function
- * @groups: corresponding pin groups
- * @num_groups: the number of groups
- */
-struct s32_pmx_func {
-	const char *name;
-	const char **groups;
-	unsigned int num_groups;
-};
-
 /**
  * struct s32_pin_range - pin ID range for each memory region.
  * @start: start pin ID
@@ -52,7 +40,7 @@ struct s32_pinctrl_soc_info {
 	unsigned int npins;
 	struct s32_pin_group *groups;
 	unsigned int ngroups;
-	struct s32_pmx_func *functions;
+	struct pinfunction *functions;
 	unsigned int nfunctions;
 	unsigned int grp_index;
 	const struct s32_pin_range *mem_pin_ranges;
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index e65c88162d7f..8373468719b6 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -364,7 +364,7 @@ static int s32_pmx_get_groups(struct pinctrl_dev *pctldev,
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
 	*groups = info->functions[selector].groups;
-	*num_groups = info->functions[selector].num_groups;
+	*num_groups = info->functions[selector].ngroups;
 
 	return 0;
 }
@@ -785,8 +785,9 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 					u32 index)
 {
 	struct device_node *child;
-	struct s32_pmx_func *func;
+	struct pinfunction *func;
 	struct s32_pin_group *grp;
+	const char **groups;
 	u32 i = 0;
 	int ret = 0;
 
@@ -796,18 +797,19 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 
 	/* Initialise function */
 	func->name = np->name;
-	func->num_groups = of_get_child_count(np);
-	if (func->num_groups == 0) {
+	func->ngroups = of_get_child_count(np);
+	if (func->ngroups == 0) {
 		dev_err(info->dev, "no groups defined in %pOF\n", np);
 		return -EINVAL;
 	}
-	func->groups = devm_kcalloc(info->dev, func->num_groups,
+
+	groups = devm_kcalloc(info->dev, func->ngroups,
 				    sizeof(*func->groups), GFP_KERNEL);
-	if (!func->groups)
+	if (!groups)
 		return -ENOMEM;
 
 	for_each_child_of_node(np, child) {
-		func->groups[i] = child->name;
+		groups[i] = child->name;
 		grp = &info->groups[info->grp_index++];
 		ret = s32_pinctrl_parse_groups(child, grp, info);
 		if (ret)
@@ -815,6 +817,8 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 		i++;
 	}
 
+	func->groups = groups;
+
 	return 0;
 }
 
-- 
2.37.3

