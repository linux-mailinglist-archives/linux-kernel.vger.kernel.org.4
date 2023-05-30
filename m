Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD256716C68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjE3S1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjE3S0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:26:46 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E97C198;
        Tue, 30 May 2023 11:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqypTYZl+JtbJczbRCHsyKYkKtcicf3zyDbW8pHYXF4Md6+2Lyvdfl1vznsUWYCd/xn5zZIPJSxEt3pJ2UnEwi0JDxa6gEEZAG/IglX+z1SZwQ8hHCqFZIQSGmBYuZd3InpYXRCjJVPlLcfQkZlRgwRUS0TvSgnJx0MVW8UWM/izIN0KjKyOLGBl3UAgKTHy9XpUx9Hm5k1PFCOU6M3EeKO+Zpr4xe1JUWUoeRRtihbYFLOmm9F7TGXFddpB1YD0+NnHOLnDWUAN+ZgtboxrcCk/nnlw72O+BPdBLBAQwi6u39JDSn9yCgR6Bq4BGcMahYK6C25OU15bPrIkkBck6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kkliZ//+rVX6FYkbDPwM9bQPnrFe3MxOKzMHJWAnQw=;
 b=AMgpRiGQBpAlPYIQUxhmzSFUX3uC3Xxiwk41Lb3DdvtUBywACqbmcTIKd1EzTZv7rl/GKZrxirDaDhD3CuEGkafP7jKur+FqdZwadLNcdaooMDsCAhAwaoxCiD3FbjkYfXejoKvC019MKnwqJKkkPNfHdWLp1NtUK7qOUq062xXIDsifVpPMMUwfV8rB/lwlzlUHhvw/3MusqAW8tJiYYz5fa5i3K7uvHyIHZBwTxjTEQQbxyZFcSwqGIzvRh69mdRCZG3eej+g8DQ+cFP4ciT+qEBAWGDacu3DffSHtuJSSCgcz5AVItbeVJVFP8fseeW1uLTpvwMHFFdW6iC2R+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kkliZ//+rVX6FYkbDPwM9bQPnrFe3MxOKzMHJWAnQw=;
 b=O/o3K1AWntlh51ksyrIOf1Z6Ohud6mcI9tOUoSQkIvCjyoERUTlCEx9cPiVdh0VreT6kVzNsHamMZ4V2jshZGDzlDFyTB35in/pYL7me4zKfsFeoFJUnJpxDKZMi6I+LeZshQghRK/U+fUbaTtvLqgbjtYLsH3cvIWtw8BY6ONg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB7723.jpnprd01.prod.outlook.com (2603:1096:604:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Tue, 30 May
 2023 18:26:01 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 18:26:01 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH v5 00/11] Add Renesas PMIC RAA215300 and built-in RTC
 support
Thread-Topic: [PATCH v5 00/11] Add Renesas PMIC RAA215300 and built-in RTC
 support
Thread-Index: AQHZjJbSjhaKMfWI8ESBrT2AvlZc7a9zLa0g
Date:   Tue, 30 May 2023 18:26:01 +0000
Message-ID: <OS0PR01MB592293A08F17EF65A39C56E5864B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230522101849.297499-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230522101849.297499-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB7723:EE_
x-ms-office365-filtering-correlation-id: 17804653-014b-423e-c9d6-08db613b5282
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zBnFUQUDv6mXCPGIXCbroRj3yaxyfD1ZHU3Ijcwd19doZSvaeB+MxBOxuUO+0v+EyLgiM7uNukNAHUNPm+FvbkpunYw0KqdKRrenAmdtrWsbaIS8cr4ELFzDbU0fKvOHaVNpJOITgBaFVEkcEgDIWFHnol/MyVAdD2EihizLjA2w9ILXi/JX1czr0gzaqYL5a96QMYUyT3BxwmFtb/Bk5kE5fZO99/uozaEgNGPPDyDJ9BSWwZSDAjJpdrkwral54StF1OVjpiwjmeFuDyPFjbu8u3zzuECkwgelhqsPgtSwO9BayaRgzPINvEvclAd3vFx8VUkk4/rh7Uj+nSUleLVBXiOWpPsqTcLn9FCpUDYUBUro7oPC1EO45HKyu+KKZASuogFcGUGaJcAU1y95rZ/ABtXvCLs+dWn2SYPd9gkNY6t31D2eaoas1bHr+KStaOPoVDJ1+S3kwUCwPLUi4e4D3Eg6OjwP5dOULS6dKUIJ8n3onrFy4tFyxmm1Gt9xmZ7kO94bvOyPZYhE71r+ArjAELsjnBJffZR5wp+tj0TgeXsWbZUmr5+VKl1tKxYbbiQ4x5v27H/CYpbw7zG27DJwykDUJ/ldac3Rcx8j3k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(83380400001)(2906002)(66946007)(66556008)(66476007)(66446008)(7696005)(110136005)(54906003)(52536014)(7416002)(86362001)(76116006)(8676002)(8936002)(38070700005)(33656002)(9686003)(6506007)(107886003)(26005)(41300700001)(53546011)(316002)(186003)(5660300002)(38100700002)(122000001)(64756008)(4326008)(55016003)(966005)(478600001)(45080400002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8n3st9ZtmmcJ3hRs4+AuUPtr0nF0sISdh//tY0/lz4kEmVgOwD4mUoF0AFKx?=
 =?us-ascii?Q?izBVeySDnWpYcK0vl0AzKawbiT3TTrNI/uGrs7tyWr/Inf++ANM/9rwRQ3Hu?=
 =?us-ascii?Q?0dJSYC5jDcF4o4Jvd1yc0HWsCdv9y/NusrAXp3GjSCV6S8oCVBGPAfuZ9DSW?=
 =?us-ascii?Q?a7yiSMKUwBCkbEUxDVsUYPpf9AAMr7wOS25MOs8wL6ZtwKFGT6mkqoqFXq7y?=
 =?us-ascii?Q?/aXF/O1ZFzKTfoXLbFMwIm7etrH1xL8i2jcr7qgOyC8ttF1yw9OZX0GYfVRr?=
 =?us-ascii?Q?QLKt1hhAGhiW2d7BZD5yDEMBZG0vZRcbpk/OnZPc2rwfCLJWW1nGhlCPybaV?=
 =?us-ascii?Q?EyoxUb7aJyoukDy1jX5XChWT8P6vA83yduuc2HSUhGAqcnK1dFl4z6XVWsxm?=
 =?us-ascii?Q?ot5x4lDvcxYvFTXcmp/hI9q3ci4t5N8A8RuEG2yVdJ7Fivr559MTJkGSl46A?=
 =?us-ascii?Q?8NZqkx1DQuZomb6kL5IJC9kJfD346HtxGNLuUn40Lu/Y6/uF50G/CbSARJib?=
 =?us-ascii?Q?mCVqjFD7TAj7XgVi35JHtM+VaENbM+y7asfMJ8L7m+GqRuITHI0fooG0vHO+?=
 =?us-ascii?Q?ibcLOeJ6LukFR0jdlc+sCZVi0UKA2vENlAMXM/9JIewfE1Fs9ays++09Tt8s?=
 =?us-ascii?Q?xNdCUWh2gB60FjW1izQQ/nb2m1bjtH7tJiZbvtmjfld3pppl2EkMh6qYYw1A?=
 =?us-ascii?Q?7b7X96SvmMoom2nCwBGBCbNzYVRjsQy/EWIVaNEnKU34iHZi534Eyw1i8Gpq?=
 =?us-ascii?Q?fKR5qhl0U36inCjP/eUrIPGVB+1dXSYDgRZCk34mLhcWi3tAyjJBBx15s3im?=
 =?us-ascii?Q?3xRyu8jckIHVnXE1NTNGpo2d358MxGNN1U6rP/5LGLctBbkKCRzU+R1kQhAP?=
 =?us-ascii?Q?SR4WKXrnO5TD4kxKeuPee3jE9zAT3saRy038jXLi0N11/tqNEls0F/hBs5hv?=
 =?us-ascii?Q?qy/Tk1+t6m0uxT2tOHSQM9YKEgAsoX6g6cgTRTu1erAuXUoqnAAOW3VJl52o?=
 =?us-ascii?Q?F/bQSa5jVCUYz5Y9dlh97KuUHOj2c8g6v/MqzY1fQl2oQhG8FLCci6v+nspX?=
 =?us-ascii?Q?+gXGTWVzotKRpYRjg5qvS/TfwXKlCsNf2NlF41hr5tN27FtR6izpILKVl8oV?=
 =?us-ascii?Q?3aBLY6nDLxC/OcP9zl/qbacIaYm0k/c8dHYJunpUNZ5/egBD87PAu7f3jvC6?=
 =?us-ascii?Q?TbJQnNXQ8Z4FP+JEJXGWQyweqpUfFAHmz8a52+z2RVSXzPzUZngYqPC/pbgO?=
 =?us-ascii?Q?d6yPUBAghQTqZYnxQ4oZ/24Wz8znLa5iEiEkSQd78jf5dPAB8pzmKnXmY2Dg?=
 =?us-ascii?Q?hGozIMxULF9Wiij0kkl/ROe5m3jAiQnBt8SpwTAmBI1xGTxABrPgH/JEmCEF?=
 =?us-ascii?Q?fA10g2THiwATCZyk7eQ7DbU6fkRWksfp2JRwCfMGIhMXhXpg4AVJfO/PWbNl?=
 =?us-ascii?Q?YhCBi8tb5IHiUmSkFnvcsaclj8MNj7E6ZPzkkXgLkPdY9wXWe/bOJA5Afl/0?=
 =?us-ascii?Q?1wR5QUpHfQNBJy2nyHTGx1vi2y/awDW/zhy7sWSws8Na2g3Okq3COGUCYdZZ?=
 =?us-ascii?Q?wEW6tv5DnHs6hFVl2XHR2Q8NZrFYoE4RBuRlYWcxrovX9aRIk3LSe3W0DlqQ?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17804653-014b-423e-c9d6-08db613b5282
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 18:26:01.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hk1bl3+ByZ+u3XTwPET7qXfTfOWCAKSfGyusEbJAZ4fSM8OHc9ewBRP9iOnjftVkwFdpcd7hiuC18yuggffNXJlDfFftxic7qta/in59fyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7723
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am planning to split this series into 3 patch series from next version
onwards.

Patch set 1: i2c core patch + PMIC patches, as PMIC driver patch depend upo=
n i2c core patch.

Patch set 2: RTC patchset

Patch set 3: Device tree changes.

Hope it is ok to everyone.

Cheers,
Biju


> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, May 22, 2023 11:19 AM
> To: Wolfram Sang <wsa@kernel.org>; Alessandro Zummo
> <a.zummo@towertech.it>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Liam Girdwood
> <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; Magnus Damm
> <magnus.damm@gmail.com>; devicetree@vger.kernel.org; linux-
> rtc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org; Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH v5 00/11] Add Renesas PMIC RAA215300 and built-in RTC
> support
>=20
> This patch series aims to add support for Renesas PMIC RAA215300 and
> built-in RTC found on this PMIC device.
>=20
> The details of PMIC can be found here[1].
>=20
> Renesas PMIC RAA215300 exposes two separate i2c devices, one for the
> main device and another for rtc device.
>=20
> Enhance i2c_new_ancillary_device() to instantiate a real device.
> (eg: Instantiate rtc device from PMIC driver)
>=20
> The built-in RTC found on PMIC RAA215300 is the same as ISL1208.
> However, the external oscillator bit is inverted on PMIC version 0x11.
> The PMIC driver detects PMIC version and instantiate appropriate RTC
> device.
>=20
> [1]
> https://www.renesas.com/in/en/products/power-power-management/multi-
> channel-power-management-ics-pmics/ssdsoc-power-management-ics-pmic-and-
> pmus/raa215300-high-performance-9-channel-pmic-supporting-ddr-memory-
> built-charger-and-rtc
>=20
> Ref:
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.kernel.org%2Fproject%2Flinux-renesas-
> soc%2Fpatch%2F20230505091720.115675-1-
> biju.das.jz%40bp.renesas.com%2F&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas=
.
> com%7C086829526c5a4b09386808db5aadf404%7C53d82571da1947e49cb4625a166a4a2
> a%7C0%7C0%7C638203475387281433%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=
=3D
> bZIDac5ULa%2F%2BX9u8ZBlXjAaka8vl%2B8tYKOgcXIOpIrk%3D&reserved=3D0
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.kernel.org%2Fproject%2Flinux-renesas-
> soc%2Fpatch%2F20230505172530.357455-5-
> biju.das.jz%40bp.renesas.com%2F&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas=
.
> com%7C086829526c5a4b09386808db5aadf404%7C53d82571da1947e49cb4625a166a4a2
> a%7C0%7C0%7C638203475387281433%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=
=3D
> aKyxhnzMXfirtEcR3XuGAhl%2FUPc6J0Bkx1iEqdvorB8%3D&reserved=3D0
>=20
> v4->v5:
>  * Replaced parameter dev->parent in __i2c_new_client_device() and
>    __i2c_new_dummy_device().
>  * Improved error message in __i2c_new_dummy_device() by printing device
> name.
>  * Updated comment for ancillary's device parent
>  * Dropped aux_device_name check in i2c_new_ancillary_device().
>  * Replaced oneOf->enum for clock-names as it is simpler.
>  * Added Rb tag from Conor for binding patches#3 and #9.
>  * Added Rb tag from Geert for patches#4, #5 and #6.
>  * Replaced "unsigned long"->"kernel_ulong_t" in isl1208_id[].
>  * Fixed the typo in commit description.
>  * Replaced the variable int_osc_en->xtosb_val for isl1208_set_xtoscb()
> and
>    changed the data type from bool->u8.
>  * Replaced devm_clk_get->devm_clk_get_optional() in probe.
>  * IS_ERR() related error is propagated and check for NULL to find out
>    if a clock is present.
>  * -ENOENT means clock not present, so any other errors are propagated.
>  * Dropped bool inverted parameter from isl1208_set_xtoscb() instead
>    using xor to compute the value of xtoscb.
>  * Added description for clocks in PMIC bindings patch.
>  * Dropped clk.h and started using of_property_present to check the
>    clocks.
> v3->v4:
>  * Dropped Rb tag from Geert for patch#1 as there are new changes.
>  * Introduced __i2c_new_dummy_device() to share the code between
>    i2c_new_dummy_device and i2c_new_ancillary_device().
>  * Introduced __i2c_new_client_device() to pass parent dev
>    parameter, so that the ancillary device can assign its parent during
>    creation.
>  * Added minItems to interrupt-names in binding patch.
>  * Added interrupt-names in conditional schema check.
>  * Documented clock and clock-names properties.
>  * Dropped unused name variable from struct isl1208_config.
>  * Make similar I2C and DT-based matching.
>  * Drop enum isl1208_id and split the array isl1208_configs[].
>  * Introduced isl1208_set_xtoscb() to set XTOSCB bit.
>  * Added support for internal oscillator enable/disable.
>  * Moved PMIC bindings from mfd->regulator.
>  * Dropped minItems from reg.
>  * Dropped renesas,rtc-enabled property and instead used clock-names
> property
>    to find RTC is enabled or not.
>  * Added reg-names in required property.
>  * Updated the example.
>  * Moved from mfd->regulator as it doesn't use MFD APIs
>  * Dropped handling "renesas,rtc-enabled" property and instead used
>    clock-names to determine RTC is enabled or not and then instantiating
>    RTC device.
>  * Added clock nodes.
> v2->v3:
>  * Enhanced i2c_new_ancillary_device() to instantiate a real
> ancillary_device().
>  * RTC device is instantiated by PMIC driver and dropped
> isl1208_probe_helper().
>  * Added "TYPE_RAA215300_RTC_A0" to handle inverted oscillator bit case.
>  * Added more detailed description for renesas,rtc-enabled property.
>  * Added support for handling "renesas,rtc-enabled" property.
>  * Based on PMIC version, it instantiates rtc device by calling i2c_new_
>    ancillary_device().
>  * Updated the logs.
> RFC->v2:
>  * Dropped the cross-links from bindings and used a single compatible
>    with separate i2c addresses for pmic main and rtc device.
>  * Dropped patch#4 and split patch#3 from this series and send as
>    separate patch to ML [2].
>  * Added RTC platform driver and mfd cell entry to the PMIC driver.RTC
>    platform driver creates rtc device by using
> i2c_new_ancillary_device()
>    and register the rtc device by calling the helper function provided
>    by rtc-isl2108 driver.
>  * Updated reg property in bindings.
>  * Added optional reg-names, interrupts and renesas,rtc-enabled
>    properties.
>  * Fixed the node name in the binding example
>  * Dropped the cross link property renesas,raa215300-rtc.
>  * Updated the binding example
>  * Dropped MODULE_SOFTDEP from the driver as it is added in RTC platform
>    driver.
>  * Dropped compatible "renesas,raa215300-isl1208" and
> "renesas,raa215300-pmic" property.
>  * Updated the comment polarity->bit for External Oscillator.
>  * Added raa215300_rtc_probe_helper() for registering raa215300_rtc
> device and
>    added the helper function isl1208_probe_helper() to share the code.
>  * Updated pmic device node on the SoM dtsi based on the bindings.
>=20
> Logs:
> [   15.447305] rtc-isl1208 3-006f: registered as rtc0
> [   15.479493] rtc-isl1208 3-006f: setting system clock to 2023-04-
> 27T19:31:02 UTC (1682623862)
>=20
> root@smarc-rzv2l:~# hwclock -r
> 2023-04-27 19:33:05.499001+00:00
> root@smarc-rzv2l:~# hwclock -r
> 2023-04-27 19:33:06.936688+00:00
> root@smarc-rzv2l:~#
>=20
> Biju Das (11):
>   i2c: Enhance i2c_new_ancillary_device API
>   dt-bindings: rtc: isl1208: Convert to json-schema
>   dt-bindings: rtc: isil,isl1208: Document clock and clock-names
>     properties
>   rtc: isl1208: Drop name variable
>   rtc: isl1208: Make similar I2C and DT-based matching table
>   rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
>   rtc: isl1208: Add isl1208_set_xtoscb()
>   rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300
>   regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
>   regulator: Add Renesas PMIC RAA215300 driver
>   arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC
>=20
>  .../bindings/regulator/renesas,raa215300.yaml |  85 +++++++++++
> .../devicetree/bindings/rtc/isil,isl1208.txt  |  38 -----
> .../devicetree/bindings/rtc/isil,isl1208.yaml | 100 +++++++++++++
>  .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  18 +++
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |   6 +-
>  drivers/i2c/i2c-core-base.c                   |  92 ++++++++----
>  drivers/media/i2c/adv748x/adv748x-core.c      |   2 +-
>  drivers/media/i2c/adv7604.c                   |   3 +-
>  drivers/regulator/Kconfig                     |   7 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/raa215300.c                 | 102 ++++++++++++++
>  drivers/rtc/rtc-isl1208.c                     | 133 ++++++++++++++----
>  include/linux/i2c.h                           |   3 +-
>  13 files changed, 484 insertions(+), 106 deletions(-)  create mode
> 100644
> Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
>  delete mode 100644
> Documentation/devicetree/bindings/rtc/isil,isl1208.txt
>  create mode 100644
> Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
>  create mode 100644 drivers/regulator/raa215300.c
>=20
> --
> 2.25.1

