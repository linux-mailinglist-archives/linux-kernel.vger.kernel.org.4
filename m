Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F1163D00C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiK3IBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiK3IBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:01:42 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1353AC03;
        Wed, 30 Nov 2022 00:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669795302; x=1701331302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+thJlamm9GLQ7+BWPKr2yWbIt1r1T5/6hZvXnw6b2Q4=;
  b=B9MskEMAjDbSxX8YbGvFtdvBoJF3zfBn7n5KOHLtrdgwfpIQOIUGiBlc
   Tx7WtJvmSWTmHol0bxUjz3X4GpI/l9cGldG4dgG0jh3+Sm9kRJt7sNaYe
   MJjLeILU+hDwLaXR8UdxyTNwzoKvgKnWypy6uZxQgNBWf7w3wqPrSbXeN
   B0gfuTAqRnekcuUW5hHkdOje93/j55V4pS1QSAfy7201psfTCjPrku/KN
   4haXdhhfyY77CDI6EDEmDBQBBvl2Qx7mb0HyArzwOfrMFDcJo5K1qLL7v
   8SYuzJneuOTASsNYZzhF2n9Em88VyICxrTEG1vqjx2RgspnF2lWV12Roo
   A==;
X-IronPort-AV: E=Sophos;i="5.96,205,1665417600"; 
   d="scan'208";a="222688525"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 16:01:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggx7JoNfrq9AVrmkVvSWIrQtE7rTQsrCsj0Ahed5rdUyRgwcZVNkEbXpM38DETodq6yKCl2iNgP53YdrRttM5bPxwFLqz0kmNJUqpHUWnbLsQ/dsEhCk1MxKK2H6adzfpet6zAoOUBI2b8lUdfqBTCU2pilE5o2w6H+YAgkBaAgHVhvkbUVG2LFrPh7GIbZ8zF7UvPS5425SsnUq2Hi9OCQ/+ZjERrpb1NOuoCXo8W+DcmLvx49lcjyBR8evfcW0nRlvUb+6iRuNbELFi40voaEgSdSO5EaKgHETPKJ4knkRVJuLqE6WaQ7HLUXUArZ2xZ/BfdtKUGm+pEKqTc4t5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+thJlamm9GLQ7+BWPKr2yWbIt1r1T5/6hZvXnw6b2Q4=;
 b=FClKUkI17gAVJlhyIn7Is/fZ5fEK76YFJfUcPTL9OTPYub9zrBTh7ILL4PQjI4wjcLbsqJANIWWyxwdpPF+upl1avp7ZsBXV7ISq1VWF0j2x5g6QG48Qw/l7Ccv5z2mMnBPDx/LFS0IwjTX02IdlhFzq+FB0Bjl+TR4xm7r2SCld42zlM6vCXor4cp6Nkl31XwEH8lDsjjJPXlPxmDBKdz1IXMAdhsbueK8159TDUKKyo6u+lx3tlS1z/vm0iW04lmYRI/Ha/VLI0pzaD9z6J+y+85a0nSPks3CKgYzfrzKAqKYsb+O+3j5fGhKcPaB0BhLk3NdTiOTbu+qe3vfrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+thJlamm9GLQ7+BWPKr2yWbIt1r1T5/6hZvXnw6b2Q4=;
 b=O38CXZWakTKGle7zFpRKGR+0ZKOf4lo16OZY90tYVgccCtKX3yMyqWNtwDt9Ad0YnReOEww/pO3k2vqn0riCa+6MLwUAxl9dRbOH1MawZqSzdK2eJ27mS7nq4np6BRxhGMcjMYxRwzsFOkM4L+8RbeHos52/nOZu1hBHNGxVz1M=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7336.namprd04.prod.outlook.com (2603:10b6:510:c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 08:01:38 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 08:01:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [PATCH V4 3/8] null_blk: initialize cmd->bio in __alloc_cmd()
Thread-Topic: [PATCH V4 3/8] null_blk: initialize cmd->bio in __alloc_cmd()
Thread-Index: AQHZBEpkNBwRKT63k0eaQfKnUma9ha5XG1yA
Date:   Wed, 30 Nov 2022 08:01:37 +0000
Message-ID: <20221130080137.r75sokfluvn4ootr@shindev>
References: <20221129232813.37968-1-kch@nvidia.com>
 <20221129232813.37968-4-kch@nvidia.com>
In-Reply-To: <20221129232813.37968-4-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7336:EE_
x-ms-office365-filtering-correlation-id: bec20963-734f-408e-9f2b-08dad2a91b90
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9o537bk55WcrBdwqxd63pqz91YVz8QxTtuLY/fpMr44FO55cyrQ8ARsE3R90UVppk44Wi38mB7yEzSE6odD3KyLB5k7Fk/djJ9Isi8/mu+UqeNMIIKrSyf9hnn+OMShvigMM7AVQ4s9Ibei+Y/rQcmz4ocZaNIP2fVjrwKvY2tlEtyuH5hHstZ53PgEE9bm06f3bwYNecU0NR6HstKgrdjBEagIgpXmpJ5oOhBLmABvythD5HrWPmRFNwnZah8WdywMXuqzRQ5o7TDBEmMXA/09s2Dsuy4D6iKFXLRr0QsNUgsO1a5mt5N/qL62qlXOT9IhVdZXNkt0wPDsQQOD/quqrFz/yRs9Rh5nj500qi9G7X1iQcxqMAYMjvl9MwvdokW8Xpl28WHwXb/TTY8qPQYNNtBi42TtSv/JrKsU7FLEIX4+BO88KI3l2QWgUuPaTyr2cENjQeORdtB0Vcoc4X9EOaQpFsY7p5F4pnXOWAJkPp59JluRG9oSZfyjRMGHbnPqStyrokGNfReph9YERooaldG7uQd6AJmajOLaEo/p6WZWdCZgmcmHXpnp0GB56hZl9GYjVIQM72gMMh9/XynycCb7M4qQVzHB1c8VsNGpsBhDuA8RHZ5hv3VyAHRtScJfbIecSwXinbs52fGqk1yvFQ5YfygB6Lhj501qaUWXqTEhtZckjR0wGb4OrX+zRwyARMdLyQL9H6ozr8W5qHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199015)(71200400001)(6916009)(186003)(66446008)(54906003)(33716001)(4326008)(8676002)(64756008)(8936002)(66556008)(66476007)(41300700001)(5660300002)(91956017)(66946007)(76116006)(82960400001)(38070700005)(38100700002)(122000001)(9686003)(478600001)(6486002)(6512007)(1076003)(86362001)(6506007)(26005)(2906002)(316002)(4744005)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mPY1T9bVB5P+NBQ05Un+vETHPew5/yC2LJIC+cCo3VVnHhrqdWpTZs71XMKg?=
 =?us-ascii?Q?WJy7KdBgr/Oed4d3Gm29RV49sGhe/RTHqPQLDzTqSydSFjoeAByC+z1Y8TZc?=
 =?us-ascii?Q?S9t4IzDADxgPFbXyAegSE9b7QCVBhmaDva5D666GrAs8jFwZDOg1Pn6U54PA?=
 =?us-ascii?Q?tzxXDJLKbMwfc3J/CbZMpixWCZh1/yfcW4s7SIXNdjX2W6eSr/K7TIVQDhsY?=
 =?us-ascii?Q?MK0vcPjMa91QVDU1x/AMhvtp4tj/QI+q0N/c4Ms1FlOKDM+S5LfB4o9/RX+B?=
 =?us-ascii?Q?2MJLD+XyX/zssIEqgtL+/+pE2yfdYRC2FzIjtA1sppwnLAYUtpkZ+pOFKpYe?=
 =?us-ascii?Q?UBdGuz1NqQQ6BSrDuPh8kWpJK7THebvAP/E6VPzGYsCe6m/n8J5UGEZUpxds?=
 =?us-ascii?Q?+5cXehYhhgbQqFeGJ6WFz/TA00hwGso6WlGp5EqKlsNbPMN0LzWfQo+sw0iW?=
 =?us-ascii?Q?Kkhytx8dun2jzS2H6m9T9uVJjPqDrW56Y4M/35GLHRdyVy17yUjYS1TkxEeO?=
 =?us-ascii?Q?TBRtH9Myrw9RbKjGQ4yoScJAhrqxWW9+RMJTn8tPQYqkmDcFfvXwOf7V6VFq?=
 =?us-ascii?Q?0s+/dvNvY+OVVp6DP9Wk3QE6amzfLsHDfzNt8JMFEu6TGNeb0gx4BN122ZaG?=
 =?us-ascii?Q?azm/7YxnT51jimD+OxT3xIQvotFQ/y7wwxo09BcyK53Q2hppAgs4nA0LaB+T?=
 =?us-ascii?Q?178NfVK/UqWaWC2JaPSWaiLgX2iOI2a6UPl81NH/5S5qRQ50+JwPG5nbHp58?=
 =?us-ascii?Q?OmYvYDqmStqCEUrjf7uiIGKul5YyMl/cocIKY9f2/nHz6hqfzNPU66RmxwMu?=
 =?us-ascii?Q?0jXpfzSVzy9Zre03PSPwrxgW5iydo2P1Ndq5wskGgS/dGGpm4joh9hfLWao0?=
 =?us-ascii?Q?1/04CV53UVDFt3y1hHXWamerxwM8uI5YD7Kx/ksIoFAzb9LjNGDctlexOQ3o?=
 =?us-ascii?Q?fqjUReiv48QgCVvwHH8lwFEHbedPJTFAXJeVeLhcCQ8jGqIUfGCVMmCMnPSd?=
 =?us-ascii?Q?ozjvmWnBv5gqDDAKwuDF9mzYW6FLVXzfEhjTu2MBFks7XX4aDsv3XWi5z7Z7?=
 =?us-ascii?Q?KtHI4tpFvNQ+IvnKZB1RafAlrAnezNF0nwtSDWrhKkPXMKOUJvJ43uAgp8NW?=
 =?us-ascii?Q?LoU+qo695uGvKvPjHaibCe3xbn/g8i+3++QOezcw8mUMz0EVBQibNd8pPT+z?=
 =?us-ascii?Q?8M26GCbFCHyUtt0QTuVeFefKaGc1BQcX3/OaumcUyVuANUKME+XI/IzupFH3?=
 =?us-ascii?Q?Ic+cnd7sza8kKZ/Jb5mK/Qil7C89R/xAB25nn2BUDt9WdzHEksOzVGkgun0D?=
 =?us-ascii?Q?U6YGMvdPVdrH9+5NPc1VNw4AWzVny6J94woUJlsC3om9Gsx6fWU6+/sAWkFU?=
 =?us-ascii?Q?O9FD3zDwuqm1CJ/ud6Ct/JFDXH04b9G+0ymQmm8QZ1vl0N+3UUK/HdxZB2BO?=
 =?us-ascii?Q?LsaUB6c9e+Xhxf0lpbe/0okA/9uGAC5OcWLmw33nch1kb2CmrEye/MnWegVD?=
 =?us-ascii?Q?lfAieJFnyYOHYOig3nkvx50tHgW/yosIZrkfhryQJbezalXqCtpr9JmYj1Og?=
 =?us-ascii?Q?1GI/Cc9nDwgV5og02I4hWh0XbkdQQj7O71mzgQDjGIZOGAeoD7aS0VPumng8?=
 =?us-ascii?Q?aHiJSkoVaZacX1Q8x7W6tNo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9CC72DE038DEB04181F7F2931C672D7B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?h34myKGJh00X7rSmckZMkVQQYW5jTWRyy2JLsCHoWDZ8oIi1t2FkaqpH4vA2?=
 =?us-ascii?Q?vnlZ0SJerS78wdofhZX5/mpnCl9NCIOwu3QkJrA9pEGoEGRvkzko6Onoc//C?=
 =?us-ascii?Q?UoFrl+JrlToUY+RDkiKm8KmGSlvbX+oFPsIqd8gKhZ5iSXUj/m+kx9ULQUaE?=
 =?us-ascii?Q?l2TiMN5AirSBPGYxDHA22tGhUjPMuf7QGvxDvA26w/oaTBduSrMbg8WycRQ0?=
 =?us-ascii?Q?mPTVpkjd1P2+bBGEzFY22hSOzDVm/nWvvjPXQbFIXNLYEXsfKqzZ1LVh/GVY?=
 =?us-ascii?Q?1klrRqNZ9K/+LVe5TWQfwdCf2VUSqaxmTuvUHPw+f2bC+P8CxFjEYuyv8a64?=
 =?us-ascii?Q?Y/orrFlteUwd+n2T5ZRtW1+uzdh+u8ZY2ytDzROR+3ir8/evr8H6W32hN0JA?=
 =?us-ascii?Q?DW5OfBkAXnuWyetmWC4rFvO3qvoSbl+tlRpNgLbe/8AjTVUSG1zCW2AEk1qq?=
 =?us-ascii?Q?3CqALgXSib7qlhNGJQuS50VmuZRzhaHLqJclVNWl10QqWnqtaZhFCnP2DyhC?=
 =?us-ascii?Q?InQGWmy2P8x/LXVcBGfm+BgmRUfb1Q/kBIxENgvrdupYanBcYFU+MUs/SYZV?=
 =?us-ascii?Q?Y96McIesHUgpmpCiFNP5bGj+NqboIApa7ttccFeIGgcxAe664tMgxiCejSQ5?=
 =?us-ascii?Q?q5Qf+M3wEbuG34ehUiZo7qsqRYxN5xlzs/pnJiuuhldj/sbnOy8LCzMr5g2s?=
 =?us-ascii?Q?SzOaf3fkXcM1YdFkeqCy/QkicVblGkd7WJPNOWb+u73msfKvGIsb9CP+jkPM?=
 =?us-ascii?Q?K3MW3ijYMNoyYdzaCZb6rzciu4JYdSIci4HrtcYd1SXHXbAl/iTJ9KPDgGCp?=
 =?us-ascii?Q?3GPabpYg0MrW+mAT0MGSXOtGf2Mtl074TSdshVziZ1mQV57iGRasIW4MPL4w?=
 =?us-ascii?Q?VCtQuVfP6eKAuiEelNA85D9LyhTSoCMWh6lbUFKGfKH7Tw9eJT8wOl8mPkqO?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec20963-734f-408e-9f2b-08dad2a91b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 08:01:37.9645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnjZsv3+ugx0scxgR6D1AOQD2A+pfHheE+pfBMzGH9dePgjyKn66RR3FQXXffxPgpmzeotY1AUCY5Ln5M3yR9EhyaNaEGsOz80PdqXiQfII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7336
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2022 / 15:28, Chaitanya Kulkarni wrote:
> The function __alloc_cmd() is responsible to allocate tag and
> initialize the different members of the null_cmd structure e.g.
> cmd->tag, cmd->error, and cmd->nq, Move only member bio that is initializ=
ed
> from alloc_cmd() into __alloc_cmd().
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Shin'ichiro Kawasaki=
