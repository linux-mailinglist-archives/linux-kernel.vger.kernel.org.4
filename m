Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856BB6AFE47
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 06:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCHFWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 00:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCHFWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 00:22:12 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC5A0F1E;
        Tue,  7 Mar 2023 21:22:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh9UtvpiPTCaI5V9hZgxzc247L8BzAX1P9vGDBEvoUK3S6szct3aWxHeHl7vXsr4tRUql468y3Tw8r2vUofqekXSXi3660ubDC0Rj+SG01TWTyaOO1V1p756LNOSQpuZuBZComToy28W9qf/qdBU4P4hUMdxLt9W2tZ6HRbJuemmNZ6KFN2+FfcNFAiFkf0OsEHi6wjQpBfybBxPYzLFpR/2ztAt1iAvQolheI6CBihAsxVPLBIwsl0VzMV/Vs4uObTE/V8d3UvfAYHsSZUbWP68HxEFe44Go8pIhOsYH210nOP5nl+sIPZsdolCQevEwPL7af39uRQPYyDjk1kFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTdxu/oQdmrHH2QQFzEZK9tLu2yxA2Cbfb9cvIUizGs=;
 b=AQT5rzRGIIyeV/gDiX/7sp7r/3qFCqMMLmgMajj4ZaK87sypvZJR/9S0JWiLDcifochM+HVB2ZeiFyMgbiNMzd+v+01P+4tX8w6+oYNCM53S8wazJ0O14J5RTNpE4hGr5rjF7lkLVP2DjGC2HVHfd6akK6o7APNQgbyNS4OeXxA0Eq404L3WvDUnVW7yk6XRRVWXFc0IXGaBk+HMQ6/j+US7/SURZnKZAz9DUVLOuT/5XAzDO7WsRZDQ0tqDxI3gaso1Ooib8rmMWavkm45mFdQEPs3eVnXo7XLucPqN2+3fHmV78Sh9FrmUl6uuI0zXFT4b+U5D6GSEiEUKV/WMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTdxu/oQdmrHH2QQFzEZK9tLu2yxA2Cbfb9cvIUizGs=;
 b=hyZZNMBH0wdcx95jd6j6F2Ro/uZrbydiDscT8MXJg4TzSzqrn7z7U838rzUn8atjvItxQ8Zq3T9OQeCAXo/pSwyKtC2wOOgG0T8GTSwgK/Hqqf96rjHmPQp5iwYoad9ACz+wcuF6XbQboxtnXvoY5FMolcTkO5zzMEVokFzl3p2rwqpxoTtqffpyj1JagFZanfCmW4NSmgFWpIB4ljMmD74Mn8rKMDF0irv9Tz5hR3Qf3mfQyviHODYFojemGceb8iZI0Y4WHxBr0YMDCTLuccfh5Ca1L+683XRTOwZd2+58OHubvanMSUPsEK5+HicsdtdL0xDk4pkBhybSwfGiZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM8PR04MB7476.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 05:22:00 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 05:22:00 +0000
Date:   Wed, 8 Mar 2023 13:21:48 +0800
From:   Chester Lin <clin@suse.com>
To:     andy.shevchenko@gmail.com
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
Message-ID: <ZAgbbL0x8hZEHir4@linux-8mug>
References: <20230220023320.3499-1-clin@suse.com>
 <20230220023320.3499-3-clin@suse.com>
 <ZAZ3CeYiZxR5zlRu@surfacebook>
 <ZAgXCi/BzyEQul9B@linux-8mug>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAgXCi/BzyEQul9B@linux-8mug>
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM8PR04MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e018b5f-b179-477c-7926-08db1f950ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Hb+3oznjP61xbD8M2O9BkO9Tbw/cVERFuSD7H5aBp3ZpSFdwa/SEOLF0KTNc6bWEKAxl23OO5Ml84JjZPwuFQlHGMUm2kDaHE6fFT9F1DXnKtA6zOg/u3c9hGgSddZNu35dnPD0Lv3qJlrRVv1DsnQRvYrGw+AJCo3GCAX0Y4/yk1JWuFr5VJ2PzKAXkJKCCjSXYDpMckHhYkqDFkdRNE2ll46eeWXYBRh/+09RflvGByeatpbf/JeskH4Vx0dCw6x1bI6JoM4oK3o9EOq/ON3u0WVIFzwrwqH1kIIcwWvw0gUqHjgLxa26R221BnDp3Ae2do1e1GPeUoITbbyMxvfuTLJJdlNt4L2VdCACtR3nfG64PiGzeKBCIBw0S9DegatpHuVPZkSNb21TGO5Zf9tNCi8akNAwRYddn5qnipY83g1KOXS+3H2AVPJ2EG0pNi2DfamokT9QdOGXXhzJgPgjzfeQGRawZ4qIHfwlZX1An1xPKq99k8JQb9L0FI4meVeVbMHyu0UK/af/Ti15Nia3A1YTCZImyf/3lnxlAxLk4k/1ZucXCcfk4Mn5373x+taWQhzqKiPQEv9MtHL116zLQ6p8/G6UOTVhlKPKQ/7Cm7tANCxbA3l6vvVlueNC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199018)(86362001)(38100700002)(2906002)(5660300002)(7416002)(30864003)(8936002)(4326008)(6916009)(66946007)(66556008)(8676002)(66476007)(41300700001)(33716001)(186003)(9686003)(83380400001)(316002)(478600001)(6506007)(6512007)(966005)(6486002)(6666004)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbhJrUQ4gh9BSupIIdTQZ34qC2HPgAUWTjao3lsNsjR2mvzhvOWvJgWg9zL3?=
 =?us-ascii?Q?Rte9Zgs8oHQfPoDTLNAznWB8rge/k4tnN0x6RZ/8tlx2FnzkS+2D2fmXEZD0?=
 =?us-ascii?Q?KLpKttL5y03VRbc8Riz2J5d4pS/H3Jl3AxBrmsAf2VbjrI0JThF8UAxX2ARu?=
 =?us-ascii?Q?py3/Tgjnap5woo7hJL2SioSsylx5QXbghjZOnMjT14aIbd7/SE1LJzyCtdmt?=
 =?us-ascii?Q?lP/WB2fBYRI3rrcln05yheoos40RZOTlt0ZfLcLlfIZ676uTMpxpa4p3XchC?=
 =?us-ascii?Q?s6bsF1ZvuqpwfNlrhvA00KPT52Q3OGXuifRh6KGPRGyeVvIZfB515PPSTGpH?=
 =?us-ascii?Q?ozeDmY5c9KewaY/yzVTsylFavZhHXHC6cnmvSUdwiMXdHICvFolrnAHlZllP?=
 =?us-ascii?Q?jz8F2D82vQYq+dr2ssrZmeUN6GSw9v44BXksF5j5ctNxgugxcECo/Wzhk+xM?=
 =?us-ascii?Q?agIOZzwOzKhoT3vcifJ890UxjQfB8g/O7gg6Xuz/W8v+yMdHN37xTdt1/fV2?=
 =?us-ascii?Q?foZA5BxQSQ9ny+xkrqAY3UoPCahwYPLORcCVNgN2/wkWuP9g2rkGApTPW0a0?=
 =?us-ascii?Q?zA1zubwYwyN6Nq2nrm7u2AL4Wuzs22tFSoBDRHFef+YdoMqlIIDUngrrcyBD?=
 =?us-ascii?Q?L+sm7FmAzhKC8OoGTYUZooL0+RvM61j9YHeuTVRVuXSwa0d9s0tYY4wX5C94?=
 =?us-ascii?Q?sMhhv559K7xYV4eLGC8otvmYn9aguWjFfS7/d+nXe1BX8nYX9a0y1cYnkW6T?=
 =?us-ascii?Q?oA015xb2Q63Iub/Gqqi5ZGTK86KOuf+qZb3+fOu+1HXj/hfVChx/6dbLUx5z?=
 =?us-ascii?Q?gXpVVY/1GKXigCaCDWhU1fRxR8mIiVPRrhyeLmX2e3Bv2vkPLgSwfgDC3giX?=
 =?us-ascii?Q?I7XNIb1SqyLrTNFTC8MYrqlIxqw4on3YxRIA8ZjPpkeWUDghjVGy1pUkWdNh?=
 =?us-ascii?Q?ScsCdLZXYSYBV4N3CinapFu03aXulpxTAffKPmTYUVj073pPc6Xb9br1pKtC?=
 =?us-ascii?Q?TuoQO/Rj8B8qEHlwvf9SKMYnhvRbdQ9FGIKUbEAKsLW7/wIkSh6jq11Sc2V7?=
 =?us-ascii?Q?QmQ6EITuDUCfhnvckjFrF0WcH47QmTZFxI6QsHfaBuI28fAAR+ziH7wKphuf?=
 =?us-ascii?Q?+ArVJ971gifW1w8ydTqUvhw/q/KI8mU9qIdBqPB2Vh9NXS2jsAuv+k8oG2l3?=
 =?us-ascii?Q?WS2VMtco53XxRLsVmItSAlCM9/Lsz6SQ/ve6oE/XpOT8wTdmENV33fsyJ165?=
 =?us-ascii?Q?LxNmhNvN/ltdTsrOZJrSvtD4hK7X7gxbSwJPjYvpOyqEaF5kNgjb9ANbg7HQ?=
 =?us-ascii?Q?VcBUGJUDeFd9NHUMJ1L5v3DI6S85fbqu8kwgqls7S7c+AVNxw0l3u7JnC97Q?=
 =?us-ascii?Q?+SuEtS5agDPXVYkYAf5B12eKEuqn7+BN0uDb461cxBjRMTXqZILdzoWOFIkb?=
 =?us-ascii?Q?oHPEiAJoCSY19z65PnI9EbY6ORZhLvygHN2GRTtYHe6PcjI8GvqN/FYUmA51?=
 =?us-ascii?Q?TdWgI6B8P1bcaXBK42CeLO6l8GPIo/S9MCaP/p18hBsxxTR3zhTuYvskMgKz?=
 =?us-ascii?Q?CYVmjnYcX6tlBtot2aA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e018b5f-b179-477c-7926-08db1f950ae9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 05:22:00.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9wy46fkWLT0PWbtay6v58SUxnP/qSmkZiRPywvyKiPAlVYYFxXTJliQnQHV/m24
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7476
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 01:03:06PM +0800, Chester Lin wrote:
> Hi Andy,
> 
> Thanks for reviewing this patch!
> 
> On Tue, Mar 07, 2023 at 01:28:09AM +0200, andy.shevchenko@gmail.com wrote:
> > Mon, Feb 20, 2023 at 10:33:19AM +0800, Chester Lin kirjoitti:
> > > Add the pinctrl driver for NXP S32 SoC family. This driver is mainly based
> > > on NXP's downstream implementation on nxp-auto-linux repo[1].
> > 
> > Seems Linus already applied this, but still some comments for the future, some
> > for the followups. However, personally I prefer this to be dropped and redone
> > because too many things here and there.
> > 
> > > [1] https://github.com/nxp-auto-linux/linux/tree/bsp35.0-5.15.73-rt/drivers/pinctrl/freescale
> > 
> > This can be transformed to Link: tag.
> > 
> > > Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
> > > Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
> > > Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> > > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> > > Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> > > Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
> > > Signed-off-by: Chester Lin <clin@suse.com>
> > 
> > Is it for real?!
> > Quite a long chain and none of Co-developed-by.
> > 
> 
> They are developers who contribute codes and have Signed-off-bys in NXP's downstream
> version. Since their implementations can still be seen in this upstream one, I
> prefer to list them all. Indeed a part of them who also actively work with me on
> upstreaming this driver can be listed as Co-developed-by, but the driver patch
> has been merged into the maintainer's for-next so I would not change this part
> unless the driver patch needs to be reverted and re-submitted in the end.
> 
> Sorry for the patch header that I mess up anyway.
> 
> > ...
> > 
> > > +	depends on ARCH_S32 && OF
> > 
> > Is OF necessary? Can it be
> 
> I think it's required since the driver file refers to of_* APIs.
> 
> > 
> > 	depends OF || COMPILE_TEST
> > 
> > ?
> > 
> > ...
> > 
> > > +	depends on ARCH_S32 && OF
> > 
> > Ditto.
> > 
> > ...
> > 
> > > +/**
> > > + * struct s32_pin_group - describes an S32 pin group
> > > + * @name: the name of this specific pin group
> > > + * @npins: the number of pins in this group array, i.e. the number of
> > > + *         elements in pin_ids and pin_sss so we can iterate over that array
> > > + * @pin_ids: an array of pin IDs in this group
> > > + * @pin_sss: an array of source signal select configs paired with pin_ids
> > > + */
> > > +struct s32_pin_group {
> > > +	const char *name;
> > > +	unsigned int npins;
> > > +	unsigned int *pin_ids;
> > > +	unsigned int *pin_sss;
> > 
> > Why didn't you embed struct pingroup?
> > 
> 
> I did think about that but there's an additional 'pin_sss' which could make code
> a bit messy. For example:
> 
> 	s32_regmap_update(pctldev, grp->grp.pins[i],
> 			  S32_MSCR_SSS_MASK, grp->pin_sss[i]);
> 
> > > +};
> > > +
> > > +/**
> > > + * struct s32_pmx_func - describes S32 pinmux functions
> > > + * @name: the name of this specific function
> > > + * @groups: corresponding pin groups
> > > + * @num_groups: the number of groups
> > > + */
> > > +struct s32_pmx_func {
> > > +	const char *name;
> > > +	const char **groups;
> > > +	unsigned int num_groups;
> > > +};
> > 
> > struct pinfunction.
> > 
> 
> Thanks for your information. I was not aware of this new struct since it just got
> merged recently.
> 
> > ...
> > 
> > > +#ifdef CONFIG_PM_SLEEP
> > > +int __maybe_unused s32_pinctrl_resume(struct device *dev);
> > > +int __maybe_unused s32_pinctrl_suspend(struct device *dev);
> > > +#endif
> > 
> > Please, consider using new PM macros, like pm_ptr().
> > 
> 
> Maybe pm_sleep_ptr() is more accurate?
> 
> > ...
> > 
> > > +static u32 get_pin_no(u32 pinmux)
> > > +{
> > > +	return (pinmux & S32_PIN_ID_MASK) >> __ffs(S32_PIN_ID_MASK);
> > 
> > Oh, don't you have MASK to be 2^x - 1? Why to drag this with __ffs()?
> > Just define a complement _SHIFT.
> > 
> 
> Will fix it.
> 
> > > +}
> > 
> > ...
> > 
> > > +	n_pins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
> > > +	if (n_pins < 0) {
> > > +		dev_warn(dev, "Unable to find 'pinmux' property in node %s.\n",
> > > +			np->name);
> > 
> > Use %pOFn instead of %s.
> > 
> 
> Will change it.
> 
> > > +	} else if (!n_pins) {
> > > +		return -EINVAL;
> > > +	}
> > 
> > ...
> > 
> > > +	for (i = 0; i < grp->npins; ++i) {
> > 
> > Why pre-increment?
> 
> Will change that to keep code style consistency.
> 
> > 
> > > +		if (s32_check_pin(pctldev, grp->pin_ids[i]) != 0) {
> > > +			dev_err(info->dev, "invalid pin: %d in group: %d\n",
> > > +				grp->pin_ids[i], group);
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > > +
> > > +	for (i = 0, ret = 0; i < grp->npins && !ret; ++i) {
> > 
> > Ditto.
> > 
> > > +		ret = s32_regmap_update(pctldev, grp->pin_ids[i],
> > > +					S32_MSCR_SSS_MASK, grp->pin_sss[i]);
> > 
> > Traditional pattern is
> > 
> > 		if (ret)
> > 			return ret;
> > 
> > This avoids first assignment of the ret.
> > 
> > > +	}
> > > +
> > > +	return ret;
> > 
> > 	return 0;
> > 
> > > +}
> > 
> > ...
> > 
> > > +	ret = s32_regmap_read(pctldev, offset, &config);
> > > +	if (ret != 0)
> > > +		return -EINVAL;
> > 
> > Why not
> > 
> > 	if (ret)
> > 		return ret;
> > 
> 
> Will fix this and the following error code shadowings, return handlings and blanks.
> 
> Thanks for your reminder.
> 
> > ...
> > 
> > > +	list_add(&(gpio_pin->list), &(ipctl->gpio_configs));
> > 
> > Too many parentheses.
> > 
> > ...
> > 
> > > +	list_for_each_safe(pos, tmp, &ipctl->gpio_configs) {
> > > +		gpio_pin = list_entry(pos, struct gpio_pin_config, list);
> > 
> > Why not list_for_each_entry_safe() ?
> 
> Will change it.
> 
> > 
> > 
> > > +		if (gpio_pin->pin_id == offset) {
> > > +			ret = s32_regmap_write(pctldev, gpio_pin->pin_id,
> > > +						 gpio_pin->config);
> > > +			if (ret != 0)
> > > +				goto unlock;
> > > +
> > > +			list_del(pos);
> > > +			kfree(gpio_pin);
> > > +			break;
> > > +		}
> > > +	}
> > 
> > ...
> > 
> > > +static int s32_get_slew_regval(int arg)
> > > +{
> > > +	int i;
> > 
> > 	unsigned int i;
> > 
> > + Blank line.
> > 
> > > +	/* Translate a real slew rate (MHz) to a register value */
> > > +	for (i = 0; i < ARRAY_SIZE(support_slew); i++) {
> > > +		if (arg == support_slew[i])
> > > +			return i;
> > > +	}
> > > +
> > > +	return -EINVAL;
> > > +}
> > 
> > ...
> > 
> > > +	case PIN_CONFIG_BIAS_PULL_UP:
> > > +		if (arg)
> > > +			*config |= S32_MSCR_PUS;
> > > +		else
> > > +			*config &= ~S32_MSCR_PUS;
> > 
> > > +		fallthrough;
> > 
> > It's quite easy to miss this and tell us about how is it supposed to work with PU + PD?
> > 
> I admit that it's ambiguous and should be improved in order to have better readability.
> 
> In a S32G2 MSCR register, there are two register bits related to pull up/down functions:
> 
> PUE (Pull Enable, MSCR[13]): 0'b: Disabled,  1'b: Enabled
> PUS (Pull Select, MSCR[12]): 0'b: Pull Down, 1'b: Pull Up
> 
> The dt properties could be like these:
> 
> 1) 'bias-pull-up' or 'bias-pull-up: true'  --> arg = 1
>    In this case both PUE and PUS are set.
> 
> 2) 'bias-pull-up: false'  --> arg = 0
>    In this case both PUE and PUS are cleared since the pull-up function must be disabled.
> 
> > > +	case PIN_CONFIG_BIAS_PULL_DOWN:
> > > +		if (arg)
> > > +			*config |= S32_MSCR_PUE;
> > > +		else
> > > +			*config &= ~S32_MSCR_PUE;
> > > +		*mask |= S32_MSCR_PUE | S32_MSCR_PUS;
> > > +		break;
> > > +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> > > +		*config &= ~(S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE);
> > > +		*mask |= S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE;
> > > +		fallthrough;
> > 
> > Ditto.
> > 

Sorry that I missed the case of PIN_CONFIG_BIAS_HIGH_IMPEDANCE:

As you can see that the pull function must be disabled as well in order to make
the pin floating.

Regards,
Chester

> 
> It's similar to the case 'PIN_CONFIG_BIAS_PULL_UP' although the PUS bit is assumed
> as 0 via the config variable so only the PUE bit needs to be configured, for example:
> 
> 1) 'bias-pull-down' or 'bias-pull-down: true'  --> arg = 1
>    PUE is set and PUS is cleared.
> 
> 2) 'bias-pull-down: false'  --> arg = 0
>    In this case both PUE and PUS are cleared since the pull-down function must be disabled.
> 
> > > +	case PIN_CONFIG_BIAS_DISABLE:
> > > +		*config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
> > > +		*mask |= S32_MSCR_PUS | S32_MSCR_PUE;
> > > +		break;
> > 
> > ...
> > 
> > > +	if (s32_check_pin(pctldev, pin_id) != 0)
> > 
> > Shadowing an error?
> > 
> > > +		return -EINVAL;
> > 
> > ...
> > 
> > > +	ret = s32_regmap_update(pctldev, pin_id, mask, config);
> > > +
> > > +	dev_dbg(ipctl->dev, "update: pin %d cfg 0x%x\n", pin_id, config);
> > > +
> > > +	return ret;
> > 
> > You are not using ret in between, hence
> > 
> > 	return _regmap_update(...);
> > 
> > ...
> > 
> > > +static void s32_pinconf_dbg_show(struct pinctrl_dev *pctldev,
> > > +				 struct seq_file *s, unsigned int pin_id)
> > > +{
> > > +	unsigned int config;
> > > +	int ret = s32_regmap_read(pctldev, pin_id, &config);
> > > +
> > > +	if (!ret)
> > > +		seq_printf(s, "0x%x", config);
> > 
> > 
> > 	int ret;
> > 
> > 	ret = s32_regmap_read(pctldev, pin_id, &config);
> > 	if (ret)
> > 		return;
> > 
> > 	seq_printf(s, "0x%x", config);
> > 
> > > +}
> > 
> > ...
> > 
> > > +	npins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
> > 
> > > +
> > 
> > Unneccessary blank line.
> > 
> > > +	if (npins < 0) {
> > > +		dev_err(dev, "Failed to read 'pinmux' property in node %s.\n",
> > > +			np->name);
> > > +		return;
> > > +	}
> > > +	if (!npins) {
> > > +		dev_err(dev, "The group %s has no pins.\n", np->name);
> > > +		return;
> > > +	}
> > 
> > ...
> > 
> > > +	grp->pin_ids = devm_kcalloc(info->dev, grp->npins,
> > > +				    sizeof(unsigned int), GFP_KERNEL);
> > > +	grp->pin_sss = devm_kcalloc(info->dev, grp->npins,
> > > +				    sizeof(unsigned int), GFP_KERNEL);
> > 
> > > +
> > 
> > Ditto.
> > 
> > > +	if (!grp->pin_ids || !grp->pin_sss) {
> > 
> > > +		dev_err(dev, "Failed to allocate memory for the group %s.\n",
> > > +			np->name);
> > 
> > We do not print ENOMEM error messages.
> > 
> 
> Will drop it.
> 
> > > +		return;
> > > +	}
> > 
> > ...
> > 
> > > +	func->groups = devm_kzalloc(info->dev,
> > > +			func->num_groups * sizeof(char *), GFP_KERNEL);
> > 
> > First of all, this is devm_kcalloc().
> > Second, where is the error check?
> > 
> 
> Will fix it.
> 
> > > +	for_each_child_of_node(np, child) {
> > > +		func->groups[i] = child->name;
> > > +		grp = &info->groups[info->grp_index++];
> > > +		s32_pinctrl_parse_groups(child, grp, info);
> > > +		i++;
> > > +	}
> > 
> > ...
> > 
> > > +	ipctl->regions = devm_kzalloc(&pdev->dev,
> > > +				      mem_regions * sizeof(*(ipctl->regions)),
> > > +				      GFP_KERNEL);
> > 
> > devm_kcalloc()
> > 
> > > +	if (!ipctl->regions)
> > > +		return -ENOMEM;
> > 
> > ...
> > 
> > > +	info->functions = devm_kzalloc(&pdev->dev,
> > > +				       nfuncs * sizeof(struct s32_pmx_func),
> > > +				       GFP_KERNEL);
> > 
> > Ditto.
> > 
> > > +	if (!info->functions)
> > > +		return -ENOMEM;
> > 
> > ...
> > 
> > > +	info->groups = devm_kzalloc(&pdev->dev,
> > > +				    info->ngroups * sizeof(struct s32_pin_group),
> > > +				    GFP_KERNEL);
> > 
> > Ditto.
> > 
> > > +	if (!info->groups)
> > > +		return -ENOMEM;
> > 
> > ...
> > 
> > > +	ipctl->pctl = devm_pinctrl_register(&pdev->dev, s32_pinctrl_desc,
> > > +					    ipctl);
> > 
> > > +
> > 
> > Unneeded blank line.
> > 
> > > +	if (IS_ERR(ipctl->pctl)) {
> > 
> > > +		dev_err(&pdev->dev, "could not register s32 pinctrl driver\n");
> > > +		return PTR_ERR(ipctl->pctl);
> > 
> > 	return dev_err_probe(...);
> > 
> 
> Will change it, thanks!
> 
> > > +	}
> > 
> > ...
> > 
> > > diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
> > 
> > Similar issues has to be addressed, if any.
> > 
> > ...
> > 
> > > +	return s32_pinctrl_probe
> > > +			(pdev, (struct s32_pinctrl_soc_info *) of_id->data);
> > 
> > Broken indentation.
> > 
> > ...
> > 
> 
> The checkpatch.pl seems not to warn this but I will definitely improve it.
> 
> > > +static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
> > > +	SET_LATE_SYSTEM_SLEEP_PM_OPS(s32_pinctrl_suspend,
> > > +				     s32_pinctrl_resume)
> > > +};
> > 
> > Consider using DEFINE_* PM macros.
> > 
> 
> You probably mean DEFINE_SIMPLE_DEV_PM_OPS. Will change it.
> 
> > ...
> > 
> > > +static struct platform_driver s32g_pinctrl_driver = {
> > > +	.driver = {
> > > +		.name = "s32g-siul2-pinctrl",
> > 
> > > +		.owner = THIS_MODULE,
> > 
> > Duplicate assignment.
> 
> Will drop it.
> 
> > 
> > > +		.of_match_table = s32_pinctrl_of_match,
> > > +		.pm = &s32g_pinctrl_pm_ops,
> > > +		.suppress_bind_attrs = true,
> > > +	},
> > > +	.probe = s32g_pinctrl_probe,
> > > +};
> > 
> > > +
> > 
> > Unnecessary blank line.
> > 
> > > +builtin_platform_driver(s32g_pinctrl_driver);
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
