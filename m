Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B043C628C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbiKNWao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiKNWah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:30:37 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD8B193D5;
        Mon, 14 Nov 2022 14:30:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctGzEMsrm0QZ6JvLD0yY3AZC6vR7Z/MQtc8DRyYb4UKuw/vLBt2uPckpkSKlFZWMg7KBsKmqJcM64Xje5L5DhP6w92hntniwr4jGbojvTLZ64L16dYiCbwztlVZd8js33xNu+6VP5nbI6TEUcIWuJz/iHnZvG/JHZGrCCeXhKMQYMEu9RduIEy6gimT4ZiC9HZKo4aUWU2/REVtyiMWyYInvXaPzuGONF/hw0NoOXOF/1/J6UvY4b4GgPPFLdUxIbuB9Fh2llyh/ZbenYRPNJnH5nN0zKqqNhLddyoItOhwY4RSDC/bKGd/CDDTrzMfhdq2lzXKDilKQ69MZTQITow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWarjNsPZgMxG3Z60KkTNocXQI2Mstn3FnPTQUIyEp0=;
 b=KsZYtltpwO/tvY5svmmplqJSJRKrFs4reNZmV/dFnAcPYfuOS0qqnTOcjyG8V6d2MKMm7ZXbxrUZltqiShHXEy6MRivocCEH0/QJDcP0al7eZVdW8bx2fEtEpFkK+Cfh794obR/v+iR7D3wTLSVL8AQm1D0T7ZkRq6KHC9wobSmxGUVjboF8+jSExBg7R0LtUbwF5N1dqApbDZ3bs0eTl4fwUTcDOrr/Sukp17oCr7lOT0Gl5MLeQC+w3ztN+WLv/WZ4FgKBCp21vziaTspKk0XW3ZcH0XY3bYcFOculps6Mn91JDrI1ht6JlDuPcX8MCPmUs9e7c3Xl1+zx5Cdibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWarjNsPZgMxG3Z60KkTNocXQI2Mstn3FnPTQUIyEp0=;
 b=cpvH6d7KYZo+Xhm48bXhhdJBpnKxE7FDL37n4L39DtsNUAigkj6wcwY0p15NfuCDKJIstpf2Goh3zPJcnwe2QOobihNmkts80J9daY+7nl7L3dfxwzslrWHcEjV52kr7xNhFg+c7znNwVANApJsZvJYCV9ErXUqnMmViephZ0Y8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 22:30:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 22:30:31 +0000
Message-ID: <8901dfd7-cdf4-1f1d-5d34-be57e74112de@amd.com>
Date:   Mon, 14 Nov 2022 16:30:28 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 7/9] cpufreq: amd-pstate: add frequency dynamic boost
 sysfs control
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
 <20221110175847.3098728-8-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221110175847.3098728-8-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:610:cc::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b57cb3-d009-4154-a837-08dac68fd718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dzLt3WfqQyigslHo1vlXghxCbvbag92aHA+4UtmLOHulEBvgB0SdJaJIKHsaTkTYNO7eRyTYX7x16JJ2fqf/HRl1hb392EGbpwT198ilSmfqWeXnOMxfdWhSfM/t85A4zaQ9elgWbJZrbwDYVGM1CQnAmjHUoZ7nQapGrHXr+CLgqsg3hP5P9feB6l9AYFnke6q4ZIiXan2XymVPA9HHllh4AF+qUiMIHHS9Kune2CehDKuuWErdrSyS6C7cI3dQGtaYLpWnDvETxT4P5gop10Fmky8HKu8ZMIEUZxnx9OJC27EXMkpqfFtQkgi9rNdTHolY9AgChaAPAVLcEhgzzDGCtVL8RmX9tkLd6JUrLy0eVTBaXYrVHMiSSOxGmnu3y4IQjW7EodvmZXcWP7BSZU0bfwYOjxI6RKZBPz2GKQc/2Y/Eui22bwk1BP8oN0EbKRqJUghkmXQmhyclmxfC6IUamIoUTpAETUxh4CxN8LzGIuuMk4LjgVALEqmd+PFPiq3yWGkUy9+IsBQF8lXopwFS0NNHkncn7VgobT/sUhbau3H7qCLhZWRS37/MvpzTFkyp52HpvhiSaoZrk1z9HsOIEnXM37Ej4ncQRL6tUunr1mML4uuMYhrkjLr1DQ+VdAIBjvr4F2cnuxMEZhyFBbOFnK6Jrsq64vnzPbukn1hMKI5Z7X5YBDKnqdmfvZRD/VznqGCZSn+zD2GMPJuOcW5r8QSHwPCVqM21CeL8Bvg1loGc59WIFkumuUPqoaDAKXZkfItm1YUgseHdaM9KrgLpywTDFK5pqo0U6RTIWJH9M/yHyS7VPOJMHVpyLuaYexu6c2hlxJBlM61MVes0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(5660300002)(2906002)(41300700001)(8936002)(66556008)(4326008)(66476007)(66946007)(8676002)(316002)(36756003)(6506007)(53546011)(6666004)(478600001)(6486002)(31686004)(86362001)(186003)(31696002)(26005)(38100700002)(6512007)(83380400001)(2616005)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW5qNld6aXJFZG1ES21ZY3JyalVSSFJRSEFSbC9OdnFQMzBhdVRpOWtaaFBo?=
 =?utf-8?B?N05SWlVBQ3Rta29ONDcramZGZzlIL28zODhid0wzVXBaOUdlcWoxUVRqQTVw?=
 =?utf-8?B?Z2p0MThoQ2wwMGVpZmRWTWtURlRhWTR2M29HbnVoZTdWWW80NThTL0V5S1hr?=
 =?utf-8?B?U1hTS3d4dTc1WkR6RFNHbWo1clp3aFExZTVCVTArL1VOVzVWUUV5YmZBT21S?=
 =?utf-8?B?R2N5M2doOVVPdW01YWx2R05VMS90UzE4dGc0cXJrMUhhRno0YjgxUDFqMmNy?=
 =?utf-8?B?bjByY1J5ek5kOFQ3RW15MEcvTEFKTnlQd3I4TGhVczFFd2orNjkxK3AyM2c3?=
 =?utf-8?B?c3hqalk4cWp3U2RYUjFtYTgzMjY1UVZaR1lxaHoxNEpEa3c4YW9DZlJMK3Z5?=
 =?utf-8?B?RmlKck82Zkc4VnA1d2t3MjhQbGFVY2g4MHhvMmJmbjQxc3creFQzYy9mdmpQ?=
 =?utf-8?B?S2prWVFNSDEzeERuKzZjUmQ0MVp5QklpcWROWFJkMmpMN2lBNk5Jbnh1WldY?=
 =?utf-8?B?RFBqQjRWMjFpa0I1YjlrNExZc3pyNlZCMkkyR2tEdzFBOVBCU1VGa09OVDIz?=
 =?utf-8?B?bW83a0c2MGc3OE0rQ2dOcDRZR081eUNYUDdtaU43TVlSbjRDc2RCSW5VcUVJ?=
 =?utf-8?B?b1RrVmI2c2ZQSDRLU21UWkZyWmpGRmNZMFdHb1FaVjRSa2Y2VVhYVFJNNUR6?=
 =?utf-8?B?N292NjRhdGkrVmUwZ3haZVRkaklrV05QaGtLaHNxd2EzRkZGSU1LYXJXNFBp?=
 =?utf-8?B?RTFVcmtCdEQxQUpHYisyODJHWGdmcGF4VlpBM0pYTGt5bW0yVDR4dFByWTFx?=
 =?utf-8?B?eVhVSGcvYzlDVWZsNlRwVnlnN214K0NXZmhPTGduK3JUY21CdGovZTdhc0h5?=
 =?utf-8?B?UkJjdlliS2xWT29ENEtZVEhFTWdhS3E3ajFBLzd0OENPOGhjQ0lIU3IwRSsv?=
 =?utf-8?B?RVI5T2k5YVFGVVlOV1BUa1J6RTlORStZSU9OMlhyajRvVXdDRERiVjUrNzUy?=
 =?utf-8?B?aHkwRHFNaWZBTXN0dWhSU1lXWE5XeTBpZTJVSmZLVFh0ZHU5eUw0eUQ4Q3E3?=
 =?utf-8?B?YmtFZmVSbzhQZ1YzclBPa1RNclUvb09vQklDM1JtbklscTZJOU1FOHQ2L0U5?=
 =?utf-8?B?U0tGQXVNelJoUS8rUXFYVk1FR0FMa0IrUXJaMVQxYjhjc25CTDFpQXJFT05F?=
 =?utf-8?B?aVJIZ2ZBeWVOb3FQQTg4U2lQVUJmaVdGM1FSRk1pSFZ1ejFGWDk4NTVnbmZr?=
 =?utf-8?B?RkRBM1RRekJzd1pUcTE4K3NZVzVkWjNUVFVlZXM0MkFCTmJDQmpIS1RIMm4x?=
 =?utf-8?B?WmJMUW1vOGgwTGVVT2dZeThuaG9aVGJGbHdiZGVhQWhhM1RqazlmSGFTNjA4?=
 =?utf-8?B?UUpKQVNlSElidUxBSWpRZ0tvUU9nZXBLdTg5M3BlQW1lNy80KzNkRTltQ1l1?=
 =?utf-8?B?MkZXWVYwdTgxRVlOMElReFlJeHNOZWRwNG1aNlpEWGwrVlZtUmdKZ0JRalc5?=
 =?utf-8?B?ZWZvY0Fua2NaeTRwaUpVVHdqSmVxU0R5akRxeGw3aHpGRXVVV3kzYXpXaERy?=
 =?utf-8?B?ejhTWG9uYVVkc1NCcWZDbTZiZUtHMTgwV1l4cDlUaER1WENJemoxU0FhMVMz?=
 =?utf-8?B?ZDRva1pkeHluVHgyRklmdU5hSFZEUDZFYklIOXh2SGRqcWJjcVN5MUpPcjFW?=
 =?utf-8?B?OWNsd1UyNXlTOTcyUVA0K3FMR3BrZFJLZUhSc1prVFJzR2xEbi9wR2h6TnlC?=
 =?utf-8?B?RnYwRGNZendJYzRVNXNkS1NOSnh5MlFTNFF6cmNqYk5HYWNncWx5L2FJTHBR?=
 =?utf-8?B?R0VGa1pleWxLbXlzTzJVZlBrbndQeEZZWS9rWkphUzY5bTVGai9JVUZpc3F5?=
 =?utf-8?B?M0lPWHlnY2M4QklKQlFZZUtERFdENmNueU9iRDFjNzFUaWMwRXYyOUJsRjZE?=
 =?utf-8?B?blF5N1pmdmYraEV3V1ZlYkZ5WFVidmFKb09WTm1wc21nUFFVWXdRQlFNQ1Zw?=
 =?utf-8?B?b3lES1ZBNHpQTVpYTGlNYlNlempGaEpPTjUzODRFdzRKQmEzWlE1bUsxL3Z2?=
 =?utf-8?B?TzRSUkZMdDEzVWZYbDc0WWVDM0lWc0xjaWNpeHR6UkxxbnFvT29UYXFLMDRT?=
 =?utf-8?Q?2eNlUElBxCWkNkqccKX2mu+eu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b57cb3-d009-4154-a837-08dac68fd718
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 22:30:31.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qon0Zcnenl8wC7eVGxp3keK6J8KF6YuZQZQTkbSlRhHPlj4/Ni+rgIRwUQw6XwNu6cY/s3oFdAx659svzwTzXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 11:58, Perry Yuan wrote:
> Add one sysfs entry to control the CPU cores frequency boost state
> The attribute file can allow user to set max performance boosted or
> keeping at normal perf level.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 66 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 645706d65173..b71bfbbb7639 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -765,12 +765,46 @@ static ssize_t show_energy_performance_preference(
>   	return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
>   }
>   
> +static void amd_pstate_update_policies(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		cpufreq_update_policy(cpu);
> +}
> +
> +static ssize_t show_boost(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%u\n", cppc_boost);

For new code I believe you should use the new helper sysfs_emit() instead.

> +}
> +
> +static ssize_t store_boost(struct kobject *a,
> +				       struct kobj_attribute *b,
> +				       const char *buf, size_t count)
> +{
> +	bool new_state;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)
> +		return -EINVAL;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	cppc_boost = !!new_state;
> +	amd_pstate_update_policies();
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return count;
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
>   cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +define_one_global_rw(boost);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -788,6 +822,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   	NULL,
>   };
>   
> +static struct attribute *pstate_global_attributes[] = {
> +	&boost.attr,
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
> @@ -1398,9 +1441,28 @@ static int __init amd_pstate_init(void)
>   
>   	ret = cpufreq_register_driver(default_pstate_driver);
>   	if (ret)
> -		pr_err("failed to register amd pstate driver with return %d\n",
> -		       ret);
> +		pr_err("failed to register driver with return %d\n", ret);
> +
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
>   
> +global_attr_free:
> +	kobject_put(amd_pstate_kobj);
> +kobject_free:
> +	kfree(cpudata);
> +	cpufreq_unregister_driver(default_pstate_driver);
>   	return ret;
>   }
>   device_initcall(amd_pstate_init);

