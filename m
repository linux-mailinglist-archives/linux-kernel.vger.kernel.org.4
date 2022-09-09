Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8D85B3C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiIIPfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiIIPfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:35:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D88F1056C;
        Fri,  9 Sep 2022 08:34:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AV0szHpeHIMvTvhmLCZ6zy3TuCcC6F+qu5iWYbtHdWFYxZ2e3OHATuPYKdH+Uy5rTZbz+9L9cx7ALXRZTcaLJEaxmoFY6VDmO1KbEV0yDK5rFBMC9wqvEZsfh9zbRor3/p8TKgie41iAGiXBgnyTpwW3PkjiORxbYgyULO8lTkCBuDHdnTOMA5uUqG7BNNdH0pm2fn3dTCC44VTwbFVjiQdgM3+YgE3F6mdzRweYwxY9jm+JGCI9KcKcY2pzoolz8SzvwIfdyAzOcaPujkNlU+F5bc0+vJ1Oi5F0wm1QooMSLcKSz634BBwMH7GSbd6o/0p607uDO/hbGF7D4VDjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+mAluL80Wxa6VWB5jR4Y6Pk2wVUozxUlat2mNhSPxA=;
 b=iuBLWSfQpp+29eRNDXD1t4bEI9MNUpoFdw5SCFg2eO8+nU95Un9/E0l4HmEnS9nId/qH/1VgLZ2nNVgkVXLLPrpZzn4rq9KZHVgZL6mE2vMOjVAJzlIZCqaHBJkKeQOK1vN3+1qhTYy5ePPAWpv8kipjIpklmON4Pm7We+PuoyeaYWjwVYU5dUeMkbMzFHK1B/On9a4rNBEtKFtnfW9WddKSc2auqsfyMt7/MZpIIlmI0mTwb94fng9m+fl6R/La/7p2vz6vOb77eI/g3p9RSOMrnQSpp3N+UONAGv03wHiiDjTwgpSdTjzmjzAGHxTrvJe6ucMj6a1bL9eYWkcLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+mAluL80Wxa6VWB5jR4Y6Pk2wVUozxUlat2mNhSPxA=;
 b=qFZ7isBt7X3jfvabi0hWfpm1+aXoYoBwozjfLzQo7UUs3nTvD3BYH3nF194cx3OtswFJh+KPKNt/xrAX+vRdnTku+h1vew5QNjwab8igenKtdwIausa0dv/ZV8FsZ1YD7MYqrSdm9vq1klzIMFXM7hOPC40OAsbLcaFmeAlTelY=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 15:27:54 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2%9]) with mapi id 15.20.5588.012; Fri, 9 Sep 2022
 15:27:54 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
Thread-Topic: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
Thread-Index: AQHYwsihZnSWdyGvYEiiheIFncU2x63UHe0wgADqGoCAAC6nAIABfxaAgACEF4A=
Date:   Fri, 9 Sep 2022 15:27:54 +0000
Message-ID: <PA4PR04MB96407B76D6DCF27798421DD489439@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
 <PA4PR04MB9640CB3CA93301CA1571D85789419@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <3126965.5fSG56mABF@steina-w>
 <PA4PR04MB9640E5CB572980CB087BE9E389409@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <Yxrq9wUWa3/WKI3Q@kroah.com>
In-Reply-To: <Yxrq9wUWa3/WKI3Q@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46a76197-35cc-48da-4a19-08da9277dd91
x-ms-traffictypediagnostic: VI1PR04MB4800:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: neCPNa3pO5ZKGxsKf7ueBexZ+QVmHcgOmvkM+zGVR6GjVwgm3nN5pkEp4dX0QRMldMlR6eyaJAGnJ1It89dTxtaAOMWArA59Bzrcd7jvx902UTXb5cT1P5FEkzOh5Df8DUkPNCgLL8Lrf4WOt5FF1Mrz04qI+R6HQKmAAEptXbORe6sjNyWNMaNSnhl00/1T04XQlN+qkm6p4VLqM0xRsB6OTIfIbta11j7GUMky1ZjGcx+N2sqgkzHBFYLX0f3ndT6F6icfraEHGzAVzlmryXJADnwHqbxTADFVXIUat0mEIgZWvnzj4JeKNBhBDCUjINvE8NQlp84HjhWRH6qwV3Se8pIZb0a5AJBbzjO1R9CJDKizFQsJ9apSV3QPDx0ZO4ta6dJ5dbtamAyS1+g6tcSF3HJgaVvmQkmuxM/XhfIB0RFF4z3IU6Pa0V1ovyU/+6MHGtoIXGg7iT+zpxYHSUyHvA2PGvdNPV2Nmwmqt8ul1/v91bAd0qNGvoBLZI2El3CwywcgLspNe3GJ2x8dkAqB0vFV9RvmQwc1IGPs/Bid/OjIlocA9y99W8H1eZcOu2Q6RAqD/tbm/jPEOv2CyZvSbgev4jzbcjtranSgalPFjpy792rIRt/YajVfPGJv0Ksbx9NAUFpfhBahHvRIthpneqYMkdHsyiWyPwbi9OOVLAIps1kuR3LUE5A8PP9Z/FPRxnKLXJ+5EAL2p2ICtQVk3EH4i/R5QiPVcimphh86d2t5MM5QCncwdRibhJd4sUD4DgTRSxgGVOi3vLn33E8nV6sDzqdm0wzR+kTSTZg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(26005)(38100700002)(44832011)(9686003)(52536014)(66556008)(6506007)(186003)(33656002)(66446008)(66946007)(8676002)(66476007)(7416002)(83380400001)(64756008)(4326008)(55016003)(71200400001)(76116006)(2906002)(478600001)(41300700001)(53546011)(8936002)(7696005)(5660300002)(86362001)(122000001)(6916009)(316002)(54906003)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RWIJdHFY8lxW9Wl67a8y+9VxKKqrkManMjsebd6zb6CP42L1axBar6/81L8O?=
 =?us-ascii?Q?RYMP7TTf64pQmMUlA0pjptN4xX6kzlo33N0ipGnfRWxtO5GxpJURLzAvaOlX?=
 =?us-ascii?Q?PNGAOz+imSHwnAlXFkXJHg83aMAhW10ACPQgq6epXsV0a7vixtu+R2KZz/pt?=
 =?us-ascii?Q?a53kSTD3ZR+y7mT0R1neMeSndZKC4lDxxRXG+eGFroLbj7lYVzBunRpRohjI?=
 =?us-ascii?Q?SePqLaFDmvWipL4BfZZmwaYN4et4/p3qaDt0IRWG3yoWZEazTlCsjDOe4AuL?=
 =?us-ascii?Q?lHNEaohxt9Bb5gAM4+m8L1aMGcYhQmvHa/23KRmwJ5yxPXZDi+TVGQSRT3kb?=
 =?us-ascii?Q?Pkp4yARj4ZyW5rcj4lvc9gahGfGUdlTTiUYpQvJT6XRvwh8Ul5c/CpGbHoHB?=
 =?us-ascii?Q?qdEdxxCeHVgO2+Ztuek6qGqy5DySoV5lLgoyh8DCqWJOwPC4HmXkfjFwqyCt?=
 =?us-ascii?Q?6NZWcD8wAwM+yMD2Mi0tGayAvevdAxveCsBTwtMxR1QhrBQaebrvEctDHSYa?=
 =?us-ascii?Q?JENMxhn7BKwjZU1IYUZVJL1eU+Zj9laqSIT+s8tqP/QOS24L4T6Gzi8erlBD?=
 =?us-ascii?Q?ChW0+eHT1FvIyrvi3kSWsJ0FypJEBp0yk74LDf35E2ZHMqT2JhHk4n8JErha?=
 =?us-ascii?Q?EvxVK+6dd4fe4ML0c8Ila+qxpLi6sLmBjEPsEV27S8uZpIMxeGcdIIGrenX1?=
 =?us-ascii?Q?N84u9w5R3tEM6MN6KbfwTJONqwCT4zZnSmcLXykkk6xVVjMvQhFLeaYrAEe0?=
 =?us-ascii?Q?84t/I7EkMRN9JwrLBIXkQsXEq1r0Z+UONlnDDC1WGzdzKYvzgaS6s5yyd2HQ?=
 =?us-ascii?Q?BF+pDlybQVidBQvNnNFg3qbFM/u234l1GzR1kY/w15MV/HlqgpC7J/LOueBK?=
 =?us-ascii?Q?jQMc492JZJuYx+pFTCQBv9PCWvi802PCM9+fxM8q8w1rzF70F4OrtCnXIvMb?=
 =?us-ascii?Q?G0aCh/Vqin+4e2K06yWYZGthfGnXMijdgNgkAd6R3tYcx5A95mDh6utiV4qt?=
 =?us-ascii?Q?hpy1kbdTZtqlu6+D09cMzYaaAWKG1oZENt4QzCAOi02HgduRprq6FsGgCCA7?=
 =?us-ascii?Q?5LIT2XmaUr6dTfGUa4q4Pbzp+dpYyjXOxJ219XAxbWkBmKE0EhHSiE2Brysa?=
 =?us-ascii?Q?ReiXKwFmVrynPE4TnLvSNZNDembbNEHRAGBMrTHjTnUN5KEpHmj51YWdny2h?=
 =?us-ascii?Q?BJSQdCIIpBT2QIn70rudpWvbvsXUe/16Qy5rJ7Cm+FAbdL3nir/JrEs4N4VS?=
 =?us-ascii?Q?o1ZgpCJ8ybWw7eE2CkT0xnXq2r6Rxz1bemKLxgaMa2uD4klVVBSmzRIF/bF+?=
 =?us-ascii?Q?H0xbNU2nVuRf1Ov4PAajnkRWENS5E1QJa//V+50y/xxo7OYbY8rWQdrQCxCM?=
 =?us-ascii?Q?4zI53hdLjxdWHnMob8kUDov1zySroc7FSkvObcfX7LVEqvIKatF38oRZoJBZ?=
 =?us-ascii?Q?iVO7b4OkdapkMpIdgymUYNnYpwUslYrJJnhR1Tieck80DfGo83ZnvEaboVZL?=
 =?us-ascii?Q?20PHv66cmLUv/UuTV5PDMnqgddEtmVZ6uQbOFkaXqQUfHbyaqMBeRR44j+6V?=
 =?us-ascii?Q?kLjhEDkpSZmBDOua4QU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a76197-35cc-48da-4a19-08da9277dd91
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 15:27:54.1927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tToHAwse3hGGE0t/8uBiPJ4sAZ2WaL4c17nKI09stPbirM6YXhDE3dAqyKGBo4YN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, September 9, 2022 3:28 PM
> To: Jun Li <jun.li@nxp.com>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-imx
> <linux-imx@nxp.com>; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
>=20
> On Thu, Sep 08, 2022 at 09:07:06AM +0000, Jun Li wrote:
> > Hi,
> >
> > > -----Original Message-----
> > > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > Sent: Thursday, September 8, 2022 1:50 PM
> > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> > > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo
> > > <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > > <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Jun Li
> > > <jun.li@nxp.com>
> > > Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: RE: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
> > >
> > > Hi,
> > >
> > > Am Mittwoch, 7. September 2022, 18:08:25 CEST schrieb Jun Li:
> > > > Hi
> > > >
> > > > > -----Original Message-----
> > > > > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > > Sent: Wednesday, September 7, 2022 10:46 PM
> > > > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> > > > > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > > > <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo
> > > > > <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > > > > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > > > > <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Jun Li
> > > > > <jun.li@nxp.com>
> > > > > Cc: Alexander Stein <alexander.stein@ew.tq-group.com>;
> > > > > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > > > > linux-kernel@vger.kernel.org
> > > > > Subject: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
> > > > >
> > > > > Hi everybody,
> > > > >
> > > > > this is a series based on the RFC at [1] for USB host support on
> > > > > TQMa8MPxL
> > > > > + MBa8MPxL. The main difference is that USB DR support has
> > > > > + already been
> > > > > added and has been removed from this series.
> > > > >
> > > > > The DT configuration itself (patch 4) is rather straight
> > > > > forward, but leads
> > > > >
> > > > > to the following dmesg errors regarding superspeed ports:
> > > > > > [    8.549243] hub 2-1:1.0: hub_ext_port_status failed (err =3D=
 -110)
> > > > > > [   22.885263] usb 2-1: Failed to suspend device, error -110
> > > > >
> > > > > This hardware works fine using the downstream kernel, because
> > > > > for imx8mp this ITP sync feature is enabled conditionally [2] & [=
3].
> > > > > Hacking this into mainline resulted in a working superspeed
> > > > > setup as
> > > well.
> > > > > I also noticed that on some android kernel [4] depending in IP
> > > > > core version either GCTL.SOFTITPSYNC or
> > > > > GFLADJ.GFLADJ_REFCLK_LPM_SEL is enabled unconditionally.
> > > > > So I opted for the latter one using some quirk (patch 1-3).
> > > > >
> > > > > I have to admit I do not know what this is actually about, nor
> > > > > why my setup does not work without this change or why this fixed
> > > > > my problem. So maybe someone with more knowledge can say if this
> > > > > is the way to go or what this is about.
> > > >
> > > > This can be updated:)
> > > >
> > > > > I also added snps,dis_u3_susphy_quirk to the board level as for
> > > > > some reason USB Superspeed U3 does not work. Detecting the
> > > > > onboard hub takes much longer and once all devices are
> > > > > diconnected from the hub it is put into runtime suspend (U3) and
> > > > > new attached devices are not detected at all.
> > > > > Until the cause is known and fixed runtime suspend has to be disa=
bled.
> > > >
> > > > For this issue you are reporting, I am not sure if this is caused
> > > > by a USB clock change merged on v5.19, if you use latest kernel,
> > > > can you try with below patches applied to see if U3 can work for yo=
u?
> > >
> > > Awesome, This does the trick!
> > > I was already running with patches [1] & [2], but was missing patch [=
3].
> > > With all of them applied, USB detects a newly attached superspeed
> > > device when the HUB is in runtime suspend (U3).
> >
> > Yes, patch[3] needs to apply with patches [1]&[2], I am applying the
> > same tag to make sure the 3 patches land on the same target release as
> > they will go through diff maintainer's trees.
>=20
> What "tag"?

Sorry for the confusion, the "tag" mentioned here is not for this patch
set, but for another patch set sent from me, which can resolve one issue
this patch set reported.

I think Alexander will send a new version because at least one of patch(4/4=
 dts)
should be updated.

Li Jun
=20
>=20
> And I'm confused as to the status of all of these, please resend the seri=
es
> once you have a new version with the proper acked and reviewed-by added.
>=20
> thanks,
>=20
> greg k-h
