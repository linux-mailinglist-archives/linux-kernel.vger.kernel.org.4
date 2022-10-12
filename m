Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD74F5FC084
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJLGSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJLGSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:18:39 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20459AA342;
        Tue, 11 Oct 2022 23:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1NWBJxEgnZW3ToQNal4/Y8VyqjSo3G107ub+NubiKEbWzobqxb95QnfInaaTeKjNEoHjwWHrigrkVJ9yd5BvRZkGCSjhSg/qm+UymmqTw0Ge3c2bnJyFgy9qK0fevH/2kNBkMcYSmnCkAmvoQE7Tg2cbVtQ1PnAIPSE9DMzbXLx6tex2xOo91/ue5YbFo4BVfU+0NswMIPbZ13LFtBfzeU+ZSm7rRDDFYES287jZAAdO6t+1nG4TVC25v52K18Uh8lZD1uM8JCyqcEbpgOya6si0p5c6ii5cWdMY+dsJtv6HtFh8UoV9HlBTGG6/1IyS5wmtMBRzgyAqnvsUfxAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AliYuxGzgkz87z5LSrALfDu+zL11p+UrBvmLNbKdBi4=;
 b=iEG+8BMeuBaglGlebfMkpHCAagh/meuJkIOu9SCLwuU/EdEpp5XtX8prkq6nlO75JmVcmSZCRA+4tY1D1THww7xfO4EZ8T8pK6A5AeIr1AcC9vgoyPHgCsMFHG6Tcb9O9QZGJw0/iUAjvgLXQYx++plxhC6l51uwPXKcXC2MELotENhHXvWDNK6jgjGzwmrekwHPIS+sMUuQmSAlbcfsRH21lW5uCMjZrcTNNSP0cYXcgk8VHPfLV/voh4kKd4WsuilyPWSpHTcmHZy7nG+KbaD2cAeGXE5q6S5rB3lT2+bsD0/KO0wq6O267hVO7OmyFUuDZFb2yWkHs4Ust40pGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AliYuxGzgkz87z5LSrALfDu+zL11p+UrBvmLNbKdBi4=;
 b=RqU9TT3y4bKO4i0wQC70N2CLryNCCsrjMYdiytWyIrdMhmUpc/jRG8kFTyUhm0MUpYq+W8yfyxgULyRweK5rToYekRDv4EIuVOxmyhMHJtovrhyP0GhlsRIWxMjIlZ8CFl+cK5xskq0vvSkxNpWVeEkCA5I9rDtu/tCosih6QZ4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:373::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 06:18:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Wed, 12 Oct 2022
 06:18:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Xu Yang <xu.yang_2@nxp.com>, Jun Li <jun.li@nxp.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Thread-Topic: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Thread-Index: AQHY3JFxx4dcN7/cu06TPYj3q5Imqa4IE60AgABbAwCAABeYgIABxSzQ
Date:   Wed, 12 Oct 2022 06:18:35 +0000
Message-ID: <DU0PR04MB9417D2C4288439343B9CB2B788229@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-5-peng.fan@oss.nxp.com> <Y0R/rJn+C0VPm3A/@kroah.com>
 <PA4PR04MB9640BA1F87883D6A61E50B6789239@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <PAXPR04MB878482DB4DF6A803EB15B9118C239@PAXPR04MB8784.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB878482DB4DF6A803EB15B9118C239@PAXPR04MB8784.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9233:EE_
x-ms-office365-filtering-correlation-id: f18f6775-39ff-4335-ca71-08daac19980a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qb/E9Vc+fjRabnazp7qq5N0tLWpwwMxUFXC7SCTuPmvIIyGLRSIB0nu3gzTvvFI/f9u1nBWRvAuzt5kIQeh+4lXR9BmLVbOcr/yzu1LE96TB6YG6ivFdXjYTUW7OGr1dZ5a35cEX3yUM4I7WeNyeGHlOpwyTYR4F/qUqXIS51Xt5T6BLA+sjz2ar3hZvzsPtGv1w/94Df51J3bdZA4SulxiV8n1YZWg/jcEe7bf1Bikx5A2qtOi2yD/BCc6Qglz3UyUoqtlURHsLs9EfKiTp6fgqWU1gugm7qqiEuYdKkpQPk27J5ouSyU6EGnB4Fenjz58uwgiZzR16p+1YTlFit78aCS8mXG46/Atg16UVLeCOyEUIKpFzIbY/JUn0/kzg3YQM7O+wMxrqa9xjrpiynx59Qy4yYCkJFHc7ab1lk7JkHep4RjCLYeoDA0xOGsndSIjEWUV99JtLzYaLlq27QSR5YbhcA623IPvRDEAkMdfAPxArJxDi/ATaaPfnsLNa5cW0YgVkw7rNbV2h2/57F8SYmSIfTDVuC1S/yrQIAD/T9GFAB+p4U3Zkf2KCnqS5z/o9yRQLLsGLlpTfbzN7dV4e37HwrO4nTGWBQiVO7GaKHgo8c7mJgNs2Q4awa7v+af67SSOpj66onIzxb1vPb0BuJqJvfuBsuy+GFYxg6bL2NHGe3Z3C5bMPeVKKLNdYqzFuCDQLNEPZyLwYxqFRx7BSU35pCCMAlbckloqE3+z/C08q+0p9kJagMhonZkjAaC7DiohI1dCjyOTTadn3OIfIg+bw6xQ4LIanNXkxu+A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199015)(26005)(9686003)(53546011)(83380400001)(6506007)(186003)(2906002)(5660300002)(7696005)(52536014)(44832011)(41300700001)(71200400001)(478600001)(8936002)(54906003)(76116006)(8676002)(66946007)(45080400002)(55016003)(64756008)(110136005)(66556008)(66446008)(4326008)(66476007)(316002)(7416002)(33656002)(122000001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0+N2zPw5hQUXfV1p6XjtLMwFVGBFu0cK5ijioQ9RfkUtWUwnhVJ+oDmISmHL?=
 =?us-ascii?Q?LxfY0wDnZzdSondYo5pJXRxpqTEZDmOU8eMfAjcfPSje5xhFlzF8T2fkW68w?=
 =?us-ascii?Q?Z55H3snBe/vHF/ygo7mRU/jQNEZ6Kc+8BewFY8Jz3YYelGQMsEpic2jPaa4T?=
 =?us-ascii?Q?gHyxx+5ycIelgp6rgEz4ve5omRNiLMYdAEra81ABT97CCQ6UAL5mUoXdJiaB?=
 =?us-ascii?Q?eNyA3OPqmza6I+QLQRe83V6gaX6vTkKnQPMqPD9iZ6ZsAE0tCcJz4DtjPdbx?=
 =?us-ascii?Q?EyzmhFVScOWQtd1LNK79BrU/JkpPPd0CHhsPonf/yyo0DF1ERZVA8Nw/fiTa?=
 =?us-ascii?Q?gIy54IF804tHxdiMabwIul03SHf8+2WTdksrkj9IjdRh+EVkfFaW0okIoy4w?=
 =?us-ascii?Q?az+lhCrqz1zXjSJ7fGEN6ns/MvBjc+DyyyPFiNVTXhNwJd2GWO1ucZ1hXBy8?=
 =?us-ascii?Q?vvBM0GA/iuG34ZsOJhHifMdRDwqHCD82v29lTFiwb4AtqqA9GaChIT8Gbp94?=
 =?us-ascii?Q?EvAeLjXf7Zw2U+aawaN9otsjQAMEJ5pgIfFsiGM3LLYH376fAoeGaSp/fmGt?=
 =?us-ascii?Q?poPUjaqO6EkYNeXVs1TBXz2KuYrNdDxJhnmEs2KKL/rd4Wfh5VmJJEAXCO+P?=
 =?us-ascii?Q?YBzQj+3/ItAsbDbcaiHCwCyBpVgvr1SCwcemIYOiZoKiDy5JOKwJI6Wg1LM3?=
 =?us-ascii?Q?IdH3623wAaKwPcVQbu1q1f2o2/zokEY1XBu+dVPjyGEMTXArbjUQHNUv4058?=
 =?us-ascii?Q?bE3kM2fqysr+B+ohvyd8lVNjCoeNMlptrOzv1RdRONjaSqYolHHMni7P58r/?=
 =?us-ascii?Q?Tm0rwaufYLqu1bKflUb3LW5nnEtD46Q920oDQo67FG57bs1WgE/lxhCtS6Zw?=
 =?us-ascii?Q?henlNYOD9dJ3qHTZrxcu3sncuGZpA9+LFd3Jgt5N9StdXlKQYW872FzckwqN?=
 =?us-ascii?Q?IzAr79r7SHhEL2HkSkkyzyCAFltwW9tDBjVx79VJVz9xfeSa1xREsc0sy9uq?=
 =?us-ascii?Q?XoVlQFC9DPf+JFUCLU5+iliQBf3LHa7D+OKCqJmqFP5E8f2T4zIKmN76VmsD?=
 =?us-ascii?Q?r7ZzTjLeTraXgaQTQqflkjwl0giLdxQqZT/pEukX1aGTKrGBX8n1R2xZ5x9e?=
 =?us-ascii?Q?8zkqwBfa3giZWz7HmgyJhn8uRrdI58rGyMy2GncPuTxF4rLFgJhu3Yvwqlok?=
 =?us-ascii?Q?mA5fkSFBwxUL+mANzrbrzG3dgo9vb/QSvXC6hhslzL+d9ruF0lIFXXHG5I2o?=
 =?us-ascii?Q?TfuUdWfgiIMsyjY4ORfD3xTM5qJ4nrxKJCG2baBmOGLnVjruC00J8IaTM/Gz?=
 =?us-ascii?Q?9SDdOTgZT9h7XP8/WWZ5E3AFYpy+hPvx1eizpqk3wBz1fZqj8Aan0th6yvwR?=
 =?us-ascii?Q?9ljcNO2x86Ny/WIXsJ3CnOY/swdxdK1/1LKYu79MCWjoOuks8mCIZH9Egy5H?=
 =?us-ascii?Q?w4QM4wd5PJ/NTLvaEf/8oz1bvJ8k3t3k9nYb36Y3pFqHcJ8JKoTxt7ZCq6Pt?=
 =?us-ascii?Q?JISzbSO8nfw/rz1tSp20lgS65R99S6wAbbfcFwkc1r6SI7ykD7VZuo8hSEIE?=
 =?us-ascii?Q?1Mrjcw9wiX0U/P/jVpU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18f6775-39ff-4335-ca71-08daac19980a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 06:18:35.1194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PeooAHaH9gBiJXGOpdn3dmspcXSIp2PvE5W1o4I5c/Y2fLh8jDTVe1rwxah0TIgZY2Mlh44D3L0zvsbnvvbquA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
>=20
> Hi Peng,
>=20
> > -----Original Message-----
> > From: Jun Li <jun.li@nxp.com>
> > Sent: Tuesday, October 11, 2022 9:51 AM
> > To: Greg KH <gregkh@linuxfoundation.org>; Peng Fan (OSS)
> > <peng.fan@oss.nxp.com>; Xu Yang <xu.yang_2@nxp.com>
> > Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > Peng Fan <peng.fan@nxp.com>
> > Subject: RE: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to
> > yaml
> >
> > + Xu
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, October 11, 2022 4:25 AM
> > > To: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de;
> > > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> > > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > Jun Li <jun.li@nxp.com>; Peng Fan <peng.fan@nxp.com>
> > > Subject: Re: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to
> > > yaml
> > >
> > > On Mon, Oct 10, 2022 at 06:18:14PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Convert usbmisc-imx to yaml format.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
> > > >  .../devicetree/bindings/usb/usbmisc-imx.yaml  | 52
> > > > +++++++++++++++++++
> > > >  2 files changed, 52 insertions(+), 18 deletions(-)  delete mode
> > > > 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > > > b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > > > deleted file mode 100644
> > > > index b796836d2ce7..000000000000
> > > > --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > > > +++ /dev/null
> > > > @@ -1,18 +0,0 @@
> > > > -* Freescale i.MX non-core registers
> > > > -
> > > > -Required properties:
> > > > -- #index-cells: Cells used to describe usb controller index.
> > > > Should be <1>
> > > > -- compatible: Should be one of below:
> > > > -	"fsl,imx6q-usbmisc" for imx6q
> > > > -	"fsl,vf610-usbmisc" for Vybrid vf610
> > > > -	"fsl,imx6sx-usbmisc" for imx6sx
> > > > -	"fsl,imx7d-usbmisc" for imx7d
> > > > -	"fsl,imx7ulp-usbmisc" for imx7ulp
> > > > -- reg: Should contain registers location and length
> > > > -
> > > > -Examples:
> > > > -usbmisc@2184800 {
> > > > -	#index-cells =3D <1>;
> > > > -	compatible =3D "fsl,imx6q-usbmisc";
> > > > -	reg =3D <0x02184800 0x200>;
> > > > -};
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > > b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > > new file mode 100644
> > > > index 000000000000..c0741ce9b523
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > > @@ -0,0 +1,52 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > +1.2
> > > > +---
> > > > +$id:
> > > >
> > >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde
> > > +vi
> > > >
> > > +cetree.org%2Fschemas%2Fusb%2Fusbmisc-
> imx.yaml%23&amp;data=3D05%7C01%7
> > > +Cj
> > > >
> > >
> +un.li%40nxp.com%7Ca362b29633474826da9408daaafd7315%7C686ea1d3
> bc2b4c
> > > +6f
> > > >
> > >
> +a92cd99c5c301635%7C0%7C0%7C638010302778862012%7CUnknown%7CT
> WFpbGZsb
> > > +3d
> > > >
> > >
> +8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D
> > > +%7
> > > >
> > >
> +C3000%7C%7C%7C&amp;sdata=3DKw6EHKfbwZ%2FfGgX6xJxML4W4E5DLiRx6
> pauQbLEb
> > > +t0
> > > > +g%3D&amp;reserved=3D0
> > > > +$schema:
> > > >
> > >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde
> > > +vi
> > > >
> > > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cjun.li%
> > > +40
> > > >
> > >
> +nxp.com%7Ca362b29633474826da9408daaafd7315%7C686ea1d3bc2b4c6f
> a92cd9
> > > +9c
> > > >
> > >
> +5c301635%7C0%7C0%7C638010302778862012%7CUnknown%7CTWFpbGZ
> sb3d8eyJWI
> > > +jo
> > > >
> > >
> +iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 3000%
> > > +7C
> > > >
> > >
> +%7C%7C&amp;sdata=3DakKA3n0sxbOhvwDURs%2FoV7nM680QcOQCLKgxna
> kRe8w%3D&a
> > > +mp
> > > > +;reserved=3D0
> > > > +
> > > > +title: Freescale i.MX non-core registers
> > > > +
> > > > +maintainers:
> > > > +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > Cool, is nxp going to pay me to maintain this?  If not, then don't
> > > be assigning such a thing to someone else.  Why can you not maintain =
it?
> > >
> > > Assigning a file to someone without even asking them is a bit odd,
> > > please never do that.
> >
> > Hi Peng,
> >
> > Thanks for this patchset.
> >
> > Since xu.yang_2@nxp.com is now actively working on this IP for iMX, so
> > he knows well this h/w, I guess maybe he can maintain this, @Xu Yang,
> > can you comments on this?
>=20
> You can assign me as maintainer temporarily.

Sure, thanks.
> By the way, it seems that the following compatible strings should be adde=
d
> too.
>=20
> fsl,imx25-usbmisc
> fsl,imx27-usbmisc
> fsl,imx35-usbmisc
> fsl,imx51-usbmisc
> fsl,imx53-usbmisc

Patch 6/6 has these. This patch is just convert to yaml format.

Thanks,
Peng.
>=20
> Thanks,
> Xu Yang
>=20
> >
> > Thanks
> > Li Jun
> >
> > >
> > > thanks,
> > >
> > > greg k-h
