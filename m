Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF976C8002
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjCXOhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjCXOhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:37:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4712279C;
        Fri, 24 Mar 2023 07:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxqusOopXuo6MS1IsrLhD8CN6EqZIKBlcMprOhvdMJpkjsZWfa6x9I093gkH84JLE5yddRyDpt1Y3ItJwRHcqfWkiXodpraYQh7YaCLyK26SXqovCi2QciFYBq9oXm0nkXFK9+3LLJqsqFJomWCv8Qh3SkW0zYrXV6i+nWCEeRkyhpWX2wSEQ1MZ2k8cS3s2JDWRP3M4XbfvbG3MFuIqZJQ699VslEF7s1YI19IK9bMbVKrBAWGUIcGN8eS7PzvoFe/IrJ8JmbpjXG+TWiZS4QwbiRwhzAmG8qjdcCLidFNcuRP6uUx3UZFWbEqxYhRK8Pe/rvfGayTlrfBSmL6sKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA36rjGQaztJzKACtcCbtTz7Hrsky4bgENUo5JjXWaQ=;
 b=X2rKnAKdk0+E3TjnwBKJL0IDmWvVyYx+vL+0TcC6YmlJFEKWwgPA+cvSrYm+/Mi4wJ+5UvpS0vm9oyUdKievjsW1XBnEjgh+qGVKhTZmcp6rKgDpxOXruulvdqhSs0yKYmssQdQG5IOYvtLZZG42g7IYaCj0hGj9nL5MWhIL6gvGN7Htv3n8PY66EcznreyEBynjp8Kqzah9bEFyB9G16v1+GZ5s5BOW1lKi+O6IbxummJsk4r3v/BTumEB/UdZ6g0kxcmWQQZQZEHXpd379Y/F37Tk04M9ZR5qstw3kO6rpLpWeMyO63usdS4HBa54eGxWbIiUGElpcipOLrtE0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA36rjGQaztJzKACtcCbtTz7Hrsky4bgENUo5JjXWaQ=;
 b=2Fu3lyJaLu1IzPNf9895q/8CnMPl75yc3owaEm8Zzv8NMxLFtY8btZGtDGIpZB4phEmX/+K+yc1DLokqgHIuv5N969KwhTOWDtZc/dF3cCHeN409xrQ8ywSz/3RWqp7ZGO2ke7dxusPQBA6E/AXmiI+ExdIFNMAwX0zCAJaT211XsviqIL/2gZAD/NcL4N4suUEwufSgpNUJcojwXd63AuIU2dF5h1bQoX67bvb3n3/qXh7F4zncBc3s/p9DsFfOkWm810IdEojzaJuNY3VEEUkvCaTzmxLmPl8sS7GbdMVxmQ+AUYojc50BMyxWIa6Y3Uo/CuKpY/FBeg2mx7bt6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 14:37:30 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 14:37:30 +0000
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
Subject: [PATCH v4 2/5] pinctrl: s32cc: refactor pin config parsing
Date:   Fri, 24 Mar 2023 22:36:23 +0800
Message-Id: <20230324143626.16336-3-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230324143626.16336-1-clin@suse.com>
References: <20230324143626.16336-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0053.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::20) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|VE1PR04MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c981a7-8f04-46e3-f94b-08db2c754c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knLGLmZi2zQQCS+w3YAVDp/9PVIaMkThwhTpaC+7EEjXKUbxrbRXqxsuF7MnTz1x22IGIS/dUrcm2HlnNsWq2a2SMw35C20yZQwoHUIjnvU1fayQfsuREt/TO1lTNGMjUUwJcptvcG9PePGv4gNWwvxnovJUSY0/ji7atCBCj1aDfEA3O1eqHFHB5xSOOqRmzSx8GsWS9cmyf1et+BUYbzDAegk+1Jq021qZhVIcN4LcQh3bVUJfQRcMTyCFV22SN9CHVngW87vhrBc9NKZYMY4ImEPlRTVWiRgr44O2RCyW9hl0lM6BJtn42AH/GqgFdeYLcMJ5/KlCU85qMd0m6FX8qlIG4tQUkKb8cYb3m73CHhrzxbo5qMvh8yxtjf3hMOtsJXG2vXHnl7UI+F5a38ebCzEQnCiV/mx056kK2Gjp5Z+mE3PaI6z+kzqGYZBkp1pHDObhfrT9onIoIQGqeM6oiviUF25/9NZX0GK/Rb4/C6pMyR+eMSE2/CELjFQGTzwqxsjJWlXPJlOV9mYaTPNezxVsm+udjq1CzuP3zE/kdZ+L4GBtHtN/kDl3AFqjNxiogixR9BOUtM3aJ6e5zpJkqe5Pf77/EsMyFj6Qv3J/cv/x0mIt00ElgEiK1WMagqfvnW2e16Pml8+dCMuahQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(376002)(39850400004)(451199018)(8936002)(66946007)(66476007)(66556008)(41300700001)(4326008)(86362001)(8676002)(36756003)(38100700002)(6506007)(1076003)(6512007)(6666004)(26005)(83380400001)(186003)(2616005)(107886003)(316002)(6486002)(54906003)(110136005)(478600001)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZCf9oSMpr+4NN50ONOZgam782YTns7Y/YeGRrle6p19uZFH1S84W4K9y4xhU?=
 =?us-ascii?Q?+vdCe/zI2Y4MjR7Z1TK4ICK5ahcwNuTOwepfgZsHqus0qN8dWWfKvb4A/keW?=
 =?us-ascii?Q?LIr4rlploKQNOdnNRzNHGZ6mAUv6FilsrlZreymWcUl+dOkJOeB40/zns7JH?=
 =?us-ascii?Q?gcnrkssvzaslkk4u4UazROyK1l9g25VpIk9BzyNe0EsWN65HjW/tqpwB78Po?=
 =?us-ascii?Q?nrFgmmXoRYPagyN1V2YS09LS93pH1LSCqXNBpXCiJEoAmW+lfddK6ab9gOXi?=
 =?us-ascii?Q?dkRDL+31khUfiL8t+jQypuzYTaMqF/zZjCUboYhNYEHNki0BtcQWJtT9O5xB?=
 =?us-ascii?Q?N/BG7bzffEP9Qd6zVJYWT4wZ8D86oI0lqDzeKqAhgszZ2VLL+vSFk6v9kxLe?=
 =?us-ascii?Q?Lam7lmJNXHr9QcVQTRDIkQytFyweHMxw5cr4tSV++jCO2E4kZ6zHQvOaL4aO?=
 =?us-ascii?Q?nsc9gJFcxthoAtfN8k8hTeUxJrqNb/7rTxlwxv5eVL7h2q99CHAcaU8VeZw2?=
 =?us-ascii?Q?mLT3PLcMdYwidoojB7gXPpkWPTdzgYTqIWdnjl993HewmJUEPbdgYyMDqHZL?=
 =?us-ascii?Q?Z2uvU3B494jgVgnMKyZb3YuQhBHlciXKWAKytczTTXAgXc3vKF7dn1DFKe5E?=
 =?us-ascii?Q?LluQ55dnUQUkoKncXBJSnZU59vsluxadvUkLUUc/5KXu2Wxi4aIVnrDU2rdR?=
 =?us-ascii?Q?PTJtiJ1a4LIV0UxaQAwNsPwYLit/UkI49ellh/1CPCP1GsrjLA4QhJ2YaRDN?=
 =?us-ascii?Q?L8zb93BhzaybRd0+lkjShBi5upd4daonomJWHnpjUwN2DqfevdB0Y7h0M4dU?=
 =?us-ascii?Q?9WmLVSUW7XW2uTn0vrNYbts70fXRTexiO7KweriMLfJGaRJZaa+5mgCenKAI?=
 =?us-ascii?Q?h6QfgG5EcpD279AUNEeSu6PjmKXh2wvLrxWwW9pqFMf40N8nBvMbvgQzINZq?=
 =?us-ascii?Q?0KBhNZJ/bow7+gBA87T5IcEuNH27NXyiYXUcOjr2tXjKp8+JQ8oZk5t1qh3Z?=
 =?us-ascii?Q?pbTquqvRXTEHFLVV+n/qVI76BCXpLuZWpjCUYyD6pYsL0VakJG3m+Lvx9sT6?=
 =?us-ascii?Q?2phUeb8wBdwT7vzdQQVYOVRFZ/S0Zmy6hPMATSYnCf1K7qqQUItz5N1I7flV?=
 =?us-ascii?Q?+8Jmy9whmfJmbTTooSx2l9V36IhvcVSpRUuaakjapxiTZGrZASaWHHRkhYkB?=
 =?us-ascii?Q?wt1AB8hHT75W97djyHtpfHofoPuxSpMJdNW356yC9cvwWqRDtRCYSmVn1FIr?=
 =?us-ascii?Q?hAU0r6/e3DDLbO1g7dUehVjpfwEI1/BV0sNwCu/ny9EulPVmQs61889vjpdA?=
 =?us-ascii?Q?LMuMuZDhs/08LC9tasc+kCrUUDbEV7BoWEPs9vjpdT4AaXLK+fQ1frN3885X?=
 =?us-ascii?Q?rwtTFSj9C5sT8vxusSTCE1XY5QqgqUdoOKrIi/OQ2OwS+0vc0+uQXbD1WjFJ?=
 =?us-ascii?Q?sADOjx7ITVPDjAkPS5Q5IttUhmt0bZ1CEJRDNzW2Qbuktic/FBgvlMbuzY+d?=
 =?us-ascii?Q?wnt0hOTltKLlA9+6GlBe+aB4nQKtxpakmmrGuZ3gTI3ctoG3G4CYwez1ZM1j?=
 =?us-ascii?Q?i5SurN2qQdXlmVcrVAE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c981a7-8f04-46e3-f94b-08db2c754c1e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:37:30.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2kBnO8EySvmRCcbw+xJHp8Xc/1MzHeOqEw/wqzIq6xjLTRRZRu2Zk+ItiR0kuq9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
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

