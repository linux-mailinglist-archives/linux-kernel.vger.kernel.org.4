Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10C6C110D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCTLoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCTLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:44:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BBA5FE8;
        Mon, 20 Mar 2023 04:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D10OUpm3dfILsM/a7RsVrwAUhnOY+QiQxP0RelGBLfzkHu+JSPt3/A5xVYvSHGpvtWn75mhDFvrom2BGSBQN2EWMg2tYw1aDzj4DYpqP60jTP0BbOHJuM5cRv0964OQou/RRvWTcLFfjZLDyp6Zi7QrDNCp8/ZZTFw+otY/jLu8ovEU8S1acMn33beQE8f9yBiOTqXuhzZ1SHaSEIjdo/raDZTWxWgjp6nZNq4g0ohBlK4dpuDdDrXTpvsURN0ONITPfDOmVDyB7MKdIcqNYOkBX4BfbGXakziJm74XkldGiu1pm14+iMc5IJtobKh48ZCWU5LQtsrDbYQt/GL3XzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOG4sEHHLZYz6oerVEoBLkwlFj+DviuLfTGUcGbKyDk=;
 b=GEq6AOq7XYaVKRBzdLFnB8/qBCdPi1x+OeKMU/ovYpXNCswLgY0RThfkLdUM6sIL1nfbwpquLJD69XNTzqSzwDGaF8ovq8JAWNCVqqm0KG0ET/NRhgdf4B/x+RoS4BaTcbqarrvdHP4nb9J4Qv3CSNNH4u4jeMFmavEKLCDJHDQO5MSCgck5FgJgaiaXwJCoyHHgnZotw2T4tZTYiPRnE9ajrzPoMeFli2IoG8hU5DrE6TItgW1dmGULw3m1AtgfPR3HGckea0RpxrKUrCTGfVQHpw523GsfjRf/Mzs8U1+QoqpJppZxvDYnkr7cb34ZNCITZXBWQUPo6iiXCR3fKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOG4sEHHLZYz6oerVEoBLkwlFj+DviuLfTGUcGbKyDk=;
 b=EORssHp7Nx996i3ksltSBdAYVJu1rKiX6wRvv1hjQkrRyhEZsgJfEg+MBHostzkXbxm6OBhVixWjGDruCzmzaTpLkmkRAp0NqYjr+COd4c72k56m7HrRlHU14YCVHE6zL01GKyicB7DHmVUBxTWDQ8gacjfGQPS2FjAzxtQU7/I=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7535.eurprd04.prod.outlook.com (2603:10a6:102:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 11:44:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 11:44:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct i.MX8MQ
 support
Thread-Topic: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct i.MX8MQ
 support
Thread-Index: AQHZWs/6lJ7epjxGPkeRDAwzZgO0X68DPJiAgABD8SCAAAsMAIAAASdQ
Date:   Mon, 20 Mar 2023 11:44:25 +0000
Message-ID: <DU0PR04MB9417FBDEC58F46C069A359B888809@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230320020714.955800-1-peng.fan@oss.nxp.com>
 <8efe78d3-ff50-1970-3a90-28bab4992bad@linaro.org>
 <DU0PR04MB9417D88E67200F4A74C5CF4888809@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <355d5dde-cc86-018c-85d5-51cf59bdb36a@linaro.org>
In-Reply-To: <355d5dde-cc86-018c-85d5-51cf59bdb36a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7535:EE_
x-ms-office365-filtering-correlation-id: bbf09f5e-70db-475a-5042-08db293874d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4iF2gkbo8kYfMea/HJLTdNouWWAM2gMICVitoTgHODyVMgZDBM/m3fph+v5k5H2p93uL4E4rt0tUdi9v2WceNJetng7VOs1wIvsljBqB3CdjOesT5tk3vieHQlyqCqqooNA+WZ0SncAozA545WGbjtKCoPm0oR6EDuslbO6v+XsyKBPRQR5wO6PXmcJrwkDf745HW4DaZJaQjpzMAFxGkCHcAJv+Ku3EOGx/wDIfSJrPtRSlLhu6zL/VlHs+ZdOj5KtgzNw6W1b9fyDRANTfOmSrF5BQSRPpLPez9MHSxxzML/tQeINrh+lzpsExaRIWaubBvXs3YAnAYoLfliuk1bPAmTI1xqHdkEyzXH9zyIASpY/jECk2IFbDUD+y50gmdewlmUcMyyb65Vduiuv4aUbAZj6MXDNB6JrSIGLeyWUdYtipYGecWOEohjwzagS4Zyjqr6nvGZBg+ARbTbNpvFlPrmJnyyHrUoQbVZ7sVDcK2SqolzYlHtQELvMFAk1Wsb4f4sSr6Zv+j93HPw0I9Rre84xaDSJBXCsDnX8VAzHCiX67rzfnuyi/cevDx1YWDunEvlt0Pz5vm4jGRIFGnMzh7+MiYDnQ0g5JTb3JdS4Ex352q9v9UlwjgyiGAx6ElTRmXanEvKdDP4z9TZE3DNk4HJfNT8XM6Www79t7RZA/Vt7zSUWacrImRgBm9BgIlkjsDwoVUeh5gs0PU1G6OQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199018)(6636002)(83380400001)(38070700005)(38100700002)(86362001)(55016003)(122000001)(8676002)(66556008)(64756008)(66446008)(76116006)(41300700001)(52536014)(66946007)(8936002)(5660300002)(44832011)(2906002)(66476007)(4326008)(26005)(7416002)(7696005)(9686003)(53546011)(45080400002)(186003)(33656002)(966005)(316002)(478600001)(110136005)(6506007)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+5hbwALPO3mR+pu4JqFqQIRmixYXg+/9zHh8MB6jIZbUr6ytjHu0BLKBArty?=
 =?us-ascii?Q?0GIxVE/2eIxNcN9zN02oE2xn21dN/Td2dq/+xTxaMrzx6jIBit3b1no7Zzur?=
 =?us-ascii?Q?+GInI1vtSqAjIQ6Tg/G2EviTGpWp5HrsjiQ3cr8B0qR8d8attr+FAiZ91E86?=
 =?us-ascii?Q?7AG+SXEswGXv7HAprAzt0fxB902cZsb7d4KaxQeiYd7y936vKOaekrYxwRmi?=
 =?us-ascii?Q?n1k4MsW2vKrf0r+KMMpt2UjAPiPNfy/7lWtJ9kWSn3s0gXZOk8XdiYjuPvUn?=
 =?us-ascii?Q?L4hymzTBH7wFgSi9BgA0ap5EbqM0PVrE5Lr68TBm1YECG7/phwDTKb8H3OoN?=
 =?us-ascii?Q?pgGSWYMbEhuzJkGQ7nnr8BAOAvVyt25UF+9JabsGhUTm4/7hRSNQlTabqctx?=
 =?us-ascii?Q?L7NTFT4BGwlYRV1G+8i1SvccUfsn6V4gJHckuTDcfmRkdFPQZdog49pOrrnm?=
 =?us-ascii?Q?UxINbqVozNMxQIP1SqIUBayu3+Zk2J7lOtgubvBuebWX0akfgph7n1dBAD4X?=
 =?us-ascii?Q?QxYuV5CnbmQpQE0RIadD3al49RdgYIv2tjHGxtleNM88dwtl6mtKB+5UShyN?=
 =?us-ascii?Q?g0ko+rV8975nXyi9x6aQQMtbSz2k8W2ktsEGnT25eWnk3zyrVULP7/NYVJts?=
 =?us-ascii?Q?VadJr35ABdX+hLifPcQLhoPgLn19i3k1LDaPcFUplG4XrAkav1PXQ36c4iCZ?=
 =?us-ascii?Q?msKalBdid/kj6hFvtyD4WVpLyy1i+4JFYgQ9fTjhy8qro0fshJb+yxwSEJqw?=
 =?us-ascii?Q?qHR2GXOq3rpFu21rklq0P9IzYTDbnROYrgISqi8q3xJ/JyhOosH8rSL5c2dq?=
 =?us-ascii?Q?ov9ZaQNATGL89tgxVYEr/6/ArXMbrkiVyfKsQ+0lQZmUfrHNPAQqZic38xkF?=
 =?us-ascii?Q?9FGzSOVz0YmkydUc6KSOV0z7ZhoCzwjIZMztd6GE8KiGVDcWTZj81vyXKyXU?=
 =?us-ascii?Q?QqxqEPifqvgOoUjvlSvjTEVIRk0Q1fFCCS/1uIJGGWjP+XMZe6yXaJDwZG8Q?=
 =?us-ascii?Q?/SgnsEenqTuYX2yrUau6HvjCTBRkYhXI+Twvx71GoGF2IfreA0clAt9kiquB?=
 =?us-ascii?Q?Elnsi51XUFKsrI+RCKl8Omx9tu70wBK1SqE2X0YCqfmIH/OMRpjrIsykGVt3?=
 =?us-ascii?Q?SmmnnipyFWr1l47nFlpGawGkT7r/lCZO7TnppMjeQ3PMW5UJdF5lgxd2hIbM?=
 =?us-ascii?Q?ZJ0D3c+BsNfcPNaqlP4RhyGddXf63Ep844/AEU5pO2MVbZhZvGC1fyIstzRZ?=
 =?us-ascii?Q?x/G0d1sBezDEYwv7ULkwl18uFyWixdbs8+6M2zyk6adc7Sd8XNrfdjKxEVNV?=
 =?us-ascii?Q?m7rqELs0CfvTX9rSa5VQUKE6ZCLenFkQxRugLwhVg3ILHuMF0S2EsC7hjQAA?=
 =?us-ascii?Q?9zHwNp0ZVinfj2ZRkTmGujlHVYKaBkeotrgs/ClOM+oyY4hCM9z2EAb8nd9W?=
 =?us-ascii?Q?zQBQGY/QTqlrUJLNzMLllUHiD2B7WRB1E4ze4dnHhCMkxHNggEkj8ReLCtN5?=
 =?us-ascii?Q?C8CEE7CBAe2HNEqy4pcqwvgoLSAPzzCmihvkUx8GAsC8O2yr6Hse0tTshnk/?=
 =?us-ascii?Q?EKAxv3bdYlBGNiAtly4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf09f5e-70db-475a-5042-08db293874d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 11:44:25.8076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xcAvZ1tneA+MdxKbWljMQJSO8Cena1+PfMwQwnpOHc+qXb1tJwy6ZRJ3/WrJ9+gKoGxjukqhGlCkzS0L5IgIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct
> i.MX8MQ support
>=20
> On 20/03/2023 12:02, Peng Fan wrote:
> >> Subject: Re: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct
> >> i.MX8MQ support
> >>
> >> On 20/03/2023 03:07, Peng Fan (OSS) wrote:
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> The previous i.MX8MQ support breaks rockchip,dwc3 support, so use
> >>> select to restrict i.MX8MQ support and avoid break others.
> >>>
> >>> Fixes: 3754c41c7686 ("dt-bindings: usb: snps,dwc3: support i.MX8MQ")
> >>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >>> ---
> >>>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 21 ++++++++++++-----=
--
> >>>  1 file changed, 14 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >>> b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >>> index 16c7d06c9172..6347a6769ee3 100644
> >>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >>> @@ -28,15 +28,22 @@ allOf:
> >>>      else:
> >>>        $ref: usb-xhci.yaml#
> >>>
> >>> +select:
> >>> +  properties:
> >>> +    compatible:
> >>> +      contains:
> >>> +        enum:
> >>> +          - fsl,imx8mq-dwc3
> >>
> >> And what about all snps,dwc3 devices there (without specific compatibl=
e)?
> >> Previously they were selected and now they are not... so you just
> >> disabled schema for all of them.
> > [Peng Fan]
> >
> > I am not sure how to address:
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore
> > .kernel.org%2Fall%2FCAL_Jsq%2BnrqTX5ND3%3D%2BkFUmStx-
> %2Bb%3DqpE_WsL_Le
> > -YX8c285-
> 5A%40mail.gmail.com%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C1e
> >
> 67df79692243f058fa08db2937befd%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%
> >
> 7C0%7C638149091586933618%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiL
> >
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&s
> data=3Dr1
> > fesB1c%2B3YxohCGM36xySFucVU25WVYIMlpgGkdoWk%3D&reserved=3D0
> >
> > Rob suggested use select, but I am not sure how to use it here. Use an
> > extra yaml file with select or else.
> >
> >>
> >>> +  required:
> >>> +    - compatible
> >>> +
> >>>  properties:
> >>>    compatible:
> >>> -    oneOf:
> >>> -      - items:
> >>> -          - const: fsl,imx8mq-dwc3
> >>
> >> I don't understand why you remove your compatible.
> > [Peng Fan]
> >
> > My last change drops 'contains' by mistake, and breaks
>=20
> This I understand.
>=20
> > rockchip,dwc3, so just bring back the original content
>=20
> This is not a reason to make your compatible undocumented. You basically
> revert your patch. It does not make any sense to me.
[Peng Fan]=20

ok, let me think more. Honestly not have good idea (:
If you have any guidance, that would be helpful.

Thanks,
Peng.

>=20
>=20
> Best regards,
> Krzysztof

