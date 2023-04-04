Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840BC6D7017
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjDDWYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbjDDWYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:24:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E564481;
        Tue,  4 Apr 2023 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680647081; x=1712183081;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uOjeBJg2l86qIN3nEdo0RYU0Dqi3MfriJMN5A2fMpjw=;
  b=R6cY6XFurlfu953iNe4nMi5ThV8UOQmm39HflswN2c0d7vx4mvIQ9jKB
   EYufGSeqmibCK12nwq/xLWMHFZsEaJHn9ABhJzvIRTtCQj9vEhimk3E2C
   G3/lhJ8iyQ0Ocd6Vw3N2N5W+simdILHPfIux4dfbi+7viM2i2kQksp+cP
   KKM9044EaMuPmXK5ZS8Q1Az4pobzX3VkyrG5PGTPsVbyScBLY5ZPhMK8I
   C1C3LxXoed43fDQ9LFOFD2zszRrkBwYAsRWDhbn4Ia7js39BPytr7RNVU
   Bc6CASUs17ve0DX23lOHuMQvAenWFrJeuQJtrC8Tj6QqGE6VcIuNSpgqK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="405092699"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="405092699"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 15:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="686535891"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="686535891"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 04 Apr 2023 15:24:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 15:24:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 15:24:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 15:24:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 15:24:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjBq6UtMLsJPauiWt0MR/S2alaib5iXAYpskQLPT0H0hai3o7KSe/qMim1mh4xi6InHnEuG+bPZP6rJgzrjupB3FtfaTdHUMvGotz7Mt1yM7bby4YD9L2nf+HO9Xje8SBPVB9uQXPhcBPZeFi0D8AF90nBHLcMvsQ5os87ub90Q+5e98rHHBhDa2a3lb7C53zNmBqH9u+jyxqi/LFbtrYSNAEOuFIq15MlMONWBVnxc5Ukv6AtELgjZ0Pakmb4gw/148wV6HGrJNnF4b0bU94hlpV8nt5rf3OpmZ1EEmuM+N8dpjQTAZ9Lz/lyH2gHw8gU8sem1zYr39NxRqPwmFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muKj9ZF2/Eq7kT7VkAZJYv/TZbmLGlKKg3nqh6Pbxgo=;
 b=Rilpqq6US5NKDtnncTz8sN8g0XfN+5eMk8zUnCbPQZSlKxAJNycyEXXZKL10gFq5SL0/Kw9qQ5ionBQhNOL9r3LpRN272yKkN8UrRcZMuxcA9SbxJnp6HBE5w/dQjz+YS60uLzrwHAgvclIGCLSHEmUJgR+dZvFr+MDK9HMunhtXMROdl6Laa5mfjx8TBgB2sfirX/eJv2+l5uprPTdfkN5fX2+FXeRPFWv++qi6wyBETKbzLDsjPJ0/iRX6iz5x1RpOvYshs12WR9ojG9AoYonHj/xa3NXCxlSClUPctSAE2fNyzgUV46m/pBbm9GLzGiO2meMfxbETLUmZMI2b/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Tue, 4 Apr
 2023 22:24:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 22:24:27 +0000
Date:   Tue, 4 Apr 2023 15:24:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: RE: [PATCH v4 5/5] docs: perf: Minimal introduction the the CXL PMU
 device and driver
Message-ID: <642ca39865e8b_21a8294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
 <20230330164556.31533-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330164556.31533-6-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b3629f-1a7b-4584-620d-08db355b5a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zd/fyptUQbxlXCAkYiXnb/OJIGju4wseoveUE5FVs2rduT6KMCGT9KnL0KIPvQvkZSWRAaDxr5IT3UzlxDVSm4pouMvoG20Yozkw2+5xHRNDA8u9xX67pCtVrPAL9nfQrIC8qysDuzHAv77wngn96Kg6pPcRLRdlETKY+QhPtSupBeffi7Fne4O61fxH0McEAi+VS3slIU0biAqpFzdbh3L53eCiEP+2WkIKf9bvR8wFZu7L/BfwNWxn/eoUhcUHO/ERsgEEom//qgdaajcRYfsktcbv/couqBMG/U3MAutxY1CzbRv8XgmdNzXsKj2TEKYrvqH7fTujEa4iOXgtXENNwAQQ3Eb8J/wNTq9W5PxAZSo4esqOO8A88UBN56bDwlDc7UN0SM8kv8iG22i+jY0KXcLvKf9GA7LKL2uCpSfguidRLSfZLbUQH2HtYqSY793zEPuofYBr9hahQC74JeNt7p4YZ5WYhUz8D7lBvuBg6ocugouC5rVLAszVqH80sg+NeAN1RhB6aOfUyhP+wfQOozCquuC65swfVGfD5keuIPG/OiMxp8wXuDWCVjAV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(6512007)(6506007)(26005)(6666004)(9686003)(86362001)(478600001)(186003)(7416002)(8676002)(38100700002)(66946007)(66556008)(2906002)(66476007)(83380400001)(6486002)(5660300002)(82960400001)(8936002)(4326008)(316002)(110136005)(41300700001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T0fUNhowrTw49VM4z6wOoI6PLT4dHwqNbqCvgGAJxzEnIKPU1Xq3M/lg18V3?=
 =?us-ascii?Q?AD0dkz7oqy2AiwPs3qBMNWYbL0IDVNemEIQCj9G5KdZ7a1ohqzbAF/HE5q3m?=
 =?us-ascii?Q?YFZTesFyrTsc8guHxoisn7upJaRb43rcTUOHIbWwMHfzxLSyvi8Uou/wGt2J?=
 =?us-ascii?Q?/JAWmWc75UKitTihxRK/f4FhJw+5cF7sBCCqpY9gJBH+m2C4NSIeF/yza0w0?=
 =?us-ascii?Q?/c+4qjxlh9eNiGEHk1lWrFltC+Wm4PhFmRHvjToGBnQSJ+dTDrWOWtANEVao?=
 =?us-ascii?Q?VTfguMu+SP89aZh0tKxC2yS9UH7Fhaez6rAUS9stgs7ZGHXPm3SW/tYz9aQe?=
 =?us-ascii?Q?9AhKlpt7aWZmHptrXaaV9oUNnlpc5KEpTXsDP6ITispEuYkM592UnfkBUzoV?=
 =?us-ascii?Q?I+PZTyuY+r9GpEeEQ2jF/TKCtGZuCpW3oXGKo1eVnoErV3Elg4Uq32PnvsTj?=
 =?us-ascii?Q?D0gd+vZlRWkJ1jZb8q9WT3GWEBaXQWxMDbnDB/j9gEkXRcTJu5lZEU6VqZHp?=
 =?us-ascii?Q?3D79IxiNiDx/639LvkgtekQStR+HmCjAwgSoitZrZEqBdZlIpehLUob/WYH0?=
 =?us-ascii?Q?2YTtjcttotSLsO/0alJrwizdrKjtjDgNDgkr7WrgOrwQ4ezFWhR28NtcelH8?=
 =?us-ascii?Q?rO2e34Oim/bud+n9f7NP0iJsheuGtgu3DGdSaSzSezysde92tEvlawPbsm4O?=
 =?us-ascii?Q?b5S8ijD9+DSnGLMgxgFu8o0oufXGATNBIuJPijjDbjw5jsJbwXxhApw1PwSp?=
 =?us-ascii?Q?6uiUWar8HOrXbUI14kc5UA5iiRzuO7JGcL9YOzFKhBB5n9ErftVSffprzga3?=
 =?us-ascii?Q?f6AZ7CY239bjitM3oHQvpnH1MJXZB87o3JFA8hdyTucVCHCCLUs05ocT87bB?=
 =?us-ascii?Q?Yhc+Ehfe8HMAG3KRDOmzhnyOqKdRARDu91pf3dwVukmW6ZJZWTxBnFJ9dKPZ?=
 =?us-ascii?Q?w0Ocl+/Fuk7etpQ1w2yrOfDVhigF5pT6FE5IKjFiMZPssTU1DnAmR8ibugkh?=
 =?us-ascii?Q?yi6AxwPjtSfz9oyRu4mXeexQDAIDbL+dkQgNSchZIR4ZhD0NoUef9dPTjHe+?=
 =?us-ascii?Q?FuQKN3vnNOWWqUT6J1uWu5stwDBJfBHKb1GVjav3tqqdgV5lpCAfZUMs/rY9?=
 =?us-ascii?Q?tUp5pHymo4YRHA3P5ys+qdCcFE1sttsPwyk1wy8a9NnUM7X5FJYO3n8cZWyt?=
 =?us-ascii?Q?Aq/puCQmxkFA4ruS+0/f+xnCct/Zdf+B0pbDNbw3KuqctPNkBfct29+zgRAg?=
 =?us-ascii?Q?Ma0a55dAhWReMiDb5MaNd6wIau6CTnRblelAVDFE9grRIiTbMhlRGy1+oMOr?=
 =?us-ascii?Q?q7CLa1+G9ri7KpT3JVIl6PrXoMAzq4iOjFhz4Dm+yPKqV6Me8JJ8Bg0xPjlo?=
 =?us-ascii?Q?UQAqNyuW24H/ns4HfrWE8n4vvxsF5xpW8C/2KaYDCJLeiyHt1Bk4sP22X79E?=
 =?us-ascii?Q?opp0f/D8fN6kkU7WopuZxsiJjQ/lGj76rzinkDJcuu9YdQGSeR/TyZjd35Sw?=
 =?us-ascii?Q?GHvXyMuaBU2A5Y+Gxwqdr1uuQ2oBoij1wCw2lqvPGsZvWej9UwaWmSWSRnfL?=
 =?us-ascii?Q?bFfxLj01dfjVEmjIpxxE55eyBMcAyAJSTWn7h7PkBZMNHJk0UxL+IA7GNrpR?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b3629f-1a7b-4584-620d-08db355b5a2a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 22:24:27.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xu2uVSxNb3xuLvK1BBP4PFedjmWrmBcF4UO/cUzwflNYcwZ/92hEcT5hbYn9Jeqg1BuVir0lwUTHd8AhJ3txi1LBZq45v1Gk09ICp9iy7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> Very basic introduction to the device and the current driver support
> provided. I expect to expand on this in future versions of this patch
> set.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --
> v4: No change
> ---
>  Documentation/admin-guide/perf/cxl.rst   | 65 ++++++++++++++++++++++++
>  Documentation/admin-guide/perf/index.rst |  1 +
>  2 files changed, 66 insertions(+)
> 
> diff --git a/Documentation/admin-guide/perf/cxl.rst b/Documentation/admin-guide/perf/cxl.rst
> new file mode 100644
> index 000000000000..46235dff4b21
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/cxl.rst
> @@ -0,0 +1,65 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +CXL Performance Monitoring Unit (CPMU)
> +======================================
> +
> +The CXL rev 3.0 specification provides a definition of CXL Performance
> +Monitoring Unit in section 13.2: Performance Monitoring.
> +
> +CXL components (e.g. Root Port, Switch Upstream Port, End Point) may have
> +any number of CPMU instances. CPMU capabilities are fully discoverable from
> +the devices. The specification provides event definitions for all CXL protocol
> +message types and a set of additional events for things commonly counted on
> +CXL devices (e.g. DRAM events).
> +
> +CPMU driver
> +===========
> +
> +The CPMU driver register a perf PMU with the name cpmu<id> on the CXL bus.

s/register/registers/

> +
> +    /sys/bus/cxl/device/cpmu<id>
> +
> +The associated PMU is registered as
> +
> +   /sys/bus/event_sources/devices/cpmu<id>
> +
> +In common with other CXL bus devices, the id has no specific meaning and the
> +relationship to specific CXL device should be established via the device parent
> +of the device on the CXL bus.

So I went to go add some text about how to identify PMUs in a persistent
manner from one boot to the next. For CXL memdevs this is done by the
'serial' attribute which is always stable regardless of the device init
order. That's harder to get to from the pmu device because it may be
associated with a device that does not have a memdev.

I think it's also going to be frustrating for userspace to see
randomized pmu ids across devices since that probing will happen in
parallel. So how about:

1/ Add serial as an attribute for each PMU to export
2/ Change the device name format to be "pmuX.Y" where X can just reuse
the memdev id for endpoints and be another value for switches, and Y is
guaranteed to be 0-based and in hardware discovery order.

...with that, someone can write a udev script that can persistently
identify PMU[Y] on device[serial] each boot.

That also cleans up a /sys/bus/cxl/devices listing to make it clear
which pmu instances belong together.
 
> +
> +PMU driver provides description of available events and filter options in sysfs.
> +
> +The "format" directory describes all formats of the config (event vendor id,
> +group id and mask) config1 (threshold, filter enables) and config2 (filter
> +parameters) fields of the perf_event_attr structure.  The "events" directory
> +describes all documented events show in perf list.
> +
> +The events shown in perf list are the most fine grained events with a single
> +bit of the event mask set. More general events may be enable by setting
> +multiple mask bits in config. For example, all Device to Host Read Requests
> +may be captured on a single counter by setting the bits for all of
> +
> +* d2h_req_rdcurr
> +* d2h_req_rdown
> +* d2h_req_rdshared
> +* d2h_req_rdany
> +* d2h_req_rdownnodata
> +
> +Example of usage::
> +
> +  $#perf list
> +  cpmu0/clock_ticks/                                 [Kernel PMU event]
> +  cpmu0/d2h_req_itomwr/                              [Kernel PMU event]
> +  cpmu0/d2h_req_rdany/                               [Kernel PMU event]
> +  cpmu0/d2h_req_rdcurr/                              [Kernel PMU event]
> +  -----------------------------------------------------------
> +
> +  $# perf stat -e cpmu0/clock_ticks/ -e cpmu0/d2h_req_itowrm/

Ah here's the examples I was looking for in the last patch, nice.

> +
> +Vendor specific events may also be available and if so can be used via
> +
> +  $# perf stat -e cpmu0/vid=VID,gid=GID,mask=MASK/
> +
> +The driver does not support sampling. So "perf record" and attaching to
> +a task are unsupported.

Is this a common restriction for CPU-external pmus, or do you see
sampling support required to get this upstream?
