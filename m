Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13396780AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjAWP7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjAWP7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:59:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66C7D506
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:59:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/wzIBMhB4XFrCj26RCxDHROtKNOhBxM/ly2PoRjvXNRCXEEL/lO3d7QmTkinr5as7TW+4xWgzhHM1GFSf24kZCvOLSY95iDyoU29sA+jdKx3RZaBCr90lGEklPJxhKM6p/YZMqlrLWX8P1wY1m6o1cf9nls0e6yrqgPaqDhb62R06+LCIaeH/T1qB4f0SmXMhJKSwrK0GtT58v/21+2Mp5wt2++vkvnCZdFWHhbqrZlKKjtC9E4/HPYxN91oO24EVVqWxG46GKfwINkThLk7xoL1e0QlrydAo0Jtz29eOZ19nqldmP7tGe5PIFlVnWphl3QR2qaeLh2wfqZpmG7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut0D6tDhZOiJ7DrqUh3+pg5FX0B0zjlzVs9lW+8BAP0=;
 b=oXXfG4ZCsefGPzVAy5krs8+oTJhjYwBk4L7/dEu+PVKPTHBczeE14zWM01e9WOxlO1xwPUHV9kquNjT4gl3x4C+ppIsMpFJblhNdG79GMaj+OOQ56g6e751j5gMI+Pi5CJT1ire6Cwei9i1DPF5EHTNPjnh/oW5bhb6fQkzNdoM6N00J3Wh1PmfYTjpVneMBV6AqbbFWJZ4DkUSqxukrIIQUOxGnHrRCzCgbN/S2Wg42Is7RNPQ45ltopzsC9vGvBKpa86hILjeuMcvmZ/hfLWgvUGl0DF6QFsoNnjV2Fa/sNB7v52RehKRSWcgAPUpv/fUBw+SVOjXjtxqbp2zUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut0D6tDhZOiJ7DrqUh3+pg5FX0B0zjlzVs9lW+8BAP0=;
 b=ktRIG2uO7Ftmacdv8zWeSAhpR+n4pp6lppLnh5eD7nuXeW+xbzveiT/aHPGBVjT8Ykq9ytrQHq5ROhvyEzJwvRkgDaD4ng6WoLTEctNzsgbLaxldVOeTlfgAtZprXV9FWJeWsAeNNCr1LFH0an8FUaLDe9qsYptnZnExdhZ/4DbCPBCL7jSMSAZ4w8R5vITNF39A599kMcVOPRK7hAXPxySKjVsc/diPd6f6TZwpAhSUZz1NeBJAg0GLhHJV8f9ok+HntERs/4U2UxXEhcnKzP2fm4JL2K9In3h9uubE3JhNlQl6/rxi2WkAqv/BM1H7rsIZdGigTXbWREH1C7puMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 15:59:05 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0%5]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 15:59:05 +0000
Date:   Mon, 23 Jan 2023 16:58:59 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mohan Kumar D <mkumard@nvidia.com>, will@kernel.org,
        dmitry.baryshkov@linaro.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com
Subject: Re: [PATCH v2] arm64: defconfig: Enable HDA INTEL config for ARM64
Message-ID: <Y86uw7QF/hMrIvbs@orome>
References: <20230117181658.17010-1-mkumard@nvidia.com>
 <e871dae2-58ac-7ad9-c198-c4e90d26c69b@linaro.org>
 <1afa38ad-716f-49f8-efd1-ed37bd8dbf6e@nvidia.com>
 <ec440deb-2970-69b8-e54d-6519c95875a8@linaro.org>
 <35eb1396-b91b-8a7f-6585-30d2f2adcf85@nvidia.com>
 <cfb9b0f2-a8fa-9bee-a04d-d195d69e4918@linaro.org>
 <Y8rHzJpEg7bMzYM6@arm.com>
 <fbeff3da-e03b-aa82-1a53-d92f95b63770@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+gDMnmwmYWgYXcHr"
Content-Disposition: inline
In-Reply-To: <fbeff3da-e03b-aa82-1a53-d92f95b63770@linaro.org>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.9 (2022-11-12)
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: a15451ae-fd3b-44a9-4cf3-08dafd5ac0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aK6Q0iiyu2GriRBeUAh84V/c1zcbARB2ayre1u3YefAnQ6i48kmQ1nrPoovun75fENCiilNKt/s4C7Ks+U/Qd4BFXzJu1UvcvjrfyuTOY7TbE/phmP6WYJaEsDjP5gH8f7ALwBr2ueSZqhpY0zfxs82+yq+0HvUqaXv2Q8mFLOuWtiidKQ3SOWpUY9XfKcJKpDg3xRDc/b49fN/n2EcCHV4MqTSEHdgrUf3861LAUkdggHt+3hzWFxK/grrq1ibWJBvNzqf3yduCE/zaMqzQ8nE3tMJ68HGJSCUWwLtzvKYwlRehZXCUZExA0genBGjecAhgEWbNpeqqdCocjail0GlCnZVZ+A8wr/G9erI8dcxYiNn2ucGHVIEJi/V7NlP8St6bUV3ePLwA9neVbO7kBjJ+ujyOx0R7xCfSURSkJ2Oi90EOTsSEmXztaoU3+F5nWCAaxcMz1x7C+m7oSSDUC11zUYB3h61V2CUnQrI1KOz38tsoBStEnRCmm+4rpYYennfPlVTXbOJR4imI6RXJ15sC36ras1GfKgF+z9gGVaSjDO3oZB//64LkeliB3C+pivFXWfU3iiXxV+dEnPUCPyslhBcQOa4BAg72CUL8c8c6kP8qPB9m2lurMnaMhPMqO7VJGHmYwfwlkDmmtSE4GjlCvPI2t2SPYbfwpeR27thpL77cg1FjFpovH0uCeKTEuyPdZMcE0lnrjzKU5UkqDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(41300700001)(86362001)(5660300002)(8936002)(4326008)(2906002)(83380400001)(38100700002)(478600001)(6486002)(6916009)(8676002)(53546011)(44144004)(186003)(6512007)(6506007)(9686003)(33716001)(316002)(66946007)(54906003)(107886003)(6666004)(21480400003)(66476007)(66556008)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3umoYx4aadjYRBEZN8f9FNHKDLc5nJPELCcGF+9FJ4P0S0a8dz2PX3qyFYBh?=
 =?us-ascii?Q?0Z+GUVyCedJeLP3juNHBemdpoA3A4OMj03SxPzBL45bYAHi1O0TwBfqz39Bm?=
 =?us-ascii?Q?HOeQrmo0v/tl74Jzlxdkup46CtrAzMW9FHvamvEW+th+hxgU7YW9KRCwi4pm?=
 =?us-ascii?Q?SmyOlQH/w6OsdmrLyuacLaqMRWwh3l6eLIjOYAPID8LCmCwd8VZKqkbQgUJs?=
 =?us-ascii?Q?cE1xu3A4qh/ynneZxgpJKi6S6tIdOw64UnqZrTrju4ui30q+vhCGRh+5FZla?=
 =?us-ascii?Q?YGXv+xvB59UXHfzvowOeUmUGkgwAo4O2KF2D9rCt1ioNcsFGuCAa8jHAd/Kt?=
 =?us-ascii?Q?z5D69vc9BG0TpyqrMbVd28awYsTVyO/wBiWam7fqst4ZPhWWRcA8ILcicu7k?=
 =?us-ascii?Q?3qtKtHj4ept6w5kIHLnYCx0JfiqF8EcSxLWRmVlN7DJPa9FvVtW8/uVOpPDu?=
 =?us-ascii?Q?P9SMD9ZF+H6rqecMIRfqCWPWeqIE63m1XBFlkOv8J75jzwgSTAf1Hvkq+hGX?=
 =?us-ascii?Q?y6eV5/Sz6jH6hlPjRII3HztIyDeq3csvb/9iZ7QVyN6o1K9N62IrkbG/Ei5A?=
 =?us-ascii?Q?5wOjXl1DPaZq7xPs8rl5w0Sb1pRLSKWnSjpKn84tVecBJ2xlPM02mknGvVe+?=
 =?us-ascii?Q?9YoxjiI189ALd6PA4QY8en6/Y09GppHSzk5LPogr8eOLVO+JUkkyJsRxUy9+?=
 =?us-ascii?Q?qZM68qosn28WiU6wc35qIbavLjxE6hl/E3jVsUxU+cHGh6yy0CAUmBUd8iy7?=
 =?us-ascii?Q?fXNMbHoQ0IjVuqlicqJczyucbUrXu0r5DFjtPfUwLp5qkQr4eOEJp3smFgtM?=
 =?us-ascii?Q?YOTZz3QXDC+WP1gXG32q1zYwCyIL+q8ZFPzojmih/rMReoDyIyRt047SbmKy?=
 =?us-ascii?Q?M+5lk/wLLd1Yer1gSpoz2tkrubdmGEdaCyQ9POCrijiZIttsk4RV666sDDyi?=
 =?us-ascii?Q?Fk4xw2geK0PsOX3JrhFMUqWYFhPYbTaa+ARkK+yRf93KBFgPEqVOEBIK8ntv?=
 =?us-ascii?Q?jSiX0s9RBeRUpYgbS/JhlxTbXkS15TGXj21NfvQ9HOZs6eFV6lCVGTPulpWA?=
 =?us-ascii?Q?Wk3Co9FItZyDyEPggwQalv4tytgtus5IJmXJmHqNiuEQ4FUR2KSkRkfs5YGj?=
 =?us-ascii?Q?j0WVARzcoY3SG5przEoia3JkYZ6xwVuTwU2UNRdq6WauWewFY18Kt+hiFfDA?=
 =?us-ascii?Q?Ne6N/RgWTSNRZqYvYoyXUaTsG5XIeYa4lT7Uh85nZG3usTK/PsR3iwBO3XFy?=
 =?us-ascii?Q?DMegzKTMUsHOgEOyu0aEnf2dTicxZGUAy/eDj4Zd1yiOVt4u0xhFzDSst5tU?=
 =?us-ascii?Q?jzccycp44A8mtYhRz+QlKSRqC6Uvi8iriteaSZnfJk9UW9R+iaGOSwY6iSDQ?=
 =?us-ascii?Q?B0ErpP5/WqPqOGlwmhBTLuutFpDnVm2/CKzI6Urkt++m+StjuG1vsYpgVhnb?=
 =?us-ascii?Q?8w6XWVbYtS0ratSlBrIGVzcAjgwDhb5Wl543zRWc0+br2+YFu9IB80lyALkn?=
 =?us-ascii?Q?SZ+Rz7C/GeBy3R2/WPjHdq7RCFJnTpxMJUlMnRPwsOXKIRfXbbbr95nAmaQX?=
 =?us-ascii?Q?qoAJLM11ooD2LlJpw19XV6uRRVNI/SwLEjbpCN31kK9CjSbbsTithPkA88Bq?=
 =?us-ascii?Q?iCMs9y2eATt5VgO1r84SY7UEO+1nKz2TTHI4ikc4VvNI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15451ae-fd3b-44a9-4cf3-08dafd5ac0cf
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 15:59:05.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nEsFtCec8/kKKuGwaFm3yfKEzH9ZtQAbgax0eGv7EowmbdvdFOYW/goGnEIV11ESkoDfOKWeb3NZoVpe3UqPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+gDMnmwmYWgYXcHr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2023 at 06:00:25PM +0100, Krzysztof Kozlowski wrote:
> On 20/01/2023 17:56, Catalin Marinas wrote:
> > On Fri, Jan 20, 2023 at 07:20:01AM +0100, Krzysztof Kozlowski wrote:
> >> On 20/01/2023 06:48, Mohan Kumar D wrote:
> >>> On 18-01-2023 18:06, Krzysztof Kozlowski wrote:
> >>>> External email: Use caution opening links or attachments
> >>>> On 18/01/2023 12:46, Mohan Kumar D wrote:
> >>>>> On 18-01-2023 13:04, Krzysztof Kozlowski wrote:
> >>>>>> External email: Use caution opening links or attachments
> >>>>>> On 17/01/2023 19:16, Mohan Kumar wrote:
> >>>>>>> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound c=
ard for
> >>>>>>> ARM64 based platforms as Intel PCI driver was used for registerin=
g the
> >>>>>>> sound card.
> >>>>>> It's not a part of SoC, not a common device used during debugging =
or
> >>>>>> development, so I don't think it is reasonable to enable it. We do=
 not
> >>>>>> enable driver just because someone uses them. Otherwise please cla=
rify
> >>>>>> which board has this device embedded (not pluggable by user, but e=
mbedded).
> >>>>> This change is required for enabling HDA sound registration for Nvi=
dia
> >>>>> discrete GPU cards based on PCI and pluggable to Nvidia Jetson Plat=
forms.
> >>>> You can plug anything to PCI slot and we do not enable every such PCI
> >>>> adapter.
> >>> Without this config enabled, the Intel hda audio driver won't be buil=
t=20
> >>> and dGPU won't be able to register sound card. Do you have any=20
> >>> suggestion here?
> >>
> >> Without hundreds of other drivers they also won't be built and won't be
> >> usable. Anyway, this is just defconfig, so it does not matter. You can
> >> always enable it in your setup, why is this a problem?
> >>
> >> Again, we do not enable drivers for every PCI card.
> >=20
> > I don't think we have any set rules for what goes in a defconfig. If one
> > has a real use-case, we tend to enable stuff in defconfig, especially if
> > it's a module.
>=20
> There will be always an use case for every PCI and USB card. It's not
> related to storage or networking which could justify device bringup
> (rootfs). It's really not needed for any board operation. defconfig is
> not for marketing products but for our development and reference platform=
s.

If defconfig were only for boot-critical drivers, it's terribly bloated
as it is. We enable things like multimedia, infrared and audio. None of
those are critical to booting a system. Heck, we also enable most of
DRM/KMS, which are useful for boot on consumer devices, but are rarely
critical on development and reference platforms.

Besides, a PCI board can be considered a development platform depending
on who you are.

I've always looked at defconfig as more of a guideline as to what's a
useful baseline configuration for an architecture.

> The only argument behind this change is "I have a PCI card and I want it
> in defconfig", but why it has to be in defconfig in the first place?
> There is no reason. This is not distro...

That's highly subjective and honestly that argument can go in both
directions. People can, after all, start from an allnoconfig and then
work their way up to something that's usable on their particular device.
Or they could start from an allmodconfig and work their way down.

The point of defconfig is to give you something that's somewhere between
the two extremes. Obviously if we start enabling everything, it defeats
that purpose. If we prohibit the enablement of new options, we equally
limit its usefulness.

Thierry

--+gDMnmwmYWgYXcHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPOrsAACgkQ3SOs138+
s6GsYQ//bpwZNKqzGrmfew/fW1GUKUCODrGlKp5OYTlZF8inkcbFD/jVsmWzBBQN
nVHlfkMgpOFKO+Jcp7ck27H1pEumoN468rOwTASLoe8VMgrbXLPuzBb8rEmKHQ86
u/gnwEqwwBBFr4klnFxkQYH2IH1ndhjb5OLDWqHBWebQLlv2fVIBwmI4iiiB+CBf
N7lOhz4urjCrnN599PiEckucOm1fnEmrGyMh+XZaHBGJa90iE/cftVIM5VDYIme4
1Ho1M2eo8YnDRidkUcxG5QYWwBlhHkcvLCNMTUOoW0i2aTpE9aia+QOqNb+QKd/7
ptWSkjMMzW74drb46Miser5lCzbeaCO563n4iRZmW5nRyxnWVqbSm/un7vzWkxbh
0PR0NGS+hRS/uO7Pdehbx98R7LRE3FIgcbnJYu6wmIZ3TPSOw0vFlsA0Ca63r8Kg
ZWk3ZQbe3nN5LIJ2mVqovW0CjjmQ8Ii+slZ+djpZjvM8nhF8zOvSkX2eJNUTPzXu
dvMb6YO69xNI/yVEbyataci2Lm4XuO5eRUvfG5Wypx4yxmxKZgaE8lWyBGnezYHh
LYCKUOH20wim60wijJIHCn31UJfFMU67mKZjpPkXhwz0lF4ER4gJg4U2ateAlBpf
0eFDJc8vEv4l+YNHp/jyMfXdCnsO218x8WuSMJf0Yb38VWAztbU=
=XAQN
-----END PGP SIGNATURE-----

--+gDMnmwmYWgYXcHr--
