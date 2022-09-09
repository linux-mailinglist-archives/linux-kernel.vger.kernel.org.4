Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DE55B3F30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIITBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIITBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:01:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91270BC80F;
        Fri,  9 Sep 2022 12:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs+n7B1k5ixSFsetLmknxs1Kgzyy7sfnZAXExNmS+7OAUtvXHC46HsDVpVtRIMMEyfqOdiWhV/Vh4oiFLx4kyFEvIExRabdkLMvj3XVI6XA2qG/XDl4+GlTVAK1ylemDmlXPo/1rdTTyOPq9tDF8L1UBBxG3P27T1aHoyXkJG83U+f0u/Iex82uEzwzKBsHPS4HmsNBYY/Yp+WPMNJTyvdTt8b6/ULQUY1cJ/t5c9GiO5COO2fMyLRk31czXDMyBA7YftoZkAyVG6tP9JlzBziJT6ia5Z/YFQk3rZSZXW1SF3z4VOiSNFRqOVcq0XrQZ8MRUq3f5O/+Ymc/q+bqmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfWK2EFh5snp4/aPa3JhtinnlZmARNs/zpUnFWwjiY8=;
 b=TGDU+u2y7m/jIU79fCkYXd9SklZQtpEU0CIpI1tBmZF5BRPlHUAT3sIDDgXXqNukpzWtzaqPbnWrfYkEy1hOClYC8+8IHu3u3Fp9io5t1G+a4fx1I5E+limhHpXzH89759jvGEO6vgEeEMMJmGqqu9u+obHlJzjr6oRrDh93M51QlqaMbhzp757jC+l4V3F/B4EW/qauJAZgwKSS0QbL55oaFtkQQHY6ZcL43S7/xXUkgzP1caCJPn5w1LuaRm3kFrpwBmGyoXAp4a/NZSxPlRqwU6/7rzRgl3r6J8Fj/geZ6gQf9aM2MLKJy0NJ7+J19g7RPX2QVvJlJw6VoJ8zoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfWK2EFh5snp4/aPa3JhtinnlZmARNs/zpUnFWwjiY8=;
 b=yr76Wkt0Arbm0jr2xVJcXO4rhbwSRffL3SIpRUoZW3cc9/NmAje79g9yNDqHqNJBajITshBxoRHFgXl/EwVQbAZr/MYH8rJ30Ob7D7PykZHnCiK0Jv0NP9VxkANMrEAZaeK8YQGV7tAe1zYQXZJFa4UpgA2kEafPr6OWKnr7Q98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 19:00:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::8ba:6e9:9e9c:da5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::8ba:6e9:9e9c:da5%6]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 19:00:55 +0000
Message-ID: <934c7784-4af6-04f8-cf2b-83123942ae7d@amd.com>
Date:   Fri, 9 Sep 2022 14:00:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 7/7] cpufreq: amd-pstate: implement suspend and resume
 callbacks
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Jinzhou.Su@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-8-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220909164534.71864-8-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:5:333::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e878ec8-8d01-46d8-bfd8-08da92959fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ule7AFv2DLEBVFyxXuZtj+mu9/Ojtj0TJCudJQbkTbMh68GFPteDAfR9TYzmdgyUvnjZXJE9pLKPmudt1QKO2KADIWBiN6JjeDQ8EoDDofsbAjFuvP0bU9rCjaVNwET2AyvteTm0aoqsF+6MoB0Lb8ntC2LnPbYmNxLGSOs0QVrakd1k70vEXCqUHkvCdLy6pVO2Rt02pjA5nA6WPde1upe5yg17FSMDxMrRJeRS175j1gQe35SuKe3m2rTCpr0D281MikX3Z2ibBr2ZrFhFuwAScYoLYJt22anIiRcObJUx6lbK2SgTc1jdoZaOIQVrD+NphHtH6rR5pNqs4ADdvBLKcAmQXL9sTaXQukZjR3XOmMhIn9pCoYcFOI1s3PInKjQQQRnjWRVnLT1YBgTBOZrYeDylRGz0cLnbCuO3cM09EmVIbGfqKDqYiD4cozKb0pcikNh23Xh/yFi7i6aVpIbiGAnuSaMBFq9G8Arr/fJMvpI293DIYGFhiNSLopLA6lShlNEfeFbo5x9UrGs6v/0X168BTpWs4Uuajd8TworoYbkVpx+89SHwLCY9BU3XSb+yIvEXuczKoE3oXZMYOYW1CXKf8zYk5RkM7eFyc0NI9XtQAbpGt1ylVhM3stRK7mctniPElr6E3R9ef0le8BmdOA7jKIwHAbAEGpfy/9pQkPu1aaatwKLWvbHiE5PrfNQ5XvEUcXlML6s8B6yqjCL65EZ2Q6GjGSFD6H98sJenqzqFZAoGQU9hZpSRcOvfYOPLNQiKNDjp/8VKGO+khujlVpUGx53+hqp6UTEaud4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(186003)(53546011)(2616005)(41300700001)(26005)(478600001)(6486002)(31696002)(6506007)(6512007)(86362001)(38100700002)(83380400001)(5660300002)(31686004)(4326008)(316002)(66946007)(66476007)(8676002)(36756003)(15650500001)(8936002)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJOM0tESnNTdEJ2ZEJxWDZkV2M2UjNaR2hUcG9hTkdCZTZ4MVhOUHJHZ2x0?=
 =?utf-8?B?c1J4Qm9RQktSd0NqZVdLRnVod0dlR2FpK3I1QXlXbTY4THBubDJmOHVibmxG?=
 =?utf-8?B?ZS9JdVRRVXZwa3lnMEd1U0NZVmNROFJWNG56cEFORFdtOWFQbFJwbDNJNEQ3?=
 =?utf-8?B?b2pKZXlZdzZyWldCNHZzaVFXUkUwOG03RkppbXpOUzJuZ0NyRk5xUlRyRThH?=
 =?utf-8?B?UDhTR0pCdEo0YVVsMUl1cjE0YSt2MjYxZzJtOU93ZzczZXFCMWgzMjkxWXB6?=
 =?utf-8?B?cVRhT0F4MlloZTNEQXVGdEQvRU5oaDJ6bGpLenNqY0VGcnRqTEovRHhESmRr?=
 =?utf-8?B?NlhrMllJSWtkL0dRTTIvWGZmQWEzZWZveUc2NlhSODJGYXd5KzdDU1F1Z2lN?=
 =?utf-8?B?R1Zybi9vSTNzV1RIamNicWcyekJESGNVZkxhL3VOVkVkRE9FRTNoTFdNdXds?=
 =?utf-8?B?YWFhYndWcGovTkQzUE1oQlBreG5pWTdhdVVVUWlWQlhLZ1E1K1B5bWtKY25M?=
 =?utf-8?B?cVlOTlJwWTd1TjlpRTRCb0t4cmlaV04yK2I1ZmI0YlRIcUp4WDR4SUJtTTJ6?=
 =?utf-8?B?YUZHRk9DMVlUT2tlQWtabytDdUk5QkZpY3RmVkJMdXpMZjg1MEl5dHRML0l1?=
 =?utf-8?B?cDJHN1ZGNHUyY3JVUmRERXdBSjJsdkZDQVUyMDJRcksrakZJOHg5VXV4ZDJs?=
 =?utf-8?B?a1hGdTBGVmdSSDhHSTNxS3RZYUh4QkJFWGJZTnNMTCs0ODI4eHhNcjdGT0Ro?=
 =?utf-8?B?TCtCcitlY3JpeHA1S0hoM2tlQU1hUFdIQkpoR1lYK2xnby80ZXlKaWFSb1lw?=
 =?utf-8?B?UFFteXFkU3VZeTVFWlV1U2ZiaUQvMVpjZU5VVEptM3BUS0QyT01FUWV4ODVo?=
 =?utf-8?B?S0RTVEZwaTdKZ2dqZEJVdU5JWCtrY0F6aWFGanQ5MSt2bWczMHdkYjVJdkVF?=
 =?utf-8?B?dlpUaXVQM3ZrY2FZZmVhaGhQRnJEM0ppMEFITkhIVmZMSWk4WHZyelpmVENu?=
 =?utf-8?B?NVFVelR6RWxjeWFzV2VGbGVwbWdmTXVXOSs5VmNacmh0ZmFUWUlNZFV2ZThz?=
 =?utf-8?B?Z0tiRUNMR1dta0hXTFlGRXk3MUFBWjM1Wmx3dEJUc0dieEprOGdtYVBhbEpo?=
 =?utf-8?B?aDdiYm40MzhoQWFrakNCa2thYnBPL280RVB6cDQ3cmcwcGRJZk9JNmdHeGdq?=
 =?utf-8?B?dk9kK24vKzZUNENJYWE3OHg0UktuVE1KVXZHdXM3YS80MWZVMkJ1MERodHov?=
 =?utf-8?B?bTFlVmxBT0tTSVlUS3lvak5ndEc4cmpMRUNacTF3eHdUcWZFN0hIcmZBRWJI?=
 =?utf-8?B?N1praXNjVUs0Q1o2RnpUYmNSdHc4TXpHOWFJa0t1akhTNHRQMjlaQlgyQXhU?=
 =?utf-8?B?Nzd1Uk16MGYvNC9VY1FHcTNBTDZpTkNOSFA5ZXNNbDlHd3FGYS82ZzF0WkdC?=
 =?utf-8?B?OGhKSkxSNlBuTUVXcWc1WkRuRnYvVDRRd0djN1E3Z1dlVVRNczVQb3VHeVQy?=
 =?utf-8?B?dnpBVEFGSktpSCtvNGkwLytBQW9MK0RFajkwQkovWWpUNG5nL1hNTEV1VjdQ?=
 =?utf-8?B?OWRIU0pIMXdYdWNjSUZ1V1NMYlBXNU1wd1IySENOYXdWR2FIUllKaFgyYk1W?=
 =?utf-8?B?SGxkMkNrRksyYlRaZ0hTWVdycWJ4MzRMOUR3MHZKVHRRcTNFMHR1RnVPSU1w?=
 =?utf-8?B?QmxKOC9KcXZobFM5V3NmeTVlMHVRYzJMVGEzdTM3Y0lCS3NSVGdKNFZsWmcz?=
 =?utf-8?B?SFpldUl0OXgyditPZkFPSEI0SS8vVEsza3I0ZkZqd0QwbU9HTG1JT0ZXS200?=
 =?utf-8?B?clc5TVZGYmRUR1dPS0R6SVYvNG9HbVM1N2dNbjdPN2NScDJqSjFEem00YW1R?=
 =?utf-8?B?NnlNVFRhejc1dWd3VU5mU3Y4MkttM0V2MHNncWJuMm5tSGNFQnl6T0JZOTR0?=
 =?utf-8?B?T3k3S0FzQ2tWenhnVURvRzAvemU5TEI3RlUxbUlKY0ROTVBMbWszenZHQXhy?=
 =?utf-8?B?OVZLUHRCcEtsdWc0SzJFaUZuZ3hleml5L3FrY2E1cGd5QUgzSjVraUhrSHF2?=
 =?utf-8?B?bkZNNjBMVG8vVU00aWYyOW5aUXdDdWY0VEVJZUVIYTRESXRzWHdybVp1TGlm?=
 =?utf-8?Q?0yyhxoBGIi0a4ydUhxlW+PrMP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e878ec8-8d01-46d8-bfd8-08da92959fc9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 19:00:55.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUCHOxjKz0uI3lwJ8ib5ceIrXRjiIM4PqhnRluLcXRVJIubT8jJNcz7MGgVTipih43Moxy7XTKhrSZjfJItnHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
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
> add suspend and resume support for the AMD processors by amd_pstate_epp
> driver instance.
> 
> When the CPPC is suspended, EPP driver will set EPP profile to 'power'
> profile and set max/min perf to lowest perf value.
> When resume happens, it will restore the MSR registers with
> previous cached value.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 39 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e63fed39f90c..749083d28b05 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1476,6 +1476,43 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>   	return amd_pstate_cpu_offline(policy);
>   }
>   
> +static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +	int ret;

I don't see an explicit guard in here to only run this code for epp 
mode.  If you want it to be running both for EPP and non-EPP then you 
should update the commit message.  If you only want it running for EPP, 
I would think you need a:

if (!epp_enabled)
     return 0;

> +
> +	pr_debug("AMD CPU Core %d suspending\n", cpudata->cpu);

This debug statement seems needlessly noisy to me (even for dyndbg). 
Unless they're for debugging synchronization problems, I would think 
that you can get a similar result using ftrace for function names.

> +
> +	cpudata->suspended = true;
> +
> +	/* disable CPPC in lowlevel firmware */
> +	ret = amd_pstate_enable(false);
> +	if (ret)
> +		pr_err("failed to disable amd pstate during suspend, return %d\n", ret);

amd-pstate uses pr_fmt.  You don't need to mention so much in your error 
message.  Something like this would suffice:

pr_err("failed to suspend: %d\n, ret);

> +
> +	return 0;

Shouldn't you be returning ret here?

> +}
> +
> +static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> + > +	pr_debug("AMD CPU Core %d resuming\n", cpudata->cpu);

Ditto on above comments.

> +
> +	if (cpudata->suspended && epp_enabled) {

If you end up adopting the suggestion above for checking epp_enabled in 
suspend, I don't belivee you also need to check in resume.  Your check 
for cpudata->suspended will make sure this only runs if you did 
something for suspend.

> +		mutex_lock(&amd_pstate_limits_lock);
> +
> +		/* enable amd pstate from suspend state*/
> +		amd_pstate_epp_reenable(cpudata);
> +
> +		mutex_unlock(&amd_pstate_limits_lock);
> +	}
> +
> +	cpudata->suspended = false;

You can move this into the if statement.

> +
> +	return 0;
> +}
> +
>   static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
>   					   struct cpufreq_policy_data *policy)
>   {
> @@ -1512,6 +1549,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.update_limits	= amd_pstate_epp_update_limits,
>   	.offline	= amd_pstate_epp_cpu_offline,
>   	.online		= amd_pstate_epp_cpu_online,
> +	.suspend	= amd_pstate_epp_suspend,
> +	.resume		= amd_pstate_epp_resume,
>   	.name		= "amd_pstate_epp",
>   	.attr		= amd_pstate_epp_attr,
>   };

