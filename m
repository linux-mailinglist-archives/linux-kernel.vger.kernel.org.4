Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4C652845
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiLTVPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiLTVP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:15:28 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2134.outbound.protection.outlook.com [40.107.113.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC101DF1D;
        Tue, 20 Dec 2022 13:15:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6e82dgEfY6Djx2OPV9mgKdjkZRQMWC/svASBDBHpDCyOmL8Un2O0kpTeGV3BK5fIsVMQmioLZvyvduG2rzb8sPzx++xYW35UCv485vjjJKXKvrSiQzxqPP7dUwOE86ZezsrY2Mkjal1IP/kaS+sm8x3hnUy86bhG4mQDoS2wdzCPApRM0dlhpI3bJBXoi2y7xHk3TMkNIvoOC9LV4+HbBGyEfguFEHh9B8Uer2RjmT9/srPUinA0PsLH+Vu51C1wOrRlp0ryVpFAFc3wtBUmxckMMHnQXKOBDk2wWsaCDSvKx4rjPdQhQy+mPloF5Ls8Zlh+AoF9b7DXNBeeYqwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiMVvi/6S08SF+q3hXBhJgnA23TUqWjNAIUweQnYpBM=;
 b=ck5l5f8RQdWOPXG/ToQLkrgIg502hZrAzU2q7NSukXG6YFsOLN26ES3EHYlpMblEtV0k1vC/FnkSL819wFlplfvItd6l1yx5T/gAdMeqKUEeqoHSVAb8NNvU56tkSG21cwybsIsf3KDw3TuNLT1xQPXohaUa8FagNf2EP6Gsisdf/r5/U9XwmJb0yLYWyeBOlx17Bp4hAlMDvPCRXlZZFpJelr5L941asauiBUVe7sAoDuXHv/yLgwMY9sNgdyTeOr57yAiMYY6c2TFR40B100eubuZxazvxgOSYlspivRJJOxmWFtOUaFoJcM12xqymgsbFZz2MQVmuoX3rI8bbCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiMVvi/6S08SF+q3hXBhJgnA23TUqWjNAIUweQnYpBM=;
 b=B2qQl+bgN/z+IU49t+aom2UTiuKph367fMEiQw0Py01uMIAaP6N62+KxjYhmzjgdK0yYCTxIwf+ZeII+IGEAQyOkfe6I4KsIjwskCB5sFh56frT8B/+IUi/YJWvSaQx8rVRkWDoMvqxrooGjKXnVylIaxYJfZILMhXS89/eEeGg=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OS3PR01MB10315.jpnprd01.prod.outlook.com (2603:1096:604:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 21:15:24 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 21:15:24 +0000
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
Thread-Index: AQHZD0RQEfhgdoTwoUKXW2j4jjmej65tjsOAgAnBcmA=
Date:   Tue, 20 Dec 2022 21:15:24 +0000
Message-ID: <TYWPR01MB8775CA5B922E9C0298A80C72C2EA9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OS3PR01MB10315:EE_
x-ms-office365-filtering-correlation-id: c62b23ec-99d5-4b77-c1b0-08dae2cf4f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0actCFqyaoTtRICwbOsx5iGSWanTAS9fQunmv6dyvighv0H4ukBaQYYw4B2FzgZsftsyKYTBM83JSZsqjeYWR2QOZobM/pk5QYA9TYlC6pV3GRyd6X9Ey6hs/0EM+9JN50MzxzqRlH49caL+qcRFVdPH0W8Mx8kKGThoIc4SXrcHeSUACpVDWvsF0GKyBe48RbLzyuuwI4UMOk+MPtGKAOfGwbCU0mYwba+gxxDPEQu3cbaTOq6dUUNWCDlLMBMnJhwmsjotYv4qvJNgcAlwWXi04gkk5mFBueybOl6ZEbX4HFB1CPS64bSSJujWSYOy2Kc5VZuys7cksRgkIWfOeUDWPhqcaIRdylVseLkzot4BRUyzCj6kLAWSowB32qJiewnRgPeY5L5U8lkFTl+5tuqXNko8CzW7f+powlv+8jOYtMh899xJcnL3XiPuo8gaOdld3rwnLT7HTe8oZzAp2wGqFkK9Uqs4eaDupyYZV4VvIHw0P1EDducidmJRblq9EengW0Hj2UER/FUMJS4Bz3mHbyIF7JwoY2Cgw0MdZkwKGOoZ+RN5L7pLjhxY/Fg75HU4WLqeGtUGrl4T/jktvc/B85/JuhiKyAafvqAZwnyJ5Gzjtb7PiTyCSE3cXUvihLjRSi4k9v119J5dvO1Ztw7+511m4NA8JwfRRk4yLQDKVOc9djuzktD66IKsAv9dVDc/ynLoHCnjfcGyHk0ZSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(64756008)(66476007)(66446008)(33656002)(66556008)(76116006)(478600001)(8676002)(4326008)(66946007)(41300700001)(316002)(6916009)(71200400001)(54906003)(9686003)(55016003)(6506007)(7696005)(86362001)(186003)(26005)(53546011)(122000001)(2906002)(38070700005)(8936002)(52536014)(83380400001)(38100700002)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uzcK7d2U5LFZnhwyMZEcvTQM6cebLfwDRDQF43sBSSFWiMVj9ZSNo+/Ob1mk?=
 =?us-ascii?Q?mNHKgMYOU1s/bZzIH3B3udY+7AWtGYS0+hwddwHCKwnUSChVHWSQYDGOWalv?=
 =?us-ascii?Q?RIEW/tRqGGR7AFxMtmd7oqTb46UOCqln0T/hGBOX2UdDMoN/tX2y49ili7BE?=
 =?us-ascii?Q?l9Sl00P2qhMyyZdtXDvtSPYFjr2U+Ho5n8PnNqO+Wire2hIVc9oXEAmXDxht?=
 =?us-ascii?Q?7e4p0DRQVXHkvkzXxr+XMXzGFTnbbWPNzb6zw90eVnPLZo77nFLz7rwFtbDM?=
 =?us-ascii?Q?VrQ+EiC0f61E/cHBgc0vlNHGel4csMuf6KNJvMP+2fSJX35ZQg4mEyCwhpRI?=
 =?us-ascii?Q?8xd0lOrs52WpnF4UJhmA47te4dG4OD/cyKHraag5BCCnxlD+vYy5a2K1RKNq?=
 =?us-ascii?Q?JMvzEboNryj7vftGwDV/lUFBw8BVi4FY0zMnPPB9+Gpvt2I4vYBHP7lElPxL?=
 =?us-ascii?Q?KN5JnawjDDv9RoV/kPUsakmCa4kdEOKH1QB3dMmTfUNgTAa55W4PigIdFqSM?=
 =?us-ascii?Q?plEjVdHe/sM/FLc4y3oP/aR26n31vO/3gBkDbyj1NMjUdsXBQ5J7UB5ZYLbL?=
 =?us-ascii?Q?DUPGtmgKVHxPbZikoW5a2vAl4udqfI9T/OuQDa/CZ7d0uTMiRzYBzH/PwZId?=
 =?us-ascii?Q?f3lkLmqvArBuMHFQNQiPZ/A7Gjts6/68sMTLbMgVYyMGaDoDPbqkoqnZM9Oz?=
 =?us-ascii?Q?NOdjTL5T0TsNnKeRRUHe3fk/irVpaVMDcYxQZFguaKkxh9dqKi96rzZN+GU0?=
 =?us-ascii?Q?k76KyvNP5dygLxaeRS4kMnCJSbsH+OFkRL5tdQht9UIGDMgZtOxOMe/MUnvN?=
 =?us-ascii?Q?gR/Cj5cvGNsdzCoYOZLMMYfVsaCb5YqPZLyeblFdxfvl+Vgk4x7f5y6EBIrP?=
 =?us-ascii?Q?UEjD4uFOrHlz93q8iQy5t9guZkMzOK5C/LWYZojCe27lbnOOMuFQfdQQS4fI?=
 =?us-ascii?Q?6WEiQj4dROfpkLwGP6T54EBQOIsJ4kcSU7fKsOGJSVXR30Q5wcipm+34fGK6?=
 =?us-ascii?Q?D3+pxl1A5sHsZhxZXfHS/JGj7Nnf0ibWLEEQH9zBh4uEAcKy8k9H0oM6e3Rc?=
 =?us-ascii?Q?Ue5u1SOGjkzoILciD+OOu0aGmwUf/HlC7aSty/yUQ7gVxGGEI6awmsYGtC3G?=
 =?us-ascii?Q?CGAdU6SouBeb1qEtMblVv9kiYRYNgtBkpgdAUZluYOfPMqhRWEQYdz8SHK2j?=
 =?us-ascii?Q?fAKNYCSEatsJEExJyUr41to5whc1PNW8CWZbWBMpy5R6BRxoopxH/EqBJkaW?=
 =?us-ascii?Q?6SzwsgImLwsaGgIwydTWzDuCEcMl7R9OE2U7PK+SopZwIMfYQ3x2p1pEStUK?=
 =?us-ascii?Q?WRhKPS7JRLIoOXfl/JRm/kQFXHxe2BuaY6/hYuga9eYtgdlwzoY76RzlBIOT?=
 =?us-ascii?Q?4p4lOoy+IEK0x7ipDgrfGoXa5jBEU1qh/YuvMBpqSQ7W5SnaLuaWhSwqvd7I?=
 =?us-ascii?Q?Ojg8j9+x0IQkxlOByem4B5wgzMukaG/6oDa5WD1yN+JygZhBgLpVgyTlq9A3?=
 =?us-ascii?Q?J5H0FINiM7KQreDw0eoaxz5h5GHCeaCNrC/wf5R1EqiJ+OHtWjJ0+wGvwQNb?=
 =?us-ascii?Q?jJ6CWROAbntrenEDr7r1IK7ekN20MnJHXbHnS8TggIeCTLNdkKFTYvqXWTEX?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62b23ec-99d5-4b77-c1b0-08dae2cf4f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 21:15:24.4628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/Qm5NxyRub/asoXRPlB7SW4j0n+t99xRDmpP6yVJY4sYiQRmvrCX0ZLMwd7hfWjHNMm6tJCCMANSs+OuOTMBxNgbYj9fxgUP0bNz7QUDLY=
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

Thanks for the feedback.

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

Right, I'll be more careful next time.

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

I'll take it out

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
> binding for that entire block. GPIO can be either either a function of
> that node (just add GPIO provider properties) or you can have GPIO child
> nodes. Depends on what the entire block looks like to decide. Do you
> have multiple instances of the GPIO block would be one reason to have
> child nodes.

I'll take out this child node.

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
