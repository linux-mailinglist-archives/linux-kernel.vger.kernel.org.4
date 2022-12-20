Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F73365283B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiLTVJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:09:34 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2116.outbound.protection.outlook.com [40.107.113.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11991E3F3;
        Tue, 20 Dec 2022 13:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgpwRHo/azanQagh/LYIMyphlSNXfg31nag+M0zKULfU9LDYfw+38LmsJQqJEuRALQXdoXAesyw/FzPlc6PySUARw0lKKVB4MO36g+NqtQTIeCBVHEZsKT3He+NPyh4bZQjGHBxU6pZcZO76Z8lly65O6cbbhyfdF4tooupyzF1/QRYGztyBXFqxaKRuCQ6fAwa2NkKZu0WnZrm6IqIgV6j4hrubSkWAJ81YWVdC6PGqNMIm2SRnBbCCiaWGu/sxW56ozKDmG69egFZF7O++JevDvNKo5jCwjFVFw9MVLs5FtulsbmskW58lzi6nfv75U7bmpHb1b6bDzh1Ilz+jBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trDK9wtCuqPx3ibYkdEErNEnSpZ2bDWOuptS1YxUp6c=;
 b=EaRrfqtgJsZQaVxuFHhCc0+aHQuFy8ObyuHLeBgvO2vDOR4ezlCUZQ6eyDE6YcJiG4nEYxKi0YfK/tnHFvEwUIqLgtB/JabrROCw2EqRAz9UsfEwQddcrAzRwPEa+TRtbcmB3e6ilKPt8bH2fKnJg0SPom1FappvNcD4q1UBRajCnndHzXn0VfM87kSyEtfjxQtxKAJkXJFgK27uc+xFwIRZMmYFbrhCs6K45v0Me8Ef9xRyBCpInvuBzQK46j82lTHszzS+e47JujVUclNSe+zIoqAPDfU/50S+NBw/2xPkhZCLomzRRGjTsz5vATc+QuouD+/EsT1EpK44i1tUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trDK9wtCuqPx3ibYkdEErNEnSpZ2bDWOuptS1YxUp6c=;
 b=bQa9jBrZ4H3K27YbPRzWCBtOApsZTnQvfgo3neoKbyu5iIxqaAflKKugTd4SHS4e6fyCKBwqiy6V+SQZBBNE1EXQDCiYV/R0+Jt83uGzYcrNJTn+95J4gUSEHt85ON/h08t3QCBdLDz88sEJrD1upC0ZCO9u+P1SBCBsSD3+qzQ=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OS3PR01MB10315.jpnprd01.prod.outlook.com (2603:1096:604:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 21:09:29 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 21:09:29 +0000
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
Subject: RE: [PATCH 3/5] dt-bindings: mfd: Add RZ/V2M PWC global registers
 bindings
Thread-Topic: [PATCH 3/5] dt-bindings: mfd: Add RZ/V2M PWC global registers
 bindings
Thread-Index: AQHZD0RWUdljgAcvZkylOB1He+HHvK5tkDWAgAm+C+A=
Date:   Tue, 20 Dec 2022 21:09:29 +0000
Message-ID: <TYWPR01MB877555D5335FF3D743E54F7AC2EA9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
 <20221213224310.543243-4-fabrizio.castro.jz@renesas.com>
 <20221214161607.GA1154595-robh@kernel.org>
In-Reply-To: <20221214161607.GA1154595-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OS3PR01MB10315:EE_
x-ms-office365-filtering-correlation-id: 911cb8c6-cb0b-40ef-35ec-08dae2ce7baa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +gNTa6xwxFQqwj9mbaL1WcJGKq001/1tQCJlu7YZsEW1pmavww0pKGtwOmN6dUw1hQstyRsUoMZkl3+Cup1Xmi9kXTwdueWsbK2pqqoJSQQEUNRrc2sX5s6HPIiM+d22TsfGBjn6U5lTuZIiOQG3sVymVsWuwUci0NuXZZiiax+5A5FCKbm3C9D4fx69wVpODQLMrlJMZ3smrsZS/6gdyCzyG2nPkMdCnl9pdZrV5mtJpXAkGAmzC9BUM7J6/73j/rL6pTeKJC6ItNX+djs2UTQ/FtR2Acrz4LBbHYqzxFPVqkP6UkSx66QcvSzD82RznRKG7/weK9UqMDnGVVfH0KLqCJvY7ojfV7XcD5UQW+2Mw/fhf4qbwa+Zkvk48AAYktyNAFObaVl6bsUFUdAtrrqOFMJDfwlGfgrEzIAEEXbpphBsT552zc4feeO0Ok5xVATpFsKvRUn27puwTV5UzTcXHGy5eMFEGlG62hqFRRgdvM+O8wzLCEgtC/+RSbx+Za+P4XxS1XfoZbOQ//jWvYSLWYCzP+m7qNicnfWSTnOW9GIImx17Frl78VpZdUtJuM9eIzEcMlVtXhrVNFBGOnGQHd8dNeLUUgTA2ocLKJshp/z4F9VRP0i/T0QRZcYWvt3dHQorrCf6qs1CkaF64rYWNkygwwr8AePqL9Jx7AZkmky/3wmWh9IjNFTCmoaOLddgjiwxJhUxbU/eVJ1FwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(2906002)(122000001)(52536014)(38100700002)(5660300002)(7416002)(38070700005)(8936002)(41300700001)(316002)(71200400001)(6916009)(66476007)(66446008)(64756008)(8676002)(66946007)(4326008)(33656002)(478600001)(76116006)(66556008)(26005)(86362001)(186003)(53546011)(54906003)(7696005)(6506007)(9686003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zixgI4gzxwiPcyKt7XJnE3z2//yZI7BpgnRh01BBSgDFUKcN6DSQAV/Ulh16?=
 =?us-ascii?Q?waKWXZ7he1jZt51FxclU5hN+DHZ9Znwphl4gxYMaP6xSOL7z4rFOkaPe9oEb?=
 =?us-ascii?Q?SVe9o7sFX+NZ0YcqZVx2V7ceTxWrdTRUiUn6IT3qFQR/aB3kHYiKfvB53JWb?=
 =?us-ascii?Q?b4cysknzKlw7mL28o7vIvdi1WNRJagnuaa7rvbivzbREDwd8cqNdPZ2eOR6n?=
 =?us-ascii?Q?QW7GHvHHKV72nxstv3e6D1IV3aJW5Zb7bIJ3QQmxN0uksQppj3e5HmyywNBU?=
 =?us-ascii?Q?RCAVZS85Fzc0ur4vk6TJkhHIb4UlONeZxClqSlo9CZDjNVcvZCVGN1JcQtDd?=
 =?us-ascii?Q?T+YD6dx12mxOQQGd051xspAwJrIVNgnYodCgy2Ep1DTnVUkYLfzksP1x4YN5?=
 =?us-ascii?Q?Og2rFMtMC5JkWwWdvwVrsdVdPUk/r1o9qarMayBEfxQh25dng76pYEjb9VfQ?=
 =?us-ascii?Q?0VaNo6nP2gVDSLLbR/tP6l819YKfE2b7IsJTa2lKbtXOWbzVHTDnzkpFmKzr?=
 =?us-ascii?Q?kGEojYY2gwGNJMpFkOwkFZNTg5s1FpO+cEFTukDWPAQtnmUN+oz+PnASrOdE?=
 =?us-ascii?Q?2a2lRpwHu9inTO3q8tzTW3IigJto7+wQV3RNosgIgGoJCk1wJVccQJOUX53P?=
 =?us-ascii?Q?GyD418sllQYIHfK7Jbz3XbOM96pc2fxMMUB/IYnt5yNXVRiQ9I/2mYRJuX2P?=
 =?us-ascii?Q?fHl/P0TrQZvrgumSh4qPDKPUsQn7c9MVKeo63q5eRoBXk3klkCpGQH7NK49w?=
 =?us-ascii?Q?emn9qg3WchGD63nZvFDH/OYb+yo3uWG3acOKZXhLU3DrVoXwPF+PvnozOliP?=
 =?us-ascii?Q?P/04mN7sN2Ciqr6rtA13BjZ+1Pq0/LEjSx138MlEAhNQmg5vTB5w8keYm0Vq?=
 =?us-ascii?Q?eC9S8e2/MVFraznCawdQ/8uz6EebZUr6cJ/FsWRdrXkIRTJXBh4lAaVVyMk3?=
 =?us-ascii?Q?7j0+92+ZUmVHmOZPi1dm5LVvz3qUhh38oTMAfQX4aCLLjdltroEFk0/DqM0f?=
 =?us-ascii?Q?aaBhFsZPBiu4r/DofJ/x2vundmAwGrIE8w3I5aad5WDfF7iFZ1uQcrD9L4zG?=
 =?us-ascii?Q?PM0PZfaLrpk0QreQKsdOSqM2lkhuRaVeT26v69yuKLtTj54zosf34AnxSknF?=
 =?us-ascii?Q?gZ6qhfI3GLrVuH2cGVFrP6jarArsT4aHIwL/eL0M5MrHayvcNNxq+fXHBtgp?=
 =?us-ascii?Q?ovltEg/XZURSQE/sOUzFWevO5U+kaxu4xJ44H4qObW/PiS5BYozB4GhLhSds?=
 =?us-ascii?Q?oZ8CizKUXBn1R5Elk7DwwhP17OJMiPZXh+X67Y5H7VxGaua44gDodsvi2Kee?=
 =?us-ascii?Q?KBI8RsMtKTV/63bd7VWjY9akPHQcyLWyXp5XTsK1kkCc+pzCHlSvbGQbgpcs?=
 =?us-ascii?Q?cWLMy+tHNY/1OiHxGIbqvRzfs1ZvSv6S5V9G2i1BmrpQo8JMVkKP67ZcjGqM?=
 =?us-ascii?Q?NqLMnnzgdZqNze1l6jB3JROwplkAzvDfJ/PlH2fB/VNXPiYhJGy6GbmG2glv?=
 =?us-ascii?Q?WT/98rtgLqAYZDQCYs8/tMA2XKwBsPhoBXtblxF8Spzw+dW4so2/LsAh5grd?=
 =?us-ascii?Q?MLzryuZzFkdXBrkaBcwYzOP8WN1jKTfPTLUlXL8CXGTwuUzrEDIFBdgeSYXk?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911cb8c6-cb0b-40ef-35ec-08dae2ce7baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 21:09:29.1770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wz/jshU9WouJIY6yduBgwe70CevRlriYfpKw2m1BX5UydV+F51fcEzYdCB3bdyCcwVDNZdYhmKxwIfslL415uxYvNURMGqUR5HDmw62iHuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10315
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

Thanks for the feeback.

> From: Rob Herring <robh@kernel.org>
> Sent: 14 December 2022 16:16
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: Re: [PATCH 3/5] dt-bindings: mfd: Add RZ/V2M PWC global register=
s
> bindings
>=20
> On Tue, Dec 13, 2022 at 10:43:08PM +0000, Fabrizio Castro wrote:
> > The RZ/V2M PWC is a multi-function device, and its software
> > support relies on "syscon" and "simple-mfd".
> > Add the dt-bindings for the top level device tree node.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >  .../bindings/mfd/renesas,rzv2m-pwc.yaml       | 70 +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzv2m=
-
> pwc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzv2m-
> pwc.yaml b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
> > new file mode 100644
> > index 000000000000..a7e180bfbd83
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +title: Renesas RZ/V2M External Power Sequence Controller (PWC)
> > +
> > +description: |+
> > +  The PWC IP found in the RZ/V2M family of chips comes with the below
> > +  capabilities
> > +    - external power supply on/off sequence generation
> > +    - on/off signal generation for the LPDDR4 core power supply (LPVDD=
)
> > +    - key input signals processing
> > +    - general-purpose output pins
> > +
> > +maintainers:
> > +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a09g011-pwc # RZ/V2M
> > +          - renesas,r9a09g055-pwc # RZ/V2MA
> > +      - const: renesas,rzv2m-pwc
> > +      - const: syscon
> > +      - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  gpio:
> > +    type: object
> > +    $ref: /schemas/gpio/renesas,rzv2m-pwc-gpio.yaml#
> > +    description: General-Purpose Output pins controller.
> > +
> > +  poweroff:
> > +    type: object
> > +    $ref: /schemas/power/reset/renesas,rzv2m-pwc-poweroff.yaml#
> > +    description: Power OFF controller.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwc: pwc@a3700000 {
> > +            compatible =3D "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc=
",
> "syscon",
> > +                         "simple-mfd";
> > +            reg =3D <0xa3700000 0x800>;
> > +
> > +            gpio {
> > +                    compatible =3D "renesas,r9a09g011-pwc-gpio",
> > +                                 "renesas,rzv2m-pwc-gpio";
> > +                    regmap =3D <&pwc>;
> > +                    offset =3D <0x80>;
> > +                    gpio-controller;
> > +                    #gpio-cells =3D <2>;
> > +            };
> > +
> > +            poweroff {
> > +                    compatible =3D "renesas,r9a09g011-pwc-poweroff",
> > +                                 "renesas,rzv2m-pwc-poweroff";
> > +                    regmap =3D <&pwc>;
>=20
> Why does this need to be a child node? There aren't any resources for
> it. 'regmap' is just the parent node.
>=20
> Assuming this binding is complete, I don't think you need any child
> nodes. A single node can have multiple providers.

Alright, then I'll just put everything the device needs into a single
node. I'll send v2 based on the below snippet:

    pwc@a3700000 {
      compatible =3D "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc";
      reg =3D <0xa3700000 0x800>;
      gpio-controller;
      #gpio-cells =3D <2>;
      renesas,rzv2m-pwc-power;
    };

Thanks,
Fab

>=20
> Rob
