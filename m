Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39E5B7DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiINALf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiINALd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:11:33 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C86582B;
        Tue, 13 Sep 2022 17:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0E2R+wy+ZjhAJ+xT/GN3KeW2vC4qsk6BmGMZDr/yfmJXX39yrwfLp2a7hVmGXKBe02M92+DC4j9oBIhwA9/HKUpyTuZWpZqHlb6mOpTReHqEGsSc9QSWV8LHuGWnFdNL4q4x8R4G+ruKAtf15NBI/SDRWsA5wp8j4k4u3r1ikQ3j3nST9a3wEC4uNkWa570ZJrofa9/ASbv/ERPsFT6sS6jqrvVu20iI+h+pVLqe1yhbJQnmnhC7HTeDp1XQumDiMQKgBoO7I8WvkoKF9D5KNfvmemUoY0QCyZiBLVUbsLElbbZ7EtP4eRyfs/jSz+Cp4ufosjly5wdUQkr1HUxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0iI8VzkPmlrXAHXVpLrHTgAcV8z/FZ/CTOY8g2saRI=;
 b=L3H/7tsrhrrxFcj8P9a6Bco+YDbI8abxZKcIZWjOyu0+csini+Wm5QeeSWqjAJ8twCC5/qFRvTm+Jx43g+ogUtr36Gq9pgb2trSb8wYWbnKLbJcqSZlUi0Vt3S4qxgVXMMqyqRzOAJj1ZZR22lqa4GJvLSJtKJPXc82GuZmGe+dlCfFeZlUWtRg7qdO8kEO325p/ynAryTLcqye7NBHHC0kn8ZGS/+gtyPgkjzoMjQZkePku6dSkAIJ/5RPDJFEWBqieS0BuO2bPNKAqMyDbxTr5VE29b6cDZy2Q+jbss9ekzVeDIEzrLRXrkd+ptbxpS6NIYjgmPPLxyQMwSb5SSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0iI8VzkPmlrXAHXVpLrHTgAcV8z/FZ/CTOY8g2saRI=;
 b=mpwUUEsUarNx3MeywZbh9fc3lbjs7/iZcC4zxTXslUdOeSu2q1gDmyT/+0MYQGqm8nWsPgNLywguQibYI8VKUynfcy0tGsr2I02s38M1j9OKpbI1GtiEsD+hWpQgD6P9b2Tb/iiSBxgwJ34Pb9t9Nf5VJweQt6SUDcggSYIALnY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 00:11:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 00:11:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] dt-bindings: clock: add i.MX8M Anatop
Thread-Topic: [PATCH V2] dt-bindings: clock: add i.MX8M Anatop
Thread-Index: AQHYx1MNvHt8cAwWZ0GJApML/seOZK3dZQ8AgACnecA=
Date:   Wed, 14 Sep 2022 00:11:29 +0000
Message-ID: <DU0PR04MB94173A2BEB0DA8EC22E3EBDD88469@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220913092908.1708931-1-peng.fan@oss.nxp.com>
 <638002c3-f402-96d3-7eb8-991f7f05f703@linaro.org>
In-Reply-To: <638002c3-f402-96d3-7eb8-991f7f05f703@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB8044:EE_
x-ms-office365-filtering-correlation-id: b1c5360a-6c42-4d1e-7923-08da95e5ac60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMGcj3wRxvxMLPYLbYSHdN5WVmLodYeQj0iiqXdYegk8DjocamSB4wypg2YMBzpC5RapXhYYYDbhniXXIlzmFIW90zvIAcIGRW4tLF3uccRbccjtxtu95tlW0SoY5Fi6zflHErmGSuijZ0noP5QTNn1PqREXgq6UTMsfLAjPrDJr1y4PworFN3ePR1ne6+c1I7BAGpMbyuO0D4uvY2B/630uJgdyEh/VvuzKNT+EUNGTe0sdYXkUs2Br0pE5DrwItePG5MkViUV+Ip0HCTQYaY8ESosbmrzu6lxcpvvfEYzg6RfoBPWuQXX/eGQ1+QjFafvrrJaknMwBEc37+L7AavqaYmm9odgv71yx0U0r5CHVg5xL6uMyhqD+YVN7EQ8hP3O14iQ4zbS+HEA35i/GI8qJ8OZ72ZT33jO9xk3AsKbZqkG/KVewx5bLNzseiRelia0I1dNjSJbqGsxZjcKdkOv5P28IxcU0QjKzvYNpk9t9cl9K4tjBNp1Fi7jS+N7/7tuVXaW3rmOMl4Ti2dV7qFCBNtRw9homzZMdU6/P3ib6OOX2lXLuFUgjk6SrZ8ausEx8KourwXILK8szjR+cH0CCpPzb9R60aVpvwXZ5qj8CmF/hf+E+1MZRoHd1HcfB68hcMiqCHpulAZNX9FA++5Vtd81Dx65ne/t4/Oxl4g994UhIzQKrJlq3zETBY3BhYiUPF6mfoQzoWJUyAHUrD2MfeQc81rF1NcwEsfbVkaJv5JuDg2MVSYtIDpR/V4K08fgTCM/y0UE0nx6jM4+akRPpNUzRdnhuyj0xISWRKeKgDC7Qn6iYH5OGNPs0CEhJbKbl2niTCUXZPyLugZnMQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(110136005)(4326008)(41300700001)(316002)(38100700002)(186003)(8676002)(2906002)(83380400001)(45080400002)(53546011)(54906003)(55016003)(64756008)(9686003)(66446008)(66556008)(76116006)(66476007)(122000001)(478600001)(966005)(71200400001)(38070700005)(8936002)(5660300002)(66946007)(86362001)(6506007)(7416002)(7696005)(44832011)(52536014)(26005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uJhPUpChnN9S9uEyzgKqPcVQU5RncBqvgmPeS4wQMhZ7NlNbyTEcwWD0zkP9?=
 =?us-ascii?Q?vDGmVMjt9XG6b06OUrVw0CsapTy6uKe5mRztglIa+p4XY+8e+D1IoipNeu7m?=
 =?us-ascii?Q?IvPQC43VLtwArdAg1YWhyE2f7y1pIKMIHsoWylHGtf93RB6SspUzB0RCoJ8q?=
 =?us-ascii?Q?kqyKK1ZXNWxa3hqqglBx2od1sgEpJF7i8C2dXrss6mkcb9iii5Wnb7wqcrWi?=
 =?us-ascii?Q?mrBTPXaerhHamNe8S0kjD+dJKs9CqTi7c9nEnQSyOslUeHro0E6seElL95JM?=
 =?us-ascii?Q?DJPbo4gAkgCP3Bxl2ZrL7x1OmennKELNCgG9Ulb6kQdrYUF61v7srzG0d34N?=
 =?us-ascii?Q?e8yqVZL/5JEcMF5zbvWsAgEP5Wo0MrcXBqMz1dGvS8tFbd8nDrCBKfkdTvkg?=
 =?us-ascii?Q?QqsID8YyaSi3i1phuQ63w50ik5UT+aZxj2SNu9DUAy9EIxPoHytPGuBzx2uZ?=
 =?us-ascii?Q?E35ZudXGt4zLFo45lrCVDKNSc/+/LK8oYe6YS+yve5fPckPPaPGxRMcynUU6?=
 =?us-ascii?Q?dK6OqKuuJ9cQeJiO7KPQ3XaiHYFGQt3hKqX68nv6vUNJpKOpmIKh1FSzBghi?=
 =?us-ascii?Q?8vfMwSXGFmcy2zxzJgY4EbaKgKEkfOM84XwTOswyGDmnRer2/0PKMX5QmWGC?=
 =?us-ascii?Q?C382GNpeKJGbMEazcBblZUl/Irxsk35aXitt+c/TwG6sNd8rNgbs6hFt1OVJ?=
 =?us-ascii?Q?VwfmQ7znNo5M33Am1EFekt2OL+woLxhLulbuiGvpCvrHfpltCYuF3RaYMtcF?=
 =?us-ascii?Q?w6o28ukWreGO6skM36W3gxa7URKiXwrNptaNMJ1zC+mqYNQIQzKxcif1gdlt?=
 =?us-ascii?Q?uEsT4Cbf87lmWxDAECS5k07S4ordqiq+492oxmsXgt+uSQIav7v2vWm8c3Jd?=
 =?us-ascii?Q?ssUSeYsyfCYhviI213pxglIJkyHd7yCSlYQvuleed5DiDt5eFeKkIfMVu4oi?=
 =?us-ascii?Q?vysB1mOUQEQt68H7/FTHc6i7HAZrmmXNiR8kSMIPw6c+SlH013kXD08hJkn3?=
 =?us-ascii?Q?OyNLBJiJEaO/1NSNxZ0S9y5KInbbvK/p18CL6Vrk5afAt3W5F9wj2JhWTED8?=
 =?us-ascii?Q?btTPxwigXzKKvj1mAUv3IDSyhe962fC73bK2QZ1JeSAmMx7y/XDg8/VzdUeb?=
 =?us-ascii?Q?X+C7A8rU6QXG1w1rzYv1d4iph9m3si9YJK/ushKayp/LgN3DWlbUX17eFGBb?=
 =?us-ascii?Q?rsdJGIlQ/CYBJBg+ygUYWMA1/h+r9CROEWnuBUDoxvSozUNyxrmTkBNh8VUK?=
 =?us-ascii?Q?rzLDw43ujPX+Ddzi/s40lLv3hdRbLwjK7pBoLLTfbipZQO3n10qw8nPH0hhJ?=
 =?us-ascii?Q?kyIH6axREYP7vnLPJCNf8NqnWOuzBv+0ObGYkTFTiciHNbcsqarisTHFhpSh?=
 =?us-ascii?Q?ipjuwfmg/uboaBLVI/raaokFkUr1HNFN4jFtEJSpVj2G807gcJfjJXyDR9bJ?=
 =?us-ascii?Q?M96Pk5d6haerfHH9d8sjL2w7bOVFaAWc4RpI3pVaupHXGuXKWtLSu2JviWns?=
 =?us-ascii?Q?BAgnkGKwv+l5Oye4ADyMgjt//1/kTghhPTn1kxXCzW/poxxX5mdbxkO0VgNK?=
 =?us-ascii?Q?5vxQI0+MpFxLG2HGPig=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c5360a-6c42-4d1e-7923-08da95e5ac60
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 00:11:29.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5ms+oAwer5X4GVflBFZBt/CbrR66wMgU+q6SXCOg2DKtoTu7KdVDD7QJvSQbAiy1U4t41SWm/Tqn6jlwAzC0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2] dt-bindings: clock: add i.MX8M Anatop
>=20
> On 13/09/2022 11:29, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8M Family features an anatop module the produces PLL to clock
> > control module(CCM) root clock. Add the missing yaml file.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Drop syscon, use clock-controller
> >  Add fsl vendor prefix
> >  Add interrupt property
> >
> >  dts update not included, so there will be dtbs_check fail.
> >
> >  .../bindings/clock/fsl,imx8m-anatop.yaml      | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> > b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> > new file mode 100644
> > index 000000000000..2c0efa58d898
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Fclock%2Ffsl%2Cimx8m-
> anatop.yaml%23&amp;data=3D05
> >
> +%7C01%7Cpeng.fan%40nxp.com%7Ca3a47985f9d9452744af08da9590fe79
> %7C686ea
> >
> +1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637986747221860721%7CU
> nknown%7C
> >
> +TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
> iLCJXV
> >
> +CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DI4LSaFBDMZv%2FcgFyIR1w
> m2Irc%2F%2F
> > +Z9eKChPCJY7XMfDo%3D&amp;reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%
> >
> +40nxp.com%7Ca3a47985f9d9452744af08da9590fe79%7C686ea1d3bc2b4c6
> fa92cd9
> >
> +9c5c301635%7C0%7C0%7C637986747221860721%7CUnknown%7CTWFpb
> GZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%
> >
> +7C%7C%7C&amp;sdata=3Ddm5exAJpmPmY%2B0vCuZtpzt7k8GHeKZKtitSvep0
> 5G%2Bw%3D
> > +&amp;reserved=3D0
> > +
> > +title: NXP i.MX8M Family Anatop Module
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +description: |
> > +  NXP i.MX8M Family anatop PLL module which generates PLL to CCM root.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - fsl,imx8mm-anatop
> > +          - fsl,imx8mq-anatop
> > +      - items:
> > +          - enum:
> > +              - fsl,imx8mn-anatop
> > +              - fsl,imx8mp-anatop
> > +          - const: fsl,imx8mm-anatop
>=20
> You dropped syscon which solves part of my previous comment. I suggested
> to make it proper clock provider, so you would need clock-cells. Any reas=
on
> it is no a real clock provider?

oh. I overlooked this point. The current i.MX8M linux clk driver directly
search the node to get anatop base:
https://elixir.bootlin.com/linux/v6.0-rc5/source/drivers/clk/imx/clk-imx8mp=
.c#L416

Not take it as a real clock provider from linux view.

I will add clock-cells in v3.

Thanks,
Peng.

>=20
> Best regards,
> Krzysztof
