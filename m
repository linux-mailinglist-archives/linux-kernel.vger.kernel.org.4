Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6342E6ABF0E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCFMFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCFMF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:05:26 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD829E2A;
        Mon,  6 Mar 2023 04:05:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmNNc1o05KP63TIODHd1JGoNJmCWL/Hhpb1k7dTM1ei0DFoX6hpgGE009nq/qpT9YfPtNPpVgdGCyst1Uym2EzKPPezYugOae5Gsw0BgHzbCALpdalTFFjuKhSLtQkStlzo5FjwXVdqFu/XNhHCrdl/OwKXLGCeHK/77nBH4s8FIxl3UnafECbIWNkkOWJDM7Ec8sQXRhWB+3N1AR7M/ThLKX6h9pIb4coqr5IeT1uOWSluUEAWfLMWCqkLaNWE97ZJ8zux2lS86WaqTHyapQWoejZZ/6urfjB4eWEtXFNwl2M9uQhJzNwZVsUOZGN0WVmom7B2YW/OtQc/JF3DrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3Kg6Dw6vqgsyLcngHl8MvyPyJBbVDDFBGjtyfesKnQ=;
 b=G3GwzBk/W/PBLT7SN/aSB+j904UasdIQ/F6Yh1OeXWPzWNUjB7WDjSifZK8OgooTT9sxIJ/yeW3HdQUJ1ujNSHpMad72NrMLBJKbrRcp93LoWmR0X2U4/8lm06qpHlsoHYwaBIYuEE0fm/DSQFqmme+7OJ3ukdlAwuymnR4+90L05CA16f+lM5j4Gl+gBaFCl5T0kTGNS7asqbSHWsryefkLBkylVwerI4Dn9VKLSerYD83nRC57RGBR2s1ywHjG0jVcUt7VzRST2xDGX0Hl/BJFj52Jc4uuQLdMNhfIk0ExxBq8b/TRlIrt1fryxHLLF8zRzvxSTBxansrDrKh2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3Kg6Dw6vqgsyLcngHl8MvyPyJBbVDDFBGjtyfesKnQ=;
 b=EUU7Dor6U1DRJSEe2c3owmTm0FoeNf3dx3s9OSFSIkj6A4aWqDylGpFBsQInwSM9FFSI9Tu/aDt4e5m4GrH66TBCJl55Mx41mlOmN1973Rn6QXTEg7Kk5d5EhMZjD5LwjAP7EFZ5sU/8eINFWI2iz2q0/sTwaZFnvCgVGPcTzFY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9407.jpnprd01.prod.outlook.com (2603:1096:400:1a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 12:05:15 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 12:05:14 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] media: dt-bindings: media: renesas,vsp1: Document
 RZ/V2L VSPD bindings
Thread-Topic: [PATCH v4 1/2] media: dt-bindings: media: renesas,vsp1: Document
 RZ/V2L VSPD bindings
Thread-Index: AQHY/qlsiqUPLyRiZEakeAuWQTj/0q6ivSewgCKAQiCAKQz6IA==
Date:   Mon, 6 Mar 2023 12:05:14 +0000
Message-ID: <OS0PR01MB5922DFD3DB42C55B4803B5E986B69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221122193415.1873179-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB5922EED83E05EC0B6EEC245986C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59224810FCA39B4E7CCAF2A886D89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59224810FCA39B4E7CCAF2A886D89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9407:EE_
x-ms-office365-filtering-correlation-id: 87cafa6a-5536-4480-4bab-08db1e3b0b9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8BIEvD8Rf2IQAcm4bEzEova2N8Zs6zRvG4DX9raGGRs9P7cOnNjGXaT7GFjxkHN2p9G7IjPpDvaGCIGvVUXXDllpe6vL8ccd8f5gbmvwMSeGagsDjcjdsZzFBm6gC5m1u0H+gPoRHeuSYTVLrJoDSTaBPSGI6BXGyB1vr2IeNks48CsCoUuViWRanYzoKQPC9FKr8aq0Lnn86wzWDAzHbSTQOYqlgVSpPCP8rci+joR2ZWWfEoVYPoSTKhkqKikajfuZvq1HqBmK4aMLh0ip0Y+gHlpVJLWBPXe+Zid4n/Xe5r+rkbkvDrO8B/rsZapqPiAYOkhlhxjDfVlD78yrVxEPsOc6ji18FAU2jtB2R4tq2BMa5hvLkfxfczK7EZzyblS6pQbtudea20syVKexvV+4IewWDUjf0k24yQCswBIIpj/YsbF0L0VemCREbYogEJ2MIcp9IqJg6foGwGDzo00TWA3L2H+W7IsRyA/uY7BMywidfWD7IcVIClBWNpgHSr4ZXAXSAniG9BmXMv9ZA6n0HGeT2lsan/6Gb/u9asP2aosYwv2AAEft3z0S+To4AH+jl8adGKMruPAON/znZvRFulLoobwsExK0V1BdlEQlIYfVsWgz3Lf7U6UjHEomm5B4gSsg1vdGToVZHDFoK7moo4Ekml8nj1YnrOjBQa9vqKcQ2+GOT1qKqwCSd9b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199018)(9686003)(186003)(122000001)(38100700002)(38070700005)(52536014)(8936002)(66446008)(66556008)(66946007)(41300700001)(66476007)(4326008)(8676002)(2906002)(5660300002)(76116006)(71200400001)(7416002)(7696005)(478600001)(53546011)(6506007)(26005)(64756008)(966005)(316002)(110136005)(54906003)(86362001)(55016003)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mZ1vGYjOxMOcbYYqs+KLC05cbTBJSxD8eilWjWnajiBMi3wLr7iEUyyHPOyQ?=
 =?us-ascii?Q?pvOd2ancqi23MdKXzT2qPhQlLHooWEYwzvVHvsnXLmVLuAgSe4Un6rRYZN7T?=
 =?us-ascii?Q?H6A/GfWRERIY0ESec+xMw0iDLjJfV+Qzz69fpsmsShILD62kxoh0omGiNddF?=
 =?us-ascii?Q?m09BkFw2OjcUPjrs6AFZGvXtSbtJ8ewoRAFiYvApEEKGwa+tKuhvSLLGGQAI?=
 =?us-ascii?Q?W6QYj7DNS1PSUdGoPt+8/TmaYfj98YoQBO9myEUmR6iw5nqU/TDyFjYMn4Zm?=
 =?us-ascii?Q?7iLx2aVI5I1otnoDJwVbtD3TdIxsgcURDY/HnvSocN1ya1HXwgXCgZYIhwrh?=
 =?us-ascii?Q?QWbNkghEP0zPzQRQdwt14UhOGNzlHxi1klekVuoAES9nNjIN5SBtvPZXMr75?=
 =?us-ascii?Q?TfMg3fMliJGQpdSANMpsf+SZ24uhC1z2eTKxmh3+0TA4axZWZYPX+SATwqjM?=
 =?us-ascii?Q?8HiLagypqozPbShOjLckafBAMRLS7I4uoRHkPCI2R2ZWMK1yO1KtCBtaNK2t?=
 =?us-ascii?Q?SC8lzPVVPYHTREpU5/gwfxhsqBdkyVwxdplS56R1Zf23yIPGM7apXImHGJoM?=
 =?us-ascii?Q?yL1qbHZ5C0ebcklOhu/RJbfn80sBlLyXsWVgEus1YgpXjthlO7Nc/vbp+LHZ?=
 =?us-ascii?Q?5atMOXWfQl0zZUKH5QBt4TBg1fzenmz/NpRUFt1Lyt3U6ZBYphTDKn8WhRBD?=
 =?us-ascii?Q?yifKCMzOFTcO4QADRZhPi4WRRoJCFR2i+PmwHoSRxvP7xoYxsnpoL38xWN6L?=
 =?us-ascii?Q?LFMC4skvGMvAwcXr4CTnM7Gq6ONpYTgqbIJcX1CENc9020LhaHH7RFFBcAUu?=
 =?us-ascii?Q?3JcfklrMjH9/a0RZbPlu/vgvE0vCKRLFTZGARSgKrtcEe6q22oMmiRGtOudV?=
 =?us-ascii?Q?N2S9jIBKWgwzyg1AVX7MwJWfMfT9pKU+HXZ/3IiXCNKHZZZL1ZFvrfTJPpOU?=
 =?us-ascii?Q?QewFukIIFUZ2PxHWww/Lw91F6uV8SVNYy0LxBxryVKZbn3IW2B5oXtTGcm62?=
 =?us-ascii?Q?uMjsTqFMn9wrIU/JzNoBoO1N0Tn9ZURKvqdpnFyVE0meft1vDfV20tWyAaUO?=
 =?us-ascii?Q?fFaRDEbAJcYaCYekiqFvmBNcfed5cfNDBpZSaXA7Pgj5lrSTFYBnCWNEtcDO?=
 =?us-ascii?Q?pzTxV5dUSnywIPpSCqKVP+SRabTD1GrCqcP0XdHt6QEk/zVrUFQ5lcNJUBYg?=
 =?us-ascii?Q?x0+tUxWpV8hMkwzJ31cQNT9pffu4who1oYn+fa+SZI7HRzWQ6bNRn7Pa28xF?=
 =?us-ascii?Q?BJ9GhWJ2qajy8M7GQHZoEUEOxjaGmFY98kLjGIb+fhbWAyLg39jDqIljoqii?=
 =?us-ascii?Q?RHl6oLiC2mIICOo3eheXDZyTGbvWmQooZ5RmkLMJkAKnE7U3OW7b/g9wJGGp?=
 =?us-ascii?Q?ohZIgtcVztgw3F0GPFXnc3dTRN1FhWyfoSKXwF7FShgO1ESyIcT3myzYGdmt?=
 =?us-ascii?Q?ZMzRMeI0IoW8EXDfm3MEkKt7A1Y7fBYa+HAbKMYvaD7l/CrzfcHoTX7UtCYw?=
 =?us-ascii?Q?g3EXQj5sA6A5KtI/epNKetaT8hWYfNVCj/mVWb3ST9REZ5EqEBY9ZCfyDs9o?=
 =?us-ascii?Q?+rgDVekTk6aCabS2C023tldBdUMqhXRGsfiy1XLt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cafa6a-5536-4480-4bab-08db1e3b0b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 12:05:14.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqbXCquVfYlCm5EuH4y2B65XLFCeEdsJ9MnUPdqdcMVEWjXEzn3iubg2/G1aFVngM2iBoa+7utYlF3CZ6IfR0RCVyA0R0fUd3HOPXRdiwv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9407
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Gentle ping. Looks like this patch is missed since November 2022( almost 4 =
months).

Cheers,
Biju

> Subject: RE: [PATCH v4 1/2] media: dt-bindings: media: renesas,vsp1:
> Document RZ/V2L VSPD bindings
>=20
> Hi All,
>=20
> Gentle ping. Does this patch to be taken by media subsystem or dt?
>=20
> Is there any chance that it can be taken for v6.3?
>=20
> Cheers,
> Biju
>=20
> > Subject: RE: [PATCH v4 1/2] media: dt-bindings: media: renesas,vsp1:
> > Document RZ/V2L VSPD bindings
> >
> > Hi all,
> >
> > Gentle ping.
> >
> > This patch is reviewed by both Krzysztof Kozlowski and Geert
> >
> > It is blocking for accepting SoC dtsi patches[1] through renesas-soc
> > tree 1]
> > https://lore.kernel.org/all/20221122213529.2103849-1-
> > biju.das.jz@bp.renesas.com
> >
> > Cheers,
> > Biju
> >
> > > -----Original Message-----
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > Sent: 22 November 2022 19:34
> > > To: Mauro Carvalho Chehab <mchehab@kernel.org>; Rob Herring
> > > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > <krzysztof.kozlowski+dt@linaro.org>
> > > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Laurent Pinchart
> > > <laurent.pinchart@ideasonboard.com>; Kieran Bingham
> > > <kieran.bingham+renesas@ideasonboard.com>;
> > > linux-media@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> > > devicetree@vger.kernel.org; Geert Uytterhoeven
> > > <geert+renesas@glider.be>; Fabrizio Castro
> > > <fabrizio.castro.jz@renesas.com>
> > > Subject: [PATCH v4 1/2] media: dt-bindings: media: renesas,vsp1:
> > > Document RZ/V2L VSPD bindings
> > >
> > > Document VSPD found in RZ/V2L SoC. The VSPD block is identical to
> > > RZ/G2L SoC and therefore use RZ/G2L fallback to avoid any driver
> changes.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > * New patch
> > > ---
> > >  .../devicetree/bindings/media/renesas,vsp1.yaml     | 13 +++++++++--=
--
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> > > b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> > > index 7a8f32473852..3265e922647c 100644
> > > --- a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> > > +++ b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> > > @@ -16,10 +16,15 @@ description:
> > >
> > >  properties:
> > >    compatible:
> > > -    enum:
> > > -      - renesas,r9a07g044-vsp2 # RZ/G2L
> > > -      - renesas,vsp1 # R-Car Gen2 and RZ/G1
> > > -      - renesas,vsp2 # R-Car Gen3 and RZ/G2
> > > +    oneOf:
> > > +      - enum:
> > > +          - renesas,r9a07g044-vsp2 # RZ/G2L
> > > +          - renesas,vsp1 # R-Car Gen2 and RZ/G1
> > > +          - renesas,vsp2 # R-Car Gen3 and RZ/G2
> > > +      - items:
> > > +          - enum:
> > > +              - renesas,r9a07g054-vsp2    # RZ/V2L
> > > +          - const: renesas,r9a07g044-vsp2 # RZ/G2L fallback
> > >
> > >    reg:
> > >      maxItems: 1
> > > --
> > > 2.25.1

