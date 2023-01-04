Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DDA65CB32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjADBFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjADBFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:05:10 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BD617411;
        Tue,  3 Jan 2023 17:05:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2hnxJLfPQZLGxGHoAXODvf7852KhuuqeZSjNudYxpcT0BQX2JNSpT9qs8Opv1CTEFXomkpAgyRywbq+eFr0DPov+GtwMkSR+gx3PBGCYK+PPZuNtGbTbQRjKzU63lucnPX38TMCB4+8efhOyssF0QhRjF468V4drIohBGvzO1koDz/JjtJzQ0dTA8tmsrP/q3Mbnk2VRAgC+eaYXtomZdgl5tKIONob2YkpcmKwU63JxDn9BuPZxpo/PO4dZLLTFUdcEa0VhHZAgWVGjtKmeZcQ6jxi+OJk9AHivhQnJn9tEAJe/Qw5XPNif1u9ZxgLe30pv9+xuDMl7P/rS4HozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dldwSiE1/DMEKCaNiwEgh0bXn/97r1QXcu8g5731QWw=;
 b=jQyusHhZ0skpLptD5U207qyY+YMu6pfEg+jigpwVi9dYAO0dEFHqRYIlxqymJwwXmCigAB7/N07WqIVI7nB0WlE2CmjN5gy/B1wlMjUSnNKi34m8jX0xRuGgvh8l4dduxLHqN1j/IRyLs7yUaaieSln5AWh5crg70B66GhKc/0XtvvX1+7XlMZ8+mNWZ4Nwogdf7UGWMfZUzYH43f4CMHEwPy9vPbpw8Kdjo0KGPW/Lm87Q7JJ3PcmwkdXxDB4S7LjLrzgF8TFHx/mEZQ541fKIYqpnD3WOg8q8VCvWzohhgmb0O/SrN3I6QEyy76wC3W0+QmwCT6iBwWWAZPhQaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dldwSiE1/DMEKCaNiwEgh0bXn/97r1QXcu8g5731QWw=;
 b=oZIPUX9gTjJG2Um8Q3BKu37zz/CSKpl8t9p2tBE9DbfRr4LM2jWAJ3p5C8IAWww8ecAxKfE5/uBICnp4VZyB2+capMq9PsgBefV6EuIxnXxdDm9S1JEPVCMI/2hMv9ICQLm2K2rSDzHaomP0Mi7p3bO0/MiWK8jk7pVL3inhFvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 01:05:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 01:05:04 +0000
Message-ID: <b8231671-6016-ec18-33d8-578bb01be674@amd.com>
Date:   Tue, 3 Jan 2023 19:05:00 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 06/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-7-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221225163442.2205660-7-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0419.namprd03.prod.outlook.com
 (2603:10b6:610:11b::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: e1773e07-aa14-4881-b798-08daedefb669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCB2J7MZquWLpsKH8COVhEbPITtrjwdE0+8JXxCH2zXZkYZAHU6lyc2PCEyt1aKebPN3FevncNor0QCKFG2do+1Y4NAoL1TIR+5xTKV3jRnefw86YuHz27OuVm6c1rVK7tG6/qeCN7aKb1v3Mmoz5BT/51k4LXRV2eR4TEoeLo8RXphoEP1y9BFKS5KhL59GCwh6A75WA+zOP2i8yDz/xTOSR3eRBMp7vVVcYaic7qRbMr8Ccses706CvIBIUD8gnPnql+ap4bfKCvAVk9KEcb+0PtpLpcTy5UB8z0yw80FCca5+66sUIZdGs1oUMDX+ioXfqsYAgKhODtNi5ehNpuD7y1NITH4kSRaSvTYJ67HojtonPa4gqB3+741ILfuVkaunSAY2SFM7LSBpTW2DnPcfXwqtEVSxO4QxWi1cZcf6mu1LUHWXyGnEzbe7Enw559NTy7GkWBfZIgmSU+IrIDSlIu1L/y5e8lyJVeB2bM6dFVMXLmtdiomCQwpSEziM+mOMQT79tt0Sc+lv+3Mip5dE0X91qC1MmZeBckzGJWY/1BWSdKTDasJbB+pDZ8118sfpkKuHpTy7EeChYBUGYQhlivXrQTIHKG5y2NglolNxaiZwFutTdgI/JxUlsziz5J1dvGEDBeHKW7+tOfeFe6EHldJgJj6K7oPtus0sC5LDAlklZkmPaw133jftvBqoSPAaDQnGtSXHntfyHM/VFgaIlB0BF1O6eTpzSN9vr88=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(8676002)(4326008)(5660300002)(66476007)(6666004)(66556008)(8936002)(66946007)(316002)(41300700001)(6486002)(2906002)(478600001)(6506007)(31686004)(38100700002)(2616005)(6512007)(26005)(186003)(53546011)(36756003)(30864003)(31696002)(83380400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZCSGNmV0J1d0x6SWgwSlJRQ3hlc3NCZVRCTXAxWUVDcFpORkV5SFg0L2pa?=
 =?utf-8?B?TGNlWWlaaFRGNnZCcmRpdnh3YlQ3bnJpZXJjVE9FR0gxcysyZ1c0VzA0QlMx?=
 =?utf-8?B?Nm9JSWpNK2x6ZmJITVdlVVNCTGsvZXhKOGR2cURHU2VIUHhtbWY2MFp0RHlO?=
 =?utf-8?B?bENDM3NMdCs1ZUQwU25vWjlFWGgyRzA4dDhUbHpScFVwM1RVemZVa3hxR0hP?=
 =?utf-8?B?T0d2SThkcCtWOE56bi9vb3NEYkdxbjF2MDhzN0RjY2JLa2dUK2VCekVVL1A3?=
 =?utf-8?B?TU1RL3BZZlRuUHgrRHJxbmZCazlYRWxWVEREZnVqQnYreVZ0a21WTnpQMG50?=
 =?utf-8?B?bjlKWmxzYTQ3MmVUTW0wb0p1UFJ3bEVtbDExYVNKRlRYSHkrSi9rZjN4cE83?=
 =?utf-8?B?WERUaE53RTZEc1NxSG4rcHNZT1JadEJ0UXRLN0FsNHpGYnRyR09WM3A0cDZC?=
 =?utf-8?B?NlAwYy9qMkp6YWpJaCs0cW9lOW9ZZFB2RU5uWndvamd3WG45NXFxL3NPdXJa?=
 =?utf-8?B?SG9pZEluZzViVHI4VkJxMTdxeVBNYzl4OUFySXZLSTV6U1BjQ0xqUWhDZDY1?=
 =?utf-8?B?cGo4Vlp4ZVlUVXdSbjF1QURNSDhiaGxUd0k2NVdaa2FOZHJjTzFIVWRNT3A4?=
 =?utf-8?B?OXJvaUZPcXA5VGN4cTBRbW1iZEJhazRXNHhuenlkTW1QL1puS2tJTzg5N252?=
 =?utf-8?B?KzNMMG9YR0J2VEhZZ2VTVUNuTG1McG9xRmEvSWFnK3dVdzlUeDl4bkhQc1Bm?=
 =?utf-8?B?dXNLSDR6Q1lSaVd5Z0haRkt3dnBjT0pCMGFnNUhEUnFacW9pc3E4VW9yL3dj?=
 =?utf-8?B?dGk2bGs3VmIxV1JlQmFlTnNLS3FKMk50QWNmQ1pvNEpKenBDTmpYT04xdkFP?=
 =?utf-8?B?dXpkdnBIbW5YWE9QUzg2K2kvamZjMXlES0F5d3NIa2dmQmhpN2p0dGIxSlZN?=
 =?utf-8?B?Nkw5azFaVWtBU0Ywb1lnSmhiQUVQMVdYY3BrUTNGdWdLNzZNS2NCQTB6aUpD?=
 =?utf-8?B?YWVhMEEwU09kU1RBYm0zUlQ0TlNqR2VOVEVGT1ErNkUxYm9UY21aMUtGWWJM?=
 =?utf-8?B?UXc3S3NTYXJMSWY5WGJmQ2gxZ2pzQ3NBcDM2bG03OGhMTS9qbmpqdENiem5S?=
 =?utf-8?B?MVljaGxSR205bS9PL09Sa0p3b0lqOUMxR1NOamV6VHdyNVFsRFhsSDBLR0ZI?=
 =?utf-8?B?LzBkQWJsR041NERVaUF3NThSVGxLbnp5TGlXa3EvV2VjdHc3ODk0WWdmMVhn?=
 =?utf-8?B?R2IvUS9sNVBFeGZLOGVLSk1jTHo5OVhlQlFENllaaCtsdFM0dkpHQllTRHVw?=
 =?utf-8?B?ZzNKVktyRXl5SmMzaHRWVEtyN1BKSEFkdkVmbjRUSTN6bnJHSmY2eTVyWkw2?=
 =?utf-8?B?MFJRTFJ1cUpIZ2ErdEJ5RFJ5Q1BkUEcxV3NSYnBWTit4MjNCejhBVURQdEN4?=
 =?utf-8?B?MUx1NThsZzA5UmlpTDRyM09KNUp6TFB0a0Ztd2lwVlFIbk44WGE2SldlWHdU?=
 =?utf-8?B?WEMrc3pyYVVZemd5VUJoUEhXT2JVSXQxeVM1aEJ5WnNlOVdrVjM3akY0dnRB?=
 =?utf-8?B?OGJmcmhHaVdzNzNjM0FBRzd5TTBXQUdYcXBKbFkwTHpsQUc3ZjRFMnNOZk5r?=
 =?utf-8?B?RnZxMFcxMjFybnYzMGlDaTNOTkZsSU5FNXo2NGdDWTZDVk9sekpDNjJLSUFl?=
 =?utf-8?B?Q3BUdUszQjZiVFZKaXVNS3U3d0IxMFNnT0RGTGNLTVA1V0hVdU10Q2ViajFR?=
 =?utf-8?B?RE9yT1RDTHpodXRZRXh4SW41TnRCUktPeElUM0NLYjAycUtTYWRBS2FPR05r?=
 =?utf-8?B?Ky9rMitHMVY2NjdFWFlpd3pYd0VWUFBldU1NV2hnYXRKbHF1MmVpQ2orNUg5?=
 =?utf-8?B?R1hHems0cW5KQWxCZHliRk1kMlMreTB5YUJCalZnZ0NBdkFxQTFpZW1rRVd4?=
 =?utf-8?B?NFFuS1NBVmJPb2JDU1NzcEJac3JLNjFVTEhJc0l4SWI3cWFSOVZPSkxMTDM5?=
 =?utf-8?B?UmNRRTVwaHhSV3B6eldwRXVLNUlUUHRhaGxiTnM2azlEQ25iRjNaWWorVmVF?=
 =?utf-8?B?OEVNdWZ4ZE9aNlh2TysxUGxNZHhacnF5bnBIVE4waXJ2b2pWRDZvdGZDb2pq?=
 =?utf-8?Q?rcAlkJUX8QZAGy44S45Hyr29L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1773e07-aa14-4881-b798-08daedefb669
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 01:05:04.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VigEXkyH5G2EZZPJaVjJoRZbRqWkTxsOyIHnSNfd7eWe1M2MGj/TZAD3VbzUwOKh6+0zYFc0OubCeGUnQG313w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 374 ++++++++++++++++++++++++++++++++++-
>   include/linux/amd-pstate.h   |  10 +
>   2 files changed, 378 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 65c16edbbb20..779bbb58d909 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -59,7 +59,9 @@
>    * we disable it by default to go acpi-cpufreq on these processors and add a
>    * module parameter to be able to enable it manually for debugging.
>    */
> +static struct cpufreq_driver *default_pstate_driver;

Considering how this is used and that it can be changed dynamically via 
sysfs, I think this pointer would be better named 
"current_pstate_driver" or perhaps "active_pstate_driver".

>   static struct cpufreq_driver amd_pstate_driver;
> +static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_DISABLE;
>   
>   static inline int get_mode_idx_from_str(const char *str, size_t size)
> @@ -73,6 +75,114 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>   	return -EINVAL;
>   }
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
> +	case HWP_EPP_PERFORMANCE:
> +		index = EPP_INDEX_PERFORMANCE;
> +		break;
> +	case HWP_EPP_BALANCE_PERFORMANCE:
> +		index = EPP_INDEX_BALANCE_PERFORMANCE;
> +		break;
> +	case HWP_EPP_BALANCE_POWERSAVE:
> +		index = EPP_INDEX_BALANCE_POWERSAVE;
> +		break;
> +	case HWP_EPP_POWERSAVE:
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
>   static inline int pstate_enable(bool enable)
>   {
>   	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> @@ -81,11 +191,21 @@ static inline int pstate_enable(bool enable)
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
> +		if (cppc_state == AMD_PSTATE_ACTIVE) {
> +			/* Set desired perf as zero to allow EPP firmware control */
> +			perf_ctrls.desired_perf = 0;
> +			ret = cppc_set_perf(cpu, &perf_ctrls);
> +			if (ret)
> +				return ret;
> +		}
>   	}
>   
>   	return ret;
> @@ -429,7 +549,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>   		return;
>   
>   	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	default_pstate_driver->boost_enabled = true;
>   }
>   
>   static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -603,10 +723,61 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>   	return sprintf(&buf[0], "%u\n", perf);
>   }
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
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
>   cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_rw(energy_performance_preference);
> +cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -615,6 +786,181 @@ static struct freq_attr *amd_pstate_attr[] = {
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
> +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> +	struct amd_cpudata *cpudata;
> +	struct device *dev;
> +	int rc;
> +	u64 value;
> +
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
> +	cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
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
>   static struct cpufreq_driver amd_pstate_driver = {
>   	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>   	.verify		= amd_pstate_verify,
> @@ -628,6 +974,16 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.attr		= amd_pstate_attr,
>   };
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
>   static int __init amd_pstate_init(void)
>   {
>   	int ret;
> @@ -656,7 +1012,8 @@ static int __init amd_pstate_init(void)
>   	/* capability check */
>   	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>   		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   	} else {
>   		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>   		static_call_update(amd_pstate_enable, cppc_enable);
> @@ -667,14 +1024,13 @@ static int __init amd_pstate_init(void)
>   	/* enable amd pstate feature */
>   	ret = amd_pstate_enable(true);
>   	if (ret) {
> -		pr_err("failed to enable amd-pstate with return %d\n", ret);
> +		pr_err("failed to enable with return %d\n", ret);
>   		return ret;
>   	}
>   
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(default_pstate_driver);
>   	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> -		       ret);
> +		pr_err("failed to register with return %d\n", ret);
>   
>   	return ret;
>   }
> @@ -696,6 +1052,12 @@ static int __init amd_pstate_param(char *str)
>   		if (cppc_state == AMD_PSTATE_DISABLE)
>   			pr_info("driver is explicitly disabled\n");
>   
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			default_pstate_driver = &amd_pstate_epp_driver;
> +
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			default_pstate_driver = &amd_pstate_driver;
> +
>   		return 0;
>   	}
>   
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index dae2ce0f6735..8341a2a2948a 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -47,6 +47,10 @@ struct amd_aperf_mperf {
>    * @prev: Last Aperf/Mperf/tsc count value read from register
>    * @freq: current cpu frequency value
>    * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + * @epp_policy: Last saved policy used to set energy-performance preference
> + * @epp_cached: Cached CPPC energy-performance preference value
> + * @policy: Cpufreq policy value
> + * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
>    *
>    * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>    * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -72,6 +76,12 @@ struct amd_cpudata {
>   
>   	u64	freq;
>   	bool	boost_supported;
> +
> +	/* EPP feature related attributes*/
> +	s16	epp_policy;
> +	s16	epp_cached;
> +	u32	policy;
> +	u64	cppc_cap1_cached;
>   };
>   
>   /*

