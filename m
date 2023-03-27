Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32C6C9B64
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjC0G2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjC0G2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:28:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C6D49C2;
        Sun, 26 Mar 2023 23:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK0/OiWRVlSLAdqWGJ3P/cKNB5KJJ5IrZCTITTa7NLYh5omcwv90gAs5nC+IgAel0H7srXJH84wKYIMijYb/TlQtwWhULAC8jp3bytIzBfqF35Dhir0FH7MyTo983GsumhFwHW9X2e4ipTjEFCEQ1kWlUY2717QUUDCyHjDCYDiHSsAh+JfHXMfXLkFNnAO9DL/rbSjWPsdZ+aDCb51Ml02rIxgpbTzKmt2knG0vumq5Bzth9amOdL5thEM69rPL/NSdoLpplBOmfyPzw0Barbo/Turnue5V1Wzon9PAFUJ1GDyBrD1IJk9Fq55H1/+ZyJQvJUvHAII/SwvoccdYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA36rjGQaztJzKACtcCbtTz7Hrsky4bgENUo5JjXWaQ=;
 b=hoHIvSc8lE9ciT4HzrWkkS+8eOC6ngHT4xvyabkH7F81E1m5m6O7tAumFz6gvBbZKmRODaWGAAkASW//ue1/d7eUvWCPtSPTbRoBFryB8rBvxbPELjtG13pQE9/7ZeHRjv/GZjtLOm/FltFtAmttUdtd8P2D3FCsiPJqTMDca/RDvOzBn2c+YnEahms+pnOx76yHqRJ9ZA31PNQuqECCqnrLXlXKlVwos374DgMMY8wpYIjKiHc+xo2acig6nLUoJnvBdfLNzGJdjPwsvWWYKPHY/jMao+BX4zy9fx9IVM75ps7i51sAc0CmUjgZeRdMMtyF8tQfqmcGNuLkQTMsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA36rjGQaztJzKACtcCbtTz7Hrsky4bgENUo5JjXWaQ=;
 b=EjmlyfhxqQ6xmQYo7sLTZ6kHhXAELt8Yqs0y4mkFg3/Znf2P00KWHO0fgF47FyWjyVhWkh9xhvUmi274e1P19dnqJ6DAwTp4zhED+f27JiAxTd51uq9f2BLwwCbvXtkgZ/MQZzQtH/yaRWQBQyKgM2KGT5afvRmnvXr5F2Vg2LDonsUyELpySHs3sOcfzoecMhXgl/IFekVyBs0DibO/3K3yaYlFqMkRBNQUfYTW2QjhloezoQanBq1CI6vLJmqrwd/UkrAsbJdSLyqsPZYxNeHhVn10jN7V4N9Dyiz3yehILcz7SD5jrUxuL/Q27pDD18dGi9wvXTWvmRQd8RtOsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 06:28:23 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 06:28:23 +0000
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
Subject: [PATCH v5 2/5] pinctrl: s32cc: refactor pin config parsing
Date:   Mon, 27 Mar 2023 14:27:51 +0800
Message-Id: <20230327062754.3326-3-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230327062754.3326-1-clin@suse.com>
References: <20230327062754.3326-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:404:42::15) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DBBPR04MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: d431e439-dc67-4518-8405-08db2e8c7710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fA7jQepgrMfM8MyfU8nJceDhqkTAkdTLB9tdjJa9fXjcCa4YDIPws4AcX/k83WeAB7uSHOACLd//FADM1K8pf63NcMpgFaw9sCgOUwvpaspnB4RU5poelxjd1hVYXMI4PqLaW7l69oCTHeescloCyl3Z8i3vKwwPSt2ZJII3tx7K4k1rQBhuZ0n2KoYAn1J2n4awDgssvgI/LsTarJ6z9auzeJ1IBvN2HGcgqhcglr5bzgoqJu/RcuN8d6p0rwnEcZoHVcXnEZt2BYK1C9LWlGDySB8hWaFs7tM+P5RZmE/P5l/I93baTG294q69C2FwEd/xp1WSdMbzBcQLL8EyjgZvSP2prsStzZ2P97X81soqkpV0gdkMJlnPfrUrQDpsXGtIwfj5gu4NT/D88Eeh2kRtNarMY8FrSKNEG2R/XQ0BTlFiNMuo5AI7UUJd2TA9rOoL2UPTmyR9VrNTZE8bZnfl7nw8OnctVXWX+OsPg8Zp3Ek7KeZTCCrTqUuDolYKhrkil1+OXP0Re+EpDOMlk9qD1mMHIVn0D1ctvEc8xymYVjgPUOCu1cV62GCHMl6L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(316002)(110136005)(54906003)(478600001)(5660300002)(8936002)(36756003)(86362001)(38100700002)(7416002)(2906002)(4326008)(66556008)(66476007)(8676002)(66946007)(41300700001)(107886003)(6666004)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SDfMjMR6aOF7O5Z2wnOKJdtJP7c1+EAI8QUqm4M/PpTd7srO1o0phGccIvK1?=
 =?us-ascii?Q?uRfbty7wVayD+QQ5FQjPgqyQW9vILOyv4WszBWPksIHKk4pwiYaO7gzYoyN3?=
 =?us-ascii?Q?NRl8iAYhk+fNuA1GyQwIhcQ4NRUZYAmI9PjPEnEEf9xjYrCIONY0SDZONXef?=
 =?us-ascii?Q?BnGflfRs2XoV/JpQai5lG8ENpPnsv9yDHwrJbFhHFEg4M38K2PfTOvTxbM5N?=
 =?us-ascii?Q?Uzol8i+Hi+CoUd48OK1FY5akIOBkPZrDgQ1cTWEgv1Qsvbr7U5Lr7AeqbV1a?=
 =?us-ascii?Q?s6/QHEJm1SIay3junkPUsBfUDPf+xH4umR4z+D5T2HX96Okuy9D8/5aksB7z?=
 =?us-ascii?Q?BAl0IyA3YCfpelTomD86e4xX9KK2dFUpXTG0xdN3pVAiHWf6/IA5d30vZU1Y?=
 =?us-ascii?Q?E2p/dIn0GgE0J9FI5Dmi2XfZRVhwvY/23lU7hytbY6vfsdqBbcc6gI1qGU4L?=
 =?us-ascii?Q?e1m04hWKuaLfmkTx2qqjbFcvb1EzOVRJhWauWCotQWt3T2DY5e5T/O2KY/xJ?=
 =?us-ascii?Q?iE0jvqM+YlzkGwUsfmlQ0DtEsCqTBN8SflT+csU7eNoPtefHctSu5Js3Lz4M?=
 =?us-ascii?Q?KZ+2BB4N1FIoS+PgAzgIMymy5rRBTtrvkaADFtcl0E1bRaFf+cKudjHyZYIt?=
 =?us-ascii?Q?dAv2o81gTRjJ6nDwI08p4HJxmyh2j7NcvprhUcSzuo1PWa/mAL5c80gLOtMq?=
 =?us-ascii?Q?h1f/PGB4skKZWx0+1PmgLpM3+R/8s/79c3GQvUg8dQN34Of3yoV/IodMnFX3?=
 =?us-ascii?Q?aBXBSsbEi056YSBEHvlFjw23Ury8a4uslffg0TaDcLWhPKhXhQ8QvaR/b2M8?=
 =?us-ascii?Q?S0snrcM6TMM0RMiidgvPg3iapSioFD1ATVp2tB5qufCz8l5cy7Dv4jl/6iGy?=
 =?us-ascii?Q?EGcSmbkTKj0y2TPyXVtynEpzlFDlLSZaop1ZeIiK7wrg8CLJhu/2pOHurYcw?=
 =?us-ascii?Q?cO04kqFt0HPz1oIEmy8meIUTkElP0jeZTnpKVt7kXskBRszpRn31/fFVAht7?=
 =?us-ascii?Q?FnrPeS7xS80d/+jJqClCbrsXPKUr0uHz0rV64QxkH5XrLbaN3bNcaxk88PlS?=
 =?us-ascii?Q?O2D+RmR+aHeiWZXE5cD2win+MGz1tZo6iB3cUyXLjgxEYP9mokXC56RoIdeO?=
 =?us-ascii?Q?Fj1OKvBJk7/ZvqpRZAh8o9L8dRJ2Sg1WQIXx0xUytv6PGYj4d6Fy1adCX+nI?=
 =?us-ascii?Q?vcrrBgYZrCW3Jh3H8pxcy+wFf0/YJrB6Mcu5GnL+/cRxW7o9wzQB8FTKHJca?=
 =?us-ascii?Q?5GHQDRQ9kVECVInM+PrXlx4LjZjT/jJNiz0rOtdw7B9hxJGoRqNCMbZs8ax9?=
 =?us-ascii?Q?gcHxhSC73hKqwC8KXkO9WOR3zn2uenzLrfNPQUW6MMIo5Zvi0zUEsqz6hmvj?=
 =?us-ascii?Q?QPHWz+uQe8YHdbKo4H6o3tawckgBMVIi5z+MiabYJi4WSduTDs/8STgzUpLv?=
 =?us-ascii?Q?+aQWiZknwt/accZOmA/PhBsQLmp9lIA3QqHMrMnqpmp0nWVJqLkKQsjvidyB?=
 =?us-ascii?Q?uxMAzaUIuPmc8IXJOSCpDY5TKWcPhVGRvSDLdf1eHElR/OyhxIE1v67V4rNU?=
 =?us-ascii?Q?GfRRC6fQiwAgsybdEP0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d431e439-dc67-4518-8405-08db2e8c7710
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:28:23.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FP2k0MtQaWXGakHQiSO9Ecmeb3zd9w7mBBZ370DpmbxTVb1/YN+S25QmtSxX27sq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common codes into smaller inline functions and remove argument checks
that are not actually used by pull up/down bits in the S32 MSCR register.

Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
(No change since v3)

 drivers/pinctrl/nxp/pinctrl-s32cc.c | 52 ++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index f698e1a240ef..36f323f87785 100644
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
@@ -508,26 +535,15 @@ static int s32_get_pin_conf(enum pin_config_param param, u32 arg,
 		*config |= S32_MSCR_SRE((u32)ret);
 		*mask |= S32_MSCR_SRE(~0);
 		break;
+	case PIN_CONFIG_BIAS_DISABLE:
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
-	case PIN_CONFIG_BIAS_DISABLE:
-		*config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
-		*mask |= S32_MSCR_PUS | S32_MSCR_PUE;
+		s32_pin_set_pull(param, mask, config);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -553,9 +569,7 @@ static int s32_pinconf_mscr_update(struct pinctrl_dev *pctldev,
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

