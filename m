Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19165E549
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjAEF4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjAEF4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:56:19 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB0C4262E;
        Wed,  4 Jan 2023 21:56:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMQKkHapIgOakFOdtmPe2j9IVdxbY1QKZOEgnwIDKU/7B7Pxqrot+Mom+ixfhL90Q+KGiOTnPnze1cWlcJBMdOErpL0BgLugjj+jDCUiaqf5C5O0wZP4NGSC50MWdGlr/Y9KmOvD6zWfcqBonpyes/X/+cEI3ahf0hMQ+vKlJq9Qhdh3yJIb+jYjAHUM2GA8CelBrQhItMd0tX6gfhVElM+1vPEbrdB8OXS0iBiSeTHsX6F5PWy5LJJXZ2hL529ltHnl9PzYN8uDch+r67UerHVj29ed6fKbWHUHTtPnubAH1/m/26/BhPzNHXUjheawDQyVPPoQf8ScHPFtseYAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8Mh7fKEbubac9hvmPHQFTzWOnb/nlAsulFQsVEQPaw=;
 b=X+vUrspqiUQJ8czv/FEnnMjFYjIE7ewkkrm+/RIlixmgPmpHIY7q31y9C1SsE7SuERU8DUKHF59iRC3ElmKbef5gSo+vTioivf5M9jubfnNWWIoFs8+QfZn5tcJiF8Zo7gfno3xRhFKaWOnxzVoEKDYFr2gSp+vqD005gdTly6tnSWXmS+TPNzDLJpAVLEGkXk49oj5SogMpUev32P24ZtQDSNjKdtdG1XBLkCgaAR3x7HrCcFTDM6yOFfJY50pTCQVnqu14ccoIpF1YiD3+R7EnlIUIu8WWlL0q8RhYS+ScmY8kfBMTY+dtzt1PSqxt1gX1Jx8zAs+bvf6iKOEZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8Mh7fKEbubac9hvmPHQFTzWOnb/nlAsulFQsVEQPaw=;
 b=s8l4W4441FKzrE7eBhYsB81JptNveyILeWhG8KQ9GLPshT3vEnpjg6yP0rq1DL1icvCaYt4SGXVtMXtmANd9aVrlOxGY2FwBKAA1G6Pxt842x47N7OfQhZpIAd7TuNpDyX7A1uk8Wotm1u2uUp1t/MuIyHexpdfkLwEqdWRXRIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 05:56:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 05:56:13 +0000
Message-ID: <60ba1e38-d196-6b38-7c34-cd94daf50f81@amd.com>
Date:   Wed, 4 Jan 2023 23:56:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v9 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Cc:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-4-perry.yuan@amd.com>
 <700d3351-1a52-5362-d22d-9326ad1220e5@amd.com>
 <DM4PR12MB5278F31C41AA3DFD5569FEB89CFA9@DM4PR12MB5278.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <DM4PR12MB5278F31C41AA3DFD5569FEB89CFA9@DM4PR12MB5278.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0010.namprd05.prod.outlook.com
 (2603:10b6:803:40::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: e769441f-737c-491b-e800-08daeee18d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wciwTVm+Wm9EX1e/QrEONPFVJQljsmYTylx3Ova0+pA4mtkz+38h1BJ2qnVtXWoSbqOONr4TMN7EhkB8EJapegqY+7bLUF/ErwRhyk1jl+RVHmuzflTQLSpntCQWbQN03NBfdqybTljucQTe/Gh+vaUZv7XCIQ4o5DIJJ0VIh3AVsbrVcF2Iqe69bNdCFuo2IOhEEgkY97s3gy+/O3hUBd7vwHRJLwUdEkS9dCehfde5PbfM73nmo1cL4T1KIXL/QgVc0CeIl6nuLkUkGyPr/3rhsZeDq+Db2Z/YQOp2wfU6Swa+LA2w6AlgA6gup6Rm1cutyYlmlQ8TH2gLsD/M4Sv/ptVmbJVA0yZwgBELxeZ0Mz2kUU+kCHIY9YjK7Qdjp3uWdHV+HfMp4rDLN/2CNj8RTsrzm7HA1t26FKXml5lwTCGe7ujA710Zyz3wIkwXhlBIVvDbytm3l/UObuPy84JNuwlQovVJIRWr/EChsQfbofN4MtZtrfD+88xn5t7F9ia4Ju8Nta0aN1BMxJ+qcKD/E02TctpZwXrZpFJDKTMePIsCfQ9oHRmjL9M6EEvcuGlI7Gu1aDMtsoSM5frLWu04214YUBELasM1KMTIjkTkY4tbcrMjurZTwvzPYlYprgDmbXGqnJt68X6ddeeCXUnny6ATNm3F1F9jqwbOi1/pZmQI2YKUNXvIQSL71GgqDr/cwD3P5hatNAWiN8njh95pPUnxowozpFqGH1XaoyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(31686004)(36756003)(66556008)(66476007)(8676002)(66946007)(2906002)(4326008)(44832011)(5660300002)(86362001)(31696002)(83380400001)(316002)(110136005)(54906003)(6486002)(38100700002)(478600001)(41300700001)(8936002)(2616005)(53546011)(6512007)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9wbmJyTUtSczZTSEJSd0p6QisyeFlkcTRxL1MvZ1oyRXgzMTlGYTVLc2xa?=
 =?utf-8?B?YkpON2dad3lPaXZuQVQwcUYvOENNZ3BhaS9jYjlqMmNEVXRjaCtHazg3d05r?=
 =?utf-8?B?SnBJM0ZIbHh2YUFSU1N5NXh2T0hwMmdyOG5FaFlaOFdrV3p3U3RER1AxWUJP?=
 =?utf-8?B?KzhESGJ2N2ZOc1VWVE5UYXYyREM4a1pUQjdSb2p5bnZML0Y5d1B3VXE3alJC?=
 =?utf-8?B?VER1cFoyYXpQVXhmRkppR0E5QUxHcWJaWTk2aktjQlc5blgrbUVISnJZYXdB?=
 =?utf-8?B?cGFLVE1vMW1VeitTZEtiRUNpZXNFRllKNmlCUm9rRTd6ZS8xZytpZnNvZlNy?=
 =?utf-8?B?Z0FKdms5L2RwMWdHNGF5UGExMlJpZEZ6L0FLSWNJeFpadVIwcXhoVHB4eWdQ?=
 =?utf-8?B?ZVl5WGh6eGFqTDF0SWlFVFBXNkJmR2FIY0UvWkJkdzBDVWh4Sy81aHNncWdP?=
 =?utf-8?B?ZklKOExULzN5bnBYWGtJdk5sQVlPVXVkWHNvQlVia3FwWFg0NEc1SGtzQys1?=
 =?utf-8?B?OCtSMXVHc1FVNEJsY3ZwVEhqY1IwZTNWdktoc3dqMDJpQ2w3dDdYOU9MWEgz?=
 =?utf-8?B?RU9EQUZHNTlJdEdXN243NGFYa0ViOEdlMTgxeTk4eEpVSVpaK3dlMTFQRStq?=
 =?utf-8?B?Q0VRY09iL1lQa2YvWmlxdUd3cHNMSjZvNGZKeDFBTnBWS0YwR0FBS0hSZnk0?=
 =?utf-8?B?OGJRWk5VdHYxM1BLd2o5ZmQ1NzZiZ2JaVUJMaVJmd0Z6NDJjd2pvWDR6djNU?=
 =?utf-8?B?RVlwK3Nxbm9aYUZnVS8vWmI3SGhCNk1GTDFwSHQ0RWJ4eHgzUU42MUpMdUps?=
 =?utf-8?B?NjBVSnJXUFZPaDhaelREMDFRM0tEUFFHeW1KTnBBTmJDQjhwWFJrRzZHS29U?=
 =?utf-8?B?SENQM0lIaDBSejJOMjRwY1dtNTVwaGdJcVZkOERBWTd3YkxscnlhVnZmVFRj?=
 =?utf-8?B?U3dObmN1Y0cra2Z4M1Q1OHRyRDhOdElvZXZFNXNPcG45R1I3TTlEbGJHRDJK?=
 =?utf-8?B?bUxJcit2Y29BSVRZTW1qMUQzODgyK2RQdXFCUFJWRFZaTU1qOTRBNUVQSmZz?=
 =?utf-8?B?TkpyQmZacUtIRytiTGoxTU1TM3Zja1RPc1Q1UXpVUHdZcEZxODUrQW5PY1Q5?=
 =?utf-8?B?cUpoRW1nVWJTczZZUzJsLzRmOFdqN2JJYlFjRmFIa05INjdTTHd3a1h0WWJx?=
 =?utf-8?B?dWJIZkJyZGtVNDIwQzZibDBzTTltckM5bU5SVnEvdG1xMDNVUk9XcVppRGcr?=
 =?utf-8?B?cXBQeXU4dXllU2d6SnpJejYyd1NRRk9hVXNDMjZvcDNXMWZBazdGRjNsN2ln?=
 =?utf-8?B?SDEvczQ2S3RSS0phaDVQckdTckNURlV5ZTZXL0pWVzJkMmJiVm50Qk1paVlI?=
 =?utf-8?B?VjY3MWUvWVU1cHA5d0Z6bmRIMk5kM0tuWWZaZDlldUFiOXlLdU1STjBMdjE1?=
 =?utf-8?B?T1RnRGNUajRSNXM5V0xvdURQazUwejhzQ2JISXdJY0xsQ1RzOXVBck9yelR4?=
 =?utf-8?B?OUE3cFhWU1FTYmNEaTRrc1J2NDg1eGVTdU5DRUV5ZHVQaEdvV05sWGY5TmtQ?=
 =?utf-8?B?dExUWG8wVFoxaEkzK1pQRjZwUUdmUGFLalVVRGRxcG5PK2kvR0ZrUUlVbGxL?=
 =?utf-8?B?N1QrQkt4eVB4YktxZnY2TDhFdGxoTjcxaVZGUS90ZCs2ZWxKTE1HTTBiMG9Z?=
 =?utf-8?B?TFBOSnRHZGM4UGxWb01YZDQxelBuVnJEMy9pMUtmZmNpcE5idFFKWUdPcUts?=
 =?utf-8?B?WFRZQk5jblBIaDZzcHlkbEZmc0RxcWNvRUpKREt2aVRydHFDa1pOTGZwRUEx?=
 =?utf-8?B?MzVvNnBVUlp1VkRWdTAzOEZhaGh2M1ZNbEFyME9GNmJ3a05hSWNIRVF5VUNB?=
 =?utf-8?B?Qk5iZm9kNzhwRUF2ZmJMamJiQVpwMjVWczZ0ZFVKSG1CYWZZc1BkMkxXK3FQ?=
 =?utf-8?B?U0M4ZFRwdkN4Z0RZN2dUak9tMVR2MERqVWxCRnJ4MFVJVFBqcHBqaDV6N0Vs?=
 =?utf-8?B?VU80bko4NFJsNFA4M2h0ZVEwUnI0SEw2NVNOMDhkSEFwV01iVThma056MkJZ?=
 =?utf-8?B?T1o2c1lkcmxUYU8ycDFFSFNPT0dUNnpDNDNHNmVhTXhwSS9ETTkwSG9oL3RO?=
 =?utf-8?B?RDcrQ0Z6Sk5UKzA3L2JVRUpuMDU2OWVEU1pnR2xUQ0RpSm8wZHlITHNmeGU2?=
 =?utf-8?Q?JOXGE+XY60LODghiwVRBCDjvkvv4XjanAT4QuSH+VqzL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e769441f-737c-491b-e800-08daeee18d40
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 05:56:13.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7vVlNpDipASK3ROryqx3TUQ+7keWTboDC1LaDDSuUNjs4B5EVCdb4CjSSwYgMJ/b7/IVuZ5l9DcyIPxJDgvDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 23:49, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
> Hi Mario
> 
>> -----Original Message-----
>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Sent: Wednesday, January 4, 2023 8:31 AM
>> To: Yuan, Perry <Perry.Yuan@amd.com>; rafael.j.wysocki@intel.com; Huang,
>> Ray <Ray.Huang@amd.com>; viresh.kumar@linaro.org
>> Cc: Sharma, Deepak <Deepak.Sharma@amd.com>; Fontenot, Nathan
>> <Nathan.Fontenot@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Huang, Shimmer
>> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
>> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
>> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v9 03/13] cpufreq: intel_pstate: use common macro
>> definition for Energy Preference Performance(EPP)
>>
>> On 12/25/2022 10:34, Perry Yuan wrote:
>>> make the energy preference performance strings and profiles using one
>>> common header for intel_pstate driver, then the amd_pstate epp driver
>>> can use the common header as well. This will simpify the intel_pstate
>>> and amd_pstate driver.
>>>
>>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>>> ---
>>>    drivers/cpufreq/Kconfig.x86    |  2 +-
>>>    drivers/cpufreq/intel_pstate.c | 13 +++----------
>>>    include/linux/cpufreq.h        | 10 ++++++++++
>>>    3 files changed, 14 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
>>> index 00476e94db90..f64aef1e093d 100644
>>> --- a/drivers/cpufreq/Kconfig.x86
>>> +++ b/drivers/cpufreq/Kconfig.x86
>>> @@ -36,7 +36,7 @@ config X86_PCC_CPUFREQ
>>>
>>>    config X86_AMD_PSTATE
>>>    	bool "AMD Processor P-State driver"
>>> -	depends on X86 && ACPI
>>> +	depends on X86 && ACPI && X86_INTEL_PSTATE
>>
>> This doesn't seem right to me.  What if someone didn't compile in Intel
>> x86 support for their kernel?  They wouldn't be able to pick
>> X86_AMD_PSTATE.
> 
> How about changed like this ? when amd pstate enabled, it will build intel-pstate.c as well.
> 
>     depends on X86 && ACPI
> + select X86_INTEL_PSTATE

I still don't think that's the right way to do this.  Why not move the 
variables to the cppc library file?  Both intel and amd pstate drivers 
select it, so it can be a common place both wil use.


> 
> 
> 
>>
>>>    	select ACPI_PROCESSOR
>>>    	select ACPI_CPPC_LIB if X86_64
>>>    	select CPU_FREQ_GOV_SCHEDUTIL if SMP diff --git
>>> a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>>> index ad9be31753b6..93a60fdac0fc 100644
>>> --- a/drivers/cpufreq/intel_pstate.c
>>> +++ b/drivers/cpufreq/intel_pstate.c
>>> @@ -640,15 +640,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
>>>     *	4		power
>>>     */
>>>
>>> -enum energy_perf_value_index {
>>> -	EPP_INDEX_DEFAULT = 0,
>>> -	EPP_INDEX_PERFORMANCE,
>>> -	EPP_INDEX_BALANCE_PERFORMANCE,
>>> -	EPP_INDEX_BALANCE_POWERSAVE,
>>> -	EPP_INDEX_POWERSAVE,
>>> -};
>>> -
>>> -static const char * const energy_perf_strings[] = {
>>> +const char * const energy_perf_strings[] = {
>>>    	[EPP_INDEX_DEFAULT] = "default",
>>>    	[EPP_INDEX_PERFORMANCE] = "performance",
>>>    	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
>> @@ -656,7
>>> +648,8 @@ static const char * const energy_perf_strings[] = {
>>>    	[EPP_INDEX_POWERSAVE] = "power",
>>>    	NULL
>>>    };
>>> -static unsigned int epp_values[] = {
>>> +
>>> +unsigned int epp_values[] = {
>>>    	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
>>>    	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
>>>    	[EPP_INDEX_BALANCE_PERFORMANCE] =
>> HWP_EPP_BALANCE_PERFORMANCE, diff
>>> --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h index
>>> d5595d57f4e5..0693269fb775 100644
>>> --- a/include/linux/cpufreq.h
>>> +++ b/include/linux/cpufreq.h
>>> @@ -185,6 +185,16 @@ struct cpufreq_freqs {
>>>    	u8 flags;		/* flags of cpufreq_driver, see below. */
>>>    };
>>>
>>> +enum energy_perf_value_index {
>>> +	EPP_INDEX_DEFAULT = 0,
>>> +	EPP_INDEX_PERFORMANCE,
>>> +	EPP_INDEX_BALANCE_PERFORMANCE,
>>> +	EPP_INDEX_BALANCE_POWERSAVE,
>>> +	EPP_INDEX_POWERSAVE,
>>> +};
>>> +extern const char * const energy_perf_strings[]; extern unsigned int
>>> +epp_values[];
>>> +
>>>    /* Only for ACPI */
>>>    #define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
>>>    #define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed
>> coordination */
>>
>> I think the right place for these variables and strings is in the cppc library
>> source file that is common across CPPC implementations.

