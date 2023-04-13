Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E26E0D36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjDMMHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:07:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B5E4680
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681387653; x=1712923653;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JGWqj1NtezttSPtvr3mg8ogtIV0JkBMI0cev7GIBlt0=;
  b=GxqRLgnXC+7VV5KL6Ctg1Y/fFFYJWQYHQ0jlv2ieCcy1z+3H4M1eBHVi
   5UuHZ3SHGkv5e+IOXqXyUMWMzczQ2Hz2P2f+cYBTbKJhsWRaSp1JPGPmI
   5zvmU///2nCCgpX9iCBArQ1UoCbBxyvrVXu7viPUHW3aNKlokNzliZhVA
   KntFwEeJmmOVW7vAn0k4hrJ0tzz8RFQtt2zt9z6eDrRJJnynPbaeqCpB+
   2AggaWa6Zddylb6kIgIT6JDnReXSD+cQq0SjiH/6QTFssDsf1rA4WmnVc
   Y8o6L+W0krGEB2OeQhb+QxwNmsIVqn5gS2uAO6orfiFmUKJ1tdV6c6YNI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="346849779"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="346849779"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 05:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="722035322"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="722035322"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 13 Apr 2023 05:07:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 05:07:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 05:07:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 05:07:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 05:07:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVlpa455J3xVHoTI/KBSi4jXGkrmNX1SyAXIEyBqVjcucHBMy2/fzIdvAsI3mICEF3eIzMBAg+7gMBMcAI4BLnyJ5sVoqzL/swpFZnJDvAhAmBImVXjsNTxTVmy+iHCnD7KN96Y6OLoVr+L8xYkMJPgko98WhEy7NNvHKaAocNIgMg7fRnqcQKau+eKFxpK/kU60D64wYSqfTv63gAUtoeQd4qrqm5yduRjgV6vs5mOTqdVdDQT/QKjXQxKHWkXmF9Bn2hEA43uALDj8s46OaM2bnnfM3TRsMjiU6XkrpcAO0inPQO0x0WcoY1lsLAOwD0cpXrqR4DqLzdVN+iRiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3smbrss0flbwhVeFZPi7psxz64yG2mFKCr79SY3l08=;
 b=igQY4oCxmUbq+Das3WioUVDkf2cKMevnWDQ6KMxfcnyvw69vhFHzwDnzIBO4lxdNn6ayz6LRC3c31lSEblQzN0fEcoXrpA7RoQVLKNYeJPiqHAmUthA0dviUxc5HQstYTEzSml3WGvVUvhh8PJvbUE+2tJz0X/qqVIhjcA1u2JSl7nGMJYwJy5Yd8KEWLDtoB/B/7WXbBzkc+TivB2HyrmEvpGaBxP409CVCMvj/Dwivyysau/7+bcOzrF6damBa7808Vzg3qmkA6kqp/zUkLd8V9mtnX4OoH2bnHdnzEkgVnzbIrxXVo4yt6sUN1+Aumsc1S5BtW6jeG1CxzzV3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MN2PR11MB4534.namprd11.prod.outlook.com (2603:10b6:208:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 12:07:26 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 12:07:26 +0000
Date:   Thu, 13 Apr 2023 20:09:01 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, <lihuafei1@huawei.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>, <quic_neeraju@quicinc.com>, <paulmck@kernel.org>,
        <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "task hung in synchronize_rcu
 bisect" in v6.3-rc2 kernel
Message-ID: <ZDfw3chR+VVO+ImZ@xpf.sh.intel.com>
References: <ZBG4HOCQIlGFFcIn@xpf.sh.intel.com>
 <ZDdsz+5/QehZ25hg@xpf.sh.intel.com>
 <ZDflLOCujdBNXl3D@lothringen>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDflLOCujdBNXl3D@lothringen>
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MN2PR11MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: aacba156-14a3-42ae-f153-08db3c17a56f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8nWF7xuwD5o2HOyKakmKHhoeAOdbVmq/j8xLp55w8xlRlb2D6t9fI1tL/cCtOJtEvIgdWr94NmfF55DpA0bURQ28qNW55wxRkMKf7ASfv7Wa3hBCCRglJ1uYX56NVGcChtfiThD/vICgHl19cOK9pPy8b7NsXg3eQdO1SN7PjSOyfTjdhZ7nqfH/hrBMD5MLPSJremQ00j/CeCZQRxUJa+FfCCSx12SFZ4pLJvuThbiyMiC5SmbwQlQk7cMviZbYnSR5sdyGriJURH3PYzcuNmQjVCXWUpFcHhUplAfhqceRIKODKMAPcTk1fSGml6ecf/86w2lgqLB32rf5S5HN7rwdwPRRjHH+79BLMEKtt6aBpPOFOkW50RNK+V7eYDEmMuqoXvUQ1wuSNXSHzj2UomGzVN/6QZshyD88MRpLGm1OibT7VlY4k0zBgdY9trSshgguDgLZgRKYuNdNrDJ5b6vgV21jmeOTRvKBveRtW0ymfkSjZl8MCUfbv7NBFyuvxjTBJ7iK/jziSyISyzQgh2hJKgmk4afSq885P2Lv2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(86362001)(44832011)(478600001)(316002)(82960400001)(41300700001)(38100700002)(8676002)(8936002)(5660300002)(6916009)(66476007)(66556008)(107886003)(53546011)(6512007)(6506007)(26005)(186003)(4326008)(66946007)(6666004)(83380400001)(2906002)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXimANmv42jr0VeHI8TuRQtbTg/8i1hGp0GG55+0TN608TUPgJrR0+XIIOAc?=
 =?us-ascii?Q?sojD6/As6NyVfQHHqjB3nBoA0F6yCq+9YuBRo9niOFAe3d7fSIdslKi4GWsA?=
 =?us-ascii?Q?4+LZfvfHafZhP5nhMv3snUveuvx0ESblbahxsXlxz7hw4LieE6gORujxkbwE?=
 =?us-ascii?Q?gBt84CqREU+K2x/HWZj3lENJsPTNUOVlUpfAKLfAMP6R8/RGa+tnipH4oHUm?=
 =?us-ascii?Q?ZEiSQc4ElWvI5DdpLwJIozLEHu9P2jOsr707F9/T+58pSXukXRu8P/mz+cDx?=
 =?us-ascii?Q?3N8yLnqL3xTGzOsxk9OpPJDitsuLxsCm8j4zUj/LW5C8l1QxfsEbrvDP/YPD?=
 =?us-ascii?Q?5yyXevDIIPuA6Pp3OHwpVhJqnXmL+04uAOb9ciMq45vXPumiMktfsNa08959?=
 =?us-ascii?Q?MBCG0mJc0nRGetQnfhTI0S8diCL+2bqqkGUnJwCaDGvJiyfCsBUTxbnICPuf?=
 =?us-ascii?Q?sE/G2E3lG6vD5Sq8J2HKXYgRTNnbxN7OtPXqRngrV7ISx4wQTamVm5/UpXCq?=
 =?us-ascii?Q?JXCa27mQmWR0DzD/cd55HdLvxw2WE1pzNXoUJwdhTPveqsOBUVrHI+1KOvCQ?=
 =?us-ascii?Q?o+bOFYppmlCAoYi5Xe+wrbrc+GcKi+ZjXikDL0KWLLvTObb0e/eYkvThq1fX?=
 =?us-ascii?Q?QQ6w8dq+lEpuK3vA/bRlXDq7X+BEgiBNVIZPZJOy7p3NsxzXtzfYwIKRIUcs?=
 =?us-ascii?Q?nm3lX84dfB0VRxrRi0bfvct0Nc/+uzvixKyHlrtxQHyVyn7gQ0znWg6A8g+D?=
 =?us-ascii?Q?4JtK2M9GYZcYYhl2MFcClzSLzbydflkkQUF8Mfd8iDXDp06ZUbRbQqVgxGHo?=
 =?us-ascii?Q?teUBtTIeKBSPldrN+Iws8AZaOMKSF1SVHfBDmRBgeD+o9Knh9MlPuJCapN+m?=
 =?us-ascii?Q?2ytrIWIlzDSgmo3FF9fpFN/b88EROfccpq41MxmRhu0RVhqBTm6zbD2buSR0?=
 =?us-ascii?Q?ODXS+Zc4S7IOmwo6C3aqlsNe6d+PRAHYF4p22lr/aP02V8CM47qPL8oSDmHe?=
 =?us-ascii?Q?TOa3ye92WkpBvr+MFQodJ9KzObcQbucLqtRNYqwEZrFqJ+E4GUIsfaUjaM3s?=
 =?us-ascii?Q?1XVo/d77tYb4HCdYtTVBXt7GF6zQY3ZrhlOP2gKZE45LjUoEmdIq5vQP7N6v?=
 =?us-ascii?Q?SiBJp1Ci2a8ZoyZmRYCWE9nw9zA4nhpkO5xH1ViKX53eZOzjiFXcsAKxWk8H?=
 =?us-ascii?Q?XfwNJrgjrYys48TjtB6HcULLccoqg9WwHpxcMPeoj7d8cIMwmA8Dd/PJpS4C?=
 =?us-ascii?Q?LKkmQs5z8NzjLX3tVbtSHojsTTagEgjrXESZo7rHPrqKO9DvVporaXa1R7pq?=
 =?us-ascii?Q?zqXeHKWdbcfw/ELCyNoTEc9oCjSGGINskxfJOMf2hmcTccfXUdogWgJIh1KN?=
 =?us-ascii?Q?1cJMRLAkQ/4xithvdvJA9RDOZj7p7xirErnr7CfYzJlgwWpLf0Y9G2zG4UJM?=
 =?us-ascii?Q?x8h4cg9UTUKb3/9mCtZpYTgHTuWvh7KylbphZzDR4feuJR9Qf+imlpweGfFJ?=
 =?us-ascii?Q?6pc4JuRez5K6NM8K0KkzRy7nZl1n5fJtNf49lwspDGjHLDeJRhS612RvzIcF?=
 =?us-ascii?Q?lIsZ48QMr7/oxL9qiS3uxhtxN2hY5ILmQBQhLs5h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aacba156-14a3-42ae-f153-08db3c17a56f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 12:07:26.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7LPhUn1OIoC4OQZb/kwKdB281Y1eehsPdE3Y92iGrKWMf5A3EFU35z1EC+rnN4r0LhjehPoj9hEd6Ax+p8KPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4534
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-13 at 13:19:08 +0200, Frederic Weisbecker wrote:
> On Thu, Apr 13, 2023 at 10:45:35AM +0800, Pengfei Xu wrote:
> > Hi Huafei and kernel experts,
> > 
> > It's a soft remind.
> > This issue could be reproduced in v6.3-rc6 kernel.
> > It could be reproduced on Alder lake, Raptor lake and so on x86 platforms.
> > After reverted the commit "0e792b89e6800c:ftrace: Fix use-after-free for
> > dynamic ftrace_ops" on top of v6.3-rc6 kernel, this issue was gone.
> > 
> > New syzkaller reproduced code, repro.report, bisect_info.log and detailed logs
> > are in link:
> > https://github.com/xupengfe/syzkaller_logs/tree/main/230412_031722_synchronize_rcu
> 
> I just tested against v6.3-rc6 and again all I get is this io_ring related
> issue:
> 
  Seems this issue could get different behavior on different platforms.
  I could reproduce the synchronize_rcu issue on Alder lake S(cpu model:151)
  and Raptor lake P(cpu model:186) platforms.

  Thanks!
  BR.

> [  448.290752] INFO: task kworker/u4:0:9 blocked for more than 294 seconds.
> [  448.293868]       Not tainted 6.3.0-rc6-kvm #1
> [  448.296019] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  448.299592] task:kworker/u4:0    state:D stack:0     pid:9     ppid:2      flags:0x00004000
> [  448.303397] Workqueue: events_unbound io_ring_exit_work
> [  448.305884] Call Trace:
> [  448.307147]  <TASK>
> [  448.308166]  __schedule+0x422/0xc90
> [  448.309824]  ? wait_for_completion+0x77/0x170
> [  448.311870]  schedule+0x63/0xd0
> [  448.313346]  schedule_timeout+0x2fe/0x4c0
> [  448.315255]  ? __this_cpu_preempt_check+0x1c/0x30
> [  448.317360]  ? _raw_spin_unlock_irq+0x27/0x60
> [  448.319400]  ? lockdep_hardirqs_on+0x88/0x120
> [  448.321395]  ? wait_for_completion+0x77/0x170
> [  448.323462]  wait_for_completion+0x9e/0x170
> [  448.325356]  io_ring_exit_work+0x2b0/0x810
> [  448.327300]  ? __pfx_io_tctx_exit_cb+0x10/0x10
> [  448.329345]  ? _raw_spin_unlock_irq+0x27/0x60
> [  448.331397]  process_one_work+0x34e/0x720
> [  448.333212]  ? __pfx_io_ring_exit_work+0x10/0x10
> [  448.335377]  ? process_one_work+0x34e/0x720
> [  448.337295]  worker_thread+0x4e/0x530
> [  448.339079]  ? __pfx_worker_thread+0x10/0x10
> [  448.341008]  kthread+0x128/0x160
> [  448.342513]  ? __pfx_kthread+0x10/0x10
> [  448.344305]  ret_from_fork+0x2c/0x50
> [  448.346016]  </TASK>
> [  448.347176] 
> [  448.347176] Showing all locks held in the system:
> [  448.349887] 2 locks held by kworker/u4:0/9:
> [  448.351829]  #0: ffff88807eb6dd38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x2b4/0x720
> [  448.356362]  #1: ffffc9000005fe68 ((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work+0x2b4/0x720
> [  448.361052] 1 lock held by rcu_tasks_kthre/11:
> [  448.363142]  #0: ffffffff83963450 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
> [  448.367396] 1 lock held by rcu_tasks_rude_/12:
> [  448.369387]  #0: ffffffff839631d0 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
> [  448.373808] 1 lock held by rcu_tasks_trace/13:
> [  448.375852]  #0: ffffffff83962f10 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
> [  448.380434] 1 lock held by khungtaskd/30:
> [  448.382219]  #0: ffffffff83963e60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x17/0x1d0
> [  448.386291] 
> [  448.387159] =============================================
> [  448.387159] 
