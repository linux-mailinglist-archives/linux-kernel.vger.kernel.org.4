Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A0636383
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiKWP1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbiKWP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:26:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BA19CF77
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669217184; x=1700753184;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LisUAU1FIuR1sBM+zCxgJ6S7SWDCXJBLsCCNmmXVGUk=;
  b=Lg6GJI9jbdv7zfvX0kTNTseeq9BIItvGVzpDZRgsvVfDs/S3gBTGzgzw
   tfgvTNLx+8N6HS4zPxxkG9XRDPbS6jovjRuK67LbTE0W8Jkkxo/987ndl
   tNx7fne0EPQNlOJ/gMe5TZ+evrefZj9lcEWBCfy5qazVyQ42qDFVv/Bxa
   xDVPQKGBBbydAaf9KRGB3m22G35R2QfAI7vQkaabuIkHOLMg4P3sx4Sa3
   e9lIpdOx80SySzFevbq0g39sJQdlcdMGPyKwWECeo0k5miL/0srvxEeZ9
   XkCxDSLa3F78+S41XWxSkrJ7ClawK+yClOqmWOtTnwMfiJfcZZtjDtEaQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="312789770"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="312789770"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 07:26:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="747832047"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="747832047"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 23 Nov 2022 07:26:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 07:26:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 07:26:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 07:26:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 07:26:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfrUm4NxAsFQVL3sQSnrvKFRxQpoVRNyLozeAwJDBp2+CzzTKj3qOaRq9CVgWUVftDRnG57LQznpUyTt62LRqz55RsfXk3A/EPggHHzG5nyCVKwIHBp5YoivjgBLiJHqU8GeJKSBLUL8DtNgpxw8SLgyKLBveHUdXoiAiA5KJZNwESHI2cVAjTr1E0JxdmaICTRdXxEfZDTo5h3CcS5D0RMxy4GQC03EsYfsFv6CFDWGxWdHLOc/kaRZm38tcYREYBF8BeFN+/7klUt8oEB7p68LXdCH5ZjP2Wieh88/3TM6Ci9vC69X0GcEyb4IzWgT8Ffuw51ErDqx7Zwq57OJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXgjvxrl1EaAADUIk/Wtj+TxXo06gVCPb48RJmj/NX8=;
 b=UoNRjaNPCQwMwRN7ToI+h3jEBGimG1pRbO7AWz40chfYOHKM0vOFA+F2JrS+UXjRBTzJgKL5v6u5NHMyIVy3rzHgOtd8Aoemr5F625h6I9uoBi1HQez4iGh1WSQwbjjHJew4AlarBhmIJCd9evgJXEIEWFUGnE9jJvoGFGgDkFBImyUqUskQCjv4BiineILPwkg1I2rhbJnAe6Y7jgKVyDq6I0K14WsUbeAF8UikRT2MrLwrpzyNqUpWfmfVDnJVNbozcH1W/sdpfpPyHwhL+xU+qrsJ9jOAW31jOvDv1Wlal39ukTn4rYWbCd9jWdsyOi3QDIYnHPOE2GsCNAaD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB6702.namprd11.prod.outlook.com (2603:10b6:806:269::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:26:20 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5%6]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 15:26:20 +0000
Date:   Wed, 23 Nov 2022 23:26:43 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <peter.zijlstra@intel.com>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>, Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
Message-ID: <Y347syXAYqnAsSDK@xpf.sh.intel.com>
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
 <Y3Z5WTk+cvHSt0lf@hirez.programming.kicks-ass.net>
 <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com>
 <Y342qkDw7yqA1VOD@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y342qkDw7yqA1VOD@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 7beff52d-8d2e-40f3-3838-08dacd6712a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lb9vP5A+XPRGXxrtMeOWLvfW3H9rARcmzyoP3IFzyyn+yo6i5bL0Bsjns6uyEWsK7Yp3c8yOud1BKQMbaT32Rmc/AbIhzRfgOWuIV8fePL6Rdd605fU19oxzUpqqGB6JGtFoblxIrVV2gwIrMcgcnL6gx7BmYbT6KOV0O33q4ts2MKA17g33spPAHb7RtsVAi9uXNaylIYCg2rykV06jIf/y5NhLYhmKO7hexs7DyPWyD9wx9Uml3/h3zFhNzy5IrPml/i9eNHLEZEUClsE3VpthVpzP7E1ApnCy7UcLMkzgoLq56xgt4/ZQW1/knLZRKHm4u899zT5DyzM7SqSik3F666Avp60FbTn8LY3xlTT8tWRxCey+unY/XHCLXpA55ajSnG7qYoqHBqZulF8ELhWi3yUeObIV/TiphSj1qSZOfsVLbo3dpgXKKNnH7ojIqP6Aev7QiZAMqVCn8tw1PAz73VUHMwMK20zJ4bCTU73IpL2G9Uzx3t2te9T1kb4c295cHIqPTWE+sRqZblHDvYXny3gOXXWpo0ss70sjCFkQBSh2UZRnCV9JIZfFiQaa2NXHacWfdnGgmCZ2fN8eHHw1kDRLFu999Lv3ze4Umb4Nl4cKRS36RLNfGSVcvAsODyD0SCy/xPCnSS3ACxGL1W4ovpIk1P8DZJTCUcrQUxLoZYWdfCaH8MftawMcTghjU5T+3wDLf3ep6PBhtIS9aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(38100700002)(82960400001)(86362001)(54906003)(6916009)(316002)(26005)(41300700001)(186003)(66946007)(6506007)(66556008)(478600001)(4326008)(6486002)(966005)(6666004)(53546011)(2906002)(8676002)(6512007)(83380400001)(66476007)(5660300002)(44832011)(8936002)(4001150100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z1IEXOGzL4a2xQOVHTVBZcFphj5qO2tN85/w3AQk6evNErWYuRFyysNVznrZ?=
 =?us-ascii?Q?HHGPVlddcD+8VYf2UrtilMnY2MQYncTLIPl5BlTz4iCfF9Jwqk5fj0mIWydf?=
 =?us-ascii?Q?r8v9h2EQ2RRMFgBaEdSE1uJTD4fnNpgwNW2weMkxVEZ9WN8prYrczixJjQI8?=
 =?us-ascii?Q?e7SK8Oyatp3VA4TIntuyYnQj/7NJaxii83k45/2XZybOf9RFdXYYhIJEkodM?=
 =?us-ascii?Q?wpuwO73Cd4JRWwpq/7mJZ2M18Km1DoIHTWleNOuDaJrFlg2Y+yuX+2R4Bd/A?=
 =?us-ascii?Q?A9HSH34DC1RrFJ/GuxPR9w98fPmishjKAwsHWjjxniwtCiwSm+0AlrX79wON?=
 =?us-ascii?Q?uoLi1WfXsBv4Es1ma58vct5PfsVqpOL7NmcEgIqssF/e22NF9Zd0MZziDUUw?=
 =?us-ascii?Q?06CQsPozBFYRqYjfyk4afx2f8gXEoBFqEz5OM9QtlyODjWzpmIhGmGKIOJDt?=
 =?us-ascii?Q?6631Oy46BMSnW04vWdqFhE2JH/ddvfpAtVI5NLNw18oN/DVK3qOmLZ7EU965?=
 =?us-ascii?Q?4mLE/VwdPYa6q9fxMMOM1ve18jHR12AqNV2dadKUdRfBVH6IJAotUuTKGc2J?=
 =?us-ascii?Q?3V1RJU/UIChbJvXD57pj/LCEnjN2Q1E/WrVq9A2zIp+p7rXXPsNnAk8VRRYW?=
 =?us-ascii?Q?GEnZjC3IYfiNvLPtIDMtsgQFerta8IMEgFdhYG/z/p/Nm8CV9RnTUzvtOWcN?=
 =?us-ascii?Q?sXfZYN03Jof89kg6Bvs571dNiHpnDa5GqhfLJDdQwL3bBaiFM7JkpGFVz7tG?=
 =?us-ascii?Q?yTR1JE/O5eINic9RfNUQINs9iyWFdEpnEuCofpHlk2AUmTzTJfjjrsqJ1jkm?=
 =?us-ascii?Q?VXnzkFQrpUr832cXyWc0QH0VbUMOIsR/Y4PZwwD1qV1CIaIPC2jDxty9/QYP?=
 =?us-ascii?Q?2QXiuGRuCmC9xpAYLhmW/LGNcsbjpQo4zs9J/gX19hgFUShgpSThwvfknYuh?=
 =?us-ascii?Q?xv6k26mqwBWjH1gZIq99EtntEVv2pJYlkq34ALAjTVxJttzT7H8J6RilBVCE?=
 =?us-ascii?Q?bKmRtbV7n+MP7gu6MAxCY7pgpu6VuCX/o9+kq+KOc+V6bDqLsjiD5NVOk3k6?=
 =?us-ascii?Q?VfUqMEZm46hMm53yOHoukNHC7tuH3rz5iXCwjpnwEMUg4hnulW/rB+aDRIuB?=
 =?us-ascii?Q?ScpdEi+sIfqwR3hhiSQT1XE1yerUNI/Ry1d/P22u8DdHRYQ2LNmHAHR/Onxm?=
 =?us-ascii?Q?cLakJ2DrC5XXjzmPETEspGIu2LoEvt6HjpeEvPhTccoy43Nd8mHxaqnd4H+l?=
 =?us-ascii?Q?0SKn+zCVf7/VY3nQWE69q2SowfZ0BC3PWg+1oVVJg9KzUkWpmooioHx0Qz3k?=
 =?us-ascii?Q?MTn7q64T82pDB5LRZ57uWZmoaAwGZe0zcuNhb1AQY8YfUpKz2hdtc2q9R/xO?=
 =?us-ascii?Q?WP95RQSFH6NqhM1TYQdjuLPqe+7Dn23tmOgJb4kgjJMMZeHRLIsnyUAZH2Yz?=
 =?us-ascii?Q?Q9yEZAe0ZRK84cJm9rW4uAyPXPlc1d/4BYGhQPkPNS/MtMOofsXsoOhEa3wP?=
 =?us-ascii?Q?QhnUcZh9SmRhhP73xJdaRq8NDduzruKRSpJDDXegHg+CweN7KWQ+G7I150+I?=
 =?us-ascii?Q?aTdEfN1SQ6GAQGWmh4+7KVnIbisnaBX053p2ETkojSAxBIfzFLtOqGN2EYnP?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7beff52d-8d2e-40f3-3838-08dacd6712a1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:26:20.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fx09F1P3enD9QgL1aX8EmGaUXZIEdwDzS2sstR83W2Iv7qR4ANEBigg37v5zjYW3copDMNfb7Ik+nIrEnNmsFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6702
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2022-11-23 at 16:05:14 +0100, Peter Zijlstra wrote:
> On Sat, Nov 19, 2022 at 10:45:54AM +0800, Pengfei Xu wrote:
> 
> > The result shows that your additional patch fixed this issue!
> > If possible, could you add Reported-and-tested-by tag from me.
> 
> After talking with Marco for a bit the patch now looks like the below.
> I've tentatively retained your tested-by, except of course, you haven't.
> 
> If I could bother you once more to test the branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/urgent
> 
  Yes, sure, it's my pleasure! I will clone and test the origin/perf/urgent
  branch in this repo and update the email soon.
  git clone git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git time
  out in my side, and I git cloned https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git,
  it should be the same repo.

  Thanks!
  BR.

> ---
> Subject: perf: Consider OS filter fail
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Sat, 19 Nov 2022 10:45:54 +0800
> 
> Some PMUs (notably the traditional hardware kind) have boundary issues
> with the OS filter. Specifically, it is possible for
> perf_event_attr::exclude_kernel=1 events to trigger in-kernel due to
> SKID or errata.
> 
> This can upset the sigtrap logic some and trigger the WARN.
> 
> However, if this invalid sample is the first we must not loose the
> SIGTRAP, OTOH if it is the second, it must not override the
> pending_addr with an invalid one.
> 
> Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lkml.kernel.org/r/Y3hDYiXwRnJr8RYG@xpf.sh.intel.com
> ---
>  kernel/events/core.c |   24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9273,6 +9273,19 @@ int perf_event_account_interrupt(struct
>  	return __perf_event_account_interrupt(event, 1);
>  }
>  
> +static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
> +{
> +	/*
> +	 * Due to interrupt latency (AKA "skid"), we may enter the
> +	 * kernel before taking an overflow, even if the PMU is only
> +	 * counting user events.
> +	 */
> +	if (event->attr.exclude_kernel && !user_mode(regs))
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * Generic event overflow handling, sampling.
>   */
> @@ -9306,6 +9319,13 @@ static int __perf_event_overflow(struct
>  	}
>  
>  	if (event->attr.sigtrap) {
> +		/*
> +		 * The desired behaviour of sigtrap vs invalid samples is a bit
> +		 * tricky; on the one hand, one should not loose the SIGTRAP if
> +		 * it is the first event, on the other hand, we should also not
> +		 * trigger the WARN or override the data address.
> +		 */
> +		bool valid_sample = sample_is_allowed(event, regs);
>  		unsigned int pending_id = 1;
>  
>  		if (regs)
> @@ -9313,7 +9333,7 @@ static int __perf_event_overflow(struct
>  		if (!event->pending_sigtrap) {
>  			event->pending_sigtrap = pending_id;
>  			local_inc(&event->ctx->nr_pending);
> -		} else if (event->attr.exclude_kernel) {
> +		} else if (event->attr.exclude_kernel && valid_sample) {
>  			/*
>  			 * Should not be able to return to user space without
>  			 * consuming pending_sigtrap; with exceptions:
> @@ -9330,7 +9350,7 @@ static int __perf_event_overflow(struct
>  		}
>  
>  		event->pending_addr = 0;
> -		if (data->sample_flags & PERF_SAMPLE_ADDR)
> +		if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
>  			event->pending_addr = data->addr;
>  		irq_work_queue(&event->pending_irq);
>  	}
