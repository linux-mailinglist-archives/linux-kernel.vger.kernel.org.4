Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4A05F48F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJDRwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJDRwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:52:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8195D59255;
        Tue,  4 Oct 2022 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664905936; x=1696441936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tZcChzk0UlMUEZ8OJRXPwbaasiI7Bjgz1LQIlrAWB4s=;
  b=H+Lm/niAfubRtDyML/GRxkLqp3NYgW05CQafPFJrCyQzdGM2I+VXNlew
   j4i93c96cy/KVUeUNw2e3TdONS2IjPV/KfMq4979ftDqE7cwKx0w5KSYF
   TWfbINJy2Ny8v9PemyFX/3BN4fQTVn0rL9eSNIN9jri+2DYwfCBmEsTnI
   FVXgM4JjEz9cXjTw2BhHNPQ/HeZLeuH/sqm42MIxYuvSldPgLtjrxVn2W
   ZHTvy8NYBOhAE/Vdn9q5ipGXPxDkXRjVwVVCAl8bdCEOF9FWQMPrPk7/T
   bYA4g65k+PTkoUAe/u4TDEj8oZ9+vCzha6A05Ylnp2yLkLy8mjHCl1nB5
   g==;
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="193775894"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2022 10:52:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 4 Oct 2022 10:52:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 4 Oct 2022 10:52:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBVrvZhLXIAJYFh0Zhs9h4njZ78BHmAJrIs6pR1ngRxZRrLQd1RvBHRaO3MZMGPRxXbyiM5fEgdz9w/kipeB5fn726aBd4kVVw61YsPqA+2+WSxk5fIdOaLRiScOQEDQQLjF9eL0Naan7R678sgnyKVng+M3qaOFecXQd6Xjf/HGZ+llP/SfIvZooBMR3phLMHOCI1zXHO+p958Uvqtkn5RinMQgKP5h3R36YNBlKf4tNb0BG5SLLp6YuY+Qv1JrKTxGHgSxQ2nXj3RC/C0vb0OgxJNfIQ0dhsfJSzOivWd0UZHvTfclT8Fu3yWnNxqp5CS3fCL4fbgrQimT3qyKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60CWsiShWhxvyyjbX5+gH92KsZyAa78/57caSU0jCtM=;
 b=Aph5JiYa7NFE0rPxxfkMIHyRsx9Zen4jJCAUM96sj69lyrwWHSMP7v12cdVq7sK9S8XK7WjAWE/2O01df8ArI1Q0/E1z6wOT5NxGPkBGG49H7i3RmiU4vl+SRl1Ng70UKOzONJB3+w8N/RrNwfpZCkvSfVGiqbaM3fNy28qd56K2P/LcqWNx0/NKgvRhvW0+cv/7Ww3XyF1Z0B0lKSX4JBlBLVLFu2pvObNeYc4f9ATVBoYpbbm8YMKt12RRjcjy/edZ1KZpiiw90mFmF4AVkVv/1CUz6HkVzOgu5k+TvtItWOZKe0bUfkdo5KR/ay6Bzwv1YAsx2EsT7BAnYRs2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60CWsiShWhxvyyjbX5+gH92KsZyAa78/57caSU0jCtM=;
 b=DsdY4w3zmsWNMAvoYQeYk4tkgXmx8H56HkVL7iH+GR+RGwTPEqTC+yHStV7LrdPJSM3/G2GQvOd4OrOyiS0cJkqpfqvp+Cendlfm49tn8nGsqcnKvcv8DebUrpSjnul0srOXdGaL5D6K8GmMHV0E0liznwpLwzHas1cTTpnCDts=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 4 Oct
 2022 17:51:56 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::6c5b:82e0:522d:6a2c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::6c5b:82e0:522d:6a2c%7]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 17:51:56 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andy.shevchenko@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
Thread-Topic: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
Thread-Index: AQHY1V0xNl764Wi+W0ymRRIbNpbBhK38aB2AgAIZh1A=
Date:   Tue, 4 Oct 2022 17:51:56 +0000
Message-ID: <BN8PR11MB3668B169D079C3F9D1C3BB72E95A9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com>
 <d184aa6d-23e-edf6-4cee-f5f4ad6bf90@linux.intel.com>
In-Reply-To: <d184aa6d-23e-edf6-4cee-f5f4ad6bf90@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|CH3PR11MB7276:EE_
x-ms-office365-filtering-correlation-id: 97131f46-8ff0-4832-d73c-08daa63120f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kznhDj/oVbrCzF2oYCnD3ftNQ3PuWLuhHnGUWtJfcvjyI64jU4l8KNor7k7ZxoYe73yJm4zMaxvua9kAKvsOPuIJzayQHHSzoy4C3DEKKhiOIdG29g8v23KLyA37PiUnyzoWK6+gmRR8mOASVoCxxdGhPPtN6b8bdFl17PWOX80/40QfKvhhlMfdJp8cKY0uMssSf64Kn19xmKa3jAd5+b+E37+OJ/tgXnwlyFdeXt/RQp9EwSRu4J5cpWMktGBCbeUxVSA0eydcntiQ7yTyonPxkSLrC6uUTAJvBpyqeOTaAZwgnnani4vBuZHUng1A7QuxoKMcMhF3zUoHOimTaft80RyuZDZ+U6x4JLWpuvwybjIDr+wiSBxKnDOHfArBXMw9DdhjyVu9J1jUpSjCirwyZZfp2ykgDbblBZnsi2kyDGLLjNoqjXPXeHgy51+3hhkXdeUNTPAQBGy3RVeFSHhCeDtrEzldkZfKyGMkSAyBk9kteFc+vntxXYN3n3PeZpT/PQ1CL3cOMqXpdSQNyM5+XlK5/YHR/jwR1nuy0VpMHXxG2aYXrLD7f5NLyRcNl4X4RPV7ld8YR4tKnoXCqAUfPPYUwXm5U2XRp03NKwbwbt2ylU3Fx71fjHulgYa+t5vX364hQUvY/6qmJ4VG8dOWrZ77QgG0UaSd1B8vugnNoDXOLk1I0qbICCvEjTpz8l4hmXliIV1IDv1r9gl1Vo4pxVybD+5FANk6ReTOjc+W75tMHulSVzZh4UbSzbM4xnKgO+2rbrnoENgeWjZRjAeIsUA6yhCiRmdJ4X8tpZTqwelojKkxVo+ubCs9EvUlCJ6hDlBLew+dlXkv9oMCsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199015)(4326008)(38100700002)(122000001)(86362001)(33656002)(38070700005)(186003)(26005)(7416002)(2906002)(7696005)(55016003)(41300700001)(478600001)(6506007)(52536014)(71200400001)(53546011)(107886003)(5660300002)(316002)(9686003)(66446008)(54906003)(66946007)(83380400001)(64756008)(8936002)(6916009)(66556008)(66476007)(76116006)(8676002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3TPrfErxkSmWgByuJ6+oON5g9QKRcRWlLp9g+UN0pOOXQm4QB18Zx5NgSH?=
 =?iso-8859-1?Q?DOtxKsGfbhNUQXoD9yDoTz93x05sm8d4OeaCHpYTBkk4JcFNGV7ljL5n7T?=
 =?iso-8859-1?Q?zJmcCXbL4cWirnDQBzUo5sR2/nYJcDoZqQxTjwyu6LGzNI/O0Igf5T7hTb?=
 =?iso-8859-1?Q?Bv2fz6lrOv1646ZmXDEtw5K7ZuUNVfiT71jTX2Lx2Yk2umyr4opVsIFsTI?=
 =?iso-8859-1?Q?MZvndOAUjFhrQAJdPYDllO7zIJ04586klTSBOkNgNbOd773pqkDUgp/3Tm?=
 =?iso-8859-1?Q?ku0llj2dZ54VsVqalLyKwn8LwWZPkasjFsl9HSSDsVOyIS3YiySwit//D8?=
 =?iso-8859-1?Q?7WWCKusQZ543kAr5i5PAbXBc5+lKkYRj/bVvtMOPoUYMcrWkv9SL3ujtys?=
 =?iso-8859-1?Q?z7ElCWQ8mjABe5QDEOOOMtVVQh6txFsHYhvTPrbzqH/g75x7/rRTweWg40?=
 =?iso-8859-1?Q?88BLd+loBqvdvLK3A/YgGpP8OW+oi1lYm1xMaXt5YAaSCr/AFV9RALVRE0?=
 =?iso-8859-1?Q?IERfvHUJ/VR2AiKIeILpK8+kvyPNiRh1DJUiwHBnf1vYREpah9LmIMaVzi?=
 =?iso-8859-1?Q?bsDMylGHv9hZltrxBaJtZzAexSFl3zXyvR/AF56avt/cBUudZmHbtDxm7x?=
 =?iso-8859-1?Q?Zc1btq9PUMufCxiq8/uAH0aS2nzGaMq23iE0gm5aK1EcpfvrK+WA4b9JU9?=
 =?iso-8859-1?Q?EGzvhmBO+HDiLQBhoMh9vA+ZxylWKajfC5WqWtPtp4SgxTRQ7IstIEnQQE?=
 =?iso-8859-1?Q?io5cLtsF8qBWaQABB+f6sF7d/ac4Wia8Jsm7LfmbRrfk0uwk2KUW/af+e+?=
 =?iso-8859-1?Q?XJbflPu1fNbZLeBxYmepyx5J+DFLLIUcnfUI9l/lYu2pzG5VPoOMBuP0+E?=
 =?iso-8859-1?Q?0HyOrLFgqEgIIBm0W7b03W9LjJopKz3Ddt8zAUVhwnWdtkAwQiU2KDa5g1?=
 =?iso-8859-1?Q?qwZtV/0Hi1qYjnYWi3WOHIFzPu17g1raYaQ7qZ26YPBpVMwQAbkv1iPXWo?=
 =?iso-8859-1?Q?6MTFsjw2rE9QvQFsi6MaZ/ME1MQV10t4XqfnHiGg6CzYkzltRUPFBRpHAD?=
 =?iso-8859-1?Q?yrL1Afgh5fP7ed3LijxscZ3OB/HVBxqxmlznFCrD34VJYGla+ZablYRs5k?=
 =?iso-8859-1?Q?ZSmaR28i8loxZv4ECJ/S7/FIMmWhHu7eFK51LxLpaQ+Vpg6F4S+lZAHDmK?=
 =?iso-8859-1?Q?NsVgG+A7CqI1SqiPTpLYYW2MzuSRMCfzOGG+UYndSSk0TqpkqoIq1A8F1g?=
 =?iso-8859-1?Q?ZPq358+/vJmoqj60h3t7ay+SWUajXwOaY1M3z+mJh+6wzNpB1D63PInb9p?=
 =?iso-8859-1?Q?KJZ905wK2VeBw9tNy4oAcMESm27HsZHGeR0m9dkKUOXhfAdbRFK8/g+1fd?=
 =?iso-8859-1?Q?r64MyvKeEHDMj2R9XQbqnBvqF9yusSJpb/mQvLWBZ4v8RsF3SiP3eAsFmm?=
 =?iso-8859-1?Q?dRPUYe2peJQwpxRgmsbZNI7TGLb0jLO5zVF8FX/aRPk5xqExWp50uZKF2b?=
 =?iso-8859-1?Q?nBONRBOrDwDihOSUuG9ZcVJ518FBtgtqqrgCO4qqNmZRsSCY1prNBWWGZO?=
 =?iso-8859-1?Q?dGx3sM8zuBqrMX+xVAxggi2JZYsw1kvZXHrxCYyNMXEVDULig5kho8IVZc?=
 =?iso-8859-1?Q?vcs+tfFuQiwxBd4bPIk0Ivle4jZi70uGxzBaSjlcRXfwp+3Kn84VpOsEFF?=
 =?iso-8859-1?Q?fRONVID5resKnt5NCgI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97131f46-8ff0-4832-d73c-08daa63120f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 17:51:56.2599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqBho3jZ1sk+XeF83L4pgLJpRxHPF6D7xyt7vusifHOMeEDG9QFW+mkPzkGCbE9gTZj/VLbHxiXQoM4CUJ3nORo6ZEcBFXpLb9+4clQ1s6pn2ELi5RT/fGxzb1x5FE1S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Monday, October 3, 2022 2:51 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
> support to quad-uart driver.
>=20
> On Sat, 1 Oct 2022, Kumaravel Thiagarajan wrote:
>=20
> > pci1xxxx uart supports rs485 mode of operation in the hardware with
> > auto-direction control with configurable delay for releasing RTS after
> > the transmission. This patch adds support for the rs485 mode.
> >
> > Signed-off-by: Kumaravel Thiagarajan
> > <kumaravel.thiagarajan@microchip.com>
> > ---
> > Changes in v2:
> > - move pci1xxxx_rs485_config to a separate patch with
> >   pci1xxxx_rs485_supported.
> > ---
> >  drivers/tty/serial/8250/8250_pci1xxxx.c | 57
> > +++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c
> > b/drivers/tty/serial/8250/8250_pci1xxxx.c
> > index 41a4b94f52b4..999e5a284266 100644
> > --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> > +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> > +
> > +             if (rs485->delay_rts_after_send) {
> > +                     baud_period_in_ns =3D ((clock_div >> 8) * 16);
>=20
> Is this 16 perhaps UART_BIT_SAMPLE_CNT?
Yes. Is there any macro definition for that? I could not find any definitio=
n in the above name.

Thank You.

Regards,
Kumar
