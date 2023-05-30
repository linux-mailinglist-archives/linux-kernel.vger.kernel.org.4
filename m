Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352797157F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjE3IG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjE3IGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:06:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B02D193
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nfg+50offH1kccf0127udae/wXg7ho7s2vxMWwTX93tBvhdhxA/guMoIwTrWsEUdFBLOz7Yqz2rjSjVD0pHCxU9QxAFWwB9l4mb07AvuughMQKkgX778lJn2zSKcW193KP96uzlHCnrRD1E62cKgAR1qo3wppEJ8Yz6qqtSW875aw574dcIqISKES9Ax8EBXM7B+VF7Wy9m+VnvmtRpwarS8LrDErRi1kyNOG+IRr83IR5ns8qjPfe8uX5++/Rf2XaLanL1V6/x8ROkvz6OtwKs630wle38+BKW+L4zdnWilSgDV8wYf5CCAO/LgEQ86VGW0FeexGKmuLeLS8A3nYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpF6BRKANr4y15G8eLXjOgDX4JPMTqUVGpQtqHqWb6c=;
 b=UkIocGuU40EVQTDA550K46atlNxmAVsxfMI0IlZ0ni898XEU5me4EBnaxRiiA6fDoPlqi0kslnalk7Ny2+HlEybS6BYAVipDXuto3Tur/hX3iLSuZhWdBApJShbwIbMZmPXcMCNAOn9B9yhfHJtZ834EyYAim+Xgda1U47IJojwA5ok44MEYI4FwYqBYPrU+z4WGzY63RN49BHTkt4rshJxezVFNTiy+KWzGPAwNkEiVIQ4mWdI0WgczQtWWgbZvG3sV5GM2qXUdngrbbgp0HFEzXA27XRYu9UozwYnAPazQP/TzRLv7fvCALQ48p74G2j6WttTvZWkqVUtJu8FgAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpF6BRKANr4y15G8eLXjOgDX4JPMTqUVGpQtqHqWb6c=;
 b=2LMP0FmkwN0TdQXfFPMr/U/EVisdudwfrgPNk3w8AH98wtcqXcbsJdpvMP2WcM+W2KMZ0OGImBbXqr+o5opJNu8QWG4JyqaDiK6YBRIiuYMJE+9E1lMSd4fy11WxN6Qh5c47qFvFn6zeVL6qSuBoLTUmG8qvxhWqSaQ5W74ByEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 08:06:24 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 08:06:24 +0000
Message-ID: <30625cdd-4d61-594b-8db9-6816b017dde3@amd.com>
Date:   Tue, 30 May 2023 13:36:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230519001709.2563-15-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 990eefe4-c1fc-4eb6-10c8-08db60e4c26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oibfGuqIucc+Wb+khK6y0bukef/+OY24bN6jUkCMSjTQ4QwU9FdUtoNECNZSKB2PGd8HqpckaxBt35G2vzUOL4gASK0BSQD47josoMlmiK2ygnW4V0OiLo1OlV/gCp/zasOE9DIhUDKJ9GiOgJwGXc9z8OMGUkYQzjuDfPMO+vR6tw2+WaLGwWVE4TVYTGJmNvcV0Qr9fA8rh6FmXnFRTA1ja9Vi1pkZWtXpZpVaehAa9U0SWvrXYJd1S2jrGe5+O6Yhu368mW6wGROVJ7exZ92B63jbfb0U3OqbSiWqjY12P1Y7RbU3WcKPcBeDMsLm1JzX4ItMWvqxAJ7b2zFX/ZsoggQOs/PW4E2v5QhfPok5Yvtuvv3WOAQfYssAIS0k7zCA+s4YZYQXuHiMyCOq4jXygtIXcc23+TsTQceq3+8pfXN6n68zdzH3519Pcxq1QiTfePhLgxPhwmnrm+w6YwyLBRM8JYP0BUedULbzl7qNJca7jexc+T14QU2pnMkOZii9BDGsAeYZQ62ngQ1alj2t6ojw1cPFJP13iYbMxD6+4I7H+Ny1GW8jnlsDR77pbJ6CkVgYOxP3CSKCUDrze37IXzcfZyXWOe4WwmwfmEGeJa96AOeRuS3hlgsYeYDGe5j+5CLZTGCHcLnjPEsWzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(31686004)(478600001)(45080400002)(38100700002)(86362001)(66946007)(66556008)(2616005)(83380400001)(66476007)(31696002)(4326008)(30864003)(2906002)(6666004)(6512007)(53546011)(6486002)(186003)(26005)(316002)(6506007)(41300700001)(7416002)(36756003)(5660300002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djZZaE5MUjN0T3pDaE82azJEbWM4WFhGZWt6Y3M3T0lXQUk5Z25SWjIxTGgz?=
 =?utf-8?B?U0p4c0RKbDNnOWhPakR3ZnJFS2FCdUpQcGwxelRYaURYVnlaTDAxdHE5R3Jw?=
 =?utf-8?B?QmlGQnhxaldsU2FvZDZMc3FNbExHM1VyZ1JlVXVuWG01UDFIQmJ2UC82dDJk?=
 =?utf-8?B?c0FibHJPcUcxanZRYWhwTDViaUl5L2hGV2F6NzFsMjBSU1VRdy84MTdybjBv?=
 =?utf-8?B?OG94enYvS3FDaVlVaUVDampZc0pxZ0NzZ3MrUHlKZ0pVd050anFCVGdDcTFx?=
 =?utf-8?B?b3EyRUF1L0EzMHEvSFUyL1U2S21sdlhnZEJPdnFiK3Zab0J1MXVnY0hoRFU1?=
 =?utf-8?B?U0srL092blIwVzZQdFVRb3N1dnNTMUtvMHZ4SUxJMzEvMGZTMFdqS0pkUzRk?=
 =?utf-8?B?T2ZobWZ5Q2ZvV3Z4UkJPeTBiMDNGRUQvOVF1LzZpdTFTUVI0VFpkYmlqNWVa?=
 =?utf-8?B?OWhPR1RNcGZ0aC9YbTdtOVc2RThtZkpKQXZDaDJKbzdxQ0NuSFdHZmlTQkQ0?=
 =?utf-8?B?RW0xbnpnaTJERGo0SDNKNEJnc200aDIyOUlQVzRQMHI2V25maWgyZ2xTekRU?=
 =?utf-8?B?dFNuREswZ2RMRVdNQnk0YjY0UktSdDVhcUZpazAvM0NjaG9qd1VRWVRCSmxO?=
 =?utf-8?B?akppb1hhMm94SzB0MFFDK21ia05QQ2JxdjFOL3V2V3hXT2dQWml6YXZUSDNY?=
 =?utf-8?B?L3hySWlGMWNMQldhUG1iend2amhHTHh6cVFhNThEc1dieEdxQm5VMjJwQ00r?=
 =?utf-8?B?SVJmTkpseWtEUjRSbGI2bHl1RG95K2UyQ0l4anBaNk1nNk40V3lZZHRMTEts?=
 =?utf-8?B?T2ZOMjJkYlJEL2M1eThtMkJsaUZrOStlWlR5VldtQ0J2ckNUSFBiemxGRmNL?=
 =?utf-8?B?ZzRySFZIMXRpblVXdlZKa3FhQ3YxaEgyRTNDWjZZVXhzTmJxQzMzY254a1Nm?=
 =?utf-8?B?RllhbUJHSjAxeEdQRkFPYVlmVDBrWEhrVmVxMElpN0x5cW1ES0FadGV0aUs4?=
 =?utf-8?B?bGpmQmlncmRVaEJFczFFL2dvdTNFdlpJWDl4WHNKSVRtVjRhTm1SbEs1aXJC?=
 =?utf-8?B?blU4dGsyT0lTSE9QUE9BTEJ5Y1oyVjJaZHlBWFEySmRpL2RmMGF4Q3R5TEV2?=
 =?utf-8?B?MWRUNFBPRk5kV1ZNdUJBbG90S054ZE1QVmRCOVhpQ3pYTlpHcGt3akphZCtK?=
 =?utf-8?B?V1pCUzYraENDY1lnSHVOWXJ6ZEFKemVWVUJxZTNpdjU5by9lWHBMeG13cG1G?=
 =?utf-8?B?RlowVWlQWE0xTTdOWE9OZmFMaHhmUWc5UHNvekVrazFYRGNza0dBRmJJb0pP?=
 =?utf-8?B?cm84aXZaN2ZlTzRSV2t3NGluZDExZTlrZ1NjRDJsUlJqU3llak14UXNBUExS?=
 =?utf-8?B?OStiUjJkZVFIMGtVWTE2NVl0djRwNGZ4anhhdFJpYTBJZ2prS1FQck05b3Jq?=
 =?utf-8?B?c25wUUNubU4vaUl4clZHQ2ZiV0VhTitRREJLRFBqMStpN3VadkJNRUd0LzNo?=
 =?utf-8?B?WFE2YmpSYjRnV0NEcDMwd0ttTEFWYnFMbk96d0E4UWFEc2tiOUZ6MURuRmFD?=
 =?utf-8?B?MHp3a0tDdFBlWkRxd0xMZDl3aUZYZ2FocUs2ZzArR1g5V2FwWW9sb3VwbVlO?=
 =?utf-8?B?TnlNazRGNjR0aG5wdWdRSVYzOTZDdzZrZVdPMDBUcW1NQTYrZ2VlRGpLK09v?=
 =?utf-8?B?c3owd1V3alcxYVFobFlJUWFMbWRkZzRKYnZuN2RwRVg4WVoyblltcFpvRXZq?=
 =?utf-8?B?RkxJSUxpN1ZNVWxvTXdqaFZ4VVBueVRyS3c3eiswWjFiYk53U0dYUGRNUFlm?=
 =?utf-8?B?dWtIOWFGeHMyTGw2SFlEQVNZOGF6aHpob3lQc3RkUzQ2WkNoYlJEV21zZmNP?=
 =?utf-8?B?d0RuMFB3ejlGNTZEOGZNNW0zT0hqZ0Y1ODl2MXZLdlZ3QmhqNUtYNkhKTVQz?=
 =?utf-8?B?V3JLc2dtUHhWNi9hTzFTZlRaWWxPRGVNcStKUWgvTU9DWUhIOERLeWU4c0NC?=
 =?utf-8?B?N3lDalFPUm1yN2F6dy9qMnVzUGk0emlJN2R5aW1jdm1qczFoQUFTV2VYNkpT?=
 =?utf-8?B?eExyRGtJYWY3eDRlWUI4RmcxSXFsZGhYanF1Nmk5aG42Z2pmSVNFaldTZmpy?=
 =?utf-8?Q?1+rix+s4BYTBaumGseBHygGuc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990eefe4-c1fc-4eb6-10c8-08db60e4c26a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 08:06:23.7875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqmN6X0xxOk5azDtLUk8ONARR4b4P9k5rT7sLTH1n6A5zumdF2wQn77BOzO/TQ2LWYrG5eirwcFPNKQ1DhvUnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

I ran into a NULL pointer dereferencing issue when trying to test a build
of the "affinity-scopes-v1" branch from your workqueue tree
(https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/?h=affinity-scopes-v1)
Inlining the splat, some debug details, and workaround I used below.

On 5/19/2023 5:46 AM, Tejun Heo wrote:
> While renamed to pod, the code still assumes that the pods are defined by
> NUMA boundaries. Let's generalize it:
> 
> * workqueue_attrs->affn_scope is added. Each enum represents the type of
>   boundaries that define the pods. There are currently two scopes -
>   WQ_AFFN_NUMA and WQ_AFFN_SYSTEM. The former is the same behavior as before
>   - one pod per NUMA node. The latter defines one global pod across the
>   whole system.
> 
> * struct wq_pod_type is added which describes how pods are configured for
>   each affnity scope. For each pod, it lists the member CPUs and the
>   preferred NUMA node for memory allocations. The reverse mapping from CPU
>   to pod is also available.
> 
> * wq_pod_enabled is dropped. Pod is now always enabled. The previously
>   disabled behavior is now implemented through WQ_AFFN_SYSTEM.
> 
> * get_unbound_pool() wants to determine the NUMA node to allocate memory
>   from for the new pool. The variables are renamed from node to pod but the
>   logic still assumes they're one and the same. Clearly distinguish them -
>   walk the WQ_AFFN_NUMA pods to find the matching pod and then use the pod's
>   NUMA node.
> 
> * wq_calc_pod_cpumask() was taking @pod but assumed that it was the NUMA
>   node. Take @cpu instead and determine the cpumask to use from the pod_type
>   matching @attrs.
> 
> * apply_wqattrs_prepare() is update to return ERR_PTR() on error instead of
>   NULL so that it can indicate -EINVAL on invalid affinity scopes.
> 
> This patch allows CPUs to be grouped into pods however desired per type.
> While this patch causes some internal behavior changes, nothing material
> should change for workqueue users.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/workqueue.h |  31 +++++++-
>  kernel/workqueue.c        | 154 ++++++++++++++++++++++++--------------
>  2 files changed, 125 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index b8961c8ea5b3..a2f826b6ec9a 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -124,6 +124,15 @@ struct rcu_work {
>  	struct workqueue_struct *wq;
>  };
>  
> +enum wq_affn_scope {
> +	WQ_AFFN_NUMA,			/* one pod per NUMA node */
> +	WQ_AFFN_SYSTEM,			/* one pod across the whole system */
> +
> +	WQ_AFFN_NR_TYPES,
> +
> +	WQ_AFFN_DFL = WQ_AFFN_NUMA,
> +};
> +
>  /**
>   * struct workqueue_attrs - A struct for workqueue attributes.
>   *
> @@ -140,12 +149,26 @@ struct workqueue_attrs {
>  	 */
>  	cpumask_var_t cpumask;
>  
> +	/*
> +	 * Below fields aren't properties of a worker_pool. They only modify how
> +	 * :c:func:`apply_workqueue_attrs` select pools and thus don't
> +	 * participate in pool hash calculations or equality comparisons.
> +	 */
> +
>  	/**
> -	 * @ordered: work items must be executed one by one in queueing order
> +	 * @affn_scope: unbound CPU affinity scope
>  	 *
> -	 * Unlike other fields, ``ordered`` isn't a property of a worker_pool. It
> -	 * only modifies how :c:func:`apply_workqueue_attrs` select pools and thus
> -	 * doesn't participate in pool hash calculations or equality comparisons.
> +	 * CPU pods are used to improve execution locality of unbound work
> +	 * items. There are multiple pod types, one for each wq_affn_scope, and
> +	 * every CPU in the system belongs to one pod in every pod type. CPUs
> +	 * that belong to the same pod share the worker pool. For example,
> +	 * selecting %WQ_AFFN_NUMA makes the workqueue use a separate worker
> +	 * pool for each NUMA node.
> +	 */
> +	enum wq_affn_scope affn_scope;
> +
> +	/**
> +	 * @ordered: work items must be executed one by one in queueing order
>  	 */
>  	bool ordered;
>  };
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index add6f5fc799b..dae1787833cb 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -325,7 +325,18 @@ struct workqueue_struct {
>  
>  static struct kmem_cache *pwq_cache;
>  
> -static cpumask_var_t *wq_pod_cpus;	/* possible CPUs of each node */
> +/*
> + * Each pod type describes how CPUs should be grouped for unbound workqueues.
> + * See the comment above workqueue_attrs->affn_scope.
> + */
> +struct wq_pod_type {
> +	int			nr_pods;	/* number of pods */
> +	cpumask_var_t		*pod_cpus;	/* pod -> cpus */
> +	int			*pod_node;	/* pod -> node */
> +	int			*cpu_pod;	/* cpu -> pod */
> +};
> +
> +static struct wq_pod_type wq_pod_types[WQ_AFFN_NR_TYPES];
>  
>  /*
>   * Per-cpu work items which run for longer than the following threshold are
> @@ -341,8 +352,6 @@ module_param_named(power_efficient, wq_power_efficient, bool, 0444);
>  
>  static bool wq_online;			/* can kworkers be created yet? */
>  
> -static bool wq_pod_enabled;		/* unbound CPU pod affinity enabled */
> -
>  /* buf for wq_update_unbound_pod_attrs(), protected by CPU hotplug exclusion */
>  static struct workqueue_attrs *wq_update_pod_attrs_buf;
>  
> @@ -1753,10 +1762,6 @@ static int select_numa_node_cpu(int node)
>  {
>  	int cpu;
>  
> -	/* No point in doing this if NUMA isn't enabled for workqueues */
> -	if (!wq_pod_enabled)
> -		return WORK_CPU_UNBOUND;
> -
>  	/* Delay binding to CPU if node is not valid or online */
>  	if (node < 0 || node >= MAX_NUMNODES || !node_online(node))
>  		return WORK_CPU_UNBOUND;
> @@ -3639,6 +3644,7 @@ struct workqueue_attrs *alloc_workqueue_attrs(void)
>  		goto fail;
>  
>  	cpumask_copy(attrs->cpumask, cpu_possible_mask);
> +	attrs->affn_scope = WQ_AFFN_DFL;
>  	return attrs;
>  fail:
>  	free_workqueue_attrs(attrs);
> @@ -3650,11 +3656,13 @@ static void copy_workqueue_attrs(struct workqueue_attrs *to,
>  {
>  	to->nice = from->nice;
>  	cpumask_copy(to->cpumask, from->cpumask);
> +
>  	/*
> -	 * Unlike hash and equality test, this function doesn't ignore
> -	 * ->ordered as it is used for both pool and wq attrs.  Instead,
> -	 * get_unbound_pool() explicitly clears ->ordered after copying.
> +	 * Unlike hash and equality test, copying shouldn't ignore wq-only
> +	 * fields as copying is used for both pool and wq attrs. Instead,
> +	 * get_unbound_pool() explicitly clears the fields.
>  	 */
> +	to->affn_scope = from->affn_scope;
>  	to->ordered = from->ordered;
>  }
>  
> @@ -3680,6 +3688,24 @@ static bool wqattrs_equal(const struct workqueue_attrs *a,
>  	return true;
>  }
>  
> +/* find wq_pod_type to use for @attrs */
> +static const struct wq_pod_type *
> +wqattrs_pod_type(const struct workqueue_attrs *attrs)
> +{
> +	struct wq_pod_type *pt = &wq_pod_types[attrs->affn_scope];
> +
> +	if (likely(pt->nr_pods))
> +		return pt;
> +
> +	/*
> +	 * Before workqueue_init_topology(), only SYSTEM is available which is
> +	 * initialized in workqueue_init_early().
> +	 */
> +	pt = &wq_pod_types[WQ_AFFN_SYSTEM];
> +	BUG_ON(!pt->nr_pods);
> +	return pt;
> +}
> +
>  /**
>   * init_worker_pool - initialize a newly zalloc'd worker_pool
>   * @pool: worker_pool to initialize
> @@ -3880,10 +3906,10 @@ static void put_unbound_pool(struct worker_pool *pool)
>   */
>  static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
>  {
> +	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_NUMA];
>  	u32 hash = wqattrs_hash(attrs);
>  	struct worker_pool *pool;
> -	int pod;
> -	int target_pod = NUMA_NO_NODE;
> +	int pod, node = NUMA_NO_NODE;
>  
>  	lockdep_assert_held(&wq_pool_mutex);
>  
> @@ -3895,28 +3921,24 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
>  		}
>  	}
>  
> -	/* if cpumask is contained inside a pod, we belong to that pod */
> -	if (wq_pod_enabled) {
> -		for_each_node(pod) {
> -			if (cpumask_subset(attrs->cpumask, wq_pod_cpus[pod])) {
> -				target_pod = pod;
> -				break;
> -			}
> +	/* If cpumask is contained inside a NUMA pod, that's our NUMA node */
> +	for (pod = 0; pod < pt->nr_pods; pod++) {
> +		if (cpumask_subset(attrs->cpumask, pt->pod_cpus[pod])) {
> +			node = pt->pod_node[pod];
> +			break;
>  		}
>  	}
>  
>  	/* nope, create a new one */
> -	pool = kzalloc_node(sizeof(*pool), GFP_KERNEL, target_pod);
> +	pool = kzalloc_node(sizeof(*pool), GFP_KERNEL, node);
>  	if (!pool || init_worker_pool(pool) < 0)
>  		goto fail;
>  
>  	copy_workqueue_attrs(pool->attrs, attrs);
> -	pool->node = target_pod;
> +	pool->node = node;
>  
> -	/*
> -	 * ordered isn't a worker_pool attribute, always clear it.  See
> -	 * 'struct workqueue_attrs' comments for detail.
> -	 */
> +	/* clear wq-only attr fields. See 'struct workqueue_attrs' comments */
> +	pool->attrs->affn_scope = WQ_AFFN_NR_TYPES;

When booting into the kernel, I got the following NULL pointer
dereferencing error:

    [    4.280321] BUG: kernel NULL pointer dereference, address: 0000000000000004
    [    4.284172] #PF: supervisor read access in kernel mode
    [    4.284172] #PF: error_code(0x0000) - not-present page
    [    4.284172] PGD 0 P4D 0
    [    4.284172] Oops: 0000 [#1] PREEMPT SMP NOPTI
    [    4.284172] CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 6.4.0-rc1-tj-wq+ #448
    [    4.284172] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    [    4.284172] RIP: 0010:wq_calc_pod_cpumask+0x5a/0x180
    [    4.284172] Code: 24 e0 08 94 96 4d 8d bc 24 e0 08 94 96 85 d2 0f 84 ec 00 00 00 49 8b 47 18 49 63 f5 48 8b 53 08 48 8b 7b 10 8b 0d 56 4b f0 01 <4c> 63 2c b0 49 8b 47 08 4a 8b 34 e8 e8 25 4f 63 00 48 8b 7b 10 8b
    [    4.284172] RSP: 0018:ffff9b548d20fd88 EFLAGS: 00010286
    [    4.284172] RAX: 0000000000000000 RBX: ffff8baec0048380 RCX: 0000000000000100
    [    4.284172] RDX: ffff8baec0159440 RSI: 0000000000000001 RDI: ffff8baec0159dc0
    [    4.284172] RBP: ffff9b548d20fdb0 R08: ffffffffffffffff R09: ffffffffffffffff
    [    4.284172] R10: ffffffffffffffff R11: ffffffffffffffff R12: 00000000000000a0
    [    4.284172] R13: 0000000000000001 R14: ffffffffffffffff R15: ffffffff96940980
    [    4.284172] FS:  0000000000000000(0000) GS:ffff8bed3d240000(0000) knlGS:0000000000000000
    [    4.284172] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    4.284172] CR2: 0000000000000004 CR3: 000000530ae3c001 CR4: 0000000000770ee0
    [    4.284172] PKRU: 55555554
    [    4.284172] Call Trace:
    [    4.284172]  <TASK>
    [    4.284172]  wq_update_pod+0x89/0x1e0
    [    4.284172]  workqueue_online_cpu+0x1fc/0x250
    [    4.284172]  ? watchdog_nmi_enable+0x12/0x20
    [    4.284172]  ? __pfx_workqueue_online_cpu+0x10/0x10
    [    4.284172]  cpuhp_invoke_callback+0x165/0x4b0
    [    4.284172]  ? try_to_wake_up+0x279/0x690
    [    4.284172]  cpuhp_thread_fun+0xc4/0x1b0
    [    4.284172]  ? __pfx_smpboot_thread_fn+0x10/0x10
    [    4.284172]  smpboot_thread_fn+0xe7/0x1e0
    [    4.284172]  kthread+0xfb/0x130
    [    4.284172]  ? __pfx_kthread+0x10/0x10
    [    4.284172]  ret_from_fork+0x2c/0x50
    [    4.284172]  </TASK>
    [    4.284172] Modules linked in:
    [    4.284172] CR2: 0000000000000004
    [    4.284172] ---[ end trace 0000000000000000 ]---

I was basically hitting the following, seemingly impossible scenario in
wqattrs_pod_type():

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3825,8 +3825,10 @@ wqattrs_pod_type(const struct workqueue_attrs *attrs)
 {
        struct wq_pod_type *pt = &wq_pod_types[attrs->affn_scope];

-       if (likely(pt->nr_pods))
+       if (likely(pt->nr_pods)) {
+               BUG_ON(!pt->cpu_pod); /* No pods despite thinking we have? */
                return pt;
+       }

        /*
         * Before workqueue_init_topology(), only SYSTEM is available which is
--

Logging the value of "attrs->affn_scope" when hitting the scenario gave
me "5" which corresponds to "WQ_AFFN_NR_TYPES". The kernel was reading a
value beyond the wq_pod_types[] bounds.

This value for "affn_scope" is only set in the above hunk and I got the
kernel to boot by making the following change:

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4069,7 +4071,7 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
        pool->node = node;

        /* clear wq-only attr fields. See 'struct workqueue_attrs' comments */
-       pool->attrs->affn_scope = WQ_AFFN_NR_TYPES;
+       pool->attrs->affn_scope = wq_affn_dfl;
        pool->attrs->localize = false;
        pool->attrs->ordered = false;
--

Let me know if the above approach is correct since I'm not sure whether
the case for "affn_scope" being set to "WQ_AFFN_NR_TYPES" has a special
significance that is being handled elsewhere. Thank you :)

>  	pool->attrs->ordered = false;
>  
>  	if (worker_pool_assign_id(pool) < 0)
> [..snip..]
--
Thanks and Regards,
Prateek
