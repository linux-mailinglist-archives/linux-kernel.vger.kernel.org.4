Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB06F9CB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjEGXVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGXVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:21:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8D2768A;
        Sun,  7 May 2023 16:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683501667; x=1715037667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RMr319ODSILRCmCs/2kEdzAyHnbDUAm0cW31+CSutGw=;
  b=l5ngEEkrh75HaOBF/JAOSA9Z3IcMPQ0cBpzwg00PokBRhrJZ5xwFHPK1
   UcfxCdw86mRQz9bsFOE5OH8hSFizJ/+53HVgSrZQR7VLdG8V+289qe0g0
   zdv5+UPDLrDJL9QCz/V7IPrBGdTD2ibXLpMZcsJvm/S99e8uZcYJ+QZG3
   aGBAtth3S8EGPrEmC4DWI5xH0Gje+Rcd1C+z59Ye5p0onp6xGKwsdxQ1g
   +DWRFeT3Mi8EjZ4c4Q+VeOKKJUlQ6cdITEUNYvOENAYyU862oQLNHH5og
   zDKWMrCoRUkS2mjdCNkb1AkEkM8MbDHMq6oZWfGGiTGUs0AR6g2DW9gN5
   A==;
X-IronPort-AV: E=Sophos;i="5.99,257,1677513600"; 
   d="scan'208";a="229995107"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2023 07:21:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9WVXz0dPvitB0QrlMwQMzKQ3nCBx+cjACMmG5R/Tn4ioHcN3MPdQq2Bm8Kkksl4MRJ0xNh/Bpn5bYbaGcB+wjvGISvjkcEg0m20Y56ff6c9DR5LASHa6ULTw0AleeZ1fclEw3OtNU8wbNYO5/RFUnPCfGhgmOtwtzWFzlwNusMi8FCk/GOPTh8A1hrae3pxZ84bR8Hn9PxL8vmdBw0U1AJ9yqyYnKLVF/CrPOpsrTduJlxrT0lq9TGr6nm4eHqtbRKl7uPPHL9c+HmeK/ePfiZTPdZ1rq/k8vPUaDPPH5anqQYAZqguIBg0WIbiXw4XjwlyFvhZrOAYtkAQCZHATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U52ohD8cU+vvil2jc2K4xBAawl0Rcb5S3L4uo8r9x0=;
 b=X3dgLO0GzAROmlby6OOTwHNi51DOq/iFJ4L07EGFeVQeksYH0DDlTOt9CXqdBYJyjDxTZH516Cl30SR2/RmBwF4IDr7deQv19JczfKybmsEDYpxtwHxbcVkJAFNIJ2C1rZnVXcTGTKQNU5Ql/Y9OnvosLZwxfks36XG/laKHynxPUeDdmIapEpHwE4iw5dKkUGLvLlkx/PW6MCDCXzldXHiXUPyzWkZFofBLdg/Y0pzCOq9HMzJoQVpT0Bd/H16I3AI4SNk0ieuOC7vbVvCqLWlMOSvIvutgqADXcx4/CkEd6kOyeWOGT0W1DVcX9q02YFmV+vNWPCdYOo66TGFCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U52ohD8cU+vvil2jc2K4xBAawl0Rcb5S3L4uo8r9x0=;
 b=pNfGPmxfn10JEv++JZjFMqvICb2QiVJhKPeP3rJE60BchWHvt3Gx++YGmsuk6JGdOjTf7XhForxTvpqjnEHM9BNhXyN9FXAhZhDIylboJs8gcAF5uRrt0kDSJ5Ecuga3m+HYX07eeBbW0GacCqyubo9acpLLWQD/l6cGFpjFnoo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6703.namprd04.prod.outlook.com (2603:10b6:208:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Sun, 7 May
 2023 23:21:03 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6363.032; Sun, 7 May 2023
 23:21:03 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 06/12] Documentation: Add info on nvme_tr_type
Thread-Topic: [PATCH blktests v3 06/12] Documentation: Add info on
 nvme_tr_type
Thread-Index: AQHZgTqXzJiOatfV2UiOqLZjCTKaDA==
Date:   Sun, 7 May 2023 23:21:03 +0000
Message-ID: <niai6oizlwp5sdisj4bd7b55kls2docnmb7mom6gnci3rhazdd@4kbr44fqjbkt>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-7-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-7-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6703:EE_
x-ms-office365-filtering-correlation-id: d37973d7-bef0-4e39-4f9c-08db4f51b9eb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V8shZCwPwGIUQRFxG3X31/6BrO+ATwjxZ/wzw7WT51JC2dD23SQWCia4Y24w6cEkGFScQWUUbO1ZWfUUJkMkk5/aZWhM/NiqZyNF5+ZN71guRL73Iam7TtSS1yDY0gwFg35MAkFoC2xtEM28S8jcMaBUM1qVSB2Bi0hPqRwcffMUsCu0aRki3IIIJdHAgX60NcSl/Hue1uUzBhBlQ90DZ4MVGzf+AHPKSOxwh08UbrhGlvvjGnJ4OTBw43W3mx77wwn58TBseW/PxTGk/ZssoZP4YgVUMt0bXmrXaWVwMFhEMUNJ9OxYh3d6kpJYNc2YCb4+2h41VEIgqzDq/6yWm34Eh41S8saqpVZ29rQ26kC7zwVt/3hBYX2fIx0aF4FFxbm++VXJadh+Jmv6VumfzUbBB4+l+BeFdSXkOEU92dVbs+Euzb/RAUn/6Hzaix1kSVwZ3o8aib5bTZl/dzrLB0MVjeV0FfE90GZUIF9BnRlxoAYrJ/WMoER+Lo8N7Qbu0HdH6RiPXLJippQ2z2j1/lxgSnDtQMMvjY2ogqc8lD5bvX1jFi2wD4DigRbu+WFFJEzcOZ+x2JTARonTFI6HL5cwxfOFxsjE7FwkKz8hCz/J6pOVczJl6PgF2EXTbwTu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(26005)(6506007)(6512007)(9686003)(6486002)(122000001)(38100700002)(86362001)(38070700005)(33716001)(82960400001)(186003)(478600001)(2906002)(54906003)(5660300002)(64756008)(66446008)(66476007)(66556008)(6916009)(4326008)(316002)(8936002)(8676002)(41300700001)(91956017)(44832011)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BX2YvrQWuztAYdaVtwzEPK0qXtRioFNNeAVJZgJlc1JEG7p8c4lIqds/GrEi?=
 =?us-ascii?Q?LED1H6CYJ+rIfbYHo7OQ1mFHNAAi1Y+q6FvIyHCbdOUbDvrpuZngXwG2OWxN?=
 =?us-ascii?Q?iuy9NyTfK9qRpelLKGWxZ4M8/3FuCVXnuBM+9Jvwh+h7F6EflLvGlW8JgRSb?=
 =?us-ascii?Q?bbYH68fFEqXe4oFruWeGVLN3AmbLKarQBfDrVwgB7a6UEM2slUiL+F4IVKv6?=
 =?us-ascii?Q?ibPNJTv2Cv2ybbh+dSMfre8Cwt/f5a9HAq0A8esho5L8n/xrz+kSF+QqBW++?=
 =?us-ascii?Q?Npe7H7uCXYjqSf8/daF3fjlmA85CDuglB0BgOAtUJAwrLExwODuaSuqJ9ae5?=
 =?us-ascii?Q?4s/F9dTXHlH46mGm09LxDkPSXlXyqfZEvGL9vZmMpKLqKf9ugHI2Igkw+FRw?=
 =?us-ascii?Q?8HcxQ4cML8cEv72kZaTIi54t/qxdqPaTPsu8oiH7EQGAq1E75CZ14/7WhI2n?=
 =?us-ascii?Q?RyFQutHjFpC0mp9q6eq7Jz8wcuOUTRdQNVVpC/cZxEDir8spBKpakrX3uKJj?=
 =?us-ascii?Q?fv9xqLrpkxH/jZjfFt/cOkYywIk9mFLImzmlgY3HDg30VnXEeDcAwVpyLSdI?=
 =?us-ascii?Q?YkluOUlHvDNIOdW1e51PqAWp2ZIak7QCuQYLUQnVvcxUeptf5yXCNr/DJPIG?=
 =?us-ascii?Q?A7qioEJXLAR4w1UQvbXmsg+URqnlqxN6pwUwFSt8VHBvv/50B4DEvLRW1XOR?=
 =?us-ascii?Q?+4PChefgPdIATvH2mD0eDPUi7Ru51WrDAbMqDbB2M5qrudV/9Jfo1BuiwyRA?=
 =?us-ascii?Q?dz5sDXCjsd9hjjIbA2CcETdc0Yp5RTioIdQUaqCWvdD0rof9KUPusZ8ENBOK?=
 =?us-ascii?Q?bRmZMwpSaRRC0LVmRuM/8pmexxlvPQTR8btWAYzyqQERGeWFo7OjkZ3xI7Um?=
 =?us-ascii?Q?M76vIadB8vXB/hSdjWEAdvHqdYiwwVnl+A01Y9Ak8MOZvIv1ZMFU+EIehdx/?=
 =?us-ascii?Q?7aeoJFIEG9rroNCrJfMYdCvm1NC0+X2D0yiOSj182BAKaLK2Br3FOZ9U1CWC?=
 =?us-ascii?Q?EfE+xWdbp9DbxabKtpJSGno+LzZwYGf8e1s6kiuenqNfDHiuS1lhqLDZHxXX?=
 =?us-ascii?Q?S5P/YdLmOfp/4Og4Kc6Vc6Hi5B5sX7KKcN1wxpeN3fV3Alz9o6flNYN7vo26?=
 =?us-ascii?Q?OcyoOAyxUfvcfzvFsPRbGDKxmmvsHhcjJ3NwZ5fYzuEENx6mLs1+zc2gWv5A?=
 =?us-ascii?Q?XNYHMAQeFk7e+WkmeWQ7SQEBw4AfKOJdU5qXd4kgvBWd6FXQTb2hbpZcg0p5?=
 =?us-ascii?Q?Gc1O1AmazlCV7ME/jlolBR9SnpqOC+JK47PMjXxnzdW4qXZXoing0hFFo4du?=
 =?us-ascii?Q?oyWTE+r+ISxOa5tzJPtqx4dl6mKZ0JmMMMNKgtXQ/yPdnuG7TXjc9H2qbKb0?=
 =?us-ascii?Q?Sog1NcHoawYt5iumBBFTV4VpUT3CHLRvdDlb8BJi5X4VT02d71wUgu9F5Cqr?=
 =?us-ascii?Q?0v5QtD/M9IYRWJLAJDv6blxnZgGotJGwU/sU6NHDZ6X53HppzCzLabEptl/h?=
 =?us-ascii?Q?i5N68ehgCQbQuwcnDnL/xu9k6VYAlAoGu/fgjpnIa8Fucq+10degvPVAHfSg?=
 =?us-ascii?Q?dgXhvbfRlMMWEhg1fdUYUGDPS0oz6vf45g/XlC5XQbw9Vtotx8OvVEw7n9wZ?=
 =?us-ascii?Q?HG1iWgLrOKrNPoKnbmLjnu8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AE29A37DACDD34180D68FF55621A7FD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0O8ovW7dvtkzMI1rV+PvkolUBfu15Vi0p2duTih0TrLNa43N6VS3nPHQGDwrekKS3iZ3C9Nnu7kSop769sv4zA/Lb3UeIwuu6EYZPIeCz6UlIvsneUdB3c48zLpt/lctBAa8sK20Qg0nKax5cs5D5JxCIzVga1dzo4mTVZIPCoTJnivOqAdbybK5c4hbgeYIbCeHcQ8Fjip1c0SoVdbvBiji4ybIRnSj469noSPB1O5Zxy8rLwje4UpnDo9H5H/nxZ1Nqy71HnTV2Ez1jupjfN6GhETuaPdE8OZwLvqflR75X9dD3JQmVTEGqvlEFDn503EtoRMOBPa4a407G7H09KBpdFUeTj26RAPYa+UwrHAyhJoRd3Z5lJ7TsAD9PgsnQKeqEHXX/VzpYVHGZ/Id/y8KKeSMqtm9IDe0BSkp4a7gGxA9d8Mo7qQJlCppqausUUY1Lz58B4/vIbMaKtkvDwqHHUmsAJgnruNoltwKvnuqj+1IjzUFbRAPrDmlnk9GQW05Zvvl7f+esPCOQI+gbTPAD0IwXgL2kSpoLJEXdyGw+P+xHqQFkkd5VLmeOOl78ugs4VY2UWeEDBUrmnHhHNt2NEl2HT6mzqudS5jIXgVCHhA5YWdGD28iKjx+mUmjbUUIbp1mdNHADj0EB76tw28604bbEG9N0Apj23ETQEosakWszeJW9gnEwXr+javsLsav7xlqL8rvwtKDm4KOp+7BIke91nXiyoI5YbATmH2psaHEf/ax5jGGjHpCZAADbxbd5uWTvfy1iRLD4lUbcKKZvLRJe3jLsmJp4LYQG3JIkb8kAiMWvpBCZ5JVorMxSaCCjJiV66jGTmRB7/SBizzqLrIn5KUYkQXnmeUF6+4+VhTjOwg/CQrSz7TiGmd4/YTEE3Vk5Sdab2XrdwEtwjyi6ZbVYrMFkgxKpXDiFNM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37973d7-bef0-4e39-4f9c-08db4f51b9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 23:21:03.2789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gJB3t8zWbp6e6CzbO6bkYARKLNN52YE3UpZgMOrey54URFxaUWb1iVjr8irl37AJinlpEWh/9woei5fA2Srg9UC49H20cLH3/m7RbirpKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6703
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, thank you for adding this missing piece! Please find a nit below.

On May 03, 2023 / 10:02, Daniel Wagner wrote:
> Mention that the nvme tests can be parametrized.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  Documentation/running-tests.md | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests=
.md
> index 3550f377f487..7e827fba7ac0 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -98,6 +98,13 @@ requires that the kernel be compiled with `CONFIG_BLK_=
DEV_ZONED` enabled.
>  RUN_ZONED_TESTS=3D1
>  ```
> =20
> +### NVMe test parameterizing
> +
> +The NVMe tests can be additionally parameterized via environment variabl=
es.
> +
> +- nvme_tr_type: 'loop' (default), 'tcp', 'rdma' and 'fc'

nvme_tr_type should be nvme_trtype. Same for the commit title.

> +  Run the tests with the given transport.
> +
>  ### Running nvme-rdma nvmeof-mp srp tests
> =20
>  Most of these tests will use the rdma_rxe (soft-RoCE) driver by default.=
 The siw (soft-iWARP) driver is also supported.
> --=20
> 2.40.0
> =
