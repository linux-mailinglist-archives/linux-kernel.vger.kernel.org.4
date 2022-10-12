Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7656E5FC1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJLIRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJLIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:16:51 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150085.outbound.protection.outlook.com [40.107.15.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6EDB3B37;
        Wed, 12 Oct 2022 01:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw2eXMNYfjfugt1aAHZiEv+BaUbA1xGhrKJeSrM5fr2JwdzwqrMu2F3cTgw/F1u0MutcYRPztJLzTmKgCGezLS25DDExrRtmjx9HlxM5KtktCuWm+lkVMHqEqOadUtJ430yKrFulNvueNDfp2FM2vld9AUHL/1nWbytAoLiem1w4FxAebMzwBgVMkFx9UlWIKUk78P9fFTvl3LdBAFg1/TGsjM40V6QropQ5jJd+6622IWwpCLRxulSUAmu5jWsZpPeRWJkkG7WYOBpOdf/XpxgyK5ZT50Yw5xrPbl2jz1MwWgqolj0tzc6AQqrOM27WCrmBnDoA7E30/RAqpAbqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY2tSwDJVsslyT6oNizXTvaORpekfHh5I+Rn+1gEibM=;
 b=oVUb202YaxFKYEZPPT4kydXmXbnNm04qo4OG9YZkVS2uHiTZVGaaYo8aln2F+Hov5OH6C4JW7UEbiNUb4fgqUoEIXaBEz/oj2k+62WAMtmbynEYriX26sjSsgP2K/s9jTibE9iozpEiU6x2LTKD0EVioCoqVMYKixwCXW4+RTi2SfUUOmP2ZV4eYagPvMMn+hqGsL3i70q7eDvYypbVuj7E1YgTY0T1kw5rPVeRIr01RkonJ1w9a/PeLJwiU4fvZzNDXkhVbx5QVg4+la5n0lUXDQ6fvT62TBHG5JNhdwfaIwz6dXkchPG3vZyTU0nrgXW6Rz5NpWjFZd9epQzTnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY2tSwDJVsslyT6oNizXTvaORpekfHh5I+Rn+1gEibM=;
 b=MkLAn7K0KfoEcRznRznuocvDV0Rc9q0F615BAZDGMY4/br0GNlbn69zCI+kWxGC398pDJzFAEG11IlOWVSooDfkOTWYj86kUyshGGmR8v+Ol8g5l/TyCYesKFAf2qvQjniSWq+/LiXIvvxojzE3vsp/ZR+7dCeSzhFdXRCc02zs=
Received: from PAXPR04MB8784.eurprd04.prod.outlook.com (2603:10a6:102:20f::23)
 by PR3PR04MB7369.eurprd04.prod.outlook.com (2603:10a6:102:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 08:16:20 +0000
Received: from PAXPR04MB8784.eurprd04.prod.outlook.com
 ([fe80::e9a7:fdfd:e80e:c6be]) by PAXPR04MB8784.eurprd04.prod.outlook.com
 ([fe80::e9a7:fdfd:e80e:c6be%5]) with mapi id 15.20.5676.038; Wed, 12 Oct 2022
 08:16:20 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>, Jun Li <jun.li@nxp.com>,
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
Thread-Index: AQHY3JFyHsORHis1NEqMKhc0Pv37mq4IE60AgABZtMCAABOPwIABytiAgAAf3KA=
Date:   Wed, 12 Oct 2022 08:16:20 +0000
Message-ID: <PAXPR04MB8784F57106C94BA0B68D2FB88C229@PAXPR04MB8784.eurprd04.prod.outlook.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-5-peng.fan@oss.nxp.com> <Y0R/rJn+C0VPm3A/@kroah.com>
 <PA4PR04MB9640BA1F87883D6A61E50B6789239@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <PAXPR04MB878482DB4DF6A803EB15B9118C239@PAXPR04MB8784.eurprd04.prod.outlook.com>
 <DU0PR04MB9417D2C4288439343B9CB2B788229@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417D2C4288439343B9CB2B788229@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8784:EE_|PR3PR04MB7369:EE_
x-ms-office365-filtering-correlation-id: 88dea8e8-3d0c-4453-fbc8-08daac2a0b3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +BEJ9GBEc3z2aqXRQUm9wSdNejKdiZgtt5p1ZxKh+30VoWNNIF8EqFnIFPTkGRxPa7Jkxnm4E0gW/Qltx6o6iJXi0+KkwKBACYrqElcFqjWr5RqKt1WVcLl4UkE7m7p9hCB1dhYrY/XEA7HEecJgYoYeT3EgBhha1WSaEyNALcFWxJggPQxJeW9QLb8bNlGJfDpoxIuiGfzxUZKdBPY/k/RWLoss5voZ3xfCjU2nHs2cqQXtWLjulj+hQIClKdCDmvAncyotKOAwT7AVlM1D+K36dHOnSaPTthtUwDI43yEeSyW5Todv1IcLq+KbtffXh2MgXJf9iOJEd0uw79uBl0OqyWDBmbVGESlnHHFUGleB42De6UegII0qrpmuY2p6+NVyZtSjEmcJt3W+E22OmBVe7iLJvbz4Fk3ocXgIgvaDRMBwgg3Dm7wMshFink2l2SF4SvYqmG1S2aXeDREilNwHRF0GWWj9NrhIDdoD78vCqLV86zML2eR29PIrtOMVsXIzGzVjhbIf+xzgxO2q73oihkUfj/BHGXeOpXR24Y+nVlNXQ+TqoFnAa15GIiLwCX10sATEzpyDyVfEBxvW7FOM1NJh277wtsfRHJhG5OKG1YquWfTyjgDpKQ0FuD5y+bUJDV9YaHcnx3j1QHxep2qWyt+TgnB3icFTjEh2vBSNIRy1jYxYGB0Fa+uZjrGjoMBL3OjSnnzLAH5vWN/HnS34HwJ6fknPFz7eE5wSggLlW1OsAuhaDoXjX2iaC9G9zzoNtsXIvD2b/sJlZT5iMsINHb6QZRpV2K9r73sBzyg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8784.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(86362001)(33656002)(2906002)(38070700005)(7416002)(66476007)(52536014)(41300700001)(66946007)(66446008)(4326008)(8676002)(64756008)(5660300002)(66556008)(316002)(76116006)(110136005)(54906003)(8936002)(45080400002)(71200400001)(38100700002)(478600001)(122000001)(6506007)(26005)(83380400001)(53546011)(55016003)(7696005)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4mGvWPnQQ6dnhzEgpuBWb5x87Ptrm13y3rkB1M2ptuNPH6NbRW1HPYkjTJO7?=
 =?us-ascii?Q?+FRDzSIL6HC/BzESaCLNhW5oO5XDc7VdMF2ha1B/9QHkFCXONlI+q6BL6ep4?=
 =?us-ascii?Q?0jw+0W7uJZhwNa1Ezi0i+RF8q9fjP0wBcW0OYeVIXMOMCHPdHDLOjX8X03l3?=
 =?us-ascii?Q?hLmI0JW0YMg9XMriv5eFgCsYXQhCOgGn1WWE3bByVkZxfrVTHDFPE3JrNXgJ?=
 =?us-ascii?Q?PynO3hLMpbrGj6ToAC1gAxB0lpGKWvZ/tAkF8SQuY9+9SmDfP0mTmcMRVYk2?=
 =?us-ascii?Q?GT1N8TUQN6C4CI7xsVucMektjpIYZaojYbu33xI2LwvskLvHOD87jLEV77Sm?=
 =?us-ascii?Q?3Zb2im1YG1K9vPzJ1tKZys5yW56deWmolAPlDt2DZZoVw2OIMEgaerq7u7Am?=
 =?us-ascii?Q?zlL0DSAhWQ89N253llO8cVQ7edVbs3H3D/VNg7YWDQAprl6iYEbDdkAZ8Gdk?=
 =?us-ascii?Q?PhW0jlSMphSs4sn4/3eKOb6A8L/Csrevx+aOEEysah6dmax2eIZsDNti14B6?=
 =?us-ascii?Q?RknwMRC77mhMGvaf2YRY38Doamy8cN0m42NqvjgiVwxkGd2kuhWhalc9dQB1?=
 =?us-ascii?Q?+vUPd0nb2goGHOrbosCHPwt5mmWTK/f6ZFqnyFJ3egC7hxzfg95GYzEhU5fW?=
 =?us-ascii?Q?1pmD+56leICAKjIUGN3X8No/1wPUhRvKvFgtfqS/pdm6AWqBwGCyxOMW/4xb?=
 =?us-ascii?Q?dn0OTpAgGKN2JPSKJkriINyoFe+EF7BLi1jL7WApXmid30G1m2KNC4kkcs1i?=
 =?us-ascii?Q?YuxJesGdk0HUUimerv8YdI+4eRE3YUCoAg02D4fm2epibyJPMRE7bNRSUZOm?=
 =?us-ascii?Q?sECiIHequZA73N0zUA5/TbUE93FkU5wRKUrMcnUUUO+OX1A3ZmWY9bWNxFXr?=
 =?us-ascii?Q?JyZw9yYui7gJOo+l0+cQDR93/FCWxbEoW81AMo7kbjbeGWW0xzs9NBOdW7i7?=
 =?us-ascii?Q?SI4xqpu/4XPmYiBayhm68lKb/Mk7+hosMB3/IIkUsbpbUJG0OMrVyH37jUfI?=
 =?us-ascii?Q?sJBeDlcsVrN7kllaKbwfT3SQ1i207NCrLK9dlNt5SkwolKE0ICpeqEuadxKq?=
 =?us-ascii?Q?gUCiz4429SHz6MkPBnuujn9FLuv0+h+oQFH/AKXi+KOW15/4uZ5TpVuOYboG?=
 =?us-ascii?Q?i7MRk4ugUjEkvt/HzCee/lmhaZOa6vM/F1+q9m5bwZgDaFQEpGYT8qw/5p7W?=
 =?us-ascii?Q?i2QJuSHv9HQ5I6XJo0AZyqhwE0vu8248OusWb36jfrjb0vKoU7h5vQMKBPmA?=
 =?us-ascii?Q?SEQhJ1OUeW+8GBLSK/hMD1812jEaqmG3Cau4GfLutK0ibYv6G1+COnwxL6fW?=
 =?us-ascii?Q?xXw6MWbHx0j0kf6fROrGjLNuRB/qQctVNm4oU+qvD/SdWbezGFtppmYHI152?=
 =?us-ascii?Q?Jl/xneiQduvYTDImWLC+/VHAe7JM81Ffo6tp4hIj8nwLg+2I7nHyjhreDABM?=
 =?us-ascii?Q?Xa0+aP0Uxpu1HWTEOvTVs7tc58NtEBsISKaHHZbJq9OBBISfsHsuvgreMPPq?=
 =?us-ascii?Q?be+MM9X5p1kqlzKkSDzJCSczSUYH6zqv0nET2Y1Yo4OjR9wWeeOw/RyLcn68?=
 =?us-ascii?Q?bftT+9wwPu6aiSTVObU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8784.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dea8e8-3d0c-4453-fbc8-08daac2a0b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 08:16:20.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2apG3DvVJxsdg4Cx1x2NGraxWvtNWTzTHzQOOc20gfbFsmcsS2E9Kd0+rP6+CXpE4pC2/uodykyHtPkdSiXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7369
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Peng Fan <peng.fan@nxp.com>
> Sent: Wednesday, October 12, 2022 2:19 PM
> To: Xu Yang <xu.yang_2@nxp.com>; Jun Li <jun.li@nxp.com>; Greg KH <gregkh=
@linuxfoundation.org>; Peng Fan (OSS)
> <peng.fan@oss.nxp.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; shawnguo@kerne=
l.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-imx@nxp.co=
m>; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kerne=
l@lists.infradead.org
> Subject: RE: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
>=20
> > Subject: RE: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
> >
> > Hi Peng,
> >
> > > -----Original Message-----
> > > From: Jun Li <jun.li@nxp.com>
> > > Sent: Tuesday, October 11, 2022 9:51 AM
> > > To: Greg KH <gregkh@linuxfoundation.org>; Peng Fan (OSS)
> > > <peng.fan@oss.nxp.com>; Xu Yang <xu.yang_2@nxp.com>
> > > Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> > > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > Peng Fan <peng.fan@nxp.com>
> > > Subject: RE: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to
> > > yaml
> > >
> > > + Xu
> > >
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Tuesday, October 11, 2022 4:25 AM
> > > > To: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > > Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de;
> > > > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> > > > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > Jun Li <jun.li@nxp.com>; Peng Fan <peng.fan@nxp.com>
> > > > Subject: Re: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to
> > > > yaml
> > > >
> > > > On Mon, Oct 10, 2022 at 06:18:14PM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > Convert usbmisc-imx to yaml format.
> > > > >
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > >  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
> > > > >  .../devicetree/bindings/usb/usbmisc-imx.yaml  | 52
> > > > > +++++++++++++++++++
> > > > >  2 files changed, 52 insertions(+), 18 deletions(-)  delete mode
> > > > > 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > > > >  create mode 100644
> > > > > Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.tx=
t
> > > > > b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > > > > deleted file mode 100644
> > > > > index b796836d2ce7..000000000000
> > > > > --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > > > > +++ /dev/null
> > > > > @@ -1,18 +0,0 @@
> > > > > -* Freescale i.MX non-core registers
> > > > > -
> > > > > -Required properties:
> > > > > -- #index-cells: Cells used to describe usb controller index.
> > > > > Should be <1>
> > > > > -- compatible: Should be one of below:
> > > > > -	"fsl,imx6q-usbmisc" for imx6q
> > > > > -	"fsl,vf610-usbmisc" for Vybrid vf610
> > > > > -	"fsl,imx6sx-usbmisc" for imx6sx
> > > > > -	"fsl,imx7d-usbmisc" for imx7d
> > > > > -	"fsl,imx7ulp-usbmisc" for imx7ulp
> > > > > -- reg: Should contain registers location and length
> > > > > -
> > > > > -Examples:
> > > > > -usbmisc@2184800 {
> > > > > -	#index-cells =3D <1>;
> > > > > -	compatible =3D "fsl,imx6q-usbmisc";
> > > > > -	reg =3D <0x02184800 0x200>;
> > > > > -};
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > > > b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..c0741ce9b523
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > > > > @@ -0,0 +1,52 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > > +1.2
> > > > > +---
> > > > > +$id:
> > > > >
> > > >
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde
> > > > +vi
> > > > >
> > > > +cetree.org%2Fschemas%2Fusb%2Fusbmisc-
> > imx.yaml%23&amp;data=3D05%7C01%7
> > > > +Cj
> > > > >
> > > >
> > +un.li%40nxp.com%7Ca362b29633474826da9408daaafd7315%7C686ea1d3
> > bc2b4c
> > > > +6f
> > > > >
> > > >
> > +a92cd99c5c301635%7C0%7C0%7C638010302778862012%7CUnknown%7CT
> > WFpbGZsb
> > > > +3d
> > > > >
> > > >
> > +8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > %3D
> > > > +%7
> > > > >
> > > >
> > +C3000%7C%7C%7C&amp;sdata=3DKw6EHKfbwZ%2FfGgX6xJxML4W4E5DLiRx6
> > pauQbLEb
> > > > +t0
> > > > > +g%3D&amp;reserved=3D0
> > > > > +$schema:
> > > > >
> > > >
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde
> > > > +vi
> > > > >
> > > > +cetree.org%2Fmeta-
> > schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cjun.li%
> > > > +40
> > > > >
> > > >
> > +nxp.com%7Ca362b29633474826da9408daaafd7315%7C686ea1d3bc2b4c6f
> > a92cd9
> > > > +9c
> > > > >
> > > >
> > +5c301635%7C0%7C0%7C638010302778862012%7CUnknown%7CTWFpbGZ
> > sb3d8eyJWI
> > > > +jo
> > > > >
> > > >
> > +iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> > 3000%
> > > > +7C
> > > > >
> > > >
> > +%7C%7C&amp;sdata=3DakKA3n0sxbOhvwDURs%2FoV7nM680QcOQCLKgxna
> > kRe8w%3D&a
> > > > +mp
> > > > > +;reserved=3D0
> > > > > +
> > > > > +title: Freescale i.MX non-core registers
> > > > > +
> > > > > +maintainers:
> > > > > +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > Cool, is nxp going to pay me to maintain this?  If not, then don't
> > > > be assigning such a thing to someone else.  Why can you not maintai=
n it?
> > > >
> > > > Assigning a file to someone without even asking them is a bit odd,
> > > > please never do that.
> > >
> > > Hi Peng,
> > >
> > > Thanks for this patchset.
> > >
> > > Since xu.yang_2@nxp.com is now actively working on this IP for iMX, s=
o
> > > he knows well this h/w, I guess maybe he can maintain this, @Xu Yang,
> > > can you comments on this?
> >
> > You can assign me as maintainer temporarily.
>=20
> Sure, thanks.
> > By the way, it seems that the following compatible strings should be ad=
ded
> > too.
> >
> > fsl,imx25-usbmisc
> > fsl,imx27-usbmisc
> > fsl,imx35-usbmisc
> > fsl,imx51-usbmisc
> > fsl,imx53-usbmisc
>=20
> Patch 6/6 has these. This patch is just convert to yaml format.

Okay, got it. Then no problem.

Thanks,
Xu Yang

>=20
> Thanks,
> Peng.
> >
> > Thanks,
> > Xu Yang
> >
> > >
> > > Thanks
> > > Li Jun
> > >
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
