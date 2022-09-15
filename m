Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDF5BA119
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 21:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIOTDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 15:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIOTDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:03:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274934A13F;
        Thu, 15 Sep 2022 12:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhSDK6rBMadP/Y9g1BeP4iZUX/NK6hH18UtBdWMDNU+IKgeEdnSPQVMQgsT5iSnlDCYFidj9vA9olyiLP1RNtqdvkgsHqzDrlOeJIaNJ5FxHn0aoDcpR0fO8ZHP0cVloQsijXUplXBV9l2wv7heh96mbAscuo/Q1rkNogUsH0GcH31cvaleqcwlQyFmnwXo3WIJztKTnXPYF8wmcvTkO1W8bBVlKB26ah/B6RjZXJQmN0kpb5AqytqoEkDg8Vuy106uq4S+saUni3M2mwen36bB1QwGg9VdEnmNLNLi/5yrA5K0UFU845DNf9rd4P4tWfzv0+thzwnowc6RqHLJxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INRzqvUatWl+t2xqmlpfOAPTf95ZV8XM2QM9cc8lvds=;
 b=IhPg2NhJDSbbqWQe8AFGr/k3ACi2pi5Tchxnpfb1Ve44DMEod+wH4uHcvE2qKzZcV2D2GFnZVjEQ2e/P7yBGfc1JJVCIhcl+kOby8J+BAiZxAVaU5OkOzUZilES+HhDh4mrFVW0lF6UwE0+z8/79M07alyG6KfmuvlzJCo4gGrDEyUiXRXJ6KcPPj1pHjvxqg5EozS+lLFf1yaIJy4vP+4HQxLWXIzbvPwQ4iWgWjnBWsxysb1ippdD9MBYhC6pZ61AJZ+Xr00CgviqgtauLSzWJDQfroXOlxmRT0ubA3lIS/QHMpegg87NB3nAiaIAL3SzO6Wh/nFwmUApEvLKPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INRzqvUatWl+t2xqmlpfOAPTf95ZV8XM2QM9cc8lvds=;
 b=rJtR8l2W6C59vK+d41jrRJ+QhwrRyqdkasFDuhbwzo+YJ/EPYuhX5M54lk4gc2vovycPuD4EvKuuRBwRj41bzZPbLptprGGZwFb5DCggWgEoLwVfGJuw+YCHcYxr7ypCkd2vDr4pXfQ39zBETf+X3+03BnVxLUeD+6vE4BKwPKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 19:03:36 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::dffa:5a91:e628:96cc]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::dffa:5a91:e628:96cc%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 19:03:36 +0000
Message-ID: <950b774b-fad6-78e8-eae8-90e1518cd32f@amd.com>
Date:   Thu, 15 Sep 2022 14:03:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/7] cpufreq: amd_pstate: implement amd pstate cpu online
 and offline callback
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Alexander.Deucher@amd.com, Jinzhou.Su@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-7-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nathan.fontenot@amd.com>
In-Reply-To: <20220909164534.71864-7-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:806:6e::32) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|MW4PR12MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 852bc306-d784-4102-f0cc-08da974cfdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7I/lhE8F5TufFG/vM6yNoczFPIBNBAijWbtX7pEt26TxItuM/5qFLXZKzYtmjo/zy93QFNzm5pAYb00MbH310jFP5uTH7WU29yHLzdPh3lCXl5ZCW6NIB+l65HOyFggNjKPQLlcK2VN3V7V3Ly5QVTff9EMNM+594E88o9ylyhTMl9ykqwn0BrI96du4nqSMZuX+XT6Q2ve5Vvd4ppMQSb6mFoapXclPKHJx+/xLk08DKD3hqRpyE+Aa6ApM0B4A1NHHB6ympjHd3JHuclVotK/rkWDFPwGhTaSsi6lUwLL0jzir587INpxTfRLs+Ij3BV0VwX8uUpnnrnuCL27wFh0Ffs8pPu8/L8QUHTiZamkLMDu1+2AaxqZ49+92xKDndcXeJMLD6dmmJswlMdHfJsNs+jDYu3EjQI9oThyPJNN/MroexKeAfPghIkgEuAB5itkGul1VXD4gVxorHTrO/JQztRMqxrQ9ICQzph+AKKSbwMyPul2fupRqk6BlnadAAyOITyYR3xHOaKXDoYuUuSpYRWMdx2ODIACR/Ka/gnliKtRm9Ps9wISoWxBwDWKWUQg9HhVJodvYee4xv3bKQt1H7hhCc7Ab/sXw8jEGjliipiuG17GHEsNvZrJ60kdVeQtDnQHrHFmAz556rn33hTShJHwT8czIIq+xQTdB04DbTrGSYBYkZ+mGPJNSrD42a1J78Xmxo/QHEzZuXJ0z804LIibok1S5l5pWMDUSVRTB6DbTDVX5ofmycQlFnC2P+cmFlSKsvNJ3hY1QPdrS9LI5m58L37HZGvuJE6ceOGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(478600001)(4326008)(6486002)(31696002)(6666004)(86362001)(31686004)(41300700001)(66476007)(316002)(8676002)(5660300002)(26005)(53546011)(8936002)(83380400001)(6506007)(38100700002)(36756003)(2906002)(2616005)(44832011)(6512007)(186003)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkQwcTZuNzhjc2RCcGd2cjJrc0luWVB3NkwwZVNUWU9TbFpJb0UrajBsMmJB?=
 =?utf-8?B?WEI1QVArd3NEZmJrRmdjQ3VMMFZQdCsrbnJHamY0N2ZSUjFtNVFqVE5tdU54?=
 =?utf-8?B?T1ZaR2hucnFoS2gwanZXL3BiNElWWXRtU0xXNDFrc1ppWFoyWDNUL0ZzUjVI?=
 =?utf-8?B?YzBYRnhyWjM2ejlUVVNrS3RvM0pWZlczOHdRR2dLcnJxMkF4VzViRUpxZ1Y2?=
 =?utf-8?B?cGs5cEtEc1daN00vZHRsWHBtbjNYZDhzOU14eFpFZlJGSnNRK2twNVU3WWMz?=
 =?utf-8?B?bG54eE1rS0dMWkh2b0UzYXpBLy9ZeDFpWU50S1Q4VU51UXByTWdoUGxwSlFK?=
 =?utf-8?B?aTIrVll2ZUxLbXVkQWJ5U1ZnQmJ3eTJnWXJoNHJpMFFuNzNGYTUycm9WZDF4?=
 =?utf-8?B?ZG1rR1EzNXFwYi9HSjZkM3pjbi9nQjVrTktWZFpwdCtTdklQMmFMUVdkRDM5?=
 =?utf-8?B?bWJpNWFWYnNXN2ttTktJYmJjNURxWUJNRnZ4bE44ZktNa2pnaEllMEpMblFj?=
 =?utf-8?B?Z21xbW1VWEZjVmhqa0dPMGpUbm4ycDlLRDNYdXR4Sk0rdUNlaHBhTUorNEk2?=
 =?utf-8?B?OS9nVEoxMkRCY3NZUWR5eTNWMVl1Z3lBejYrdnBPaGtOMUNFaHRpRFJVWDhY?=
 =?utf-8?B?K0pHV2JEQ2p1NGxlNmxwMWg3dEJHZ015VmpVZ3dtVDU3cThzRjMrSVBrcm43?=
 =?utf-8?B?UWtsNEdDdi82MFg2NDlJZjFodXdTemVRN3AxUWxqUWROdUdqRUREUWwxQzVa?=
 =?utf-8?B?eVFqREtQV0l2SDQ3YjNHSzUyTS9NbGo4OWN6RklRbjB6V2ZBSXF2UXpmMkZD?=
 =?utf-8?B?OXBYRGtJdVNBT01paE11WjJJcXNkeDV1UzVXNnl6R0tBOE1RMklnR1pteXFQ?=
 =?utf-8?B?cldIeGZkNStSTVp4WlVEcno5K0lPQzRta05ZVDdHWFZtdWF1VmVwcFlBQmI2?=
 =?utf-8?B?TG0vVTdrS0xxR3ZrdURqVUVnM3MvakpReDVXcWREVUlkeGZNOVlEdjVOZTMr?=
 =?utf-8?B?ZHJyL0ZtTWREWm83TmFna0piN0pmNzVVZ1JDd3dvajdYY1hvcnZDV3h6a1BH?=
 =?utf-8?B?SDdEeVlodWNhMXkzdnhoVWRrRTJmWCs4UW9yb0hldXRDZmtYbGRJaS9id1Z5?=
 =?utf-8?B?SU5OWFRiUThKenJ4Zkw5alc3bE85SFVIRndEamhNNG1jbFBNSjE4emZFa1N0?=
 =?utf-8?B?ME5TbUhMTUk4OUpVTVY5R002cEpYRHJaaTRsTTMvdytPRVBnSGNkV2xlaDBB?=
 =?utf-8?B?WkZzcGhIWE43ZnorWTNUVlhPYk1mSVNIYmFTcjhQRW1DUUtsOFhpWkc0SEpj?=
 =?utf-8?B?Qjd0RzFnR3cycE9YcFIxRTVBTVFIcVNxMjRCaDJRZmViV3FpYmxBQytxUE9Q?=
 =?utf-8?B?SC8xVlZvcnVSTlNIbTJUOXVyK0ZqYVdiRGpicWd1Q0tVUGRNakZZZU84UUJs?=
 =?utf-8?B?R1BCWWY4MXFJTXllK1dTMHg1RktTQWI4NTUyQlNTZFJoNmthMEx6am9lVFlO?=
 =?utf-8?B?RnNJVjMxWXJWY1M5L0FDWkdUYk41QkRWMk5DUXZmVEg0ZkhMM3M2WkFlT29j?=
 =?utf-8?B?blVab3Q0M3lKK2E5NXlySko2TVRZaXU2bHBiUzNVbVpBRVBUeHYveGVUbUtN?=
 =?utf-8?B?WW96LzBzUXFKTDBjc0NTWU9vaEtrV3p3dS85UUdvR21GVzhYZkhqM2RsZ0hs?=
 =?utf-8?B?MlZTV3hrcG9qVjZ3ZWszOTI2bXpmZHV5L0VwQ3NEVzV5OVIxV0FqMUZ5Tng5?=
 =?utf-8?B?bmh2SFhJU2JOWGV4Qlo3UGVDMVNoekZGNWFNeVkvalQycGdmdlVSamorZUpM?=
 =?utf-8?B?RSt3QnVoSGZMQzB3Tm9HZmwvejBjdHRJT3d1SDdhMXF4bVc5L1NoeXdBWVdn?=
 =?utf-8?B?eksvUmlUaVJXV0Vnb1lEZXVNeUZPNmMwOEFWK09nUUJzTzl2d2FURTZyTHRw?=
 =?utf-8?B?TnJRK2cra2lISkh0NHlvd24yKzRYVTlGY0NiOWxRaEpUNi9Lc1U3TW1HNlVy?=
 =?utf-8?B?N21CYXJRaG1kRmVoMjVsd0U0NWgwSndOZ0hveDFicEI3MTBPazRKaWJLQ1hi?=
 =?utf-8?B?SzhLZldRWW5raWFRcDZVRWN2Ulp1S0FVWXVIZkFRVFdoRDAxekxLVmxScEZL?=
 =?utf-8?Q?Y1MMtoXVKOlbcq0HaaCGoNmQe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852bc306-d784-4102-f0cc-08da974cfdd1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 19:03:36.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHv7uG6UikK9GhfEj9SaGiVBzR8wqkkbTaiTpYMy6kHW/a9esZncsUGdBapaYT+6yJOLmcRqfp2KBl+HVea/Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 11:45, Perry Yuan wrote:
> The patch adds online and offline driver callback to support to allow cpu cores go
> offline and help to restore the previous working states when core goes
> back online later for EPP driver mode.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 93 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e71b06e20050..e63fed39f90c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -111,7 +111,8 @@ struct amd_aperf_mperf {
>   * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
>   * @update_util: Cpufreq utility callback information
>   * @sample: the stored performance sample
> -
> + * @suspended:	Whether or not the driver has been suspended.
> + *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
>   */
> @@ -151,6 +152,7 @@ struct amd_cpudata {
>  	u64	cppc_cap1_cached;
>  	struct	update_util_data update_util;
>  	struct	amd_aperf_mperf sample;
> +	bool suspended;
>  };
>  
>  /**
> @@ -1387,6 +1389,93 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static void amd_pstate_epp_reenable(struct amd_cpudata * cpudata)
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
> +	if (epp_enabled) {
> +		amd_pstate_epp_reenable(cpudata);
> +		cpudata->suspended = false;

You've added the suspended flag to indicate when a cpu is online/offline but I don't see
any place in the offline code where you set suspended to true.

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
> +                value |= AMD_CPPC_MAX_PERF(min_perf);
> +                value &= ~AMD_CPPC_MIN_PERF(~0L);
> +                value |= AMD_CPPC_MIN_PERF(min_perf);
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);

Some odd indentation here, looks like you may have a mix of tabs and spaces. Did you run
checkpatch?

-Nathan

> +	} else {
> +		perf_ctrls.desired_perf = 0;
> +		perf_ctrls.max_perf = min_perf;
> +		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(AMD_CPPC_EPP_POWERSAVE);
> +		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +	}
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
> +	if (epp_enabled)
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
> @@ -1421,6 +1510,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.init		= amd_pstate_epp_cpu_init,
>  	.exit		= amd_pstate_epp_cpu_exit,
>  	.update_limits	= amd_pstate_epp_update_limits,
> +	.offline	= amd_pstate_epp_cpu_offline,
> +	.online		= amd_pstate_epp_cpu_online,
>  	.name		= "amd_pstate_epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
