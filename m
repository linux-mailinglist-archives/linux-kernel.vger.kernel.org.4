Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730DB729615
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbjFIJ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbjFIJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:57:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D090430F3;
        Fri,  9 Jun 2023 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686304162; x=1717840162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8PqdhAauomu9LDefedssY5mhzLhmtFgzheW8FstvLpw=;
  b=nvdQH3Gby+SM6WmY52DVwx/JHxhTmVUEZUB/Tq55vyWkCT9rz/1UO+fN
   ATukx2p+G0WS12HpuxigsyE/Mx/Wp09Aj01lE65YcXH23e/LC8sI43xuQ
   zNxS7aIzqEb4qy8Z7DTQBshzcnj3U62bjD7+JxXql13/8q63Z9/hd2NpG
   W19DsIBJHcIiTPMpT0MC51ydwVCLyZgnHs3ZPVbHp/Ma72kxOs6SYdalp
   6JyMNpMM3zbdIh7nJQ4ivllUooFw3XtZA7sqJfhnwHBm95UGjwaKUi5Jk
   6tRWAW/b6n6SaRYy8r5PQ7U8eZ9/qt4DyD7fimdqqhW9x1gMvTpTyRU4G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="423442707"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="423442707"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="687683784"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="687683784"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2023 02:49:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 02:49:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 02:49:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 02:49:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 02:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYz1izSFhAvUuriCfqJw56F5r5EecG/zZCiV6eOMrEmAyoEBf2MG2/0E4KhpA8d/uE/eWjc4VkrAblgWWz2IUvyGda+MD1Fw2jt/vFpT7uvgZuPJxxdyAHDF4ndLcbXqc4ERPg46MKQKxuoS0oxLYXIh1iGqcSMMdvU2wIa255PyDGs87GMFz9mlkhpPUQ3ArkqIUB012WXk6/d4pBOsyexqnevjlpZT93K3yQpOU5754S8vuqZNsHQ+oLG74lQ2halIaHl8mN/JaVBNdh2hRdL0Y4ryglmHSCtaZeTV+cCmj7zsTuMvfuMD6ZlMvitf5gBD+lCdfc1+RsEyi0LiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7ep08V5in0Wd5qXI3nMOBfyW/m/z6TEYmCL/3Mpgdw=;
 b=Ney/zaMKsoagl2JFY9GGVefmz0CHasKJQhwaHfxT12IcsXlp4j1clwriVkL9HlyI47NLZcTg83JqvWS4voSwvNUlM21pYemGegNvqHfAYo+9kYVy7xMR1ZNVbu2FCxf1Hezc0r9D+N0lEJpOsY40y0U166whjOjV9GtIvM4H0H0hxBhZkkQ9CpWxrkmUFVYh0arAjMPBw1c1hqeW0IJq7oKs/8HGB27opjSMt/iRWXNiW9MXb8g5Y/PCcS6dH/stMgdIAkr6wlD25yzzpIMsTbNdCg0f6mLbPl7Sz1fe2PsKmHVnZ7eAU7VKu0xMZiZZP5oCH9MQil04A7z0tOoDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by SA1PR11MB7129.namprd11.prod.outlook.com (2603:10b6:806:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 09:49:18 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::cf52:d7:14f9:f2bf]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::cf52:d7:14f9:f2bf%4]) with mapi id 15.20.6455.043; Fri, 9 Jun 2023
 09:49:18 +0000
From:   "Roberts, Martin" <martin.roberts@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>, Suwan Kim <suwan.kim027@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Thread-Topic: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Thread-Index: AQHZmqPojdX+pHytPUCdD+Alcr/i4q+CJE+ggAATuQCAAAFIYA==
Date:   Fri, 9 Jun 2023 09:49:18 +0000
Message-ID: <BN9PR11MB5354B884C2C89BB6AF1092B48351A@BN9PR11MB5354.namprd11.prod.outlook.com>
References: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
 <BN9PR11MB53547AEE6DAB355D5C04BFE98351A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <20230609054122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230609054122-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5354:EE_|SA1PR11MB7129:EE_
x-ms-office365-filtering-correlation-id: a2c3ac32-8a22-40f6-94e8-08db68cecb46
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2fUcTh6Lx2gaIWS8D5m6ThB3TQHVC4UmGvB/qWDXPAA+D8d42GGldoH4kmoHKX4CrwDDUePQUJbCZ6WCwARIkVb+LDp+Z5UvXt9b+IqXUEc0KtSRRbUhfJklW9mnrqztDwBt7UTUzrDqX+7Q1Q5g9EGkx6X9CAF2L1JdmhYsRYy0cDVpGWCkcRgAn0iGNKY++f/EgIw6Gg1S+NqsTgUhSgrm200GqmbilVMcfMDnQmzdWh6ImzExM24GfLy4yIf2jrkM2A0Pq4o3FEQ0lo3LwMeAeis+bs7yEnLpTl+HleByfiJgYghelWqr3DtVzTQbw0UDE1SLyiHfh64rjIsNXo9wBjmm6z18ZVpoZW4qJiBdhsSOVp/q7YPsfyOqzfKK4K9A2cZ+xEceZ4qVzNo7/1cRRFEkNdNqj1xsOFdCDVFP/TQ91AReSXiBwhWG4945UIkmfbsl0A3QM28E+7HDloaFgmgZkA/c4sEOMl5LOqTVwN8zzfVLq9I4La5T9A6kHNZcpOqI7l5o0Y/3FjL9YD2vT2cmhr/u6OQfWy9Tg4w6G4u7KsC+pIbPcO0+hm9T+BVruE8+8gssoteha1wzOey36JT+bGdyWxcv8u4yWI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(2906002)(7696005)(966005)(38070700005)(71200400001)(9686003)(55016003)(83380400001)(6506007)(53546011)(33656002)(86362001)(186003)(38100700002)(122000001)(7416002)(54906003)(5660300002)(52536014)(82960400001)(316002)(41300700001)(478600001)(4326008)(8936002)(66476007)(76116006)(64756008)(6916009)(8676002)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sTIjWGgvzAIezwkRc2EXlh3CsCxcYR815QWMIFIhQbtLp7z9wbkugx/JYc+8?=
 =?us-ascii?Q?S/fb4ls1oNXTAeR8Dtq+yHJencMi6j5nkv7SBS+sN5RA8IPzBhnV4lilJz6z?=
 =?us-ascii?Q?CbRhID5geOh2tnpP0C79gdfVQAbzfBnKp/70PgfyeWfbcwPSdTR9AVjXfdwF?=
 =?us-ascii?Q?lvo507786DwEByQ0ZVmSFiN5+Fh6wG5w2qtVquwYL89IRWSkDLwOQUYzv2Qm?=
 =?us-ascii?Q?eQrQCEbb37u2fqpmdLgCIUqqH7R8cWOJaSsXXHNrknykVyJhU+hhJ8LxcNGT?=
 =?us-ascii?Q?1mBmrLv4T9hObBIbIii0vS8uK4UeQDFfinAp6ievfWPFaEyPWJoVegmmFERi?=
 =?us-ascii?Q?4y5UdFmAY/DIbhN2YZS2gn1whQcPbCX2tRBsAOAQUw6VcpAmHPr6N3DyWrGq?=
 =?us-ascii?Q?himjMMApCs3oNwR+ZRfAlxDITrWCC/rvWBVA1Bdp1V3R9i3QyQQky8DDcsxG?=
 =?us-ascii?Q?Ws+zrWjctWmNGF2tKOmUgb2QgOjBrEjf2K7gGZsAUkEaRhqBnXWJH+vQ8dAs?=
 =?us-ascii?Q?sg8hB/ZGfa0BEUl69uqXcY5p5fueu0WudexXfNArceoM4CjfJGGOd172gIK2?=
 =?us-ascii?Q?fqu/nvI8rrhtRPKk62mRTMiFyH8lpfNjxKx/9vUt+qu0xdxZoLUIVMsDwXb8?=
 =?us-ascii?Q?nWh3vw3Mw8FhAwRFfwSf19bHyTJf88AflA/5H0eWoiOpoC87KdbskQ6VQKdn?=
 =?us-ascii?Q?KdzN2BPm2iF5+v4aeb70tWyG1qkNQiEg8unvkdRmaIBZEZIDAYHiAzn/meEI?=
 =?us-ascii?Q?9AxlW03YY79HZUR+UWP033aG5w+4aW2N61SRvRejRoH77cqeD2FWYHsezlQ8?=
 =?us-ascii?Q?1Badarhglvj6ROKHRGL6OSRP/+peL7/qjZEtQ1nm1gVMC+oYMzef0tXh8BCc?=
 =?us-ascii?Q?lwJTEEMjjLndghkerTJelOAhzf/znE+HqaANy1L3jGw7NgqH620+Q4X5PVUL?=
 =?us-ascii?Q?sC2G3C/GBRM7ueIPWcPOfFPp3liAWj9F6EZrC5vqKi2y3IPFJKLifhzSD/PY?=
 =?us-ascii?Q?J4cMeE/93XERZ4y8edUSo1iZmhCxSZL+jiN1Lb9E0Nic0CtXUxLMmiMatMO9?=
 =?us-ascii?Q?9hhb/sYUfytxhPG8swkh6eejPkMAKcYFNg3CQ5+1JP3Fg22y03ShFFaZElBa?=
 =?us-ascii?Q?v52OT/mJMDcGYD+HAkMnmWPnCtFT99rbUE/aqYnfasgmlrNi4tEYEXyVkuug?=
 =?us-ascii?Q?6j/Hu62lcKeb5y7MQ5wgVRKV2zYWUX2hLsU5H/Fx/Ou9RObeDxjuMY5BGSac?=
 =?us-ascii?Q?m6yyRyisZsbk/KbQyFFU32y12tyNUhbEUZtPwluQlSkDPL1rzZgphc+VpoY2?=
 =?us-ascii?Q?Z5MgMR+9e9oIFyFAQQOzrZh09klCbcZMqDxb27m9lJ8ntc6wnNVhg+0fdp6r?=
 =?us-ascii?Q?t49L5phImqi/Ji778yhuDJjdqtwj/UeEDE9I8WwEUYlq4/vBccEosuAxLzRh?=
 =?us-ascii?Q?O2b2F20EtzsTtyEWVHzzlk682aqcGaTjfLlF143+aDzpuOQAbKrca9Mu3xn/?=
 =?us-ascii?Q?dL97PaIjrowz7orXcB7rcy/6CXgAMDfVKOdDrUwEtU2qaPr24lix6nStjEZu?=
 =?us-ascii?Q?i+AApgZE1FvWTCywDLM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c3ac32-8a22-40f6-94e8-08db68cecb46
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 09:49:18.5824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jDyRcMJDVYG1pVN/ewnW3j/S6fk/n6vVD782Nc5Jwgeu8gU0hdl9ly8CAYV3vg2+oyvytEuURIKJErD+noGAR4E8eXBfGcnCWnWmF5sgYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7129
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I didn't realise you had updated the patch; I only looked at the first =
one.  I think you did the same as me, just changed vbr->status to virtblk_v=
br_status(vbr), in virtblk_poll().

-----Original Message-----
From: Michael S. Tsirkin <mst@redhat.com>=20
Sent: Friday, June 9, 2023 10:42 AM
To: Roberts, Martin <martin.roberts@intel.com>
Cc: linux-kernel@vger.kernel.org; lkp <lkp@intel.com>; Suwan Kim <suwan.kim=
027@gmail.com>; Jason Wang <jasowang@redhat.com>; Paolo Bonzini <pbonzini@r=
edhat.com>; Stefan Hajnoczi <stefanha@redhat.com>; Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com>; Jens Axboe <axboe@kernel.dk>; virtualization@lists.linux-fo=
undation.org; linux-block@vger.kernel.org
Subject: Re: [PATCH v2] Revert "virtio-blk: support completion batching for=
 the IRQ path"

On Fri, Jun 09, 2023 at 09:34:40AM +0000, Roberts, Martin wrote:
> I think, at some point,  vbr->status, got changed to virtblk_vbr_status(v=
br).
> If I use the version of virtblk_poll() from the patch, but substitute vir=
tblk_vbr_status(vbr), then it (patched 6.3.3) compiles OK.

Hmm v2 does not have vbr->status anymore. Are you referring to v1?

> Note, my setup never causes virtblk_poll() to be called, so its influence=
 on the issue is unknown - but maybe it also shouldn't be running in batch =
mode.
>=20
> With the patch, I've not (yet) managed to hang it - I will let it run a b=
it longer.
> Martin

Want to post the patch that works for you?

> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>=20
> Sent: Friday, June 9, 2023 8:27 AM
> To: linux-kernel@vger.kernel.org
> Cc: lkp <lkp@intel.com>; Suwan Kim <suwan.kim027@gmail.com>; Roberts, Mar=
tin <martin.roberts@intel.com>; Jason Wang <jasowang@redhat.com>; Paolo Bon=
zini <pbonzini@redhat.com>; Stefan Hajnoczi <stefanha@redhat.com>; Xuan Zhu=
o <xuanzhuo@linux.alibaba.com>; Jens Axboe <axboe@kernel.dk>; virtualizatio=
n@lists.linux-foundation.org; linux-block@vger.kernel.org
> Subject: [PATCH v2] Revert "virtio-blk: support completion batching for t=
he IRQ path"
>=20
> This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.
>=20
> This change appears to have broken things...
> We now see applications hanging during disk accesses.
> e.g.
> multi-port virtio-blk device running in h/w (FPGA)
> Host running a simple 'fio' test.
> [global]
> thread=3D1
> direct=3D1
> ioengine=3Dlibaio
> norandommap=3D1
> group_reporting=3D1
> bs=3D4K
> rw=3Dread
> iodepth=3D128
> runtime=3D1
> numjobs=3D4
> time_based
> [job0]
> filename=3D/dev/vda
> [job1]
> filename=3D/dev/vdb
> [job2]
> filename=3D/dev/vdc
> ...
> [job15]
> filename=3D/dev/vdp
>=20
> i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
> This is repeatedly run in a loop.
>=20
> After a few, normally <10 seconds, fio hangs.
> With 64 queues (16 disks), failure occurs within a few seconds; with 8 qu=
eues (2 disks) it may take ~hour before hanging.
> Last message:
> fio-3.19
> Starting 8 threads
> Jobs: 1 (f=3D1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
> I think this means at the end of the run 1 queue was left incomplete.
>=20
> 'diskstats' (run while fio is hung) shows no outstanding transactions.
> e.g.
> $ cat /proc/diskstats
> ...
> 252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 7125=
68645 0 0 0 0 0 0
> 252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 7049=
05623 0 0 0 0 0 0
> ...
>=20
> Other stats (in the h/w, and added to the virtio-blk driver ([a]virtio_qu=
eue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree, an=
d show every request had a completion, and that virtblk_request_done() neve=
r gets called.
> e.g.
> PF=3D 0                         vq=3D0           1           2           =
3
> [a]request_count     -   839416590   813148916   105586179    84988123
> [b]completion1_count -   839416590   813148916   105586179    84988123
> [c]completion2_count -           0           0           0           0
>=20
> PF=3D 1                         vq=3D0           1           2           =
3
> [a]request_count     -   823335887   812516140   104582672    75856549
> [b]completion1_count -   823335887   812516140   104582672    75856549
> [c]completion2_count -           0           0           0           0
>=20
> i.e. the issue is after the virtio-blk driver.
>=20
> This change was introduced in kernel 6.3.0.
> I am seeing this using 6.3.3.
> If I run with an earlier kernel (5.15), it does not occur.
> If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the blk_=
mq_add_to_batch()call, it does not fail.
> e.g.
> kernel 5.15 - this is OK
> virtio_blk.c,virtblk_done() [irq handler]
>                  if (likely(!blk_should_fake_timeout(req->q))) {
>                           blk_mq_complete_request(req);
>                  }
>=20
> kernel 6.3.3 - this fails
> virtio_blk.c,virtblk_handle_req() [irq handler]
>                  if (likely(!blk_should_fake_timeout(req->q))) {
>                           if (!blk_mq_complete_request_remote(req)) {
>                                   if (!blk_mq_add_to_batch(req, iob, virt=
blk_vbr_status(vbr), virtblk_complete_batch)) {
>                                            virtblk_request_done(req);    =
//this never gets called... so blk_mq_add_to_batch() must always succeed
>                                    }
>                           }
>                  }
>=20
> If I do, kernel 6.3.3 - this is OK
> virtio_blk.c,virtblk_handle_req() [irq handler]
>                  if (likely(!blk_should_fake_timeout(req->q))) {
>                           if (!blk_mq_complete_request_remote(req)) {
>                                    virtblk_request_done(req); //force thi=
s here...
>                                   if (!blk_mq_add_to_batch(req, iob, virt=
blk_vbr_status(vbr), virtblk_complete_batch)) {
>                                            virtblk_request_done(req);    =
//this never gets called... so blk_mq_add_to_batch() must always succeed
>                                    }
>                           }
>                  }
>=20
> Perhaps you might like to fix/test/revert this change...
> Martin
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306090826.C1fZmdMe-lkp@i=
ntel.com/
> Cc: Suwan Kim <suwan.kim027@gmail.com>
> Reported-by: "Roberts, Martin" <martin.roberts@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=20
> Since v1:
> 	fix build error
>=20
> Still completely untested as I'm traveling.
> Martin, Suwan, could you please test and report?
> Suwan if you have a better revert in mind pls post and
> I will be happy to drop this.
>=20
> Thanks!
>=20
>=20
>  drivers/block/virtio_blk.c | 82 +++++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2b918e28acaa..b47358da92a2 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -348,63 +348,33 @@ static inline void virtblk_request_done(struct requ=
est *req)
>  	blk_mq_end_request(req, status);
>  }
> =20
> -static void virtblk_complete_batch(struct io_comp_batch *iob)
> -{
> -	struct request *req;
> -
> -	rq_list_for_each(&iob->req_list, req) {
> -		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
> -		virtblk_cleanup_cmd(req);
> -	}
> -	blk_mq_end_request_batch(iob);
> -}
> -
> -static int virtblk_handle_req(struct virtio_blk_vq *vq,
> -			      struct io_comp_batch *iob)
> -{
> -	struct virtblk_req *vbr;
> -	int req_done =3D 0;
> -	unsigned int len;
> -
> -	while ((vbr =3D virtqueue_get_buf(vq->vq, &len)) !=3D NULL) {
> -		struct request *req =3D blk_mq_rq_from_pdu(vbr);
> -
> -		if (likely(!blk_should_fake_timeout(req->q)) &&
> -		    !blk_mq_complete_request_remote(req) &&
> -		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
> -					 virtblk_complete_batch))
> -			virtblk_request_done(req);
> -		req_done++;
> -	}
> -
> -	return req_done;
> -}
> -
>  static void virtblk_done(struct virtqueue *vq)
>  {
>  	struct virtio_blk *vblk =3D vq->vdev->priv;
> -	struct virtio_blk_vq *vblk_vq =3D &vblk->vqs[vq->index];
> -	int req_done =3D 0;
> +	bool req_done =3D false;
> +	int qid =3D vq->index;
> +	struct virtblk_req *vbr;
>  	unsigned long flags;
> -	DEFINE_IO_COMP_BATCH(iob);
> +	unsigned int len;
> =20
> -	spin_lock_irqsave(&vblk_vq->lock, flags);
> +	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
>  	do {
>  		virtqueue_disable_cb(vq);
> -		req_done +=3D virtblk_handle_req(vblk_vq, &iob);
> +		while ((vbr =3D virtqueue_get_buf(vblk->vqs[qid].vq, &len)) !=3D NULL)=
 {
> +			struct request *req =3D blk_mq_rq_from_pdu(vbr);
> =20
> +			if (likely(!blk_should_fake_timeout(req->q)))
> +				blk_mq_complete_request(req);
> +			req_done =3D true;
> +		}
>  		if (unlikely(virtqueue_is_broken(vq)))
>  			break;
>  	} while (!virtqueue_enable_cb(vq));
> =20
> -	if (req_done) {
> -		if (!rq_list_empty(iob.req_list))
> -			iob.complete(&iob);
> -
> -		/* In case queue is stopped waiting for more buffers. */
> +	/* In case queue is stopped waiting for more buffers. */
> +	if (req_done)
>  		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> -	}
> -	spin_unlock_irqrestore(&vblk_vq->lock, flags);
> +	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>  }
> =20
>  static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> @@ -1283,15 +1253,37 @@ static void virtblk_map_queues(struct blk_mq_tag_=
set *set)
>  	}
>  }
> =20
> +static void virtblk_complete_batch(struct io_comp_batch *iob)
> +{
> +	struct request *req;
> +
> +	rq_list_for_each(&iob->req_list, req) {
> +		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
> +		virtblk_cleanup_cmd(req);
> +	}
> +	blk_mq_end_request_batch(iob);
> +}
> +
>  static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch=
 *iob)
>  {
>  	struct virtio_blk *vblk =3D hctx->queue->queuedata;
>  	struct virtio_blk_vq *vq =3D get_virtio_blk_vq(hctx);
> +	struct virtblk_req *vbr;
>  	unsigned long flags;
> +	unsigned int len;
>  	int found =3D 0;
> =20
>  	spin_lock_irqsave(&vq->lock, flags);
> -	found =3D virtblk_handle_req(vq, iob);
> +
> +	while ((vbr =3D virtqueue_get_buf(vq->vq, &len)) !=3D NULL) {
> +		struct request *req =3D blk_mq_rq_from_pdu(vbr);
> +
> +		found++;
> +		if (!blk_mq_complete_request_remote(req) &&
> +		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
> +						virtblk_complete_batch))
> +			virtblk_request_done(req);
> +	}
> =20
>  	if (found)
>  		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> --=20
> MST

