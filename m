Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722B7673112
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjASFRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjASFR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:17:28 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6A0C9;
        Wed, 18 Jan 2023 21:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daxY4/W99/P5uHI32yUymq2aKbdKQHXuhrdiIys4SZUdx1DnjY0P32fWqeMfUCGOnfUKrIA3Swd9IMkdDR3LzQXu/4UnL3Aoh34f4madsMYeTzOIyxo4HqATQ+FLvKdTzpSo0tmuewWa/cNc4zPJK6BRPoY6puFkABSlPgm02VaqWhRU9GW0wTGjWGl5fu3/guK+F3po5qYDIc4xwZYoJRNEkbsTq2gRYBsquAHdkekFjN4uzeODI38Ba4LvBOLIyr0MtZerBm/hyL1AE9dHthF+I2VgZo0A+G2QSNb9vxCXi7gqJ65nrJbVhjfSAIkXUIY+LDe3J6EsSnE9+k5MEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBGuJMDa1qTxXvoW8K2NUAw423b7kPprjCBUAOpofsg=;
 b=RGpDaSrwlqWzBZL4Cgz6JxdHLuUeUfjkEnaCLYdZ7F5CCAMUzFu8Oa95VFttedmP44cukbuV8671l7p7a6od/lvQiqcTQsbf64kOHwIn0fc9Vmsp3ZQsknNhdu66VZ+vkp4pbZ+rrNE9ukm7Xb537RfbzdE9feU6W5qsNbsI+uvXZz+HNKxI41colTEdNDFZgoujrbplnFUqkrAW+IcnQdpksD+AyFznLuHi97znUR3fF2jfVXBG1QqpHbNnZfUke1jtKjQzVleEruEy7/LPKMZR/7HArn9xizsJyOcCGGpmuKmzxE+c1h4dA2WOfu3buIodGns4j6l80xYY+J/30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBGuJMDa1qTxXvoW8K2NUAw423b7kPprjCBUAOpofsg=;
 b=4+acYkEDF3/Xl+cDKrouANyif353uUFbGpc73Wc9WZ2SzHzY3LEX5gxamJIPcug/wrBNtvOeWVVdhMA4T4QZieiumRlaan6Gy1ToVGU6kCSyDJgxWonT48i71QgpfCGnuxbpFJ0jX4uPr3RVMC/NpDXFj73GnknBNnlXcm/JrQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 05:17:24 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 05:17:23 +0000
Message-ID: <8ee9f7d0-2204-92de-dae5-0348e926c461@amd.com>
Date:   Thu, 19 Jan 2023 10:47:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 04/11] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230118075210.447418-1-perry.yuan@amd.com>
 <20230118075210.447418-5-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20230118075210.447418-5-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::20) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b80561-855f-4172-60b0-08daf9dc7190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oesj2rVf622Z2f9P7pzT+ksAnaX9jPP2jQ6XSU1hnZst421Vx5fU1HJuCeLZhPdCgWh9222DGpLMn9rJW4lgFU5RyVd5j4rxlCIKFFbHyzWdkHX2PzKicQDHrZDU0S0hRbuX1c6BLYsiETervjW9CklLeuc30cr93pmri4j/8bw91oEGJmax4PIBUBusj3NKo+nNajtCuMBLb3zJu25pGVyafrajC/UOEwT/BAn8QRnw4u2ppf5WeWWwWX+UXEs7S4FFJA9dwA7OBi/OyQflcLOSYj2cIeOOjIrpGrSerxbVdZi7XbNhA5oWuXIVqtS8Gozs2KwTPcCvwfFtuTzk+88vJbmTGIIr/UqZ81K/sBckkSGk36StHXeZaUv/AuHsSCIVAaLTUl6UnaI0n2XjfHraGxqEs9P7QisfYJqwNPMCZCUI7ZslPgoiwMXQWGjfqCPXbtozOv1vWGSpDmBQ9GoJdOO1+gN4e03omyRz71jXoqXwpxDPQN2H0WDiQv7S614hQMsAGPI1vQOEAZpbhuvAWTTpcyk0Cn55y0eD4NiEkGSQo3+Ir9/jJKpjKBXg0N42wZPSGNDTzPZbrfmdPEQOGvw1Ml+7rgPv3KUAEjqmgNiiF8yZVYPr5F7fW+zXoM50s1uQ+hH3aUCGHM/dwUGSxThmYNWADbDD+s02egUpFWRK3vBHPw1LxweNf9N5jeBbtVj/NCuChn7aMEfM0/g9qzssJywC5oVyacN6fGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199015)(83380400001)(38100700002)(86362001)(31696002)(8936002)(2906002)(5660300002)(44832011)(30864003)(41300700001)(6666004)(6506007)(53546011)(478600001)(186003)(6486002)(2616005)(26005)(316002)(6512007)(66946007)(66476007)(8676002)(66556008)(4326008)(66899015)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVlvMWVIOTVoZGR5SzNGanN6dXZSNUY3bTNEYklUM0ZSUXFoZTUrbm1xVEJS?=
 =?utf-8?B?eDIzeFgyN1dLM2FBblIwblJxUDZld2FETTVCcHZBcW4rU29RZ3JvZTNyTVcz?=
 =?utf-8?B?d1VhTm8yUldUKzQrVkpUZG9HOVNqZzg2Ymo4MjJjVUs4M2tzS3ZlT29US1Ny?=
 =?utf-8?B?NjZVTlVEVUJ5Z3dIOW4zMDhjYWs2dnlXUmZOUi9kRnJudER4aFpFWithck5B?=
 =?utf-8?B?bWFYTFVPdVhVb20yNEd3TU1hSnMyUjgxZ29yRTVWTFlSd1ZqUko5SHlJdWd3?=
 =?utf-8?B?YnpncmNQRnZBUjQ5Q1FraTRQM0JTVEo2RlU4QjEySDB2Y3RRL09YazE5bXhN?=
 =?utf-8?B?ZHpTTFZjb2NlVTh0ZFl2cUR6dnJFM3hTc1Y0ZmowaTc1bFp0M2oxZ3pyeXNT?=
 =?utf-8?B?cXFiMWQ4dE9rMnJZY0QzTTF5Mkxmd3RQb1RWSHU3RGJKZHZ3SWhLdXNRQkZN?=
 =?utf-8?B?aGVWVEsyWUo3ZmppelB6UE9uV3VrTUNCaUlYdUFQbzQ0ZkROc01sL0p1S2hk?=
 =?utf-8?B?bWpvOWhJRlhQWWlZTytaQ3F0QWFNcDJnOVhEek43L250OGhzc3ByeGp1RmR2?=
 =?utf-8?B?Y3B1V0RiZUhua3ZDMTRPQmVwTHkxcCswdDA5aU9YLzNCdXRQQXpHWHRNMzlF?=
 =?utf-8?B?LzJWWjgySEY1UE1sK01rNXBTN1RWK3plUHFGcGdaMjY2VlNFTXBJbFdBZjh5?=
 =?utf-8?B?bTFzRTJtelhGRXNxVDJMRWxPb2ViUWk4Z1hsL29IMWlvQ1B6aFl5ZnV0VDBw?=
 =?utf-8?B?Y1FJa0FjanVJQ3RJWXRjelJWYnllak1oRWxyNkdBZEkyUnE1MWR3T1J5dVB3?=
 =?utf-8?B?MVVKQk9VQ2lWa0Zrdy8vQS92V0xhSUJMWllmN0NHd3pBeUpocDFXdHE2dEZP?=
 =?utf-8?B?NEtDRVJZWjhBdGR5Ymt4MldyYzA3ZnNvQXFhM3BUTklyTGYxSDc5cG9VTjhp?=
 =?utf-8?B?cHFCdHRGdFRmalVYaEp5bHNsb1hFYm44SGN5QWZkbmI4WlRpWVZjcUpSbC9U?=
 =?utf-8?B?cU92ZmpLT3RrSTNQNjJjOXF3ZzhsZnEwaGNDUGRNQWYrUmFqUUVGNitFUG16?=
 =?utf-8?B?ZXp3R2Z5K1NuYzB1V3ZNaGU5dUthRGpFRXBvYjJzbmN1dVVPeWU2cVBRN0F3?=
 =?utf-8?B?Uzl6VkhJQ25QdXVWbzQzc3d3aXQ0bWZaRkRYaTBQMGtyN2JaL1VRN0pXcHd2?=
 =?utf-8?B?Y2NVYnhkMTVZZGJhRnFobThhQlpqczBQQVoyNUZoS0ltZ2VIWmg1bDFwcHNp?=
 =?utf-8?B?MFVaT1BzVW4yMUh2TmhoN3kwUFR1d3JQVC9CQWs4NVNPYzlmcVNSd2I4OVJm?=
 =?utf-8?B?QjhzZmJKSGRGSTdLK0dJN2ROKzl1MHBMdS8vdG9LZVI0TERsSmZGeDF3ZWdO?=
 =?utf-8?B?TmJYQkE3T0tRdmZzb0pRU3RDR3V5ck1JbkszV2kxN3lmVXVlZGlHb2l2cmJC?=
 =?utf-8?B?ZzhEL0c0S3JZVTJmbmFLbUY1RFRvc3ZiK2N6aTV2UlVzaDY1dGJOdU84Umlh?=
 =?utf-8?B?Yk53cXVrUWwvaEZUNlBCNm1sMk1VSjlXVUVGVDNuSkw1S0JSSzBYTWdpdmlz?=
 =?utf-8?B?aWNGZ3N6SkR6eFBpNVI5YmV0eDl4enNCQW5URUFVTG82WGJsOG5vOStOT0s2?=
 =?utf-8?B?ZnlqbWFiV0VHaGdNbEJkb0Vsb1R6VXFzMDZpYzdKakpMTGJmVU9RaDJXTWJs?=
 =?utf-8?B?c1V5c01Wa0RFNDBaMlg5U1JIdllkZHNrRXNsV1JyNmRHSjhFYnViNDdlWVBw?=
 =?utf-8?B?aUdoNmtweFhqeEI2aGYzWEFYU1BUYXlJMXJjVjluZWNpT3NrdDVTeUFzZWhx?=
 =?utf-8?B?OU9uM3VENCtuNWg3d1Zkd3QyL0g5Wkw3S2lCS0tqUlV4Y3d4eHJrM2o0YXQ0?=
 =?utf-8?B?MjhMUUtmZloweWs0Y3RwVGQ4N3Vmeng3QWlNVlpPVnY4Zy9rb3cydGxlUThP?=
 =?utf-8?B?ckd4VkU1RXQ2OEdsRFVZRkdGdXdRRFYrRVYrWFgyL3p2dEdjWEZRSXZlMjB2?=
 =?utf-8?B?bkFtN3UyNW9wNHZTNDcrcTJLbS96cSt6NklDLy9yRVhUTHllZHB4aGVzZFFQ?=
 =?utf-8?B?cHg0MWhyNnpJckYybDRIMzNLSmk1cngxbWNTallFVkdQMitWMlVNelVPZjVJ?=
 =?utf-8?Q?0QDZeSPwg0RGwHpl4VtfDUNGZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b80561-855f-4172-60b0-08daf9dc7190
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:17:23.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftHyClzW11ATU8Y4SF+ipbcVpkTRIcPDyE/8X5w6VlUmNB6b9rXl6lF0dYj+ZnNBlosQgbIc7SC2oKj+MRxi4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 1:22 PM, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add EPP driver support for AMD SoCs which support a dedicated MSR for
> CPPC.  EPP is used by the DPM controller to configure the frequency that
> a core operates at during short periods of activity.
> 
> The SoC EPP targets are configured on a scale from 0 to 255 where 0
> represents maximum performance and 255 represents maximum efficiency.
> 
> The amd-pstate driver exports profile string names to userspace that are
> tied to specific EPP values.
> 
> The balance_performance string (0x80) provides the best balance for
> efficiency versus power on most systems, but users can choose other
> strings to meet their needs as well.
> 
> $ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
> default performance balance_performance balance_power power
> 
> $ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference
> balance_performance
> 
> To enable the driver,it needs to add `amd_pstate=active` to kernel
> command line and kernel will load the active mode epp driver
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 379 ++++++++++++++++++++++++++++++++++-
>  include/linux/amd-pstate.h   |  55 +++++
>  2 files changed, 428 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1a8b31277620..2109ad3fdd42 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -59,7 +59,9 @@
>   * we disable it by default to go acpi-cpufreq on these processors and add a
>   * module parameter to be able to enable it manually for debugging.
>   */
> +static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
> +static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_DISABLE;
>  
>  static inline int get_mode_idx_from_str(const char *str, size_t size)
> @@ -73,6 +75,114 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>  	return -EINVAL;
>  }
>  
> +static DEFINE_MUTEX(amd_pstate_limits_lock);
> +static DEFINE_MUTEX(amd_pstate_driver_lock);
> +
> +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
> +{
> +	u64 epp;
> +	int ret;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		if (!cppc_req_cached) {
> +			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +					&cppc_req_cached);
> +			if (epp)
> +				return epp;
> +		}
> +		epp = (cppc_req_cached >> 24) & 0xFF;
> +	} else {
> +		ret = cppc_get_epp_perf(cpudata->cpu, &epp);
> +		if (ret < 0) {
> +			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
> +			return -EIO;
> +		}
> +	}
> +
> +	return (s16)(epp & 0xff);
> +}
> +
> +static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
> +{
> +	s16 epp;
> +	int index = -EINVAL;
> +
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
> +		break;
> +	}
> +
> +	return index;
> +}
> +
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
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
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
> +		int pref_index)
> +{
> +	int epp = -EINVAL;
> +	int ret;
> +
> +	if (!pref_index) {
> +		pr_debug("EPP pref_index is invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	if (epp == -EINVAL)
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
> +
>  static inline int pstate_enable(bool enable)
>  {
>  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> @@ -81,11 +191,21 @@ static inline int pstate_enable(bool enable)
>  static int cppc_enable(bool enable)
>  {
>  	int cpu, ret = 0;
> +	struct cppc_perf_ctrls perf_ctrls;
>  
>  	for_each_present_cpu(cpu) {
>  		ret = cppc_set_enable(cpu, enable);
>  		if (ret)
>  			return ret;
> +
> +		/* Enable autonomous mode for EPP */
> +		if (cppc_state == AMD_PSTATE_ACTIVE) {
> +			/* Set desired perf as zero to allow EPP firmware control */
> +			perf_ctrls.desired_perf = 0;
> +			ret = cppc_set_perf(cpu, &perf_ctrls);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	return ret;
> @@ -428,7 +548,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  		return;
>  
>  	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	current_pstate_driver->boost_enabled = true;
>  }
>  
>  static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -602,10 +722,61 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  	return sprintf(&buf[0], "%u\n", perf);
>  }
>  
> +static ssize_t show_energy_performance_available_preferences(
> +				struct cpufreq_policy *policy, char *buf)
> +{
> +	int i = 0;
> +	int offset = 0;
> +
> +	while (energy_perf_strings[i] != NULL)
> +		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
> +
> +	sysfs_emit_at(buf, offset, "\n");
> +
> +	return offset;
> +}
> +
> +static ssize_t store_energy_performance_preference(
> +		struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	char str_preference[21];
> +	ssize_t ret;
> +
> +	ret = sscanf(buf, "%20s", str_preference);
> +	if (ret != 1)
> +		return -EINVAL;
> +
> +	ret = match_string(energy_perf_strings, -1, str_preference);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&amd_pstate_limits_lock);
> +	ret = amd_pstate_set_energy_pref_index(cpudata, ret);
> +	mutex_unlock(&amd_pstate_limits_lock);
> +
> +	return ret ?: count;
> +}
> +
> +static ssize_t show_energy_performance_preference(
> +				struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int preference;
> +
> +	preference = amd_pstate_get_energy_pref_index(cpudata);
> +	if (preference < 0)
> +		return preference;
> +
> +	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
>  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_rw(energy_performance_preference);
> +cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -614,6 +785,186 @@ static struct freq_attr *amd_pstate_attr[] = {
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
> +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> +	struct amd_cpudata *cpudata;
> +	struct device *dev;
> +	int rc;
> +	u64 value;
> +
> +	/*
> +	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
> +	 * which is ideal for initialization process.
> +	 */
> +	amd_perf_ctl_reset(policy->cpu);
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		goto free_cpudata1;
> +
> +	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> +	if (!cpudata)
> +		return -ENOMEM;
> +
> +	cpudata->cpu = policy->cpu;
> +	cpudata->epp_policy = 0;
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
> +	cpudata->epp_cached = amd_pstate_get_epp(cpudata, 0);
> +
> +	policy->min = policy->cpuinfo.min_freq;
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	/*
> +	 * Set the policy to powersave to provide a valid fallback value in case
> +	 * the default cpufreq governor is neither powersave nor performance.
> +	 */
> +	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		policy->fast_switch_possible = true;
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
> +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	pr_debug("CPU %d exiting\n", policy->cpu);
> +	policy->fast_switch_possible = false;
> +	return 0;
> +}
> +
> +static void amd_pstate_epp_init(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	u32 max_perf, min_perf;
> +	u64 value;
> +	s16 epp;
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
> +		if (epp < 0)
> +			goto skip_epp;
> +		/* force the epp value to be zero for performance policy */
> +		epp = 0;
> +	} else {
> +		/* Get BIOS pre-defined epp value */
> +		epp = amd_pstate_get_epp(cpudata, value);
> +		if (epp)
> +			goto skip_epp;
> +	}
> +	/* Set initial EPP value */
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		value &= ~GENMASK_ULL(31, 24);
> +		value |= (u64)epp << 24;
> +	}
> +
> +skip_epp:
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +	amd_pstate_set_epp(cpudata, epp);
> +	cpufreq_cpu_put(policy);
> +}
> +
> +static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (!policy->cpuinfo.max_freq)
> +		return -ENODEV;
> +
> +	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> +				policy->cpuinfo.max_freq, policy->max);
> +
> +	cpudata->policy = policy->policy;
> +
> +	amd_pstate_epp_init(policy->cpu);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
> +{
> +	cpufreq_verify_within_cpu_limits(policy);
> +	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
> +	return 0;
> +}
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -627,6 +978,16 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.attr		= amd_pstate_attr,
>  };
>  
> +static struct cpufreq_driver amd_pstate_epp_driver = {
> +	.flags		= CPUFREQ_CONST_LOOPS,
> +	.verify		= amd_pstate_epp_verify_policy,
> +	.setpolicy	= amd_pstate_epp_set_policy,
> +	.init		= amd_pstate_epp_cpu_init,
> +	.exit		= amd_pstate_epp_cpu_exit,
> +	.name		= "amd_pstate_epp",
> +	.attr		= amd_pstate_epp_attr,
> +};
> +
>  static int __init amd_pstate_init(void)
>  {
>  	int ret;
> @@ -655,7 +1016,8 @@ static int __init amd_pstate_init(void)
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  	} else {
>  		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>  		static_call_update(amd_pstate_enable, cppc_enable);
> @@ -666,14 +1028,13 @@ static int __init amd_pstate_init(void)
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> -		pr_err("failed to enable amd-pstate with return %d\n", ret);
> +		pr_err("failed to enable with return %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(current_pstate_driver);
>  	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> -		       ret);
> +		pr_err("failed to register with return %d\n", ret);
>  
>  	return ret;
>  }
> @@ -695,6 +1056,12 @@ static int __init amd_pstate_param(char *str)
>  		if (cppc_state == AMD_PSTATE_DISABLE)
>  			pr_info("driver is explicitly disabled\n");
>  
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			current_pstate_driver = &amd_pstate_epp_driver;
> +
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			current_pstate_driver = &amd_pstate_driver;
> +
>  		return 0;
>  	}
>  
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index dae2ce0f6735..9bfdabd9d930 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -47,6 +47,10 @@ struct amd_aperf_mperf {
>   * @prev: Last Aperf/Mperf/tsc count value read from register
>   * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + * @epp_policy: Last saved policy used to set energy-performance preference
> + * @epp_cached: Cached CPPC energy-performance preference value
> + * @policy: Cpufreq policy value
> + * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -72,6 +76,12 @@ struct amd_cpudata {
>  
>  	u64	freq;
>  	bool	boost_supported;
> +
> +	/* EPP feature related attributes*/
> +	s16	epp_policy;
> +	s16	epp_cached;
> +	u32	policy;
> +	u64	cppc_cap1_cached;
>  };
>  
>  /*
> @@ -91,4 +101,49 @@ static const char * const amd_pstate_mode_string[] = {
>  	NULL,
>  };
>  
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
> + };
>  #endif /* _LINUX_AMD_PSTATE_H */

-- 
Thanks & Regards,
Wyes
