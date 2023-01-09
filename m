Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9007B66296B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjAIPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjAIPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:09:21 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2122.outbound.protection.outlook.com [40.107.114.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62406B3;
        Mon,  9 Jan 2023 07:09:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVlDTxIRQF/RAfWaBQKPrVbmul42c1q5hI7wXTixOsHXMgZIa5ZOyf7l3P0C2MTIQ9e32qnCZ3/tzmMgNfVuF7nd2seieX3mSONjHoAsRTmtB4ezE+oxiYXcJyNZI7hShrJvHTm8TA1UrIh2AdXABE3wtBi9hIh4wpiW1C/gAM6GKr/+LOzVj5VccN6REiKA9++Vm7yYlVeieeQGowMUYYLxfAXA0W0BE1MSS/xTTMdqS+ZzjAngm14j/2yVtdaG64ZzXUVFSCbJ2JyGFmM82MjfvaGhiqInK4w4onh8t3Wi0D1ckPB4yL4417dgOv8vvT5SBdxoXHlNj8hsH7asag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixqMxH0nHT3N5dcKYSQ23BM1EXY6aUT1ETQNY8AyqMA=;
 b=l5t4sFJrR2XiOM7mewW6+u17SgirD9WfxAnDiDewxJfNgySihRBnHbU+7fED+WV91y/DAibTlbDf+QZJ6ZKINQRS1NAxstFpTQf+yATBJlJQlTB46dyeRWgxHHB3lf3RuOxJjLmFeQe7GDjwcgHA4AEXrCqqTE6kunuavtCf2KSf1sRPk0xsE38uQV6WvxNFUX2OTJoXnayj1pjJdkx+RYvTCCyNboDBpDjPVzqsFXiXUaqcvfw5waI04nPR+xPFPO3sDK6x7mjTBhN79vhrPGMBjmO/sWvMHMcm/tnbnt7V7JdPwcaRCxzS3jQdsqJbmizHP842B/U54wmHXDnFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixqMxH0nHT3N5dcKYSQ23BM1EXY6aUT1ETQNY8AyqMA=;
 b=EuBWqFQd0+Jz2/n2RgBAYbrQZJQ+An1vQHOI51ULxiGAfXS70Nbh48vx6PQohAA77FlndXl7QNZur/U//bkDs6Tpvku2e72Sj1KtG6oqKB4M9Og5N+o9im28KZPPXDtFiI9uJ9esEEMssurHmzb0v/sseIDCVdlimVIq6X2BDHc=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OS3PR01MB7922.jpnprd01.prod.outlook.com (2603:1096:604:162::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 15:09:16 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 15:09:16 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 4/4] arm64: dts: renesas: r9a09g011: Add eMMC and SDHI
 support
Thread-Topic: [PATCH 4/4] arm64: dts: renesas: r9a09g011: Add eMMC and SDHI
 support
Thread-Index: AQHZD0brJZWEh0Wnlkygwc/8wYZvPa6WPe2AgAAbmVA=
Date:   Mon, 9 Jan 2023 15:09:16 +0000
Message-ID: <TYWPR01MB8775E5C532C3849E63DFA123C2FE9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com>
 <20221213230129.549968-5-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUrAF7CRGSirfZE+aKB9dmWe9mjZoUJW3yRNu1dSuhFig@mail.gmail.com>
In-Reply-To: <CAMuHMdUrAF7CRGSirfZE+aKB9dmWe9mjZoUJW3yRNu1dSuhFig@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OS3PR01MB7922:EE_
x-ms-office365-filtering-correlation-id: f2a90ede-5341-4dde-1a81-08daf25379e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3aFGa4XZ261VydO96y36fDKS6SVARl/9T3MuHV7bhSX5L3GMg/j87AQHIQ7P3LpbumL4/82NEeEYJ5xDNdvU+gLSP2UW2h1xzY/1KE5N3QGOkrmD2TaBq1Tu9bMvx3NHykWveA+MunGOwoTPLsVQ1/GhrnApjRsbloiE804OmcPNDkyw03vh77Sg/TraXXoZ7+XCULcKmqCQzrJtQK97SRbNCmlFZo0p7gCLU68E67zJGFHRzJ9tbF02c7dhYMTJbKiCpq5PlOzltLmJvMZrm/wLiDiRI7xVcQ6rnYe9apjmgYEYH/CVMOb4pDHCALwKv3D9vJ0NJzGTA5RiIGXCpzs5n8qEOO4e161PhI/9PAbPnLiywvzknY8kl/w4QtNqBuXV62aMtfzNq+gcrYul2Cy2eEQmQ8jFsCR8AFU1i/Yk3QJJgL8g0FZwYf3K68g/0Fp2OvHbwk6pXyPlLTmQ7eAJoyzQ7HWvH+4EcnAh6cT8PCOA/GBvYxMv1xQ0poiLoNDF8PIIKDsNdbyRqVi4klTM12OspfaQOPy2WXvt24XwulAJLEEgYiF2inyd65cGLIeX3xoUy6+2ZwGc8/4pIplpLuoQAZ8rnAlBWcorz5ewyn/ZVdyvls01EQGn7DXBWP202AAaqYx/+d42jhRDiZOFG8R74INuVYI403Tq8vLUglinFyDajjWFEH0H1tYbrthEL3NbDrtiTFICB0AEir13cqmUKpm2VAtLAOD8O0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(2906002)(83380400001)(54906003)(9686003)(66476007)(7416002)(66446008)(66556008)(64756008)(5660300002)(55016003)(66946007)(7696005)(33656002)(52536014)(26005)(53546011)(186003)(122000001)(8936002)(6506007)(478600001)(76116006)(38100700002)(8676002)(41300700001)(86362001)(38070700005)(966005)(6916009)(4326008)(45080400002)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J8YFugFlszlo3it/8ZI0ImSwZvB//PbJ3O1906x7SqrN229JVNU9xzptvmCI?=
 =?us-ascii?Q?ZQw9KDkd7xVe1bhdxsZ0A+a9m3llSqlIKEAheY6I8a6iCWsqMWBnTlfh4gl2?=
 =?us-ascii?Q?90KRDdma2yCQSQqfCIhdAdfhbuLLYyCcO+HN0uTkgwoC1VMKI8mAKsVDiQIg?=
 =?us-ascii?Q?c90TKgCDtXi/cdSK+V66m+ABTl93mzh/eFWloGQqqMZwBfFYlls3MgGZ3Tkq?=
 =?us-ascii?Q?V6iU/KJv/3mls1J336aAI/Iy4h81Z3p2wDIwYj+7+ZtKEV4yLaCIrUss610d?=
 =?us-ascii?Q?3eyk/fIeI0c4uOKTUyePLxaUs55txMq78I7hjwlNmmsUadUkmGbz8eoiaM2u?=
 =?us-ascii?Q?ly+W+7fYNzWKoS+Zm4b0z3d6On61QbmBCpkZMy15gKXHswz8LPSX3SgcKkir?=
 =?us-ascii?Q?jl1Ai6FAdU7efBi1+dd1kAa70zmKU61e+1e/M40Kzh0eDpDCBT7pDFbcxHRj?=
 =?us-ascii?Q?FTGNIjFEYJBmSCLpiYZlaeMjAyY3q6vXRq7pC06+r46LvUjaIc9HrI3+jxpQ?=
 =?us-ascii?Q?+SK5q524bOJoO2ySd9457+n+VPkFvkWruntU7Atjfz2+TN1dYrGKbKjtXffb?=
 =?us-ascii?Q?wTticmeAoQNr+0ZQCyDszqvNGkLs+MsP2wWr6Uc42E5aW99uTvr6UZXpIh9W?=
 =?us-ascii?Q?BU7G0XWHZayS/H8izkBqG2SpgDiPDZQRDHVB70LGmbsjUqHUOSvmbMWykslQ?=
 =?us-ascii?Q?PQkMH18DmcjAxooYfP5caC3eF/k9SIM0032O3mGvJ+5zpNnmGMepRbo1ppSH?=
 =?us-ascii?Q?qOQvJ0xMgi+/D+g8ycs7J63CWP0mc0Zz+OT3fgcmhW5p/Qbai1vRKAimjJE2?=
 =?us-ascii?Q?c6SMcAQ7C4q3JS86tLvk0Q4Qm3UNsYRYv5u6KCK27pDaVBC4Xm+H11MCpR/R?=
 =?us-ascii?Q?FM7X67QtUIVE8LbLrqT8k50tVrUoUIrEnb3GDsVgONSCNAM6aMyNsqsXvEdv?=
 =?us-ascii?Q?7jqlkXzFHxpEit7ujFZYfdQpAAl+hzgzHe9O8V4OEg3tG0s7hkeelaRBCir/?=
 =?us-ascii?Q?Eqy4PK3Vx5aP+S3RsaT1rXYw8ClNaD+CE2FO9+Jb3MTZjE51xAsDmbHPMkUk?=
 =?us-ascii?Q?cm92Ycyy03pD/ASeGAvAp2xKqAmAhj10LhzqmI2SHUKiNIO/ir/Ex0puy44b?=
 =?us-ascii?Q?CieUnGU+Wkv1b93DbmERnptaeekLfSWXfF9CWvx3QeKSVBkRVCR0Myc3BCce?=
 =?us-ascii?Q?EVJc+JgTlIyQhrMRdaV3pgbO06yk3X+BuKcRzBp4H7BSeLIAh6ishcr9rfey?=
 =?us-ascii?Q?6+c3wIJVayc9FtQhXABiOteikCBsZhVvNrsUgB1wq8sJWjBI8y6gf9jmiAkg?=
 =?us-ascii?Q?lnACf5MJ7vYjuvXLU4lPaqp2+7vIeXX2w2iPfu7O4HPVry2pIAvRJpzZDMAU?=
 =?us-ascii?Q?gjcpgfmi+VCK5S5kjSY2a8KtT241yA9031K16Zm9yUyWecdTFL89AVA/9pHl?=
 =?us-ascii?Q?8Dnuv609E2u15IUfhqJCiZUaMQh75AEgRaGiPfp5AhyzzKd/JukVNcRVrVMK?=
 =?us-ascii?Q?PFFg+W/+tdIgFJReJt97o6UxFGEb9fG8lix2mtS2rSLmu2guqS9WgMIPSedQ?=
 =?us-ascii?Q?LxS7RCLvbP/THTMDAfkUFqQajuHp6MnHLdwILD1vh0BPxufqheC6LYG4eQX0?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a90ede-5341-4dde-1a81-08daf25379e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 15:09:16.7167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77qc6OeDmitVhB8N3+Dx56ueYxd9b5jvZEmXEz5iafV0zSdavD20LdKcPP13b+IjaIZV6h273XPMes8HG7GgHIaliEMcBlzTdNzBs2oI4Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

>=20
> Hi Fabrizio,
>=20
> On Wed, Dec 14, 2022 at 12:02 AM Fabrizio Castro
> <fabrizio.castro.jz@renesas.com> wrote:
> > The RZ/V2M comes with 2 SDHI interfaces and 1 eMMC interface.
> > Add the relevant nodes to the SoC specific device tree.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.3.
>=20
> Note that this causes "make dtbs_check" failures, due to a bug in
> the bindings. I have sent a fix.
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ker
> nel.org%2F054c9f4dbb0bb1525f780d1e85c724436465c20c.1673270716.git.geert%2=
B
> renesas%40glider.be&data=3D05%7C01%7Cfabrizio.castro.jz%40renesas.com%7Cb=
621
> 0a13c0e64f5719a408daf245694d%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7=
C
> 638088677177461554%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2=
l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DcHhpiy1cwPTir=
i2I
> l1j7Ck6iwR9DEdvlc8egJDBc2cM%3D&reserved=3D0

Thanks for that!

Fab

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-
> m68k.org
>=20
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                 -- Linus Torvalds
