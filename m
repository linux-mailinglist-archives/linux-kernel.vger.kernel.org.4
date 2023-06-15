Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87678730EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbjFOGB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbjFOGBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:01:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69632716
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgA7GVDmXhjgMH0cTtOpRTcN5ZmKw6QkpZFlOR6SWKi459z8MzXJ5YUOUhZI+gichFlwmkIX7xrUsNPUW5BJjTpp8a1mev3VreF39MTLSP/JqYjeCrmTLOlpbItri5/6qpS/CvuPM/N46kd5ivjNPeIfM4r4Vr30LcrbgI7ECgKu/9Vr4rEOBSb2nes4uaDUqGJYlsRkdOkPVBEW1BOc4OAmhlZm5r8cFciZVNB9vekAKr3IYlOj+ajSW1eWRZOQkIxNLolacrzrxWKVsVWwPK+3+CH7RjD0QM0P3gN7GQErTcR62TlJV8s2tv8InA8eEUD8siooZNd31q6LW5GRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEpzXGb1ihXuEKLV+C4YY3KbOcBCRhLUw5MNmOKGiCM=;
 b=GAJ3lfYjCiJpn/3V0ZgnZr0Nmk9nIIrBHrTyyQUggSBsSWGvZHPS1X1wJNrCY4RYwxyWVYq4Ba6HdtQ+2teLxb5ecLkf1EqVCg8TvQ9au2XBR5VDdf6uRZ3CM4PmQAnOktRbt8VQP+Yuj8bcOM2mc4MUSky5VdheOesGSfWeetEp6akp6ZTdK4YySkBNI5msvb//wAKRKU9dpiBwV2rqUb5L8C7xGJDk7BwfG29nipImucKG4gb4FF0il/oyCq8T/XRFC2s7OdNOnMLdrm0uPlymRf9eLD9nHo8q3jIRf6XC2kRRPKFJqh65X7ZVnarlmcT1PrzhKqFdcYJSZawZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEpzXGb1ihXuEKLV+C4YY3KbOcBCRhLUw5MNmOKGiCM=;
 b=gCyp2IBeja7xUzgfhkQCVxwBscxxes0i3M4BchbWEkQTQHKuY4JUkvWbBK3NvWxEu8fPm9Gk3jkvoqscj97btTeec6hhHNPGKiJ/uihv/oXTYEUg2K/d3rNo2aDQ3ui7CcXDi5wMlxeBBAdxiiqMfZsKFsdwnnvaSGpf+nApct4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 06:01:20 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1%4]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 06:01:20 +0000
Date:   Thu, 15 Jun 2023 11:31:07 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Message-ID: <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
X-ClientProxiedBy: PN3PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::16) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 7777817f-851d-4ab6-3d86-08db6d65f0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqUdL8v/U823vOfFzwicOiBDBVSdnYOJ38AmypU9yj34l9hDOqEfqu6iNVlQ29MV2RAFP7E/eaOgjY/DxwYhAA2ophrkcxGwwpKZHZDLM4ZMm+FTlT4WVZiW9TByTGFQFIu3/FehW9WDS/ZnvFmasup9+JDQiFyf9w/+Cuo4+HEmF5ip9qXHzOaRnjHcmFPACWuChnzOI6DoQLu4GF51EAJPPmrzn9LLjlFZfqims1/Lr9FzEKYzb/xsLJ4kzgCLpEqhRdpMTOwSoyZ+PqyC0jI8NxZHkdj4LZ1ClF/Z8UF+KRO5nLZcvfr61cz1mdBbwWw3nVlfvlvK+lf6OEeCQcOuSeAVxr8tXJchSA/MNIQ7D8OsiyoNelqhv9rGKbtQ+T8IHWnGaI2eRgdVIE1wXwFntODraulW9Ju51ePTmnPQcmniwg8dGASkQrg2inbAOUeXsdX8f9pV2hyOXYoirEBP572f7MLN6A4ozncIgN9D6s6vonRZWuqsvvN/M7OqMVRyFcqGssNDipmBtpfETQefWLgLrhEYHvGe6CnaNYoudeGVyGVGfc4gTpLIwNX+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(41300700001)(5660300002)(7416002)(8676002)(8936002)(2906002)(478600001)(86362001)(26005)(6512007)(6506007)(83380400001)(6486002)(6666004)(38100700002)(6916009)(4326008)(66946007)(66556008)(66476007)(316002)(186003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/TiUSBNZDq7tAbalS+g3PA4kPTclbfeDFTsplhVZB2XxghPPU+UOgN780Hdk?=
 =?us-ascii?Q?Q6yMVWQBbV9mvCa7N2hnRkCoX7mog9pGNj4agOPahdRJLJG/w37xg/QZPmc+?=
 =?us-ascii?Q?srdEWhEdc/TNVFrLiEMIE+3RkkSUk3+OxRuikaDrP52e5fdIF2Peri2k3/8b?=
 =?us-ascii?Q?Jvxkz9iKVcr6EnJ7tYISM4lWaefu47LGyorVJzs7v3kA35OurG6G7/3/OBb2?=
 =?us-ascii?Q?pI9tANfd2rc8G/dxkITRvA2WY4k8dm7Q9RrVyTVF+A45lIhFLKab3Xziy3RQ?=
 =?us-ascii?Q?DK/j3+BC1n7dcuax7EkZq9/MhgSUQkqoLkihre78qeYsp93fkYbRiOD0we+w?=
 =?us-ascii?Q?bWeE7Op9bTjnYmQpugjT/XvGl500uP0RW1YrSwowB6vPw0WkX0DEE8Q73aIb?=
 =?us-ascii?Q?wjR76iRz+Qxzxr/vb07gtjfoIhjO+0EU87AlmJek5hEQIgKxAGmz9qKYiRdp?=
 =?us-ascii?Q?WT/cKZ0T9tcgGy+EMOmXsnD7Ea6mrFKNkyJAXNLZi6brSZskpBaH+bgkOZnO?=
 =?us-ascii?Q?p9+88K96pXrOy0Ze2JLo+u1I3qoacMDZy1y+/4a/9QAQpRNi+FsGJ+HFe6PM?=
 =?us-ascii?Q?4Hu73OUbGMFTHeGUm/uOBRAwW0imgrl+YNVH69GgGwqKX8kE7oaEHbockwuc?=
 =?us-ascii?Q?Dy/0JA9QediSfzJQPOZ1LSLVL1F0jnsaKbSoFGdqjrTgs5bMlu6l/eYBakzd?=
 =?us-ascii?Q?uXymqMFyHnDQlKJxgnHufn42A0DANG67oif8cP8A9xulatkctL3BzI07haKJ?=
 =?us-ascii?Q?W2cHq3HKJEYYBVBJRmbLv751kYHVIj2pVm7+jeSExXT5wqd2oyzQlUcluWow?=
 =?us-ascii?Q?ub6QZO9+LbFrUE4W8m1t+w2pcZIeiNSz09FJbA1RbpaGLVIAa3Vhs5bxlCvv?=
 =?us-ascii?Q?KW1mEOBRVHcoF9+4o5p2FjY623xizumhfYFVoQOWQfcCyMmKmtynqPvrPpwQ?=
 =?us-ascii?Q?AkgBVDZvsLJnz9J71MnJkCzzxHrZq8gDrudXBvgSdtTykpcIr61zEFox/W+e?=
 =?us-ascii?Q?hGmwwPmmH2AG3VAEsCr0A9Dxd8RBu+igk91XaPbvlHdNeIhqlRzU5gSqGHNt?=
 =?us-ascii?Q?jVGoV9iEKGLwT0QVtDm1sgnEIsfrZGQiJYztgsPzL65Jx9xwqckPsy0lQNuW?=
 =?us-ascii?Q?ywXlKcM9NNwm/+oa5AOgcK9CSjz2pK7PT3CQlTHA0fqDkNHPoLy2jAvJxYKE?=
 =?us-ascii?Q?8jTImle/A0XFjKoH/9sjWvhiKvh5xT5+ebtd2Dzvyo5LQWUKYrKuifVGh/DU?=
 =?us-ascii?Q?Dhqt6F0eMYkIE4SisvDIHG/jdMF/ftpbjRDn4ORvUfrQl6jFq4NI9QCra3lE?=
 =?us-ascii?Q?jl4bWy2cV23ega3QHyAgy++TolrfMRbcJTBW9njw14blmkb7p8PMMi25ef5N?=
 =?us-ascii?Q?TbaBdmetR/CYBxux4Bizqka0w/8ldcqQh7fUs2qFS5l/rwtHMYsf2jyrmzcv?=
 =?us-ascii?Q?VeZ3nD99YRlJZzd7yXh5XU/w7Zj1bl258kObVwZx2hAvKjOeTDwAfI7wDkHo?=
 =?us-ascii?Q?O4FxD7nJRrESxTlU43ELXv6ldT5HSXcfydGwRyxB/6HCFpSZTje+k/b/PFSM?=
 =?us-ascii?Q?DUELZRJGbjSQihW5i19rHJsH23A/tD88ZT5N3oih?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7777817f-851d-4ab6-3d86-08db6d65f0dd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 06:01:20.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jew0C89RfpKHWr3zqq4LiuXVVzwwrs1t5S29p/2QF6wu24K+szp62meuRKx1/X5zwf1WjsG8WecjdIlfcAZs9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen Yu,


On Tue, Jun 13, 2023 at 12:18:57AM +0800, Chen Yu wrote:
> When CPU is about to enter idle, it invokes newidle_balance() to pull
> some tasks from other runqueues. Although there is per domain
> max_newidle_lb_cost to throttle the newidle_balance(), it would be
> good to further limit the scan based on overall system utilization.
> The reason is that there is no limitation for newidle_balance() to
> launch this balance simultaneously on multiple CPUs. Since each
> newidle_balance() has to traverse all the CPUs to calculate the
> statistics one by one, this total time cost on newidle_balance()
> could be O(n^2). This is not good for performance or power saving.
> 
> For example, sqlite has spent quite some time on newidle balance()
> on Intel Sapphire Rapids, which has 2 x 56C/112T = 224 CPUs:
> 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
> 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
> 
> Based on this observation, limit the scan depth of newidle_balance()
> by considering the utilization of the LLC domain. Let the number of
> scanned groups be a linear function of the utilization ratio:
>

Is there any particular reason why this is being limited only to the
LLC domain ?

On architectures where the LLC domain may not be so large (POWER9/10,
AMD), the additional cost is usually paid at the higher domains where
the number of groups is greater / equal to the number of groups in the
LLC domain and where sd_span is pretty large. It would be good to
explore avoiding the scan cost on those domains as well, right?

> nr_groups_to_scan = nr_groups * (1 - util_ratio)

If we can extend this logic to higher domains, on a Zen3 1 Socket
server with 128 CPUs at the DIE domain containing 8 groups, we can
expect a significant reduction in the time spent doing
update_sg_lb_stats() at higher utilizations.

util_ratio     nr_groups_to_scan        nr_cpus_scanned
========================================================
0.9              1                       16     (-87.5%)
0.75             2                       32     (-75%)
0.5              4                       64     (-50%)
0.25             6                       96     (-25%)
0.1              7                      112     (-12.5%) 


On a Zen 4 1 socket server with 192 CPUs at the DIE domain containing
12 groups, values will be:

util_ratio     nr_groups_to_scan        nr_cpus_scanned
========================================================
0.9              1                       16     (-91%)
0.75             3                       48     (-75%)
0.5              6                       96     (-50%)
0.25             9                      144     (-25%)
0.1             10                      160     (-16.7%)

> 
> Besides, save the total_load, total_capacity of the current
> sched domain in each periodic load balance. This statistic
> can be reused later by CPU_NEWLY_IDLE load balance if it quits
> the scan earlier. Introduce a sched feature ILB_UTIL to
> control this.
> 
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  include/linux/sched/topology.h |  4 ++++
>  kernel/sched/fair.c            | 34 ++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h        |  1 +
>  3 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 1faececd5694..d7b2bac9bdf3 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -82,6 +82,10 @@ struct sched_domain_shared {
>  	atomic_t	nr_busy_cpus;
>  	int		has_idle_cores;
>  	int		nr_idle_scan;
> +	/* ilb scan depth and load balance statistic snapshot */
> +	int		ilb_nr_scan;
> +	unsigned long ilb_total_load;
> +	unsigned long ilb_total_capacity;
>  };
>  
>  struct sched_domain {
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b3a24aead848..f999e838114e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10122,6 +10122,39 @@ static void update_idle_cpu_scan(struct lb_env *env,
>  		WRITE_ONCE(sd_share->nr_idle_scan, (int)y);
>  }
>  
> +static void update_ilb_group_scan(struct lb_env *env,
> +				  unsigned long sum_util,
> +				  struct sched_domain_shared *sd_share,
> +				  struct sd_lb_stats *sds)
> +{
> +	u64 tmp, nr_scan;
> +
> +	if (!sched_feat(ILB_UTIL) || env->idle == CPU_NEWLY_IDLE)
> +		return;
> +
> +	if (!sd_share)
> +		return;
> +	/*
> +	 * Limit the newidle balance scan depth based on overall system
> +	 * utilization:
> +	 * nr_groups_scan = nr_groups * (1 - util_ratio)
> +	 * and util_ratio = sum_util / (sd_weight * SCHED_CAPACITY_SCALE)
> +	 */
> +	nr_scan = env->sd->nr_groups * sum_util;
> +	tmp = env->sd->span_weight * SCHED_CAPACITY_SCALE;
> +	do_div(nr_scan, tmp);
> +	nr_scan = env->sd->nr_groups - nr_scan;
> +	if ((int)nr_scan != sd_share->ilb_nr_scan)
> +		WRITE_ONCE(sd_share->ilb_nr_scan, (int)nr_scan);
> +
> +	/* Also save the statistic snapshot of the periodic load balance */
> +	if (sds->total_load != sd_share->ilb_total_load)
> +		WRITE_ONCE(sd_share->ilb_total_load, sds->total_load);
> +
> +	if (sds->total_capacity != sd_share->ilb_total_capacity)
> +		WRITE_ONCE(sd_share->ilb_total_capacity, sds->total_capacity);
> +}
> +
>  /**
>   * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -10200,6 +10233,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	}
>  
>  	update_idle_cpu_scan(env, sum_util, sd_share);
> +	update_ilb_group_scan(env, sum_util, sd_share, sds);
>  }
>  
>  /**
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c76bd3..8f6e5b08408d 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -85,6 +85,7 @@ SCHED_FEAT(RT_PUSH_IPI, true)
>  
>  SCHED_FEAT(RT_RUNTIME_SHARE, false)
>  SCHED_FEAT(LB_MIN, false)
> +SCHED_FEAT(ILB_UTIL, true)
>  SCHED_FEAT(ATTACH_AGE_LOAD, true)
>  
>  SCHED_FEAT(WA_IDLE, true)
> -- 
> 2.25.1
> 
