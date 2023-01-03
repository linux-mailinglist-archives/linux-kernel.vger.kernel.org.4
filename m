Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F865C3E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbjACQ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjACQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:29:22 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F394;
        Tue,  3 Jan 2023 08:29:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JooFwg17YJClex2ydVlgebOqESuN7EKc/94fSQJuepJbT26qcka/s/Iq0+daHPZu8kHwCeGD9hKYf0vsySMJMwZNO+fip5PKlfrp9ujzoncMexMk4j++LVydhxp2vNaOAEei1ZbxwuzJRaysrqlW9q78VJY9hzbuU2xeuRoA74dglvvXBk6DI8GEZ2zs5Z34qR84CLzmseZyS+We12wKXmxhwnJK4r9balOWN9K4AxTw71uqtBRyu16w6dtG/j0npiE5nqCWK3CjlLt9emNzBPo8I+RGR7EL4nqExlixbnyGG6aUBFyUh5aQD7icwtQjM6vJEeBkNGic0MAT7uiPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMbT8BH/+LL8YPC2xW0Kbv42poqoNe7Bk+j8AKs55s8=;
 b=ABZxvLp/m7NqqFUXURt36xyXPQ2rCDIHnbqhvlaW23huG2DaWjK2kwD9NaC+MRDsadojQZXlNdgwRpKGsMazD3f53J1Toc9FpsmFVloBBKGRGLVy8bqBCv6/3kOyVJZgIdHEupd01MbauQXNd5RjYat3csUsv+7vhAgUjdIov5ESnPmBllefwnhp8UJmAF/1bnwzTilZEK+Rdx3sDRbMWenc4WXrZTSJzmE5mdYOUv72cCM28RmFo6FHIsTFzEZ4lee7NtjwLimveeXcbp71OfChlSAt1LA7+4Fog66sOyyUcuDBnT61m5yy/j8JRA2TO6uDAboSS+vE8BkUIMeirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMbT8BH/+LL8YPC2xW0Kbv42poqoNe7Bk+j8AKs55s8=;
 b=dnsTpSF3uPp5+w6bn9TwEJvjalSuCq2jYdDyByTA2ozl0Yc3Wb4YDKKkJOtrQ0qouUlU/Uw/qGt0/ng2CzCcuAZ5Ebh/NN7ujKyWIzcRd4V0Kwc2dK6he+6lznFGXvEUiBu8KyW/HxedAOLOgAEZpf7n92ZEhC88PBQwgWxj4cQ=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OS3PR01MB8602.jpnprd01.prod.outlook.com (2603:1096:604:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 16:29:18 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 16:29:18 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
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
Subject: RE: [PATCH v2 1/4] dt-bindings: mfd: Add RZ/V2M PWC
Thread-Topic: [PATCH v2 1/4] dt-bindings: mfd: Add RZ/V2M PWC
Thread-Index: AQHZFYCKWr09zSoo0UegvxITN4qezq6Mb/GAgAB861A=
Date:   Tue, 3 Jan 2023 16:29:18 +0000
Message-ID: <TYWPR01MB8775175AE5F25D12A22AD8C0C2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-2-fabrizio.castro.jz@renesas.com>
 <CAMuHMdW=+0JU5-d6tSKPsvO7ZxWQzNVf0LvSTfimYoBgg4RrHg@mail.gmail.com>
In-Reply-To: <CAMuHMdW=+0JU5-d6tSKPsvO7ZxWQzNVf0LvSTfimYoBgg4RrHg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OS3PR01MB8602:EE_
x-ms-office365-filtering-correlation-id: 8d3f5853-9845-467f-42af-08daeda7a999
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 28M8k5XQktKWZD816hEDidiNh4ZIMuVAaB2pcc85NONnk93TThV4d7ho24rCp8B+/y0ovZY3cQoNPk8O41pHBqDdrNnfzmQg83/1qmlvH91rxwXewFcQtcYtu6V1d8u38517xB8C905AAxYRV/kADM6GrBe+ow78bMzvH7KbMUz5CUDaUOjMG8mY6GQxANphP9IToRt3kjcT8Rzb87cYZs4ajxPI+ppdIa+QqlS4EgWG3unNOlFKwqBq+VvvUqyN1BURGIyzLJM/K7imqaLam/9uxBryjfHxefTG57SAw7S95illm4wOzRw5e8u/N7afGXZRajSwqxvie34YUQlCCNVSuUgZILUSOSz0Z3eRejLvYgYtjNoVnZXeoeXJaxczVJCdN25Hv8c1ykxmjEst8D8rpmu/4qygcwRRJJYq3ySZfrBCWQ9ryR+VaySDRoMgr7IrTxDfhJDOpTyzMMrZkB74OtwgUQUsrptVTeYgq88ev8/i+thDBeSQngWQaL2ZAQuvJJ/N0AQbV6d/sshhV/MDNZujZy+7doKqkAIxtVHn3W2YWE+ElootZi4VaAnA11a0huZudwpQWPasw1uHHgIFHx754Y6/UrKSfk5kWg7caTbmfbLHTigsMpWnx2iOIYr5cBN3rlPv/0Grw7Zgpc9qSVMyfMmOTAi4a5+XwGdxmdkPJ7UE5jNF29CXrp4cqOBQRSxBD1NwWuvCTGJGznU0khILS1yZ1rV+fqwvjC0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(7416002)(55016003)(316002)(26005)(9686003)(71200400001)(38070700005)(478600001)(33656002)(186003)(7696005)(86362001)(6506007)(54906003)(53546011)(5660300002)(6916009)(2906002)(52536014)(41300700001)(8936002)(83380400001)(38100700002)(122000001)(8676002)(4326008)(66476007)(76116006)(66946007)(64756008)(66556008)(66446008)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zeHBZRzuTBrmnuylQSfHh5+1HU3pW++S6BXFH1p5EE9/8OSjlULmtcX9gj7o?=
 =?us-ascii?Q?eVPFxeNK8EDFT+u6kAe/KHfcsaV84DHUWPs7wQVAVSNMhZi6tf5Xu7C0rZqY?=
 =?us-ascii?Q?z65l+Y9CMMRGS5tMZwNvNpf71ddO7H3LLGDsJm7P8Y27TJgIhMUbRirqSeXi?=
 =?us-ascii?Q?3fjbev64nnyalHAHommhNmHuf+pqu9hZmeQhBoLwLB986mlLjai+YwnmQwZD?=
 =?us-ascii?Q?eLHJiKnA0DU7tp6AYt3c8CBCbYr70NtGOJnq5XmfFT6E14eH76PSrJ9O6sz1?=
 =?us-ascii?Q?wsQJCxdf42uYAqjaRwMN7dJxR9tPxek1KguK3fDR8My0qvYbf0dYKI0tPnmS?=
 =?us-ascii?Q?R0mqVLWlj2am767bv9EdgQAAwaYkKda16tzmp60o2mj40qFMX/sKlIEsEAf6?=
 =?us-ascii?Q?pMSZymmHDXZywSH3OiWkVDMTcNL64dkptW4/R6Ce0P8VZe+/r1iRw/o/WMF1?=
 =?us-ascii?Q?MmXeDeDlFP+styFRjA9oc7qoL565qt8cMbxDVySLgE2LZcU2WVKoqHhIbI30?=
 =?us-ascii?Q?OtK0yX8kbLkX+rMIuabcJNMXbMvPEc5N2QYLOh3x/LVs/nRHMqSnhhzfz+MV?=
 =?us-ascii?Q?PeQkXq5ErGURz8238TwyKv34JlvWGU70Kr7FU9UAvKKOFAo5vM9pUgjxj/N/?=
 =?us-ascii?Q?d1A/UUv97obuJcJjGZP6FKiMlySYgsjiK+7IAUL1V3Af1rPvL8V6f7b3Ony1?=
 =?us-ascii?Q?OxJ1pvb1hx0lnoBaNw1JF/u8He78BHc9rPm/wZG0oGP/JEDs9kDvK+vnLRH8?=
 =?us-ascii?Q?nWI/7b/6ASrUl+BcJ1m4VWzBAg25oQORrOOJ66ISgwd+VCf4L9C65eeoPOJo?=
 =?us-ascii?Q?W+eJ8I1KNczcKKQQzAFRYGFD77rJyuaeDGTzSXMtKKha2EkWLz3lFzFGKhMe?=
 =?us-ascii?Q?83hCbVTG/cDspGdAtogEJovaZsUrh8PeUTa8QIhnKQGTEO/rAT+Ees0ZRE+Y?=
 =?us-ascii?Q?nqjcYy4w2r1uLHr4uMFCATdnLU+WXChJGi7DjtKchS5iU/fVgFa/YOd5+Xw7?=
 =?us-ascii?Q?mpjwXitYX2DBNdEmk8buVhXu5JBZeVirzzStkfJNAmNLFS/W8NRCts8m5l7p?=
 =?us-ascii?Q?HZ3qun118wOog9pl8tTBi107DADw+76ppcyZuQkGKqLWhrPUynLwl99MM7Ig?=
 =?us-ascii?Q?wsEEA2pC0rzlBUucweVBn42nmrTR20/HZVnUHNptkJAOyOmBqZzueS+chOu5?=
 =?us-ascii?Q?9iIkNIdIaYPJVt1bHsXAGEpIQopeiNUikhbDfZDkcANzoWpfxl+/j15WgY8s?=
 =?us-ascii?Q?E6XU85ul6+h2ZYlGG/WaAf/i81G0HPzmeu7EcCV+UtiuWRK+X9ASImwux02U?=
 =?us-ascii?Q?0v9lo2sR15Y0C6kC7R6t65PiINwtqDH8X1jOXTSEDNeTBTBamJVfblEvPGVV?=
 =?us-ascii?Q?t4uRpG7qcXelRtgwWuyEWK8NYtt+0Q2Ra7brTc4/BiM/OWBzpSEl0/DfVRt7?=
 =?us-ascii?Q?5hzTBT4tK3xZp2Fp2EnDBV4MBmYy6NT77LNFyKdxgvZUCMUemF+AJVemn9tq?=
 =?us-ascii?Q?99nefOdqO0BXBBYt16pz6PrDqb8Bt5dwFGbPxcREC+5CbrjEZtH9JNa40B/5?=
 =?us-ascii?Q?yYkjGkqLzh3fGoOLmGgETaLKaULCxxx+ehKoaWHM9++9TD1UfulwjHEp0TFv?=
 =?us-ascii?Q?Ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3f5853-9845-467f-42af-08daeda7a999
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 16:29:18.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1l8AsX1NODGe7ovEkcp3CtODNy1XX2DXRufyZ8znJ4B1O4Ny1x0ZQ3haFEyvm9SweG+NU71gDVSQ7SIBNj3zqfFx/Fkv1noZcho6nI2Gow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your feedback!

> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Sent: 03 January 2023 08:29
> Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: Add RZ/V2M PWC
>=20
> Hi Fabrizio,
>=20
> On Wed, Dec 21, 2022 at 10:09 PM Fabrizio Castro
> <fabrizio.castro.jz@renesas.com> wrote:
> > The Renesas RZ/V2M External Power Sequence Controller (PWC)
> > IP is a multi-function device, and it's capable of:
> > * external power supply on/off sequence generation
> > * on/off signal generation for the LPDDR4 core power supply (LPVDD)
> > * key input signals processing
> > * general-purpose output pins
> >
> > Add the corresponding dt-bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >
> > v1->v2: I have dropped syscon, simple-mfd, regmap, offset, and the chil=
d
> nodes.
>=20
> Thanks for the update!
>=20
> > +  renesas,rzv2m-pwc-power:
> > +    description: The PWC is used to control the system power supplies.
> > +    type: boolean
>=20
> I'm wondering if there is some other way to represent this, e.g.
> using DT topology? Some regulator relation?

Not that I can think of. With respect to power, this IP only generates
control (enable) signals for external regulators, it does not supply
power.

Thanks,
Fab

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-
> m68k.org
>=20
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                 -- Linus Torvalds
