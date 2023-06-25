Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E85773D556
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjFYXyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFYXyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:54:36 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2111.outbound.protection.outlook.com [40.107.113.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E41B9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtw7ykokn1MBgAi/dPNFGeimpBIfvfS38fZvf9ngcWBbjBDdezFji9YI5ijRGLJkBvNdFeOuw+4bdzflmcxsfwlpSLJQkdSi9OjcTSGXW3tcQTpivfr9F3ufEWa1Wach6SHCQIOG8NwJtoN23kECfYk8jENpo1p8ND/LVahI5t+qFZTHrJuYprnKARJ82Nze7WRKvmz0Je+XIHMPGHftttaz3RhWS7JQGzWIJc4rvu8/250C44yIGsBAB/oC19CuFgdIu4y0dL/qG+LxF2qagUqAUFV9murvSJQh/kCtVTmSS0s7POIsTNaHtSOA3lpIk2lDOfT0eW9aIAKqAc02KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0o2pBUDCYLXiqD3EDINJvhtlxTXnxpB9cpIK8gV2FQ=;
 b=dWjTbddNEzCR2gfpZACJWUOkZh/avGBlc7IZVD2mW/tGBNkaC7RBbrOAmr5cG4reKhCBYZxRcBn5dL9158rYCK/91nV4wkOKU3W72HUQUvfzbYhP1/9UhfMvQ/SpKsoF0X1HodkoXOmhsMwf0H9IGQQ18zKPK5wdrOHhYlX/wfu5CjvEGpdOjGVszggFPumKl2Gg1C3vsXhO0f10YlQ3ozaDtXHjeFsERQ5hBS6AudMsAtY5n/Pg13UpJQoeKCiNCAKyYEyEHeHlqtwcbrceOl5gDRy42mdFDE1XqG2kKKMUWfrwMJ6/X1kXU8Y96oH9ilADjIJGFq94SMU2Az0TAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0o2pBUDCYLXiqD3EDINJvhtlxTXnxpB9cpIK8gV2FQ=;
 b=ekLslLbz6H2w88nubcdGXkyFKcZtEvUlMG8nYItLVbcVHSfcDNdgfQFGFTv5ZtxPSKhg/aQUmfeS/OPqTWW4MXjMluBMfa0x5TmNe31DuAJMVQGTbxdMsDSf+43/eeaAFtTd7h5WHEPO0js3fLzISjcD/PMwXsG3Cl5I42GIMpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by OS3PR01MB7827.jpnprd01.prod.outlook.com (2603:1096:604:160::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 23:54:30 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::3ac7:b366:51f:3e26]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::3ac7:b366:51f:3e26%6]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 23:54:30 +0000
Message-ID: <87jzvrksi2.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: core: Always store of_node when getting DAI link component
In-Reply-To: <20230623-asoc-fix-meson-probe-v1-1-82b2c2ec5ca4@kernel.org>
References: <20230623-asoc-fix-meson-probe-v1-1-82b2c2ec5ca4@kernel.org>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Sun, 25 Jun 2023 23:54:29 +0000
X-ClientProxiedBy: TYCPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:1::30) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|OS3PR01MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 93067dc2-30d4-44b0-5696-08db75d7843c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1C/F3TCE/5CLn7gyTJ+B9tjmGF8EoPlYvDdTegr463iPxhh7fmv7JaxXNdGlCNxjR/oxHApOe9akl68NAh4u0VW0yvK/A5HOOEau7EJmLpdKhG0tDoyV5vkMTNTWMrfBfHs8SuHvsiTtVi7OXtFAbOIzxc/NB3m0zwL+wdBU4sC/YK+t0hb9doEq2/iKPdI4YtQgaN2hZbKu2O4m+7BI6KEx6yWNLe5o4ocxPdzZDHxJgsXjxwvkrHNcfTuCIEjgBLg1I9/GOv7Bb61/KPR+UTBHSpNipr+SeAvGJuknH626ecglZQXNvRvVYC6oHM/kh6MpS3Qupy9C+1NL7g84lbQZsyMeAy6ZGvM4XBk8CKz5vZNkCBme3ki4UzC1thLfPrHds1zsnEm2blgo0n1nRNpz6S19uy3wp14ePagvb2ZyH927a6PVjwPodRT+dCbZItVobAxaKOHf73801iMd+DsA9JHVswFWZEkTNlgf4+a8zhrBNFXWTpvJb+vS9CDwjDN8WUzFg+0DQYtTBDsll3F5vZ/DBG5Iie5bwf8XEvK87B1IZKnIHUCC0K8j6XfG8UBzcmxH2FwSkoYr3CKmRXYFkajXpBVCmE/GJXmX2PkDlXBOfWSMgVKhVwuuFGe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(6512007)(36756003)(5660300002)(41300700001)(86362001)(6916009)(66556008)(8936002)(8676002)(66476007)(4326008)(38350700002)(38100700002)(316002)(66946007)(6506007)(26005)(186003)(2906002)(52116002)(6486002)(478600001)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YbTJzvveshHUxx5u/Eu8HXrsoFXo283TTeYpXzYfwC/49HOoLTozRFTKF5Yt?=
 =?us-ascii?Q?Zuln3bGU+v2G/NL0AEyhyDOrJ8fe7SAJUoEvGlPLGwZ7ruzzGmQaABt1dq1N?=
 =?us-ascii?Q?j6dAIdVJ16whb9sQc+xzGEM3AH98XvN6rbA8nE+UbK6eSuVbeSy0xpGlaMzY?=
 =?us-ascii?Q?ATP2D5APSiTCQZQTpmi1gUE74FsmdDW4p+kvwZC+qvUw8enzkCbQV8QYFhpF?=
 =?us-ascii?Q?XjEsAJl/YWVwVd3somdEoUr1VDxhVYLEbCDdmCLksnVa4Q+T4IfCID88ogOX?=
 =?us-ascii?Q?xGDitPwUWxVYK4Ov/zFHsFW6Ki8QLf6hJuKK727w0qqJ9jFpAKAzLO+plmah?=
 =?us-ascii?Q?GlLko9XeD5GhbiAf2VzrO5C6RAlTHM/FxIRuUBL72aogpFSwyEcgIFvM4PCE?=
 =?us-ascii?Q?tBl6INtaMHL3W7rOSYXZ7Kt28JhajbO1oVkiQeNt7Kb/f1sNQ7Tm25nF4hn8?=
 =?us-ascii?Q?3YAlZvf1Zq5M2JuDi9CnIApItEPM/1bb6iOVIUnwpm1UBk96yGp1BJ7yuFKt?=
 =?us-ascii?Q?8/ED9aZiDpiBwU+Z58UnJyxbSqQ0Wlc0I6vkk9icuhPDHH6oCKsYYazuGnnq?=
 =?us-ascii?Q?WHG3TpaDxqBG6gmJf1MkFrf48LqRBbhWTFp3D1pzfy3WJokOxCtyCnesDegp?=
 =?us-ascii?Q?KPniVucGmnuNXKE+xeAX8JzHE6NWroGgSz8Och1U0RIo3cTZdQf8gLrv/eI/?=
 =?us-ascii?Q?0wFg3O9ub42tWDiWmag7MKGmJuhrGzyZp1dJM+7LgSxdfodC+zZVs9JX5XYW?=
 =?us-ascii?Q?iA7sBlX2KkJqmZdpURC51x0tM965/Xoi3/iSFgHBuQ6q1w17LpF5i1uvKTJM?=
 =?us-ascii?Q?5banw7kLMSJaS1+HvTZKDH/Sb0KQrIA+SwtdDRnMJHLs8F7W5LqXbomZWtqU?=
 =?us-ascii?Q?pJjA1hn5LphmvZAZpxB3K0vLwbH30zj9To4mTwIeYBJA3oqRWE3n/9KeHyc+?=
 =?us-ascii?Q?SUAn86ToMmcvBnrtGM3/a8UrRChrxH9lHcVw81quKrjHyXP8HzCFSDhfoWTn?=
 =?us-ascii?Q?MRElLGXZu4ltkxms5Cx/SLdXfBMTWoulJB30n9MlWZcBuYgy8nFaFzvwMJBn?=
 =?us-ascii?Q?aIN6cEknPepirdx4IuuuJykwS4ed5OxbcZpIQZoFe0DcbGUc1ky9Okqs9XUX?=
 =?us-ascii?Q?MtsHvXq12K1LPqYPXZvZtha1h1D0/e1XPXloFd/PVLblA7AgDryGDxBFbuIg?=
 =?us-ascii?Q?cqKgc2A3Rpsml7+ZJnYzJTLCERSW1IqfKF/T8u/MTM1tg2azN/G9ZjStjJZK?=
 =?us-ascii?Q?GGqfgF9lC9h3jfwj5OCTz5NYUM0Q3ujYeD45fiiO++cw8HAn/s1UoDm952g2?=
 =?us-ascii?Q?ZG6u5FoytPNORw/36ZQq0ctymaltiC5xx4N5vw/WwKv7cL2Gp5d5lODQ93fO?=
 =?us-ascii?Q?+3fUeBNeezAP/ccRQFnxOiVwcVlpPk1aemm/KLTY0+4QONBQ4Ve5DVGevxfD?=
 =?us-ascii?Q?yCfaqBPZRLWn0WcvQ0MknGpBv4KsYFrjxTesvL0BKLSHvuJzPZWlJuAdxLot?=
 =?us-ascii?Q?/np/DI3+6EaYBBYJLa94azCJS7pd4EENYs9d19tuZ3Hh+stL2NuAFxPdCB+f?=
 =?us-ascii?Q?V62ujc5/TzNvQGY3mU88SnJU01AV4GYnKJ/wAen3IRAbbZHcIjMR+0xnWU8r?=
 =?us-ascii?Q?gAd3T9rzVZf+q7/chGMKFQg=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93067dc2-30d4-44b0-5696-08db75d7843c
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 23:54:30.1426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MATtBXATPm3aYHWlcrEJCCWto8gZQmllsQVZL/lxEFm8ojCFaVaeOBnJL3FdMubTMtOOgRMk/Cr50y9MOh7BM6VscaXd2ekHj1HSkMvYI87bz+L7/JVvlxeBfk60dpBk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark

Thank you for the patch !

> The generic snd_soc_dai_get_dlc() contains a default translation function
> for DAI names which has factored out common code in a number of card
> drivers, resolving the dai_name and of_node either using a driver provided
> translation function or with a generic implementation. Unfortunately the
> of_node can't be set by the translation function since it currently doesn't
> have an interface to do that but snd_soc_dai_get_dlc() only initialises the
> of_node in the case where there is no translation function.
> 
> This breaks the Meson support after conversion to use the generic helpers
> since the DPCM cards for it check which component of the SoC is connected
> to each link by checking the compatible for the component and the Meson
> components provide a custom operation so don't use the generic code.
> 
> Fix this and potentially other cards by unconditionally storing the node in
> the dai_link_component, there shouldn't be a binding specific of_node
> selected since that's how we determine the translation function.
> 
> Fixes: 2e1dbea1f8a3 ("ASoC: meson: use snd_soc_{of_}get_dlc()")
> Fixes: 3c8b5861850c ("ASoC: soc-core.c: add index on snd_soc_of_get_dai_name()")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Yes, indeed.
But I think we want to set it under lock and if ret was no error case ?

----------
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ab1f302ee078..5cc3f4cc9d1b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3375,7 +3375,6 @@ int snd_soc_get_dlc(const struct of_phandle_args *args, struct snd_soc_dai_link_
 				id--;
 			}
 
-			dlc->of_node	= args->np;
 			dlc->dai_name	= snd_soc_dai_name_get(dai);
 		} else if (ret) {
 			/*
@@ -3389,6 +3388,10 @@ int snd_soc_get_dlc(const struct of_phandle_args *args, struct snd_soc_dai_link_
 
 		break;
 	}
+
+	if (ret == 0)
+		dlc->of_node = args->np;
+
 	mutex_unlock(&client_mutex);
 	return ret;
 }
-----------

Thank you for your help !!

Best regards
---
Kuninori Morimoto
