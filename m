Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25476A6593
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCACfi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Feb 2023 21:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCACfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:35:36 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594FE32CDE;
        Tue, 28 Feb 2023 18:35:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzVCRn6doF/iIWYIaNAx8ONdDXf35ddkSS+QVDWKhaJUwRdNWK03tOgn6CIq8zGCHKagnyydotJCrjIiUy9ZWALIy4IwEfoMWWENKAvuXw3Y1Ss0cBWMKDSwIvJwK6B8ZkpVW6U6P2JeTo0QigYCx/imbJJ8gdHtfMN2Wl23hnh5SophbyDPN+LLNNJgQbNJuF2GsgmRuuZFIwkdXXmmsH8/bJTEvbWWDJJZDEGvmZiUSOsu8CiGy8n0TYEUbIHAqkyXyo/Ua35Yf9/hoyOJvj7yELKjxbHs1Gezk/h/TBU4fHsxXEEgPAXsAnHuygljHu/M+dyaG3snVyt+NgobIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJfHpWtsFQCvpKFm5caBMdpm+NWH0XDspa+bqGZ88MQ=;
 b=IXZKU74Xk2vgcBPW6gaixHeEgpmT3CiLoVgDLRBV9aVgHKoTQDa+z8htjA95V84DEqACJ1xpHOcc05JAD2ezYq1ooKNmK/Y2QZ5RljZ86X5M9wTKlIuXptjQECBGYSevrpYRfdC/sUnUEKyqhamUii7hMBVyqqi7EtMTaO1TU2tsXICMUxVtYlCoBETAu2zsgd+nSGz4gAJmwkeYCuVG4+aAdMXzvtTL/Mb4zxCoGifuBLC+26sgxwDJFw3nI3WOBt3kJbCUEpbjfUHoHHnDDVtP/lUQr42qFVwjzPYcsgCYeLim2ta7LtX4xOLY0gepQ1ycjiuFUXuh+MONOGMNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:35:31 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::1793:79b4:2cb7:4db]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::1793:79b4:2cb7:4db%5]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:35:31 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: clock: imx8m: add interrupts property
Thread-Topic: [PATCH] dt-bindings: clock: imx8m: add interrupts property
Thread-Index: AQHZS+ECotOWgCkTKUua1Qtf9bVuNK7lMhAggAACxACAAAA5UA==
Date:   Wed, 1 Mar 2023 02:35:31 +0000
Message-ID: <AS8PR04MB86427383662B9852BD16477187AD9@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20230301020122.3389102-1-peng.fan@oss.nxp.com>
 <AS8PR04MB8642379DB76D1C529CB8960487AD9@AS8PR04MB8642.eurprd04.prod.outlook.com>
 <DU0PR04MB9417700E2F71A06D9A7247BB88AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417700E2F71A06D9A7247BB88AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|VE1PR04MB7213:EE_
x-ms-office365-filtering-correlation-id: b9d48bfa-dbed-434c-0fb1-08db19fda091
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pTJ6ywDmxhqd9oXvm9xoYBTMNt/8jMB776Ha3lZUnESXs3ZZG/ZNsndGNPnMiXK5d79g4XWRmqc4ng3XpozV3488AEB4Re9gatYDsO+9ypIzrbY++Qe5KYAEKltJCUnX6NUH/dZaplPxWIzd4nyRXTSBmon33nyqq4F9XX1Y/W85fmv8E3Kxe023i9SMVWmoN4TDMwv9hqeAL/n6kgKOJVgB2vqfHMTT/wC+SvkPaEkQXCXinPqpSUguZ0MW4RU7kiRVY3MLHSI7Kpzd9Z9ZsKUaN2lhMB2oNwk4nuPcwPT9j98qvtdbvDAd10AnOuEShdtTdq5+eT86B5dzgJCXRa9KGj5UR5rCSUlPWFgxT4SVrdGVvQKP/vfmFbDWW/AU/BvycAB8L9MKqlcghVrjuixmpwEE7j8jEdd/nHJ4ECWKIIvlJKZerbG18IEe0OoY34b9NngSDFUEmdK1mMfeyYu6aDu1z1Fxy2THHQGj5RO98NVcukY8tSxEfPoT0PcbR2vXEiwjacyP1oKPqCYkO2taNgoODdbClPSjXrr5pNHHGr9AbpxBupt0maFVgwJQsrLYxdkdwh/Nmrt5aeEo3AyPMe7MVuDKya9EpSARwk1zMUg6k0KoHgMZlK4jlnfzYMEPT+G+XfMq7fNZ6NNQijyYF30o7TuAC+GAhuM9VIH9mh3LbJjZytFwHwXYS+YWTa3uioisja9puGDWUjN4+ci9fvzI6CKl1roEyq9x/thCP0zp5oGXu9cAVy/ayNBO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199018)(33656002)(54906003)(316002)(110136005)(478600001)(83380400001)(71200400001)(7696005)(6506007)(9686003)(186003)(26005)(8936002)(41300700001)(38070700005)(921005)(52536014)(86362001)(2906002)(5660300002)(7416002)(66946007)(66556008)(55016003)(64756008)(66446008)(76116006)(38100700002)(4326008)(122000001)(8676002)(66476007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iO+zm1/NVjcLhzNtFR2o0cZWdJK452gNR3sq2+xhNoRMjrFTfFuheKVswf5h?=
 =?us-ascii?Q?995/G1kte8Adrd2xflitjMg3lcGsZQ9Q2u8O3Vs4Syxawyy71SSoFV/pog2X?=
 =?us-ascii?Q?+zSxe9BODaLTj1W6qTUDc7ijwnDMa5sPUcHvesFRL7Zmgq7NltoD6TBe24Ro?=
 =?us-ascii?Q?Tc83nnmbG5SGJkL7Eb6JymmMrMka988d/SYG2o7k9wZKLXr+WqCA9RHCarEU?=
 =?us-ascii?Q?g7RrjdXenbkqT3vQw4mvT/PAV6lhQ3Ap0toNfEWwFiiKIhQCKjgrxd26w5RR?=
 =?us-ascii?Q?S53qmgLaKDrmnT+FeYOE3fotqdShaIOebN+ir1deo2HVLkFlBKkRqPxGjT6I?=
 =?us-ascii?Q?HdxQ9EtKjRQO8eDmDJsIpmQl/ry5vmuS/A8lSp1LVGCiht23oJgL/UgGxq12?=
 =?us-ascii?Q?e3XzK2hNAG4oo2YHrYPCaUIQnGp4aGAv//QGiVVQyFUxCfWl70ao0P7jmE1b?=
 =?us-ascii?Q?GT+huX8LKM6dGEeRPr+RHOm+85TrTrdWnOwjH2PcIfQOjppjyW5tZSsdKYIB?=
 =?us-ascii?Q?2GLGJvFoxotSUXyReSQ9wv9N4TisGGnIM8LJreOFpzdZKe7Q2XUR4wjTdh6M?=
 =?us-ascii?Q?lO692BmU8d9tTt+aRCDA2e7HbjcXBdLHPHBsdIpAMX5fMgcCkLo9rN655xfD?=
 =?us-ascii?Q?iQAyybRRB/D+WfZ4NmlvUylujf28PJ3mATERmP+T5hinHzDRL0/6isTrcupI?=
 =?us-ascii?Q?4tQFDkKlIS5hpElAQegkKc6S6IefA85c0X5Q+Uo4dYiukqyC1h3SoYgQnoC4?=
 =?us-ascii?Q?N1f4Q4FT9FSB9T1x1ikpjgRMGd/I98VlKWfLy08NXpZvDn81Q9QnowUwSNdo?=
 =?us-ascii?Q?/rYS5awsRqS3xBUKwSdWbzyBW0PtgB8NyebcBZgIxQTaqLt6V3lcV/bol+Vz?=
 =?us-ascii?Q?YlgSLL2OX5Co9vZxb+1NAFoTZCvuuT+8HRA4K4w6aJWYuaPH5s/SKy+bizfq?=
 =?us-ascii?Q?hOkuIeiJEJ3ptEhv+yVXviAfwYLT1DS59A5w8gGjsDuegMLRUm7iHZ1y842M?=
 =?us-ascii?Q?5u5caYHDotIZ+4NmMXd/SF9DaOiez8VMB0eT2PgmVZsW+FDiRt/XGkj5znt7?=
 =?us-ascii?Q?g4PsN9GRAvHkUM+cB29qJEF2pInNJrSlUDXLHhIylmV//dBAepdeITIOTYQj?=
 =?us-ascii?Q?ZfQ5K6ZM+syTVYPTwIi1RP1gT4hgvyYjvBiU8d0VJQm2U2iGABHfgrwGeRLv?=
 =?us-ascii?Q?mX+GaKiTHQmMq7tr3vo/a7NQ6n0awtCbUtwRHf6JlkOywcm6PzERQPxVXPbY?=
 =?us-ascii?Q?xpLffywZyjbiehHWjBvKOnxpoG+FvDz3PBbqGPx7RHUGoUmDSbfu9htUecf2?=
 =?us-ascii?Q?996zDkHJhf+nir7nfS7srU6zuY/vhp6+Ml2XOvUssCTyRWNNRfKonEIAbz2I?=
 =?us-ascii?Q?xt7NLdK4a/Ia4U3gIroL9l+i/38BkJwP9G+gt+ihq66+Gb7X/cWIsa+7O6QA?=
 =?us-ascii?Q?xxnJTDFG1kWluw9FmSTlNWnfCZHTfQSsmIdchOb88aCcHQ/tUcqorxo4YRrO?=
 =?us-ascii?Q?F5Da7jbyemc6cK0u7IxkMvh9JfZYTpQmDtSvpS18L3s+Yier0/Y5nV+6aqn3?=
 =?us-ascii?Q?ojLMKnephKe/ZJDG6g4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d48bfa-dbed-434c-0fb1-08db19fda091
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 02:35:31.3870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6wuNBUF+a2oi3J5IVwuF19mqm93hPlNWWH1cbmqjOy/Jb/KP7FBYibaidEDRM84x7QlAZjcjTp5evZiyZBdRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [PATCH] dt-bindings: clock: imx8m: add interrupts property
> 
> > Subject: RE: [PATCH] dt-bindings: clock: imx8m: add interrupts
> > property
> >
> > > Subject: [PATCH] dt-bindings: clock: imx8m: add interrupts property
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Since the CCM module could trigger interrupt, so add interrupts
> > > property for i.MX8M.
> > >
> >
> > Any chance that these interrupt will be used? More likely such
> > interrupt are useless and has no details about how to use it in RM,
> > just piece of words in the interrupt table.
> 
> This is to clear the System-Ready check warning. This is to describe the
> hardware. Since device tree already has it, and the hardware indeed supports
> interrupt, so let's add it.
> 

Ok, got it, thx.

BR
> Thanks,
> Peng.
> >
> > BR
> >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > > b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > > index 0dbc1433fede..ac7ad8459c79 100644
> > > --- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > > @@ -39,6 +39,10 @@ properties:
> > >        ID in its "clocks" phandle cell. See
> > > include/dt-bindings/clock/imx8m-clock.h
> > >        for the full list of i.MX8M clock IDs.
> > >
> > > +  interrupts:
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > --
> > > 2.37.1

