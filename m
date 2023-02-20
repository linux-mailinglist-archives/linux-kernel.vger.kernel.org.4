Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6484269C4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 05:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBTEzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 23:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTEzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 23:55:40 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A72B76B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 20:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676868939; x=1708404939;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ql4U1tywwQlma/Z5C0vsawLQdeJ7iwaJ3AbaLslPgcY=;
  b=dtBi9vpoW2MIHaEkTGXh95YWWJTolplUDhwN7owK3e6Z7SsMIRYGGABO
   4v2n2emOu+8IQIoqWFho5jLBgcnT/+8PWDOoflOB76imDRPQnk62jYJOp
   vf62UNlzlQhudFsTHRhPuC93qbSQGs/NWcRwdbB2gl9QNFSj4AF2ZVFko
   HG8AvP2K+UDjB41Hk/133ELfajXmlD4OKrnES9wrTWhvdHQGw0VY8zNsB
   4LKzourlslobiDMmlgShF7HnSDZDiphF4wFKZDKcJK34Bvu+vlQgz5fQt
   FLsH3iTPnR30xGxAdBQUiSNXp69F2KyLXgI+X5r86gKNCfFI/jAysoHYn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="320442322"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="320442322"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 20:55:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="734998450"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="734998450"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 19 Feb 2023 20:55:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 19 Feb 2023 20:55:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 19 Feb 2023 20:55:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 19 Feb 2023 20:55:37 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 19 Feb 2023 20:55:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqBAwXpJYC+kbvyqrwb5JmCAIXCPEnxivtUr+ciJSVWtsWzV0PcOpLSQVx3gv3aOnYyGNq7E8grSSG4ibAYNlPr2zeRGUbuJhE7MmTLAzZgu2zL7u7bRSvmlAg1edK6QxhnMpdJeED6FHk3FuHD07u/c0zW4CRrE7OMvojo09L8DCDSpbc8UVx3btcWcSfyg39hcscDamwBr85SyaL0VZBjqkqhwnSmtUGFgRoBu8+vjn/oGTVqwGVfvVertkQezVkiiA4el7x809fK8isjjEo+tbY/XxrTBcHXuFRUeUnFGhRZkMfzuz9bG6oWiLM5/Ph9Zo7lk7r9hMFD2gir9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHfOLJIFcJTjlQ32dDoN1Sfp9OBt05NtmAuNQwsw18c=;
 b=a30/wo9inFhc4/xQVhsYTZgdXpOUEY9NZj1u7cSEi6TG+Gro7Qf89wh8M+MLgXgbKimpmSsoILnOOxR+coZzU3PwBKFgHtylBA25ia9F/UOTt4gISzyjXqjgn5zDAB1Sdsv638mLaEESMQFS13HybrKbe8+Pe7itu2OJlOKGFLe7pIQJZBsW7nxlUvxDtBIPqYAFnhyNBZZXM06KsfJ/U9pds2iCJlcItlwf2gWUbAkrwQwYFYgkY55NbtbD8phFfH7aa0Legj75145PoObcQR1O5fRq60tbkbpGFEympvGUHsRdxWx8x7KFvTIyZsr5eclLo/onm7h8+lqOzGZS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL1PR11MB5512.namprd11.prod.outlook.com (2603:10b6:208:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 04:55:35 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%7]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 04:55:35 +0000
Date:   Mon, 20 Feb 2023 12:55:13 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        "Hillf Danton" <hdanton@sina.com>, <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH v5 2/2] sched/fair: Introduce SIS_SHORT to wake up short
 task on current CPU
Message-ID: <Y/L9MajLI3mqchQr@chenyu5-mobl1>
References: <cover.1675361144.git.yu.c.chen@intel.com>
 <1b8af8d99da99a20449288ab4fbba64dc05057ce.1675361144.git.yu.c.chen@intel.com>
 <36ba3b68-5b73-9db0-2247-061627b0d95a@bytedance.com>
 <Y+5Kwxnrj16xRklf@chenyu5-mobl1>
 <3a3220f7-e35b-ee77-649c-8c75dcb26b6c@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3a3220f7-e35b-ee77-649c-8c75dcb26b6c@bytedance.com>
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL1PR11MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c45c72b-044e-48df-c7d3-08db12feb398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zuDYeLsARdDWF27h1SUUh43urfD7jQBYooZ8HLJfSvPM7pcMzrcifVQy9JuNckeRVdZg/71NDxOkU2rvaxzdQqRkRiYXuyMeWkhhvUnIRTxuZhD61zvi3ExcoktJIUrTMtF9lR8PUcg0Fcnx1/WgU9M3MwJpM2pVKM2X43gj5nlzToAeG0vikpaPCL7jgStDmr0HyixWNhxOyBnjpCX4mq64A9Gd7GQa2lLkj+9/Ui8CcP+zqRF42xeAP7Yo3twn6962XxMgwrScLb2pT7cbV86JvfDRN6jCedIikX2/lipuhSGenF5d1gRiMwy6/lY84zknwfJQz8wPPnHYm/HF7W9C/41HbtIhOohl3vJaVwcVc6Bjdt6CAHZ9ohuKwoLjjA6BR9MfoZIbAzIFhzqb4JF0B9Um33cZVCmLZhK+xpdnjfG/7rFV9T++PvjlrEMhdQ9PIWi3ufYB5/0KO0RCyNmldOChv2MBcdKUUIytVUJBlDhT+6ZrZA3BUbRWKXtq2wu2GbN7CSbGU2VDM9ZweVk75lh7/Y6ok33L7sLishRDGnkGU+xOGGdWHLnBuqpCbTIrQ4i98rtLiwsDefhJo4yP67k9JaTIqdxMsqrwmAA4RNm7ykiF3QxL1k/JM3bxs5ELpYK3UMBjGr1lvgcDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(82960400001)(86362001)(5660300002)(2906002)(7416002)(38100700002)(33716001)(478600001)(6486002)(53546011)(9686003)(26005)(6512007)(186003)(54906003)(316002)(66946007)(8676002)(83380400001)(4326008)(6666004)(41300700001)(6506007)(8936002)(6916009)(66556008)(66476007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQE0cHcc3CjhO3xQB/vqviajSQATZXmzwTncanDHrmoz+92zcSsoc4dV2Ru4?=
 =?us-ascii?Q?qJ7KtC7er1qTXZk1NLbc8p7G3dyoGmzaWedoKvgCmdG9OaptNPsmmafXOvLO?=
 =?us-ascii?Q?CVhx/HfJf8yn4IwknzE5g9q8ZW6IP489etZpZ6PETqJzisGVvwtH/+dcwLpq?=
 =?us-ascii?Q?nK05Xqz8PnzZgzboXYE0iRvcGyD51OvX52z2xarovZfPC8P6gu9XB8XM7WBQ?=
 =?us-ascii?Q?7/79cdDHawcXGFaQVVhueQ8cgJl0BVQAYTq68CprMIuG3xasHqsYp4o8nkva?=
 =?us-ascii?Q?Q9FBGace6js40WO0cAe9V312qmGRNId4LOQkdgBgwetslGazRPpxM5DGZafY?=
 =?us-ascii?Q?GVB4PNVqxjDjIs59qy1PIC9oow3mODNIqgE5V7lpzWuAKIKEOBe7UkZIS371?=
 =?us-ascii?Q?Pxgw0kw9HBIQ4n42nQqkLe6CkXgq/OFzxVOkqk3MqwuaX4ZAxKWxYQ0h6YD4?=
 =?us-ascii?Q?SullXQU50hvSPmh1pKZQQt/L0+XQU8WiE17SLIqErDo5hc4IgLgqs2geF0Dd?=
 =?us-ascii?Q?C+vy+pvG4yDTZkqDmwCVxTlVSV94eXaUVCTRNQ+6N3CCyHw7IZVNHgCz+1F0?=
 =?us-ascii?Q?talKtVLuI93ySKhraLKsH4PLOjdA7/qb4hgPT5Nuw9qExyvtzCL30FmNk9iA?=
 =?us-ascii?Q?cHLtuZNi+Lt8oxtek3ZEzQpskfBLKImLW9nOmlLG+0ohTSE+5ibYG4EQYEic?=
 =?us-ascii?Q?aUGc0LOyj7xla8Tf3dPs1jhtVj+fcm2aEMAfXHv8AeGTqrv8/xvFi1n6M8Pm?=
 =?us-ascii?Q?9b2pOk4bKhtJR7fHmHae0T6dHM0UfKmgpKrtr+HeZvQCtnH9geCBp+Qbc7OJ?=
 =?us-ascii?Q?90FiRjDpFQVrtAzc6G/Bw+/kawZBRoQgbDtcf643x4IilYtKW96odMfxdhuP?=
 =?us-ascii?Q?uJeV2BcyqdnwtoUlFDgil0n7Lb6y0E9peJoLulgZ/Q7KaUHSyVEJUm1L08au?=
 =?us-ascii?Q?kL3+HIiIQGbqghOA737Msz5j8JQcCbdmcdgXmLtK52PFkal9ZOjmNY9U9ze+?=
 =?us-ascii?Q?mDtnRw3OyeR7ObQtfPb7aZxJcy2/O9crFGw5K61yT8YspQlslDBKpDBHoToT?=
 =?us-ascii?Q?2c1UPdToLNsRmaEtvSFrvlaEvCwxZamppJXy8QvQs1VlfYpVkxUWt50cHMUw?=
 =?us-ascii?Q?Ap5lWxDn6ogDVm7kvYUQ1XVN8OQYlsjqhWmpE2L70rQWdoTpT9cjjnN9ME9q?=
 =?us-ascii?Q?pQdsTP6XuFjkW+//9ueVETg6P6g1utd6vrIi1kvQdO5Id5cEO44NrNaYnS4G?=
 =?us-ascii?Q?RKFgsvMaWMONCZRmea6zDjUpbZ+t/luVIxRFBok9WdPTRtbEzH7XLhReLV/y?=
 =?us-ascii?Q?2hzvPS1u+PkH2bWBeISUkliH3jRWSI7jckpSXf8zqyaAtN8yBH4B5tSyMXO5?=
 =?us-ascii?Q?uqqzXjU2PRzzX4v2HM0y6A0ym3JNeYVzX8ThVGmGa6vmjGddwef7FUxCksa2?=
 =?us-ascii?Q?Y4oiOWv8ArS/7FaxjldNMb9qkzftP1T6rrxF9evLXaoUcsRD1zRGDlXxb7lF?=
 =?us-ascii?Q?LRUTnBUaGrVeq0IzeEVm2G+1ysuR0dQoylECQxDpkIliOdxXvrRR4YKHCVja?=
 =?us-ascii?Q?zt0x4RTnBeDJOUjKkRnbo1xldFk9Gs2s8ZFZoULE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c45c72b-044e-48df-c7d3-08db12feb398
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 04:55:34.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG3MEGcOb7bPPYGTMqKQOm+RbbNHzycmXBFuH74mnq4xWGwU4q8ovZ5M1vpAbWyCdKtrxhaieJrmxIxPg8hb9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5512
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-17 at 10:44:51 +0800, Abel Wu wrote:
> On 2/16/23 11:24 PM, Chen Yu wrote:
> > > The following change greatly reduced the p99lat of Redis service
> > > from 150ms to 0.9ms, at exactly the same throughput (QPS).
> > > 
> > > @@ -5763,6 +5787,9 @@ wake_affine_weight(struct sched_domain *sd, struct
> > > task_struct *p,
> > > 	s64 this_eff_load, prev_eff_load;
> > > 	unsigned long task_load;
> > > 
> > > +	if (is_short_task(p))
> > > +		return nr_cpumask_bits;
> > > +
> > So above change wants to wake up the short task on its previous
> > CPU if I understand correctly.
> 
> Yes.
> 
> > > 	this_eff_load = cpu_load(cpu_rq(this_cpu));
> > > 
> > > 	if (sync) {
> > > 
> > > I know that 'short' tasks are not necessarily 'small' tasks, e.g.
> > > sleeping duration is small or have large weights, but this works
> > > really well for this case. This is partly because delivering data
> > > is memory bandwidth intensive hence prefer cache hot cpus. And I
> > > think this is also applicable to the general purposes: do NOT let
> > > the short running tasks suffering from cache misses caused by
> > > migration.
> > > 
> > I see. My original thought was to mitigate short task migration
> > as much as possible. Either waking up the task on current CPU or previous
> > CPU should both achieve the goal in theory. Could you please describe
> > a little more about how Redis proxy server was tested? Was it tested
> > locally or using multiple machines? I asked this because for network
> > benchmarks, it might be better to wake the task close to the waker(maybe
> > the NIC interrupt) due to hot network buffer. Anyway I will test
> > your change slightly changed to see the impact, and also Redis. But it
> > would be even better if you could provide some simple test steps I can
> > try locally : )
> 
> Sorry for missing the info. The test was done in production environment,
> and what I have done is only updating the kernel in several machines
> which are highly loaded, that is over 85% cpu util observed by mpstat.
> Please let me know if you want any specific info.
>
I've modified the code a little bit, which was inpired by your statement
"'small' tasks can be easily stacked on this cpu when wake up several tasks
at one time if this cpu is unloaded". I added extra check on wakee_flips, so
that tasks waking up too many different tasks will not be treated as 'small'
ones. That is to say, only tasks waking up each other exclusively will be
put together. So far this change has verified to keep the improvement for
netperf/will-it-scale, and I just launched the redis test to see what will
happen.

thanks,
Chenyu
