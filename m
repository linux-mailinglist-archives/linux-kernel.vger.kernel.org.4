Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A976D8CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDFBUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjDFBUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:20:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D87281;
        Wed,  5 Apr 2023 18:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680744029; x=1712280029;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f6d4HgOWPfXA5lrM8xYxjNOBS3U6kLe/4oXmPj61WK0=;
  b=NT3raorhuxVAqPLmOeCamkV3aQcp2jGUJTurou+K2KJ8XLaVakvxcmN+
   0iEIh7SeOq8i6HzlUtHK2w323X8tUEw1QZUlT7hOu2aykr3vdrJQBZ9PW
   MMGIIp6p//kh6oOCujzNLI+Aa+uPJS7XZprFv+u1r8A3QgBjOqCf352zT
   zeorewffNUGxwimpJ6SIH4NMbsLIBpj7E/YhXPk8n6pYtpRWCsaI/SzL+
   X6Y2azld3KGJse2xfRHhiHgYA2D2eWtsFC/oRTXStCn1Gt7JgHgwrnB8/
   Emp4IK5esCmelKEVSyFK55S4IkodT0XXwT/FANRjwAcQ0+8l0U1MN4VDA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="345201744"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="345201744"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 18:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="810813034"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="810813034"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 05 Apr 2023 18:20:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 18:20:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 18:20:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 18:20:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 18:20:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJxUA6SvpwFx+UFE01+kLCQTmZwIstc8VixDubPwMUPcC6R7NHuQCco/PLl9zXbGvoKagFO/Da3CnhqeF8R0VORmsq7MCK6Qft5+90FK102sk0kyhrkADuZamKZuvDJzWod3xDjx6iJtcr/L5+pDms0ssSf93nywkZm8JqPtxVB+Dp7NQDXCsKIFa0U5+iXsn+WzGfKVvLE2Tt2BE/o2GxtX87zO18G/fl5YFtcoMFQ0Q++c+RnXOp+nC8b0xoi3ceqfc7RI89ZVOh7v9Sm07Mt/hlUeRnJ6+kIwfb0qlaEymaAWafjmsdNTv36hW4voUo41UKix7JckpxnbJZwe3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjCEUtj1Knl53CZVuRJ+3Yl/BGYdIUuNdQORk9vwdlo=;
 b=LXfbEp1DkQAvSQABgF0TqvRvWXgdu54anX3FETmErCZZZN0qAuSMi2A12vrF3FJBn93uXfOxh0JFd2riZdxZ8RpOj9WCYUgpGXRMxFjxdfcin+5PeBh8tpWVZ8UkCtpGf9+AQlpYz9X+SFhvauHlc3waxl9T5bOJ1A1c5+BnDSHOvMEAJ/SrQxSMIIns6T/TFQ/pIvjuXhz0T9Gaa4rPFGqM0eyG45uddxLnJA9qRA8b9CEyHzf7Y1IJ+Uj6gab6I9Sre+DWd09uvjAkCbedjiKfwsj6bNP4GdI4Zb97jMwlqF5XnQjZ/9ey7GOPFJbjpqiIVtYaEqyOhZjUTj7ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB8129.namprd11.prod.outlook.com (2603:10b6:8:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 01:20:23 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 01:20:23 +0000
Date:   Thu, 6 Apr 2023 09:14:27 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
CC:     Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>, <dave.hansen@intel.com>,
        <ying.huang@intel.com>, <tim.c.chen@intel.com>,
        <andi.kleen@intel.com>
Subject: Re: [PATCH v3] Documentation: Add document for false sharing
Message-ID: <ZC4c8615XM8dfxa+@feng-clx>
References: <20230404052228.15788-1-feng.tang@intel.com>
 <2520c3d060e7b77560ea32a4b132d8e1a5f14ac9.camel@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2520c3d060e7b77560ea32a4b132d8e1a5f14ac9.camel@linux.intel.com>
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: f08b04e3-3f6d-44c6-d24f-08db363d1853
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tb484tOo+z1xosSMxT8/YyIJXXIr6kTdCbML2CQuDdHmW7NKa9AS+ULh2xfV/z5QqCY10t1Xid6z2n9PIc/+7fwG5jFsvwnAEzkF9BstYok+4R4Rqb38BTPT5QpLjtBmbMtpnC0QeVD34/AgW8Q6nX9MnA7rP7gaoI06ThTxKXK9sEnYR5uIisgfTX19nqvj/sSVM6zjvRHwVkqavycMe0jumzpNNCfIxk3yHoNXIaMWDNV9ASQ/KcypF+uJEDOW5O79Hb3MagwTyouDXevkUQWx0ffSdncF6gQppw/n2kqQWRjNUY5X9KquJbaOEQZqigqW2SnFyElWwg3e4xk0KdoQNGeXcMeDUQbhYbqAXmcyweUoaQHJRnuni6RTYPnd3UiiDHmmgdA0EIGI2Ml2h8Y4x0cl90ykAlI38DOJzGP5tgd1xoHCwFvw+IaI6JpHRts9KHMFkIRf+8Cx0qFhVZTtUf/p36UWuydKRY3p+DW7u1c5hRcrhCFdsqcVwutqjnZ8p5JguKTUQQ5p38ycFusLbxPnrVHDkMA0YaTmrkcYsz6MLx9ht4ZWJW7NzF90I3NNiM9vVT9BIafxnLrhIJNy3OXk5R2q4wV6VZD16fCcfZb/eqLKALvs42WCNIi2FHmM1lgMHC/518Y94Puaug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(26005)(6512007)(9686003)(6506007)(86362001)(186003)(33716001)(316002)(54906003)(966005)(6486002)(8936002)(7416002)(5660300002)(82960400001)(44832011)(2906002)(6916009)(66556008)(66946007)(8676002)(4326008)(38100700002)(41300700001)(66476007)(478600001)(83380400001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yEnsye0y7ZyN875rkMW7BJGb7g+ZddKV2X6ZwWANq+HcfOMFy9gMb/1rNHGD?=
 =?us-ascii?Q?q3h8NyOetlxxagqQjUdoC4mp12ZloFyDPZmm3o1vpiY+2ColT/YW5Cq136t7?=
 =?us-ascii?Q?9OwP1A15R08DcDsUlQerT8Di5gus6eW5rZBKOcJUqAfco19pyTG+vUrpTxYu?=
 =?us-ascii?Q?/3T8ec9ZoCjKyAaCrNvuYShavN0TGHx00HUhAn5dfvJ3imY0Xc5dKOD4NiRQ?=
 =?us-ascii?Q?q+5sXvxzIy8wyAJvScwjZlchybykApsLpWJHbXN8sLzrWYRYxxhylmKNXEEz?=
 =?us-ascii?Q?eyKizUrWsHyGKr4DPbC4uFtagLzJQQul8iE0MgMnO6LmFGD0tNV74TSknjvH?=
 =?us-ascii?Q?h0V6amVdhRghKaRPcRy7JX5/SncLBGCrbbAmYKmLfy2Fb4gLwKc4FRZW3O8v?=
 =?us-ascii?Q?XcB6RCb396tI8psxiNUN2I54Efk9k9Oj1FnXy5FqJTz79a61SARKPOhNhDwn?=
 =?us-ascii?Q?Qpq8D1K5SGKbZBDYKK0UQXcsyDkwGQ94u5XSDD1XiVRdDe1+hrtL2Wshf9Jr?=
 =?us-ascii?Q?Jz4u+3gtsi34/eZzn/SHZetcapPLFF7ST0L0oFD0ja01EuXMrLXY6ppZAdeJ?=
 =?us-ascii?Q?RYR0ahpvmQiHQ7rI1dBaDh+ZOBrETQ1wmjJIzmG6Y/w8ncZwjTA7oULNFEcj?=
 =?us-ascii?Q?t5bQiBs1WQNdIEXIN7FtxNEF3h7D/Jaz8+qOc/hFB2seiBhxZ5jKVqKWYU94?=
 =?us-ascii?Q?Dal4fWKf15Ho7XZP9uYPn0n5osuyj9WK3vBRN8D//DHuPVkzrKaEdS3b6F56?=
 =?us-ascii?Q?p+VY2cRid/vYIklkzGSX35tJO4R9Y4cO3tw4qX3kkA/3r1q7/3CZPiLo8KA/?=
 =?us-ascii?Q?UT1ZSXxZkigSP3eflx7R+2P/mzpECXWhaKv7cf4brgq+YUgY3xhQswg734P1?=
 =?us-ascii?Q?VjrXs6attAyGgKEPU1JuYY4QTYi8sWjz891dztY9gyFGiVz4xh0HVE3MQULo?=
 =?us-ascii?Q?XhW6/6LKzA9pcvZnPhkoUa5ZdWJBR5XwBzOEGT6mJUs588reCkj8kq4qwYM+?=
 =?us-ascii?Q?o5sR8n6qUbeX65f1TB//YJqDRfHWmRB2FBkJ/OgFWrAjYNXT/TXOWJADT0+7?=
 =?us-ascii?Q?fulV3KQ5BbNDLoMuPWwTttD3j3HuX2YlYW651vuWNuwcDlVTg/tOWLh8CRBb?=
 =?us-ascii?Q?2Vxm0v73B6w/nGtUcOvB1c17ThrUa9SsRn8OPbOBCRpNKE7MrSnl7ykfp99D?=
 =?us-ascii?Q?KkxqJUm0HS/3CUWgvRJUOPeyjmkZENOu/tJiqmIpeZrYdA1IkQ5nd9PT1sz5?=
 =?us-ascii?Q?FmXOBlM4Bi6o35w7lJEAZHs0nxIWB/T5+3Cjet+hUbJK+RoalMqu4PgbqttN?=
 =?us-ascii?Q?w/kaeaB+CI4Mw5ldx1kcJkRv+Spr2JhHpGYhzxN2Pu2DInUHcK8Rc9TnIOto?=
 =?us-ascii?Q?6iIohGIcxladJjC3uB7CqqzP1Gvnm4p7Dfbx9uKXf1b7vXS5mtcV2z8P+g8v?=
 =?us-ascii?Q?jTttnVi4jxTMIzY8unhReiP1zpdV2lLwcLttW60xIjG2ohsqqP5COU5qsEse?=
 =?us-ascii?Q?Ourt93ojMFATYIjmTxjQc5VENGSsHCilnXNAEFG45lAF8jijKBzugAtIthQy?=
 =?us-ascii?Q?0ssIc/0uFv+0TBgB+D9mxkVbxWogRoDN9IuwbkcH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f08b04e3-3f6d-44c6-d24f-08db363d1853
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 01:20:23.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbglmwpnAxRv47cgXjkh/ZZKGDLd4rcGfk2reM0XdKMi84ZnKiAjh4AcSsgowEFLCO4KT+X5+swehmp70wzC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8129
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Wed, Apr 05, 2023 at 03:38:20PM -0700, Tim Chen wrote:
> Thanks for the update. Looks good.  Some minor nits to improve readability.

Many thanks for the review!

> 
> On Tue, 2023-04-04 at 13:22 +0800, Feng Tang wrote:
> > 
> > +
> > +False sharing could easily happen unless they are intentionally
> > +checked, and it is valuable to run specific tools for performance
> > +critical workloads to detect false sharing affecting performance case
> > +and optimize accordingly.
> > +
> > +
> > +How to detect and analysis False Sharing
> 
> s/analysis/analyse

Will correct it.

> > +========================================
> > +perf record/report/stat are widely used for performance tuning, and
> > +once hotspots are detected, tools like 'perf-c2c' and 'pahole' can
> > +be further used to detect and pinpoint the possible false sharing
> > +data structures.  'addr2line' is also good at decoding instruction
> > +pointer when there are multiple layers of inline functions.
[...]
> > +Possible Mitigations
> > +====================
> > +False sharing does not always need to be mitigated.  False sharing
> > +mitigations need to balance performance gains with complexity and
> 
> s/need to/should/
 
Will change.

> > +space consumption.  Sometimes, lower performance is OK, and it's
> > +unnecessary to hyper-optimize every rarely used data structure or
> > +a cold data path.
> > +
> > +False sharing hurting performance cases are seen more frequently with
> > +core count increasing.  Because of these detrimental effects, many
> > +patches have been proposed across variety of subsystems (like
> > +networking and memory management) and merged.  Some common mitigations
> > +(with examples) are:
> > +
> > +* Separate hot global data in its own dedicated cache line, even if it
> > +  is just a 'short' type. The downside is more consumption of memory,
> > +  cache line and TLB entries.
> > +
> > +  - Commit 91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_sockets_allocated")
> > +
> > +* Reorganize the data structure, separate the interfering members to
> > +  different cache lines.  One downside is it may introduce new false
> > +  sharing of other members.
> > +
> > +  - Commit 802f1d522d5f ("mm: page_counter: re-layout structure to reduce false sharing")
> > +
> > +* Replace 'write' with 'read' when possible, especially in loops.
> > +  Like for some global variable, use compare(read)-then-write instead
> > +  of unconditional write. For example, use::
> > +
> > +	if (!test_bit(XXX))
> > +		set_bit(XXX);
> > +
> > +  instead of directly "set_bit(XXX);", similarly for atomic_t data::
> > +
> > +	if (atomic_read(XXX) == AAA)
> > +		atomic_set(XXX, BBB);
> > +
> > +  - Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() multithreaded CPU false sharing")
> > +  - Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
> > +
> > +* Turn hot global data to 'per-cpu data + global data' when possible,
> > +  or reasonably increase the threshold for syncing per-cpu data to
> > +  global data, to reduce or postpone the 'write' to that global data.
> > +
> > +  - Commit 520f897a3554 ("ext4: use percpu_counters for extent_status cache hits/misses")
> > +  - Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy")
> > +
> > +Surely, all mitigations should be carefully verified to not cause side
> > +effects.  And to avoid false sharing in advance during coding, it's
> 
> Maybe say
> To avoid introducing false sharing when coding

Yes, this is better.

> > +better to:
> > +
> > +* Be aware of cache line boundaries
> > +* Group mostly read-only fields together
> > +* Group things that are written at the same time together
> > +* Separate known read-mostly and written-mostly fields
> 
> Separate frequently read and frequently written fields on different cache lines

Will change. Thanks!

- Feng

> > +
> > +and better add a comment stating the false sharing consideration.
> > +
> > +One note is, sometimes even after a severe false sharing is detected
> > +and solved, the performance may still have no obvious improvement as
> > +the hotspot switches to a new place.
> > +
> > +
> > +Miscellaneous
> > +=============
> > +One open issue is that kernel has an optional data structure
> > +randomization mechanism, which also randomizes the situation of cache
> > +line sharing of data members.
> > +
> > +
> > +.. [1] https://en.wikipedia.org/wiki/False_sharing
> > +.. [2] https://lore.kernel.org/lkml/CAHk-=whoqV=cX5VC80mmR9rr+Z+yQ6fiQZm36Fb-izsanHg23w@mail.gmail.com/
> > +.. [3] https://joemario.github.io/blog/2016/09/01/c2c-blog/
> > diff --git a/Documentation/kernel-hacking/index.rst b/Documentation/kernel-hacking/index.rst
> > index f53027652290..79c03bac99a2 100644
> > --- a/Documentation/kernel-hacking/index.rst
> > +++ b/Documentation/kernel-hacking/index.rst
> > @@ -9,3 +9,4 @@ Kernel Hacking Guides
> >  
> >     hacking
> >     locking
> > +   false-sharing
> 
> Thanks.
> 
> Tim
> 
