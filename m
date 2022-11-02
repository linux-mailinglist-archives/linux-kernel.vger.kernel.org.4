Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112576166A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKBP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiKBP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:56:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA72B25D;
        Wed,  2 Nov 2022 08:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z16AHCi4AG6flJ+F+Bi57YTMT4p1K4vX8sWgs5xipbjLmN0zNSFxjXwxQeZoNPuCB54LVhHMfBl5J5PxE03rrpHT6Wu9sN+hFuidP5k21zX7vtXV329oSQsMNeLpfuV4rSwLH9zVgif1qLdyG0Hj/s05tk1XEt61kl6bWlu4ThFyBtDgj3A40NLyc7hQdUsiu+qSw0OYeZN7HxVktz3jXLa8eGNj1Os5toleAlehpNmVyCvJ5zkCCgDd5xBCqM1klhfiyWKOHrbkidoMlm9nUCXE1h005SM4DdCpzZR6BguhaPMTSzUjd0G2y+HQBtH0vpNqR0mr9eSwFHHoQZ3VNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E88lq9SCTtrU68q1H5J4BMoViyWR9Fhq9m+zYAWjmlY=;
 b=UqWser/SYIV5MGBeGOl2Wog/Bi5sVJ7qN+TSpytVv0NXrMba5w0IoVilcx+gPOxXElOFZy3+ZnmV6QzEKduMYbEvTRQFm9PJKsJouniki8MkCMXvc3w1IFo8nZo3gIR1J+UbbXyKAcQLcz6xtE5mfDB4C9Y1e+mwYSzqYQUCMSQdbFvApVnFI3Ciag/BctDRKZU0QYRhdeErVCnu/ZWMl/hCI+DlS+278m6JdJlBIBRJFTu8UALnHzSWZGfBC5cVKVqtdNL+vCMIYaIb69CJLYsABfPG5gpPTMgOCGSYLjQpNaytQZMPOMLYfOOXAAXw+7WG8jbsRrAub461s/jJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E88lq9SCTtrU68q1H5J4BMoViyWR9Fhq9m+zYAWjmlY=;
 b=p2lWBn9EQZk5Z2QT8Sdh2obP7W2pa//iB2QM4UqGSRnyTuzEkk5pHzJdwnJpweoX9kxVrw2LBWUsXEEatmPL0agmeWmWthKNAFUbaFODqgCaYkPtriRGIlH4lncc6h2at7cFS7DD7hJkL7ujfLTEuCofhELq39heBsBvQMb2RME=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5807.jpnprd01.prod.outlook.com (2603:1096:400:45::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 15:56:43 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 15:56:43 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "BMC-SW@aspeedtech.com" <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
CC:     kernel test robot <lkp@intel.com>
Subject: RE: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHY7p7kl1T9YGA12UCEvmgRzmEVOa4ryCsw
Date:   Wed, 2 Nov 2022 15:56:43 +0000
Message-ID: <OS0PR01MB5922014A7D74A884D2E7BDC286399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-3-billy_tsai@aspeedtech.com>
In-Reply-To: <20221102083601.10456-3-billy_tsai@aspeedtech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB5807:EE_
x-ms-office365-filtering-correlation-id: e6c95c21-135f-4ca9-c7d4-08dabcead69f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wEFyAAGughwQN4h06Onna24c1izMR6CWkeKTbRIN6Whr2OxAvpDm7o0f2fvEHaFAYMTlqibc/aCeqT7nSKNf5uYDaH/vQOVnhGoqqUXIL7Z/qZhwvfche32KUYnPI/VeRzYdbJqLOmHPic72mrkMwIPG70vak1JLPeix6CAbxoF4YFRLdocSBdAZNuz1Ukx34OgTadWuDpU7IYKsns8oPFkN0UVkjzZ6qElTE7EEQvaIvdlnGnT4Nu9lhe4aV0Q0xT8qm6zaNaPnJnr2PWOfgrb5+7ir09250QAp4S+t6aZwlTX01tf76PYlqGSoOjiBkmZSvx/IwenDJsuQ6akJ4efuVCIUGb+aTeWUS7m9XjICjkRwZV97zpC9U9zB7HFhA9NnKMct8owmBJlwK80bCJGbdLr1gTQH35GsIkiPIr7ZTqedNL/CSVdA2Vlm/zhpcUtNSYQgGZ0n1Z31aLqyhYrO0Tk0jpXBQ4uMD477hl7dRd2uif+6vs2qSGa8szLQPskEAlVcVOWJgstTVnfmOczgyV6aeKXuKb4q0Fj5FmXKYaMyq/tJsS4b61w1vH9C0x31tKjU9BbYIrmPV47ZS9BBg0CJ67fSxSU09Jf5UjTMcEkZ3cV+jpcYEwHzS9BjRbXorOoIn3+9chG/u1NgdttJk7og1fYOdM6K7hkQejoETfgydpK0PDSNwbb1ABj36Gbw/tB2YYWxYVKWUpchiN/l3l19MRYtnJH4rfrXdhjVqFgqggvtfgJs/kZYYVobgI/vHM5KwO/w0Gz1KMVL3255Qh85uWQja/vyUdMb0c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(7416002)(41300700001)(921005)(5660300002)(38070700005)(8936002)(66574015)(2906002)(8676002)(55016003)(186003)(33656002)(52536014)(4326008)(71200400001)(83380400001)(7696005)(478600001)(9686003)(86362001)(122000001)(316002)(26005)(38100700002)(6506007)(66556008)(66446008)(64756008)(66476007)(66946007)(110136005)(30864003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CWQKIm5pgZjHoHBjxLHVVL0P8YwCkYbZHKL5JAbrGP7xOmdGfzC0a6XPHZ?=
 =?iso-8859-1?Q?k6DshDqexOyt9Wq7v01IFa9GuIyG28Lou2mD4AMTqp51tzvffMiOnuigDf?=
 =?iso-8859-1?Q?q0jUyYRdKCaszPlWCTUsggdmFNq9QQIxGmydN9vOWevdGyZugm1xAOxtKp?=
 =?iso-8859-1?Q?AFqVwNF++bhss4i/+txlbAVHO56mYCSdoTaoT34o6GvhQWgPNv0MtgRfdE?=
 =?iso-8859-1?Q?MHLpFzBSaqtcsMaGjQ5UZ1VQA1ZYqkkUDJS+0y7aO8VwCHRcDwo/jWX0iN?=
 =?iso-8859-1?Q?TvDT5eHyrF1fXvASppNv+3KrF49N46h5bCAV8B8z2+RActWps06z2tTWEo?=
 =?iso-8859-1?Q?k2n9847p0Um0dDkZDsE6FWXgwsx+g8bz/mMgQDQhlw1C6zzPIm+CaaaDTr?=
 =?iso-8859-1?Q?Vf3jIcO7xPwqY8zXxgy3Rfcib29Ef/xGfz1WeT2Najxah91raXZfsEkRYD?=
 =?iso-8859-1?Q?pJxPaQGF18lrt6vRGGY36p9dCoqoi1f/BqjkE3Jd3pvxSRcTcraLNMSAQS?=
 =?iso-8859-1?Q?W3PrKLqMvHQEtYIs+UMQyvKBOX8Civ/qPGkqnimHbrn0jYHk+x6NQuNLn+?=
 =?iso-8859-1?Q?kWbJUt6VlKdHdrRh0FcYDYxBSb2PeSfVRfoDAW6VaGGfnH6LblDhEGoHd9?=
 =?iso-8859-1?Q?ryxUyB9KOEYov5pTZeOieyGx3BA45L+dfDn4KS8F5SIMGW2AY/Lq+DUGtF?=
 =?iso-8859-1?Q?HU8gDsj8zA7WzYi09LCSov7QUNEOrQL7GaE0/tJ1CpXy+kZIE00m2PzHUI?=
 =?iso-8859-1?Q?7DpEgpN8gU+R5SjNl3l/w3ZDFQX1M0P29D8IfQawxFgStEw6vmlhkSk/zD?=
 =?iso-8859-1?Q?/Dk74vkMAtM7t6VINKgVrxTbU1vljfxikyym57g3Mdt2a8P9yh5wyR5cvt?=
 =?iso-8859-1?Q?TpGH3X2Z0c264taJ+71iD5IjxJqrPnbglHWt//Tp1mQX1xbuzwv2i6R8Aq?=
 =?iso-8859-1?Q?iY6Oy3wUwXRlG8HxZIP0yX0mxXh2PICWJGlRfQrBwiWjaCgKRau549Q1x1?=
 =?iso-8859-1?Q?eoh6PaNJuJzvvjRob1LFaqzyU8vfh9tSLCLDMFDg9kgFpHljMv3AbXPvNy?=
 =?iso-8859-1?Q?ZBHv5+V4eAtfCR/4GCy1DC4eisWWmPNymXow1SafWkAOvrBVHkfwQDuiuH?=
 =?iso-8859-1?Q?y/FINnCs9uTjNg+EVqGroD24gu9cAX9gDxpt0zc5yRsZuwP7Ug7b0JFxL9?=
 =?iso-8859-1?Q?VoGsuEkjYQyAZY7RxHbySSoP4rS7L+4ix7tKjjTMrMHBTJgcrokknjzmH7?=
 =?iso-8859-1?Q?7969Ls4f8v+4+IOwvzGH5AfAy4th3cGJsrE72cbvrCbJveyByv3YE1a+zD?=
 =?iso-8859-1?Q?cxlpBgonV2KBtktCg+pzE+0o3HmMi0tHyyFZ/mGP3kZyexO5WB4y+Pdal1?=
 =?iso-8859-1?Q?TLVvF9z4yG1OOL3o/RHMMi1T4tmUtIQVfVWQ7ChGSz2c6oeBy1ncOzVw++?=
 =?iso-8859-1?Q?lObBPcs+CQ3/myPrl5sj/ojUzkHxxNvFhQdPmIj7Pi99BfnU77JZQvHPYG?=
 =?iso-8859-1?Q?nCB2ezjeDWitEjV4yg9WpogEI05S5gZvf9rrd8Y21M6XDglJPp5AYT6FAD?=
 =?iso-8859-1?Q?ls8Lpqgu29ofOQ4BuuR/W/vurlCQT/IDspoW05xuPTtH8JL/MGVUMa3C+N?=
 =?iso-8859-1?Q?2H6CGii3FOZ9rgOlghSGLsKydHqXSi52fmcUSs6X28BKYUgHubxAHZFA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c95c21-135f-4ca9-c7d4-08dabcead69f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 15:56:43.5197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gI7HNMuOo8GSddZlVwhPXqenlInnaJ4XLd/5O1W2deQOmHAbjmmTf+k1EUGSCPlGDkL9NcnS/K7qzaqMbaRHJrcpJpP7n6vUIUgyh7JZHaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5807
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Billy Tsai,

Thanks for the patch.

> Subject: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
>=20
> This patch add the support of PWM controller which can be found at
> aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-function device "pwm-tach controller".
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/pwm/Kconfig              |  10 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-aspeed-ast2600.c | 319
> +++++++++++++++++++++++++++++++
>  3 files changed, 330 insertions(+)
>  create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> aa29841bbb79..3313f074f15e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -51,6 +51,16 @@ config PWM_AB8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ab8500.
>=20
> +config PWM_ASPEED_AST2600
> +	tristate "Aspeed ast2600 PWM support"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	depends on HAVE_CLK && HAS_IOMEM
> +	help
> +	  This driver provides support for Aspeed ast2600 PWM
> controllers.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-aspeed-ast2600.
> +
>  config PWM_ATMEL
>  	tristate "Atmel PWM support"
>  	depends on ARCH_AT91 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> 708840b7fba8..6be0c67bf08a 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_SYSFS)		+=3D sysfs.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
> +obj-$(CONFIG_PWM_ASPEED_AST2600)	+=3D pwm-aspeed-ast2600.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> diff --git a/drivers/pwm/pwm-aspeed-ast2600.c b/drivers/pwm/pwm-
> aspeed-ast2600.c
> new file mode 100644
> index 000000000000..e571e9fadf0f
> --- /dev/null
> +++ b/drivers/pwm/pwm-aspeed-ast2600.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 Aspeed Technology Inc.
> + *
> + * PWM controller driver for Aspeed ast2600 SoCs.
> + * This drivers doesn't support earlier version of the IP.
> + *
> + * The hardware operates in time quantities of length
> + * Q :=3D (DIV_L + 1) << DIV_H / input-clk
> + * The length of a PWM period is (DUTY_CYCLE_PERIOD + 1) * Q.
> + * The maximal value for DUTY_CYCLE_PERIOD is used here to provide
> + * a fine grained selection for the duty cycle.
> + *
> + * This driver uses DUTY_CYCLE_RISING_POINT =3D 0, so from the start of
> a
> + * period the output is active until DUTY_CYCLE_FALLING_POINT * Q.
> Note
> + * that if DUTY_CYCLE_RISING_POINT =3D DUTY_CYCLE_FALLING_POINT the
> +output is
> + * always active.
> + *
> + * Register usage:
> + * PIN_ENABLE: When it is unset the pwm controller will emit inactive
> level to the external.
> + * Use to determine whether the PWM channel is enabled or disabled
> + * CLK_ENABLE: When it is unset the pwm controller will assert the
> duty
> +counter reset and
> + * emit inactive level to the PIN_ENABLE mux after that the driver
> can
> +still change the pwm period
> + * and duty and the value will apply when CLK_ENABLE be set again.
> + * Use to determine whether duty_cycle bigger than 0.
> + * PWM_ASPEED_CTRL_INVERSE: When it is toggled the output value will
> inverse immediately.
> + *
> +PWM_ASPEED_DUTY_CYCLE_FALLING_POINT/PWM_ASPEED_DUTY_CYCLE_RISING_POIN
> T:
> +When these two
> + * values are equal it means the duty cycle =3D 100%.
> + *
> + * The glitch may generate at:
> + * - Enabled changing when the duty_cycle bigger than 0% and less
> than 100%.
> + * - Polarity changing when the duty_cycle bigger than 0% and less
> than 100%.
> + *
> + * Limitations:
> + * - When changing both duty cycle and period, we cannot prevent in
> + *   software that the output might produce a period with mixed
> + *   settings.
> + * - Disabling the PWM doesn't complete the current period.
> + *
> + * Improvements:
> + * - When only changing one of duty cycle or period, our pwm
> controller will not
> + *   generate the glitch, the configure will change at next cycle of
> pwm.
> + *   This improvement can disable/enable through
> PWM_ASPEED_CTRL_DUTY_SYNC_DISABLE.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>

Do you need all the includes?

> +#include <linux/sysfs.h>


> +
> +/* The channel number of Aspeed pwm controller */
> +#define PWM_ASPEED_NR_PWMS			16
> +/* PWM Control Register */
> +#define PWM_ASPEED_CTRL(ch)			((ch) * 0x10 + 0x00)
> +#define PWM_ASPEED_CTRL_LOAD_SEL_RISING_AS_WDT	BIT(19)
> +#define PWM_ASPEED_CTRL_DUTY_LOAD_AS_WDT_ENABLE	BIT(18)
> +#define PWM_ASPEED_CTRL_DUTY_SYNC_DISABLE	BIT(17)
> +#define PWM_ASPEED_CTRL_CLK_ENABLE		BIT(16)
> +#define PWM_ASPEED_CTRL_LEVEL_OUTPUT		BIT(15)
> +#define PWM_ASPEED_CTRL_INVERSE			BIT(14)
> +#define PWM_ASPEED_CTRL_OPEN_DRAIN_ENABLE	BIT(13)
> +#define PWM_ASPEED_CTRL_PIN_ENABLE		BIT(12)
> +#define PWM_ASPEED_CTRL_CLK_DIV_H		GENMASK(11, 8)
> +#define PWM_ASPEED_CTRL_CLK_DIV_L		GENMASK(7, 0)
> +
> +/* PWM Duty Cycle Register */
> +#define PWM_ASPEED_DUTY_CYCLE(ch)		((ch) * 0x10 + 0x04)
> +#define PWM_ASPEED_DUTY_CYCLE_PERIOD		GENMASK(31, 24)
> +#define PWM_ASPEED_DUTY_CYCLE_POINT_AS_WDT	GENMASK(23, 16)
> +#define PWM_ASPEED_DUTY_CYCLE_FALLING_POINT	GENMASK(15, 8)
> +#define PWM_ASPEED_DUTY_CYCLE_RISING_POINT	GENMASK(7, 0)
> +
> +/* PWM fixed value */
> +#define PWM_ASPEED_FIXED_PERIOD
> 	FIELD_MAX(PWM_ASPEED_DUTY_CYCLE_PERIOD)
> +
> +struct aspeed_pwm_data {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +	struct reset_control *reset;
> +};
> +
> +static inline struct aspeed_pwm_data *
> +aspeed_pwm_chip_to_data(struct pwm_chip *chip) {
> +	return container_of(chip, struct aspeed_pwm_data, chip); }
> +
> +static void aspeed_pwm_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	u32 hwpwm =3D pwm->hwpwm;
> +	bool polarity,	pin_en, clk_en;
> +	u32 duty_pt, val;
> +	unsigned long rate;
> +	u64 div_h, div_l, duty_cycle_period, dividend;
> +
> +	regmap_read(priv->regmap, PWM_ASPEED_CTRL(hwpwm), &val);
> +	polarity =3D FIELD_GET(PWM_ASPEED_CTRL_INVERSE, val);
> +	pin_en =3D FIELD_GET(PWM_ASPEED_CTRL_PIN_ENABLE, val);
> +	clk_en =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_ENABLE, val);
> +	div_h =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_H, val);
> +	div_l =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_L, val);
> +	regmap_read(priv->regmap, PWM_ASPEED_DUTY_CYCLE(hwpwm), &val);
> +	duty_pt =3D FIELD_GET(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT, val);
> +	duty_cycle_period =3D FIELD_GET(PWM_ASPEED_DUTY_CYCLE_PERIOD, val);
> +
> +	rate =3D clk_get_rate(priv->clk);
> +
> +	/*
> +	 * This multiplication doesn't overflow, the upper bound is
> +	 * 1000000000 * 256 * 256 << 15 =3D 0x1dcd650000000000
> +	 */
> +	dividend =3D (u64)NSEC_PER_SEC * (div_l + 1) * (duty_cycle_period +
> 1)
> +		       << div_h;
> +	state->period =3D DIV_ROUND_UP_ULL(dividend, rate);
> +
> +	if (clk_en && duty_pt) {
> +		dividend =3D (u64)NSEC_PER_SEC * (div_l + 1) * duty_pt
> +				 << div_h;
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(dividend, rate);
> +	} else {
> +		state->duty_cycle =3D clk_en ? state->period : 0;
> +	}
> +	state->polarity =3D polarity ? PWM_POLARITY_INVERSED :
> PWM_POLARITY_NORMAL;
> +	state->enabled =3D pin_en;
> +	dev_dbg(dev, "get period: %lldns, duty_cycle: %lldns", state-
> >period,
> +		state->duty_cycle);
> +}
> +
> +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	u32 hwpwm =3D pwm->hwpwm, duty_pt;
> +	unsigned long rate;
> +	u64 div_h, div_l, divisor, expect_period;
> +	bool clk_en;
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	expect_period =3D min(div64_u64(ULLONG_MAX, (u64)rate), state-
> >period);
> +	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns",
> expect_period,
> +		state->duty_cycle);
> +	/*
> +	 * Pick the smallest value for div_h so that div_l can be the
> biggest
> +	 * which results in a finer resolution near the target period
> value.
> +	 */
> +	divisor =3D (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
> +		  (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
> +	div_h =3D order_base_2(DIV64_U64_ROUND_UP(rate * expect_period,
> divisor));
> +	if (div_h > 0xf)
> +		div_h =3D 0xf;
> +
> +	divisor =3D ((u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1)) <<
> div_h;
> +	div_l =3D div64_u64(rate * expect_period, divisor);
> +
> +	if (div_l =3D=3D 0)
> +		return -ERANGE;
> +
> +	div_l -=3D 1;
> +
> +	if (div_l > 255)
> +		div_l =3D 255;
> +
> +	dev_dbg(dev, "clk source: %ld div_h %lld, div_l : %lld\n", rate,
> div_h,
> +		div_l);
> +	/* duty_pt =3D duty_cycle * (PERIOD + 1) / period */
> +	duty_pt =3D div64_u64(state->duty_cycle * rate,
> +			    (u64)NSEC_PER_SEC * (div_l + 1) << div_h);
> +	dev_dbg(dev, "duty_cycle =3D %lld, duty_pt =3D %d\n", state-
> >duty_cycle,
> +		duty_pt);
> +
> +	/*
> +	 * Fixed DUTY_CYCLE_PERIOD to its max value to get a
> +	 * fine-grained resolution for duty_cycle at the expense of a
> +	 * coarser period resolution.
> +	 */
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_DUTY_CYCLE(hwpwm),
> +			   PWM_ASPEED_DUTY_CYCLE_PERIOD,
> +			   FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_PERIOD,
> +				      PWM_ASPEED_FIXED_PERIOD));
> +	if (duty_pt =3D=3D 0) {
> +		/* emit inactive level and assert the duty counter reset */
> +		clk_en =3D 0;
> +	} else {
> +		clk_en =3D 1;
> +		if (duty_pt >=3D (PWM_ASPEED_FIXED_PERIOD + 1))
> +			duty_pt =3D 0;
> +		regmap_update_bits(priv->regmap,
> PWM_ASPEED_DUTY_CYCLE(hwpwm),
> +				   PWM_ASPEED_DUTY_CYCLE_RISING_POINT |
> +					   PWM_ASPEED_DUTY_CYCLE_FALLING_POINT,
> +
> FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT, duty_pt));
> +	}
> +
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL(hwpwm),
> +			   PWM_ASPEED_CTRL_CLK_DIV_H |
> PWM_ASPEED_CTRL_CLK_DIV_L |
> +				   PWM_ASPEED_CTRL_PIN_ENABLE |
> PWM_ASPEED_CTRL_CLK_ENABLE |
> +				   PWM_ASPEED_CTRL_INVERSE,
> +			   FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_H, div_h) |
> +				   FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_L, div_l)
> |
> +				   FIELD_PREP(PWM_ASPEED_CTRL_PIN_ENABLE,
> state->enabled) |
> +				   FIELD_PREP(PWM_ASPEED_CTRL_CLK_ENABLE,
> clk_en) |
> +				   FIELD_PREP(PWM_ASPEED_CTRL_INVERSE, state-
> >polarity));
> +	return 0;
> +}
> +
> +static const struct pwm_ops aspeed_pwm_ops =3D {
> +	.apply =3D aspeed_pwm_apply,
> +	.get_state =3D aspeed_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static void aspeed_pwm_reset_assert(void *data) {
> +	struct reset_control *rst =3D data;
> +
> +	reset_control_assert(rst);
> +}
> +
> +static void aspeed_pwm_chip_remove(void *data) {
> +	struct pwm_chip *chip =3D data;
> +
> +	pwmchip_remove(chip);
> +}
> +
> +static int aspeed_pwm_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +	struct aspeed_pwm_data *priv;
> +	struct device_node *np;
> +	struct platform_device *parent_dev;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	np =3D pdev->dev.parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unsupported pwm device binding\n");
> +
> +	priv->regmap =3D syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Couldn't get regmap\n");
> +
> +	parent_dev =3D of_find_device_by_node(np);
> +	priv->clk =3D devm_clk_get_enabled(&parent_dev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");

What is the use case?

Is pwm configured by boot loader initially ?

Or

pwm configured by Linux, not by the bootloader initially?

Or

Driver needs to handle both cases?

Just asking, because you are turning on the clock unnecessarily here,
If you need to address all the use cases. If it is just first one, then
It is ok.


Cheers,
Biju

> +
> +	priv->reset =3D devm_reset_control_get_shared(&parent_dev->dev,
> NULL);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Couldn't get reset control\n");
> +
> +	ret =3D reset_control_deassert(priv->reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Couldn't deassert reset control\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, aspeed_pwm_reset_assert,
> +				       priv->reset);
> +	if (ret)
> +		return ret;
> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &aspeed_pwm_ops;
> +	priv->chip.npwm =3D PWM_ASPEED_NR_PWMS;
> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +	ret =3D devm_add_action_or_reset(dev, aspeed_pwm_chip_remove,
> +				       &priv->chip);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
> +static const struct of_device_id of_pwm_match_table[] =3D {
> +	{
> +		.compatible =3D "aspeed,ast2600-pwm",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_pwm_match_table);
> +
> +static struct platform_driver aspeed_pwm_driver =3D {
> +	.probe =3D aspeed_pwm_probe,
> +	.driver	=3D {
> +		.name =3D "aspeed-pwm",
> +		.of_match_table =3D of_pwm_match_table,
> +	},
> +};
> +
> +module_platform_driver(aspeed_pwm_driver);
> +
> +MODULE_AUTHOR("Billy Tsai <billy_tsai@aspeedtech.com>");
> +MODULE_DESCRIPTION("Aspeed ast2600 PWM device driver");
> +MODULE_LICENSE("GPL v2");
> --
=20
