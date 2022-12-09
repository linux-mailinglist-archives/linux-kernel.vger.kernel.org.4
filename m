Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187A6647EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLIHne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIHnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:43:32 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C18C1EEEA;
        Thu,  8 Dec 2022 23:43:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8nR3jy0E4sMbsmkrpH9wBPTqDsWsgQyRE8JLGtdxYZY9DZq7gTMvmLCrtBX048g1iWBZ4D8gkea/Qu9gjMqWQq4CLOGjYcP4bCckipeHy6p1b7Cv7+vf2VAYl3M2jLeOQhjkAQqL2VnF1xmn/aC5FzYhaiXfRn+VaJiTMgKbwJntJkbsV9/ZiIxIDPOxNu74YSQ6EuXuXmEcJyd1W4W9WQSKuGsEjFfTqhqr7E84czVTJo/4SCjRrMS86Pb4daApFWZRTNdKDhYN2xCpKVrBDb0JwTia8d4DrmGTKtcJacl++qjPZvZ4/u4n09t/5JNseFkVD55i1KlzhQQ/0ocLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V9J9zgRGIBK/uP2Yx0h5oCgiL9GgQ2pbBkjQxR3kbc=;
 b=ddR5rzF1ZBCYfi3ovKG/O/+vvFaajOyh1f3JFHKF1V6nEcfZ2YqXGFjI9xbeWneiydq8KMVJ1y8fRnVwjqJynmTh2OR6i/al82JIFX3e6l5FMzfaDSpgfrOHgB3KlZPpU/Rq1k4e4HTcdd005og1cB37iryqJJzEnbFLE6DTK0CX3/1n8EB6yqXD6Q5yG6CAa6/+1bZtB9F5rhAhp/Sx9fxuOqw+XUfGtTsH1VsslGi1xBiIYENW/ZtJ8zHic3LmiWYisxXl6aR4sLBGDTyU4j9FLuOSv58C0IApyriGj62Qk4+ZR5Ao/1Vge4YWHx+erEtnwhUGqL1ggY1HwMWf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V9J9zgRGIBK/uP2Yx0h5oCgiL9GgQ2pbBkjQxR3kbc=;
 b=bJ62DeXYdcBJCZyeQKcW5q/tXSKb99Kv6yaM6dnZAMw557kcUYKUpcHEi8DvKb/7ZC/AZsXEHdZLwfGe6Y27vyI3yG3BUMTruPd9GP5FiOPJa46u/6RE4LEpskriafqZGbaGVMB/S2FnvOPI8bI0D5nzEDe0WKH/yr9wdWx0MgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Fri, 9 Dec 2022 07:43:25 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 9 Dec 2022
 07:43:25 +0000
Date:   Fri, 9 Dec 2022 15:43:03 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Subject: Re: [PATCH 1/4] cpufreq: amd_pstate: Add guided autonomous mode
Message-ID: <Y5LnB+zUjy7aJmOr@amd.com>
References: <20221207154648.233759-1-wyes.karny@amd.com>
 <20221207154648.233759-2-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154648.233759-2-wyes.karny@amd.com>
X-ClientProxiedBy: TYAPR01CA0139.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::31) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: b3af91ae-fbed-4ea4-e97a-08dad9b90d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KknDmMV9Tt9wBJBsrrxCuvZEN+r876L7yLv0SrfmbXoP17oHTV665NiRj1Pc8U0hbzu7AERbm+md6Ly0Vc2KbBshoq58aNaJ2vu0uLDK5/FVIjEOe8lOqNYEW8vgyllPX1L0FPYh7t+e6XDG2+XI9x+9SsayISqcUxzUeX5YnnEniV2Z8tSjgENPiUtnZ7HgqRCarNmhLpFsAjgrFhht/5vQidmjzWTvacM3iaf6EiuS7TMfvmS4gVYnLobyBXFU4lsnwNgnHQuv2GayvGp1unLwOJVB+1H9m/x+RdOdu1V9W4HvEsUEOy1EqwNh/5AGmBTuXqcucCfTY8xo/QiW/juSO960JVH1bV4A4mGHsMzqpq9piY6YS9Bf3c2633wZtWwN/dgAG2Jx9TtpXruE4cMY9oNnpLOZT1q8poNQEgJSfWnIrGcwI7sy2lDPb1EmN3uy5ERm82RaOPdYqD39SzV/CQtzX/OAOz1kVrcj6/vEXpdJJszjp6yO0R7xFUbQyksFzy3arRfHad6EIDMtaZ3mYmLF+MW4wwErxI9BdvlygSLqnN86VBIfopC+Dsy2umF7nKJQ421f2E4haznyGaQk7aAjGY0B2phF/vJ2+WTW3Lh4GdmjcTbso6+Q1Wl4rRHRx/uT37lch5aB3k/YrCKeQXofdubRZUUq33faiRVotjLTEv99/Ci+ntf+WR+0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(26005)(186003)(6512007)(54906003)(6636002)(37006003)(6506007)(316002)(6486002)(8676002)(478600001)(6666004)(66946007)(4326008)(2616005)(66556008)(66476007)(41300700001)(8936002)(6862004)(2906002)(5660300002)(38100700002)(83380400001)(36756003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ItxKXqwgJUquqfP95X8klK0G46O5pmeSSJiSXwgVUx36AvqwAG2iZaX84/S?=
 =?us-ascii?Q?xwhrYFxcK9r4plKN+HVt2e6fjLxmUBC3+W+kWMDIM21J4lIobNQkKLrbaGxr?=
 =?us-ascii?Q?hdac5o11FN3IlgjEyI25TDPG54kwuOJLwjN+B32au+kpV6FXl2GRrQWGoMc6?=
 =?us-ascii?Q?RpvDHoN9bU2jw0q9SVOYGxXVTnRoC+bY/d+ah1S1o7IlBlj9mgvORTY0hpHW?=
 =?us-ascii?Q?aBs445Av+/wmfHvdmuiWDrQRym5EBTfDa1pMg9pWD8gwB2VYhb01JF2I20fD?=
 =?us-ascii?Q?J8c84Y3QpJOMh+oJKFYyJk9R2Qnr5Ens5pdA27UkWw4VYc7S2YVT57rMqVQV?=
 =?us-ascii?Q?g9kmzlrvlfZ+JomTO8DGd7QBuFkdbvRwCoO75fYK+cw99EuO2DVH5igJ7Qjo?=
 =?us-ascii?Q?F76q2Ye+yvihG9wVib3yWPUcfg+VqLMciqEplb86qfkwfmIE8TwdPygvYcma?=
 =?us-ascii?Q?I5SE29mGMV81Hfv02YkHgbUyDyam1pt586zce6TwRXy7BLGsKLfxtkHJXskj?=
 =?us-ascii?Q?w6vd5Tq8NV9FmqXsZV3AtEbG9e2QU2VkhrtkLSqbY6EixUabIqRClP1YJCRm?=
 =?us-ascii?Q?tKeO8K+6wzDBZN04uJ+cFGYxmOQHfAPQcBZNszUOld+RltnoLbF8kqDGRKMk?=
 =?us-ascii?Q?QmydGwUY9JQlZRMAzzBHfNbpYZpWkoE8pTDf75FwUq8RixgFIv/3DRWAOL/d?=
 =?us-ascii?Q?xHprtiWaJ2u1VfNM7WVXMosRyhvnEcbQSEhhbet+x+MiltlXOWrcrRb8/a7E?=
 =?us-ascii?Q?vmd8U7bk/9wUP+eED37ujsnzPWm1uWzkXQy5uv5YS6jXg1JMfOzL7yHgHQFJ?=
 =?us-ascii?Q?wtim5DYK0kVCls8Gj1ttX1bUkcnlt7Mep40KHOwpz5JUKNPtF+4DYwhQjDuG?=
 =?us-ascii?Q?jMOq7YXKiYflFNX6GoICAnnvDv0ubVKDFmuQxG5dLa7ml/QWjb8YzAbYzqvg?=
 =?us-ascii?Q?hJfx4yfMVMPQX+h7nOQBMyj/luzKLXuCLkHin4NpDgijIXlT5LTCbzquy5DZ?=
 =?us-ascii?Q?pJ1rUf9tHrEhiUo7lPYYr/h52udJaRneJvnmhPLUjF6r1Aezb0/aVermbxAt?=
 =?us-ascii?Q?SLyqv2UTvsaAXdMExlrlC7EdrjyipHQe/RZ50Jwl4xpj9hVzwTnOPXWwlJoA?=
 =?us-ascii?Q?kzQB/nYeqhfWwUFe74dWQegm+N55nXGY7DYm6oyPYC0Sp6hU6xHJvuI18xn5?=
 =?us-ascii?Q?3BFAUZkHJvxRWlUfSZgMYHJYTK+0QvwGz1jGX1VM6EkjMqAaKHp6ksDPbEG5?=
 =?us-ascii?Q?JiPQwsQE3Ku/esNuIfh1/VQMVIyt4SUsjVs8IDZXeQqQVUmp8iXLpdjp/KH1?=
 =?us-ascii?Q?ZZ50tGSRsHwa1XmSeU2Ie3kkfjktd1dMAh2TnhsyJ417tLjxlfiAUoCrYyNK?=
 =?us-ascii?Q?mnDtaWtShJ8q6kqGZybny6uGdi+VVCsXg90/qwZ7E8WBrjFZsMd6gNq4IvDB?=
 =?us-ascii?Q?h6rj4r5pM55iOctQQq2Bkq0eVIcrjWGwxSdceycQbZVwxQX4hWqtnXedFnVb?=
 =?us-ascii?Q?q2D6K3nAsk9LnUWeYgReVi55n/AY9AV5hOxuCLJH9mcBkPAWYsdTG3wE4E0K?=
 =?us-ascii?Q?4C5jur4tk32/3LaKhLig2s6O7ootjsUAvsne5wDP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3af91ae-fbed-4ea4-e97a-08dad9b90d9a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 07:43:24.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbvLrXj9j0Ftapdh+fO8QNJQZW6p2pc2RlgX5DM2bwifoiQCTSrp9dA4dSe09qAMC8yhMKK0n5+wg6eps3NdjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 11:46:45PM +0800, Karny, Wyes wrote:
> From ACPI spec below 3 modes for CPPC can be defined:
> 1. Non autonomous: OS scaling governor specifies operating frequency/
>    performance level through `Desired Performance` register and PMFW
> follows that.
> 2. Guided autonomous: OS scaling governor specifies min and max
>    frequencies/ performance levels through `Minimum Performance` and
> `Maximum Performance` register, and PMFW can autonomously select an
> operating frequency in this range.
> 3. Fully autonomous: OS only hints (via EPP) to PMFW for the required
>    energy performance preference for the workload and PMFW autonomously
> scales the frequency.
> 
> Currently (1) is supported by amd_pstate as passive mode, and (3) is
> implemented by EPP support. This change is to support (2).
> 
> In guided autonomous mode the min_perf is based on the input from the
> scaling governor. For example, in case of schedutil this value depends
> on the current utilization. And max_perf is set to max capacity.
> 
> To activate guided auto mode ``amd_pstate=guided`` command line
> parameter has to be passed in the kernel.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++
>  drivers/cpufreq/amd-pstate.c                  | 60 +++++++++++++++----
>  2 files changed, 53 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 42af9ca0127e..75e57afba77e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6970,3 +6970,7 @@
>  			  management firmware translates the requests into actual
>  			  hardware states (core frequency, data fabric and memory
>  			  clocks etc.)
> +			guided
> +			  Activate guided autonomous mode. Driver requests minimum
> +			  performance and maximum performance and the PMFW autonomously
> +			  selects frequencies in this range.
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 204e39006dda..05e4003a77ee 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -50,6 +50,20 @@
>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
>  #define AMD_PSTATE_TRANSITION_DELAY	1000
>  
> +enum amd_pstate_mode {
> +	CPPC_DISABLE = 0,
> +	CPPC_PASSIVE,
> +	CPPC_GUIDED,
> +	CPPC_MODE_MAX,
> +};
> +
> +static const char * const amd_pstate_mode_string[] = {
> +	[CPPC_DISABLE]     = "disable",
> +	[CPPC_PASSIVE]     = "passive",
> +	[CPPC_GUIDED]      = "guided",
> +	NULL,
> +};
> +
>  /*
>   * TODO: We need more time to fine tune processors with shared memory solution
>   * with community together.
> @@ -60,7 +74,18 @@
>   * module parameter to be able to enable it manually for debugging.
>   */
>  static struct cpufreq_driver amd_pstate_driver;
> -static int cppc_load __initdata;
> +static int cppc_state = CPPC_DISABLE;
> +
> +static inline int get_mode_idx_from_str(const char *str, size_t size)
> +{
> +	int i = 0;
> +
> +	for (; i < CPPC_MODE_MAX; ++i) {
> +		if (!strncmp(str, amd_pstate_mode_string[i], size))
> +			return i;
> +	}
> +	return -EINVAL;
> +}
>  
>  static inline int pstate_enable(bool enable)
>  {
> @@ -212,12 +237,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>  }
>  
>  static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> -			      u32 des_perf, u32 max_perf, bool fast_switch)
> +			      u32 des_perf, u32 max_perf, bool fast_switch, int flags)
>  {
>  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>  	u64 value = prev;
>  
>  	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> +
> +	if (cppc_state == CPPC_GUIDED && flags & CPUFREQ_GOV_DYNAMIC_SWITCHING) {
> +		min_perf = des_perf;
> +		des_perf = 0;
> +	}

Since we would like to modify the min_perf on share memory processors as
well. The current cppc_set_perf() in cppc_acpi doesn't provide the MIN/MAX
values. Could you please add the max_perf/min_perf in cppc_acpi.c as well?
Then the APIs will be available on the share memory processors like Rome.

Thanks,
Ray

> +
>  	value &= ~AMD_CPPC_MIN_PERF(~0L);
>  	value |= AMD_CPPC_MIN_PERF(min_perf);
>  
> @@ -272,7 +303,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>  
>  	cpufreq_freq_transition_begin(policy, &freqs);
>  	amd_pstate_update(cpudata, min_perf, des_perf,
> -			  max_perf, false);
> +			  max_perf, false, policy->governor->flags);
>  	cpufreq_freq_transition_end(policy, &freqs, false);
>  
>  	return 0;
> @@ -306,7 +337,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (max_perf < min_perf)
>  		max_perf = min_perf;
>  
> -	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> +	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
> +			policy->governor->flags);
>  }
>  
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)
> @@ -627,7 +659,7 @@ static int __init amd_pstate_init(void)
>  	 * enable the amd_pstate passive mode driver explicitly
>  	 * with amd_pstate=passive in kernel command line
>  	 */
> -	if (!cppc_load) {
> +	if (cppc_state == CPPC_DISABLE) {
>  		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
>  		return -ENODEV;
>  	}
> @@ -670,16 +702,22 @@ device_initcall(amd_pstate_init);
>  
>  static int __init amd_pstate_param(char *str)
>  {
> +	int size, mode_idx;
> +
>  	if (!str)
>  		return -EINVAL;
>  
> -	if (!strcmp(str, "disable")) {
> -		cppc_load = 0;
> -		pr_info("driver is explicitly disabled\n");
> -	} else if (!strcmp(str, "passive"))
> -		cppc_load = 1;
> +	size = strlen(str);
> +	mode_idx = get_mode_idx_from_str(str, size);
>  
> -	return 0;
> +	if (mode_idx >= CPPC_DISABLE && mode_idx < CPPC_MODE_MAX) {
> +		cppc_state = mode_idx;
> +		if (cppc_state == CPPC_DISABLE)
> +			pr_info("driver is explicitly disabled\n");
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>  }
>  early_param("amd_pstate", amd_pstate_param);
>  
> -- 
> 2.34.1
> 
