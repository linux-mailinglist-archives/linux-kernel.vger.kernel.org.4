Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FAD600D94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJQLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJQLRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:17:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EA95F22B;
        Mon, 17 Oct 2022 04:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRHnROnkq/DOvTx3UrjbBJ6PWv6M52V/3+jmPr+M5Xpmm7jMVhdqUxqmL5FirtGiuMwaxwh/Lou63gZjaHAWQuss9Np2uxvAGKkij+SMAfTBU8naeV2iuuaU/+ZVNQg6y13lPSI7/WvRck++quNv7UeY8in/zwBTfeeDMzVe1A13OlP+TA+KMI6nBip3OSWQWzNaAaru1w4XoS8xaey5mIRHy/OeO1JrRrEFroF94YUt83HU9PDpvU4FUgQCLZTqv8PnvZ/gxeEGJgnMuQnQJ31SgijFpFaq/W1rXMqmTub0T8D2mhFhDFfeQgux1PjbyBslki0GtDzpgm5Lr1B/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GapNIhsQWJ1/iXaK7w1OEJrMcmi1yo1MAWkbIEEhL3U=;
 b=lNsCfCqskSt887jqjCv+tz2ZTN4n8r5MonN8eGC35oIfJGhR5arkd10NoRvGH5sB5r0OxI6QZk/o0hOJI8UxnNEcnq7VdBexo4eFob+H74GdkLRQ56+2fP0KdUDXMyP7tRbzBvFNSwuHROnOMhIq9z7b+mzXcTofmscv4XUuyMJSdRUJMAdxYOhbenvgmvH3bYu5o0GzBlOaAQX45zIcxX/a+EOh/8T6O0HCQNDFJhAFEfPNlru/NfYMV8gr58dwgUTtFAvME1nwiZnGzjuN3UxdZ4VbPptl7zcGCLnVLizRomAK1ScGketlApYunP3c4R/sRQ+vQ57SDovpI4r4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GapNIhsQWJ1/iXaK7w1OEJrMcmi1yo1MAWkbIEEhL3U=;
 b=x6Fo7Klok2WNyQaPn1EwNeQ3e3pBKZ9xTovvKxh6XoUUvWq6TGso3jpsOkIt8JvtJbjrCUfUrr8HH3aLIfZBiGflMQHKPlqmIBL74G6A1eQ31RQ1L9zf1aePIss9uQwTlTReP45ias2uwW/nnxdwyjYaY2imlrKyEjxf0iMjudo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Mon, 17 Oct
 2022 11:17:29 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 11:17:29 +0000
Date:   Mon, 17 Oct 2022 19:17:08 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2 7/9] cpufreq: amd_pstate: add AMD Pstate EPP
 support for the MSR based processors
Message-ID: <Y005tHJUU0uX8ow3@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-8-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010162248.348141-8-Perry.Yuan@amd.com>
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: ff847fae-d002-4cbf-ecbb-08dab0312dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFMM5OcwgFVZs/AIjt4RiSehQ5EEqGmRu6b26oXyDTu6QsFZ7vXWvSqGOLHLfsyX52TuVcMMHtwSw85YitsO52aSwWp+Mubg6gc/EmvzwkmE7X3S3zCN81+NPcnxY6AFtAAehGTrI53CN2Tjp8SwKq4GjvXaeU25GkepJclhJ9VU2zpmwDbjrFcot359BJ+7CE/QZ4f0Y/yUfHvYM+Nk0bAmdvkX5var+OQ8RWURhYSO8fgtzmP1RYtI1XhsPhRqv9AZ9vRXQ2oNcAMzQb/SqWhBn/YTgnqlUgVC7gFxfl+GmrF5GHQQwvGHf/+ZD05a7r/XAV/YqlROPmiLKXBroDfntuAlm1BQV08uWFQQonyflCT8+bd9Lf9wWJwTSyrCBtwO2OoSnYvSFJCbqc+NU6T5wnG9c6ABwpKArY+g5lU8p9V8lW6ePsKDXROgyxaF2cI7VZQSsBLNLCHKTSt0W/ppm03JHvKDy70JfrLtV7/fxj4mZq4CUApLdykH2MG9hnQ2wvIdgd5UUmcK2l73nCJTfp4+iZPralBrlQveR1dnyFp8EeQvw7cA24q9V3OuN1cLBuOMkdPgi4B/s7dnpKMIRFFQKBkaEBj5x9uJdyZofRmTJoOyAQKQTo65fRBtDOFSrGQo3OXlqVOhL1H6JvR9/ZraEPWxg1A1XWbi9QYC9ARooSCw8d3lvg20WQ2+Qy9suEi+XNTwpqPLQijNnieAnSGK2DgCO4sR1MORuVwSAV7cFtcTJlj6PFHHX5aHmT9NbwzEQ2XeVM8RneIVhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199015)(8676002)(316002)(30864003)(478600001)(66946007)(38100700002)(36756003)(26005)(8936002)(66476007)(2906002)(54906003)(6512007)(41300700001)(6636002)(6862004)(2616005)(66556008)(5660300002)(6486002)(6506007)(186003)(4326008)(83380400001)(37006003)(6666004)(86362001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/S9s44KAHhC91rPfhOUQ9WFYf+m+50pcIP/zzu0r4Ka3s+ZmtmKe5T6MgO8O?=
 =?us-ascii?Q?3TTwm7L1HvRTo9WD5mtn2cPaPpsEmq8wBtDYYpk5BOaGINu0poC0Si7mZ/RD?=
 =?us-ascii?Q?VOXQRExblPvD6OAJCH51EsQA3lVedbCQfsaqMMgQ3mieOHizmFa01+rGenrF?=
 =?us-ascii?Q?jHtUnE2ooO4CFrMMv9jFdB2RxeNFjn4P7aC4HqqEWR/n5TT7zk0u3VDLw9Xg?=
 =?us-ascii?Q?gTuUTwsJXAK52zA2y/xjJlMAUU8r4nb/UkFGVFtBTrhYc9yw40Xq+hRNO47/?=
 =?us-ascii?Q?B3HHkY2CmD0od9DZT7CRZEGpIYPzj4IkrDycX7756di7tLL8DVFOZA6CUSxs?=
 =?us-ascii?Q?juBLCMbVMTptg3vD0Fj/xvk3umwp1xBzqHMZiZRJ86TggWsPfLwWaNu/d14H?=
 =?us-ascii?Q?NOCWKs9rwMQSpx5w4bQL+9fQPFYaNA2ngV/Jp5BHSP37f4t8GeqCgFWgBGkx?=
 =?us-ascii?Q?LhWbCTpAquNAx9rGsn0dpH0owXvfCbowrxtVL4DZnIVcSEhwLGiBVCISda5T?=
 =?us-ascii?Q?rwmQaIkUjbKX7BxaxD6Kzy8NmiDHwDLfHyPKQL+laq1AUebmBIGHdOUdi0xZ?=
 =?us-ascii?Q?eWHGfeOG/MBJqCegUSoY9FNGucdEUcj5SgoIpGnHz2xOivsoDgIDYgenxKLu?=
 =?us-ascii?Q?NgsEOQuurJkUnHhfm0V+wOvS/ggXX1xnHtxKWNayjVVpWuqvs7ABEXG6y/oH?=
 =?us-ascii?Q?g/8AeOxJCv49L4UmNMVhPnh/soNpzs4HxS71/TVSL9P61t4ubU2nGpmEjVhB?=
 =?us-ascii?Q?+Q6P6eVt99Ca4UMNT6ewaMFCi2BnPN7cuxgzt7c9krbLdvJvxKLRPudlnzK8?=
 =?us-ascii?Q?EIxjf8iDyTfN/6dxebxUPrpE+YosHcoUX5YF8UpJC7VlWmc7QF4EzzB3zQVY?=
 =?us-ascii?Q?z1LOpkP/Z31GsPqzcd45mZwHHxFtEotJxEBrKIxp6gLcyQUpvHXVWpNP5Tbr?=
 =?us-ascii?Q?3WYqNS6R+kcYhUj6lHNpu9dKwwUiu7It5dncwt0dV1p/RZd4ad9FInxkxrAS?=
 =?us-ascii?Q?5iJCjcIZ7CPKusiIi7aM8GV0FL0BF0GHmiXi1lIxQ5Qes2ss2IKFR9PKyC68?=
 =?us-ascii?Q?Qzk2OcFNUbXm7CrEOFlrD4T8JnB4tVCSCrSsQJUYlGNbY20QQXsrYamSmQVu?=
 =?us-ascii?Q?owjFe6t2efT8hDc0x+Snh/Bvs2r0UwwZzvpBSoB0UboSJWg+RkURDVIE5hF2?=
 =?us-ascii?Q?pPmJBd3MPjga6AbZgCkTbG0v1f5GAaIXdMSsfSYaE1DZRaloRDiXgTodLHJH?=
 =?us-ascii?Q?/XvOhYrg+0DLYd08IcyI9gjq2/yF9naNQENXSpFeupfT7NkAIeX0ze24Nh91?=
 =?us-ascii?Q?X44p0XtG38dFX172JMIBzRlXKj0FH2YJ7CdvlYu5n16qJff9cwMN2+tYWIPF?=
 =?us-ascii?Q?g7JflSwkc31Fikg5t2dJdYE84Pz4fHPTmHAQOmAvy0mbFVOVPrawNJesFfqq?=
 =?us-ascii?Q?nRP8uqP7lYeniXz+8CGhpbQdhHSXc8u7uX2aZDXpdA8XLTqPlOC6NlLwcilW?=
 =?us-ascii?Q?5XdpIEtd+l6SQwQXslRUr9ljw+0J8TRcKWSa1fMw1yXQVslTdMqIGd69HFoU?=
 =?us-ascii?Q?ORKYT2XS2njR0UAaIBEVfPZ9zdY0oD+WAUKFM00W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff847fae-d002-4cbf-ecbb-08dab0312dd3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 11:17:29.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpLmskzIJK5r3cplEU0XTwGQWurtE+gM6oA9mPqqTYHUfUeMqQ7/XvLDPDgYVxGWL9tQ+z5ww5KhMnKfe7xVhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:22:46AM +0800, Yuan, Perry wrote:
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
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h |   4 +
>  drivers/cpufreq/amd-pstate.c     | 795 ++++++++++++++++++++++++++++++-
>  2 files changed, 792 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index e5ea1c9f747b..53cbdb0c522b 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -588,6 +588,10 @@
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
>  
> +#define AMD_CPPC_EPP_PERFORMANCE		0x00
> +#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> +#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
> +#define AMD_CPPC_EPP_POWERSAVE			0xFF

Please move this definitions into amd-pstate.c. Even on shared memory
processors, we still need this macros as well. They are not MSR specific.

>  /* Fam 17h MSRs */
>  #define MSR_F17H_IRPERF			0xc00000e9
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 08f9e335f97c..58418808aadf 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -67,7 +67,8 @@ static bool epp = false;
>  module_param(epp, bool, 0444);
>  MODULE_PARM_DESC(epp, "Enable energy performance preference (EPP) control");
>  
> -static struct cpufreq_driver amd_pstate_driver;
> +static struct cpufreq_driver *default_pstate_driver;
> +static struct amd_cpudata **all_cpu_data;
>  

Why do we need a global all_cpu_data here? We can get the cpudata from the
private data in cpufreq_policy.

>  /**
>   * struct  amd_aperf_mperf
> @@ -79,6 +80,7 @@ struct amd_aperf_mperf {
>  	u64 aperf;
>  	u64 mperf;
>  	u64 tsc;
> +	u64 time;
>  };
>  
>  /**
> @@ -101,7 +103,19 @@ struct amd_aperf_mperf {
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
> @@ -126,8 +140,197 @@ struct amd_cpudata {
>  
>  	u64 	freq;
>  	bool	boost_supported;
> +	u64	cppc_hw_conf_cached;
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
> + * @ cppc_boost_disabled wheher the core performance boost disabled
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
> +enum energy_perf_value_index {
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
> +};
> +
> +static unsigned int epp_values[] = {
> +	[EPP_INDEX_DEFAULT] = 0,
> +	[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_PERFORMANCE,
> +	[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_BALANCE_PERFORMANCE,
> +	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
> +	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
>  };
>  
> +static struct amd_pstate_params global_params;
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
> +
> +		ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +		if (!ret)
> +			cpudata->epp_cached = epp;
> +	} else {
> +		perf_ctrls.energy_perf = epp;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls);
> +		if (ret) {
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +		cpudata->epp_cached = epp;
> +	}
> +
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
> +		pr_debug("EPP pref_index is invalid\n");
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
> @@ -496,7 +699,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  		return;
>  
>  	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	default_pstate_driver->boost_enabled = true;
>  }
>  
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> @@ -660,10 +863,108 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
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
> @@ -672,6 +973,424 @@ static struct freq_attr *amd_pstate_attr[] = {
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
> +	global_params.cppc_boost_disabled = misc_en & AMD_CPPC_PRECISION_BOOST_ENABLED;
> +}

The legacy HW_CTL register is used for legacy ACPI P-State that I mentioned
before. We cannot mix them up with the CPPC driver.

If you encountere any problem, we should handle this in the firmware.

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
> +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> +		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> +				min_freq, max_freq);
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
> +	if (global_params.cppc_boost_disabled) {
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
> +			wrmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +						cpudata->cppc_req_cached);
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
> +		/* force the epp value to be zero for performance policy */
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
> +	if (!ret)
> +		cpudata->epp_cached = epp;
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

Could you please explain why do we need the update CPU utilization here? I
know Intel has the similar implementation, but why do we need them?

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
> +	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
> +	return 0;
> +}
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -685,8 +1404,20 @@ static struct cpufreq_driver amd_pstate_driver = {
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
> @@ -701,10 +1432,24 @@ static int __init amd_pstate_init(void)
>  	if (cpufreq_get_current_driver())
>  		return -EEXIST;
>  
> +	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> +	if (!cpudata)
> +		return -ENOMEM;
> +	WRITE_ONCE(all_cpu_data, cpudata);
> +
> +	if (epp) {
> +		pr_info("AMD CPPC loading with amd_pstate_epp driver instance.\n");
> +		default_pstate_driver = &amd_pstate_epp_driver;
> +	} else {
> +		pr_info("AMD CPPC loading with amd_pstate driver instance.\n");
> +		default_pstate_driver = &amd_pstate_driver;
> +	}
> +

The pr_info can be handle with one line like here:

pr_info("AMD CPPC loading with %s driver instance.\n", default_pstate_driver->name); 

>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		if (!epp)
> +			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
>  	} else if (shared_mem) {
>  		static_call_update(amd_pstate_enable, cppc_enable);
>  		static_call_update(amd_pstate_init_perf, cppc_init_perf);
> @@ -721,19 +1466,55 @@ static int __init amd_pstate_init(void)
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
> +	if (!amd_pstate_kobj)
> +		pr_err("amd-pstate: Global sysfs registration failed.\n");
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
> -- 
> 2.34.1
> 
