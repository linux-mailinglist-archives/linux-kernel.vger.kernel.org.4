Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39B68EABB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjBHJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjBHJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:12:57 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::70a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AAA29E20;
        Wed,  8 Feb 2023 01:11:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5PKqn3owCrnuJxJ4Ivtpv9Hc1b/pJFL5wK2aSFVa5Qmo/8Q2jXlMpUF4WuJTsPavB4GW/fgnTLXex6XemyCGapGxPJ3AiFAB1j5Tq2NgcFGpQsXIjgA4Xi7+0pNkIxQPSltEAvJoi/U7Uu5NJj34qTOdtOv1ntETZOmGsvnQRFskM323StxODSa7bA9bDGX7cyPIJwkXyX6QzvqI6qZYfIRq17I5HLCylM2YZFRUucJX7V6yqvYM6JJL+FqETzBNDeyrv4rJx/pGHIrYXW9tQ9pXxvKx+1M79a9KF/agjGcZdNa4rr0S+LkRK2IM4ODkC6GnZeSQpmIqcHiJ0LT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7nfG0Gi19F/mynOfY7AhAX9+5IESCxIOJ4ufWRN2fA=;
 b=TwQLnavTkHRqAr2bNJ3JsNn4kuc3jnQrNVvpEj/dNIxcl8fJgO5PQj7MWwH8W+UGpqwmh9L6w+J3IE8jzVU9WrqZxmMU+n1xxc+WtktiYhmXd+hbDEEhBdbP/owi0GzGIaOeZX9oMFMHVre8Nj9Gp5DGXGpQdMn4kTGPebkVba+s4sVmBJEHNgCoBc5fK6JbxI/YLFFMG5sl74SUoLJ5JHkBUuHwgVnjsM1+W4lvDORwdi5Jmir+iL4dlszAZODesFl0N6ZAoGzhQY+PaQ1VVKCXRGkTOvOdMVFFrRtLqsDAIoi332R26Icky4YGO2M3z8DBxWSX/kYpPiiYxLc7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7nfG0Gi19F/mynOfY7AhAX9+5IESCxIOJ4ufWRN2fA=;
 b=WNOEuw93gCJT82W6kEJpxOkJkehIn0ritnECFMrLNbD3RoVBh1aWQT20H7sgFVLgCRINRyRaTQeOuibNyPZ+fqan0e4gdSTD0Up1mc1abpt4c0oS8txBZaZbaS1AnrCE7FtbRzqw2D3J1Bx1UIjgx24wUjQ+A0DCGrLEzQmykeQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8296.jpnprd01.prod.outlook.com (2603:1096:400:15c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Wed, 8 Feb
 2023 09:11:27 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%7]) with mapi id 15.20.6064.035; Wed, 8 Feb 2023
 09:11:27 +0000
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
Thread-Index: AQHY/qlxicYftSpeMUKKL0vGYRE9G66iv0cggCJ9GCA=
Date:   Wed, 8 Feb 2023 09:11:27 +0000
Message-ID: <OS0PR01MB59226BBE7D9D7151EACE52D286D89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221122193415.1873179-1-biju.das.jz@bp.renesas.com>
 <20221122193415.1873179-2-biju.das.jz@bp.renesas.com>
 <OS0PR01MB5922D9004BC2A00BF1CCA0E186C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922D9004BC2A00BF1CCA0E186C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8296:EE_
x-ms-office365-filtering-correlation-id: b18a69fb-a8ed-4dac-815c-08db09b4758b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sEe3rRtBu9G+eEFz/E92J1Jq4klkAdu7ENBJwy4d+uSl52MiZh+wg4HyLUbs44gJ17b5mH7iWSOAcRtG8s32hktcXclT5Uu9383lYlCwlDX0uLrMydODI4FxbYIuScYXQLRYDH38JuUpSNoZtfoEEG7K1nj6P6A9VUyPyGgKvx0bkUBc3kdex08/o/nBqeowQj9eR6VwDbyCBEBoC1ACpE374IUfVRxl0/B5GjVFXWGxJXwKV++/Yrpz+OBLAhvHWutrdfqH/fg5YqApXTOalc85zd6gRiictshOex+OEeFmXlDjl+K0sFAZys0U2wiTTF84BndmEZTiMxiQkoSfFnlql0f8pUHfgjDkd0h2PIBh5KHC/Owwkf8ZUDK69ZLqLLo9hRvwmAh0kkXt01wNVutSRaPp4gEWlpEkFXH97br9oM5hrHELnKzlu4f6Orq1Q99pzM/ZRTVSHuOiE3tSP+Y7EdDOdfyk8CzZnFduo0zfeke/DBWLPR17+yS9VFahlrH9Vaox/1/wLOPi/KqPld7Yor8pEJ87aYUjjQezcaMChxCrT/2h3KuhZtandb4TROkb9RpvknkrjeBOw0ebDeitUHOGRW2ImVynie5mmsWsd8C54YXypMxN1In+DknvceVs+DJXusDI5STzXAWXjiNylB8eHzkVuto+fHlaiRqRdunNpvSBtvxHqygx9ORrT270BXd+87hvLjdTG48VFHdwmKMcjjh/fSRBe2kcviM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(54906003)(33656002)(316002)(110136005)(38100700002)(41300700001)(122000001)(2906002)(55016003)(8936002)(7416002)(5660300002)(83380400001)(52536014)(66946007)(76116006)(66476007)(66556008)(66446008)(64756008)(8676002)(4326008)(9686003)(966005)(478600001)(53546011)(186003)(6506007)(26005)(86362001)(7696005)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CUHN8VtbQu6EypXiTU/UtINZ+rfr3lbRBC+rb+eYqkKqY6t7mZA/s65jWAbE?=
 =?us-ascii?Q?ReAJbCCTDcHoVoZPa7KjaRjSxKeVcSrT6BtyiC2OAb0EJuPibLGl+zsBbvwa?=
 =?us-ascii?Q?M+Nn6yvbmN6EF1x4jXysJhnKmnXu2hkluaVvjDtPB1Zjjq05k8bn0kGqHZRL?=
 =?us-ascii?Q?CK66c4wz7LYzIpChKdaMHC1aZdJb41BePTp+ykMPpMp4+7SQAIceCC8G8Vng?=
 =?us-ascii?Q?uyTbXceAVE9lQQJko5Fh3vnkqibzoXaT1N/hjVekawvZsgZUHCJSLKYD+Bwc?=
 =?us-ascii?Q?f0c8xgO1/6DEtKspPShSD8HhMATUhQ+3rQ4pLwd/sYznXFFLI8hkLx8+DdPa?=
 =?us-ascii?Q?VOlEbI5VaZ+9vTXpoNHnu1u+lsD2J3F0gUM8GkZikXt6mOdGOiADqR36KY5o?=
 =?us-ascii?Q?N65vDvUmbdNP87nMd3B5OpYtB1zQlp6JZx+a/qhMQYOc693hmg+E6s/JnyD4?=
 =?us-ascii?Q?+FV2tBgvOpiqtqM4m3gvwA4L0NxCAy72jydv2xm8oRAHtksgLpa/P736/ltt?=
 =?us-ascii?Q?MdZNs+0oUkxOqMJJnLgLqzJDT4yGb65W9Os5INEkW7/SqWfSaSR7cRODTAVd?=
 =?us-ascii?Q?xA+f3wiUiKEgDO8UOV3jFMi+BNwjqnFPzZyx2gwr9aUcsrf7g8rvk51r50LI?=
 =?us-ascii?Q?zYga94eQYwAnAbRN/15944em08ETretS6muRdwZG+xkVe0QXm5iHqkZnc9TE?=
 =?us-ascii?Q?VBuy5QW4xhuOraLLNPX2nhoCxO2vXV0bRJhO9SEuusEBP29T9trvz6Y1Q4/0?=
 =?us-ascii?Q?OIZ+vPqIXrNfJz/RYM0GPM5G8u9XCGAgU7pewr/keqfoJPganMFKuKku4gE7?=
 =?us-ascii?Q?9y4JQAB0wqVddJPIw+kOCDPDcQWpTLT4AqQE6rJhS5M3cxzh+Lqwd2T1QJ13?=
 =?us-ascii?Q?XfOZvks37u/u9xEkm293s/8+2QjuISrF/pCi2pC0GckrK/58ZSxk7JUdY2Jy?=
 =?us-ascii?Q?hp0Wgd9oqoSD5SubUCc25/ossDKmTuk/La0fiCYF8o3WGhCJevW/xn0ZI3tO?=
 =?us-ascii?Q?b0GCnX6fLStzQ6GtollBoD5bv7+wmdkyCK/rG1Y2PTM0nXrX/WRDDCTfAHsu?=
 =?us-ascii?Q?TRlgUasQqBnNl4qZV7OHN8cFs2tNARs8ygaTDN1KiRIHEZOSNbX8XzNF3AlB?=
 =?us-ascii?Q?IgBLp0F/cRxK071NOBiy/Tel+1yJlZxwjANQbbpXV3ULwoSv5XA9SQylzjot?=
 =?us-ascii?Q?oja8S6rJNVGBkdZC3FhQtHCoD6GM96vXiImq6sj8SOqU3Ndjl+1EStryNg7x?=
 =?us-ascii?Q?WCvMd/64UMRkB5qchlMmAYptkeC4p8+8fJi2A4E6hqTPN1GLCQpQ1hAWN/P4?=
 =?us-ascii?Q?6qnctf1qGu6ek6mNFN9F24GB8kN2PpWMkDYuwHxadUZhkhEUI4ca2MLuLQyp?=
 =?us-ascii?Q?HToXRYJtx3r2Mhp4DOORoRIWUrYF6cCRmqZ1w2XZc/GsobKFI3WKfKDpuRkv?=
 =?us-ascii?Q?3LaiabreAzkLlozUb/lBqP8ReRK1KOK8g7P0Smf0dbre/tzJeqrbMkBzmsOK?=
 =?us-ascii?Q?ERcDTLZwYYRwTRCtAcV986xmzDenEkglU1m0jwUPNFQmyMu6tItuGZYLAVFX?=
 =?us-ascii?Q?RV7EF0QMh3Uw0NHjY6dQ02GDn/vDX3yoSg8b2JSl/DK+V2pNrvkL/Eiui54I?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18a69fb-a8ed-4dac-815c-08db09b4758b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 09:11:27.3741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sCzqhhHCVp6hB685tfTBB+Q9qR1Nvc4D8OhT2IoHsZxIuAVvxFoaPo12gU7yf3Z9XlS95/GTJ3G/fEHWmX6qL92Cc6//063nHr21TEnZR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8296
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Gentle ping. Does this patch to be taken by media subsystem or dt?

Is there any chance that it can be taken for v6.3?

Cheers,
Biju


> Subject: RE: [PATCH v4 2/2] media: dt-bindings: media: renesas,fcp: Docum=
ent
> RZ/{G2L,V2L} FCPVD bindings
>=20
> Hi all,
>=20
> Gentle ping.
>=20
> This patch is reviewed by Rob.
>=20
> It is blocking for accepting SoC dtsi patches[1] through renesas-soc tree
>=20
> 1] https://patchwork.kernel.org/project/linux-renesas-
> soc/patch/20221122193415.1873179-2-biju.das.jz@bp.renesas.com/
>=20
> Cheers,
> Biju
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: 22 November 2022 19:34
> > To: Mauro Carvalho Chehab <mchehab@kernel.org>; Rob Herring
> > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com>; linux-media@vger.kernel.org;
> > linux- renesas-soc@vger.kernel.org; devicetree@vger.kernel.org; Geert
> > Uytterhoeven <geert+renesas@glider.be>; Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com>; Rob Herring <robh@kernel.org>
> > Subject: [PATCH v4 2/2] media: dt-bindings: media: renesas,fcp:
> > Document RZ/{G2L,V2L} FCPVD bindings
> >
> > Document FCPVD found in RZ/G2L alike SoCs. FCPVD block is similar to
> > FCP for VSP found on R-Car SoC's . It has 3 clocks compared to 1 clock =
on
> fcpv.
> > Introduce new compatibles renesas,r9a07g044-fcpvd for RZ/G2{L,LC} and
> > renesas,r9a07g054-fcpvd for RZ/V2L to handle this difference.
> >
> > The 3 clocks are shared between du, vspd and fcpvd. No driver changes
> > are required as generic compatible string "renesas,fcpv" will be used
> > as a fallback.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > v3->v4:
> >  * Added Rb tag from Rob.
> > v2->v3:
> >  * Updated the compatibles by replacing items->enum as
> >    it is just one item.
> > v1->v2:
> >  * Documented RZ/{G2,V2}L FCPVD bindings
> >  * Introduces new compatibles renesas,r9a07g0{44,54}-fcpvd
> >  * Added clock-names property
> >  * described clocks.
> > ---
> >  .../bindings/media/renesas,fcp.yaml           | 45 ++++++++++++++++---
> >  1 file changed, 40 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > index 43f2fed8cd33..c6abe719881b 100644
> > --- a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > +++ b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > @@ -21,15 +21,22 @@ description: |
> >
> >  properties:
> >    compatible:
> > -    enum:
> > -      - renesas,fcpv # FCP for VSP
> > -      - renesas,fcpf # FCP for FDP
> > +    oneOf:
> > +      - enum:
> > +          - renesas,fcpv # FCP for VSP
> > +          - renesas,fcpf # FCP for FDP
> > +      - items:
> > +          - enum:
> > +              - renesas,r9a07g044-fcpvd # RZ/G2{L,LC}
> > +              - renesas,r9a07g054-fcpvd # RZ/V2L
> > +          - const: renesas,fcpv         # Generic FCP for VSP fallback
> >
> >    reg:
> >      maxItems: 1
> >
> > -  clocks:
> > -    maxItems: 1
> > +  clocks: true
> > +
> > +  clock-names: true
> >
> >    iommus:
> >      maxItems: 1
> > @@ -49,6 +56,34 @@ required:
> >
> >  additionalProperties: false
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - renesas,r9a07g044-fcpvd
> > +              - renesas,r9a07g054-fcpvd
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: Main clock
> > +            - description: Register access clock
> > +            - description: Video clock
> > +        clock-names:
> > +          items:
> > +            - const: aclk
> > +            - const: pclk
> > +            - const: vclk
> > +      required:
> > +        - clock-names
> > +    else:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +        clock-names: false
> > +
> >  examples:
> >    # R8A7795 (R-Car H3) FCP for VSP-D1
> >    - |
> > --
> > 2.25.1

