Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55342730E66
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbjFOEuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242415AbjFOEtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:49:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFABD1FD4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686804591; x=1718340591;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uRpNTSWiew2hsdeLSihQrh1cl7HO0WBakm87kw4O9e8=;
  b=VDzEJVaXR2qPBfRLAO7c67H28u+e3IrVibWYEpZedSwUKPmZg/73O4Q7
   JjuR0ZLUcxD5U12CRu8JhxQJPbIvpVqOph4pAA4306m/cA9mg0O3JY1En
   /LKv2JdeoYOErrrPpRny3pPxbKxpBWzoPEW/u166hWAwvVhfhRhikNo5d
   lOTmUKJzJp3vbCisoM1Y2Q2klVu+eR1WLNbbvcMXwFVeS0nD33xmJGfk9
   o5i31BakJic7X9bW9dkcTJy0jyEXpRzIiQO7G7tdRQcG9Gxer6nEmMvbv
   Jz42J/8y7CatyBl07XyfDGV1pfBnJlKACNynqvv5INjTM+i/4fV1bq5RM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="422418107"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="gz'50?scan'50,208,50";a="422418107"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 21:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="825095852"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="gz'50?scan'50,208,50";a="825095852"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2023 21:49:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 21:49:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 21:49:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 21:49:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 21:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyIoovs9JRzFs6g4lF9o/7yxQp+pr8GaZ5RryTgg76cnRC16OdRU/y1LG9TvYoAqeeq6rO6wxW4rbw8ridfwNFYwoLNSFcKTntwCCX5FuRqY7NnejbRmEuik9MvsM/n9iQ+uL84kn1CnORVAOIjU45eT71XoN3s2cYfS672X98DV5wYrEcCzCFYH6ZYCvoJSC1AF0Da6ney+1k+ZXu5nrxemc/U8jbSVYuAAWCsqWvpTRnlhddCYLMPpGUNnhzGbeGNLkULU2sJ/pXttfxsg0+n9/gOXgG1iL9/gSaEGK204raIVHbCsWE0VUX7ogfky7+GqjKcHTqNrsIqTCFHfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ5yMgy6DXHv4gQGoJp6TeFoWBg+Orq5LlFOSiCcHjk=;
 b=VnWG++rbJhKSxw7LSLTPoxW0BE/x0AND77tVT8S3pTJwR54wKL2lIibQTAeIzFYE2jjXgHoyw0AcssT2B3J55fL4BIBgWwP6b1pkq6KhsaTPqxaMiK73dNJwivb+SW7K4tj5iZMI240xpaJwMzbAexgBswAiTxsbUUHsdCKmTye7JXg4WsLbnX9CeFgtYmDLuQsaTjRCk2HMRDdW42ZoadRzSQveeWGKA4o642iqpURJx0BUb/phSlemNbm6hmVVm2jf12gnr9SKYkN9iUqJsk34fRRpFH6CMokcYDv6GnTUZwgZ711z+oB9bRGngHPHwaagdyfx3CdxquKo6JpVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 15 Jun
 2023 04:49:32 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%4]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 04:49:32 +0000
Date:   Thu, 15 Jun 2023 12:49:17 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     David Vernet <void@manifault.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <rostedt@goodmis.org>, <dietmar.eggemann@arm.com>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <joshdon@google.com>,
        <roman.gushchin@linux.dev>, <tj@kernel.org>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230615044917.GA109334@ziqianlu-dell>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230613083203.GR4253@hirez.programming.kicks-ass.net>
 <20230614043529.GA1942@ziqianlu-dell>
 <20230615000103.GC2883716@maniforge>
Content-Type: multipart/mixed; boundary="8XlPbk5RYVynPJwG"
Content-Disposition: inline
In-Reply-To: <20230615000103.GC2883716@maniforge>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH0PR11MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f10f10-b456-432f-0b5a-08db6d5be80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6e4+BOX3uWExjMTMbPpqbml6iIA+c8az9mHzSRlZ3NkSPqMqpRw4RxQ5ZKmskWRdtFrQyjhNFGwVy1hxLhNwGk1/eewXmzySZt+AoV/l5LSBZL0fp8snaZyYQT/pmQQ5pYDqlXRH7wH+lca2eLJIbMRQ68dJTHOCJYVd3GHnAEgC52j/9Oi3ZiRHcWSx/xZbTUKucMYZFzpi983GXKC20Upr6gLWq1I51rDRSMaIIXS0tERN+6Xbwbi49Z/FZ4ZtWXN+fPU6Xb5aa13Pc/2ALbEeYF6025UIOyTuYBrsa2BZpEtjFPrFdkAatNxABpIw0Vj2TMo++SSSVGf+DGq5laj4y7QrmvK9+4B39isLIuAehdnMM4+PDZnmvtg4Q19BHINtE+HMaW8f76OujnLBWkLy8WzH95QgAgqB1tWWlaQ1g1SsIIZIiVthPujljQamnR4YrQMxXAlXUOfajg8AuqTJrZMEASp7qBJYKaS4PUk7dyIm2T/AsONi/KyVop4VRgizu9DvDGsRLQ8NKO2/zTKPtvmmuh1uMFxpu5TSj9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(6506007)(186003)(1076003)(9686003)(33716001)(26005)(6512007)(83380400001)(41300700001)(7416002)(44832011)(966005)(6666004)(2906002)(44144004)(30864003)(33656002)(8676002)(8936002)(4326008)(82960400001)(6486002)(478600001)(6916009)(316002)(5660300002)(86362001)(66476007)(66946007)(235185007)(66556008)(38100700002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zc9Hbkqxar5eE2R7h0nyA9PEbQYudiSswWsSubRT4cMlFvAAaVLct49r4cV0?=
 =?us-ascii?Q?bANSPJ1wg69LVabmO08irLnlj5BiCKDQXEXAWTJd2/i7/MoGJ1N0+BLUOMC7?=
 =?us-ascii?Q?TKYB9AYqJTXHoDjLRtl7negJtqV6jMd7eJyhtGTECBX6fNUdVfsVLdObs5x4?=
 =?us-ascii?Q?JQ6C6qFa+At6bdwRBUrbKNOxF99nIWrNt2yfoBOdNPGaqqP6E+pYr6GEUcXc?=
 =?us-ascii?Q?Pa7eCnQYUVkCNfxZiXyXo8L4q8pzIHRpjKcJ4KFNzMPGGTYiy3MVrqxr0zzV?=
 =?us-ascii?Q?Am2+VMiiFbct/4MzXmvTjuOxBeFJliXLfAx1gt/hmTC6Y7MEXQq3I+yN5WK4?=
 =?us-ascii?Q?kzW84cGvrGBw8gGGRs5aj8IPaH/ENWpyQL/S9L4BVaKwAjPmKIgjUj7q8WVp?=
 =?us-ascii?Q?GqrPGiD3xvIVNQZax0jJr6W3ZkejhzgQqt7NXuktZte66Zv58y9izRJZe15L?=
 =?us-ascii?Q?bbfQp1TGwvOTmC7TWMz+jvC0Ou8v4VVhh6jYz+uLlcGnwMGlswl43HN0Odc0?=
 =?us-ascii?Q?laf9FwoDzpEWbXvkAKuwHacD5JEvJVnkbJuC7/Qwgfw31MX/gvDls4OzOdl8?=
 =?us-ascii?Q?TuDNlxYYZmnN/jVkj+Vqjqk5bVw5wKkDiF35y82YHYbMH8SCtAHxyitaoMjr?=
 =?us-ascii?Q?ApiaNO3zQzL6iYwlcOpyAxfrDT68u705xGKttF6a47t4ysmcl+PXbmlVndaV?=
 =?us-ascii?Q?rzRftMaBPLgS3PisDN7TJXoA6D3pkn9kbVfgQSaWNg/FQGqFuQCfe6/zjMHk?=
 =?us-ascii?Q?jAfnfRd15dDGFR2xGS6FhWsgkkVFGnh98GvWLFA/j9+Lvn/BXN5APckH8cUh?=
 =?us-ascii?Q?KnNmhFL9bRurjdwyUSiwa4cJmFPIDn2/J4ra15caAlV7AMyr2+dbqLITXJab?=
 =?us-ascii?Q?DOGYqdB44IgkTlxnu8svxnminaPZJ1EaNejjTOFqZzkU8CcHcWxo0Mqv480N?=
 =?us-ascii?Q?LiGKOchCgv3Di6leD4gZT+5vYKk4lB8GtXIPNALEuJoOu8P5B3LxaKwfYBV9?=
 =?us-ascii?Q?BTdJxnSkYdYTwvDAXO7PYHs6J9SRe2A+7ojkpNk6glzbWLMwzoajWHBUCjmW?=
 =?us-ascii?Q?B9VVlSzhOc4V9msTeeTHj7EVHO7RosjyLKJqaijX18FLhCL2MqWwpG7Cjilr?=
 =?us-ascii?Q?riK2WrHJK/UP7W797Fumx+mJkefAp16q+XHlCXrvAKwvfHZKNwZ74HcFGImu?=
 =?us-ascii?Q?ZJwHAAxzqXOxhe//hj42Un5rkTk023zIyVUK9rf98fiYv6JGC3+XJjcOc82h?=
 =?us-ascii?Q?5+6igQq3tyZG70KPVUFWuS2SpqvnIvarFmWbWBba4udxajqIDvyfBE0kIUDF?=
 =?us-ascii?Q?RT0VW5Lf8qzbI4OsiUvkWr34lDJecg+uVYdFMJch9imQ5OGEXuYOBMlJw35Y?=
 =?us-ascii?Q?kSJcWZ0mmBjfAWrHn3zU+MJAVtYI9p9IOnbisVQhQHI8ZFDkSQ58ZJcepYP3?=
 =?us-ascii?Q?YnjX42+kVNS7CqqJkeWTW1no0NX4STjTcgYS8bKrZYCC9wpxGFVDNDNRTkKU?=
 =?us-ascii?Q?3hlcZxDUCgAdwqbpJ4hOdNQ/a4d2uCET29HQcHX0ywqHTOKzDIkkeH8VyTjg?=
 =?us-ascii?Q?ZEE42H58Z97bfE9ytfYwgE9m0OltRFKEevBHPVpb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f10f10-b456-432f-0b5a-08db6d5be80f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 04:49:31.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Thrle4+fJ0t0OM6c1xnF1xxYDZgv52jritfAaIBoUKI58f5GHwxOigfP7N+se+5m2XcRxRs6Mn5wqz8K17W5Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8XlPbk5RYVynPJwG
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi David,

On Wed, Jun 14, 2023 at 07:01:03PM -0500, David Vernet wrote:
> Hi Aaron,
> 
> Thanks for taking a look and running some benchmarks. I tried to
> reproduce your results on a 26 core / 52 thread Cooperlake host, and a
> 20 core / 40 thread x 2 Skylake host, but I wasn't able to observe the
> contention on the per-swqueue spinlock you were saw on your Ice Lake.
> 
> I ran the following netperf benchmarks:
> 
> - netperf -l 60 -n $(nproc) -6
> - netperf -l 60 -n $(nproc) -6 -t UDP_RR

Just to confirm: did you run multiple of the above or just one?

> 
> Here are the results I'm seeing from taking the average of running those
> benchmarks three times on each host (all results are from the "Throughput"
> column of the below table).
> 
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput <<<
> bytes  bytes   bytes    secs.    10^6bits/sec
> 
> 
> 26 / 52 x 1 Cooperlake
> ----------------------
> 
> Default workload:
> 
> NO_SWQUEUE: 34103.76
> SWQUEUE:    34707.46
> Delta: +1.77%
> 
> UDP_RR:
> 
> NO_SWQUEUE: 57695.29
> SWQUEUE: 54827.36
> Delta: -4.97%
> 
> There's clearly a statistically significant decline in performance for
> UDP_RR here, but surprisingly, I don't see any contention on swqueue
> locks when I profile with perf. Rather, we seem to be contending on the
> rq lock (presumably in swqueue_pick_next_task() which is unexpected (to
> me, at least):

I don't see rq lock contention though and since you have seen some
contention here, I suppose you should have started multiple instances of
netperf client?

> 
>      7.81%  netperf  [kernel.vmlinux]                                           [k] queued_spin_lock_slowpath
>             |          
>              --7.81%--queued_spin_lock_slowpath
>                        |          
>                         --7.55%--task_rq_lock
>                                   pick_next_task_fair
>                                   schedule
>                                   schedule_timeout
>                                   __skb_wait_for_more_packets
>                                   __skb_recv_udp
>                                   udpv6_recvmsg
>                                   inet6_recvmsg
>                                   __x64_sys_recvfrom
>                                   do_syscall_64
>                                   entry_SYSCALL_64
>                                   __libc_recvfrom
>                                   0x7f923fdfacf0
>                                   0
>      4.97%  netperf  [kernel.vmlinux]                                           [k] _raw_spin_lock_irqsave
>             |          
>              --4.96%--_raw_spin_lock_irqsave
>                        |          
>                        |--1.13%--prepare_to_wait_exclusive
>                        |          __skb_wait_for_more_packets
>                        |          __skb_recv_udp
>                        |          udpv6_recvmsg
>                        |          inet6_recvmsg
>                        |          __x64_sys_recvfrom
>                        |          do_syscall_64
>                        |          entry_SYSCALL_64
>                        |          __libc_recvfrom
>                        |          0x7f923fdfacf0
>                        |          0
>                        |          
>                        |--0.92%--default_wake_function
>                        |          autoremove_wake_function
>                        |          __wake_up_sync_key
>                        |          sock_def_readable
>                        |          __udp_enqueue_schedule_skb
>                        |          udpv6_queue_rcv_one_skb
>                        |          __udp6_lib_rcv
>                        |          ip6_input
>                        |          ipv6_rcv
>                        |          process_backlog
>                        |          net_rx_action
>                        |          __softirqentry_text_start
>                        |          __local_bh_enable_ip
>                        |          ip6_output
>                        |          ip6_local_out
>                        |          ip6_send_skb
>                        |          udp_v6_send_skb
>                        |          udpv6_sendmsg
>                        |          __sys_sendto
>                        |          __x64_sys_sendto
>                        |          do_syscall_64
>                        |          entry_SYSCALL_64
>                        |          __libc_sendto
>                        |          
>                        |--0.81%--__wake_up_sync_key
>                        |          sock_def_readable
>                        |          __udp_enqueue_schedule_skb
>                        |          udpv6_queue_rcv_one_skb
>                        |          __udp6_lib_rcv
>                        |          ip6_input
>                        |          ipv6_rcv
>                        |          process_backlog
>                        |          net_rx_action
>                        |          __softirqentry_text_start
>                        |          __local_bh_enable_ip
>                        |          ip6_output
>                        |          ip6_local_out
>                        |          ip6_send_skb
>                        |          udp_v6_send_skb
>                        |          udpv6_sendmsg
>                        |          __sys_sendto
>                        |          __x64_sys_sendto
>                        |          do_syscall_64
>                        |          entry_SYSCALL_64
>                        |          __libc_sendto
>                        |          
>                        |--0.73%--enqueue_task_fair
>                        |          |          
>                        |           --0.72%--default_wake_function
>                        |                     autoremove_wake_function
>                        |                     __wake_up_sync_key
>                        |                     sock_def_readable
>                        |                     __udp_enqueue_schedule_skb
>                        |                     udpv6_queue_rcv_one_skb
>                        |                     __udp6_lib_rcv
>                        |                     ip6_input
>                        |                     ipv6_rcv
>                        |                     process_backlog
>                        |                     net_rx_action
>                        |                     __softirqentry_text_start
>                        |                     __local_bh_enable_ip
>                        |                     ip6_output
>                        |                     ip6_local_out
>                        |                     ip6_send_skb
>                        |                     udp_v6_send_skb
>                        |                     udpv6_sendmsg
>                        |                     __sys_sendto
>                        |                     __x64_sys_sendto
>                        |                     do_syscall_64
>                        |                     entry_SYSCALL_64
>                        |                     __libc_sendto
>                        |          
>                         --0.68%--task_rq_lock
>                                   pick_next_task_fair
>                                   schedule
>                                   schedule_timeout
>                                   __skb_wait_for_more_packets
>                                   __skb_recv_udp
>                                   udpv6_recvmsg
>                                   inet6_recvmsg
>                                   __x64_sys_recvfrom
>                                   do_syscall_64
>                                   entry_SYSCALL_64
>                                   __libc_recvfrom
>                                   0x7f923fdfacf0
>                                   0
> 
> The profile without swqueue doesn't show any contention on the rq lock,
> but does show us spending a good amount of time in the scheduler:
> 
>      4.03%  netperf  [kernel.vmlinux]                                           [k] default_wake_function
>             |          
>              --3.98%--default_wake_function
>                        autoremove_wake_function
>                        __wake_up_sync_key
>                        sock_def_readable
>                        __udp_enqueue_schedule_skb
>                        udpv6_queue_rcv_one_skb
>                        __udp6_lib_rcv
>                        ip6_input
>                        ipv6_rcv
>                        process_backlog
>                        net_rx_action
>                        __softirqentry_text_start
>                        __local_bh_enable_ip
>                        ip6_output
>                        ip6_local_out
>                        ip6_send_skb
>                        udp_v6_send_skb
>                        udpv6_sendmsg
>                        __sys_sendto
>                        __x64_sys_sendto
>                        do_syscall_64
>                        entry_SYSCALL_64
>                        __libc_sendto
>      3.70%  netperf  [kernel.vmlinux]                                           [k] enqueue_entity
>             |          
>              --3.66%--enqueue_entity
>                        enqueue_task_fair
>                        |          
>                         --3.66%--default_wake_function
>                                   autoremove_wake_function
>                                   __wake_up_sync_key
>                                   sock_def_readable
>                                   __udp_enqueue_schedule_skb
>                                   udpv6_queue_rcv_one_skb
>                                   __udp6_lib_rcv
>                                   ip6_input
>                                   ipv6_rcv
>                                   process_backlog
>                                   net_rx_action
>                                   __softirqentry_text_start
>                                   __local_bh_enable_ip
>                                   ip6_output
>                                   ip6_local_out
>                                   ip6_send_skb
>                                   udp_v6_send_skb
>                                   udpv6_sendmsg
>                                   __sys_sendto
>                                   __x64_sys_sendto
>                                   do_syscall_64
>                                   entry_SYSCALL_64
>                                   __libc_sendto
> 
> There's clearly a measurable impact on performance here due to swqueue
> (negative for UDP_RR, positive for the default workload), but this looks
> quite different than what you were observing.

Yes.

> 
> 20 / 40 x 2 Skylake
> -------------------
> 
> Default workload:
> 
> NO_SWQUEUE: 57437.45
> SWQUEUE: 58801.11
> Delta: +2.37%
> 
> UDP_RR:
> 
> NO_SWQUEUE: 75932.28
> SWQUEUE: 75232.77
> Delta: -.92%
> 
> Same observation here. I didn't collect a profile, but the trend seems
> consistent, and there's clearly a tradeoff. Despite the small drop in
> perf for UDP_RR, it seems quite a bit less drastic than what would be
> expected with the contention you showed in your profile.

Indeed.

> 
> 7950X (8 cores / 16 threads per CCX, 2 CCXs)
> --------------------------------------------
> 
> Default workload:
> 
> NO_SWQUEUE: 77615.08
> SWQUEUE: 77465.73
> Delta: -.19%
> 
> UDP_RR:
> 
> NO_SWQUEUE: 230258.75
> SWQUEUE: 230280.34
> Delta: ~0%
> 
> I'd call this essentially a no-op.
> 
 
> With all that said, I have a few thoughts.
> 
> Firstly, would you mind please sharing your .config? It's possible that
> the hosts I'm testing on just don't have big enough LLCs to observe the
> contention you're seeing on the swqueue spinlock, as my 26 / 52 CPL host
> is smaller than a single socket of your 32/64 ICL host. On the other
> hand, your ICL isn't _that_ much bigger per-LLC, so I'd be curious to

Agreed. Your 26cores/52threads isn't that smaller than mine and I had
expected to see something similar.

> see if there's a .config difference here that's causing the contention.

Attached my .config.
I also pushed the branch I used for testing to github just in case you
want to take a look: https://github.com/aaronlu/linux.git swqueue

> Also, the fact that Milan (which has only 6 cores / 12 threads per LLC)
> also saw a performance hit with swqueue for UDP_RR suggests to me that
> the issue with UDP_RR is not the scalability of the per-LLC swqueue
> spinlock.

I've tested again today and I still saw serious contention on
swqueue->lock with your cmdline. I did it this way:
"
$ netserver                                                                                      
Starting netserver with host 'IN(6)ADDR_ANY' port '12865' and family AF_UNSPEC

$ for i in `seq 128`; do netperf -l 60 -n 128 -6 -t UDP_RR & done
"
And the profile is about the same as my last posting:

    83.23%    83.18%  [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath            -      -            
            |          
            |--40.23%--sendto
            |          entry_SYSCALL_64
            |          do_syscall_64
            |          |          
            |           --40.22%--__x64_sys_sendto
            |                     __sys_sendto
            |                     sock_sendmsg
            |                     inet6_sendmsg
            |                     udpv6_sendmsg
            |                     udp_v6_send_skb
            |                     ip6_send_skb
            |                     ip6_local_out
            |                     ip6_output
            |                     ip6_finish_output
            |                     ip6_finish_output2
            |                     __dev_queue_xmit
            |                     __local_bh_enable_ip
            |                     do_softirq.part.0
            |                     __do_softirq
            |                     net_rx_action
            |                     __napi_poll
            |                     process_backlog
            |                     __netif_receive_skb
            |                     __netif_receive_skb_one_core
            |                     ipv6_rcv
            |                     ip6_input
            |                     ip6_input_finish
            |                     ip6_protocol_deliver_rcu
            |                     udpv6_rcv
            |                     __udp6_lib_rcv
            |                     udp6_unicast_rcv_skb
            |                     udpv6_queue_rcv_skb
            |                     udpv6_queue_rcv_one_skb
            |                     __udp_enqueue_schedule_skb
            |                     sock_def_readable
            |                     __wake_up_sync_key
            |                     __wake_up_common_lock
            |                     |          
            |                      --40.22%--__wake_up_common
            |                                receiver_wake_function
            |                                autoremove_wake_function
            |                                default_wake_function
            |                                try_to_wake_up
            |                                ttwu_do_activate
            |                                enqueue_task
            |                                enqueue_task_fair
            |                                |          
            |                                 --40.22%--_raw_spin_lock_irqsave
            |                                           |          
            |                                            --40.21%--native_queued_spin_lock_slowpath
            |          
            |--38.59%--recvfrom
            |          |          
            |           --38.59%--entry_SYSCALL_64
            |                     do_syscall_64
            |                     __x64_sys_recvfrom
            |                     __sys_recvfrom
            |                     sock_recvmsg
            |                     inet6_recvmsg
            |                     udpv6_recvmsg
            |                     __skb_recv_udp
            |                     __skb_wait_for_more_packets
            |                     schedule_timeout
            |                     schedule
            |                     __schedule
            |                     |          
            |                      --38.59%--pick_next_task_fair
            |                                |          
            |                                 --38.59%--swqueue_remove_task
            |                                           |          
            |                                            --38.59%--_raw_spin_lock_irqsave
            |                                                      |          
            |                                                       --38.58%--native_queued_spin_lock_slowpath
            |          
            |--2.25%--sendto
            |          entry_SYSCALL_64
            |          do_syscall_64
            |          |          
            |           --2.25%--__x64_sys_sendto
            |                     __sys_sendto
            |                     sock_sendmsg
            |                     inet6_sendmsg
            |                     udpv6_sendmsg
            |                     udp_v6_send_skb
            |                     ip6_send_skb
            |                     ip6_local_out
            |                     ip6_output
            |                     ip6_finish_output
            |                     ip6_finish_output2
            |                     __dev_queue_xmit
            |                     __local_bh_enable_ip
            |                     do_softirq.part.0
            |                     __do_softirq
            |                     net_rx_action
            |                     __napi_poll
            |                     process_backlog
            |                     __netif_receive_skb
            |                     __netif_receive_skb_one_core
            |                     ipv6_rcv
            |                     ip6_input
            |                     ip6_input_finish
            |                     ip6_protocol_deliver_rcu
            |                     udpv6_rcv
            |                     __udp6_lib_rcv
            |                     udp6_unicast_rcv_skb
            |                     udpv6_queue_rcv_skb
            |                     udpv6_queue_rcv_one_skb
            |                     __udp_enqueue_schedule_skb
            |                     sock_def_readable
            |                     __wake_up_sync_key
            |                     __wake_up_common_lock
            |                     |          
            |                      --2.25%--__wake_up_common
            |                                receiver_wake_function
            |                                autoremove_wake_function
            |                                default_wake_function
            |                                try_to_wake_up
            |                                ttwu_do_activate
            |                                enqueue_task
            |                                enqueue_task_fair
            |                                _raw_spin_lock_irqsave
            |                                |          
            |                                 --2.25%--native_queued_spin_lock_slowpath
            |          
             --2.10%--recvfrom
                       entry_SYSCALL_64
                       do_syscall_64
                       __x64_sys_recvfrom
                       __sys_recvfrom
                       sock_recvmsg
                       inet6_recvmsg
                       udpv6_recvmsg
                       __skb_recv_udp
                       __skb_wait_for_more_packets
                       schedule_timeout
                       schedule
                       __schedule
                       |          
                        --2.09%--pick_next_task_fair
                                  swqueue_remove_task
                                  _raw_spin_lock_irqsave
                                  |          
                                   --2.09%--native_queued_spin_lock_slowpath

During the test, vmstat showed lines like this:
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free     buff  cache     si   so    bi    bo   in     cs   us sy id wa st
185 0      0 128555784  47348 1791244    0    0     0     0  32387 4380484  1 98  0  0  0

When swqueue is disabled, vmstat showed lines like this and there is no
lock contention:
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free     buff  cache     si   so    bi    bo   in     cs   us sy id wa st
116 0      0 128977136  58324 1338760    0    0     0    16 599677 9734395  5 72 23  0  0

The runnable tasks are a lot more when swqueue is in use and sys% also
increased, perhaps due to the lock contention.

I'll see if I can find a smaller machine and give it a run there too.

Thanks,
Aaron

--8XlPbk5RYVynPJwG
Content-Type: application/gzip
Content-Disposition: attachment;
	filename="config-6.4.0-rc5-00237-g06b8769b15ae.gz"
Content-Transfer-Encoding: base64

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

--8XlPbk5RYVynPJwG--
