Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85A6D58B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjDDGY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjDDGYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:24:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B314D1FE1;
        Mon,  3 Apr 2023 23:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJm7XQl/gyzsXIJoztudjQVELw8tspkcgkkTi5wwtC/CtjgF/YzFUm/oTJl6gsBZDTG0DguQGA7AZnFCWLyscoo/NGJ7yjUER6lP2QBYtKa2puimFFjeFrOUZfW0OYcOs48GFB79JI90YUUy+pD3WNw2kubeSrS5lXCp+BZtHM92N+J9QqSAhcMMPRwAz7BGjIbqPnrRbz6T9Rk/1VRf/l6sBWAaohKHDE8tKWa+PWKSDgYOnv9rP96fCGNxLWsT90Jxbss7dzy6GXvRIPvsRtBkQl/GwyPJ+UgyXnaW36fnasP4dM2OcTufZrky81ZG6amLv2vGxLi6A8DMSb8CKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwxnmdcqQ4Q8usyP3Fya1bDc3pt4OKrGzpW9GvAL29Y=;
 b=g8HOx5VnoS/RijTs0zYXPwWhaRTxfx8a483/jtfihI2rG22rK+fuWlcqwBibXrKgdHrRjOXTyV3ZWxGYpcQH0XuvlS2snPtZX2bnMLK8hZFk4759xgHTOelGfQXkW+pdaCvY6cZ7Ow3phJD0OnX0QUJjc65WGg3w8GRZJ7WfU2VU/DofHRYy+039aTzUOCXwXh00heqgPi8A02syEOmAhmN041UjflEalb3YO9dKWTvWK1w+Ca2ELEoP6lHHSlr6XNi8WCw89WwkAJ7EKTAYaIbxGMCNU6SD/bUwT9gARakj1qKBd/d/SFvbYmkdfwVvW7oZx+YHy+G4nHDXLPcY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwxnmdcqQ4Q8usyP3Fya1bDc3pt4OKrGzpW9GvAL29Y=;
 b=N0d4+EQEbUdakgE8LxigjP9deCvd/5L9wCuXnqqnJqCGVeUOVuktkpSsGGrU6dOvyQbA2wQZ0lVzT3A8G1ajOX31XPWOFaqSL4E+fjhxStiQtAoPWmhRxmeyNevLgm9syzdjmPZgF76rU8CTySy8Q2YLa6Ig75OwZeMdQ3yqxSk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8649.jpnprd01.prod.outlook.com (2603:1096:604:19d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Tue, 4 Apr
 2023 06:24:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6%8]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 06:24:16 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Icenowy Zheng <uwu@icenowy.me>
Subject: RE: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Thread-Topic: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Thread-Index: AQHZY0gufzzLDccxyUW8wSwyIaAovK8apkQAgAAN0RA=
Date:   Tue, 4 Apr 2023 06:24:16 +0000
Message-ID: <OS0PR01MB59224C99770F84D8CE2D0DBA86939@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZCu1tFrQCVe2sgNz@infradead.org>
In-Reply-To: <ZCu1tFrQCVe2sgNz@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8649:EE_
x-ms-office365-filtering-correlation-id: 3779876c-8e83-4b8e-62d7-08db34d5375d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3cb4weHMKvanSBlH2vbqO5GtBedbwPTS8PpGU4L1cxLnqO7sv+kryne+ThMr01gBks33wMfZZ3Ak27DrC2RL1AnJ+pYVuXf6lewIGu1Zd2N84hbGt83coV3QVSKxuWhLy4E49SyoBKEJ81oldpRsIbs42r3JqSOqUf+Bhl0OfnLRDxwx9CVsqAlYRglXUinWgYhRt9XnMfgD3Y9SqI8/Er9flOp88Ft/vZdEh7LjHlYHlnYapp6hszau6UhSDwE7mCAfCNlDsQrd0R+DhLozqzDjlltzSWi4Rx6Lnh+4OBzamrLOo0Nb7teGdQ7BB8CAK5WnsHDG6tgKm39gfrbKT9f1W/h2YZTEqVWfFlsWZGEz19wh4bnNDBBSWpeFiov3w2aT2rPthbGjQB5Rfvs+RNPlqpEOfkdIJChnlTe/3jwrMexfnpHyLld6CKGzKl4OAcSrbgCL6cD3UMm6Ie9XUGY6QpjjcLBpJ7RrbRKhFHSaUh79sFKfjpWbqrN6GNvh0h7uQNQZwY+9FXV0ehHWnF3oxvCvu2bUgJjLKKo7M9MJl46IcUC7fGsNzl4wdmaJRh4pMzr45BVNi8dJPwQ2MQ+58Ynu2FmYcvh0fCX3FM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(2906002)(478600001)(86362001)(26005)(83380400001)(6506007)(9686003)(33656002)(186003)(53546011)(122000001)(38100700002)(38070700005)(71200400001)(55016003)(7696005)(7416002)(966005)(66556008)(5660300002)(76116006)(41300700001)(66946007)(52536014)(8936002)(66476007)(4326008)(66446008)(64756008)(54906003)(316002)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jAW+bKAjIYYxD7hSC+kyN2QPLft+8m//4f3xIUZ6l6o/D8QAeX3Fvb8TWYS6?=
 =?us-ascii?Q?vMoavP09SyUis4AvYEN3ojJPB9cgIWlqjD/BJ6615Wq75DAJj7hz/VjKv/mW?=
 =?us-ascii?Q?stFi3pIIJyGvX332Tjf0cuoM9DGxqEu565ikz5QAbsV7YJC8BA5iTF++YaNh?=
 =?us-ascii?Q?aeFwpYKwHUoUbpjq2V1Wdw9aJ8+BZ5UnHHT3PTdzToOgap3c10SM9e2Nyflm?=
 =?us-ascii?Q?MVZZQAi15V+jWKskJm8en7nfNL12jifeM+BhS4a3VOakEWNPtlGGuVNdisw/?=
 =?us-ascii?Q?iZJJ62hiYTiXmLP6dLZ1a5qBxkchJ2nFPwqfax0BzwA0nj45apH/4PHMiX+d?=
 =?us-ascii?Q?yga2EXOvGyKRz8vuf28Pz/KvEpWD/tjBfK/AYtf/MseYNVy03pCjl1BAcL2Y?=
 =?us-ascii?Q?qAYXEiuNfc11AXaVmIXpICyfpBLk+N+unBJ9vWEWuk9SW4tR/X5c2f605nyJ?=
 =?us-ascii?Q?cSPSxTJ6xjhaOFgBmxuqj7boDQ6FG04r4egb5yRKK60wYGd3RoXDSrB1VfbS?=
 =?us-ascii?Q?T30IcT5bO/CKJkpYtVLG2Wnbxg6ZwE0G9cZJVwa73KOTtbMIU8V3LW4W9MaK?=
 =?us-ascii?Q?8xqkusk/EyNU4p2/dVykW4i3MvR9ATOcmesoQR1IlwmEgz6fa0ZFsBWjvvOl?=
 =?us-ascii?Q?TIAzLUGYy2vflLH1MFyhmjJ+nSLL7DIeRlfgVV2TYopNqV1npoBB6n1vJy+T?=
 =?us-ascii?Q?uP9gprAPuRyJ/oasrqaoEcgPSndPborcOCpfVxaJbmcUnkzh91psBIR3Cur6?=
 =?us-ascii?Q?LCKrFSX1nefnHUGYnquZBZjvwvesIv5P0hvjOFks/LhPXZ2yUE6z/Irq4NlB?=
 =?us-ascii?Q?aLmamp9Zd0TmulDLFmqg06XvEl/AcVIzKmkJyO3oKGcvMDeM9fJ06awEENSg?=
 =?us-ascii?Q?gT4NIVwqouJ8Sig6h7382D+aU85BcxSaI9m+TEwSXIW4Dhgz0FEOwTwhMKDF?=
 =?us-ascii?Q?RiOIErWcEICL2LT+my2yazW1CBdVA8MZZWB7V27XUF3kFJlNiyZROyY2L5Ge?=
 =?us-ascii?Q?igcriv9Dz5LNWXEBZN+lXAaIxFqvK/iqKL3LOXPLrYCPAnrVFgZhtucMLHLk?=
 =?us-ascii?Q?7H/Lk3y46Y0pfLItqRX8OwSppgm+TucRyJJN4DMHc6NhkmnxeeSk7lFBME53?=
 =?us-ascii?Q?EzY+S6Ttv43N+F2AaxzS/8b1+SkedbvN/JjgE1yLf3rXyWWh/mS/VW5NI+E9?=
 =?us-ascii?Q?6MxTkUtAIYV1uO3n9JlZpNtmP82nisYi/elpigCJf2pnkQD+IqY9qGdIV9Bs?=
 =?us-ascii?Q?HneIm81owYSY93W92DvDtgsmNTzpPYtpw87qoHb9oe2RXTjMbldV6sUS2UJc?=
 =?us-ascii?Q?aDfSL1sMulJIlVlUdbeDrsXP8Lq6HLnfbcaTb3G6fnFKXxiS3phATHbeycfH?=
 =?us-ascii?Q?qFpWgQhGXPw1RmhM8O4scsszvvTFMz1uNFBr6qlzBM9CmlvU9yJYLoMsTjgX?=
 =?us-ascii?Q?1S2MKJdWEH1F/Kj6F3ApCE8iYrm2rXv/Q1poU4ijMNnf0YnHK15Rbui7oelc?=
 =?us-ascii?Q?9xxVXCwBRz4pJqVa3JOgbUYTFfpfHXwMyGRWk/IoMHggHwbqGdX6ihtzCX1v?=
 =?us-ascii?Q?daSj2BF6uQ3Xe6SH257LDF/oGbysuk7eFhsUMlL6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3779876c-8e83-4b8e-62d7-08db34d5375d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 06:24:16.4334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q85BQ0JAVAFIgQNoDRUee4qhdx3KMquyO+dtY6vEUe+dIKOFYD3Q573KjSyNcIHmaaR0VG3DgZMufE11yr9zc+QL2r3vJzVnvxMWG/86Yos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8649
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph Hellwig,

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Tuesday, April 4, 2023 6:29 AM
> To: Prabhakar <prabhakar.csengg@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Conor Dooley
> <conor.dooley@microchip.com>; Geert Uytterhoeven <geert+renesas@glider.be=
>;
> Heiko Stuebner <heiko@sntech.de>; Guo Ren <guoren@kernel.org>; Andrew Jon=
es
> <ajones@ventanamicro.com>; Paul Walmsley <paul.walmsley@sifive.com>; Palm=
er
> Dabbelt <palmer@dabbelt.com>; Albert Ou <aou@eecs.berkeley.edu>; Samuel
> Holland <samuel@sholland.org>; linux-riscv@lists.infradead.org; Rob Herri=
ng
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Biju Das
> <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using
> function pointers for cache management
>=20
> On Thu, Mar 30, 2023 at 09:42:12PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Currently, selecting which CMOs to use on a given platform is done
> > using and ALTERNATIVE_X() macro. This was manageable when there were
> > just two CMO implementations, but now that there are more and more
> > platforms coming needing custom CMOs, the use of the ALTERNATIVE_X() ma=
cro
> is unmanageable.
> >
> > To avoid such issues this patch switches to use of function pointers
> > instead of ALTERNATIVE_X() macro for cache management (the only
> > drawback being performance over the previous approach).
> >
> > void (*clean_range)(unsigned long addr, unsigned long size); void
> > (*inv_range)(unsigned long addr, unsigned long size); void
> > (*flush_range)(unsigned long addr, unsigned long size);
> >
>=20
> NAK.  Function pointers for somthing high performance as cache maintainan=
ce
> is a complete no-go.

Just a question, how does function pointer makes a performance difference c=
ompared to
ALTERNATIVE_X() macros?

On both cases, we are pushing function parameters to stack, jumping to the =
actual routine
And then on return pop the variables from stack. Am I missing something her=
e?

Benchmark results by [1], shows that there is no performance degradation. I=
 am not sure
What type of benchmarking used in this case and How accurate is this benchm=
ark?

https://lore.kernel.org/linux-renesas-soc/40cdea465fef49a8a337b48e2a748138c=
66a08eb.camel@icenowy.me/T/#m093c1f3d8f7f0e15bd2909900bf137d5714c553c

Cheers,
Biju

