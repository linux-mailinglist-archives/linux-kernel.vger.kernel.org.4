Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C415B3F32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIITDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIITC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:02:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB5CAC24F;
        Fri,  9 Sep 2022 12:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXrYBO1cCmsLIt+3wwP/5OcwY8AGz1sDW/QRlzGHgZNsHMEo8RqkuWWxW4u4KtrCsvN2Tj5LBbxO1yBxDIy2Fj/8PzMedA2KX2SgnkXodoGnafwRzhfInUePcoEMnjVY9tXjg2mZQ5R5Phxzw+cb3+XBlLMuFPLM9399wAamh1gt39SPmoMMmJ/nmsT0Pc710YofV7kkH2M0SDCH+pCohUbByJuMYHsvDhl7n8vO6SUOvZTP0nsVIMKLXb9C83eP8Xd+kx2QNfVdQWgSH78GYtb4d7MNed57rdMdyUIUOHeD+5IGmi1mziGdib+q1Ot40Vl7m3gxopfi/Yw4PfdyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUJgCHCiMi2BozAe5LYUdvDH/lUzly3UUDzIZS0udjI=;
 b=BmFx1Rs/Ag/cs4fDsL0g4fyIyb59kW340A8eGuTP3oXJm1m8qL6LeRQCj7XOmLVTxmiV/JWgTj4QT1+GCrO0L9eb/4hlzl8pvI7bPM2B1yOIVjFioAAePkDrVsTEtcFZVvDcll+sLJ7OGZ97BidAJRPTajQF1730oRyHnq6aK+vK7k5gTWCyDP8k03KzWXotboO7h0Qvj38Q3eFXePqA/I+W5s8Vu2hzaYroeEf7YjJb3voK12YRpUxHD122L6JvpDXMiRQbUNGv+VnzDD4sv9aSjhMH2oD7SPZXKVi77uQFz92mY//aOp8WWBFNHfIPKiey30mkGyvLNyuBfbuiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUJgCHCiMi2BozAe5LYUdvDH/lUzly3UUDzIZS0udjI=;
 b=IHFOT4tewucxuDmcmJsqmTCycTHKS1cF+DOcMKydReoclcQIeuuVAD9V2xcyXSYqYItnBsun0e5Eyum//jbtMLfWYXoWlESnjGgSidf5e+tCmj7NiRKb50QkTWiRGqQ46L1PDo5O60VO5USDH5awcdQEtL+Jxvp3wgWB78NKlIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 19:02:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::8ba:6e9:9e9c:da5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::8ba:6e9:9e9c:da5%6]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 19:02:53 +0000
Message-ID: <5074afe6-96fe-0550-6772-4ed767f446e6@amd.com>
Date:   Fri, 9 Sep 2022 14:02:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 6/7] cpufreq: amd_pstate: implement amd pstate cpu online
 and offline callback
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Jinzhou.Su@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-7-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220909164534.71864-7-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:8:54::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a33769-aafc-4760-6e50-08da9295e5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+Gw7sCyMxgeKWSBu96b+zYfcqfyCQBg0I2e7pHNqrPlAr9GGMrJwCXw97K1Odg3cOkFwvLOilJriFbdKdHFG5++y7W757A2WW+RxiN42BasM+45kJl2atjbLLXgwus5RXFiubVubOuwXJcaYtCHBO5OQxtuK61faJm9x1zt7MXzItyLaFzKObq1K/asvWlvakHPW5GQcrFZOM5NfbxDIPlP3NfNOmX3d+2KJOiKwjqV+pJLCmqlflPpyJvC0+eQyfxXpzdGGtC4yx0lCQDPSxPwq1v6BHoR0R7vUkV3FE4a0Ov1FwqcX74I31yF5KOwSO5ToLl3HwZ53Au1Id4MXIpFhG/vP/++MJeoO+aAJB615Ao9QkRzbRcq573X/jwnxhPzmWnevhA0wk4gDzXzlCJhgvzKzY9EUB70nBDz5nIvtaUP6P1hF3kdTGf6MF5E6392R2IP/tKrHlrDSBzzaVggnZkO0IVmxfQrv64PVIGZ9gjza2Ebg2N9DDV4NDrZGrwI71IZb5pdii5Jk9q+4WF2GoMq8qruGT8X1Rp4yUhiMJwNGJbMClRq6tJ0ytliXMcX/rIZSxG9NvjwnzvItcgy7O9mR1tG2sAXsl33KUTqj+sNUA3S8RxpWzKKIylj6LAkZqvHdUt1hFJBsh3PMrMhMlhsqEZ/qXMLAMr8T8lHB8N1xDUrtLFV1XUTIcueeWXT9P1iSamdtwYVqDwdRFmSQHQdxmNDML9WWXGwT+JlFipsO/gNQ149o9/ydW7gkWtsTy5j0Sh4Tyr/AHKSoPy5Yp90FZc7diY6+eqFfjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(38100700002)(31696002)(316002)(5660300002)(4326008)(66946007)(2906002)(8676002)(66556008)(8936002)(2616005)(66476007)(53546011)(83380400001)(41300700001)(186003)(6486002)(478600001)(6512007)(86362001)(31686004)(6506007)(36756003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JHVzZ1V2R1MThWNjFwS2dRSWtwK0lVYm0yeFJ6aHVPNHFBZ1Zkbk5Hc1lZ?=
 =?utf-8?B?aFYrdFplVFBzaUV2bHhuVGhQc25GM01CYWI5NFVLRWRsZHNCcnNFN1NkVzRp?=
 =?utf-8?B?Tms5RG9EUzJ1UldGVXZwZlZIWUdiZjBYSXZMZG4zUXpPdFkrWmZDeFJhYlhI?=
 =?utf-8?B?Y2trOFJLYTJSUVN6a2RKVm5lcCtkUlhsUXNHSEtIVDQ0cW9PZVhaMnNUd2hJ?=
 =?utf-8?B?VUVRSkxMVitDWE9JWlFucWlqV2ljeVM0SC9xS1d6bk9QOTZPQW9xeXB2alhr?=
 =?utf-8?B?bU1qSXN0YzgzamgxMmJVZWtQSTRPRThjeVBHNzluMzZObXU2QU1pcEFSTmtI?=
 =?utf-8?B?SENncVI4VXlwaGE3cUVOZWEzR3NiQlRCSFdQVGRIMkoyN1ZGRzhxWmdySytQ?=
 =?utf-8?B?YncvQlNWYlZhTGErUUMwRlY2Q3gvc3RYcU1neHZzSm80ekVtQ2hqenBqaXhK?=
 =?utf-8?B?QWErMnNVU1pZUlVuejVSa29qc3RtZmhsU3pwM0hNSTNYNVB2bXFMd3NxL3hN?=
 =?utf-8?B?YVVXNmZ4R21jaFI1bXVadjZSODVQeXF6anhLUmRoV1NBbHZkajdKMTRDbzFF?=
 =?utf-8?B?NVRrUjNJM0svVzNoQmVSSFQxYml4eGwxTzlLUWY5S1FUdUN0V3R3Uy91MU9j?=
 =?utf-8?B?RWdpcDJ1b0hyK3BkWk9jb0xpeTFVdmt2L2M2SE9LS1o1M0NDdkNVS0hCQ3RV?=
 =?utf-8?B?S3R5ZEN0TVF5Z3IvNE1QRXlHbEV1U1FYOTZndjlIa0c1UlhoeGRaWHJyM0lh?=
 =?utf-8?B?ZDBLcXpNQzAreUFsSlYwYWp6OGYvUGNxM213SCttUGlyd1BWYlN1Vlk0bWl5?=
 =?utf-8?B?MkVrakcxVDNPdjN0NjVJbjR0bzBDQkF4Z0ExUk4yL2h4K1RicEhUMUFwNlVM?=
 =?utf-8?B?K1JId0MvSXc2S2QyYlVqTEgzS2pwUEQ4Yk5nZXdaZzdNZmgyNXR0dldqQUlJ?=
 =?utf-8?B?THlmV3cweWlBa1BjbWFnQU1SWFJ5bkxwK2xrN2k3dkhIR1I5Q3ArU041VC9k?=
 =?utf-8?B?a1pReC9tRG11c0xjQlRXcHg0cnVjcXNRU3JhSm9EcCs4UEMyMjZleW5uOEZh?=
 =?utf-8?B?eDV2NncrS0JPZHlDSWtvZVVKeHF4dTRPUEFROHBkeHZqWTBSQkwvOXFIVmQz?=
 =?utf-8?B?TmFFQXZpcnBqQjdtUlhRSkt5N0RpM2JtWEZoY2ZWREk0emZreGNyU3RvUitT?=
 =?utf-8?B?ZTlkQ01LaEV5RVNNYy9MZXdSTTVIc0tFcHRWdG1CVXYvejYrSGRBaWkrNWdx?=
 =?utf-8?B?emFmTFJVSHMzVGtoVi9mWnJCMHplNGFPRHMxY1hocTlIanlDMWNPMm9oTzd5?=
 =?utf-8?B?SDl5c3lrNE4weDcvSldXcTA4Yk5nQ1FIS0d2MUdES3pRaDZIVkpGaXdmN0Ji?=
 =?utf-8?B?b1AwVlpEakhsemJjcGJmRTZpOVFJbC9yeGpwaCtjd1l3NUNYMExFRUQxUFBs?=
 =?utf-8?B?MlhEOVpPWSswU1ZkckUveTk2M0VlZEx2QUtmTU5ML1ozSFpoVkdvbjlKZmlx?=
 =?utf-8?B?dGp3UzdLVUlySGpiSlpnUW9ydE1yMUZyQ21BSm9GK1hJamx1NzlxTTl1V2Y1?=
 =?utf-8?B?OU1NWjV3SDNEcThMSWVwRHlDblkwUk9GL1dHOGNlVGc3eTlkWWhkdWR0NVd1?=
 =?utf-8?B?VDlNTDRTb3ZzNzNkMFMxRnNHQmo0K0s0VzRudHlZVVc1ZTlzNkx0RE84SnR6?=
 =?utf-8?B?QzRDM3REMGFwZmk3V1RvcSt1K01McUU5Q3lHOWk3V0JQSy8zck1qVHlDVWlK?=
 =?utf-8?B?ZWFXZmZFQnZESE9wL1JSSGsxTUNabk94bWJLeUlkd0EwaHRma3l5Um80OEkv?=
 =?utf-8?B?SWprM0Nac0hzVHdBK3czNkNJYWsrczFHSXlTeGE0ZUI0dmFIMU9tR1hhWkpX?=
 =?utf-8?B?UGx6b3dsN2Fva0did0FHU0xLTTlxeTVnYlRMYmNBajBWMzE2L3o2aWdpN2lH?=
 =?utf-8?B?d3BXWElLdmRiWXNOeEFuMnBIUFVLcUFad3c2QlYyYkpSdFRGZ20rNXZGajUy?=
 =?utf-8?B?bCs3ZFR0UlMrQStlemlKWHJEajk2OVF6N3AvZGhVQi9LWDh5Q010Y1E1djFU?=
 =?utf-8?B?ejZYUnRCc0NpZEQ5S3duSUhUMUJ5L2EvMVdQWnFYV2grL29mc0MzNVB2MUNN?=
 =?utf-8?Q?j5zc1zR5jeh4qgBMcHTL/Rq5i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a33769-aafc-4760-6e50-08da9295e5c4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 19:02:53.0390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tX5+bK6WPZsly3CDNjvHIjzMrSfD8Nx+gxKWqkfowkuHaGltc8qpFmFCkaC67FoWPSZvFRhdHIEOgmhjTQcL+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/2022 11:45, Perry Yuan wrote:
> The patch adds online and offline driver callback to support to allow cpu cores go
> offline and help to restore the previous working states when core goes
> back online later for EPP driver mode.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 93 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e71b06e20050..e63fed39f90c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -111,7 +111,8 @@ struct amd_aperf_mperf {
>    * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
>    * @update_util: Cpufreq utility callback information
>    * @sample: the stored performance sample
> -
> + * @suspended:	Whether or not the driver has been suspended.
> + *
>    * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>    * represents all the attributes and goals that AMD P-State requests at runtime.
>    */
> @@ -151,6 +152,7 @@ struct amd_cpudata {
>   	u64	cppc_cap1_cached;
>   	struct	update_util_data update_util;
>   	struct	amd_aperf_mperf sample;
> +	bool suspended;
>   };
>   
>   /**
> @@ -1387,6 +1389,93 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>   	return 0;
>   }
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

As this driver uses pr_fmt, this doesn't need to be as verbose.  Look at 
my comments in patch 7/7 and you can adopt the same here.

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
> +	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu); > +
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
>   static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
>   					   struct cpufreq_policy_data *policy)
>   {
> @@ -1421,6 +1510,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.init		= amd_pstate_epp_cpu_init,
>   	.exit		= amd_pstate_epp_cpu_exit,
>   	.update_limits	= amd_pstate_epp_update_limits,
> +	.offline	= amd_pstate_epp_cpu_offline,
> +	.online		= amd_pstate_epp_cpu_online,
>   	.name		= "amd_pstate_epp",
>   	.attr		= amd_pstate_epp_attr,
>   };

