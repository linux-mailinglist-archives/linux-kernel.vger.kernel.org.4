Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D954A6B88DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCNDJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCNDJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:09:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C330E9F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678763347; x=1710299347;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NoNuKE3w2GaCbjt0sw3FF0F93fgJS7LWPCmQTL0EuEc=;
  b=DiEZn0wNMCe3DLLCXQ0P4o0CF2k7wjVFxV/HerZUufNHHTsSLBtBIa8s
   ZccN0EWpXWRhORykAmcBieCeRt38+v9zQ2H18VzNyiRGiuf0pG8uVFjFp
   M5PdY8LUuuW3lfuPVdUFemTQxtThgi9jqpJnPcaT9g0U1JPks7v5Mb6rB
   1Wtk9GMhOoHp4HPMGNYnzAID5bwHoPQz80TakdgOqjkJRSXh7xamrcEkc
   30TRdrc1g1rRp5uN1l+Lajcm4r2JWw6zmALTfJ45aVNz5NaaBHVevg1uJ
   hGAbvM/miBc0tOmn9TWALrXvQIKTI1mzswkTA/cQIgI7jM0vyMGuBrBMY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399908430"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="399908430"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 20:08:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="789169229"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="789169229"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 13 Mar 2023 20:08:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 20:08:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 20:08:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 20:08:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 20:08:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6ZEambbk0UU2ZQSE4cainjfMS0p2EeoQAg8lPsaN8mQhbyp8cJTb31UmYNTi39mNlT5u6HtQ6q3Q2mkLbnanau9ZEQKI3OXaCJE1TCZUx4ucOLLIlVosg8pQ/8DgAGOtAahrmy71lm4HCWIzzcPfzmoKdt56uWx/hxzOulj7ggqqBmPmDOfT2y/MioHs5hM8SE+qfXi/zg2aF4wKyTOWOkgAtfhl+ct6BCbs+G6kmvJdQfS2yTJKXg7ujPMhEo4QD5q7+2mG4Y+DnPDdRyJthEruL/kz03kTh49BCSnmHzv+dJRzQZj+G8Pos8UiJFF1XtLGxjVkz7wGjW2+HViZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCuD1CZWRIOnPE+AMskJXcht1bYAEnn90SM/RY4MSdA=;
 b=NBJfmeLP8a7QmupNoDIpJLjjcB6/BqHmXU8sDdONXvwjcmVKUppqeLQoNpNaQpaXH7I/Gt7zAJN/tCyKk89fqW+rUm2+xrc/GsFf7jghnuSmnFXWIhIROwH09Ic2ial6HOfFfrJADqk55xjksN85Qc2k0dAFuvdcd5BT/6+IPutAYzI3EL9Cgf0EChql+wFkxzYLK8H+GVCdBqI3bWDvUcG7VegvgG/DHOXHmepD7NXEG0HGUlKw+2oxYBHM4jPl4tIW9ilyvE7b1C54LijPb2pIWkIkawKhd+pfoThpX6TrLmj+aaFuAgLsb1FLeOmCKYYG0B93usp5+rdfbRJOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Tue, 14 Mar
 2023 03:08:35 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 03:08:34 +0000
Date:   Tue, 14 Mar 2023 11:08:18 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <linuxarm@huawei.com>,
        <prime.zeng@huawei.com>, <wangjie125@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: Re: [PATCH] sched/fair: Don't balance migration disabled tasks
Message-ID: <ZA/lIjaNY7PhjcXh@chenyu5-mobl1>
References: <20230313065759.39698-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230313065759.39698-1-yangyicong@huawei.com>
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ1PR11MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 548c7a5b-896f-4bd0-d374-08db24396605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIrkQ5/iko1WCaK6jCOoFNOhtsNqiVVwZCPd57+zMzwf9azYwJlvpMygBXBeHLnDAKTiQz+JBBAId3Vqm+zD7FcZbxspiKFn1XWMEk8Mz87oT1O+oVYMroS5pW56TSqpHNEb7Hkx4P8QVXE8DuJnhhur7nKAUNaj1iaT3J7ZBUkKKLhR78C5R9AXB0h0LVavDRUWP7g3sTNT24TaChIFUBuUcl0WfIiXVOPzlTO1rvuycrpDngDwj8R/Mk+CovjNMoV1FHYS92+f+WQybjlgAdEPpZbQMXhyEgkIRccpW95/4s4v1g5mmbiZ0gf8++Kndi8irJdKIFfRbU0XThMOoCPW7c3EMDAOLZXiND/53W7Rq3Dafl4PKIXqBByRTjAuG8mhhJJi1CNIglL12TvKqy+Z2YwN+FUkrC+a76CfouoU1RL24Fc5rpoKciPtE819cURzNAnOwwXcIA0Lj9cM+rAWGnhPluC0T7QIjYKTKrR6XuhzFw7Q6L3JvPSDDZIc7rVI7VhUxxOW4CEaGfhzbioqxKqpGH0mCqFYjKCd1z3M09HIwpqHBhCNPwSUPgrGisUQ1AkZx6wKyAaBWFCmC+285m22g+Tc4yaPQztDO1vhZus59TFnmIKQjMx3Uaf6Dj/8M72SWKGVtm8WFO4kVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(5660300002)(82960400001)(66946007)(33716001)(186003)(478600001)(45080400002)(7416002)(2906002)(6512007)(6506007)(6486002)(26005)(53546011)(9686003)(6666004)(86362001)(8936002)(38100700002)(8676002)(6916009)(66556008)(4326008)(83380400001)(66476007)(316002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?USlc/ROCRUrL4To5jPnn6XK40WDW6e5c/2+lfQwkha5CTyrBUfUEBCA7dCHv?=
 =?us-ascii?Q?IeWbY5+36M1mMNJ0Q8HCS7pJLQA9/NVh260ecyel56yUdPTLLa93H8UL8obd?=
 =?us-ascii?Q?d+2lwsIdysNStF8X686CkzNjs5Mc6LdG2cVJezlWof2xct+QKZVuD0+gPjEL?=
 =?us-ascii?Q?aHn0LxkL2ybBOvWxlfOE5j4DyMK7YzM5ryj/3Y1Z7PLYe9RE34URh9z0eOg5?=
 =?us-ascii?Q?SUMhQ+IDGq+5UBNIIncd2XpWqABFTJFOp3MqF5tZWomE9lGAjogbY57yZnFN?=
 =?us-ascii?Q?XtDA9JN2QhyIU2o7AdYE2rWa7/7Kdi6HQo+9H+y6J4DRZy5vkhuNJXFytcig?=
 =?us-ascii?Q?GyoqqxKP3A9Bk0WTwGK46vOmEiZwSdGWCPRx8vFWDgdbzwijoEWY51WyGou/?=
 =?us-ascii?Q?bh4nY2Q19nUmNlMReK/r0eOLEM0ApVwXcdci5Vje8Gav/MAemmxMAgcPVgNQ?=
 =?us-ascii?Q?sEA4aK4zSbMrPupJRs8hCvZuaC1ZLtLw1kFWr9iB1sjiNFC0bdi//y6N+nd0?=
 =?us-ascii?Q?x0SWYaXKsUXUHNxxjia+eB10cAPR14xGLyoXpYC/lS0d00NZvcHejobIZdtx?=
 =?us-ascii?Q?JGVnOFpAm8zMzl4NJuxPS/Nfj7c5Es5MwjBi5LMQIqdOHrHryTc0aPzY99ME?=
 =?us-ascii?Q?MNf1VPdmhNIc+4NkrN1B/BlMV/bvFwS7P/iTNKFuZcLHFscc1sXrSYddo+2A?=
 =?us-ascii?Q?cqVSwl4wRr6NP3UFLbjNVOGfzCHKQJyA7lQZ6V6zNZ545bAXsm1Q5v8Z+jII?=
 =?us-ascii?Q?bd8oaqiah5meaJcc6im0m5fkfNVW9fdzRzB0tn2MIQbMxWta40m/5ZbRxfKK?=
 =?us-ascii?Q?fmSeSHgN8EuFIUVjFF3KarqquhZj2Toy7cAGb3wGzM8vV3Ezw2XGkAlMjJwb?=
 =?us-ascii?Q?3EYjslHyIc/Iwh9KY80iDo/4Bs4AkTASb4iJT/D7TDXraWxMfAM1Gha04BOK?=
 =?us-ascii?Q?g+ryS2AwCCk8/gGVGDLhcd68w6T9HRRja/2ZWlFPDz+DThkOkpwSu0Ac0XCZ?=
 =?us-ascii?Q?60ZrdL+BDnYEhourxys3dLLYrZlfG0opFfwLg0hZ+uwsy4H/90h7i01Fyp6g?=
 =?us-ascii?Q?NPa2K2nDOeu3YBss1HovqVjZplAE9+DZieMCsmnjx1xv8nbbvfCmzfjQlK39?=
 =?us-ascii?Q?GL56/DTKIubyTEqfS3++hTiAEy0+nnPT4aY1WA6HVjLkMU6vkNv85gQQ1yka?=
 =?us-ascii?Q?7H9EDkTJnnscFkH9eDjW4uSYmcbqSRlhMa7J54x4T4AAJJ3WpLkGRqGcHrPs?=
 =?us-ascii?Q?SB3MqEZpn8PapViv/pQ2gxuxdm1Ilsq7I+iNvrCmHnKWD+MB/Wd2Js4EQntA?=
 =?us-ascii?Q?NG8JvR9u4kVXmAfJPN/V9pPHR+9JHuMdvaT4dMRTWGPolP99YXryDu+UmHm0?=
 =?us-ascii?Q?wWhRrzX+POWagTUa5Y4FoQXyUUc0+03t6tMVe0idHZu+l40BoNb06J+F/0/i?=
 =?us-ascii?Q?P7fRxwTPsiXQ2zSkHe8Q1ct2pFSinpq9307jRpLe3EvfajcNaKqJMuNz2A1s?=
 =?us-ascii?Q?R0HEWnD0unIilkvgr+cilc6BGGYnx7Su/jZ/ru7dHbFgi3ZDKiujnOaDyR7e?=
 =?us-ascii?Q?Ru3dOo0fn1nAmmUO74yr7sbDNOkdUo6vhNrRq1Ea?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 548c7a5b-896f-4bd0-d374-08db24396605
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:08:34.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpCv8FNba0D1WRkd1OrqmFPS4rs4q3xC/jlZ3+e8WzFJs9no6kenxz9rheIW+hChncij/PpJDa77qfTkFKM0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
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

On 2023-03-13 at 14:57:59 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> On load balance we didn't check whether the candidate task is migration
> disabled or not, this may hit the WARN_ON in set_task_cpu() since the
> migration disabled tasks are expected to run on their current CPU.
> We've run into this case several times on our server:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 7 PID: 0 at kernel/sched/core.c:3115 set_task_cpu+0x188/0x240
>  Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT nf_reject_ipv4 <...snip>
>  CPU: 7 PID: 0 Comm: swapper/7 Kdump: loaded Tainted: G           O       6.1.0-rc4+ #1
>  Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
>  pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : set_task_cpu+0x188/0x240
>  lr : load_balance+0x5d0/0xc60
>  sp : ffff80000803bc70
>  x29: ffff80000803bc70 x28: ffff004089e190e8 x27: ffff004089e19040
>  x26: ffff007effcabc38 x25: 0000000000000000 x24: 0000000000000001
>  x23: ffff80000803be84 x22: 000000000000000c x21: ffffb093e79e2a78
>  x20: 000000000000000c x19: ffff004089e19040 x18: 0000000000000000
>  x17: 0000000000001fad x16: 0000000000000030 x15: 0000000000000000
>  x14: 0000000000000003 x13: 0000000000000000 x12: 0000000000000000
>  x11: 0000000000000001 x10: 0000000000000400 x9 : ffffb093e4cee530
>  x8 : 00000000fffffffe x7 : 0000000000ce168a x6 : 000000000000013e
>  x5 : 00000000ffffffe1 x4 : 0000000000000001 x3 : 0000000000000b2a
>  x2 : 0000000000000b2a x1 : ffffb093e6d6c510 x0 : 0000000000000001
>  Call trace:
>   set_task_cpu+0x188/0x240
>   load_balance+0x5d0/0xc60
>   rebalance_domains+0x26c/0x380
>   _nohz_idle_balance.isra.0+0x1e0/0x370
>   run_rebalance_domains+0x6c/0x80
>   __do_softirq+0x128/0x3d8
>   ____do_softirq+0x18/0x24
>   call_on_irq_stack+0x2c/0x38
>   do_softirq_own_stack+0x24/0x3c
>   __irq_exit_rcu+0xcc/0xf4
>   irq_exit_rcu+0x18/0x24
>   el1_interrupt+0x4c/0xe4
>   el1h_64_irq_handler+0x18/0x2c
>   el1h_64_irq+0x74/0x78
>   arch_cpu_idle+0x18/0x4c
>   default_idle_call+0x58/0x194
>   do_idle+0x244/0x2b0
>   cpu_startup_entry+0x30/0x3c
>   secondary_start_kernel+0x14c/0x190
>   __secondary_switched+0xb0/0xb4
>  ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a1b1f855b96..8fe767362d22 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8433,6 +8433,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if (kthread_is_per_cpu(p))
>  		return 0;
>  
> +	/* Migration disabled tasks need to be kept on their running CPU. */
> +	if (is_migration_disabled(p))
> +		return 0;
> +
>  	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>  		int cpu;
>  
> -- 
> 2.24.0
>
Looks reasonable to me. Would it be possible to also update the comments at the beginning of
can_migrate_task() starts with: "We do not migrate tasks that are:"

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu 
