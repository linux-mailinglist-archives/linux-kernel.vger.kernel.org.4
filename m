Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF1161FD2D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiKGSRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiKGSRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:17:32 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DE729838;
        Mon,  7 Nov 2022 10:16:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls7VJnsEwVDPzMmQz9ZeI0ArX6pWklD5hiSWdIZc3MZRQvPq2bSvSQPYPcc49kn5z8wcVAzGvCU/9zlO+LsCvWbrKL9JQ1V1I0f8emlgpiFZEKHWwj5owrmpfdTZ4QeOaCAQzFG/pmOqX7wQNYf+4soY8knZ3yGh3d5u4ZE0X3e2khGG7P5JxOks/i0atpIW1H90AiMY4DUg2XtHNfFBWigj0ipPlO6PYXe9UQhvGSldbioAt2TNANqQW9nZR/1mywy180TGFncAch5R4wVf+vh8yKebn9eIiUa12lOA7XR1z3qv5KWgomF8OjmL2Oi+sKHjs6p8XtNVQJx70L7dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx8vWEdogkOq9K85mOgAuTWXrPehFEmKqK24k5EbteU=;
 b=C/KrEsxQd0FAPUQlJ+Zlj41TFuFtjp9td5J+OrIePE/Fm34TrkejiMOoqat4YWz4g2DdS6KCGNbQlS8SRZ17cfsOv6HuP4LRPHLSSnz2MHmzhGddp9rAwmzwuLs5aFWJSDJeJ/oBZtXSxMBduKp8qxP7hvuqUrLxpX2p4J7SsOd4a0U529n0ID/lZRqhCaFpk+8WylZVzALPm5u/WdidybW3lAn50OSxTqjfSBO70u20ubCZ7UA8Wi1PXwQsICaQWqSyQiJHGHBSgeRaGNW5gwqKMBUsa+g1xBBzuTGfIImS8S219itbSLkp+hbqeElJCDYcs68Y21mQSg/oZ3IqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx8vWEdogkOq9K85mOgAuTWXrPehFEmKqK24k5EbteU=;
 b=QXOo9eR4WUE7HuKm9db9MtjsXkMO2le6ml2jc17/ZmRngfhoomBNzZ39Wy7no0sOl0fuNkbDvCiwDTs8pXpJGd08ud4V772N1SWaARC9zvmQ+MsCLVS7sR9RLf5v0Fv8bPwoqGUp3cFGQtZyimaeuFD24DF8+NtVAHbzpcYJD20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Mon, 7 Nov
 2022 18:16:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:16:04 +0000
Message-ID: <1b7a5cd5-6ecf-8529-f10b-4f7f06fc7462@amd.com>
Date:   Mon, 7 Nov 2022 12:16:00 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 7/8] cpufreq: amd-pstate: add frequency dynamic boost
 sysfs control
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wyes.karny@amd.com
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-8-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221107175705.2207842-8-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:610:4c::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 136b7024-f38d-4193-574b-08dac0ec21e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKYHK00KhhbXKlq7HUVLLGJBde+op5Xr9t/0KiXKBBDzl8+0JbWqpROi9qMvlj04amVkHji1O04pRsBiFJjP1rpqf2q4Df1C/vX99o8zMv4drvdOmHFgEme7tpR5JaX7N/kAoiDkyXwUG3fUtjPzyPiBPXajSBxD3AEe7yAybfrP6QZRADuLrOesk9zAWFd518JRSirW+IUKTJoS2xki/qG3/7uzoZ41OCUHvVz8xrXWGY4OPRdOWggNloEWggAD+WZ/qTW085SdLoaFjFdbdRPB4H+4C3MUZlWPWy4VkyKWFUcBgf5QPqOIFjAPFE0pyftRHJ/sb39KRvAPUO6HQZQ85JxDTbE3aB2MGyBDe+9dpiFsSmsfkg0xKrP/rtKxIjlGJCP/+uXIy5uGlxUlKz7Z+moCZVTaEN7k6vtnP/0UMMBrzlWkyWV1xanGtgjtOOB5W8DaHFPPibpoXTt9e9F/aGobDEH2xTu/d7UEjOkzP6U0c+28Djf3OOLpB0NJ6i1TIigWS2OvFG4rAZ2XPm+euQqWIslU105Mr+iJ2OJcwtK1sWcdRudG6vWJN8FTKpXfi1LBEWIHajj60AVfGmoAuNkP4FJRWQl5At5qDESgm8zvowyj18VsZ7GYoSZd/jaA6cClXDxSOKLIFqqjOW5/a7zgR/x73BcKarRYCB1NJohkqK6SPXDtoob6aqOVp/8XWXMlJ4ubAV8a6b/oADFRydrZGnLdL35fo5ReFoi680BB4ufr1mkusQ+p5eLVJ3iheSc5oZ/XQ/xHVsILS9Q7doCfn6m+blVCfJaeKBbsD5N7nPp1A3hn7OhbUssBs+jVzWrSuoXfbu6T2+tCBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(26005)(186003)(6512007)(83380400001)(2616005)(38100700002)(2906002)(5660300002)(8936002)(53546011)(6486002)(478600001)(6666004)(6506007)(4326008)(66556008)(8676002)(41300700001)(66946007)(316002)(66476007)(31686004)(31696002)(86362001)(36756003)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SllDTWE0MG1pYmlEUmd2Vlk0cm80UVBMa3JlQ0FaaWQ1WTlZZ01rYm9PRHBI?=
 =?utf-8?B?S01lMUgvMjdCNHVPUkU2RWhOL0grK1hQQzZsZnppNWc3SFhUVXNmZ1Fja09B?=
 =?utf-8?B?dDNTVm14c2tKRzBGQndubnh6SnNCcjV6eTVnR1k2TFJmV1R6cEs4b3hpQzUr?=
 =?utf-8?B?NjVuYUwrbkxyT01xR3l1enR4Ly9kS0hUdGh4dHNBdUl3NkFSdnVEOW9pOWpr?=
 =?utf-8?B?c2NMcEpDdDRUUlQ4d0hYdjBpd3o2a3ZoQnJHQlh3Z0Q2c3VqM1U2MFlXV0pm?=
 =?utf-8?B?T2Z6NitmekxqZWVIdW9tK0F0VlNRaGNiWjV1K0ZaN0J1QVFicmdzNk9tOXAw?=
 =?utf-8?B?dDlDamNMUlQxUkFBcFF4SktXWEUwRjZIM3BZNWx3U1ZkRG5UdnhqV0ZsT0Jx?=
 =?utf-8?B?QjZxUHFMdkFlTWQxbDJCOGR0OUNiUm9RcXo2TlVORFdtaUZ0TGUzT0NnM0FV?=
 =?utf-8?B?b2p3eVBIek43aGJKMHRoWXB0cmdBL3N4d0xVN3lZV1d4clkzbFozeWNSZ0U3?=
 =?utf-8?B?OGtSelFuRHZqNWdGaUZmbXZJSFdHdjJtRkYvWThYY25nb1UrdmRpeHliVTFH?=
 =?utf-8?B?aEdXTHFSdSt2VHVNb2F1ZWZWUW9hSkZUV1FXVmNjMVpicncwdHBCTitIZFAr?=
 =?utf-8?B?VGVGQ0l0dEVuT1ljZW54NmdRQkVzQUwraGZPY0xGVCsrV05PMTQySEdTQnNR?=
 =?utf-8?B?K1UxUW42N0NWTUdVckJLMitySklRVXpRejR2d1UvekZWaEhpVU85Y0VMbGtD?=
 =?utf-8?B?SnlKb2pvUFAvcEE1ZDNIczkzOHIwN1RJaFR5Z0Rzbk5sTm5GSHFmZktCYmNz?=
 =?utf-8?B?aWRpSHJjV2I4cnhZNE8zc1ZNL1FVNy8vRTdqKzJKWGJ6dDBTRXNIcFN2ellt?=
 =?utf-8?B?RjY0OEdQL1ZFSi9sUnAyZStVVi9PTUk4S3lrYm9SMm82RXMreGtXUjJJdXBx?=
 =?utf-8?B?MDZJRkhKTDhWRGFMT1JFeDBnaDZKcE1xek40ODZXZ2Z4emhpS1pnL0EyTFZQ?=
 =?utf-8?B?M1M1a0dzZ1RDZUpQNkErR3ZPQWtIeFQzbEptbTN6bnJPdG03RWNpOFA5UUJO?=
 =?utf-8?B?bTR6SEY2a1FYQzVpRmxuc2NyeGpnVU9oVCs3MWl3V1hBUllyUjlKOUM5ZWNP?=
 =?utf-8?B?TjJwb2tLUFpNWW1ZM3J6TGtOSDRNZ2xDMG5pdEd5U0phRXhPRjk2L3BobHlW?=
 =?utf-8?B?NFdpZkg5NmFuNUtYcHNWYnNYcEZLSEFRQlVYOEl5czkvUGhlZXVFdXFmdWJn?=
 =?utf-8?B?MzRsYlVpeTZYUjFBRnNqdWwxK20wK2krUkxDYnltOG93NHZCSUVxOTdQOGdR?=
 =?utf-8?B?MCthRkRoc3RmZWtTNTc5M3MxVk42UE1aU1c5ME5CeWZ3UHFzVUdXeFl6eHJZ?=
 =?utf-8?B?SmxaTzJobWdUU3I3Y3NUSnMzRTNqV3ViVlRZWlUwdHJWZW5kS0NKL2xiOW40?=
 =?utf-8?B?OTZva3NSeDhsRnhsNk1IYjFxM0NKT2xqZHR6Mm9VeW8zOXlFOTNoYml2eFBD?=
 =?utf-8?B?SWJsU2RpNXpKejM3ZDgwUFFWN0dqZll3RDJxRkRYemJWZ2dKQUZZZHhhT25K?=
 =?utf-8?B?aHNEZG5GK1NFbVoyTWZseTZXL0xLNkhSVTJ2QXQ3TmNHWko1MVdyVmZWYzNM?=
 =?utf-8?B?MHdTN3ZQSWtKbTFFeEFxaS9JYzBvMzRrNFV3TnpDc3lHQzJPY2o2VzFiMEQ0?=
 =?utf-8?B?TG5nMjE2cFJMWExRL3dtSFFraHdZTkYyeGlvbGpmdFBvNGR2RlcwV3gza2hi?=
 =?utf-8?B?UjN1amZ4QzluNXpuem5SN1VsV1l6MHMrZTdtanFrL0NnZHcvejJrY0IxYmVn?=
 =?utf-8?B?STR5NUdGVC8yUkNkd1Bpc0ZBQ2swY1hqTkJZNXoyU2VZZUdmTFV0VExLTWZx?=
 =?utf-8?B?Z1dLYkZZSGUvcjlIQ3ZjOVljVjFkejlaTmNYUExxYWVlVzd4eTVlZWZhVDhU?=
 =?utf-8?B?bi90ZWc3My9NWFcvbGxxY3ZxRTJvTHZNRDJ4N0UyREtJdWFVNlBsL3hRQVNX?=
 =?utf-8?B?YVEwOXRQRERSTGJXaGxsaWFWV1BtUng2eU8rcytiREdHSFUvM2J3amc3Q3ZL?=
 =?utf-8?B?cjhBZDZRb1pneFB4Mmdkd1NFSTRtKzZuK05OZTZBczltcDNEcEdMdW95d3BK?=
 =?utf-8?Q?BJMxO60HjRHjlc+QpN0Ah3Fm1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136b7024-f38d-4193-574b-08dac0ec21e0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:16:04.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /x6cUlB8qp9j49TZaih7s0ArekLdCC69poXNT1IUHBRks05H8VDYMC+kYie879Irr3ejwX1mv1/vmqOfFEUtWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+wyes.karny@amd.com

On 11/7/2022 11:57, Perry Yuan wrote:
> Add one sysfs entry to control the CPU cores frequency boost state
> The attribute file can allow user to set max performance boosted or
> keeping at normal perf level.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)

Make sure that you update the documentation for this new sysfs file as well.

> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 841b1e2383b8..6958c5fd9e1c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -786,12 +786,46 @@ static ssize_t show_energy_performance_preference(
>   		return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
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
> +static ssize_t show_pstate_dynamic_boost(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%u\n", cppc_boost);
> +}
> +
> +static ssize_t store_pstate_dynamic_boost(struct kobject *a,
> +				       struct kobj_attribute *b,
> +				       const char *buf, size_t count)
> +{
> +	unsigned int input;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &input);
> +	if (ret)
> +		return ret;

To be more flexible maybe kstrtobool would be better here instead?

> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	cppc_boost = !!input;
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
> +define_one_global_rw(pstate_dynamic_boost);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -809,6 +843,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   	NULL,
>   };
>   
> +static struct attribute *pstate_global_attributes[] = {
> +	&pstate_dynamic_boost.attr,
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
> @@ -1416,6 +1459,16 @@ static int __init amd_pstate_init(void)
>   		pr_err("failed to register amd pstate driver with return %d\n",
>   		       ret);
>   
> +	amd_pstate_kobj = kobject_create_and_add("amd-pstate", &cpu_subsys.dev_root->kobj);
> +	if (!amd_pstate_kobj)
> +		pr_err("amd-pstate: Global sysfs registration failed.\n");
> +
> +	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
> +	if (ret) {
> +		pr_err("amd-pstate: Sysfs attribute export failed with error %d.\n",
> +		       ret);

amd-pstate can currently be a module too.  So don't you need the 
matching cleanup path for this code too?

Also, regarding the error messages you don't need to prefix with 
"amd-pstate: ", amd-pstate.c already sets `pr_fmt`.

> +	}
> +
>   	return ret;
>   }
>   device_initcall(amd_pstate_init);

