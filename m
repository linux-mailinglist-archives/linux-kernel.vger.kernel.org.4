Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDD66A3F60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjB0KUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjB0KUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:20:15 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8241A8A50;
        Mon, 27 Feb 2023 02:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677493213; x=1709029213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4hNMS5p2nzXmTGgd/7JvpJVC3yURXtuB/cICXnHg3EU=;
  b=ojLM49TT3SpIOtZEvrPoHXufq/qC2g9kExG1j1S6m1ug24Rify1prsqq
   FEEBZI5rO8YByaQy3Z32m7Hje9BP+6BLwYQnrjU7Y7Obwlk7R4fkyKLrX
   dlYMvRNeb5Zuef2MDkFzbMxOZGV1xY10O7h8/9xKrwls+TUnhMvkq3T4/
   JZ5V2rZUM5QqJRLLXXBEsr9ITM8qr+8CqBoVMI0AuTyg+ACaEbXtTBwk/
   efcTWUvkQpRQiIdXnwnDoRNBNKUbN5RWrv6z5ogUwxyH0A8pM4qvDcyAJ
   PA7ET9/k0m6syU5wy1sFYxkwUPRFCd5L8z3+lBj4+Z+VMwg5YHytrT3or
   w==;
X-IronPort-AV: E=Sophos;i="5.97,331,1669046400"; 
   d="scan'208";a="222599773"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2023 18:20:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7xUgv4tfwl5n0WCp2kFP9Wb/usLcK+H5iakK8FjL16xHk4v/eJgHZxDTC3FOuNb6SVnO509/Hx/gQeQ5/TRIedL4GA3R7FC98O6kyfaGL4Md7019qAGuqXM+aQUKvIjhXFruS+qF/FItFRbBfBZjq7JuskHbIFhi68z7g0h+iODrz2VIW12I590wZtEWnQZoNNDIVo3QwmM93CsZ+igW0/3jmeQ7qhVvjnCfBS40sBIroJbKCwNnwBj1lr1m4IMI6xIxhDy5vzvdknWOYUZ5FB2ogTd4yXpE5edDNiv2S7m2q+saZgLeGsl1JO3am5ZmbCaueE8jJPXDNfxvA5mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql7qqdEI9A+7q+zESf8rpVVws6sMwdE1bMsH0B30+Os=;
 b=beOCjcIi6h5Pfokuuuv2hcpznr10uLAiOSKK9AoajjswZ7h2FKrCaunlk89gp8JL73yhTMBkEcBi65gtCPv/+fHNEaTikRcAHgWSsj+eR4MO3H/t8iqFBdy6MR5bHTBdHLg7v5jsaAmAqo4r2fKSowc+cn2jmAxv/rUuHiRLS8kMRzhzV97YqNuhwbd0a6I8THwTaCgGgCncZeWgoZ5iFC8DN8xzdK5MUUfPW8Hm42dgxqss+nHP+TioV2R9i8zfrANCG+ECAAWyHJHUuZFnv7z/dirCN0O2ZCR2lbUaXpWjb8BCG5hhtjTqrXP8E17HN2+tWGbYNIKOuJlhFF587A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql7qqdEI9A+7q+zESf8rpVVws6sMwdE1bMsH0B30+Os=;
 b=XomGv+ESLZB28Yfa2xzkHWWVs/hKaZf2GZ8ucIZQLHpkJ5DBS6AlWV79TnQRSBSB/6ppvyT/sdj1sxc5c5a3j5nO7KPo/EdQPWjojkdpl6LWzzGgKwu0Z1GRwnQR5TR7L4NijiaXRkZXrYRnUQwbgMaw4hSCA/ARNNquzV3D6Vw=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB7802.namprd04.prod.outlook.com (2603:10b6:510:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 10:20:07 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a%7]) with mapi id 15.20.6134.024; Mon, 27 Feb 2023
 10:20:07 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Thread-Topic: [PATCH v2] block: ublk: enable zoned storage support
Thread-Index: AQHZSItvYj2fUTtyhkmoNbHcKTvJAa7imQeA
Date:   Mon, 27 Feb 2023 10:20:07 +0000
Message-ID: <Y/yD1WMJ5zc7KkBz@x1-carbon>
References: <20230224200502.391570-1-nmi@metaspace.dk>
In-Reply-To: <20230224200502.391570-1-nmi@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB7802:EE_
x-ms-office365-filtering-correlation-id: 3d287230-1aca-4962-7ec5-08db18ac330c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IcAUBPYrE7l33Vt72idryjHo3aUxnUBLrFUL0zRM8EFaObS78/P79wAw4O8fFRwP8fSHgSv6nOYpgX9UpmWRs4B3RBRiff8k2sgyS1sDExzEcblAQVZHEpetk6OvJ1+HmLZAs/w2KLIkj2kdm0NNOcZVIbX62CzJuhhYaCu6t1NaU2t+mMv4MOYyYH/4CpnIUtp8LOrTLRa/Q3sqay7pzevYz+8Y97tfZAvMbtsNmqQ1HD/lksugvzfbebtahbyVuO5LpxOtD7Z0BRlesRa5m8JHvW/ORBntA//v8nWTisuFt/kBLwdcbdztOPqdZZzlKantXGR7SMT2+ypN5OlnhWuLbDIHo9UAMCoZUy2kWbdRoL+1DtXVwcCTlY/kuC/Duygy6vuA+691cFkqrKqdTeg/wK4eMY2I8Q3I2u0/PM9mhlM6MwLXkHMpLPIpsQmtZvSFfSLVqDgZmCwGRAx0Dww7T62asCPxUngxqGiD4uThUHzqEBucpvijEs/L5okAS9bEjY8AflBZ74OVbzgS009KNAMgiUiNkcK3EfOBgBKQjllrtBYrvpJ90UXn3YqF5Scz5LDLxLjy9FQtbUB3kFNWhOBSb9aanh9q8SnTAUvQdjWsKXq9RmaCoXk7ZxoKfyvGY0D9C0YYVot6Kjw7mLoYixWnltJLFvcWsX12Yaq8Qcwz2GMw0wJ1QFAUyErnTx0feDKIt1yfqcPLM03luHk2as19/14t0BTAGAQV8xU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(54906003)(316002)(86362001)(38100700002)(122000001)(82960400001)(6506007)(83380400001)(38070700005)(26005)(9686003)(186003)(33716001)(6512007)(5660300002)(8936002)(2906002)(71200400001)(966005)(6486002)(478600001)(6916009)(4326008)(41300700001)(91956017)(8676002)(66476007)(76116006)(64756008)(66946007)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/AERb3BxU1NnHfpRJEXaYC8MN0thn/nwh/mVT47ibMH/DH3S/tk+2p6O75?=
 =?iso-8859-1?Q?F+H+Ws9lbD0LohsYer/Q3zF7PEkZ/RZgRD25G/25NnJXKYc7EZ7/A7c6le?=
 =?iso-8859-1?Q?+2lGViXVSwjbuhndPvLwtXUy1AM4a7TGU3QQZH2Xygt6aDbyIKKwHicx/K?=
 =?iso-8859-1?Q?+3goQ5PEIMAJMkRQpk7CutMG99SdWue3U0GuCQj/jM0NMWm8jPDYozaYpU?=
 =?iso-8859-1?Q?bMvoIhlKvq5wcIyZLrY1F745NTi1WVaJyzi3W+e0Xmh7GTl1yCK494Kg4W?=
 =?iso-8859-1?Q?ZfejpW6qJurXKt1bxQkm734aQjTmLwoyNiR21/F9AxkrUFAizLPNDGxSci?=
 =?iso-8859-1?Q?5+5fjzdq4k686Q/J3AQu1+TTvgqkXrsC1NFmbl6SkMGImw3rxWgCSnjxJ3?=
 =?iso-8859-1?Q?9PCN2XuY+18G/cANdvQgD0AIFwMZqcYmE8UtHcEpkcfe1PttKY6w3t7GWT?=
 =?iso-8859-1?Q?wq591wfA1AVabiuzqR9USMJBGSKFd6fOv/g+sVQTMifL9JusxxwhVnVx4T?=
 =?iso-8859-1?Q?tzWR4FyGGlgR+nCWPLKtZoDX6f1Qnsh/ERdKYEE3evRcmPomKr7Ht1wtrp?=
 =?iso-8859-1?Q?FD0Aenw3/KNMCvLPr8AjE1WXLUo9BoS5ARrvIa6Saa8Y8srA//dycHi4Eo?=
 =?iso-8859-1?Q?GjyXXm45tM7AEQiiEmM91K4IXgnrXlLZba7aOB/952ggks8+qSZ8V8YdCX?=
 =?iso-8859-1?Q?FZjCpRqkTzYjJgoomK6aOctwHS6lieiW9E/hVfuQtu4K+9mCMMdo+Yjgfh?=
 =?iso-8859-1?Q?pxUN2EgObraYcdPsRvAgyvOPyiMLXLcJs4MKrtJJ+BDgeQLAdhOIuBlU2p?=
 =?iso-8859-1?Q?TFYOVLfxRv4lJsYbWUSZ6z5D+p3fr1l6DM4dGoQy7VOc32TIPtg4gXOKgS?=
 =?iso-8859-1?Q?eJfa1qUXSDNgxejglCGZSb3dZLaHt4ILL55MjDr1R9ba6iKnq73gcvJsfY?=
 =?iso-8859-1?Q?Bb8cUXNwdUKz92hhGRsZ2d/uKqscoy+xcYSCdCLSY+wmObPp9Qgclp48Hm?=
 =?iso-8859-1?Q?S4tx40JmwX6DrwCoBdXhXvBwIFQiQiJRV2ZgA1ZmfIWdmf3hWsRSSc3nXD?=
 =?iso-8859-1?Q?T2I5kkWD/2NVSLrQ1JUSY4sYwAo0wnHkgoIT6cyfop+Uka3qfu5PVoTpaI?=
 =?iso-8859-1?Q?QFuVt3WB0HrbpHC6s19twcbE0oZEEje8GU9TzDYEPlPQv9Aqim+OvG056l?=
 =?iso-8859-1?Q?BelHomB/k/+vb2ugXg0JPyaSHu+NfdkILhNLc3PZjN/xGiP+hoW5BBPcBt?=
 =?iso-8859-1?Q?otgRSJnFjXqQKWcCcZUm3yD+Sc5MyNZtyxmg5LhBR46Kv/SaiiCjLOGl5M?=
 =?iso-8859-1?Q?snQBihQWoF1hpra1HSqX1A9Nv8g8hQfOWk0B3tLPK3Ah/X8zkmOooEfytG?=
 =?iso-8859-1?Q?InNqQGgglvyCYLQyUbLwKsRr5dul+hmub5CfWBsNDYRi/B9E2g9/DVicpv?=
 =?iso-8859-1?Q?SeesjWl3j83MTse8JEX867lJhoaTWr+/AlierW+um3kv72XOzDJbU3zVGV?=
 =?iso-8859-1?Q?i0729xIHvwUU4Lorp0gGb9txPc7HXkVYQUohoaowH7nYYCgsvdGj5q05m3?=
 =?iso-8859-1?Q?gx6kY4bVvEVImERVr5+73QLwch6yGPX65Qaxzm/HpIG8Y2j0LVebVycpWg?=
 =?iso-8859-1?Q?jv1KAs73j3KdkAPnAjUFiLTQwbph8UEa3qtwLhwAywD+O3PkPA4jmFBg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3CD3D650C2B4914398CAC97ECCEFE37E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?ZQvoWGhmiBn2sKQ2KXOwt9zboFRrx1p48npSDwIuAXZ1GLVZ6ZboGWgfW3?=
 =?iso-8859-1?Q?ZTwgqgeszIIyANtfk5Rs0C/wbKdB5rLOtJoFqCbBppZS+l4v2bcMDpylAU?=
 =?iso-8859-1?Q?DXpcprA4s4UK2pFTWbQ2h/JEax/KNi+0a++ROr0jZ/iLr97ZGWE7Nbgz+9?=
 =?iso-8859-1?Q?GvZyl9cEvfy4LevNGSS/GJse/Cppw+V0VZng+8aHejcIG2OuQe1LaSeerI?=
 =?iso-8859-1?Q?yV4MUNORlsbgHXR1OHdnhzJuSa7q0rMLoZziQrxPiYqJVhfOjszHVlk30+?=
 =?iso-8859-1?Q?NRpdP0xN2bDu45CBK4SMeHsknfW24DhA6aWnhbZlCDWaITjifGNxArm3VJ?=
 =?iso-8859-1?Q?gzZq1n9Zs/bcZyXtjJQrtoq7+WjTjfXlHQnrLcqxn6BqjY/QonRvvKgMoP?=
 =?iso-8859-1?Q?vmtDhuZGTnjJUxQznH2dfXsVBczvCn1q6okv5nGo6Hf4tn/LMjur4sY3CM?=
 =?iso-8859-1?Q?XjvQUJTqgCMrIE6YRmMjwFTMd2B1+JFqnU4vwsHb0JlKURBELKPyoPRuzD?=
 =?iso-8859-1?Q?OAeKBVzLiOGsN2hi1rwkkWbDsGgOdxsqse5IhdmAu47BIc8SPph2+PiTvJ?=
 =?iso-8859-1?Q?4V00I4++F3x+RP8wJn5vsOD0rTOo+X6H6VY5cJG16wGiJssn6EAbNigh+2?=
 =?iso-8859-1?Q?vwkE9F5Ce2UY530yjsdBWztxTwioMRbf8yjoMIi9gL/GY0V6MVhSlYKyxS?=
 =?iso-8859-1?Q?7On4QZryzRY8uenvD286PnyzqW1ufGRXVm3uAwjcKXqGV8WJdZZHmutF+r?=
 =?iso-8859-1?Q?xMV0JmCK/brNdMMiVpwJWd/qrD/XQ96SjP9/+e5YVu00S1qRCtoPOnYD8b?=
 =?iso-8859-1?Q?h/4q6RQLHhnEqvrwlafAI1fvNVLFm7qX43nkiM3smZoOOxhjBlYy9+CeOW?=
 =?iso-8859-1?Q?mDT+fA17t7JqRrMyWLQ+LJ1+YbdtbqcyibRFal/ggkxktyPWMuoIIWfEh8?=
 =?iso-8859-1?Q?G9e9HuEHoHfsPD3nCJxC+qEuo6XfdexG?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d287230-1aca-4962-7ec5-08db18ac330c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 10:20:07.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LN2wQcrSSWAM/Z12pyGZJ2GBogFrjJ4TwMSXbu8QTC/BP4ajuitHr4Odqo18stmXYbHNKo+VVfYMWeEbRlvDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7802
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 09:05:01PM +0100, Andreas Hindborg wrote:
> Add zoned storage support to ublk: report_zones and operations:
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET
>=20
> This allows implementation of zoned storage devices in user space. An
> example user space implementation based on ubdsrv is available [1].
>=20
> [1] https://github.com/metaspace/ubdsrv/commit/14a2b708f74f70cfecb076d92e=
680dc718cc1f6d
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
> Changes since v1:
>  - Fixed conditional compilation bug
>  - Refactored to collect conditional code additions together
>  - Fixed style errors
>  - Zero stack allocated value used for zone report
>=20
> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302250222.XOrw9j6z-lkp@int=
el.com/
> v1: https://lore.kernel.org/linux-block/20230224125950.214779-1-nmi@metas=
pace.dk/
>=20
>  drivers/block/ublk_drv.c      | 150 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/ublk_cmd.h |  18 ++++
>  2 files changed, 162 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6368b56eacf1..37e516903867 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -20,6 +20,7 @@
>  #include <linux/major.h>
>  #include <linux/wait.h>
>  #include <linux/blkdev.h>
> +#include <linux/blkzoned.h>
>  #include <linux/init.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
> @@ -51,10 +52,12 @@
>  		| UBLK_F_URING_CMD_COMP_IN_TASK \
>  		| UBLK_F_NEED_GET_DATA \
>  		| UBLK_F_USER_RECOVERY \
> -		| UBLK_F_USER_RECOVERY_REISSUE)
> +		| UBLK_F_USER_RECOVERY_REISSUE \
> +		| UBLK_F_ZONED)
> =20
>  /* All UBLK_PARAM_TYPE_* should be included here */
> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DIS=
CARD)
> +#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DIS=
CARD \
> +			     | UBLK_PARAM_TYPE_ZONED)
> =20
>  struct ublk_rq_data {
>  	struct llist_node node;
> @@ -187,6 +190,98 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
> =20
>  static struct miscdevice ublk_misc;
> =20
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static void ublk_set_nr_zones(struct ublk_device *ub)
> +{
> +	const struct ublk_param_basic *p =3D &ub->params.basic;
> +
> +	if (ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors)
> +		ub->ub_disk->nr_zones =3D p->dev_sectors / p->chunk_sectors;
> +}
> +
> +static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
> +{
> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
> +
> +	if (ub->dev_info.flags & UBLK_F_ZONED) {
> +		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> +		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
> +	}
> +}
> +
> +static int ublk_revalidate_disk_zones(struct gendisk *disk)
> +{
> +	return blk_revalidate_disk_zones(disk, NULL);
> +}
> +
> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
> +			     unsigned int nr_zones, report_zones_cb cb,
> +			     void *data)
> +{
> +	struct ublk_device *ub;
> +	unsigned int zone_size;
> +	unsigned int first_zone;
> +	int ret =3D 0;
> +
> +	ub =3D disk->private_data;
> +
> +	if (!(ub->dev_info.flags & UBLK_F_ZONED))
> +		return -EINVAL;
> +
> +	zone_size =3D disk->queue->limits.chunk_sectors;
> +	first_zone =3D sector >> ilog2(zone_size);
> +	nr_zones =3D min(ub->ub_disk->nr_zones - first_zone, nr_zones);
> +
> +	for (unsigned int i =3D 0; i < nr_zones; i++) {
> +		struct request *req;
> +		blk_status_t status;
> +		struct blk_zone info =3D {0};
> +
> +		req =3D blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
> +
> +		if (IS_ERR(req)) {
> +			ret =3D PTR_ERR(req);
> +			goto out;
> +		}
> +
> +		req->__sector =3D sector;
> +
> +		ret =3D blk_rq_map_kern(disk->queue, req, &info, sizeof(info),
> +				      GFP_KERNEL);
> +
> +		if (ret)
> +			goto out;
> +
> +		status =3D blk_execute_rq(req, 0);
> +		ret =3D blk_status_to_errno(status);
> +		if (ret)
> +			goto out;
> +
> +		blk_mq_free_request(req);
> +
> +		ret =3D cb(&info, i, data);
> +		if (ret)
> +			goto out;
> +
> +		/* A zero length zone means don't ask for more zones */
> +		if (!info.len) {
> +			nr_zones =3D i;
> +			break;
> +		}
> +
> +		sector +=3D zone_size;
> +	}
> +	ret =3D nr_zones;
> +
> + out:
> +	return ret;
> +}
> +#else
> +void ublk_set_nr_zones(struct ublk_device *ub);
> +void ublk_dev_param_zoned_apply(struct ublk_device *ub);
> +int ublk_revalidate_disk_zones(struct gendisk *disk);

These are declarations, shouldn't they be dummy definitions instead?

e.g.
static int ublk_revalidate_disk_zones(struct gendisk *disk) { return -EOPNO=
TSUPP; };


It would be nice if they could be avoided altogether.

Looking how e.g. null-blk and btrfs has solved this:
https://github.com/torvalds/linux/blob/v6.2/fs/btrfs/Makefile#L39
https://github.com/torvalds/linux/blob/v6.2/drivers/block/null_blk/Makefile=
#L11

They have put the zoned stuff in a separate C file that is only compiled
when CONFIG_BLK_DEV_ZONED is set.

I'm not sure if a similar design is desired for ublk or not.

However, if a similar design pattern was used, it could probably avoid
some of these unpleasant dummy definitions altogether.


Kind regards,
Niklas

> +#endif
> +=
