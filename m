Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC88668C16
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjAMGDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbjAMGCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:02:46 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C256B5BB;
        Thu, 12 Jan 2023 21:58:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbUp+GcGdaK0pyAvJSU23eRAzLNZy3467/+gYvG5xGCCeh5UlZlOYDsiFndMjoUBYKsUbIZ0FVEuy79Sd5nwQOR5t1GA0DrnXUt/QFgUqzak8BuLUMMWL1iiz4870A/R8XusFTrBzDy+ETponHbXwjVAN6ykiNHjIwXXxc9vlN1eZYl5RZcTY/a3E3Ko4D+g7ITrzg05VDwSMnvtgVwXGMOG4qP9f3qjtdXjoeLJ9nXMgUDeLCYzjkx5Gz7f6itdk120dWQcnaDmRpKn9M45TvyDVn3RoQNPED7v59+xTDG1ERoa8i19a+mp1NQffdaEnhmm2Rb7jSGYDSwLo09yBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHVHRUCeRiR3IVaH6oRtyO0GDzuY+efyWn9KiLWjQng=;
 b=RZcTiibElV0jIvKo3uEPlIGX9i2oaDKtonKb0OX8Gd8Qx2YwTrWAah9lzQSSJN2Y/utxrtrHgsOI42k+0GlNHvUqYGMaStMNCMPLgTSAFgh1CLEmo4fKQ4fgK2w/NOe17CLsQv14HbOsQ+ksWdvQZIEJzVQ/R34ljZKH0YFNycbRRsCF9lAYQiR3lQgZsKRXLLXSz1w3WaB9ka4vrlbgbWjnVG6qmAyCDsXRwFKww9qVxF5AVm3y2R+vdcp1kCWOPL1XH5jxFrMdnx0dGIi6c3OfubKA/CxNZkrr6pCILpRs7TF5gFG7SqqKtQ2A6zAyWrdJgIeQkxPDfYcnPewr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHVHRUCeRiR3IVaH6oRtyO0GDzuY+efyWn9KiLWjQng=;
 b=QOIHDD2tAvmJ6tH+6B3KOPmO7rdvdvSRCOCtNpV67HnRBDy9Np+ebPB/stVOwcxerU1kaifVkjBqR19Gjzk4Da2CTjJQWtoo3f6g8myZzBSljBYwqHoVNpHMkCCY6E+RU61CZqfVhPiafQb70URue4TyRoTJUJk/PGC/B6ZPgDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 05:58:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 05:58:39 +0000
Message-ID: <c21e3837-aaf3-d198-392e-d48b5d82cda4@amd.com>
Date:   Thu, 12 Jan 2023 23:58:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 3/6] cpufreq: amd_pstate: Add guided autonomous mode
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com
References: <20230113052141.2874296-1-wyes.karny@amd.com>
 <20230113052141.2874296-4-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230113052141.2874296-4-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:806:120::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4a58d8-43ef-42cf-e08b-08daf52b37c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNDck5c1I06PNQOeYQBy8qPtzCZTiN99IHWExNmiK2m66gtEbhSgcFuA5g8GYjbaeY+tHtNFHYpJCUQ6KVd1eTv/K2IHYb40AcnoDWCau/DG4SvuX62QqBzT8n2N201FIvgkea4Yc3CWdGrParwjx3+/p2NAWuCui6rQh90qosKP1SwAQugjHYR+558IJGrooobUA9gLsAfJaA4c0cXje/kK7iJhE9C3WCMy57HGiPtWz3lhQZdMl/IFKd6caHHTC8882XOXOplG2Uz0Q92xsWcW41gjWsqeAyt9TDv8SNLfmGyK5sq5JeLfCOSoGC3WXMwc2ssEi9yFbcW6n/sKvsHx589zqXm4Szm4qKvNsyBjdQjKgtA0P625jK0NyzNcdyNTL0wvxgWnt5QWODc6jvSCO+vP5zvOckQR+emn37dkzXuSiQh+TrpPQHBpBrSPzolqOrMMgc2v97Ca/QKTtuGkvF2nUzx2lkZQ0bYoyYKo/+yeWanreWjLoSM/SHg5710PgejAAnvktOcY6OJ9S7gjXKO9RPORud3bFfVFbl0WpMRDIgEk0qUYj6EbR/QV2Mbn7ovr+EetaXPqNoq+u9khwyV6aogBRFI7ikGFSFJvZxv0ti/rLgAhKYnHenopywdEbDECpgJZ73t3p0M7EbOW7kD6hS8iNI0n50Cl3uy7xgkQHnjCtr2b5ls5zydWYMu34HBL5NGYTaSYn4Shi+fvnAcS3b/aWjkoAs7Pyxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199015)(41300700001)(6636002)(4326008)(110136005)(2616005)(66946007)(83380400001)(8676002)(36756003)(316002)(66476007)(66556008)(86362001)(31696002)(5660300002)(8936002)(38100700002)(44832011)(2906002)(31686004)(6506007)(53546011)(6486002)(6512007)(186003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytkbXpkNFYzKzdNQVRoU2R6cHpKb0tFVVFCM05MZW1YcmRBOEc5OVZkNkNs?=
 =?utf-8?B?L2pNN3FXeG9HMXlUYk5DNHJBdFFXTlBkUmU2anlkNHdKdFhSbmhWdkhKRWpk?=
 =?utf-8?B?aWZFMjVIYnBqVjBMOWQ3OUZLSm9ZVlVZRkJuMVBFWU5xWTREalhmNUx5OFEy?=
 =?utf-8?B?dHNCSGxwS2NORFRBWk8zeW1wdklZVEVMRkMvTGRaaE5RbXdybXlWdjhzc3pr?=
 =?utf-8?B?TU9ySHN6ZDBaTG4wS3BpQ3JqNnh4VUNEUGVPVzNSMlVxYkk5MVN2WnhNYWxw?=
 =?utf-8?B?eFVONXlWTTFlelVNSjU1bDNDYWJHYUQ5cDFySjNHVlRHRnJOZVdPYXJmTGRP?=
 =?utf-8?B?RXlPRTVvNmJTc1pDYkU5eEw2d2oyRjh5MWQ0SHcvNjN5bFRGV3lSYmhoT2RS?=
 =?utf-8?B?OS9QV1RqeGhpRlhBaDk4bGl4alNYTE1YOVlVUTNXWHhYTTFqcURyOVpGT0Nj?=
 =?utf-8?B?TVoyVEEraEVIeGQwOVgwUkt6b3ZTWlBDeUNpdUx5UVN0TUlOVnRZNVdBUVlj?=
 =?utf-8?B?WHRlMzBpMjU4SklEcy9Hb1pzbHVKMHBhdzVENE16NGlLN2lkcVFjdG1rK1Vs?=
 =?utf-8?B?a04xaGtLSHJsQ2FxMUhkaWZpZnNTYXhVWUV3TWQvRG8wRG45cDdRUzFaS28x?=
 =?utf-8?B?MEU4d3RkMDRvSHlrVkFqWWhiSEVrY3JaWUV6NERCWGJ6YUp3NS8weElzVk5I?=
 =?utf-8?B?TTZ5b0pkRkwxNjFEd1NxSHAzb2NPelpUM1FEV0V0VEtpWGdTdVA4bS9EdWtY?=
 =?utf-8?B?Y0RBMkZncFhqYWFDL2VaS2pSZFVWTjhOOXluQlgvbWFMMDJueHRxUndnNmow?=
 =?utf-8?B?NXB1ZS9admMxbU5kUE1ld0thYzhaWnRBR0FsMER6b1RqbXNjZkJuNG12Sm42?=
 =?utf-8?B?aDdkQStNWmtGWVNIUjJoSHR3RDdDQ3BnTkU3akVUci94SXVUb3JDY1pDWU5m?=
 =?utf-8?B?QkRjUmNScjF3bHg4VUUvSm1jSk0yMmRSYis1N2pGWG5PRXd4TXdDdzZiTHRG?=
 =?utf-8?B?dG1WeWFBY29MOU0rUytSeWhRdU9jWFNBNGxUOVBsUGY2V2tBWVo1RzZSMnVP?=
 =?utf-8?B?OU5yY0c3QVNYZzM4QXlzbmI0Qi9obmZlZ25ndjhBaUl0SWRIK3prUUpBc2J6?=
 =?utf-8?B?UjFrMjE5MWVmZmtmR21OR0JOTFRyTytmWVdZWkJXdXE2anJkSVFFdUo0RnNi?=
 =?utf-8?B?c2VWOEJYRFlSNHlqYm44bldMdklLdDhqYWpnb2hJNUF0ck1QZ0tvSjZneVhC?=
 =?utf-8?B?WUN6TS9YSUZZUlpDbDlSeDRpNmdwMC9rM0hYVlUxQ3Z6MjZOWlg0S2lPUkJT?=
 =?utf-8?B?Z0dCYTFGVVN5WXppbGY4SUo5bjJIbjBMRmtXcm5mS3J3eGl1RkJvL1R5N1FK?=
 =?utf-8?B?SFZXdE93Ny91SXFqWjEveUtYQ1lLbHFkckZ4WnI3S29VMFlQVCt0Ui9hMVZX?=
 =?utf-8?B?ZDdCTVY2eXBZWDE4bU9HZDlEQ3JHZmdoZkE0K3ZjVndEZnBjWE0xYlMxSVRm?=
 =?utf-8?B?Q2RGNUs5RDRqdGsyai95d0JMMWhERkUyRGJzY0lXS0FKVWVRMFZtQWszRU05?=
 =?utf-8?B?UEd5djROZnNxSThtSy90eFVMYWszK0tUdTlmcTA2VVFEdk9Na1VlZ0FVL2lC?=
 =?utf-8?B?alp6eEFPTkcrbmdwVE1yUUJocEdPTDJuaEYvNVg2UnlKOGRCR1Bra0pFMDBS?=
 =?utf-8?B?aGl4U3RML0RKZ1dKV002U0V1SmtWY2NnMS9pWTh1N0VuTmh6Q01GYW01U0c1?=
 =?utf-8?B?bDhqallxRlN1c0FEQVZJTkhjVTNFbkduVzlmcTB5alA4KytMaVpNakQ5c0dv?=
 =?utf-8?B?WGZpNDBnU2hRZHNVeWJWTWJBNU5JNDQyT3B1T01hSkg3QkRGcDhVODNjZ1hI?=
 =?utf-8?B?L1FGczd0K1hnK2lJOWlQS3lNODVPb3hST3lnRkdoTFlONUJhOUlMcDZxVEZK?=
 =?utf-8?B?Q3V4YUNaNzMrSkdKVmU5bzJycEZqak96SnMwYkkvYjM2RDF6c0E3RExDQVVD?=
 =?utf-8?B?SlJsNnpkSllMTjJWWDJ6Q2J1VTEwQUtEblhNZEtQWk8wRlZUT0dJWDVkSkVG?=
 =?utf-8?B?OS9qR1dLWU9PWUIyT0F4eE1Xa2lqTklhZEI3a2JZZHVBZTJ0VWhwOXlGMDBm?=
 =?utf-8?B?RWoza21HYktVR3hjZnNzT1YzSUVNbTRhQ0ZXeFdHOXlURFNkdzZOQ3RGVkRT?=
 =?utf-8?Q?RNDUJKkG3fgbAsjx9kLBgBRX+kUQlJV6R7z2cfKwjpxj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4a58d8-43ef-42cf-e08b-08daf52b37c6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:58:39.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymbHjzxEgxdFxTK7ybh4fY6PjcDmpGuMhH66ZLFEM7SDp9Fy7wZ95/e4VlQ04mE6yKIjgMchVNxxBaNOFFezfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 23:21, Wyes Karny wrote:
>  From ACPI spec below 3 modes for CPPC can be defined:
> 1. Non autonomous: OS scaling governor specifies operating frequency/
>     performance level through `Desired Performance` register and platform
> follows that.
> 2. Guided autonomous: OS scaling governor specifies min and max
>     frequencies/ performance levels through `Minimum Performance` and
> `Maximum Performance` register, and platform can autonomously select an
> operating frequency in this range.
> 3. Fully autonomous: OS only hints (via EPP) to platform for the required
>     energy performance preference for the workload and platform autonomously
> scales the frequency.
> 
> Currently (1) is supported by amd_pstate as passive mode, and (3) is
> implemented by EPP support. This change is to support (2).
> 
> In guided autonomous mode the min_perf is based on the input from the
> scaling governor. For example, in case of schedutil this value depends
> on the current utilization. And max_perf is set to max capacity.
> 
> To activate guided auto mode ``amd_pstate=guided`` command line
> parameter has to be passed in the kernel.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>   .../admin-guide/kernel-parameters.txt         | 15 ++++++----
>   drivers/cpufreq/amd-pstate.c                  | 29 ++++++++++++++++---
>   include/linux/amd-pstate.h                    |  2 ++
>   3 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e3618dfdb36a..0d8486325c9a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7015,11 +7015,11 @@
>   			  Do not enable amd_pstate as the default
>   			  scaling driver for the supported processors
>   			passive
> -			  Use amd_pstate as a scaling driver, driver requests a
> -			  desired performance on this abstract scale and the power
> -			  management firmware translates the requests into actual
> -			  hardware states (core frequency, data fabric and memory
> -			  clocks etc.)
> +			  Use amd_pstate with passive mode as a scaling driver.
> +			  In this mode autonomous selection is disabled.
> +			  Driver requests a desired performance level and platform
> +			  tires to match the same performance level (if it is
> +			  satisfied by guaranteed performance level).
>   			active
>   			  Use amd_pstate_epp driver instance as the scaling driver,
>   			  driver provides a hint to the hardware if software wants
> @@ -7027,3 +7027,8 @@
>   			  to the CPPC firmware. then CPPC power algorithm will
>   			  calculate the runtime workload and adjust the realtime cores
>   			  frequency.
> +			guided
> +			  Activate guided autonomous mode. Driver requests minimum and
> +			  maximum performance level and the platform autonomously
> +			  selects a performance level in this range and appropriate
> +			  to the current workload.
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 87450413cf45..20d78dad712d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -267,6 +267,20 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>   		   cppc_perf.lowest_nonlinear_perf);
>   	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
>   
> +	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
> +	if (ret) {
> +		pr_warn("failed to get auto_sel\n");

To make debugging easier in the future perhaps:

pr_warn("failed to get auto sel: %d\n", ret);

> +		return 0;
> +	}
> +
> +	if (cppc_state == AMD_PSTATE_PASSIVE)
> +		ret = cppc_set_auto_sel(cpudata->cpu, 0);
> +	else if (cppc_state == AMD_PSTATE_GUIDED)
> +		ret = cppc_set_auto_sel(cpudata->cpu, 1);
> +

as a simplification maybe:

ret = cppc_set_auto_sel(cpudata->cpu, cppc_state == AMD_PSTATE_PASSIVE ? 
0 : 1);

> +	if (ret)
> +		pr_warn("failed to set auto_sel\n");

Again, probably good to emit the error code in this message;
> +
>   	return 0;

As this could fail now shouldn't you be returning ret?

>   }
>   
> @@ -344,12 +358,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>   }
>   
>   static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> -			      u32 des_perf, u32 max_perf, bool fast_switch)
> +			      u32 des_perf, u32 max_perf, bool fast_switch, int guv_flags)
>   {
>   	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>   	u64 value = prev;
>   
>   	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> +
> +	if ((cppc_state == AMD_PSTATE_GUIDED) && (guv_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
> +		min_perf = des_perf;
> +		des_perf = 0;
> +	}
> +
>   	value &= ~AMD_CPPC_MIN_PERF(~0L);
>   	value |= AMD_CPPC_MIN_PERF(min_perf);
>   
> @@ -404,7 +424,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>   
>   	cpufreq_freq_transition_begin(policy, &freqs);
>   	amd_pstate_update(cpudata, min_perf, des_perf,
> -			  max_perf, false);
> +			  max_perf, false, policy->governor->flags);
>   	cpufreq_freq_transition_end(policy, &freqs, false);
>   
>   	return 0;
> @@ -438,7 +458,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   	if (max_perf < min_perf)
>   		max_perf = min_perf;
>   
> -	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> +	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
> +			policy->governor->flags);
>   	cpufreq_cpu_put(policy);
>   }
>   
> @@ -1233,7 +1254,7 @@ static int __init amd_pstate_init(void)
>   	/* capability check */
>   	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>   		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		if (cppc_state == AMD_PSTATE_PASSIVE)
> +		if (cppc_state != AMD_PSTATE_ACTIVE)
>   			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   	} else {
>   		pr_debug("AMD CPPC shared memory based functionality is supported\n");
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 15761a581e82..e07cfbd63560 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -92,6 +92,7 @@ enum amd_pstate_mode {
>   	AMD_PSTATE_DISABLE = 0,
>   	AMD_PSTATE_PASSIVE,
>   	AMD_PSTATE_ACTIVE,
> +	AMD_PSTATE_GUIDED,
>   	AMD_PSTATE_MAX,
>   };
>   
> @@ -99,6 +100,7 @@ static const char * const amd_pstate_mode_string[] = {
>   	[AMD_PSTATE_DISABLE]     = "disable",
>   	[AMD_PSTATE_PASSIVE]     = "passive",
>   	[AMD_PSTATE_ACTIVE]      = "active",
> +	[AMD_PSTATE_GUIDED]      = "guided",
>   	NULL,
>   };
>   

