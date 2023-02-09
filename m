Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2A96909B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBINRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBINRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:17:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61E22D7B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675948660; x=1707484660;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=49LA9jDcxsJaF4ieP04JhJZtpaqbAa5/i2jxA9qC3Xo=;
  b=CnkjcPLaQeYsgeBE9BG5s7y01JLjrCTQz9GIlAAT82wBWhePISTGYH0S
   U+mvnGvrAiGLBqDHgDosmZK9/UxlQmzNsXYGOgu6yhmqEO9zDaGqS4t9C
   sRKiFQV78WKT8IwJatxfTr58bKWtvTeE9Omkmcvzo2u0ty50mV0K/J2TL
   XEjdnx9vrp0WI5KPU8z5K9UE5Nuc+dD19UX+hWYonYLmBMlaoQtMs8aTW
   nPMFBNEo+5KLmp+FxDJACgayrChz4fIs4yUMcjcmgJ39aPhIMGLKYFZAx
   /shL6/29/Q86NigHvkVHCk8GxF4H2KFutgtztLbvn2Ps2CS6xLLZvQP5C
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394688479"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="394688479"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 05:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="756398887"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="756398887"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Feb 2023 05:17:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 05:17:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 05:17:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 05:17:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 05:17:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAuF9fSq5tfvOjXoAhuSCruM0VGE7BmyWArs6IuQXoiHC74f5ASEyqjoIdCddIKZUtfnkP6W8qnFZ89PrnqTux5KRtpilIosH2t/lbZm0Ly/JWXy4z/F2/zfawnQ/PW20LXiHTcEb+kdvaMFK191tdK/5TIAvwnviHG2WB/++fKUn1bmXuOHIOmLbOfuNxXe7VMzXQ7WLS8G6yvO3j0S0HwWZP2s2TMJSG+LNbAUlNQP/SaqF73xjDSvoC0goa7IiQ750ZvElm/UQJ0ZNLml9iWfQwchSObt6fj9zKmsIFZdVKkqcmy0UMgOcOc9L4OvHQdjP0GaAVib+L3xAqar3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KZn3uRNIM3anmW0hUk8Fb4YmxlSUt1bWtJztN4ZTec=;
 b=QSxyClzem2poZxd/p9tA9u4IY2V5gOCckYwl2OxMkE3WseYeZO8+RByjM9OYXJoM5d441qduMjb9Qp/oTt8TDGJgRYOUeuJC5dxnjeuAdp5yNv5M5oXB2JdKAzvIwBq13EGOdv+YYUNBMtBbNs2/L1Sgx8zgxyy6cbgtjmLZDrOkSkgEwB4U7dssu9R5/jd69/ElNG3dEETcH37Dn5kEYAYTwR6nFoQPq4bKH/ysfkHOCvIcn2bgdgcKAug0e4OtlfsXcx8ZvKnEpPyVJJHoBR5Cy0sb+HGi0ezDHzlVFLPmc2Sv2C+VOsKoxMbNWtdjMdr7CCLtE4daKGPikK36yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 13:17:25 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 13:17:25 +0000
Date:   Thu, 9 Feb 2023 21:17:05 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Message-ID: <Y+TyUZg86LYhtWeJ@chenyu5-mobl1>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5fa6c0-bdad-4c94-d959-08db0a9ffc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlFngzALzsr6ZyIWgvFP5At4sjUoK0q/l+st+rcVWGX7FE1YK9KuEZBAa3Eg8JCFZzsDbLiGIRXqdxpGonYwHGChZfMUjZ/uz9G3aVPowxmdD7KuX+2tyA6od/KV0r53tE8TK2Ad3i0aHqf0I67C/AzIUks+jwxRq1RvWn/yC3Ovj41YRr24nLxNge4d8Jt3iec7XPYbOvagNKQGYEKwbmFS1edlJOQl08NVj4lbzxlbGk0rysPsVGKBU2s0Zdy+DLLop6E6MIXgPZEOnPGhoSZXzj5eE4d8vbk1J1pi0YGtizuEUgY5Nl9rtTlOZIY/zW61cYHuHXodHBIi0shfBIK+zsGWFaZN1DU/7EqfgnVdrYmNsJU2ErOntRg0Z/8peYqtUl2oUUBmEYbVFthiY8o1YVxMS0O0KHdtvDueqzQy3hE7Jg5RlHEiIGKwOWmW6K92NPSiHcsKHGWl+pqNz6vqUj+///648WUvMEEOBKvcwsoTSITF5bxlDvae4AiWpQZJ6S988OyWs1a4lu3GTVfvO18jOGfIgjj3wKcH3B7EjCYgfQ/lZQE4oO1I98OYPZVQDD/X/wXsicNeK3tK32MVHiUoIpPhGMtzteW4dJDAQHfjeZtyeXgs+Fjg/epT/L3nanxWT1J+29rBMFXArS30e1vdA1jMwzoq9u5p8CSyC8PKtkcE4OJZamE2SpYn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199018)(316002)(8676002)(33716001)(66476007)(8936002)(66946007)(6916009)(66556008)(186003)(41300700001)(4326008)(54906003)(5660300002)(86362001)(82960400001)(38100700002)(6512007)(9686003)(6666004)(26005)(6506007)(2906002)(53546011)(478600001)(7416002)(6486002)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2c1ginA8ZI8P/wof/ewa8h6SBBWBBgXW4+FZTSc8bXAaIAFH9fVVXAuMXRK/?=
 =?us-ascii?Q?sHc4WucT2weFzCYZ8eYXCr3IBSJUuWKp0fnCgnPnTzn4r4ku0bY39omxdvv5?=
 =?us-ascii?Q?C0rejmrNBpt09Ww7UO49036EtoQEVKMwIhf6wT2LzQOsSh863LMw9jm4Apho?=
 =?us-ascii?Q?dbPUPi11P35Cm1vVcX1kxn7UWkNCsUXKfmPsV3t4Zxqy02t1pWZfHSymddav?=
 =?us-ascii?Q?adNDoVoCSQfkbTpi6LoGLiONd3AKckk6Ya3LJEXTaAeZovIL3UoGxOMCqr9l?=
 =?us-ascii?Q?rESxoeQWPenHo9k3h8iCnL/cChnfTx05wmD/aluFlbgENaP+UtEStfjA1jru?=
 =?us-ascii?Q?gh7DlFqMIg3O0RMcZMmASNq3PS51rXa7gTWGilFLBDEZVa2yD0pECc4tS6wV?=
 =?us-ascii?Q?mZ8tB3kAn9FDLipAaHJL9KP7/YaSAz/z6BpAivCC677ZyN+GM4m9dsYFhsAO?=
 =?us-ascii?Q?hKqVwL2jDHxM+PuL1B/snji6dd2WiDR+7b6LchvrrvFtnoY5jb1LZ2wxslKe?=
 =?us-ascii?Q?ez1DvZJoGyz5OZEiojLYGSJPZA3MqvA/V+QiGFzWTiv++iCbBEjQvx6hUVT5?=
 =?us-ascii?Q?XjnV1HApNuxig7Tkl1VlhP+5GvuR2miBNoa790S+WyNTFhc6bMk/W1rTQnf/?=
 =?us-ascii?Q?me2LziYVhtuom/3A6PLj1G1ZhTOK9FKpruA3udJxBm/eWjWQqPMofXf2ee0O?=
 =?us-ascii?Q?BW+p+ur+qdul39WwswZeEZsosKXN8ZsPdNjHSJjUYc6kiGCU3oNBIjtjEHUB?=
 =?us-ascii?Q?cefMf5SaG916ekTYBTTMZ+L8StPHC8K6JMw+4n4tUd0CXfe/E5IBSR7NbFqM?=
 =?us-ascii?Q?TSxMCh2c36UmciyvqQjj2j0AwSkL3h4iUUS6ZtR6771vjMBubyqoa6bqTNBc?=
 =?us-ascii?Q?ctANIF8t9bCShsJvnmBFxOdBlZ/wwWY5z3J3SpC98IWYT9hpkVfMhsLtls6c?=
 =?us-ascii?Q?XLB8WXgWG3nSD4hKJINIs0+WRlxadP4389QUWm6rCdTc0UI1PEgEHEMtzO77?=
 =?us-ascii?Q?X4ixA9K56b6/vjei4Ckc5PUZVZBMelwdxqcGyzBKGA1rgI7ovmHe3HnP6k93?=
 =?us-ascii?Q?Ezv5j3ysXdAPzdXvMQZIeJRqa2hCjFDmVIxzpjdRzOQgjkHzjfQZOzbXR7tk?=
 =?us-ascii?Q?cjuq13GbrCnydGnEXtgbXw3tsOQZVVtWrmSR1Fg3n+kACsA6wGyc1pC/MWu0?=
 =?us-ascii?Q?6QyikV8jT01coQD1wyXkZJ9dwD9npenm1/TO28KA8C5TCnHb4Si9fMwMsrZ1?=
 =?us-ascii?Q?MfJ8VAnSSdiX+JsLd6ThOFNeuwPzv4jAWGsNkdDEaIAVOdJgCErEnw6g6JCY?=
 =?us-ascii?Q?r1JlwUjGN5L2R/uWbKwk2ScOE3sotGlhmV1ZCvPTtDCUTjMnYHkWBP1iMqKM?=
 =?us-ascii?Q?xB5HbqBmLcUtY1e9tdqwkO21l6+liWp6DBIOKRS5gaBouQmF8ES3A/qQWaI2?=
 =?us-ascii?Q?VovvfAm8w6vYhOJlh6n1kaqiNevagB6FTSeZJoicSj9Pih6yNJre6TNa+Ch7?=
 =?us-ascii?Q?vO3lp9B4h9JpdRZFWSNRwOulrjAxmfaaTVDzGaCTpNYEGRKsapKDS8k8LXw8?=
 =?us-ascii?Q?jORlceAQcd2nZDN0oh2y0G06emYZSW+MNvoAH3nm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5fa6c0-bdad-4c94-d959-08db0a9ffc2a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 13:17:25.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxD0OuveyPihvrOI6e5FjILbcQ3z8D2+6oI9nUetfMNGm9oSeAVldNOEgUSGswKh0FYL5whCdXKeRoR/sE82rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-06 at 20:58:34 -0800, Ricardo Neri wrote:
> SD_PREFER_SIBLING is set from the SMT scheduling domain up to the first
> non-NUMA domain (the exception is systems with SD_ASYM_CPUCAPACITY).
> 
> Above the SMT sched domain, all domains have a child. The SD_PREFER_
> SIBLING is honored always regardless of the scheduling domain at which the
> load balance takes place.
> 
> There are cases, however, in which the busiest CPU's sched domain has
> child but the destination CPU's does not. Consider, for instance a non-SMT
> core (or an SMT core with only one online sibling) doing load balance with
> an SMT core at the MC level. SD_PREFER_SIBLING will not be honored. We are
> left with a fully busy SMT core and an idle non-SMT core.
> 
> Avoid inconsistent behavior. Use the prefer_sibling behavior at the current
> scheduling domain, not its child.
> 
> The NUMA sched domain does not have the SD_PREFER_SIBLING flag. Thus, we
> will not spread load among NUMA sched groups, as desired.
> 
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  * Introduced this patch.
> 
> Changes since v1:
>  * N/A
> ---
>  kernel/sched/fair.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df7bcbf634a8..a37ad59f20ea 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10004,7 +10004,6 @@ static void update_idle_cpu_scan(struct lb_env *env,
>  
>  static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
>  {
> -	struct sched_domain *child = env->sd->child;
>  	struct sched_group *sg = env->sd->groups;
>  	struct sg_lb_stats *local = &sds->local_stat;
>  	struct sg_lb_stats tmp_sgs;
> @@ -10045,9 +10044,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		sg = sg->next;
>  	} while (sg != env->sd->groups);
>  
> -	/* Tag domain that child domain prefers tasks go to siblings first */
> -	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
> -
> +	/*
> +	 * Tag domain that @env::sd prefers to spread excess tasks among
> +	 * sibling sched groups.
> +	 */
> +	sds->prefer_sibling = env->sd->flags & SD_PREFER_SIBLING;
>
This does help fix the issue that non-SMT core fails to pull task from busy SMT-cores.
And it also semantically changes the definination of prefer sibling. Do we also
need to change this:
        if ((sd->flags & SD_ASYM_CPUCAPACITY) && sd->child)
                sd->child->flags &= ~SD_PREFER_SIBLING;
might be:
        if ((sd->flags & SD_ASYM_CPUCAPACITY))
                sd->flags &= ~SD_PREFER_SIBLING;

thanks,
Chenyu

> 
