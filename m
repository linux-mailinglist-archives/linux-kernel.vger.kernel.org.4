Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD006DD130
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDKEwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDKEwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:52:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4361981
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681188758; x=1712724758;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PgI0Qz2YYTowZxUbfFGTEVUpmBATChd1Lt8hWJT7nkA=;
  b=IibehbJdcIIaOUdatwEvUWToGURhd+s7MKn7zIYZexmInOqZhleGSolT
   i9a9BGIl+xf/I5pIhqXu9Iu/L+AqvvmIZxEpLlWBfAAah/BIj18F6mctQ
   0v5Au5coV5G5T1dYHqt08qRNofUBZYT+hXtmj63XpPSOpwjQ7WfRC36t+
   H4dp6KiGpvxBydDdx32OjnHQrNj/BLUOCKRSBX7i5NFf30SpdGQwwRFbO
   Cq9hkE7cEknljW4BPxNPzjJWIky6BCn2K6l2krhGPtf9+o6uRJpgonTmq
   FZL411gUykQ21f9ccMf3JxVPAxQZ2aHOW7IdH4aNqyDW+YU7a1rMtUTQS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="323157431"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="323157431"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 21:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="812436717"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="812436717"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 10 Apr 2023 21:52:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 21:52:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 21:52:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 21:52:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 21:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANtrhrI1kJcOWt0rJHTUvEpjC6wfjF5x9sGsFtAe2BZVeuAhm4VAfFgngjLtZ6kv5Djboz+ahGJEKwn70ufg3042mZ25/9BiD6av2sxhAPIwVW+Z9ebacJz3cffXd7n7wFeKApZV4YYd6NQdaoDFG+jubCis8o5FGDiOX9noe8WZgtKTGJR41i646VIp9mmYI1dyH8JMABrWoEhAWEVsqhjk0Ty1RudHIcIhJqhjQLMAX5azWFf9nTt2zqxAVd7x+axaMIJEM7Iq0vDv4XFh6TZRy0EdLe4SstZ7Yb6Eat0pnROq9FYAPGlm2aNGi0S40c5wKTl+3UETw0ATnFyr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOYAbd/OpYWyBN+oNVl6xSfQgvxby2AyCRGUKhlqfkk=;
 b=SFV+UQmLQActjKB7dSDnl7q9N9PPDhyrsShiYDtQXFRh51/BcQ9D/Dx3+7DC9nMqrLOMy0dOc6V38ClJgIoABVLmFUAKxMjHcj1tUg+S/swmxpmhsVkVChtOfJ65u3bbtbIj04yiDTQuFTaPLpdxBWedJZ4WegbC+PZytXpO109AizAdkdQgV5zRfrJ5hqt2XlAOIdI5tljP9Z0j1eqqVu5giCcjs7SoF/OOaqjZovlL6VsGPObImSxNvplBGBD7J4aCle2qYIVMmImI9rRRxBWRr/2YFSZ+9dihYZ3FEyiyOzy6L0ydBVjj0URofrXK+sxjT/uWAtPFW4Q4EoFoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 04:52:35 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%3]) with mapi id 15.20.6277.031; Tue, 11 Apr 2023
 04:52:35 +0000
Date:   Tue, 11 Apr 2023 12:52:25 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230411045225.GA3509@ziqianlu-desk2>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b19a4de-bf50-4ecc-919c-08db3a48915d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvZsHmIRdAdM65T41TM0werk3cypLyRyEMI+uVtx7PafpiCpdwyHSCCMTprGPgUhjrQq0yO798E1eUOoGxUSj5exXHOTMn72qJ1Vhngrv8iGGYQr1JigWuyKRgXuDpEJmSRl5uTMWa2HJfhaMRvMTVef/o1ogfH5Q3vSOpvgNhsAbecHZzmRRvlHQ5fQ++gSp/X6jt9n2XkmaXisorXNRfLpsNLXSTUxDAJykwM6GQizzVRsmi6TnV7EErFdkNesLob9S+FEfpXY1SPJF9+9LHlt4PJvfVXKPnuzgOYD6ayEjtf1ivxvyRNVU3H73O+V9brzFVpZiDCXRkuIWOEe+/dKA3wBQQhUlbHFVssdzVMpWWbEIjElxObGevCQZmz/1az8rCHtkS/++XHEMuY744aJAu+EfaYdg3zMNn9rqnERdQW2h1MFXmOoGH6qquVB25jgfflwdzYky4h0rBrCYWZOZWeZgJAY5fxzmoEUjY+WPoIDXxUQdKNh8kNWn/uQgIvnXgPsF6WEseao27oJefz3L9YzBNQFecRFo5K6D5hfOfT1cvVzqb3gkTFPz+VA4HdqTI1aKgbtHitn25r1pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(316002)(38100700002)(54906003)(82960400001)(33716001)(66946007)(66476007)(8676002)(86362001)(66556008)(33656002)(83380400001)(478600001)(4326008)(6916009)(186003)(26005)(41300700001)(9686003)(6506007)(6512007)(1076003)(2906002)(44832011)(8936002)(6666004)(5660300002)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GyigLjv3QXxtmPV2lyqFQw2JV9aVQQxKQqF0NqgeJxPPN3kfaD44EdTutGD?=
 =?us-ascii?Q?eBmcALe4LlfLizHW52EcxyiGIhgN6Vjn8AvKh/wlhkhfHIrYICGWi3u2jR1I?=
 =?us-ascii?Q?93WSXD5zi0PiUUGnn9b4i8KGJL6Pmdr9x8xuMBTE5G9VSjYoUlo+5JLXPsz8?=
 =?us-ascii?Q?JAWj0pVFB4po1Rm8zFIIvP61k+SCZXQaBltKmjBnYJNX4y5zZO/Ur3zmCImz?=
 =?us-ascii?Q?eHSX4OjcOtoFQ5bNKPxccce+a7yzmCgHW7bUTmaYCrSz1FxD5Lz7HmlxWds7?=
 =?us-ascii?Q?E6mrJotz34uF9YaiaZ20gNvHuRUfPZLoRdbBaXoKwvQn8MaavJtm+bReKfd4?=
 =?us-ascii?Q?J4XBuPkB8BCkrh+C2HZyPenTTi0kHCfkGUZhvv7NclbQbA8IHJoEFgsdkxI3?=
 =?us-ascii?Q?vB2EPDtJbHSiKj0faiTPFI+6DW8MkGEEWCMfje+BdBcOYA1+l8atYMxshvyI?=
 =?us-ascii?Q?vPPd6BdTGQ+yCWRGnOqfTCTqNn1Psh0aea6muMtjHC3NDnnXZWhWT+svcRXU?=
 =?us-ascii?Q?9i0KdrsLJlpZnSCYkBfm+MiMl6tfrK8Kjvfv+vmrnkjJOtcGx5/3hErV10ZE?=
 =?us-ascii?Q?vt979DngVBQKP1q5NVvCWUzyAsRwvhtrj1SQGYYLhwiWGUJyir2c4yoYuudg?=
 =?us-ascii?Q?UT41ScLGfNPRwHj5VEvyQsz4xkOX8MjBS8Ku6FE/RNaZwxgbHYRNWkoTk31y?=
 =?us-ascii?Q?p/7j3/B+NZUaM6NQgTPGG4vJqE/7EJ2KBBYjsoGuz9rIthlbkvGiAKnEAiIz?=
 =?us-ascii?Q?B34myQ3jpfqcXEB3+6GLtHOZKlK4bfTTRR8aMteQ3DFwjIlX1EEItLHq0R5K?=
 =?us-ascii?Q?OcPnt/2pdNI549fbJZJOoACT7bojFqGClL3jGgRvziAt9Sv7kk83hGLeUOjH?=
 =?us-ascii?Q?f7p6uTZscA+5okumGMnfsteNFTIWuJFcMFrRxoSRteg09C2q9aM04g/LjWIC?=
 =?us-ascii?Q?R5+tNJ+JZ5gEv/7GqqLOrHO2s5zwrLLaLxANz2eIUS9reCLFA5tAgwjd3k/6?=
 =?us-ascii?Q?/Edt3Dx1DF0zY35jbBTsQHy5zSkJv2X1ZbKbtsYT3YJ2tbG/9g/6CGzfIa8P?=
 =?us-ascii?Q?4lEKFya090lCcOP4DoC9yxHvnuYB4/9R2JXu5FNnC6M66M9Gm8agftzVl1Lk?=
 =?us-ascii?Q?7MqvwQ2E4F5PkP6xYC2TKuqVRPIh994iThdZvNtgeQi6aNI2408UAkYwleUs?=
 =?us-ascii?Q?iW95YQTPJZ9j6wz+bMetR4SMkNYV0E/49U056m9Ee/1jEUiVjSEj+384ar+h?=
 =?us-ascii?Q?E0mj7MQPBfiGl8hcPL5IHjw2uYefASzaziQkhGhMRZi+8KxUD6S1tcnj6vYl?=
 =?us-ascii?Q?IGsBaRyEU1ojni+AomAmWMzBZGuj8fr6gwvaMTKvDj7bXez5M+9og0Gik4v0?=
 =?us-ascii?Q?gG0rHPKkXXbnbUAtWqAQmAL8QFOxUwO5M/a9p8y04EUcalBKzVqmx6j9I066?=
 =?us-ascii?Q?5mI4EgS4fcXdSO+9nKD3RFj6J6QP1fvMsyiG3WmGKWI/oeSbC77LnOZAvfNT?=
 =?us-ascii?Q?zTH187RVHJueNfYjxLW+kkQHG3t6GMkgF82BlGTuftqG/n2Bkimgt0ZvrsIQ?=
 =?us-ascii?Q?mW10W9/pLDuJHGLmKyct3a6LeKXM/ytLBeMnlLca?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b19a4de-bf50-4ecc-919c-08db3a48915d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 04:52:35.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPuuf9LMzlYxYERsS1lUCtpXtzlb7LHUmhfowqkaqS806xJDLIjAuENT0cKG/ww6p2RHANrD5D7fCwrcrNqzcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 11:01:50AM -0400, Mathieu Desnoyers wrote:
> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> sysbench regression reported by Aaron Lu.
> 
> Keep track of the currently allocated mm_cid for each mm/cpu rather than
> freeing them immediately on context switch. This eliminates most atomic
> operations when context switching back and forth between threads
> belonging to different memory spaces in multi-threaded scenarios (many
> processes, each with many threads). The per-mm/per-cpu mm_cid values are
> serialized by their respective runqueue locks.
> 
> Thread migration is handled by introducing invocation to
> sched_mm_cid_migrate_from() in set_task_cpu() and to
> sched_mm_cid_migrate_to() (with destination runqueue lock held) in
> activate_task() for migrating tasks. set_task_cpu() is invoked with and
> without source rq lock held: the wakeup path does not hold the source rq
> lock.
> 
> sched_mm_cid_migrate_from() clears the mm_cid from the task's mm per-cpu
> index corresponding to the source runqueue if it matches the last mm_cid
> observed by the migrated task. This last mm_cid value is returned as a
> hint to conditionally clear the mm's per-cpu mm_cid on the destination
> cpu.
> 
> Then, in sched_mm_cid_migrate_to(), if the last mm_cid is smaller than
> the mm's destination cpu current mm_cid, clear the mm's destination cpu
> current mm_cid. If the migrated task's mm is in use on the destination
> cpu, the reclaim of the mm_cid will be done lazily on the next
> destination cpu context switch, else it is performed immediately.
> 
> The source cpu's mm_cid is _not_ simply moved to the destination cpu on
> migration, because passing ownership of the mm_cid value to the
> destination cpu while an actively running tasks also has its own
> mm_cid value (in case of lazy reclaim on next context switch) would
> over-allocate mm_cid values beyond the number of possible cpus.
> 
> Because we want to ensure the mm_cid converges towards the smaller
> values as migrations happen, the prior optimization that was done when
> context switching between threads belonging to the same mm is removed,
> because it could delay the lazy release of the destination runqueue
> mm_cid after it has been replaced by a migration. Removing this prior
> optimization is not an issue performance-wise because the introduced
> per-mm/per-cpu mm_cid tracking also covers this more specific case.
> 
> This patch is based on v6.3-rc6 with this patch applied:
> 
> ("mm: Fix memory leak on mm_init error handling")
> 
> https://lore.kernel.org/lkml/20230330133822.66271-1-mathieu.desnoyers@efficios.com/

Running the previouslly mentioned postgres_sysbench workload with this
patch applied showed there is single digit lock contention from
cid_lock, ranging from 1.x% - 7.x% during 3 minutes run. This is worse
than v1 which I tested before where there is almost no lock contention:
https://lore.kernel.org/lkml/20230404015949.GA14939@ziqianlu-desk2/

Detail lock contention number for the 3 minutes run are:

$ grep "\[k\] native_queued" *profile
perf_0.profile:     5.44%     5.44%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
perf_1.profile:     7.49%     7.49%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
perf_2.profile:     6.65%     6.65%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
perf_3.profile:     3.38%     3.38%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
perf_4.profile:     3.01%     3.01%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
perf_5.profile:     1.74%     1.74%  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath

cycles are recorded roughly every 30 seconds for a 5s window on all CPUs.

And for the worst profile perf_1.profile, the call traces for the
contention are:

     7.49%     7.49%  [kernel.vmlinux]                           [k] native_queued_spin_lock_slowpath                                                           -      -
5.46% native_queued_spin_lock_slowpath;_raw_spin_lock;mm_cid_get;__schedule;schedule_idle;do_idle;cpu_startup_entry;start_secondary;secondary_startup_64_no_verify
1.22% native_queued_spin_lock_slowpath;_raw_spin_lock;mm_cid_get;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_epoll_wait;__x64_sys_epoll_wait;do_syscall_64;entry_SYSCALL_64;0x7fdcfd755d16
0.47% native_queued_spin_lock_slowpath;_raw_spin_lock;mm_cid_get;__schedule;schedule;exit_to_user_mode_prepare;syscall_exit_to_user_mode;do_syscall_64;entry_SYSCALL_64;0x7fdcfdf9044c
0.11% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;try_to_wake_up;default_wake_function;ep_autoremove_wake_function;__wake_up_common;__wake_up_common_lock;__wake_up;ep_poll_callback;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;0x7f2edc54e494

I then also tested v3 and v2, turns out lock contention is even worse on
those two versions. v3: 5.x% - 22.x%, v2: 6% - 22.x%. It feels to me
something changed in v2 that brought back lock contention and then some
optimization done in v4 made things better, but still not as good as v1.

Thanks,
Aaron
