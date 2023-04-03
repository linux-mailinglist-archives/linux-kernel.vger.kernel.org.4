Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C176D3E93
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjDCIGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCIGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:06:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A972D60;
        Mon,  3 Apr 2023 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680509166; x=1712045166;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=nIdcxdufUBcTw6XA/9Uofh6bHcVK5xcKDa8lwPjt/Uw=;
  b=Bocy1zrlykA20H/aabJDWnmjAAdxtBfK15sqDx4UlPL3ZiBbqI8w4TGq
   WIDQsslPxko5depomSO4OQj64oLIF6vKaDTU54Frba8N7OHniQHXWNCi8
   UrPTvwcrok2iVMC0sfM7+eaoDT1hlNptEenBmF+Vw2ruQATqGpzFIpXUE
   BXEzgYiAaVtMv+APXuWEHliZgWOgYWXi8xAMiELIept9ly5T+L0zzLcfu
   BnOfZJFqiNr/sLbFHpWYHAY907I9zDpxxOR2cVqHtjzhMV6wfuVstYIMD
   BbXjx+gdzJbL99rt9ws++i/kZNJfVVS8OtVE9HsVYLQ6J6+0HAd35XphG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="404591827"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="404591827"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 01:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="750408162"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="750408162"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 03 Apr 2023 01:05:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 01:05:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 01:05:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 01:05:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 01:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P21VFRIM/cR6Lft1wXEtvovG3h5zbivmGRt1FJD9Ru1oTPTrHcTpziCRqasC3/6wEJoYe5nCotVVMqZNaSKxrOEMmPkLyLSeeHXHI5k2hj1/iG5GpGM+c7cfP94Vujf0Ru2RLr5MSPb/fdJz3+iw0cQe0R/7GRSDLaj3PhHtlgjkHI2+XcBs8IjyzTbTGTITydwKRdWkK1tfdhnv/UkuZm/qmdFWhMKEelbrGTNzunhJecFQ4eMpUs1UM36UshGrZtpTrlVyw5WKLN8o0kubs5Q519aYvE7MzCXy5RM+b7o0xH8lgzBCnkEkMIgQF/IDzMCPwZWHAua5pIxfx/XVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IVHzoEc+ymfxhNp7s9XFknSc2J4S5a2mpb5qKqf7Rk=;
 b=brmmUtRvF9xHeIpMTok+9tn7Qw7qGYag88TXMO7MfL+AxCFjGybEUFn3dCy8IFWf8DrU5bSMC4zVbxwo+lFYA0UqTp9MQSdNbusiY0YZ+jCHm8uRyc0/dKTAB9Nc+T94LAYofqc88MLT0lqxEj0TchW2OlzCqG7/o6Q+3+i7Ra6oTY2Lq5qu3FUmIp+j3HaQJutTLSjrEg8/X+ubG/8k2xy6fYXuIDyhMiTjvFI5Qq2qF63pU+jUkwO/QqY8fMr2ld+Q74mOInsXu3LboUpl5PBfH8OofkIn7LBMDTaKXfHbyv52tRrvlHk0MVY84tBxuHKgibPBWTaRY5vzst9nTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3244.namprd11.prod.outlook.com (2603:10b6:5:8::22) by
 DS0PR11MB6421.namprd11.prod.outlook.com (2603:10b6:8:c7::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.22; Mon, 3 Apr 2023 08:05:52 +0000
Received: from DM6PR11MB3244.namprd11.prod.outlook.com
 ([fe80::6540:79c3:98e1:7be2]) by DM6PR11MB3244.namprd11.prod.outlook.com
 ([fe80::6540:79c3:98e1:7be2%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:05:52 +0000
From:   "Wang, Wendy" <wendy.wang@intel.com>
To:     "Chen, Yu C" <yu.c.chen@intel.com>
CC:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "yebin10@huawei.com" <yebin10@huawei.com>,
        "Li, Yifan2" <yifan2.li@intel.com>
Subject: Re: [PATCH] PM: hibernate: Do not get block device exclusively in
 test_resume mode
Thread-Topic: Re: [PATCH] PM: hibernate: Do not get block device exclusively
 in test_resume mode
Thread-Index: AdlmAUM01YqZY1GMS/O4hzI83IeadQ==
Date:   Mon, 3 Apr 2023 08:05:52 +0000
Message-ID: <DM6PR11MB324417D36DFC57019A89E4839F929@DM6PR11MB3244.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3244:EE_|DS0PR11MB6421:EE_
x-ms-office365-filtering-correlation-id: cb4c7920-d707-4089-8ebe-08db341a3e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30qrsrMiJGzyf434jJH2HMT/DJQdN0ljqbnGSOyp1P4J/kDk1tWo072ElZJWfUv/IUYhDArIym5B12F7Capocy4btt2Nl11qnrI3ZTFIen3oYSUftIhl7J3YqTtdyifSJZGG+WH3BHDfkKTpV9GDshKpziu2e5q1DHF974OrpAgaqMGsoTlWbr2C/9XTXmaScd+ZxKayB/Ow1XxZDDZ1xHWjm07PY0RijUGpcn4ZVRQ7EbHz49+MYzW23kUgxL0KMilY2HZ4QnA1q4+TwV03K5BPQsQnMbsg3nce8Z4CtbsgencCkJqjR4f/EIbVnefG3xUan3wUMBejLBRbLw4oUfjQVjjpLNbkPxzMbCL9zxSkOujeGmtEUdzCAP/596GgssufLX77exIVX+fzmmK8SpAYJEKgdffFKPeidyogRXw2BmMKyytzr/NQUaPhGmoPoFRFqtgjfMx1Bwo8aOHnfPtHSw89/8bv+L2xQeP3dLC+w327dt5ho8WZkMXJ6uxEcntSXcfy5IMK1AtC1FBewqDZcdtfEnMRRzoubjxYhLF/fgyor6kIcLKlVdI3pGTS0H6/fy7xsU+3K0lCwix50ujd0Lw7xaDOiEZZURyTes7DoQJ0OZByJbOA7UKbEq0L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3244.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(41300700001)(6862004)(86362001)(64756008)(26005)(316002)(107886003)(6636002)(8936002)(7696005)(4326008)(82960400001)(5660300002)(122000001)(71200400001)(66556008)(6506007)(66946007)(2906002)(66476007)(38070700005)(53546011)(186003)(54906003)(76116006)(38100700002)(55016003)(66446008)(8676002)(52536014)(33656002)(478600001)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FwsVz8QQVfA3oAfHGTj8ty8Bv4ufc5WaicgXw0nMtspW8EmQbAynHCD3V3iv?=
 =?us-ascii?Q?dCaRqt6AuOQxNsiwJ3cvi3C1oUZomljkZZi7Gw8tiVnW4awbn2pq/j6VsxYL?=
 =?us-ascii?Q?voLOyXkm/Q+n65anklK3c4N2wypLjVWXrt5kF0YMa4hwrxNZ4NG6Lmu2NXj1?=
 =?us-ascii?Q?gDS+3J1MfX/j34tU4mNe3y9SD5JO9rsz+DXECqZQLlCBcgalXqzk+YyLXOX3?=
 =?us-ascii?Q?DR/241QTYG605k96WgKpTtjKl2/JiWJ36sJlaGUx+8h1qdZ+xxQ70ulYjJb4?=
 =?us-ascii?Q?bCCqGyoHrI7APGuBLt0f3q5fDZB/Pa1Bq76d/wUQC4vXUWdKDaOWXeo9NoK8?=
 =?us-ascii?Q?46ohYqanh9sDiTKL26gmpmDP6EeOln6R7y3rZevDI/Fs6XzWMc37YUozimo6?=
 =?us-ascii?Q?5dSaJA/xEz39EmNgticEM8z1NiB+E9wUQRKyZ3lStgGpT0hbQWBjLM4YpuYg?=
 =?us-ascii?Q?jd8z4aHtRUhRhAR4BxmdnmEo7JnzPhs0GAgwsvu9yflDTBz4cOHXhYKLt22L?=
 =?us-ascii?Q?IUkFUC4zmbw3ulaPKXQfdMtL6KY5eY1mwAZl7eZkoeDG6TZmZcqz4XKiTMCp?=
 =?us-ascii?Q?D3+Ep7rIGHkufjSVPWpPtLCBFijBDbiV4NQtUfgwZfMg03GueZjb0txEyX7z?=
 =?us-ascii?Q?T/jDrR1joXZI6203euq0eRvtefmIlp5kCJPvf9wbuQlrmG2GrrYej95ZiHGV?=
 =?us-ascii?Q?YY8QjRts7kgz/NwBNu4A4To6Z2b2NMdyhV0vH4NOZKdCoL3kgmBTI4F5YB+/?=
 =?us-ascii?Q?9+N077ttXJ5Fm9ZgguxpU2UVGDit2gB2Obk/t55Ztv7Rzn+jRzVasx8C7kT7?=
 =?us-ascii?Q?u3Yk7RnvMRjAGmyXAPlzKRo6X6jd+Z6PPbVhRSgMnZ0qMYgif7UlGmWct0dZ?=
 =?us-ascii?Q?DVF+apfDKNVYwRY/yjWdpMxDGPmcFgYlBzn2OmeF3WHn0gVyC2gX2/15f3RT?=
 =?us-ascii?Q?d26VeXkO7SMiXoP6qUh1chmT/8suhnREiHtruCtlG5RZEYd1gWuAf+zh6E2g?=
 =?us-ascii?Q?zqF4Am1KWRn/Rq4j+GXKFgkEg7yN/04Vn0ClaZNGld8u6xjx+wjWZUHs0LoG?=
 =?us-ascii?Q?wOE9wrlnzrDIowTM1lc4QitNPNeDZXMnuVWlWAoHb4hnMtsF14BA+Bldx0SH?=
 =?us-ascii?Q?p7PsY1YbthhEoLHfkD2ayT5MP5Nd06DhHI4M5rGEP0qYZJrRflLIUrLU9Wrj?=
 =?us-ascii?Q?B4s9Yk+ibB4pubkrfJxBwAmKYJea7t26x9O17FZiSFJE2aH1xfVtvimduL1R?=
 =?us-ascii?Q?e9rrGC/lgIlvlung7ysEsBHbhIMint/PAqrPxxConamvyTV5M+lKdy4vgqoX?=
 =?us-ascii?Q?AhdnSivyZxlth3hdMD805Up4PerCKnZ4QDGs9daG9OQxAqpyN19WhDcE6Yi7?=
 =?us-ascii?Q?N8+KpRXrGHoC9JFIXKAvqHJ/Fp0ESk9wilU4sOAU604Fp94V3n4WKsnpcaE9?=
 =?us-ascii?Q?NLHJPYsynu4nWArFM0Nwe/Ms9mgxOYYNG3A1GFRKShbco+nJHadEePVx7wW1?=
 =?us-ascii?Q?jkvyYe4o2LW9785f9H9cG2dFiAWH9gPrGUf7Keij8g//rPX8ftauS299eDmF?=
 =?us-ascii?Q?hDFlaXbuNi0hsw3af38m425s7rlyVRoisrqy+Lle?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3244.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4c7920-d707-4089-8ebe-08db341a3e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 08:05:52.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1kLJt8zfAHhFOI1SWX4Qppl2ZQKEx67CgCMNqD+unSBgt3QPcbj0riBMNq2wyAMzo/6yxwDV7gCY6Y5B/I8ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-04-02 at 00:55:40 +0800, Chen Yu wrote:=20
> The system refused to do a test_resume because it found that the
> swap device has already been taken by someone else. Specificly,
> the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> do this check.
>=20
> Steps to reproduce:
>  dd if=3D/dev/zero of=3D/swapfile bs=3D$(cat /proc/meminfo |=20
>        awk '/MemTotal/ {print $2}') count=3D1024 conv=3Dnotrunc
>  mkswap /swapfile
>  swapon /swapfile
>  swap-offset /swapfile
>  echo 34816 > /sys/power/resume_offset
>  echo test_resume > /sys/power/disk
>  echo disk > /sys/power/state
>=20
>  PM: Using 3 thread(s) for compression
>  PM: Compressing and saving image data (293150 pages)...
>  PM: Image saving progress:   0%
>  PM: Image saving progress:  10%
>  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  ata1.00: configured for UDMA/100
>  ata2: SATA link down (SStatus 0 SControl 300)
>  ata5: SATA link down (SStatus 0 SControl 300)
>  ata6: SATA link down (SStatus 0 SControl 300)
>  ata3: SATA link down (SStatus 0 SControl 300)
>  ata4: SATA link down (SStatus 0 SControl 300)
>  PM: Image saving progress:  20%
>  PM: Image saving progress:  30%
>  PM: Image saving progress:  40%
>  PM: Image saving progress:  50%
>  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
>  PM: Image saving progress:  60%
>  PM: Image saving progress:  70%
>  PM: Image saving progress:  80%
>  PM: Image saving progress:  90%
>  PM: Image saving done
>  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
>  PM: S|
>  PM: hibernation: Basic memory bitmaps freed
>  PM: Image not found (code -16)
>=20
> This is because when using the swapfile as the hibernation storage,
> the block device where the swapfile is located has already been mounted
> by the OS distribution(usually been mounted as the rootfs). This is not
> an issue for normal hibernation, because software_resume()->swsusp_check(=
)
> happens before the block device(rootfs) mount. But it is a problem for th=
e
> test_resume mode. Because when test_resume happens, the block device has
> been mounted already.
>=20
> Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> problem because in test_resume stage, the processes have already been
> frozen, and the race condition described in
> Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsu=
sp_check()")
> is unlikely to happen.
>=20
> Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsu=
sp_check()")
> Reported-by: Yifan Li <yifan2.li@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>
Tested on Intel EMR, PASS.=20
Tested-by: Wendy Wang <wendy.wang@intel.com>



