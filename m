Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E746B0FB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCHRFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:05:09 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8432B1;
        Wed,  8 Mar 2023 09:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK80AtDmR3YZ8dQ+fNJcXNJUwm21ohfzj+hDF0jzPgQmfOiabSaE90M0FqcfiAIwE1aESEMYmG2uu7BbJeAa1goRKaOkOyTpgKlrjMmSRlakD06gCjhWemGP7PJ/WNQ2M9l5csPRztN/cBvLlSvrnnvgdPaiQaDskir2scmreloMIXuqis8cszAjdDpwZ9E03mURpcvnsn9dHUaPe7d8pH7IGk0e/wE1/iS9Sv3XmQGmi3m+5HWVi55RtAObLfW6vCTL9cYcSiNnh/GRpmjynPqT/UYWdsVa125hUKH9J9RM9L5E5pZ0tmZAt44AHAR9vU4+AWm9s54+2JDzOTvbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtjttpMPDUMC7Zfu/UD1mMg2X4M52/+RCxzvjzMgrBE=;
 b=j+StVwG+ifhHMMG4kNz1svORfZB0iPG7wsU0g8qHz7fdpKayZplT3kP0PQ20ejSzsj0zh7fOqvKO3lYiYi94TEss+vbn88vALQ2jB4Ir0+MvWY6XPokZAk/SK8OTzbXhGoj5l6gLcyNVdh/zXgd7Xxq7a1nnNE0Jq9EmCs0aTmqr8vwpn0UxXksa9xZMd3ag1wkEseBA4K0jiUZnkzoETh9qdaIyo8UWjmA3kBCOq8Om5V69NmYJE/AHUhRwd+V0CIo0IC8jCOQUU/cgHBQ+GSSbpFqtTZIPHmnWERdmujhUw35vA4jJ7aZ74zzDxF/FG1XvYY/3KSipzlstFRzCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtjttpMPDUMC7Zfu/UD1mMg2X4M52/+RCxzvjzMgrBE=;
 b=fe0cXlLWsTa2Gg9ZkN5A3hyAQu6NXC2aaQTRgsXVsz25cLWkCNLY02xv6AlbNx9ZlA8FIZsGbcudS05W2L3Y9q0VlUKcj+E9ePwKI/VuZoHuvDXlqkY/ivRw9tietXy0reGf6fO5HF44nsMv76uxFgMISDTgVzWLMFMarVpqwi3Ns382Mu0irMamo3sc8LNhEVq4mXHU9DgC+eLAODOYZ8BM1KEEpKpam2XhEHSevZgbADP6CkaE9TTWgS8AHyEjLN+U+zsIfzO0A/5p+H2XUnMLOEp7aNZrZxeS0KnwrE3nvoF+oGs+nvf3gwvlBmtMuHot0c6+BYdvXoab1Iquxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 17:05:03 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 17:05:03 +0000
Date:   Thu, 9 Mar 2023 01:04:55 +0800
From:   Chester Lin <clin@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH v5 2/3] pinctrl: add NXP S32 SoC family support
Message-ID: <ZAjAN4mO8U1Dh86P@linux-8mug>
References: <20230220023320.3499-1-clin@suse.com>
 <20230220023320.3499-3-clin@suse.com>
 <ZAZ3CeYiZxR5zlRu@surfacebook>
 <ZAgXCi/BzyEQul9B@linux-8mug>
 <CAHp75VfxffTvAPSB4D2Oc3-vbiYM4DVpZf5=jRYGsCdFgAyxJA@mail.gmail.com>
 <ZAi7CPXX0z80mKfQ@linux-8mug>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAi7CPXX0z80mKfQ@linux-8mug>
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fec5356-3d13-4528-99a8-08db1ff741fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OYVhG4BNSaEVQgSAfRhOT1v/EaRZpd86f9TdGBl85DLgrs7p3XDFIqrjj435aubng/RYAf/ybYoBeDXOFp+hM6k76gkYkEmj+vIHI9hVqmN68/0vB88GALF8KWUsM8IK74TW4ZebYRch5LryVzkIoCU7H2CexYm2WvvsxC1aoRpJv7MXLSjWOUg8eJJW1L4tCW9hKRKx753NFmwf/yYnPnPpnSQc06f/dwui2qAKxFKbZIOrAseUSs+FIU5DwfYBqlwhbJtp6KWHX7pkjiI/NVxpTcHZrgJaNA8LYxVMCGopFeShBiqizb3bxeF3p/YNegDpOfmlQq0RsclA65sMKQgZxb03drW9HXydDPtVmyBMRMqY1bGeAWi0OesdXl1b1rOKwIadxLyTGPr7BgjKmiYH5fvo/tnwYS0H1TTepGWlfRdLXByvHfKThLK9FD6m+qOvPtutjVwNKLCVH5ea5EaXSN0WekX9nKsq+mGi7FAJWrYJ6O8wQs2wyBlKFsgha79et0RET2sHhaBaaZOVe2oypOpQBh3mQpFqexv7PUAXMOlMamHo6Q+Q9trh2MGGaGbzjnvmww6jPUwkn1PnFksEhi3ofj76TKNasta2TcrpG3inx7mbxegy1T8d3GU8AbhYqAed+jS0DKqsWXr5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199018)(2906002)(5660300002)(8936002)(7416002)(41300700001)(66946007)(4326008)(83380400001)(6916009)(66556008)(8676002)(66476007)(54906003)(6666004)(186003)(6512007)(316002)(6486002)(478600001)(6506007)(53546011)(38100700002)(33716001)(9686003)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?621rQjmZDx2TrhILwwE/8652ZsR8m/Ub5PKbIy47hEToG/xN9+pn18ddBk+g?=
 =?us-ascii?Q?gXbCpwdtEfKY9hiyl4tdicqwGPVqkM2h5C/bMZ2H+BU0Z2VBwzbIGpvVEm+4?=
 =?us-ascii?Q?DMOPeYN3oYeRUhm+cxNWqbu53eNMjhSl9rLsYFkhotAp0+6K4t6/hGyd7wUl?=
 =?us-ascii?Q?RXjFwJBNlbNGNU2wRJc7OdyDiFdcYe1a3ZPPQ6XTBigwkBgQdR/B02G3h0CU?=
 =?us-ascii?Q?GFavPhK9wdbWcW+Vc8aHyOObujoCn9zoLGpbvgcFn2rCGiRDehObQQE3CSu7?=
 =?us-ascii?Q?gaZGGtoYsim0U5XOPAn3GSEJv8PiuQ4sFM+tGJWgmFZ8VbES3Ju9JenADnsg?=
 =?us-ascii?Q?lOzSlLNO+UsEEWbPTOacTzXG9Mu8L+UX/Jg4P6T4kwWf73EYvoC40DGPAb95?=
 =?us-ascii?Q?K3ewoN+v2S0rfOzGlZ4jJ6JZ07LadtJEY8AgqAf7nJjfvhdlyLFxBujfM1Rr?=
 =?us-ascii?Q?gxdlnOdvx8qAcDWu2KMs/Yp+gbo2NbLRxqgQY/AUB7YoovBMNO63r+2sQiKk?=
 =?us-ascii?Q?q/7HzvokrhSuteatbwJIsrXD+xhN8PU/BPYK27cK6zYJiS/pn1AZvhYsRW5k?=
 =?us-ascii?Q?CHWRb5fHuRnBYdRKuKXuRqcZ19bNDOy9/K90/BC0oLnvH4KMIAEz9vNnVRyQ?=
 =?us-ascii?Q?x2OPMLPl5rfB2VRwyR73pboMoKQ3AKDjfbK0ao6Mf7dD8PvD+admFPjFhf6F?=
 =?us-ascii?Q?rRegZeq/TmYd467nqJRVmXgr8vpbVI3hmVZ7OuvjzFH4URNqHe29JdEDu8f2?=
 =?us-ascii?Q?t5S6WKKPrfqoxsEAQ3lE/rozp1Dz2QaLS5nGa3rH0B1I+2oLzkOJP27gDldB?=
 =?us-ascii?Q?q8seQUrf+jLdYmJng4eCzE6q5tWodIlbBbg9J3gyFNzYyko+hQMTOyufLNNs?=
 =?us-ascii?Q?otHETG5W4HdLjmstd6cmuO1LZVVgdAVsTu/IY+V7IlnUV0y4DIGnYj7aghNH?=
 =?us-ascii?Q?jtMjl3ggwIEBQcU5G3fxOvAeUX50YsWCcVDE/MSbVLxwh4H3Vf0G8lltqfWg?=
 =?us-ascii?Q?nH/Z3V5utt2IsZpgRPI7ncgCGzDx6qcQ+gCrWzT7ezImIB/l7omgoJGZUiax?=
 =?us-ascii?Q?MQCXqUOvTI4f/6PbxE1nEudnSlhdBD7nc9yp8P+QPsj/nv0jfLKSB7LdNhDd?=
 =?us-ascii?Q?N6FqZIKB+jJdGSVJxXgqCUMLCGeCkLFPOTHXALSHn6otSxYq7znmy+bgBhMJ?=
 =?us-ascii?Q?/gCcaiskse8KraCAzIFf3Io0FkjqfZw2mJiomsI4m0xhLScA49kuXRWE9Y7p?=
 =?us-ascii?Q?tCNXf2418zolko7RYSIV3HvcWYZaBURrg/D56thfZYzu/Jsz9jhROHX+Tqox?=
 =?us-ascii?Q?L+GcP7/dPobKkqQlFZ0kKc2HM3yuHAoHiq9nIllKN/SdvsvMhKZkh0of0wdE?=
 =?us-ascii?Q?0mrdGqGSvRdCx6+fbtlf940Yc0taE3E5baSrTxwQr9nEHr0K4QoXIHBT4MHd?=
 =?us-ascii?Q?WIXBEUCHlToUXsj07NIuQF9lecm3AiODKR3/4JiPs4kj9VyrZc7RzpaNhvxE?=
 =?us-ascii?Q?gipc1DXB/3gdCwFzzxQS2V9PTbS3AHGcNWeNPWKITDdd2JpwoZPJmKWN/xnV?=
 =?us-ascii?Q?jGFDQL4RSl1NH2OGy6k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fec5356-3d13-4528-99a8-08db1ff741fd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 17:05:03.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kasYTVOw3wEltumMsUQcACOUSH4FuClPXEyRRRlXGZkjlEisK7AaUpZYWorrcxYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:43:35AM +0800, Chester Lin wrote:
> Hi Andy,
> 
> On Wed, Mar 08, 2023 at 03:21:00PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 8, 2023 at 7:03 AM Chester Lin <clin@suse.com> wrote:
> > > On Tue, Mar 07, 2023 at 01:28:09AM +0200, andy.shevchenko@gmail.com wrote:
> > > > Mon, Feb 20, 2023 at 10:33:19AM +0800, Chester Lin kirjoitti:
> > 
> > ...
> > 
> > > but the driver patch
> > > has been merged into the maintainer's for-next so I would not change this part
> > > unless the driver patch needs to be reverted and re-submitted in the end.
> > 
> > As I said you have to keep it in mind for all your future
> > contributions to the Linux kernel independently on the destiny of this
> > one.
> > 
> > ...
> > 
> > > > > +   depends on ARCH_S32 && OF
> > > >
> > > > Is OF necessary? Can it be
> > >
> > > I think it's required since the driver file refers to of_* APIs.
> > 
> > And? Is it functional or compilation dependency? If the latter is the
> > case, what API exactly isn't providing a stub?
> 
> I was wrong. Looks like the ARM64 arch Kconfig always select OF so it's not
> really necessary to have OF here.
> 
> > 
> > > >       depends OF || COMPILE_TEST
> > > >
> > > > ?
> > 
> > So?
> > 
> 
> Since the OF dependency is not really necessary here, to fulfill the compile test
> purpose, the possible dependency might be (ARCH_S32 || COMPILE_TEST), but it
> could meet a compiling failure on the reference of pinconf_generic_parse_dt_config()
> for those architectures which do not select OF by default since there's no stub
> for this function. [pinconf_generic_parse_dt_config() is called in pinctrl-s32cc.c]
> 
> > ...
> > 
> > > > > +   depends on ARCH_S32 && OF
> > 
> > Ditto.
> > 
> 
> Based on the previous assumption [OF is not needed and PINCTRL_S32CC doesn't
> depend on COMPILE_TEST], selecting PINCTRL_S32G2 wouldn't work if it simply
> depends on (ARCH_S32 || COMPILE_TEST), for example:
> 
>   WARNING: unmet direct dependencies detected for PINCTRL_S32CC
>     Depends on [n]: PINCTRL [=y] && ARCH_S32
>       Selected by [y]:
>         - PINCTRL_S32G2 [=y] && PINCTRL [=y] && (ARCH_S32 || COMPILE_TEST [=y])
> 
> So the better solutions is to still have OF in PINCTRL_S32CC, such as:
> 
> config PINCTRL_S32CC
> 	bool
> 	depends on ARCH_S32 || (OF && COMPILE_TEST)
> 	.....
> 
> config PINCTRL_S32G2
> 	depends on ARCH_S32 || COMPILE_TEST

Fix the dependency here, it should be:

config PINCTRL_S32G2
	depends on ARCH_S32 || (OF && COMPILE_TEST)
        .....

Just in case if OF is not set but COMPILE_TEST is set.

> 	.....
> 
> Regards,
> Chester
> 
> > > > > +/**
> > > > > + * struct s32_pin_group - describes an S32 pin group
> > > > > + * @name: the name of this specific pin group
> > > > > + * @npins: the number of pins in this group array, i.e. the number of
> > > > > + *         elements in pin_ids and pin_sss so we can iterate over that array
> > > > > + * @pin_ids: an array of pin IDs in this group
> > > > > + * @pin_sss: an array of source signal select configs paired with pin_ids
> > > > > + */
> > > > > +struct s32_pin_group {
> > > > > +   const char *name;
> > > > > +   unsigned int npins;
> > > > > +   unsigned int *pin_ids;
> > > > > +   unsigned int *pin_sss;
> > > >
> > > > Why didn't you embed struct pingroup?
> > >
> > > I did think about that but there's an additional 'pin_sss' which could make code
> > > a bit messy. For example:
> > >
> > >         s32_regmap_update(pctldev, grp->grp.pins[i],
> > >                           S32_MSCR_SSS_MASK, grp->pin_sss[i]);
> > 
> > We specifically provide those data types to separate generic things
> > with custom ones. I don't think about the code getting longer, the
> > access to the proper data seems reasonable to me. Look into other
> > drivers that utilise these data types.
> > 
> 
> Will change it, thanks for your suggestions.
> 
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct s32_pmx_func - describes S32 pinmux functions
> > > > > + * @name: the name of this specific function
> > > > > + * @groups: corresponding pin groups
> > > > > + * @num_groups: the number of groups
> > > > > + */
> > > > > +struct s32_pmx_func {
> > > > > +   const char *name;
> > > > > +   const char **groups;
> > > > > +   unsigned int num_groups;
> > > > > +};
> > > >
> > > > struct pinfunction.
> > >
> > > Thanks for your information. I was not aware of this new struct since it just got
> > > merged recently.
> > 
> > That's why the rule is to keep an eye on the subsystem development by
> > regular rebasing on top of its tip (pinctrl tree, devel branch in this
> > case).
> > 
> > ...
> > 
> > > > > +#ifdef CONFIG_PM_SLEEP
> > > > > +int __maybe_unused s32_pinctrl_resume(struct device *dev);
> > > > > +int __maybe_unused s32_pinctrl_suspend(struct device *dev);
> > > > > +#endif
> > > >
> > > > Please, consider using new PM macros, like pm_ptr().
> > >
> > > Maybe pm_sleep_ptr() is more accurate?
> > 
> > You are the author, choose what you think fits the best!
> > 
> > ...
> > 
> > 
> > > > > +   case PIN_CONFIG_BIAS_PULL_UP:
> > > > > +           if (arg)
> > > > > +                   *config |= S32_MSCR_PUS;
> > > > > +           else
> > > > > +                   *config &= ~S32_MSCR_PUS;
> > > >
> > > > > +           fallthrough;
> > > >
> > > > It's quite easy to miss this and tell us about how is it supposed to work with PU + PD?
> > > >
> > > I admit that it's ambiguous and should be improved in order to have better readability.
> > >
> > > In a S32G2 MSCR register, there are two register bits related to pull up/down functions:
> > >
> > > PUE (Pull Enable, MSCR[13]): 0'b: Disabled,  1'b: Enabled
> > > PUS (Pull Select, MSCR[12]): 0'b: Pull Down, 1'b: Pull Up
> > >
> > > The dt properties could be like these:
> > >
> > > 1) 'bias-pull-up' or 'bias-pull-up: true'  --> arg = 1
> > >    In this case both PUE and PUS are set.
> > >
> > > 2) 'bias-pull-up: false'  --> arg = 0
> > >    In this case both PUE and PUS are cleared since the pull-up function must be disabled.
> > 
> > So, split it to a separate function where you do the enabling only once.
> > I can point to drivers/pinctrl/intel/pinctrl-intel.c for the idea to take from.
> > 
> 
> Will do.
> 
> > > > > +   case PIN_CONFIG_BIAS_PULL_DOWN:
> > > > > +           if (arg)
> > > > > +                   *config |= S32_MSCR_PUE;
> > > > > +           else
> > > > > +                   *config &= ~S32_MSCR_PUE;
> > > > > +           *mask |= S32_MSCR_PUE | S32_MSCR_PUS;
> > > > > +           break;
> > > > > +   case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> > > > > +           *config &= ~(S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE);
> > > > > +           *mask |= S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE;
> > > > > +           fallthrough;
> > > >
> > > > Ditto.
> > > >
> > >
> > > It's similar to the case 'PIN_CONFIG_BIAS_PULL_UP' although the PUS bit is assumed
> > > as 0 via the config variable so only the PUE bit needs to be configured, for example:
> > >
> > > 1) 'bias-pull-down' or 'bias-pull-down: true'  --> arg = 1
> > >    PUE is set and PUS is cleared.
> > >
> > > 2) 'bias-pull-down: false'  --> arg = 0
> > >    In this case both PUE and PUS are cleared since the pull-down function must be disabled.
> > >
> > > > > +   case PIN_CONFIG_BIAS_DISABLE:
> > > > > +           *config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
> > > > > +           *mask |= S32_MSCR_PUS | S32_MSCR_PUE;
> > > > > +           break;
> > 
> > Ditto.
> > 
> > ...
> > 
> > I assume that non-commented is equal to silent agreement and will be
> > addressed accordingly. If it's not the case, reply again with your
> > objections.
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
