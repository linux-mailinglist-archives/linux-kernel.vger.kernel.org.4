Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2051F629341
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiKOI2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiKOI23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:28:29 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F71108;
        Tue, 15 Nov 2022 00:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT2YR8Ka7OQwE3kuoUGI/Y8WDhM1pn97VqxrMGb8lcqNy9dlBaXdhroXqZz2ZctCw44ej61m2sXGWThSPFxwa1WezAZX6vEpoeih1LYDfnZHbr7m/xbW2f9t3ki/XXpxzlHqq1RcOdnfXYXAcZI3a/gAHsrhQlE+iBc4rPAVcDaGm798d9DgGTkvi33eWwfjHpmAo3YVntRRw0MCrVecOIcsBwA070OPlQTS+PLVh2nBsBnwBhP2fvxtAVOnZj2yDD0UU+V3VqGnFneNblx3Ok2yFud0SCtgF9W1xIVjJPKEEgoM0FkZiwQij+A7y6YCTjxXxysGmrbtLCnqJIIFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ud+NQT6sg6p/F8RGZuMZNJuqnswFJ7ywOEzh5PRP0hE=;
 b=kbz4hi1ddyQPssIIiifgxcExWudyEUuiPyr271BHyblj3MG1KhHl/mvivN/C30A/D1LC01UvR1zeFen9lX/wKFuRj+bjqU+Dgr7CFVQk0ggoZPTqP6GCZvoC+1IXjc0wRC9JcEmPZ3UB57591Opmpjyni7u46P+nlD4xCVqm/2mgkCtZdycYEtvfJ0UYHyyJ4GdgnFGUW0q4y7fXt+9g6I1N0isg1ycPdkUBw9MEBg+fe8EC64qBa2b0Km+XgflfiTPGAMWa3e4P1KbOQWBjcdYyOIxmAyzIlc9MSpzAzqy7tLK9oGnfKWhr70hLLslAUDy8tk44tgLL0F+hzBwWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud+NQT6sg6p/F8RGZuMZNJuqnswFJ7ywOEzh5PRP0hE=;
 b=T0bhJQ0nz+RtHQDT33LT6lNYUcjpblD60O7yis/W9VW06EvYrnobq6Fl/XcJ82bFDAmWAitaOYddYw5odbD9qlrmNVvsQchaZD1iLbJDDUlYsLKRm1GpEwxO3GVJKQDyHR7ONU2ZxNKV23GeZm3qnLRc8/RMjT+OH833Q68W+eY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8445.jpnprd01.prod.outlook.com (2603:1096:400:176::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 08:28:24 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 08:28:24 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Prabhakar <prabhakar.csengg@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
 clocks
Thread-Topic: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
 clocks
Thread-Index: AQHY+FQ3i7+8G/jXAEWaK/AAUJtKua4+wHcggAAGgYCAAAGLYIAA0q6wgAAHxICAAAQu4A==
Date:   Tue, 15 Nov 2022 08:28:24 +0000
Message-ID: <OS0PR01MB5922145243E28E06FD3216D886049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUFsOktkVG0T9yGoVSKZ=JP1bdWnhpyQ5rKFt545JYnHg@mail.gmail.com>
 <OS0PR01MB59224DF03590185EFD5AF91386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB592239F10E9C768888F41D1786049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUzNA7CP1zGHSEMK9Jo+76fzEkZ+RXa7ecL0HD4y2gfMg@mail.gmail.com>
In-Reply-To: <CAMuHMdUzNA7CP1zGHSEMK9Jo+76fzEkZ+RXa7ecL0HD4y2gfMg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8445:EE_
x-ms-office365-filtering-correlation-id: 4b01794a-0912-4156-6fa7-08dac6e35d0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8l7Wb9ZGf9vIoiLHXxCX9QKbfBMK+a7dKCapik5i04GlXCqL79JhiPzQasLFFgpnIJ+tIAQ4dLYll8Hy73M+9rMyrzUOLDuJwV8orM+3f+8lD1IlHKPpvdVQJESLBSGn5csB7vv+Yn66zPRUnJ+BtlpJ4C+244lLmMV16+7oOXYiENlN/jZ+sfx6WmtRhOmLnDMWbzQp0GrQvV3jT5ZPseuJGh77tlZn1FpXkborg2ZwFHAwsO76UvPc8oCStTwbKruBGUgpKk6n8Ib+/JTzvJpmLFiYgQ7uUAo93ibC9IfoFa43DFYPQKqtTIYL69g0pusP2PIQU8e8rMMhYTdhktY8aBpOn/lAEMToyVITW4vAF/YOVpI0o7djIFU6r8c0KIAsX1HzH9SFMlrG8RniVzPAIhoWEz44HrjcaKtbU8NF2N6nqRQqX84sQxLOJd+xSaD0Kajo0o2kx5FAKigulEsdqC52hnpk17eZ1x5kUINktcLhMj5aYS3paE3sfCjGa8Zx4OADOWtD8zjfCDMAWlit2psHi1GNM7iqpBWVEqlsazxgF7UowS+rStlZpAGrNv3uPOkbvDBhxca3jBmOcSuvKN4mjgOdxRkXEdsXATApHYSnGc4MVcRdRZtAz9UQEHBHL5w7dZtPhzhvmU1HH6cCvsUwPM6ly/twWjwE0BvqYYuRXrPIsDbQVttJ43Qw+8U764ZiNgZbrXZf4/JISgyt35c/Vn2CYOtfDwLW9zpP2NiHkNUm++qaoBMQ3qjdbtuL0tiMw96R4daoTajylA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(71200400001)(33656002)(38070700005)(6916009)(478600001)(107886003)(54906003)(7696005)(6506007)(8936002)(5660300002)(9686003)(316002)(66946007)(26005)(66476007)(64756008)(76116006)(66556008)(66446008)(4326008)(8676002)(52536014)(186003)(53546011)(41300700001)(55016003)(83380400001)(2906002)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NI1z3tqlYVxfEgwrYK7YVS52cUyvQ7Nej03GtMKv064tDkbRZYnK2QY61/5t?=
 =?us-ascii?Q?yrO0xBa0ctxSlN8kc5CfiIrQoYKf5BdX0mRxwdfQAyMjn9vi2GLV5U6mi8Wj?=
 =?us-ascii?Q?lrc7T/j9AtEf7q2k4fY7i2/j62QSZgEShvAsFHrLs8h7nZ9dzR5lsVeR/vjQ?=
 =?us-ascii?Q?8VSe9HWKL2OEIITTuoysCpu/A90gXLHqTLQHTWt7LHW+VW3y4JcuOFZpFn7A?=
 =?us-ascii?Q?CvGZDxoXZrSBzYPXTGF4ZOoNY0jhdnxj1K6XAP8q5xPaX+Cxsts2egKUqfpL?=
 =?us-ascii?Q?6QeufE5bTd8+FZNdFsrp7dva4QTRpDhnLi34WoGXGFo0Lm5ZggWsZB5q9qeE?=
 =?us-ascii?Q?VxC0Rhy0eFzhHts6sqjQiMj6rS3eZ2qQsV1Z7q0lzkPzJy6NdZ46c150Ser4?=
 =?us-ascii?Q?VY/2abS1hnw2/OdTnfNfYdJNi+vj+UEQlRMyFexb7eqwv9sN01KXybJTglfQ?=
 =?us-ascii?Q?WTdmSfKDfg8knfqYrdK26ztrgdof3SNolYNu7lvE8KpIk1mM4TNGCaFEE3Z+?=
 =?us-ascii?Q?6MJi3WpwNaj31UdJY4zSkpT4dWRFo0rjG5XxCbrcTVpNbe4SVkYmTc1oGOkv?=
 =?us-ascii?Q?HsU+5beg2yS0L6E0YsSy8EWYhni658siblJkRbYPdBaLRgJgYlfGOA08u1b+?=
 =?us-ascii?Q?3ThY9D/gaOjVQ54ZrrfY6DV6lsHO7fyFoj6pUFa1Gb9rcUAcxhCRZjfX1krA?=
 =?us-ascii?Q?HiRFmKV4d9b+Q3Wmruzdf+1H75cFOHT9zKaTfMA5cJRkVOv/iHTBdcdgvER2?=
 =?us-ascii?Q?4fJQriUszrziFmaZdDyh2ZJT/2byKcrrcu2VSi0fHUaZVG2VnTgh2hJp5aY/?=
 =?us-ascii?Q?60La7ADC5l42YypR9UtFwzY5SkiK6O3t0Q3TRdTEG2ntJ+uIC1VmW48fgo3z?=
 =?us-ascii?Q?5X789O/8H1o33mGh6db3r+tYDEujE+UGBmxJAzhIKsWN2i0NMp468XC1MRwQ?=
 =?us-ascii?Q?C2oc4xL3q3aMEXCFdRUkDUU9XpFCCQqDEe4T1/xUXZCMojVXb3BDAaD8dAY1?=
 =?us-ascii?Q?ukD63SiwIs1xAbNObpB06lsi+lihksSuuR0/ms5TP2R1qE9q87zTty38M2xp?=
 =?us-ascii?Q?K4lAOeThupJFAeu4Szk2lhr+6ON72sd5YUS+9QhKVkMpkC5LVv58qpp1ti07?=
 =?us-ascii?Q?tbwqYDoeHpuIqrz9oU5Bdi6T6Mgy2FM4IenQDutr2QexyItyNOP6cnIjhg4N?=
 =?us-ascii?Q?k40qda6LWI4qH9N2iYOw8GPtWn1Bsrul6Us3zbeC7eJALBhsK7aA4oaM1lcc?=
 =?us-ascii?Q?HVm+HI/e+XQJKpGDbciiNgosOZyYFOvOVQpt0SEvTNcjU5mkQ4scH1bpmqwl?=
 =?us-ascii?Q?Yc1tOomREF5hiIOBoFxZBSoHydd44lycmH4qzv36St5UjE7+A2+PKvxCL5+L?=
 =?us-ascii?Q?A1IkpRs9ayMuAK4/ozFLjDL4CrnaKCMzEE7Cni0cyjuBmu5sdKIGmiDZ5yME?=
 =?us-ascii?Q?qy56rVUXgUTE6LZkdUbqw6cWuO0iwG8QFlSYOEGi5ft2kOzk6yowHGAcSjEK?=
 =?us-ascii?Q?L8ouAJ7z/U+aHVRU8r7tb9z5sHXw1wexgQ451cwrb3wOnUu8ysfamq5RkZZA?=
 =?us-ascii?Q?WoNQt3ON/PRTa9XYRVC0YLhsqBuC82l9gEcS7CIViSMC02hy541Gbd+HkVnD?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b01794a-0912-4156-6fa7-08dac6e35d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 08:28:24.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqcbYI7FFNI3moe161SfYjDKKk80NP3Z/x9DTKztypZVUs4AeRh2za6ycHETcfLgSNr8I4ADNvWF6Y5uUFNtMkqlDABWccRvI4rHsaivnYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8445
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Sent: 15 November 2022 08:11
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Prabhakar <prabhakar.csengg@gmail.com>; Wim Van Sebroeck
> <wim@linux-watchdog.org>; Guenter Roeck <linux@roeck-us.net>; Philipp
> Zabel <p.zabel@pengutronix.de>; linux-watchdog@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Fabrizio
> Castro <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put
> the PM clocks
>=20
> Hi Biju,
>=20
> On Tue, Nov 15, 2022 at 8:48 AM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> > > > -----Original Message-----
> > > > From: Geert Uytterhoeven <geert@linux-m68k.org> On Mon, Nov 14,
> > > > 2022 at 7:42 PM Biju Das
> > > <biju.das.jz@bp.renesas.com> wrote:
> > > > > > From: Prabhakar <prabhakar.csengg@gmail.com> On RZ/Five SoC
> it
> > > > > > was observed that setting timeout (to say 1
> > > sec)
> > > > > > wouldn't reset the system. To fix this we make sure we issue
> a
> > > > > > reset before putting the PM clocks to make sure the
> registers
> > > have
> > > > > > been
> > > > cleared.
> > > > > >
> > > > > > While at it re-used rzg2l_wdt_stop() in
> > > > > > rzg2l_wdt_set_timeout()
> > > as
> > > > > > we were calling the same functions here.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar
> > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > ---
> > > > > > Note,
> > > > > > - This patch has been tested on RZ/G2L, RZ/V2M and RZ/Five.
> > > > > > - My initial investigation showed adding the delay after
> > > > > > pm_runtime_get_sync()
> > > > > >   also fixed this issue.
> > > > > > - Do I need add the fixes tag ? what should be the operation
> > > PUT-
> > > > > > >RESET/RESET->PUT?
> > > > >
> > > > > It looks like timing issue, None of the previous devices are
> > > > > affected by
> > > > this.
> > > >
> > > > To me it looks like the device must be clocked for the reset
> > > > signal
> > > to
> > > > be propagated?
> > >
> > > Yep, provide clk supply for a device, then apply reset.
> >
> > Maybe we need to make it consistent by taking care of  [1]
> >
> > Current patch: CLK ON -> apply Reset for V2M.
> > [1]:  Apply Reset -> CLK ON for V2M.
>=20
> Yes, that would also simplify that patch: just add the call to reset?

Fabrizio previously told me, CLK ON -> apply Reset does not work for RZ/V2M=
 reboot use case.

Regards,
Biju
