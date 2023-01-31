Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81AD682315
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjAaD62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjAaD6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:58:25 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D81ABEF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 19:58:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJw3WFThIfQ6XE//zXzUetBHU4ymJvaw92z91cRLuR9H9Gv/vLOKEbBVYFES08lp4rz5BH33VHXnI5+wyZMi/TV0wJE8VZLHFOXobIQP1gMwF+HNwI3rSz/p1exeJA5bSVbsRQfhmaWgZqrYi6e6PJbRKDr1cVUhFBd7vfT514QwGcQhjqzxU8obr//oFsv7PCSZVDrOi9RzEEkKQbGpKMuhoWyL+2Pj0j9CbIupSY8MvUZUN5BGgonactGN1BaJnVQQto1BCKA3MIz7hV3YG1i9DkHakxQ2gHrsHBHuPdhSaRLhHnCZvIjvnfXM1LB+RX9YSY1Onz1Easojm7gCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPJYAkYtmtHb8RSllivrVAxpQmHKwZaRqtyVfMHCZAM=;
 b=TDdS8kzLc4Y50dTDy2QnIqadkus/iSXYLtBhbQsF3v9RImpXIr/hUk2KuP8wAOydc/uBZhagWb08zd7Q8DLxYkXkJ5CUZ0jOyq0xIsaxar7tK6H2r2sFLfO/yTuElGyZrSg3ut4W2tJy3Uo8LR5qt+FQY2Kcun0cdOIp1hjTUmu5CMSuf+yrQ+xvDhktbWaeESHQR7ju/NNGO2j+U+bol0xTpniy70n+iS2FYin67H1RJL8EZQJhUG4f7KCVgAzDMr0CxOoqTR0o6czt1xn26VNtusqw/JHD7woeIO00pHe2Ao0Igy8F7zFSH+shF9atC3ONguF/MluPd6txTc84Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPJYAkYtmtHb8RSllivrVAxpQmHKwZaRqtyVfMHCZAM=;
 b=eRw7CvhmZK5XHSqahQgsD1SSGZqbivHrIKlTqQuCMRX4APygAjmHUFaGMad1pOmPrN9W4rfLppvEGLHBJTLBtIwEWesBWcIZDXrJe0bt+HF8LEYmOpy/8RZunoBLWpY3nuuB4ElnYC6U4AX9EhFO9f55WIZuj1ImwDjnXYGCslw=
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 03:58:19 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9438:5139:7952:d8b0]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9438:5139:7952:d8b0%7]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 03:58:19 +0000
From:   David Rau <david.rau.zg@renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Thread-Topic: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Thread-Index: AQHY/Wc8EHyTvYawJkGeL+1XJ6BDpa6jYNiAgAIOc/CAANeEgIASDP8A
Date:   Tue, 31 Jan 2023 03:58:19 +0000
Message-ID: <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
 <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
In-Reply-To: <20230119161221.GA981953@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6641:EE_|TYCPR01MB8455:EE_
x-ms-office365-filtering-correlation-id: 9d389b75-9fac-4501-53fa-08db033f638c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LY1FOj4bMsG8pmPf0VqRr8EGXtW6/Lgl24XQwyQXO61/z3Wvu2+Q5rlqCN+LwNikEERvRkcj6GdVaORXsEBUJ2NsY6Sy3t+A9JYwfnvax8g9uBCY5RkoVr5QmfgpdrWoONf68YCxpoZftGWcqT6SAmLk1IaEou8v4ir9Hzz2tg1E1BHsAC1qh4lAhTapnjOcpSG+ulRkABy7nES6uOuKLNTNkApR5/IgBYTVoogNW2Q+xoTRxqDvhF+qfZZfxKUTu4TYuyOPKlSl6ofBRTofQvWDY2B2KUI+BJthlnYh7ENeJeN6IKVWs0FunvvLZ13HaVFJKO+oK0UrFalKUXmY2pf/uQDaXiTEzfS8q0L+SBlWTKF50mNEODSTWOgXI2xME4ZrD3Q6IemqaXoIqCTGS6J8BRkvf1B+WvAhvjGOEvRnKrA5uP5HnH5Iqk2Pjg6sTwk4OY3y2S/4n1EHn2HmlCeOFgIsibyKQWZk/B9kiTQdG50FEhnn2BYbPMvxPT5Ac/WL8SeMRbULP4hur+sJqFg+tXpzHXXKHznT0UmXv8ESkf+gqBGt+5tEoRdPhCJ5D5I/OR9Te8J+SlNpHVmIq2x4wnu0+CogeWUfrMOo48g9DzAb+JZClWFFjkQ7epQBEeGarNtEgl09l8AasmBAlZFkzvroTmEY7Whw/TFN8ipmqOA6THyFXRM2iXmvVeaF++CKg+A1xleGUFhe96fRAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199018)(71200400001)(7696005)(2906002)(83380400001)(6916009)(4326008)(66946007)(8676002)(64756008)(66476007)(66556008)(66446008)(76116006)(478600001)(41300700001)(8936002)(38070700005)(316002)(6506007)(33656002)(55016003)(9686003)(53546011)(55236004)(5660300002)(54906003)(122000001)(38100700002)(52536014)(26005)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ScC2KQ0eTjGQUrQuC2PG05Eg0MjOh2g1DZq5AUCg6RJhwdWhq0/FvF5Fr6Hf?=
 =?us-ascii?Q?SRClofxrWDKqEfOzx+CyKRfVxREPrsJioyMj9REWN3khe+1T8zAD5DR9jT3K?=
 =?us-ascii?Q?WeINokXH6W+8J60QGX0WwSi9Crh55z3QjLUiVyuCSz/IDziZljPlYoGDQiZF?=
 =?us-ascii?Q?OYpoYFtyqTDLf/RLmMuqIr5hdsNQvhQPdZZ+IdyGNFyee9en+vlZ8nGrLKOP?=
 =?us-ascii?Q?4pefsx6hIVskFqlIZO2v9QMg9U3+LFgnTM6NcXWXTZmYpl32mxVq9QnVMlHl?=
 =?us-ascii?Q?sEkZuDEx/6DSU1s+vg7gFLfsn9GOXKaGmkWc5Dh9GbS2OgYPuQc5iNOFwUMb?=
 =?us-ascii?Q?bO4/c/J5B6ShDLbyxk5LEYmATI9RmK6SEUnTlrViPKP7QIdIpBWxoNyOhI0e?=
 =?us-ascii?Q?ovY6Fn/+Z7utUEqn9nyGWHR3pTo4/pbAe7mG5o85IjD2Z7qlAFHOhmNKHx/3?=
 =?us-ascii?Q?Rl/imj8+SMuGrPGSBUSyR8mp9Mb5fNbI/DwLdRk1jB5W5RLvf/5KQUIxI38b?=
 =?us-ascii?Q?oexnGYFqqTMycMajvShwiPE6foLDxuI/Zrrpyl2cwFJIFJUNsA1JY927A9B1?=
 =?us-ascii?Q?h+4hWImLMcLpdPeGA7LSINppSZlA5bC9NQDcuQaHaW/RhDTjNnYzTRBz7iiT?=
 =?us-ascii?Q?jBX7hJyJbT9znbpn1GdEb/6f5Qqz+xePXEqUBakiOJom2XRINNr8tAHicY16?=
 =?us-ascii?Q?V/eOXxIFjiqkkF9yC7VmOn7edwwKFe4vNLDQAjpbq95vb6Boaef2kvRJgMHJ?=
 =?us-ascii?Q?br8iEQhtaErv63NbANZ8WkoclyzUjx7ZXbawXBkpD58hxfXdnI+JJJNuNrr/?=
 =?us-ascii?Q?t7xIYWupak6TbBIE8HCLShbPtxtC669ehnfAnOidn1NdkmqIDjXtZEoQ0+hA?=
 =?us-ascii?Q?yB6E9Uq7WjDDon6lSMpzmrA9j/Q2j7fx6H5GHNmgBVWMhyGSrGAvt+yoRgfS?=
 =?us-ascii?Q?evfsQjSABFPViE4u9rXzcbhE5qwTEwQvBYGNmNquYyk2JW5jyKqm9je3rA7y?=
 =?us-ascii?Q?C6gxR9QoKLnrwHuYjrvwd9fDk7vzgUxck2S8KQRE0oTS1u87R0utOmvPSlqi?=
 =?us-ascii?Q?ui0XZ/po2kB6C+ieO6QS6s6iQ4P3FPmUdyOO1xkrbyi+0NEpsPTKCddbjTwv?=
 =?us-ascii?Q?1dwf0keR4EDfio8+k7sOTEl/SDf+l7d5QJvTur31BzDXWU1CJiQBkcWUgBA5?=
 =?us-ascii?Q?F6foVWnr7+lpomeoBVNaPUh5ZmQ15i0J0+ONG30mVZuqpmjBbZ8k52LyIHFm?=
 =?us-ascii?Q?iuRiTNC85SXi+lkXlvWSoe2MQxgR/9yvjPC52L3nYwc/Wi9z1q+yIV9o5pRS?=
 =?us-ascii?Q?lHHyrM6oAPP/4eO/RbO9CiP10AZZ1QUeVLa7/xeQOfIk3VQHkdk/6I5BWLqP?=
 =?us-ascii?Q?4CLno5mOVZDxl1Tkg4A+OBahrqcIutw98rAKz/R+tEPDWb0GFrCRO225QkrL?=
 =?us-ascii?Q?VMMOQfc/UrJbRmkwM43lzRzWsd+57/sUbcGuFGD0pMzi9/4oQ0c8TQZxRbdB?=
 =?us-ascii?Q?xc7bLbR1z7yhFUxAiGN1MPnHHljNfhGkVCCD8tpdRaa3vVDiKznjVMV2uICw?=
 =?us-ascii?Q?RihoxubbKn15DZV1UlKJW2yO1dFXKweE1fil5+qD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d389b75-9fac-4501-53fa-08db033f638c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 03:58:19.0396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heFz/kPTs+jED4KIp1/dOczXfdfNOJDRh9gimVutn/yCeStqOzCZX7qbKxso8kXAiRL9KfX0lbUR6c2W30GAi+LWZoXJQm5aOPRdlDSI+ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8455
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the kind feedback.
Would you please let me know what kinds of environment such error appears y=
ou ever meet?
Ex: da7219_aad->gnd_switch_delay =3D ?


-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Friday, January 20, 2023 00:12
To: David Rau <david.rau.zg@renesas.com>
Cc: David Rau <we730128@gmail.com>; perex@perex.cz; lgirdwood@gmail.com; br=
oonie@kernel.org; tiwai@suse.com; support.opensource@diasemi.com; alsa-deve=
l@alsa-project.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP h=
eadsets when playing music

On Thu, Jan 19, 2023 at 11:02:25AM +0000, David Rau wrote:
> Would you please provide me the related error messages when hung task cra=
shes in da7219_aad_irq_thread()?
> BTW, "gnd_switch_delay =3D 256" is an unusual use case of the longer jack=
 detection latency.=20
>=20

Here is a typical traceback.

<3>[ 246.919057] INFO: task irq/105-da7219-:2854 blocked for more than 122 =
seconds.
<3>[ 246.919065] Not tainted 5.10.159-20927-g317f62e2494d #1 <3>[ 246.91906=
8] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
<6>[ $PHONE_NUMBER] task:irq/105-da7219- state:D stack: 0 pid: 2854 ppid: 2=
 flags:0x00004080 <6>[ 246.919075] Call Trace:
<6>[ 246.919084] __schedule+0x3b0/0xdaf
<6>[ 246.919090] schedule+0x44/0xa8
<6>[ 246.919093] schedule_timeout+0xb6/0x290 <6>[ 246.919098] ? run_local_t=
imers+0x4e/0x4e <6>[ 246.919102] msleep+0x2c/0x38 <6>[ 246.919108] da7219_a=
ad_irq_thread+0x66/0x2b0 [snd_soc_da7219 cd5a76eef6e777074216b9d61f7918f756=
1bf7ec]
<6>[ 246.919113] ? irq_forced_thread_fn+0x5f/0x5f <6>[ 246.919116] irq_thre=
ad_fn+0x22/0x4d <6>[ 246.919120] irq_thread+0x120/0x19d <6>[ 246.919123] ? =
irq_thread_fn+0x4d/0x4d <6>[ 246.919128] kthread+0x142/0x153 <6>[ 246.91913=
2] ? irq_forced_secondary_handler+0x21/0x21
<6>[ 246.919135] ? kthread_blkcg+0x31/0x31 <6>[ 246.919139] ret_from_fork+0=
x1f/0x30

The underlying question is if it really appropriate to have an
msleep() of any kind in an interrupt handler. If this is about debouncing a=
 signal, it should be handled with a delayed timer.

Guenter

> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Wednesday, January 18, 2023 03:57
> To: David Rau <we730128@gmail.com>
> Cc: perex@perex.cz; lgirdwood@gmail.com; broonie@kernel.org;=20
> tiwai@suse.com; support.opensource@diasemi.com;=20
> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; David Rau=20
> <david.rau.zg@renesas.com>
> Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on=20
> OMTP headsets when playing music
>=20
> On Mon, Nov 21, 2022 at 05:07:44AM +0000, David Rau wrote:
> > The OMTP pin define headsets can be mis-detected as line out instead=20
> > of OMTP, causing obvious issues with audio quality.
> > This patch is to put increased resistances within the device at a=20
> > suitable point.
> >=20
> > To solve this issue better, the new mechanism setup ground switches=20
> > with conditional delay control and these allow for more stabile=20
> > detection process to operate as intended. This conditional delay=20
> > control will not impact the hardware process but use extra system=20
> > resource.
> >=20
> > This commit improves control of ground switches in the AAD logic.
> >=20
> > Signed-off-by: David Rau <david.rau.zg@renesas.com>
> > ---
> >  sound/soc/codecs/da7219-aad.c | 42
> > ++++++++++++++++++++++++++++++-----
> >  sound/soc/codecs/da7219-aad.h |  1 +
> >  2 files changed, 37 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/sound/soc/codecs/da7219-aad.c=20
> > b/sound/soc/codecs/da7219-aad.c index bba73c44c219..08200ec259f9
> > 100644
> > --- a/sound/soc/codecs/da7219-aad.c
> > +++ b/sound/soc/codecs/da7219-aad.c
> > @@ -352,9 +352,14 @@ static irqreturn_t da7219_aad_irq_thread(int irq, =
void *data)
> >  	struct snd_soc_dapm_context *dapm =3D snd_soc_component_get_dapm(comp=
onent);
> >  	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(componen=
t);
> >  	u8 events[DA7219_AAD_IRQ_REG_MAX];
> > -	u8 statusa;
> > +	u8 statusa, srm_st;
> >  	int i, report =3D 0, mask =3D 0;
> > =20
> > +	srm_st =3D snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA=
7219_PLL_SRM_STS_MCLK;
> > +	msleep(da7219_aad->gnd_switch_delay * ((srm_st =3D=3D 0x0) ? 2 : 1) -=
=20
> > +4);
>=20
> Ever since this patch was applied to ChromeOS, we have observed hung task=
 crashes in da7219_aad_irq_thread().
>=20
> Is it really appropriate to sleep up to (256 * 2) - 4 =3D 508 ms in an in=
terrupt handler ?
>=20
> Thanks,
> Guenter
>=20
> > +	/* Enable ground switch */
> > +	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> > +
> >  	/* Read current IRQ events */
> >  	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
> >  			 events, DA7219_AAD_IRQ_REG_MAX); @@ -454,8 +459,8 @@ static=20
> > irqreturn_t da7219_aad_irq_thread(int irq, void *data)
> >  			snd_soc_dapm_disable_pin(dapm, "Mic Bias");
> >  			snd_soc_dapm_sync(dapm);
> > =20
> > -			/* Enable ground switch */
> > -			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> > +			/* Disable ground switch */
> > +			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
> >  		}
> >  	}
> > =20
> > @@ -831,6 +836,32 @@ static void da7219_aad_handle_pdata(struct snd_soc=
_component *component)
> >  	}
> >  }
> > =20
> > +static void da7219_aad_handle_gnd_switch_time(struct
> > +snd_soc_component *component) {
> > +	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(componen=
t);
> > +	struct da7219_aad_priv *da7219_aad =3D da7219->aad;
> > +	u8 jack_det;
> > +
> > +	jack_det =3D snd_soc_component_read(component, DA7219_ACCDET_CONFIG_2=
)
> > +		& DA7219_JACK_DETECT_RATE_MASK;
> > +	switch (jack_det) {
> > +	case 0x00:
> > +		da7219_aad->gnd_switch_delay =3D 32;
> > +		break;
> > +	case 0x10:
> > +		da7219_aad->gnd_switch_delay =3D 64;
> > +		break;
> > +	case 0x20:
> > +		da7219_aad->gnd_switch_delay =3D 128;
> > +		break;
> > +	case 0x30:
> > +		da7219_aad->gnd_switch_delay =3D 256;
> > +		break;
> > +	default:
> > +		da7219_aad->gnd_switch_delay =3D 32;
> > +		break;
> > +	}
> > +}
> > =20
> >  /*
> >   * Suspend/Resume
> > @@ -908,9 +939,6 @@ int da7219_aad_init(struct snd_soc_component *compo=
nent)
> >  	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
> >  			    DA7219_BUTTON_CONFIG_MASK, 0);
> > =20
> > -	/* Enable ground switch */
> > -	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> > -
> >  	INIT_WORK(&da7219_aad->btn_det_work, da7219_aad_btn_det_work);
> >  	INIT_WORK(&da7219_aad->hptest_work, da7219_aad_hptest_work);
> > =20
> > @@ -928,6 +956,8 @@ int da7219_aad_init(struct snd_soc_component *compo=
nent)
> >  	regmap_bulk_write(da7219->regmap, DA7219_ACCDET_IRQ_MASK_A,
> >  			  &mask, DA7219_AAD_IRQ_REG_MAX);
> > =20
> > +	da7219_aad_handle_gnd_switch_time(component);
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(da7219_aad_init);
> > diff --git a/sound/soc/codecs/da7219-aad.h=20
> > b/sound/soc/codecs/da7219-aad.h index f48a12012ef3..21fdf53095cc
> > 100644
> > --- a/sound/soc/codecs/da7219-aad.h
> > +++ b/sound/soc/codecs/da7219-aad.h
> > @@ -187,6 +187,7 @@ enum da7219_aad_event_regs {  struct=20
> > da7219_aad_priv {
> >  	struct snd_soc_component *component;
> >  	int irq;
> > +	int gnd_switch_delay;
> > =20
> >  	u8 micbias_pulse_lvl;
> >  	u32 micbias_pulse_time;
> > --
> > 2.17.1
> >=20
