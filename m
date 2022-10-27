Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C407560F73B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiJ0M2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiJ0M2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:28:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CAE167256;
        Thu, 27 Oct 2022 05:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqiH37Z1hmGTcMYEq8OZRy5ZHe0Gg36C8gNEtSExlJOY14/NjIgqY6GKNmbULlzbYO3LdJbl8Yq6Q1Py9wjpEVq0GxsemWjMQyrrf/yomqskITbiM63CsRXTtQmSDF+hoDcTrZwmxnagDRq8EBPbaMfXRnos2Rj/sTl+ZQVLSI7QULa+YRlbXe6i732V6ctjGENXa4OUsm85KfhErXqmUYMTxwpjVusoMtDmmvL9c+B6oxfcuvP46EDT9QPhaVwqSU/0WAXJahx+EH4Y5F6pIZBY8f1/jjFwu1Xo6fDLOGIeOYG/rJLPSCLnY01CGpjOMhY7H3Pu5qdZP9CRwbsX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3aQEypUdWuT7vwOlhMBAxlfw5A2SSoh4OdoKY7Ei3s=;
 b=HvRN3HIAaJTw5GXUEgsv6RX00zqXb6jS34cGnvrBzR7GBVFLEf/VrjXGR+/92rmP/pOP1DKbiSIjHNipPQPHqGuYJBsq7q7PVeSUh4IajIhN+Ytswvkt87+J1M9JYMgbK6T9RGCvaNZYObVsHkZK3nJAHtq1ypTd32f4LIe6/93dYBPb8gWxybSmOs/4EK0lWnkLwCnAvXOkftkV/cFhVuZ8H9fcBQ64MBCFkjDzRbJletJtjjjNO3Z0MTCquV9J3SqboYFGUKdCBqitJsRqCBZe2126GywO3vH9kr5TRunI1Y09S2R7NHe5GXUEePGbLTYhSxNBclbp9twIhcsc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3aQEypUdWuT7vwOlhMBAxlfw5A2SSoh4OdoKY7Ei3s=;
 b=EOaKYZpJ2tjqtZARsuvrF8rW9R/85POF/V4rnzQ1yVsxiHMqSbj2++wIDzKq1fnp4X59nAcJT/mUuGdXaBpOj0f4HBpUj5mONruT5O40lUz+b1Vrg0TERAj7PGNiKq5WPxHg90L228XMlCRlPkO8q1KaoH20dxHc4ZMIQi/Kx/A=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PA4PR04MB7789.eurprd04.prod.outlook.com (2603:10a6:102:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 12:27:28 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 12:27:28 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
Thread-Topic: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
Thread-Index: AQHY6ffdJD/5Oq16AkSmf/jVUKUJTq4iJNOAgAAGMIA=
Date:   Thu, 27 Oct 2022 12:27:28 +0000
Message-ID: <20221027122727.fhs35eqtzmeen6x4@skbuf>
References: <20221027113248.420216-1-michael@walle.cc>
 <20221027120519.7f3xun66l4lamcq6@skbuf>
In-Reply-To: <20221027120519.7f3xun66l4lamcq6@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5136:EE_|PA4PR04MB7789:EE_
x-ms-office365-filtering-correlation-id: 24606e99-e106-40f8-7e8c-08dab8169cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8xcH6FevX6hIdtCMM8Vbrbx0+Vd5594ZBeKOiGn8ITdUCUqwySXFN/oi0OjELzT9jOrGjw6bex/fEOTzpu+aJ82qbrLc5jnIDd6r8etaVZ2RIQkJvJueWrM0c8i5qyKrFoyShOaQ1+Wwwx+8fOojmopVqN4xBpM3Ss3LWelcUoYpIuTGqeIZxLT+VuMhEkvSmPKRRG4Z4h90Li4bir6ajCkCtl43wurC8vYfDBwt3yc2BFuLFHcQz6t7xeblpM8r33w57I89WJjWt4VpTWLf2SHs00lv5Ua3XIxoUO+W03b8UVLS4xzGnw0ue4vW+1XtNbhhRAwVoFnaBMlaoLocoKtFy7BOylQNE7UwoorOPGi04kiP0uvld7h3dI5rk35zBk7dF8zIkSLXMFUJPkb6bBvOMSlXNIcLIc3GqCSAJRyfub8TJGKTgCBD5nvm1GQxQDpc4MCgdNBhc/mLSlzvoVaH6LIeKyKmSUMQT2M19zhEI9QQEbaaqU4iwaO8uyVfWB091F2kRzYhjzXyw11hDDzXjntBalz9ne8k6zYdfsNb/yUG5eiz6HIXJoXUiqTJEDBAhSAfnB9lfOMCq/ggV7EY/I2iazSXWuqjGQHtAHGzBhybDEuW5GfJobrcm1Ko5yVvAPvYqWnwZXx6DcNr3XzDD1PX0tQaIf0Zf5QHx+iPB66ypGL7XiQHkMTXFbF6ycXCmjEVKbPUQReyU2ViBwX/KoYn7ByW6iOCqBZkgCXPJiWefX9sWH/NE9tUP0WiI38K8W+/c8GDl+CJyftjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(38070700005)(122000001)(6506007)(4326008)(2906002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(54906003)(316002)(6916009)(8676002)(83380400001)(1076003)(186003)(86362001)(6512007)(26005)(9686003)(44832011)(41300700001)(8936002)(5660300002)(7416002)(478600001)(6486002)(33716001)(71200400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DIeVvrR451wRRIeK0BEJl1rEl+kpAbj//IZ5/o96zweKRroQCuR5ANnpylRP?=
 =?us-ascii?Q?5AGefkD47NNJhHMZwaft4VDeczjJZzzo5qsjzSybL5Jf5UCaoqRglOajIjYc?=
 =?us-ascii?Q?9SJu323Mxj5YCX8fNmwB83l9dNQFZF3CmART32dpC2WacBSnWpUS65/osYjF?=
 =?us-ascii?Q?yMx4wpUtACUjbITC7MHJFbdLmmy1rvOSC4XbwdnmxPefi9tXM64x0oUjU7BO?=
 =?us-ascii?Q?6u/n7Z3GGXPJcNqbsokwvGIgPBLSmIamNrDwdfmMDKLKITXvI1F2dBDED+7r?=
 =?us-ascii?Q?RkthgeuQecURwj2MtsC3PRZrgdYb2RxC3uIlMYHtrMYeIKwbY9MbbM55smdL?=
 =?us-ascii?Q?SW0Gq8MbFyyhzB7PoGlF42lznx+X5UFdzUMt0cjqmoG53Rjhs70f0/Wv9fv1?=
 =?us-ascii?Q?+WcasV2ENHezH4EbDJAmLPPzZ/EAPPweY/SkZRzs85NBsZIPyDPVCW0FgfWv?=
 =?us-ascii?Q?D4Qq+HtdbjiKnmiLN70sIGRSdnzDQrwUIj2SwCY+xCDDT8kYhssCG0NRDc0v?=
 =?us-ascii?Q?VfRYjGbYAKzrRJq+h6vdpJtrmMOgYF7a5s7kEzbKYB6CdPO+A/aPLnTFcQoi?=
 =?us-ascii?Q?Y24L+3iD2ASMu/mEVn/5PuD5EgTvQdicdkfSWTiMXNixDHA8VlxmM7bfopU9?=
 =?us-ascii?Q?hGOJ2cikE4TLaTCPHghAqj3cQK/6hlq6zyr3Dg7qtGoZaQLyvJeSB9MasJOs?=
 =?us-ascii?Q?4l++n/zIeYEqze1EfGPUEX46xMHeBRaMQDwVp7NFqv4zsWmce5m5QVJMxZvU?=
 =?us-ascii?Q?nA5bW95vWVOfuHYdqgkWP9YzPOk9BY0zLF0lVWc6YaUEBj+G9ea9InSsrUmu?=
 =?us-ascii?Q?dastDhTHQGrvyMpeawZwZf2PSWYgpN9kh2eVzXn68bbMyiYceticexe5pCsR?=
 =?us-ascii?Q?6bQiDad0gCHEokeHYq6YnDXkdpTwV5WrV5XoVygYWjGvJdzoWsE0RHzIb9aI?=
 =?us-ascii?Q?QDYN1UONDanzxC031OuGYyjpc9DFdVLLwClizzzwxp4IXmujQKYKmIh4ROQC?=
 =?us-ascii?Q?6KGsuKThlQjTNcuJfSrtgihlDEpo4R+bVtg/jfXFk/KmLod2AGcu5LU6aN5I?=
 =?us-ascii?Q?lXSyp0WOUnBz+vxJqGD6WcpDu6/r+AdCF7PV2F3fShcxMNQksF8uj6VKrEON?=
 =?us-ascii?Q?DmoBQfiTviumYkcnLYtqHEhc8Mp5I+73FL+qCfoOr/cwbNHDRDWIQL4snosp?=
 =?us-ascii?Q?+UFARz7VdtG/3gxReNdhRWddGrHXb19PjvuhpX0BNYhVT8nscQPmzYgse3WI?=
 =?us-ascii?Q?8NKE0JQYTB4L47TZVLYaAKgf9KcZ3Oar7387PnhAOcmHvsH9tmX+IUQIa9Bz?=
 =?us-ascii?Q?kLRVDJaluHzo82/wvgaPBcietzif2pVeyMHf+JTPAZfFSeLW7wRmhdFh95BM?=
 =?us-ascii?Q?p0yR3xI6zOUGAMOtP7/mXq2Ot9tboMBbcXgi9i4fAEDHcYVIK0S80kqqQdNS?=
 =?us-ascii?Q?7ipTKwzwfsExrk0R35yUWVukJ1PLemsxZ4HV3KkxbTxavV7Qzi5ThJSuNC59?=
 =?us-ascii?Q?H0GivgjHs1NNjZBJmGx18AZDT/RiofxN1IKcT9nC7YnsfvYDkUw5j+qy5yRC?=
 =?us-ascii?Q?YP5XRdvJc6t6+fYaKniVwiCVUa4UBNdO86ui8gqbdsrpQYEfFrtUq5vCTzmu?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A9F26EFFD79B141BCB4039AC7B3D820@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24606e99-e106-40f8-7e8c-08dab8169cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 12:27:28.6284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOUzUVXjC5BJ7hw7pe6myKDvzs/eprOAswvBDL7ht6p/w6uxcwNI/8K6FU5n+2Q39Tel7fez7Dlf4p0izpI9uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 03:05:19PM +0300, Vladimir Oltean wrote:
> On Thu, Oct 27, 2022 at 01:32:48PM +0200, Michael Walle wrote:
> > This reverts commit be0b178c50c37a666d54f435da71cf9f008362a0.
> >=20
> > This commit will break networking on the sl28 boards if the tagger is
> > not compiled into the kernel. If a non-default tagger is used, the
> > kernel doesn't do a request_module(). Fixing that is also not that
> > trivial because the tagger modules are loaded by ids, not by name.
> > Thus for now, just revert to the default tagger until that is fixed.
> >=20
> > Fixes: be0b178c50c3 ("arm64: dts: ls1028a: sl28: use ocelot-8021q taggi=
ng by default")
> > Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> > Vladimir, I'm not sure how to fix that one. Adding aliases to the tagge=
r
> > modules? Something like "MODULE_ALIAS("dsa_tag-ocelot-8021q");" and the=
n do
> > a request_module() in dsa_find_tagger_by_name(), too?
> >=20
> >  .../arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 8 --------
> >  1 file changed, 8 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts=
 b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> > index 72429b37a8b4..771c50c7f50a 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> > @@ -324,14 +324,6 @@ &lpuart1 {
> >  	status =3D "okay";
> >  };
> > =20
> > -&mscc_felix_port4 {
> > -	dsa-tag-protocol =3D "ocelot-8021q";
> > -};
> > -
> > -&mscc_felix_port5 {
> > -	dsa-tag-protocol =3D "ocelot-8021q";
> > -};
> > -
> >  &usb0 {
> >  	status =3D "okay";
> >  };
> > --=20
> > 2.30.2
> >
>=20
> Pretty nasty. Of all the switch drivers that support tagging protocol
> change, Ocelot/Felix is the only one with this bug, because in all other
> cases, the default and the alternative tagging protocol are part of the
> same .ko. Only here we have tag_ocelot.ko and tag_ocelot_8021q.ko.
>=20
> The problem preventing us from calling request_module() is that currently=
,
> the string identifying the tagging protocol (to which we match device
> tree information) is part of the tag_*.ko. I think we'd need the
> translation table between string and enum dsa_tag_protocol to be part of
> dsa_core.ko.

I think we should treat what we committed to in terms of dt-bindings
with utmost respect, so I would consider your proposed revert as the
absolute last option. Reverting a device tree change doesn't mean that
the device trees without the revert will disappear from circulation.

So far we have 3 options for fixing this within the kernel

- make tag_ocelot.o and tag_ocelot_8021q.o link into the same
  tag_ocelot.ko

- change the MODULE_ALIAS() of all tagging protocol driver modules from
  "dsa_tag-<number" to something containing their string name - what you
  proposed. I don't know why the current MODULE_ALIAS() is formatted the
  way it is. Maybe Andrew can comment on whether this is feasible.
  I think there isn't any backwards compatibility concern, since only
  modules compiled for a certain kernel version are expected to be
  loaded.

- put a translation table between string and MODULE_ALIAS() inside
  dsa_core.ko, which potentially duplicates code. Maybe if we
  auto-generate it somehow?=
