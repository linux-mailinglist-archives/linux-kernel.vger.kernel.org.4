Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09595BCA50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiISLKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiISLKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:10:10 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2121.outbound.protection.outlook.com [40.107.114.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438251261C;
        Mon, 19 Sep 2022 04:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqgxXqMyPpI1erZuqkcNAjyHvxhKlnS0VbnN7xtQtgwhqkh5qOoyM7bc4zOJ+HIPtGYMTgtupelx5hPWiboXQpdSDo7Fo2xFmLveCJ4h2nN+dyxjMaQZI016bTLTBibdz62goP+w9pVvD+UVtgujQRWd0BfG0Oguawh/S0xLZl2F0upYAAgzguLHMSE9KIhmCEocoM81E0AzAaed7bNnd6uZr2LiD6Q/CPwEM/n0j/FlAhIr7LCrzStnnDMB0rBirYMGd6Rc6vjIG3cxqUMX5/VVNGA6DP/0jchhWSQHuZ8ZfgWejtPeZIjTQyy4dxTE8rzih/QolEb8nat7ZbI+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYUk4jQM2YmDY4SlEPd1PLC8vK+Db11ShhE4O29Scpk=;
 b=fZJqSdj62rZqm3KLJ5Mygw6Z1cY4ODbGE/X2a3pJ70nUMeuMZ73Flrf58pUzQWRhYYJT0bZ8r31ewtacZdnLCSieIn9m+/LWBWQMoBE/psdNhty6U7U4HICB3Aqvsafg8FU+VT3Z2uufzcI1JR9+xGwQxbpelrIgdC6UzVSwr+hq8UQhXO8wa1lMOoIz8QmSWGMuXdZuKOvAZp80CPX/5qlsfTjDbBmJoDvIaS+5BoAvhVkSzDCrJsfw1OKyv3FKd0BoCW46Z1nYqsyGKetKhRhzrAjSemTv4Oz4K3dcrYcLeUvpvQ4rj6iVWoG3PP5jaz9R5uT5Lbg6O8d7WhBEPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYUk4jQM2YmDY4SlEPd1PLC8vK+Db11ShhE4O29Scpk=;
 b=vqW7TAa1mq3T9phFad8bA9D9RT0snZEEuLHuxN19b4u50VDtsMzWt+g7NapfhSrDtTZ3XBNZF4Ug8tbNx+MeJvck/aYVTFKs3OaFMl/R0sasUzNKSbx7xI/zaQYiRoGmIyDzANXJ14ukvIhz23+DYDaSrvfE4rmMk9ssLVNFkL0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10071.jpnprd01.prod.outlook.com (2603:1096:400:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Mon, 19 Sep
 2022 11:10:05 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 11:10:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
Thread-Topic: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling
 wdt2
Thread-Index: AQHYyD/rtz77kMV/LUKpS1dYBqhnjK3k6tOAgAGecYCAAAScQIAAAboAgAAA8+CAAAhtgIAAAoaQgAADNQCAAABl8A==
Date:   Mon, 19 Sep 2022 11:10:05 +0000
Message-ID: <OS0PR01MB5922C709C73F97E1269DB110864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
 <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com>
 <OS0PR01MB592272F7C6A9519E1CA99647864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWzWQgL1eki_aL_MnfQfM_S1yTuabWQAP8GzuA_D_A_kw@mail.gmail.com>
 <OS0PR01MB59221867F12797CCA685F954864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8utMR5GRnNGYhn_hhRnDpxtBLjEhqBXmoNZXmiBObojmw@mail.gmail.com>
 <OS0PR01MB5922A255CBA720023536A151864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8sXfRQAMDGhF4JnK-Ucmb6G502oxt8L=wYZP2Vb3bd3jA@mail.gmail.com>
In-Reply-To: <CA+V-a8sXfRQAMDGhF4JnK-Ucmb6G502oxt8L=wYZP2Vb3bd3jA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10071:EE_
x-ms-office365-filtering-correlation-id: 9376d83b-0b78-493b-d27c-08da9a2f81c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0U99tFkUqsrl4W8ef0BTUqn5IiceFo3Zv7E2G1bMOmbMoD7nhwOI7iYOyTc/vBU8iG9twvQLrkdAbi5qRPoD4+424B0pJdkzKRPShtQprgw0qkEIQC651xHSfqgQpiKOyLB8KKJYYPu1Dja110QO8SUnDjT/wAKbzu2wyRIRKb3+qDWK/z7q9VpxgQUIzxLJiqm3RnbsEh2Y3a0mGtajxxhePL0fxCr7idfbHYogyFfZWmbxt8XmikmaGkt3SrB+Gyn6MSixTbzcGNvJBn76Wri8bygppNgVc3Wi9UmU4XEoWBUqaA1v7i/4cWLIfc9VwA333yeTR9hFxIsA9K3wqP6mSCi0pco3P7yvXawkwSH4wN3SRLTGguPk7GHkwkq5/XTdsFpMUGNRj/5349j7/ARZLHlB0l7AsE9NuCYQ+LgNrMIv4J+yysdLoyB0PL6PwI0fkghkESA3QfFiKTHNgEUlZSDMtYEnSYABRD+8aGe8xzf3nys003y/vOciWXcHC7VuGPwJ4V47oc7CpPG8VF1rhSoAMPvZDVp/LVqMaxQR109drZueUXGHWx3VOwRgRBx300KveL874vFa0PdXfAevw0h02pC+XPPD+Bk940Mk+xN9fcLEfgy3n25YBCfta3o2S3kpdvTAT/6lEStbian+qwIxApD1m+pJ7T37XD1JykpYV9t3nke2EBjykI4MSN9N9eE4WjkSRVqJMhW+BQ9vS69M4WvGR7i6iQtsgeBeYwmtRbJoEXhT5AG9yzt/LRmnrXSDJz8NAk0vC319jLr8N+4pNMSBdH1ygpU4/9g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199015)(55016003)(33656002)(38070700005)(86362001)(122000001)(38100700002)(6916009)(316002)(8676002)(45080400002)(71200400001)(54906003)(52536014)(2906002)(4326008)(5660300002)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(41300700001)(8936002)(83380400001)(186003)(107886003)(478600001)(966005)(53546011)(26005)(7696005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rf0a4Yx7deEhoYUIOkqjaeUIvgFfnXp5+CJN5qKRSHqmcY5AjEQyCsZXNJlw?=
 =?us-ascii?Q?6Z8lwxrGsxy2YDfrx3SAZ3jv1+rOvjVr6mgxHbzhPuciKLQdcTuO5bxG2mO1?=
 =?us-ascii?Q?WmlJrCxNx7P+uz04rj/7BDXCrN8nBTll5N5PFACdDQIrfuUhmWyPkEAsXwT4?=
 =?us-ascii?Q?6HNkAmS7f8ho4ya+ZoGe78rEMrLzdJEMs1gFlFM/9qOXXvfhbHInWqvLud5A?=
 =?us-ascii?Q?QjLZSHeL/pkgfmyF1mA6vcLQQF1SfZp/6CChuakE7ZrGpqtTkILSnL7KVsIG?=
 =?us-ascii?Q?4Nz/KrZZjWn8pPvCHmKOOQcBqhrbVjxKRKAcvgHsDdO9IQKgjg1Bs4eXEpv7?=
 =?us-ascii?Q?WbI8k2apTITj8Rt+Fr86TkoIXlmjcmYMM9GpJFedvPiFqUh2mz1wmfr/KOWH?=
 =?us-ascii?Q?95lrTBO5VPvAarEhK22YC2gxjUMSzlD94v2IkyIfpdSZtoerY6aHHoogrF37?=
 =?us-ascii?Q?kPGXihsjipuhZzba0ZzPyzVHTPD4YCpYBiexfxGNmeHHisC8kBmhxwgnTmJ2?=
 =?us-ascii?Q?ixm/biKq5NX9uollEZZIa4qxvEDKNfjl7C1BqT7Oa8lh7iiEBWJW4LwFhaXD?=
 =?us-ascii?Q?73FVSKUvPdKtxauEXppV8lA6LrN8ZczExqhLceYSb1EdpQzqvlM2bmMV+dvy?=
 =?us-ascii?Q?siGjuJRFMRfWMVHxY6aBT17y7jvLE6wTa4ddajEZcSi9JTHEUdFXPKTqkQWU?=
 =?us-ascii?Q?rykyZBLd6pbzhC+EqMkWfST6mg55YyUMnscBXWBUqIKe/RdznyACNHhGntOb?=
 =?us-ascii?Q?mv+r5EAdGxoONvaVtQCSvCoAyCX3UiED1uClUPoGn1UNs5wO+qlsE95+ZioP?=
 =?us-ascii?Q?SbD/gBTs1HrrNawQBsMsCIpXZBbyLO8v2jORDM8e7V5GhQ0gjwXjyFddTo/A?=
 =?us-ascii?Q?Get2BqDlJGCVwZ11YX2M0+Tym8Dtua4Kwz2JbfiAGaZ3KiAMm6BPbY0aScEg?=
 =?us-ascii?Q?AUM9y238vjbTY8tN5vj8pAmE4eBCgIbX3F3l7uK3Kij34/JvlvUY+/dWtpio?=
 =?us-ascii?Q?Vre7XIfrRdxPgqa8vt7iGxwSy/tD6Uq1ClSibxvtWg7HFalEviKeqrZzDaI/?=
 =?us-ascii?Q?1qOzucRwmVcRPA+fzPYJUL/KA3LMKltmi9Ocz0WeZhEIqu3y3Ytq2fM3V1Vz?=
 =?us-ascii?Q?FiOR2+TrZtGK1Q+s9IiywQwyKj5FJVdOt1iZ6pp3W0krfnM2agSAjEDY71FF?=
 =?us-ascii?Q?I9uL/fbtiOXqgsUgwaG5AkUwel/Sd/0aVxx5IZXIcgh2U423B4qFeTySa8Ke?=
 =?us-ascii?Q?s394eqgqoBXXnSCL04637OOFLHApHqznQddWC9zUG8MDUncCNJBum99tj3JA?=
 =?us-ascii?Q?nECgJ/tZF9zdVF5lq7doPjWOgCLo3iJ+a6jrNao7Vt74SeCgFnTLrvNjN3qI?=
 =?us-ascii?Q?BEbNCd6HKhlBy1TTanX0biPvI5WwGxs0cIZPe1niPJfM0LEDKlON6LOFaCjH?=
 =?us-ascii?Q?dByawHEgYo9ApQjchfBwVONedoFTfp7XrB91RngGItPBrEqrrbQNrZjmIi5L?=
 =?us-ascii?Q?+cIJXGps5MZQ+Wq8G27ug0wFC7EufjO8Gx795TCqh3BlLVw12Yqdlrse5cQ/?=
 =?us-ascii?Q?NPH85fNKHcJDJBPhvrD+oHOxGv5GWbt6q5+oifAVpaqS5gjnolMIo1MwAIZN?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9376d83b-0b78-493b-d27c-08da9a2f81c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 11:10:05.7178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ce2b7ebJzk4t/eUIIPIXOi6Q/rlKj/56sHlcjxA0kPf/ZgVJxu3M+yN5x3tFvkLIMn3rhPEi+5PQl2qY58zqLTUZdkdfZ0c53rRBHs2Vcv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10071
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop
> enabling wdt2
>=20
> On Mon, Sep 19, 2022 at 11:55 AM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > > Sent: 19 September 2022 11:44
> > > To: Biju Das <biju.das.jz@bp.renesas.com>
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>; Magnus Damm
> > > <magnus.damm@gmail.com>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof
> > > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; linux-renesas-
> > > soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Prabhakar Mahadev Lad <prabhakar.mahadev-
> > > lad.rj@bp.renesas.com>
> > > Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop
> > > enabling wdt2
> > >
> > > On Mon, Sep 19, 2022 at 11:15 AM Biju Das
> > > <biju.das.jz@bp.renesas.com>
> > > wrote:
> > > >
> > > > Hi Geert,
> > > >
> > > > Prabhakar Mahadev Lad <prabhakar.mahadev-
> > > > > lad.rj@bp.renesas.com>
> > > > > Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som:
> Drop
> > > > > enabling wdt2
> > > > >
> > > > > Hi Biju,
> > > > >
> > > > > On Mon, Sep 19, 2022 at 12:06 PM Biju Das
> > > > > <biju.das.jz@bp.renesas.com>
> > > > > wrote:
> > > > > > > On Sun, Sep 18, 2022 at 10:04 AM Geert Uytterhoeven
> > > > > > > <geert@linux- m68k.org> wrote:
> > > > > > > > On Wed, Sep 14, 2022 at 3:43 PM Prabhakar
> > > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > > > From: Lad Prabhakar
> > > > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > > >
> > > > > > > > > WDT CH2 is specifically to check the operation of
> > > > > > > > > Cortex-
> > > M33
> > > > > CPU
> > > > > > > so
> > > > > > > > > don't enable WDT2 by default.
> > > > > > > > >
> > > > > > > For consistency I'll drop enabling WDT2 from the RZ/G2L{C}
> > > too.
> > > > > >
> > > > > > Does remove unused clocks turn off WDT2 clock during late
> init??
> > > > > >
> > > > > > If that is the case, we should remove entries from clock
> table
> > > as
> > > > > well?
> > > > >
> > > > > Or add it to *_crit_mod_clks[]?
> > > > >
> > > > > Note that drivers/clk/renesas/r9a07g043-cpg.c creates wdt2
> > > > > clocks and resets, so that should probably be moved inside the
> > > > > #ifdef
> > > > > CONFIG_ARM64 section.
> > > >
> > > Yes we dont want it to be listed on RZ/Five.
> >
> > OK, So this patch [1] will break existing RZ/G2UL till we have clk
> changes suggested by Geert.
> >
> No it won't, patch [1] just disables enabling wdt2 on A55. Whereas
> Geert is suggesting adding wdt2 clk R9A07G043_WDT2_PCLK (and also
> R9A07G043_WDT2_CLK?)  to crit_mod_clks so that we dont disable them in
> A55 (currently we dont have any scenario where M33 is up with WDT2 and
> patch [1] is breaking it). Also Geert's other suggestion was to add
> the WDT2 clocks under ARM64 as we dont want them to be visible under
> RZ/Five (where wdt2 is not present).
>=20
> Or is it that I am missing something?

It all depends upon whether remove unused clocks turn off WDT2 clock during
late boot process.=20

I guess, since we have wdt2 entries in clock table, it will turn off WDT cl=
ock,
since you have disable it from DT( it becomes unused).

By adding critical clocks, it won't turn off the WDT clock.

Cheers,
Biju

>=20
> [1]
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.
> kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-
> next.git%2Fcommit%2F%3Fh%3Dnext-
> 20220919%26id%3D31989ece707adc453eb9f4f019fdac118f8fee72&amp;data=3D05%7
> C01%7Cbiju.das.jz%40bp.renesas.com%7C55f37d25d74646611de908da9a2ecfac%
> 7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637991823087385873%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DhP2u5NwutD8AhhrOrY6dPvlWW8PkB
> g3skyTMXBJQaWc%3D&amp;reserved=3D0
>=20
> Cheers,
> Prabhakar
> >
> > >
> > > > Yes, both will do, I guess otherwise WDT enabled by Cortex-M33
> > > > will
> > > be
> > > > disabled by
> > > > CORTEX-A55 during boot.
> > > >
> > > Agreed.
> > >
> > > Cheers,
> > > Prabhakar
