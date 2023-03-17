Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934456BE5E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCQJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCQJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:49:51 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F7B57099;
        Fri, 17 Mar 2023 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679046587; x=1710582587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/sXbHFO3Sap4m+1NXsTYujkoLtGZOw3se6w1ylLJjSw=;
  b=DSbVUjCt2TQtgntmemjW5OEMVxO8Bmpjq8vXoHDAoEfWFErKjTrUdYPQ
   Xwhb49UC10O8i62GH+OQ9aitQ9IR+abcJ/FctITmGCIJgMfqNWtUVcOY5
   9EsG459YHAHWabSJ8D+rT5I+2ZAxQ1+cLzAh+k2xNReWlwYiGO0sWpqmw
   yBez/Xh0dXKxMBIiK+V7Eqvq/lm698piQdOdFG7bKuaoKdVNyluSx/5vB
   RuETcbH/ljdXR1WAMzsDYVtkjgtaKwxSRXU1DrL1AAKWXQwvlVN9qznzr
   vG/Eru4L4+jixPLDW+mxLjLvVOx4lmhbewxSkAK6d60R5FdWQIlhXVfVN
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,268,1673884800"; 
   d="scan'208";a="225649477"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 17:49:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njHuGJVps22MnIvQqD6zRQCq0HcyAd99xBLC8NzNSbJM1K1ebmMwYbZcExGfF8MyVyXjG0Z5zc84UlIbvDBRfMhPry5Nx9sdYQnSRdZc1bv5pYLtrMYvo0GQ5U1yTlHDxC4zY+mi8o7bTG+aFbqCEwI+zzX1W+76FJ8asu8K5TaoRIPwmyvWfP0fDCi+e9NaX2rvK/E3FTLYONaOkCndRvCB8ZjiQXMu1/NnNtIDMeSe81tlNBRFSlsLsbWEB/r7DpdDMSivCVgTmx4HmqLNVBI65VekW43QmcKhFmpS6x7fA8ArOTBSZlSBZMmAQPXU8xBb02lRlzp+X3YXajEa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpn+5vH95jU7dl09HR1vz7a+1m7D0dESP5tNMPal/Hk=;
 b=SvZYCOg423sWL4g9c1gQa1xFvagtVVvtGowdoor4Dp6hBuNhg+aKI8Wf4mInG9x9nPTEEHjOpQQ3Cs2lMr9SYHiYobnEJ4ef75uYyd4TQF1RCpdwvi+0iVO7HFmCI9qa1WZ/O32iFmGb2BSble3h58hYCkTu9AaCua1KZy5eGlszAuSqDeGQPEn3+KhFSkIlnZsEl4wwXTq0u49LkeK/o7k829R2hLO6IWeXt1OvflEoCbzAPHykOf8l8WFL/ZZEPCF3+E0zBgU/+BPQTxf4HKVItNG2n95aHBWKV5ROHbfiDwSJfnHonotIj59IQKJmpRXm94AG14GLyZKU8DkKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpn+5vH95jU7dl09HR1vz7a+1m7D0dESP5tNMPal/Hk=;
 b=f7vlSVolV2cswIIhdTK+cN2BU+A/gMQ5X1BkaJvDep6yGrw/Yc44bmvuOA5nut1OOZTzswrj+zOV7RVU9cUQo85uPgtd3Dynm2e3Wmen6Mb64oujb+PoKc3ws5uNyHlAi0zenSjmINh51KRLIxGANOjbu8gLS8lZvc49Fw3PrQU=
Received: from BYAPR04MB6261.namprd04.prod.outlook.com (2603:10b6:a03:f0::31)
 by DM8PR04MB8008.namprd04.prod.outlook.com (2603:10b6:8:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.35; Fri, 17 Mar 2023 09:49:41 +0000
Received: from BYAPR04MB6261.namprd04.prod.outlook.com
 ([fe80::2f6c:1333:cf0d:33ba]) by BYAPR04MB6261.namprd04.prod.outlook.com
 ([fe80::2f6c:1333:cf0d:33ba%5]) with mapi id 15.20.6178.024; Fri, 17 Mar 2023
 09:49:41 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] block: ublk: enable zoned storage support
Thread-Topic: [PATCH v3] block: ublk: enable zoned storage support
Thread-Index: AQHZWLXLJvMUWIcVXUW/Cc7lkitPOg==
Date:   Fri, 17 Mar 2023 09:49:41 +0000
Message-ID: <ZBQ3sgoN8oX5HXOJ@x1-carbon>
References: <20230316145539.300523-1-nmi@metaspace.dk>
In-Reply-To: <20230316145539.300523-1-nmi@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB6261:EE_|DM8PR04MB8008:EE_
x-ms-office365-filtering-correlation-id: fd6951c2-0bb4-4c42-1a40-08db26ccee06
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iiuw9pcKENRzJy10Z8G5WvCoTGQfFPK5kz427LZuCsKT2sCpq/Lxh0mOhnEUGSkP3xdOioZv50EdPIhTdTDmYxVg0KTHnKzphg3nrffn+8Qcp95NOaCeCNtxW5dQkC+j7sdoYn4K71fWYxBTe6sE8L1DwHlyesv0HFIvzIyOtYdDvKxPK/XMff0841hDX4cSE2gArCwggda0WSq5pjChBWX2Bo69RQp9iXshZmohvzgiyDlnC1LOZaPZ5i8DiFwAIZ9nh6cQIGI9waBI8ZvWwqe8wx5hzuDKPnv/V8vNv4av8cwvfVwl4cHtSONgIQsh0+8NwWazYYa+bJ7OtUmz5tzyg3b7tttpgU11Y3NgZVsPfoeCWYoAyyRSzPWNeqqkLK8SjlQzEs5JzgQ1A/nf/RQK64BhpdUOGoAiyA44u9vhZ8sVpUMyAKphtZ1TlF7OZOu4rVvGOfJwwek/Wj6mIg/Q9dZqmnA20f/wWnhaNc+Ctdv32DxPSbAYjF2MXj3/vAUGFmYQen0NsXimjgSJhjBINwQyfuhIYWTxIQEP7iTe8WfJSGzRt4koTbPeInREqpVl7ZoiY8pUnItdqqUCx6WsRlLHf7eAunvi49wVnqSrW13PbDn7pGC7Zih+RrH7RfhRUTYp/69VDvJBzZZMn9HKiL6KCinh1FKSjlv+QlAnkCDNVEYEYNIt5yDVnJ4+WfSJrsWdrp0oc2+saWljSzqBPigQKO7uz0+r1gMRD38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB6261.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199018)(86362001)(38070700005)(33716001)(71200400001)(966005)(54906003)(478600001)(6486002)(41300700001)(30864003)(5660300002)(26005)(8936002)(66946007)(316002)(66476007)(4326008)(66556008)(8676002)(6916009)(66446008)(64756008)(2906002)(91956017)(76116006)(38100700002)(122000001)(82960400001)(6512007)(6506007)(186003)(83380400001)(9686003)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xw27U+gz+RRpgfWeTzw4HbbwCFWtHsZKfN5ZNTcTVRo1CG9fQlzxwgoZpO?=
 =?iso-8859-1?Q?bjTjuU5kFv6jrtRw8mzApFFlSEsWJ476AWtg5Lg3Zaw+32n7DdLb+oofvH?=
 =?iso-8859-1?Q?wFIY1aTuJeL36/auu79RflFtg1eXEr2158C8nbjZDbnf/s/XEjldTbgTKx?=
 =?iso-8859-1?Q?c3td+919tp9sAODZ4kzzkiDmUmGsy59EwxQuoesq+4sj+il50BB9H6IpF4?=
 =?iso-8859-1?Q?7nyy5f7M9IVQWko1LS4hK/FN3LFCXHx5APcYqHgEunM2pnerhMD9ryZnCK?=
 =?iso-8859-1?Q?L8GXFhC0ZWScQsx0jcoI09ZhV2vLEwpLgQi7g+ZXDgZJNVrz4lTzbmWqdr?=
 =?iso-8859-1?Q?QCk3fopZom8fg2lR5qBnKrAq8S2dqgmgBuiDqkzDRGi69K6xAml4znj/Pv?=
 =?iso-8859-1?Q?HTgRlvIIBJt48kQQE1S31aFvLCSSO4RcfFQz4mGTlnsql74Wje5x6ExR/O?=
 =?iso-8859-1?Q?F0c4stw6pmqJEocMJP8nODgfDiUsI22t1QmD344I+xTLS4VVF4nw0tSqt1?=
 =?iso-8859-1?Q?OHCT0opmBEws9VZ9VvLtA1Ejwv4o36qOtQMigZ2LKcjaV/7E2s7LyeDjAO?=
 =?iso-8859-1?Q?JXwQS3AfwMNpGAz92WNxUjgibJ2Ea/JwDAROq0ot1plxSRMwM7p87V8NLY?=
 =?iso-8859-1?Q?iDrvqaHfJ2OlJlTWZRfAL5oKlraYKOpUojtu4Z8DUhq9xk2/2aCHGfTi0v?=
 =?iso-8859-1?Q?ywjvDMvZJrBWt/Luki9KhbeRAjEkv3npja87duhY79B64ag53JYLe4wmhU?=
 =?iso-8859-1?Q?IG6GjDwmUoAKCUT5wqLhATWcesz2Eo2N+dFyCLvAXpFpwKixs5zbKs7IaM?=
 =?iso-8859-1?Q?jX05s3cP4wiWmoZNxVk8blBqbv4FgbQLxh7IXSJ01jurGdn5SZdB3bADZM?=
 =?iso-8859-1?Q?t2dqU/xIh10hq5iOU04wXGtqWz1Xyt4kbUF4z+HxSEXwxsF2pAARTg1bKZ?=
 =?iso-8859-1?Q?fmWoZL+koKs+gFbfmozs+qGFa48Yy6//6biqgLf17tR0tB3ve6WAg4qaD0?=
 =?iso-8859-1?Q?aZMxCnl5YZ7anz8tlwKOGPCGZV6dNmbhTGmDJJb/slEqs3sMMMpJMB5Oj4?=
 =?iso-8859-1?Q?CjcNXJPhzWzpsWY2xIQkW/stZgUAOriOVTJywr4NBFtLjmcbilDyXgGA4r?=
 =?iso-8859-1?Q?Et2cZiQD4akMKOhQa1R7JJJP86XhyO5sZn9Lxf/m0fVH+SGFlH7Y6fSQZW?=
 =?iso-8859-1?Q?eBXmtYt1CI7ZdC/7RCGh5ugYWq+lz1ursf7BUvNS6kojee21AkB08edUm7?=
 =?iso-8859-1?Q?pg/sQ5QhVWp5Nb8BcYKWXkjEVA65C/5n34NDQGWUweIIlmZgPjG9ffKuGv?=
 =?iso-8859-1?Q?B2wG0vppz+8gfXIWAKPMEfA3cbAdJ744ZvPEWBrSbPtvj+GV8M5Z78qeTe?=
 =?iso-8859-1?Q?4NjUP+nFWtLNfrVzPXau1W5Lom6TKEwT6QvE4+a3N6OYWBEaaq6fV8SOIi?=
 =?iso-8859-1?Q?v2kKanzCrZyTJOS5zzabpBbXp/5alNDAxusXhD5fLK2G3BsAOBKA8Rityj?=
 =?iso-8859-1?Q?D3VFbx3m7rGnKY/gtR2XhgdNC6BAEzXL4mRfol6kQVZ2tAhbjMRbir+tpm?=
 =?iso-8859-1?Q?Hi56UUsuvYM7sHZZoneT6ZPrX1X5cESV0Jb/q653IXUWLFy7wIxPbToMGQ?=
 =?iso-8859-1?Q?sw/oIRcCv1wEyMruRTe+pUt67WbL0iWXlUr8BRriT0eEjXHtgYn/PubQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F4C57D12647CF84FA98F3D63EF3ADC37@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nGTqZxVpu/RirtP9WPMM3DcfZUuS3Cb7eviA12aoTgVQMHSlB49wxRsch0KAjfyOzP/mt+WB1m4NKtCvBvX7gLLgUTD5DN5cVb4qdiDLrBwAJ6ylDsqb+RllmEhmJj/z1n1ofdpISF/Z5pfFfPRQpHhfMCc1Yq7W/VNEZ/xlWVKA4P/XfYQ0wLxr2Z4pKf39F5X7SOI8xsbHaS0uAy0gZw6ly+/29aophLNWvRoXGFSp70m4wMfUFyeHukEsvTU2/jndYHLwc+eP87U1UIXZkpFfiEnSnMJiwfL16k4vXYxkj5H8+GNDTYBlHHIK1nra+f3bYJbFT+hL7/nFkNUPZL+wVSnoQmPMv7Y0jlb3TIekuPCVAP6kobkheMXOEVA8NI0ILZQ0PZZd76yDBLaWffn9b4a/4CSt9RdHjWs9S09rH3B/ruWanHganUA9z4eo9IqPgggfzzvyD3whi3hS2yeom0Fo7V9Ju1WdRsRcowWgfr8xI2KQTtZs9Jzcbi0C/QQrvxhN27AnZa7x5g2ryTIIFuWK9mlGl1fp46Q4JnIU5XxuvyWXMbcJhMD1eWrubsA+PwfcsIQKlUOD4+skBjRoMvsTJ67dZWy6YsQ4GYDVgL4aRXyMsg5ibcwjvPHjdHsVs3wwYW3yHKJLPrBQ6mpmRirkL1USaRdKfs3p4tOqSCP7Zt4H4dRh8FMWSmRAQnTFOdMxcu+asmU0DM9vILaTZoNDI5u5UY3RoQggdPt0O0VQaXqt/YOSfMVFbHYWp5D/jid4OeVsNiwlLH5os1LaTiHQVNQCk+uea7r9KkhK7SXCn+QaOgeUuo61D7CVVXMDGU0s6svte2msrnjiJM/Lhea/mnVSmXk0FafU0JuMyCfSqiXCyREMcFJp9NaVAj7/4fkZ2Q/lzwHaOhaiQQEMxIToA+O95P0i6ysluNo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB6261.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6951c2-0bb4-4c42-1a40-08db26ccee06
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 09:49:41.1149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNaC/SQsDfUYUpysWTzMt7A6DSn0gH5g5Syn7HK4NYPUBupUhY+kWM+sOWqV1ynMMN1Jj65HQ7pq3WUAmWM6ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8008
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 03:55:38PM +0100, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>

Hello Andreas,


I think that this patch is starting to look very nice!


>=20
> Add zoned storage support to ublk: report_zones and operations:
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET
>=20
> This allows implementation of zoned storage devices in user space. An
> example user space implementation based on ubdsrv is available [1].
>=20
> [1] https://github.com/metaspace/ubdsrv/commit/2c60b9ffdfb7cb44c5cce0272b=
b52229ea6c95d4
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>=20
> Changes since v2:
>  - Allow reporting of multiple zones in a single request
>  - Move zoned functions to separate translation unit
>  - Do not overload REQ_OP_DRV_IN for zone report
>  - Reserve space in ublk_param_zoned for future parameters
>  - Do not overload (struct request).__sector and .__data_len
>  - Remove unnecessary conditional compilation=20
>  - Remove goto statements in ublk_report_zones
>=20
> v1: https://lore.kernel.org/linux-block/20230224125950.214779-1-nmi@metas=
pace.dk/
> v2: https://lore.kernel.org/all/20230224200502.391570-1-nmi@metaspace.dk/
>=20
>  drivers/block/Kconfig          |   4 +
>  drivers/block/Makefile         |   1 +
>  drivers/block/ublk_drv-zoned.c | 142 +++++++++++++++++++++++++++++++++
>  drivers/block/ublk_drv.c       | 113 ++++++++++++++------------
>  drivers/block/ublk_drv.h       |  69 ++++++++++++++++
>  include/uapi/linux/ublk_cmd.h  |  37 +++++++--
>  6 files changed, 308 insertions(+), 58 deletions(-)
>  create mode 100644 drivers/block/ublk_drv-zoned.c
>  create mode 100644 drivers/block/ublk_drv.h
>=20
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index f79f20430ef7..311e401eece5 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -385,6 +385,10 @@ config BLK_DEV_UBLK
>  	  can handle batch more effectively, but task_work_add() isn't exported
>  	  for module, so ublk has to be built to kernel.
> =20
> +config BLK_DEV_UBLK_ZONED
> +	def_bool y
> +	depends on BLK_DEV_UBLK && BLK_DEV_ZONED
> +
>  source "drivers/block/rnbd/Kconfig"
> =20
>  endif # BLK_DEV
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index 101612cba303..0de9379ba9df 100644
> --- a/drivers/block/Makefile
> +++ b/drivers/block/Makefile
> @@ -38,5 +38,6 @@ obj-$(CONFIG_BLK_DEV_RNBD)	+=3D rnbd/
>  obj-$(CONFIG_BLK_DEV_NULL_BLK)	+=3D null_blk/
> =20
>  obj-$(CONFIG_BLK_DEV_UBLK)			+=3D ublk_drv.o
> +obj-$(CONFIG_BLK_DEV_UBLK_ZONED)		+=3D ublk_drv-zoned.o
> =20
>  swim_mod-y	:=3D swim.o swim_asm.o
> diff --git a/drivers/block/ublk_drv-zoned.c b/drivers/block/ublk_drv-zone=
d.c
> new file mode 100644
> index 000000000000..fbcbe1bbf653
> --- /dev/null
> +++ b/drivers/block/ublk_drv-zoned.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2023 Andreas Hindborg <a.hindborg@samsung.com>
> + */
> +#include <linux/blkzoned.h>
> +#include <linux/ublk_cmd.h>
> +#include "ublk_drv.h"
> +
> +void ublk_set_nr_zones(struct ublk_device *ub)
> +{
> +	const struct ublk_param_basic *p =3D &ub->params.basic;
> +
> +	if (ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors)
> +		ub->ub_disk->nr_zones =3D p->dev_sectors / p->chunk_sectors;
> +}
> +
> +void ublk_dev_param_zoned_apply(struct ublk_device *ub)
> +{
> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
> +
> +	if (ub->dev_info.flags & UBLK_F_ZONED) {
> +		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> +		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
> +	}
> +}
> +
> +int ublk_revalidate_disk_zones(struct gendisk *disk)
> +{
> +	return blk_revalidate_disk_zones(disk, NULL);
> +}
> +
> +// Based on virtblk_alloc_report_buffer

Change from C++ style to C style comment.

> +static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
> +				      unsigned int nr_zones,
> +				      unsigned int zone_sectors, size_t *buflen)
> +{
> +	struct request_queue *q =3D ublk->ub_disk->queue;
> +	size_t bufsize;
> +	void *buf;
> +
> +	nr_zones =3D min_t(unsigned int, nr_zones,
> +			 get_capacity(ublk->ub_disk) >> ilog2(zone_sectors));
> +
> +	bufsize =3D nr_zones * sizeof(struct blk_zone);
> +	bufsize =3D
> +		min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
> +	bufsize =3D min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT)=
;
> +
> +	while (bufsize >=3D sizeof(struct blk_zone)) {
> +		buf =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> +		if (buf) {
> +			*buflen =3D bufsize;
> +			return buf;
> +		}
> +		bufsize >>=3D 1;
> +	}
> +
> +	bufsize =3D 0;
> +	return NULL;
> +}
> +
> +int ublk_report_zones(struct gendisk *disk, sector_t sector,
> +		      unsigned int nr_zones, report_zones_cb cb, void *data)
> +{
> +	unsigned int done_zones =3D 0;
> +	struct ublk_device *ub =3D disk->private_data;
> +	unsigned int zone_size_sectors =3D disk->queue->limits.chunk_sectors;
> +	unsigned int first_zone =3D sector >> ilog2(zone_size_sectors);
> +	struct blk_zone *buffer;
> +	size_t buffer_length;
> +	unsigned int max_zones_per_request;

Nit: I would sort the variables differently.

Perhaps:
> +	struct ublk_device *ub =3D disk->private_data;
> +	unsigned int zone_size_sectors =3D disk->queue->limits.chunk_sectors;
> +	unsigned int first_zone =3D sector >> ilog2(zone_size_sectors);
> +	unsigned int done_zones =3D 0;
> +	unsigned int max_zones_per_request;
> +	struct blk_zone *buffer;
> +	size_t buffer_length;


> +
> +	if (!(ub->dev_info.flags & UBLK_F_ZONED))
> +		return -EOPNOTSUPP;
> +
> +	nr_zones =3D min_t(unsigned int, ub->ub_disk->nr_zones - first_zone,
> +			 nr_zones);
> +
> +	buffer =3D ublk_alloc_report_buffer(ub, nr_zones, zone_size_sectors,
> +					  &buffer_length);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	max_zones_per_request =3D buffer_length / sizeof(struct blk_zone);
> +
> +	while (done_zones < nr_zones) {
> +		unsigned int remaining_zones =3D nr_zones - done_zones;
> +		unsigned int zones_in_request =3D min_t(
> +			unsigned int, remaining_zones, max_zones_per_request);
> +		int err =3D 0;
> +		struct request *req;
> +		struct ublk_rq_data *pdu;
> +		blk_status_t status;
> +
> +		memset(buffer, 0, buffer_length);
> +
> +		req =3D blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
> +		if (IS_ERR(req))
> +			return PTR_ERR(req);
> +
> +		pdu =3D blk_mq_rq_to_pdu(req);
> +		pdu->operation =3D UBLK_IO_OP_REPORT_ZONES;
> +		pdu->sector =3D sector;
> +		pdu->nr_sectors =3D remaining_zones * zone_size_sectors;
> +
> +		err =3D blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
> +					GFP_KERNEL);
> +		if (err) {
> +			blk_mq_free_request(req);
> +			kvfree(buffer);
> +			return err;
> +		}
> +
> +		status =3D blk_execute_rq(req, 0);
> +		err =3D blk_status_to_errno(status);
> +		blk_mq_free_request(req);
> +		if (err) {
> +			kvfree(buffer);
> +			return err;
> +		}
> +
> +		for (unsigned int i =3D 0; i < zones_in_request; i++) {
> +			struct blk_zone *zone =3D buffer + i;
> +
> +			err =3D cb(zone, i, data);
> +			if (err)
> +				return err;
> +
> +			done_zones++;
> +			sector +=3D zone_size_sectors;
> +
> +			/* A zero length zone means don't ask for more zones */
> +			if (!zone->len) {
> +				kvfree(buffer);
> +				return done_zones;
> +			}
> +		}
> +	}
> +
> +	kvfree(buffer);
> +	return done_zones;
> +}
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index d1d1c8d606c8..69a3e7dedfc0 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -44,6 +44,7 @@
>  #include <linux/task_work.h>
>  #include <linux/namei.h>
>  #include <uapi/linux/ublk_cmd.h>
> +#include "ublk_drv.h"
> =20
>  #define UBLK_MINORS		(1U << MINORBITS)
> =20
> @@ -53,16 +54,13 @@
>  		| UBLK_F_NEED_GET_DATA \
>  		| UBLK_F_USER_RECOVERY \
>  		| UBLK_F_USER_RECOVERY_REISSUE \
> -		| UBLK_F_UNPRIVILEGED_DEV)
> +		| UBLK_F_UNPRIVILEGED_DEV \
> +		| UBLK_F_ZONED)
> =20
>  /* All UBLK_PARAM_TYPE_* should be included here */
> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
> -		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
> -
> -struct ublk_rq_data {
> -	struct llist_node node;
> -	struct callback_head work;
> -};
> +#define UBLK_PARAM_TYPE_ALL                                \
> +	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> +	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
> =20
>  struct ublk_uring_cmd_pdu {
>  	struct ublk_queue *ubq;
> @@ -135,45 +133,6 @@ struct ublk_queue {
> =20
>  #define UBLK_DAEMON_MONITOR_PERIOD	(5 * HZ)
> =20
> -struct ublk_device {
> -	struct gendisk		*ub_disk;
> -
> -	char	*__queues;
> -
> -	unsigned int	queue_size;
> -	struct ublksrv_ctrl_dev_info	dev_info;
> -
> -	struct blk_mq_tag_set	tag_set;
> -
> -	struct cdev		cdev;
> -	struct device		cdev_dev;
> -
> -#define UB_STATE_OPEN		0
> -#define UB_STATE_USED		1
> -#define UB_STATE_DELETED	2
> -	unsigned long		state;
> -	int			ub_number;
> -
> -	struct mutex		mutex;
> -
> -	spinlock_t		mm_lock;
> -	struct mm_struct	*mm;
> -
> -	struct ublk_params	params;
> -
> -	struct completion	completion;
> -	unsigned int		nr_queues_ready;
> -	unsigned int		nr_privileged_daemon;
> -
> -	/*
> -	 * Our ubq->daemon may be killed without any notification, so
> -	 * monitor each queue's daemon periodically
> -	 */
> -	struct delayed_work	monitor_work;
> -	struct work_struct	quiesce_work;
> -	struct work_struct	stop_work;
> -};
> -

I think that this change should go into a patch 1/2 that is simply
create a driver internal header file and move appropriate code.


>  /* header of ublk_params */
>  struct ublk_params_header {
>  	__u32	len;
> @@ -225,6 +184,9 @@ static void ublk_dev_param_basic_apply(struct ublk_de=
vice *ub)
>  		set_disk_ro(ub->ub_disk, true);
> =20
>  	set_capacity(ub->ub_disk, p->dev_sectors);
> +
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		ublk_set_nr_zones(ub);
>  }
> =20
>  static void ublk_dev_param_discard_apply(struct ublk_device *ub)
> @@ -285,6 +247,9 @@ static int ublk_apply_params(struct ublk_device *ub)
>  	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
>  		ublk_dev_param_discard_apply(ub);
> =20
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && (ub->params.types & UBLK_PARAM_=
TYPE_ZONED))
> +		ublk_dev_param_zoned_apply(ub);
> +
>  	return 0;
>  }
> =20
> @@ -420,9 +385,10 @@ static int ublk_open(struct block_device *bdev, fmod=
e_t mode)
>  }
> =20
>  static const struct block_device_operations ub_fops =3D {
> -	.owner =3D	THIS_MODULE,
> -	.open =3D		ublk_open,
> -	.free_disk =3D	ublk_free_disk,
> +	.owner =3D THIS_MODULE,
> +	.open =3D ublk_open,
> +	.free_disk =3D ublk_free_disk,
> +	.report_zones =3D ublk_report_zones,
>  };
> =20
>  #define UBLK_MAX_PIN_PAGES	32
> @@ -558,7 +524,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq=
,
>  {
>  	const unsigned int rq_bytes =3D blk_rq_bytes(req);
> =20
> -	if (req_op(req) =3D=3D REQ_OP_READ && ublk_rq_has_data(req)) {
> +	if ((req_op(req) =3D=3D REQ_OP_READ || req_op(req) =3D=3D REQ_OP_DRV_IN=
) && ublk_rq_has_data(req)) {
>  		struct ublk_map_data data =3D {
>  			.ubq	=3D	ubq,
>  			.rq	=3D	req,
> @@ -607,6 +573,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue =
*ubq, struct request *req)
>  {
>  	struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
>  	struct ublk_io *io =3D &ubq->ios[req->tag];
> +	struct ublk_rq_data *pdu =3D blk_mq_rq_to_pdu(req);
>  	u32 ublk_op;
> =20
>  	switch (req_op(req)) {
> @@ -625,6 +592,35 @@ static blk_status_t ublk_setup_iod(struct ublk_queue=
 *ubq, struct request *req)
>  	case REQ_OP_WRITE_ZEROES:
>  		ublk_op =3D UBLK_IO_OP_WRITE_ZEROES;
>  		break;
> +	case REQ_OP_ZONE_OPEN:
> +		ublk_op =3D UBLK_IO_OP_ZONE_OPEN;
> +		break;
> +	case REQ_OP_ZONE_CLOSE:
> +		ublk_op =3D UBLK_IO_OP_ZONE_CLOSE;
> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		ublk_op =3D UBLK_IO_OP_ZONE_FINISH;
> +		break;
> +	case REQ_OP_ZONE_RESET:
> +		ublk_op =3D UBLK_IO_OP_ZONE_RESET;
> +		break;
> +	case REQ_OP_DRV_IN:
> +	case REQ_OP_DRV_OUT:
> +		ublk_op =3D pdu->operation;
> +		switch (ublk_op) {
> +		case UBLK_IO_OP_REPORT_ZONES:
> +			iod->op_flags =3D ublk_op | ublk_req_build_flags(req);
> +			iod->nr_sectors =3D pdu->nr_sectors;
> +			iod->start_sector =3D pdu->sector;
> +			iod->addr =3D io->addr;
> +			return BLK_STS_OK;
> +		default:
> +			return BLK_STS_IOERR;
> +		}
> +	case REQ_OP_ZONE_APPEND:
> +	case REQ_OP_ZONE_RESET_ALL:
> +		/* We do not support zone append or reset_all yet */
> +		fallthrough;
>  	default:
>  		return BLK_STS_IOERR;
>  	}
> @@ -671,7 +667,8 @@ static void ublk_complete_rq(struct request *req)
>  	 *
>  	 * Both the two needn't unmap.
>  	 */
> -	if (req_op(req) !=3D REQ_OP_READ && req_op(req) !=3D REQ_OP_WRITE) {
> +	if (req_op(req) !=3D REQ_OP_READ && req_op(req) !=3D REQ_OP_WRITE &&
> +	    req_op(req) !=3D REQ_OP_DRV_IN) {
>  		blk_mq_end_request(req, BLK_STS_OK);
>  		return;
>  	}
> @@ -1601,6 +1598,15 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub, struct io_uring_cmd *cmd)
>  	if (ub->nr_privileged_daemon !=3D ub->nr_queues_ready)
>  		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> =20
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    ub->dev_info.flags & UBLK_F_ZONED) {
> +		disk_set_zoned(disk, BLK_ZONED_HM);
> +		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_W=
RITE);
> +		ret =3D ublk_revalidate_disk_zones(disk);
> +		if (ret)
> +			goto out_put_disk;
> +	}
> +
>  	get_device(&ub->cdev_dev);
>  	ret =3D add_disk(disk);
>  	if (ret) {
> @@ -1746,6 +1752,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *c=
md)
>  	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
>  		ub->dev_info.flags |=3D UBLK_F_URING_CMD_COMP_IN_TASK;
> =20
> +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		ub->dev_info.flags &=3D ~UBLK_F_ZONED;
> +
>  	/* We are not ready to support zero copy */
>  	ub->dev_info.flags &=3D ~UBLK_F_SUPPORT_ZERO_COPY;
> =20
> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
> new file mode 100644
> index 000000000000..7b21235d7673
> --- /dev/null
> +++ b/drivers/block/ublk_drv.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _UBLK_DRV_H
> +#define _UBLK_DRV_H
> +
> +#include <uapi/linux/ublk_cmd.h>
> +#include <linux/blk-mq.h>
> +#include <linux/cdev.h>
> +
> +struct ublk_device {
> +	struct gendisk *ub_disk;
> +
> +	char *__queues;
> +
> +	unsigned int queue_size;
> +	struct ublksrv_ctrl_dev_info dev_info;
> +
> +	struct blk_mq_tag_set tag_set;
> +
> +	struct cdev cdev;
> +	struct device cdev_dev;
> +
> +#define UB_STATE_OPEN 0
> +#define UB_STATE_USED 1
> +#define UB_STATE_DELETED 2
> +	unsigned long state;
> +	int ub_number;
> +
> +	struct mutex mutex;
> +
> +	spinlock_t mm_lock;
> +	struct mm_struct *mm;
> +
> +	struct ublk_params params;
> +
> +	struct completion completion;
> +	unsigned int nr_queues_ready;
> +	unsigned int nr_privileged_daemon;
> +
> +	/*
> +	 * Our ubq->daemon may be killed without any notification, so
> +	 * monitor each queue's daemon periodically
> +	 */
> +	struct delayed_work monitor_work;
> +	struct work_struct quiesce_work;
> +	struct work_struct stop_work;
> +};
> +
> +struct ublk_rq_data {
> +	struct llist_node node;
> +	struct callback_head work;
> +	enum ublk_op operation;
> +	__u64 sector;
> +	__u32 nr_sectors;
> +};
> +
> +void ublk_set_nr_zones(struct ublk_device *ub);
> +void ublk_dev_param_zoned_apply(struct ublk_device *ub);
> +int ublk_revalidate_disk_zones(struct gendisk *disk);
> +
> +#ifdef CONFIG_BLK_DEV_UBLK_ZONED
> +int ublk_report_zones(struct gendisk *disk, sector_t sector,
> +		      unsigned int nr_zones, report_zones_cb cb,
> +		      void *data);
> +#else
> +#define ublk_report_zones NULL
> +#endif
> +
> +#endif
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index f6238ccc7800..a9c3e71b0756 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -102,6 +102,11 @@
>   */
>  #define UBLK_F_UNPRIVILEGED_DEV	(1UL << 5)
> =20
> +/*
> + * Enable zoned device support
> + */
> +#define UBLK_F_ZONED (1ULL << 6)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD	0
>  #define UBLK_S_DEV_LIVE	1
> @@ -155,12 +160,24 @@ struct ublksrv_ctrl_dev_info {
>  	__u64   reserved2;
>  };
> =20
> -#define		UBLK_IO_OP_READ		0
> -#define		UBLK_IO_OP_WRITE		1
> -#define		UBLK_IO_OP_FLUSH		2
> -#define		UBLK_IO_OP_DISCARD	3
> -#define		UBLK_IO_OP_WRITE_SAME	4
> -#define		UBLK_IO_OP_WRITE_ZEROES	5
> +enum ublk_op {
> +	UBLK_IO_OP_READ =3D 0,
> +	UBLK_IO_OP_WRITE =3D 1,
> +	UBLK_IO_OP_FLUSH =3D 2,
> +	UBLK_IO_OP_DISCARD =3D 3,
> +	UBLK_IO_OP_WRITE_SAME =3D 4,
> +	UBLK_IO_OP_WRITE_ZEROES =3D 5,
> +	UBLK_IO_OP_ZONE_OPEN =3D 10,
> +	UBLK_IO_OP_ZONE_CLOSE =3D 11,
> +	UBLK_IO_OP_ZONE_FINISH =3D 12,
> +	UBLK_IO_OP_ZONE_APPEND =3D 13,
> +	UBLK_IO_OP_ZONE_RESET =3D 15,
> +	__UBLK_IO_OP_DRV_IN_START =3D 32,
> +	UBLK_IO_OP_REPORT_ZONES =3D __UBLK_IO_OP_DRV_IN_START,
> +	__UBLK_IO_OP_DRV_IN_END =3D 96,
> +	__UBLK_IO_OP_DRV_OUT_START =3D __UBLK_IO_OP_DRV_IN_END,
> +	__UBLK_IO_OP_DRV_OUT_END =3D 160,
> +};

This also looks like a separate change.
I would put it into a patch 2/3.


Have a nice weekend!


Kind regards,
Niklas

> =20
>  #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
>  #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
> @@ -257,6 +274,12 @@ struct ublk_param_devt {
>  	__u32   disk_minor;
>  };
> =20
> +struct ublk_param_zoned {
> +	__u32	max_open_zones;
> +	__u32	max_active_zones;
> +	__u8	reserved[24];
> +};
> +
>  struct ublk_params {
>  	/*
>  	 * Total length of parameters, userspace has to set 'len' for both
> @@ -268,11 +291,13 @@ struct ublk_params {
>  #define UBLK_PARAM_TYPE_BASIC           (1 << 0)
>  #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
>  #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
> +#define UBLK_PARAM_TYPE_ZONED           (1 << 3)
>  	__u32	types;			/* types of parameter included */
> =20
>  	struct ublk_param_basic		basic;
>  	struct ublk_param_discard	discard;
>  	struct ublk_param_devt		devt;
> +	struct ublk_param_zoned	zoned;
>  };
> =20
>  #endif
>=20
> base-commit: eeac8ede17557680855031c6f305ece2378af326
> --=20
> 2.39.2
> =
