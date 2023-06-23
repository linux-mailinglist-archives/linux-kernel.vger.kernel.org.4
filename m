Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F673BA8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjFWOpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjFWOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:44:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB01988
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687531450; x=1719067450;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wQ5KQXFcAhMBCLoKZ0WPtoUQhpNqTQ8AlcZN++zAjkI=;
  b=XEPy+co98Y0IGghAsWS8wNTLA/+NCkqp49M330jujuU5XEO+I892dy0v
   hHgSmiCyYqACYvUmICtwPfn+UIlFQWi7+xKuBpbMWd2aYJdyDUZffEGiU
   zNmXQSbER9/NUBwFTW+xzFkvTKlXHvJQ63Eu9k6P8DVShf7AI72937jSo
   xAU//0rvAZKkjhVAjjgM9vQfP018QINID8US48I+xPc+iUObax+ZF3BAC
   Hl20EpfTlXmTA8L0m0mogGrMGH7fmIJVnh6XxRd7u6TMQNKPtlis/kX3f
   A9lquX8HnPKSqkbMHtljQal6KjlU28J+P6vitstv6RxwV96KEDKvEu8lA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="363331703"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="363331703"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 07:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="665502161"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="665502161"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 23 Jun 2023 07:44:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 07:44:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 07:44:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 07:44:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 07:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjzmODc8qISqubtYRZpPUdp3DIQ5y5m7S1TQr82Fu7OzEJTNXCn2Y85xDuRZsNkI4vNSs58FIVD6QFBdbfz5Tz2niiuhh17lHTN6VIlHLDLZ4vl7C5wB5kL4hzzFzd+19RhHxP7M+ZLOUM3NcwjSn5zryyzk2/dj8yMnghZIhVIM5Tmdipo9E/RrhuYXaXh213S0V8RdXuRwp8rxWvA4vW5/bEAccysJuCE8yA4e/u3agxAkfcjM/HNoLAoEwJ8ZdnsFv1yrjOiwsrsEXg1BJZxPAqOkjb9RKDfrf8/9M2lvJ9Trk3bvx7fmvCHLuZl7xoEsYDy4RZqKhelY6wUfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NLnh7VySFL6KjiTBPuose4F3Zi5WYYIZj51fimjKGs=;
 b=IXexgnkLtQFp12muAJsGFFTCCJEsqBmYrCvUwruVbghq5nIOzRoZ5J2VTXBdLEHP3/295/a1aSFfMEn8N1gW+xpaQq4GHC04jyNbvypaZGnfqj1TLkNwsflCE+TUcCzXxannlAEPfVw2fCNJruDeNBJbOmY90DCZnMF8TQirRtja8xQpOWjnaHRRm49G0xgduDzUMJKx+uUci/z0KEaodmpVqTmMwgXVg769SIBH3dvgn4dTj1pHV37sdpQj49Gnc5I9U0lQuLlHnY6qAwA1LqG4NuZiPdwqJyRZo2HD4NSkij8COQ7lIaHbavnwOS1dJhVdeUHDWWPPXXMWDsf9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 14:44:06 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::3cc2:6622:cce5:cd02]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::3cc2:6622:cce5:cd02%5]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 14:44:06 +0000
Date:   Fri, 23 Jun 2023 22:43:50 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Message-ID: <ZJWvpi5VZtxnyDg8@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
 <20230621111721.GA2053369@hirez.programming.kicks-ass.net>
 <ZJWtM1rgC52twqPS@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJWtM1rgC52twqPS@chenyu5-mobl2.ccr.corp.intel.com>
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To CY5PR11MB6211.namprd11.prod.outlook.com
 (2603:10b6:930:25::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6211:EE_|SA1PR11MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: b47fbfab-ab26-425c-981e-08db73f84ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYBCk4UiEgFp2ERSfz1284t2nnWSuhJyL2Ptu29i6CPDcjEfUlbx6GXlix8kvpVKJttXlaqCAW3J2ukCX22BKmZzMZBTMwFU6+SHp+IcOUJg93RKZFS5svadVhpE9dgnQ6a0CW71St8yIKqdzfCQ59r3eRYcnyi2F60K/3bm0vfrn/m+sP1OGBPiQe3KFw/icX3+HG1BV4jBj89kH+rxDG/IxvNkid4YCWGBTOjLV8V7M7eRC9wCc1GPnrG1FmU9j8rrL+WxBUmJKMO+gbZmU1yl8R926nSkebvkfKNjRTPLWTUDOMZC2ocRmX0THIO4FAniKMMxlr1LkT+tlYgdeb9TI9GEPqD2VG4arK8qMxLxc+/IV58zIbsuKXnAI0f2QIMhJom01f18z/2PX7W7VtFZpWka00HTzovPuNYi6KzWnSCRD2v63kgHCiqrtpr2FTS05ux2EfiAsR4reOwRKU2TsLy8RtUfsnZy4GTGiw203DCPOqal6LEZf+XGTctLywYOdx9JlyBJkyHzqx9yAm79f+uvTQfje8bZFcdf2kjd+bfwU4h17qQyqIJXB5As
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(83380400001)(8676002)(41300700001)(8936002)(316002)(186003)(82960400001)(38100700002)(6506007)(53546011)(6512007)(26005)(6666004)(54906003)(6486002)(478600001)(86362001)(66946007)(4326008)(66556008)(6916009)(66476007)(7416002)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kd31D3FUrh+Uck4YAfIStvmGvwSZvXaxiCu5jzmMEOR/5UvTwMcDzf8ft8Qj?=
 =?us-ascii?Q?cYc94B6oSMW0f4qM9H+WWGRJPx6M8id26220WLFvrG/XvLQd0hsdnm5feqnY?=
 =?us-ascii?Q?lxcEAz/ZGt50S2vjx3VCKWUaibHe0lIWWaPUAA/Q3BCC7tU3xpID9MqeZa4w?=
 =?us-ascii?Q?NKC4GMUPRIfnQ3qIahx9dojNvbtmxRITsmU+EUi3EeCZ4GdIbrr/hhweSMYs?=
 =?us-ascii?Q?GgXKjfiLSP+7uXjS+R7CYndJVAIHPi2I5fJBcWDeQPE3Ywhnwr26if2MNbdR?=
 =?us-ascii?Q?oeEL02CAWEksv4/abH5veACPJHOMoQpYI5IFLdu+GzmUm2HEpXYM9hiBPeiP?=
 =?us-ascii?Q?ksPr2qri6ZB3o3Hso51b7OJOeeSf6KubVgwyJpD/MICnOPdiHF2DVzn0jB5B?=
 =?us-ascii?Q?otmovJOZ4ysiSdgi1RLyBYCaHHndYxViEEXUUeF/Gwhf/gTgV20xrV+Fppmn?=
 =?us-ascii?Q?JX/C5R36beRoYBJpJHvsE/wxfp/kgosFtU4SwdkI4jd3+L62e9+ThMqYHhqr?=
 =?us-ascii?Q?KSte3oeD1Mm+PXD5A2d/v3OTCU2t7cg6ezcJIlSD0kyIXCyp7uf5BF60/6JB?=
 =?us-ascii?Q?/GH2STi2Waxwjz8+BUKlwrC1Fp76YANuZt1UUa4zI5x+b0SNLgkhKdTFXM5D?=
 =?us-ascii?Q?iVebqME14bFz0u2k5gS1YVYth1zgb7/yAyYLc4/bIaLJErFOIO+QO1847hpX?=
 =?us-ascii?Q?mrfpK9YeYtIooXX5vJvEf47QLk8EO4w8ZtpRbczD77tUmh/RoVPGeU27F1Oi?=
 =?us-ascii?Q?YdfwrnKjt08MpIL7cm/Qe7MWngWFgu3zaMblsJoBrc3KhjtxTd1rodEM9ggs?=
 =?us-ascii?Q?pbpYGzwHdEo+Kbx2/mZo7/EXx4FV+Zmb5pfKJ7zaaYSI3Cv8lbAJ1N8KmOys?=
 =?us-ascii?Q?Iv8IfWpL41c14o+F/EaLd90n0bDc0Mvdh0XRWvwbU9/fv5kZoe8jwkC/lEwc?=
 =?us-ascii?Q?1u9NF3dFAYXozV7zx9NQ8LyjzqodvkpJobu2NI6E5t/eQ8mX2Q54HATEeSWq?=
 =?us-ascii?Q?Z0CljCmcnyiaaJIGDw2gaFwju2OTWnv+1zWjJYucKSeFjwGxCNHZGRwLE+wA?=
 =?us-ascii?Q?GCrEENONTSQ1mCayXJpY9w0BVgXQJr55B6k6ZAXQ3x4NsxnRDxFO43Pn9vcx?=
 =?us-ascii?Q?1WTKvrpPQWwFDedg5Gwvfs/r9I5TYxWfKPI3YQKvby0/Pam+Vj7bXqwJ4bRl?=
 =?us-ascii?Q?nPQ4y/hW/l8oPBG1xzzlRUFnXnuIyWrUbJGlEmkSYP/9vHlX428FAxAFvGkn?=
 =?us-ascii?Q?OpL+HznT8lu/R6eSE3gThu2fi1sFUtYuU9jT7ApUNDJW9zVFoGXl3rI/+Cf0?=
 =?us-ascii?Q?S5Yu48zdGkLEyTKQ4jccaNaCba+NnvSvlASoBf0rgosepqdYUgrQbm9HVHFm?=
 =?us-ascii?Q?zc541w29EAeDZoDK4tt9Gh9Xu+C5rL1BwfVf/sxSbr89Vo5RzGorZ4EGfQz2?=
 =?us-ascii?Q?nca1ENsxbosFwO47MctqckI9fuSaZfeX2Jw7+GX/dhE83Szyeee8HKQWb92X?=
 =?us-ascii?Q?0rWQXMeUdvs43mtUh/2CgaDQ7IaOAj2pv/l9FHpp535bbm5DLNMRjtMpNFNv?=
 =?us-ascii?Q?BmHis0sPSKrwwcvb2iHBNLGH+2hROAx4rJcW7WHS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b47fbfab-ab26-425c-981e-08db73f84ba1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 14:44:06.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dm+SlMGg721r/2P51mUXclnTu6HtOxEToSSr6wgcVfYINNghca2wc9JT3wYjzpHyoUPchqanUiucBDfD22axtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-23 at 22:33:23 +0800, Chen Yu wrote:
> Hi Peter,
> On 2023-06-21 at 13:17:21 +0200, Peter Zijlstra wrote:
> > On Tue, Jun 13, 2023 at 12:18:57AM +0800, Chen Yu wrote:
> > > When CPU is about to enter idle, it invokes newidle_balance() to pull
> > > some tasks from other runqueues. Although there is per domain
> > > max_newidle_lb_cost to throttle the newidle_balance(), it would be
> > > good to further limit the scan based on overall system utilization.
> > > The reason is that there is no limitation for newidle_balance() to
> > > launch this balance simultaneously on multiple CPUs. Since each
> > > newidle_balance() has to traverse all the CPUs to calculate the
> > > statistics one by one, this total time cost on newidle_balance()
> > > could be O(n^2). This is not good for performance or power saving.
> > 
> > Another possible solution is to keep struct sg_lb_stats in
> > sd->child->shared (below the NUMA domains) and put a lock around it.
> > 
> > Then have update_sd_lb_stats() do something like:
> > 
> > 	struct sg_lb_stats *sgs = &sds->sgs;
> > 
> > 	if (raw_spin_trylock(&sds->sg_lock)) {
> > 		struct sg_lb_stats tmp;
> > 
> > 		... collect tmp
> > 
> > 		sds->sgs = tmp;
> > 		raw_spin_unlock(&sds->sg_lock);
> > 	}
> > 
> > 	... use sgs
> > 
> > Then you know you've always got a 'recent' copy but avoid the concurrent
> > updates.
> Thanks for taking a look and gave the suggestions! Yes, this is a good idea, by
> doing this we can further limit the number of CPU to do update in parallel, and
> allow the newidle CPU to reuse the data for idle load balance from others.
> This lock only allow 1 CPU in that domain to iterate the whole group, and the
> bottleneck might reply on how fast the CPU who grabs the lock can finish
> collecting the tmp sgs data. For MC domain, it would not take too much time, and for
> higher domains between MC and NUMA domain, it depends on how many CPUs there are in that
> domain.
I just realized that it's a trylock, so it should not block other CPUs who launch
the idle balance, but just to let 1 CPUs update the 'snapshot' at one time.
I'll do some tests.

thanks,
Chenyu
> I'll create one prototype based on your suggestion and measure the test data.
> 
> thanks,
> Chenyu
