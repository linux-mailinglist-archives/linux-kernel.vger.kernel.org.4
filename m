Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D66C1C77
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjCTQqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjCTQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:45:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B34833461;
        Mon, 20 Mar 2023 09:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMVkbd01A7yrnkSV0srQ7zXFx1OkOzHCS1+1l1irwB53BoYdXAZSvML96O0pssiiIZu4iNYv7n+i0YyDDMhVtG5LbcEtap8jQeKT8f8tCaLXsfp/XE1eVntT15YG7/zNa1iHYiBZDWOFGEna8kIq/MnT3hhn1wmOqiaGObpjd24Mhzw1G/5f/JmZ2mv/k5sgy7LIlI97MtCUZ3VL6UeYl7dxWvYoCiyM1bnPizd8H18MEX2ExxI8EwPZpfn+y8fwSrZG12JT8tfJNqGbJ9Y61OyBGfPutCMLzDM7/HtHW6doEdiu2agVZ97ycKaYtUgL9Ii7dzb2p9I5YmYwzoEcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQu3jYKokEz7tGJfJMQP/VuspHARz/h6PMLM5pn2zdY=;
 b=AL5XuwcVUMS3zq7hFNG/1adWJFJmRUL1mcxFPYSfTcKTIIF8b08NhgsAgY/1z/cXJ0T5i6EoNT4MIyBSTYqkTrNU7Y+V7YFHCRkBDW73aq9sVFHwvDRY8XJKeCqIIJISxoU9IvYVN8Zx8m9wP3hOiK0Y81YnZmb56hzA7BveULYdIwctJEwetFXU/wVGikroTLS975hZSEFFZta9QZwK1iU+kbMkDhuk+/hpvreirg6OYWEdawK/mqBnMxDBDL2MCc/5eeLn0/o5eT0JaMdP1HQWfpMgIwSs46LvDweT10UvSjfqwM0P12nUf0tj1abyBmGBrCRQ0WZPC4EZxHeuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQu3jYKokEz7tGJfJMQP/VuspHARz/h6PMLM5pn2zdY=;
 b=3PTRK1W6czKXuYSBjLYqakcpyjvL9Bh5hKLrJhoAr4tTaASxB7p+YoH0IzQZLlIgd4XBiLJhoJWCd6OuHF0MYVB8+2BiLtG5QOAkiLvP3j2Pwkw0g5/1jMKzFImkH6M4HPlSpbxR55dVHkjZH9PDeO0VEbzj02BnKJoaLXbaSoARtvBDHPdqNB38YhCYVsHrzKlOw/OxuSpqtPYGschKyvmt5nTQFdAF14e/WFOGMUn6aL+e+u8kMUOalYuWQDygUh6I2jRkSOMyptWkUoV3GpAzyIOXRNkV/x/7zJwOpbX/81tRVt8iEiIlyKM54uKYH95KBr0o+MJIoLYxg14PKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU0PR04MB9274.eurprd04.prod.outlook.com (2603:10a6:10:355::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:39:42 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:39:42 +0000
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
Subject: [PATCH v2 3/4] pinctrl: s32cc: refactor pin config parsing
Date:   Tue, 21 Mar 2023 00:38:22 +0800
Message-Id: <20230320163823.886-4-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230320163823.886-1-clin@suse.com>
References: <20230320163823.886-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0177.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::20) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU0PR04MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd42464-8a6f-4b44-9591-08db2961b4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lyTXE+FH2n9QUP82u9GcI1f5p9MvOE3wswwtfq786He9MoH7612KGR0MfVjDJ8feWGNDkGlQf38SZ/u8qJoNWfrWO+ac/XU64dOYKTDz0HoFfvRWMo2FKWjJOfI2SPniUyGgyvL3hP5/yI0AHPH3hF2bL07huIVhDtdFF8DdlBDTjztckJJDad/AKV+glA7cDcvVXrqMNbDHFU1q2nEaCC9vW7rtKcK3Xm/lhrvbFkKtVyEP9/3Bve1nPdiLfA2zNcuRAv/X1ylOY+YGmy3L1ZzshTgS6MHvgljAbeQrRMxNGQOOAqG2brX2ZrRTnX+8+hHUWR2itJbRmRrUpiR1Jv/cjJcwEijeRFOaCAltpRrFSkM8Yvj+AWzQ/xQ2lDtbmKYyBDOCjcd9VMsSjFMdMpGNG/MB5qc5NYMXeHSkoWVi58GwTobeA9lW4aXzRNyuPGbKjQKx02glIqfcbbZ/4U4Z01lWK25S+j+OXeI5KEGHWTvtr8YW71BLCYkWeXkDoUwH6WC/rXA1aRbT+4B418Q6oJSdvlbeFQaTwqzRmhq3dqVi9BJWLrayfwvAuvm+sl6hkOcuXbfll2VVr488BxbHV5HIfCcBSiVYDOkHtxuZz/zPYVr3bpm1zAum/XdWNiv6ziBwOVQHBaeT8bNBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(8936002)(5660300002)(7416002)(86362001)(38100700002)(2906002)(36756003)(4326008)(6486002)(83380400001)(478600001)(6666004)(107886003)(41300700001)(2616005)(186003)(1076003)(6512007)(26005)(6506007)(54906003)(110136005)(316002)(8676002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r1Mf4mcY8YpmZPtVsYhFrEr1nTO0weweuB0NhtDCNFlwlTZqKx8noDAfDXYx?=
 =?us-ascii?Q?HIW76gC3uL5+ViIwwUe3fiUxk/iJ5scjYprjpFVJTwtw/Mo6Lw8wl+b9tYcT?=
 =?us-ascii?Q?rf4LNSkhzTNKmgBMLAjkaCFzFBR0bJPC4uNo6gKdJl3P3gvPghmsHueNAQAw?=
 =?us-ascii?Q?AzVj4BLcPmB9haYg2TeyR+ZPtxpusy73WhV61EMJsi9r8vShK0ZZRN10kFrz?=
 =?us-ascii?Q?ErvzxZuY7UDvZFaPPpfPy7iJV3mNp1MeucOsOSNgRq92c2r9WGsT4UB+JWx0?=
 =?us-ascii?Q?m1oyuKyUjxIhDzrbdPoYMMS4ucMjHj5/AbUMmcbmggnyf4WskdO9ZlP9NA8C?=
 =?us-ascii?Q?jdzLfEovcq83JoM1v4hJk8UrY19+O1186FE46Rg367n5X+rwT+4+NYuMNlL4?=
 =?us-ascii?Q?c/FMhV/TpockRRB06hslX/FQOops+uZ14dKdgPmnhxztMG08+JKnJPB8IP0M?=
 =?us-ascii?Q?yUBiTzp8ITQQ8fcGeX+vGnGVxSavd89xAfiaSTixgkAZVcQPQORpV44B+7at?=
 =?us-ascii?Q?e8DCyRW8Y8fZHYHdvj05orD75OmnO2QNk+WRP1Irj2UjZ/5oINUKsK6Y6QRZ?=
 =?us-ascii?Q?l5hx+HP0nMEQ+djWVMJU0fhjHZ5ms3y/BP6P6CtFxEWFsaDxhmLIFJmtU8x2?=
 =?us-ascii?Q?d9LPR3DDtZjlrEKGpL5EZlwzGsC3WRUr8kUFB17BtsnQL+9UwVA8KhI2NhTx?=
 =?us-ascii?Q?PlxhtjZqL6tMnXIyawNjWPds7YZgz5j3qc1ReTIeeJd5yF8YNLXwivMEW8DM?=
 =?us-ascii?Q?Nxp2cGLH9pJwk1EaeBSdbDClxVORm5P0ks5gXUUgbikm47I17P5z0vvjKQ6R?=
 =?us-ascii?Q?Eb0TM+zAjHzP677RoABYD5BL8FrQjZPmZFAydmXvpr5K0vnA05fRN5UnxNjT?=
 =?us-ascii?Q?zycuudFLM/02rIZSzsrP6DG9qE3jk9OtW30PoAg85V+Yn2QhjGf291JuS7p+?=
 =?us-ascii?Q?uW/XqUJ3cW/+bqPwnjfK+iAik11/9/PkYeSXLCviq0eC+Ml5cqDsfYXJNZjJ?=
 =?us-ascii?Q?o6/rQGbBRo5PHOO405JRyAo0AtUXtu1mOXiiu0qxAaPUyA/vWYUPIINtuDMK?=
 =?us-ascii?Q?GYpMCmf6yg52tq9a0RL36kowS08WKaKvhN/U6nWULEojWXko/R34lj6BAoZ9?=
 =?us-ascii?Q?RHB3KZgIMp9JhBa9m3r8t6MksMMP5D8i+SyTJg1St2mVEx2Fd096Rbod6ulT?=
 =?us-ascii?Q?4g7LLENn9OA8EZBktaN8+UcXiM6z28s4s1rvrxLL7DKau1RICi4n3Z7CgwAF?=
 =?us-ascii?Q?mc4TUZzWLw3QbTLHWG9+7ei/LXAR4ZPCWFnxoxQMiFs5g0inahFoH1ueBfsD?=
 =?us-ascii?Q?JYW8sLEX3lITm5/cLWUSTws0sQsBTpK87ImfsN2ObF473Z/eycrFdW2Z9JFF?=
 =?us-ascii?Q?N/P9TAHxXlB9lGv2Pgr+oNhRXazpWlZMe+dvN/NM0RND1lmnsfEZfCYtU6pg?=
 =?us-ascii?Q?M3i3UeLZ0CVvo9GsPoPJ+xOWrdN8RZvCtw61xi2xBQYKNuaG+5fEOckpOIY3?=
 =?us-ascii?Q?y9f0k5fCROfWncPMUSWX1E+cI+Bg1Wv5xelZNtuK+hwYmkEfJO3Hre1k+H07?=
 =?us-ascii?Q?8YyaYTVTE6xO34pI8aQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd42464-8a6f-4b44-9591-08db2961b4bc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:39:42.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucLPWKFTubXFKqgGksMpp8H7Di+4QgFrKfTDOpigk+d1mzpPlkzc+nQBVv3T/Aw1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9274
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common codes into smaller inline functions and remove some argument
handlings that are not actually used by either S32 MSCR register or generic
config params.

Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v2:
- Drop unnecessary marcos and s32_pin_config() implemented in v1 and set/clear
  mask/config values transparently.
- Put pull-function related cases together in s32_pin_set_pull().

 drivers/pinctrl/nxp/pinctrl-s32cc.c | 62 +++++++++++++++++------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index f698e1a240ef..cb8a0844c0fa 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -474,11 +474,38 @@ static int s32_get_slew_regval(int arg)
 	return -EINVAL;
 }
 
-static int s32_get_pin_conf(enum pin_config_param param, u32 arg,
-			    unsigned int *mask, unsigned int *config)
+static inline void s32_pin_set_pull(enum pin_config_param param,
+				   unsigned int *mask, unsigned int *config)
 {
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		*config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		*config |= S32_MSCR_PUS | S32_MSCR_PUE;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		*config &= ~S32_MSCR_PUS;
+		*config |= S32_MSCR_PUE;
+		break;
+	default:
+		return;
+	}
+
+	*mask |= S32_MSCR_PUS | S32_MSCR_PUE;
+}
+
+static int s32_parse_pincfg(unsigned long pincfg, unsigned int *mask,
+			    unsigned int *config)
+{
+	enum pin_config_param param;
+	u32 arg;
 	int ret;
 
+	param = pinconf_to_config_param(pincfg);
+	arg = pinconf_to_config_argument(pincfg);
+
 	switch (param) {
 	/* All pins are persistent over suspend */
 	case PIN_CONFIG_PERSIST_STATE:
@@ -488,17 +515,11 @@ static int s32_get_pin_conf(enum pin_config_param param, u32 arg,
 		*mask |= S32_MSCR_ODE;
 		break;
 	case PIN_CONFIG_OUTPUT_ENABLE:
-		if (arg)
-			*config |= S32_MSCR_OBE;
-		else
-			*config &= ~S32_MSCR_OBE;
+		*config |= S32_MSCR_OBE;
 		*mask |= S32_MSCR_OBE;
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		if (arg)
-			*config |= S32_MSCR_IBE;
-		else
-			*config &= ~S32_MSCR_IBE;
+		*config |= S32_MSCR_IBE;
 		*mask |= S32_MSCR_IBE;
 		break;
 	case PIN_CONFIG_SLEW_RATE:
@@ -509,25 +530,16 @@ static int s32_get_pin_conf(enum pin_config_param param, u32 arg,
 		*mask |= S32_MSCR_SRE(~0);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		if (arg)
-			*config |= S32_MSCR_PUS;
-		else
-			*config &= ~S32_MSCR_PUS;
-		fallthrough;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (arg)
-			*config |= S32_MSCR_PUE;
-		else
-			*config &= ~S32_MSCR_PUE;
-		*mask |= S32_MSCR_PUE | S32_MSCR_PUS;
+		s32_pin_set_pull(param, mask, config);
 		break;
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
 		*config &= ~(S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE);
 		*mask |= S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE;
-		fallthrough;
+		s32_pin_set_pull(param, mask, config);
+		break;
 	case PIN_CONFIG_BIAS_DISABLE:
-		*config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
-		*mask |= S32_MSCR_PUS | S32_MSCR_PUE;
+		s32_pin_set_pull(param, mask, config);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -553,9 +565,7 @@ static int s32_pinconf_mscr_update(struct pinctrl_dev *pctldev,
 		pin_get_name(pctldev, pin_id), num_configs);
 
 	for (i = 0; i < num_configs; i++) {
-		ret = s32_get_pin_conf(pinconf_to_config_param(configs[i]),
-				       pinconf_to_config_argument(configs[i]),
-				       &mask, &config);
+		ret = s32_parse_pincfg(configs[i], &mask, &config);
 		if (ret)
 			return ret;
 	}
-- 
2.37.3

