Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B325F5BCD5B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiISNfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiISNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:35:35 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B65C1C90B;
        Mon, 19 Sep 2022 06:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQh1hAsFPbDKZKVQAAXc8IdCJ5BQckO2POqU7pSti5Fv64VV+sy1pMLYBYNjxkJZuvRnb8kqdy/nYmTq2mQOUufgnnkFrrIEjA5lMqulQTV4/FzeADMIKCvUu4R/BPn4eaAQfjpocp/FAaBg6nZAVHHiKQh9xpzbNT2RnuD9h7mHuur5aAvnvBs6hqJ+NuyW/oEgy89CojapNLiMZp/qcHsk3dEn57shU8agG/U3QIIRxc6VMAb3RT6mORBQzN1i+lr0qV12/78XrKSRXl475BIYz8guKPGYz3NK1QpyezaoFSsoCOb7Z3noqQ8cD3Z+iAt+bFpvg/jlup1bYt+UJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=383HXuL2aR+rz08/J0pS2jWSkaV9k0Lig1w5oQkaGe4=;
 b=Y6IapHtxPtNdFDv/3aCH0+T8TJ1fJJ53hbaGZ8RFPciXFHIejlOHCUvWJVh6wlT2Uaza+3Owb9ml8JAg6hmWExHlDHuR05AKC94whXjIU44CjPw5CvoDBrjCqGgvHbP7iin4DSnO1uJQDQNc61LHe7HuCn0s4G1BYTYCdayeQFbMm54Tkc75Qtk/36LwJJwnSzjAqKwiN2QXS1P4hRrsPyXqUiqRqnSU+ODWbXFgZR4qAla7FSJAb1yTnM/NufyXVHisuBrn+/R2eDkjU5w28PkbLwL8cHIUcDG+p7JvCNdjSrHPk2kjZpAYUFnqNVgOzDQD46NxEtYOvs98yMe9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=383HXuL2aR+rz08/J0pS2jWSkaV9k0Lig1w5oQkaGe4=;
 b=R17Njbq17RXzKJFcBnxqig6WRkA8hnreWF/25oawaF+24yxfRcNkM35kcbLAgv8KVrzaN/wJVFY8UU5i3y7kZpLyENpxUBk7zwazy9D7swmOMFxfcZ1Iwa5kqhmn+jYpqx9Ld9x/lAxKgOh2ahk6AthMTiuHrpSttm8j+RU3JWM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10602.jpnprd01.prod.outlook.com (2603:1096:400:2fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Mon, 19 Sep
 2022 13:35:30 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 13:35:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical list
Thread-Topic: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical
 list
Thread-Index: AQHYzCwlVjlhhutYXUubI25P/bpXfa3mwNiQ
Date:   Mon, 19 Sep 2022 13:35:30 +0000
Message-ID: <OS0PR01MB5922E64DD745E4F8A5FEFCD5864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10602:EE_
x-ms-office365-filtering-correlation-id: 69078bd2-6943-4006-ccc0-08da9a43d21a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: re1FyQfmmcYPDiJWPKqesMATe8vNDULIImHeemM0RFfP2rj1cWX9kX3/cgIbGdnjU8m4tMndwA86SDhDiSko4YzzWHKONGqv7JgvKgijGM2qMRSjsnTeLfXP9pEN9Gn1okWbBq8nL2uFhLKYba81jYmFu2R1Huz7gapUGNbYhJo7UybSC7W6rNW/s9IVWfWfFVutcfgekWKUyMLvnbH1X1cxOGX+YJPOzmjxvJ3x+JIgloHSY/OvigcZno2ebwRr55zX2Ovv15aL4g4m4BANjGciLbEh42I4T7FNHevMU+2+fkr3dCuZr4XhcjjXnHxaw5u9ZQejHlSDyGt2mXnQSKj5ctBrRHQLiNY51K3qRPp/10x9a9D9joMqbeTqrL7/KDfZG+P1ZImJChaWMjmh9VERgb8vtQhVDX7IQfhN8Yc2Yn5D0/5/VheE/iyTQDKlZc5ff2zk+8+jti2OA3AXU7tWeCs5Vh8HwnRc6uOeExRye4/dUKOEfhrEjytyDYljmxWU7Oa2anSin8HPomuzbWy2urdzGEytzKTCtuw0pNl2P1IHc1o4hMg/efmuaPI/sy4ksPTTVz561SQ/XbjBlEAqzRZVag3CU3moqpfevlTL/YAExVyPLdCa5GSHqhZMd4xmUy6nq+msQoxwloFWny3wsjaKkyo/Hkpg2+CIYWWdMhDM4a7EYZuhl7QhUgYld89/R6hkgbAkZjz81X2Bvxn5Tp8POMbMrF86MAZE1lB9Dd78kI4fbW9Tc5it/pbG2cxfGYwuX2pDLEAhTyPGGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(7696005)(6506007)(83380400001)(107886003)(186003)(9686003)(26005)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(5660300002)(4326008)(71200400001)(478600001)(55016003)(8936002)(52536014)(86362001)(76116006)(41300700001)(316002)(38100700002)(110136005)(122000001)(38070700005)(2906002)(54906003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ubIOzhy+ck+89Gd0hT1pTq/MDHO0VRzWbxPPLwbHkJakb644JHf2h3HlJeiW?=
 =?us-ascii?Q?BjjM/uWiQsHyjblVeX/pgbm8rnjLhYnmnEl2RBa2q1BRn9TbDTchdOkjNuSK?=
 =?us-ascii?Q?Ow3Y406ElUfcocHtFarNLpWYpP/0KbCGVGXjwZFKVpvvMJYxqnB6Ubtw4sNn?=
 =?us-ascii?Q?k6WpG9rnGzUIhgVBVb/LZOcYFbJZl5V5Fqvw6Ad396JBACE3AY1qnKMODmv1?=
 =?us-ascii?Q?iWrpyUCqwzjShniHJ5WqF/xa9gV7fWme8ghUaKZCH1vNTI0y/Z+mx986uX+g?=
 =?us-ascii?Q?JlbZvEa3BsgutADBxzuzHAyv4KnHNMZ1bbs/jrWFiq81J69ZOgi8MUA/rNDs?=
 =?us-ascii?Q?Qq+9PBq9L4FdbC6MIlxusyEokuEBZfMTGr+/4LYW5FZhz4wahKIPRNBfvetw?=
 =?us-ascii?Q?wMjZhThsaaG+g02iYAT9OtBjbr7iZPRi0L8F/5NPCQQhzHlqVmw9aO8KeOdq?=
 =?us-ascii?Q?L7ndfQmWZn8NS+Uf/ELji2DuPcBR0L1LQwlYB8V1533R4qJ/W1VoF2DfTnmD?=
 =?us-ascii?Q?AmXAe/0I7SuQdCmilfmxGXrSQiROs69uSKchHA79s4CBMPvsBYqWmNhqtf17?=
 =?us-ascii?Q?xvPP/DJi5x4OFC7dSiAW2EnzT/znQv24pNsogWg9VGW4ZmNCNwcksize1qLy?=
 =?us-ascii?Q?4mMHX8BOschWdFougv4fOAReCU5IAURiyIrbLx7HN8HKpjmKSsXofLzVJfb+?=
 =?us-ascii?Q?73hTZ3zR2E32O3yhSw3ian3GGedFV6hBJENQa8144BBSRWXyNkWhTOplBlyA?=
 =?us-ascii?Q?bcSm2PF2qhTaz+c0ug1dP8VTLmtLjhEx6w2CrVGkiUjC+E7qx3ylFPIgE9tm?=
 =?us-ascii?Q?GM5rT+9Ot+GF48QaDogszK1fBsNWFYrA6QGz0YC+u3f3nFhZ7bnvh9w7t7H6?=
 =?us-ascii?Q?44yGymSxBoAClLcbRxViR1XRM1BP29iV57v96CQl7BIhFaqM/ZoQwmZrKgSa?=
 =?us-ascii?Q?hDb7msDnA1xozsRY+hLTGOi6s+UvBD1KsuxES7BIFkHrQjRVwKm+Fe/kKtUp?=
 =?us-ascii?Q?q24CPIGj1wG3PwpNQNQ9ZOLUI7gtm28OQJdzIQAA2UEbj28+r3XyqHXSlRgw?=
 =?us-ascii?Q?dbDMpV3z6YpnSRJF94vk+DY0gI0EgJPcYZ4tZ8lMCLvlKqczPIePONxOqPqs?=
 =?us-ascii?Q?YvHr4tOqF/1tNVSoq36zrb4Keqt2wA5b+twsfoxEwgPqp1DyvwUaYADz9dpl?=
 =?us-ascii?Q?HfMk+R9b1ITtDW8i5ybNgvIp/Ol8eTamp9PdJVME5IgauKPBGsmZYQTrb4DV?=
 =?us-ascii?Q?DE3ArwHVaLlQwXAyqD5kajj4eDwLAgxdaMDNonCXaPd8cgfPuVoCXBde9wm/?=
 =?us-ascii?Q?vxuesH5HbgXjAyAwKAdtma0De1BzXg8aLnF4SzOQyTJVzvdhQoo5jaKng3y8?=
 =?us-ascii?Q?mBksYiK24vX4DRacVwrSd/vBzHiNG305qE+Gm41XJe8JR8Md3HSRNjec96s6?=
 =?us-ascii?Q?PZCcE/ih219ElN4HUx50HWQkZwgAhS0WwauQIr90ctQhscej9iLp6G8/8Vy/?=
 =?us-ascii?Q?alXhPsLu8uTH5D26vZGbIJ2H1Uu7PgnPFS4vBh9DS/BhujVRaMK0oPi50rPT?=
 =?us-ascii?Q?BmV3i+UvnFcxr7ftfV26Iy7+aQbLuEPsvDqrqinOW6uMB/L6x5YQf4jJiB46?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69078bd2-6943-4006-ccc0-08da9a43d21a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 13:35:30.4179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpkrSmvwbTpJbOOTvnD8Bb4CO1/wSDL2adktN73oNF60XG0HV4y59Wj78esVSp+mLYy/VzA0ykNc8kphrmeBXAxPTpN1zo9gOplZdCwadys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10602
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

> Subject: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical
> list
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add the WDT2 clocks to r9a07g044_crit_mod_clks[] list as WDT CH2 is
> specifically to check the operation of Cortex-M33 CPU on the RZ/{G2L,
> G2LC, V2L} SoCs and we dont want to turn off the clocks of
> WDT2 if it isn't enabled by Cortex-A55.
>=20
> This patch is in preparation to disable WDT CH2 from the RZ/G2L (alike
> SoCs) DTS/I by default.
>=20
> Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/clk/renesas/r9a07g044-cpg.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/renesas/r9a07g044-cpg.c
> b/drivers/clk/renesas/r9a07g044-cpg.c
> index 02a4fc41bb6e..cf9b1bd73792 100644
> --- a/drivers/clk/renesas/r9a07g044-cpg.c
> +++ b/drivers/clk/renesas/r9a07g044-cpg.c
> @@ -412,6 +412,8 @@ static const unsigned int
> r9a07g044_crit_mod_clks[] __initconst =3D {
>  	MOD_CLK_BASE + R9A07G044_GIC600_GICCLK,
>  	MOD_CLK_BASE + R9A07G044_IA55_CLK,
>  	MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
> +	MOD_CLK_BASE + R9A07G044_WDT2_PCLK,
> +	MOD_CLK_BASE + R9A07G044_WDT2_CLK,

Do we need to turn on this clock unnecessarily?

Cheers,
Biju
