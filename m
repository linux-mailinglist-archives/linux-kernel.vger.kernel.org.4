Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980AE5BCAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiISLnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiISLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:43:11 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F20112AEB;
        Mon, 19 Sep 2022 04:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUHi88X3yJG1o+7y/y4iVbgAxhnQ8A4Hw9l+mYsR7pqTatu/bpHLiqt+K2go7+f79HvoljH1BOZ0vE6M2EnouHKwBf6u5BWDeIjUmjh8netEbWWaW1+IL5yL6UWFMc53Anxz939jJqYbwcjf+UWvfGnV3PNFUHE073eiT1gXMJhU+fs0OzSCGHsoOupeMEAj3RXmutNHELfewMiomZq3l0weX3N9Bdx+v7gauUWmDkXtCfy259uQEFOpb4u5pPwCV3uTrqHqPzilLlxTCsxPmrpLKKPkXJ8UWVZV7iVet3VD/atgcrHIst4TYh/t+8dLwfBiRYCjuanrMEmGcFUvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjF7tXOkpnQLFdzspNt8tlnzHES7N9x7trcPhbIUpqU=;
 b=L5yom1RNQ7mA3DEwEhcYynB3KL0A7p4tVfUN8E9sTK4MR8v3f/WZ2ZahI2QzVnwTM1sQpmFMBCj5W1OzVD4Pxk1JfKNmtPZDb96Y4dvKbsmPcD5tGeShi4FdUqflaLlTSLb0nj4M1Z+zovG5rIsyiyYQwUPkv9athYdSB/LkyCPjIvGjL4sIGbTbbXbWbGVUZeKIiH0FgXCgXLSctB+Vr3ZZr6M8b8wKn7QNoxjVsA51rmunA3TrCXGeRLJt5UFr7amTM/ogt8eMCSe7XXFiJYJuMKuBo6OCtIHhvA1x3QnQBYeGgIRTSmOpkWxjbaaTOc56JDtNVAXQ1BVFEFCkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjF7tXOkpnQLFdzspNt8tlnzHES7N9x7trcPhbIUpqU=;
 b=sLcMaJhA9FsfsekbyeU8Lrwdx9YHcuPb8RmNP2dNw4mIglnx72y6Lt26+4JScYoHMAQzhLauXvzj8/2JLHwaIuyJxAOyGiXXzUGZHG61+sjPAqdb3+omhR/Qh3+nqgPqb3Z6FG2WM5hqxivLjBfzISC5UgjE8MNxF4kFg7RX0Y0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8042.jpnprd01.prod.outlook.com (2603:1096:604:171::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Mon, 19 Sep
 2022 11:43:05 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 11:43:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
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
Thread-Index: AQHYyD/rtz77kMV/LUKpS1dYBqhnjK3k6tOAgAGecYCAAAScQIAAAboAgAAA8+CAAAhtgIAAAoaQgAADNQCAAABl8IAACLIAgAAAUoA=
Date:   Mon, 19 Sep 2022 11:43:04 +0000
Message-ID: <OS0PR01MB59223965328DAFEB17C42710864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
 <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com>
 <OS0PR01MB592272F7C6A9519E1CA99647864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWzWQgL1eki_aL_MnfQfM_S1yTuabWQAP8GzuA_D_A_kw@mail.gmail.com>
 <OS0PR01MB59221867F12797CCA685F954864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8utMR5GRnNGYhn_hhRnDpxtBLjEhqBXmoNZXmiBObojmw@mail.gmail.com>
 <OS0PR01MB5922A255CBA720023536A151864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8sXfRQAMDGhF4JnK-Ucmb6G502oxt8L=wYZP2Vb3bd3jA@mail.gmail.com>
 <OS0PR01MB5922C709C73F97E1269DB110864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXCyTGbwp9F-PEcn3qxapDMU+UEY2=RVNy8p9fNesKepA@mail.gmail.com>
In-Reply-To: <CAMuHMdXCyTGbwp9F-PEcn3qxapDMU+UEY2=RVNy8p9fNesKepA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8042:EE_
x-ms-office365-filtering-correlation-id: 92f14f74-d051-442a-218b-08da9a341d88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCkU2762MS4CUZ35ytRR8iOrkKGk2jSzKa3SD64Ovc6+pZ/wa1pnXxQwu4mfapzXs2n3B+kr4vJw2PNtN2f2od/YD/kAfZKUIXulI6Kk7oL8HOeJxn19yu9r6p28DR1eqiMAdFFTN7TdyLa1IBc1M32JpKblx48VwymOpJRuqfGrya05aozrspqNvaIcD5OCayDuFB8Hnhmi1/vpISl4SyTXej1LSf08snFBKjAvSOSuRrDtbG1UB7GO3CoTKn1UZnbfQZKnI+9iSujMHVRnI6Aq+3rZqDMtOP9gekPJ7aBR9z5glLd8HZE6Xm4EdmTmmh5Q6vtwsEvOEMEDwH/h/QIYxwdHsrYRej5A8r3txRbg+Me/FryXhy4n59EJYGYjBmZsJ8VlWBZ+AqGc4Hyuq7+oU23cGuJk5+Tp+l7FIRo1MBCZwcu91xtPdD1KFIHhp4HLWcERfnQz4oDEB7/WyI9u2oHMPYiDYYulRgXgaktMxPb+V2RMWCwY3sCmSndKwgRKBBEOk5KFQiz1JXTceIWn250i9zNz5D1rb1xypL2EE6nG0xs/uL+s3o6crh3SYyPG/ZJ8ZUD700F2FVySgXJEFzPxyEVsSQrBJS96qR4435xcsvaAS3YIDJsd5xKAb33aF0AvAMCvkQoIGDCSRul1zPrB8l9pGMfxunFEEXE7y28g+8FlsV3S0I6uY47vy9J7GKgPc/1EP3JAVvD86pkASdexRtU62/8PJsPgfmr5R+3Aar0hcK4EL5psrz43+KkTknnakr4Le47gnkHXXLv8V+LZQ0pKqbhCT9s8wi4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(66946007)(76116006)(4326008)(66556008)(8676002)(66446008)(66476007)(5660300002)(64756008)(54906003)(86362001)(6916009)(8936002)(45080400002)(316002)(52536014)(122000001)(33656002)(38100700002)(83380400001)(53546011)(7696005)(107886003)(41300700001)(966005)(6506007)(71200400001)(478600001)(186003)(9686003)(26005)(38070700005)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VbfXn9TNTp4dul8WHsYwq6/nsrFd+QiLuy5+PrTcNrQOmcyLVwO43UDfPu27?=
 =?us-ascii?Q?fB4IFidptNGsVu5GtHUNaZo0BihxCddvnC+XuGAZiS1vA0C52omhsU8lHwG2?=
 =?us-ascii?Q?vNPJ3rtbQUM64PPkO9PKkmtLV3xJScRFAC7T/XVT7EL5aTufKPDzoDPYLKB6?=
 =?us-ascii?Q?Dh4dZ+KfeUUINkPmN4ZpFI87rWlwg8nGqGRTPVqfmaAM0G9P0FeXdqmFdeY7?=
 =?us-ascii?Q?KoM12Ts669yltZfuY6TITDfbfYE6Jnc1zS8uG2hlS2Pl1+d0Ojy9u6IATEXZ?=
 =?us-ascii?Q?/f/xNVHCmwF1JBfytgBZOAjw4llbcjgoummuNF5mAKkuNKVRWAY8m2xV2WJ6?=
 =?us-ascii?Q?OeSWvSnDGCkK+d8L8rQGWOMzm+bpbMeC/gsTuFe28C+BsCL6MLRkp/Yo32nR?=
 =?us-ascii?Q?PhKEO+wif+PgNuMHZCKmCPYGFyq9Ir0zFqqBMa74mfNzTvlAIZKU+iyifLEo?=
 =?us-ascii?Q?LGzKeYx9j+BOTSvxQhXYSO0DXxcb2c1cFDwg2FHhbWiBiP4P8qUWFfJe60Jb?=
 =?us-ascii?Q?DmE6ZTZ5zOByntFoJj+1QCmB0IZtVDvll5+EvYwhr7miTY/nn7Beu1EAuNwu?=
 =?us-ascii?Q?YiRaQA6Hmbfn+4LpM6M9oNaobbz9fbjugTrAmOVzdzBj6tY066owmQP+OBaT?=
 =?us-ascii?Q?xNZhPhSNgvYdKucx3VmZPM0Ci2N5rBLrEIgyto2xWMKasu+29sk73BuoGqwi?=
 =?us-ascii?Q?laicvxoXgNnNV4kwcs35YfcUcX9hOi6jBvOtpC3eR5KehbuVfGTeRMr0Lcjo?=
 =?us-ascii?Q?Se81uufQnCBArQC5jaFg5/HtdinnIc6omQ0bzVmJHzzYfjaQLDjDRDTDkjhR?=
 =?us-ascii?Q?mi/Ouq1umpc/OxsX1XIGsNlN3UUoiP1zImHE11xH7Mr5C0rCBl+Lba2P91AH?=
 =?us-ascii?Q?d60Yl6QJFlV5BTUsoTf67knNz3t4MYZYolg+CWHOJSZQuOKWGnVWJDgeEGLz?=
 =?us-ascii?Q?VwoGyLsD4XzIOFgY/9Jnm3oJzeeHSFPokrIEaGxwQvs+M4eVMDDfj0ctzjfA?=
 =?us-ascii?Q?x0UD0bJNlrCLJuNBW83DvPjH1MoayTbYqpDxbYHt84oCjLZqQeKfpJh7vvtc?=
 =?us-ascii?Q?zdFINuqyWawnXx9WtOO0sSurPcTaoAEWHcT8Kh95sO/dZAn+15BpyYk9C09q?=
 =?us-ascii?Q?s7PU7s2nNAPh/nqHxIGuL9HMCzbmSD7W7KY8oVvsXHkwdcqETKTtv/8ub4n3?=
 =?us-ascii?Q?Ic4uZLv2sU+ujAABWGeYeMf9PYtA+cZGD7Sk6vh5nlK1+PMg5a329SUkobQi?=
 =?us-ascii?Q?aTLPHG6dXI4M6vfZl/9nNkAHnRLpOtyN8jDOjdKt3v0C9l40GqHL7JXq3Cdk?=
 =?us-ascii?Q?cSjCZor7qXb7BdfPsdJIIXacTQN70HMO5osa14dhZYDrfF1uMKEzVIga+lRq?=
 =?us-ascii?Q?k55eOC2/1+XB15eZQ/DktqISI97l+7x2ATPz50b4K1dBf5s/sQm64sut9A2G?=
 =?us-ascii?Q?3qvxNckx7uqqUXVQUtz2fyy/ohiiIYzZ2njXiDu7i47jCwv+lENnbWDMHmq4?=
 =?us-ascii?Q?EK+5kmHB1ptyJrwSqmYecZJocOCrkmvZhwMfgjDUJ1EfpoCoO5UCdhWobyMZ?=
 =?us-ascii?Q?SqT1Md5evbp1eAp9Qy7k53UEmwo1Wf7v3V5Rdxr/mI64STY+O1st7Nu4WvUu?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f14f74-d051-442a-218b-08da9a341d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 11:43:05.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVDU+fHPHHmRghP5Cu6qi7tzb+rFgPBPESGANEmqhMxryk/Fbg5TmoTVHMfrvnKTGpTqMBzeUIg+BFXXTWBISgbDKKwrbDdG+RaheLs3YB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8042
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

> Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop
> enabling wdt2
>=20
> Hi Biju,
>=20
> On Mon, Sep 19, 2022 at 1:10 PM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> > Mahadev Lad <prabhakar.mahadev-
> > > lad.rj@bp.renesas.com>
> > > On Mon, Sep 19, 2022 at 11:55 AM Biju Das
> > > <biju.das.jz@bp.renesas.com>
> > > wrote:
> > > > > -----Original Message-----
> > > > > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > > > > Sent: 19 September 2022 11:44
> > > > > To: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>; Magnus Damm
> > > > > <magnus.damm@gmail.com>; Rob Herring <robh+dt@kernel.org>;
> > > Krzysztof
> > > > > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; linux-renesas-
> > > > > soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > > > kernel@vger.kernel.org; Prabhakar Mahadev Lad
> > > > > <prabhakar.mahadev- lad.rj@bp.renesas.com>
> > > > > Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som:
> Drop
> > > > > enabling wdt2
> > > > >
> > > > > On Mon, Sep 19, 2022 at 11:15 AM Biju Das
> > > > > <biju.das.jz@bp.renesas.com>
> > > > > wrote:
> > > > > > Prabhakar Mahadev Lad <prabhakar.mahadev-
> > > > > > > lad.rj@bp.renesas.com>
> > > > > > > Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-
> som:
> > > Drop
> > > > > > > enabling wdt2
> > > > > > >
> > > > > > > Hi Biju,
> > > > > > >
> > > > > > > On Mon, Sep 19, 2022 at 12:06 PM Biju Das
> > > > > > > <biju.das.jz@bp.renesas.com>
> > > > > > > wrote:
> > > > > > > > > On Sun, Sep 18, 2022 at 10:04 AM Geert Uytterhoeven
> > > > > > > > > <geert@linux- m68k.org> wrote:
> > > > > > > > > > On Wed, Sep 14, 2022 at 3:43 PM Prabhakar
> > > > > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > > > > > From: Lad Prabhakar
> > > > > > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > > > > >
> > > > > > > > > > > WDT CH2 is specifically to check the operation of
> > > > > > > > > > > Cortex-
> > > > > M33
> > > > > > > CPU
> > > > > > > > > so
> > > > > > > > > > > don't enable WDT2 by default.
> > > > > > > > > > >
> > > > > > > > > For consistency I'll drop enabling WDT2 from the
> > > > > > > > > RZ/G2L{C}
> > > > > too.
> > > > > > > >
> > > > > > > > Does remove unused clocks turn off WDT2 clock during
> late
> > > init??
> > > > > > > >
> > > > > > > > If that is the case, we should remove entries from clock
> > > table
> > > > > as
> > > > > > > well?
> > > > > > >
> > > > > > > Or add it to *_crit_mod_clks[]?
> > > > > > >
> > > > > > > Note that drivers/clk/renesas/r9a07g043-cpg.c creates wdt2
> > > > > > > clocks and resets, so that should probably be moved inside
> > > > > > > the #ifdef
> > > > > > > CONFIG_ARM64 section.
> > > > > >
> > > > > Yes we dont want it to be listed on RZ/Five.
> > > >
> > > > OK, So this patch [1] will break existing RZ/G2UL till we have
> clk
> > > changes suggested by Geert.
> > > >
> > > No it won't, patch [1] just disables enabling wdt2 on A55. Whereas
> > > Geert is suggesting adding wdt2 clk R9A07G043_WDT2_PCLK (and also
> > > R9A07G043_WDT2_CLK?)  to crit_mod_clks so that we dont disable
> them
> > > in
> > > A55 (currently we dont have any scenario where M33 is up with WDT2
> > > and patch [1] is breaking it). Also Geert's other suggestion was
> to
> > > add the WDT2 clocks under ARM64 as we dont want them to be visible
> > > under RZ/Five (where wdt2 is not present).
> > >
> > > Or is it that I am missing something?
> >
> > It all depends upon whether remove unused clocks turn off WDT2 clock
> > during late boot process.
> >
> > I guess, since we have wdt2 entries in clock table, it will turn off
> > WDT clock, since you have disable it from DT( it becomes unused).
>=20
> AFAIU, the WDT cannot trigger when the clock is stopped, so RZ/G2UL
> should be fine?

If CA-33 turning on WDT clock (eg:- u-boot loading and booting CA-33) and
Later it will be disabled by CA-55 during late boot, then we will have prob=
lem.
Then WDT on CA-33 won't work.

Currently as far as I know, no one is using CA-33 with mainline code, So it=
 is ok.

Cheers,
Biju

>=20
> > By adding critical clocks, it won't turn off the WDT clock.
>=20
> > > [1]
> > >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.
> > > kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-
> > > next.git%2Fcommit%2F%3Fh%3Dnext-
> > >
> 20220919%26id%3D31989ece707adc453eb9f4f019fdac118f8fee72&amp;data=3D05
> > > %7
> > >
> C01%7Cbiju.das.jz%40bp.renesas.com%7C55f37d25d74646611de908da9a2ecfa
> > > c%
> > >
> 7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637991823087385873%7CUn
> > > kn
> > >
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> > > wi
> > >
> LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DhP2u5NwutD8AhhrOrY6dPvlWW8P
> > > kB
> > > g3skyTMXBJQaWc%3D&amp;reserved=3D0
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>=20
> In personal conversations with technical people, I call myself a
> hacker. But when I'm talking to journalists I just say "programmer" or
> something like that.
>                                 -- Linus Torvalds
