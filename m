Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE05BA114
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIOS6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIOS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:58:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB96B895F9;
        Thu, 15 Sep 2022 11:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AED+EcB2OvdHqglNlTIPfLWvGRfwltuotaNnlsTMj8d/Xi8HKfX4EnMArkiCfcCiXCbqU/Nbz3i0TnCPkAIk5M78vTDCYnzTAHzBsRolLnelLoJKAd1aZfC+B8FiJM4iHEPnV0in7IhxdL+prlTkcv1vNTFd3a7M3unrkwgdbyRCHyNWp47SSFDXrMH6pZkN3m1VhkZCxBtHQjfkKCjgZduex2s4hfzo75HlIv+WrIL5jkssFmc188rol4u8znIo+NrQZICaD8qALjAiHPVh05nSFX+j9hkfEcy9q9VpmBWiTHHy2oUh1vWSdAA3SMA7OGapB7am/3Zw7yzhXrXrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zMhL3EEuifrAr0U0nUUz8W/mJosGlL2AlbHX3zEIqI=;
 b=igM8jhPdN1gi8PZhEjnvBdMcDTpizlRCxGKlQlQFs+8rGLLK4s5aEPA5SV4z5WCi1LYmtvl1ZvF8jlkWNZNdzknfjNjcT1+gdI04akZ4TQYspkIuJSRBG6bEajdm9BmnDac4k/4WBNEVTRmqFRK+6QSqR2HWytFaB+M9HSoUQjCoB2YFi6oARhdHVShfszyjV593sDXnaCJ/Eo4oYNNfPALl1YxylD2Qgk4jLGRSAPYW1fCxAGfN3vEireullkA9Yw+/qzOb7dhx6/mGCO+ggdDhzZtTBwR9nxCQ5ks+WqXGgLQKo88st0tCGlZI6vAt/3/pLw9lncNDNECDJW3PBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zMhL3EEuifrAr0U0nUUz8W/mJosGlL2AlbHX3zEIqI=;
 b=RhLdDCvzdbis5FFhFodeqqnU53e6xEIa6T2UtoD91ag9Oxqe3DbEROrnvFs32LL7KtWfadJNFrO76J9qghHVZcpQkRP4f1ph8CFEkDl+DvkZjpg0/ZLmD4uGARHnSddu2XYVBlgPbx7JsmLKOFAo6H1GRe4+g152/IlGgBjXPEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Thu, 15 Sep
 2022 18:58:36 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::dffa:5a91:e628:96cc]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::dffa:5a91:e628:96cc%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 18:58:35 +0000
Message-ID: <958a5436-c34a-86f1-777c-7962f90f8259@amd.com>
Date:   Thu, 15 Sep 2022 13:58:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/7] cpufreq: amd_pstate: add AMD Pstate EPP support for
 the MSR based processors
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Alexander.Deucher@amd.com, Jinzhou.Su@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-6-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nathan.fontenot@amd.com>
In-Reply-To: <20220909164534.71864-6-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:806:125::21) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 661d0f14-ff50-45d2-6166-08da974c4aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAbHoZBhedLWDxvk61LQKWKHApRFD03fivLvaQ5TGgj1PX5SwwiBFuJi1WbW3AMkGhzFDm9dv17j3QqnbB2NMxOMgpaTX6yittEP8wJT9Hs8v3Q094yWFqRRolIKFU2XwPBYscwGtq0yQXHWhy3p0e04JEj4tHFvcic4FBB0A/XChX4NEruG/9+cM8N4hUAaRdxCrhu7F/p2k8CR+/eRM+eDaQ+qWeRuWCCYwkAAJ4aLXkSGqn6gvQz8E5MFbsrJzsqxOFuuyjigeS0VfUaAglTwZ7Y+CNZIZpL5rK6Qy9annqjrqFh6IG++9ynddqWKB6UNRK5ELDls8F4CzalA58T+JzMg/mUb8Y1r3ozo1IC2Z3hznjG4mAMpE5Zaoxe9rXxnBpa9EK0I8SDBnHgd7662RPNQBaIZjj6+Hbw0BwmgHSrlRwFayADbJNv7zH7JhLsNck5g+vVjrSfO1BQA0H/ZaOZJ/FPHDJ3Sal3jShJjwb3b8gbXftxntczaO8O1kRyy4Ptvt7WD9iKK7nQbVLD72pvopJp3fO0hUsKOYRK7q+9YaOhMRw4RVfT0VGRIBhJSFxcTS6X/AQF7gdjDf+kyYtaC54oYp9ISL3NXDAM0qIV+rvWyOpdBfu3NlzZrJVruEpyYM/j31H4aaOE4B8h4hu8+hxzI8u2SvHr72m61+5YLkK+Fc99SHLOnWm3S7gE4uQWE54RMvcTaOdPJD3LJQRnX26AQyc++J3UpTnxtONd4p5vg1vnqEkfVkpOLJvT/kd1mTzGuxqN7+IUK1tRPnAQvQ66GYl9uT1WRPVMTHeaMX2arClr1DOcfxk1U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(31686004)(36756003)(44832011)(30864003)(2906002)(38100700002)(8676002)(316002)(6486002)(66476007)(66556008)(86362001)(31696002)(8936002)(4326008)(5660300002)(66946007)(83380400001)(186003)(478600001)(2616005)(26005)(6512007)(6506007)(41300700001)(53546011)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFhmelUwMk9vQjRQTlFHZEg2WnFOek1WamorQ2xlR1EwTXpnZ1dmUmY2SEMv?=
 =?utf-8?B?bURXTlpWUWRvUEllclJiTmsvc1F5VjM0ZTJ1K0JlUnFaZHIyOFYyVEJOUUFk?=
 =?utf-8?B?Y2Fjd2pGNWZlTjUvSURwRVpxMXcxcGx6aHl5WStkTm8yRWNyOXJ5YWR6UHA0?=
 =?utf-8?B?ZGNxUTRMK0x6UGN1V1JzeW03UHZCQlVjMDBzMHFIQlFBQzZ5NjEzSXJWczFL?=
 =?utf-8?B?VjRwNVpHZUxORHhtSEVoZE8wRThPSWRNRllPTGNaTENGZDlGSjNHL0cyRVgv?=
 =?utf-8?B?cHRrc2MzbGtxcWZ0dGdUREk2QXV3RzRETmc5RTcycmdyeDcvUVFwV000SVNo?=
 =?utf-8?B?SVU5emtrNHJsbGVobzVibG45cnJWZis5K3cxY2lpZGxiYjUvbUg5eG5GaTRF?=
 =?utf-8?B?VEhQTjVVVVF0eFpESE9ZenROeHZGMVAzYzZOM2hFWS8wWlJIOEVaT21Tcjln?=
 =?utf-8?B?TGhqV0lxeVdVRVovQUt2aUwzVUFXblN2U3JiL3hMaFh6ZzFBc0xGTDdKM1hm?=
 =?utf-8?B?TWE5RDZySTlrclZFSVYxZnlUcXM5UFU3S0duUFprRGlJQ01vWm4yQmdtOGg3?=
 =?utf-8?B?WGRFZnBhNkJZd21sTWZTNU1KYmlobVVyQVdRd2FoSWxDNkFTU2pGaXY2eVpl?=
 =?utf-8?B?Z1ZmMitxVU1GMjZXenRYeUhWWEtvdzFUVEFUZStLWFRYVUlXSUhJTHIvQUxa?=
 =?utf-8?B?YktoRXJVZjJWek8wcnB1b090YU5rM1d5aml4dEZJOUtmeHBwZWNpR00vRlAw?=
 =?utf-8?B?Tk4yejJpQW1lVWduaWRIQ1F6ZzhvamF5VFkrNTg3UG9TSGVkcFhXRkgzMkJt?=
 =?utf-8?B?YTk5YndRaDkydURUdGdtaU95RktKb1Z2T1RHVU4rV3ZLTWZyYmhVRy9hOEU5?=
 =?utf-8?B?RFloZ2l6bnRxNitGTng4c0kzVG42WmI5QlpWdWhEallMQ1Vsc01tSjhZZGVL?=
 =?utf-8?B?ZGdWU1VYMERoQW5FY3A1akRQd2M3Mm41VGtHalJZbFZYYUNqSm90Ylo2bWhW?=
 =?utf-8?B?aFdiMDZCRHkyK2JjWE5uUzIyNlVmWDFhU2d0TzYxMGhUaFNaRVZoM3JISG1G?=
 =?utf-8?B?cDByN0h4OUtwN2ZLRTVvNUJGNHJHczg3K3JKWGYwcThsMXpXaFgrKzZwOUJn?=
 =?utf-8?B?RVp3SkRhNDBCbVF3ZXpqY3JLb0s2WUJZckZOY21Wb2liYU95dWJzek4wMzB1?=
 =?utf-8?B?Y0lPUktpd2hwdyttN2RQVC9rVm0za1E2WU1FTXhGd2RyR0h0SXJjY0UxL1JF?=
 =?utf-8?B?ekh6TmJJTk9BU3N4bjdZK1JGekl6MFQxU2xUUkhQTjUxdktOclNrcFk2V3FC?=
 =?utf-8?B?Y2VGdithMVpJcnVHS0NOS2ozMmpORy83c2cxMldQcFpGanZuMGI1Z3FXRTdU?=
 =?utf-8?B?SmFJUk9qYm5KR0VBeFFzaVFGSUtTUGtJdDh6Z3k5UUNzWEZWdEVOdXBERlJl?=
 =?utf-8?B?dWdCdkFHSkVIMFhyQS9KSDZqTkJEMVB6THhiTXVsTHdrZ0F6cG41ODBrRUlS?=
 =?utf-8?B?NW1rc29wem51aERwVTk5Rml3T2Z6MEV6OUdaYlZCbElLR01xaGh4U0Zxay9R?=
 =?utf-8?B?Y0luQ3VQa2pqODh4dTUvN0hOSTNFVlQyd3NuQ25VS0ZDeWxLcjNvZDIwMzZW?=
 =?utf-8?B?ckhCM0VWTTRwNzU2QWZ2NzVqVDRBQXBJZjZFOWI3MjJmdGZlQ2JzYklWNllJ?=
 =?utf-8?B?QTJ1YU5JMEUwQWZmRGEvT0ZIK01Zblk3UVdNVXN6WWZzMTUxRVRhUDdkVG1V?=
 =?utf-8?B?c3VTZ0lva1FRTmgrVVVMSEdVdzVHUmZuUzdjR2ExWHpJR1MrQ1lSMW51UDhF?=
 =?utf-8?B?cW9VRFVFc0pYaCtVeFR1Nys3OW42d2wySVQ2cEE1UThZamYvMzkyckdTR29s?=
 =?utf-8?B?WGJjZkRYT1lxbVNPR1JXUDFkUDVtQnRwbi9JWlg0MGU4T0dqenNVcjJyRzN4?=
 =?utf-8?B?bjJhVmJzN0dqV0NPMm8rZGt0cFVUVEhualRhM3pSMmg1ZzBCQjdsSjZmcEhz?=
 =?utf-8?B?ak5hRXl3aUs3VXE4QjNGTFUxVHJPUXZJbXlUQVhiK3hYRXdPNVozMjhQK1Fn?=
 =?utf-8?B?RHQ1OERaU0Nra3l3elFXYzdmVDFRYmZZVVFMSXpUZUt0dVlOUWpZaFVZOW1n?=
 =?utf-8?Q?bSxFQF7a/9/yfsquzkCCe0T2t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661d0f14-ff50-45d2-6166-08da974c4aca
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 18:58:35.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbhM0J1J1QnoQdgIscn/cuf8JeKHdXHYXpuIGIqn/efsmaVa0FqkzatXiOEMI1b7/pmbwNSR/BVztnffDHl+QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
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
> Add EPP driver support for those AMD CPUs which has full MSR feature
> enabled, The EPP is used in the DPM controller to drive the frequency
> that a core is going to operate during short periods of activity.
> 
> EPP values will be utilized for different OS profiles (balanced, performance,
> power savings). cppc performance can be controlled by the user space interface
> sys attributes for min and max frequency limits, when pstate driver is
> working under power save policy.
> 
> EPP scale is 0 - 255, 0 is the max performance and 255 is min level.
> balance_performance (0x80) can provide best balance performance and watt for
> most of system, meanwhile user can choose performance policy on needs.
> 
> $ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
> default performance balance_performance balance_power power
> 
> $ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference
> balance_performance

A lot of what you do in this patch with respect to the sysfs files for
energy_performance_available_preferences and energy_performance_preference mirror
what is done in the intel_pstate driver for EPP. Would there be any value in
making these pieces common code?

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h |   4 +
>  drivers/cpufreq/amd-pstate.c     | 818 ++++++++++++++++++++++++++++++-
>  2 files changed, 804 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 43a3d8e4eb9a..4c540badab4e 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -577,6 +577,10 @@
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
>  
> +#define AMD_CPPC_EPP_PERFORMANCE		0x00
> +#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> +#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
> +#define AMD_CPPC_EPP_POWERSAVE			0xFF
>  /* Fam 17h MSRs */
>  #define MSR_F17H_IRPERF			0xc00000e9
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fff298744a8e..e71b06e20050 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -63,8 +63,8 @@ module_param(epp_enabled, bool, 0444);
>  MODULE_PARM_DESC(epp_enabled,
>                  "load amd_pstate or amd_pstate_epp (true = amd_pstate_epp driver instance (default), false = amd_pstate driver instance)");
>  
> -
> -static struct cpufreq_driver amd_pstate_driver;
> +static struct cpufreq_driver *default_pstate_driver;
> +static struct amd_cpudata **all_cpu_data;
>  
>  /**
>   * struct  amd_aperf_mperf
> @@ -76,6 +76,7 @@ struct amd_aperf_mperf {
>  	u64 aperf;
>  	u64 mperf;
>  	u64 tsc;
> +	u64 time;
>  };
>  
>  /**
> @@ -98,7 +99,19 @@ struct amd_aperf_mperf {
>   * @prev: Last Aperf/Mperf/tsc count value read from register
>   * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
> - *
> + * @epp_powersave: Last saved CPPC energy performance preference
> +				when policy switched to performance
> + * @epp_policy: Last saved policy used to set energy-performance preference
> + * @epp_cached: Cached CPPC energy-performance preference value
> + * @policy: Cpufreq policy value
> + * @sched_flags: Store scheduler flags for possible cross CPU update
> + * @update_util_set: CPUFreq utility callback is set
> + * @last_update: Time stamp of the last performance state update
> + * @cppc_boost_min: Last CPPC boosted min performance state
> + * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
> + * @update_util: Cpufreq utility callback information
> + * @sample: the stored performance sample
> +
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
>   */
> @@ -124,8 +137,195 @@ struct amd_cpudata {
>  	u64 	freq;
>  	bool	boost_supported;
>  	u64 	cppc_hw_conf_cached;
> +
> +	/* EPP feature related attributes*/
> +	s16	epp_powersave;
> +	s16	epp_policy;
> +	s16	epp_cached;
> +	u32	policy;
> +	u32	sched_flags;
> +	bool	update_util_set;
> +	u64	last_update;
> +	u64	last_io_update;
> +	u32	cppc_boost_min;
> +	u64	cppc_cap1_cached;
> +	struct	update_util_data update_util;
> +	struct	amd_aperf_mperf sample;
> +};
> +
> +/**
> + * struct amd_pstate_params - global parameters for the performance control
> + * @ cppc_boost_disabled Wheter or not the core performance boost disabled
> + */
> +struct amd_pstate_params {
> +	bool cppc_boost_disabled;
> +};
> +
> +/*
> + * AMD Energy Preference Performance (EPP)
> + * The EPP is used in the CCLK DPM controller to drive
> + * the frequency that a core is going to operate during
> + * short periods of activity. EPP values will be utilized for
> + * different OS profiles (balanced, performance, power savings)
> + * display strings corresponding to EPP index in the
> + * energy_perf_strings[]
> + *	index		String
> + *-------------------------------------
> + *	0		default
> + *	1		performance
> + *	2		balance_performance
> + *	3		balance_power
> + *	4		power
> + */
> + enum energy_perf_value_index {
> +	EPP_INDEX_DEFAULT = 0,
> +	EPP_INDEX_PERFORMANCE,
> +	EPP_INDEX_BALANCE_PERFORMANCE,
> +	EPP_INDEX_BALANCE_POWERSAVE,
> +	EPP_INDEX_POWERSAVE,
> +};
> +
> +static const char * const energy_perf_strings[] = {
> +	[EPP_INDEX_DEFAULT] = "default",
> +	[EPP_INDEX_PERFORMANCE] = "performance",
> +	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
> +	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
> +	[EPP_INDEX_POWERSAVE] = "power",
> +	NULL
>  };
>  
> +static unsigned int epp_values[] = {
> +	[EPP_INDEX_DEFAULT] = 0,
> +	[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_PERFORMANCE,
> +	[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_BALANCE_PERFORMANCE,
> +	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
> +	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
> +};
> +
> +static struct amd_pstate_params global;

I think a name more descriptive than 'global' should be used here.

> +
> +static DEFINE_MUTEX(amd_pstate_limits_lock);
> +static DEFINE_MUTEX(amd_pstate_driver_lock);
> +static DEFINE_SPINLOCK(amd_pstate_cpu_lock);
> +
> +static bool cppc_boost __read_mostly;
> +struct kobject *amd_pstate_kobj;
> +
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
> +{
> +	s16 epp;
> +	struct cppc_perf_caps perf_caps;
> +	int ret;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		if (!cppc_req_cached) {
> +			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +					    &cppc_req_cached);
> +			if (epp)
> +				return epp;
> +		}
> +		epp = (cppc_req_cached >> 24) & 0xFF;
> +	} else {
> +		ret = cppc_get_epp_caps(cpudata->cpu, &perf_caps);
> +		if (ret < 0) {
> +			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
> +			return -EIO;
> +		}
> +		epp = (s16) perf_caps.energy_perf;
> +	}
> +
> +	return epp;
> +}
> +#endif
> +
> +static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata, int *raw_epp)
> +{
> +	s16 epp;
> +	int index = -EINVAL;
> +
> +	*raw_epp = 0;
> +	epp = amd_pstate_get_epp(cpudata, 0);
> +	if (epp < 0)
> +		return epp;
> +
> +	switch (epp) {
> +	case AMD_CPPC_EPP_PERFORMANCE:
> +		index = EPP_INDEX_PERFORMANCE;
> +		break;
> +	case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
> +		index = EPP_INDEX_BALANCE_PERFORMANCE;
> +		break;
> +	case AMD_CPPC_EPP_BALANCE_POWERSAVE:
> +		index = EPP_INDEX_BALANCE_POWERSAVE;
> +		break;
> +	case AMD_CPPC_EPP_POWERSAVE:
> +		index = EPP_INDEX_POWERSAVE;
> +		break;
> +	default:
> +		*raw_epp = epp;
> +		index = 0;
> +	}
> +
> +	return index;
> +}
> +
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +{
> +	int ret;
> +	struct cppc_perf_ctrls perf_ctrls;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(31, 24);
> +		value |= (u64)epp << 24;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +		ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +		if (!ret) {
> +			cpudata->epp_cached = epp;
> +		}
> +	} else {
> +		perf_ctrls.energy_perf = epp;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls);
> +		if (ret){
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +        }

Accidental '}' not indented enough?

> +		cpudata->epp_cached = epp;
> +	}
> +	return ret;
> +}
> +
> +static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
> +					      int pref_index, bool use_raw,
> +					      u32 raw_epp)
> +{
> +	int epp = -EINVAL;
> +	int ret;
> +
> +	if (!pref_index) {
> +		pr_debug("EPP pref_index is invaid\n");

s/invaid/invalid

> +		return -EINVAL;
> +	}
> +
> +	if (use_raw)
> +		epp = raw_epp;
> +	else if (epp == -EINVAL)
> +		epp = epp_values[pref_index];
> +
> +	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		pr_debug("EPP cannot be set under performance policy\n");
> +		return -EBUSY;
> +	}
> +
> +	ret = amd_pstate_set_epp(cpudata, epp);
> +
> +	return ret;
> +}
> +#endif
> +
>  static inline int pstate_enable(bool enable)
>  {
>  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> @@ -141,16 +341,18 @@ static int cppc_enable(bool enable)
>  		if (ret)
>  			return ret;
>  
> -	/* Enable active mode for EPP */
> -	ret = cppc_set_auto_epp(cpu, enable);
> -	if (ret)
> -		return ret;
> -
> -	/* Set zero to desired perf to enable EPP control*/
> -	perf_ctrls.desired_perf = 0;
> -	ret = cppc_set_perf(cpu, &perf_ctrls);
> -	if (ret)
> -		return ret;
> +		if (epp_enabled) {
> +			/* Enable autonomous mode for EPP */
> +			ret = cppc_set_auto_epp(cpu, enable);
> +			if (ret)
> +				return ret;
> +
> +			/* Set zero to desired perf to allow EPP firmware control*/
> +			perf_ctrls.desired_perf = 0;
> +			ret = cppc_set_perf(cpu, &perf_ctrls);
> +			if (ret)
> +				return ret;
> +		}

This update to cppc_enable() should be part of Patch 4/7.

>  	}
>  
>  	return ret;
> @@ -496,7 +698,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  		return;
>  
>  	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	default_pstate_driver->boost_enabled = true;
>  }
>  
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> @@ -671,10 +873,108 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  	return sprintf(&buf[0], "%u\n", perf);
>  }
>  
> +static ssize_t show_energy_performance_available_preferences(
> +				struct cpufreq_policy *policy, char *buf)
> +{
> +	int i = 0;
> +	int ret = 0;
> +
> +	while (energy_perf_strings[i] != NULL)
> +		ret += sprintf(&buf[ret], "%s ", energy_perf_strings[i++]);
> +
> +	ret += sprintf(&buf[ret], "\n");
> +
> +	return ret;
> +}
> +
> +static ssize_t store_energy_performance_preference(
> +		struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	char str_preference[21];
> +	bool raw = false;
> +	ssize_t ret;
> +	u32 epp = 0;
> +
> +	ret = sscanf(buf, "%20s", str_preference);
> +	if (ret != 1)
> +		return -EINVAL;
> +
> +	ret = match_string(energy_perf_strings, -1, str_preference);
> +	if (ret < 0) {
> +		ret = kstrtouint(buf, 10, &epp);
> +		if (ret)
> +			return ret;
> +
> +		if ((epp > 255) || (epp < 0))
> +			return -EINVAL;
> +
> +		raw = true;
> +	}
> +
> +	mutex_lock(&amd_pstate_limits_lock);
> +	ret = amd_pstate_set_energy_pref_index(cpudata, ret, raw, epp);
> +	mutex_unlock(&amd_pstate_limits_lock);
> +
> +	return ret ?: count;
> +}
> +
> +static ssize_t show_energy_performance_preference(
> +				struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int preference, raw_epp;
> +
> +	preference = amd_pstate_get_energy_pref_index(cpudata, &raw_epp);
> +	if (preference < 0)
> +		return preference;
> +
> +	if (raw_epp)
> +		return  sprintf(buf, "%d\n", raw_epp);
> +	else
> +		return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
> +}
> +
> +static void amd_pstate_update_policies(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		cpufreq_update_policy(cpu);
> +}
> +
> +static ssize_t show_pstate_dynamic_boost(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%u\n", cppc_boost);
> +}
> +
> +static ssize_t store_pstate_dynamic_boost(struct kobject *a,
> +				       struct kobj_attribute *b,
> +				       const char *buf, size_t count)
> +{
> +	unsigned int input;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &input);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	cppc_boost = !!input;
> +	amd_pstate_update_policies();
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return count;
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
>  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_rw(energy_performance_preference);
> +cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +define_one_global_rw(pstate_dynamic_boost);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -683,6 +983,424 @@ static struct freq_attr *amd_pstate_attr[] = {
>  	NULL,
>  };
>  
> +static struct freq_attr *amd_pstate_epp_attr[] = {
> +	&amd_pstate_max_freq,
> +	&amd_pstate_lowest_nonlinear_freq,
> +	&amd_pstate_highest_perf,
> +	&energy_performance_preference,
> +	&energy_performance_available_preferences,
> +	NULL,
> +};
> +
> +static struct attribute *pstate_global_attributes[] = {
> +	&pstate_dynamic_boost.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group amd_pstate_global_attr_group = {
> +	.attrs = pstate_global_attributes,
> +};
> +
> +static inline void update_boost_state(void)
> +{
> +	u64 misc_en;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = all_cpu_data[0];
> +	rdmsrl(MSR_AMD_CPPC_HW_CTL, misc_en);
> +	global.cppc_boost_disabled = misc_en & AMD_CPPC_PRECISION_BOOST_ENABLED;
> +}
> +
> +static int amd_pstate_init_cpu(unsigned int cpunum)
> +{
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = all_cpu_data[cpunum];
> +	if (!cpudata) {
> +		cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> +		if (!cpudata)
> +			return -ENOMEM;
> +		WRITE_ONCE(all_cpu_data[cpunum], cpudata);
> +
> +		cpudata->cpu = cpunum;
> +	}
> +	cpudata->epp_powersave = -EINVAL;
> +	cpudata->epp_policy = 0;
> +	pr_debug("controlling: cpu %d\n", cpunum);
> +	return 0;
> +}
> +
> +static int __amd_pstate_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> +	struct amd_cpudata *cpudata;
> +	struct device *dev;
> +	int rc;
> +	u64 value;
> +
> +	rc = amd_pstate_init_cpu(policy->cpu);
> +	if (rc)
> +		return rc;
> +
> +	cpudata = all_cpu_data[policy->cpu];
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		goto free_cpudata1;
> +
> +	rc = amd_pstate_init_perf(cpudata);
> +	if (rc)
> +		goto free_cpudata1;
> +
> +	min_freq = amd_get_min_freq(cpudata);
> +	max_freq = amd_get_max_freq(cpudata);
> +	nominal_freq = amd_get_nominal_freq(cpudata);
> +	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> +		if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> +		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> +			min_freq, max_freq);
> +		ret = -EINVAL;
> +		goto free_cpudata1;
> +	}
> +
> +	policy->min = min_freq;
> +	policy->max = max_freq;
> +
> +	policy->cpuinfo.min_freq = min_freq;
> +	policy->cpuinfo.max_freq = max_freq;
> +	/* It will be updated by governor */
> +	policy->cur = policy->cpuinfo.min_freq;
> +
> +	/* Initial processor data capability frequencies */
> +	cpudata->max_freq = max_freq;
> +	cpudata->min_freq = min_freq;
> +	cpudata->nominal_freq = nominal_freq;
> +	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
> +
> +	policy->driver_data = cpudata;
> +
> +	update_boost_state();
> +	cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
> +
> +	policy->min = policy->cpuinfo.min_freq;
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC))
> +		policy->fast_switch_possible = true;
> +
> +	if (!shared_mem && boot_cpu_has(X86_FEATURE_CPPC)) {
> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1, &value);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
> +	}
> +	amd_pstate_boost_init(cpudata);
> +
> +	return 0;
> +
> +free_cpudata1:
> +	kfree(cpudata);
> +	return ret;
> +}
> +
> +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	ret = __amd_pstate_cpu_init(policy);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Set the policy to powersave to provide a valid fallback value in case
> +	 * the default cpufreq governor is neither powersave nor performance.
> +	 */
> +	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	pr_debug("amd-pstate: CPU %d exiting\n", policy->cpu);
> +	policy->fast_switch_possible = false;
> +	return 0;
> +}
> +
> +static void amd_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
> +
> +	if (!policy)
> +		return;
> +
> +	refresh_frequency_limits(policy);
> +	cpufreq_cpu_release(policy);
> +}
> +
> +static void amd_pstate_epp_update_limits(unsigned int cpu)
> +{
> +	mutex_lock(&amd_pstate_driver_lock);
> +	update_boost_state();
> +	if (global.cppc_boost_disabled) {
> +		for_each_possible_cpu(cpu)
> +			amd_pstate_update_max_freq(cpu);
> +	} else {
> +		cpufreq_update_policy(cpu);
> +	}
> +	mutex_unlock(&amd_pstate_driver_lock);
> +}
> +
> +static int cppc_boost_hold_time_ns = 3 * NSEC_PER_MSEC;
> +
> +static inline void amd_pstate_boost_up(struct amd_cpudata *cpudata)
> +{
> +	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
> +	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
> +	u32 max_limit = (hwp_req & 0xff);
> +	u32 min_limit = (hwp_req & 0xff00) >> 8;
> +	u32 boost_level1;
> +
> +	/* If max and min are equal or already at max, nothing to boost */
> +	if (max_limit == min_limit)
> +		return;
> +
> +	/* Set boost max and min to initial value */
> +	if (!cpudata->cppc_boost_min)
> +		cpudata->cppc_boost_min = min_limit;
> +
> +	boost_level1 = ((AMD_CPPC_NOMINAL_PERF(hwp_cap) + min_limit) >> 1);
> +
> +	if (cpudata->cppc_boost_min < boost_level1)
> +		cpudata->cppc_boost_min = boost_level1;
> +	else if (cpudata->cppc_boost_min < AMD_CPPC_NOMINAL_PERF(hwp_cap))
> +		cpudata->cppc_boost_min = AMD_CPPC_NOMINAL_PERF(hwp_cap);
> +	else if (cpudata->cppc_boost_min == AMD_CPPC_NOMINAL_PERF(hwp_cap))
> +		cpudata->cppc_boost_min = max_limit;
> +	else
> +		return;
> +
> +	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
> +	hwp_req |= AMD_CPPC_MIN_PERF(cpudata->cppc_boost_min);
> +	wrmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req);
> +	cpudata->last_update = cpudata->sample.time;
> +}
> +
> +static inline void amd_pstate_boost_down(struct amd_cpudata *cpudata)
> +{
> +	bool expired;
> +
> +	if (cpudata->cppc_boost_min) {
> +		expired = time_after64(cpudata->sample.time, cpudata->last_update +
> +					cppc_boost_hold_time_ns);
> +
> +		if (expired) {
> +			wrmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, cpudata->cppc_req_cached);
> +			cpudata->cppc_boost_min = 0;
> +		}
> +	}
> +
> +	cpudata->last_update = cpudata->sample.time;
> +}
> +
> +static inline void amd_pstate_boost_update_util(struct amd_cpudata *cpudata,
> +						      u64 time)
> +{
> +	cpudata->sample.time = time;
> +	if (smp_processor_id() != cpudata->cpu)
> +		return;
> +
> +	if (cpudata->sched_flags & SCHED_CPUFREQ_IOWAIT) {
> +		bool do_io = false;
> +
> +		cpudata->sched_flags = 0;
> +		/*
> +		 * Set iowait_boost flag and update time. Since IO WAIT flag
> +		 * is set all the time, we can't just conclude that there is
> +		 * some IO bound activity is scheduled on this CPU with just
> +		 * one occurrence. If we receive at least two in two
> +		 * consecutive ticks, then we treat as boost candidate.
> +		 * This is leveraged from Intel Pstate driver.
> +		 */
> +		if (time_before64(time, cpudata->last_io_update + 2 * TICK_NSEC))
> +			do_io = true;
> +
> +		cpudata->last_io_update = time;
> +
> +		if (do_io)
> +			amd_pstate_boost_up(cpudata);
> +
> +	} else {
> +		amd_pstate_boost_down(cpudata);
> +	}
> +}
> +
> +static inline void amd_pstate_cppc_update_hook(struct update_util_data *data,
> +						u64 time, unsigned int flags)
> +{
> +	struct amd_cpudata *cpudata = container_of(data,
> +				struct amd_cpudata, update_util);
> +
> +	cpudata->sched_flags |= flags;
> +
> +	if (smp_processor_id() == cpudata->cpu)
> +		amd_pstate_boost_update_util(cpudata, time);
> +}
> +
> +static void amd_pstate_clear_update_util_hook(unsigned int cpu)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[cpu];
> +
> +	if (!cpudata->update_util_set)
> +		return;
> +
> +	cpufreq_remove_update_util_hook(cpu);
> +	cpudata->update_util_set = false;
> +	synchronize_rcu();
> +}
> +
> +static void amd_pstate_set_update_util_hook(unsigned int cpu_num)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[cpu_num];
> +
> +	if (!cppc_boost) {
> +		if (cpudata->update_util_set)
> +			amd_pstate_clear_update_util_hook(cpudata->cpu);
> +		return;
> +	}
> +
> +	if (cpudata->update_util_set)
> +		return;
> +
> +	cpudata->sample.time = 0;
> +	cpufreq_add_update_util_hook(cpu_num, &cpudata->update_util,
> +						amd_pstate_cppc_update_hook);

Here, and elsewhere, the param on the second line should line up under the first param
on the previous line.

> +	cpudata->update_util_set = true;
> +}
> +
> +static void amd_pstate_epp_init(unsigned int cpu)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[cpu];
> +	u32 max_perf, min_perf;
> +	u64 value;
> +	s16 epp;
> +	int ret;
> +
> +	max_perf = READ_ONCE(cpudata->highest_perf);
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
> +
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +		min_perf = max_perf;
> +
> +	/* Initial min/max values for CPPC Performance Controls Register */
> +	value &= ~AMD_CPPC_MIN_PERF(~0L);
> +	value |= AMD_CPPC_MIN_PERF(min_perf);
> +
> +	value &= ~AMD_CPPC_MAX_PERF(~0L);
> +	value |= AMD_CPPC_MAX_PERF(max_perf);
> +
> +	/* CPPC EPP feature require to set zero to the desire perf bit */
> +	value &= ~AMD_CPPC_DES_PERF(~0L);
> +	value |= AMD_CPPC_DES_PERF(0);
> +
> +	if (cpudata->epp_policy == cpudata->policy)
> +		goto skip_epp;
> +
> +	cpudata->epp_policy = cpudata->policy;
> +
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		epp = amd_pstate_get_epp(cpudata, value);
> +		cpudata->epp_powersave = epp;
> +		if (epp < 0)
> +			goto skip_epp;

This looks wrong. The epp value is a s16, but reading the MSR can return an EPP setting
between 0x00 - 0xFF. The epp value returned from amd_pstate_get_epp() can be both
negative and a valid value.

Were your intentions to skip any EPP settings that tend toward POWERSAVE values? If so
I think a comment explaining this or re-working the code to make that clear would be good.

> +
> +		epp = 0;
> +	} else {
> +		if (cpudata->epp_powersave < 0)
> +			goto skip_epp;
> +		/* Get BIOS pre-defined epp value */
> +		epp = amd_pstate_get_epp(cpudata, value);
> +		if (epp)
> +			goto skip_epp;
> +		epp = cpudata->epp_powersave;
> +	}
> +	/* Set initial EPP value */
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		value &= ~GENMASK_ULL(31, 24);
> +		value |= (u64)epp << 24;
> +	}
> +
> +skip_epp:
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	if (!ret) {
> +		cpudata->epp_cached = epp;
> +	}

No need for curly braces here.

-Nathan

> +}
> +
> +static void amd_pstate_set_max_limits(struct amd_cpudata *cpudata)
> +{
> +	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
> +	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
> +	u32 max_limit = (hwp_cap >> 24) & 0xff;
> +
> +	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
> +	hwp_req |= AMD_CPPC_MIN_PERF(max_limit);
> +	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req);
> +}
> +
> +static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata;
> +
> +	if (!policy->cpuinfo.max_freq)
> +		return -ENODEV;
> +
> +	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> +				policy->cpuinfo.max_freq, policy->max);
> +
> +	cpudata = all_cpu_data[policy->cpu];
> +	cpudata->policy = policy->policy;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		mutex_lock(&amd_pstate_limits_lock);
> +
> +		if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +			amd_pstate_clear_update_util_hook(policy->cpu);
> +			amd_pstate_set_max_limits(cpudata);
> +		} else {
> +			amd_pstate_set_update_util_hook(policy->cpu);
> +		}
> +
> +		if (boot_cpu_has(X86_FEATURE_CPPC))
> +			amd_pstate_epp_init(policy->cpu);
> +
> +		mutex_unlock(&amd_pstate_limits_lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
> +					   struct cpufreq_policy_data *policy)
> +{
> +	update_boost_state();
> +	cpufreq_verify_within_cpu_limits(policy);
> +}
> +
> +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
> +{
> +	amd_pstate_verify_cpu_policy(all_cpu_data[policy->cpu], policy);
> +	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min );
> +	return 0;
> +}
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -696,8 +1414,20 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.attr		= amd_pstate_attr,
>  };
>  
> +static struct cpufreq_driver amd_pstate_epp_driver = {
> +	.flags		= CPUFREQ_CONST_LOOPS,
> +	.verify		= amd_pstate_epp_verify_policy,
> +	.setpolicy	= amd_pstate_epp_set_policy,
> +	.init		= amd_pstate_epp_cpu_init,
> +	.exit		= amd_pstate_epp_cpu_exit,
> +	.update_limits	= amd_pstate_epp_update_limits,
> +	.name		= "amd_pstate_epp",
> +	.attr		= amd_pstate_epp_attr,
> +};
> +
>  static int __init amd_pstate_init(void)
>  {
> +	static struct amd_cpudata **cpudata;
>  	int ret;
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> @@ -712,10 +1442,25 @@ static int __init amd_pstate_init(void)
>  	if (cpufreq_get_current_driver())
>  		return -EEXIST;
>  
> +	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> +	if (!cpudata)
> +		return -ENOMEM;
> +	WRITE_ONCE(all_cpu_data, cpudata);
> +
> +	if (epp_enabled) {
> +		pr_info("AMD CPPC loading with amd_pstate_epp driver instance.\n");
> +		default_pstate_driver = &amd_pstate_epp_driver;
> +	} else {
> +		pr_info("AMD CPPC loading with amd_pstate driver instance.\n");
> +		default_pstate_driver = &amd_pstate_driver;
> +	}
> +
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		if (!epp_enabled) {
> +			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
> +		}
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
>  	} else if (shared_mem) {
>  		static_call_update(amd_pstate_enable, cppc_enable);
>  		static_call_update(amd_pstate_init_perf, cppc_init_perf);
> @@ -732,19 +1477,56 @@ static int __init amd_pstate_init(void)
>  		return ret;
>  	}
>  
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(default_pstate_driver);
>  	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> +		pr_err("failed to register amd pstate driver with return %d\n",
>  		       ret);
>  
> +	amd_pstate_kobj = kobject_create_and_add("amd-pstate", &cpu_subsys.dev_root->kobj);
> +	if (!amd_pstate_kobj) {
> +		pr_err("amd-pstate: Global sysfs registration failed.\n");
> +	}
> +
> +	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
> +	if (ret) {
> +		pr_err("amd-pstate: Sysfs attribute export failed with error %d.\n",
> +		       ret);
> +	}
> +
>  	return ret;
>  }
>  
> +static inline void amd_pstate_kobj_cleanup(struct kobject *kobj)
> +{
> +	kobject_del(kobj);
> +	kobject_put(kobj);
> +}
> +
>  static void __exit amd_pstate_exit(void)
>  {
> -	cpufreq_unregister_driver(&amd_pstate_driver);
> +	unsigned int cpu;
> +
> +	cpufreq_unregister_driver(default_pstate_driver);
>  
>  	amd_pstate_enable(false);
> +
> +	sysfs_remove_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
> +	amd_pstate_kobj_cleanup(amd_pstate_kobj);
> +
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		if (all_cpu_data[cpu]) {
> +			if (default_pstate_driver == &amd_pstate_epp_driver)
> +				amd_pstate_clear_update_util_hook(cpu);
> +
> +			spin_lock(&amd_pstate_cpu_lock);
> +			kfree(all_cpu_data[cpu]);
> +			WRITE_ONCE(all_cpu_data[cpu], NULL);
> +			spin_unlock(&amd_pstate_cpu_lock);
> +		}
> +	}
> +	cpus_read_unlock();
> +
>  }
>  
>  module_init(amd_pstate_init);
