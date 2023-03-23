Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E236C6B80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjCWOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjCWOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:49:36 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07811660;
        Thu, 23 Mar 2023 07:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fuj3W4Md950fd5qD5aXrCXIu8j3PJUSU6X3h2I1hYtjUi/whMkCDjGSjalc4hDOcj8Cih/e2DRc3Rwe1Y6SL5dR6VBL+jsHrK58gD8ib1xIE7Y2YiL2nFcfF5ujliqBGLSkAnbwEQbA4yszmr0Ufd5gStIn74bQx8SvvMpA0v/kTkELy2Ir1sJaoFy57plmSk/b91QfVfA7kafXixhJ/tRnC4E2aJT6BCSwmpXo4ozC6SNpLAoFDLlqtSfAJmnBZM+5dcOo0R6i6zxJxn3Oz2D017mEcyrcamnMTPzibvg1Mr5rp8IN30gWwZcBMk1ZcxhZssdNkTBLzhBjUjpaPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm+Vx6MTV2jd4c9xtkF2pGG0an24ec9FXbgz+8g44Fg=;
 b=T6fCzU4vhoi8RS/8gHG4a2QWGO2S5E+NxGrsKqVebWVX4FyfUkMUiS/0uetMI6PZMm/QxfnnhIO9gHKH2z+sHFqAAAbuOTbmv27lY9QDgxYGkSzDF9GsGvlJSmDxgfburgZ55XtF24gMSEYUqNe2sZBn9Tni/E5lcEANPgDttDoLGotW377xuKfXEE9WFZIb/K+gG2JY2B7olYZvLZQi5OqOO69l3KffwMxLDBzmMIX8rnQAmJW359u7026jgt/D0r+7lAX/ijkl2CK4lmL2oAh9pgsseOkt1TUI86ytcr9zhbcC3VSEFwlxv5/K/S6cS7NUO4ak+aGRAPMJ7ykYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm+Vx6MTV2jd4c9xtkF2pGG0an24ec9FXbgz+8g44Fg=;
 b=Sd8+v6gwPhBL/MbKoWXhRA1eOeNjW8RKGxtkK4cJPwf/SQXZqwHpGD7YlQvhqbgWMTTq/wkha+2e1KfWnTm/ahy6++h1p0uZLScELxaNyln0FR1wImnAsIuXurnUczUBj5rlImLCo6yGkqeIMAHeo9WiDoFnvyEu/dTDXAKg/6eAbyCkvZs7stLVcjAYNc065ptpKjIFNr1xqP/AQs4Y9X4eWnisM8mXhfPbIM6huxrgDHX9r97YUBtM7wyZHkZiA+h4BjRvAQ+HUNhw5+6WlXb/gFpLuKH9nPzWU9NR0RL38CHJWxUAKkBokOwRtEnwdfFYyPwAKCbrQmbRpAGtcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS8PR04MB7544.eurprd04.prod.outlook.com (2603:10a6:20b:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 14:49:27 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:49:27 +0000
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
Subject: [PATCH v3 3/6] pinctrl: s32cc: refactor pin config parsing
Date:   Thu, 23 Mar 2023 22:48:30 +0800
Message-Id: <20230323144833.28562-4-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230323144833.28562-1-clin@suse.com>
References: <20230323144833.28562-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0332.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::18) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS8PR04MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: f59b9066-3cd0-4ac1-1d62-08db2badcd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EsZ5Ycp0sWkWwXdCDL+94Fu5bcMSUrtQ74uSyQYWiMrmYgrXElxVYAVQ4LRj1Hj7VLvwKXWgXtGw11kctBfzx/sMHPEdktNSLIeUU7XWoTzYzcRgkcXaZ+KhLgij71vEjQTMpWIrgFRn+ZVIt9el7Wdi3JBwqtNa2alroKBjw57y7JTnldgvsWWQBjGzp0UeXV/Ch77HKxVtsqIVR9v5uBdW3TNp88/PBkUSUtOneZI5FVarmtwH3whCllSIV0YSxLC3Sg3bbp3U18vMrnHHFVDPXBoVOWraT4Chcm6qpNZn9fqR/cL7RotmMOkeEuaZhPXMburHdmA9OMHQuomDf9wD/3+d4GP1yG0q1GlG5l+sV9q9BV5ret+02Vhd0BJvFHdo1s2zwAPAbfOLl3MND8O8kJwiVVpqFv8/ccjETM8/r9UpeyfGH1lpDpBCCMdy5+6ok+tW7WCAABT8ykVmt82zcbmVxRaayPvL+gkAPokSVaWLabbgakGvP4Ep6CLMLIMB6BFOb0KB9kZuvzZlBe1ae1X+b8aQ5jH1Uiep/TNEckHoiXaLOg5bwlNju1SJr5NrMICtUoa0s0QMOOjk0nXw39vN1oShtMcB1QQn6vjgybzWAQujv1Q8pV+8FeDa8FGd9Oihss6JWlEIRD2J/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199018)(4326008)(66556008)(66946007)(66476007)(8676002)(110136005)(316002)(54906003)(5660300002)(7416002)(41300700001)(8936002)(1076003)(26005)(6512007)(6506007)(107886003)(6666004)(2616005)(186003)(478600001)(83380400001)(6486002)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOBLIp5xZ2Imd6GelnGUa671DPPQCnjBJFisr1xS59uwFangYhTTMhsuImeh?=
 =?us-ascii?Q?zlfUOIGRswrlUywDYBhTKuZoFk0X3S7f+w1RY2LeMlgk/RSlAAV9sj2ix7iP?=
 =?us-ascii?Q?mZGn/4hsGARUPx7M5ze0jgb5edNQRnES3Uq8rHlHnzyhyiSjm+W4N8DtCEFO?=
 =?us-ascii?Q?jqbQnEACa4Dv4NXYnvgvqb7YLmOK1ZTUCtlJsPF+/zs9Xdo02CmcuHxRqMfY?=
 =?us-ascii?Q?h17QTA6VNW+MqhYrfp9k1Fvg8EIpDeoOMIpXQ2L1YkWBgzacAfLF01KrzXZy?=
 =?us-ascii?Q?nPmuQR5uPDl1jdrDOXKqgVodVk2rLjuvXCf1P1ai0Uf+GVmFIzm7suoPwHiW?=
 =?us-ascii?Q?/khiqY+kvxX8lYNAK0AZzjZpqKcPkXlbb2HkttC2I39hflBiIrIBcoikeHwz?=
 =?us-ascii?Q?Bh0CJ+LLTTUiBjf1HPXVc9AG0cHFKKU+gsXLbVZW6VVS60qI50/Nlc+KM4k1?=
 =?us-ascii?Q?4x8ATfSHI0ERblv3ImeQLBClz7KzVBK1Wm5PBeSrxlrtg0acx6flshukCFzz?=
 =?us-ascii?Q?ixw8lTpeOSwFXjFeUNfx8gNU/UHASt175fYY2y30+jodJutbAo8PQqF4UlZN?=
 =?us-ascii?Q?VGj3HqVY0uKtU7P5cOCHK6fJumxrknfsPGBouhTxi0M0ETea9jl8rSoU2+YS?=
 =?us-ascii?Q?Lm+JTAMmx+/IPmBrznTjuQYj+CRuSQ/uLEXswJuun8SYoJon4ssQgrwOQsV0?=
 =?us-ascii?Q?zGYtzT5EQMfXaIqNcCBBNeUL564VT1URvS0lBwskdFj8xH5rPwFdUiu6KIkt?=
 =?us-ascii?Q?P2w3U9gErX1lxY88uYLklgB9gTIeOSEMSi878G1sFl+ZArEoQ9j+/IOgC8/1?=
 =?us-ascii?Q?cNvEIDZTlRSJbJTIyrRQnv3jC0PJ0YkkiLU9Kl/uybqTWqyFI7Oq+VkJ304R?=
 =?us-ascii?Q?Fl2B7Vro+uDiKloqlCU3yOKWQeUAezX1s5jK3dWlh/v4sjF9S6UScgB0V0kb?=
 =?us-ascii?Q?/6GrJu4zrRl4U0d2oqyxxZ1hCKoTk/xK6pjMAGXfzNlOzQ01ETJNmhtdJ/k3?=
 =?us-ascii?Q?FUXYDmgFg/LBfYNOXzrypMn0FlFCcu2GSTEXW+pxPeuxz294hExthYNVgqRN?=
 =?us-ascii?Q?vaU7LbP4QyPnzDoE6rXucuphRDFYy9WVD/TMlSgXDQ1y15gmapvLEwg1Nj34?=
 =?us-ascii?Q?GQQNIouokFwebgjXJx2QhkdfV3UEVFeGtv+svh8rZY6PE1wcIp2O71fU7lHA?=
 =?us-ascii?Q?Bzq+llvE59UUERTtMmDBfT8wpKP8ZkelQAYIuSNqVZSJuGy5nyQ9iSjE949J?=
 =?us-ascii?Q?Lri4J//vp40/SWLpoWn/wIdZ405oPVWEkzTzi5QB7zOjnhlnEFixJRzTeJsa?=
 =?us-ascii?Q?4PYPW3xMdwkuHeBbkgPCAp21uGh9HqRsKC7tYibYVCTNQPpF27clHpUrhc2C?=
 =?us-ascii?Q?G15OWPokk6pa8jH1nahRfwJXmYUftr53EYnNx6D2gPLs4ogYPGUiz2WypKP2?=
 =?us-ascii?Q?mASFZHYQ6aOH7ZgSdwd60dWPF1n2F40LnU1erNBOibAFrwWgtA9PNsvsXYdI?=
 =?us-ascii?Q?DFxg/knt1Ct7FeX74iNSOhxjYT8KOjuMQqV8YTBFkQCIxe1+gapQmf3Bx+Yc?=
 =?us-ascii?Q?KNG64PNRusDnadIcS/s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59b9066-3cd0-4ac1-1d62-08db2badcd16
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:49:27.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMQ8ocR7io/rOc7wIHJg5tJeCZEfm/UZY1FzUvuGt1yZ+x6nHUMg3Za8q96f3GES
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7544
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
that are not actually used by pull up/down bits in S32 MSCR register.

Signed-off-by: Chester Lin <clin@suse.com>
---
Changes v3:
- Move the PIN_CONFIG_BIAS_DISABLE case to be with PU and PD cases since
  they have the same function call.
- Roll back the argument checks of OUTPUT_ENABLE and INPUT_ENABLE cases
  since they were wrongly removed with the PU & PD parts in v2.

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

