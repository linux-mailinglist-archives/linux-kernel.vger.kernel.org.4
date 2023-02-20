Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2F69CBE0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBTNST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBTNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:18:17 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2103.outbound.protection.outlook.com [40.107.114.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4ABDF2;
        Mon, 20 Feb 2023 05:18:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpH+dGVitcezQ032gAnJm+IRDgDLr1+hYdkGpB22ZDuzFFF7V6Iib48ly/n/jkL1ZeSkS0uUOzGlTRhQ3OXw425+YMZrLQSpwFLGgSRHwb9g5AXWpl3PZxMtUijcLqK1O+YWcERrgGfUH2uq15Zgb2d3Zg8Ka80JWdycB3bZqZthYs3DWbw7VeG8dEmtaKqo/NNTZcJ9mWjp/Y+7U7OJGh5Nk3aoai/uGoIY46egjHKtiX3zKroR6n3qlIzLi/Dp4S+g7XaUJ4VQ3SuzGDVb12vcaW/dgIczXS+kd2hDkse8KRQxH3zszRDwDVXd1kOornqSFHBA0roRqWYVUG8+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t36J5Qtqjgt6Pp3RXMF7UBl3KTE6kdf2GcBjL0VOHII=;
 b=jbZ/tLS4oxyJNbh+5eLpFKDoYdk/atgLtTq9k7M6YR5OVRv57OwqNMBl6AkxpWAbLmEImJmiH7Eh5rGsVGUAzb4nlAD9w4kljfVAwKm5wXSRRs/3Uet6wGv7eQ64q2WoW9GWSzrZ1cl3YddJgb/k4r80fwOuEkScPs/4RPSb2SqQOtiA+pAStg3qElNS+8mfX531cgmTsU/gHeFf4DHEEVFuInKWkUM0L3nQWAMTMmSIRWMP3PCxsYXUvUF7hyst7Fa5RJt3MVFmz8Y0r+xcpF6LDyFsq5vZcEwVsMUAF5QUrSbGrfgOft+oDPDqF3V6WAhrQzz6dhmdwonzm+xzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t36J5Qtqjgt6Pp3RXMF7UBl3KTE6kdf2GcBjL0VOHII=;
 b=ffKADlrXmcpxVs6OOkU+Ba96pXR5lrFELQjhDtmX9CQdgHsnya2Flb4asm3TdhC+G6q0++ganMnKIrAognFC+GWpzRbcNWf6VVhzsHCP9wgY8Gi37ID8aLKyigmZjrWFVgeI2o/qQH+eUB9uzNXzCf1vkiAVntrmI5GyK9n4iGo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10760.jpnprd01.prod.outlook.com (2603:1096:400:294::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 13:18:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 13:18:08 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 0/3] Add Versa3 clock generator support
Thread-Topic: [PATCH RFC 0/3] Add Versa3 clock generator support
Thread-Index: AQHZRS0b8JYC5www50CVHBoCQPQrMK7X0LvQ
Date:   Mon, 20 Feb 2023 13:18:08 +0000
Message-ID: <OS0PR01MB592217664FC7D09EB968947486A49@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230220131307.269100-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230220131307.269100-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10760:EE_
x-ms-office365-filtering-correlation-id: 58ee151a-ae7a-4f55-fdd1-08db1344e87f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyIyJozhWHkrZ6fmdQHJghTVTgY0nIvptTZeaYMknJPbGe4a7A9V4jVdK3vEz0SBRjlUy/94aAlewiYf+1+dCcIpZexSyMwiU0j22ugJg/eZ618vAGRr7TGn7K7ruwo0MqtWcX6jd24CIajkBWbvdEJXQWCZqQxlfkMv7UG70ZETDeWfYjVhO27nLx04N4Jvl44OZaUUJYe0cLwRiPqG0vGaK/grqPeNcPcsflfqC3ZrgAvolKjlO0GQm8zaV9LDvSIhMWwZ7j1+k9vMnC5NtZ/7GTmV7Iz5F5KhJ8Mu3QgLGo9gAEuUCMzrVTNbuoafARm99i4FFzTfPUdcndrt1Marol5FSmnY0YYw9LwlYwrGnkPEiaoNz6iwWeyBdSxYS7qELPFZR/4w6Z8bO8q0zRKW7iLQZwhA4nLJQrouc05EQxUwm13V4ssHD40uDMlT7Uo8DJK0ln8/dCcVBBACRWHQQIH/dtmlaObZGoc5a5ONLFYt4r4RHk/NLas6NXEL2VDDdktTKBsFp63Ltb0h/ZbWSCNCpbQnFprr8zb6tcAvV1Opcv9pqIbIj83ZYm2YQbqckVSwxR8Tk7HYfxM91X7Tky5VWygpqQ/YWMJMiyTLz2OAbwDhSo8SNZdAh+ZEQkwqS/68ENXKSYzggRh0YJE5MVLw77H+Ls0UHE08Dt8bmFgSIsGJowrEQkzAhtf7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(38100700002)(7696005)(54906003)(110136005)(316002)(122000001)(38070700005)(76116006)(2906002)(966005)(83380400001)(64756008)(66556008)(5660300002)(66476007)(66946007)(478600001)(71200400001)(86362001)(52536014)(6506007)(55016003)(8936002)(7416002)(53546011)(66446008)(8676002)(4326008)(41300700001)(33656002)(26005)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OavH7Zgn9O1zlUqHe9s4nre3Qkrdaor8d3etIh0UkwYDUycZJ+GIUgd/MkSM?=
 =?us-ascii?Q?kqAtM4SGnhADBzoN85w+rTGYx6OZSB/YmwFsXuJkzhMPlaNxJRfHWgWVXfoi?=
 =?us-ascii?Q?79VHXXHBwD6L58I4awxf+B8k58PUNEJJh7jh4l2X6wHVikyfPaVdfGhDJ1Vo?=
 =?us-ascii?Q?cUOw9/glvkrK493rfmgHg06YVZ+ndfsGrv9J4Iy28kj9l4WLZ5o4u67TEfjp?=
 =?us-ascii?Q?XcRtqKHlHmmxsHjLA7rXvWtY4O2wadIWx6AHbUE/Fmn7XOGeLA5iWmCrqMC3?=
 =?us-ascii?Q?mCrECNDErdQucpxsIrjmpglKCd7YB8X1id2R6tlXz8+Fk5evyJ1EJoM5m8FL?=
 =?us-ascii?Q?sUnz71buUh/pSVyb0SE0QXDzbxa4rPuEblMrmqmQ1BFtxafxDqQzsy6Er99c?=
 =?us-ascii?Q?6wJy9TDppt/JdiatqpNX2wl/+hWsJzDZWl/oZxrarvPoLvc9y0jsvQ2EX3qO?=
 =?us-ascii?Q?bbN7EOD8jgld8bta5+pI/JYyfoL9TkWHW7gV2Exs+xzpX+2f4Y6OKolbT9rR?=
 =?us-ascii?Q?44h4HutcB3/8Ys3Qw8NgIPvTMf6XZ0uxsDinHO65YbE5cF4O04XYEkYCYvlx?=
 =?us-ascii?Q?RWhcdOMclWw4YsWsdqzwzpc2IkpofJVI3pfmzGhIaaN/FADSQEeqmF3qc0Rg?=
 =?us-ascii?Q?lpe0JZMmdZIccDGkX5g4s+2PPqRpyqWWyBWheMjM+6viF5YoKCYPCRfZcKoK?=
 =?us-ascii?Q?MDOTnGvD0rgdQRyOxedqvpGa1PFyn/kxOd+3idnHWvCvlJ9iAioR2XKoZsTU?=
 =?us-ascii?Q?BPCwyABoxxdBrJGGW7nAlcHIFEvSc+qeoAosTDnOuMfm/FtHPBTDC+y7oOtG?=
 =?us-ascii?Q?9auMJQ0umzj7nBBLyz+AP2dcCbdsLYw6+d4Pg7qCCu7toq58F2Y57r8L06PD?=
 =?us-ascii?Q?t8+isuyvbDV25DqiEjCtPUElA102gHbxKC9AqpLkYs8WWOH5r6UmkmP0WbUD?=
 =?us-ascii?Q?9OMBI5/TLXjg9zXXK+Qnom4EFzPpOzesFV4UJHNPhpmunX5lBoyfmcy5ppNQ?=
 =?us-ascii?Q?QM++pN9l0/6nAIb8d2ZIrbsABfYk09I1QFAhiSnQL+356bx6IqoVnUkiC5bB?=
 =?us-ascii?Q?vhum6XwmZAoOx2m+JTxDNbqdKc1ocSt0bIkTwnHiiypWFjN8UfT8nXx1/JBA?=
 =?us-ascii?Q?ES5Xzi0iGhOyCGtVUii1BNjci476Fnwt4uoap0HLkPMGX1Q05SXr+oakRLob?=
 =?us-ascii?Q?6JizPkTWgpvbhz62S3Q4vCTR6jXVxAa+2fDM82n8Fvw1ySeQvwpZHkV1/knB?=
 =?us-ascii?Q?13PWCSiiN92RavQFrYMisl7xp2zljhGvl7myvGg3DD1rGCBLc9XzihYCP4Rz?=
 =?us-ascii?Q?Xa2W7wtYJIZnv4uN9Z1cR4B5SbKOz6iwqnvVtzm9LXN3u4UejBqY1GpxwOuL?=
 =?us-ascii?Q?VU6G38v0Xbmh+LoVlZ2j/nuVwUip4fDECLvsq4Pj/TTgA2we1r1Hobm5tVC8?=
 =?us-ascii?Q?A4tw297i5OBywKQisY0hX/angac7yoK+OZcNDif2lCl9VsRRMSPDPD1Dn8p3?=
 =?us-ascii?Q?FMHpsj6IOoOkISvxt3VbNymFeD3uRcj+Qi/URUJCI6tV6Zl6PgATCKmqf3lv?=
 =?us-ascii?Q?7u457UK+9wPRpK6/cNQ/yCHUgvKN90LGBp1TmuCUTgzZpAXccs0OesuJJIwh?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ee151a-ae7a-4f55-fdd1-08db1344e87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 13:18:08.2150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhY2AEyP5kEIbM1hm4O9WX7c0Cc87BlGVhQXrW/ydHENktbcH4QBpp8+niElODXTp53z39Plhj1gdzmE9aAVOkQxkRdFya+Bbn2JCtwx4hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10760
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rob , Krzysztof Kozlowski

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, February 20, 2023 1:13 PM
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; linux-clk@vger.kernel.org; Gee=
rt
> Uytterhoeven <geert+renesas@glider.be>; Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>; Mark Brown <broonie@kernel.org>; Takash=
i
> Iwai <tiwai@suse.de>; alsa-devel@alsa-project.org; linux-renesas-
> soc@vger.kernel.org
> Subject: [PATCH RFC 0/3] Add Versa3 clock generator support
>=20
> The 5P35023 is a VersaClock programmable clock generator and it provides =
6
> clk outputs {diff2, diff1, se3, se2, se1 and refin}.
>=20
> It has an internal OTP memory allows the user to store the configuration =
in
> the device. After power up, the user can change the device register setti=
ngs
> through the I2C interface when I2C mode is selected.
>=20
> This driver is for overriding OTP default values during boot based on a f=
ull
> register map from DT, and also minimal support to change the parent of a
> output clock.
>=20
> The motivation for developing this driver is for supporting 48KHz
> playback/record with audio codec on RZ/G2L SMARC EVK.
>=20
> On RZ/G2L SMARC EVK, By default audio mclk is connected to
> 11.2896 MHz clk which is multiple of 44.1KHz.
>=20
> Please see the below default OTP configuration of Dividers connected to
> output clocks.
>=20
> DIV3 12.2880 MHz   DIFF2--> Audio clk2
> DIV5 11.2896 MHz   SE1  --> Audio clk1
> DIV5 11.2896 MHz   SE2  --> Audio mck
> DIV4 12      MHz   SE3  --> This clk Not used
> DIV1 25 MHz        DIFF1-->Ethernet clk
> Ref1-> 24MHz
>=20
> With this setup, we won't be able to do 48KHz playback/record on audio
> codec, as mck is always connected to 11.2896MHz clk.
>=20
> But by programming the i2c, we can make use of DIV4 to generate 12.2880 M=
Hz
> and make that as parent of SE2 and there by supporting 48KHz
> playback/record.
>=20
> A block diagram with modification can be find here[1]
> [1] https://paste.pics/a253ce7cdc8720c3b5eb6953b97b25ff=20
>=20
> DIV3 12.2880 MHz   DIFF2--> Audio clk2
> DIV5 11.2896 MHz   SE1  --> Audio clk1
> DIV5 11.2896 MHz | SE2  --> Audio mck
> DIV4 12.2880 MHz |
> DIV2 12      MHz   SE3  --> This clk Not used
> DIV1 25 MHz        DIFF1--> Ethernet clk
> Ref1-> 24MHz
>=20
> The driver can read a full register map from the DT, and will use that
> register map to initialize the clk generator when the system boots.
> and later, based on sampling rate, it switches the parent of SE2 and supp=
ort
> both 44.1 and 48 KHz playback/record at run time.
>=20
> 48KHz playback
> 1f: f6 --> setting Div4 as clock source for se2 Read at address  0x10049C=
00
> : 0x300B4022 --> Setting Audio clk2 in SSI
>        pfd2                           1        1        0    24000000
>           pll2                        1        1        0   491519897
>              div4_mux                 1        1        0   491519897
>                 div4                  1        1        0    12287998
>                    se2_mux            1        1        0    12287998
>                       se2             1        1        0    12287998
>=20
> 44.1KHz playback
> 1f: b6 --> setting Div5 as clock source for se2 Read at address  0x10049C=
00:
> 0x700B4022--> Setting Audio clk1 in SSI
>     pfd3_mux                          1        1        0    24000000
>        pfd3                           1        1        0      960000
>           pll3                        1        1        0   564480000
>              div5                     1        1        0    11289600
>                 se2_mux               1        1        0    11289600
>                    se2                1        1        0    11289600
>=20
> Please provide your valuable comment for this patch series.
>=20
> Biju Das (3):
>   dt-bindings: clock: Add Renesas versa3 clock generator bindings
>   drivers: clk: Add support for versa3 clock driver
>   arm64: dts: renesas: rzg2l-smarc: Use versa3 clk for audio mclk
>=20
>  .../bindings/clock/renesas,versaclock3.yaml   |  135 ++
>  .../boot/dts/renesas/rz-smarc-common.dtsi     |    7 -
>  arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |   35 +
>  drivers/clk/Kconfig                           |    9 +
>  drivers/clk/Makefile                          |    1 +
>  drivers/clk/clk-versaclock3.c                 | 1134 +++++++++++++++++
>  6 files changed, 1314 insertions(+), 7 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/clock/renesas,versaclock3.yaml
>  create mode 100644 drivers/clk/clk-versaclock3.c
>=20
> --
> 2.25.1

