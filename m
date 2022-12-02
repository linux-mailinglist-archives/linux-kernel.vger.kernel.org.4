Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E224764099D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiLBP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiLBP5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:57:12 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056B3B6;
        Fri,  2 Dec 2022 07:57:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EI2R7ZJGVg4Qlfp5wIEa6N0HzFhj0BVseCPf9qfYnIqx2Y+3PqmIbG1L4z86dmr5RqdS40/JIwIW/X8RNnwRRrxsIehKIljU/EcUMU62VInmXEMjjFzwLl4vblPksHm+C9KCh7e7S/NVeCQi8YsIJrKe4dt7LCNqtRf5U3RlDKI5zlaaxmAt9+YI0kWggKY7+kH/UTvD6CyY3RQm92vsgYgo4sfiuDjqkUN4Ali9aC9U4Z5FSUyQIgSFQEMXzAbI11G05x6erlBdM9v9Bnr4vk/3rdl7juB0ZfxtUbaxznblNxDfR/m0TD5+76RRIa0Dyy8TmkqITIIImpuKUYqK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqpYOry6XWCqrTFofRX6yrv340AJ54Xh+Xa/k39QZA4=;
 b=fsSrumXCGulIYAH0K3fwob7v4ToYOK0zKWh1XWQ57M0CGR7E1/Wp02tZgzCYxMr+i2oC/ysK/IyCyOUj7l7lfe9pNoiO6B745wrxeD7J/hC41qFpVW16oJAw0fk7tjTdsxqf/cExzHIDHYo/wi4whW6JNo6s8jnhcwNMCsdm9MjYuDjs9e8qffikIHAUp0U5p1p06g3nwb9cJeeAS1/lFd9vDyKKaokE6AemH4N8QGl9uNDpRScNJ+XlbQA8O8noUGkVtuveGAcTj+JBbYN8QrTOI+i7PkrgYpKbN0a+UYK7WNa/JnkjIm060vCuXlwCvkHjsW9BOKfAXPiMH6XqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqpYOry6XWCqrTFofRX6yrv340AJ54Xh+Xa/k39QZA4=;
 b=3GLIQj/X40Zj3DYISLHDZF53IDVe2SqvcWyTipnPnAGNxsrS/5l2LzSa/CagB0VGAOk8ZLpb73ElcVLpD4uPN+CRfTygqW2Sc3dIZjtcgt8iPhVw8/4a8aR0aqJCdZ845dcSoNUjxWHlrXofsBKGAynQxCqBPBjXMgurY+N3hEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 15:57:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 15:57:09 +0000
Message-ID: <b984800e-9d70-3f43-1af2-7f3d85d356bd@amd.com>
Date:   Fri, 2 Dec 2022 09:57:06 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v6 08/11] cpufreq: amd_pstate: add driver working mode
 status sysfs entry
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221202074719.623673-1-perry.yuan@amd.com>
 <20221202074719.623673-9-perry.yuan@amd.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221202074719.623673-9-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0280.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 72413c16-ed8b-4a79-20aa-08dad47dde20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLekf7x5DPLXPpJzX2igY/+mU/WQVCDQoF2QkqMeHQEXdEfZ9A+5r4AHmWuA24MCNnks//XDSYctzLUkVEX9P2ipnsD5zcJkOu6s/umtHe9TY6TxUNTCDrFMwNJEm9EJmz/a9JfvefHSGmXLtXQff3aIxB50J8UZvyJU3+AKg/dK79jULhaQoBjuPJ9Ip+TYUNpW7csbLCNot/Shs2QY2/sZfBw7nfAep3ytS5lL/oL2ybe5tPIHyej5G0zbcNmrBAihS12ZHi9GyGBrVnKgMdBXS3ZWoJiGHl3WRWzIHWx6J5irDotF64qye/fLKNWX8tiL0unT6MhGXVQNmW0mVFjS4gPgm7vqipaFMth6g6vlFL9vZ0nM/xz/S0Rpa9pHhx4/dQVG2t3tShD1UjtFTdv6z+T+TayTl+ZejG+TucapPF9ppqfmgKUv3lxGkYfPSb2M126Ov9UfPwhsuEtlrEbFS6y8HTObXBpS6zK5uG/owelOMlFySu7HlBE4ylO8VTya/71R4sCOMWsMgJw6z13UrkU1K6DoqDxRMqhLYC1m8bMRqYvCIycPaFqcb3vQhVU+6EwWg7lrl09zANUlHoC4bhy7gWO3IaNJQZmvrR6DRdN1zXBQJTstsOUb9k71R8Cawrh7bua0sQYZIw/tlJ+k31ciFslgMkkwyUeKX05tYDTGXO3lMwxvCGOYP67v0XDUK15SYEjsAiS3H8dqeT7NxX1kNUoTk+b/XDzAxTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(83380400001)(6486002)(478600001)(38100700002)(8936002)(6666004)(5660300002)(41300700001)(4326008)(66946007)(316002)(2616005)(66476007)(6512007)(66556008)(186003)(2906002)(6506007)(8676002)(53546011)(86362001)(26005)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFNNcldYaDlFWG1SU3piOTNmK3JSOU5KMytUK1hxNEt1dmUycTRCK09Wbkth?=
 =?utf-8?B?emsvSjM2V1NCYVJqMEZwb3hVODNLUEk5blcrOGduQWdWRTVZenRDOXFHdzNI?=
 =?utf-8?B?dUhKMVlBK0Q4emJueEtpMnQ5N083ci9SRVRnWlRWb042KzVVbW5pemRSc0dv?=
 =?utf-8?B?TUIwS3lpTlJQOVJ6eXVUM2h0ZWlqaXVwb3ZWUWQ1Z1BNS2pFOGlWaW4ySDV0?=
 =?utf-8?B?Tnd6NHlmMUdBMlVDSnV3OWpoRnRSckhwRW8zeFJEVkxxdDAwSExDS3k3Rk9V?=
 =?utf-8?B?NlArT0ptb2ZHTmJBOE9GMjI4c3ZSRUJOVFpVNjBnNmF5eEJpdncxMVJGUnAx?=
 =?utf-8?B?eGNyOTBjNlR1MG4xaEVJOFN5cGI0TjRxMjdEWWRCSnUySkNDSWNlVmpYRWNT?=
 =?utf-8?B?WUdKUGRJMVQvNnNMUzlaNEs1cVRtRjQvUGNBSTZRczVVZ0duUUFqOWdPZ0Rl?=
 =?utf-8?B?RTNuc0tHN0lwZC9FQkpjWjdwRlgrUHU1WFRGclU0QU8xL2tXMHBtbTZXUVN4?=
 =?utf-8?B?VGFSdWhYeUsrbWhpNTEwcUJGbmY5QlZXYitTUzBUK0lyRVpTbHNqVFFMMk1q?=
 =?utf-8?B?a0VKNk9aZUIzc05lekd3cXVqVHVXaUNaQlduM2tvcDVrUGFWeTA3eDlTY3Zt?=
 =?utf-8?B?Qjcwd09YeWN3N0tOWDBmNXJZci9MRkIyaHYwL1hUb2ttd3l2ckFJZ09OMU44?=
 =?utf-8?B?SjJoVGxqRGxIcVdZN0lPeEJmY3Zwckl1QTluWHYwNG5EMkUrWHRKdEZSUXMx?=
 =?utf-8?B?MGdCNWhaTElEZnE3RFNUSnJnR3YzYzNTelJUaExqZThndHVOZCtQbWJ1VEJ5?=
 =?utf-8?B?d1RKUXhwelFTK3V3RGtURThWbjliREtlMitaSlc5QTZDKzgxY2ptYjlFbTRw?=
 =?utf-8?B?ZlRyKzQ3WUZJSU02cHZUc05aTjMzVkxFaXI5RjVRd1JmYWpWV0NUdjZBMVZy?=
 =?utf-8?B?RE9aekorSUFOL0Y2cXB4SC9nL3ZkR3pjU1I4aEZnTWd0MkROajRXUjVkdEtY?=
 =?utf-8?B?VEhoRmUrbzdvNUlkNmIvNTBwT0EwalJRMXE2RHQ0d1JuY2IrSGZLV2ZaSXFs?=
 =?utf-8?B?OFRyTHRRcEozZUtLUDdDcEhTVGNQZmo3RkRHdStTekNBWFFSZWxQMmxPdkFR?=
 =?utf-8?B?QVJLZW9GSVRhODJFOENnM3RyWmptejFuR2lKc09KYk9Ldmw5WDBuQng2THFU?=
 =?utf-8?B?b2RrR3N6MHVmVUk0bTRrbTlIT1NMcVFRK1BaTjJJcGNsbGtEaEhnMkR6NVVB?=
 =?utf-8?B?Q1VBeGoxQkVueGl2cFhLRzRBVWVUaXF2dEc5VFhzOVNNYlRoaUlkRWdyVTRV?=
 =?utf-8?B?NlU2eUFORk9RUzh4NmtTUzU5RnBmQno5Uzd4cGZDRkl0WHAzZ3VHQ3liRnRK?=
 =?utf-8?B?VnVJRitIS3Y0VFdxdnhtVGI1KzhQdFRqWGdNeXl0dkt4WVZVa1J3YWJ1T2p3?=
 =?utf-8?B?Tzg2aXlsSkVxYlRhWHg4cGFFUXhYWXNBMG1oRmZtRCt1cjQrd2VVcE1vc1Vl?=
 =?utf-8?B?aWVQSmdWRVl4bDRLbEZ3a29HaFlGeTFGSU9ScUpnbGs5L2dVek5Fa0lMNkVj?=
 =?utf-8?B?VW9PaEZLUVNGR0Q4MWpqL3pHYUdzVUdzcjc3VHFIM1hBOWJQcStnM3B6cDBt?=
 =?utf-8?B?aitSVkhQRGpoVTVTREl5aEVoblc4bmltU2JRZjhuRlo5OWdUMFprVHpTS2Vm?=
 =?utf-8?B?dTdEcndNWGFzcUZZV1RHZkhJMGpla3lWK09pMVRic09IdmorcitlQldISVUw?=
 =?utf-8?B?a3hmR2YyYVc1Vi9VY09ZVDFXMGVaVGhTd25XUjdTMVh2ZHBMWm50NTJORmFL?=
 =?utf-8?B?SkYyZk1GRFZ0V2tLOEdhaUpTSk1PUFNhTEpXaVl3aXNxOGRKM1Y4anhCVHBv?=
 =?utf-8?B?Vk5hZWRqeVdtcGg3L3o4Vk8yS0t4WmwxdDIvUEZKS254WjdjYndlTnpoa3oy?=
 =?utf-8?B?R3RLT05NK2ZvWG9uSjFVNzIrTEtWMXV1OThSMk9xZCtsR1VmTWN4cU8xM1JU?=
 =?utf-8?B?SjZrNjRUUE5idDVKdEdMK3FWelZNaU5TK2RQSUFCUjNkK1E4Qi9UdzROK0lC?=
 =?utf-8?B?R0YvbU0rTDVCU0h5VURJWHV2VGttcmhjY3Jyek9HVUMxZUN4bFVpNlRNSHNV?=
 =?utf-8?Q?H1FNY8LyM863ZwOM7aUxDjUfr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72413c16-ed8b-4a79-20aa-08dad47dde20
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 15:57:09.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re2DYQ255C+XZja6SoYAK60ZVEowzL3EBvrfpLQOAJ494vL/mwgQ70vRyqaFGFUwVUALnoVtYUySEReFzkOHMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/2022 01:47, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> While amd-pstate driver was loaded with specific driver mode, it will

The *driver* doesn't need to check which mode is enabled from the sysfs 
file, but userspace may want to check this.  I think you should reword 
this accordingly in the commit message.

> need to check which mode is enabled for the pstate driver,add this sysfs
> entry to show the current status
> 
> $ cat /sys/devices/system/cpu/amd-pstate/status
> active
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6936df6e8642..7f748a579023 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -66,6 +66,8 @@ static bool cppc_active;
>   static int cppc_load __initdata;
>   
>   static struct cpufreq_driver *default_pstate_driver;
> +static struct cpufreq_driver amd_pstate_epp_driver;
> +static struct cpufreq_driver amd_pstate_driver;
>   static struct amd_cpudata **all_cpu_data;
>   static struct amd_pstate_params global_params;
>   
> @@ -807,6 +809,46 @@ static ssize_t store_boost(struct kobject *a,
>   	return count;
>   }
>   
> +static ssize_t amd_pstate_show_status(char *buf)
> +{
> +	if (!default_pstate_driver)
> +		return sysfs_emit(buf, "off\n");
> +
> +	return sysfs_emit(buf, "%s\n", default_pstate_driver == &amd_pstate_epp_driver ?
> +					"active" : "passive");
> +}
> +
> +static int amd_pstate_update_status(const char *buf, size_t size)
> +{
> +	/* FIXME! */
> +	return -EOPNOTSUPP;
> +}

Why not just fix this as part of the series?  It should be no different 
than unloading the driver and reloading it in the appropriate mode, right?

Is this going to be a short term FIXME/TODO or a long term?  If it's 
long term, it might be better to just make the attribute ro and and have 
just the show callback.  Then when you're ready to make it rw you can 
add the store callback, change it from ro to rw and update documentation 
at that time.

> +
> +static ssize_t show_status(struct kobject *kobj,
> +			   struct kobj_attribute *attr, char *buf)
> +{
> +	ssize_t ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_show_status(buf);
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	char *p = memchr(buf, '\n', count);
> +	int ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_update_status(buf, p ? p - buf : count);
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return ret < 0 ? ret : count;
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -814,6 +856,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   define_one_global_rw(boost);
> +define_one_global_rw(status);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -833,6 +876,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&boost.attr,
> +	&status.attr,

In the series I didn't see a matching Documentation update for the new 
sysfs file, can you please add one?

>   	NULL
>   };
>   

