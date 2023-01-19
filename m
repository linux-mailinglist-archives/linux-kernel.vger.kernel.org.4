Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0187267364B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjASLDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjASLCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:02:30 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2101.outbound.protection.outlook.com [40.107.114.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064654A1C0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:02:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5apvSaJvQ18/EWjGtND9e7A4NWlcXgRNys+szUuh1w901eMLBBUiIr14LS79BkePiwbgvFQ2Xe3/bMnnyMCJ8f+5GlA6bk0tBXMyeiLre8LKELOx9ZsJzqGHetXBarv3iJope6LVvC7x3vi2XnH4u5Rod0nsDCzwbu0ZGOEnQDJKahTtJ+0ElC0UojICY17aCFn0FvBeUabbDN8kWr+uq11Sl22XeZkVR24UGwOUZPt5TfbtXYKlI3hR81brSc9wKo+yKfxVRgIv6B9KwGIlG6dGzW7OAO1wDKif/emGsCxqTdyUPeWN8jXnrAt91ewPpb/mricaBJylSLQ22emGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peBMV7DtHD1lOVtJafsp4qWSNJ6ZuEWxN5i3yZSUS1Q=;
 b=ff197CQCGpgjIiOOdx1TB7vPaXN60vnJ37mdc/QLYIkrqcSPG+6AQ42Sz6QwhI7/4zNB3USJvVqtlVkK3kEQzB6N57hhZlzIp0arGqjgJh5X9WD/CGiTmKTXJ5I71ftjSPMOguDc+hBo1hzTlYDyXPHMLb9VL4hXoKTzweuCTJfGkG/HTBpQ9eSyDN0sWzxyHgiMr5K9akPyxa7hEIduwX5KcLW7IhJYF0sqU9COGqYYFLyikTK1sumBI0+A1rk35TWOOT83Xbv5nnOT76wIQXsz6zVmiFltqClmHjvkIsttPWQdxuEBa8JKgqwWWgkmD1yD6qWF3wwqzNn8iXV9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peBMV7DtHD1lOVtJafsp4qWSNJ6ZuEWxN5i3yZSUS1Q=;
 b=Sh2ygkDQV5LEnEjwl0n17UAOXMh3H51JtPIuRgFpO4BQXRMqQ+KDJfJm/IC540itSVmLlsGM7jshWcNct4xFtBOl4yHT5Y4x/5CSpOmyo5StgEqHxPK9Q4nKiPkmsCgm8XyFQTwoZG4sdIxtb6wQgWdPm0a3ODEAiDemoWUFZYE=
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TY3PR01MB10402.jpnprd01.prod.outlook.com (2603:1096:400:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 11:02:25 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::8059:793b:71e3:72af]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::8059:793b:71e3:72af%4]) with mapi id 15.20.6002.026; Thu, 19 Jan 2023
 11:02:25 +0000
From:   David Rau <david.rau.zg@renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>, David Rau <we730128@gmail.com>
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
Thread-Index: AQHY/Wc8EHyTvYawJkGeL+1XJ6BDpa6jYNiAgAIOc/A=
Date:   Thu, 19 Jan 2023 11:02:25 +0000
Message-ID: <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
 <20230117195645.GA83401@roeck-us.net>
In-Reply-To: <20230117195645.GA83401@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6641:EE_|TY3PR01MB10402:EE_
x-ms-office365-filtering-correlation-id: d2c973d5-7a37-4c2d-ffeb-08dafa0ca5c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8nGBxGP8Bn64dVRL5zqckT1S4OOv4iHCeHhZ4tPPUbinN1os2QnUGD0FZxP8Li5FjllY5mjgPQbWO/jHQV9NSjxXH7NNHvENpXcDxYMkmXP3rs5aaZ6q6GwQIT6tAIkie2diZQxwbWxqGCbTzgdc6MgeAXIVsSx/B84hVfFp3D1oAiwyEU/QouatQ6226N4nOV1rghhFuxV/leSmPatgBjv4ZeyAxoXmOhE9NesJ00DQtdL3HUm1s0h5k/0nL3nSIrdH1FUXHe9GOe110uswlExsoIoCDB4h12evJaL+BIDRtlRvZQ9Z1JER+IInqdwMi7v/3o51R0WnYDDgFq4fQIpuWtIBnFsaW8TyXUXSzkaQ/eZvhSyJosEP2kBYhtG52ilSotFshRJ0XbxuaPt8fOkm1FxP0dJURzs3uL1fimfN3JV+EuTkX0qU3k6xshzD1LdqcgUEIQASrG8PZGHUWVtsA/GnKDkyZcNtnxYR5XFroRZmQuZl0M8Zzxmg2Ld0sIGEtaZtfMDZrD8i3U6yIQT9nzGncZ32uvgyZniyEvhxWH/EiicqziDzMmx8sqCu8H8F2nrZ+cx96//sHawSibaqQ0oB7CJUtgdZ5aa4IdscmULsd8ivHruq3ortLX6cHh4Lr7zde7/TyDb+NCILcrXMscMdvyF/fXkI6zmtjRWlPHdCLd8k7IYypc3D7fQ72IMvsPlj7i6mx6Y5NKSX7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(2906002)(122000001)(38100700002)(55016003)(33656002)(54906003)(71200400001)(316002)(110136005)(7696005)(86362001)(38070700005)(5660300002)(4326008)(41300700001)(76116006)(66556008)(66446008)(66476007)(8676002)(66946007)(64756008)(6506007)(53546011)(83380400001)(52536014)(9686003)(186003)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BpW6CP9LLcto3w4PywSD2U5PTPJHMz3IGCgDflQmgU6BcrfsBM6Gtx1Ojcml?=
 =?us-ascii?Q?ykZ27DrJ1gtihws764aLKdxSApstUvQGkZ6by7YjSmfhkiPPTr8XqHPhl5pV?=
 =?us-ascii?Q?1A/JrfEUyGtnelruruZiGtubt44nwTIK3oyH2YamXnOGbYRyb5wP8NO34Pvu?=
 =?us-ascii?Q?1Pc4P/wvjriI5WZ+n2BS5t/fW+A52QQS4VxRAScFaKb3FcMZsKOl98DighgZ?=
 =?us-ascii?Q?DgmU2uVTsJxL7yz0Vwh5wJgR9EzgicpqDZ6DPb1cqM4Y/kdcSyhzIK/bneSl?=
 =?us-ascii?Q?GBzYwRmmSVu4eWhMlwCX+8bkGD585XvY5P77rh3TR4zMmhFrJ07mkL2s7Sa0?=
 =?us-ascii?Q?uKrNqL8GdtwTZqbGH9ZNFy9WSvFwaow++6XJLvMpY+6s+71PhlycxH5k4mOa?=
 =?us-ascii?Q?+K+GICJuwEIfgZ0Za/QQGY/YR2ldl6vX28pk0GJHgjYcFnBaDBfIuOM2qVvR?=
 =?us-ascii?Q?JOiRVSq6oz3FBmtEdLLolzBZS5oShGZeiYIVhdUqYxwCfw/Br2V+doGYJfsj?=
 =?us-ascii?Q?Jy6AVwicArONUmYZRSBoJgs5QJfpa8ieNNZIq7AgUKUw/ZdPmO6QyXPi4krB?=
 =?us-ascii?Q?wJ8yqKpJhUcGVD03pZwslux03YZsBwSc5/2z72TNC5u2TRevqnTbviq47BpW?=
 =?us-ascii?Q?IB9K2RbuwaKT6xt5NtofDgzMlWulIRbQXv9uReARpMna7t7LbR44yZ9X3E9u?=
 =?us-ascii?Q?nn/dErrpyvIKJ6gxGKYpUEgBA0MwxdjUmfOStQyAm1fwCdMRp6rzX2sJclAc?=
 =?us-ascii?Q?uQD+T4T0CfqVHlZ1YYw/vSMeNgj4G9fOrPyjIxKCT2z9C5Y9nNqJe8zPMioJ?=
 =?us-ascii?Q?5N0Fp8wCUZussZj34Y3/LLOGib45k4Uboiwth94yUI0ViUZ3XwcyI8rcFUvR?=
 =?us-ascii?Q?+5lqafFahOAQq4e2feCTWQBR/sDco8ioAWmvjpB+GHtibeip9yKxvcM2R46w?=
 =?us-ascii?Q?eWaIc0/4vYuk4rVmAVSE8KtPcRQ6rdaVfVJ5AO7J4A8/KCqhrYhkCUT5Ni9E?=
 =?us-ascii?Q?x68chO3AHc1AkDtJuJ9JgtSAdlt7zs8fCECwLdrScTin+U5w/LNwUAM7yCIv?=
 =?us-ascii?Q?nQlrVYcpi1joGsGKId5zUtXTgbUigrZZ4EPUZRH4pNvJcivYl+avCrOmP8hZ?=
 =?us-ascii?Q?LlHmO9Ks7pvyDhVQMk8sAIZNeCr+8wEHBy7M+meL4uVeYM9d25acCEWapK5o?=
 =?us-ascii?Q?PvuYaYNZMinkwe0CmZ7vOX6IqzPMlFOrGbrOEUuDfCl0brjjtxA2zuPhbHGl?=
 =?us-ascii?Q?SVlXDQkXxjeQYNOMSOZIznGxkDXzdHDKyX6UAUnsEx3CwxuYG1DPKoroGJ93?=
 =?us-ascii?Q?xbyGTgulqWglUyNPK2TJ5zAkzSY+STQEgnQec9PWVgDn6rSL/fO9c0dejaca?=
 =?us-ascii?Q?96z1kRy/+XufRm8Jc+h96+rCz90Vrw0nkqlxpFuKdPAxbOy454mDiSmKTA/j?=
 =?us-ascii?Q?nSQwAuslkxZ34+fLJaY+P1tkXSJniPa7YxiXU5BiZCQjLOmpXDib1cOHQxqX?=
 =?us-ascii?Q?yrPUdH7Z9XwNaAw1egbxketTIKBstGNsF5WQeNBQfaJxPH76WeJhcleQ2Yty?=
 =?us-ascii?Q?LcJXCsHxd6OBOpiTruTcdkaw6c8JM779WOJ87mAo+xq6G/GLaoecXl4Q5U6A?=
 =?us-ascii?Q?oIA4iFxs+jKI9cd9EKg0+ImSTliedCiC+Estu5WiK+vtMVzIcGesA236qe90?=
 =?us-ascii?Q?wo74Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c973d5-7a37-4c2d-ffeb-08dafa0ca5c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 11:02:25.3711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jSO48x1isLABY3vUwr71ZzgKPILRQn/F4+UWFFhWRalojnTqyHCY6k3Ai8ZWweyC7jyAyL8worTe5ry3VhV3rKD4w26lXfXDdl/chCw0aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10402
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would you please provide me the related error messages when hung task crash=
es in da7219_aad_irq_thread()?
BTW, "gnd_switch_delay =3D 256" is an unusual use case of the longer jack d=
etection latency.=20

-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Wednesday, January 18, 2023 03:57
To: David Rau <we730128@gmail.com>
Cc: perex@perex.cz; lgirdwood@gmail.com; broonie@kernel.org; tiwai@suse.com=
; support.opensource@diasemi.com; alsa-devel@alsa-project.org; linux-kernel=
@vger.kernel.org; David Rau <david.rau.zg@renesas.com>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP h=
eadsets when playing music

On Mon, Nov 21, 2022 at 05:07:44AM +0000, David Rau wrote:
> The OMTP pin define headsets can be mis-detected as line out instead=20
> of OMTP, causing obvious issues with audio quality.
> This patch is to put increased resistances within the device at a=20
> suitable point.
>=20
> To solve this issue better, the new mechanism setup ground switches=20
> with conditional delay control and these allow for more stabile=20
> detection process to operate as intended. This conditional delay=20
> control will not impact the hardware process but use extra system=20
> resource.
>=20
> This commit improves control of ground switches in the AAD logic.
>=20
> Signed-off-by: David Rau <david.rau.zg@renesas.com>
> ---
>  sound/soc/codecs/da7219-aad.c | 42=20
> ++++++++++++++++++++++++++++++-----
>  sound/soc/codecs/da7219-aad.h |  1 +
>  2 files changed, 37 insertions(+), 6 deletions(-)
>=20
> diff --git a/sound/soc/codecs/da7219-aad.c=20
> b/sound/soc/codecs/da7219-aad.c index bba73c44c219..08200ec259f9=20
> 100644
> --- a/sound/soc/codecs/da7219-aad.c
> +++ b/sound/soc/codecs/da7219-aad.c
> @@ -352,9 +352,14 @@ static irqreturn_t da7219_aad_irq_thread(int irq, vo=
id *data)
>  	struct snd_soc_dapm_context *dapm =3D snd_soc_component_get_dapm(compon=
ent);
>  	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component)=
;
>  	u8 events[DA7219_AAD_IRQ_REG_MAX];
> -	u8 statusa;
> +	u8 statusa, srm_st;
>  	int i, report =3D 0, mask =3D 0;
> =20
> +	srm_st =3D snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA72=
19_PLL_SRM_STS_MCLK;
> +	msleep(da7219_aad->gnd_switch_delay * ((srm_st =3D=3D 0x0) ? 2 : 1) -=20
> +4);

Ever since this patch was applied to ChromeOS, we have observed hung task c=
rashes in da7219_aad_irq_thread().

Is it really appropriate to sleep up to (256 * 2) - 4 =3D 508 ms in an inte=
rrupt handler ?

Thanks,
Guenter

> +	/* Enable ground switch */
> +	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> +
>  	/* Read current IRQ events */
>  	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
>  			 events, DA7219_AAD_IRQ_REG_MAX);
> @@ -454,8 +459,8 @@ static irqreturn_t da7219_aad_irq_thread(int irq, voi=
d *data)
>  			snd_soc_dapm_disable_pin(dapm, "Mic Bias");
>  			snd_soc_dapm_sync(dapm);
> =20
> -			/* Enable ground switch */
> -			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> +			/* Disable ground switch */
> +			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
>  		}
>  	}
> =20
> @@ -831,6 +836,32 @@ static void da7219_aad_handle_pdata(struct snd_soc_c=
omponent *component)
>  	}
>  }
> =20
> +static void da7219_aad_handle_gnd_switch_time(struct=20
> +snd_soc_component *component) {
> +	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component)=
;
> +	struct da7219_aad_priv *da7219_aad =3D da7219->aad;
> +	u8 jack_det;
> +
> +	jack_det =3D snd_soc_component_read(component, DA7219_ACCDET_CONFIG_2)
> +		& DA7219_JACK_DETECT_RATE_MASK;
> +	switch (jack_det) {
> +	case 0x00:
> +		da7219_aad->gnd_switch_delay =3D 32;
> +		break;
> +	case 0x10:
> +		da7219_aad->gnd_switch_delay =3D 64;
> +		break;
> +	case 0x20:
> +		da7219_aad->gnd_switch_delay =3D 128;
> +		break;
> +	case 0x30:
> +		da7219_aad->gnd_switch_delay =3D 256;
> +		break;
> +	default:
> +		da7219_aad->gnd_switch_delay =3D 32;
> +		break;
> +	}
> +}
> =20
>  /*
>   * Suspend/Resume
> @@ -908,9 +939,6 @@ int da7219_aad_init(struct snd_soc_component *compone=
nt)
>  	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
>  			    DA7219_BUTTON_CONFIG_MASK, 0);
> =20
> -	/* Enable ground switch */
> -	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> -
>  	INIT_WORK(&da7219_aad->btn_det_work, da7219_aad_btn_det_work);
>  	INIT_WORK(&da7219_aad->hptest_work, da7219_aad_hptest_work);
> =20
> @@ -928,6 +956,8 @@ int da7219_aad_init(struct snd_soc_component *compone=
nt)
>  	regmap_bulk_write(da7219->regmap, DA7219_ACCDET_IRQ_MASK_A,
>  			  &mask, DA7219_AAD_IRQ_REG_MAX);
> =20
> +	da7219_aad_handle_gnd_switch_time(component);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(da7219_aad_init);
> diff --git a/sound/soc/codecs/da7219-aad.h=20
> b/sound/soc/codecs/da7219-aad.h index f48a12012ef3..21fdf53095cc=20
> 100644
> --- a/sound/soc/codecs/da7219-aad.h
> +++ b/sound/soc/codecs/da7219-aad.h
> @@ -187,6 +187,7 @@ enum da7219_aad_event_regs {  struct=20
> da7219_aad_priv {
>  	struct snd_soc_component *component;
>  	int irq;
> +	int gnd_switch_delay;
> =20
>  	u8 micbias_pulse_lvl;
>  	u32 micbias_pulse_time;
> --
> 2.17.1
>=20
