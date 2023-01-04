Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0A65CAE2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjADAbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbjADAbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:31:40 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C267A450;
        Tue,  3 Jan 2023 16:31:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElKtT52UNjJmTE/su+bP1dII61Bw4QeQB+/h8O0WeVnGJsBsUHxw1HEr8NIdubQnJUjRh7uTF4f4ff05zAz3povua2ohR54/jiJ2/lafxpCD8r/d/4YXxeSwxlZUSg2sQ2rx1svWuQspvrAQElw5xl2DHMvXYy5iK+vCnYyOD+XbOLXlKxJwVsceJxQsSwyfleb5zlWmmEgc6dZyIRRBMmiMvoqoWhOD/51kgO2acDKtS+GOd8kIbKl847pkkmyxqBePycSi6OAApYGfDl7Mtiq+mzjWJW5KLuUD9aSRkppRYMEPFsHuAhJG4/6bZK5erRk30S9rCPxwKRs5eOkhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuyv142qX49eKkWUb27e2RMqNGaNQ1z9I+3tNZb3eP0=;
 b=XHK3J8rlixuUcN80shhCOBbepyd5Z8mI3flDl4FjE5sk1xaTN8GowXzgbqUfmCKu2Sl8YD/p/g3DwHxCpX0vSzgB4NH85Y/CmV2m31mOeTznOXlxq9pdfrlRbJZaB7uJQL3C00YenkJpRPoT4en2ivTnTq8lFJ1s2wRCtAmp98WTWUjKTzC+O7VTn7FOSu/4buxJNuFL+8T+3MVhYpVcbSzNiSzs5BfrSv/MquYkLyTwzYVoYwhT55QZlL8Yi4fqRrgKOtyHeVZosZcB4Dt/cEf1U+BvFCi/egix6MWXkATtCGVpVafC5STaSrnp3xs3sw0APJ/mGdFcL8IifHqJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuyv142qX49eKkWUb27e2RMqNGaNQ1z9I+3tNZb3eP0=;
 b=Wj368TllwO2FKB5ddlLXcVychL5hFv84giyN+O7fRkTYD/AC5cmc0r02E3u/IbZmW4wNE/MKxiRNnn3EBkklNYuURxzsYdxIKfqsbObvOHSgZJWQUQ0/ACvQvjChRsVKYtYM0RZEMsi2PGfdg2ih744SJls/uO4Au6iQ/l9lo+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:31:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:31:30 +0000
Message-ID: <700d3351-1a52-5362-d22d-9326ad1220e5@amd.com>
Date:   Tue, 3 Jan 2023 18:31:26 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-4-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221225163442.2205660-4-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0406.namprd03.prod.outlook.com
 (2603:10b6:610:11b::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ddba69-6dd1-49c2-73b8-08daedeb05e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwjGGutP+CxneDqOc0fRhNzflRPJZjKN01KzeAe+bfjSp9nHp5aqyh85RaiEJeCLsD5wql2pxsTiIoLQHL+m7KT2tCzxGHzLxH5Xmfr/0MWT/n9y41TwKb/VuMsbmSF45rUdte5dfD0FhmV4T6C+vlTTvkJi85E3OxUP1WnfveMUKeIoXIziPIQSAa5Oo985nsKZStZQMECd2/ByOtVv3D3fFr+TelrIjAd8hv3MyyxkYqnOVNv1QX1r0GrPnfOJzrnmv0nzL6t0Saf0EYwe4/cOTsgZj06VqsCmQffkROz5ZnVuxBSENvoyIXIXV0Yz6CQYdRViJZPUQMO7dJHYaprqbi1R04g9oePyMnBZqmMupkHHYN65UVCvc3GMVYs+hmZjesj04t/ap5UAPCwCZSJNlXm6QB+u/J+zrrB3pbM5dXknOhrAc1BoRPvcdIUH+tTYC7U9SerhCF5Wn/GKs75eaOLuYvkdQDGNJboZrd4ZkU4a+iYKEYzdV6fqz5fWVrgt1uXevIVLdv2xzPqM/YfaThUl3y2TTSXOzTWxG9h9/N/mzqNVdvmA25xc1K1iNVL2e/+ABor1B2SmE5qisX6Qs6XUw3xqItzpjE/RkUUMEUPJB7OmSThLUdblBxmWcLIsNsvPgn934/RU/fEgNdWDZlwJR5rs8ZDMAVrsZwhO5BEKD8XG1Q/FRlfAecfj2wxe9786xezT259fC+MFPFWiG5mYLBjYu8pQbIaHS5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36756003)(2906002)(38100700002)(8936002)(5660300002)(41300700001)(83380400001)(86362001)(31696002)(66556008)(31686004)(6486002)(66946007)(6506007)(53546011)(66476007)(478600001)(6666004)(8676002)(4326008)(2616005)(6512007)(186003)(26005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2Z6R0JZdGJ6ekR6cis3Y1NhcHZ5VVFzT2FSTHd3dnplb1huaVNQWXVKTVA4?=
 =?utf-8?B?SU13UDRLeG5rS0hwd0c5OEVIbHRnL2NMdStoUFp4N0EwUnBOT3pUQXNza3Ew?=
 =?utf-8?B?VXU3WmpZUkV1WW56ZWpIdGsvend2NzhrdEdKTGszMlExZEZ1d2NSUUlOMENJ?=
 =?utf-8?B?My83NmdydUJ2UWVTSlBqMTdPR2g3cncyeW9PSHllVXdWclRCejFPUEQ3UGhG?=
 =?utf-8?B?bzkrRUtmUzJOSW91NmpwMnhFZzZOamI5TVBmaDJ3UU9LNmt3R0huUzloQis1?=
 =?utf-8?B?QmhYbVBOSjg0VDM2blllc252MDA2UmVGeG9WbDhPMDV6VitlaXlhNXNyYU5S?=
 =?utf-8?B?bmd5YXpJZEhWekdKUmo1bUYwbW0waFlBN296a2gxbGlMWklzcVJhYzBMaEwy?=
 =?utf-8?B?Q0owbWplaHhIVEtselA5T044SnpsYm45dGRZVlhTVXRnUmxWYWsrbEphRWhI?=
 =?utf-8?B?N1lleWVsVHBVMzJUZkd4WmhFZnpnaUhiQjBkRGR3cGkvRWkvOTVzcTVOWWpI?=
 =?utf-8?B?TEVEbmZBTWJnQ0FLdE43dnJQYVg2eHVYNjcwZStXY3VmUzdsc1hIVDJmT08x?=
 =?utf-8?B?aUJkUG5hNW1UWS8rL25pU1ozUjA4bkY5aVQ4d0NaNU1nQ1ByNjFPeVdLemRW?=
 =?utf-8?B?bTlBRzhWWVp0b3BMeGNSZDk2WXBGZ3J0WVZqdFdvU3o0eE9mZWZwSXJkRVFX?=
 =?utf-8?B?L3BwQWxHT2FNNUNkQUlUVTBmU2U3eksyeFdCRnVwdGFmYUlwS0xPTVZJN241?=
 =?utf-8?B?Njl1ei9Qd3FWZGRlelBONFEyZGcySStSL2lYeEtETzh6ZDFodyt3L2l0d3h5?=
 =?utf-8?B?WkhaNjY4QUpMelhvbnlNb3lvR3pETU1SbVVSb24zZFQ4S2Iwc3F5M2VDS2hn?=
 =?utf-8?B?QkZnUVdqVkhQZUplSTRDdUgvWW9EY1Y5aDMyYkNDMlUzY0g3Zk9sVmxOTmlZ?=
 =?utf-8?B?Y21Oa1dOclpHTnBEd01LRDFWaXM0WUhwOWhGK251WWtuemttbS94WThVWTFO?=
 =?utf-8?B?NGFJeVB3V1FzUEYrR3lGQkVNZForeENSbTFoS09aem4rUk8zOFdrYjdWVi9n?=
 =?utf-8?B?YnRDWjRlMjhDejJaK2pzMlMzTjFJRWxjS2hZQkpLdTVaMjk5U0ptd3V4Qm1w?=
 =?utf-8?B?Mi9DWlQ2NHMwN0RrMWowVGZGSEhHemY5UWVJY0tkWXMvbENqYndKdWpVVkw5?=
 =?utf-8?B?WUF0ZHN0SzV1QndMK0gveEdURFgvc2haY00zZ3NTdkFiakpZUzVXM0ExVnFj?=
 =?utf-8?B?N0lGazNPcUg4TllUM0NpVDFEcUpoa2h4QkFpMFdqVVN1VVVlZzBkc1BLS1N1?=
 =?utf-8?B?TVZhVzN5OGFaZWp1V1JsSi9tRlhYWmgraDZsR0RzQ1BNVEZZeVIvVGVEM1hI?=
 =?utf-8?B?eUhSdm5ROEZpanB2MTE4cTFnVERWMnc5b29tQk9WMWx3YlQ4QWI4UG1kWDha?=
 =?utf-8?B?MzZUclUyVlBtL2RYL2VrMmp4b0paTkl6NHB1RGN3N1ZKVDRCbjZ2UGlNZnJr?=
 =?utf-8?B?TjQ1OGloMkFrc0JTL2JkMC9vS2gwdnZPaGVmeVNZZWFQdlFTenZnak9zSHJ5?=
 =?utf-8?B?QjRML2w0bFhsMHkvS0V3cm40bFd2YXlsNHE5bmhTaU5mNFBzTDVkOTV0RllQ?=
 =?utf-8?B?eHFPcW82NERzYnFJVWtieFRBQmtycGpEUjliUmRtc3cwaDErK1h4V0FtUlJw?=
 =?utf-8?B?Qm5hQU5kcGJkN1FPMEJvaS9aRGZKVnk0UEZ1cm84SWN5MnR1RW14ek9mSFhv?=
 =?utf-8?B?UzVYRWgrNjlCZmFQaU8vSGhqOVhsMDRjajY3QU1kbzVwSEtJSVNTWEtiNlhn?=
 =?utf-8?B?YmxvaW5PeFF5UlBRdUQzK2RGQjVJVWdYYkZrVEVUcVo0RUl6bCt1ZWsxNDUz?=
 =?utf-8?B?Z0FHUHBjaVM4WkgwazliazQweGtLWDc4TEVKeit1VHR2cWpxenBqSnYrM1Rs?=
 =?utf-8?B?U2txRkJBSVp1b3hFMGIrcWNCOUREVFNWNkp2TVJWVEc5K1FVRVRhS0N0MFRH?=
 =?utf-8?B?WkVnNU5OcFpXRys0dlR5ZzBNQS9RM0c3QlZiMWh5Ri9PUlkweFdYZi9uKzc1?=
 =?utf-8?B?eUxwZmQ0dVFmTkFTN1V1cU1IUERzMFFNN3lBOU0yeGNTS1p2NjE3QUZCbzRz?=
 =?utf-8?Q?8R6CsGXBLCTAsX7jg6sSEKD52?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ddba69-6dd1-49c2-73b8-08daedeb05e3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:31:29.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4tc1hMokn6ECWTfiGOvpcTINA9CjcqKtzrwe2auY2PeZUtZQCfayho/W3U81SvfgOE7/ljr7/ee8Ua6ugRz1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/2022 10:34, Perry Yuan wrote:
> make the energy preference performance strings and profiles using one
> common header for intel_pstate driver, then the amd_pstate epp driver can
> use the common header as well. This will simpify the intel_pstate and
> amd_pstate driver.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/Kconfig.x86    |  2 +-
>   drivers/cpufreq/intel_pstate.c | 13 +++----------
>   include/linux/cpufreq.h        | 10 ++++++++++
>   3 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 00476e94db90..f64aef1e093d 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -36,7 +36,7 @@ config X86_PCC_CPUFREQ
>   
>   config X86_AMD_PSTATE
>   	bool "AMD Processor P-State driver"
> -	depends on X86 && ACPI
> +	depends on X86 && ACPI && X86_INTEL_PSTATE

This doesn't seem right to me.  What if someone didn't compile in Intel 
x86 support for their kernel?  They wouldn't be able to pick X86_AMD_PSTATE.

>   	select ACPI_PROCESSOR
>   	select ACPI_CPPC_LIB if X86_64
>   	select CPU_FREQ_GOV_SCHEDUTIL if SMP
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index ad9be31753b6..93a60fdac0fc 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -640,15 +640,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
>    *	4		power
>    */
>   
> -enum energy_perf_value_index {
> -	EPP_INDEX_DEFAULT = 0,
> -	EPP_INDEX_PERFORMANCE,
> -	EPP_INDEX_BALANCE_PERFORMANCE,
> -	EPP_INDEX_BALANCE_POWERSAVE,
> -	EPP_INDEX_POWERSAVE,
> -};
> -
> -static const char * const energy_perf_strings[] = {
> +const char * const energy_perf_strings[] = {
>   	[EPP_INDEX_DEFAULT] = "default",
>   	[EPP_INDEX_PERFORMANCE] = "performance",
>   	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
> @@ -656,7 +648,8 @@ static const char * const energy_perf_strings[] = {
>   	[EPP_INDEX_POWERSAVE] = "power",
>   	NULL
>   };
> -static unsigned int epp_values[] = {
> +
> +unsigned int epp_values[] = {
>   	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
>   	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
>   	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d5595d57f4e5..0693269fb775 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -185,6 +185,16 @@ struct cpufreq_freqs {
>   	u8 flags;		/* flags of cpufreq_driver, see below. */
>   };
>   
> +enum energy_perf_value_index {
> +	EPP_INDEX_DEFAULT = 0,
> +	EPP_INDEX_PERFORMANCE,
> +	EPP_INDEX_BALANCE_PERFORMANCE,
> +	EPP_INDEX_BALANCE_POWERSAVE,
> +	EPP_INDEX_POWERSAVE,
> +};
> +extern const char * const energy_perf_strings[];
> +extern unsigned int epp_values[];
> +
>   /* Only for ACPI */
>   #define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
>   #define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed coordination */

I think the right place for these variables and strings is in the cppc 
library source file that is common across CPPC implementations.
