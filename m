Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9745262D9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbiKQLj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiKQLjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:39:19 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFFB4C25E;
        Thu, 17 Nov 2022 03:39:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxqg/neWzA1y60W2dnDl6dPh8YknRGaaXsheSHQJnLH4puiJVvsr0y9seqSiO2FOjtLzPPRIiknkJXNdk9k6tI7qJ7aSISlQ2DPloFGvYPlosypFSCLHVNn/FereMWCJOsHqbZKrpiux/efyo6e/2wQLcqMZwFuhiRTkbM60JqPlQXfq0XIlo0v3jIZvEMpo/h1DNb83S6cVvKvwtXlDSv52ciNCGWBzucJzrjzGodp7sQVui+0fWVzZxi1hVH+M/lDsAjIoCQm0IDr3DarawmR5ZErUJPEpptmSxVSIn8A2RMl2Zigg9Ub6ySv64xkEOGBKyrgYMGPvLVfwAiR1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHaWehAUOmivtUJ9rR2vFHNK9mn0r+uONq0t3GPB8do=;
 b=HfqLsZrDFqKA0lRkhY67nxAhMRtX3CaKuVr4pke9BsiLwCpLqMBJZ68Jup7W+01WatnEhJO2veAUxeuXCDFMcZnGJJrDxnRS7hwsbFRj+HAM7shhhHHGevRR4u4zoDSHIi1G5cF/1EZfBhQ6EJJb87c5/3Yfyo7TSoXuM5vlSNACtwYTTfYtJ6ugKXB5nD8cMO9nhPE8W6Bvpbay5auj5yWahPiyvEjCxnyU7C+NOM/hSlvKbp9UuSGl0j0cVMx+KKHhMW3IdsVzliELxsc7QqVVRwm9KUHrOI6TV8HHPZE/spDkXS1F1pJa3nn/j9n0vHInYbaIsr5EhodWQfxX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHaWehAUOmivtUJ9rR2vFHNK9mn0r+uONq0t3GPB8do=;
 b=LUjrh9BBiWf4heNhR2SaxVbOdRiz3eKZzT/D21tvp1KFqvW9Ne+OpSlMXyWZrN0w9Isd0az+k/T/VrPkayWHtHutQMA9ZHZtn1R6FBmYMKL2gtMeRcgm5azqcfbw3Dpesw5h4cJmvJw7gFe9d3lcI0LLSSy3jxnWPxgcHakqioI=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OS3PR01MB8697.jpnprd01.prod.outlook.com (2603:1096:604:151::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 11:39:11 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::60f2:fa8f:329e:5924]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::60f2:fa8f:329e:5924%3]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 11:39:11 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
Thread-Topic: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
Thread-Index: AQHY79U/DwHbR6F/y0yl0C11fUlkPa5ADIuAgAMEP/A=
Date:   Thu, 17 Nov 2022 11:39:11 +0000
Message-ID: <TYWPR01MB87753203F46FA9C744FEF7E6C2069@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com>
 <20221103223956.50575-2-fabrizio.castro.jz@renesas.com>
 <20221115132811.GA4189373@roeck-us.net>
In-Reply-To: <20221115132811.GA4189373@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OS3PR01MB8697:EE_
x-ms-office365-filtering-correlation-id: 49d6242c-87f8-4d25-ab2e-08dac89058df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMrT7yDMf6NAWCJfSKxqz+DZsGpwyHy92tlQr0Nd/JtUQ9HBy764CjN+zrPjgl+zoDQJJ1NfhX17uS3XkCLj6kPYcAZClxPA7EpkRSS/k+Cd0plfhGWvW8yj98xRcJeiz2JTH8pXJMSBzG3VrBkcEalIdDC+Vulm7qcgQ3EBrTRUq2scJAXGzApiEMzO81VlL/VUI/rT3z6cpp6GcueyQ1HKcKZWJbriZjxVlUErTJtao813y/5ceo2Mry+VwcDZ1o0p8TlqUzsZDJiR4QSBbAi3cjk9EwFbjHOlTqObeVq7TBtnISIX6//KWBR9XAjtNx0sohwsnTSR+/NJUx0jDyfbLQUTBKGjfYdgmBQNsbSOZwifZQEhqoVp2qk0Jh8MuUzn7UyXjGp8a0YaUjsZkm8fQFbN1j1no6AQAy0RhGfyqnUyzTsLd79BSBbJKWNK27yVkHCac7lsjTLFLet64ALf9oqCD85CIltT3GoqEbSCBIK8mTP9Bb+ESwLrgZGeB+XQ4N0It7Qx1TlmdiyidhwkW0TZEFygR9mhK27oD6334bqyzZHpFwTan/9Gx2uWUhHoAT4O7ngpeln/oLUWK0yUDcohTuVH8d/j7nM5C0UpF03a+7xqFmUyQEqBW5bExCpjkoMor4ktqrEhKbk9vZMjaQ5prBs9Fz9NznmjTt57HoXlXV7F1njG55O8oWgwf3Dx92r4YeEdvzt59nu3dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(86362001)(55016003)(76116006)(33656002)(66556008)(66446008)(66946007)(66476007)(41300700001)(71200400001)(5660300002)(64756008)(8676002)(52536014)(4326008)(7416002)(186003)(478600001)(9686003)(316002)(26005)(53546011)(7696005)(6916009)(83380400001)(122000001)(38100700002)(54906003)(6506007)(38070700005)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YyIH8nujHqf3ICnH1T2C8lB2yul64UdeDqCana5pshIQU3qLgkBiINYdawMF?=
 =?us-ascii?Q?Ufld6IIogTN0n3Z4V4lxyT+/So2KdirC6cmWiK+xs30MIP9Ybksgxct3ul9a?=
 =?us-ascii?Q?4+Q5pTkPWYYqBsobbNpiAXNS4JDgsXQaPO42em+XrCmtlm8RG3JcFG+s4uSW?=
 =?us-ascii?Q?5ZvyME+fa+d2UNcdplvqKYUgkIm76lNMXQ2/u+wRG+4x1aXvZKtyOrnkLBnx?=
 =?us-ascii?Q?n9+U8CqoFtwSegFvO/sLlgtZLqjPr/2s3vnMCVDebwZaGVICfOOjwZ6OODiz?=
 =?us-ascii?Q?NBVEZHzrVX5ZM2l/cJXS4Xc/mE4Ryq7imp7KQe+6F5UJv9hsgO6scCxGXh/I?=
 =?us-ascii?Q?ToHHoG82NbknQvO4JV0A2PSKPflORhPPyIkaTi7DBHTJq3HMDMyZTfBY5gJe?=
 =?us-ascii?Q?ndz2p+KHMgZRbRohSqCRaxVE+U2iLaUkrknz1BOMlGJ5lBz5p+tV7h4gltNE?=
 =?us-ascii?Q?4NsUbIbKAA6U7Ur4fIvhTAy2M1kbEBSourS/pKNPe3sci+Bpr6+rh4VsQjq3?=
 =?us-ascii?Q?UXR75ZJ8GuHH74+By3OTR1VfWKAfxOHdzB0xp5a5r9VhUQiMQGB4BmQZshyF?=
 =?us-ascii?Q?vBv4vDZoKnI2M2v2VEk7LlsIzrhNI2uHliBIL+RrRa3mjWczW6uBT7vqJ4dG?=
 =?us-ascii?Q?Prb3mIDCbyyaMs8rzIZW0CH3c1p9fWS6sExSDACC/qxgE8CVnMTFo4otephI?=
 =?us-ascii?Q?ATwIaTPNbx9xJ3tBRindo6Zew2P2g1dX5FO5r1kzOAdQW8mJkipq3Xq5BLZ1?=
 =?us-ascii?Q?o+oQ6T0Q1zWjRk5Os36Vk/dEvGNf2YJKHVyV1RVai9ne91sbO2u8+GisvPLT?=
 =?us-ascii?Q?TZdN+HRKkeWRcsr05HICJKP6nYynntb5tr1ZuimuaiWB6zo3eLO7UAhqqhid?=
 =?us-ascii?Q?gBWYbwJ/R0gG5Lq0lXaJAgdCJ11Awz7OO4w0YrlAvzWtUm4zgi3fgJ58/iaB?=
 =?us-ascii?Q?tzWLrbQIbsGTnnGHjNKUB+Tgl4PuyjFKrVLdvLU1TLs0blY+CUVwC4I3iK5F?=
 =?us-ascii?Q?0tjrIpVLnNUmwSISv4vJnOIYgR5rlgFpVQBjOxZp/i10F/qvGJ3vSzrQgt+K?=
 =?us-ascii?Q?8SSFm4QuTo9EJSJavl4HbVYi6PUpwMhjiP+OL6wrx/FvztY8cHb8TWNV8qI3?=
 =?us-ascii?Q?MwJ/G0i73eyTFumlbTI6B0B42W9nJoL2J+c2j9WyQ8W7r6410uEhlrqEk+rI?=
 =?us-ascii?Q?kKllBjZDbGwB4srh3JbWHJZRLuFOuejVqhrGi+wk53v+53zLlqXrg/MdB5eH?=
 =?us-ascii?Q?l+xls/cZZjwK/neNYY949Gx46DUFytDiF3z0m7bRDsb8xaDcEMjg3CVxSF9R?=
 =?us-ascii?Q?TahUGWAXI24PGvd/lyWyH9ZQJnnc7rY2C2FOLsEG5q8oAUxls0qXcmR6DioJ?=
 =?us-ascii?Q?QrD002+8rfAyN+2ac5DRhlce5yzz/ZElcPotykhY6q5b6PvdMPB/+HG+KEtj?=
 =?us-ascii?Q?Ywz8X84p684hiKzXyc7dBBhaE6B/eJjlMNs1nNEajKepJSgQo6qZ2Iv2MeFT?=
 =?us-ascii?Q?fw4tGFOIck/lJhdcKrVojPSQ6GUJ18sM22gd09y0cB+5tpziTYl58Hs7tAt7?=
 =?us-ascii?Q?Mqy3mhQsRXMddD1IG1DYohc5NCQ5auR2yIKXCq6VBfrdAsI6kgjOw0HsRZ34?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d6242c-87f8-4d25-ab2e-08dac89058df
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 11:39:11.7620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bplytWenr7rt+qG0Bsn4lOPBCHjtW1XswzehH4klnyf4wfwC7T9kW/QLQfBpzyYFRwS+tis1RdSymZXsFmIcRw+oYr9M0t7ERscZf3kJiH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8697
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert and Guenter,

Thank you for your reviews!

As it turns out, the rzg2l_wdt driver has some reset related issues
(currently not addressed by the driver) for the RZ/V2M and RZ/Five
SoCs. More specifically to this patch, there is a better way to fix
the restart callback by addressing the way the reset is handled
for the watchdog IP.

I am dropping this patch, and I'll send out a series to address
the above concerns (which will tackle the issues with the restart
callback in a better way).


Thanks,
Fab


> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: 15 November 2022 13:28
> Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
>=20
> On Thu, Nov 03, 2022 at 10:39:54PM +0000, Fabrizio Castro wrote:
> > The setting for the RZ/V2M watchdog cannot be changed once
> > the watchdog has been enabled, unless the IP gets reset.
> > The current implementation of the restart callback assumes
> > that the watchdog is not enabled, but that's not always the
> > case, and it leads to longer than necessary reboot times if
> > the watchdog is already running.
> >
> > Always reset the RZ/V2M watchdog first, so that we can always
> > restart quickly.
> >
> > Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>=20
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>=20
> > ---
> >  drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.=
c
> > index 974a4194a8fd..00438ceed17a 100644
> > --- a/drivers/watchdog/rzg2l_wdt.c
> > +++ b/drivers/watchdog/rzg2l_wdt.c
> > @@ -145,10 +145,10 @@ static int rzg2l_wdt_restart(struct
> watchdog_device *wdev,
> >  {
> >  	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> >
> > -	clk_prepare_enable(priv->pclk);
> > -	clk_prepare_enable(priv->osc_clk);
> > -
> >  	if (priv->devtype =3D=3D WDT_RZG2L) {
> > +		clk_prepare_enable(priv->pclk);
> > +		clk_prepare_enable(priv->osc_clk);
> > +
> >  		/* Generate Reset (WDTRSTB) Signal on parity error */
> >  		rzg2l_wdt_write(priv, 0, PECR);
> >
> > @@ -157,6 +157,11 @@ static int rzg2l_wdt_restart(struct watchdog_devic=
e
> *wdev,
> >  	} else {
> >  		/* RZ/V2M doesn't have parity error registers */
> >
> > +		reset_control_reset(priv->rstc);
> > +
> > +		clk_prepare_enable(priv->pclk);
> > +		clk_prepare_enable(priv->osc_clk);
> > +
> >  		wdev->timeout =3D 0;
> >
> >  		/* Initialize time out */
> > --
> > 2.34.1
> >
