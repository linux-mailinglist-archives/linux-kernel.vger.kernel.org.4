Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED56A52BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 06:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjB1Fzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 00:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1Fzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 00:55:47 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2500F19F32;
        Mon, 27 Feb 2023 21:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbTQ1XoGd6UWT50++WN1xdSP/Cr9A83g+LlCta+4g6C79S+AUhT2Wb8fHLcyu4h0sHyWZ/SJAz5N4HRuF3CXoX8cLpgsBGYD6fS2tVhaf1V6Qnfzno4Pqekk2GdrsmDVoeLIeTLNakqTSSN9SqRZ50bXos3WgFTWnCGeH0wAlLP2VXXqF8qCzN94DxKuVNAwZ95vFcdOmFp8HNr2ztYesDJ3Qd4c38AJ+e8syMttQYMtczlqS2jlGa22OQ1cmr5RtFiUuxScHsvJVSBxRFWJj/QULciLXya0IKbpueUS2YeKofTrvJEQnMNqS2VEJDmxHW5EkW6cDwUavEXE0j3UlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z25aQigcUAku7Yfyq9rkgDyyRVWBpF5v3xX/lLlTXvU=;
 b=kIXdoj99k62jm63eAvi3syKqk3Q6u1vEUxesUNQsxfJYW6S5ole0tDbdMpyIT0hkHZDbX8KjDqUUAmQrAH80c5A4JeB17yOR8J7PsuaDvBwZ0ZMPxPgdZLbNc5uPf7TKHoOqKiNtHK7xuKx/LMPE0IDLLm+tEw/J8eDMCDO6tVdNSTQcBat+qymAuN62XCcjyFb0gRnx4pVk030M69v5dzxaJtXtRZVQd/74PPkAXOvdaYkFHcr4m0sUWqxukjrobPeaWBvL+3O6kqTs0ceR8A5WTqb09dxzL7cepsY2WxPVEbdJMEaoUUJqkLJuoSmMdYWdhJ5sONJV7sz3UTUWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z25aQigcUAku7Yfyq9rkgDyyRVWBpF5v3xX/lLlTXvU=;
 b=DsPU+kynomKBT+ONr0zTOX6UnT5ADNeLjsKGt86tpog5dvVixzYeRHXG6QyjkWtkqvlyMxTAANjcb/5Fb8/+vrzavBwmnJRbkemc+bJbm17JMVgW6HD8tWPyfMWANO7GNnVKc1mz171JBtJK1TUz0fwovhCOSdv2fnUkn0w0JOg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 05:55:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Tue, 28 Feb 2023
 05:55:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH V3 1/7] dt-bindings: usb: usbmisc-imx: convert to DT
 schema
Thread-Topic: [PATCH V3 1/7] dt-bindings: usb: usbmisc-imx: convert to DT
 schema
Thread-Index: AQHZSeJRkcdiIOC050mFYy8QwdoUHK7jRwqAgACW12A=
Date:   Tue, 28 Feb 2023 05:55:40 +0000
Message-ID: <DU0PR04MB9417EDBB2ACDC761D6D6C31488AC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
 <20230226130539.277336-2-peng.fan@oss.nxp.com>
 <20230227205229.GA880857-robh@kernel.org>
In-Reply-To: <20230227205229.GA880857-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8953:EE_
x-ms-office365-filtering-correlation-id: 6f2066a6-a00d-4b51-3082-08db19506c6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2w3otHt6keeiIJw8mzCgG2rWkrbOoN/arq95U7aRZ75KNgMoT6AlsbIIObQpt0qzU6t0JzvNt8ABvi+iDquU/DFZVNNnQLLu+hz1pMDgOYBs8ObnG9SlyeTb/irdi4JzBX+ZY9CJSjkshpskg4Qe/puWwvBYxu5zrDYwy2FbndReiEJy1JS1hWz4+uqjqyAyNPVN4zO1KgA7Ad/16aR62UGSmRyxH2JMo4np3ro6xQNrmE5EZcGXnfbA8TKa52vnnXUN6BNH/60K3aXeVTf4Md/0JR3yeto+aMhDji4alfLEmKn4XkEq5v56MwtykXt6Fnm5kUzUPSwQYMqQ8nzHN9GXw6M6bJKQQmf3iMSum59pX3QJjLhJieSdYcZXAcSTwn53h32h83mTJ5kvJlTWMM07EVAZ4IM6AXzEH6v4CaOk1HtxlzOBCRYvj0ZrEIRon+cE7OZe9En8TDovoQdIyjZaSpwPx7ZLB/4aDVZnN+pGXeS+ejKbNNNZ6xXRNpKHiHDzJIQLA1TpVS01Y9Pq4YupE07HbCubqGOyWeCjkqo2r3qIkSoIbv4NgAY4BhoR0W28ujpVHhz0GH2tkCgd56GMc5zmrz7SvD4Pb/fUdmQ/4rvWn4eZvS0FMWgz/uqKDWYG/7/XTMOa+iKm2wz+2vCxDU+3MLfyclssGWPSZKiq4/nCQmgSovGcIjYyP7irQb6euMAoyZwNDV+unOZ9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199018)(122000001)(38100700002)(52536014)(38070700005)(33656002)(86362001)(44832011)(2906002)(7416002)(41300700001)(66556008)(55016003)(66476007)(66446008)(64756008)(66946007)(5660300002)(4326008)(8676002)(8936002)(6506007)(9686003)(186003)(26005)(83380400001)(76116006)(110136005)(45080400002)(478600001)(316002)(54906003)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h1vAcqOb+o+4zy6SCSJ9r+rcBFhAj20W9HPZoMRiX/abERw5mDBJyvOg3lOF?=
 =?us-ascii?Q?33VZidU6dtj2rZuSa8kKdvClCOkdTSny8GBKouTSd4+72j4TBGdbw5nq6xpm?=
 =?us-ascii?Q?6kA1adOQiumt+99/mssJCRdptxguhfJ1mqRKSj3ksBlOUK0B5AWi6hN4LPZ3?=
 =?us-ascii?Q?opOJPN7pSb7FZPByJ1TK3WPV0vqA3uIEJ4A4vrffzHITvIRRi4rUiDTc/zai?=
 =?us-ascii?Q?FGVoGgkjzAnn8rOthzb14VekPwMs9Em2RUEPMVjw5oZAXtwptYSxTL7MEMIZ?=
 =?us-ascii?Q?1KnQ3k0Mu03aanTOZ3tvdL7SD8njGBxZ3a/5CNQaEhM9Jw0CeJx2KTslcEEu?=
 =?us-ascii?Q?IGB4TJClu6W6dWwKRQjxqlN/AtPl1IbcKM+J4663gieZ+rCI6xKBV0yA+yds?=
 =?us-ascii?Q?TthR+d+oYPhmDBMrdFvvQn/tPB6JAYK7GFKhOjE3nkA2l5+JCqiKJ1VAW4Qk?=
 =?us-ascii?Q?+s88U5XTXyPYkMOMfbV9GR7zmRSbh7H17W/Pq6ucdBvcJbmZ/BnolwDcmm/t?=
 =?us-ascii?Q?qvUfY3y0/rZTKeiryXs1bTr5Z7btGDZqGcIfSQe9OZtelw4DI3j6IrHGIXye?=
 =?us-ascii?Q?0EAHivzvqAEONwsR06lP8F7L1h3CtBpzevvwtyBiHoTgImJJotV25jo3pVHx?=
 =?us-ascii?Q?1kLbpAfbDJE1sZvyupT+m16BYJOF9P/4JAEkKqrh+gQrvty53p0fDWNNSpri?=
 =?us-ascii?Q?hUdEeg+BTh6Rhn9DwLCL6ao30jxUVBbvthFJbk/1oTsXExYFQZtSCwFRiI2t?=
 =?us-ascii?Q?qYV9pHL7HVIB0ygpSFYR70oSaAOGtdz+orCipj3EMsMebF5zle2wYwqIuu5w?=
 =?us-ascii?Q?acG8RfiDnUFT0eoMP2GKqSgIGltPqJmRPo/A721gYzOYjzT91mIK0DlmY7Ng?=
 =?us-ascii?Q?6LmQJE9kcUMFlUf0wEl/U8Gle+S2H6JyH8/sOThE11+GGYspGCPxrD6j+jUu?=
 =?us-ascii?Q?yOFlQx6V2KTfuK1kzbRO+zF7ZFAsRaSgsEFRU1oBBMlLNNmoEFeVSJpCtbBx?=
 =?us-ascii?Q?2B/7Oci3ks96PqB8QG/lTFhinR2rziII/tMl1aDddnIMDGsu6pzzp7ZCTWwe?=
 =?us-ascii?Q?fs1dwB5qL95xOvp2z6QXdI0oEFQTdRTEiuS0NURlb6yDEt+4FY9ihTqkHzrO?=
 =?us-ascii?Q?hyiOd65xyVKUO/jmPV6LgixCSBjFDQbKL+Ty5IIkSmG9bNEMbIGIQTbvjwH0?=
 =?us-ascii?Q?XTJCaOFCLaMMXoPirsRCZd+mRm614H2nAPcnB2o1ja+23wAoq27ONHvxtCoc?=
 =?us-ascii?Q?WJb0Zyd+mN8+L6M/2NKU3v0w1PrAqGHsy12SAJImG22MpG/nE6xv5/UyBHp+?=
 =?us-ascii?Q?gGyCIlA6nPbwY0tgF6y3dho2EEMLioZjQO9Asrztgrda38c6ThSUyAwO3JBB?=
 =?us-ascii?Q?TSRzFzVd/skbGw+m0dZHVzHOmV1jsUUYLmdQINuvb+fZgu5no58p2a8I6a6a?=
 =?us-ascii?Q?rk8MSGdBZgCyeMRu64TGvFlycHF5xjn27/UzWRqvw/bFYQzDK08/c57j4ZYj?=
 =?us-ascii?Q?bwwwf2Lc2561bxmdEZD8LnLAx/x7eXcv/TjSPeeZIOR9EeHUVdpJJnlc4Kmx?=
 =?us-ascii?Q?IZXkcmZH7L63sDuNFd8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2066a6-a00d-4b51-3082-08db19506c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 05:55:40.9983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CnEcvuh9vb0/Ds9CdNxxbOpFWblpFK4KZvIa9zddxgwhMUna7Wv8GxZG38WqMsNdGcX9M0bWYqMFITtEhIuWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3 1/7] dt-bindings: usb: usbmisc-imx: convert to DT
> schema
>=20
> On Sun, Feb 26, 2023 at 09:05:33PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert usbmisc-imx to DT schema format.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 54 +++++++++++++++++++
> >  .../devicetree/bindings/usb/usbmisc-imx.txt   | 19 -------
> >  2 files changed, 54 insertions(+), 19 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> >  delete mode 100644
> > Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> >
> > diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> > b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> > new file mode 100644
> > index 000000000000..517390b9d2c6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> >
> +cetree.org%2Fschemas%2Fusb%2Ffsl%2Cusbmisc.yaml%23&data=3D05%7C0
> 1%7Cpen
> >
> +g.fan%40nxp.com%7C688a52ac42294bd0a9e208db19048b8c%7C686ea1d3
> bc2b4c6f
> >
> +a92cd99c5c301635%7C0%7C0%7C638131279545141829%7CUnknown%7CT
> WFpbGZsb3d
> >
> +8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7
> >
> +C3000%7C%7C%7C&sdata=3D4V5Lpsj6g0mJqJyGZTVoFeas%2B1IvTEW0ERe3y
> 9vjsxE%3D
> > +&reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cpeng.fan%40nx
> >
> +p.com%7C688a52ac42294bd0a9e208db19048b8c%7C686ea1d3bc2b4c6fa9
> 2cd99c5c
> >
> +301635%7C0%7C0%7C638131279545141829%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0%7C%7
> >
> +C%7C&sdata=3DPVGWk1%2B9YP1vixM%2BiB4XDH0UKWTTM%2FOiA5aZiPcn
> 6Qk%3D&reser
> > +ved=3D0
> > +
> > +title: Freescale i.MX wrapper module for Chipidea USB2 controller
> > +
> > +maintainers:
> > +  - Xu Yang <xu.yang_2@nxp.com>
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - fsl,imx6q-usbmisc
> > +          - fsl,imx7ulp-usbmisc
> > +          - fsl,vf610-usbmisc
> > +      - items:
> > +          - enum:
> > +              - fsl,imx6ul-usbmisc
> > +              - fsl,imx6sx-usbmisc
> > +              - fsl,imx7d-usbmisc
> > +          - const: fsl,imx6q-usbmisc
> > +      - items:
> > +          - enum:
> > +              - fsl,imx7ulp-usbmisc
> > +              - fsl,imx8mm-usbmisc
> > +          - const: fsl,imx7d-usbmisc
>=20
> So imx8mm is compatible with imx7d, and imx7d is compatible with imx6q,
> but imx8mm is not compatible with imx6q? That doesn't really make sense.
> Maybe all 3 compatibles makes sense, but only if s/w understanding only
> one of the fallback compatibles would function without knowledge of the
> newer h/w.

I added the list according the current device tree in use. If using
three compatibles,  that would involve device tree upate, and firmware
update for SR-IR.

My understanding is imx8mm is compatible with imx7d, imx7d is compatible
with imx6q, then imx8mm is compatible with imx6q. it is just not put
them under one item. Please correct if my understanding is wrong.
>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#index-cells':
> > +    const: 1
> > +    description: Cells used to describe usb controller index.
>=20
> Please mark this as deprecated. If it is always 1 cell, then there's no p=
oint.

Fix in v4.
>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#index-cells'
>=20
> And drop as required. That all can be a follow-up patch if you prefer or =
in
> this patch is fine. Primarily, I don't want this pattern copied.
>=20

Fix in v4.

Thanks,
Peng.
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    usbmisc@2184800 {
> > +        #index-cells =3D <1>;
> > +        compatible =3D "fsl,imx6q-usbmisc";
> > +        reg =3D <0x02184800 0x200>;
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > deleted file mode 100644
> > index 29b8f65ff849..000000000000
> > --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > +++ /dev/null
> > @@ -1,19 +0,0 @@
> > -* Freescale i.MX non-core registers
> > -
> > -Required properties:
> > -- #index-cells: Cells used to describe usb controller index. Should
> > be <1>
> > -- compatible: Should be one of below:
> > -	"fsl,imx6q-usbmisc" for imx6q
> > -	"fsl,vf610-usbmisc" for Vybrid vf610
> > -	"fsl,imx6sx-usbmisc" for imx6sx
> > -	"fsl,imx7d-usbmisc" for imx7d
> > -	"fsl,imx7ulp-usbmisc" for imx7ulp
> > -	"fsl,imx8mm-usbmisc" for imx8mm
> > -- reg: Should contain registers location and length
> > -
> > -Examples:
> > -usbmisc@2184800 {
> > -	#index-cells =3D <1>;
> > -	compatible =3D "fsl,imx6q-usbmisc";
> > -	reg =3D <0x02184800 0x200>;
> > -};
> > --
> > 2.37.1
> >
