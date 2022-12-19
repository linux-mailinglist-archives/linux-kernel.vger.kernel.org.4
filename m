Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF336516C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiLSXjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiLSXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:39:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790C2FCD4;
        Mon, 19 Dec 2022 15:39:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kanuVz+y6mekdg0hRIX8uThNzn53a6puPa/W0dRJEhjMK2hk1ulhFMMk61ahxkcoBfiWTy8jYRhIQm+89QlKBom5tu6PPgArTw0fS0SVMO7nUpxxqknguV8pUAonLdRAHHdJM4IaHlqhA7ZWL+pxb+BMCbwbyF8Vek0r/1tfFzGkm+ubUhi1UigPy6zgcJwqgJYisnPfQ129Be9IDLpzTR5DL+RnSyJI9jfRWH5u4rhH+a3fmFu9OYeWeFH9TMGB10wKmQCiSLG/wAPOKvFwdYMd7bnfxxINsHAcGv9gZzC6/R0cyNiTq1o/9GrYkVwttXq9MgadOQfZdd3RkH8VEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHrbGt91maFUx0UX3hGSwdUarMEGwM6MaQYrk/mGkc8=;
 b=ffXZfzrBY8/EA3W6mjmenSOixOaP9H3WLvTM2tVM9dtYZhA20QTf20E6A9VO9FPaNkE0djOazKGVbidCmtddwADYdGubknud2tVZKDd3VTgwn+4geRoI6ABhwHRwFIPeKI3fkkvx9cei3M0xg/3FXdy8kxbsAh5/VildxKTl8zleZdx695j++v6qaSBzVA082ayYsSS1O1/r3jbfa4ZGiYZQ8XG6pR4BTSLfdapMH6gSWyCqb/u8s/qstoaVDeeANzfJ8w84/Vz8eEMmzUj1VLChL81guwqXKJz1rbRL8dTunadevTrBj6z7QtjS6lkiP2bMc0K4B6uMKLFp7onbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHrbGt91maFUx0UX3hGSwdUarMEGwM6MaQYrk/mGkc8=;
 b=0ldSwmY3eUV93n31rmHUYgc3mITTtmeUDJYwoF8BHIQzyu8FOCcseppg2yewKYFC3v88n+iyeWpI3BjKYWPldrTOelK4TUPxGSieXslF7mVMNziT0hdtsg1HOyw5ZW12F4iIJgdUFP/bTZeqiKTQcCZdWuS4zuyavcvOYP7KHjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 23:39:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 23:39:01 +0000
Message-ID: <d4b602e0-53cb-e7d5-7055-ea4b79fc909b@amd.com>
Date:   Mon, 19 Dec 2022 17:38:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 09/13] cpufreq: amd-pstate: add driver working mode
 switch support
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-10-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-10-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:91::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e64b4a-aeb0-4bde-8ce2-08dae21a353a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxABG+6I/c+PWpYI3mIhrDJAt88GWqOL3to7cEl0/I4TLktRjd6Ld4fAty50ARFis8NbLLGjzIwqT9GmejgWGV3EJCETvJ+UHw2c5M7iRrgf+FOJnpNTLmmz7D7nCkK15lKxxFdI8nNvvJDPiTuXc1nGfjPA27KrKpEDmOq6sHU0yeHUpXLbrZMupL5yw2KxOqo50ku+TSkdBA2Nfp1NjPHIuuG9ytGt7JyUzIegckWkgs4bbaKFlnrSDubsebEBYYZ7qyTuRrQb3CaI2YcZG00h2TsjzJvSdfzO9QQqURhSNdgGrpr341qk+4AlOOA2NYUFpvUKbLDj6ag+GZkmfZ6jyFQklXY3omBXagKBE4i6TMfI9Az18aH2rfcCprG6gFAURL+cSTzCahdkEfqrK2DQVKF58JT59B5JmoFChLPH/AKyvc6NydWPTxEEGyDnmx1/7jKY2ome+R6wMw8jxn//ifbFeQvti+oCCi+gEEuEXW6mowsBjjVTFrCl4VSwC4b5DaTJhnL8Y9JPLCH1Z7we0Ea33LI0no8p0vQyevk6CWc4em8lrfpjetCWL15L5NknkNPTgDHfo66BGMgScy4biXhhCdYb6n++umGeVNSxO2zyOE7yH6AIxrnEhM1r7jKDIxOzlXKkaIHAHCNNHy+QFcXPkFlqETUDZNLhIyLIOSk0c8tsPVKrBMxlA6BqQGBbyqxfrjfmfrIC+ltyjlPbLgnxtS/FzgT6lDBzJ+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(31686004)(5660300002)(8676002)(86362001)(4326008)(6512007)(6486002)(186003)(26005)(316002)(31696002)(2616005)(66556008)(66476007)(66946007)(478600001)(6506007)(53546011)(38100700002)(8936002)(83380400001)(36756003)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTd1cEJGVWlVeGJEY1JVaHNTVmluOVZxdUJYNDlpcE5xNWdFQmE5YmpCUnhD?=
 =?utf-8?B?RkRvb1V2S2dJR2h3bzZUdFdjblNnNVNDMThuOEJTb2NiaGgrUEVyclNxTVhD?=
 =?utf-8?B?Zyt5YWVpcm5rQjU5TTEzYjFDeW5RdG5PeUlnU2IyYjdFWmZSd2xUNVMzU2hv?=
 =?utf-8?B?d2VIMm45Mmdpa0J5eWtmWVdiRjVmNXNwVW1wVk53dW8xOFZvVGthS20vamN1?=
 =?utf-8?B?YnAwbkFtRXp2SWRhZ0dxbWZGai8yc2dGVDB0eXkveTRyOWtYUWUxR05SZ0xo?=
 =?utf-8?B?RFBCVWJ3OEd1NCt5UFNNM253bDkrbjc2R296T0xDdDYyVW90TVBNUGI1NDZE?=
 =?utf-8?B?OFo3b29zQ3NYYmJGU01TYi9ZY0ZyZ1FiMllHNW92dUkxa002NnNsa1FtbU1k?=
 =?utf-8?B?ekhuSnV1VGFIVUdCazlWOCtJY283SlNnd2U2dUcreWRNTXlaYkhWQU5tLzM3?=
 =?utf-8?B?MTJCTmlPTHJaTGl0SFBaTnhaUkR2cmRhTll4MTRsYitPV3VFQXNVbTdrcXgw?=
 =?utf-8?B?alNBMSswUkRCQ1dPSWNGVllBSktGR01GM3pmcXl5aDVnY1duWnZTWlc2WjJ5?=
 =?utf-8?B?dm9odFJWa1orRHpiKzVsZ3FEd2pEQVd4Z1RzL2ZYdTV1ZVlHUVFmZ2tIUzJX?=
 =?utf-8?B?ZWpvV1hHSkhBa21WMjFPRWh1TXN5blYxZ0crQ3NZTlp2RnZFZWFLVXU3U3JE?=
 =?utf-8?B?d3lpMmRJNVVXNXk4SzdibWtwS3ZEMVpwaWt2U2hWRmZNUml4ckFvWG1hK3l2?=
 =?utf-8?B?Z3VTb2lBRzNzZzJKT05sdXZFYkR0ejVlQXFoZGFla28yNndDeENlN2FQV3kz?=
 =?utf-8?B?ODJkKy9wd3hIdzBETW1JNGdQOVRiQjVKNDdHWVkzYjJvak9zSGNGaEVraEVH?=
 =?utf-8?B?aURld0F4OGRvTER2VFVDV0dqMGJuWTBlelFkR1U5UHpiRkF3UWR4ckxrU2hC?=
 =?utf-8?B?SUpHa1l2cFl1MDkvUjl4Q2pLQm80ZGlxREM5TkI3aXB3TmFURHF3L1FaNFB1?=
 =?utf-8?B?ZytPMHpYdi9CWEJhSFlBQnRpZGE2aGxqWnIxeDljOWc2MFUvVTRlemZjLzNv?=
 =?utf-8?B?MjU0dUZQMjVhdG5CTllFVHV5QURCbXQ2MkdLSVdJdFcwbkE0dmhHb05WWlRZ?=
 =?utf-8?B?UW1KOFRBSWhkMmxOUXdLaWg5RHR4WDdvd05hN2JoSGlHTTRJQzhPZXhvbnRr?=
 =?utf-8?B?Y3Qvb3pCV2RRNGxjeEhxckZYSFhSZmZlZGxZWm50NFZhWnppRDIxMkViYmZJ?=
 =?utf-8?B?TVU5SjFlYlZLMXdYZ3M5ZjRSd3hEVGUrdHd6T0lPQW85dlVjMENnekxsUjNo?=
 =?utf-8?B?WmVIRzQxSlVWZW1PMk5pdlA2b3o5MS94MVNGNkxkQllCUk53T21telRvbFRH?=
 =?utf-8?B?Yk5xMWdGYmxvZHVpWHV6b1duaFBTdy9VaHJBVllIS0t1OEd5bm15aWxZSGxC?=
 =?utf-8?B?bWVHRXp2bUtTNVJxR3UxMHArMUt3aElUY1Q0dk5aMlUvMk1zUVVLbW9VdU1q?=
 =?utf-8?B?QytRQkRaNlpsMWxpUnlSTDRWd3VrbTV1UHdLMTNDMmdjQ1c3NGdzdUNLRHBY?=
 =?utf-8?B?NzB1Qzk0SmcxN3NEcDhyMTU1dHlrMkxEcnhuVVFQZWJlenZGZjZTWjNwdjRM?=
 =?utf-8?B?RmRiR2oxYXUyYklOaTlsU0lZVTNJbDRjbEpra3RUNHFWa2RGdnJUalJPdHI3?=
 =?utf-8?B?Z0MxMzJsaWYyMm5BSTdIcDVBalpWMURKUVgwVEtQUUFCdUJIRHVwTURORWJR?=
 =?utf-8?B?bWJLZmRQTzdJLzUwM1Z3Y0FVcXdtODdFNzcveHIwQXA4aFQvK3A5djRDNHIx?=
 =?utf-8?B?cnNiMWwwalhQanBQTHBYejhOSE9nNlNEL1dyTklyaE0rRTUrTE13RVVEbERy?=
 =?utf-8?B?U2toeWYwOUFyZ0RkeW9kVS92TnJKQkRTVHFKTjdUMElBZ3lBbzhFRUNlclU1?=
 =?utf-8?B?UlhBSzRvS1F0aGNXY2E2Wkg5a2ZKZEYwVHFsRGoyYWYrNWhyVEJkUkhUSkpm?=
 =?utf-8?B?bUZHYnVZVmJvL3lmY2lBSmwzZkVVNUhNenJlVTFtZFQwYkxWNVc2cnByL29l?=
 =?utf-8?B?OHFvekh0VVE2MkZVOWJNc2lna3lHUTJwRnp2RkNNTzRneFVOMEJiU1FMTGFn?=
 =?utf-8?Q?jJ7Gv4uPYIjtjhPbkAkcytQV9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e64b4a-aeb0-4bde-8ce2-08dae21a353a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 23:39:01.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l70Dx1gUwBWIbSw0EvL2H9IhqVIsBnU+hqA5DCcDO+PwmzE8CxDiAi/gQ/U7w09FVGkFPjw5keZ43Wg7cZAUHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
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
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> While amd-pstate driver was loaded with specific driver mode, it will
> need to check which mode is enabled for the pstate driver,add this sysfs
> entry to show the current status
> 
> $ cat /sys/devices/system/cpu/amd-pstate/status
> active
> 
> Meanwhile, user can switch the pstate driver mode with writing mode
> string to sysfs entry as below.
> 
> Enable passive mode:
> $ sudo bash -c "echo passive >  /sys/devices/system/cpu/amd-pstate/status"
> 
> Enable active mode (EPP driver mode):
> $ sudo bash -c "echo active > /sys/devices/system/cpu/amd-pstate/status"
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 128 +++++++++++++++++++++++++++++++++++
>   1 file changed, 128 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fc12d35bc7bd..e8996e937e63 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -64,6 +64,7 @@ static struct cpufreq_driver amd_pstate_driver;
>   static struct cpufreq_driver amd_pstate_epp_driver;
>   static struct amd_cpudata **all_cpu_data;
>   static int cppc_state = AMD_PSTATE_DISABLE;
> +struct kobject *amd_pstate_kobj;
>   
>   static inline int get_mode_idx_from_str(const char *str, size_t size)
>   {
> @@ -90,6 +91,8 @@ static struct amd_pstate_params global_params;
>   static DEFINE_MUTEX(amd_pstate_limits_lock);
>   static DEFINE_MUTEX(amd_pstate_driver_lock);
>   
> +static DEFINE_SPINLOCK(cppc_notify_lock);
> +
>   static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
>   {
>   	u64 epp;
> @@ -644,6 +647,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	policy->driver_data = cpudata;
>   
>   	amd_pstate_boost_init(cpudata);
> +	if (!default_pstate_driver->adjust_perf)
> +		default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   
>   	return 0;
>   
> @@ -784,12 +789,106 @@ static ssize_t show_energy_performance_preference(
>   	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>   }
>   
> +static ssize_t amd_pstate_show_status(char *buf)
> +{
> +	if (!default_pstate_driver)
> +		return sysfs_emit(buf, "off\n");
> +
> +	return sysfs_emit(buf, "%s\n", default_pstate_driver == &amd_pstate_epp_driver ?
> +					"active" : "passive");

Didn't you introduce const strings for this in an earlier patch from the 
series?

How about using the indices from that rather than hardcoding /another/ 
string.

Also keep in mind guided mode will be coming so
"case ? true_val : false_val"

So perhaps you should just have have some if cases so you don't have to 
switch the whole thing out.

> +}
> +
> +static void amd_pstate_driver_cleanup(void)
> +{
> +	unsigned int cpu;
> +
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		if (all_cpu_data[cpu]) {
> +			spin_lock(&cppc_notify_lock);
> +			kfree(all_cpu_data[cpu]);
> +			WRITE_ONCE(all_cpu_data[cpu], NULL);
> +			spin_unlock(&cppc_notify_lock);
> +		}
> +	}
> +	cpus_read_unlock();
> +
> +	default_pstate_driver = NULL;
> +}
> +
> +static int amd_pstate_update_status(const char *buf, size_t size)
> +{

Rather than looking at each size for each case, how about you just look 
at the boundaries once?  Something like this:

if (size > 7 || size < 3)
	return -EINVAL;

Then you should be able to run strncmp for each of your cases.

> +	if (size == 3 && !strncmp(buf, "off", size)) {

This seems like another case that would be good to use the const strings 
you already introduced for state machine checking.

> +		if (!default_pstate_driver)
> +			return -EINVAL;
> +
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			return -EBUSY;
> +
> +		cpufreq_unregister_driver(default_pstate_driver);
> +		amd_pstate_driver_cleanup();
> +		return 0;
> +	}
> +
> +	if (size == 6 && !strncmp(buf, "active", size)) {

This seems like another case that would be good to use the const strings 
you already introduced for state machine checking.

> +		if (default_pstate_driver) {
> +			if (default_pstate_driver == &amd_pstate_epp_driver)
> +				return 0;
> +			cpufreq_unregister_driver(default_pstate_driver);
> +			default_pstate_driver = &amd_pstate_epp_driver;
> +			cppc_state = AMD_PSTATE_ACTIVE;
> +		}
> +
> +		return cpufreq_register_driver(default_pstate_driver);
> +	}
> +
> +	if (size == 7 && !strncmp(buf, "passive", size)) {

This seems like another case that would be good to use the const strings 
you already introduced for state machine checking.

> +		if (default_pstate_driver) {
> +			if (default_pstate_driver == &amd_pstate_driver)
> +				return 0;
> +			cpufreq_unregister_driver(default_pstate_driver);
> +			cppc_state = AMD_PSTATE_PASSIVE;
> +			default_pstate_driver = &amd_pstate_driver;
> +		}
> +
> +		return cpufreq_register_driver(default_pstate_driver);
> +	}
> +
> +	return -EINVAL;
> +}
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
>   cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +define_one_global_rw(status);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -807,6 +906,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   	NULL,
>   };
>   
> +static struct attribute *pstate_global_attributes[] = {
> +	&status.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group amd_pstate_global_attr_group = {
> +	.attrs = pstate_global_attributes,
> +};
> +
>   static inline void update_boost_state(void)
>   {
>   	u64 misc_en;
> @@ -1228,6 +1336,26 @@ static int __init amd_pstate_init(void)
>   	if (ret)
>   		pr_err("failed to register with return %d\n", ret);
>   
> +	amd_pstate_kobj = kobject_create_and_add("amd-pstate", &cpu_subsys.dev_root->kobj);
> +	if (!amd_pstate_kobj) {
> +		ret = -EINVAL;
> +		pr_err("global sysfs registration failed.\n");
> +		goto kobject_free;
> +	}
> +
> +	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
> +	if (ret) {
> +		pr_err("sysfs attribute export failed with error %d.\n", ret);
> +		goto global_attr_free;
> +	}
> +
> +	return ret;
> +
> +global_attr_free:
> +	kobject_put(amd_pstate_kobj);
> +kobject_free:
> +	kfree(cpudata);
> +	cpufreq_unregister_driver(default_pstate_driver);
>   	return ret;
>   }
>   device_initcall(amd_pstate_init);

