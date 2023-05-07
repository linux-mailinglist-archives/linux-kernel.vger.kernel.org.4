Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD746F9772
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 10:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjEGIIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 04:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGIIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 04:08:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB97AD03
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683446917; x=1714982917;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JZYElODHZ9qjIeR1q2/AU/wIq6mbxZT8sekjzPZeJts=;
  b=lFigfyqA5et8nQWIFYdN8t7NaXj9B6SLsTnQjdLbhopK9+WwbA1J0SmA
   NnAonFMiNGczlAYnkMkwCQYmynw4mNBwRY4fs1W7t/4TZqV6v4eo85goN
   Zd6SsQknlJwDT8iwg6I7D9oQXpBhy8nPoegf+x+yR/SapOreeiA6TgwU2
   48oGbms2gkpEIdVQi1W8d70Zhbnbqt1MGyf9Lotr2GTenGXr8lDYBsJRv
   uUqB2uHSdO7O0WLEQrkjpxc3CVRtN7J+/7aH+2YWXL8MGhbVPk7fD+9Im
   b+TrBBYoDyXEb4rTChEO6pL99SaaEsQ3Y9xjpJjPVhYgkQXAc9w3n2+oe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="329817469"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="329817469"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 01:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="675689488"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="675689488"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 07 May 2023 01:08:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 7 May 2023 01:08:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 7 May 2023 01:08:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 7 May 2023 01:08:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 7 May 2023 01:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS0Lozg65kcZ4cFccfv32Zeo4YSys3RazZlZEPOtjpxE1kKo7h1iyrxO6U0+4T87A98UcjMqfJ8TKaw6oxoGi08KBJAUy0KLuF42zOIUAs/o++hDreRgSrUrwl+NdiNRJLnFLZVd43G3OfQ7Vu8bHmxqudn0VO2+G7/VmZFsIJJBG2gJ2p0Q6cFcn6kJlNv4phL3TzgMgMhM2RanEAH4Ixk8IoKe19/+h3xfVAx4fO1vtwBy700okR9DYxmwvb+laKijzMXnWcAt8hcoJ4fDivjX4A3I3NBvrLYNm5cV6t2vs7IUPplyaVStraGqCNkr1QeRBfl6+YHhKsQjJwJbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qwznAsdeYiq107HfW9rttSLxxRQQZ75sx+E+eZtIdM=;
 b=kxdadunDuBwT4U2Vk3wSTZdpRRmRK5udIb7vbP/QFuVlF9lyrxMXVTtCyj4I/CLbUczB5NJMBMq80fzB797gJoTybJ3adgA75o5YRJxhNYAlenJKR6vm/wGKpHrDD+/n4SFxisyiVqruXw432leCyVy7OU8SChKG28gX2k13Gk6epJ9Mj6QJQUfDHHK16w1jChXGSRjIf5d3W0FIAZ2m9a8duQsbi7xVkU6FZtp05MZ8zkRigMCZ7u4FMdDXnHXZKaM5fcjFGJZzRYqp4uyG70yIezOQroZavYN/j9wRmWNQ2IJJFTLa77eBi/B8rphgPpMBzx/zm6d+3JvDdpZVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 BL1PR11MB5511.namprd11.prod.outlook.com (2603:10b6:208:317::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.31; Sun, 7 May 2023 08:08:33 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::bf39:1326:e68e:2ebf]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::bf39:1326:e68e:2ebf%2]) with mapi id 15.20.6363.031; Sun, 7 May 2023
 08:08:33 +0000
Date:   Sun, 7 May 2023 16:05:10 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Shanker Donthineni <sdonthineni@nvidia.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael Walle" <michael@walle.cc>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors
 management
Message-ID: <ZFdbtipfTsIF0u6z@yujie-X299>
References: <202304251035.19367560-yujie.liu@intel.com>
 <87a5yuzvzd.ffs@tglx>
 <ZEsiYbi8dorXTI5t@yujie-X299>
 <877ctw5mdp.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <877ctw5mdp.ffs@tglx>
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To DS0PR11MB6397.namprd11.prod.outlook.com
 (2603:10b6:8:ca::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6397:EE_|BL1PR11MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd6a4ed-4696-44a9-2fc2-08db4ed23fac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+0IpMfrNA4MkbxNAh3NUS5jBP7EeShSj5hjEn9K50GUkMQGcQCQaev+xrRn2/vMvG/np07qTOw7Fcuyt+TMqAgVP2suI9+zX9dsuN2/1ZuQZ4ibSDZVRojwkjoz45A68L5mCTs4V9e4umpRsjM3Ot7sarrDkp/P4SupcztExtZ0JPz0g3loZn8nOFv7lcbNbf6XvkkrPtnR123y0kr38WDy23hoL2dmG1CDsA3mv1YqJVGPzR1mLePSR+I6ngU72nah4LHl5S20sA+RLs6AdbXl+angV0fsV7AFobh10hG8/0Le9zoFZzGa+1jZ+onfdHFfzQzmK7bMXH+8CTG+NAezat/P8oKSkemdm4IVRCVrPH74xEDLTmFH5vdnFAZqIm1xCE8Bs0rZn06gWlPE91AnYWHJZdlFDC8kv4jdIJ3H2CJYay2KoOwHxRedwaVWkoEcTfdv7Pd5kaPigX8sSc8ezLMsVhLjSDGzexJqPPX0cdGZoiwMoueD9eFbzpCJrAhTT0jcdsBRkUBh1B0yUiFTwtboN9T+IQwR8zqH9mlRdfbB/Sk6lnuj4SVKzI9C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(33716001)(44832011)(8676002)(8936002)(5660300002)(41300700001)(316002)(6916009)(4326008)(83380400001)(9686003)(66476007)(66556008)(66946007)(26005)(186003)(6666004)(6486002)(478600001)(2906002)(86362001)(82960400001)(38100700002)(6512007)(6506007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gHfxpow9HFifAsuyWOwcSF1CfQ+MLv2sht/HaXYEZSUMjgX8nwDwixobDr/r?=
 =?us-ascii?Q?hN2Mxhxe4g1kNM4GyyhSzAWkA7QAbSSZIkcdHRArG5/TtBopTkLy/uc2z09E?=
 =?us-ascii?Q?5FAM0JxLexgK/6A3826oBLgg/x8+CphHoktb1+gf99WY6rRKPQT2jitSPDGS?=
 =?us-ascii?Q?DOfcIcM/17d7Q0ksa2qQR2qN4MU6GJACqa6uxNE5CSgIAVUSLZ1WM87nFSHg?=
 =?us-ascii?Q?EO5cocy4/sHtHPHTtrUHbwJrRZ0rXNEIvGYcLxyS4Rp0eJ9NR2zWkkLAft5M?=
 =?us-ascii?Q?x3PuMINoDqx6D8gVpndumLe5IpN777ZFzdBaX8qAPUfum/4CvD50eXuZB1/h?=
 =?us-ascii?Q?160mS439raRAjuWTQMFJDYr8D/PNv79ddCsgkUnBeH5pjY6JnQfr20cZZj5/?=
 =?us-ascii?Q?gx4EYcKcZ9EEnHMQGY+OK1hQDlRL75EqVb2JHHPLXsKcS3PnDplBti71lKbF?=
 =?us-ascii?Q?0S3FqRjcCEyHbXdM1WS4+SqP+Euojnf9b2tXDcj6EcsPNCAGlSIFPtLSVACw?=
 =?us-ascii?Q?NU6eKOQWxLCHupSJvBzEKwv81VzcBWqhFfAKcQS0lQMu0i7LG+CcbzIUkJaF?=
 =?us-ascii?Q?ruBB8x5EQd77wynD1PabDkubfd9r1A7rICvscMZPK8vnLdSvx9/iY6ry/2r8?=
 =?us-ascii?Q?ii/Ro5aoBrbZtU3ZLBodbxc6Wv/tgD8qc4bzwKSCWUKdMi692YUUgz1fdT5E?=
 =?us-ascii?Q?30CdqBbiERcGjN+WCX8Gm0YiYjgqbNfuYwcfTBvLaFE0zC0l2QMFv3lpvm7h?=
 =?us-ascii?Q?AYR049nLf61eZIy9ulpXN1YqoTYkLLj51hxnETyZgsHw30immg2zkeM1Nxmq?=
 =?us-ascii?Q?gvI0ix07Cl0pDLo6BlpZcuKaADaknYDiifEZUuLjzGZLETbBP3Ha9qsRIfME?=
 =?us-ascii?Q?nNYykipYAfzm0jzfbndpHC2x+E9/CtOpvBYtQOcdN8bcVBbrBP6t1UHfxXPL?=
 =?us-ascii?Q?1SU4TmoU7vWkefr2C7LpU2fsG8739TLZq8ViqDXZ80G/vPZAfrJ2Gtdt9QAE?=
 =?us-ascii?Q?z9YMhY2ZCPr4S24zt+ogJrQvi/lVlaXZlU5Z07/VuIsjuX1JVD0AYCX9wnZz?=
 =?us-ascii?Q?VafLVUN4t8WevWXItqpWCHllGUo/SQr6hfAmXjylf/YPuIocOY5wlKS7rvIm?=
 =?us-ascii?Q?ZlFos0U82Wpjj7OVGAKaT19CKn8P5KC4s89Tvp5vRJtaldz9akufRDS8B4ll?=
 =?us-ascii?Q?Z1+bRJl/SqM3fKJicKBCGr26IvAVUUFLO6rgc2vGJ0tSn963vTCILzoAm8ap?=
 =?us-ascii?Q?vLhrNRNqX7lQ2Ic4NMfA+pKE4wyigt1Mq/N86ll9pZiGohTlt7mZ94S78DRd?=
 =?us-ascii?Q?iYvLMW7S7Ybaa3DtVOpZDYM5RNcZUx/oVsWTHFidD6GNT3qxC9kxf7xwJNPj?=
 =?us-ascii?Q?4uqeiqsZxjGZ/5t7Bsc2hvddxY8RARR7cHv/R9dsdNRFLU5mJXcKQnOoFg41?=
 =?us-ascii?Q?iyZDWdrzH8iP5Rt2qDjGvpHFyEYhWwHxXvcsz3f7jLvzCQs8zF5J9Vdaf9nY?=
 =?us-ascii?Q?v3bME1d4BSnVbEscChhvPmUroSjSWA2qEyc/L64ifnRNKX60d82oR+k7AiWc?=
 =?us-ascii?Q?N/7p5lb18sxzjQaviXIMDuxaPXyHAE2taZBqWRh0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd6a4ed-4696-44a9-2fc2-08db4ed23fac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2023 08:08:32.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXjUOpCQC5sTga6/xUcNTUc7KQRAYC/eM/uABzuLNSVRJW5DbhBFH7OWm/c+Z2glV0YsP9x0QY46/rKK/eOfdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Sorry for late reply as we were on public holiday earlier this week.

On Fri, Apr 28, 2023 at 12:31:14PM +0200, Thomas Gleixner wrote:
> On Fri, Apr 28 2023 at 09:33, Yujie Liu wrote:
> > On Wed, Apr 26, 2023 at 02:08:54PM +0200, Thomas Gleixner wrote:
> >> Can you please retest this on v6.3 and report back when the problem
> >> persists?
> >
> > Thanks for your help looking into this problem.
> >
> > The problem persists when tested on v6.3, but not 100% reproducible.
> > We ran the test on v6.3 and v6.3+patch each for 20 runs. There are 9
> > failed runs on v6.3+patch, while v6.3 is all clean. Full dmesg is
> > attached.
>=20
> Under the assumption that the code is correct, then the effect of this
> patch is that it changes the timing. Sigh.
>=20
>   1) Does this happen with a 64-bit kernel too?

It doesn't happen on a 64-bit kernel:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit/compiler/disk/kconfig/rootfs/tbox_group/test/testcase:
  32c58fc685e5cd6b5947a5f8e9a3c318a63fcf0a/gcc-11/1SSD/i386-debian-10.3-fun=
c/debian-11.1-i386-20220923.cgz/lkp-skl-d06/block-group-00/blktests

commit/compiler/disk/kconfig/rootfs/tbox_group/test/testcase:
  32c58fc685e5cd6b5947a5f8e9a3c318a63fcf0a/gcc-11/1SSD/x86_64-rhel-8.3-func=
/debian-11.1-x86_64-20220510.cgz/lkp-skl-d06/block-group-00/blktests

kconfig:
  i386-debian-10.3-func
  x86_64-rhel-8.3-func

i386-debian-10.3        x86_64-rhel-8.3-func
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         16:48         -33%            :7     dmesg.EIP:default_send_IPI_ma=
sk_logical
         16:48         -33%            :7     dmesg.WARNING:at_arch/x86/ker=
nel/apic/ipi.c:#default_send_IPI_mask_logical

>   2) Can you enable the irq_vector:vector_*.* tracepoints and provide
>      the trace?

I'm a beginner of kernel and not sure if I'm doing this correctly. Here
are my test steps:

# enable irq_vector events
# cat /sys/kernel/debug/tracing/set_event
irq_vectors:vector_free_moved
irq_vectors:vector_setup
irq_vectors:vector_teardown
irq_vectors:vector_deactivate
irq_vectors:vector_activate
irq_vectors:vector_alloc_managed
irq_vectors:vector_alloc
irq_vectors:vector_reserve
irq_vectors:vector_reserve_managed
irq_vectors:vector_clear
irq_vectors:vector_update
irq_vectors:vector_config

# turn on the tracer
# cat /sys/kernel/debug/tracing/tracing_on
1

# run the testcase
# ./check block/008
block/008 =3D> sdb2 (do IO while hotplugging CPUs)
    read iops  0       ...
    runtime    0.576s  ...

block/008 =3D> sdb2 (do IO while hotplugging CPUs)             [failed]
    read iops  0       ...  0d06 at May  7 07:33:46 ...
    runtime    0.576s  ...  0.580sommon_interrupt: 2.34 No irq handler for =
vector
    --- tests/block/008.out     2023-04-18 17:36:53.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/sdb2/block/008.out.bad 2023-05-07 =
07:33:47.336596084 +0000
    @@ -1,2 +1,8 @@
     Running block/008
    +fio: io_u error on file /dev/sdb2: Input/output error: read offset=3D2=
73571840, buflen=3D4096
    +fio: io_u error on file /dev/sdb2: Input/output error: read offset=3D6=
4757760, buflen=3D4096
    +fio: io_u error on file /dev/sdb2: Input/output error: read offset=3D7=
00571648, buflen=3D4096
    +fio: io_u error on file /dev/sdb2: Input/output error: read offset=3D1=
05357312, buflen=3D4096
    +fio exited with status 0
    +4;fio-3.25;reads;0;5;0;0;0;0;0;0;0.000000;0.000000;0;0;0.000000;0.0000=
00;1.000000%=3D0;5.000000%=3D0;10.000000%=3D0;20.000000%=3D0;30.000000%=3D0=
;40.000000%=3D0;50.000000%=3D0;60.000000%=3D0;70.000000%=3D0;80.000000%=3D0=
;90.000000%=3D0;95.000000%=3D0;99.000000%=3D0;99.500000%=3D0;99.900000%=3D0=
;99.950000%=3D0;99.990000%=3D0;0%=3D0;0%=3D0;0%=3D0;0;0;0.000000;0.000000;0=
;0;0.000000%;0.000000;0.000000;0;0;0;0;0;0;0.000000;0.000000;0;0;0.000000;0=
.000000;1.000000%=3D0;5.000000%=3D0;10.000000%=3D0;20.000000%=3D0;30.000000=
%=3D0;40.000000%=3D0;50.000000%=3D0;60.000000%=3D0;70.000000%=3D0;80.000000=
%=3D0;90.000000%=3D0;95.000000%=3D0;99.000000%=3D0;99.500000%=3D0;99.900000=
%=3D0;99.950000%=3D0;99.990000%=3D0;0%=3D0;0%=3D0;0%=3D0;0;0;0.000000;0.000=
000;0;0;0.000000%;0.000000;0.000000;0;0;0;0;0;0;0.000000;0.000000;0;0;0.000=
000;0.000000;1.000000%=3D0;5.000000%=3D0;10.000000%=3D0;20.000000%=3D0;30.0=
00000%=3D0;40.000000%=3D0;50.000000%=3D0;60.000000%=3D0;70.000000%=3D0;80.0=
00000%=3D0;90.000000%=3D0;95.000000%=3D0;99.000000%=3D0;99.500000%=3D0;99.9=
00000%=3D0;99.950000%=3D0;99.990000%=3D0;0%=3D0;0%=3D0;0%=3D0;0;0;0.000000;=
0.000000;0;0;0.000000%;0.000000;0.000000;0.000000%;0.000000%;12;0;163;100.0=
%;0.0%;0.0%;0.0%;0.0%;0.0%;0.0%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0=
.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00=
%;0.00%;0.00%;sdb;0;0;0;0;0;0;0;0.00%
    ...
    (Run 'diff -u tests/block/008.out /lkp/benchmarks/blktests/results/sdb2=
/block/008.out.bad' to see the entire diff)

# check the trace
# cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 0/0   #P:4
#
#                                _-----=3D> irqs-off/BH-disabled
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| / _-=3D> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |

Nothing was written to trace buffer, seems like no irq_vector events
were captured during this test.

> And please provide /proc/interrupts from that machine.

Before running the test:

# cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   0:         34          0          0          0   IO-APIC    2-edge      =
timer
   1:          4          0          0          0   IO-APIC    1-edge      =
i8042
   4:          0          0        635          0   IO-APIC    4-edge      =
ttyS0
   8:          0          0          0          0   IO-APIC    8-edge      =
rtc0
   9:          0          0          0          0   IO-APIC    9-fasteoi   =
acpi
  12:          0          0          0          6   IO-APIC   12-edge      =
i8042
  16:          0          0          0          4   IO-APIC   16-fasteoi   =
i801_smbus
  19:         12          0          0          0   IO-APIC   19-fasteoi
 120:       3608          0        617          0  PCI-MSI-0000:00:1f.6    =
0-edge      eth0
 121:         50          0          0          0  PCI-MSI-0000:00:16.0    =
0-edge      mei_me
 122:          0          0          0          0  PCI-MSI-0000:00:14.0    =
0-edge      xhci_hcd
 123:          0          0    2109981          0  PCI-MSI-0000:00:17.0    =
0-edge      ahci[0000:00:17.0]
 124:          0          0          0        206  PCI-MSI-0000:00:02.0    =
0-edge      i915
 NMI:          0          0          0          0   Non-maskable interrupts
 LOC:     221252     228764     471985     229286   Local timer interrupts
 SPU:          0          0          0          0   Spurious interrupts
 PMI:          0          0          0          0   Performance monitoring =
interrupts
 IWI:         16          0          0          8   IRQ work interrupts
 RTR:        108         25         15         11   APIC ICR read retries
 RES:       5016       5486        697      10440   Rescheduling interrupts
 CAL:       4618       4578       2775       5754   Function call interrupt=
s
 TLB:         12         15         14         18   TLB shootdowns
 TRM:          0          0          0          0   Thermal event interrupt=
s
 THR:          0          0          0          0   Threshold APIC interrup=
ts
 MCE:          0          0          0          0   Machine check exception=
s
 MCP:          4        108        109        107   Machine check polls
 ERR:          0
 MIS:          0
 PIN:          0          0          0          0   Posted-interrupt notifi=
cation event
 NPI:          0          0          0          0   Nested posted-interrupt=
 event
 PIW:          0          0          0          0   Posted-interrupt wakeup=
 event

After running the test:

# cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   0:         34          0          0          0   IO-APIC    2-edge      =
timer
   1:          4          0          0          0   IO-APIC    1-edge      =
i8042
   4:          0          0        635          0   IO-APIC    4-edge      =
ttyS0
   8:          0          0          0          0   IO-APIC    8-edge      =
rtc0
   9:          0          0          0          0   IO-APIC    9-fasteoi   =
acpi
  12:          0          0          0          6   IO-APIC   12-edge      =
i8042
  16:          0          0          0          4   IO-APIC   16-fasteoi   =
i801_smbus
  19:         12          0          0          0   IO-APIC   19-fasteoi
 120:       3807          0        617          0  PCI-MSI-0000:00:1f.6    =
0-edge      eth0
 121:         50          0          0          0  PCI-MSI-0000:00:16.0    =
0-edge      mei_me
 122:          0          0          0          0  PCI-MSI-0000:00:14.0    =
0-edge      xhci_hcd
 123:          0          0    2109981          0  PCI-MSI-0000:00:17.0    =
0-edge      ahci[0000:00:17.0]
 124:          0          0          0        206  PCI-MSI-0000:00:02.0    =
0-edge      i915
 NMI:          0          0          0          0   Non-maskable interrupts
 LOC:     221568     228973     472239     229475   Local timer interrupts
 SPU:          0          0          0          0   Spurious interrupts
 PMI:          0          0          0          0   Performance monitoring =
interrupts
 IWI:         16          0          0          8   IRQ work interrupts
 RTR:        108         25         16         11   APIC ICR read retries
 RES:       5017       5488        698      10440   Rescheduling interrupts
 CAL:       4622       4584       2783       5757   Function call interrupt=
s
 TLB:         12         15         15         19   TLB shootdowns
 TRM:          0          0          0          0   Thermal event interrupt=
s
 THR:          0          0          0          0   Threshold APIC interrup=
ts
 MCE:          0          0          0          0   Machine check exception=
s
 MCP:          4        108        109        109   Machine check polls
 ERR:          0
 MIS:          0
 PIN:          0          0          0          0   Posted-interrupt notifi=
cation event
 NPI:          0          0          0          0   Nested posted-interrupt=
 event
 PIW:          0          0          0          0   Posted-interrupt wakeup=
 event


Thanks again for taking the time to look into this.

--
Best Regards,
Yujie
