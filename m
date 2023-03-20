Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F166C0C35
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCTI2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCTI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:28:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A549E5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679300877; x=1710836877;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QvAbeI4LGVgtMxt/NGEdKO7FKVkJtmU6ERiiA8QzOd8=;
  b=j+ouT8ed9aUiDoX2Lq54dZ3XF1wRPGTrUTE2PQB4xvcjcGdjfc8DLIuG
   Vf2Ud1T7o0Zn1VT37VuCoVscEKleqQ1ODP167UlwdJjxz+ELI0hvTdjbu
   ymHrufA5S/O+AlRHT5kbV3PszF7PLmLEHV04yg9Rr+vq3oo4of9IFVuDJ
   9EA/2ExlT+pOijFBq7IGAAKw9PJqvwvjGFz6zJPfFnY/SO3ADZMkDGB7Y
   rk00ymdMrz5uXW9sOCN2lO+u3tEjMGkG82eWjnWAres1/sZp/Gjm+xDQv
   TdZllg8aFMG53UkHp6O7rQL5VHxj1qRFLuX8qwm7GjdNjULf6wPByXHdL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="336106423"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="336106423"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 01:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="855198928"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="855198928"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 20 Mar 2023 01:27:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 01:27:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 01:27:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 01:27:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 01:27:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2jW88Tyur0npgrEZzAcCu3PzLeEf4fzFvjB+wIrLLO1CxNvdbwc6/TiD18T8MQh96qm6V9nvEy7tmSmhNlmXOXrWUYfn+gQw9n/mNItz/4WUGvNcjcTnvGPZrO7Z6Cp7J/LVKqvPIddHZZRsd/uax+Ai/NJXENXHNhL3P6bAYKd59yRm2YtNp32WzI7x9KOp85mphL0kl1qvIKGG/G/dF7MF0GiHsT5tYg9kjB1Wu2TJQiEwLPUFFNOYbwN6KuWHlznawusX29K/5Ef0Bw++XiWBIUkqhhAsgfImYOfc7nh5TkCmYkp1QMw5uDxFXgaBq7HAbRX7YA8m8Wbz+ABFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOsCRGcupoZXLMJdr/3z1JWUFP/Z7MkV3gznkah62w4=;
 b=ii0+PP3GutTu1Hb0tZ+FLdr/Yvl+6qC7OmGN6xfMLiD01mh3HUvZTnsBZaIEdfQmbqnHD9uyK555hPohZjcOgnNWSGG5NWWmx61UgRg16thN+Q1q46DDoDcEeqiTVIB/LGC29MQfNOkq0A+pZMC2mGap8U5AsreghQLx5h1IL4nLOD4xUfurK+VEv3kxn0oI78T1AKKpfpqMPkqueWoO330w7BzIrpTvbVaO7/m20XCaGAnEiO8zH+qEgRUeuKkuf402l7iw1cMwOtaJiUumtXUXhOC4u/tsaMtwvMpvCstZbK7REWZ6RYSCGiG2kBoeyfgOM4QE2RB3Gmy5sGts6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB7733.namprd11.prod.outlook.com (2603:10b6:8:dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 08:27:49 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 08:27:53 +0000
Date:   Mon, 20 Mar 2023 16:29:05 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <asml.silence@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <axboe@kernel.dk>,
        <heng.su@intel.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is "tp_perf_event_destroy" task hung in
 v6.3-rc3 kernel
Message-ID: <ZBgZUWjTVE+iUrxI@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb980ea-f08d-4e19-d951-08db291cffc8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PT+YOYotrkroM4+KSD3W8jxCSnuSg3XVZ2ypMGNDDFIE0d9lO+8JCL88k0jzjyb4/d2f1t3lgmiqIEB0Ov/hg/iWRIWaudbGmjj8CZly4lXlZ/0BrMtFsIYl6z9SW3rYpJ5w04okN6FE0An4drlLZp5fAMsKgcHjjZGaRVLlhb231MDPjhEf1mh9dtTmlTaiocSy2TRIhDQ9MK3BSUNJ3r8xq1Vx6SoAKfobeqxw92IpPSFDEwSQ/Liee2tAUxs54f72RTjF4PsA3Cr4OuMxasK0rgDrWwWV2PeQ92+1phWbZely83a20dI6ZULWAu08kpAlYdEnE1HAWWSEAhpafhCtc08GbcvQWwiLsJgBEd2ngbcwpQbbSgmPEYTvUdTW0UGkC8r/hn0s1+RB5s2ARlIFeAtOFgcoVPFunAkQ9WBxXPDT/+llaWQGh6QM7z2fRThW6ihqlQmKd+umqa+BStB3d2NICfIYKt5VataG8b6RwHPxNLsKx2USownJ5kib/zwHsf+wnzVA7vZE5kTLkDkr12zuejQq4vFLpMbroT6MgdOPs0RGU3MtirFoIqRf2Y1LhqeBQfzR9SJ4/fWW0q1UHQwgXOulotw0Let+cu5o5NhAuBiw8ekfg/QgSKESj2PbMQy+moVjTmIhFhAOKp2Nf73bqLUQPb3J5ZLVb4/cQCQLbQuNvt9pdsviLflrrRgUl3AzLJZC/PfHgkRI/00ddrlCcDfVcoDYD8YbkBcYdJojO6FeQ/J9izffWtD7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199018)(26005)(6506007)(6512007)(107886003)(966005)(6666004)(6486002)(6916009)(4326008)(316002)(8676002)(83380400001)(186003)(66946007)(478600001)(5660300002)(8936002)(30864003)(82960400001)(2906002)(44832011)(41300700001)(66556008)(66476007)(38100700002)(86362001)(21314003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z1INYSMpqe1nt88Mz6JAvbVwb7zJ12LoZGl9g2hRa+7WG0zlPEWSwZhnmUWR?=
 =?us-ascii?Q?YSr5IqUsbAKY/mv2gRz/1uw8ExVaR+Mbdgw8c6jp0YoAC+In4Sko9YFFk3+N?=
 =?us-ascii?Q?xuzB9mfEJ8gyV7vq6qFJu0ulcSNKWT0r78ALIt7p40CukFP6cGRqYxcwv/z9?=
 =?us-ascii?Q?+w2sAJUVXbqRzBjdzfCPkMWYqK8/SXnam4x4rugOC6pdvpBzlQ8eia6aXw/+?=
 =?us-ascii?Q?LQgvrb/eT8Rc89fjm5xvxtOBa1qTjQ0jGX3/rp7587IMWum9KiRga/JaGA6m?=
 =?us-ascii?Q?mD33vK5/XjGtSC7r5qTXeRoz/sZ4+rsy2vUkDQXKZoNgPKr1SsivyupUZeEC?=
 =?us-ascii?Q?9oXdQggK/ZZK/1x6ci7BxJ+zFrPWuvKK/6HTzcH7VAOBHLV1DiCCcxqZPLCi?=
 =?us-ascii?Q?LQsCVC7LlTUwz1qEmEfIM4gFhGcuRhITnWYvNOoJWtWXv45SUcH48LrN0q3g?=
 =?us-ascii?Q?UsJQaDfbTFsfhBFAvEIvQKJQkOAlK5TSlfQGL3mIcWc+cpLxc7YffB4B8Q+K?=
 =?us-ascii?Q?gidRRXWD7FyTDOhxRsXKsJ3mLdIHbJ8BVjgPfPPwE1yPECmo6/WHwGbqc7iq?=
 =?us-ascii?Q?2Io/NZvrYvvdLtgI+YoFimnZty/ZLIszVLSTX45yRhYdizHajEzD8/igXx6T?=
 =?us-ascii?Q?n9Idm7iQYikolh8uOp439rigbatjfbyiueip8DTbFxi3puZtnhILBP4nBqe8?=
 =?us-ascii?Q?iQw5NOezKP7yJYYbQaXPAknIcRi7f/xX0tSOwOcPYm+7st8VSeASBcR6sTYc?=
 =?us-ascii?Q?A24rlI9lLGThjD2g7vfcsw/DQ6uedGte8CDuwaLyOtbEHiWn/0E7w1Pm3HDL?=
 =?us-ascii?Q?/5npkWglBwodmc5XT0ZzX3a4RDNLyw6R2oGFY4BxDh+2OkHvKDMzV1AlHDmZ?=
 =?us-ascii?Q?B9O2FeGar1CTxQUIaOZpmcXG9JECBXoj7FMkS8pQgEQJItNJ8RjeUk8KyotL?=
 =?us-ascii?Q?AcsPSmmoGSNhm2DBMYXgXUhbwiymdWtNEI3kjSMsz6yb/XEy81QL6GtHCwLn?=
 =?us-ascii?Q?VZMBaPHBbJuGe2GNgr4V8B3mO1NFNcI0yBquW+hB70mG9SNyqpcSlKK46B0S?=
 =?us-ascii?Q?+wGfxkDcjz+3SSkPTD39fjUHVfZk7U67IGxkCb50k6lKdHm1usc0JEUdFYVc?=
 =?us-ascii?Q?ktiL2dJLeazkUmkJWcreP5eAejFknteuWtFX9q9L944G/FRRCArFMnc2ypr2?=
 =?us-ascii?Q?A7piB/jvG52y9UP3q5oguxQkyNUcUX1tPk/FTtl+3NcTi4oXIao/pghVlmiV?=
 =?us-ascii?Q?WKM4erdEFNzaoEXlQ05plF3ZgJ71zhuUavqeuQ8ajjMsms1b19h9IkOCRTVq?=
 =?us-ascii?Q?wGFOPMp57vQ6B448MpMkH3ocxFBiQJlSI1c6RAMAGxpJYIcLDswUTckp+x9y?=
 =?us-ascii?Q?Pl8Ivbl1L7T5xsT4VkjwJTiaXCX9xpSqXdUpre6j0bK/+6VaDJh9Pnhqc5jl?=
 =?us-ascii?Q?+FgPBbe+6TNV/0rZjeI/EeD07HYYjY9WzWLO2pgHt7EyG6KDqcyHm3Gved72?=
 =?us-ascii?Q?EobCBCRdoLOgaTCGgur89aaa+n9CDus8YMWDBEhwJpH3/C+UHBUWhD+JmTWS?=
 =?us-ascii?Q?hA12Rziksnx4JHtmArBcXGtOVKLJgXdiPwl4KD9gqfpwpT/rokmKcovzEPfy?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb980ea-f08d-4e19-d951-08db291cffc8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 08:27:53.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCchgG1cdlVCA7c4D5jxWTi1SW8/u/q9MV7nmJgJl5Vn/3tV4lhIwlUbKDibTBZcHpdj9zoL2ES2w+HANWKxBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7733
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel Begunkov and kernel experts,

Greeting!

Platform: x86 platforms.
There is "tp_perf_event_destroy" task hung in v6.3-rc3 kernel.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230318_215818_tp_perf_event_destroy
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230318_215818_tp_perf_event_destroy/repro.c
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230318_215818_tp_perf_event_destroy/kconfig_origin
v6.3-rc3 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230318_215818_tp_perf_event_destroy/v6.3-rc3_issue_dmesg.log
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230318_215818_tp_perf_event_destroy/bisect_info.log

Confirmed this issue could be reproduced in v6.3-rc3 kernel in 2300s.

Bisected between v6.3-rc2 and v5.11 and found bad commit in last week:
"
846072f16eed3b3fb4e59b677f3ed8afb8509b89
io_uring: mimimise io_cqring_wait_schedule
"
It's just suspected commit, because reverted the above commit on top of
v6.3-rc2 and made kernel failed, and could not verify after reverted the commit.

"
[  158.190103] hrtimer: interrupt took 948122 ns
[  168.878677] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 2522 jiffies old.
[  199.374623] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 10146 jiffies old.
[  289.871462] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 32770 jiffies old.
[  447.599142] INFO: task repro:419 blocked for more than 147 seconds.
[  447.600607]       Not tainted 6.3.0-rc3-kvm-e8d018dd #1
[  447.603309] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  447.604861] task:repro           state:D stack:0     pid:419   ppid:395    flags:0x00004002
[  447.607597] Call Trace:
[  447.608530]  <TASK>
[  447.610781]  __schedule+0x40a/0xc30
[  447.613504]  schedule+0x5b/0xe0
[  447.614867]  schedule_preempt_disabled+0x1c/0x30
[  447.616254]  __mutex_lock+0x824/0xcb0
[  447.618529]  ? perf_trace_destroy+0x21/0xa0
[  447.619831]  ? perf_trace_destroy+0x21/0xa0
[  447.622075]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  447.623795]  mutex_lock_nested+0x1f/0x30
[  447.624987]  ? mutex_lock_nested+0x1f/0x30
[  447.627019]  perf_trace_destroy+0x21/0xa0
[  447.628315]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  447.630454]  tp_perf_event_destroy+0x1e/0x30
[  447.631886]  _free_event+0x101/0x810
[  447.633787]  put_event+0x3c/0x50
[  447.635214]  perf_event_release_kernel+0x2de/0x360
[  447.636510]  ? perf_event_release_kernel+0x9/0x360
[  447.639127]  ? __pfx_perf_release+0x10/0x10
[  447.640646]  perf_release+0x22/0x30
[  447.642731]  __fput+0x11f/0x450
[  447.644831]  ____fput+0x1e/0x30
[  447.646309]  task_work_run+0xb6/0x120
[  447.648178]  do_exit+0x547/0x12b0
[  447.650481]  ? write_comp_data+0x2f/0x90
[  447.652453]  do_group_exit+0x5e/0xf0
[  447.654929]  get_signal+0x1465/0x14a0
[  447.658053]  arch_do_signal_or_restart+0x33/0x280
[  447.661093]  exit_to_user_mode_prepare+0x13b/0x210
[  447.663714]  syscall_exit_to_user_mode+0x2d/0x60
[  447.665332]  do_syscall_64+0x4a/0x90
[  447.666695]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  447.668028] RIP: 0033:0x7f7722b9159d
[  447.669404] RSP: 002b:00007f7722a6aca8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  447.671273] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f7722b9159d
[  447.672733] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  447.674936] RBP: 00007f7722a6ae00 R08: 0000000000000000 R09: 0000000000000000
[  447.676392] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdb9febe5e
[  447.678602] R13: 00007ffdb9febe5f R14: 00007ffdb9febef0 R15: 00007f7722a6b700
[  447.682294]  </TASK>
[  447.683218] INFO: task repro:416 blocked for more than 147 seconds.
[  447.684574]       Not tainted 6.3.0-rc3-kvm-e8d018dd #1
[  447.686549] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  447.688092] task:repro           state:D stack:0     pid:416   ppid:404    flags:0x00004002
[  447.690853] Call Trace:
[  447.691788]  <TASK>
[  447.693419]  __schedule+0x40a/0xc30
[  447.695782]  ? wait_for_completion+0x7b/0x180
[  447.697262]  schedule+0x5b/0xe0
[  447.698585]  schedule_timeout+0x4db/0x5b0
[  447.700870]  ? schedule_timeout+0x9/0x5b0
[  447.703596]  ? wait_for_completion+0x7b/0x180
[  447.704925]  wait_for_completion+0xa6/0x180
[  447.707869]  __wait_rcu_gp+0x136/0x160
[  447.709489]  ? __pfx_arch_ftrace_ops_list_func+0x10/0x10
[  447.711137]  synchronize_rcu_tasks_generic.part.24+0x3b/0x60
[  447.712538]  ? __pfx_call_rcu_tasks+0x10/0x10
[  447.714614]  ? __pfx_wakeme_after_rcu+0x10/0x10
[  447.716657]  ? verify_cpu+0x10/0x100
[  447.719178]  synchronize_rcu_tasks_generic+0x24/0x70
[  447.720588]  synchronize_rcu_tasks+0x19/0x20
[  447.722680]  ftrace_shutdown+0x1cc/0x410
[  447.724567]  unregister_ftrace_function+0x35/0x230
[  447.726917]  ? __sanitizer_cov_trace_switch+0x57/0xa0
[  447.728819]  perf_ftrace_event_register+0x95/0xf0
[  447.730371]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  447.731759]  perf_trace_destroy+0x3a/0xa0
[  447.733061]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  447.735193]  tp_perf_event_destroy+0x1e/0x30
[  447.736623]  _free_event+0x101/0x810
[  447.739130]  put_event+0x3c/0x50
[  447.740550]  perf_event_release_kernel+0x2de/0x360
[  447.742608]  ? perf_event_release_kernel+0x9/0x360
[  447.744492]  ? __pfx_perf_release+0x10/0x10
[  447.746758]  perf_release+0x22/0x30
[  447.748114]  __fput+0x11f/0x450
[  447.750960]  ____fput+0x1e/0x30
[  447.752297]  task_work_run+0xb6/0x120
[  447.754904]  do_exit+0x547/0x12b0
[  447.756524]  ? write_comp_data+0x2f/0x90
[  447.759255]  do_group_exit+0x5e/0xf0
[  447.761004]  get_signal+0x1465/0x14a0
[  447.764701]  arch_do_signal_or_restart+0x33/0x280
[  447.768441]  exit_to_user_mode_prepare+0x13b/0x210
[  447.770797]  syscall_exit_to_user_mode+0x2d/0x60
[  447.772266]  do_syscall_64+0x4a/0x90
[  447.774354]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  447.775680] RIP: 0033:0x7f7722b9159d
[  447.776887] RSP: 002b:00007f7722a6aca8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  447.779720] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f7722b9159d
[  447.781345] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  447.782803] RBP: 00007f7722a6ae00 R08: 0000000000000000 R09: 0000000000000000
[  447.784258] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdb9febe5e
[  447.786464] R13: 00007ffdb9febe5f R14: 00007ffdb9febef0 R15: 00007f7722a6b700
[  447.790697]  </TASK>
[  447.792534] INFO: task repro:425 blocked for more than 147 seconds.
[  447.794718]       Not tainted 6.3.0-rc3-kvm-e8d018dd #1
[  447.795940] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  447.798661] task:repro           state:D stack:0     pid:425   ppid:402    flags:0x00004002
[  447.800661] Call Trace:
[  447.802321]  <TASK>
[  447.803798]  __schedule+0x40a/0xc30
[  447.806473]  schedule+0x5b/0xe0
[  447.807823]  schedule_preempt_disabled+0x1c/0x30
[  447.809344]  __mutex_lock+0x824/0xcb0
[  447.810920]  ? perf_trace_destroy+0x21/0xa0
[  447.812215]  ? perf_trace_destroy+0x21/0xa0
[  447.815033]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  447.816749]  mutex_lock_nested+0x1f/0x30
[  447.818843]  ? mutex_lock_nested+0x1f/0x30
[  447.820158]  perf_trace_destroy+0x21/0xa0
[  447.822200]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  447.823589]  tp_perf_event_destroy+0x1e/0x30
[  447.825022]  _free_event+0x101/0x810
[  447.827503]  put_event+0x3c/0x50
[  447.828928]  perf_event_release_kernel+0x2de/0x360
[  447.830969]  ? perf_event_release_kernel+0x9/0x360
[  447.832864]  ? __pfx_perf_release+0x10/0x10
[  447.835090]  perf_release+0x22/0x30
[  447.836443]  __fput+0x11f/0x450
[  447.839498]  ____fput+0x1e/0x30
[  447.840832]  task_work_run+0xb6/0x120
[  447.842867]  do_exit+0x547/0x12b0
[  447.844491]  ? write_comp_data+0x2f/0x90
[  447.847194]  do_group_exit+0x5e/0xf0
[  447.848942]  get_signal+0x1465/0x14a0
[  447.852641]  arch_do_signal_or_restart+0x33/0x280
[  447.856372]  exit_to_user_mode_prepare+0x13b/0x210
[  447.858710]  syscall_exit_to_user_mode+0x2d/0x60
[  447.860202]  do_syscall_64+0x4a/0x90
[  447.862295]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  447.863624] RIP: 0033:0x7f7722b9159d
[  447.864844] RSP: 002b:00007f7722a6aca8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  447.867459] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f7722b9159d
[  447.868934] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  447.870577] RBP: 00007f7722a6ae00 R08: 0000000000000000 R09: 0000000000000000
[  447.872051] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdb9febe5e
[  447.874268] R13: 00007ffdb9febe5f R14: 00007ffdb9febef0 R15: 00007f7722a6b700
[  447.877963]  </TASK>
[  447.878914] INFO: task repro:427 blocked for more than 147 seconds.
[  447.880283]       Not tainted 6.3.0-rc3-kvm-e8d018dd #1
[  447.882254] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  447.883809] task:repro           state:D stack:0     pid:427   ppid:403    flags:0x00004002
[  447.886569] Call Trace:
[  447.887508]  <TASK>
[  447.888991]  __schedule+0x40a/0xc30
[  447.892252]  schedule+0x5b/0xe0
[  447.894255]  schedule_preempt_disabled+0x1c/0x30
[  447.895625]  __mutex_lock+0x824/0xcb0
[  447.897381]  ? perf_trace_destroy+0x21/0xa0
[  447.898713]  ? perf_trace_destroy+0x21/0xa0
[  447.900811]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  447.903238]  mutex_lock_nested+0x1f/0x30
[  447.904426]  ? mutex_lock_nested+0x1f/0x30
[  447.906460]  perf_trace_destroy+0x21/0xa0
[  447.907770]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  447.909320]  tp_perf_event_destroy+0x1e/0x30
[  447.910792]  _free_event+0x101/0x810
[  447.912539]  put_event+0x3c/0x50
[  447.914682]  perf_event_release_kernel+0x2de/0x360
[  447.915979]  ? perf_event_release_kernel+0x9/0x360
[  447.918019]  ? __pfx_perf_release+0x10/0x10
[  447.919501]  perf_release+0x22/0x30
[  447.920856]  __fput+0x11f/0x450
[  447.923141]  ____fput+0x1e/0x30
[  447.924447]  task_work_run+0xb6/0x120
[  447.927780]  do_exit+0x547/0x12b0
[  447.931182]  ? write_comp_data+0x2f/0x90
[  447.934722]  do_group_exit+0x5e/0xf0
[  447.936532]  get_signal+0x1465/0x14a0
[  447.940264]  arch_do_signal_or_restart+0x33/0x280
[  447.944018]  exit_to_user_mode_prepare+0x13b/0x210
[  447.945794]  syscall_exit_to_user_mode+0x2d/0x60
[  447.947286]  do_syscall_64+0x4a/0x90
[  447.948652]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  447.950725] RIP: 0033:0x7f7722b9159d
[  447.951943] RSP: 002b:00007f7722a6aca8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  447.954535] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f7722b9159d
[  447.955993] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  447.958422] RBP: 00007f7722a6ae00 R08: 0000000000000000 R09: 0000000000000000
[  447.959904] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdb9febe5e
[  447.962104] R13: 00007ffdb9febe5f R14: 00007ffdb9febef0 R15: 00007f7722a6b700
[  447.965788]  </TASK>
[  447.967915] INFO: task repro:430 blocked for more than 147 seconds.
[  447.969442]       Not tainted 6.3.0-rc3-kvm-e8d018dd #1
[  447.970680] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  447.972193] task:repro           state:D stack:0     pid:430   ppid:407    flags:0x00004002
[  447.975058] Call Trace:
[  447.975971]  <TASK>
[  447.977557]  __schedule+0x40a/0xc30
[  447.980071]  schedule+0x5b/0xe0
[  447.981674]  schedule_preempt_disabled+0x1c/0x30
[  447.983036]  __mutex_lock+0x824/0xcb0
[  447.984557]  ? perf_trace_destroy+0x21/0xa0
[  447.986555]  ? perf_trace_destroy+0x21/0xa0
[  447.988600]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  447.990982]  mutex_lock_nested+0x1f/0x30
[  447.992143]  ? mutex_lock_nested+0x1f/0x30
[  447.993565]  perf_trace_destroy+0x21/0xa0
[  447.994841]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  447.996222]  tp_perf_event_destroy+0x1e/0x30
[  447.998367]  _free_event+0x101/0x810
[  448.000101]  put_event+0x3c/0x50
[  448.001662]  perf_event_release_kernel+0x2de/0x360
[  448.002946]  ? perf_event_release_kernel+0x9/0x360
[  448.004795]  ? __pfx_perf_release+0x10/0x10
[  448.007013]  perf_release+0x22/0x30
[  448.008339]  __fput+0x11f/0x450
[  448.011124]  ____fput+0x1e/0x30
[  448.012434]  task_work_run+0xb6/0x120
[  448.014990]  do_exit+0x547/0x12b0
[  448.016581]  ? write_comp_data+0x2f/0x90
[  448.019455]  do_group_exit+0x5e/0xf0
[  448.021888]  get_signal+0x1465/0x14a0
[  448.024789]  arch_do_signal_or_restart+0x33/0x280
[  448.028453]  exit_to_user_mode_prepare+0x13b/0x210
[  448.030753]  syscall_exit_to_user_mode+0x2d/0x60
[  448.032208]  do_syscall_64+0x4a/0x90
[  448.033709]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  448.035025] RIP: 0033:0x7f7722b9159d
[  448.036207] RSP: 002b:00007f7722a6aca8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  448.038759] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f7722b9159d
[  448.040195] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  448.042361] RBP: 00007f7722a6ae00 R08: 0000000000000000 R09: 0000000000000000
[  448.043795] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdb9febe5e
[  448.045938] R13: 00007ffdb9febe5f R14: 00007ffdb9febef0 R15: 00007f7722a6b700
[  448.049568]  </TASK>
[  448.050486] INFO: task repro:429 blocked for more than 147 seconds.
[  448.051815]       Not tainted 6.3.0-rc3-kvm-e8d018dd #1
[  448.053012] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  448.055229] task:repro           state:D stack:0     pid:429   ppid:405    flags:0x00004002
[  448.057355] Call Trace:
[  448.058283]  <TASK>
[  448.059750]  __schedule+0x40a/0xc30
[  448.062372]  schedule+0x5b/0xe0
[  448.063668]  schedule_preempt_disabled+0x1c/0x30
[  448.065033]  __mutex_lock+0x824/0xcb0
[  448.067309]  ? perf_trace_destroy+0x21/0xa0
[  448.068608]  ? perf_trace_destroy+0x21/0xa0
[  448.071370]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  448.073039]  mutex_lock_nested+0x1f/0x30
[  448.074912]  ? mutex_lock_nested+0x1f/0x30
[  448.076183]  perf_trace_destroy+0x21/0xa0
[  448.078436]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  448.079810]  tp_perf_event_destroy+0x1e/0x30
[  448.081347]  _free_event+0x101/0x810
[  448.083069]  put_event+0x3c/0x50
[  448.084464]  perf_event_release_kernel+0x2de/0x360
[  448.086454]  ? perf_event_release_kernel+0x9/0x360
[  448.088274]  ? __pfx_perf_release+0x10/0x10
[  448.090457]  perf_release+0x22/0x30
[  448.091767]  __fput+0x11f/0x450
[  448.093960]  ____fput+0x1e/0x30
[  448.095257]  task_work_run+0xb6/0x120
[  448.097088]  do_exit+0x547/0x12b0
[  448.099437]  ? write_comp_data+0x2f/0x90
[  448.101545]  do_group_exit+0x5e/0xf0
[  448.103335]  get_signal+0x1465/0x14a0
[  448.106454]  arch_do_signal_or_restart+0x33/0x280
[  448.110172]  exit_to_user_mode_prepare+0x13b/0x210
[  448.111829]  syscall_exit_to_user_mode+0x2d/0x60
[  448.113466]  do_syscall_64+0x4a/0x90
[  448.114851]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  448.116187] RIP: 0033:0x7f7722b9159d
[  448.118140] RSP: 002b:00007f7722a6aca8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  448.120035] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f7722b9159d
[  448.122386] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  448.123860] RBP: 00007f7722a6ae00 R08: 0000000000000000 R09: 0000000000000000
[  448.126074] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdb9febe5e
[  448.127550] R13: 00007ffdb9febe5f R14: 00007ffdb9febef0 R15: 00007f7722a6b700
[  448.131287]  </TASK>
[  448.134851] INFO: task repro:432 blocked for more than 147 seconds.
[  448.136243]       Not tainted 6.3.0-rc3-kvm-e8d018dd #1
[  448.138626] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  448.140159] task:repro           state:D stack:0     pid:432   ppid:408    flags:0x00004002
[  448.142863] Call Trace:
[  448.143792]  <TASK>
[  448.145398]  __schedule+0x40a/0xc30
[  448.147962]  schedule+0x5b/0xe0
[  448.149422]  schedule_preempt_disabled+0x1c/0x30
[  448.150827]  __mutex_lock+0x824/0xcb0
[  448.152393]  ? perf_trace_destroy+0x21/0xa0
[  448.154403]  ? perf_trace_destroy+0x21/0xa0
[  448.156514]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  448.158931]  mutex_lock_nested+0x1f/0x30
[  448.160129]  ? mutex_lock_nested+0x1f/0x30
[  448.162120]  perf_trace_destroy+0x21/0xa0
[  448.163428]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  448.164823]  tp_perf_event_destroy+0x1e/0x30
[  448.166560]  _free_event+0x101/0x810
[  448.168290]  put_event+0x3c/0x50
[  448.170417]  perf_event_release_kernel+0x2de/0x360
[  448.171702]  ? perf_event_release_kernel+0x9/0x360
[  448.173692]  ? __pfx_perf_release+0x10/0x10
[  448.175180]  perf_release+0x22/0x30
[  448.176497]  __fput+0x11f/0x450
[  448.179260]  ____fput+0x1e/0x30
[  448.180566]  task_work_run+0xb6/0x120
[  448.183105]  do_exit+0x547/0x12b0
[  448.184687]  ? write_comp_data+0x2f/0x90
[  448.187344]  do_group_exit+0x5e/0xf0
[  448.189059]  get_signal+0x1465/0x14a0
[  448.192701]  arch_do_signal_or_restart+0x33/0x280
[  448.196614]  exit_to_user_mode_prepare+0x13b/0x210
[  448.198944]  syscall_exit_to_user_mode+0x2d/0x60
[  448.200401]  do_syscall_64+0x4a/0x90
[  448.202466]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  448.203774] RIP: 0033:0x7f7722b9159d
[  448.204969] RSP: 002b:00007f7722a6aca8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  448.206968] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f7722b9159d
[  448.208411] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  448.210569] RBP: 00007f7722a6ae00 R08: 0000000000000000 R09: 0000000000000000
[  448.212008] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdb9febe5e
[  448.214165] R13: 00007ffdb9febe5f R14: 00007ffdb9febef0 R15: 00007f7722a6b700
[  448.217786]  </TASK>
[  448.218689] 
[  448.218689] Showing all locks held in the system:
[  448.220025] 1 lock held by rcu_tasks_kthre/11:
[  448.221304]  #0: ffffffff83d63490 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  448.224867] 1 lock held by rcu_tasks_rude_/12:
[  448.226732]  #0: ffffffff83d63210 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  448.231085] 1 lock held by rcu_tasks_trace/13:
[  448.232239]  #0: ffffffff83d62f50 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  448.236085] 1 lock held by khungtaskd/29:
[  448.237918]  #0: ffffffff83d63ea0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x1b/0x1e0
[  448.242209] 1 lock held by repro/419:
[  448.243265]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  448.247475] 2 locks held by repro/416:
[  448.248529]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  448.252631]  #1: ffffffff83e1cd68 (ftrace_lock){+.+.}-{3:3}, at: unregister_ftrace_function+0x2b/0x230
[  448.256342] 1 lock held by repro/425:
[  448.258088]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  448.262205] 1 lock held by repro/427:
[  448.263242]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  448.267384] 1 lock held by repro/430:
[  448.268413]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  448.272557] 1 lock held by repro/429:
[  448.274354]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  448.278575] 1 lock held by repro/432:
[  448.279631]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  448.283856] 
[  448.284660] =============================================
[  448.284660] 
[  560.206631] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 100354 jiffies old.
[  595.054648] INFO: task repro:419 blocked for more than 294 seconds.
[  595.056103]       Not tainted 6.3.0-rc3-kvm-e8d018dd #1
[  595.058758] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  595.060338] task:repro           state:D stack:0     pid:419   ppid:395    flags:0x00004002
[  595.063086] Call Trace:
[  595.064000]  <TASK>
[  595.065607]  __schedule+0x40a/0xc30
[  595.068094]  schedule+0x5b/0xe0
[  595.070083]  schedule_preempt_disabled+0x1c/0x30
[  595.071455]  __mutex_lock+0x824/0xcb0
[  595.073013]  ? perf_trace_destroy+0x21/0xa0
[  595.075071]  ? perf_trace_destroy+0x21/0xa0
[  595.077326]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  595.079050]  mutex_lock_nested+0x1f/0x30
[  595.080202]  ? mutex_lock_nested+0x1f/0x30
[  595.082179]  perf_trace_destroy+0x21/0xa0
[  595.083467]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  595.084920]  tp_perf_event_destroy+0x1e/0x30
[  595.087110]  _free_event+0x101/0x810
[  595.088829]  put_event+0x3c/0x50
[  595.090414]  perf_event_release_kernel+0x2de/0x360
[  595.091753]  ? perf_event_release_kernel+0x9/0x360
[  595.093819]  ? __pfx_perf_release+0x10/0x10
[  595.095386]  perf_release+0x22/0x30
[  595.096766]  __fput+0x11f/0x450
[  595.099583]  ____fput+0x1e/0x30
[  595.100926]  task_work_run+0xb6/0x120
[  595.103524]  do_exit+0x547/0x12b0
[  595.105921]  ? write_comp_data+0x2f/0x90
[  595.107947]  do_group_exit+0x5e/0xf0
[  595.110439]  get_signal+0x1465/0x14a0
[  595.113659]  arch_do_signal_or_restart+0x33/0x280
[  595.116675]  exit_to_user_mode_prepare+0x13b/0x210
[  595.119104]  syscall_exit_to_user_mode+0x2d/0x60
[  595.120655]  do_syscall_64+0x4a/0x90
[  595.122788]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  595.124137] RIP: 0033:0x7f7722b9159d
[  595.126152] RSP: 002b:00007f7722a6aca8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  595.128042] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f7722b9159d
[  595.130250] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  595.131772] RBP: 00007f7722a6ae00 R08: 0000000000000000 R09: 0000000000000000
[  595.134033] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdb9febe5e
[  595.135572] R13: 00007ffdb9febe5f R14: 00007ffdb9febef0 R15: 00007f7722a6b700
[  595.139283]  </TASK>
[  595.140217] INFO: task repro:416 blocked for more than 294 seconds.
[  595.142705]       Not tainted 6.3.0-rc3-kvm-e8d018dd #1
[  595.143964] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  595.146263] task:repro           state:D stack:0     pid:416   ppid:404    flags:0x00004002
[  595.148288] Call Trace:
[  595.150743]  <TASK>
[  595.152189]  __schedule+0x40a/0xc30
[  595.154648]  ? wait_for_completion+0x7b/0x180
[  595.156049]  schedule+0x5b/0xe0
[  595.157468]  schedule_timeout+0x4db/0x5b0
[  595.159739]  ? schedule_timeout+0x9/0x5b0
[  595.162351]  ? wait_for_completion+0x7b/0x180
[  595.163685]  wait_for_completion+0xa6/0x180
[  595.165981]  __wait_rcu_gp+0x136/0x160
[  595.167439]  ? __pfx_arch_ftrace_ops_list_func+0x10/0x10
[  595.169325]  synchronize_rcu_tasks_generic.part.24+0x3b/0x60
[  595.170754]  ? __pfx_call_rcu_tasks+0x10/0x10
[  595.172046]  ? __pfx_wakeme_after_rcu+0x10/0x10
[  595.174306]  ? verify_cpu+0x10/0x100
[  595.175832]  synchronize_rcu_tasks_generic+0x24/0x70
[  595.177391]  synchronize_rcu_tasks+0x19/0x20
[  595.178748]  ftrace_shutdown+0x1cc/0x410
[  595.180589]  unregister_ftrace_function+0x35/0x230
[  595.183146]  ? __sanitizer_cov_trace_switch+0x57/0xa0
[  595.185014]  perf_ftrace_event_register+0x95/0xf0
[  595.187106]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  595.188492]  perf_trace_destroy+0x3a/0xa0
[  595.190650]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  595.192050]  tp_perf_event_destroy+0x1e/0x30
[  595.193636]  _free_event+0x101/0x810
[  595.195375]  put_event+0x3c/0x50
[  595.196797]  perf_event_release_kernel+0x2de/0x360
[  595.198772]  ? perf_event_release_kernel+0x9/0x360
[  595.200619]  ? __pfx_perf_release+0x10/0x10
[  595.202793]  perf_release+0x22/0x30
[  595.204118]  __fput+0x11f/0x450
[  595.206330]  ____fput+0x1e/0x30
[  595.207619]  task_work_run+0xb6/0x120
[  595.209570]  do_exit+0x547/0x12b0
[  595.211192]  ? write_comp_data+0x2f/0x90
[  595.213301]  do_group_exit+0x5e/0xf0
[  595.215069]  get_signal+0x1465/0x14a0
[  595.218659]  arch_do_signal_or_restart+0x33/0x280
[  595.221777]  exit_to_user_mode_prepare+0x13b/0x210
[  595.223405]  syscall_exit_to_user_mode+0x2d/0x60
[  595.224909]  do_syscall_64+0x4a/0x90
[  595.226974]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  595.228316] RIP: 0033:0x7f7722b9159d
[  595.230569] RSP: 002b:00007f7722a6aca8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  595.232391] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f7722b9159d
[  595.234504] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  595.235932] RBP: 00007f7722a6ae00 R08: 0000000000000000 R09: 0000000000000000
[  595.238043] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdb9febe5e
[  595.239469] R13: 00007ffdb9febe5f R14: 00007ffdb9febef0 R15: 00007f7722a6b700
[  595.243044]  </TASK>
[  595.244090] INFO: task repro:425 blocked for more than 295 seconds.
[  595.246596]       Not tainted 6.3.0-rc3-kvm-e8d018dd #1
[  595.247797] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  595.249475] task:repro           state:D stack:0     pid:425   ppid:402    flags:0x00004002
[  595.251419] Call Trace:
[  595.252336]  <TASK>
[  595.254448]  __schedule+0x40a/0xc30
[  595.256931]  schedule+0x5b/0xe0
[  595.259688]  schedule_preempt_disabled+0x1c/0x30
[  595.261037]  __mutex_lock+0x824/0xcb0
[  595.263401]  ? perf_trace_destroy+0x21/0xa0
[  595.264703]  ? perf_trace_destroy+0x21/0xa0
[  595.267542]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  595.269904]  mutex_lock_nested+0x1f/0x30
[  595.271085]  ? mutex_lock_nested+0x1f/0x30
[  595.272349]  perf_trace_destroy+0x21/0xa0
[  595.274364]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  595.275730]  tp_perf_event_destroy+0x1e/0x30
[  595.277337]  _free_event+0x101/0x810
[  595.279086]  put_event+0x3c/0x50
[  595.280473]  perf_event_release_kernel+0x2de/0x360
[  595.282535]  ? perf_event_release_kernel+0x9/0x360
[  595.284410]  ? __pfx_perf_release+0x10/0x10
[  595.286934]  perf_release+0x22/0x30
[  595.288328]  __fput+0x11f/0x450
[  595.291181]  ____fput+0x1e/0x30
[  595.292542]  task_work_run+0xb6/0x120
[  595.295127]  do_exit+0x547/0x12b0
[  595.296739]  ? write_comp_data+0x2f/0x90
[  595.299422]  do_group_exit+0x5e/0xf0
[  595.301300]  get_signal+0x1465/0x14a0
[  595.304201]  arch_do_signal_or_restart+0x33/0x280
[  595.307819]  exit_to_user_mode_prepare+0x13b/0x210
[  595.310117]  syscall_exit_to_user_mode+0x2d/0x60
[  595.311564]  do_syscall_64+0x4a/0x90
[  595.312915]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  595.314996] RIP: 0033:0x7f7722b9159d
[  595.316223] RSP: 002b:00007f7722a6aca8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  595.318821] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f7722b9159d
[  595.320288] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  595.322490] RBP: 00007f7722a6ae00 R08: 0000000000000000 R09: 0000000000000000
[  595.323955] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdb9febe5e
[  595.326146] R13: 00007ffdb9febe5f R14: 00007ffdb9febef0 R15: 00007f7722a6b700
[  595.329860]  </TASK>
[  595.330790] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
[  595.332380] 
[  595.332380] Showing all locks held in the system:
[  595.334428] 1 lock held by rcu_tasks_kthre/11:
[  595.335544]  #0: ffffffff83d63490 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  595.339209] 1 lock held by rcu_tasks_rude_/12:
[  595.340343]  #0: ffffffff83d63210 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  595.344102] 1 lock held by rcu_tasks_trace/13:
[  595.345460]  #0: ffffffff83d62f50 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  595.349059] 1 lock held by khungtaskd/29:
[  595.350802]  #0: ffffffff83d63ea0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x1b/0x1e0
[  595.354998] 1 lock held by repro/419:
[  595.356037]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  595.360123] 2 locks held by repro/416:
[  595.361309]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  595.364710]  #1: ffffffff83e1cd68 (ftrace_lock){+.+.}-{3:3}, at: unregister_ftrace_function+0x2b/0x230
[  595.368890] 1 lock held by repro/425:
[  595.370633]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  595.375506] 1 lock held by repro/427:
[  595.376544]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  595.380137] 1 lock held by repro/430:
[  595.381332]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  595.384754] 1 lock held by repro/429:
[  595.386509]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  595.390628] 1 lock held by repro/432:
[  595.391653]  #0: ffffffff83e206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  595.395216] 
[  595.396002] =============================================
[  595.396002] 
[  758.862658] INFO: rcu_tasks detected stalls on tasks:
[  758.863903] 00000000858563e2: .. nvcsw: 1/1 holdout: 1 idle_cpu: -1/1
[  758.865579] task:repro           state:R  running task     stack:0     pid:452   ppid:398    flags:0x00004004
[  758.868098] Call Trace:
[  758.869032]  <TASK>
[  758.870199]  ? __wake_up_common_lock+0x5/0xd0
[  758.871725]  ? preempt_count_add+0x9/0xc0
[  758.872868]  __wake_up+0x17/0x20
[  758.874225]  io_cq_unlock_post+0x34/0xb0
[  758.875706]  ? __io_cqring_overflow_flush+0x33a/0x360
[  758.878046]  ? io_cqring_do_overflow_flush+0x37/0x90
[  758.879380]  ? io_cqring_wait+0x707/0xaf0
[  758.880760]  ? io_cqring_wait+0x9ee/0xaf0
[  758.883425]  ? __pfx_io_wake_function+0x10/0x10
[  758.885940]  ? __x64_sys_io_uring_enter+0x207/0x680
[  758.888843]  ? do_syscall_64+0x3b/0x90
[  758.890390]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  758.893858]  </TASK>
"

I hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

Thanks!
BR.
