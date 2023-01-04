Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BA065CB35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbjADBGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjADBGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:06:18 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A4813D23;
        Tue,  3 Jan 2023 17:06:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzDWIyTYcTRy0SZUAszdQfg0NM+DzLVqjY0Xw/feqjL6xO8EdEMi6L+PxG4rvk8c74efz5BttIDqA1LWjuChhOqH2F5CRtVmj4vvvfEnVSnRKECBfgjSEyVPzqxt6OEsvZDPbyl+usQbv0K8zONOMtE9tLNAa+EXNRasOBmEyBLaJnbgqKNvB54S31c2KP59cDmnNk4cArNMNtJC6t3Z32UNQXbCpt9S/6yvEffY4t1b4ixKpKkU41kWTIsbicKmX6GjMCbVq8buB9ja0Iodzq8bL7pnIQEyWtZ3/EE14dvjOb9SV1+c6czTFSaBRS7rYfRe6al9bQy5mVCrOp6/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9v6q09LLOdMwSJXJKTRyCPxOD/7hEGkTp/mbZ6OOSQ=;
 b=kVIpJjcYGR7BBz0uLMuARH/7ifGBEFczNWaSFFawKj0qt3m0s4GI84QnKr4bEm+wSCuz613jVsH7U28+IP5AsMUU8VaChJCY6QvxnrmqhPGgkqvg6xflT3LZ1I+2Na6Ady7PcWBurpdPbXg00Byi+VGoiO0wkoSey6bB61dvnUtKybrbI/p2UV7cw5KuqeaFtQD7xmPaJR8Fkcxkv5FPOuY3tKs47bEj777bz/5QDJ9nZddkM5YtNDqPhHhiqjKe2AhXbJFv+2jGz5ag2WcCsp6iufwSW2hO6cdkRKsGlBblh4UWtrHL21aXgJUCYS4zWGReHYj6/lGqVVzk6AXVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9v6q09LLOdMwSJXJKTRyCPxOD/7hEGkTp/mbZ6OOSQ=;
 b=p1+3Z+mk1DEK58iz8y9YKfQKGL2Ou6FxVd1sr9pFcAAAbov+VgsjPDRjO8dXzdYsaYYBiHOCVP+RI/L2OD4S9eeJh65Bya7vh5EY7NdtLwY3qs3mCNDZqQONAVHpIwGtb4ttx8lIf4q+f5Np8PrATXL0Ky7TWmFSF0j4K4iKnCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 01:06:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 01:06:15 +0000
Message-ID: <27311050-37a5-7977-bc5a-200c43b3dbbc@amd.com>
Date:   Tue, 3 Jan 2023 19:06:12 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 09/13] cpufreq: amd-pstate: add driver working mode
 switch support
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-10-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221225163442.2205660-10-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0306.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a169640-a161-48cd-6553-08daedefe0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uvHOJqD3B8IUI/KBAagkVwAW/zzqXDASg4ks3ldHLZ5JVPKMeLUYR0EnRbAk/WV1UQxvQd8Nb0XAZU5Ye3e5m7qYGaRsuNh/OiXvHECn+Of423DjrR1hZKt4Rkq7+gohbV6kOliDfdjDFwJmwuBTQwlJQ1+Hrisl96Q3dhZ26QKutQWyTlFyKt3vj3USCAQThKll66we7o5Jp9Xlb/L+UCayIJWcj9kq4q7QcxO4P+fodJz2ssfmrDPweIVRHYHQnm6Xam/co+1iQw93J+vo9jMw5zJiMnSkbrNr52AxTJRH9JHfL70/ITipvFkw8P8oCdmsFHQUyavHdmOFuzKzog2zN93zJRB/7LqGzRVJH9up55wPqgr78LCR5QuH8l5buea3aatqHHM40aD9lF+h+0eXnuGB6NJrIYxF5r63rihGNCewzWw48rJ6P2g2HWLVDdJ20LXOZyp01CpF/1MQyECeuslheKt5RNo26V9odhkRf+FQttFWaglJaomPVVZAHtd2lVQvhvTK0094XKFlftwgV6XmbNj+gkvw8DcDYtisR/P//zfOLQROIr+vOinTmwh8516pokPWmblfXIIyl6ibtl6Sz1wet46hKJ1uVuVBStcPVwrpdCmoLkllGJC1OirfULv7Dd/LWk1NeFoavHN3ZbvJ8C+p7zZ8VL/KflRS8sfNI4xjOn75QBJlhKYuEyIo9yz/m3BcbgtDqf3/JtRe3J0WUTXL77v8hSEMm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(8676002)(4326008)(5660300002)(66476007)(6666004)(66556008)(8936002)(66946007)(316002)(41300700001)(6486002)(2906002)(478600001)(6506007)(31686004)(38100700002)(2616005)(6512007)(26005)(186003)(53546011)(36756003)(31696002)(83380400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0xNRlhUMEZNbThjdTFrRnJESytpUWQya2FCOFZoeXdtNzFOWUlLWnFpZ2Vz?=
 =?utf-8?B?VDdxejZ6eGhtbWJSVEJ2WjVPZGZtSlV5Mldxb241bUh5WFNsUlVZelpRaVV2?=
 =?utf-8?B?OUt5NEsyWVM0ZFoxUnR1bzBhc3JKTVhFbDkweG41eGR4MWUreXl1cEszcTQ5?=
 =?utf-8?B?VU9hY05tR1ZGNnU2SmhGZjBGcFJFM0QvcjdRcG1URVdnTVZwSGM0eEZPc2pE?=
 =?utf-8?B?cTdQMm4rcXBMU1dodDNON2RjWFRxMlVDaTNncmhKSTEzTXhPa1dYY3RITkZa?=
 =?utf-8?B?SDk2dmZJRkJIYXZQazk1ZzA4RVBiTkt4RVp4QU1KMExxMVJBRW5mY3E0eE9j?=
 =?utf-8?B?Zy9tdi9DL3B0b0JDcEtkT29sZlQ3S3piaWVDUnRzYzl3RFpRNFNKbFpVWlJ5?=
 =?utf-8?B?eGJrYW9MSXE4b21WUzJHSXlaTlZBR2UwazQzdDhPSDlWZldMb0N4Tk91SDVS?=
 =?utf-8?B?OVNBM29Eb2J5U0NXZll0dGpOd2hvb2FrRE51N1crM0c4QWxNYnVGSEcxUHRD?=
 =?utf-8?B?a0NETnVicU1QUEoyUnhnYjdDSjUwTk42R1cvZTR2YlpRV3VBYTU4RmlSczlr?=
 =?utf-8?B?dW55eGxiSzlMQXBTQVVBckJxOEx0QlpyYVF5cVl3aXdJMlV0SWNqcHprUjNn?=
 =?utf-8?B?SWZiK0pzVWlaVkFodC9hbEZUeUxHWDFWS08yaDhsWWVGQWZBdkovSElFV0Zu?=
 =?utf-8?B?YUNBb3UyWndOR2FYdEdqN2NLd2FTMVhBMDl5TThDVzZCb1pSUkhiR3ZRQXcz?=
 =?utf-8?B?Vno1dkFSVVpQcURSd3BZbFdna284TXphNHBxUW9Bb0dCYzNjeWZnaHZWZlFy?=
 =?utf-8?B?a3A4T0xMQzc2K3RXQ3JKMlhqMDQ4aFZYQVZLZ0xBbUpjWHoxME1NZi9URUNa?=
 =?utf-8?B?S3AzaHYvV3J6SmUwSGplQzVEYWY4NkJuNjVScWw5b0dZVWtZNVZ4Y1lQcS94?=
 =?utf-8?B?QVd2RmFweDYrSkxMSkk4Sk5TelVQVTQ5anFSWHRPV2xXeXE2a0phaFMwOXR4?=
 =?utf-8?B?cFRiQnBERVc1WUJBRjJGUmE5aEtWSWxqY0dBK3VRaXJNalZrVUhseGtOYVU2?=
 =?utf-8?B?aXQxRWdnejdJMUdLUDJRcURHNjFKWloxUXEzMWRtRmdNYWM3VXFjYklOL2hy?=
 =?utf-8?B?b1pkblJuUzZ1ZzYwUHBNSWlOdGU4TXNvSWtKYmlVOXlvcFkxa0pKekVTUExl?=
 =?utf-8?B?K3Q0UDdQbExramlvNzRqWjVrdHJnYld4NlRIMWF4TFM3RDUvS05CcUJKbkJG?=
 =?utf-8?B?VGpJM1E5Rk1LelVqVXRSUU5QUmZPQnhPWUZWaVZyMWxGZCt2ZDN6S2czRFJu?=
 =?utf-8?B?MnVUNVgxWFFMUHBLbGxIZnFKd01yS3Z6N0ZXUGlibjRMNzNFQm9MZEJoclNx?=
 =?utf-8?B?RCtZb0RnVlUydFozbXE1dldaMDdwUnFkbkNXTlhTdTNiRjBCbEYwYnAxNmJG?=
 =?utf-8?B?TnMrMlR5elM2NnB3bnhQUWcxMjBBVDlDZTBuczAwMEFHdHBzdk43NFdBaDVL?=
 =?utf-8?B?bDg4cy9rejFMb1RHdFJFcVkwSUJRV0U5V2dnczZIUk5YV3gzMXQxRjJmNXo4?=
 =?utf-8?B?VGpod2E1d1hmRFJXSnM5THR1L1ZNVnZmTnEvcE5JaWc1YmJsS0ZxaGFkWlZH?=
 =?utf-8?B?aWljeW56czg5K2JoMzFZaVY1YmlSTU9pajd0QnZHa3YzMW1TV0NJc2RSNXB5?=
 =?utf-8?B?OVFIUDE0aTIvNHNjSXAveXJySDB6RUJGcHRjKzZ2ZEVrMHdpRW5FaHFkNVk1?=
 =?utf-8?B?Z1ZralFWa0ZJaGE5QS9EblFsNTNvWnZGRHBMbU5meE5xVE5CNUlVbGU5NzNJ?=
 =?utf-8?B?cHc4bEZTT3Jid1FvUTFPV1c3R2c4clhFR2E0ZFI3UldnRzJ3TDAwSFVSU04x?=
 =?utf-8?B?UmllR3FIMFUyY0pYQ3dWYW10SWh4QTAwbWcvYkEwVXpWTFRNMU9jcERxNkZB?=
 =?utf-8?B?d2l1S0pKZnAwUDZzRDd4cnd0c2V6OGloOXhiSkw5ZXVtUk0zdjF6aVhBbTEr?=
 =?utf-8?B?cnpraXBocUVJOG1QbnN1cEd4bkRyb3dJY3NabE5nR2U2dmdFc1FMQVBOd1JV?=
 =?utf-8?B?bGFZa2YrMkt4K2hMTm9leThhdjliSExzd0syZWVSMUZmNGtYcWdOb1B3Zzcr?=
 =?utf-8?Q?F9Lg3JKxoBZx3LQkWudhaL23k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a169640-a161-48cd-6553-08daedefe0c0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 01:06:15.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNZv4hfGqjKBbNkxIwMV3FRxXFtweRaDWj2zfACUVTATH9TuPd/395v4jRV4+zEidQm+z3SZMonRk2/l8gDcIA==
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
>   drivers/cpufreq/amd-pstate.c | 118 +++++++++++++++++++++++++++++++++++
>   1 file changed, 118 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e3676d1a85c7..8ceca4524fc1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -63,6 +63,7 @@ static struct cpufreq_driver *default_pstate_driver;
>   static struct cpufreq_driver amd_pstate_driver;
>   static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_DISABLE;
> +struct kobject *amd_pstate_kobj;
>   
>   static inline int get_mode_idx_from_str(const char *str, size_t size)
>   {
> @@ -632,6 +633,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	policy->driver_data = cpudata;
>   
>   	amd_pstate_boost_init(cpudata);
> +	if (!default_pstate_driver->adjust_perf)

As mentioned in the other patch I think this pointer should be renamed, 
but otherwise this patch LGTM.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> +		default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   
>   	return 0;
>   
> @@ -772,12 +775,99 @@ static ssize_t show_energy_performance_preference(
>   	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>   }
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
> @@ -795,6 +885,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
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
>   static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   {
>   	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -1154,6 +1253,25 @@ static int __init amd_pstate_init(void)
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
> +	cpufreq_unregister_driver(default_pstate_driver);
>   	return ret;
>   }
>   device_initcall(amd_pstate_init);

