Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8D461FCFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiKGSMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiKGSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:12:01 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9DB286C6;
        Mon,  7 Nov 2022 10:10:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCWnybleN6WPOIYxCqNAAWDd65amIZ2QydtMI4hxPaEKUtZ4vodV+HMxS2fkosmu7CkMcbpOzV+kJYcTl08ME01kpP187X3pT94G0uSdu2Jz/Do4ibnnicKOcf7eyCjU9Si7g3sYjQOAFO9qNkkZb/AvBWfReOjdgLZvFcSSJLEAVEk8SWUA0YgwCPx3sE918TmZG7DQEv6rwU4S26jD8gY9nlOeiYjImtlaLOk5OY4Dq45pqbm5vy402N/uL7yjKHNFO55dMU/5nKr1lLgsnkrhf2SoYLWGfA/LTRI+rpUk6QdykDEbRY0hc95M7b+hoYWP7d6ibyLGvdeOpSIpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03X5L8OoEvtOwAXWo89e83DsVnwybAMLwzrJv9yCdq4=;
 b=aE2OQtwDgETMzSpXNtv3Z8w49q10fdigSFtqcSHSQbwn1282LeBbzjjhTRcPj9vNTyfDTLpVDF5bmXEGw77aUzhw0T3V5UJ/Vqzyy798tXitL89mgyhRBV5DyNBFeMO9q/zAXoddq2epvDpAlJpVFHfa/T09G3wiZbLBxTSgslMoEllo2jHEIeEWLptJ11ZaNRDPpAQNvRbiz0InhtHLSruPkAAYH/zBcegkwV7BRjBiXJ4K8fz7ViLR/a7ZMl74OqpW92KYUT4KZNdZQUxOtkuBeMIbDOzhbkGmC+r3Ldig5amIlanjWc1F+bQ4aSxszG++N88YwDxBfXY6xNng4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03X5L8OoEvtOwAXWo89e83DsVnwybAMLwzrJv9yCdq4=;
 b=hlVt7n+Y/aVORpbgiTfqGutQi6/IRax5SYfMY7csGXEqtcSDGmEnkx990oiQBfGS8YYzis6OYzl9MFxE47IZE0M9pJFmiTvSsRwAm7mkzXj1QNCPFSlJMPdrvmpSuMTcmi8H5FsIEoz+Li9ykDaHheZKRYIIEn7seKj6QHhJVLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 18:10:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:10:32 +0000
Message-ID: <72f8e103-b5d1-0def-685a-280b061fa759@amd.com>
Date:   Mon, 7 Nov 2022 12:10:28 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 8/8] cpufreq: amd_pstate: add driver working mode
 status sysfs entry
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-9-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221107175705.2207842-9-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:610:b3::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ab01d9-baf0-4c1d-71fb-08dac0eb5bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dssVeFFQ3DCxe9KCunjOugKfBVy+ol2V6G4ehG9qenEcPIFqaMbi35l0QEjgkOR+Uz2vv9Cp5c8Iw13zioMn5tyDdacI7YWrAcBjGZ9Ncz+ekQb0FPdNVA3cv8OW27xbsGhsjtFHdmmUdtSnrSUF6ThKA4dZGoMnQchUJEdXD2InZ+jTCC0QrNFTPU/Blla/V9m6/HL0WohmvIk3RZyUdOh2+JG3PtmOhgSrI/wE/IQuWjl65Ba2M7ZCT8Vw72g/NzM2QfLaLNTUtaDPMpfR40kU4/PP9Il7GKQqnx8YYC/dUPDWQ/IFpGPSGzxxKzFtX8ATveFgSwiWXi4wlyFyZ1VF3un6pPi4Ipa3YF7GDqZ9S2iTQ2fCudQQ8uv7rJTAVuehn4pOV6YZCwvhkmmjB3k68dRAhMo8N+2hYThFxvg6g94WGDTIVrCnZQZv7yrpszAmRdhlCEIfN0LkwVy5FJlTeNSr7qV0X1ZTcGadPHUpclqkoVhzqCvFEdSWadgbz9V/vTxUDWJoHeB8D5y1RoDmZcqHKb38L0yySmZhm5+k+nlszQXyobCar386djhN9HYIuWtBqEOHeo6G+pUtcj9krIVWZtGkf16uVHq+QiHEXFRv1FioqoAUW7bRVM7gsW1YBQeZ7t0awGLWQ5vUY12Xl8RFr6WCYnQU3a+rIWmHWImIQ4r1UWC7HAy6HZBTJuJj4hdr2n3Mi7BETK0GYuu8Kuwerl7qAV/p1u0uSlTpNodfnVpGpdsSXq+ye+R+V0AUx+S8ucJJPFVPKCGbvPTYDZxuHeYTv8LKlzwaNWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(6512007)(2906002)(31686004)(6486002)(83380400001)(8936002)(36756003)(86362001)(31696002)(41300700001)(5660300002)(66556008)(8676002)(66476007)(4326008)(6666004)(316002)(66946007)(478600001)(53546011)(2616005)(26005)(38100700002)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHNMUXJMd0NFMUJ1UXlueGZmbWxTWjFVNHFpYXl1ZExZMlNIZ0lJMXp2Vzcr?=
 =?utf-8?B?SkRFM29LTDlKdUlZQVRRdFRZOFp2eTZJWDZtL2YzUjRwWEZhaVh1N3l5UWFo?=
 =?utf-8?B?MDE1WFoxZ2lsYXZ6UXNXRWZOZHc0RVEzbEg2WW9raURKSFdRaitSdUs2NGNs?=
 =?utf-8?B?R1hrbkpuaEllVFIxa1FIV3krUGtaYlpObWxxYldCZXdBdTd3UGhSaTA3VXdL?=
 =?utf-8?B?L2hOUHUzQjZFQ0svMG1UUlhiM1NGQjVHTmNLSCtSRTBhVlNtZERNS3JBS1F1?=
 =?utf-8?B?NXNKd2NzcHVuRDFuQ2JZc21FcFdiLzNPZGZFc1BPWENLMGlqUm5CWGdxSGZu?=
 =?utf-8?B?RnF2RTJaTElVSnhCTXJ3dkd3dnZ5ZG9GYjRDMVlTOWJvTm02YTJVMGlnbkwr?=
 =?utf-8?B?K2RLOGNyVmY1aWxmRlRYbUUya1UzYmM1Qytmay9hYUZMRm9nOE5JaDMzZzJl?=
 =?utf-8?B?QjVobHFLUkJ3V21DbmlGcUNCT1NqeTc3ZTd5U1JjdGxxYkp6VG9UUkc5ZjNh?=
 =?utf-8?B?TTJlVkRGWmtCclIwSGRmMFMyd2wrZFd6MERDS0JCUWY3NUpOR2liYkdoTnRa?=
 =?utf-8?B?eWltVzM0NUtHSEdrYWRTY0FoQ2N5Y1dpY3JWeGNhUHBCbXNnaHhXSnRjMC81?=
 =?utf-8?B?MG5XOHZMaDZIYXJTS1U4a2UyNTJHeVZDcTIwQVJLY2xoWUZPOXJXV2VNK1JM?=
 =?utf-8?B?cUJQR3V4WVRCbVJydFhRMWJRT1JiTVAwc3U5QnkzbmlxQWFkWmtvb3libEFm?=
 =?utf-8?B?Tnc1UjFXUG1wYTNQS3VpWFhrYk05U3hRVFlBVGpKU01jaFhDNm9nRU9rQWFp?=
 =?utf-8?B?Qmt4U2YvNkJLMWx3aTRQRHhEdXJkR2dJL3RhRmZ1dVdHUWhqNTV0bzhiTit4?=
 =?utf-8?B?OU5IU1EwL1BKNG00YjVyMGR0ekVNblMyc1RpUXJFTGFBTS9TSFNTYlpKUWs3?=
 =?utf-8?B?dzBiRTFXMDRBZkhJTnVOekk0NzhGMUF2WVY0TVMwWVhGZkk2Yy9YYVRFS05w?=
 =?utf-8?B?NGdkdkw5ZkwvYVJsUXR3ZE5DWldieE1aN2YxNVczQXFmYUhqeU56b0pTZ2xm?=
 =?utf-8?B?SlJhVEtoclN2YkE4bElsc2ZiRkJhdk4xWDVSYXV5dDU1UzIzVlFHVFN2Q3BE?=
 =?utf-8?B?SGpwWW04d3dkWEdhMmpjN1hPa3NnV1kxQ0w2THJUVW5yaXVrdFFHMW9HZ0ZS?=
 =?utf-8?B?amsvcmMrSXNtRzFPU3F4aER1U1ZGaE5RalNGY1lCUHU0azNHeitpdmU4YWNL?=
 =?utf-8?B?eld0OGpwLys1UGVhcUMwbExuaWdicEdDSzFMMXVnajU3eVpxS0hTcnFEajEz?=
 =?utf-8?B?azdMTzZpK3dqVkpDMER6L0orMkpLV1huZGZGbStNRWxTS2ZwTWlXUmhwdjdw?=
 =?utf-8?B?TUtrdlE4b3ppOGRwcUJna3FFaHB2ZVZ0dzFRSzVsUjlic1JleHV0bk5jWW8w?=
 =?utf-8?B?K3kwemtCQ0NqNDFIRTBKcFFBSmU4TTZ3aHBMVk9Renk2N0lOQm5LSHZEUm9C?=
 =?utf-8?B?RUxCUzlrZXdpUTYya0VCSHhVdThMNCs1VGhOOVVQSFN4V0ZTdTBvL2JXWnNC?=
 =?utf-8?B?R3h4S3VwYUVUM05mNkhUYTZiWVdiaUR0NmlIbDN0NjZBU1p6MVpNWmlsS0p4?=
 =?utf-8?B?QnJGdU9TZ2VLUDV0eXd5MW1Sai84ZnZHbi9mU3BUT09VNSt4TTZnNm1MdDZ3?=
 =?utf-8?B?K2dVTlcvcVd2Zno4eVoxTkNzL2xGbzBUOU5EVGVQYW5pUWNNVWJSNUZSNDZo?=
 =?utf-8?B?UFBhN2N4cHRmWVFpc1FSOCtxRUtSeFJxVm1HQVpoOWhjUk5MSmxEMHVGclNN?=
 =?utf-8?B?M3AvZXpQS0haMlgrVGVhSEZEbHhHZTJtVXZvZTFQL0szTEUwM04xSXY4bzBS?=
 =?utf-8?B?L1FwUWJ2SkY3K1U1cVBDVEVCcHBmQjhUUzdDbC9ibmdrbUU2ZlpFUmVBMGNQ?=
 =?utf-8?B?R1NHNStGbS80N2FRcFNORTNSeFludlFhdHhaRUhSSm1ReFdiazFFU1I5ZVll?=
 =?utf-8?B?QmMzQ0gwS1ZJbnFVeDFnc2dna3VrSjZKcFUrRStENWpIN1ptbjRPK2cyYUtD?=
 =?utf-8?B?djlwRnMybTlrbWt5US9Ea0Jwa0JoRjd5aDllODlpclNxRVYvOUtQV2pZNUlY?=
 =?utf-8?Q?ToJP/0Est8fPDsOf4HkhPh0uY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ab01d9-baf0-4c1d-71fb-08dac0eb5bd7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:10:32.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKWfcmQhkRaJb50nne3CNXCnMZcyyHZtB9slCZONAg+zksMK/wA3pCB0ZOibdmjRMExuuWLuvU8/o0/T/qdD/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 11:57, Perry Yuan wrote:
> While amd-pstate driver was loaded with specific driver mode, it will
> need to check which mode is enabled for the pstate driver,add this sysfs
> entry to show the current status
> 
> $ cat /sys/devices/system/cpu/amd-pstate/status
> active >
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++

You should update the matching amd-pstate documentation for this new 
sysfs file.

>   1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6958c5fd9e1c..eadcc9d61d39 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -65,6 +65,8 @@ static int disable_pstate_load __initdata;
>   static int epp_off __initdata;
>   
>   static struct cpufreq_driver *default_pstate_driver;
> +static struct cpufreq_driver amd_pstate_epp_driver;
> +static struct cpufreq_driver amd_pstate_driver;
>   static struct amd_cpudata **all_cpu_data;
>   
>   static struct amd_pstate_params global_params;
> @@ -819,6 +821,46 @@ static ssize_t store_pstate_dynamic_boost(struct kobject *a,
>   	return count;
>   }
>   
> +static ssize_t amd_pstate_show_status(char *buf)
> +{
> +	if (!default_pstate_driver)
> +		return sprintf(buf, "off\n");
> +
> +	return sprintf(buf, "%s\n", default_pstate_driver == &amd_pstate_epp_driver ?
> +					"active" : "passive");
> +}
> +
> +static int amd_pstate_update_status(const char *buf, size_t size)
> +{
> +	/* FIXME: add driver dynamic switching code */
> +	return 0;
> +}

So "Effectively" this is read only right now.  I think it's better to 
mark the sysfs file as read only and not bother to populate "store" 
callback until you're ready to allow dynamically swapping back and forth.

If you want to keep the code there, then I think you should return an 
-EOPNOTSUPP error code for amd_pstate_update_status.

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
> @@ -826,6 +868,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   define_one_global_rw(pstate_dynamic_boost);
> +define_one_global_rw(status);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -845,6 +888,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&pstate_dynamic_boost.attr,
> +	&status.attr,
>   	NULL
>   };
>   

