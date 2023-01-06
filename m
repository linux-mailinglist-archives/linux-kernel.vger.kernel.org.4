Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4E465FA79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjAFDqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjAFDqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:46:18 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67ED6A0DD;
        Thu,  5 Jan 2023 19:46:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDG4eKsFRCtOY6eygrw3PhNtogQAi9ASQ4H94NzvQWexEzaG6OxDfWqg7qAvxbZpHgmWphqZIBGHd4wHRUjl6dBipSwRuXwsPFbmQdx46rPa23QtdGxIx9EyAYOQRimOSAFfH5wOVHRrA/6PU5vNB/y4jnVgsKWN+DyvKcYPxO973tWouGULCjgYbdd2RZxMeby+6EwDjNy4pxU7wf8aQD8Aj++TiwTO8YgVLH17pcrcXTCANpq7UGn/RLm7SJlROS1apPhqg+AXwle76q9FJC8d85nLUMYnmb0nwVnJ5XNUuq0MX81MzFVFFHR7UZEvTQj+6+alKRWznU5nCpuMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfkWYfmf08RPyaseFOn8H2ZqENHSOLXOvc2w8xowAMo=;
 b=NKrldTnRFXEZFksEF3xLWSgekQJs206l07DaT7/QMsX1NpGjFktJ5F1IZA7s1Clzu93gX30ZZHvpPTSx+r9jQ5I0AnDUS3RUTvkFddil9cpcbv2SpyXfVb1g+i9QNRKjOlRpJaRycvzzAq1ETj2JIJ/aOr3WCSzevnp9kaL965kXy3N1L4NxFJI8hqj27MvnApQuUvdxvupk9mxyS4FVca4+HIa8G/jyAnsHMro5VevxMDh37p42Dh7yYvYRd3l8UPExqqHrDFTwJw7F9keM6C99qoPbq3nLPXL6ff6bwHW45yUHREO8mPsihwaURnViW7wggBug8/PK7vIcXQq3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfkWYfmf08RPyaseFOn8H2ZqENHSOLXOvc2w8xowAMo=;
 b=e3IDOgwnrsTGgA7ud7gXqVIfSh2fLFa6Q0OroDSUF/Iroa5fvqZphalr+LdimJTBcbKl1iBn60rD1KVerYbQN5cdBitz70t3aYWJ+cK0/Kt6Dr/XsUD8FKPg0GNnHzKIYeOAbemYDEOFVpqrcHqUGlsuZukn1KFqndfpy+pCLjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:46:15 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:46:14 +0000
Message-ID: <77ad7875-4f02-d194-028e-aa39f510e39a@amd.com>
Date:   Fri, 6 Jan 2023 09:16:01 +0530
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
X-ClientProxiedBy: PN3PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::17) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddf73b9-99a7-498b-ef49-08daef988f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tpRccgm/qYeWwD0flt1ywYiUCDHu0JXyvlbtyDohAv8Iy0rgA6wQsnbGu9L0W4WobY8fVlPboifrPLe3T5+r6xgQ6QYCNTbMQM2U+L1u5HXHtjIbRdjm/W3qsIX02IUukB0tGMMMAPq6/1ApFFsjv79Kztf+EwE2t8Igt0ehKE/x3y93jZHwralOvhWBazhyM0gzx4WAT24VPWc9paX1ZWueyXg88fZTfKesdw1rFv8jmzUhYueVYsAOfTr8QARCGAyGoX8z3nSHCVvAnQjma3Z7Zjdw3iw1hcUaY8xpfHB3t6nzh5azhzjgfMqz7yMPi9JrkhdX/hipnjbDGlS1mZWBgaHWNWHNrEYPSEuidT7hic8dUGslevcBWDybCqI9WvjSyTmq4015T2bmHxRKgWByAMGkRZDhnuDLgqNdAHg3hL13pw6BfecQaxwi6D77hgVC07VobttIXxjnmfi+mYjO8L3mVO5gicvR5lgiUcuxAfQ3dYIet7incx2y8j/R4fUjuHKp54pvzwH5UPXsgTs3eZArFkvt6c6bCoub7Ewt7DzicwUxpI5WNrP5YjNo5YHt86I0JwKQXhDX0VIfN6o2Lk22QQA7Ly+bg7WLGtcB/BkMPf4KBCKbZwV8WE0Sk69np5QDLxwEZ/5gISt1VEDdxokteYRF0BFwPdrv/w94iAaw9jo7Co6QeXEM/szWQrvqOqz05owrziR8t0PZGvj+Vt7wQ7q7kbwHlxwbdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(66556008)(4326008)(36756003)(66946007)(41300700001)(2616005)(8676002)(316002)(66476007)(2906002)(31696002)(86362001)(5660300002)(38100700002)(44832011)(478600001)(6506007)(53546011)(6486002)(8936002)(26005)(186003)(83380400001)(6666004)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRxRENKcTFkMXhTWjNSbWs4TTVTTXNxSkxGUEdzVzArdEVZclRBRDVVVGJX?=
 =?utf-8?B?dWwwSnFiT2N3NXhkV1RZSEJHcm15MCt5Q2V2SFFZNHR3NXRXeUI3Yi9VOHBP?=
 =?utf-8?B?bXI2bTE1ZW1uSFRNbXFaNGsreWFNSGJsaUdGdDFqNk50RHdGckdmbnZKa20x?=
 =?utf-8?B?VnljRU15d1JLMEtiK253OHJVK09qNzBTTklnK2dkQkMvRGJvdzhCWjgzNkln?=
 =?utf-8?B?d1ZEelYxWTl6QVJZOGM2UWJETnlYaHNtb09YdG52QlF0NXJvcmVReFdzOFlt?=
 =?utf-8?B?QkJQd0JPTVdrMlJ2M2ZjdmMrM0g0YXQ3MUQySGYrb21kKy9US1VXN3R1ek5K?=
 =?utf-8?B?SVFLOHZVZUROTXd1U3hiakdCQlltZ2d3bFd5ZjJ2V3cwS1NCVDRMdTl5WDRl?=
 =?utf-8?B?Mzc3Uzd3VzhhSUNEdlowSHhiNjBzT3hWeFFJOVUvRW9peVNGTThhVTRocVRu?=
 =?utf-8?B?RVppbUpZdVdWangzU2FqWFQzVTJMSUU5NXo2RmVxQjkwR2VPbnRWakZlU3A1?=
 =?utf-8?B?cmNBNVhNeUVaZzJ6STFwUjRIbHBMTWRUMldscGt0L2lZcW9zRlA0YTFIL3ds?=
 =?utf-8?B?RzFkUXJadmJyNmt4emtORXl6K2UyMlg4cEg2aDRVUVpTdXBvOW83a3hGaVo5?=
 =?utf-8?B?c3VzN3g4QzBMZVRzL3NRUmZ2ckEwL0kvT1hBTEJnc0VXQkczZ3BMV3lpbVEv?=
 =?utf-8?B?QjJiM3RqQ1l5eUNUUjNXZDhDbklyaVgrOUNibWp1SEpZQUxuRUhDVW1mMXV4?=
 =?utf-8?B?K3hSa0UxcCszRnNVeXVIUlppQ3ZmdTNkR3o1Z1M4aHhkRFJSbUxFSjBscHhV?=
 =?utf-8?B?eXFFanhWbEVGbUNQd1MveW9KZDI1cjUzUlZ4ZWU2OTVKVk9uVmRqaG1BQzk5?=
 =?utf-8?B?a1ZhRXc2WFJOWmNPbkU3UUdvamNNTy9nKzBSYXR3NERMYWpKeFlmd3ZLa3Bi?=
 =?utf-8?B?NXpETWtlNlQwbm85Zy94RmQ3SG03eHNmRzlqSHBPc2FLNmFlVHR4bEsyeFQ4?=
 =?utf-8?B?MHZxa2pRNjJYM1hyM3g3UGYyNS9WK0F1dnJ2VWVEdzdHVnczQXVNVFVpU2FU?=
 =?utf-8?B?TWRVOVdnU0Q5aWw3eHN3aGEyRzk3OEliSHg1K0VmaGNtUkp2cU91U0lLdDlE?=
 =?utf-8?B?REhFVk1rWFVValFSL3VnNkNsQ3g5MmJJMUxlTzh6RGhZTXYyditsT1dtQjVU?=
 =?utf-8?B?NFZrWlJmeHY0M21sU3F2L3dyMnNzaWtoWlEzTmRPV2JrbktZdCtodVdnTnNx?=
 =?utf-8?B?anRxZVBtYzZpTlE5eTkxdHRlV1gvNXZDMWlqZHdCTUUreEhmb0hZNDFISEVr?=
 =?utf-8?B?L2xZaG9oL2c3RGM1eWMyRVVpbzBYcnA0RUpHTUl6ckxhSmxQdTVKNjlqL29Z?=
 =?utf-8?B?NUl5aDVxS1ZTZFlTNlhiQTRUNjNpSThUeFhLMEZpTHNpY29sSkRTZEVTYThj?=
 =?utf-8?B?VU5WOVFuQ1JXeERSSWplMzhiNGcxNXRtNlhvOElqL2VNdW5FL0VlK2x3Vkdn?=
 =?utf-8?B?bmtjT2JDSGJPM0RQNkNLR2NrVHhLeFJDYWYycVF5L21GMHovYjZvZ0VOSnMv?=
 =?utf-8?B?WWV1QXJiZ2lNT3RoOUNtSjBsc2ZhQlVWSVZnRHZYUUJQM0ZrRVk5NkR2c1Yv?=
 =?utf-8?B?bHNxT05HcWpYUHJlRFhNWVRmSjZmUUU1eXFPa3hISDdKc2JDTzI4Zk10azU5?=
 =?utf-8?B?cUhEY2hVM2JXOHVWTDY2V3IvaHQ2QUM1a2VyNEo4dzRHZ2NXMGtxMlNlMmVq?=
 =?utf-8?B?MXR6M25RaktIVmZzdE01MnRUeHBNTkRRaklKemRxanRJZTlQK3pUcmNhSGdX?=
 =?utf-8?B?NkZ0K3Bmd0JTbWgwRmJFZ0JFamRIUkZLUXdScnpkYW9pSnZ4Yk9WTVBVQm1y?=
 =?utf-8?B?ZDRQWkVuYnhmNm5KUFlrMTN1bnZPZVJlait6K2k4WjRod0FENFZWcmZ2dVk5?=
 =?utf-8?B?ekczVG1EOENabTFOcmxUY3VTQThTZzhtL2cyUEJCb0hYcU85YUtMSDh5dmpW?=
 =?utf-8?B?NkZraTVXTzNaY0RJM2FWN1VnNkc2RHAvYTIvVWhNaXQrRG1GTE5FY0ppK1hE?=
 =?utf-8?B?bXdOMVY4ZW1UZ2dmdFpYbE0zZ1g0ZTFWVGFTU2JyRHZuNUlHOEtQK000S3Nq?=
 =?utf-8?Q?eWlID2102YkUjd+59s8G2/XQx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddf73b9-99a7-498b-ef49-08daef988f2e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 03:46:14.6850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJKEUDPR9FtxhGSsAgYWUUxLNiilMnZNZgRT/nMGSxZgETpyQ5l36XXKWLbf+pQhvkQNGC3SFozw6ZMEVeyIYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
----------------------------------->8----------------------------------
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

what's the reason for not supporting active -> disable?

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
