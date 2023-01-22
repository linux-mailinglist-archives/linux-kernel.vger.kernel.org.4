Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B627677038
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 16:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjAVPiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 10:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVPiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 10:38:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7012D17168
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 07:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674401894; x=1705937894;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tLh07w4nolyKnPDzUaicKM68N5tcowwgy8/52yMTTH0=;
  b=e6uzXkDXhleCVBuprONA56UOvs00oeTGcSM5grXy+3cBAICHYHFxAfpE
   qNdeWMuZpDXBNLTwDeJSmrFlVNzDp32XfFPZeZYukS0z/PHcnYJk229+5
   dzyRDaJMvr5Uzh14sJwsWgJQmaoEl551T9x+VQElkV59k6wAen2f5bcfR
   b3tCrBwm6LDeCrePxLqC50x1g0G/tsKXbQ3zcnfhSwfK2/lTClQQB2Fhd
   x0VIn8cEA0XT1xiGLbhL/Ioz5smfpjJBfnQaCi+ZCn9nqPDkbRKD+eWx0
   OuUhI+VIpPUn/u4Zyhx9Csj6z6Ht+qPUNYCNigmYq7xw4CcuryzRubGxC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="325939452"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="325939452"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 07:38:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="906701195"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="906701195"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jan 2023 07:38:13 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 22 Jan 2023 07:38:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 22 Jan 2023 07:38:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 22 Jan 2023 07:38:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 22 Jan 2023 07:38:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahOqywcQ98qXClOuP5FoV9nVJxV3I0fZPkYoGOs3PVgzn69bb3MFhNKsN+EA9egXpAF5mpQrkPZhBtTV+vgF27WvVALgjwkDTlz6euXpQxSQCgWxHu7hnDhkDu7xW/ew7B3E3GlIldd6QDkVS2nVMpYJuJhlKC1kYH7N37q6y7rY+7Lot7oN2lhys76tsS3atbtncT8tG47mdLCic9CpwIXLS2iIYqfSXvkj4GIhJrqYfQpQs95fT7WoZUVyY1JlZdoqAnLRNcNiv9E/RratfCQs1jAGwahcm0vpZZrNCMiJuj3y0vLYl5j4xfQ2/1ETCiT+C6yNrs8SGxBlfSFX0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JT6ToGsI95p5Z1jhFcfzIeEgYtubJPodux4QHyRtA4=;
 b=SwRLLw65ZffJYmmHWri0cWyJHlgXFtIQidPw7AOq+D5fM3OyRpH9tajLrgYfCxDXpPFgxY6D3teZ9H/ZmvXTWOo4dZRj850IJE8dUuqQNy5B/mD/SEsSHK/N16V6vJg5MYXR41WHkMvwuIBwsjyj9ig86QPNplEuxesJQPx42LJtta9LfYL7lO9jJTjr6jkEZbqm7NEJlgs3vaq7Ay6MhaBgzM+t6O9IVbfZlNN4tpPq6OYLFq4sdCJv4HZPTsY2Y7438rcBEA1wPJWR+OP4LqUh74i5uFI9o+cvMe09BpKyVvdddmTr2ThI4D0W8MNqe0UrryU3vCgF4vtutaNMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MW4PR11MB6839.namprd11.prod.outlook.com (2603:10b6:303:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sun, 22 Jan
 2023 15:38:10 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%6]) with mapi id 15.20.6002.025; Sun, 22 Jan 2023
 15:38:10 +0000
Date:   Sun, 22 Jan 2023 23:37:43 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        "Barry Song" <21cnbao@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 0/2] sched/fair: Choose the CPU where short task
 is running during wake up
Message-ID: <Y81YRyRpg6xsyJK6@chenyu5-mobl1>
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <5910589f-fe3e-5999-5821-7b2b8021e74b@huawei.com>
 <Y8lrnvLzGGJmlPor@chenyu5-mobl1>
 <d3d04f60-e3d7-9abb-4cfa-57790b359dd9@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d3d04f60-e3d7-9abb-4cfa-57790b359dd9@huawei.com>
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MW4PR11MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: adaccdc7-9de1-407d-824a-08dafc8eaa2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bk4aneq60Y3secUZEPZ71Ph93AMtF4H9bF2UmhcQBckMm3JwJWx1772nxZhqPmCRlOvIk/B52hGQgearRMCx/eBt1muDF0oRyUKAXVmc2VPVnleMGSihXPGzrJy1iASduzwP4DLAZcZ5/d15YUSIW3z0xSQc2WMRciRPxgpN2JO0G+MLBm21/P+kTD/5M9kTOiqOKQMbOVL+8EsMdw85QdC/OzP+MCKrhdYkGKSbAWaubB5+Yrg3WMNJv9SyicKe0m/pwe7t1gQrvpHxxDgaVsxkPayJUcSjPjcQbb7aNrJWKGPqIOOhRT+GK3g5vNytUVCmZa/pmz5UBLsT/jy3lUhYFnV9fRgEJR5iXnEv1RSP9n8hY9lDWo4Ei22CqvwnB8qPbD7C+D33fOLOS+4syP2yvzbUSo8z+DOlcQ4VE/RBsH8xrnrsQM/ovhELXPT7GFBGALagUoJX0fKuEC5JQx3ItfS78sGRj8xeVfkPPsj4rCGrq9JAPYeutLee4V4+CBuzXMP5L5DqYw/Lv73UVrZkejuKJtsZkkuos5W4ODRBTbgd1V7fePgtJFS8+b6twGkqoEi+R4Y2qTh1DeO46NSaqZc8bg58nwY4rBBrWuHFHToI+CIcaPivvazI1VJMz3UkMrt1LWikeF6joCfFHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(316002)(6506007)(33716001)(6666004)(38100700002)(54906003)(41300700001)(82960400001)(83380400001)(9686003)(6512007)(2906002)(26005)(186003)(53546011)(66946007)(66556008)(4326008)(8676002)(7416002)(86362001)(5660300002)(8936002)(66476007)(6916009)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jy1WaWkveLj3zK8KGw54UIf6BvZ/NMVdVOSN7Kd5YI7O5U4lKL3HgpSDNAqI?=
 =?us-ascii?Q?TBOPw5OP0jQNXYORipvdhXqRilT2qXm+qWxxP4EMpmCsDG5bz+88XcQ38gBX?=
 =?us-ascii?Q?qzz68qQDvZDt6nuj4YXObymqUxcgTS1IfY9aI891lPEiC5q4/xNzofBuUuir?=
 =?us-ascii?Q?NEQeAjLzMRub8aJqFGLA2LhJREc4uRDFL+isEresGE8JR5SWojF2uoUxi0ey?=
 =?us-ascii?Q?f2WrneUWQoywmHl86tDxSLsZ17jjLpok4UHPQm2/uzx1wM+gFdqGMRiby3sU?=
 =?us-ascii?Q?hrOe+xEd1CujYLCHXxVNQWGXTp7t4rplkhlZFhbiZIRRBo8gODIKLo73Tg6p?=
 =?us-ascii?Q?PXgrkEkxctrrhzRgJ9VHYZhBHrcNzdKuPc8uLTMKxsrpxTDczLI63SByWeUI?=
 =?us-ascii?Q?3SB/AP0cY45SXlQ87IIiWyP6lZH/N2i0e4gLDH+slwucIRgu5/tZi6B/sQHN?=
 =?us-ascii?Q?dcZlnN73V/w+Hn/h6utL35JhdFQLQk2Eb7M51/tmvB6uZ2fm03LlPnuIGUMJ?=
 =?us-ascii?Q?AgEbb5D+CrVoml0GVL0w0bmmCGe1O/NyjvauOwzNjY4aYxUEr0tCM5Yt0Pix?=
 =?us-ascii?Q?7oxgtEpNafwHO0/aApfRkSsYfvZQm/1WSyMej5PwsHmTE/zDmTu9ujljgJWb?=
 =?us-ascii?Q?STdt9GF+sHwtbeLCykuFQOGARmbcgZZsFLK0gtLCqST5EBifz/S49ASu9yfb?=
 =?us-ascii?Q?QFlHrD7ZNeCcmi7V7JBDJet8vdaYW6ESd6MnPM+m2mt4bFVAbZINbHrcILJp?=
 =?us-ascii?Q?Mb9W554n7r9BaaQeFOGjNidHEvOE327fGOHUkGphEOcjSFUX8mKJ6r4Gnloe?=
 =?us-ascii?Q?42nPnVBZUdpiJjD0gjy912SsAz71/Vx6C9OaRjiS3LpgiLo+6GpeVLMJPXTy?=
 =?us-ascii?Q?wgGElYFgpHSJC85E9bSPAnFpg35u32JS+N5FX/IEYAfDUE9WbzzLjHaGwuCv?=
 =?us-ascii?Q?/GEMt36E1i4+f3ElIWeanOCWSmq/9cab2AhO/J0mFSJhXXQ369eWW85tn4Vw?=
 =?us-ascii?Q?shYxMIYcYe6jNc8tYsCOvt5zyEI32xiMxt5+D3+XLpLx1S1YZqLB7b+asFu0?=
 =?us-ascii?Q?xxlPz2Nr7oVFOCReLHx6bI5TBgr4u9sxshOA4Uuj1ymAGWrC1qwg6GZsVFnV?=
 =?us-ascii?Q?SIcAWE7XOfs7dZuS3MPhKUe933HntlSaQBIJh0C9x88X4xT8jK4s+wIKYaTo?=
 =?us-ascii?Q?5ukxgrnJgEgtnibuVlq3QJ3xoTAmnnTm4mnQW/WkR9UAJ7JOF2mx+H+wqFec?=
 =?us-ascii?Q?tuzzkRglz5DJl5dtv4IV2IRxGnZJB+GDYEXbvOM5cRzvDcqw1ef8ySA4lIKs?=
 =?us-ascii?Q?G67kZinLLE1o4mwKYTP1JkIH6q3uPRWZcPrQ7OMKT5DHBWUjrMDiPczWYGfL?=
 =?us-ascii?Q?pEF6B54tLcpuRFPNndrInQmcMsGXDTEVjyCtfgwJwjQ3BoiBgUU3ZQ02mdG0?=
 =?us-ascii?Q?6Rc+0/wj7lKzOfbCFp4gWN3bgVLy+OctSMkd9jTQqDKEOG6/os74hyi1XY9B?=
 =?us-ascii?Q?DSZg2/SGwDAJ1N1aF4TgSmEWTZaO80BiMaLQJCKd26Y11/vW1GbqUhYqqbiZ?=
 =?us-ascii?Q?IZK6KxYaHuhyfs0aVjTB6Z0X5vSLZtyu+N5gjK9r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adaccdc7-9de1-407d-824a-08dafc8eaa2a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 15:38:09.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fMnzoaXuZ99ZKKethXi1zyAoVTXj6LsylkHkl5tv+eqmUoEyq9eZakq2R0wc+UcRiT/CySA0Oh1E8koxXP3+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6839
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

On 2023-01-20 at 17:09:28 +0800, Yicong Yang wrote:
> On 2023/1/20 0:11, Chen Yu wrote:
> > Hi Yicong,
> > On 2023-01-17 at 10:53:25 +0800, Yicong Yang wrote:
> >> Hi Chen Yu,
> >>
> >> On 2022/12/16 14:08, Chen Yu wrote:
> >>> The main purpose of this change is to avoid too many cross CPU
> >>> wake up when it is unnecessary. The frequent cross CPU wake up
> >>> brings significant damage to some workloads, especially on high
> >>> core count systems.
> >>>
> >>> This patch set inhibits the cross CPU wake-up by placing the wakee
> >>> on waking CPU or previous CPU, if both the waker and wakee are
> >>> short-duration tasks.
> >>>
> >>> The first patch is to introduce the definition of a short-duration
> >>> task. The second patch leverages the first patch to choose a local
> >>> or previous CPU for wakee.
> >>>
> >>
> >> Tested with tbench and netperf locally and MySQL remotely. Unluckily
> >> cannot reproduce the improvement and see some regression.
> > Thank you for the test.
> >> Detailed information below. The tests are done based on 6.2-rc1 on a 2x64 CPUs
> >> Kunpeng 920 server with 4 nodes and no SMT, CONFIG_SCHED_CLUSTER
> >> enabled.
> >>
> >> For tbench and netperf tested on single node and two nodes on one socket.
> >>
> > Does this platform have 2 sockets, each socket has 2 Numa nodes, each node
> > is attached to 32 CPUs, and the benchmarks are bound to the first sockets?
> > And may I know how many CPUs there are in one LLC? Is it also 32?
> 
> you're right, exactly. There're 32 CPUs sharing one LLC.
> 
> >> Further looked into 64 threads since it regress most and mainly looked on the
> >> server(mysqld) side. In this case most loads will be on node 0 and partly
> >> on node 1. With SIS_SHORT the utilization on node 0 keeps almost the same
> >> but utilization on node 1 remains nearly half comparing to baseline. That
> >> may partly answers why the performance decreases.
> >>
> > OK, I see. So it seems that the Numa sched domain load balance does not spread
> > tasks fast enough while SIS_SHORT is waking task on the same node frequently.
> > But I thought select_idle_sibling() would wake up the tasks
> > on the same node(LLC) anyway, why SIS_SHORT inhibits the load balance more?
> 
> Wakeup will happen much more frequently than load balance in this case and I don't
> think load balance can handle it in time. In the fast path of wakeup we care little
> about the load. SIS_SHORT may aggravate it since we're likely to put 2 short tasks
> on one single CPU.
>
I see. Suppose cpu0 ~ cpu31 are on node0, cpu32~cpu64 are on node1. With SIS_SHORT
enabled, wakees could be stacked on cpu0. With SIS_SHORT disabled, wakees could be
woken up on cpu0~cpu31. I undertsnad that SIS_SHORT inhits searching for idle CPUs
in node0, but why SIS_SHORT inhibits tasks migrating to node1?
> >> mpstat 60s, non-idle%
> >> 	vanilla	sis_short	
> >> node 0	94.25	91.67	-2.73%
> >> node 1	46.41	30.03	-35.29%
> >>
> >> Previously there's argument that sync wakeup from interrupts maybe incorrectly
> > I see. Do you mean, wakeup from interrupt might cause tasks stacking on the same
> > CPU, because the interrupt is delivered to the same CPU? I thought userspace
> > irq load balance would spread the interrupt? Or do you mean others?
> 
> Nop. I'm using HiSilicon HNS3 network card which has 32 queues and 33 interrupts
> spread evenly on 32 CPUs, not on one single CPU. I considering a case that the p1
> on cpu0 and p2 on cpu32, interrupt happens on cpu0 and tries to wakeup p1, since
> p1 and p2 are both short tasks and then p2 will likely to wake and wait on cpu0.
> p1 is not the actual waker and has not finished yet and this will increase the wait
> time and also load on cpu0. Previously we may wake on the LLC of cpu0 and try
> to find an idle CPU, with SIS_SHORT we'll just wake on cpu0.
> 
> Does it make sense to allow the SIS_SHORT wakeup only from the task context? I'll
> have a try on this.
> 
This sounds reasonable to me. I think we can further enhance it.
And before you sending out the proposal, could you help test the following
experimental change, to see if it makes tbench netperf and MySQL better?

Hi Prateek, could you also help check if below change would make the Spec regression
go away?

thanks,
Chenyu

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fc8a636eca5e..6e1ab5e2686c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4974,7 +4974,7 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
 static inline int is_short_task(struct task_struct *p)
 {
 	return sched_feat(SIS_SHORT) && p->se.dur_avg &&
-		((p->se.dur_avg * 8) <= sysctl_sched_min_granularity);
+		((p->se.dur_avg * 1024) <= (__this_cpu_read(sd_llc_size) * sysctl_sched_min_granularity));
 }
 
 /*
-- 
2.25.1

