Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2DD6BEC6B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjCQPHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCQPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:07:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0631.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5749C1BCF;
        Fri, 17 Mar 2023 08:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCx9vjQ4d4AoyIWGadL197grNECr77YfiwFhCLysc+JA8m+dXYpmL0T+snHkXRMF1rZkhyqqZOgXVOkHsBXWihlbE9ZwEo8clBGquTibeEWrNSn0HxyQKDvoR4VrHsVMlY0ZA+U9KxuiGlvO1CTvyl8biosqJZT4CklmINsAcLLVcl/W4FetUBp60FOOmJuo22fu4s+vE+Rz5/C+3qV9ukivVct6r+YrQ9z6I9tuRWFvn0KcMfsdUy83mINxg3FILp9Dwi/t9WqsyNsN1RAEsElGL9NQHRSEurWzy71hQajkVZYpNk5gqgJpvNSK4MbuGnb+RmCQvLpuf7j1+4Qyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAZmkxD1IDWc34G3D6qOyWAhNx9y9C+YSEpFYL+zrQs=;
 b=jn65DInsl2pKmdhVDQhiDawjlEvjPtZvdTRFew3isqvjUb4b6jTjKX5fQdfLcWnzseKYpWaHBrm5yD5jOz9ZqoZu5mLVHL7y63jdgecEavdxSN/W542W8a9VQ2xEs5+2LX14DHjK0mhWJ60E9D6gNAaMDbwq0hgtBtQcGtm7o2guiRNTWPUjtoPAL3CkfHFZDqU40R/nO0CEoYcfbIfCXpqVvAuqlUeubxYuK8PO8fp+53y68Rmsq2maB8Va1pI4oLK2GqYR2uu6t8OOURHKu9nFi47Q1lLMBX6LEeIE5viw0jhIkdDxvSaqfx0wV2yCrDfU1ItpC+cbWNkRas41lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAZmkxD1IDWc34G3D6qOyWAhNx9y9C+YSEpFYL+zrQs=;
 b=Q9wk908hAMx+5vDVIT3gLxVxnwv5yQhLMbXMYW24PVH3csTt+H7/x5A5jg+wg2QSZ28aRXpWcLvvPfwmJXZUuTvKAMUpWn0PJ+luzWaW8xPDMYMph7Hix22svrTRVd3Llv5vguXr6wyBCYWQSZ8ayHz2dSZv9yJQ+48YdXE6xXE=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Fri, 17 Mar
 2023 15:05:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.029; Fri, 17 Mar 2023
 15:05:44 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 2/3] arm64: dts: imx8qxp: add cadence usb3
 support
Thread-Topic: [EXT] Re: [PATCH v2 2/3] arm64: dts: imx8qxp: add cadence usb3
 support
Thread-Index: AQHZWE4gY8I1HVGK8EKXaSGyCYF/Mq7+hb6AgACL7xA=
Date:   Fri, 17 Mar 2023 15:05:44 +0000
Message-ID: <AM6PR04MB4838F13033FCB62B2519C42088BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
 <20230316212712.2426542-3-Frank.Li@nxp.com> <3810738.Icojqenx9y@steina-w>
In-Reply-To: <3810738.Icojqenx9y@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AS4PR04MB9363:EE_
x-ms-office365-filtering-correlation-id: 5f0ceb4d-5b53-4aaa-fc99-08db26f91539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBWTmQ7SHmXR89oIo8yT4EgOwbZ2Al6PYDr4WAvACRlbdxwotBy+UOgSF7pqLrw1WYKjTuWLQovUil9RSjyYVUD5Y1wOPM3nPIeF9MA2lvPlViiLuj5eBeCM3U+anx4PSUtPz91W+LGWoJBCexuCy43FzmyqJ/9cMItw/oS2ZoyR3x7dpkB3fU7J/FcUX13TSb6u/Hmr5OQ9VAFU9lz1S2OIPslr5RPl9WSBDPXXSmUe8MrP7Szs7viPV7CRIHAfHKQljlgfqqXStEjvg6YpRzAM9ziQg2EDQAUzYZxKoZhOpg8ZS+r5s7spMP8vv0kfqrklQ0oYfuLJMytQFxVT6TjOKU9eM6AqeQk08YMVLK0et14fNYr72cqullqJNNUY6wx1k6a1HQ9JSXZs3zqW9of2LEF3OLI2LviRwS5Qwj2Pwzi/hB/xLgZu/HS/Q9J0/WEj5JP5JsRF4tJAOqsuZkXP/oZCjcYI6k7gCav7pnThMcHH6BrxoojCL4ZiKa2QuNkngJJ3AbDE/7HhChTm0c5tHvtsQ3m9T0Zodh/85ZX6KRPrmygzq4Pgp30hzU4VN7W5iYbvNyIDZSrtIfaRsp70NqfXT5k3BI1MZQcEYoJ8+fawygxIHSMyjlk5MDQ15++ID6d5aykTX0hPZ9NAuTVRhKGOiW65Lh73uvBhOYR/EGTyFGzBx7s2lSc0zTtix2cfO8PyPRgADb60YasI6UBnaAt7jmw6KxZatZ56VhE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199018)(5660300002)(44832011)(7416002)(4326008)(8676002)(41300700001)(52536014)(55016003)(8936002)(33656002)(86362001)(38070700005)(122000001)(2906002)(38100700002)(26005)(6506007)(55236004)(83380400001)(9686003)(186003)(71200400001)(66574015)(478600001)(76116006)(64756008)(7696005)(66446008)(66476007)(54906003)(66556008)(66946007)(110136005)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1tUGZ4Swl+I8S/JGcCQSqIHKH0I8THnSbUg4ZqVsN4XFniHfLBYFEZB/VQ?=
 =?iso-8859-1?Q?1dngZHyfvM+rD7bTo4E6+uOke8YHsL3E1cyF0Vo1eN0idrO8wmacTJDB77?=
 =?iso-8859-1?Q?1GrN+Fh5UvhTS9mP1xE8vAi8XAOeHwXsL8a0KQvX6aR4qOKAEbd+V7WXZl?=
 =?iso-8859-1?Q?ANgB/waXR77Rwo+UL9r4eYCFumGCHvmqI9e6n7bp0fJPzxYtLcDxvI8vSK?=
 =?iso-8859-1?Q?sKuPnLt+GwZStSFvZaEJWHZYf6qy85CUuGQEIp6vwYK9xkbJHFw2sHI29J?=
 =?iso-8859-1?Q?n67aLdISu39OFSPYRlS1pBKzy82bVPAGPmAUQKvFv215vuKXaAouAu5Sc7?=
 =?iso-8859-1?Q?GziUTA2y9TfHmhJb3PNn3G9RovZ4LfMnDiBIwIuiwRAlNuLooi38etDr/O?=
 =?iso-8859-1?Q?tc9H4Mq2o/FG3srzhBGsBDcE9anUojfsogwwaLS7IgIRUmwPqChkW9j8Yi?=
 =?iso-8859-1?Q?9CbDGD6r28+yHqopOB9FBoJd+lSS0qvEQQ9mazvIUEwJVlF6IgyLuqwplQ?=
 =?iso-8859-1?Q?SJfieolPzwr7vLMAMmGIOn6mOZzPhlI134QYDFxJb3GBpirOj46pu8vTa0?=
 =?iso-8859-1?Q?YALQFaCEgaLpE9lrGfxgddBVNV4dgEJNrg0To8qf6suHir5C7bkhieZXrQ?=
 =?iso-8859-1?Q?CSraugPwIDBJQ/kl92AAK0Ul1ZQ7ktAVff1IBAM7jvfVFFoRiDLKh27XGJ?=
 =?iso-8859-1?Q?7bpE8OUvftTsAsN/DMDsJMLbGEms9gNW2ggp4Ahbzfs+fE1/i2KPXhyswK?=
 =?iso-8859-1?Q?HwAfJG65wUdvv4tXsAGkpaecI0OuwQ170m930MGfSleGhSObOz5EF2WajO?=
 =?iso-8859-1?Q?erXQRwUcOR+TzMl1uEk8cxDgnxj9znGqXK+c20o4gvOrrqNfKgiGyd5CEk?=
 =?iso-8859-1?Q?eIQnGo4yfzuJFPyWXHOHikk7oWSwqC+dNwt1cDVQUARRxCr2WxKbXgq18M?=
 =?iso-8859-1?Q?MEud0MAwz4F+JaSlbp3vFV4Vid7QBWcd0g2hXUm8N7IaP9BXGMhHvoUEro?=
 =?iso-8859-1?Q?SDz7lFeS8FhX/sf3jt7png8L+/fKMA50zzwwJsC3ZOi+B4QplF/kXD2lGy?=
 =?iso-8859-1?Q?+F43dSyX5fAwDJzDRJr/+Zx2/+T7vlQ5O4Hbiic39AGxGnS5nUj78xvVrF?=
 =?iso-8859-1?Q?YpZRKTSXHgkw/sOOcT14vTMZdZgJ2pFngTrYw/UAaRB5JUWa5av7Zkl3rh?=
 =?iso-8859-1?Q?emu4UAIJvZ6J82VLc5zGgDa3ZQwF8jXvV0F3gS2NvRzTfNt/ZT0trhFV4U?=
 =?iso-8859-1?Q?MuJdh6nAyAzwshiAGqK0vNlGqPIa2L/EaiRt6FVjz58Wu5KDFLKrqi3WZI?=
 =?iso-8859-1?Q?ClBwDasfVzDEv1xq9pvd0uim/3bvAk9Xn1FIyhc9+q2qj7E7hwTxmKAQCx?=
 =?iso-8859-1?Q?sV4PS7hXNTBT3Q63zBaKo2yg//B31fsMzoSzcx2etOll4sY9m+QGsxM0uO?=
 =?iso-8859-1?Q?snSErGKArafrJol/H45Byw+cCATGoxk8NkwcpXQNmHS80oU98S7z1WUAzi?=
 =?iso-8859-1?Q?POIn3O7XsFGhnqN+Ftv+nJ3y3pHAwItwtSovtngVKHgfp2Rd6jRfBXio8D?=
 =?iso-8859-1?Q?YOVjIlylfYXwuZYkYYOa16OWpINBykS+ZiBmDD6jbTP/GLEdMAS+04YOJC?=
 =?iso-8859-1?Q?q/Zg6xvavpI9/DweX4v/Q/LHcG3sDUyRr4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0ceb4d-5b53-4aaa-fc99-08db26f91539
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 15:05:44.7422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyIZi8gFWcP4/fR0nh1wAKK9yENI/V6gN241yqwd37gVj9ubOURlgv492wLV856xk9XFAsyAE1TWErdDnqBo4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Caution: EXT Email
>=20
> Am Donnerstag, 16. M=E4rz 2023, 22:27:10 CET schrieb Frank Li:
> > There are cadence usb3.0 controller in 8qxp and 8qm.
> > Add usb3 node at common connect subsystem.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../boot/dts/freescale/imx8-ss-conn.dtsi      | 72 +++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi index
> > 4852760adeee..389f52f16a5c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> > @@ -138,6 +138,56 @@ fec2: ethernet@5b050000 {
> >               status =3D "disabled";
> >       };
> >
> > +     usbotg3: usb@5b110000 {
> > +             compatible =3D "fsl,imx8qm-usb3";
>=20
> Mh, is imx8qm considered a subset of imx8qxp or vice versa?
> Maybe it's worth adding a dedicated compatible for imx8qxp as well.

Imx8qxp is subset of imx8qm.
This part is the same between qxp and qm.=20
If exact same,  I think not necessary to add compatible string.=20

>=20
> Best regards,
> Alexander
>=20
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <1>;
> > +             ranges;
> > +             reg =3D <0x5b110000 0x10000>;
> > +             clocks =3D <&usb3_lpcg IMX_LPCG_CLK_1>,
> > +                      <&usb3_lpcg IMX_LPCG_CLK_0>,
> > +                      <&usb3_lpcg IMX_LPCG_CLK_7>,
>=20

