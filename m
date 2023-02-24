Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29FD6A1AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBXK4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjBXKzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:55:37 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065E679AD;
        Fri, 24 Feb 2023 02:55:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvgDrURwC6hYQAyQQBaPkg1Mq5qbD7C9rVyHwgQNgi24M3srogVrj6YP7pz2aaIOyTsxpf3hpL0Qq9FREb9vZxLAocrEqh+pNJ4xwB5zJXJJIUy31Cm9SW4J3MbJgxRTRJEeu0m0Zr5MRqAwHaz5MTlCDnJXVTOmk+KFjx0n4f2AIoaw9a6ZrHfFomU/e5b/rt5AIem9jHk1a63/ZVsmCV3fKrU3ap1Uw0fyQApJS9z/9+sVSfOM8OsjLn+ZVw6YqJu+pa7B+D/6ipnpuesSH+THknHZG9lUBlb0e7oJ6bUMHfAvQI4A6yk0g8kI9b1DswaHkupkT+NxQbY+IZJgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB7y3LDbahb8yui2G9xOB2XPefnco+rFVHFEgcdcg9Y=;
 b=RYN0ezY5UQ7FqaRm7uNUgxlA3ONl+5OU9H+aM22RgNjzxCpw/lnxzX1rutil7X2g6dU+JA816VmzK6p4HPgpqiBy24gxd7KgtuXtfWifxfZH0tNSnzobvL70jUle3SUJEQV6p2zKhNrbeNkXV4tUwdI7/RyW5GD7JjRpUidBNR5vp6JvzjlGnw1FtKJCVb0PVcNK6QIIm93zylLytgKYdfauVjSgTBQJkkudqM91OnATdmgoLoGtOt4Y3VU7SOyhOsfqVViqqCV/s2owbeF1HnBFRNUVaPCdrqMh6l6979X9SkOJckx+PBYZSpnZ1a7S3Ot9XfuZInvXD4lFInWVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB7y3LDbahb8yui2G9xOB2XPefnco+rFVHFEgcdcg9Y=;
 b=AtqvABPm9dI/CM+O8VHdmWFmDw4RS3TXXO5Ig++vkB8Y10n7ZOR4OvBeY+zL5AMS9IsErCZmAtxmB6CyK9mXXoX9OqpFXWRhoHLfREzwed6iUyPy8s0mqBU7b/PnC/Tv3UpNrHlAGOP9px0u4rqLGAXwSzYZWvRFYMAAzD25/jY=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 10:54:59 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610%7]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 10:54:59 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: Re: [PATCH 4/4] ASoC: wm8524: Delay some time to follow power up
 sequency
Thread-Topic: Re: [PATCH 4/4] ASoC: wm8524: Delay some time to follow power up
 sequency
Thread-Index: AQHZSD5wvadUyO/5A0CFUk73BVIm1A==
Date:   Fri, 24 Feb 2023 10:54:59 +0000
Message-ID: <VI1PR04MB42220617033D1DE404AF445DE3A89@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
 <20230222113945.3390672-4-chancel.liu@nxp.com>
 <Y/YPNMGMZcVZs3xy@sirena.org.uk>
In-Reply-To: <Y/YPNMGMZcVZs3xy@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB4222:EE_|PA4PR04MB9687:EE_
x-ms-office365-filtering-correlation-id: 0be954e0-7ce6-4c64-1a18-08db165592a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DbuBA0q12onnR61iuOkRKOJ6T9XhMWunTsIAPnKxIOeT2v7GLScDjTcfQyTBxAZ0KsS+vaxwvGf7hYJrmcJ2YMcU+zLfYiNhMlgp/TNCEZCofg/L/99Hb8+Uu/nUK5qrQJyZG+FkzkXxJwjMM/JlQu+b/6/uUTThuf/Ius9Qtz41C/xS3QLmGwkEZVa2r/mcQ2gd1cCzsEFFCmfThBeGf8gLCcaX+2GgCc2UXflQkrKiZXgO3D9df4LBLVKctMcwJQasSnxJWSnibaCy5kVXzW4T3ryRPw+S2hP/IFOf8Ss3xnmg4YyvnbUQ2CFLOy/1x4/8THrlY/tuU0YRSI9mCvdUbA4qve+Il8WGTUhDiAu/RHeyRmsxMjG5uEB9RVhEGCI8YMTONeBfQ+zYvn/CG7FmOwKkvu2hh3OcvQ2MuLCjNrEY2zCvcAP2sLk0i37GBXlYW+YiFnTrU8zxXYd10lYAzpsgypU+DltvxsN9/9Tdk98w1lfH+PFVD/TvJHUDDZ0/pi+j5vLdxiYiLzTcWY4nF8bW8TDivrKpfDPzD9+ENeO1uhDdoFKbR69YnMbQdVGol1GqudYipoi6pjjcM+Q9flLrie4UAbqQas7lTwvn4s9IJ/wggJpNBQG3VUyjkHKXBklczxGDsDnW9fNj+6Pgf00Dc4TpWajR7TgOO/FKdYhueX4XWhJr+ZLHJhPRKEEimXpB4iZrAWSxiTf6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199018)(71200400001)(54906003)(316002)(478600001)(86362001)(7696005)(33656002)(122000001)(38070700005)(38100700002)(6506007)(2906002)(66946007)(55016003)(66476007)(8676002)(66556008)(64756008)(76116006)(4326008)(6916009)(44832011)(41300700001)(52536014)(26005)(66446008)(7416002)(8936002)(5660300002)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d82zA44PhvIW4lgT0OgH5SMCfRwZ0gVBekFLiP+FUe/iS85h+1ZDXSbnKhmr?=
 =?us-ascii?Q?nHJ70pimQrKn6YadmNSUHLtCRvla+hZhwW127xNPYandVo1kJ31AswHwtshe?=
 =?us-ascii?Q?qp5Sz7xY0cLD/GPB3CoR8xIt93zVlPrQw5S6NPQ2J0rFjS4F488xDoV7ISr/?=
 =?us-ascii?Q?QseA+6qHdSXYL2RMeXA5AAxHE+Bg6WUM0UH/eIflvk6vhLR1kXrdV8VOrn86?=
 =?us-ascii?Q?4VwELcRB5FH61WI3uuHQ9DiFh3AwwGBYMd94+I3SPOQoncQTYXweragVF4W8?=
 =?us-ascii?Q?fpA58TJHiaUHRVzZ31FZD8Bw4sdqIWK1MXRJ8vinFdqWmTsbviA6wOKnqJ6+?=
 =?us-ascii?Q?+SV1s/DBKqSCy1sSDJnBGDp/32idyhJODG8tknvBPCJ5w9olQOinkz+ZeB0g?=
 =?us-ascii?Q?tm0cS6asH71jGV4B86/hG39tS7kZdHXCmgo9bBeseMhcpTRii3PptVIB/1g4?=
 =?us-ascii?Q?oR7jrpR3YmgeC1ZO3OMuw7WYZvjNrGZw13mc2zk4bdJaOQUFem8LeBh2EfI3?=
 =?us-ascii?Q?zknBeG0qVm7NI1ZZYrj1EPraKTVV5fWB2WW2YPcFH6ZkkGNnbKR0u8EeaxIj?=
 =?us-ascii?Q?GoSwXwahM68/Fxz4C/xsBSWmmIzhqKY02+h7JxsxtS6fclFXlsTONbuNKwin?=
 =?us-ascii?Q?wgcdq5sNygOeCmigl2f9l7poRL3wES5Dau5MEtDfRvrAViPcqS+ZB6YGuYAb?=
 =?us-ascii?Q?9GWlx0qAzHPuKGoUvylUKvEz95pLm1nuXBEAhKLgLiIZlmSrfIts2c4FiwYp?=
 =?us-ascii?Q?nanSVj5g44NiKGreC5X2JGJ7rUJYYzsgHQEDexfPevaWTu1yUFIgwB2les/u?=
 =?us-ascii?Q?DM/FYFMoec5HwIQjaEOKF9VQrPYEuU9WYWpIIrvUu5kMuY0TKwG+hQkja639?=
 =?us-ascii?Q?OlsptpNf7dlSmEFV4kuBvROOvtqqer0cl7eGdyRTTgnZa/bO5iXcJiHkJgSp?=
 =?us-ascii?Q?DakdkcPb8E1VHDGFn455eRF947PEun4ySICxt7WfsXnqwrkons9JdZ3YfIqq?=
 =?us-ascii?Q?bgedijSyu5RZn7mCtL3Asmy31AdIzWYtHuu8MtrEQ+S/6szrsgynzux+tQd9?=
 =?us-ascii?Q?3Y4lZqbT8S5cgzta2tH1d1F6P4mJT1h9LylbNGOf7VScytyOT+diiY7sNVRw?=
 =?us-ascii?Q?ZhxKvymoU0OZCu3y+NW8xiGrmWPgtncoSenSp6Kl9SC/0dd7NvVHGi9Hwv7H?=
 =?us-ascii?Q?6fPFDvk1vkgD+rscWr3EdIyArzfgD2ehrKUWoqdkCR5xQvtMRHVxk80F130g?=
 =?us-ascii?Q?CmvX6ihLONhj+NPsnM7dqQ4p89PHQAsQ3ODhUcFajp0IHcx67iuSpNpbiL73?=
 =?us-ascii?Q?wwaOnjZuOHtG/AgAK9hGmdMSAUc9Tg6k2nls87/2yP0mSYzkerrsZ/UBlG8J?=
 =?us-ascii?Q?0TzVLsMU0cgL+O/wLO8Tx9ATd2C6TTBQmFUxBZm6yIkXvz2HTbVRGVsx7H+l?=
 =?us-ascii?Q?Kj9WwA/A06uzuwWa1Z1wcUSpopHccI9MWJPzq/gzqsvEGNVCbO/vKEWdIqO/?=
 =?us-ascii?Q?cmSWb927R4qnxwQQ6W/537u0G6NxWetTc2Z+sZ69ohZIq6ewKyEx8iTRmeHC?=
 =?us-ascii?Q?OAa3GXPJPXNZRdqG53YZ9oCndOHMOWZ/tCraNgpk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be954e0-7ce6-4c64-1a18-08db165592a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 10:54:59.1487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Seh2L9/mMfs1Ov4MzsgMyNxaNwcqnQRpE4JyvcZqRCZZF5FcXxJ7z48PaZqeV0SDEWmWnslD7uOp1LoAoOK/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9687
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Feb 22, 2023 at 07:39:45PM +0800, Chancel Liu wrote:
>=20
> > +	switch (cmd) {
> > +	case SNDRV_PCM_TRIGGER_START:
> > +	case SNDRV_PCM_TRIGGER_RESUME:
> > +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +		mdelay(wm8524->power_up_delay);
> > +		break;
>=20
> Doing a 100ms busy wait in atomic context does not seem like a great
> idea, never mind a 1.5s one.  This shouldn't be done in trigger, it
> needs to be done later - digital_mute() might be a better time to hook
> in, though longer delays like this are really quite bad.

Yes, such long time delay in driver is very bad. But this device requires
waiting some time before able to output audio. We have to wait otherwise th=
e
beginning data may be lost.

The power up to audio out timing occurs after MCLK, BCLK and MUTE=3D1 are r=
eady.
I added the delay in trigger() because some CPU DAI drivers enable BCLK in
trigger(). You suggested moving the delay to digital_mute(). It seems
digital_mute() is called before cpu_dai->trigger. Please correct me if I'm
wrong.

Regards,=20
Chancel Liu
