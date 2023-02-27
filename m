Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A816E6A4467
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjB0O3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0O3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:29:43 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373CBF946;
        Mon, 27 Feb 2023 06:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677508182; x=1709044182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ozDXN/o0ZbQOn7zs14m75AWPwtx6CB6fMd27E37ZUV0=;
  b=dwWf4YjLqRBg7WKMHlJ1gFYdAt/72fe0M/p3LUVrmRmy+2UNR/aGrzlV
   Py8aEsRSU3zHlnggDYOfx3o8bGIyiCTfacxj2BvBLX4VNhPn6wPe/jiTa
   LVS+9VAckooAA5FWwpbF1HKzY6dx3zLC4P0mk0BEmYOVApY5LWsYQ9SvT
   csh2ZD0Xbh4d2Kmg53nMBc7ivQ3wbHF7/nhGXc/RuOGBT0GXF4sMC4O5b
   PXMGZr8PT38qep9nB9YBq/fewICAGbue4/a30k5zAZYi1YruWLKOFuse/
   gIuzmoWV6lpOOugv0Tz86KrJPHjRjFDCDL19ODjtwML3DCVZv1JICgfce
   w==;
X-IronPort-AV: E=Sophos;i="5.98,219,1673884800"; 
   d="scan'208";a="336301869"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2023 22:29:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8kRyjEeV/Ho3IWB641E2hNqFU4hva2mugibRrm4AbsOsizOIKW4apj1eUEb4C5CvGR0+RpKiO0Ciisqhscbw+wXN6kyZB79ym+Zq/UMfRWHvQcQAEiUZAAVTpMLYVsIpeF4r8RaPux1hkKeG+iNXHWF7yVEejM1a5KxeoNPrcGJwl/49USJURNaNcC7attSzzUe5kZiBF4v43w6otxfY/RqwazR+k7pNst8BuSoGKRfS1Kk6XKuz4QC+PRNBTbRlAO30XoGZ+z+2dS8BEX8Lq29P6VBasnWVLmwfVjbuFZ+oYYNbJLPyeKYRqxVRybqb2kNUWV1yxN3pT/Vmvqsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4PYN0uMSxJzzWnp9RCq01pGiORWWCwDBWuUrwW/MnE=;
 b=aWmn06IOwr1d+1B+yUqgr7fPwvGbw43BmjFE+LDL7kytPJRAlvBJixUSOh3rU3llgoOcYLv2mbuzT4sfSl11IBGAmbZpg4bE7ooQBK+XYwC0VWMMEYFpn+RDADlwnAHDOvEj2g7d0xglrLnrFAIh//LYozcXBJIXSEszZqDA1Yd4m4lnGEtpanKRZBMwjYSrii0brjDk+6umTwHGSLWmI20r/yZnMFuzGg7+v7NJOxxJ9u+fEbPfmhOgqhvaRvriM4fDJC/+bdqiJwpjJ0Nsz92y/5uUc+cTTEewy5JfNjhmIocNPr7T4UP9M9TjMGUuIg/ylfYYem6kjnuMcPfjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4PYN0uMSxJzzWnp9RCq01pGiORWWCwDBWuUrwW/MnE=;
 b=t5ycvFY3Lieo7ha25mJNDvmVBK8NSgnB5HeWoCwiluoCeNo7DdBHKanCi034Br3WrNzvBXFZ7R7HAeUw5n+xSx041rlhGUJbwY4dsGd6X+n5k2ay0jDxURxXgFYU9q4Y4V7NArRH21NUKdZqSesZu7dfYlp+0GOEFqPitwKXrWo=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MWHPR04MB0446.namprd04.prod.outlook.com (2603:10b6:300:7b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 14:29:38 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a%7]) with mapi id 15.20.6134.024; Mon, 27 Feb 2023
 14:29:37 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Thread-Topic: [PATCH v2] block: ublk: enable zoned storage support
Thread-Index: AQHZSItvYj2fUTtyhkmoNbHcKTvJAa7imQeAgAAb2YCAACneAA==
Date:   Mon, 27 Feb 2023 14:29:37 +0000
Message-ID: <Y/y+UFEHn1F1sg4i@x1-carbon>
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <Y/yD1WMJ5zc7KkBz@x1-carbon> <87ttz79u8p.fsf@metaspace.dk>
In-Reply-To: <87ttz79u8p.fsf@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MWHPR04MB0446:EE_
x-ms-office365-filtering-correlation-id: 3c943081-3817-4b39-8a85-08db18cf0e1d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+TxiCHlwTLF40wFfLWKepirub0zKJfoXDv/OC7Bm4wMez7Fbpcj3RP6BBrcz6ZI8V4jxWF8bL3GjHNo1PREveydDQKk/sOja1NR5hwQNUjG3pgbt6YDZKvg8JvKmTTcqfgKhQgshG0tYb2kIFVtB0uIlMSl2mwKm72NBc5O2n1KnlpAJ8GrIc9CBpTOF/34LV9w2Pf0pTBcHOl6i/5C4cFfmF++8hd1fI7q2vE3oKl+Ghw+JAuN71Mqj0SAHhMS78GHMoyyRf72F89A0l3LKIdlma1mN9e8fbxyOqYhP45wmvxJfPUiQKYE49p6l2L3jnTqz69t9a4/2JsKVGGVhi/1yK46IlkoVffDPIUhna/PD3UFcE2rQnrdBlNdBWiJYHcuSiLSo1Sv2IAiYrhXMm1r8gxfGtcIUe+NFsAAzfrLfKHvN1kjskjWilpWJVvlh2UUv/on/u0gfC9bvK86aWrAu4hHk/rDBCJtkzncV7HlLtAt4HetGkuYNDaJXnpjX2kdGYerTq4HShzNqtB3ju4TIo+CjdzSQfdfwG1mYDQnQIiF5D38U8mBlhmSXg/kbRh246HaNO8qEaU07XTef972c8th2LZWOWHFqS3XK+0JebJliM2NaaCb+omUmINl6QgL8MmWxAMkw44U95UoBTEtpQrC0OxgmvcMFoMwmIYGZHo6F4XA1jVdEvyeyjhyjyLMeBvmfS1CZmxYMhgo1udc8zHAgyJ1RS+/NZin1mw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199018)(33716001)(54906003)(316002)(83380400001)(71200400001)(6486002)(966005)(478600001)(6512007)(6506007)(9686003)(186003)(26005)(2906002)(8936002)(38070700005)(41300700001)(86362001)(5660300002)(66946007)(66556008)(76116006)(66476007)(8676002)(66446008)(64756008)(91956017)(6916009)(38100700002)(82960400001)(4326008)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Nkfr+L4RzpzoE7Ftzk+LIT5qy8alv4ScVG/VZ7ATWBEqFYFvl382ZWufri?=
 =?iso-8859-1?Q?q/GdxFBB7s05AVqc+WyGSLLVUn/sHjexIvPzx445XTKLMuSdo6UJzHYLRS?=
 =?iso-8859-1?Q?+FJlLBgj9qNT3rcmSQ91xmjaZMF1wj2+P4eEaDM8CkxpyibmP8F28/lDx4?=
 =?iso-8859-1?Q?/k4XCDDWMJ3rEey2WTnmXFTbHuw2ippc/zxanK+skyO0Mc9Nw1a47PVr4V?=
 =?iso-8859-1?Q?E3Abgl5BddJ3hU/wGTnPu0K8Y7s3FGt+59tZzf1xKiFST7/jVyFzSmkk5O?=
 =?iso-8859-1?Q?BQh3VqZ4HMSp3RAgsmQxMQyDCUbg6BIGVEBWSFaK9cQrsXR5/4/7wz3Ms2?=
 =?iso-8859-1?Q?kq7GOZ6dM+IHj5GGOy5fKjotAaH7uYnkROBvFMs/vIJfqevUVPQvDmuBrB?=
 =?iso-8859-1?Q?AnlkBPhP/5rQ4ediSQcx8IRNivrtLXwU193MfJMXt2YLUPiiLHuhSRQ0WC?=
 =?iso-8859-1?Q?REWQV8N6cawOK2L2feUkWHS9tSIrxiRa28q7EMRawnzP0E24GNTLHrLE62?=
 =?iso-8859-1?Q?eG4gC6FB9ghPHYjkhumRmfauF0Pbr1BJzmT4VQ7UYtRwALHGcBX8Eac9hf?=
 =?iso-8859-1?Q?sTyog+nacmUog+3FKAlelsWx+IFWpQ00Fq0zAUo6xvovQTO+Z7RPpTY8U5?=
 =?iso-8859-1?Q?ujOMwKgnn1hakZDtW8kxlJGKvotiWxJ2yi1PiOGCoWQKjM3IWClAJlqaIf?=
 =?iso-8859-1?Q?dyeXlOf1fyEvaMh6C4XO0I6SgAgEqeHm7b2iSB4kiRD1wW9irn3DWLEnQX?=
 =?iso-8859-1?Q?jbuHDa32uQqwzEN3q/3ap8OO/9TfzKS79vMBDn5zVylMiIVou7WO3LGhYD?=
 =?iso-8859-1?Q?f0qA5LjQwuqHFS8AQvkn2w7Q7nGmPGEHNuM/qg1bylRk1bE9oqMHOXKO0k?=
 =?iso-8859-1?Q?W9KR8TJazR3owQF43tqcY+hxo7Z+rrFEZwS21csA2XnP+XLKqhvHM+9QWr?=
 =?iso-8859-1?Q?dB9G9+rR1g+g62fUYN295OF3OXnYcrivH3SJfUfhxSd9odt3xGH/XAs7ul?=
 =?iso-8859-1?Q?mkR0/dRdRKJTEfhJKGf66GscbuXFaPYiRN+e4jijLJEaGLAj78eaZaEeAt?=
 =?iso-8859-1?Q?XEWjK4KqCxP59KIZ5POCKvpM7fFNjZmQsuO2ul/FtrpAqjHcCpsFogQSY1?=
 =?iso-8859-1?Q?86h/wmyo5B70S3f90B10mnsotUzrfq2V3qFYl6KwJHQ4+x/tdNwRza2Hvw?=
 =?iso-8859-1?Q?lCgVP8N8jyDan6wU2AVnmlVmAoGNZ5YFfKt3DK1mNCenUuT3QsuXqfmwfT?=
 =?iso-8859-1?Q?RZw+IminNIQ1EZv7WFjkmE8UISR0fngWsA6vcfqq2s2lOX2P+fqj/XkE4C?=
 =?iso-8859-1?Q?QGgqQzkM/YQHQk8FvfrvT6KCasVrL4D359R8injh9vHv/wgtBclbuQ1Ym5?=
 =?iso-8859-1?Q?4oNoGILaxcQs+zHEXf8dJSf1Akwj8OKXPOMzpMY7UaAJNH9IQZg1qC9Wgz?=
 =?iso-8859-1?Q?vQyQpin0n4efkvMpULJYv8+wyCxiQimLIW93Fp0vwPy/liotkTAJ2tq2Qs?=
 =?iso-8859-1?Q?Hy5yuEOZfwWi4f5c+4RYXSApzYN/4En9JXEe9vznDlJ2rztioGy8vuzivz?=
 =?iso-8859-1?Q?NkkjlVHPfN9V4jetaB51e32iFZDhq97R9x7nsYR+DmJdMNysd0r7FUzPT4?=
 =?iso-8859-1?Q?9oX2ahJn38gdvbD7GgDW4yDNRLWDNdEOESawhPHqquWntLUcyi8iMr1g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6981E34CBD5EE644B41A0F09D5259CE6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tyz8WmoPmWFprxHNeNj4aUOPyrB9LRqnsq9+I2fihJSvRZbn/DgdZ0O3y0dM/e+TJ6ObhYjN3osqzXKE1k/1PuwGQaKe5stPVnjt8lfFFhpLkWTeEUgDWFZr20Gku2fdKvuc+e2b2uvCSpeYbG4aNK+P3BVIdnt/hgtUwIl1m/RZRE2Vyc/yZTlunC7Qpn379OJGc5xH4yjdRiqCx32qjpKqWxn/apLfSp1ObE43aHC7foykw49lTHbSWj3hZgGpH22FMccoUlXk18OFuAvtS1T0UjupC/5Fzkmke5BMO8/AIyIlhRMr901M+huBwVvGoCX55fEkzON3R095BtgKgJVEh/6AR+fan7OZ+Ru7a2wOEoUWMTUX2IiF3yqHhB72S3GQAtZbCbGIpwQ6wyg0POSGDluGkmqy5DX8YdlSpwzecxcJGjWHDv9y6QalIbqgDSf/G8z6+afPAk1N+CtCxj5afAETV72X2V+Neoa+vZMocwGISCPThYLp3HO0DRK4nIN+8OqqMj6IhqJTnjLtgAbLHWhJmi8VCba/SBdw2krn/FMiLUU0uBVLvr6/GNP6YbvXUQxV2MBiZt7GBdZv6S0JReR3zJVf6D7YK7a9ipJqggDBfr0ATPcojLV5iXytvxwrqlWL4Z5KmxiDMU478B7bSBHV0YHnvNs3XATA+6iAu37lzr8Hz1GuX349lp6EZCvtxbCAroQ6L9pmvq5dUcxNMx7RR1434C4xKUs2bb7EPkQRJ+ODkNcmYH56v4MpVfOjYDEefd1GKKkI2M0YwqZ1fhAFzIEy11eDwb4phKRBJScB92dCS6ovIz9nligkmtWX2R2VDyaRlRcFWLLj5aNZelERFkmU68cHgmSwBQ/q/1u+MnW2OQHgbUIIVQnri48IRpwaHcm5JP+b5qqoaA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c943081-3817-4b39-8a85-08db18cf0e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 14:29:37.6702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9KsobD+Q9Gok+L706y5yaQ37nOk7sYBycujr6tf2cSzgvoOf01UG/QzokPeQ6z5b8U17UKy+PXpQKjR7llaYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0446
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 12:59:45PM +0100, Andreas Hindborg wrote:

(snip)

> >> +#else
> >> +void ublk_set_nr_zones(struct ublk_device *ub);
> >> +void ublk_dev_param_zoned_apply(struct ublk_device *ub);
> >> +int ublk_revalidate_disk_zones(struct gendisk *disk);
> >
> > These are declarations, shouldn't they be dummy definitions instead?
>=20
> I looked at how nvme host defines nvme_revalidate_zones() when I did
> this. The functions become undefined symbols but because the call sites
> are optimized out they go away.

Looking at e.g. nvme_revalidate_zones

$ git grep nvme_revalidate_zones
drivers/nvme/host/core.c:               ret =3D nvme_revalidate_zones(ns);
drivers/nvme/host/nvme.h:int nvme_revalidate_zones(struct nvme_ns *ns);
drivers/nvme/host/zns.c:int nvme_revalidate_zones(struct nvme_ns *ns)

The function is declared in nvme.h, but like you say, without any definitio=
n.

zns.c provides a definition, but that file is only build if
CONFIG_BLK_DEV_ZONED is set.


> > https://github.com/torvalds/linux/blob/v6.2/fs/btrfs/Makefile#L39
> > https://github.com/torvalds/linux/blob/v6.2/drivers/block/null_blk/Make=
file#L11
> >
> > They have put the zoned stuff in a separate C file that is only compile=
d
> > when CONFIG_BLK_DEV_ZONED is set.
> >
> > I'm not sure if a similar design is desired for ublk or not.
> >
> > However, if a similar design pattern was used, it could probably avoid
> > some of these unpleasant dummy definitions altogether.
>=20
> This is the same as I do here, except I put the declarations in the c
> file instead of a header. I did this for two reasons 1) there is no ublk
> header besides the uapi header (I would add a header just for this), 2)
> the declarations need only exist inside ublk_drv.c. For btrfs, null_blk,
> nvme, the declarations go in a header file and the functions in question
> do not have static linkage.
>=20
> I could move the function declarations out of the #else block, but then
> they would need to be declared static and that gives a compiler warning
> when the implementation is not present.

I would love to hear someone else's opinion about this as well, but I do
think that having #ifdef and #else with both a declaration and a definition
in the C file is quite ugly.

If having an internal only header (in the same directory as the C file),
makes the C code easier to read, I'm all for it.

It seems to work for nvme to only have a declaration in an internal header
file, and only provide a definition if CONFIG_BLK_DEV_ZONED is set,
presumably without giving a warning. Perhaps ublk can do the same?


Kind regards,
Niklas=
