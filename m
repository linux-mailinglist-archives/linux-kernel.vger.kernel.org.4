Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3256F62D294
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiKQFGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQFGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:06:33 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403B2EF55;
        Wed, 16 Nov 2022 21:06:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGW4eZl/Jj2fvmHnse5nnvkk6kXmr18Az0+pLZNBHaKA2QPiJRBTaHkm85sn5g16IMlpZReHJdeAakolvqykap+Y2VezB02NgJschzmyBzzSzsRuGwJTL7C8r4DU2VrFSNJJsSpKXJJF/vQ3bPBbjtb29OPoywZFqzJRa2TWdlHoVsNKULWD2bYjqmHkD0YaQ39Yp7mVIvFqtVrTLttviyCXvGfs4i64VuHQvp05bkOLIvXjleueQkNC0LSQgp/DvthF4mFH7qbzQNzRpdhAq7F6cB6XM9eIloDWFXsfFVHakm/Ug83tpbU7eJkpSScPWbvmlreTE/AqCXSafd8eOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLMViK6YiohHqF21KeO7zwz8pfUBemZ4ogMlM+9ObAE=;
 b=jsU93qCigALvKv6zGK5i3quHI3LsrjO+vYRfS9eViag4Iy2pQDHBlNoYLLg6VFPvpckGxE83cylxKSSmOuDPOf4OSvltv0zmIxqoLXd+eaNzCZVIqGZtXqDy+DNclurxtG5dheWTQR9bo2FPjDFiBfh2l8H9bIFGat5CTFXhRY12HyNldpJlIEpqIqA7utf+9VNQsiRwhy8JNWV+Xy5ZFloTVTH7GTwy1zLLwm/X9YtGfA9wAz0teCZD9CWhPLHM+03/PM7DpJoCJmNpXPtTvC4D3GptRaJbIjfRjyDSYNahT9/RXPMRlRgCwJxKVHv0iMHoidjeoz5cneE+olJeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLMViK6YiohHqF21KeO7zwz8pfUBemZ4ogMlM+9ObAE=;
 b=vOiUdiyIzdhGN8nPCS2O/HPrnvdweHy1980PmbBl6t62fuMUQzdVTUZF92LZ/mgA7zMPlsRgTYiKWlAqiQ1YtsrET6iEpC9ExAHTjcS8zi5YgoJsT/hbA9NHwBtsGYisEWzNdR1O7teesCByURmolkd1yDPNRWSsk3Ntb3kxZAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Thu, 17 Nov 2022 05:06:30 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::b6f2:3174:a1c2:44b5]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::b6f2:3174:a1c2:44b5%7]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 05:06:30 +0000
Message-ID: <a219d952-6090-454e-a4d2-f5b9ff308129@amd.com>
Date:   Thu, 17 Nov 2022 10:36:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/5] cpufreq: amd-pstate: add amd-pstate driver parameter
 for mode selection
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org,
        Mario.Limonciello@amd.com
Cc:     Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Deepak.Sharma@amd.com, Shimmer.Huang@amd.com, Li.Meng@amd.com,
        Xiaojian.Du@amd.com, gautham.shenoy@amd.com,
        ananth.narayan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
 <20221117024955.3319484-4-Perry.Yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20221117024955.3319484-4-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::25) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e49371-1afd-4804-bc53-08dac8597cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSQiCIsTphkWS66zvrL89P1/36bxi4c0tOkWgzLakEOxKHCYO0IPCvbmYqVRk3EBB3wXSxO68hKyVRSYVR6VbAVcWwijd+LA29FeZy2n5nh4Zrc5+ZJbyTF0s17vlOPKxDa64TualSipsBKMJYv41FgKQtTAk+PaPakCKverFN/23EatywTESZ9J95vxUTZAzp2GZh0H5wMHhGdGfeubUF7aLMVdAaHR5tArybviouX/v3BukhkcX9Z6wQ2NBiA70utm3B5QKGYghahqgCUt3tRC2UZDRHRJG+djbjBRzWDhWYoFZ87sRontTIx/vml2bGckVTFzUwAOaKUuIRrEUjtsVjX4BYQrb6P3Lj6Xcq4Elx44qPtvIL6gebP035BonJGDTq/JKU0aAAh6t1F5u1GBa4KaLeDcEXkA2T3baWsgoWr79g9oKrG7Qj1mOyFmipvZFmSGEkWMFL4u8pzYFRXS7mfg6qkTBlpc888z3rGomTkOSyOleYAs2u3+A8pBtABnuYJPtkPyr5sH7zFUvg2CMXKDbpYqzXT8vbDn/q3HbKRlDYjz0s1DPT/iMJ+eR60LTs5mfkpbDNN1xHxRUZD8S42R5LxTcSxCH21HzM81p5e2WeHqpaUqq8cYz/GolhRM8TfSqdtkuJyItSXIvgOEmm+UH5EVeivYOF0mFjWZr1vN44Voc66Cqj2b/FEBNmwPYZsQIiqaTQY6fHvgHiYkGpBBw3nb1nbw3b9cD88=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(38100700002)(31686004)(31696002)(86362001)(36756003)(41300700001)(186003)(316002)(66476007)(66556008)(4326008)(66946007)(8676002)(8936002)(2616005)(83380400001)(6486002)(478600001)(6512007)(5660300002)(44832011)(6506007)(6666004)(2906002)(53546011)(26005)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZytFdmJFejNQVk42b1VTQmlrVDR3cUZkKzRMdzhqL29CeTNkaUhOOFI3aWRU?=
 =?utf-8?B?Um9aZVpPdHJTbnFmeC9BR0pXRDlyVzI2LzliRnAxYzltVTAvZVNCSEhDamlE?=
 =?utf-8?B?c2d5TTV6eG5qak9CMzdyTmNQOHJWLzVlU3FwUHdGSENHdW14N2NRZVlJRWxk?=
 =?utf-8?B?UXo5dlNKN0M3RWRrem9aS2c5NitxbjNTM1c4eFpJNVAzTkp0TytEcE41WENu?=
 =?utf-8?B?eGE5eEVDelVrdDhNYmtRY01NeTBGUnE1ejZPZUU2ekdENmxFOWdQamdiUW9H?=
 =?utf-8?B?WDk4ZVhBcU1ydFFFSnJuS3ZJakpBNlFnTG1GZkM0anRmb1IxL24vdGFlckVi?=
 =?utf-8?B?TDVzd0FpL05NblQyVlVCV1hGeW9kOCs3OUJvSkxsS1A0V1dKbFJ6bk1kMmh6?=
 =?utf-8?B?RjBWcVRYTm53dXdBRXplNkszSVJnVUVReUdFRFlNQ21tMDVvZXJiRExLODE4?=
 =?utf-8?B?RUdXZ1h3YnpFQ0p5Y0NTOWFSdW9jcDM2Ky94RlRjRWxRc2YzZElSOE1oTUxY?=
 =?utf-8?B?MnFLSUNkMmVZakpuVmNmOXNHTHdOOWF3ZDJSR3ZqbjBScnlBRW5GbzBNZnl1?=
 =?utf-8?B?b083SUJ1a2dDeHdBWE4zLzB3S3NpaGVmTThHUWZHRSt5WXlSa3AwRFVpNmti?=
 =?utf-8?B?YWQ3ZVJFbTlCUjBIZldxSEZ1NmFrTlVZVG5sVFp0V1pCQ2haMGFocjZIRmJH?=
 =?utf-8?B?Ykx1d1l1Y0V4ZGxmcyt1akIwMlRLVE5RVGJZSmlaRkgrd0h0ZGU2NFdSamxo?=
 =?utf-8?B?RzVvTFQ1aXdlUWh0N1Y2bllPcHB3OU9aYWtUYkJIVDJGMjlYeEZ6M1RvRks5?=
 =?utf-8?B?dmFuR2NQYXNUUTYrbU9PeGY2OUhYQk5UdVdZRmhKSThaVGdWVlY4RnZ3VTNO?=
 =?utf-8?B?bVJOWW9SNnliSm41TUEveUZRZmJ3VmNvWXhaRFB0YXZVaWc2SjU3aG5KVENo?=
 =?utf-8?B?dU53dURoV0hKa0JPNDNHeTFXNTdMYnFqOGR4NldNRG0raXhjWm9wWkVPSjhS?=
 =?utf-8?B?WjF5c1VFMVNnZHdDSVgrdXpzcXlWK2lNNkg4NEFaMHJYVk9wOFRHK3V1LzB4?=
 =?utf-8?B?bk90OFMvSFdMc3BBTjBqM1dCVEFhbjU0dnpDSGo0WnJHQ1JEajZTcXFJYmRa?=
 =?utf-8?B?UWxqK254WHVPbTZVRFhpbmxSSHB5dnY4bG02YU9lMGROcjZZQy9FRktDWUFY?=
 =?utf-8?B?elVIamVLQlF1SzhVLytiZ0V2U08vbjA4dUkrQ3NSWGZHVWhlNWhVREduNE5N?=
 =?utf-8?B?bTBiVGs3emZsVkx6K0NJa1FycDQ3OWhmYStUaE02cjN1cURDcUhIZ3hzN21Z?=
 =?utf-8?B?UmtDVWhxZUVLeDVHeW9vRUlPaUpvRFhDdzZHclhoNUFaYUpWc0o2NDVhZHlx?=
 =?utf-8?B?dUxUYkpubUJMNzFjTmhqbTJJZDlZTE1vcWxwQlV5ZFo4RUgvQjJwdEl5U1hV?=
 =?utf-8?B?SjVFcTIrdm1wTWlUVGFxM2IzeG1oUkwzY0NOWXk0RE5MWC9yWXphMUxnckZ1?=
 =?utf-8?B?RUV3UjdTdmR5dUUzL1FVcXRSSnNsc1dBaGJXalJDem9BajBTdTVZaU10SHlT?=
 =?utf-8?B?bGZ3RU5kT01kZUEyR3BzSkdEN2M5MWJ5WlVYMTBqRVI5dkc1bkd5bzc5VTBn?=
 =?utf-8?B?RmRMVVpQRjBrR2ZyTHliOUFoN2wrc2ZHQnJzelFTdG9FSklHRldORXFQS1Yv?=
 =?utf-8?B?K2ZWeHRqdE9ENVVIOWhETDBhc0x0RzFvZ0R2Q3AwYmVBTkRvdzFxNStiREhK?=
 =?utf-8?B?Mm1jazk1MUhpUEJtcTI2ZmxCamRsTWk3bEV2cjV5TlBzbjFOTERob0RNSUdp?=
 =?utf-8?B?cEQxVTJBN3NYa3F0MXJ0U3VOWUVORVo1LytkRTkraWNmZ1VPbEQyd01iRXpn?=
 =?utf-8?B?b0pZRXVSSVdpaEI2Z3Zib1RrcmVlVnB0UWhBMVVYZTZSWWl6VVMxWTlGWkhi?=
 =?utf-8?B?MVdacTJKc05QUU9yaUVpcmZUdTR3NkhxeEc1QnpLQ0libDJienpRcXcyWENx?=
 =?utf-8?B?UElhVmVkdHkrY3hqd0g3OG9JdmtDTXcrY213L3VWM1llcHNJZVdyU0ZGdnhn?=
 =?utf-8?B?UnpQUlY4dzcxTmdHSzBydmx6MTZWaFl1YUswNU1rdXE2RGd4OUJrLzBacS9N?=
 =?utf-8?Q?/7al91GzwCebyHp+u8qdvywc9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e49371-1afd-4804-bc53-08dac8597cb1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 05:06:29.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6xzC8E+pW6tBgiKR7TC4DfGHBrJRZssD+lhC6l8sXJqFJTgCxFtpv8ZirOFFefgvD79mNTCJdzq6qUnJIKEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2022 8:19 AM, Perry Yuan wrote:
> When the amd_pstate driver is built-in users still need a method to be
> able enable or disable it depending upon their circumstance.
> Add support for an early parameter to do this.
> 
> There is some performance degradation on a number of ASICs in the
> passive mode. This performance issue was originally discovered in
> shared memory systems but it has been proven that certain workloads
> on MSR systems also suffer performance issues.
> Set the amd-pstate driver as disabled by default to temporarily
> mitigate the performance problem.
> 
> 1) with `amd_pstate=disable`, pstate driver will be disabled to load at
> kernel booting.
> 
> 2) with `amd_pstate=passive`, pstate driver will be enabled and loaded as
> non-autonomous working mode supported in the low-level power management
> firmware.
> 
> 3) If neither parameter is specified, the driver will be disabled by
> default to avoid triggering performance regressions in certain ASICs
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Tested-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 701f49d6d240..204e39006dda 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -59,12 +59,8 @@
>   * we disable it by default to go acpi-cpufreq on these processors and add a
>   * module parameter to be able to enable it manually for debugging.
>   */
> -static bool shared_mem = false;
> -module_param(shared_mem, bool, 0444);
> -MODULE_PARM_DESC(shared_mem,
> -		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
> -
>  static struct cpufreq_driver amd_pstate_driver;
> +static int cppc_load __initdata;
>  
>  static inline int pstate_enable(bool enable)
>  {
> @@ -626,6 +622,15 @@ static int __init amd_pstate_init(void)
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>  		return -ENODEV;
> +	/*
> +	 * by default the pstate driver is disabled to load
> +	 * enable the amd_pstate passive mode driver explicitly
> +	 * with amd_pstate=passive in kernel command line
> +	 */
> +	if (!cppc_load) {
> +		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
> +		return -ENODEV;
> +	}
>  
>  	if (!acpi_cpc_valid()) {
>  		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
> @@ -640,13 +645,11 @@ static int __init amd_pstate_init(void)
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
>  		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> -	} else if (shared_mem) {
> +	} else {
> +		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>  		static_call_update(amd_pstate_enable, cppc_enable);
>  		static_call_update(amd_pstate_init_perf, cppc_init_perf);
>  		static_call_update(amd_pstate_update_perf, cppc_update_perf);
> -	} else {
> -		pr_info("This processor supports shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
> -		return -ENODEV;
>  	}
>  
>  	/* enable amd pstate feature */
> @@ -665,6 +668,21 @@ static int __init amd_pstate_init(void)
>  }
>  device_initcall(amd_pstate_init);
>  
> +static int __init amd_pstate_param(char *str)
> +{
> +	if (!str)
> +		return -EINVAL;
> +
> +	if (!strcmp(str, "disable")) {
> +		cppc_load = 0;
> +		pr_info("driver is explicitly disabled\n");
> +	} else if (!strcmp(str, "passive"))
> +		cppc_load = 1;
> +
> +	return 0;
> +}
> +early_param("amd_pstate", amd_pstate_param);
> +
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
>  MODULE_LICENSE("GPL");

-- 
Thanks & Regards,
Wyes
