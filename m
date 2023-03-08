Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7786B0F17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCHQnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCHQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:43:36 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C719061514;
        Wed,  8 Mar 2023 08:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/B46cMBrF/rt3onmDu8ei47B6gKT0FtPQ6D7QurcKOoxVsfjPcmyB7DwvQQKPFSGJJ/TqcqgAvETM28emtGLKSJc5J4lL0oCIP+KV7qjusy0r7aF/TFnXALC1Hw7yzF/XZI2DQ4Nwi9b5u9K2Mtx7epf8eaDJ9Gksifyuf3jJmpikM03iHDAQuU918WNhy9inWPG/6YLSFxAN+mDg2avqwC8sa+pF1aIF2Cvt8J85lViX3I4UhBllVBpsol+Q4gajks3qRvO4wkdY4DfZFrbgbDCw112vE1ZsSH3dLIIGjFgJb+Qknv84jOccbPdkiTct1Wpncie0MI0MTu658zvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkVYidusz9H8zHvCfqLTnNLkP+d5DEfF711U5eIlh+Q=;
 b=E5FPj4ZpjRU1qFALofcbgX7jDjHm92rEo8nWtsV+K5jDJxBSs+L1spH+Qe6+bdp8FpFcUE/P+9tRvBh/ez2zW7sJrRJ3ANb0ss2uUAyYnO6qpByvycTNjSWmZ5LW1oy7HR/fS8dohKpTjpfhqeW6+G3mxyVoFwu1YTbYzRmmhuRewAE/d3ZHi0jQqjn5+Kec1foQUCbu2V6iU6W5U5DlgcqPnCfEjamosTqmxqA23WA6hbC9/O9W3zLBE+LY50eut9hJcJcm3HjrQULsGK/IFKBdvwx9OWKHE8V/DY38tvjy+dVq0j0S1zCMC6kzp2o9wExdxrbsqi8tnMyZWjwihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkVYidusz9H8zHvCfqLTnNLkP+d5DEfF711U5eIlh+Q=;
 b=EmVWIxDBnfoKtjnha1+yjui0gg+C5yvBSLMjuP2bkm9s/BdEY51euh/0Az0E78rj7zzSQtAtqAWGCi8smC+PNWmnYBMqsUCD/skf7o/BG57gIoVZrjtVBMXyIcid61Og1jCO3GC1U/yxCPl0aE7pWxCilEvb3gCMfWBx58LF5jsuaYdOY08ZkQo1UN9azoxWO/7h1S85gxrYA3rN0Kd8RL36DBSCXZuheiWxP+1fbu7F2Y13wlFRoB199fOrFn1v6P0ltaB9f0Bz+2aYzDCu8sKj8QRj8OiG0f+OP3VVHJMQpSZyak5RIWhqwQIlOjRnaCipY62gmxt44/A62My1CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 16:43:31 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 16:43:31 +0000
Date:   Thu, 9 Mar 2023 00:42:48 +0800
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
Message-ID: <ZAi7CPXX0z80mKfQ@linux-8mug>
References: <20230220023320.3499-1-clin@suse.com>
 <20230220023320.3499-3-clin@suse.com>
 <ZAZ3CeYiZxR5zlRu@surfacebook>
 <ZAgXCi/BzyEQul9B@linux-8mug>
 <CAHp75VfxffTvAPSB4D2Oc3-vbiYM4DVpZf5=jRYGsCdFgAyxJA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfxffTvAPSB4D2Oc3-vbiYM4DVpZf5=jRYGsCdFgAyxJA@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: f750851a-034a-4b9c-ab4c-08db1ff43ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yucp8m+7LfFSpgVJnNxjfZsNWrTsz6gJwug47SZHWaYX/g0YX2K4iGcIyJ3dgpJtbTDETTo6v3gxYIcr8A2weak2AOAxXGylUIWclOrQqLo+ZqkcwbUVcEB7Tky/Ed1YBA7uKQDSW0U6Cn3qzFjdg/K44RsjF0Atszsgr51W1wIojZJz78ihSY5r0+Y9P9EHiSarpsIXK7nMUWwrfFKWiJ2RT9QbRZFihXHZlRa55L5kudu89KigGAi5zP8GNMeLdGAGdr8YNMElG5rOeW79CkItzm1HI5G6To6t/IAgZPNum/yio7rJYJKjl1QOjFbL4YJYNm3FjcVGA/kmc5VqnfcbchLrNwS6QePmLU9Je0P9rpMtOUfAz58nzTwsyVHIRZ6YubmHVSDHYWm/V/prEy8TNEIhWYqvLsxfS04HBqw0Di5WAg4tp50rYsr78u3tbpSwwI0hpyHEuVxItAHw4DIpZSlyf7uJ51QXOhm+IjxD1c80JYkPAtC8EoY3zo3L7hl5vZaaeCiDsLp2hqg2PQUuwHf9xhlPeQU1Cq27fclE3hZlBztQFkYVyc/XFTENyZORlH+P/xBA6Sr3rStBj5C/WNsJ22H8iHEm4WGcZHSR6P+bjbtDCPQKfRPvs0O0O1fefPLZPW6bkaRr0k4QTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199018)(86362001)(66556008)(38100700002)(5660300002)(8676002)(4326008)(66476007)(6916009)(7416002)(8936002)(2906002)(41300700001)(66946007)(33716001)(6512007)(9686003)(26005)(53546011)(6506007)(186003)(83380400001)(54906003)(6666004)(478600001)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XP026NB7lDNjdAvIMePAyWR/0LLogptCpgWndifLEKbRHLSZkqu9jNbukXee?=
 =?us-ascii?Q?K0RYCiC9EOOtxCr0kwvmlI6xXj2Nhezd8Sk10uc5zsNBwV1/0PDywBV2PZHM?=
 =?us-ascii?Q?5OkDEoPU2Vvx3M11cGV9FUBdhxjJQMHDkZ10irvD/vdfwmFwk+GqBZhAyo7k?=
 =?us-ascii?Q?Jhzrv6tIV5M65N4fx3rRBn681SSXuxuXPQ9JyMtusX04dije4OZdpxZlepII?=
 =?us-ascii?Q?mOdPAnZsJK8BVOzcJ5+fEQEPu4WD/imivk3bFeU7iurudoXgrKFKgL3zhzYy?=
 =?us-ascii?Q?WKYw80bW10p7dyDbE5fMOIO7AQS4WYKUbcY8uzZm4J6609ZwwA6oa1F1sJ/C?=
 =?us-ascii?Q?sYgwctZx+f/W2IwPNTubSBiw+1wr3nMBUlHx21AzWPwK8ygFTOixw29B5qG7?=
 =?us-ascii?Q?CKBAxLi/LB3DBYtFCLCBr1dp1BNE/7G73zTg2Lyq195PXwmnlzfIHLFIu0jY?=
 =?us-ascii?Q?YwZu7+5LEEirn7sxJQS2k/zC5OMjDbuVWFCxuee21qU4APZGQe222qsUMFZ0?=
 =?us-ascii?Q?ZQW9gM/4ApcKgq2CsRoLTtJPJ/Dv1jviQT6EB4Ug8Q/2iXoWsTxIKzJlgwC5?=
 =?us-ascii?Q?6yu+5kiQzm6jhv+Be5Iid6KD8GOq+Nijc5eFFriYSt713vRQ67B/oHF/FDgu?=
 =?us-ascii?Q?nB/B5RK6xSuL5ThHSbx5578sPyyvbI0WLpId5nbccvdLTZ13OACe8JIALxCi?=
 =?us-ascii?Q?j0AyVOn5g6SYOX5YeVaYADdm53d3LD4AzfHhCBvOFvvf6oknLlRYanTSjGf/?=
 =?us-ascii?Q?6o3dRRoEgbhXhyKjfJ+CkjXtCgqPC8ozOzqX4630826pUkslCBIX52zKW8Zh?=
 =?us-ascii?Q?Hnp5dgX4sE4M7C3pQWs2YKbGu/7aKJ/2sNPZPEuedCqgLabq7OiXB/+87Zk1?=
 =?us-ascii?Q?koqbwuxf76pR70YqKvLdIqxo/Bx2CCoaVK1J0Hemb5Um8y0wGag8o+SbbQ6/?=
 =?us-ascii?Q?uNeLZRXJjINDRmf/YBqmdGomPcr8inP8Wd9BFVWP1K4omF8LFECzZEqiR8Fm?=
 =?us-ascii?Q?FP4duV6YvsdBpNTHxvV6iyrHazAxbVzJ36TTpz+YHfwfkLMpS45vV9/6aQje?=
 =?us-ascii?Q?2M+7Nhy6TyXsgLxBR/yzkLIho4rjWPl1J5T68R3xpROwvcPJsQlYVn0rNw3z?=
 =?us-ascii?Q?kGa98I3S01vWUnvvyYS+swkoXDFruTsvVfecvgrFr1WD4ECvi+DiQr/msFSe?=
 =?us-ascii?Q?R2ZSewXDfbR0WoD0iaK9SsukcX+1M0UBuiJedFHY6w08WqmbPIhQvyJtOzZc?=
 =?us-ascii?Q?mmXDpswhn7iBYKwAfuTVxDiL9LTxUnOw4D2tUNFGxcccCvggZMRFkX3XrbgO?=
 =?us-ascii?Q?kmtVlMOn32jvjmBkaKQaUz1Gq07YJpjiMpvTg1uEneF5w7w5Q/jzlJ0FIfDG?=
 =?us-ascii?Q?Njjps/v7a9kDGiVtqPxLJHJU0Pu4uz2xlDcBqcIt3gQN2mY2jpJT6xWE5B70?=
 =?us-ascii?Q?9/2DUA4WuaTXNQLbxxN7eDpy8eK6AuntDjMgQ0YyzObPGN6Ams6VPth4weSJ?=
 =?us-ascii?Q?6XiXkLxB4eY+zuzVMBL8UMA1N7og1E9A61CwY9qUyAiUrqj5TFLIpxuopxsN?=
 =?us-ascii?Q?CK+UJHhlYnNsbaGUkZU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f750851a-034a-4b9c-ab4c-08db1ff43ff7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 16:43:31.4202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNPtSjKQoOvorkofM1R/tTdmEva9GpNhYABbFMXqyXa6TSQglsS+B1+V+n5hmWPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Mar 08, 2023 at 03:21:00PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 8, 2023 at 7:03 AM Chester Lin <clin@suse.com> wrote:
> > On Tue, Mar 07, 2023 at 01:28:09AM +0200, andy.shevchenko@gmail.com wrote:
> > > Mon, Feb 20, 2023 at 10:33:19AM +0800, Chester Lin kirjoitti:
> 
> ...
> 
> > but the driver patch
> > has been merged into the maintainer's for-next so I would not change this part
> > unless the driver patch needs to be reverted and re-submitted in the end.
> 
> As I said you have to keep it in mind for all your future
> contributions to the Linux kernel independently on the destiny of this
> one.
> 
> ...
> 
> > > > +   depends on ARCH_S32 && OF
> > >
> > > Is OF necessary? Can it be
> >
> > I think it's required since the driver file refers to of_* APIs.
> 
> And? Is it functional or compilation dependency? If the latter is the
> case, what API exactly isn't providing a stub?

I was wrong. Looks like the ARM64 arch Kconfig always select OF so it's not
really necessary to have OF here.

> 
> > >       depends OF || COMPILE_TEST
> > >
> > > ?
> 
> So?
> 

Since the OF dependency is not really necessary here, to fulfill the compile test
purpose, the possible dependency might be (ARCH_S32 || COMPILE_TEST), but it
could meet a compiling failure on the reference of pinconf_generic_parse_dt_config()
for those architectures which do not select OF by default since there's no stub
for this function. [pinconf_generic_parse_dt_config() is called in pinctrl-s32cc.c]

> ...
> 
> > > > +   depends on ARCH_S32 && OF
> 
> Ditto.
> 

Based on the previous assumption [OF is not needed and PINCTRL_S32CC doesn't
depend on COMPILE_TEST], selecting PINCTRL_S32G2 wouldn't work if it simply
depends on (ARCH_S32 || COMPILE_TEST), for example:

  WARNING: unmet direct dependencies detected for PINCTRL_S32CC
    Depends on [n]: PINCTRL [=y] && ARCH_S32
      Selected by [y]:
        - PINCTRL_S32G2 [=y] && PINCTRL [=y] && (ARCH_S32 || COMPILE_TEST [=y])

So the better solutions is to still have OF in PINCTRL_S32CC, such as:

config PINCTRL_S32CC
	bool
	depends on ARCH_S32 || (OF && COMPILE_TEST)
	.....

config PINCTRL_S32G2
	depends on ARCH_S32 || COMPILE_TEST
	.....

Regards,
Chester

> > > > +/**
> > > > + * struct s32_pin_group - describes an S32 pin group
> > > > + * @name: the name of this specific pin group
> > > > + * @npins: the number of pins in this group array, i.e. the number of
> > > > + *         elements in pin_ids and pin_sss so we can iterate over that array
> > > > + * @pin_ids: an array of pin IDs in this group
> > > > + * @pin_sss: an array of source signal select configs paired with pin_ids
> > > > + */
> > > > +struct s32_pin_group {
> > > > +   const char *name;
> > > > +   unsigned int npins;
> > > > +   unsigned int *pin_ids;
> > > > +   unsigned int *pin_sss;
> > >
> > > Why didn't you embed struct pingroup?
> >
> > I did think about that but there's an additional 'pin_sss' which could make code
> > a bit messy. For example:
> >
> >         s32_regmap_update(pctldev, grp->grp.pins[i],
> >                           S32_MSCR_SSS_MASK, grp->pin_sss[i]);
> 
> We specifically provide those data types to separate generic things
> with custom ones. I don't think about the code getting longer, the
> access to the proper data seems reasonable to me. Look into other
> drivers that utilise these data types.
> 

Will change it, thanks for your suggestions.

> > > > +};
> > > > +
> > > > +/**
> > > > + * struct s32_pmx_func - describes S32 pinmux functions
> > > > + * @name: the name of this specific function
> > > > + * @groups: corresponding pin groups
> > > > + * @num_groups: the number of groups
> > > > + */
> > > > +struct s32_pmx_func {
> > > > +   const char *name;
> > > > +   const char **groups;
> > > > +   unsigned int num_groups;
> > > > +};
> > >
> > > struct pinfunction.
> >
> > Thanks for your information. I was not aware of this new struct since it just got
> > merged recently.
> 
> That's why the rule is to keep an eye on the subsystem development by
> regular rebasing on top of its tip (pinctrl tree, devel branch in this
> case).
> 
> ...
> 
> > > > +#ifdef CONFIG_PM_SLEEP
> > > > +int __maybe_unused s32_pinctrl_resume(struct device *dev);
> > > > +int __maybe_unused s32_pinctrl_suspend(struct device *dev);
> > > > +#endif
> > >
> > > Please, consider using new PM macros, like pm_ptr().
> >
> > Maybe pm_sleep_ptr() is more accurate?
> 
> You are the author, choose what you think fits the best!
> 
> ...
> 
> 
> > > > +   case PIN_CONFIG_BIAS_PULL_UP:
> > > > +           if (arg)
> > > > +                   *config |= S32_MSCR_PUS;
> > > > +           else
> > > > +                   *config &= ~S32_MSCR_PUS;
> > >
> > > > +           fallthrough;
> > >
> > > It's quite easy to miss this and tell us about how is it supposed to work with PU + PD?
> > >
> > I admit that it's ambiguous and should be improved in order to have better readability.
> >
> > In a S32G2 MSCR register, there are two register bits related to pull up/down functions:
> >
> > PUE (Pull Enable, MSCR[13]): 0'b: Disabled,  1'b: Enabled
> > PUS (Pull Select, MSCR[12]): 0'b: Pull Down, 1'b: Pull Up
> >
> > The dt properties could be like these:
> >
> > 1) 'bias-pull-up' or 'bias-pull-up: true'  --> arg = 1
> >    In this case both PUE and PUS are set.
> >
> > 2) 'bias-pull-up: false'  --> arg = 0
> >    In this case both PUE and PUS are cleared since the pull-up function must be disabled.
> 
> So, split it to a separate function where you do the enabling only once.
> I can point to drivers/pinctrl/intel/pinctrl-intel.c for the idea to take from.
> 

Will do.

> > > > +   case PIN_CONFIG_BIAS_PULL_DOWN:
> > > > +           if (arg)
> > > > +                   *config |= S32_MSCR_PUE;
> > > > +           else
> > > > +                   *config &= ~S32_MSCR_PUE;
> > > > +           *mask |= S32_MSCR_PUE | S32_MSCR_PUS;
> > > > +           break;
> > > > +   case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> > > > +           *config &= ~(S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE);
> > > > +           *mask |= S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE;
> > > > +           fallthrough;
> > >
> > > Ditto.
> > >
> >
> > It's similar to the case 'PIN_CONFIG_BIAS_PULL_UP' although the PUS bit is assumed
> > as 0 via the config variable so only the PUE bit needs to be configured, for example:
> >
> > 1) 'bias-pull-down' or 'bias-pull-down: true'  --> arg = 1
> >    PUE is set and PUS is cleared.
> >
> > 2) 'bias-pull-down: false'  --> arg = 0
> >    In this case both PUE and PUS are cleared since the pull-down function must be disabled.
> >
> > > > +   case PIN_CONFIG_BIAS_DISABLE:
> > > > +           *config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
> > > > +           *mask |= S32_MSCR_PUS | S32_MSCR_PUE;
> > > > +           break;
> 
> Ditto.
> 
> ...
> 
> I assume that non-commented is equal to silent agreement and will be
> addressed accordingly. If it's not the case, reply again with your
> objections.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
