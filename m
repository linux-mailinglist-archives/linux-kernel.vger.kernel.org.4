Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2DF6A737D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCASdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCASdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:33:33 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77AE2F790;
        Wed,  1 Mar 2023 10:33:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WytqAZQZ4vSF5sBunIePmfl8/PmmqAE24UBwxpRT6hWS7VaIpdgYnjQX2JhMLH+tQKZUNSwnaNt+66k9fRzOOTcLbu02gSNmKmPySDawOo8/h9cNTZUUonwNApli+eMUHrtqX0ERsPWp6Pnkau8n03L1/Jg+wTGIej23so0kq7Yux1lGsOhwXlwKeWBsXQe0y9++JORC0GxVIu60KPxwG4k0iY/UDqN8AzO5cG2dlqvxjo8Ey1aRMmH+mYsLbocDzMbuO8VHidFiCd3WTe5yw/BqnIIw4Ux3UwF9Ov4NtJuBjlNZYD7lQdI/vuIP9jhJFDLDlQA6I6PwKJMtqFRxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fF5h4cg8SHlwtmpmxL58+dtdKLW7hceuXLyTeC7d/+I=;
 b=XAKXloFUo6MTJh2kKx35+hy3kKR/a+j0Fs+X6JBHZeVINiVN6WSbzhge2okUUgG+GaSja8sT4jcrJ4MU3Gamw+ZgGLc2iTF+87GH5PqV1s0adN2LzeDSjCFHfLNoeL4xK/qQInZ7f4M38HvIvp4KJBre5mvxrq+UgE84zRKWKDBz9GQtGhNCCqcPdDjaMTh/hVgnOre/vpytzrXBir2eqUIXc4YfDMCT9kkagpHtK8r++40d9dtT3agPbGuaJLHF9AffVEl2zVY/DOH8xnoDaccnSJSGY/VhHgzJI4cLwpElaHJFlSukiYCAkcWylK1f8Mr8vSSH+V7V0FmiBJ/OHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fF5h4cg8SHlwtmpmxL58+dtdKLW7hceuXLyTeC7d/+I=;
 b=q3AnpjArFLkeuuVGbDcV+j1VRRMWcBcncuptjXO8szg8YV5EvwKolQ7vOeHy0Vt8/UOfg3hS5luJlfGYNlojKTJFmmvcBKsIuDwg2JSrmpkdD2BDZVcKdkv/olRtOLW/XX+kLpUKcDM0enDsF6u52tCauRzDUqhMRa+40Tv0Pg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Wed, 1 Mar
 2023 18:33:10 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::c1ee:6529:69ca:7e63]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::c1ee:6529:69ca:7e63%5]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 18:33:09 +0000
Message-ID: <7d31ec11-cc4d-b6ed-8656-d23257e5af95@amd.com>
Date:   Thu, 2 Mar 2023 00:02:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] perf/x86/rapl: Enable Core RAPL for AMD
Content-Language: en-US
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com
Cc:     x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com
References: <20230217161354.129442-1-wyes.karny@amd.com>
 <12153455.O9o76ZdvQC@natalenko.name>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <12153455.O9o76ZdvQC@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::32) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a17a85c-9afc-43a9-1bf8-08db1a8367e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zy05sQWP4heA+3kBOkVvuyDDy1cTIxXoXp2YeM+NfUy9I2NZ8dgXHRckLjJU0vtibL+m3vNqQxsjTlIsvIVeokAmU8q7p6ax7/HhDNZtMwYA9P/483z/Kx/H7kq5fcwJbedouaG+Ke8zs3ASq7XqhbRAhnz9AU/NbS8LGUT22chDZhPJIj7wjmbANwWFjAzvTf0khLyCoMXp4pbiaMJfDEPKe0T5hV4z5L5KgoUVmWFHbiUfXSzr5u1lsFq5Fyp1FC5L3nbF/+/LAnZrQIIcosLdJ7aOiV5LZHFrnBPASzm6YOcNC+T+88i7XTi+1QpDIyOXdKxDFY7mgyb6625eYaGpYw5Xzh7B4jc+LH5qHA8CklolAUsD+aNZdC20hZ/YAw8onppsgV2ykMwLJfiMeFbHFOKosotPyIGcsuSc+dMRpiCeohaIonOe1XjY77xr/1ZNQ2OGgzxhg7kitrNxtuTGym0SJb013fduASZwTjlhzjZ/WmWUuXvwmXnoHi7THEHRoWWt/jzMkhYbcPIQqu+Sw5NGInjdjJlHJl4xidRGymOeZKCBxzqJZx1Tg6xhNC8VlsBd4xRu58Alin/nT2gvRquKPwk+r5x9G7r6NPGMvaceUj99FMf0Uklhk93LEF5GslIqx7f4HHmXFC7Lzna+lDpxVculqdPWmwgAwcfF0aG+8wbqg2ky6CnvFSc3ijux1pJbjRX6XxACfHyz8zaqCyoeukI1TsNGBz2iLDYb7RySwHiVZ38l+4VxhCbL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199018)(8676002)(8936002)(110136005)(316002)(36756003)(6512007)(31696002)(478600001)(186003)(26005)(921005)(6486002)(86362001)(2616005)(2906002)(6666004)(6506007)(38100700002)(44832011)(53546011)(5660300002)(7416002)(83380400001)(4326008)(66556008)(66476007)(66946007)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUd1YnNic0JldWhKWDc5TDdtQWwwMGZaYmhLRS9ZMWY0bk8xYlErZk5PT1Iz?=
 =?utf-8?B?NGFGem5RWHdwYVlhMmhGakhCTW02M0N5UXRrS0xOMkxQSlI3SSt1WThGY0tI?=
 =?utf-8?B?SENwY0lqRWtKMDhkWFg3VlM0MGJRQ3NOWkZScWE2WjRKdWJXQmhXVXpjSUJs?=
 =?utf-8?B?V1NWNUNHbDZ5cXFEL2FOdWQzTk9sTUNKcmhpYlo5a2tuOFJIT25QL1ZFeWxv?=
 =?utf-8?B?ektYWFBlazNFWVZFbk5GTVZON2lNKzVIZFF1YlR1NFFtdlJpbTFPVms5Vkxy?=
 =?utf-8?B?MTBHUjRGcDZPLzdUMTQ4NDRJd3ZBZHY5M2VEUVFaVVpXSFBGWFp2aWVOUzE5?=
 =?utf-8?B?QlJwREozTXZvSVY3Qmd4aDVwbUdmY1pnNXJyUFgxZEZqcE84OFo5Qlo2U3o4?=
 =?utf-8?B?YzIzWGcyM2ZycTlSYnF1ZE1DWXZVSDdsbVBjVDFCZ3RjbVplN0JxN0RBSzhy?=
 =?utf-8?B?ZFpyR1NyNFF0TXR5RUg1dUhUWGxINVZMMjJwUFhUUzdVTzdCSTZDZGtvamg1?=
 =?utf-8?B?NDBNUGFJTjJycVArN0UzZzkzVVpLNk1XdFA1ZmtLZmxUUmRqMHZ3R2s2MVdM?=
 =?utf-8?B?cHlvcm1HSTdpSzZML1VVelRXeUIycys5VEVGWTBDOEp3amxNMmJMWVI5ZDdz?=
 =?utf-8?B?bHFrOEZGWHZJTDNUdWVyQzl2U0x5dEFiWmp2QjZJR3JMSFUrdy95N1hPRFIr?=
 =?utf-8?B?S1hicUZiT0V6UzVLQjhFUWlYNWE2NFNvWnhBUE9ybC9wMnp5cGJvS3F2R1Ez?=
 =?utf-8?B?cXZDYmJsRG9qZVMxQ3FxMnVTb0JFMVhSOXJjUGQyQ1E4cHRkVTZtdEwvWHRx?=
 =?utf-8?B?NDVCQmhKd2xvdjhpQkhWYmtTMCtQTHUzaVNhd2xCTTFpZm1PdTlkdWFzanhC?=
 =?utf-8?B?RHBjdDRaV2xKWG9IMUNCNWRLZUJscHdwV043Zm5PSWljSHdDVWhscURiTzF2?=
 =?utf-8?B?MW8ydlp3eDR5ZC9uY3BoeDFndVk3Ynluak5OUG1nbFAxSFVlTWxubkVjQmE2?=
 =?utf-8?B?bXJNc2ZRSXhka0xVMnVFOVRYeUpyR1NKVnE0MHlQYUxWRzdCbWMwa1VCY1NN?=
 =?utf-8?B?OERkRnI2MlVIaVRhSnVueENJWFI1bjQ5QTRWMEVIczR5VXY1RHVSOXowK2JM?=
 =?utf-8?B?eE9KeEdqbHFQUmNQcWtWeUl0a3NjUDgwUWJ4cnlNYUt1dTVVc1Q1cnZxb1pr?=
 =?utf-8?B?VVBPMmpzL1JHckpuempuYXYwVFpiQWg1ZTNvSEtraDg3NmNqWEpMazN5citn?=
 =?utf-8?B?SUZOZXZsb1g2azE0b1NTWkpBY1hmQXNvVUNSMDNkaVBzaW05aml3VG8xOXl0?=
 =?utf-8?B?TDMxSFZtWTNQdEJ5YlNHa3BoZytISDQrSnVPbmsyNE5qd3pUZm9Wc1RsbEp2?=
 =?utf-8?B?bEpzSHMraGV3Y1NrTnNmME5tWVRqY2VXdVFrY01kV25JbFZyaTIvNzVIS0l6?=
 =?utf-8?B?TWsvMFZ6TldpR2NISjRnSFF2cTlEOVFCVGs0bUFQNnFzZE1YWkc5emp0Njls?=
 =?utf-8?B?ZktXTVZ6eGM5ZSszK09oUk1yL2I3dm02ZTJkeFF2anIvZm40VjMvNnZFOHVG?=
 =?utf-8?B?K2NNNnNOdm15d3R1bUcrRFJUL1JmU09pRzhxaThVb3hlYU9PMnFEL1hTSGZv?=
 =?utf-8?B?ZXN6MUpiNi9rdVVJNXh2RHVQbU9mR2FaV1dkdUdQM1dtRE1la0l2dUVPNTcy?=
 =?utf-8?B?VzBsL1RWaUJBTHpXQ2llZGZFcDJ6Q2YwVmE2em5zRDRESGN1UXlza0pIZnov?=
 =?utf-8?B?MHlSeFdSeis5cFlnNFIwc3UwN0RrdEw2cUFwcnZsU0VZc2lGMEtZZkFGWVhi?=
 =?utf-8?B?aE1YSVUvS3JBSkVFZnpmTzZpWXVOTVBZUzBOVEtEUStUTFZBazRDRUcvbDdv?=
 =?utf-8?B?b0dEaTd0cDFIZnRVMExYYTdNWEhIK2krQ3YrRndWNEN1Y1JYc3hUemI0Zzlt?=
 =?utf-8?B?bFpIUlpwVTdwaDJVT1dWWHdSelBQVzRjWjFOdzV5dEJiTEplMy9HeGRKNk05?=
 =?utf-8?B?dnlOcU9sQ2dmWFEyQWt5VGlkZFJiUDlEY3BsNTdjR2FTMForUWVtekRKNUR3?=
 =?utf-8?B?S056TlJHMUNNR25VZWZwRVVYb25VVC9xelhXbVBZeURGRmp3dGJnWlA5R2My?=
 =?utf-8?Q?wxYrPLKt+D4oLWAPn420uicXx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a17a85c-9afc-43a9-1bf8-08db1a8367e2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 18:33:09.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZPG4ZPKU4LSRMsGKhPpzdsfKWcM5DkQ9UW6ZTqB3yzPA6W4pgI1o2SGJ/SldKjTwnk1rEGXhuf1NZg9AvBKXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

On 2/19/2023 5:22 PM, Oleksandr Natalenko wrote:
> Hello.
> 
> On pátek 17. února 2023 17:13:54 CET Wyes Karny wrote:
>> AMD processors support per-package and per-core energy monitoring
>> through RAPL counters which can be accessed by users running in
>> supervisor mode.
>>
>> Core RAPL counters gives power consumption information per core.  For
>> AMD processors the package level RAPL counter are already exposed to
>> perf. Expose the core level RAPL counters also.
>>
>> sudo perf stat -a --per-core -C 0-127 -e power/energy-cores/
>>
>> Output:
>> S0-D0-C0           2               8.73 Joules power/energy-cores/
>> S0-D0-C1           2               8.73 Joules power/energy-cores/
>> S0-D0-C2           2               8.73 Joules power/energy-cores/
>> S0-D0-C3           2               8.73 Joules power/energy-cores/
>> S0-D0-C4           2               8.73 Joules power/energy-cores/
>>
>> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>> ---
>>  arch/x86/events/rapl.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index 52e6e7ed4f78..d301bbbc3b93 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -537,7 +537,7 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
>>   * - want to use same event codes across both architectures
>>   */
>>  static struct perf_msr amd_rapl_msrs[] = {
>> -	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
>> +	[PERF_RAPL_PP0]  = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
>>  	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
>>  	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
>>  	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
>> @@ -764,7 +764,8 @@ static struct rapl_model model_spr = {
>>  };
>>  
>>  static struct rapl_model model_amd_hygon = {
>> -	.events		= BIT(PERF_RAPL_PKG),
>> +	.events		= BIT(PERF_RAPL_PP0) |
>> +			  BIT(PERF_RAPL_PKG),
>>  	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
>>  	.rapl_msrs      = amd_rapl_msrs,
>>  };
>>
> 
> With this patch:
> 
> ```
> $ lscpu | grep 'Model name'
> Model name:                      AMD Ryzen 9 5950X 16-Core Processor
> 
> $ sudo perf stat -a --per-core -C 0-15 -e power/energy-cores/ -- dd if=/dev/zero of=/dev/null bs=1M count=100000
> 100000+0 records in
> 100000+0 records out
> 104857600000 bytes (105 GB, 98 GiB) copied, 1,59252 s, 65,8 GB/s
> 
> Performance counter stats for 'system wide':
> 
> S0-D0-C0           1               1,56 Joules power/energy-cores/
> S0-D0-C1           1               1,56 Joules power/energy-cores/
> S0-D0-C2           1               1,56 Joules power/energy-cores/
> S0-D0-C3           1               1,56 Joules power/energy-cores/
> S0-D0-C4           1               1,56 Joules power/energy-cores/
> S0-D0-C5           1               1,56 Joules power/energy-cores/
> S0-D0-C6           1               1,56 Joules power/energy-cores/
> S0-D0-C7           1               1,56 Joules power/energy-cores/
> S0-D0-C8           1               1,56 Joules power/energy-cores/
> S0-D0-C9           1               1,56 Joules power/energy-cores/
> S0-D0-C10          1               1,56 Joules power/energy-cores/
> S0-D0-C11          1               1,56 Joules power/energy-cores/
> S0-D0-C12          1               1,56 Joules power/energy-cores/
> S0-D0-C13          1               1,56 Joules power/energy-cores/
> S0-D0-C14          1               1,56 Joules power/energy-cores/
> S0-D0-C15          1               1,56 Joules power/energy-cores/
> 
> 1,593982452 seconds time elapsed
> ```
> 
> Hence,
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

I haven't put your tested-by tag in v2 as I've added a new patch there.
Please let me know if v2 works well for you and if I can add tested-by on v2.
 
> 
> Thank you.
> 

-- 
Thanks & Regards,
Wyes
