Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C3865284F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiLTVUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLTVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:20:07 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7931E70A;
        Tue, 20 Dec 2022 13:20:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1q81R/F2F4ZalwpdOCbu11aEEttaIxWe6EzfrbuZKNX6QS99fe/MxdA4DEXBDN1qxaiSyWF7Nue1qSJcDfoWho6E553/SGd2hxEFbyD7q1cO8NmQrGSGj9oztuEfeC/Z8WNLM5ReGBC6b4Ba3UUDNZyWjl0qF9SwVI/UVnx+0p7nVT+cxkuOfAv20PlOJjsLflE0ZbKxFddjBLyFOGysOHtZDg3xxG7AKNxZljcr5ClROgCkSwCtmWKING/4LJBgdMfNR00avoQBmpN9ir8s5BeN/RThuiZU3zHYMS3Y3+t5pRBOa0zV307S+vck2biDwO2Q2nC2p0mVQ8fas8ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uslm6LYeYIR7C/e3tPqNlxvMbKL1HuMxMHGpk7HIx3I=;
 b=QFfzGtTSBgSRYy58r12Q8syWGTyz7ohyqKMDWmGPQe7bu6k2+1CogmfSccx2EkcOnQDarNS3R4HdhJmmZtsjNq7mh1cEOr+m/ItOcYOkHPiRKGNTCGdLa+S/7BlVgY0+IGDayPwx7Zize1cajaD2Ysao7UoTIiEUmSVA69M4lqzu1FYamnQkZWPWxrEi3GeSr8KS3qPKWTTPpncnoBtwquv5sk9WKW9pMB8H3CVNeLfJ0wsqR6YGteaBt/f1I6zwRhcvAKUt0ZCjy/iiPgyUr3/9CHTXuEbDQ7ZH8/QQrOFm11XJAnkTKi/I/c98KSwcn6IK9ZJh63wzzU+KrYBJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uslm6LYeYIR7C/e3tPqNlxvMbKL1HuMxMHGpk7HIx3I=;
 b=pdqn0uF1gPi+56AsXmw0r2rEVq0ZwVIuszC7W+2mkpeoeFOWtJcTUzsPbH7XORBmc1fxmH5+cY04urQXut1glpzMOAhWKk64BTAQulLGG7OSJ6yKWOLPmrwp8PU9//8tC4CdJqHhqSOnShNCuuBrKpF4Jl9PC9D6jgOC+3H1LVA=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB9422.jpnprd01.prod.outlook.com (2603:1096:400:1a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 21:20:03 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 21:20:03 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
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
Thread-Index: AQHZD0RQEfhgdoTwoUKXW2j4jjmej65tjsOAgAANPzCAARpzgIAIm7FA
Date:   Tue, 20 Dec 2022 21:20:03 +0000
Message-ID: <TYWPR01MB8775047341FBAD895475CC85C2EA9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
 <20221213224310.543243-2-fabrizio.castro.jz@renesas.com>
 <20221214161057.GA1140718-robh@kernel.org>
 <TYWPR01MB87759AE2651E96276F6CAE94C2E09@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <8199105f-4c67-1af3-65fe-a5c8ddababca@linaro.org>
In-Reply-To: <8199105f-4c67-1af3-65fe-a5c8ddababca@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB9422:EE_
x-ms-office365-filtering-correlation-id: 54b3218f-0380-4fb4-85dd-08dae2cff5c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dRvLRSFDgTXzXKmMhZqDnpEbzk7ww40kxFZEM4ongiTx/S3BiIKoaQTl4ggPUASpEqHU4wiO9cUYwhuSVQQXzNnvHIwE656Okrj023cA2iHQfoRVQohlOamDAmsiYXiGyittAIPV9kXLqEKVa5WDfix4N61FwZovRC5m24klqtFHWLQIMhd8pFmR/i6te8fC+2RfY8DwtvgQikHDjQ7ByX4YDbk1NyXsikDVz/9r+Yd+IZl8rJc38M3s1TSLBFODITNw7EURLAvuO78bKWb5DT68m2liq70UDCpPsMLcCzIqaIpHwFga0pAXlZ1HM7nzUXxlvwUlzuBcZMpQgruzlehYTFNUp67BgXJaTc4TQouh3bFvhxwUVt1RM4wByQaGvCn8wVpnPQqgICoFLgKMbBqt3Ejvq8bKPxa+Y80NjXw1Sqa54ZGYXFvvQmbme/a3w9b8wTHCy5LwxJTr64qysOq0DRAzEkx+4FeNFOOnOFWKBp1Afns1e9Oxbj1SLxubSeZY001wQnCzRjMKI/53r48JuvzTGiutU2bKfBzqmVlqS7yz/p3sdbwx78i88amTD1XGIBv4/c9CCrJZe0oL4XsFIOH8oo834IkxYJ1HI0Mwp3Xs8/1X8DjYVB0+mf2VHpVV6S21vDpccrCDW1LrYyly+flkSK31f7GwBlITnILTRkGJjxs48u1M+VTwJbvEvJ+kF4Lt6n+2s1+xx4wXSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(86362001)(38100700002)(52536014)(71200400001)(26005)(41300700001)(7696005)(122000001)(8936002)(186003)(9686003)(54906003)(66446008)(66556008)(66476007)(53546011)(8676002)(2906002)(4326008)(7416002)(66946007)(64756008)(76116006)(83380400001)(33656002)(38070700005)(55016003)(5660300002)(110136005)(6506007)(66899015)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DYEc+5cPpD1VLk/rGYU7RoHFek957sc5scc6KslbH7H3OGEqs8iJ7WvU0jEZ?=
 =?us-ascii?Q?mmsyNTsGh8WM6eWNSjC4voJDc/z3X3ddsjr9mg7s8LrO3rysdqW9t96C3tr+?=
 =?us-ascii?Q?sHF7NtZoZWDCnjao7fsGrWFL6NpQzOviTJ8qQuN+4NMrg8P7mlhcIGXOltHG?=
 =?us-ascii?Q?bH2BGfpm5uELKUHpKGEqTE3puPUPeOqONKfTOJs8iZx40QajTfJs5e024jV7?=
 =?us-ascii?Q?W2hRz5q3W1j0JkeeaVRBnO1ke3lEJ6+VwXotRr/nWdlb8XvPqDyc1Lokzlv7?=
 =?us-ascii?Q?XnQqbvoiQeCDSuKrZQMtKtK+2nq5MJCZxHscrvYx5d34X6SMsAQo37mxieiw?=
 =?us-ascii?Q?+F3QDelT0YSEGQd07djoEJfFp/+pPCCTt8I0/di+Es5e8rdCIC1cLq53NOXt?=
 =?us-ascii?Q?BE/U+uCkNqtMZSJX6xoa86WXTPl0whnHGIEpZo6mZG+A2A6q/4Pc5Izq06Wi?=
 =?us-ascii?Q?JcC9rZjIEc/Hcjdh/BmXvJUBnVLicSIdZCr/YDa0dp58mzOkQHErVuv39JzJ?=
 =?us-ascii?Q?3qTPQK4HrcmSPdlbDVgldmUEP4j68yZTU8AwOauE5tBKwRemMicF5qoNA6T2?=
 =?us-ascii?Q?tFMxVXjirMRcSK54x+eLdRDfD4NJtUG4M5IKQ9WFiPZcl12upkruzH3qTSFS?=
 =?us-ascii?Q?qbR8DFqA5j2LPTTGGLtEZPM8KOdSt9E/LxusUpqsFwaH09ZP974yykIgtSAd?=
 =?us-ascii?Q?9hTQXlmUqRvtHYQIOsHPRePlN1V6nr4cqq+wwSz9pJ57E240bNauakOZYPHL?=
 =?us-ascii?Q?TWdB9qkpgCZHQnT1vhEz/LPhgZPgZyvreQthFPZbEDCLXoOozimXkp8LWU2P?=
 =?us-ascii?Q?PiUOi0xXR56kMQ/i6H3cN/knwlfCFxz8OFDsaErnf8Ys3R+HXgBBIvAdNr2f?=
 =?us-ascii?Q?NzEly4KXi5US4JuNunQKBaHtbRknPt7uVqZxn+aKckQGKeD0dFMBBHEzw+IO?=
 =?us-ascii?Q?UgVGNByHruIuLhhWtdmOncMkW6nvyfJrVlCxLk8hRwBXe+7qk5fpxL6cfiOP?=
 =?us-ascii?Q?xADrcfhPb5vZnVjdClqcE0QUGgW6qj6p+WeMJeG+8Xl/hV63nC0ClJ8C/Pg6?=
 =?us-ascii?Q?Quc0smmKjEUNQ4fMHclEw7CEBcKyQNWMqqs2F6d2DIKM9qpV9oGnJ/7UN9Io?=
 =?us-ascii?Q?cT48V9zr0zKYnjCoS1tWLmBJWOE9NIgXDn+rYuZbZod3/vDLEQcVZ/25iJxN?=
 =?us-ascii?Q?H6/Djjimpfd3ByIgBNs+LCNqwiEM/bqyD48nYLcdXmfREr05viGvQ7LgdR+t?=
 =?us-ascii?Q?ODdVYMKkur89/z1XBR1oe8mEmoERgd6J17ptRC1XF1gVNk0t5MP4zi/6uEd4?=
 =?us-ascii?Q?7TrVpTbsCeVBZA11pea7Iz/66IsYYbiNoarRz7YanNPhP+T4MHZPndIz5xjL?=
 =?us-ascii?Q?qUTfC8sfxhMS9lrY56lxwujcZgp3vy8mraSM0xuqdBgzq3TyP/Cna3a1f89n?=
 =?us-ascii?Q?tK582UYAIhaFrV1H0CcQ3/6OP3tVQ8cFV4pZpIaWTxN6/nX+ZHnXxMQbafWU?=
 =?us-ascii?Q?/iIbT8R90TYt0OjR+alysAy0f210G+4pvl0/k8+2zbK3XpbEmFvosYTzn6/A?=
 =?us-ascii?Q?QEZsvPPMqC7hZ/DMwsJywEkdMsuB4ftliF1a0NMywJn9CmIES29eAbDUPfwi?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b3218f-0380-4fb4-85dd-08dae2cff5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 21:20:03.5700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/R5pUJuGPLDWtstjlqTTMwu4NI2k141zog5Z/H6qIvgqIYKvf7t2MqXFylwQI1ySL1V3tnd1EQJAHOK8oyT5awlPvsjxk+9FsPHdUmTvpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your feedback.

> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: 15 December 2022 09:49
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Rob Herring
> <robh@kernel.org>
> Subject: Re: [PATCH 1/5] dt-bindings: gpio: Add RZ/V2M PWC GPIO driver
> bindings
>=20
> On 14/12/2022 19:26, Fabrizio Castro wrote:
> > Hi Rob,
> >
> > Thanks for your feedback!
> >
> >> From: Rob Herring <robh@kernel.org>
> >> Sent: 14 December 2022 16:11
> >> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> >> Subject: Re: [PATCH 1/5] dt-bindings: gpio: Add RZ/V2M PWC GPIO driver
> >> bindings
> >>
> >> On Tue, Dec 13, 2022 at 10:43:06PM +0000, Fabrizio Castro wrote:
> >>> Add dt-bindings document for the RZ/V2M PWC GPIO driver.
> >>
> >> Bindings are for h/w blocks/devices, not a specific driver.
> >
> > Apologies, I will reword the changelog in v2.
> >
> >>
> >>>
> >>> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> >>> ---
> >>>  .../bindings/gpio/renesas,rzv2m-pwc-gpio.yaml | 62
> +++++++++++++++++++
> >>>  1 file changed, 62 insertions(+)
> >>>  create mode 100644
> >> Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-gpio.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc=
-
> >> gpio.yaml b/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-
> >> gpio.yaml
> >>> new file mode 100644
> >>> index 000000000000..ecc034d53259
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-
> gpio.yaml
> >>> @@ -0,0 +1,62 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +
> >>> +title: Renesas RZ/V2M External Power Sequence Controller (PWC) GPIO
> >>> +
> >>> +description: |+
> >>> +  The PWC IP found in the RZ/V2M family of chips comes with General-
> >> Purpose
> >>> +  Output pins, alongside the below functions
> >>> +    - external power supply on/off sequence generation
> >>> +    - on/off signal generation for the LPDDR4 core power supply
> (LPVDD)
> >>> +    - key input signals processing
> >>> +  This node uses syscon to map the register used to control the GPIO=
s
> >>> +  (the register map is retrieved from the parent dt-node), and the
> node
> >> should
> >>> +  be represented as a sub node of a "syscon", "simple-mfd" node.
> >>> +
> >>> +maintainers:
> >>> +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - renesas,r9a09g011-pwc-gpio # RZ/V2M
> >>> +          - renesas,r9a09g055-pwc-gpio # RZ/V2MA
> >>> +      - const: renesas,rzv2m-pwc-gpio
> >>> +
> >>> +  offset:
> >>
> >> Too generic of a name. We want any given property name (globally) to
> >> have 1 type. With the below comment, this should be replaced with 'reg=
'
> >> instead if you have child nodes.
> >
> > My understanding is that syscon subnodes normally use this name for
> exactly
> > the same purpose, for example:
> >
> >
> > What am I missing?
>=20
> These are generic drivers, so they need offset as they do not match any
> specific programming model. You are not making a generic device. Address
> offsets are not suitable in most cases for DTS. There are of course
> exceptions so you can present reasons why this one is exception.

Thanks for the explanation

> >
> >>
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    description: |
> >>> +      Offset in the register map for controlling the GPIOs (in
> bytes).
> >>> +
> >>> +  regmap:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>> +    description: Phandle to the register map node.
> >>
> >> Looks like GPIO is a sub-function of some other block. Define the
> >> binding for that entire block.
> >
> > That's defined in patch 3 from this series.
> > I have sent it as patch 3 because that document references:
> > * /schemas/gpio/renesas,rzv2m-pwc-gpio.yaml
> > * /schemas/power/reset/renesas,rzv2m-pwc-poweroff.yaml
> > Which are defined in this patch and in patch 2 in the series.
> >
> > Do you want me to move patch 3 to patch 1 in v2?
>=20
> We do not want regmap, but proper definition of entire hardware.

Will do. I'll drop regmap.

>=20
> >
> >> GPIO can be either either a function of
> >> that node (just add GPIO provider properties) or you can have GPIO
> child
> >> nodes. Depends on what the entire block looks like to decide. Do you
> >> have multiple instances of the GPIO block would be one reason to have
> >> child nodes.
> >
> > From a pure HW point of view, this GPIO block is contained inside the
> PWC block
> > (as PWC is basically a MFD device), and it only deals with 2 General-
> Purpose
> > Output pins, both controlled by 1 (and the same) register, therefore th=
e
> GPIO
> > block is only 1 child.
> >
> > If possible, I would like to keep the functionality offered by the sub-
> blocks of
> > PWC contained in separated drivers and DT nodes (either non-child nodes
> or child
> > nodes).
>=20
> Driver do not matter for bindings. We talk about regmap field which - as
> you explained above - is not needed.

Okay, I'll rework, and I'll send v2.

Thanks,
Fab

>=20
>=20
> >
> > My understanding is that simple-mfd will automatically probe the
> children of the
> > simple-mfd node, and also hierarchically it makes sense to me to have
> the DT nodes
> > of the PWC sub-blocks as children of the "syscon", "simple-mfd" node. I
> have found
> > other instances of this same architecture in the kernel already (plenty
> from NXP/Freescale),
> > for example:
>=20
> I don't understand. You do not have here simple-mfd and it still does
> not explain Rob's comment and regmap.
>=20
> >
> > etc...
> >
> > Something like the below could also work, but I don't think it would
> represent the
> > HW accurately:
> > pwc: pwc@a3700000 {
> > 	compatible =3D "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc",
> > 		     "syscon", "simple-mfd";
> > 	reg =3D <0 0xa3700000 0 0x800>;
> > };
> >
> > pwc-gpio {
> > 	compatible =3D "renesas,r9a09g011-pwc-gpio",
> > 		     "renesas,rzv2m-pwc-gpio";
> > 	regmap =3D <&pwc>;
> > 	gpio-controller;
> > 	#gpio-cells =3D <2>;
> > };
> >
> > pwc-poweroff {
> > 	compatible =3D "renesas,r9a09g011-pwc-poweroff",
> > 		     "renesas,rzv2m-pwc-poweroff";
> > 	regmap =3D <&pwc>;
> > };
> >
> >
> > I think the below describes things better:
> > pwc: pwc@a3700000 {
> > 	compatible =3D "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc",
> > 		     "syscon", "simple-mfd";
> > 	reg =3D <0 0xa3700000 0 0x800>;
> >
> > 	gpio {
> > 		compatible =3D "renesas,r9a09g011-pwc-gpio",
> > 			     "renesas,rzv2m-pwc-gpio";
> > 		regmap =3D <&pwc>;
>=20
> You speak about two different things. So again - drop regmap. You do not
> need it.
>=20
> > 		offset =3D <0x80>;
> > 		gpio-controller;
> > 		#gpio-cells =3D <2>;
> > 	};
> >
> > 	poweroff {
> > 		compatible =3D "renesas,r9a09g011-pwc-poweroff",
> > 			     "renesas,rzv2m-pwc-poweroff";
> > 		regmap =3D <&pwc>;
>=20
> Drop regmap.
>=20
> > 	};
> > };
> >
>=20
> Best regards,
> Krzysztof

