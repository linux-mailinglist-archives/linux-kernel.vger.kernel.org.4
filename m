Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C319264CF67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbiLNS1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbiLNS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:26:58 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2128.outbound.protection.outlook.com [40.107.114.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0733C10A8;
        Wed, 14 Dec 2022 10:26:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2nCvw17+SsO5zFYHQgVh61/b9kQoNhHEqOyaDO8R9jUyaIh3uCcBrf5Vpr5Q1vgGukvOkM4d1cOtJgMeKeRCwxkq2aJSMxY30o7zKrKGUoA5QfO1P/99jK/8W5cHRka4OyFA2/ZB3pcXCCliknIy9CRmEOQaHEQbS9sEQPK5w0jX4ov6YpFBpPraS7gRXd/xpNH/s0kpWehG7n4aoIW5elOOtl5evxSeeTvlpNk7GsenGwex6uPnsmUAGICch5qQIWYbjHbHjz/N+X7S7GsSST41ECdCxkVydCuWXO/QuFxhGd3UmxJEOGu2iHXmgn6JQEDmUkfov2fXRdN6loWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJz3StwXsCuRbOWUUQQo7wrAUmccOcnhXaw79ou6sSQ=;
 b=eCQKyXvJtkJO25mTgktAPRSM6GP1u9m91Rf2tWMe6yDnoa0xvgf9ybfdlSNZzCOmz5nx1YlS3eP97f3Rdc+KdKn7CShXLbcXkEOG8kHYZiSfVNjjN64xfcVoE9v8/Pz4g+87acGulrzquW8vInxpl3HKuSrnEfBX64dJq4dt3hSQnHGJ9g13wJCbvEzkDsu63rLTXa2h6eYKwKCz7kckPpFTdjX7/STNVuXiNdRt9G2TYa9XKccIbfKkW173qpxa9+9AuGMGgWh1EMnIhEcWVPc8B1SxCUkJn9pPhMrMSl2IDjPGdOu/9RzVnM7k5bgaIZgYCF9EEJ3l3cyML+R93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJz3StwXsCuRbOWUUQQo7wrAUmccOcnhXaw79ou6sSQ=;
 b=EFv0VDcqbKQRhNyZR2Zoq4afr5i1Eq91EmGP1fnWe7TMMSTc7rktUrkBC//tA1wB+RvhUncUS+osYF7eWgLegMJuoFghOZATB5ryTqHu+KUrJMOUwo3sd1+aOvQLdpndw9IxxJqfHKU4+kiCk5dVHhDCl1gxYpQd2J/+qAqMy9c=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB10491.jpnprd01.prod.outlook.com (2603:1096:400:2fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 18:26:53 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%4]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 18:26:51 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 1/5] dt-bindings: gpio: Add RZ/V2M PWC GPIO driver
 bindings
Thread-Topic: [PATCH 1/5] dt-bindings: gpio: Add RZ/V2M PWC GPIO driver
 bindings
Thread-Index: AQHZD0RQEfhgdoTwoUKXW2j4jjmej65tjsOAgAANPzA=
Date:   Wed, 14 Dec 2022 18:26:51 +0000
Message-ID: <TYWPR01MB87759AE2651E96276F6CAE94C2E09@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
 <20221213224310.543243-2-fabrizio.castro.jz@renesas.com>
 <20221214161057.GA1140718-robh@kernel.org>
In-Reply-To: <20221214161057.GA1140718-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB10491:EE_
x-ms-office365-filtering-correlation-id: 0135fb9f-1546-4b95-2a6e-08dade00c528
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yMaAT1HLtzs/Eboc7N5KtXg0GPuIpw2eS19U4V+Sw4WhN7x3P0W94n5PnaXQKLVYt48+080z+CRebpeBZT9rGr/n9PooMV8Bi46/1ug1OUQFmGsL++w7FPObLbDD6dgjR3uwDH7zF1MxbSzwnf4mnpfJXpvnd1fNpm0e9vvyYWd99cHjmjf7A1qy3x36cxRA74v+XA/8fYO5QGMKfDnwq98XrMtrvItDKyGYMcl8+sWS0x6pTCoMQqutA70f+pDyrTxgY/Cr7EkSYiclEB69Z0YGgLpFyxouKy7wB50ATB7UTc4fGMTet04vpaWg7d/Xyd+TcOQ59Me4m9YWuySGfj46CIDI0gMeNdgX5N3o5YR3MNDCozn5bzHN6eCSJfKdUllsvitB3bqWDv2JFXhsY89m/mt5RsgqodriAmNZGYGxhlsXB024T2fSf68W9VaSR5peyeN9cYPmHGGJVC8st04LNfjmv6hCAnwLO0sij868tcZNMO5E4lQECpwzt1/5wQOpJ0yijfj05ujY/DZz7YBTSSBZenK7oMLRV09uNbv3Y8MXdtB2Oe8Amr89xaWyZoINXxMpV9lOgN/JZ/FYPYM9Yf296hWohOdO+i9Vtcf9+SNg/dhGG5qQwWlR6O0HYHIi8PxQI2rOuopNLmvS04h2blN6wKHh5xJYJj2FQU/k2GYtpKn+Z5mNAmeCRWhlqOKQD57B73mAe5R4ihyJhhewhtW1yWKdoCdv9f85TtGTAjnfQiHdLD9jbvSARMztS5DK+4r0oLPRCHmC6E1YqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(38070700005)(55016003)(86362001)(33656002)(45080400002)(316002)(54906003)(6916009)(478600001)(966005)(71200400001)(7416002)(2906002)(66446008)(64756008)(8676002)(66556008)(66476007)(4326008)(76116006)(8936002)(52536014)(66946007)(41300700001)(5660300002)(38100700002)(122000001)(9686003)(186003)(26005)(7696005)(6506007)(53546011)(83380400001)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mTa6FxV0lScKndhorV3qIRtWjey33li7dLmQYU+rJSTb0tkXgi2H/v0CFn62?=
 =?us-ascii?Q?EPoyYbPyFHveuO6Vdx+RC0TBLLXqdbDQIn+JAA+/dilTgWA95SsWtPn6DZvA?=
 =?us-ascii?Q?WMFEN9Ss9jHHaFzo2ZRoV/4S3Vp+r4O70PUb3Z0HfNHnVs0R9wHj+XaHLLkn?=
 =?us-ascii?Q?MwHEE5/bKQhaIdMtEaPqLmCfEp5g+dOhnlbTFYcfRoGgGQg8t+NLAvsjVH/b?=
 =?us-ascii?Q?PFf4XU15JbHBEC/GH+29MMFrMsiWD1+F/VApBDQeo4rc1oC17yNiLBwOAk/b?=
 =?us-ascii?Q?8QNmUPSjacpTDHD3T16OclhQmmz8CYaOH/Y0bV0XpESS/+SdRKOsdz+MJuT1?=
 =?us-ascii?Q?vIsV1EOreSWch3n+DRRzrPRcBbklEq/xo4TwgyuTfJjqRGYi8HpJRYrBfC7K?=
 =?us-ascii?Q?YZtC69K7ck0w2NqUOMue9xDFpID/A4nzvYqdiTFWnSutgARtRUNNTB3/Vjgr?=
 =?us-ascii?Q?fVBq0ZI06JtoH1fag0/IPA3ZI08929IC6faG407RGWAHd+g7B95udvtvkF8w?=
 =?us-ascii?Q?FYd3AcXHGFXHWxCB8yaDS8/LQJXUhFOIxazyr3WikMPXz6AZOZYB5XR6rPSo?=
 =?us-ascii?Q?Xy+v1PXMlki2UniJynGuef4m2K2Ders9RAOnttrQCxESy5SxxIEY6HK3LELJ?=
 =?us-ascii?Q?9TOMmRt3qIQvZ7xDdie4o24/2zFI6czRC4d+jfF36VXSQ/8MvxiZSWOSDemq?=
 =?us-ascii?Q?e+81gTg8QaiZcK+kjPrqQmQbOcvzrPSy/kWq7QTnSEH+xQ60OVsVos1/cr+d?=
 =?us-ascii?Q?jpLjXcSaiKo7AtvcUvjrUw34HpcgBs1bmxru4A3XL2QRdmioGfxsiXGOeeFU?=
 =?us-ascii?Q?VZvt3KGUmTujhzI5BaxDtrzJ6wxBrQXf/zwMVAaryuJgLDih961w34/7/QBD?=
 =?us-ascii?Q?FAqo0uF02BqqzxaC2OSOkwsY8/TxBR7zMBB9AE6sz1oWnPrx5xD1BRKKknMP?=
 =?us-ascii?Q?ZqreCtR+wOAn9GgnaoC1D2qtlekck9YuZqKAVP19Us7+sraP1NbOa2QLHzPn?=
 =?us-ascii?Q?V9NcRjHQZdY/c0bySaxLbOHbEvbeUxXwgbWgO9n4+BZAC1GmwxmYdqByO5VT?=
 =?us-ascii?Q?VsR/MLLK6RsXEHemO+ifdopEOYm3F0tjekdk1hbPFKD/54xXQLpJpNkjRGCR?=
 =?us-ascii?Q?FnMm9Qu07cbCCLqaknVQiHQqHSVLFudBn0tAiQfZcqMNNV0q0BzgRd1OqoEn?=
 =?us-ascii?Q?C33OBaN2gsuatSTR/p4r/G4EM77Fh9mUp8siiPTmUZ7yQSwqH10rFAz+rKdP?=
 =?us-ascii?Q?o8doUXxhGS9B8ZsTI7AyWMukG55Ng0r5Er7pKjvCy7zh6GqpaKpeGhJGjs6t?=
 =?us-ascii?Q?6/PBRUKPnHX9HSwPpJY+PQ9PVmGGMAmwRat0WWeIxTIz4lTcbcjcGKQpwzvz?=
 =?us-ascii?Q?9YpA9jqmEpkiW9Vn2uPJWXPibixsiBCV4Y9L3MJpFS+pJeIIIvdPDB4JbASl?=
 =?us-ascii?Q?Mi2VIhoaZVTJTwRGbqrGiOjs2gzdp5FL0E/W4awcb81P6eZRXivPdRW7+ZA7?=
 =?us-ascii?Q?FiCVScHa5fRpc9tsfVH9vHd5EFshte/JW9I+vOh1pfMAni2/p6csgJa5tnZm?=
 =?us-ascii?Q?P2tukWG8wC9+r6SsWFcCpMB3655j6vjjwuWkhebMm7STnFL93l/Th+lMBblV?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0135fb9f-1546-4b95-2a6e-08dade00c528
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 18:26:51.5144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+byU6iTnh3hqW/M+qKkzUQvlttlnuBkDsqxUE9tZZLE1Jq3QV+yW4ki733HUS2HlK7I+Lrh8hVlfLc9VebB7AVZPUAiluhN7kDVVsyjHV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your feedback!

> From: Rob Herring <robh@kernel.org>
> Sent: 14 December 2022 16:11
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: Re: [PATCH 1/5] dt-bindings: gpio: Add RZ/V2M PWC GPIO driver
> bindings
>=20
> On Tue, Dec 13, 2022 at 10:43:06PM +0000, Fabrizio Castro wrote:
> > Add dt-bindings document for the RZ/V2M PWC GPIO driver.
>=20
> Bindings are for h/w blocks/devices, not a specific driver.

Apologies, I will reword the changelog in v2.

>=20
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >  .../bindings/gpio/renesas,rzv2m-pwc-gpio.yaml | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-gpio.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-
> gpio.yaml b/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-
> gpio.yaml
> > new file mode 100644
> > index 000000000000..ecc034d53259
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-gpio.yam=
l
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tre
> e.org%2Fschemas%2Fgpio%2Frenesas%2Crzv2m-pwc-
> gpio.yaml%23&amp;data=3D05%7C01%7Cfabrizio.castro.jz%40renesas.com%7C6036=
23c
> 766f4421b85bd08daddedcb8c%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63=
8
> 066310628408926%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM=
z
> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Do46ncDZK8YK5=
HYJ
> ZYDXuq3yfEA34vnaxEsIDBlcroc0%3D&amp;reserved=3D0
> > +$schema:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tre
> e.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cfabrizio.castro.jz%40renesas.=
com
> %7C603623c766f4421b85bd08daddedcb8c%7C53d82571da1947e49cb4625a166a4a2a%7C=
0
> %7C0%7C638066310628408926%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
Q
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DVo=
WvV
> pW782DVH2zdTKIesyzqm6sjiFyacbl833%2BjRis%3D&amp;reserved=3D0
> > +
> > +title: Renesas RZ/V2M External Power Sequence Controller (PWC) GPIO
> > +
> > +description: |+
> > +  The PWC IP found in the RZ/V2M family of chips comes with General-
> Purpose
> > +  Output pins, alongside the below functions
> > +    - external power supply on/off sequence generation
> > +    - on/off signal generation for the LPDDR4 core power supply (LPVDD=
)
> > +    - key input signals processing
> > +  This node uses syscon to map the register used to control the GPIOs
> > +  (the register map is retrieved from the parent dt-node), and the nod=
e
> should
> > +  be represented as a sub node of a "syscon", "simple-mfd" node.
> > +
> > +maintainers:
> > +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a09g011-pwc-gpio # RZ/V2M
> > +          - renesas,r9a09g055-pwc-gpio # RZ/V2MA
> > +      - const: renesas,rzv2m-pwc-gpio
> > +
> > +  offset:
>=20
> Too generic of a name. We want any given property name (globally) to
> have 1 type. With the below comment, this should be replaced with 'reg'
> instead if you have child nodes.

My understanding is that syscon subnodes normally use this name for exactly
the same purpose, for example:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/power/reset/syscon-poweroff.yaml#L27
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/power/reset/syscon-reboot.yaml#L30

What am I missing?

>=20
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Offset in the register map for controlling the GPIOs (in bytes).
> > +
> > +  regmap:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Phandle to the register map node.
>=20
> Looks like GPIO is a sub-function of some other block. Define the
> binding for that entire block.

That's defined in patch 3 from this series.
I have sent it as patch 3 because that document references:
* /schemas/gpio/renesas,rzv2m-pwc-gpio.yaml
* /schemas/power/reset/renesas,rzv2m-pwc-poweroff.yaml
Which are defined in this patch and in patch 2 in the series.

Do you want me to move patch 3 to patch 1 in v2?

> GPIO can be either either a function of
> that node (just add GPIO provider properties) or you can have GPIO child
> nodes. Depends on what the entire block looks like to decide. Do you
> have multiple instances of the GPIO block would be one reason to have
> child nodes.

From a pure HW point of view, this GPIO block is contained inside the PWC b=
lock
(as PWC is basically a MFD device), and it only deals with 2 General-Purpos=
e
Output pins, both controlled by 1 (and the same) register, therefore the GP=
IO
block is only 1 child.

If possible, I would like to keep the functionality offered by the sub-bloc=
ks of
PWC contained in separated drivers and DT nodes (either non-child nodes or =
child
nodes).

My understanding is that simple-mfd will automatically probe the children o=
f the
simple-mfd node, and also hierarchically it makes sense to me to have the D=
T nodes
of the PWC sub-blocks as children of the "syscon", "simple-mfd" node. I hav=
e found
other instances of this same architecture in the kernel already (plenty fro=
m NXP/Freescale),
for example:
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale=
/imx8mm.dtsi#L585
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale=
/imx8mn.dtsi#L586
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale=
/imx8mp.dtsi#L451
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale=
/imx8mq.dtsi#L616
https://github.com/torvalds/linux/blob/master/arch/mips/boot/dts/mti/sead3.=
dts#L93
etc...

Something like the below could also work, but I don't think it would repres=
ent the
HW accurately:
pwc: pwc@a3700000 {
	compatible =3D "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc",
		     "syscon", "simple-mfd";
	reg =3D <0 0xa3700000 0 0x800>;
};

pwc-gpio {
	compatible =3D "renesas,r9a09g011-pwc-gpio",
		     "renesas,rzv2m-pwc-gpio";
	regmap =3D <&pwc>;
	gpio-controller;
	#gpio-cells =3D <2>;
};

pwc-poweroff {
	compatible =3D "renesas,r9a09g011-pwc-poweroff",
		     "renesas,rzv2m-pwc-poweroff";
	regmap =3D <&pwc>;
};


I think the below describes things better:
pwc: pwc@a3700000 {
	compatible =3D "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc",
		     "syscon", "simple-mfd";
	reg =3D <0 0xa3700000 0 0x800>;

	gpio {
		compatible =3D "renesas,r9a09g011-pwc-gpio",
			     "renesas,rzv2m-pwc-gpio";
		regmap =3D <&pwc>;
		offset =3D <0x80>;
		gpio-controller;
		#gpio-cells =3D <2>;
	};

	poweroff {
		compatible =3D "renesas,r9a09g011-pwc-poweroff",
			     "renesas,rzv2m-pwc-poweroff";
		regmap =3D <&pwc>;
	};
};

Do you think the bindings I have sent out are causing confusion here?
What else can I improve?

Thanks,
Fab

>=20
> > +
> > +  gpio-controller: true
> > +
> > +  '#gpio-cells':
> > +    const: 2
> > +
> > +required:
> > +  - compatible
> > +  - regmap
> > +  - offset
> > +  - gpio-controller
> > +  - '#gpio-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    gpio {
> > +            compatible =3D "renesas,r9a09g011-pwc-gpio",
> > +                         "renesas,rzv2m-pwc-gpio";
> > +            regmap =3D <&regmapnode>;
> > +            offset =3D <0x80>;
> > +            gpio-controller;
> > +            #gpio-cells =3D <2>;
> > +    };
> > --
> > 2.34.1
> >
> >
