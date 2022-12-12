Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D355649A94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiLLJDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiLLJCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:02:52 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EDDB54;
        Mon, 12 Dec 2022 01:02:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/aPSPKLAZwPVeraDYZJA/HL7PpemWuBe28aFEI/Wg3SrH6i0dyHJfaR/SZhOtX7I/xImpFhS/3LOxg7v0TlZYhVKvhK6x7D/YPtoh+qg1WyRjitzB2al8xnoEPO14Fob5mEJ/kp65yYpd78LNBanXt4KCfME15hK2pL2NbfNYM/uR7WCjrFhuUg22UaBUlGP00U6ooLO6KzfWRxn8uWwNUVgUmlh8d7WSUq+E9dlrFuMtkqlh0ZCtqAPwJOdsJr1L+pAZcsG8GYWStaIGdsLRVZYm/LfcJ1rzFJW0wwhY3f46I15HmjPDbgcKwGA3sryGVrwuhTcb5pggOjTliySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZv5grP2mx5MaE2FOqdwDdQcjzFJYa9uXF8Jedq4KzQ=;
 b=nKdInLfCsBIyiJ5EHlITkgxMSjVDP0osw/opUd4th1DnhlCQg6TU9A/j8RWlKjAzDFdUxz/HPPzid4cqsipmW9T5eZ0Rb/Lw+cEh1Y9UJDLmShHuT/FzIcy/iFTfM8v/cP3zYWzy1i5oXMQQpK6+7FCrPXgu+p2SXJk0s+2EGV+efr03LzxJuvFqTQSbieCVbVjZKrtFtJ1aMludRQzI8roN4cmjeu3cdKyJnOTUYhvPPKxu0sB6E93MmY4/otG4BRXIHLWsz9ba9II8g02CgK75lPiqYkxO4qjYBQK3kCwT3EGIlLIUfOH/J5oykwjQy6tR3aHszQy1moJrqhRfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZv5grP2mx5MaE2FOqdwDdQcjzFJYa9uXF8Jedq4KzQ=;
 b=uQKScHI12B/ohdyrLTqIrS9NBFTqc4Th0CfiarB2g4u04D/vGFPlrCW5i8ilX2tqujFuZNctRXezWNcBJ5IEo3561aROrCaNdEtYjf39LDe5qSjgh4r5WwWadtuv+IwsgzsWiKGyaD0WxaWpeJJUSB84WgERgg3SogEmU2oxOUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 09:02:47 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Mon, 12 Dec 2022
 09:02:47 +0000
Date:   Mon, 12 Dec 2022 17:02:24 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 06/13] cpufreq: amd-pstate: implement amd pstate cpu
 online and offline callback
Message-ID: <Y5buIL08ovNxYp5f@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-7-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208111852.386731-7-perry.yuan@amd.com>
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5689f8-7ddb-403f-5647-08dadc1fa397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruMxLcXFkBs8PJEj/w1QPudz8yxDrQ3fh9hIp9DMhNIsKawDjyqI3OBR0/z5OiisHLQUjTqYBtUJhNcXpUoAHXk/JzkqQxzJz5ec6/Cud26LeKMf0tfNTBv54TJxao5G/gCtYLaOx+VMbF8c2sMef7IWqzSgZm9xnhwpfV0lSZNRYqxJ3TcibUmToBgsfNqaDxibxbZSZmFWX2Ru/rrY49pBbqMZhISwk52E7IObjyq0da+x88qNIAL1H3jm+sEXz9Sr456kpqlRkD3SY0ResGd49MUDrIkyYNqj0qXubH1W2SSkWpBvShicDVQ4XrMINHLnD0mcRZWMBOzjNf9V9XbSZz+YkSOuHS1QX3BBzXGvXwtT9yI10CUdsgK5tYkYDVwfe/Aoxjc9ETlarkTajIKGdncbYAqA44jClY7zpaW0UA9MQLQ0JYTl6jTCBYI8nUxzzPpMCFRKAeSFHSZGHawdDAnLu7Oqh/NKjDaLaSY3RqeukCxKBalgGteWVWsmCveM6WX+wFjxKn0R46OWngXDa5voL2+g8eXr2EHHSNV1RlME5kxblfl7yUWcLWqBcaJu39RMMtrO4W4KN7xb3OgY7nt2MPUcJraDlIkC4pEWuPoX3BosZ9BYZ+x0ZZFFYqwn6RXPq1SEP6Ja+gdgBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(8936002)(83380400001)(86362001)(38100700002)(2906002)(5660300002)(6862004)(8676002)(66556008)(4326008)(66946007)(66476007)(41300700001)(2616005)(26005)(6512007)(6666004)(6506007)(186003)(316002)(37006003)(6636002)(54906003)(478600001)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CpyMNu4M9ms7J5hYKYgzZPsuMZLMDM2RdOKQ0Y1BZbFkzdFiR1jkdq8wARjS?=
 =?us-ascii?Q?zjvCyWYPsyFo2oO1Jj7mInjcdbdZ8MaOKb2sx1bVZ0GLXJHMVY/jhtdwfh+x?=
 =?us-ascii?Q?DoTjIOZTlLSt7nAHcRb+9D8xPimN+yNSajNtUPLzpcrL5MDm5HThhASuz0AY?=
 =?us-ascii?Q?hISCtwG9ThAZgwhArYpLiOOfvSgLB6sMXwEbnw61ZIb4RxyiP6+lMpiqPdZB?=
 =?us-ascii?Q?4xoKUotydhTDbmMKAcQtj5mHewHsP03sfljH0efuH7govgemqjBKT3kNZkux?=
 =?us-ascii?Q?TjVlj3mzAUfsWDnXNiYZsBO2v6mXONHOfgWJDWiLvITreU3amSdi1GS5B+o8?=
 =?us-ascii?Q?a7FY6jx0cDSw9265W4BZj0asM5yzb8JvtNN/Acu8ru/kMO48fHjpCz/ZCNMa?=
 =?us-ascii?Q?/5OtP8Qw5+gp8JXMgUac8EdPSHHQQ1YmU1pCYwnOkPFVSytP1vLso11v+q3c?=
 =?us-ascii?Q?pEPOK99go3UX8aRav+LF0MTiA+HeR37ywvEzlaN/jei2VDp3TUVTZrWJ2LNz?=
 =?us-ascii?Q?SsmyehzuyIUDs77YosMj1GF4C67PynRowLoIbJEamzkoCxD0aTVTiITMdy5U?=
 =?us-ascii?Q?LW60xdBIRNXOuZCRHn4LCqEHOxxS8z1+CTP5tUiSWgnnhCU6h5j0D2tGspnw?=
 =?us-ascii?Q?n2Vx57mlnRCxakj1FV9MbG+tIshMgVoO7GDB7ZWhigvd1JyxM88hZMaB1O5R?=
 =?us-ascii?Q?KqPuJkJgDWgcrN/plJ/rLo0kteVHouXOUQck1TkoIclmD12GxA72m1p2R9gQ?=
 =?us-ascii?Q?Fx+wnd3+ty6cZWotX6ciRszIQR1vNlJWGANOi1s/w2ByRD0uEzW8acH0fzVr?=
 =?us-ascii?Q?WKZDn++R8R7BOsLoGqr687M7FnPyp3mEvjD/pXpx0+qgHU1VVmeq05BM4Z76?=
 =?us-ascii?Q?+FC1mJuX6FcyQkOQzfot/2TsX7lYg4jZrbqzaI63X6GJiclPUakn6SFgD140?=
 =?us-ascii?Q?oyt56HLTEjJsZPszWALe/i4iNChzYOonGs3vIvnwmHzBSwnqCecYFcZb2kP4?=
 =?us-ascii?Q?eYfae9jP+GpohlpAj3ncdQ8TkUhKXgAqI+cIlovyM0G1jvQjcOLYBwwDAGVf?=
 =?us-ascii?Q?XVnZQX8uTuZwvqIBEFxjtOW1McR4V5NsaQEjKnXsfsimNU+8xmIrM561w6mp?=
 =?us-ascii?Q?CnP4v0zqbDJPdcpMWxzflAZpeIpeTuAa+S1q6gHSQQSG7GQmnzP1SRstyBcX?=
 =?us-ascii?Q?8Ggb70Vs2i2GKhCnjFkW1MY71sxE0p/DeJqUoNEPrwPG0/RoM0zir16gwsg+?=
 =?us-ascii?Q?nTKHvn6VYG+cVNveDChy5JZIDGOLahFUM/z2bREHC21QBqxxaMuIx6p9NuFU?=
 =?us-ascii?Q?+Kn+frYV5LyYPqqIDxJqTfCtSYUujUYgi07X9YEbhnGOcTS3ONk2ZkIUYQ9l?=
 =?us-ascii?Q?S+i4aFEWDLCgq4ZPFIjCqS0wcXLK+kV7k6j5vt5BGWnWw5Iex2jcotEPHIyf?=
 =?us-ascii?Q?0NQU++T/tjnTUsU0hEDHq/koMjRcKVPDvqEo6mThRMqUoy8ry2sVJK6YWy/p?=
 =?us-ascii?Q?YzqFWrSqsloCh6i/SRvVIsPgoVVaoXVtAzc9cEA+P8ZEJ6dza5Nn6q2qkrJJ?=
 =?us-ascii?Q?nCWA0/clnGps0M7d+qYRe9okPRaSOdPl1TOK/QC4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5689f8-7ddb-403f-5647-08dadc1fa397
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 09:02:47.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYI79ZUuhnx7I/R25mNGGTwW6TjgC4FIb7wYfd5QbeFXj6X5atTxqIUdkc3yRJ/25Hj24dDRv3AS/YizLfejHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:18:45PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Adds online and offline driver callback support to allow cpu cores go
> offline and help to restore the previous working states when core goes
> back online later for EPP driver mode.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 89 ++++++++++++++++++++++++++++++++++++
>  include/linux/amd-pstate.h   |  1 +
>  2 files changed, 90 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 0a521be1be8a..412accab7bda 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1186,6 +1186,93 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
> +{
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u64 value, max_perf;
> +	int ret;
> +
> +	ret = amd_pstate_enable(true);
> +	if (ret)
> +		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
> +
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +	max_perf = READ_ONCE(cpudata->highest_perf);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.max_perf = max_perf;
> +		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
> +		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +	}
> +}
> +
> +static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +
> +	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
> +
> +	if (cppc_active) {
> +		amd_pstate_epp_reenable(cpudata);
> +		cpudata->suspended = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +	struct cppc_perf_ctrls perf_ctrls;
> +	int min_perf;
> +	u64 value;
> +
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +	mutex_lock(&amd_pstate_limits_lock);
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
> +
> +		/* Set max perf same as min perf */
> +		value &= ~AMD_CPPC_MAX_PERF(~0L);
> +		value |= AMD_CPPC_MAX_PERF(min_perf);
> +		value &= ~AMD_CPPC_MIN_PERF(~0L);
> +		value |= AMD_CPPC_MIN_PERF(min_perf);
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.desired_perf = 0;
> +		perf_ctrls.max_perf = min_perf;
> +		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_POWERSAVE);
> +		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +	}

Could you double confirm whether these registers will be cleared or
modified while the CPU cores enter/exit online/offline? I remember Joe gave
a test before, the register value will be saved even it gets back to
idle/offline.

Thanks,
Ray

> +	mutex_unlock(&amd_pstate_limits_lock);
> +}
> +
> +static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +
> +	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
> +
> +	if (cpudata->suspended)
> +		return 0;
> +
> +	if (cppc_active)
> +		amd_pstate_epp_offline(policy);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	amd_pstate_clear_update_util_hook(policy->cpu);
> +
> +	return amd_pstate_cpu_offline(policy);
> +}
> +
>  static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
>  					   struct cpufreq_policy_data *policy)
>  {
> @@ -1220,6 +1307,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.init		= amd_pstate_epp_cpu_init,
>  	.exit		= amd_pstate_epp_cpu_exit,
>  	.update_limits	= amd_pstate_epp_update_limits,
> +	.offline	= amd_pstate_epp_cpu_offline,
> +	.online		= amd_pstate_epp_cpu_online,
>  	.name		= "amd_pstate_epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 888af62040f1..3dd26a3d104c 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -99,6 +99,7 @@ struct amd_cpudata {
>  	u64	cppc_cap1_cached;
>  	struct	update_util_data update_util;
>  	struct	amd_aperf_mperf sample;
> +	bool suspended;
>  };
>  
>  /**
> -- 
> 2.34.1
> 
