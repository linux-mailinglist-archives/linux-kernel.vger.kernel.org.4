Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383D15BF5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 07:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIUFW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 01:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIUFW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 01:22:27 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2116.outbound.protection.outlook.com [40.107.114.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD07B87A;
        Tue, 20 Sep 2022 22:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lmm5RejlX6p2XOmy7fHlwYp8bQ4RJYwdJFJRnv/WoKOHY9Coe/MDtdaZjk0asRxa8Bt4PKJZ9tJntXd1B/EBZApnnJs0yEpAR6Cs0IdvCoUIkg8W2hEbTAYPHMw4bQluQG28yuot+5o5jmtzDihMuxdLH8bITyZ4f/H2q95CCSodsJi01uFavyzwv4rmU5kfF2IMuq8OlIvIkTirtRVRN7MLLxcc9vVmL92Z/HQdAcrhydqnNVtYR+z6nFqxvW51ZZ94PPykHHi5b8E8hyrwOnGMmn+21sf+iPGZFI+yIKeWEe951W1XhxCkq3ulK4I/1xG27wADZO9AG4XJAij6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGeEHiScC9EXLFA5ZCTWQmK6K6h0M9QT9sf6tP+TRZo=;
 b=aBpHmZAp7qxY8Vu73yfJbkJ4+XuZmyZWFAU+VW0V2Ia8EEz7N2hha8FgvpqcFm5KRVVJJf4I70HTBC+WNLhYiTCXL5OjD1F6pNtiXeZ6EFvxgdCqV1NvKDtMreP9QBxl2PTecpTuyBi8tT+kQ2aglg1mzr1sf2EWaxrcaZhGE6sjrGieLMz/pDgRTKuKkguMjPPZynkRGTAkMhG/tTyUxDV1WmE1qwcih3sswsIQYl02aQ5SQ8aPcJUtaJ/fp6zbthqzjOcNGPqAcokOFWqd7IBaHvgNN3Aj0rcAuH1THltxhAd8p9UR7Z9vg8FoZhBT0xB+KYvwqlF9QRp59Q9vEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGeEHiScC9EXLFA5ZCTWQmK6K6h0M9QT9sf6tP+TRZo=;
 b=HUQh4EIAYYqtVQpN+cwLoGeHyU/cWuey1PA5Qwy40TBAnSBCA8Aaz2+ZT/HXqBojBPc8/EoH71lgTAm5UxnZjL1kNGBZzvtzW7RV7seKuefUbGqMm7E2jvrEM4R1LikPZ/JpqB6blpuGrws3qKuPOgZfpKgXMcb4g0GzuTKLyL0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB10327.jpnprd01.prod.outlook.com (2603:1096:604:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Wed, 21 Sep
 2022 05:22:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5654.015; Wed, 21 Sep 2022
 05:22:23 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 07/10] riscv: dts: r9a07g043: Add placeholder nodes
Thread-Topic: [PATCH v4 07/10] riscv: dts: r9a07g043: Add placeholder nodes
Thread-Index: AQHYzSHUiYFQxotF30GY+2sg2SrZHa3oru6AgAAEELCAABhRAIAAjN6A
Date:   Wed, 21 Sep 2022 05:22:23 +0000
Message-ID: <OS0PR01MB59220E0803C83EC63954340E864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220920184904.90495-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922AFDAFE3DEBBFFF875875864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59224D591B8A227A5655ECDE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s-6FLu-5D44-Szt8eN1V0rhPxm+cO4OrcKmT90O8LoXg@mail.gmail.com>
In-Reply-To: <CA+V-a8s-6FLu-5D44-Szt8eN1V0rhPxm+cO4OrcKmT90O8LoXg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB10327:EE_
x-ms-office365-filtering-correlation-id: 9542c870-8851-4f22-e83d-08da9b9143a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xraFaubFC0D1HfOD91YPVFzRQ5DnYAx8Tt36rbZjZb8a7Gwywy6VOGMxVA2+crUBpt/AXu8TEDNLikPBrFOr1vgUgSg5A9LIbcwu1TCeWx37PT1d0eFmICxhFWwMeWu5wu4/nme2aThtVlQXYaCJgji1BQrf2YLjjcX+hsV7Mp/rTojKnrYu40OakHDoW/b0KgEI6dCeme+KirPj6OxO3dGIAwJJAtaBIETg5WqqWkdyIILWHxtPcBbJU/1RmXNleaDoJv/G7t8wlPe879/XNAcFcwGNlEdwihQmKwNu6gf1F50+Ng+0hi3iyJZTKCvDFP7pRTywRVLhhHdabyZ6OImMcweBhG4OxaZNMUW04zwahPuyWjplAGP8qqdqV6A7EgeyjZYL50kR33NAfDN6StG/vVidv2ftrcP3WDt8INFfPqtbvkXBu9kyvJz89kHtqFESUUOR3cM3z/RA52Lz3SF0sCqgCog+sbHKDo1hGUoegsZxONgQfICdsIchAu3KwgFMLpBDX0rxGdImQJzrhjYVi6HV7ZRwcgzOOjJxRV+TM+6cXdlb/aoPtrb1GjOkbGkDB1xbySpPEEA94ViJpwN3zNuPn/kk5k2JZtx2CQ5Ydp7gbgnqXzz5xDvo+v9tO+tK0bslYIkL/BJ6SFPVFIb+uXwVCC8Uq4srNU9ZqdOL3kJwM1lQ5sCG1o9Sc3p8+Qu5WzusDnr11B4i279dUJZC6kDH93v6g7dl4QePUqkILuiub0fY238Kzv1qdgYWU0i1sOoyN9OeYwy1F/FSVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(7696005)(53546011)(86362001)(6506007)(66476007)(64756008)(52536014)(4326008)(8936002)(26005)(38070700005)(66556008)(478600001)(41300700001)(107886003)(8676002)(71200400001)(66946007)(76116006)(54906003)(6916009)(66446008)(33656002)(186003)(2906002)(9686003)(122000001)(7416002)(38100700002)(55016003)(5660300002)(316002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mhpoj3lJz2L6fgNlpQp9oAcuRUEyIrAMMxueNBI15fKNSkdPtzoCsGUr6reI?=
 =?us-ascii?Q?5hS+yoMELkExMZ/FJOF/pVhpSRLN1t2yYmiSGo1oR9GXPJbI+WcQdpXRD4jv?=
 =?us-ascii?Q?Bggy9FnNRU1llodJle7yA7jQ7k1tFI8SPUsAb1T5bulYvtOujY4OZmqQMk3q?=
 =?us-ascii?Q?47KwneMUhYTdQBw4S7+gJD9gMrl/CywcKoh0xDyZLXxddKNeG4LV6JiJ6i3c?=
 =?us-ascii?Q?tN2eGsyvEx4XgFcNM/KMB/r61MQOXPBPQoePl0absPtYmSSZSXE1UL4fGu60?=
 =?us-ascii?Q?iXkRexVBvS+SzYxplTFzPA+ZgCf9ukcWPyxGWJdNBwoM1CY0LF2rTJByskUj?=
 =?us-ascii?Q?BFYWlXvwJ5iA5CsSywNHqx+Ro0DJUaF8dRPQOfoplVM75d1grRsgFFtxHgZf?=
 =?us-ascii?Q?bc2til3lRqC/M7/ANHR4w9/WbLsM7AFn6LRgGtHJBlFNQOXg67jWQg5WPJHp?=
 =?us-ascii?Q?aI9yFYBKlOmlF3gU+mvxuCL2V9lHs9oD05I+pdesLZ66R97oP9mYbGIE2RwO?=
 =?us-ascii?Q?FhgwG6ZvrzJU4dgz7T/sB9sYmexP5K/cqAG83Re6sqVrZCQAq6g1oUi72Ahx?=
 =?us-ascii?Q?2FPCU0BcHOXvPPnwE9Ij5mqEUvxseCnAZRtIhs+uJUazQvO/23AII382Ak7g?=
 =?us-ascii?Q?0zM9py+pxyuq8d1ntYui182GqC9QUJB0jiJhcGQXMrUfMpFkubhd5WiBU5XJ?=
 =?us-ascii?Q?LQhmf++99mui4yeVGusMUxeuiZ8cG1m/0cH4BvHeqOk+cRcE/WDkguZN/VLw?=
 =?us-ascii?Q?hHIRpLYSk+pAaWbRqr+T2e8jFsJTlMe/PMJfBHYevGrxxE0TNP+ExjzS0XyP?=
 =?us-ascii?Q?mlgWkJ7j5iyRYLaJc3v94bWDQ+pi4rTWRRSrA6Uc5SiNiSFxMO8al5OAfohU?=
 =?us-ascii?Q?DfZiRDtvPL9jxSVAkdbF/h0c+EWSqBGQB0LBNWOt8M+yHG9HXdaiKgDgkupn?=
 =?us-ascii?Q?QSug6Z0ZQnef9JVnk8+23kmXS22z4Mtg9tUeG955TvHDLtgroz7YvQtQZYM7?=
 =?us-ascii?Q?7vfP5+86WrYfXUQR7EkM1eZCZxOEu8f0+KcxnB3Jhcv5fbSQ65/R0FIqEj2F?=
 =?us-ascii?Q?AH9XIIv0vFA3IwhPHLhHxNjbuMHPXaVlhGqB2VbmfOLNwz3S6vViE4GKCXwM?=
 =?us-ascii?Q?Ug2+rw3czrluj2D4gRnPvf6XimyKdrVlIKxsA1WQU16DK7rTg3/+yLVHXrVz?=
 =?us-ascii?Q?8jStVkown3CEbxMbioA7zfXfJXYTZSwe0sLOGJ4c+Kbpyn/a44Bc0Z8VN+OF?=
 =?us-ascii?Q?jOivjaAGc4CeopQhks+k4JXNb79SPDBzG1RA3Szf7h9O2YKWLbriwaYoyKOO?=
 =?us-ascii?Q?4pHVLf1QKKWuBvgaU0gL9fwU/FjBdz/vM87NjK0Gd/VONyJL5IzihZo2dx/Q?=
 =?us-ascii?Q?Dd9X86l+3fTuELzky9imk3PG4E5e3rpFLQCVehv5SEOtxcqhdaIVwzEoKOO3?=
 =?us-ascii?Q?xPg10rZASgQ6oKgbOwWKzquPgy0VdPxc08jZ3qi4Ag8s4AfallP9lwVTFsTr?=
 =?us-ascii?Q?BDGH9MVFRA3RS160aJ11bZUo0s45Qi2FLwnq8M2CuSPuKHScp7ikkt5i2jRy?=
 =?us-ascii?Q?0rPNp5jVaCZlxQQuNj5iHAryTS7JVy30tIeVJkJxVCj1D6BKHQNBDryG9jKp?=
 =?us-ascii?Q?jQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9542c870-8851-4f22-e83d-08da9b9143a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 05:22:23.3830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PBIJVWVgCm70xFaCDJo+45gr1M8QhJnp1t3bZ1C68nWMOwHHufUbnNC8cwReK2+nfm3icgolgmwlQWVXrcluEhW8qqTSX4iMHeHNeEHeHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10327
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

> Subject: Re: [PATCH v4 07/10] riscv: dts: r9a07g043: Add placeholder
> nodes
>=20
> Hi Biju,
>=20
> On Tue, Sep 20, 2022 at 8:26 PM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> >
> >
> > Just ignore my mail, As I realised IRQ property in each node will be
> a problem.
> >
> Yes the IRQ numbers are different (offset of 32) along with the IRQ
> parent.
>=20
> Refer this thread [0] where other SoC vendors have similar issues,
> maybe in future when DTC becomes more clever we can use single SoC
> DTSI for both.

Not sure, May be the macro suggestion mentioned in that thread will work fo=
r us??
As it is just only the interrupt properties that differ which is
handled in macro. A Generic macro in common dtsi which is
expanded in RISCV or arm64 specific dtsi to get proper one??

Cheers,
Biju
