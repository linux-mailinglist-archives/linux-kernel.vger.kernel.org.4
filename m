Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9E61FF94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiKGUcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiKGUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:32:28 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A529345;
        Mon,  7 Nov 2022 12:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHfjw8s8LhQjOjghX8qz/MMSI3bq9b/ZfJvaqOlJ3pkd8x8nUhyU4eEgrclp8cI28LLtWY9jrW60tirb1SwiNPtFxKJkpExXMzKZQ1NNRvpUSjNSC/AyvPr9GP6n61khPhaLtgKWq/wMPnNIVIltozybznPdcEGTLSB2z7t/hhmid6tG4pxPVtVDt4hHywg5MKbYxTQHxwSilRzY7z1xHcT+2ewHmQIWIFsrWCC2ynLjywZP8VBsKoZ5ojXwIQBbPFP0zcGyQ5muVaAD6d6OrmnEtpqRgmkPwM/99+nDK+s+asJdLwv07x6Pp1iuLeGxg4+K91Lqp2uF+evVuKzJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o2ZdnGUNy9Z1bWEeCSSfe3MRhAi+ZHDLfbW7SDeoSQ=;
 b=EbXIar+PdHWAXwsA69SmURdklDNlZfDiP6rUOhsCsSWcDkde+/vB5mhUVYnwALXztPy0maCwNqPbmYFGsT8Q32qSQuIjmRT5bfb6SLOvyypRdlmMueWGfRqIAbkJszvaFVFa5ZBpmk+C3RGdT/KJCEVGaAlkEz7HaaF2Cx16nQge6IFXc+LXbQhdj8y4i3y4NOi7jFjwmktGzC9RRWOQSzrepb5UoIhPzf4Bo52uGKEnBR/ErSz5yyNoqG44533MMq9WT1EC6CN6fc8lcPOA4kuwh/AOoRh564b8KvqSSa3vbDiXmnJiuAnJGMKH/lDLzSTwL69+t7TAVkfIUe7NRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o2ZdnGUNy9Z1bWEeCSSfe3MRhAi+ZHDLfbW7SDeoSQ=;
 b=mVK9YhpnpWNYcP0QRnzQbtJa004+uCf9J0NmmY7kgJU3xYZ+STWtI5stdKXDos0d2ZdyHADsaRpwimgLUCn3BNLFUnnwlZirV1RW+Rf8zqXWF+SnnshFCPTjZMUChBVhAGc/BG7GMQaUDqgHa/0PqK+sSlmMi1Z65ZJA00PR8us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 20:32:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 20:32:23 +0000
Message-ID: <4ea6a91b-e91b-d373-8415-ebac42acd615@amd.com>
Date:   Mon, 7 Nov 2022 14:32:19 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 4/8] cpufreq: amd_pstate: add AMD Pstate EPP support
 for the MSR based processors
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-5-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221107175705.2207842-5-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0046.namprd14.prod.outlook.com
 (2603:10b6:610:56::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: 53357da1-0235-47d2-b56a-08dac0ff2cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6EcCNpiTKBDQduYg/yKYT4vZZZdtjG2jMzD6KiJbbRuRw7yhdIrVyb4poWgW2fsLIsMtqKgkA2sbYZjrCmltV33jNH7RhGfia7pmjl5eQuwxbzTGlBlIwQVCWWJc5zwJ6KnKlr4oArPWlQcFINLlZ3iG7lQo8RZZGYeJ8SR/I/+JWkQzWTQCur8i1G4Iap1JJ6aXgUqSS9VWtPdiJc3L/0Kqp87SsOEVa2gloQ55VdIvjUxvzLuAsFDozQ6/gsDeUQYWAxGO3f+ob1UNdhmFWPhKme9T1hg2NO/9+M+S18tEk22skPdJr7NdBl0j6JQBYwuvk1fjrmCAfnvuTPpSjXXVxWV/D9KMGvuhGrm8cwTqOHSZR/QH13p4xCwJBNi9SHltbUG/ESY7AkEvl8t/gzcNKIOnpmV2/nPt9gIc735SytCtiOe6FpCLRkMQOmNto1JxBFLPBevhewYTo9Q6+6FxCjGmxn1J0aAmOqqg7OKZr+gjHWNCO1FGldbxNmJ7IP+fgTfsHXpfvGAD56M4vPqw5JBMVLEq0yzlYVyD0FoipGIzMJ0lmST79po866+UrZOTzDKP6zhi8VDndV0gkykuYdKQDZ+tSQgYz29sDZY7ggl1rwC6Lm1avY4p5sjPC5K6AlBOUynMBclz7QBX5RIgPPDS4OWWmJ1xr/ir5HCGsmlEoR2eFsE5y03BW4cP1wpqgDqsgzDqKSXKgKDqqYux3dkKqH/wrhtVQLfXYc45WBFsdAlN+4J+BOjIuzk69EoDgTGva/umYi8sXH+xa5UyopgtULnUKsvy7Rb0Ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(4326008)(8676002)(5660300002)(6486002)(478600001)(66556008)(31686004)(2616005)(66476007)(30864003)(186003)(8936002)(53546011)(83380400001)(6666004)(38100700002)(2906002)(316002)(41300700001)(6506007)(26005)(6512007)(66946007)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnMxNnJHdEtSdHgrVVlZZnhMS0g4YVlialhETldaSDBhc0tOTXZYZStFKzZz?=
 =?utf-8?B?TDZVU3FVbExxVkVjZlBsRkF4NytYQmRRZ0JubHpRekFoN0oyTFczOG9yT3lU?=
 =?utf-8?B?ZjlQMzVIM3pVQ2RsdGFydkdVdTA4UFpMZ1hGdG9Xd1lybWdsK0ZtelBqZ2FM?=
 =?utf-8?B?aUJjbUpXdCtTMlZiSTBHdURWdkl4VTBVeEdWVVdKYzJKbjBXOG8rU290enRT?=
 =?utf-8?B?RVBzenliUXNzR0RGNUVSdGlQNmRCMmwrT1o3VTY3bytpUnZOM0RtQm9mWm9R?=
 =?utf-8?B?WUJvb1hoVzBRWG1CK3crdXQrR0hoait3L0lZYmdndXI4eERpeEFKNGh1ZWt2?=
 =?utf-8?B?QWYwRGUxYmUrTjJLY0gxd0N1bklydHhzbFJ2TVFYZGZ3MGRlV2ZLOUlHaDB0?=
 =?utf-8?B?aFM0bXN0VHd4c0xXM0lHak9NRVpIblZVcVo2NjlIUzVjSndUb1k3RDllR1h4?=
 =?utf-8?B?aUp2SjNhMklrTXpCRDNNU3dFZzVXd2lyOU1Nb296QnNLeE53d24vUXNKQWQ3?=
 =?utf-8?B?aitTeXBQVkU1dDVqb01ybGNxbmpwSysxMzdUQkxVd1Fmb3pZdW92RHJSaVhj?=
 =?utf-8?B?LzZVZ1J1RkZIalA5OGROSW1OeTlKY2dIbXlxN2w1NU5oN1l0NFdFUnRqRlpF?=
 =?utf-8?B?WEF6aDZYNnNFOURWeHdIekFnT01uZXFWMzRqYnBwZkp5SEtJS1p0dUNzU3lQ?=
 =?utf-8?B?emQ0WVJOcGcrUnp6S3h6Wm8rS0M3N0I0ZUdRYlcrQ3ZGZkFJUUtVTTdXYUVZ?=
 =?utf-8?B?aXZGTEw2NkRWSDU2cDc1UWVJM0o2dTRLQUZNU3ZBeEhCTkQ2c1FEakkzb2pJ?=
 =?utf-8?B?SFhGL1AvbHVlMW9DTEVzQmRRYUtZc2t4R0JOUzRNaXZCdVI5OTVLL1UrUmR3?=
 =?utf-8?B?WGZ6ZTBnMHZpTkg4V29WRGgrUjQ5YWJFUXFwNFpObXlzUmF0TlBpWVRKMXI2?=
 =?utf-8?B?WjhLZ3JFcjJXOWxFcFp5ZTA1NHJucHVPZzVhSEJvVnVxdVdKZldSVmlFcHd0?=
 =?utf-8?B?ZFZ1UVdMYThacGFKWFpqYkdGTlpSRGVSbDRkcmtLNDNFTDhWNFBVbWtwT1Z3?=
 =?utf-8?B?bnRlam1Jc2lKQitSSDl5K3dzeWRjZUlBWjF0ckhMZnF4ejJ6ZzNoQWNTL0Rr?=
 =?utf-8?B?TFB6VkJQOGc4SWlCMEt1SXZrK0J5YWVNVmJZRG91WWViZ0RHU1RpUCttRWMr?=
 =?utf-8?B?RkEwSGU4SVJsdjRYSUNaZG1jTWUwYjVHbllZM0VXYjhkK2R6eTBlUDJiMG9Q?=
 =?utf-8?B?ZURkbFlIb1gwVXRBMyt5TWFrMjNIeUp0ei8vUmUzaE1FVDJYRjNvRncyVWJD?=
 =?utf-8?B?OWlqeG5EVk8vRWh5RVQrRVRkR3pIVHdJaHhOeGFsM29VL3d1WG11ekE4WXl2?=
 =?utf-8?B?K3dCcXVFMWpkQkphL1psL0g2N0dUeC92a1Y3aURDOGZkeFNCOUVtakRqcG8x?=
 =?utf-8?B?MmZqRU1ESkcxN3JibUZlYlJSQysxUmJJZGkzQjVuTDY0VEdRQWlIMEc2WWxW?=
 =?utf-8?B?SXFtSTdLUHJRMnM3THZNN2FPRko5K2JFb3VHdjFhSlRBQmJNaFl5TmZsbUR0?=
 =?utf-8?B?eloyelVJZ3NWUzBtT09nZlRpU1VXRzhVQnlvZmdIL1puSkloeHJXOFdCZk85?=
 =?utf-8?B?QnZFMGt0SitFK2w1bFhQa3piUERydkRaUkg4cjFWSGU2NzdISFAzL0k0OGRp?=
 =?utf-8?B?STJEUVYzb00xbVo3RzhxSVVLY1Y3ejFxekpGTzh2b0ZUandQRC90TjhkejYy?=
 =?utf-8?B?WVVXcXN4QmJFUDFJNHUwbmNrR1FQY2phTURIQzM1YW8yaVZ6b0FlcUhtRm9q?=
 =?utf-8?B?c0F6QnlKOVdHODlmWGU1MkZzOUdCU2hzU3B5RVhVeUdaTlk5V0xRVVB6c1Vp?=
 =?utf-8?B?V1pqbXFiVU9SYlFHbHZ5czZ1SjEycDhkbG5NamRvWVc2Vkl6THAxcDZnWmp5?=
 =?utf-8?B?RjZKNzZKTGx1N0xrZGY2OENka1JyK2lBZUhrYUJCMDFTeHV0TmJCaldKdzNh?=
 =?utf-8?B?S1FKZm8vQnJGeTBRcHMxaFlGbWdTN002VUJ3QktEcEtZY09tMW1aM0NpcStJ?=
 =?utf-8?B?bDZCbm9HZHZkSHZmSTUxek45RnpETms2WHJsekVQbTFHYjRla1N1REIwcTN2?=
 =?utf-8?Q?+/5D63ESGWJr3zpJ/iE/x/9k9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53357da1-0235-47d2-b56a-08dac0ff2cea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 20:32:23.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AK0rGCLn/Ik2D4y0Jd4B1Sjl6w1egXv47+sA+IujeXK4IBcN4Sfh8nyLGUCxYYrHxaX+QfHddjKn81ppuBjzhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 11:57, Perry Yuan wrote:
> Add EPP driver support for those AMD CPUs which has full MSR feature
> enabled, The EPP is used in the DPM controller to drive the frequency
> that a core is going to operate during short periods of activity.

To avoid the run on sentence, here is a different wording proposal.

Add EPP driver support for AMD SoCs which support a dedicated MSR for 
CPPC.  EPP is used by the DPM controller to configure the frequency that 
a core operates at during short periods of activity.

> 
> EPP values will be utilized for different OS profiles (balanced, performance,
> power savings). cppc performance can be controlled by the user space interface
> sys attributes for min and max frequency limits, when pstate driver is
> working under power save policy.
> 
> EPP scale is 0 - 255, 0 is the max performance and 255 is min level.
> balance_performance (0x80) can provide best balance performance and watt for
> most of system, meanwhile user can choose performance policy on needs.

As a user reading this message it is confusing that there are values and 
then there are strings, but you don't know the linkage between the two. 
My proposal for rewording this:

The SoC EPP targets are configured on a scale from 0 to 255 where 0 
represents maximum performance and 255 represents maximum efficiency.

The amd-pstate driver exports profile string names to userspace that are 
tied to specific EPP values.

The balance_performance string (0x80) provides the best balance for 
efficiency versus power on most systems, but users can choose other 
strings to meet their needs as well.

> 
> $ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
> default performance balance_performance balance_power power
> 
> $ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference
> balance_performance
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 658 ++++++++++++++++++++++++++++++++++-
>   include/linux/amd-pstate.h   |  81 +++++
>   2 files changed, 734 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 14906431dc15..eb82bc6a7f66 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -60,8 +60,136 @@
>    * module parameter to be able to enable it manually for debugging.
>    */
>   static bool shared_mem __read_mostly;
> +static int cppc_active __read_mostly;
> +static int disable_pstate_load __initdata;
> +static int epp_off __initdata;
>   
> -static struct cpufreq_driver amd_pstate_driver;
> +static struct cpufreq_driver *default_pstate_driver;
> +static struct amd_cpudata **all_cpu_data;
> +
> +static struct amd_pstate_params global_params;
> +
> +static DEFINE_MUTEX(amd_pstate_limits_lock);
> +static DEFINE_MUTEX(amd_pstate_driver_lock);
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
>   
>   static inline int pstate_enable(bool enable)
>   {
> @@ -71,11 +199,25 @@ static inline int pstate_enable(bool enable)
>   static int cppc_enable(bool enable)
>   {
>   	int cpu, ret = 0;
> +	struct cppc_perf_ctrls perf_ctrls;
>   
>   	for_each_present_cpu(cpu) {
>   		ret = cppc_set_enable(cpu, enable);
>   		if (ret)
>   			return ret;
> +
> +		/* Enable autonomous mode for EPP */
> +		if (!cppc_active) {
> +			ret = cppc_set_auto_epp(cpu, enable);
> +			if (ret)
> +				return ret;
> +
> +			/* Set desired perf as zero to allow EPP firmware control */
> +			perf_ctrls.desired_perf = 0;
> +			ret = cppc_set_perf(cpu, &perf_ctrls);
> +			if (ret)
> +				return ret;
> +		}
>   	}
>   
>   	return ret;
> @@ -418,7 +560,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>   		return;
>   
>   	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	default_pstate_driver->boost_enabled = true;
>   }
>   
>   static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> @@ -582,10 +724,74 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>   	return sprintf(&buf[0], "%u\n", perf);
>   }
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

What's the reason for supporting putting the raw number in here for 
stuff "in between"?  I think this is going to pretty confusing to 
userspace that you can use string values or integer values.  It also 
means that if userspace writes an integer with a mapping to string and 
tries to read it back they'll get the string rather than the integer!

I can understand using the raw values for internal characterization and 
development to possibly introduce a new mapping string, but I don't 
think that makes sense in the kernel.

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
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
>   cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_rw(energy_performance_preference);
> +cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -594,6 +800,415 @@ static struct freq_attr *amd_pstate_attr[] = {
>   	NULL,
>   };
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
> +static inline void update_boost_state(void)
> +{
> +	u64 misc_en;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = all_cpu_data[0];
> +	rdmsrl(MSR_K7_HWCR, misc_en);
> +	global_params.cppc_boost_disabled = misc_en & BIT_ULL(25);
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

Drop the "amd-pstate:", this file has pr_fmt.

> +	policy->fast_switch_possible = false;
> +	return 0;
> +}
> +
> +static void amd_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = policy = cpufreq_cpu_get(cpu);
> +
> +	if (!policy)
> +		return;
> +
> +	refresh_frequency_limits(policy);
> +	cpufreq_cpu_put(policy);
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
>   static struct cpufreq_driver amd_pstate_driver = {
>   	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>   	.verify		= amd_pstate_verify,
> @@ -607,8 +1222,20 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.attr		= amd_pstate_attr,
>   };
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
>   static int __init amd_pstate_init(void)
>   {
> +	static struct amd_cpudata **cpudata;
>   	int ret;
>   
>   	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> @@ -623,10 +1250,18 @@ static int __init amd_pstate_init(void)
>   	if (cpufreq_get_current_driver())
>   		return -EEXIST;
>   
> +	if (!epp_off) {
> +		WRITE_ONCE(cppc_active, 1);
> +		if (!default_pstate_driver)
> +			default_pstate_driver = &amd_pstate_epp_driver;
> +	}
> +	pr_info("AMD CPPC loading with %s driver instance.\n", default_pstate_driver->name);

This is pretty noisy, do we really need it on every boot if we can 
easily check it from sysfs?

> +
>   	/* capability check */
>   	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		if (!cppc_active)
> +			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
>   	} else if (shared_mem) {
>   		static_call_update(amd_pstate_enable, cppc_enable);
>   		static_call_update(amd_pstate_init_perf, cppc_init_perf);
> @@ -636,6 +1271,10 @@ static int __init amd_pstate_init(void)
>   		return -ENODEV;
>   	}
>   
> +	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> +	if (!cpudata)
> +		return -ENOMEM;
> +	WRITE_ONCE(all_cpu_data, cpudata);
>   	/* enable amd pstate feature */
>   	ret = amd_pstate_enable(true);
>   	if (ret) {
> @@ -643,9 +1282,9 @@ static int __init amd_pstate_init(void)
>   		return ret;
>   	}
>   
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(default_pstate_driver);
>   	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> +		pr_err("failed to register amd pstate driver with return %d\n",
>   		       ret);
>   
>   	return ret;
> @@ -657,6 +1296,15 @@ static int __init amd_pstate_param(char *str)
>   	if (!str)
>   		return -EINVAL;
>   
> +	if (!strcmp(str, "disable"))
> +		disable_pstate_load = 1;
> +	else if (!strcmp(str, "active")) {
> +		default_pstate_driver = &amd_pstate_epp_driver;
> +	} else if (!strcmp(str, "passive")) {
> +		epp_off = 1;
> +		default_pstate_driver = &amd_pstate_driver;
> +	}
> +
>   	/* enable shared memory type CPPC ,if you processor has no MSR, you have to add this
>   	 * to your grub to make cppc driver loaded successfully.
>   	 */
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 1c4b8659f171..7e6e8cab97b3 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -25,6 +25,7 @@ struct amd_aperf_mperf {
>   	u64 aperf;
>   	u64 mperf;
>   	u64 tsc;
> +	u64 time;
>   };
>   
>   /**
> @@ -47,6 +48,18 @@ struct amd_aperf_mperf {
>    * @prev: Last Aperf/Mperf/tsc count value read from register
>    * @freq: current cpu frequency value
>    * @boost_supported: check whether the Processor or SBIOS supports boost mode
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
>    *
>    * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>    * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -72,6 +85,74 @@ struct amd_cpudata {
>   
>   	u64	freq;
>   	bool	boost_supported;
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
> +#define AMD_CPPC_EPP_PERFORMANCE		0x00
> +#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> +#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
> +#define AMD_CPPC_EPP_POWERSAVE			0xFF
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
>   };
>   
>   #endif /* _LINUX_AMD_PSTATE_H */

