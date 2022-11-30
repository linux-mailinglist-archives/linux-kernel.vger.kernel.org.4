Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8136B63CE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 05:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiK3EDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 23:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiK3EDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:03:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEDD2EF14
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 20:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669781016; x=1701317016;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ayk9Eu6f2IoaGxPbClXkcBhkkHe9KVSeKlLIIimyo2A=;
  b=LwiCJpW8sijF9HZPE3IfkSY6sibMSq96equXnBFoDK8IWqPIXoMW/QsQ
   ZH/AcNo+yuHc6rTP9m0+Audo/wfP3YjXiSWWaEf6KPz9czyE1JA7bmKAU
   NeFTOAbWS93nCa7Sk90MQCNpR3wkMlcejjBAmE5OHANjVyEKPPwED9rfE
   1vT+yulmczwRqLnpfqFSlCjgT1daWiSrWU0xZxe9r0ZXvy6fA7QgL6UeV
   89KyrBJsIohgBEfQ3xBzm3DXFpLDwaDwgg6xZaVDWFkd/8oue6zq6eXUx
   y082Yb2ELZKptetm75iWJlz7K+v4TAeppm5xv2mCccLxmyR+iM1DPb7xq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342220327"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="342220327"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:03:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="786311927"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="786311927"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2022 20:03:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 20:03:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 20:03:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 20:03:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 20:03:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFpJWNcVbxtAFP31iBVGPH2WwGxnLpi8BZyNPmdW2if7D46pLHiIpf0r/Kg46ujoHf0ERbZahTTRUTQqQpO+NV7ts+T2mvgbSEFRJbe9kEJb4a0lDd9NwZ6TqIcoEuMqBIg6OQY+dapgAZWgjMAiXfnZHpl6XipEhS4AFln/8xOSnxJ7MQUaCVnMr0TZq9PYXJF5ZCR+mf1fAvYeIZNunq7/QWjtaj8VbQQciuZEQSek1P3Frh6Jkv6fENNsWU+K0Wz9bKBN84y03wz0CvK4LCDiwQc2QvMwNeAKvd9hiFkjQmw36UJM4uqVt+0Ka+8D41LEiZkILvo4OJztCiPn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcey2FXXqVJw7yfC74y0iqscWvFpI71mouz1hFCaL0g=;
 b=mKxpwE0yXjket0be7pyPQwUyS83yUw1uuLgXROHs2O9i/ziEFcITp5SPVZtY7Y55DvK+jq0pYEtWCBZMYGh9+9KNHvqLhpeddbvhwyM06L5EEc2BlN6U8JdU/qFCEhUqijIvpedLyCdmzHFmiZOAKb0MUYRWztMdJ6MlObBfh0ra3mETP0oqz3Fpw7lGGiKO3wpERgrS5jRz+DAjQO1l2IHvJcwy6Za5w+nl/yrg1WYpxsXRHzcKxAliGTdfpY2d9ECCyTO+8v8rdKbcBzMzowa/06ZnVFotXQzXnazy6XP6gT22aVX70393BRjdEX7VuiYlHMjgslxU45oqj+JFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 04:03:33 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 04:03:33 +0000
Date:   Wed, 30 Nov 2022 12:03:06 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rik van Riel" <riel@surriel.com>, Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/2] sched/fair: Choose the CPU where short task
 is running during wake up
Message-ID: <Y4bV+uaqx/P4Q4j+@chenyu5-mobl1>
References: <cover.1666531576.git.yu.c.chen@intel.com>
 <9b639dbe-15ec-da58-9e11-0b3b76a3fa1d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9b639dbe-15ec-da58-9e11-0b3b76a3fa1d@amd.com>
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 2739d629-48f5-4de2-b285-08dad287d8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrD2dewaoJuXFUxZeoJlPBfc7IGmqED2+5tw8Xfy4y40tPIM/vLb0325hYVfmc5YqmTwun5rDc2QThhZY4BiKmpzIohxfRQ4LnAGzcCUSPfO6xIg3vuLq/9g/1JCxdDDc4a9n9iyOW3U7/iKhn21GC3HMJGujqtYBpxH2DKXHa/269YLgDwPkPMxuJdXF2cnDgu/qwlmwEgsGj4AazPUYMfcGz4XOZfRlTs/xOcLq/WvXLej/WIc0Vw3loBxM9Xw6kteAopfGZaEJWWRtO5OlUfUSf/6H1fcxP5jpbsNZSJeZzR/dxhWCyDjtDUXlzS9hnIBpN26Etwago3njpHhmrL1XUDgr2odGNBan4Ao5L5IAPjZyHq9G8heSy+bCi1IUTHaZKSVQmIHBCl/qN+YTFigjzintLfZ2H/mKDfKmyxRbb51uG3I8/k7BTkhOmsTuzvcpU6MrGMwgtySHBj5usKnirWbNaKttJlJtnI+vHJDQVDX27GEvqw5dvX7Fpd/3oc/cUKAPRYdLH7zLxhMDp7Ivtn/hzMQLEu/oeeS0MpIMlq59VnwgdL4eERSPEtLzGgVGZRkIcDeyPSTLbU+MrWm+Og7ykAxGrYp2uOIh/mDioAthJkuBYTsWp9tkM+UGOcCniYf+6lDYa/a/FQmov+GLJtLUyqBXb7NSLyeZHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(86362001)(478600001)(8676002)(2906002)(26005)(6916009)(53546011)(6506007)(66946007)(9686003)(66556008)(66476007)(30864003)(8936002)(6512007)(7416002)(4001150100001)(6486002)(5660300002)(966005)(54906003)(316002)(6666004)(38100700002)(82960400001)(41300700001)(83380400001)(186003)(4326008)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?frfAFEIe9+loBGSCS4pxHss2ZVe7yeEeNkxc3D3wCvS6vxrg+m6Nnw5OaIZm?=
 =?us-ascii?Q?aGhWYk7wSirfYMKvv/MgcF3ZcdZCZH4lNxVjX2FLUDe3mxasl3tKp7sN9eVN?=
 =?us-ascii?Q?51R1Z9JqaQptzISxfFjpaUg1zTZxuwytxm6jGOOd/nqZsaW8cS6OG65XarW8?=
 =?us-ascii?Q?ZyxWAUYUTcEkU+yWoZugcfmaUDfkR+ceBhXC7eSPjOdz/ZYcoe6k2TTKgJti?=
 =?us-ascii?Q?7sTvCNKhWcpVrrPGDaVgrH4o+TGTkvPno/PhrSohPaSSn10JgOTvcpiKOJE9?=
 =?us-ascii?Q?lRbyUC4OuJw11/U6M5Ll1OSDIsWzhDNwACo8LNG9P9w6yX51YVvG5nQWdeuK?=
 =?us-ascii?Q?YeB32DLBCRzPFGUoJ9jOn8tH6gIUqybHDNTf1FSX2SJz1nOCnl6QGTqraQY1?=
 =?us-ascii?Q?9p44131HehPZhaTA8qx0So6mvOESVK6Hcxe+kgs8HrbebU9MRF9NFwFFa9m9?=
 =?us-ascii?Q?9mz6jchtU0pbBs3GhokUjLs/Glpczf9aK0IczGotQ1dBh4KuoYiPEXtdnTe4?=
 =?us-ascii?Q?hDJlbG100ocHu22gh4Y0KJ+HjZZD+nxspUKlawMTExLjrJ3ClB1hW8o4Qvnl?=
 =?us-ascii?Q?UlZAo3WLaj96riHQK9zMKANORg0SVezdvLGh0gcZndw5xsDwTADd4IA7v2xI?=
 =?us-ascii?Q?zr/K8kwObGOWhqtz0ub3tompgghJprf7AHkfD0MmDzAmocgsRiUyxhtghjL+?=
 =?us-ascii?Q?2sZy6Htm0BYkFSFofVjXgHzjdO6w8NWT05l4bPiAGWRRftMCUkqFJnWfoM8e?=
 =?us-ascii?Q?nODICpWDgNhRMY1Wlc2ZBedz7gp4FW7kEczn4cF6hkkec+8PpvaL7Z4HSKuG?=
 =?us-ascii?Q?EQD7OHhfpOcHzU6wR2SbdlH4C2WOj1+jJcFzkHoMu5mxMMs9xvhegkQV10qZ?=
 =?us-ascii?Q?XA0fciZLsWuM/hmpfC4L92Xn8xayuNq21MgfnsiKfTC7wRfWnTBhX+LeUpF4?=
 =?us-ascii?Q?nkPO8WY3jp6x8wY7c5zQINFXh4DeGBH+heH8cDEOQsolTnsYntGqaAHgJSee?=
 =?us-ascii?Q?Yik1HEQ9cgwAoGFY+a8ruCOb+spel8eJelg02V/6uL4x9ZYAu5KVNirbQnnu?=
 =?us-ascii?Q?LG6SLd7Hf/faKqg3zuVXJqN1fEbPee43BIiK8OopqYFuEQLq2kCywGlb1COY?=
 =?us-ascii?Q?VrfvcXh1VakMlOILnG79r1elkAiWUtLZNTGJvKrDpqbibIe0YIUo3lQQRQ5h?=
 =?us-ascii?Q?UD7BklRjg0EAHtAi+UfLEfvgBx4OlEbHYjxI8N1VfSZLAnIzFG/T1eG9oUxp?=
 =?us-ascii?Q?MSOI4aCB8ahDrCScc2QH044NXqYfHhioD13xXUK2Er8ezoK7SPCtewOkd0Rl?=
 =?us-ascii?Q?Z2iQegZzXEVC/3K0vx2JCBWd4hj+QOFitjtP3OtT/nci7bjaLx3+06EzuiL4?=
 =?us-ascii?Q?zHHWXieUar8JumIxQ4idcFng2U5XdMzmd9fqobGRdp2y7h3vESRGf7C+d9ag?=
 =?us-ascii?Q?baQ76rr7t/LmQ6AuRjLlc+embw/QYBwuNAibvjutuqlzgUWBWUP+mukBLyQm?=
 =?us-ascii?Q?r4ZBVkr43z340IYZtH4p+HDHZfDDUIDE0fMlyfsdSH6rTNSVBNxBu7lfaOlM?=
 =?us-ascii?Q?ul0cXkORxh2UQn2ooHB6L4RmX7NMmWsHkcths3pl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2739d629-48f5-4de2-b285-08dad287d8a8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 04:03:32.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MG4EdAmHOf+j/Gw/zt5155NHLM2VZ01vg2z11DlpOyTpWgaA0eDJyi8rFRvwrEZNSGsRyJ5t3mVlxidL+4rL/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-22 at 16:01:42 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> I've tested v2 series on an dual socket Zen3 system (2 x 64C/128T) and
> the results are largely positive.
>
Thank you Prateek, and sorry for late response. 
> tl;dr
> 
> o Hackbench results are mostly similar with tip.
> o schbench sees improvements to tail latency when the system is
>   loaded in NPS1 case but I do see one small regression for
>   128 workers in NPS4 mode.
> o tbench sees small gains in NPS2 and NPS4 mode
> o Stream and Spec-JBB results remain same as the tip.
> o ycsb-mongodb sees small gains in NPS2 and NPS4 mode.
> o unixbench results see small to moderate gains overall.
> 
> I'll leave the detailed results below:
> 
> Following are the results from running standard benchmarks on a
> dual socket Zen3 (2 x 64C/128T) machine configured in different
> NPS modes.
> 
> NPS Modes are used to logically divide single socket into
> multiple NUMA region.
> Following is the NUMA configuration for each NPS mode on the system:
> 
> NPS1: Each socket is a NUMA node.
>     Total 2 NUMA nodes in the dual socket machine.
> 
>     Node 0: 0-63,   128-191
>     Node 1: 64-127, 192-255
> 
> NPS2: Each socket is further logically divided into 2 NUMA regions.
>     Total 4 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-31,   128-159
>     Node 1: 32-63,  160-191
>     Node 2: 64-95,  192-223
>     Node 3: 96-127, 223-255
> 
> NPS4: Each socket is logically divided into 4 NUMA regions.
>     Total 8 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-15,    128-143
>     Node 1: 16-31,   144-159
>     Node 2: 32-47,   160-175
>     Node 3: 48-63,   176-191
>     Node 4: 64-79,   192-207
>     Node 5: 80-95,   208-223
>     Node 6: 96-111,  223-231
>     Node 7: 112-127, 232-255
> 
> Benchmark Results:
> 
> Kernel versions:
> - tip:          5.19.0 tip sched/core
> - sis_short: 	5.19.0 tip sched/core + this series
> 
> When we started testing, the tip was at:
> commit fdf756f71271 ("sched: Fix more TASK_state comparisons")
> 
> ~~~~~~~~~~~~~
> ~ hackbench ~
> ~~~~~~~~~~~~~
> 
> o NPS1
> 
> Test:			tip			sis_short
>  1-groups:	   4.06 (0.00 pct)	   4.02 (0.98 pct)
>  2-groups:	   4.76 (0.00 pct)	   4.71 (1.05 pct)
>  4-groups:	   5.22 (0.00 pct)	   5.07 (2.87 pct)
>  8-groups:	   5.35 (0.00 pct)	   5.31 (0.74 pct)
> 16-groups:	   7.21 (0.00 pct)	   7.22 (-0.13 pct)
> 
> o NPS2
> 
> Test:			tip			sis_short
>  1-groups:	   4.09 (0.00 pct)	   4.05 (0.97 pct)
>  2-groups:	   4.70 (0.00 pct)	   4.69 (0.21 pct)
>  4-groups:	   5.05 (0.00 pct)	   4.95 (1.98 pct)
>  8-groups:	   5.35 (0.00 pct)	   5.27 (1.49 pct)
> 16-groups:	   6.37 (0.00 pct)	   6.60 (-3.61 pct)
> 
> o NPS4
> 
> Test:			tip			sis_short
>  1-groups:	   4.07 (0.00 pct)	   4.13 (-1.47 pct)
>  2-groups:	   4.65 (0.00 pct)	   4.71 (-1.29 pct)
>  4-groups:	   5.13 (0.00 pct)	   5.05 (1.55 pct)
>  8-groups:	   5.47 (0.00 pct)	   5.44 (0.54 pct)
> 16-groups:	   6.82 (0.00 pct)	   6.72 (1.46 pct)
> 
> ~~~~~~~~~~~~
> ~ schbench ~
> ~~~~~~~~~~~~
> 
> o NPS1
> 
> #workers:	tip			sis_short
>   1:	  33.00 (0.00 pct)	  34.00 (-3.03 pct)
>   2:	  35.00 (0.00 pct)	  36.00 (-2.85 pct)
>   4:	  39.00 (0.00 pct)	  40.00 (-2.56 pct)
>   8:	  49.00 (0.00 pct)	  47.00 (4.08 pct)
>  16:	  63.00 (0.00 pct)	  64.00 (-1.58 pct)
>  32:	 109.00 (0.00 pct)	 106.00 (2.75 pct)
>  64:	 208.00 (0.00 pct)	 214.00 (-2.88 pct)
> 128:	 559.00 (0.00 pct)	 497.00 (11.09 pct)
> 256:	 45888.00 (0.00 pct)	 47424.00 (-3.34 pct)
> 512:	 80000.00 (0.00 pct)	 77952.00 (2.56 pct)
> 
> o NPS2
> 
> #workers:	tip			sis_short
>   1:	  30.00 (0.00 pct)	  31.00 (-3.33 pct)
>   2:	  37.00 (0.00 pct)	  36.00 (2.70 pct)
>   4:	  39.00 (0.00 pct)	  40.00 (-2.56 pct)
>   8:	  51.00 (0.00 pct)	  50.00 (1.96 pct)
>  16:	  67.00 (0.00 pct)	  67.00 (0.00 pct)
>  32:	 117.00 (0.00 pct)	 114.00 (2.56 pct)
>  64:	 216.00 (0.00 pct)	 214.00 (0.92 pct)
> 128:	 529.00 (0.00 pct)	 597.00 (-12.85 pct)    *
> 128:     388.00 (0.00 pct)       382.00 (1.54 pct)      [Verification Run]
> 256:	 47040.00 (0.00 pct)	 47424.00 (-0.81 pct)
> 512:	 84864.00 (0.00 pct)	 81792.00 (3.61 pct)
> 
> o NPS4
> 
> #workers:	tip			sis_short
>   1:	  23.00 (0.00 pct)	  33.00 (-43.47 pct)
>   2:	  28.00 (0.00 pct)	  27.00 (3.57 pct)
>   4:	  41.00 (0.00 pct)	  37.00 (9.75 pct)
>   8:	  60.00 (0.00 pct)	  56.00 (6.66 pct)
>  16:	  71.00 (0.00 pct)	  71.00 (0.00 pct)
>  32:	 117.00 (0.00 pct)	 114.00 (2.56 pct)
>  64:	 227.00 (0.00 pct)	 218.00 (3.96 pct)
> 128:	 545.00 (0.00 pct)	 747.00 (-37.06 pct)    *
> 128:	 383.00 (0.00 pct)	 412.00 (-7.85 pct)    [Verification Run]
> 256:	 45632.00 (0.00 pct)	 47296.00 (-3.64 pct)
> 512:	 81024.00 (0.00 pct)	 78720.00 (2.84 pct)
> 
> Note: For lower worker count, schbench can show run to
> run variation depending on external factors. Regression
> for lower worker count can be ignored. The results are
> included to spot any large blow up in the tail latency
> for larger worker count.
> 
> ~~~~~~~~~~
> ~ tbench ~
> ~~~~~~~~~~
> 
> o NPS1
> 
> Clients:	tip			sis_short
>     1	 578.37 (0.00 pct)	 568.72 (-1.66 pct)
>     2	 1062.09 (0.00 pct)	 1055.45 (-0.62 pct)
>     4	 1800.62 (0.00 pct)	 1833.37 (1.81 pct)
>     8	 3211.02 (0.00 pct)	 3124.95 (-2.68 pct)
>    16	 4848.92 (0.00 pct)	 4823.27 (-0.52 pct)
>    32	 9091.36 (0.00 pct)	 9301.80 (2.31 pct)
>    64	 15454.01 (0.00 pct)	 14639.52 (-5.27 pct)   *
>    64	 14890.79 (0.00 pct)	 14314.95 (-3.86 pct)   [Verification Run]
>   128	 3511.33 (0.00 pct)	 2740.46 (-21.95 pct)   *
>   128	 19750.19 (0.00 pct)	 20006.42 (1.29 pct)    [Verification Run]
>   256	 50019.32 (0.00 pct)	 50384.18 (0.72 pct)
>   512	 44317.68 (0.00 pct)	 44155.90 (-0.36 pct)
>  1024	 41200.85 (0.00 pct)	 41242.49 (0.10 pct)
> 
> o NPS2
> 
> Clients:	tip			sis_short
>     1	 576.05 (0.00 pct)	 578.08 (0.35 pct)
>     2	 1037.68 (0.00 pct)	 1098.68 (5.87 pct)
>     4	 1818.13 (0.00 pct)	 1838.79 (1.13 pct)
>     8	 3004.16 (0.00 pct)	 3071.73 (2.24 pct)
>    16	 4520.11 (0.00 pct)	 4820.67 (6.64 pct)
>    32	 8624.23 (0.00 pct)	 9264.14 (7.41 pct)
>    64	 14886.75 (0.00 pct)	 14976.91 (0.60 pct)
>   128	 20602.00 (0.00 pct)	 20247.46 (-1.72 pct)
>   256	 45566.83 (0.00 pct)	 48786.00 (7.06 pct)
>   512	 42717.49 (0.00 pct)	 44678.97 (4.59 pct)
>  1024	 40936.61 (0.00 pct)	 40866.32 (-0.17 pct)
> 
> o NPS4
> 
> Clients:	tip			sis_short
>     1	 576.36 (0.00 pct)	 588.43 (2.09 pct)
>     2	 1044.26 (0.00 pct)	 1074.47 (2.89 pct)
>     4	 1839.77 (0.00 pct)	 1852.10 (0.67 pct)
>     8	 3043.53 (0.00 pct)	 3235.32 (6.30 pct)
>    16	 5207.54 (0.00 pct)	 4804.41 (-7.74 pct)    *
>    16    4620.29 (0.00 pct)      4714.69 (2.04 pct)     [Verification Run]
>    32	 9263.86 (0.00 pct)	 8238.55 (-11.06 pct)   *
>    32	 9263.86 (0.00 pct)	 9443.77 (1.94 pct)     [Verification Run]
>    64	 14959.66 (0.00 pct)	 15321.44 (2.41 pct)
>   128	 20698.65 (0.00 pct)	 16806.27 (-18.80 pct)  *
>   128    20698.65 (0.00 pct)     20978.42 (1.35 pct)    [Verification Run]
>   256	 46666.21 (0.00 pct)	 49787.15 (6.68 pct)
>   512	 41532.80 (0.00 pct)	 44738.18 (7.71 pct)
>  1024	 39459.49 (0.00 pct)	 41473.96 (5.10 pct)
> 
> Note: On the tested kernel, with 128 clients, tbench can
> run into a bottleneck during C2 exit. More details can be
> found at:
> https://lore.kernel.org/lkml/20220921063638.2489-1-kprateek.nayak@amd.com/
> This issue has been fixed in v6.0 but was not part of the
> tip kernel when I started testing. This data point has
> been rerun with C2 disabled to get representative results.
This reminds me that, previously I tested with Cstates > C1 disabled, and
with turbo disabled, so as to mitigate possible deviation. May I know if
all C-states and turbo are enabled in your test besides tbench?
> 
> ~~~~~~~~~~
> ~ stream ~
> ~~~~~~~~~~
> 
> o NPS1
> 
> - 10 Runs:
> 
> Test:		tip			sis_short
>  Copy:	 328419.14 (0.00 pct)	 336740.00 (2.53 pct)
> Scale:	 206071.21 (0.00 pct)	 212682.17 (3.20 pct)
>   Add:	 235271.48 (0.00 pct)	 244104.35 (3.75 pct)
> Triad:	 253175.80 (0.00 pct)	 251776.26 (-0.55 pct)
> 
> - 100 Runs:
> 
> Test:		tip			sis_short
>  Copy:	 328209.61 (0.00 pct)	 340132.12 (3.63 pct)
> Scale:	 216310.13 (0.00 pct)	 218811.70 (1.15 pct)
>   Add:	 244417.83 (0.00 pct)	 246349.22 (0.79 pct)
> Triad:	 237508.83 (0.00 pct)	 260160.20 (9.53 pct)
> 
> o NPS2
> 
> - 10 Runs:
> 
> Test:		tip			sis_short
>  Copy:	 336503.88 (0.00 pct)	 319171.80 (-5.15 pct)
> Scale:	 218035.23 (0.00 pct)	 219061.13 (0.47 pct)
>   Add:	 257677.42 (0.00 pct)	 256776.22 (-0.34 pct)
> Triad:	 268872.37 (0.00 pct)	 263751.14 (-1.90 pct)
> 
> - 100 Runs:
> 
> Test:		tip			sis_short
>  Copy:	 332304.34 (0.00 pct)	 320547.46 (-3.53 pct)
> Scale:	 223421.60 (0.00 pct)	 220418.63 (-1.34 pct)
>   Add:	 252363.56 (0.00 pct)	 254553.30 (0.86 pct)
> Triad:	 266687.56 (0.00 pct)	 260009.00 (-2.50 pct)
> 
> o NPS4
> 
> - 10 Runs:
> 
> Test:		tip			sis_short
>  Copy:	 353515.62 (0.00 pct)	 338973.78 (-4.11 pct)
> Scale:	 228854.37 (0.00 pct)	 230319.08 (0.64 pct)
>   Add:	 254942.12 (0.00 pct)	 247794.21 (-2.80 pct)
> Triad:	 270521.87 (0.00 pct)	 261432.32 (-3.36 pct)
> 
> - 100 Runs:
> 
> Test:		tip			sis_short
>  Copy:	 374520.81 (0.00 pct)	 363272.21 (-3.00 pct)
> Scale:	 246280.23 (0.00 pct)	 241457.83 (-1.95 pct)
>   Add:	 262772.72 (0.00 pct)	 261924.44 (-0.32 pct)
> Triad:	 283740.92 (0.00 pct)	 274791.15 (-3.15 pct)
> 
> ~~~~~~~~~~~~~~~~~
> ~ Spec-JBB NPS1 ~
> ~~~~~~~~~~~~~~~~~
> 
> --------------------------------------------------
> |   Throughput  |     tip     |     sis_short    |
> --------------------------------------------------
> |    Max-jOPS   |     100%    |      98.84%      |
> | Critical-jOPS |     100%    |      100.31%     |
> --------------------------------------------------
> 
> ~~~~~~~~~~~~~~~~
> ~ ycsb-mongodb ~
> ~~~~~~~~~~~~~~~~
> 
> o NPS1
> 
> tip:                    131696.33 (var: 2.03%)
> sis_short:              130844.67 (var: 2.55%)  (-0.64%)
> 
> o NPS2:
> 
> tip:                    129895.33 (var: 2.34%)
> sis_short:              133104.33 (var: 1.65%)  (+2.647%)
> 
> o NPS4:
> 
> tip:                    131165.00 (var: 1.06%)
> sis_short:              138180.67 (var: 0.83%)  (+5.34%)
> 
> ~~~~~~~~~~~~~
> ~ unixbench ~
> ~~~~~~~~~~~~~
> 
> -> unixbench-dhry2reg
> 
> o NPS1
> 
> kernel:                                        tip                          sis_short
> Min       unixbench-dhry2reg-1            48876615.50 (   0.00%)          48489507.40 (  -0.79%)
> Min       unixbench-dhry2reg-512        6260344658.90 (   0.00%)        6253084311.60 (  -0.12%)
> Hmean     unixbench-dhry2reg-1            49299721.81 (   0.00%)          49014780.04 (  -0.58%)
> Hmean     unixbench-dhry2reg-512        6267459427.19 (   0.00%)        6261978461.64 (  -0.09%)
> CoeffVar  unixbench-dhry2reg-1                   0.90 (   0.00%)                 0.98 (  -9.38%)
> CoeffVar  unixbench-dhry2reg-512                 0.10 (   0.00%)                 0.17 ( -61.99%)
> Max       unixbench-dhry2reg-1            49758806.60 (   0.00%)          49428847.90 (  -0.66%)
> Max       unixbench-dhry2reg-512        6273024869.70 (   0.00%)        6273555460.00 (   0.01%)
> 
> o NPS2
> 
> kernel:                                        tip                          sis_short
> Min       unixbench-dhry2reg-1            48828251.70 (   0.00%)          48591509.40 (  -0.48%)
> Min       unixbench-dhry2reg-512        6244987739.10 (   0.00%)        6254966248.00 (   0.16%)
> Hmean     unixbench-dhry2reg-1            48869882.65 (   0.00%)          49230596.10 (   0.74%)
> Hmean     unixbench-dhry2reg-512        6261073948.84 (   0.00%)        6260685008.60 (  -0.01%)
> CoeffVar  unixbench-dhry2reg-1                   0.08 (   0.00%)                 1.20 (-1347.66%)
> CoeffVar  unixbench-dhry2reg-512                 0.23 (   0.00%)                 0.09 (  59.12%)
> Max       unixbench-dhry2reg-1            48909163.40 (   0.00%)          49752650.10 (   1.72%)
> Max       unixbench-dhry2reg-512        6271411453.90 (   0.00%)        6266517108.00 (  -0.08%)
> 
> o NPS4
> 
> kernel:                                        tip                          sis_short
> Min       unixbench-dhry2reg-1            48523981.30 (   0.00%)          48728886.20 (   0.42%)
> Min       unixbench-dhry2reg-512        6253738837.10 (   0.00%)        6260870171.70 (   0.11%)
> Hmean     unixbench-dhry2reg-1            48781044.09 (   0.00%)          48969711.29 (   0.39%)
> Hmean     unixbench-dhry2reg-512        6264428474.90 (   0.00%)        6277327761.28 (   0.21%)
> CoeffVar  unixbench-dhry2reg-1                   0.46 (   0.00%)                 0.43 (   6.91%)
> CoeffVar  unixbench-dhry2reg-512                 0.17 (   0.00%)                 0.29 ( -70.82%)
> Max       unixbench-dhry2reg-1            48925665.20 (   0.00%)          49091708.50 (   0.34%)
> Max       unixbench-dhry2reg-512        6274958506.80 (   0.00%)        6296828879.20 (   0.35%)
> 
> -> unixbench-syscall
> 
> o NPS1
> 
> kernel:                             tip                  sis_short
> Min       unixbench-syscall-1    2975654.80 (   0.00%)  2971008.50 (   0.16%)
> Min       unixbench-syscall-512  7840226.50 (   0.00%)  6586485.10 (  15.99%)
> Amean     unixbench-syscall-1    2976326.47 (   0.00%)  2971920.50 *   0.15%*
> Amean     unixbench-syscall-512  7850493.90 (   0.00%)  6597210.63 *  15.96%*
> CoeffVar  unixbench-syscall-1          0.03 (   0.00%)        0.03 ( -14.26%)
> CoeffVar  unixbench-syscall-512        0.13 (   0.00%)        0.27 (-103.14%)
> Max       unixbench-syscall-1    2977279.70 (   0.00%)  2972935.80 (   0.15%)
> Max       unixbench-syscall-512  7860838.90 (   0.00%)  6617515.40 (  15.82%)
> 
> o NPS2
> 
> kernel:                             tip                  sis_short
> Min       unixbench-syscall-1    2969863.60 (   0.00%)  2974771.70 (  -0.17%)
> Min       unixbench-syscall-512  8053157.60 (   0.00%)  7411223.90 (   7.97%)
> Amean     unixbench-syscall-1    2970462.30 (   0.00%)  2975278.63 *  -0.16%*
> Amean     unixbench-syscall-512  8061454.50 (   0.00%)  7437679.30 *   7.74%*
> CoeffVar  unixbench-syscall-1          0.02 (   0.00%)        0.02 ( -17.72%)
> CoeffVar  unixbench-syscall-512        0.12 (   0.00%)        0.34 (-179.38%)
> Max       unixbench-syscall-1    2970859.30 (   0.00%)  2975972.90 (  -0.17%)
> Max       unixbench-syscall-512  8072312.30 (   0.00%)  7461732.50 (   7.56%)
> 
> o NPS4
> 
> kernel:                             tip                  sis_short
> Min       unixbench-syscall-1    2971799.80 (   0.00%)  2974601.20 (  -0.09%)
> Min       unixbench-syscall-512  7824196.90 (   0.00%)  8242480.10 (  -5.35%)
> Amean     unixbench-syscall-1    2973045.43 (   0.00%)  2974739.93 *  -0.06%*
> Amean     unixbench-syscall-512  7826302.17 (   0.00%)  8261295.03 *  -5.56%*
> CoeffVar  unixbench-syscall-1          0.04 (   0.00%)        0.00 (  86.39%)
> CoeffVar  unixbench-syscall-512        0.03 (   0.00%)        0.37 (-1376.49%)
> Max       unixbench-syscall-1    2973786.50 (   0.00%)  2974895.30 (  -0.04%)
> Max       unixbench-syscall-512  7828115.90 (   0.00%)  8296830.40 (  -5.99%)
> 
> 
> -> unixbench-pipe
> 
> o NPS1
> 
> kernel:                               tip                  sis_short
> Min       unixbench-pipe-1        2894765.30 (   0.00%)    2904821.00 (   0.35%)
> Min       unixbench-pipe-512    329818573.50 (   0.00%)  329565756.00 (  -0.08%)
> Hmean     unixbench-pipe-1        2898803.38 (   0.00%)    2911189.71 *   0.43%*
> Hmean     unixbench-pipe-512    330226401.69 (   0.00%)  330389884.94 (   0.05%)
> CoeffVar  unixbench-pipe-1              0.14 (   0.00%)          0.22 ( -62.25%)
> CoeffVar  unixbench-pipe-512            0.11 (   0.00%)          0.24 (-126.10%)
> Max       unixbench-pipe-1        2902691.20 (   0.00%)    2917740.00 (   0.52%)
> Max       unixbench-pipe-512    330440132.10 (   0.00%)  331162497.90 (   0.22%)
> 
> o NPS2
> 
> kernel:                               tip                   sis_short
> Min       unixbench-pipe-1        2895327.90 (   0.00%)    2905421.90 (   0.35%)
> Min       unixbench-pipe-512    328350065.60 (   0.00%)  330137916.90 (   0.54%)
> Hmean     unixbench-pipe-1        2899129.86 (   0.00%)    2910562.69 *   0.39%*
> Hmean     unixbench-pipe-512    329436096.80 (   0.00%)  330509036.17 (   0.33%)
> CoeffVar  unixbench-pipe-1              0.12 (   0.00%)          0.20 ( -70.84%)
> CoeffVar  unixbench-pipe-512            0.30 (   0.00%)          0.10 (  65.00%)
> Max       unixbench-pipe-1        2901619.40 (   0.00%)    2916758.50 (   0.52%)
> Max       unixbench-pipe-512    330239044.10 (   0.00%)  330814020.50 (   0.17%)
> 
> o NPS4
> 
> kernel:                               tip                   sis_short
> Min       unixbench-pipe-1        2901525.60 (   0.00%)    2909864.00 (   0.29%)
> Min       unixbench-pipe-512    330265873.90 (   0.00%)  330543034.40 (   0.08%)
> Hmean     unixbench-pipe-1        2906184.70 (   0.00%)    2912725.52 *   0.23%*
> Hmean     unixbench-pipe-512    330854683.27 (   0.00%)  331540275.79 (   0.21%)
> CoeffVar  unixbench-pipe-1              0.14 (   0.00%)          0.09 (  39.44%)
> CoeffVar  unixbench-pipe-512            0.16 (   0.00%)          0.27 ( -73.84%)
> Max       unixbench-pipe-1        2909154.50 (   0.00%)    2914249.80 (   0.18%)
> Max       unixbench-pipe-512    331245477.30 (   0.00%)  332305755.00 (   0.32%)
> 
> -> unixbench-spawn
> 
> o NPS1
> 
> kernel:                             tip                  sis_short
> Min       unixbench-spawn-1       6536.50 (   0.00%)     6458.00 (  -1.20%)
> Min       unixbench-spawn-512    72571.40 (   0.00%)    91525.90 (  26.12%)
> Hmean     unixbench-spawn-1       6811.16 (   0.00%)     6510.74 (  -4.41%)
> Hmean     unixbench-spawn-512    72801.77 (   0.00%)    91829.95 *  26.14%*
> CoeffVar  unixbench-spawn-1          3.69 (   0.00%)        1.00 (  72.93%)
> CoeffVar  unixbench-spawn-512        0.27 (   0.00%)        0.41 ( -50.84%)
> Max       unixbench-spawn-1       7021.00 (   0.00%)     6583.60 (  -6.23%)
> Max       unixbench-spawn-512    72927.00 (   0.00%)    92257.50 (  26.51%)
> 
> o NPS2
> 
> kernel:                             tip                  sis_short
> Min       unixbench-spawn-1       7042.20 (   0.00%)     7411.00 (   5.24%)
> Min       unixbench-spawn-512    85571.60 (   0.00%)    89549.50 (   4.65%)
> Hmean     unixbench-spawn-1       7199.01 (   0.00%)     7553.53 *   4.92%*
> Hmean     unixbench-spawn-512    85717.77 (   0.00%)    89751.68 *   4.71%*
> CoeffVar  unixbench-spawn-1          3.50 (   0.00%)        1.68 (  51.98%)
> CoeffVar  unixbench-spawn-512        0.20 (   0.00%)        0.28 ( -36.60%)
> Max       unixbench-spawn-1       7495.00 (   0.00%)     7650.40 (   2.07%)
> Max       unixbench-spawn-512    85909.20 (   0.00%)    90028.30 (   4.79%)
> 
> o NPS4
> 
> kernel:                             tip                  sis_short
> Min       unixbench-spawn-1       7521.90 (   0.00%)     8404.10 (  11.73%)
> Min       unixbench-spawn-512    84245.70 (   0.00%)    91260.20 (   8.33%)
> Hmean     unixbench-spawn-1       7659.12 (   0.00%)     8526.01 *  11.32%*
> Hmean     unixbench-spawn-512    84908.77 (   0.00%)    91365.07 *   7.60%*
> CoeffVar  unixbench-spawn-1          1.92 (   0.00%)        2.06 (  -7.21%)
> CoeffVar  unixbench-spawn-512        0.76 (   0.00%)        0.10 (  86.60%)
> Max       unixbench-spawn-1       7815.40 (   0.00%)     8729.60 (  11.70%)
> Max       unixbench-spawn-512    85532.90 (   0.00%)    91437.30 (   6.90%)
> 
> -> unixbench-execl
> 
> o NPS1
> 
> kernel:                             tip                  sis_short
> Min       unixbench-execl-1       5421.50 (   0.00%)     5466.40 (   0.83%)
> Min       unixbench-execl-512    11213.50 (   0.00%)    11720.30 (   4.52%)
> Hmean     unixbench-execl-1       5443.75 (   0.00%)     5468.53 (   0.46%)
> Hmean     unixbench-execl-512    11311.94 (   0.00%)    11809.97 *   4.40%*
> CoeffVar  unixbench-execl-1          0.38 (   0.00%)        0.04 (  89.57%)
> CoeffVar  unixbench-execl-512        1.03 (   0.00%)        0.74 (  27.60%)
> Max       unixbench-execl-1       5461.90 (   0.00%)     5470.70 (   0.16%)
> Max       unixbench-execl-512    11440.40 (   0.00%)    11895.60 (   3.98%)
> 
> o NPS2
> 
> kernel:                             tip                  sis_short
> Min       unixbench-execl-1       5089.10 (   0.00%)     5119.50 (   0.60%)
> Min       unixbench-execl-512    11772.70 (   0.00%)    11591.40 (  -1.54%)
> Hmean     unixbench-execl-1       5321.65 (   0.00%)     5251.49 (  -1.32%)
> Hmean     unixbench-execl-512    12201.73 (   0.00%)    11665.67 (  -4.39%)
> CoeffVar  unixbench-execl-1          3.87 (   0.00%)        2.33 (  39.91%)
> CoeffVar  unixbench-execl-512        6.23 (   0.00%)        1.04 (  83.38%)
> Max       unixbench-execl-1       5453.90 (   0.00%)     5359.00 (  -1.74%)
> Max       unixbench-execl-512    13111.60 (   0.00%)    11805.80 (  -9.96%)
> 
> o NPS4
> 
> kernel:                             tip                  sis_short
> Min       unixbench-execl-1       5099.40 (   0.00%)     5352.70 (   4.97%)
> Min       unixbench-execl-512    11692.80 (   0.00%)    13368.20 (  14.33%)
> Hmean     unixbench-execl-1       5136.86 (   0.00%)     5404.31 *   5.21%*
> Hmean     unixbench-execl-512    12053.71 (   0.00%)    14018.53 *  16.30%*
> CoeffVar  unixbench-execl-1          1.05 (   0.00%)        0.84 (  20.12%)
> CoeffVar  unixbench-execl-512        3.85 (   0.00%)        5.29 ( -37.45%)
> Max       unixbench-execl-1       5198.70 (   0.00%)     5434.90 (   4.54%)
> Max       unixbench-execl-512    12585.70 (   0.00%)    14839.80 (  17.91%)
> 
> 
> Except for schbench with 128 workers in NPS4 mode, I do not
> see any large regressions for the above workloads and I do
> see small to moderate gains overall for most workload, even
> the larger ones. I'll try to get data for more workload but
> overall the idea seems promising. I'll also get some numbers
> with the changes Peter suggested on Patch 1.
I spent sometime to dig into the issue which motivates me to propose this
solution. And it was found that this issue could not be easily solved
directly because there seems to be an inevitable race condition window, with the
increasing of CPU number, this race condition is exposed easlier. So
current patch is an indirect solution to avoid that, I'll send the detail
in v3. 
> 
> If there is any specific workload you would like me to run
> on the test machine, please do let me know.
Thanks for always helping us to test the patch, I'll send v3 once I get the
result and we can discuss on that then.

thanks,
Chenyu
