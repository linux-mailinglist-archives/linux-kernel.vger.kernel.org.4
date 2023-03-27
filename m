Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8456C6CA0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjC0KB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjC0KBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:01:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18B219AC;
        Mon, 27 Mar 2023 03:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr3G0AIUe3ZAiS0QqxmS2ymJP5R0pTzMl/yJ7qtVrKwIEDMOU3VXSksqdvyfVzcayjZAzs9iIPQzi22M72PQ1muu6zocLT++PeAs7QtlEWdRp3kW4napEpS75TdrpOqnBEjto21Ko48eoW2RYBlFI/P7GCig77pylvfkQWx0j6F7zo50F6IjZUdiHMruCrpsXs0G7OjjkuilenDwNhFZfM/NV0DkAdbYIyl5DtiVPqFVK93coLOk1yKi9toFDNvDoqeqF10f+YFUF6KissqeVxQx6kA9WNDCpbuYWSDcfa+tafES8rTh74rsxfoPQ5Ic3Q2w29Y0lIUyB1DGuEXopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6kGFqkwoW+L4X63fM/0viQOXvj9PI4d05Iindwvh5Q=;
 b=Qh4mjRtkjYGYdbA6OeG+6cCN3g6p13Lqhw716uI0182zNd0vO/DJcVU7LFOa0qnEYvog2rojnYovxULTifEcfadIKQruOWY66XFXPTaegYoeM+cxfCr9CfjX3GNnu7uixTyktlIUlHvRcK6N1UJ/8vkYLMEC4lim3dc7GILmLpEtOukAeWCJD8VnuwIvaPhUwAold+XrtKkamw02NJzrAtKFLuRmyIX1Zut344Vp7NHw2TpsHmgDqM7pUUrpcbNCLfoMtPVKNJUEfswDI3COSv3yr24M6c4hwClG3L9zPu6i4DQYdoRQvGAJlEIP3zdqo5HMeMAevHpuaW31Zyzanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6kGFqkwoW+L4X63fM/0viQOXvj9PI4d05Iindwvh5Q=;
 b=d+9HySXdXPvb2CBQPdoUTyCqYCcR67jJbn0Tcp0Wdbvv7YQ/hd7L+ZIRlL8kUs+AbIH1P/9LMED1jT5vv4+1MpIZcANRtYK6PMDCSwVg2sm2+t/xLcm/Bibr3FiLcIoTJWnj7Duq5YSnDPrMgXSBBpkma38uhM4nb12+KA2LUxM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9888.eurprd04.prod.outlook.com (2603:10a6:102:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 10:01:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 10:01:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "gerg@kernel.org" <gerg@kernel.org>
Subject: RE: [PATCH] arm64: dts: imx8mp: add vpu pgc nodes
Thread-Topic: [PATCH] arm64: dts: imx8mp: add vpu pgc nodes
Thread-Index: AQHZYGnzfuhET8vzU0qSzMmiiHJQlK8OZTnQ
Date:   Mon, 27 Mar 2023 10:01:50 +0000
Message-ID: <DU0PR04MB94174D60EE38B56FEB6CD5BC888B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220713063653.2584488-6-peng.fan@oss.nxp.com>
 <20230327050642.593778-1-gerg@linux-m68k.org>
In-Reply-To: <20230327050642.593778-1-gerg@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAWPR04MB9888:EE_
x-ms-office365-filtering-correlation-id: 2991739f-bd5b-4d56-12dd-08db2eaa48a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kKLWpRjyf5Ub+aSmyPchmNeoeNeMs0OamqX8dOZ5TUP83BI/shDtpGH8qhbvjMBb6PhveCalOs0/8GqiV4MwQPVlFHjS1FG/rGXyYog/pHxZfQ07PhGNTcF4Q6DKeiUGmAYDbf4k6dzr7HAFZqx21edgJzoilGUq1yR7CLzGAXiWxF+qS+IWk8Bxb1x6sVqMBrG28EAQ9W2A8z5wQn4r7nuUq7+VVoftFdNqJzTd+wJH3Dw0GojNaNhGlZ085QRwgPX0cOF04K/Mznp3yQqr+zWri15AtBUPuF5WGmU6Y3cIpPw26If+KcqFrvbOsnNeuFBvnW0a41VGT78+pLocXYhzoCS0IPjNz9YERdbgoRwWfXglMJCjJ87cwsZByp/Zg3gk5ywYEXfqxn6A6LYo8atUcJmpv0NbsfdsFkcqwGkkCpiWq2C5oC6zEOdrcAL158vDc1I0kjY4o/jEMhf4Wy7+03Emctmtr4K4VzmDfeP/FOL5RTDYciempIgXP4pKeLuXLgcpr7TJcWTrKeyfhL+uBz5KiGJucnzIbENtcuqMVK2um1U4/+pW+R37Dnt4oMAWyOVWVaBMHl742nYVmvYVh7ml2XkyueMx3oAvei7EUaJ4FQNCzVsOaitU5P1SRFMRJrt/rSba/v5fZm9WUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(9686003)(316002)(7696005)(2906002)(5660300002)(8936002)(76116006)(33656002)(38070700005)(53546011)(52536014)(66946007)(26005)(186003)(6506007)(44832011)(38100700002)(71200400001)(54906003)(7416002)(66446008)(8676002)(41300700001)(66476007)(64756008)(4326008)(66556008)(478600001)(86362001)(83380400001)(110136005)(122000001)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XsdGG1lP8S8xOxDjLNifExGaruPQvdAkStKdOkK/0oqE/ytiblmo6jDMrpF7?=
 =?us-ascii?Q?GLqIgBxuAVvMDWLxTziqZGE2I6PTPKuOKzBxcM8Gd470ytD8foJvo2v00aWb?=
 =?us-ascii?Q?BaxT1WbDY/ajZPPjIrJP3dhvfM4qDxwkvpA2k+vhr15i5pykTwlMl4KUZ4Pq?=
 =?us-ascii?Q?cxowZrhiXqgrEc2ChenXiEEiS7FZ8+t92fzxIYKMJ0GZToX7//AT+biwrlYi?=
 =?us-ascii?Q?NkdcJmRGZPwQ0eFZnsblFB6JbfD1Ew0PonZOw0gsbKmzYiRpNjIo3B6pfGzY?=
 =?us-ascii?Q?X6keLd144DIrLhkgGnfgjGIJGByITadA4gvPsNuO+cUFf7gJY7nqwZ+y1O4Y?=
 =?us-ascii?Q?Bw7/PTfMjcF2LduQWrilkjPc7mnImSyJtvyBpsc7cqIJvrs7z8zpZOEpyb0k?=
 =?us-ascii?Q?yylSXWIxx0qhydwHHC63HU9AB1PWUsmCKqyzTMkIlPz0wHG8sm1AJbuCFcxK?=
 =?us-ascii?Q?WWa8q7uHfUzpmHiq99rKWLjbidYDCu/KT9vpJb98RLswVH4LZZ+EJzcx4W6M?=
 =?us-ascii?Q?EikBZmbqEyoBM/W//y3HJOBVpr69zLsuvnt3ravvQuHTYc1FF/NavyW5Rr0k?=
 =?us-ascii?Q?8zT/69bLeMhDSg7yiMvzzy4qDc2DWo1FKd+u1L0cHVpfcxEUYsTOkObJOxs3?=
 =?us-ascii?Q?+8Uuts3uRk+6sq9HffjfMFtWLMyBQpxgD6HIwhsTumDZIPinGAONi8Z56dSQ?=
 =?us-ascii?Q?hUK9llznAihCiYi02Ta3VQdHzvCDUE68ugfdg7NAdy3dtTKgVVJYvhqTZ4+J?=
 =?us-ascii?Q?yokKPkzrxh37JdZ6f7AUPYfpYxUwMFz3N0J+duKgeHCf3ekS5WQ7lF13sARO?=
 =?us-ascii?Q?XGFwy7U9aNJbl2N5OGayI13alOgReCPLeyQeJrPGPTdDQbihsHktoclcawB9?=
 =?us-ascii?Q?Ui9N8OktIGrsVnSt0cX+h3rnP23hZCR47mp4nI1Zby2Y27gE3qRrU4eoEJsH?=
 =?us-ascii?Q?05OMV46yotX8h74L7qWHpku53IaZnHGO4zqdkzd3238VOaaG/aRI8NBZiZwp?=
 =?us-ascii?Q?veOnrhkh4qLVmJ96ab4NVF22AmmQosJas1mQqgJPsNisAeaJdP0bBjljAHBC?=
 =?us-ascii?Q?4yqqASIrIQobQwO+q2gJoLDJhy/Mw+eqKfzgPRF8cPhRsImJyTr0JwhZG2uT?=
 =?us-ascii?Q?uwyY/Ibt4nfNl+iH1cLMnBzJmhXpiTuxt2f2gaVrJpbuOP1AoQMMUldP9GRa?=
 =?us-ascii?Q?BdlKavNMALAbn51buzE8uOU9rzr6igYxQPGzIXL0/MVwMZj/dgf4hcyOFGlg?=
 =?us-ascii?Q?hl/eOnNfuuP9FxETkrE8QPS3rPh8/8HYmfvrivxqAgwrBSVy7zmJdF5yTFLY?=
 =?us-ascii?Q?84VZXGVBtbWp8pM/z8ieii8MG9J7ywoznt3ROJgLuK8Hi28GZ95e2ojMXQQn?=
 =?us-ascii?Q?DMz6VmMSdnrztTVqLp08oZKFxLAJSymy7Bx53XCcRynPjxtqbN+oyDQ+/HT7?=
 =?us-ascii?Q?J5VT+fLmsdqloGwePugbWddv/pHhDCVbC3qjGmC/DZb/RO361GIbPskCvx6T?=
 =?us-ascii?Q?ktc1sTgI3ov0cQIhC+8cTXGCxA3VkjnX19VZoggKuSRIjCPakm/2rpiW1PHP?=
 =?us-ascii?Q?PBJIHfEGQAz82twByGo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2991739f-bd5b-4d56-12dd-08db2eaa48a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 10:01:50.1001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juEerTqYrr6niluEKOO/P74tza+UlNP/PnUftbyWDa50JOvBDDg8aIxLdu6gHD0k8LyKFyNCiz6pz7UyFIlCAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9888
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] arm64: dts: imx8mp: add vpu pgc nodes
>=20
> On 22/8/22 14:45, Peng Fan wrote:
> > Add i.MX8MP PGC nodes for vpu, which are used to supply power for VPU.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 27
> > +++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 0b165f98a82c..34af983b0210 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -598,6 +598,33 @@ pgc_ispdwp: power-domain@18 {
> >                                                 reg =3D
> <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
> >                                                 clocks =3D <&clk IMX8MP=
_CLK_MEDIA_ISP_ROOT>;
> >                                         };
> > +
> > +                                       pgc_vpumix: power-domain@19 {
> > +                                               #power-domain-cells =3D=
 <0>;
> > +                                               reg =3D <IMX8MP_POWER_D=
OMAIN_VPUMIX>;
> > +                                               clocks =3D<&clk IMX8MP_=
CLK_VPU_ROOT>;
> > +                                       };
> > +
> > +                                       pgc_vpu_g1: power-domain@20 {
> > +                                               #power-domain-cells =3D=
 <0>;
> > +                                               power-domains =3D <&pgc=
_vpumix>;
> > +                                               reg =3D <IMX8MP_POWER_D=
OMAIN_VPU_G1>;
> > +                                               clocks =3D <&clk IMX8MP=
_CLK_VPU_G1_ROOT>;
> > +                                       };
> > +
> > +                                       pgc_vpu_g2: power-domain@21 {
> > +                                               #power-domain-cells =3D=
 <0>;
> > +                                               power-domains =3D <&pgc=
_vpumix>;
> > +                                               reg =3D <IMX8MP_POWER_D=
OMAIN_VPU_G2>;
> > +                                               clocks =3D <&clk IMX8MP=
_CLK_VPU_G2_ROOT>;
> > +                                       };
> > +
> > +                                       pgc_vpu_vc8000e: power-domain@2=
2 {
> > +                                               #power-domain-cells =3D=
 <0>;
> > +                                               power-domains =3D <&pgc=
_vpumix>;
> > +                                               reg =3D
> <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
> > +                                               clocks =3D <&clk
> IMX8MP_CLK_VPU_VC8KE_ROOT>;
> > +                                       };
> >                                 };
> >                         };
> >                 };
>=20
> This change causes new error messages to come out during boot, for
> example:
>=20
>     ...
>     imx-pgc imx-pgc-domain.8: failed to command PGC
>     imx-pgc imx-pgc-domain.8: failed to command PGC
>     imx-pgc imx-pgc-domain.8: failed to command PGC
>     30890000.serial: ttymxc1 at MMIO 0x30890000 (irq =3D 197, base_baud =
=3D
> 1500000) is a IMX
>     ...
>     hwmon hwmon1: temp1_input not attached to any thermal zone
>     imx-pgc imx-pgc-domain.8: failed to command PGC
>     imx-pgc imx-pgc-domain.8: failed to command PGC
>     imx-pgc imx-pgc-domain.8: failed to command PGC
>     ...
>=20
> They don't seem to cause any problems on the hardware I am using, well, a=
t
> least not that I have found so far.
>=20
> This first appeared for me in linux-6.1. But it is the same in todays lin=
ux 6.3-
> rc4. Reverting this change (not completely trivial due to a couple of com=
mits
> after it that rely on it) fixes it - no more errors.
[Peng Fan]=20

The VPU BLK CTRL seems not enabled.

Regards,
Peng.

>=20
> Regards
> Greg
>=20

