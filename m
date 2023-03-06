Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531D96ABF0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCFMFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCFMEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:04:50 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F5622A31;
        Mon,  6 Mar 2023 04:04:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbuwmQ3lb/x4o9DPwGrDDabt6XpWzgHzcaaNsP6Q3z8HSwan69xKdJqeyH4JsMHsm5zDF6/v88RghD6rEqbHBw9+9eIAw6x0oqNT0K0SQNR5Ctlp8sjAYX8vZ/5UsJzf6XAZZahADQdv8WWGRELgEQUwwfvr3pax0FxYy+7vQvptkt2kkXsyJr3gsIoIpRuYTzwKed2mt3AsYTJvUFtEF73hCOgplA11cfr6/cgeQAMi8MwIwHZPpmD/BJ3gU5SUm7JGleni0PR+BzOWpp0FNo6PursVVwQFDqnqP9rYQ3NnZHl4f5CGXJPMDmK67SyUsVphSrwGlCE9cUBUGNwHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnVqT3Ko4kybjGHQWQUkWcqylboUx2ebODctrhSRgX0=;
 b=D/BiQmuHTFt5RrRcsLwUvjUSBIFDP7Gj5d/gFt0P63MfvTr2iT9pikWzRUQQcVoQU33Ab1jBSDqviQ2EhIEEUkXdKNU8Xng/lodIAjrX6BDEaCS2vSRbM7FPpVWWs5tTE9V0KtwXpPsaUgSQaUkaRKVp7+zL0xHnKmaxwWmI2NzyXMRqHM2Clj6xIMfwkcEyVEi7IHsqohgPEa1qKG/DSMFkM17z/TDfwQMajPGLgeKQUD7c/5rTjNAB3ufIRO8WkWmsraKKn4YPCR5Z4hEFI5VdWynwMTApiAZi9xwbyGtHHbV0Exxl28US4moNvw9mwnwp2+SzJUjNHsFVntUQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnVqT3Ko4kybjGHQWQUkWcqylboUx2ebODctrhSRgX0=;
 b=sMEZghNKY47kJNJN/yVFmQnLfseW1cp2oVJ2os1YcEXAAia3gCEwV6J/1zZ4vDc5XRsTREFMVnPFQYknzEqZw6ys7dtKoernAkP9XsbAJf466exiBRKfZgs9U+Uhh+oRiTDVTu5iyqQm7nrz5Vr5TaGP+07pO40zk/Se4V+FhLs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9407.jpnprd01.prod.outlook.com (2603:1096:400:1a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 12:04:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 12:04:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] media: dt-bindings: media: renesas,fcp: Document
 RZ/{G2L,V2L} FCPVD bindings
Thread-Topic: [PATCH v4 2/2] media: dt-bindings: media: renesas,fcp: Document
 RZ/{G2L,V2L} FCPVD bindings
Thread-Index: AQHY/qlxicYftSpeMUKKL0vGYRE9G66iv0cggCJ9GCCAKQ2YIA==
Date:   Mon, 6 Mar 2023 12:04:44 +0000
Message-ID: <OS0PR01MB5922A09190347117F81C20E186B69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221122193415.1873179-1-biju.das.jz@bp.renesas.com>
 <20221122193415.1873179-2-biju.das.jz@bp.renesas.com>
 <OS0PR01MB5922D9004BC2A00BF1CCA0E186C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59226BBE7D9D7151EACE52D286D89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59226BBE7D9D7151EACE52D286D89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9407:EE_
x-ms-office365-filtering-correlation-id: 08476da8-5a1d-4722-f7f5-08db1e3af998
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gJ5Icj+dNKLcYvrWQZx1Fwpjoaj414lGpO/ulEcJ1hiluUDXaDnQv/AT+Qf4qa9ObRuNIvzd8CPJ1UiLCG8uZmZYia0hLSEv6q4UHBOfX7EcRIR6I1DJqLNh9pEb3vlBVuaDJcp1tG+/ZasP4FEw29YMl5V0euHj1QXEEL1UFeH1xeEJ4i9ck7cImMxzCc0rNruVNsMb7udyoCgPM6lkR24ITGrxXUl/W6lEqRscT5AjZm4yWWenPHDYgN2Msz3smE8u6KP9fpv81Hts3d6ZmosClqt+O2MZ63rakzFdSZqNcp/N0tyrd2f7U5hXYVSAE5r5WiLHGPcb8qeMq3RatbW57Oa2dXnVcbNiwRI9hhQU6rcgdRIZu65f7qZQryRA9/WJSXTgxN0LV2W7f/IlwWVYXJS+ZWyvxmL/w2M4TIz0v5Z/HebTUVD8VBZOWirxBNIBgbye/hFttghnzN+gk18BRpILwxGVNNDyEG4o+vxctPlecGqmJPB3ESlywoauyL1E6popWjz4e9+nc9Z55XiFO3QwQZNHuRy06Uyl620KQfqsK3Z//DWX+eLRShyc9dNq+SjPepSo01zHDYLHmGP0WWwY9VeGrFRIwaSXTWMpL7aZHyKHRNK6wEE/oPEhoUUJg3MEFJt92Tf05pF1pd0Ag6t4EVSmkSq4SZK6Ij5/oMjyUJrLhbyQRkXdza+I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199018)(9686003)(186003)(122000001)(38100700002)(38070700005)(52536014)(8936002)(66446008)(66556008)(66946007)(41300700001)(66476007)(4326008)(8676002)(2906002)(5660300002)(76116006)(71200400001)(7416002)(7696005)(478600001)(53546011)(6506007)(26005)(64756008)(966005)(316002)(110136005)(54906003)(86362001)(55016003)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I7eB0fSW86b6BAG8MqmRNO7BMgglZ1SN2djYDewmy+m9XNnW3eC64JZ2yNO4?=
 =?us-ascii?Q?k7xInii51+qk7qwj+g7q5mjtmVKQtI7LAVXnyOxHO1JNkD0eB2iSBphV4kJE?=
 =?us-ascii?Q?qFkuDfddhPPpK4l1MmNCUJe6nFb0SfwiT9K9aGpWkhCq1qwbp+LCYvR0y2iU?=
 =?us-ascii?Q?n/aI5UOGvP738UuIjIUPzntptjL8LqMIaSn/76+T3vqK0oWSh856MMp8HehI?=
 =?us-ascii?Q?QJsWDdmbPGuRm8JRi7Y+gZ4HqKV2B75TKRAIgMHf1B5+QiO0QXQwGves0vOz?=
 =?us-ascii?Q?yGpdzaisqrl9uQW/tjwbN0CbNN2cG+JDNUpjPNk9izX8Rb1zQl5Y1fG7cqmJ?=
 =?us-ascii?Q?20A83dc9lPktgE4b3DKkmIUiLp77QKwVstov6PIqnRw2CUA9a2ZaWYw/1sgS?=
 =?us-ascii?Q?7WqONYR+JfElJo0BcX28lbdE11YgEAGzFgxy6B5n4D4Ew59XoCkiTBeMZ8xQ?=
 =?us-ascii?Q?dnOwsW21/N0XeQXSXgi/d1rFE2mJAg9cBUjkhrhm0OfDTQW7yY8GVnd0Zl34?=
 =?us-ascii?Q?DBbsf4GzPYe5cPsfxhbn06HC7JOJMyu7CC3dvWcfO1Fg04Bp+rnkxbIjaQQ9?=
 =?us-ascii?Q?+srfUJykkB2Wq525D4diM0GSzEunqViunhZH2cBHCvljx6SfQZ8ktpw2SbgY?=
 =?us-ascii?Q?m+APhMUEDHuqEpP+H0vLBq0dX9sdZxlQkJeYMg+EnEJFMELw9wJfB94GQcQo?=
 =?us-ascii?Q?lt5k+riYOgHMUMiznR1ItbbRK9LbHGWr2CExwJ8ibH2W0W9CSIeoe1csTj3N?=
 =?us-ascii?Q?F0Ydp02fI/pce7m+9SCfe9PLaAPu5AnBMfNzXMgs2UAYBK6j2eUOmrPrWi9s?=
 =?us-ascii?Q?7PAfFn3RzTJGFj68yJ1HVJNuPzgRPBp+e/BbQAU/UW3gd5JvPPPW0gOx8OwG?=
 =?us-ascii?Q?/yG2ndJMkp+RaoCmIZvbJqqn+XhEroyI3LhQpi5Zom0AD3TEg+Udl3qzms9T?=
 =?us-ascii?Q?agsB0420ZVb52EQxsc54VLO2RiFlHCpKRBF66ZJKTC86QtaiVCQ0itaoh62r?=
 =?us-ascii?Q?zaZlgkll6ojkIwGXHb3MnQp/kELBe+j5JYpPdf5pzBGEJI3OztEx7N2nyOTd?=
 =?us-ascii?Q?w14Nzo3kP1v1T41cy9KxNwazREv2kz3peeKggkMXfLOEPzAcaqMUm3xf8U3p?=
 =?us-ascii?Q?8C/3+9/zoBD7lyz+BE4sOEgABobP8Av807uzxvX9WVqEPmtv2ORrGSw6h1Uk?=
 =?us-ascii?Q?A7zFu5tAQY+kZxkF0EEe2ukpyf5Q/LOLmUTNhWnq2iy4LPLj9vKy/ziK9Xj2?=
 =?us-ascii?Q?iZg2wwKFLqEdMXMeshFOalTC3MtOr5xbAkFstpVBLHhWwf6WoZyggY0AAZxH?=
 =?us-ascii?Q?6xoW5QvCXK2622lxf5KZzh7qMBNN61pLnxZaHQ0RrCNsA9deSNe06bGJlFAG?=
 =?us-ascii?Q?hGW5BGWKZbL/PnV/FkQ2k3cvQkzQCxfOPxLWPkwqUb9H1gaapMDsy03GcjdS?=
 =?us-ascii?Q?yyuAOXmuSJYZcH8SBi6QdH691zuRLK3AiS/KkFYVdXDZi6MDDr96Sjqxq4q2?=
 =?us-ascii?Q?kj2U8KZ605rPoNlrVHAkvPDdeJAueJwWla8z4dDCHlmeJHzEHAyzWfyhtzDA?=
 =?us-ascii?Q?iGB3P8EI59iOBGyJBhHdzfjedpfrDDPsm9jtg5DS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08476da8-5a1d-4722-f7f5-08db1e3af998
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 12:04:44.7232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JM8tOX6u33tesSMejACOugwRlQmRZjHvPDv4xXNDYhzqs8lsmABR+xVcNxCiBHGE4xJDAJ158YHcdvhXgu7KIZXFvEp/jNFdg7z32Xktee8=
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

> Subject: RE: [PATCH v4 2/2] media: dt-bindings: media: renesas,fcp: Docum=
ent
> RZ/{G2L,V2L} FCPVD bindings
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
>=20
> > Subject: RE: [PATCH v4 2/2] media: dt-bindings: media: renesas,fcp:
> > Document RZ/{G2L,V2L} FCPVD bindings
> >
> > Hi all,
> >
> > Gentle ping.
> >
> > This patch is reviewed by Rob.
> >
> > It is blocking for accepting SoC dtsi patches[1] through renesas-soc
> > tree
> >
> > 1] https://patchwork.kernel.org/project/linux-renesas-
> > soc/patch/20221122193415.1873179-2-biju.das.jz@bp.renesas.com/
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
> > > <laurent.pinchart@ideasonboard.com>; linux-media@vger.kernel.org;
> > > linux- renesas-soc@vger.kernel.org; devicetree@vger.kernel.org;
> > > Geert Uytterhoeven <geert+renesas@glider.be>; Fabrizio Castro
> > > <fabrizio.castro.jz@renesas.com>; Rob Herring <robh@kernel.org>
> > > Subject: [PATCH v4 2/2] media: dt-bindings: media: renesas,fcp:
> > > Document RZ/{G2L,V2L} FCPVD bindings
> > >
> > > Document FCPVD found in RZ/G2L alike SoCs. FCPVD block is similar to
> > > FCP for VSP found on R-Car SoC's . It has 3 clocks compared to 1
> > > clock on
> > fcpv.
> > > Introduce new compatibles renesas,r9a07g044-fcpvd for RZ/G2{L,LC}
> > > and renesas,r9a07g054-fcpvd for RZ/V2L to handle this difference.
> > >
> > > The 3 clocks are shared between du, vspd and fcpvd. No driver
> > > changes are required as generic compatible string "renesas,fcpv"
> > > will be used as a fallback.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v3->v4:
> > >  * Added Rb tag from Rob.
> > > v2->v3:
> > >  * Updated the compatibles by replacing items->enum as
> > >    it is just one item.
> > > v1->v2:
> > >  * Documented RZ/{G2,V2}L FCPVD bindings
> > >  * Introduces new compatibles renesas,r9a07g0{44,54}-fcpvd
> > >  * Added clock-names property
> > >  * described clocks.
> > > ---
> > >  .../bindings/media/renesas,fcp.yaml           | 45 ++++++++++++++++-=
--
> > >  1 file changed, 40 insertions(+), 5 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > > b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > > index 43f2fed8cd33..c6abe719881b 100644
> > > --- a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > > +++ b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > > @@ -21,15 +21,22 @@ description: |
> > >
> > >  properties:
> > >    compatible:
> > > -    enum:
> > > -      - renesas,fcpv # FCP for VSP
> > > -      - renesas,fcpf # FCP for FDP
> > > +    oneOf:
> > > +      - enum:
> > > +          - renesas,fcpv # FCP for VSP
> > > +          - renesas,fcpf # FCP for FDP
> > > +      - items:
> > > +          - enum:
> > > +              - renesas,r9a07g044-fcpvd # RZ/G2{L,LC}
> > > +              - renesas,r9a07g054-fcpvd # RZ/V2L
> > > +          - const: renesas,fcpv         # Generic FCP for VSP fallba=
ck
> > >
> > >    reg:
> > >      maxItems: 1
> > >
> > > -  clocks:
> > > -    maxItems: 1
> > > +  clocks: true
> > > +
> > > +  clock-names: true
> > >
> > >    iommus:
> > >      maxItems: 1
> > > @@ -49,6 +56,34 @@ required:
> > >
> > >  additionalProperties: false
> > >
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - renesas,r9a07g044-fcpvd
> > > +              - renesas,r9a07g054-fcpvd
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          items:
> > > +            - description: Main clock
> > > +            - description: Register access clock
> > > +            - description: Video clock
> > > +        clock-names:
> > > +          items:
> > > +            - const: aclk
> > > +            - const: pclk
> > > +            - const: vclk
> > > +      required:
> > > +        - clock-names
> > > +    else:
> > > +      properties:
> > > +        clocks:
> > > +          maxItems: 1
> > > +        clock-names: false
> > > +
> > >  examples:
> > >    # R8A7795 (R-Car H3) FCP for VSP-D1
> > >    - |
> > > --
> > > 2.25.1

