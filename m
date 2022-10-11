Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DEF5FAB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJKDPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJKDPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:15:33 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20078.outbound.protection.outlook.com [40.107.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351AB1CB2A;
        Mon, 10 Oct 2022 20:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQA+q1y6moVQQ/Zji0IKOHA5WuS37E2rCP+mCABpbhzWjPD8IY9cjH9O1AUp+1cP9TSzQcGacKAiFcX3xr7PCXCxDsejhM/hvFhfHMaIG2NWhg+BxB6TWxK0JAGbHNGm8jP0UVlqaGhdluq5d2Rb8eYql/nwCM5cfRF8NGQc6EQEUDFQNG5Yy7vIqdPeDXjHbdTHVEQSgW/6D+5jMV/n2kkMIFxlVlRRSGjS0At0H0I+x8QyVisY/h0kKy0Sb+Oi18mEb9M8JazYfIt9akULuji843eCidZDFgorXo6lp/6ha3dtproAQU2dPykli3491HW6b9nbWF3UoN4DI7axVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0DeBssDQvHRclUTP+yOBz0CJst8lkok5uJtbNTIK74=;
 b=EjcUWuXDyOnyXgxJeIgnxaZiNNASQ/87f9hhlcL+DJGIRECOZ0nkNeFBxXelef15VfsQjcdnIVEq4IzIObpMkxqu1VLAdEuD75wxwLWYSeJesTvC1Yl2yfmUKuf8AsHeg/EyCk5oHwwpR6+F+84ZEoXT2Ak6KS+dShRs02u+zEWIcYoCgAfRv9QLrdGiLPxwSrYZ7bDnOR0RxJL72UKxXdhZDDn2AhZcvOVaa2EYq0cqJVQ+1thOD009LkYwx3f14hjZhTQFDmHlDLQIAerVRbn9bBc5ZRBVRmfX2JZueI2Ghu6vqQogwYPbd46OSX029LfmPcI2WFbBINEc1IUNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0DeBssDQvHRclUTP+yOBz0CJst8lkok5uJtbNTIK74=;
 b=j9pk1q7wCbD0SL9uH1EOkpw6GCFAm0wXblaPdcWEdvVhHcrfmE/f9DvDKH0yL3++8iUddBElIkXaWwJE3v4bQmPPRc7CVyTmJp26xs4AmUw57hzWmt+ZrIo7ZcnIanbx6lHcy6dMvC9pJUu3XD3x+4/vTPR/GS0WidJ401yenT0=
Received: from PAXPR04MB8784.eurprd04.prod.outlook.com (2603:10a6:102:20f::23)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 03:15:27 +0000
Received: from PAXPR04MB8784.eurprd04.prod.outlook.com
 ([fe80::e9a7:fdfd:e80e:c6be]) by PAXPR04MB8784.eurprd04.prod.outlook.com
 ([fe80::e9a7:fdfd:e80e:c6be%5]) with mapi id 15.20.5676.038; Tue, 11 Oct 2022
 03:15:27 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Jun Li <jun.li@nxp.com>, Greg KH <gregkh@linuxfoundation.org>,
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
        <linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Thread-Topic: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Thread-Index: AQHY3JFyHsORHis1NEqMKhc0Pv37mq4IE60AgABZtMCAABOPwA==
Date:   Tue, 11 Oct 2022 03:15:27 +0000
Message-ID: <PAXPR04MB878482DB4DF6A803EB15B9118C239@PAXPR04MB8784.eurprd04.prod.outlook.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-5-peng.fan@oss.nxp.com> <Y0R/rJn+C0VPm3A/@kroah.com>
 <PA4PR04MB9640BA1F87883D6A61E50B6789239@PA4PR04MB9640.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB9640BA1F87883D6A61E50B6789239@PA4PR04MB9640.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8784:EE_|DBBPR04MB7788:EE_
x-ms-office365-filtering-correlation-id: a5829fa3-2a6e-481d-87b0-08daab36d882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 70j6p763TUanScFQZcGGzCLNjYVU462h9U5RCMrvpMY2CuaFMXf6NTPbsQ23kutE/U58qmZE+MbSkWwhwy/o6dY4SzyGXjU6HjQBDVg5uAKkwM70YqObsGlHr0x2OckofFPyqrPxr0Xvw6p0+gOsuHEGHnfRYPOwdk2wLik+YuN924v2crbbipCwts5Fz2NE2EQ6j3mujcFtcOfcUBrrQKn/uuRSGVwhlQ+w3QpXaeJGjcXWrMOohWiUfukLkILgKrlFofnp8a+LZubU0Q5V13HksI8pkvXdL8og0WirexiaQ7VVwwDcQfA0lFB83Ea7GJ4ivzmzK+KfdKjku+GP+6/YuIfpj+zqnLFZa4WfTRkLoF0Rr7OhQZnwhcZhuaDf7UYSKxnHwBRzDyifSY6Ma2M3N6zQLRgvXvwzRb7lNRdIz8RAsBYo8A3TmzJPZQB6Wq+/16iE/nXCWlztawZviLPo0bkrrBUC0lmZQVi0109QeVnZango7o3sn9SBd2SduX2ZrCbmHdLbUkF7q53jPk5Y2WhlrRVA3biP+pHU5pMUit9relrEIDW5zOqlN4VDyt/NtYu8PJTiMsjoRnGZK5F10UPMVePUcDIPWUQIfH/NRS108sS2BThTN/NXDYt/SZEV7VoSOIdmSef9mcqCh39UrZA+LK0Mvdmus1FXh58MG1bFRSMABpRz8So3wI1UWCYrt48HTvoVNZHukAnJrIEQaPH3GIwbXZZUJOD5ENmQUmY+qq/IEoOLJIa/Dmwo3tn067eAAuEnax3x0A6AIf70WdJmvuYiw4CKriYyey0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8784.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(66476007)(33656002)(38070700005)(38100700002)(122000001)(55016003)(66556008)(45080400002)(76116006)(64756008)(4326008)(71200400001)(316002)(66946007)(86362001)(66446008)(8676002)(54906003)(2906002)(7416002)(9686003)(41300700001)(8936002)(52536014)(5660300002)(110136005)(186003)(83380400001)(478600001)(7696005)(26005)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R28uHhpnpk7RLmxxdLtfcQ61YVCDll5TbMa7XRcuxwcaQ5LUPtnszw16yRll?=
 =?us-ascii?Q?OO+P2nkbGlUaLt5K8SBalpImVyrJ1NWImUvLeVA6Ir24rQioRW1XjmgmoU2e?=
 =?us-ascii?Q?rnwK3MNrNT+5F/Yz3lKYG5bq3w5FsN/1nbzmiiXr4S8wHyBb62YbXVlEz7u7?=
 =?us-ascii?Q?bOsFHCKqQhd5qIglgmcsF6YdLJLv6fA/LtpWcfAmwyB3yv8PP8oBevurfuMl?=
 =?us-ascii?Q?ON3wOIbuv5Iyl+bERfEjh4Bt9jKm7x11pfExfX7VtaGHXFgOCcrvGgQrhfLb?=
 =?us-ascii?Q?pu0rkBTSm0OplReUwh3UhYmJE2BHOtEbxKS+IfVlDaK2BpaSK6SvF8hKVyid?=
 =?us-ascii?Q?QOFDRQ/UKp6xrItEST97woN55IYpr7Xaubm/TDgURk3iPwCuu8jEKU9ekitZ?=
 =?us-ascii?Q?jMC8m4u6kR/BFzmXCV1Uk+l8gIvgw8oLcTvgz0MO5tITCvuVeCoI9UVHG1HC?=
 =?us-ascii?Q?cOeyUQ/xaaXW9MYMa9Xk+ql2xH2q9oZ66IT60UE7IVyTWtkFdkzwYaQEjf55?=
 =?us-ascii?Q?3IeKX15qmo5i9ctPuvPxsbU+nu8zg4UHaUHatDHoTnKCfK/zyA/CrUmhZNJD?=
 =?us-ascii?Q?fAQBs6D+ZkG1EMxd/QFGUbcj1CW3GXqN+CebxdjHhsukhk7NzdeAdeywkaNt?=
 =?us-ascii?Q?GT0DYfg3RgMiT4j15Nt5dQjBKYOrkQo+hwHcJploKHhASemfkFwLJSCquLRk?=
 =?us-ascii?Q?u0paCPKgRTeRnXIz6lH5fcKjdo0atQ3Gk7uf5gFtm4fjz+bMPVyyiCbDZF6D?=
 =?us-ascii?Q?CDr/vDBq0B0wYGZbwRQqRA5fwcX5WfVw6Qvf6nH6ls+UX34J5VsEyyEwbihZ?=
 =?us-ascii?Q?RmevEqAKkFh0nU7FhR9FQcLEUUx7FlxHOM4fdZlGzur+p8AiPdHkVEDMsAkW?=
 =?us-ascii?Q?MYNN0VICjB7HXfOGmwcDE/fKjt4D03Vl0KlNWnH8EDasS6A/Km90TfOH3v8F?=
 =?us-ascii?Q?StlICXrfKjcYJOhwOICTbdB/witZKrHs1x43iTu3lkW3NCUYzvYbhargawlt?=
 =?us-ascii?Q?Xanm2UWdvtBJhFVV3AoD0DwgAj0jYSzPfgicRAtrl+hbM2jmGHpAudX/Ejm9?=
 =?us-ascii?Q?3375uGGQloXLmaX1hwWC96X0T6AjhLk35mpD7JGV9j8d7buv5RdEOJfJDl01?=
 =?us-ascii?Q?ToRfQop9ufu42qjFQ2AN7p3YdTOxHjIXs/UCbcfmAWzvh2F/r107fcuhmVz9?=
 =?us-ascii?Q?DgaptNR5mAnhTSJyhpPAGWUpwlx5VbIT3xBj0UrlOKngIVvyOrgPWxJYohqn?=
 =?us-ascii?Q?xA1I0sHjvCa8l2VM8CY7HwcU07GRFARFi1/bXYHibuc49AbN7peNYGLD+7sP?=
 =?us-ascii?Q?vfIlI71I0R9lYYBIL8997xfRw6nQ3fD0nOdrLk5xR/4ezMYMbs4SjcgWwAyY?=
 =?us-ascii?Q?BsugXRG2PLMlxEol7TaPlmsR4p0nJNFOLIRX1eQOgd+c2ezT+jKH7GV5le60?=
 =?us-ascii?Q?4QUNR0AktpFjnf8+MqEYigTMXcOaoWQ/MivgKTJtJGaNDyvo//HZf10eVLci?=
 =?us-ascii?Q?PvegX01eWMNFWCoXeqojk0Eg1vVr3tZy2k6RFlgznyA9p++WA0MRr8GXrD4O?=
 =?us-ascii?Q?KNyHcS8nQH56LxMXrYg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8784.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5829fa3-2a6e-481d-87b0-08daab36d882
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 03:15:27.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uf2pnl0fYQHX8J47b3Ka+OuIX4OsGnOKDYEv3UNOZOetfXVAQa4Pr6FkI5ISCWf8dfcwakENvQB630atyrm1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

> -----Original Message-----
> From: Jun Li <jun.li@nxp.com>
> Sent: Tuesday, October 11, 2022 9:51 AM
> To: Greg KH <gregkh@linuxfoundation.org>; Peng Fan (OSS) <peng.fan@oss.nx=
p.com>; Xu Yang <xu.yang_2@nxp.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; shawnguo@kerne=
l.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-imx@nxp.co=
m>; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kerne=
l@lists.infradead.org; Peng Fan
> <peng.fan@nxp.com>
> Subject: RE: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
>=20
> + Xu
>=20
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, October 11, 2022 4:25 AM
> > To: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Jun
> > Li <jun.li@nxp.com>; Peng Fan <peng.fan@nxp.com>
> > Subject: Re: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
> >
> > On Mon, Oct 10, 2022 at 06:18:14PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Convert usbmisc-imx to yaml format.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
> > >  .../devicetree/bindings/usb/usbmisc-imx.yaml  | 52
> > > +++++++++++++++++++
> > >  2 files changed, 52 insertions(+), 18 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > > b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > > deleted file mode 100644
> > > index b796836d2ce7..000000000000
> > > --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > > +++ /dev/null
> > > @@ -1,18 +0,0 @@
> > > -* Freescale i.MX non-core registers
> > > -
> > > -Required properties:
> > > -- #index-cells: Cells used to describe usb controller index. Should
> > > be <1>
> > > -- compatible: Should be one of below:
> > > -	"fsl,imx6q-usbmisc" for imx6q
> > > -	"fsl,vf610-usbmisc" for Vybrid vf610
> > > -	"fsl,imx6sx-usbmisc" for imx6sx
> > > -	"fsl,imx7d-usbmisc" for imx7d
> > > -	"fsl,imx7ulp-usbmisc" for imx7ulp
> > > -- reg: Should contain registers location and length
> > > -
> > > -Examples:
> > > -usbmisc@2184800 {
> > > -	#index-cells =3D <1>;
> > > -	compatible =3D "fsl,imx6q-usbmisc";
> > > -	reg =3D <0x02184800 0x200>;
> > > -};
> > > diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > new file mode 100644
> > > index 000000000000..c0741ce9b523
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > @@ -0,0 +1,52 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > >
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > >
> > +cetree.org%2Fschemas%2Fusb%2Fusbmisc-imx.yaml%23&amp;data=3D05%7C01%7C=
j
> > >
> > +un.li%40nxp.com%7Ca362b29633474826da9408daaafd7315%7C686ea1d3bc2b4c6f
> > >
> > +a92cd99c5c301635%7C0%7C0%7C638010302778862012%7CUnknown%7CTWFpbGZsb3d
> > >
> > +8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > >
> > +C3000%7C%7C%7C&amp;sdata=3DKw6EHKfbwZ%2FfGgX6xJxML4W4E5DLiRx6pauQbLEbt=
0
> > > +g%3D&amp;reserved=3D0
> > > +$schema:
> > >
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > >
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cjun.li%4=
0
> > >
> > +nxp.com%7Ca362b29633474826da9408daaafd7315%7C686ea1d3bc2b4c6fa92cd99c
> > >
> > +5c301635%7C0%7C0%7C638010302778862012%7CUnknown%7CTWFpbGZsb3d8eyJWIjo
> > >
> > +iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > >
> > +%7C%7C&amp;sdata=3DakKA3n0sxbOhvwDURs%2FoV7nM680QcOQCLKgxnakRe8w%3D&am=
p
> > > +;reserved=3D0
> > > +
> > > +title: Freescale i.MX non-core registers
> > > +
> > > +maintainers:
> > > +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Cool, is nxp going to pay me to maintain this?  If not, then don't be a=
ssigning
> > such a thing to someone else.  Why can you not maintain it?
> >
> > Assigning a file to someone without even asking them is a bit odd, plea=
se
> > never do that.
>=20
> Hi Peng,
>=20
> Thanks for this patchset.
>=20
> Since xu.yang_2@nxp.com is now actively working on this IP for iMX, so he=
 knows
> well this h/w, I guess maybe he can maintain this, @Xu Yang, can you comm=
ents on
> this?

You can assign me as maintainer temporarily.
By the way, it seems that the following compatible strings should be added =
too.

fsl,imx25-usbmisc
fsl,imx27-usbmisc
fsl,imx35-usbmisc
fsl,imx51-usbmisc
fsl,imx53-usbmisc

Thanks,
Xu Yang

>=20
> Thanks
> Li Jun
>=20
> >
> > thanks,
> >
> > greg k-h
