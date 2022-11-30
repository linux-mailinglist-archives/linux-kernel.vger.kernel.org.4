Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F85363D2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiK3KDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiK3KDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:03:38 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B624097;
        Wed, 30 Nov 2022 02:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669802617; x=1701338617;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1IxjdenxuqW79XnF636O1dt50OIvPutHGjPdl3WfgiU=;
  b=mDLNVopEqaOs/KyHtYqmyOH+i0O5C7YGZVgsX83YuIx8YV3U3VDB1RWG
   dKogmq4Iz3M/SZIIYXNV9QELf3CBwsKMh/1w5xfzvmdGa9diNTpZChNBo
   nFkPFxXc1QGcbRNjxfPXvsv9blycgOPqUw/4VBNW2/u8//EMa0gbgIHJ0
   sFSCfhvAFLhrVuR0qT+ZOGMWxbOuPD8O9TNjQqDRenejF6xTjF4gTPxcE
   4H/swwF30kk5BCs7Ng1PU1gnx1ze2WTnkDB31pFWruV5gFaOzc5B2CdHv
   U2ZubJ5Ioo6stVD/kUgd5Lacp7mB8DbgYYUNVFAka0e67/MKWHxyi65Lf
   A==;
X-IronPort-AV: E=Sophos;i="5.96,206,1665417600"; 
   d="scan'208";a="215772677"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 18:03:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF8fV6gpupb4FI5UfTzDVNGN6TQogLosoG/tIW8iXla3i2jKB0Q5788yGS9AQoLsqc56qm40wJehjil0/dKBYaICy/+H+7dH3HGhzQewdFU6bDxYkvs6ytzEw7LvN/FhC8zVp1VTv4veSz1RVyhMOMCl6xSLNE22bCgvJG4x1yMcOZMRLyTJxQNlx74G+OggO+g8mH1olRnPJ67wqRFBV7bEWk0Q4iYlUdTWSQjWZ0X56G6yj9Fo6JF8GRzSqnFQs2WaP+rvZV+Cu9GevHISARNYp1mD3eN0Ah8SEndLd1v/KBriS5yc8x3aUBvAiix3lCIiY2YHF/HgE04Wj0NTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLcW0cp98qQsjYXdrJSYrOWtfEtMjkfyIUVr+YCrlZA=;
 b=c5tzbTfQiYc79pdJOcuuwhrEzNiPO87+0P3oTVH7Xn7DHs/gpxLSYbLBujq2K3Xrvr001SWxVYlWiQ4Fe0bYGdLo3QGxwBznJBYR9IZj3heoS1fRGQaGGQmH/n68kSpZJ9P3lOVhl8QNsKUe+fdrdHdKpT4z5K1C7f8DmBs/aItbiRXNP5Wx9ToP1fqRQDqj9ZPwG/wYyVEnA9gopI/dvGcYANa7WPycn0PKN0DVpuqZuE8GDbKDVqZvz+9O1LzNdBpbrAIv8/uuB1a6U6IPYXHU7OWMKFmdGolq5pbdTQM7K79d35ZQ6EG/bH8xl0EzJUZOgEzIt65fNtymfJeuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLcW0cp98qQsjYXdrJSYrOWtfEtMjkfyIUVr+YCrlZA=;
 b=MVYY/UeVOTtkpDRah3QLq8zI8Dl4cY0QrVdZ59qIwvoIHgX0lNP1BoMdF9I7l16uLbPTAxbHEfwTcCXRZeWcj9nGfdfeYdT79bAgkWoRPpXsyk42FNYTkCbF1Yyd06ii2i3BxWZNh9glZ75kkRabtaBFg/SOfjLkDbhL/PxQ24E=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN8PR04MB6002.namprd04.prod.outlook.com (2603:10b6:408:55::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 10:03:31 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 10:03:31 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Carlos Hernandez <ceh@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Thread-Topic: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Thread-Index: AQHZBJ/Zvzcbgwhw1k+Lzs5S1h+ZY65XPL2A
Date:   Wed, 30 Nov 2022 10:03:31 +0000
Message-ID: <Y4cqcTRcni5H7UAU@x1-carbon>
References: <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
 <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation>
 <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
 <20221017155246.zxal2cfehjgaajcu@mobilestation>
 <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
In-Reply-To: <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN8PR04MB6002:EE_
x-ms-office365-filtering-correlation-id: 5436595b-cc8e-4c56-2d2c-08dad2ba2283
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1WhstygWXtVGXRnwSKQYnDyxj/E7MACuMNTJaNFBNuB82ipXCmnsy8aKCiLK/st+X5SL7Ix8k4WUNMk5nmhfM6sf50SKTaSMQvLsX3tMlP0qDzwQ38/MChl8jT+AfkVGi2vNpBt5blb5E4cu0mvj6MPBAbT6y1YWVEQfaAbU9SXvqYwoWyIeZpAvHSDm6q+cwvOxpwynA5nWw++uLwFKHVF0BT2KIVe9CsMsnrhAMSuMAbIak1tVhpDZi26iUvi6JsArNzTb7WJuUYLIvz5Cmi09TX+6XJKwp0sr0FV/DoX9BuovVzdF15S/PRCYHF5cuNbvabYHIe16xpBNnSc/LFBOeEXAFUJB2beLfdaBVPKmfqaY8NeLJGcoxhUnnZw++2ki7cdq/INGcMvg0hLcm5Y8edhoIEFI0xv8ut2T/xR97cXszmMFFG4+bnxzCHnZwBSj5t8JvyszTKlMwIAhhXoxKm3NeglGuaZWag6XpE2qpUJMY7S4XWZSiXhVQmDAhNh29qOliFi9SiCyzmT2NJv3ae55NWU1IVjRHUrlI7QyfwB/2GcHkE8jozr7xAhBSqnp1EGuCv7NQo5j+gA+O8Pm5FG+LMswGugrsHxUCSgLwz9etGtd1Pp6OGs1CnJAg90cnQBzH5BxFn41QFHaDpYIGQ+HFCavPBlWJfzm1FgdQUOEcKmbQZ/hEwQOjnw/KjBjbPC+LNRxDktk6rgMOC+pgNwpQtXgHi9ovHl2YNc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(186003)(2906002)(41300700001)(5660300002)(86362001)(122000001)(38100700002)(82960400001)(33716001)(7416002)(38070700005)(8936002)(6512007)(71200400001)(316002)(26005)(6916009)(54906003)(6506007)(9686003)(8676002)(4326008)(64756008)(478600001)(66476007)(66946007)(66556008)(66446008)(91956017)(76116006)(6486002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oAsvlDsJtIC0i6GwShJ+Qm7Md6hU8NR41gBD51S3MhLVW60pKfqXGbmU8YI7?=
 =?us-ascii?Q?ouAaYlXyclY38wq7SF9YDVw7p+NyZCicTayKiUQXWy0oYjXbaC3kD6tpCZ9t?=
 =?us-ascii?Q?P7htQ2wHIFfkBOxe/PhSnfVpf55g6oJuAx63L9DDHjukwKtQJJ7BIOUPOSVL?=
 =?us-ascii?Q?M7r/+uHju9wuBgXP+0n+YHISlkcxUPGsQjNrhn0GnIDMK9BjDYd8fqK8mtXy?=
 =?us-ascii?Q?LZpXLil94VDOFEd8Cy4kocZtjXUs0T9763lEoHx8h0UV6eBZaLzHNQX3/lPJ?=
 =?us-ascii?Q?k5zs5tyN+qOKGG/DmnVH8/tWL+s1sWxg006h+XFMDe5XsDIHlVAZb/A0h7uB?=
 =?us-ascii?Q?Sd7CwWLCF1PCapHvgmD5RGnpX4hjmpKC2/ZRCCBKML8bJYuZdEzwTsEPsAxt?=
 =?us-ascii?Q?hMYwj29OMngBohsLPCAGG4TidGzeR43CzpN2G7/aCgJmLr5CrsEv3BIMC6xS?=
 =?us-ascii?Q?wggJRdL6KFkErUFGXD4GkpKkyfolFM4Ft/Vlu+QpWobDp1m2uJAyQgupE/fz?=
 =?us-ascii?Q?NvqQ+csh572UMQD1NjOPnH8xZ1kdGlQ9kmErfs7PWEnJe7XjsYdIJORxOPw9?=
 =?us-ascii?Q?vjdgcITR6MjEO14/LP6tRqcgko+q9RsntBIZ5qftmYe9VCY2uk/DZz6Co0tk?=
 =?us-ascii?Q?S2llo5gPfo8cL5JT+LOyhI9++uwdkHwHPwlvj31rq+DgtzjY9niLA6aZKbIg?=
 =?us-ascii?Q?xyWnXXgkbBAySwt1Zc/iG2ncfQJ5lGbeDPdHIvFUPosXDWPI/JeHetLAW1Ef?=
 =?us-ascii?Q?aLE8cKP06vFpKTlC2ftxtAnUbhDMxkmeG3n3FOfonYaDxCAAGLast/kQPG2+?=
 =?us-ascii?Q?uun2DVxNeh3Zx6KY+mOG6Z445oQOc3WaeFogMpKREfm0RD62It7grn7fpFM4?=
 =?us-ascii?Q?yJxnvEMeW5ZXfr5KWGJj4veE4JhMfX+8nLc4EjzDZum9EtHIasjOvnD9SJlo?=
 =?us-ascii?Q?kaW/WhC4/raWrBK6XS0MPf12yPBPMiz2SEeMoeriyZInu2SGxHQmz+f4HFG/?=
 =?us-ascii?Q?5k4i0AxTKah9/Unuj60eiFQmwDEdEYWIkHqk9tze1kznvAwQvVRimAIC+t4f?=
 =?us-ascii?Q?DLohEnl/X8W/hnv0PaSlV+muJrw88/+t1jCd4QUkpHRql8ygflEpICk0R8X6?=
 =?us-ascii?Q?TrEIhj40YFQEBFmlV14Eorfx7x0zKLWvsXUgw/Z3+5acIfVe1SPf/KWuXNPB?=
 =?us-ascii?Q?lu0i2MZb+WndemuLGcDslHzqFHM3o0TnZAZcoK+9AQgmeixeqeA23qle/WXZ?=
 =?us-ascii?Q?QdIniGbvc+JACz2TTpQt5t6calduBGqXxiQzZC/nlEGuRpEmZbKqYanB0LXi?=
 =?us-ascii?Q?clcivssvLstxIgSGFihTg9NKLUq6rWVS7mOf+QCERPjCVqvLwhC4ConPC1ZS?=
 =?us-ascii?Q?PfxQkItTdOhX9Kcedke2OUH2F2A57biBo8zkDdC4hYbJmrLgWUPavadfd+YJ?=
 =?us-ascii?Q?3/oHKhy3COf/Ft8anZUYo39lGDubSQa5C/BDa4VpL58uMTALxFxxLp51SjB0?=
 =?us-ascii?Q?RLKOpHpQ1R59NVYEQSJUpVqLAAI2aaUZE8k0kufgvSbz6n0UvwLXfdzXOjZX?=
 =?us-ascii?Q?BJdzkw9mw8eG7Wv5zdtW6DGIprQo5EbJL3teZM+zme+pxGHnS3jxSXgjtWfD?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E3C0B3A8D78B147AC46C79460827D60@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZAWgS+PNDwuKyQ+rMrOfQBQ4h6NEvEeLfhCRhEKBJD+j6WrJ61RbB9ifWXRg?=
 =?us-ascii?Q?hhxy3CI/xlkH7QarvJQF2fm244QaY4hx8lNWVE9T+Pk3wYF4ILn1DLnAMQ38?=
 =?us-ascii?Q?NYIXO6XeMP5mlGWvjHplCCXSHYrsqpxcCcMgu7+0c+/ZxjEmu42np8m4bk1S?=
 =?us-ascii?Q?R1T3iV5+cAfZYtZnbIN6bJBkchhwE31QPpn3EFPP7hE5i3k77UaPhOgNtTLJ?=
 =?us-ascii?Q?lE8O0/SZ7U4eWsxgnQ42sASfWX7KR8IGmgc2a9clMnJA6cqze7yJy45NCaVT?=
 =?us-ascii?Q?FdBF8ucQ1hLXXorq+o6Y9NzyQLeIs6N/Gxq43/0MEmLvuOLiQADtRR1awb85?=
 =?us-ascii?Q?YDDHIJzCQ9GosK4/D8Z1AKn99Fcp0Zq1GQEj9824SC0b6avfRaQiGo00xWhl?=
 =?us-ascii?Q?foCk2Up78h2yyqLOeob/Y2F0UKzzIo3N4Bk5+xBYmIvltoHxvPf3/VFEY2xK?=
 =?us-ascii?Q?oVoIHWrWaUNtpImOcOPSOxSLItZuCYNy58tUMk8wS6ighFUFzWHq3AyLKGaU?=
 =?us-ascii?Q?KpgMZp6R2XYi5KKv7L5vEcR2NOaq1+B5/S08DthY3+riiyqHPQPMb0aUHbVZ?=
 =?us-ascii?Q?gg8OHBv1UMA08cyfuamA3iihFAA3oufvRFfjUWF51Ge2NlMvsT5uIgiGBxGM?=
 =?us-ascii?Q?wu+vlppw1jBa8SsI/kzvoWmtmORTDAQerS1KuY09FkZ6Ww0TTnvP2Owibz1T?=
 =?us-ascii?Q?YAGvI3Ikr9W5ckeEdj0z5yxO+NrVF9XMwGMJAwzdKqC0KrQEwYFpyYxVujQH?=
 =?us-ascii?Q?8DFDNm3KOJ6LHCKKJoC1UEq3oKmMcfxqVxhGibnHH+uY01fQbm1jegR86lR/?=
 =?us-ascii?Q?UTJ/RkrbgDlvw5jl27XxSbdD88ESTDoTGlcharmSWlyC+CNhPiR5Qkw8tU0l?=
 =?us-ascii?Q?n3+59xnSmu7FxnM5Qiw5WllGZOkbcvjzGdD4QEgCAQ7Qew97wGG5AlYGlAOr?=
 =?us-ascii?Q?pwNJ6OcnbyVC+tCxfMuI1OM8l0F7Zf7p4mjymhTrymG/UxMYiu4v8PF8xoTG?=
 =?us-ascii?Q?VweqeHPm65/mw9Q8FxdEddqk760gh2XY6i/q8AV6KzFZ/nGgtqpGBA/AlEFs?=
 =?us-ascii?Q?opYpBITptiSnGkds7TBfOETxtgI8LEPTqqYpOEWZRKsYKCeKF56ykdiE0wTd?=
 =?us-ascii?Q?/LPylD6fxUmCqAXvBF/G9WmLSkUEDV0lZQ98Ei0tN72/V6kj2B3zaDsBv1zF?=
 =?us-ascii?Q?mtWAVLfqifhCStJJYpvo+vIOhLt/ND2IzeY5PIQJhMGa75X2NldAEW2XBsk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5436595b-cc8e-4c56-2d2c-08dad2ba2283
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 10:03:31.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pl9ppNZ6aqEAQYmyR6im2CkKRxe6tZdJz49DB03F/V9NCHmtyTflqKCkyuyCTcDYF83lqKyRleO0rq9y50X7iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6002
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:10:37PM +0530, Naresh Kamboju wrote:
> On Mon, 17 Oct 2022 at 21:22, Serge Semin <fancer.lancer@gmail.com> wrote=
:
>=20
> FYI,
>=20
> We have been noticing this problem [a] & [b] on Linux mainline master 6.1=
.0-rc7
>=20
>     Test error: mkfs.ext4
> /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 failed; job
> exit
>=20
> Please suggest a way forward on this reported issue on arm32 TI BeagleBoa=
rd X15
> device. Build and Kernel configs details provided in the metadata section=
.
>=20
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainlin=
e
>   git_sha: b7b275e60bcd5f89771e865a8239325f86d9927d
>   git_describe: v6.1-rc7
>   kernel_version: 6.1.0-rc7
>   kernel-config: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuqtRW/=
config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainli=
ne/-/pipelines/706371149
>   artifact-location: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuq=
tRW
>   toolchain: gcc-10
>=20
> [a] https://lkft.validation.linaro.org/scheduler/job/5892099
> [b] https://lore.kernel.org/all/20221017155246.zxal2cfehjgaajcu@mobilesta=
tion/
>=20
> - Naresh

Hello Naresh,


Looking at the error from the log:

+ mkfs.ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
mke2fs 1.46.5 (30-Dec-2021)
The file /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 does not e=
xist and no size was specified.

It seems like the device that you are trying to format does not exist.



On October 17th Serge suggested that you guys should try to enable:
CONFIG_AHCI_DWC
and see if that does solve your problem.

There was never any reply to his suggestion.



Looking at the config in:
>   kernel-config: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuqtRW/=
config

# CONFIG_AHCI_DWC is not set

This Kconfig is indeed not enabled.

Could you guys please try the suggestion from Serge?


Kind regards,
Niklas=
