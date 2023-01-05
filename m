Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2120F65E612
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 08:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjAEH3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 02:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAEH3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 02:29:37 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0242D52769;
        Wed,  4 Jan 2023 23:29:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE3b0J1gBGpAe0+/TfkVGBhLe6CLdnIo5k6wVC20ivuAhwUdUhp+boOuRd3bqwJpuGHgTQyjFIw4oWwi536lf+3qLY28iqPexfUArWH7LOET2Sk5yI9dMgPgPixZfAA4svcqyHzftXXHh9xZ6uuIujXYxqeLID7K20AeyK5D+dbDojBcMn7xYnoocsQOQdb2EX9teQswSPaOVJ6l6buUKp/LaYaT0732k3qVKvgRU4eoyB3RbrPyIqggh9RXgolrY8tgapUy+D1e56LNMl676XHcALs5KX7jrfMYRCF7uxYO9F43Lrkrlx6DKMufaQJD3rowOTDXknDghlCX9pw3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHHv1eR+EkSCTdg8eiWPCm+zZM8oxNx2gWt6oNYZCvQ=;
 b=n0xaLtA+zCYvNzdQO9VjseXSS/s5eilgRHNWQKsoCBut+uSYgYVXLq0AlRrhKy08aGAVWIFACLyr4O+HZBLE04NOjdGBMOYckFdq2ppF1DvTGaxAtGbmUhcU5i9u8fIVDgPNnvkktzSHEh7f0h9mbYbxJfDiw9XQkFFPGppYkIbkQ9y3sz/byv4ppg/It9CF2DOO6+MEovz2i0wDJFfK7aVi6RZaY98v6I0Uv9h1zAvuclYTwrMqZg2+ZxHaQsUtio9fjIGwgSQOsQ8AUzPRwYvw7rWb6bOkYf/99qc6OL2RhUAfaJYQt4IfPDpkN3CYop8nBjD5qb6UGoMXl62XzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHHv1eR+EkSCTdg8eiWPCm+zZM8oxNx2gWt6oNYZCvQ=;
 b=Dl5+lXZ/nZN4PUitmjHcFA/YscKnU7YZmnggsrtGyMfaicNAH3Pppd5ATKAaApCqyxbEiPgfhzndfjoCaykT/IaVDqoj7WrjEWPrFSw4o/zUIKHCpu7gmRcJYrBLiwiFPbjENqzewJ986p/CtHM7BPNA/b0hSmSQBV0eOb8yqFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 07:29:33 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 07:29:33 +0000
Message-ID: <89be7b77-3478-640b-1400-5c0a1548c332@amd.com>
Date:   Thu, 5 Jan 2023 12:59:22 +0530
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
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e158ba-d598-4dee-49bb-08daeeee9775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0G0gi+7oslL7axnGYZ21HF3Ih/bx6q2H1cYHIdCM+it4vS9rjZVgy492nHiryz58DTu/CkdZgmK7TYAHat+mN39nbzVullgDw0o6dovJG94+su8y+k9uuzgbAoKgvd2ffSDNX7tq5wjzTMtNLOPg1CHOZ1CpESnq/9tokUq8SThIGvm2AZwM3aPQY9QKZUvXCTIaHqPgHPBPJA1t0pFUmlyMHu9U2ud5sN5AZ4q5ozZ5weHjq3q44Du6m6+bS4sTJTCUArPsVV9F4E3E3brEeQqIU1lGN7W+4wnvoWwqFlsO10TBLsVRMU24q7EaXCIdrVL2iZ+LkVtDJ4/Ml0FVldJf1AkSFpBG4JcvXZmc6hgVQxcvxB51ocUwaUsOeFZoU9JLrwlQywDL7SK9X8CIV939YhHdQD3Qzskdr8HQOYZBX1z0YZvq3S5KNpJ6i4f1YEXOYVoh2xPw3bmoM9UXjZcj2csbTlGHYbAVPaIlH/1HeJoih4AXsNsTEq6zL/QbR2JfvinjtDz8ttc9/yswr+hRvtZCvrCmmghHtTcHE8tWqe6M9ZtZtfC5FQoNo4RUVKs8TEvQlXTeZvmONVIro0t3o7ogFheaqbtXlcygXC3kKGoOoLWnDuDuAwoEcPgce1TjsmL1P4XQ8QH8a80/HZFX+d7BN4R5U12bQ6B79LtcsgaPGInbpQPWCjkiZaAgMARY2rr8chlJGtqCeD3UyPvNa+MjV7kIYWXIsIPspxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(5660300002)(4326008)(41300700001)(316002)(66556008)(66946007)(8676002)(66476007)(8936002)(44832011)(2906002)(6666004)(6506007)(478600001)(6486002)(6512007)(186003)(26005)(53546011)(31686004)(31696002)(86362001)(2616005)(83380400001)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1FUakVOMjJpNWJMNnMrc25RS1BEL1VrWUN1NVJSMnFuRTU5M08zVVdrRi9I?=
 =?utf-8?B?c3BzZ2RKR29lcGVseFV0Wk0zTlZtT3lCYlg3alZYNVgySktaVmNlRXBscE5Z?=
 =?utf-8?B?M1l6ZUpYZGxNM21rMnZXaExrMGc5RDNhb2pYb3pib0d0Z0F3MFhDVTgyd3hu?=
 =?utf-8?B?WnFHaGQvalRwcFM4dDhxVTAyYnpuc3ZKQXp2aGI2OHpMZXUvOFgxSE5OQk92?=
 =?utf-8?B?emVXTTEydUQ2aERWc3E2dXR4RXBjeTJQWmwxVVpGMzNJaXEvQzNweXhyWjlt?=
 =?utf-8?B?dzMyQ1Qvamx0c3gzYVRGVmxGYnBqV251dWJ4d1RmcHgwQUFRb3NCaElOWDhn?=
 =?utf-8?B?K0VtbkYrVzZyWkR5V2tTVTVVRE5WdzIvRVQrekEzVnkvWURVSWpCRWJTSjhC?=
 =?utf-8?B?RWhtQUtwZzYwRFBHQkwwcXNuZDlXVExsbTV0Q3o3MTlFWTlBRUdNSElRSjNh?=
 =?utf-8?B?RklKUklQOVF3RmZrakxKd0JWUGlFZktydkhvY29KcU5YUlBMVTFmRkYvR0lu?=
 =?utf-8?B?enNxd1lJVkdhKzRxTUt2dzVWdFJnN2svaXhERmtyUjFmOFVwOFZtTndrMW1T?=
 =?utf-8?B?by9qbmhnK2ViaVJPeXNLM3dBY2w0Z1FCcWtraENFTXVUOUlUVHN2ZmNUR1U5?=
 =?utf-8?B?S1FVQm5KeTdGa0V1aHpwWCtja01JZHVHbGxZd0lRelljaC9jR1BicU1yWFZZ?=
 =?utf-8?B?TU44SThQY1BlZVVWOVlTRGNVcW1uZkdnS3JmQWxFSlpHYnRZc0JPdGo2ZkdD?=
 =?utf-8?B?RUV3YURYRXB5RzBrVFkwbDBuL3VleDAyaWN1VTk5MFBQV242L05BSFZka0w3?=
 =?utf-8?B?bHJJa3BaVHdZZ0p6SEZ2YlpqQlcvbHdUdE9LZ0xja1A4dnJXL0IzN0xKUWlL?=
 =?utf-8?B?OW1pNkdFT09yWEFoRlJod29YYXdwSGF1Tk5GUWp6QkF1MktyMDg5ZTdiL3NC?=
 =?utf-8?B?c2lZQzl3cE1YdXRNNjA4Tm9PelNwSlNUVDJkSllINVpIMVF6YVlQOEdjaWxp?=
 =?utf-8?B?WFl4bjhMQ0Z4SzdYeUFtcGwwc01qTm1tV2dnVTFiQnRtZldYUmZWY2lkMGlY?=
 =?utf-8?B?MWtTOTdHRVBmTG02VUJTT3lnbEpRdjNXZVJlQmxNWFVsRkZWeHVJZ0tVeDB0?=
 =?utf-8?B?UzU4R3dzTWFWRUhMdjFKTjBYMzFoSEtpc2t4aU1IeWFwTWM3RjJnWUI0U2Vu?=
 =?utf-8?B?TC9NTkc0cDZ2MkNOSVVuQXhEbUhEbkQ5TWxCUGVZUStwY09RMGErZUxiWlUy?=
 =?utf-8?B?WGlQVElPb2ZLV2tqYW5wVEQzeWdPTlFML3YxTXZsTWxFMHlGZUpYM1JXWXNU?=
 =?utf-8?B?ZDRvalR5aklYSzQ4V0FwNlFyNFhVeHJxd3lWY0VxeVlsMElZWlJuODE1eWlN?=
 =?utf-8?B?UVFHeEdXZTB3a1JERzJDNlk3T0x0ZWp3MTRNU3dOMTJOTEhLWXdPYjAvMnNp?=
 =?utf-8?B?L1d6S3ZpWllnYng4Q1UrU2F1Vk56UGxQVEhPMUt6WXVWMEFFZkdhNzRBV2I0?=
 =?utf-8?B?T2Voek01b3dqTjBBbHd5VDcycDZLeTRUSVRaeVZLdk42QTFmRkFYdm1aVTVl?=
 =?utf-8?B?YnB1OFR0VUhqbEo5NlRnbmdTM3VtV3ZpUG1IQWFpZWM0VndGNTlVVEtFT091?=
 =?utf-8?B?aFIyeDExWXN6YXZtTFQ3d0h1dW1OanlLbmxJUmQxck9ZcjJ4UkpmeVBrZjY2?=
 =?utf-8?B?YmUybktuOUIyR3dMNEJOcm9wR2hOY0d2ZHY5QmhzNU1ndEtPS3lNZnA1RWdM?=
 =?utf-8?B?bmF3a2dYcUdjT0w1VUNlekpCV2x6TEpJMDFZejVualBpMnRTa3MxbHAwTEdS?=
 =?utf-8?B?c1dJWUc0Nkw1RkNIeHJYY2tud2J3ZjMwbTI2L3BEN3YreTNpR0hzcHJlczAz?=
 =?utf-8?B?dFpsd0tpTWdhSmZDVSs4M1BYY29qZVFqRHRtN3hXU09RUmt6QmJ6TmF4aTlF?=
 =?utf-8?B?R3oyMitYb1Y2dEx3U0w2WVZXL1VGODBnTHF0U2twWk55bzhvdHJCSDdnanc3?=
 =?utf-8?B?RkN4blF6ajRsRnM1TUlHcVJZL2tGTzRLSUtaNEVFVG1rS2dYSGkwQmE1SWxE?=
 =?utf-8?B?TEJ0QmovMTFtQXNhTkZqeHR6czNydXhEb0NibGliS2pkR3ozWVV4K3o0S1B6?=
 =?utf-8?Q?zmj2LYFbnlDIhyNXlN5Nbjclz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e158ba-d598-4dee-49bb-08daeeee9775
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 07:29:33.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBUgGQAv4c+omDxZV6PLKafusudenjfS5XvRaMVnT5QSdGnkfFoA/5MTTjvd8dAucB37zr8h7u8ZLy8gGzfUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
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

IMO amd_pstate would make it more consistent because the boot param is called "amd_pstate".
But no strong opinion on this.

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
