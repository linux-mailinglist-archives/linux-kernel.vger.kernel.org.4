Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AF561FD5C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiKGSWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiKGSWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:22:35 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E9F599;
        Mon,  7 Nov 2022 10:22:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry8zSf0LubbP4Xl99em62Zy6P9ppOhz5opCS+J5nk9md5WW5e4b89bOcIyrxZrncyFDRI9DOjXskuLKW3Z7qgTLtuCVnZmwrXe7rNmb7K+OMqjNstgwkEqffW4cSJLjjc8QKlruQswPqnE+Yfg88Muj+SM5f9dD4Z45aKTf9VeTAS9MzESHbafWIDiNN0FqJWkh15bj0wzTjLn/oV21EYp3Higgqg2D8DhKUj2OXzhake0VhRp60oQf1F1q+iHH5Gph+3zxVN11jw84ZRURdPXstvcKrEdMxQAmqg98eGFySsvbjoWxamM5O/ROF/Ov+6NeMJWRMeqCK47fDGwF3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKx3FdZmIrp0aZ8Id0jMTifOGQd1ePfBWQxP90VkkwQ=;
 b=lRZoutpeCh4jBLcMOU/38BqSaTctjZpeSokRQzMTgGINS0aIBhkBEXjAIjAjCWR4Sdc+rhbiD4ywi191ZUQPM9czYwWEz+kO3OcAdZOzw/g+9HU3P028IZcbJKylKSHf26gLwGUv1zyObAU1gRQo6TKHEcGGAOv6GfPwf+eqwtEL+rV+UhxBIHEqGTd3OzhDM0XRBrpcuhdxSPtw+tZFSm1ZxgHZjCOqi0qec4xyHUzGq5PT48+Ugu9clAxf28ZAZjt0xwgABHipC72Ez0mN50jiWT05g5T5dVi8eS3eV2s43NpeORVaB5BYhOk85qBed3W0IWVkIpK+aa2lohRVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKx3FdZmIrp0aZ8Id0jMTifOGQd1ePfBWQxP90VkkwQ=;
 b=Pf84E4BeUe3bNo20k3IjN/eBWXSrYxQy6o46fcImu//zXDVs2B7P4o4RiRCWjcpokAXzLjBpzLgTFt4Z4hv9O6uJw4hc1owEwSksMn+3gE5aW8QwG8Wjjzf58EY8kHPqUIF4UFapJCChnwn0SerWclJSA+2v5jEmb+qmQcjT5vI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 18:22:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:22:27 +0000
Message-ID: <6a2df432-be04-be50-392a-9a935a588822@amd.com>
Date:   Mon, 7 Nov 2022 12:22:24 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 5/8] cpufreq: amd_pstate: implement amd pstate cpu
 online and offline callback
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-6-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221107175705.2207842-6-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0037.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ce4f76-9478-4a42-1ebe-08dac0ed0685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRr8tXAGyu7ji0JrdIh3XBPIcou7v2unbj7XagdUHRHxX7A4gYrB+YWqVtHeallGUnKkLKm1b366vJBFF85NPfgazJtPCnv6moHv0ZIDERpEW2c8/otkf86n3XalfJSavCsK3ujhHEZqeVL2uOspk/YT/ooRoD4lGZh7fwqF9gEa2dsctO1CqTsNCyIW3Un8pA6XR2mxtjkOxj7gTV/wz2QPvmLk37jpjbKAxal3mKYOmsELPgz0bZfaOae8L67BPwkS1L8CMuNNlzowDiy71KiIAei4k2og6UrAGbsvzbO07pJ56FjGp7pOaBnjiTreRJ7ZZivOFFSEA9oc9+9UyJqaPGFIt7AAbVvbEVzWfpELGzXlBPXnSaKDbrX+YVoyX3S88oKT9rJewUfHNaw9uZnUjQWed13l3i6O+uSC1s7VRTuM50EZb+XSOernYLpZUK8kd2JMdAzMXfaOZ8AjYxk+eZQMvIncSHEBMxCX7Tj888sDHQ18Qv4hiNy+kYyWrvgAwb29W5GMIK9kVjL286u8ZoDkkQstz3hzH5813Gy4DdW9hc8rLhpPNxiryWMpFYBRgr3rHMVM68wbBXe4aJbeP59NNJ+2KbDlrUFZhcbeOqsGDjoLHPPNDLyYGwrvHxdXs2Oqdn5NOyVo1O5xxzBxa7rwpwzyiSuW3A6Wa1evSXdaJd5/q/HqwFnzD6tudZKMPW3k4IaygWiF4hkhMOIMErVFye2x8SExS6hs0ecNYE/gYrD2bL6FZ/ejMRo8TYnfQRwLgHJkREHnQWh8ognq5T9ElOY1RFjZok83LOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199015)(2616005)(83380400001)(6512007)(26005)(186003)(38100700002)(2906002)(8936002)(5660300002)(6486002)(478600001)(53546011)(6506007)(6666004)(4326008)(8676002)(66476007)(41300700001)(66946007)(316002)(66556008)(31686004)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1VjVG5vYUZyUENPZEFDd2J1aFc4RGFrOUNnZE5Gemt2eXlXVUtKWDJRSEEr?=
 =?utf-8?B?UXpPTVpHbWxwQTVtcTZPTGU5TUc0SEFVcWhYRHg5d0c1OVlGOHJMYms0TDkv?=
 =?utf-8?B?TElUOUdsaENFK1pKQU85M3MrZTgxQUV6ekNUZEdCUHZlRUhHNWVkUU5WVXp0?=
 =?utf-8?B?Zk5jVkxTdHBHNkJZUk03NVQzNlgvNkdqUzVQSWJCK2IwSllHeVRTV1phWHFV?=
 =?utf-8?B?b0dZakxaSzBIb05GS3FSYjB1QzA2cUMzaVZ5cFc4dFVtQkRjWktDZ0tVbmdO?=
 =?utf-8?B?M0gvVTRTaTk5c2VGOVkwb3NSRnRkRDNXUDNFTkVjOGJ6MGNWT0xrakRBcHdZ?=
 =?utf-8?B?aDFxb25IL0R6aFRBbHNvZnB2MU1zWUhPR1BqdVAxUTUzVDVFeThLNE1vdXJq?=
 =?utf-8?B?WXowakRPZ1d0SDdpSlVZV1FsN1RTN0hwZFpsV0VjYjdsOC9Na015WVl1aGdn?=
 =?utf-8?B?K01GUnRRcC9rTDlZdEs2OVlzQXo4M1h5ci9LMll3R2JXU3QxTjdwSlpWYldM?=
 =?utf-8?B?a1RYeGROdnZHVGJLVU9KVXNnbW9DUFUyajd6b0ZaYlpLOGdCNmdxK3FST3Z4?=
 =?utf-8?B?TEdLYk1UdEhEY2cyN3VnOWhWelJaa0R1MFdoUkoyV3pqSGlhckZ1VnYzc0pN?=
 =?utf-8?B?WTlaS28xZWU3ZG1zcFVPeEU1YzVnUDd6b1RmeHpESkNaMnlseDM5UHZrY1h6?=
 =?utf-8?B?TE1wZWd4aDExVm5yd2x0TEZHZjNxVUhVbDlLQjNEQnNldjY3NndWY3h4TkdY?=
 =?utf-8?B?S0JRS0ZmK0RrZjVWYytVWU9XZmZpV1MvMFhnQXYwQURmVW04enJUbE9DekZh?=
 =?utf-8?B?QzR4UzFvYnYzT0xjOUFLM1JkbFZ3RDBrNThqV1VsZklTZHlHc1lZdlBkN1hQ?=
 =?utf-8?B?OU1TSjdiSEZRNWlTWjBtd1ZGdVoyeVZYQnNQcWtRNERnRGFSVDRuM2tvRFRx?=
 =?utf-8?B?SEtzK25IN0xJVFIxZDNXL3dRQmNYM0tkS0V1Wm0xdEhUZ2E1aGJXSG1LeUNI?=
 =?utf-8?B?d1JqZEhBdWprVEw1K21FL0lrRzVyeUVNdWVzZC9OZ09VcDRoa2RubnA0OS8z?=
 =?utf-8?B?M2xiak5ER24xcEpKUExMcm1BOVA3dlFsUWZSWFFQSGRRSkVxaTBHYU8xSmt3?=
 =?utf-8?B?ZmxKYWJTUWFjZndPSlI2dTVIQllFZmM1R01zOXI2aEJDVUhuamMyaS9vVFIy?=
 =?utf-8?B?Q3ZXR2Z2NkN6SDU2YkJvZXVna2c5U3FkdExTSXdJeVdMWlp2YkZIRnA4cFJs?=
 =?utf-8?B?ZzFpaVpyejNXTkpIc3l1NHlKZEp0SGpRSmJhb2FPVjdsc002WGVndDZ3RXZq?=
 =?utf-8?B?THhqdkpiTUVibStaQkpCeW1hZm9nbk95RWtyaS8xNVNJOVB2UlJwaUxQN0Mz?=
 =?utf-8?B?ZWIxSFMrZmtYRUNMWUVCTmJOTklmZ1pzMUpLOUU0NVFwbERMN1FuN1IrT01V?=
 =?utf-8?B?NDBRRnFZeW1tOXo1cHltayt3cW5qVDBVQ1g3dDRrYlBxc2FuVVZZRk53ZUVX?=
 =?utf-8?B?MXZvT3VJSXRucllRNGlkdzBvZkx0M3RML3hkdDloMllGdDdWamRHVzVTM2pp?=
 =?utf-8?B?Mmo4djZxU1RnZFNSY2tOSXQrdGVnaHVFREc4MWd6ak8xV0ZsL3NaYm1QQ1h5?=
 =?utf-8?B?N29nZTZ5SHBZZ0VJTUJZYjhCWWFFMXhJYkpPTmZOVW4xL2x3Tm91SE0wWi9x?=
 =?utf-8?B?c2tFYXRDZHBETUowVlZiU1VDeU4yTDZzQXpZdGl3Ymg1aHZ2WksrYUllSU4v?=
 =?utf-8?B?eWtEY1Z6RWpSazFMaWFLaWsvYjRpVmRrYlI3STVQN1B3U2NsRWg5aFJJcHNJ?=
 =?utf-8?B?WG1VOGlwWW9zSWFra0xxbVBHdGZSR0h5bG5RU0FRZ0oyQmwyQ1ZSTytNalk0?=
 =?utf-8?B?NE03N0l5THBrRDBWa0t5K2xpdDNmd2U3Rml3SlFhcHovZU43TGJVTlExT0pa?=
 =?utf-8?B?bXdlOUdOdmhQSzl6cGJjL2R3elRkRHpjREJDSjBPVDZaU012YUtRL0NkR3M1?=
 =?utf-8?B?ZmJCRWFNOWd0NkIwR0l1UCtHZUl1SGNMY3I2V2EyRUU2RXM4OFJMZzh0Y1JH?=
 =?utf-8?B?RjlEVlh2TmtZNkpzaTY0MmU4NjNLamlzU1pKUTRBODYvRnh6KzllUW40RFEz?=
 =?utf-8?Q?dO1krnYpK2momNbAnnZkt1OV6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ce4f76-9478-4a42-1ebe-08dac0ed0685
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:22:27.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EbOhNeDvanl43R0MCbMgLOa/w4btur1mfF0GvkOXHkd/QS9AYIgMPmet2oVaPwjqKA7d4o5OuR4R5weLz/K+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
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
> Adds online and offline driver callback support to allow cpu cores go
> offline and help to restore the previous working states when core goes
> back online later for EPP driver mode.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 89 ++++++++++++++++++++++++++++++++++++
>   include/linux/amd-pstate.h   |  1 +
>   2 files changed, 90 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index eb82bc6a7f66..6ce9fca0a128 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1195,6 +1195,93 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>   	return 0;
>   }
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
>   static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
>   					   struct cpufreq_policy_data *policy)
>   {
> @@ -1229,6 +1316,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.init		= amd_pstate_epp_cpu_init,
>   	.exit		= amd_pstate_epp_cpu_exit,
>   	.update_limits	= amd_pstate_epp_update_limits,
> +	.offline	= amd_pstate_epp_cpu_offline,
> +	.online		= amd_pstate_epp_cpu_online,
>   	.name		= "amd_pstate_epp",
>   	.attr		= amd_pstate_epp_attr,
>   };
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 7e6e8cab97b3..c0ad7eedcae3 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -99,6 +99,7 @@ struct amd_cpudata {
>   	u64	cppc_cap1_cached;
>   	struct	update_util_data update_util;
>   	struct	amd_aperf_mperf sample;
> +	bool suspended;
>   };
>   
>   /**

