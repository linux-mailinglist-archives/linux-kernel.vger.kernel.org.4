Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6330C68EAC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBHJPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjBHJO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:14:26 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7846D5D;
        Wed,  8 Feb 2023 01:13:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuvSTLY2gFzKhWSNo67MUb6dT6i+072hscyBnc7S2r0qKmeetAPhrg9BGc6hKG9YBahj7c6S8xQyRyAKOzVoBne0IJNxTZr+AGiYNzq16n+VTnuh6vsJggezsUvaZPVwvv0ae3aaZdAehvFkuXqkFLHWfhFqcAZhZxsh4GvZ8SOTiNWCNKJDs7oeWX53vYYkWqTopCOEoDGoY55Uxoy11u3UY1n9H/4ln+TDaJXjkSrEQwYCpbgmdEr1fOCtr0gUjJYxOLD3BJeHr4rjegMqFWNSfrlTwS8Ma6nVjQ5+FyfY4OH1W2+IJ7PUA/C+2iNVM8uTgjt/hy9dSvVHsnLmRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y2G7QLTRROgDp1QW3nK15qSOjDA/1lx48/HutSAp5g=;
 b=HOMa6+JtAk9HhAVPJBK3RPFRSQROwqf0i+ZrEMX0jFJC51K6PH2MIBPxagt9pNVip0/OqghwwTk+afCaIPynUMCSVfs4vUYX3ERBZlsokzB1XSWKAPYjur8WCApDkr9u/0hVU2VHT1dmfx6yMFURyiNA4d8MviY6D1W9gig1DHUdwVneeKS5jVElMElUg/gnoNkbl+qJ+SJp+L0DcvexQ6hbHUzol4oURndNE3M2zPjVczZ9bzTlNqirkyGZjoGb4p1Qf7NND2csnlngFxp/Q6RbJdwXchHpt3DAd8ylaj6iGnQAUacqsXyxDLIGcH0jxl+ZY1GS1cEUM5NynGaPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y2G7QLTRROgDp1QW3nK15qSOjDA/1lx48/HutSAp5g=;
 b=wiYJBdvm1ZMIb8STarlCMFXUnENnYvdKl0XeMxP4b4DKhtpqKlZDg6vgYkvCFOytsqtxoJoWBwqakiLGUVnwK83KElcLpaJ6/zJNICOzNr18azW5GBK44lEi2Q0YjD3g8MexkMZX3vmg15CxE/20u95mhkFF1y5xPMcQBTusmZM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB12014.jpnprd01.prod.outlook.com (2603:1096:400:3e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 09:12:14 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%7]) with mapi id 15.20.6064.035; Wed, 8 Feb 2023
 09:12:14 +0000
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
Thread-Index: AQHY/qlsiqUPLyRiZEakeAuWQTj/0q6ivSewgCKAQiA=
Date:   Wed, 8 Feb 2023 09:12:13 +0000
Message-ID: <OS0PR01MB59224810FCA39B4E7CCAF2A886D89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221122193415.1873179-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB5922EED83E05EC0B6EEC245986C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922EED83E05EC0B6EEC245986C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB12014:EE_
x-ms-office365-filtering-correlation-id: 64c99f39-3687-466a-1802-08db09b49158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hn98hzDiJbmPK014L/aSz7utIIo26YqG/nkZzakp/mx1uiNmBnN1kBwHvqJ+i41tlpfd8VRL9BnjJJeJwtAxpDFagOojZ7/lx+/zH0LukFW4m//4vXJ9Azmk7rhw3OPwWoYMz7LW1m/TUwThhzLmh3OBZo4hrd3yvUVAErkSllAN5LE+MsxfScUWQZK2XfBkqhsqEyZbXqXEITy7mDirE6qWwPlaokzyilm8ffEpH32hi4g7LyUaStvEKxzTAdPjLaIpN3Vg4KlyEYW42zcq1XsaOPZKF/dW3Y/8u6G7674FktkM2O7w8KK3q2hijd5elqEvC7CCpBbM8n4rPI5VKMFPOep4YeIXbAR0moRXBijnLQ838TVmxK7tiRlZpxCHGG051+SMLW8j5tq47Uqx5DRIqZeFQMRNp2Cv/IrbEBctR1AuidISSW8XS3TdoQcu0PbfJdI3m26tXL8lcT6Wzrjiawhu+O1HPbCIezgRR9ylZa4+EPWsKgoEYZ8eJDdlLLpKQVHrSl2FMu8+wW6Br6Z1O791roUusegirk8xnIHfba91s21BoPTtTFPYrDXjuHL5GSewLaJ1oIoFOe8eGOxB+8eCvUr+WGtCIBxhPD6k4cyhXItjMfiZsbk21yTWvNrq+WMZUy5EkiisqGs8g/UJD4kfe9LK6tdHIqWxalcvc3HE+HrJl/X7xOeGB/kApB8Fjc6LNq6WtLkYWyA0LhHS0Fj0+gLTyu8P69FQDD0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199018)(38100700002)(122000001)(86362001)(2906002)(33656002)(38070700005)(316002)(54906003)(110136005)(41300700001)(5660300002)(66556008)(7416002)(76116006)(52536014)(8936002)(55016003)(83380400001)(8676002)(4326008)(66476007)(64756008)(66446008)(6506007)(66946007)(53546011)(966005)(478600001)(26005)(9686003)(186003)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H4aFsnNnWyKnVlDp/2cPQvwo/Da9Po5lfwDIrUWM7C91H864lPJ0JdNHAQdx?=
 =?us-ascii?Q?gHNFOnjg8CvunrJjnK1M25MwbSdGn14nUrPcRpKzVktXnevpy3QpzV308O2K?=
 =?us-ascii?Q?wlnrRUcrLVVcm1cUrUdeQsXe3IK94rT21XFLtmzsw3OfGB/J6N7wSJh7BJP7?=
 =?us-ascii?Q?YNKd4bYLsb1Y3NF74PGXnzQEB6GrbvVhYv0Sz04WmOUAfkmqKmoXAX8J2VIJ?=
 =?us-ascii?Q?aqIJp+l/+R2pF5NwgRvmU5SObyVZyrZ6cHesu7tVOBaTZn45WwN1pP42q/9h?=
 =?us-ascii?Q?xMEWT8DKQ/XUG11Ym2J2W61/LPKSbaPmleqqrh4/Jb2Cf+c+nWf3omc5//wP?=
 =?us-ascii?Q?6dD4nLCrS+2Yt8ppV3lATN+gFCffT2GS5ojexnFA5deTgwBbLiDIwBNxxh/c?=
 =?us-ascii?Q?WVpxjrw+jH8m+E9vNdqssJMIhqDS6Jq1/Og0v0ZyRJCB0SAug9XjFB5EHLtf?=
 =?us-ascii?Q?KSMnOc5mLLTQpL4/XRIUBHG5dRvFXqblAKGjnpi2PD3zMvMGGZl28eL0OPN6?=
 =?us-ascii?Q?JzBmqcWylhw2MrIJ4tr05nIAHAW/swgji68xsF83eEQQrNLtLeJfN9w/wx7Y?=
 =?us-ascii?Q?U4ShA/3/+XaAC2cWkBnHZcGme3dvta0AQJ2wr+xvEqwGTj0216i5hzt+5fQy?=
 =?us-ascii?Q?E5nO76eEx0ILixXGqn1HuFyO1hYB66CPBwUOwonw75TK90SOx5juABMmVZAE?=
 =?us-ascii?Q?ZsQbdgfBjW59SprhI4I7JC6nnWe5NTtz7L/GGIlPo46cvVSvRLKZZM6esWUI?=
 =?us-ascii?Q?5cn1vmRa5QH2j7Xj/KD0va5Uzr6nh2GGvuUEythjE7lq+eIaCO1XbtKn9OeL?=
 =?us-ascii?Q?SpS+gX7+JhVdGxV5UqyqWfMF7BzHxT1PGdHs1scLTJ7DR7BIvgSae4HqoGAe?=
 =?us-ascii?Q?Tkf6aOGeyGf8MuuFRMm1f4X5nsZU2xout6vWGNJJy93c/b0Xzp3AHRZFdoFT?=
 =?us-ascii?Q?jsogt04leUBNUqsGIHuWKge0PajasQzaIRUFvjgUj+Ko6OG65JX9xy6jTv4V?=
 =?us-ascii?Q?wx0c75/Lswfu3dc7qFhb3AJEWn4sO83+bSyV/qy9E998xsPljPDVDwEyXOg3?=
 =?us-ascii?Q?3pM5UaNaaM0CpeSKcH41XtYo5BDGCeIJSV7CWq+Xb27zfykzmMMZkYWXXqPQ?=
 =?us-ascii?Q?XArX/gbLzaeHKF2Y9j6J4W88KfxSld6J6eqIlNx/ftj11ZFl4Uv3Itnmvi2b?=
 =?us-ascii?Q?KrmcvpCx/RXG9GzKgVeH0FX1a7QYVzoQRhSLp7+NLQ0FwqYs4p3HaggObCbF?=
 =?us-ascii?Q?k6+LV/wYb8ZrvE2W0U/VNvMeVDeHzvGVB4K042WiLq5RLruV5D4KWfMM0CnZ?=
 =?us-ascii?Q?J9oIms/SZpDiw27OkfHduXJu9y2Hpfvdhb8z/YQysZiip6jvURTYaqF6VtzO?=
 =?us-ascii?Q?rSV18kHQLzOKlsucngQPU8BdOIXA7piN0K8OKclS4K9ctPT+sC9QbQR8lhp6?=
 =?us-ascii?Q?nkBeYSRTABvG+Sj2DuA3XuFgdkuCe44yQsf0Dg0f+lF/6pCMoHHvITK5XhZP?=
 =?us-ascii?Q?9m36+Of7KOyIfZGBUWoUcrwSrH6s1SOyEFaDNS3rjzW8XvTU13vYmxKUA84G?=
 =?us-ascii?Q?H6gWfK7Sx6E7Myq/bsdaxM0vBD9mI6HtvxB8QHS4c/7eGTWfvmclyn4C2PgW?=
 =?us-ascii?Q?tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c99f39-3687-466a-1802-08db09b49158
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 09:12:13.9665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXi9NHNbbbW3A6k4pTe9WGcA2/MtVFAhD2XQuAZN5T0gWGDwrrG4yxphqmKB/Xn25seavbCqZ8vOBOxEDFVv2A2xqBjqzhhYxoRTN7he6n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

> Subject: RE: [PATCH v4 1/2] media: dt-bindings: media: renesas,vsp1:
> Document RZ/V2L VSPD bindings
>=20
> Hi all,
>=20
> Gentle ping.
>=20
> This patch is reviewed by both Krzysztof Kozlowski and Geert
>=20
> It is blocking for accepting SoC dtsi patches[1] through renesas-soc tree=
 1]
> https://lore.kernel.org/all/20221122213529.2103849-1-
> biju.das.jz@bp.renesas.com
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
> > <laurent.pinchart@ideasonboard.com>; Kieran Bingham
> > <kieran.bingham+renesas@ideasonboard.com>;
> > linux-media@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> > devicetree@vger.kernel.org; Geert Uytterhoeven
> > <geert+renesas@glider.be>; Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com>
> > Subject: [PATCH v4 1/2] media: dt-bindings: media: renesas,vsp1:
> > Document RZ/V2L VSPD bindings
> >
> > Document VSPD found in RZ/V2L SoC. The VSPD block is identical to
> > RZ/G2L SoC and therefore use RZ/G2L fallback to avoid any driver change=
s.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > * New patch
> > ---
> >  .../devicetree/bindings/media/renesas,vsp1.yaml     | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> > b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> > index 7a8f32473852..3265e922647c 100644
> > --- a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> > +++ b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> > @@ -16,10 +16,15 @@ description:
> >
> >  properties:
> >    compatible:
> > -    enum:
> > -      - renesas,r9a07g044-vsp2 # RZ/G2L
> > -      - renesas,vsp1 # R-Car Gen2 and RZ/G1
> > -      - renesas,vsp2 # R-Car Gen3 and RZ/G2
> > +    oneOf:
> > +      - enum:
> > +          - renesas,r9a07g044-vsp2 # RZ/G2L
> > +          - renesas,vsp1 # R-Car Gen2 and RZ/G1
> > +          - renesas,vsp2 # R-Car Gen3 and RZ/G2
> > +      - items:
> > +          - enum:
> > +              - renesas,r9a07g054-vsp2    # RZ/V2L
> > +          - const: renesas,r9a07g044-vsp2 # RZ/G2L fallback
> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.25.1

