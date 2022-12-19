Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D39D6516A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiLSXHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiLSXHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:07:05 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFB717585;
        Mon, 19 Dec 2022 15:02:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPoai7BXbL2B8duPHnx4e5g6Mah2lB4OHE4SRHt+yO54Cyoz1QA6A2vecBuaWYaVz0QQPUooHdcV8nxkcTIkULdtGuL0qKMEmv3eVUw4QjO2EgD2Ry9zttuj+o9oz0HNBnsrG7Qt6B5QkRy0C6GwA9+ZDsjdAhDzljOu3STmzB3GTh5NepWM5WzVyDyALXF7yvE6miEKhn4G+Nj5UiEzwssNTv6mBNDPpLEm/zVgt0KXpX+Hut0Pxk9rDqvbEoTJKBPhALPp/piT2XN4PW1RP87R2xvZYviI6UUyqtIDi3LzVF9dyS1uA6Y5qYhhK5EfdmLMZoeQg/lsD7EY0GMKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eI+DHn8Pv6w+6n5X9IHyI/ROENTq+x0z/36d6kypuQ=;
 b=LJrnRmTDHGYIIjWmeyZBpBttfDxu0culU32UJXLaE2M0nk047596XraBPOAh1ePbtu+LGBuENmkL+bwHChbvsvdvlTITwWSgdNhwJAo4DegN4pKHtWOld8AnYb6aa5fhscl0UlbDVYg1CoObLG8wpZ/uaOWo81Kvw8A6SiJo/PwqHlKNPCT7JcEKmeRKFR315iqAYwg8ZO4pN5i4nU4VYdMr3mkCKkCEOToiJ/SkB7u07dZft4zfAS+Unc0Ga1RW0Caeeeb4Ebnz636qFu/B3w7ifALsOh4smp7eiKUcV8J601w77kXGxpGe33pLGPUIlQUTQu7M+GL4Dy1KciScyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eI+DHn8Pv6w+6n5X9IHyI/ROENTq+x0z/36d6kypuQ=;
 b=GLJB3TM10+8deRFR2EqxURFZYYXbDz2dOKQXDh0BZhcsJckAMMKRyoYpEKJiGCNkb4DGF2V5wAkSXD1s4cC1UOQR2g+FeLfUs6EdT6a2KxXeTIYQFnTKuEE8/i33isjSCdkA4MP46rbIHVf6SI4kR50BRfqfF5KuJnCV87wpN0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 23:02:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 23:02:01 +0000
Message-ID: <59f451af-56a9-5c89-7c59-321850114df7@amd.com>
Date:   Mon, 19 Dec 2022 17:01:58 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 05/13] cpufreq: amd-pstate: optimize driver working
 mode selection in amd_pstate_param()
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-6-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-6-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:160::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 54de3116-dae4-40c7-f548-08dae215099c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewqq1aLo9wzwVI97ZpV+fcAyDAOYtd/slRuhW75FgJPSoI1xKW8aHzz3sYKXDrV+xCDDynaG+ne0oFU0IQhItE8M/7PBroSdBGp2osq59T3EC8TytDpvheW+2DyXiQqdH00a4ZIAAFOMh8V4P7KRlbEg/wxioYlmvts3dx1QK96rEtJQHgqZjzRvkag3A9HuAFalxyNUJCgG6x7YT/DPWyyxiRX6WmRmA9SZt6vNtMklsURF7xy7s1FqCNjE3SSlJqRQhiLxSfWmuhB9EUKwGGY+zNxhRWhHxus8YDdPvn3H1zhBVUQTHib/Hfu70EdRTQUHDH04wGXxUfZiA3WiG+isU6IpEZtT4ez6V9+4LrqPmbECZX7E2wP11oJlGIm2iSGE0KG+gud109meSqf+oHtYNjO5KUcGbYCw7lvNui5UvY0/eb/gIVYjNQt33gZNW5hJXfCIiAK6DvpFidwSDVuq6bD5EKtvtlh6Nx44lKYyerD9YuS8etr5dV6LNtuRX2bA7zVJCneFPoTySE3fjkM8p5GGqTTiCZGFmGIZmtWUC0xWHmOm8Iy2o183U08vfVfhG4aeONiankq8rz5ZQnnO642iBArBUhOMJ8/D6+pcN13T+BWPghtrovaXgA6mwGUqcN9cNn2VCmoGJ3JVOXtkEjmnlz2PmAXlT6Lq7YC+xsf3Dba2Ejf/WT+aqICerv/wYT2eBnsHfLPd2zVn1Z7CqdE+sCwzDLsm+RjaClI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(41300700001)(36756003)(2616005)(8676002)(4326008)(66556008)(8936002)(478600001)(66476007)(5660300002)(66946007)(6506007)(53546011)(6486002)(6666004)(83380400001)(186003)(26005)(316002)(6512007)(86362001)(31696002)(38100700002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjVyS0VMWmxMTjBYTlk1VkVqejlIcDJySGNWbDlwdkdHd0U3N0J4M2dSNUUz?=
 =?utf-8?B?SWgyK2NYNU5KV2JBUHVqbU9GZkE1a1NPeUZPODhlcW1kaXI5NTBlaGtZdWxG?=
 =?utf-8?B?MDFtYkFEOEVvcnlNc2Q2NzhMZWV4cnAzLzZsSXFvQTNGSW5hNTNxTG82QWVR?=
 =?utf-8?B?N2R3Yk0zc1FUNWI1QWYrTGZtUXBGUzczT0w3NXU0NXVQMnNoRVJlY09Kb3RC?=
 =?utf-8?B?c01ISENUVWphbVVwZjZEaE45K3RsRmlIbUpNRUFuQVFrYmxVS2JjWTBCR1hV?=
 =?utf-8?B?Nks3emt0ZFVIRjZZdzJTUjUyZ3hJalE0dWlNaGxoQmx6bXhCek9YeDViWVVv?=
 =?utf-8?B?ZnlLa3NiUXlJeVp2YWErUGtoZktLVWxzRnlFc2o2RzE4TWNrdzU5VGtqNjBm?=
 =?utf-8?B?WTRhRDNiV21sOFJ5ZW5jeFovNDZxUXlYSFY2ZUhEVDRYRU9sbmtHcUpFZ3Jy?=
 =?utf-8?B?aHhxeHArZ0ZjLzkwTitRT1YzY3l1U1NHSm5HWFp5a01KTUlFTTFQUFM3T3hV?=
 =?utf-8?B?Z1ZGZ0I2M0dlUThCd1c0MXBGeEJZUzlMTGdCQUhqUXExNEhhRG0zYjdJUXpT?=
 =?utf-8?B?REk3R25uYjRUWjZkZWNmaHhWaUZHWGc0MHNvRmF5ck1SQXp4bG56bDFxRWdG?=
 =?utf-8?B?dkJIZ0gvVkk1RTVwblUxTUNiQXlVSFE0Vm9ycjFScW0zMzlPZEYvRS9uaTNK?=
 =?utf-8?B?R2lVenlaSnVEdkk2RnVqdWVUTE9LNmNCanZrYTRlSWFLeGcyR3JVM01KN0J0?=
 =?utf-8?B?QWZvQlJVZmRNRE5yZEV5K3A4d01lVi9IZGgvYVVZVUhqeXRMQmlxeTRzS2Vo?=
 =?utf-8?B?WWoyUjVlL0srK3dLMlBobjRXeEEvU21zaUVCOERvQ2huUGFnRUlVNkZvbnRB?=
 =?utf-8?B?L2o5VjdoNzFZeEJwL21aR1o4V24wdS9Jdk0zRGR0c0VyLzNycXhteW1TOFlx?=
 =?utf-8?B?T3JWRXhxbkUraFVrQXBndmZvWFcvMFlaQTh1VU01YTdQREZaaEVJZ3hzZStW?=
 =?utf-8?B?a0xrdDgrZkx0eHlFYXFoNzJOMlliUjZ3dHErT3QrTndSVUkvT3NNSUZ1K05m?=
 =?utf-8?B?U2tHV1JZcUlJeWYvcmhrRnBCdFNFWVJYWWNiV2RXeDZjZDZmSi9zT1ZRYzF0?=
 =?utf-8?B?bWc3bU9kK0RWK0prNGRoY1dOYklaSXFCTkI3QWZlQVEzTmMwd29nQzhwOEQx?=
 =?utf-8?B?VXYwN0hhTUJHV1YwWXc5ZGdmL292eWdZREEzSWs5dXVqV2pQWUcvSDl3eEIv?=
 =?utf-8?B?QUgvT21jaFRDRXNhSlVRV2lOTXlhSHRrWmJ2VVFUOFU1M0cxQjd5TWVFMXRo?=
 =?utf-8?B?QTlEdnpKbjZzSTJydWNkbndScGNGalg4L2piNWlCRzF3QVlONzNsRGV3N2pi?=
 =?utf-8?B?aFRxQUZaajNyYjdiYVdzbURqYmxqNVRxZXZLL2ZLUytiVWlXZ1hPRGI5Wjhl?=
 =?utf-8?B?Y3RNQUVQSWdlRWQ1WGk1cEtDT0pERGk4cGJXMEVkdEI0VDVSaW5Ia0FMZEEr?=
 =?utf-8?B?WjErVXhJQXZjMFVOY3hXZ3ZJNVdwQWJXYzE0UElMYmxkSEpRMzhnR3dlU2JJ?=
 =?utf-8?B?aGkrSU8zOHZIbUhLNEJMOWJFMkV2d3dGNDVsaUhhT2hPUGZwdGQxL3liWG5Q?=
 =?utf-8?B?SGM4ZlJtYWxSZm44Z2k1U2tMcW13QXF5VDN4a0VYaEZKeEZockpMMXNzUjVP?=
 =?utf-8?B?U2MxbHpZd3dMSVhqelFKT1B2VWFjZWF2cmkwbGZFVlh2R3ZoRVpxYXJBbGk4?=
 =?utf-8?B?L1hDcjYwWmQ4RGhJSlM3NnI1bzZMa1BLbmphUEVmRE0wM1B1eFB0VmNsVmxD?=
 =?utf-8?B?M3RkbnVuNHJIcXNacWdERWNraC9yTXhPODdDTGJKTFNEcFJpTHlFYXBaUjBp?=
 =?utf-8?B?UFgrTW5UUGR5N25heTlmZCtHL29tN0V0TXlLSTU2eHZHS0tjbGlKSEZlUmJz?=
 =?utf-8?B?bzQrd3VYeVI1bHcvdmVJbWMxa3U4WGgyZEJKNFY4clhySlBMRllkbGwwTWp2?=
 =?utf-8?B?Ui9PcWZoTURhNnhyU0lkdmp2eWZ6QTBsczRYZytZbVFOUzVPdnE4VDNMRU15?=
 =?utf-8?B?WXV4NUIyNG5mVjVNM202VnlNZUNveUw5QitnaW5QN3lWeE8zbDBqUDV2N3pK?=
 =?utf-8?Q?NSTaJhH02mkCaOhMAPkm2iah8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54de3116-dae4-40c7-f548-08dae215099c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 23:02:01.1068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utjH9Fyrrnp5w2RF1gG1bTE8TdlMWHo/5lM0i2zuPcgOfmfWJ4erHYklFqIRHfc20PbHqNs3G5vc0oM7FfIWJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/2022 00:40, Perry Yuan wrote:
> There are some other amd pstate driver working mode to be supported.

Perhaps:

The amd-pstate driver may support multiple working modes. Introduce a 
variable to keep track of which mode is currently enabled.

> Here we use cppc_state var to indicate which mode is enabled.
> This change will help to simplify the the amd_pstate_param() to choose
> which mode used for the following driver registeration.

s/registeration/registration/

> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 35 +++++++++++++++++++++++++++--------
>   include/linux/amd-pstate.h   | 29 +++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c17bd845f5fc..861a905f9324 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -60,7 +60,18 @@
>    * module parameter to be able to enable it manually for debugging.
>    */
>   static struct cpufreq_driver amd_pstate_driver;
> -static int cppc_load __initdata;
> +static int cppc_state = AMD_PSTATE_DISABLE;
> +
> +static inline int get_mode_idx_from_str(const char *str, size_t size)
> +{
> +	int i;
> +
> +	for (i=0; i < AMD_PSTATE_MAX; i++) {
> +		if (!strncmp(str, amd_pstate_mode_string[i], size))
> +			return i;
> +	}
> +	return -EINVAL;
> +}
>   
>   static inline int pstate_enable(bool enable)
>   {
> @@ -628,7 +639,7 @@ static int __init amd_pstate_init(void)
>   	 * enable the amd_pstate passive mode driver explicitly
>   	 * with amd_pstate=passive in kernel command line
>   	 */
> -	if (!cppc_load) {
> +	if (cppc_state == AMD_PSTATE_DISABLE) {
>   		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");

Presumably this message needs to be changed since there are different 
modes that can be used to enable it now.

>   		return -ENODEV;
>   	}
> @@ -671,16 +682,24 @@ device_initcall(amd_pstate_init);
>   
>   static int __init amd_pstate_param(char *str)
>   {
> +	size_t size;
> +	int mode_idx;
> +
>   	if (!str)
>   		return -EINVAL;
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
> +	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
> +		cppc_state = mode_idx;
> +		if (cppc_state == AMD_PSTATE_DISABLE)
> +			pr_info("driver is explicitly disabled\n");
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>   }
>   early_param("amd_pstate", amd_pstate_param);
>   
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 1c4b8659f171..922d05a13902 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -74,4 +74,33 @@ struct amd_cpudata {
>   	bool	boost_supported;
>   };
>   
> +/**
> + * enum amd_pstate_mode - driver working mode of amd pstate
> + */
> +
> +enum amd_pstate_mode {
> +	/** @AMD_PSTATE_DISABLE: Driver mode is disabled */
> +	AMD_PSTATE_DISABLE = 0,
> +
> +	/** @AMD_PSTATE_PASSIVE: Drier mode is passive mode */

s/Drier/Driver/

> +	AMD_PSTATE_PASSIVE = 1,
> +
> +	/** @AMD_PSTATE_ACTIVE: Driver mode is active mode */
> +	AMD_PSTATE_ACTIVE = 2,
> +
> +	/** @AMD_PSTATE_GUIDE: Driver mode is guided mode */
> +	AMD_PSTATE_GUIDE = 3,
> +
> +	/** @AMD_PSTATE_MAX */
> +	AMD_PSTATE_MAX = 4,
> +};
> +
> +static const char * const amd_pstate_mode_string[] = {
> +	[AMD_PSTATE_DISABLE]     = "disable",
> +	[AMD_PSTATE_PASSIVE]     = "passive",
> +	[AMD_PSTATE_ACTIVE]      = "active",
> +	[AMD_PSTATE_GUIDE]      = "guide",

I get the intent here, but guided mode isn't actually part of the v8
series under review.

I think it should either be folded into the series or this patch
should be split into two across the two patch-sets:
1) introduce the state machine (part of the EPP patch-set)
2) add guided mode support (part of the guided mode patch-set).

> +	NULL,
> +};
> +
>   #endif /* _LINUX_AMD_PSTATE_H */

