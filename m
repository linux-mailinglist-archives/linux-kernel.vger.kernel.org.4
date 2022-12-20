Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A7652859
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiLTVWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLTVWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:22:15 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CDA1EC5B;
        Tue, 20 Dec 2022 13:22:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwbqEqeKPMfw8g2eIL4e5/JHGQ/4xdfNkUFbRVq0Bjh+JuPyVEudZCcGFgxuikJi7HZWk0Uc35ZtEjOg38DB711kaAgXbL5xAxSzumCzpxK/ElYSOcPQ/+YTIU6ezs4XCIOQ0l/yS8Y7iZRo6zuBOvoyOy9lEKBSwZUlaEEgqEE27kk1uyGJfm0nJLTY2AD6KfMyG15/6qaxTUxO2p1KhknG+LoYAOYjUo8zyAHNz9dyOq4jDBCLWGPiSiBF5JP+jfoePwJpfdjzasZwciAdYLuVL/a7qZoE8fuvA+7ciqJPh+eiWGmLGHTBR7LJCAMxoYQ9mCXCnRAOdsZhU597jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOs/dVj7DY1qBdgtIwky7k4Kd5HS2tKmfWFKLztRlBc=;
 b=mmRzQurZzs6TPTRMvlelBcwHoIzGy2hbGd5rL0osFDQ0Z6TLOpgxajXABYgzlbVmIEY4TcO1+Jlb3oVY1zWOBRZxGPa9hjnGEwVkNPMDzS18DRtFm8hIektaCxFA0VUeYOAv65K0sp33INr29TUyv2DBhUAObcHLFhn8bPKXOzhlgI7/jvABJ12c36dTJ3AEgiIZl8K041Y3LIiQ0d34KpLiXPUy4BRDkFnVN6aYBYJf5IlP4nA3WDxVYiG2CBhMhBXi/whA2Mf6jtEbjsEeUpgzfAUFGtwLah9rqmxcoMj2nxpten9WnVrnPyIcjps0qWi3AIAy5Gq76VHrA3j5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOs/dVj7DY1qBdgtIwky7k4Kd5HS2tKmfWFKLztRlBc=;
 b=VmTdVXgNKgd+EF3JJQhuGElSOBwN3aB3OV9zM4Ib8Vt1+jtJ25tkJnkU6Gep2R5dMIaTTODzgrNPWy578qe+LQ0lBmvs9yAq5bU7nRStmkfG17tnIkYlMpZfIqrkJYBeXeLqfr1guYZE3S5cTYfxinIcu3CEOw+tWhw9pa2En2Y=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB9422.jpnprd01.prod.outlook.com (2603:1096:400:1a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 21:22:12 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 21:22:12 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Lee Jones <lee@kernel.org>,
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
Subject: RE: [PATCH 2/5] dt-bindings: power: reset: Add RZ/V2M PWC Power OFF
 bindings
Thread-Topic: [PATCH 2/5] dt-bindings: power: reset: Add RZ/V2M PWC Power OFF
 bindings
Thread-Index: AQHZD0RTibrnAoAXK0KZj5lZ2/4nUq5utr4AgAichIA=
Date:   Tue, 20 Dec 2022 21:22:12 +0000
Message-ID: <TYWPR01MB8775F68FD5F270350045EDD3C2EA9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
 <20221213224310.543243-3-fabrizio.castro.jz@renesas.com>
 <0161902f-1a0c-0be2-2141-3c14d6e6fe54@linaro.org>
In-Reply-To: <0161902f-1a0c-0be2-2141-3c14d6e6fe54@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB9422:EE_
x-ms-office365-filtering-correlation-id: 4b52c876-5d1e-452f-715e-08dae2d04287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gd21cFX02Vt4QlaZQigpZSl8fOorzuy+XnIznuqFMhKE3A6daXZqffTfN0VSvadYrkORhyul8TlGHObtQEnlnAvsmBhjE5wHB+ZUvKTgDWkQzJCsDuR0BW5993UpWIYCumG+hN2pKitY32naMs2oPtxzaA3oAdSKgDPz+cymexAO+Gny+xhJQWMvNyuyJwfYvrbrGUHvys6kUAgbyDx7TQEUwSpAK83+WXXIYXRrDdZc9GoN0D7ToXHR8WP6aEqHPgH7CHg4IE/mr5AMnAoFPuHmxCr1tsm1bQrU3WZLpl1TFNC0I8ng91yix2sbqzs2X4Hte87MV8lhp0K7IUi0NH5nsFHWvfGiJjP2/qwz6X3dnp+vlDY9+87wD8nBtbA9ywht8C0Wy01J4HclSNGj6btX7rndyAlB+Dby5H+o5L1yjmGQPVTPSV25vPpHBFNn5DZ6Z+6boJuWwRDXar6Kjowi8fw5nGsL/InpHuVraF55iylpnUSmO7HPgZc2IGqt9Y9aUHV60bxFWDiIEhAkNoN1S0aXk9AJK1xE0TK+OXVjlNtA4SSgt9zm6/fgWaO+4szoxOuaMyiT4yeiyZEQupXB+Dn8JaozdwmE87ITsEsJUZvEPHRpRTCfmsRGSYCILyMeYp/322eVuHWvwdjmgDiAdEQwFBZCZn137K+LZJyttQZCVJWIIqPFHgt9tIT5aGFT1lE41xwVwvlipqBecw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(86362001)(38100700002)(52536014)(71200400001)(26005)(41300700001)(7696005)(122000001)(8936002)(186003)(9686003)(54906003)(66446008)(66556008)(66476007)(53546011)(8676002)(2906002)(4326008)(7416002)(66946007)(64756008)(76116006)(33656002)(38070700005)(55016003)(5660300002)(110136005)(6506007)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tTD1elBYoi23ovnt/NDjLZwM2koTVq3tKi+r5YmWWgZ0CpseQQ5aRsdg0uFd?=
 =?us-ascii?Q?TYQnoFiu0zjHJcQHxgZ9PqDK7HfTrkg4LWJ14qoT3Oc2JdTSLg0rg5y60vxZ?=
 =?us-ascii?Q?fSMQ63YaS3yr50Y4uYzI9xrXaEJRYnoD/ybwv4gqRB0/CpDPTl8d0eJZuAt2?=
 =?us-ascii?Q?rGKin7NiZxWVr3g25y//vSfeY1PDLPiyzpSxTNPV0O5xPsWFrJuHv9Ab3Ofk?=
 =?us-ascii?Q?tmFltmtm+TihZd4ZqH/NEz4V6wgl6sNYnWraGUwtyqFILOY98yX6UE+tAZps?=
 =?us-ascii?Q?luXJ4O/UcxkZjzlWKFaWtzNnHBgTJGU/Vvkr2RUDif8tpukB/4qlj5v6jfNJ?=
 =?us-ascii?Q?+55dRlhAubGfQNIXDlOyY/Y3G66+rlVFez0Cr1SZGQRVC7WOvPTYT32eLNlE?=
 =?us-ascii?Q?9S5bSK1KnDjTjC7ktOe210rJg/A6kTpjW8RmpgRJbW3fID/Q4uqysXAEsfTo?=
 =?us-ascii?Q?AUFAsVoeBDXgiet9WBgXXFP7snkX9GoyiWIVRxXQBCNze3LvhYhppRVhwF2X?=
 =?us-ascii?Q?kv3Kouo2K6ANO7zGilf4H4HP+IunSLvHgNnZAMceO4qJHwYTbVuVy4wpElaN?=
 =?us-ascii?Q?WhM+pNXePg3D4a7QbRHww3gyxnFt9Vif8l5fLqHbE02Tf8DrmPPyTXnmy1RS?=
 =?us-ascii?Q?VV1UlT7Lv6g6wKMXRqh0j9TFVIKjz4tlcHfKl7vomV4jm3kyd9L2WwLemSNp?=
 =?us-ascii?Q?EBnV4CbfudtNLn19KXBTbeJg2x5o6w/tnyfUApsLw0SdKP/S6T5hZdOnDAjg?=
 =?us-ascii?Q?WSFjQyt3/iSK2ykvmqzyLF6Q9V/Lu6wGtVI23eoOUG9VLcq+kwEs6YQ1j7Gp?=
 =?us-ascii?Q?g/qCbNwAS73Rf8X5D3DpmMgwfeFLqO2wF8EvZx2MQw2GOyxYlLQKvRGp6G9k?=
 =?us-ascii?Q?lSbe1s4Zvx0GZypkWC1eAuFHocXQ7as+U0HhlD2pMwubFgMMEYe40GuYbYqW?=
 =?us-ascii?Q?efLAu9LgWf+LLSk7x0BuXsUubczgcecj2PSjNqdiQig9O15VP5W7zxgEQePe?=
 =?us-ascii?Q?Jbp11GeyTsFodjrBY+7/HBTnwgPh/xhiiz70lx55zKSJWIKHqKjQDWGqYhf6?=
 =?us-ascii?Q?OGzIhrkf98zDQctE96SUzqj74OYgn0ROi5vRcCAI61iK71OqMxDKkfY9aCCm?=
 =?us-ascii?Q?YzWQQYt85iSULa4wBiSknSFbJIuX8zBsxT8yMPY0i+0nnVjAFFAYSNm05A0a?=
 =?us-ascii?Q?FgO9tkg710uqvPyJVBYbrtByFqEzD6NYTz2aqLHPYTUjMc489XklAB3r43KE?=
 =?us-ascii?Q?cNo8hhhAlF0opMI8QSIO4cpKnwchwo9fT5sShBVCDwKN8WRK3RWFkq4f56X9?=
 =?us-ascii?Q?vw//vYnG2nJGSy8tYw9WzR17/x11gcJl3ahpnF0GbeUA08Qs7ojhsNpklebF?=
 =?us-ascii?Q?wxVsXP+DcZYOlzfCm4QQ0PojFkyPfTUAYgFlktg+COmL1XiPWI2jPon+YONr?=
 =?us-ascii?Q?OilqyErMzsPZ2L31nSSmOORkv9h4Q6tqYmKXNN8zb1QGpPEMmW5cum/Ul4H+?=
 =?us-ascii?Q?1vwy/5JNFK0Wuzg31wt8gJUve7iRO0uezzNM+XR/01gh4BFmuaVBy9RQYPm5?=
 =?us-ascii?Q?fzJVVyj02ikSI5vpaUfhIYikVUnJW2WWa6g+boxbSTCLVK0dQ+Kppp14Lhil?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b52c876-5d1e-452f-715e-08dae2d04287
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 21:22:12.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bO/kg8+AatXTQefI/W26KOMPGx6kSTG8EanUCokgEd1lSITCe6g/vnYzzoTRnRHSJ01g8jThTr/XbLI7pAYK2+GRONm3SE5QDCke+2pbQks=
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
> Sent: 15 December 2022 09:50
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>;
> Subject: Re: [PATCH 2/5] dt-bindings: power: reset: Add RZ/V2M PWC Power
> OFF bindings
>=20
> On 13/12/2022 23:43, Fabrizio Castro wrote:
> > Add dt-bindings document for the RZ/V2M PWC Power OFF driver.
>=20
> Drop driver.
>=20
> Subject: drop second, redundant "bindings".

Thanks

>=20
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >  .../reset/renesas,rzv2m-pwc-poweroff.yaml     | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-
> poweroff.yaml
> >
> > diff --git
> a/Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-
> poweroff.yaml
> b/Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-
> poweroff.yaml
> > new file mode 100644
> > index 000000000000..12456e3e93e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-
> poweroff.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +title: Renesas RZ/V2M External Power Sequence Controller (PWC) Power
> OFF
> > +
> > +description: |+
> > +  The PWC IP found in the RZ/V2M family of chips comes with the below
> > +  capabilities
> > +    - external power supply on/off sequence generation
> > +    - on/off signal generation for the LPDDR4 core power supply (LPVDD=
)
> > +    - key input signals processing
> > +    - general-purpose output pins
> > +  This node uses syscon to map the registers relevant to Power OFF (th=
e
> > +  register map is retrieved from the parent dt-node), and the node
> should be
> > +  represented as a sub node of a "syscon", "simple-mfd" node.
> > +
> > +maintainers:
> > +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a09g011-pwc-poweroff # RZ/V2M
> > +          - renesas,r9a09g055-pwc-poweroff # RZ/V2MA
> > +      - const: renesas,rzv2m-pwc-poweroff
> > +
> > +  regmap:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
> > +      Phandle to the register map node.
>=20
> This also has to go.

It'll go

>=20
> > +
> > +required:
> > +  - compatible
> > +  - regmap
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    poweroff {
> > +            compatible =3D "renesas,r9a09g011-pwc-poweroff",
>=20
> Use 4 spaces for example indentation.

Doh, I'll be more careful next time.

Thanks,
Fab

>=20
> > +                         "renesas,rzv2m-pwc-poweroff";
> > +            regmap =3D <&regmapnode>;
> > +    };
>=20
> Best regards,
> Krzysztof

