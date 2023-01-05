Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B843365E556
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjAEGCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjAEGCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:02:20 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8348833;
        Wed,  4 Jan 2023 22:02:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUP9haITFkk0VwJ7cOysBy4cGVG8QCtXXDQu8DUtxcR/0qlYWRJNrRan+KHNvKgvPM+JM3PCbZ1QQSPuLr6ZKIP6j3NP8hl41RXrUwp2cauB+sDck4CCJZaFN3DGfGk4opOEA4lGz+bURnO8T0/oAP7f1M7oxVzHCJEcrPaRnrqWyD91hPcah2o2YIJzx0gEp84Zs2b8l1XX4xS8zLZsf/IzvJQ0gJQPUvuZ/GIo+N80RYFUul40fxcVCuDfvlt5j+eFQOFoZJK4Cu0d9cYndi/2MYuFr9GamgBl3B2zz4KBA8tGG4P9kz0vRY316rUnGKPx0Dt0zE1WgIF9WTls1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEuyPcoZqgW0ysZK/80Vj5OYuGqkTV0vR76ZGWf4W9A=;
 b=PfCowHsQQ9EgoZY4dsDyjxdHvYw9Sp3m32Zlcnxzk3jeYLsPVC5dCuf0RDtesVG3vDrLG7c/LJAucQ3ynsqDxiMQ8DWVX6t3SZHvW0P7SOLwHrZzyVqVKe7NyFPW50DoVf2XnXN33a3524/NlRtvnGzlz4MAcmqgyz5HW+lTCZ2D4o2MQqUMhLSvb6Q62KoNiGgw7B+i8BNg6OP8Tf0eQZ61J1qhqDmam3AtbTXXnRZt1EZk9wCwimqq5Ohd5EGaEy+OreJWig9T3fx56hWynTlfNdKUyriWKAbPgOCwS22QDNmyQdr/MHZNqQT0Fkf9w0NEZRbOMOU3i6ud1D1c7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEuyPcoZqgW0ysZK/80Vj5OYuGqkTV0vR76ZGWf4W9A=;
 b=rRtB6aWrMes/czXV5YT1PGPFzz9s3uV5+XB/Bsn6mc5UfMj6gmQXaKLdTCkxzwOdkH7rYST2SbxHvZBlVUU3Q1jchiMXHd+T/rHhcareLnVW8ChS7BEDLno90/XGPItpDZ7agGKhYDFoPUZln1hu8NivxEHCZShvM3bdRir8Uao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:02:17 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:02:17 +0000
Message-ID: <6bf69386-3e8d-d820-de38-38a1bbe987fc@amd.com>
Date:   Thu, 5 Jan 2023 11:32:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 09/13] cpufreq: amd-pstate: add driver working mode
 switch support
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-10-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20221225163442.2205660-10-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 73dd7eaa-fde2-4368-0004-08daeee26632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efAWl1rV5TCFvnxxxX5BGEX7l9qnOB5iDa6BlSXokiwuxoN3kmYaxwqRRIUkgEF4s48ma8z4nEMBrsGs40PhEJvUums8zdmUUw+0ifNEyTbzcYgch6JwlPELmfJcgiG8uQzgc+xtHrNSQxTbx822uR0IUOWLR9rbipz2ZP+IQ4AuyvjcHDOrIa314KYxKWZV7ldZjDAzDjZOjuMNq+20f3aZ4HF/RWsB0p0N++wlwSOGo+7MwA9dyB6CqvEPzZSRyqIO3C7bLQniyT5fVy8M5Wd01a6GexDN4Bx7fmZXyY8+o5xPJ9kMEDrjawS9uRBT3wHcLuBQuFS5aUJ6qKtXjNt9dhLk5h6jsvb2c+BMn+pjouWla1tOkYjnMr0flr4PRb9JozEXE+1EohnZBtvOPL1CYsg2xaN3O6i4O+OmJ1VzONSOD/KXYKUpllWIMKKSLIYY7rOpLap4hxiPDXlEtQYW8BQpVzDoNGDNw6xQXQ1Vt91fsw4w+yeGwS5AAjgK1OUzEcp69XsfY3osU6Bs6sCpvAneFQ95zgDXCxyaRAL6NzExdK/a1JU+hLYhBdpk0KpH9NtI4QuLaDJeJNAbr+TOyIYzHwEoVv5EAl2UgG4BtQEsSYAocHpPvYBlheV9hVxOpYQXpyfPxxirU1dTIJDTwZkVFVyHRzS6nJbilaFqP60SP02sXXFHfRcrQsZkHqclpHvFQO2HkEpkjCKOaRmCqQ8Vde1t046UvjRB/yg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(83380400001)(86362001)(31696002)(8936002)(44832011)(5660300002)(38100700002)(41300700001)(2906002)(6666004)(4326008)(26005)(478600001)(6506007)(186003)(2616005)(53546011)(316002)(66476007)(6512007)(66946007)(6486002)(66556008)(31686004)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVpXTDFKZ2FPZHlWN0s2RmZFd2d0cUluVkFvSTBFajdCb2tHQktqUWVKZytu?=
 =?utf-8?B?ZGJqaE5uRmozTTB2bS9VNlBGVDNkT0RZaklZVkxsbmlxQUQ0dDd3bm1PV0RL?=
 =?utf-8?B?Y1NvaE1OS2hZSEwzTnI1WmtXaGZRSmRnTTk0ckRyYjVRN3ZxR0R5aEROUDl1?=
 =?utf-8?B?Z0JYZWhrOXoyWGFydWtPK1ZxZVIremNkMHorYVZhMkhkRlZESUNzOW9aVlJQ?=
 =?utf-8?B?Y0dwdGdOR3V2Mzcxb2hsVjlxa2d5dXB4SU4xQ2tFeE02R01BSUhYdmcyMHVG?=
 =?utf-8?B?cE9sSDM2Mnd6NUtlV3cyMGlmc3kySlByVC9VRi9SNU5yZW1hOUF0NE5HaDJo?=
 =?utf-8?B?L0xpbVBWcDVxcGFHczhHa3ZBcEVhU0VKT3FYczJxQlFwUVdid0JqeTZGMTR4?=
 =?utf-8?B?MXRTL0p1dHVTdkU0UVJiRWJXT081RllCZHVETzJWT21GYnc3UnVwQTFuc0Ix?=
 =?utf-8?B?RE0yL0hKWmg4UzJybHkva0V1bmRKaUdHN20wMmtKQ2N0WTd6S0J3Q09mdzFQ?=
 =?utf-8?B?SVFwQnZSeFRWa3dKUGxRU0ZldU9wYit2NzVxMWdjdHYxNDFhb3VXcTdiQ1JQ?=
 =?utf-8?B?ZWx6WHhrcnJPNWpYOC9OVnVjNmRwMkZYRXFkd2M4eXRKOHpkUzlxWGVBcnh6?=
 =?utf-8?B?dnM3cjJPZmFBR2tvVVYwS2ZOY095OUptTmxmRG9rZXdtcXMwZGoxNHBxamRF?=
 =?utf-8?B?UzRDb1dDOXVCTnN2WWY2aEJzRG8wWkgrN3BFWlZZanpZRzZMenc3ZnFKSE9z?=
 =?utf-8?B?NVB6K2pheDhBaHU0aWFXemZaRGhjVXppZC95cGxyY3RjM2crdllIaFp4N0kz?=
 =?utf-8?B?SlI2WkxhR2hPT3NTamY2NlQ3VXRzVGNXWitwNll0MEp0amJOQ0RIN1RWQkY5?=
 =?utf-8?B?WEZlWlMrbHY2Y2tWOUhKOXIwWlg0VGF6QTVuc0F2WG4yYUpiRmlySW5vdVdn?=
 =?utf-8?B?QWlxQStWWk9zOUNMTmVUU2dzaERYMXdCNm5vbkdoRExwc0FKdmo4aDZ2bGVV?=
 =?utf-8?B?eGl1MFFaQ2JocENVbGpaVTRBT2F4aTBTZEVuY0xyYS9CSlk4TWtJa2FLamQw?=
 =?utf-8?B?bnRJNkt1amE0Mlh6Y1FZK3JFdUMxckhzQjM3VW9lSGt6bEI1VGxFSkdGMmpS?=
 =?utf-8?B?Q1RHWkU2cUtaTzJVa1MwczMzRWNnZWlmS3JIQ2FxL1hkY3ZoeGpxaEsxRXV1?=
 =?utf-8?B?aTlhS3Era0lZNGEwY0ZpUGwzcTBwbTlBU3FPYzZUS1llTm4vLzF4RkM1ckhJ?=
 =?utf-8?B?MXVYbVZ2Q2w5RkM0anozTGlpMmo2dnM0eEFEdnVqbU1jcFlMMXJka0txb0tD?=
 =?utf-8?B?VGdVd2ZTWGQ3bHVjWEkzSjFrUlozWnluaW03ZE5SWGwxaHh3Z2NkcUpqZnFp?=
 =?utf-8?B?Y29Na0ZGeG9OdDJOY0Z6RlZ5SWcwMG5aUzlrUHA4RmJJOUJlMS8xa0NpQUtV?=
 =?utf-8?B?NFZNMGJoTUJ2Uy8wWTEyaTNNS0g5VC9NOFMyMldFbFZJR3hOUFphYnczT1ky?=
 =?utf-8?B?TW85eUlLb3Uxd2JJRW5DZjNMdXNsVDFMS25XdDlCWDMwSENXb25KQStYeDNF?=
 =?utf-8?B?ZWRwcjJUcjkrK0dBOWU1SkIvTXBGczRzWTFVaXU5NDdVRzNqTzJvRWNmblpB?=
 =?utf-8?B?MmlNMFBOdG1Sc0V3eE1oT0NpbkplQ2xnTURRS2NLbTRVVXIySE1OVElrNEQ0?=
 =?utf-8?B?Mld6THVmZHhYbm1WV1g3S1praHQvb1pxeVVVaWRBZWtmcDJidWJqdUFlUUxE?=
 =?utf-8?B?ditTQXBidndtUktZMlo3OFZQQWpYOVBybS9WbC8xekNlMEJrKzA2RVhmM1dE?=
 =?utf-8?B?dTdmdStxKzhrQWlXeC9DbkhKNGFBUjd2UzdOT1dBNGl1dnh0bmZwRGpXUUpj?=
 =?utf-8?B?QjAzZFJMR3l1RVR4SWpPeDA1U0dLV2RzWjNoRU83dHVxQms4dDNkdStScEpX?=
 =?utf-8?B?ZUNvNSt5Nk5Ldkh1Wi9ieXloQjFDbG5BOW56VEQrbFdOYzltQ2VJL1ljcEI1?=
 =?utf-8?B?R0lpNmRUZ2U2Qm54SmtWbExWTGpjaUY0dWRBWmx1Y3BpMk9TM2NVNVhwMEtz?=
 =?utf-8?B?eXh2MXQzU2twd1l5ZGx6aExqaVRFbVdzNzh4bEsyN1E4c25xQmpiTGFIdkJ4?=
 =?utf-8?Q?7rImuvUV3TvTn2D22kozJVhQV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dd7eaa-fde2-4368-0004-08daeee26632
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 06:02:17.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1oivdNdu82qBC2BBo+TiOnVabO8G8gYdTdaIqEVN2N8dA1HL7K4RIbUBKsXWXCb7zAd8SZTrW8s6X3uIfA0XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

On 12/25/2022 10:04 PM, Perry Yuan wrote:
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
>  drivers/cpufreq/amd-pstate.c | 118 +++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e3676d1a85c7..8ceca4524fc1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -63,6 +63,7 @@ static struct cpufreq_driver *default_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_DISABLE;
> +struct kobject *amd_pstate_kobj;
>  
>  static inline int get_mode_idx_from_str(const char *str, size_t size)
>  {
> @@ -632,6 +633,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	policy->driver_data = cpudata;
>  
>  	amd_pstate_boost_init(cpudata);
> +	if (!default_pstate_driver->adjust_perf)
> +		default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  
>  	return 0;
>  
> @@ -772,12 +775,99 @@ static ssize_t show_energy_performance_preference(
>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>  }
>  
> +static ssize_t amd_pstate_show_status(char *buf)
> +{
> +	if (!default_pstate_driver)
> +		return sysfs_emit(buf, "off\n");

IMO 'disable' is more consistent to cppc_state.

> +
> +	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
> +}
> +
> +static void amd_pstate_driver_cleanup(void)
> +{
> +	default_pstate_driver = NULL;
> +}
> +
> +static int amd_pstate_update_status(const char *buf, size_t size)
> +{
> +	int ret;
> +	int mode_idx;
> +
> +	if (size > 7 || size < 3)
> +		return -EINVAL;
> +	mode_idx = get_mode_idx_from_str(buf, size);
> +
> +	switch(mode_idx) {
> +	case AMD_PSTATE_DISABLE:
> +		if (!default_pstate_driver)
> +			return -EINVAL;
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			return -EBUSY;
> +		ret = cpufreq_unregister_driver(default_pstate_driver);
> +		amd_pstate_driver_cleanup();
> +		break;
> +	case AMD_PSTATE_PASSIVE:
> +		if (default_pstate_driver) {
> +			if (default_pstate_driver == &amd_pstate_driver)
> +				return 0;
> +			cpufreq_unregister_driver(default_pstate_driver);
> +			cppc_state = AMD_PSTATE_PASSIVE;
> +			default_pstate_driver = &amd_pstate_driver;
> +		}
> +
> +		ret = cpufreq_register_driver(default_pstate_driver);
> +		break;
> +	case AMD_PSTATE_ACTIVE:
> +		if (default_pstate_driver) {
> +			if (default_pstate_driver == &amd_pstate_epp_driver)
> +				return 0;
> +			cpufreq_unregister_driver(default_pstate_driver);
> +			default_pstate_driver = &amd_pstate_epp_driver;
> +			cppc_state = AMD_PSTATE_ACTIVE;
> +		}
> +
> +		ret = cpufreq_register_driver(default_pstate_driver);
> +		break;
> +	default:
> +		break;
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}

The implementation of amd_pstate_update_status function is good as long as the possible states are less.
Currently prev_state and next_state has 9 combinations. But with guided mode this becomes 16 combinations.
Do you have any concerns if I optimize this function by creating a state transition table in guided patch series?

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
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
>  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +define_one_global_rw(status);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -795,6 +885,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  	NULL,
>  };
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
>  static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -1154,6 +1253,25 @@ static int __init amd_pstate_init(void)
>  	if (ret)
>  		pr_err("failed to register with return %d\n", ret);
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
> +	cpufreq_unregister_driver(default_pstate_driver);
>  	return ret;
>  }
>  device_initcall(amd_pstate_init);

-- 
Thanks & Regards,
Wyes
