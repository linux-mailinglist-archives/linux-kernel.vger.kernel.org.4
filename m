Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7656DDBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDKNMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:12:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2853E46A4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681218753; x=1712754753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xMZVI3Xt/zlK6jGKVqQyOnOii7kNiDTNN/fW2WryOX4=;
  b=U4lBCqZOHYYq40P4AjBbNk0uYHXY3dQmpwdFZC/o6YbmhtEWCR8PFw4+
   37ddfNGyG37kjBjbHIZOjvTFwLI3GNNXPp9yPMyXIuzy8ckNqwu7DF9a2
   46XzF1lsdupZh5r3LJyIcL6pMuPEpyjWcnyvNUCkWA5MGIA9ae0yONAeP
   ZQpwApdnXkjnU7y2MzDGiB3yTUczo9LPY9GTl+8PCpNRCUXEHKF5JnW3B
   bIu4W/Z+g2FGEFKEFSUCHc3ErzjRr3nAJIE+7SQud59Io6z0xlfARtoGw
   0HlOXmvpbfoQRpkgViw8eNukViJOlfU+D2VWx+OrNWGs37AW5HQOtFPvy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="341101659"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341101659"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 06:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="753133297"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="753133297"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2023 06:12:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 06:12:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 06:12:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 06:12:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 06:12:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFf46MdVS7mfqvMLMcTipNkmFJd0Y+/L2VFB6AAlho51fE6B6w6LZJ9qzcbjLXldQDG9LYSi7Z+1M2F5CQ3OYX4KRcVTQrXGLqIKyizDHPHsR06/BbFdDbIQ35Z2MUQwdIMTqe25KPQkMiMciQv6baEJatPj3TgPQtDMrVW5ebgyH7l0L7L0fnOdAddBRpXVBsOlUzvSJAusiPR6mjaSibJnoVTVpgVmZ7nDcYoALl5uqdYrHeO43s3/tfDIFinsw3smE/11yeWGiIfiBWIOzlvHCb0efvgOry98gYhs89sROWWHSxU/M78ABhCvWQeWUevrGccEm0381tu1depgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4YFbqNLs8rp1f79XPe0gdzQ2VTXetbaive1IvtHsDQ=;
 b=nVfxTyeHJInSWYWnBRMGmL9dKzbXp1Cttgd6I7u9KVcRiZWEau9MsDRzHHS3tQdghHToTKrV9KPpBHc9c9DWInkGqpEl4I4yHmZkKkW5LAAzjWWoeCwQEqoBFifu36LvkKLW5TW+ZS47LuDVptLu+Wj9svHSi9lGb1HGhTTIX7b+QTN7PMBb79WICZfL6l+ozt/VhwR1GKwGCY1ZEn7xQH6BbI32sC+0EQ6gHFVaDo9H2fZmP1j+0UT77NS3dBQPz4bOE/+gNFgR2z0SQ88AfgvHLBD9uXdqMCdi6otaj8zuv7AftOvlw+1KAHslcCVDHevUcPzGAwjMSXOF8ZdhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY8PR11MB7337.namprd11.prod.outlook.com (2603:10b6:930:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 13:12:30 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%3]) with mapi id 15.20.6277.031; Tue, 11 Apr 2023
 13:12:29 +0000
Date:   Tue, 11 Apr 2023 21:12:21 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230411131221.GA7356@ziqianlu-desk2>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
 <20230411045225.GA3509@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230411045225.GA3509@ziqianlu-desk2>
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CY8PR11MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 2497973d-b9a6-40fb-c117-08db3a8e6739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnYbQtG0oBbhn8uihvfOPfpO0td4jAhxFYuyefEiQHFpYy0ajxOWuxZy1m/Vl1OpFyX3ngiUHJmEo7YryAYbt1vFpNnK18XKPCQWr50i/xTd0VCQIa1NIsAlWjHifsefYU4zMipyZL2K1tjdCNPiSiEtysrqifE9JUQynGmAofI9lbWqXoHisX7m8MCEufFFXSrvRHZWQiMNZAUdrlR+uuDRW9fF8Ys9xcs5csBt/BxCSkyganxUs0VrOWdFBLaSAaw9gW8ojOeothC7wc8KvBKp8aGMFEQXlxJN94pbRxxNKtErngRpqxjuZ7762GWARiWwjQCTtuWAKcth8L7PcNLRwuJa6+8/G3dpHYqmFvQ3XHg/u9zFcdkaft7b3tRdvO03+/0+XghEI+eOgYiDO/N119x9jfEiPdLx/zeatRPGAkcFZuIA15g5FVCSYfXCJ/EYTh83ExCDfxiE6e1ZnD9JcDdYqWsD7iLUvYUhufZUW5bsH5Q0HWXgSneUseby6/0Z+kttfW130LOHm6VADQpR5bvj5YzJbV9UUGq738AN0Jt3Z+nM+tA87DrNcZ1q9/Ubyp/QPwkTZeZFCA9oMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(33716001)(33656002)(86362001)(2906002)(9686003)(6486002)(6666004)(186003)(83380400001)(6506007)(1076003)(26005)(966005)(6512007)(6916009)(66556008)(478600001)(4326008)(66946007)(66476007)(44832011)(82960400001)(316002)(41300700001)(8676002)(38100700002)(8936002)(54906003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xVuMMkaXwJD1TH5cRpmb8HyO0gcV7snP2eHEY5dvH+GfzTXo2++T8rKXrQfy?=
 =?us-ascii?Q?qEmTCYfY2RqrEw6nnNFz0ypPOCCFcU2qhNDp61/HsEBc76r/u9ERtNyo4IvZ?=
 =?us-ascii?Q?TJtAs9ilR66pA3eJlXZgrRdajG08dz0s8PzD+ixkI14ePrj8jOokiqSMTF98?=
 =?us-ascii?Q?60GEvpD0fXDDqXpQ+rkarD1ODyEMxn9FX7cDQzF2RDC8gCLEJB98JplnY6Lv?=
 =?us-ascii?Q?CB8CasXoaEtCZK6hU7FTrkJ+dM5T0fK9qa0zga5a44qsSETCvLOptXPL3uh0?=
 =?us-ascii?Q?qkFTGBqYe90s7wwKHSQnWJMwgn2bKcxqX0JoqOPOxAZn7abvckZTOrJnaOcA?=
 =?us-ascii?Q?TwqzvnRYt54ejFJyNp2MidHr3UVznHvavvVqWjkbfvcUnNlV8UIqnGZBBbTL?=
 =?us-ascii?Q?dtyAIWcCZyVeVSZxbdtRlba5Nuhdj59ZVStQLz/sfITPAOCx/VsdWXynhCR3?=
 =?us-ascii?Q?A0Rc0EcRqvjpwQMtnOf4u225cpPwKU2SxOv5w4QlXOkPv56GGU2hUHTngnwA?=
 =?us-ascii?Q?hmU+/m1DuNi4d6slm8URkt4DBwuOiPBSNi1ezqZFb8J0veKj3ZxgIH7ZJZDZ?=
 =?us-ascii?Q?Sm9NDa5Y15SApYNzym4PaLjrAkgr85s0LISTs+1N9/OSmeHikRvwydM6aGFo?=
 =?us-ascii?Q?Obw9zE/7lzgLBi5HwlP/eSc+KKFM8M0Sah/0SQpPeE0gu788oJZYRcMjchcD?=
 =?us-ascii?Q?JYLucRh+dyFIJQRvsZ5o4tPIl47pIWn9qbkM6RQrhy39QnKpWoveNrQmCqXr?=
 =?us-ascii?Q?yeu9TehQ2zaJOS0rD0UWxWcrFXtt1TZC4e8l205ICQXwFcROvZkdczw/u5mB?=
 =?us-ascii?Q?dGxZbKGPsJpLYaUMsU+XHu4PEAIatrFCXwz3VYdt/pSCFepNZYT7JuXDor7X?=
 =?us-ascii?Q?OMKz4hf4e/RPFLWMpmLRUANK/bh9vzKjbK6nYlvF86VvYBrpi7oyMQs8m4/O?=
 =?us-ascii?Q?yBGXXgbpmm7NkNQKZw1JJqhxcTd3k1QOSeYD7w/hXm1gAf+LO2JoUAxLj/k9?=
 =?us-ascii?Q?0wwxkgdyk1NXbwYPJazkUnxfrUPm9L7z2He/bagbqGznGhBzwzBqvQM7w5LG?=
 =?us-ascii?Q?7kJXaGciuA3ZrVgOrS2+9RHdxH6oYSXW9MzippjaQUpzCUo/1fqnc457f/1R?=
 =?us-ascii?Q?v0pxFX3q+wkaAbmmZfjOJyf2GbffLpJJHMdMMESRTyYElU1pOwbF6mGr8w4B?=
 =?us-ascii?Q?VyLFAWbxAgcM5d1eC8y52veFqkk7TRNDGsI+I6xyjWiXT1DtRChj60SuJ7v9?=
 =?us-ascii?Q?wOxt8xCfJyuSxtT5peiUsJOrqUPqIR31iXdGBFBzIxo4CnrAMvIobv25qiAJ?=
 =?us-ascii?Q?TvaKbXCt8V4ms+n0ZC+8n8EeIAt7GO4oW11hHda35FoNA6vDxpwNKmz3SZMw?=
 =?us-ascii?Q?tBGTkcqyQ8OE9Aj2sAQt92gFwe2ddeARt2Hng5M/YBF7GtNIua42eOIrzdcz?=
 =?us-ascii?Q?qmjOkA+DekZS82/aG4l/ysrT+ejVlg0qf4yF1m1pedxFpLLQ164lArxlIBCy?=
 =?us-ascii?Q?i2G1WM7faG/mc1zsIlzHxm2X7mwZZojEFh6+tu05Iag0BFa34/caD1fst8Y9?=
 =?us-ascii?Q?JeY2pxY6y3K9hkZ0dk3GT0omQrEGdDS2IxP34MxF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2497973d-b9a6-40fb-c117-08db3a8e6739
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 13:12:29.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBZpf86gO5GLBYWaBpPfZVXpWNu6zjfD9NfPouVlGLO+AhSW+Zqf6d7L7bVvVGZc+PQL5r542bPbZlp+mtfrcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7337
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 12:52:25PM +0800, Aaron Lu wrote:
> On Mon, Apr 10, 2023 at 11:01:50AM -0400, Mathieu Desnoyers wrote:
> > Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> > sysbench regression reported by Aaron Lu.
> > 
> > Keep track of the currently allocated mm_cid for each mm/cpu rather than
> > freeing them immediately on context switch. This eliminates most atomic
> > operations when context switching back and forth between threads
> > belonging to different memory spaces in multi-threaded scenarios (many
> > processes, each with many threads). The per-mm/per-cpu mm_cid values are
> > serialized by their respective runqueue locks.
> > 
> > Thread migration is handled by introducing invocation to
> > sched_mm_cid_migrate_from() in set_task_cpu() and to
> > sched_mm_cid_migrate_to() (with destination runqueue lock held) in
> > activate_task() for migrating tasks. set_task_cpu() is invoked with and
> > without source rq lock held: the wakeup path does not hold the source rq
> > lock.
> > 
> > sched_mm_cid_migrate_from() clears the mm_cid from the task's mm per-cpu
> > index corresponding to the source runqueue if it matches the last mm_cid
> > observed by the migrated task. This last mm_cid value is returned as a
> > hint to conditionally clear the mm's per-cpu mm_cid on the destination
> > cpu.
> > 
> > Then, in sched_mm_cid_migrate_to(), if the last mm_cid is smaller than
> > the mm's destination cpu current mm_cid, clear the mm's destination cpu
> > current mm_cid. If the migrated task's mm is in use on the destination
> > cpu, the reclaim of the mm_cid will be done lazily on the next
> > destination cpu context switch, else it is performed immediately.
> > 
> > The source cpu's mm_cid is _not_ simply moved to the destination cpu on
> > migration, because passing ownership of the mm_cid value to the
> > destination cpu while an actively running tasks also has its own
> > mm_cid value (in case of lazy reclaim on next context switch) would
> > over-allocate mm_cid values beyond the number of possible cpus.
> > 
> > Because we want to ensure the mm_cid converges towards the smaller
> > values as migrations happen, the prior optimization that was done when
> > context switching between threads belonging to the same mm is removed,
> > because it could delay the lazy release of the destination runqueue
> > mm_cid after it has been replaced by a migration. Removing this prior
> > optimization is not an issue performance-wise because the introduced
> > per-mm/per-cpu mm_cid tracking also covers this more specific case.
> > 
> > This patch is based on v6.3-rc6 with this patch applied:
> > 
> > ("mm: Fix memory leak on mm_init error handling")
> > 
> > https://lore.kernel.org/lkml/20230330133822.66271-1-mathieu.desnoyers@efficios.com/
> 
> Running the previouslly mentioned postgres_sysbench workload with this
> patch applied showed there is single digit lock contention from
> cid_lock, ranging from 1.x% - 7.x% during 3 minutes run. This is worse
> than v1 which I tested before where there is almost no lock contention:
> https://lore.kernel.org/lkml/20230404015949.GA14939@ziqianlu-desk2/
> 
> Detail lock contention number for the 3 minutes run are:
> 
> $ grep "\[k\] native_queued" *profile
> perf_0.profile:     5.44%     5.44%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
> perf_1.profile:     7.49%     7.49%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
> perf_2.profile:     6.65%     6.65%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
> perf_3.profile:     3.38%     3.38%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
> perf_4.profile:     3.01%     3.01%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
> perf_5.profile:     1.74%     1.74%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
> 
> cycles are recorded roughly every 30 seconds for a 5s window on all CPUs.
> 
> And for the worst profile perf_1.profile, the call traces for the
> contention are:
> 
>      7.49%     7.49%  [kernel.vmlinux]                           [k] native_queued_spin_lock_slowpath                                                           -      -
> 5.46% native_queued_spin_lock_slowpath;_raw_spin_lock;mm_cid_get;__schedule;schedule_idle;do_idle;cpu_startup_entry;start_secondary;secondary_startup_64_no_verify
> 1.22% native_queued_spin_lock_slowpath;_raw_spin_lock;mm_cid_get;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_epoll_wait;__x64_sys_epoll_wait;do_syscall_64;entry_SYSCALL_64;0x7fdcfd755d16
> 0.47% native_queued_spin_lock_slowpath;_raw_spin_lock;mm_cid_get;__schedule;schedule;exit_to_user_mode_prepare;syscall_exit_to_user_mode;do_syscall_64;entry_SYSCALL_64;0x7fdcfdf9044c
> 0.11% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;try_to_wake_up;default_wake_function;ep_autoremove_wake_function;__wake_up_common;__wake_up_common_lock;__wake_up;ep_poll_callback;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;0x7f2edc54e494
> 
> I then also tested v3 and v2, turns out lock contention is even worse on
> those two versions. v3: 5.x% - 22.x%, v2: 6% - 22.x%. It feels to me
> something changed in v2 that brought back lock contention and then some
> optimization done in v4 made things better, but still not as good as v1.

Forget about this "v4 is better than v2 and v3" part, my later test
showed the contention can also rise to around 18% for v4.

About why v2-v4 is worse on lock contention than v1, I think that's due
to v1 invoked sched_mm_cid_migrate_from/to() in move_queued_task() path
which didn't affect tasks that migrated on wakeup time while v2-v4 invoked
sched_mm_cid_migrate_from() in set_task_cpu() which affects tasks
migrated on wakeup time. And for this workload, tasks migrated a lot on
wakeup time: during a 5s window, there are about 5 million migrations on
wakeup time while for move_queued_task(), it's only some hundred or
thousand during 5s window.
