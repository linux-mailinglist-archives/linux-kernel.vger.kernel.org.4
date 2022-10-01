Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89315F1A53
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJAGiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJAGiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:38:04 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D5163A17;
        Fri, 30 Sep 2022 23:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhDSafHeaA0qC73i1nbo8rx1v3Vpt+qrz94QVgmI9sq8KByiEOjRdvVlagSNQpirRQtt2jJHsWYw5oSuOCp/K135hcN4EFXz0Ji3H5SRs3402zJ+tQ9MCD6xQV9s4x7d6cI02j0c+acVLFVMsLHKcwI2JhjWdlBWI8Xxpftw2Tw6Uv0vtBTBZSn084i3F0wqKMut3HnHMq2BLNO0ImdtS/LZR0rQ4DjGVhIneA9EFvwQmXbPe1lGfdGBHMXkNpiYPJEYsMcsehKbVFpxg5lmZkCM8h3bbqWwr39vi3dU8QXRvMFEG/GUemkOUOI5nUZJ1sElxo/3DWqTWENWknaSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vig2o6n3TTCzYaBatHOXet1ZQ3dKPrZKH7EPzFfbsbY=;
 b=WzwaMzc7wvaxoZnm/IGZN945fj7qZMAJTt3mOETbgCP6Ttu6cAbbVcOdSVG9hUVUgue7v9s6H/x9vlh9OPAYky1NWhJevnFVQe321CMrE0LOvjNqu8zrxLYTgrlUCHfK3OYjHenMrxElkl3vhkZ+Tvza6nj7FlA4PhoyAJxSGrgqSmXZybGJvsCaZcygkyGwEE2r4ljxIdbasbaoalL4/sdHyaG/qd4SfqzRPtmLDEHTF6f4XNAi8duekGAcRRVCuVpZNJv64LBPiO5PpJrM6cii+tkkdoaXvbs5MVPMYGwH9MkAzQqB1W2z6jYPyT4/tRSD2Xrvh51ANxvqN2peTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vig2o6n3TTCzYaBatHOXet1ZQ3dKPrZKH7EPzFfbsbY=;
 b=nlKKzSnxYzL9gV37NX1YPYYxhtm7nfD208aGlZkvDJl2MI9Zideo/xqoaE9fOT5EucUw+CfXnlhEE1ohFx40zIRnacfKN0Qnp+L7XIDjxliqu1UgrUu7QYop8toD2ZGPAy7gMQOpzPc0drSmut7jOS3KZQknXTyoEi+fs6RKMtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Sat, 1 Oct
 2022 06:37:57 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::2eac:da0d:9d7c:e20e]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::2eac:da0d:9d7c:e20e%7]) with mapi id 15.20.5676.023; Sat, 1 Oct 2022
 06:37:57 +0000
Message-ID: <f6268268-b4e9-9ed6-0453-65792644d953@amd.com>
Date:   Sat, 1 Oct 2022 12:07:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 01/15] perf/mem: Introduce
 PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        kajoljain <kjain@linux.ibm.com>, peterz@infradead.org,
        acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        irogers@google.com, jmario@redhat.com, leo.yan@linaro.org,
        alisaidi@amazon.com, ak@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-2-ravi.bangoria@amd.com>
 <bf4ec1cb-49a4-f5cd-8fd0-c70b287180c0@linux.ibm.com>
 <a36ffee0-b0d5-5941-8d98-cc8e9b100a50@amd.com>
 <88c920de-5af6-c7b0-d6a8-6c365491dd3e@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <88c920de-5af6-c7b0-d6a8-6c365491dd3e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::22) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e28dea7-95c5-4347-dc69-08daa3777a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuHMZ0PjpFLM8bZUy2cjH/oJW99Tbwf/Zs0rhiOkoOXy0/WftNtVQuQZUj5J2ywx20rnBjPWnYInOUxp3emWURDN9kruL26Z7ZvZANWiuqtXKc7lxG6aas18n0gxld1Lw1pqGfXxVRq6yyQiNZgengBw8mPj0qO6ylxxpywXBZozH/UWSb//EAukWkwi7jiUrxMR52h+VCwkdBUxlHrjm8Fo8et2aWdGZ9E6qYuWkN5O+OiPIrkfOrIIJLSg+jpMIFFf3bc6lny68eDtYREPfjKiz5j7nnV3gpEMErc1Mf5tP4fA1vqfSKlwyAEvgmZ0FynmyOGP57L3WWbiQDmgOtIBOcdFQzHtXGvO4mxL5DgiyvATJlTE6QHPZHIo1ARFoPimdk45wTFmIH9zGqEGmrVWKC6OQ6QF0t0UjErY0Q1/XcyFObFtfyT62tGLr45j4zZguw2HidEEjzYOkK2yeoSL0e3lcM4fWrLOa4j3WY9V/LExFTdWq76cD3HpgFwdhnNF2ixN5FYjMKxvFJKzC6ncpC8u2t9wjob/pdFeaMXwJOVU5ofvCIAXJAiERtmrPhH94Xf6QzqWYoziugyXe8Xc6ocWEpzsqvcDwgodC4ni8QUbeSXLa4ZlTiVEiXKCPnXRnNOb4giNxsbwuc6d+loYEK2TeeGmdTNkxQVMhLWgiwwkJDzV4pMFZX2fJJddOzeeB2Yvh4jXa8SyCAQJfw/zuqViZiGH8c1WjRgkm2fBnYdNxdj13Mc7nJwvx92KaXwflHaiTWU57kw18sG9UcbEK97dCA8axp+bUjwkZ7roxopMnk+lD0op48eMbshk5bTWw+wxACKpf58GFRJoTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(36756003)(31686004)(41300700001)(6486002)(83380400001)(186003)(26005)(44832011)(6512007)(7416002)(2906002)(86362001)(31696002)(8936002)(38100700002)(5660300002)(8676002)(316002)(110136005)(6666004)(66476007)(6506007)(478600001)(66946007)(53546011)(66556008)(4326008)(2616005)(83133001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTA2TXJwSXppTnNLQ3FaVFRkQzFlMmJNMGtYcjhHTmIvcGdZSW9kS3pYUHNs?=
 =?utf-8?B?ZG5NTjBIdkp4WWRlVTB2aTh2SzNjaDhjVlFDQy84bHdXZGVINXpPOHlBc3JZ?=
 =?utf-8?B?V3JZTXFZbW5ibCs4UUV3RUpJeVlRSWNPSWt1aWdMS1RibElzNDIrNzRGL2F1?=
 =?utf-8?B?UzdHTmhwOVNWbnRta0NWKzladGxrWk9YY0g3VFYrcDRmbzZCTXdZMTZSenZK?=
 =?utf-8?B?RmVBUXlDQkN4WUJKYlF1TFpLS0VldDVKcE9Ic3hIWWU1Z1VnOFhHbFRjM0VF?=
 =?utf-8?B?QnZ6UzAwdHJxMjgzclhVSkpiQmlFdTlBWnhYeUZ4MFZxMEU5QlhkbWplOU43?=
 =?utf-8?B?T2M5dlpJNnI3Zi9JbGFjaldVOTJhTk9qV0VLdDRUcWpraFVTcTdxSEl5ZDVI?=
 =?utf-8?B?TXluRzVidEY4OW9KWUpjSVZvYVZIczhsdzZHTVRQam1oakYzSEw3L21hUUVj?=
 =?utf-8?B?SWtoNlRuaTJ1RUNZbXZxV24rakd0RVZjVXdaVlprWnRPVnN6QS9JTlE3NTRI?=
 =?utf-8?B?TCtyM2VmVnBnZVJuSUxROTdobSt6T2E2ZWdHd1NQQnF1SWxpQ2l6a0hnTFZX?=
 =?utf-8?B?ZlZrdGgySGxRcjBSNWMwZ01Ia3JzenpDSUl6SC9OYVF5N2N5ZVRmVStJOVRs?=
 =?utf-8?B?SFJmWVJZUndnSHlkYzF6ekFjQkxGc0NMNWt0Q0Z2QW5ocEZoeWs1aURyOTdl?=
 =?utf-8?B?cHhucTRaMlQ0SUlnRWJwNmlwRXp2Y0dDaG9iakp1bys0YWw4K1ZHR3NuZUEr?=
 =?utf-8?B?WVBwZWFaUWU3aHhZcGpycjFFY1ZjQWpWeWZMSXBEai81L01BRjdIK3hSOCtK?=
 =?utf-8?B?ZUNjUDM1dGpNaWswTXUyT1kzZ3JvQ0c4VWpQcnBDSzRkamxiSlBibnUzN1BJ?=
 =?utf-8?B?b3Znb2I4czd3YmZWS0xRYnRDSWEyWTk0SkxOU2pydmlvc2JpcFBiTnl5czdN?=
 =?utf-8?B?VFFEdHNxSzEwbVg3eW0vVGRNVXZnSHg3UXhYU1dKQTZPeS9FU1RrVGlUb0NR?=
 =?utf-8?B?TEJBWHA0TlU1bFhRWEhOWXc4VWVDL25uYmtWcXFZd3lsckhxaE5Beld2c3N5?=
 =?utf-8?B?YXZGUStWNGkwcUtMOXJTMDN3WFNOSUd3UkhOMndmT3VIYnUyOHN3aUJxUlJn?=
 =?utf-8?B?cFVvWXBjWmlPemR3V295RkNOYjdleUlFaitoUnQxVlc2b1hydlU0TkFKTE1R?=
 =?utf-8?B?WUFzUy9pNWl5eml3dTF1N3dIT3dBY1FIUDVPLzFJN2pXU3RkZEQvaVB6VlEy?=
 =?utf-8?B?RjFOT2dDRitwdmFUZHkrMHYrRzRKVU10eC9kbVZaTHZsOURzRHpXYkpmNkpX?=
 =?utf-8?B?NG1vUHpHZDJHa0RFdEs4a2dYRWRicFh5Z0NyNHF2aUNXOGlLVC9ENWRFemhw?=
 =?utf-8?B?R284enEyeTdzc0c2REwrUVNFazY0a1pCeXZQaGJtZ0c4c2FETVoyZDlvNlFq?=
 =?utf-8?B?aWY3ZmFDbyt5cWN0Rm4rRnV5R05IS1MycklPNlNCalo3U0hSOTR2M3NwQXZC?=
 =?utf-8?B?cVdwQzZ6ZUVkajVud2V4S3EwSTVmN3dJWVNUajhEZ3dRNFRkbFNFbHcxcnlJ?=
 =?utf-8?B?RE44SnZLbXBoVmtJalYvRTFDdzVlSEpPdnNtbkFCWEFEYm1xZk5CeThhbDFL?=
 =?utf-8?B?NUFyQzJ6V1FHNGdMVXl1OEFQQzlrQkZvZFQ2OSszTVBOOThGUnd2M2hqNVht?=
 =?utf-8?B?c0ROOXJDTThlVUx5ZEtnQTZLSzdTSnBFT1lRbHhYdFY2Q2t1enBWMlFaVEIr?=
 =?utf-8?B?WVcwZEFMc0JQa0tQbUx6cXNkWWptWmIwVmJKTHc4SU93VjFjZGpxd0N2Ujlu?=
 =?utf-8?B?dEVaQnpLbi9QWXhETzZSTWpaUkVnL3I0UEpFNzd3dG4rdm16VG5JcHZFeEIw?=
 =?utf-8?B?V2wzMCtVMW04K0czK2RzYlkxYzJiOWRwM1Vkclo4eDNjT1BSdFRFNmJuaTN0?=
 =?utf-8?B?NHFMWnEwdE40Q2Q0SXpxT3lHVlJPSEliTENpcmxBNDNuNDJRcjd4b3U1Z2ha?=
 =?utf-8?B?N2NGZTAwQzhidVE4YXFWQVRXTmpCNVBRbm0ydDRkWVpOcTVIV3VRTEhTRFBE?=
 =?utf-8?B?Rno4UjBaS1NJQk1wZHFiVytaVDU4SFRZQWNhVDdlRHFiWEdHcm02UlJqKzhv?=
 =?utf-8?Q?Ck0DdnFnNcwi4AUI6ikHza8xc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e28dea7-95c5-4347-dc69-08daa3777a17
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 06:37:57.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rmtijSSgLC8WMe5+8TnSRunglbA7L8apmW4ETD4MtGve13fijCsmhV50/f5tsvb8LbkP6J+d3DPi+AwvjNz4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Sep-22 7:47 PM, Liang, Kan wrote:
> 
> 
> On 2022-09-30 8:50 a.m., Ravi Bangoria wrote:
>> On 30-Sep-22 4:18 PM, kajoljain wrote:
>>>
>>>
>>> On 9/28/22 15:27, Ravi Bangoria wrote:
>>>> PERF_MEM_LVLNUM_EXTN_MEM which can be used to indicate accesses to
>>>> extension memory like CXL etc. PERF_MEM_LVL_IO can be used for IO
>>>> accesses but it can not distinguish between local and remote IO.
>>>> Introduce new field PERF_MEM_LVLNUM_IO which can be clubbed with
>>>> PERF_MEM_REMOTE_REMOTE to indicate Remote IO accesses.
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>>> ---
>>>>  include/uapi/linux/perf_event.h | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>>>> index e639c74cf5fb..4ae3c249f675 100644
>>>> --- a/include/uapi/linux/perf_event.h
>>>> +++ b/include/uapi/linux/perf_event.h
>>>> @@ -1336,7 +1336,9 @@ union perf_mem_data_src {
>>>>  #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
>>>>  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
>>>>  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
>>>> -/* 5-0xa available */
>>>> +/* 5-0x8 available */
>>>> +#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
>>>
>>> Hi Ravi,
>>>     Here we are adding entry explicitly for accesses to Extension memory
>>> like CXL. In future if we want to extend it for cache or other accesses
>>> , we again need to add new entries.
>>> Can we rather add single entry say PERF_MEM_LVLNUM_EXTN and further can
>>> use reserved bits to specify memory/cache?
>>
>> Is everybody okay with this:
>>
>> #define PERF_MEM_LVLNUM_EXTN	0x09 /* CXL */
> 
> I think a generic name, PERF_MEM_LVLNUM_EXTN, only make sense, when it
> wants to include all the types of the Extension memory, e.g., CXL, PMEM,
> HBM, etc. Then we can set this bit and the corresponding CXL bits to
> understand the real source. Is it the case here?
> 
> But if it's only for the CXL, I think it's better to use a dedicated
> name, PERF_MEM_LVLNUM_CXL. (as we did for PMEM, PERF_MEM_LVLNUM_PMEM).
> If so, I don't think we need the PERF_MEM_EXTN_CXL_ANY.

Ok. For now, I think below is good enough? Later we can introduce new
variable to provide type of cxl device.


From 5deb2055e2b5b0a61403f2d5f4e5a784b14a65e3 Mon Sep 17 00:00:00 2001
From: Ravi Bangoria <ravi.bangoria@amd.com>
Date: Sat, 1 Oct 2022 11:37:05 +0530
Subject: [PATCH] perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to
 PERF_MEM_LVLNUM_CXL

PERF_MEM_LVLNUM_EXTN_MEM was introduced to cover CXL devices but it's
bit ambiguous name and also not generic enough to cover cxl.cache and
cxl.io devices. Rename it to PERF_MEM_LVLNUM_CXL to be more specific.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c       | 2 +-
 include/uapi/linux/perf_event.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3271735f0070..4cb710efbdd9 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -801,7 +801,7 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	/* Extension Memory */
 	if (ibs_caps & IBS_CAPS_ZEN4 &&
 	    ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_EXTN_MEM;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_CXL;
 		if (op_data2->rmt_node) {
 			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 			/* IBS doesn't provide Remote socket detail */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 85be78e0e7f6..eb1090604d53 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1337,7 +1337,7 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
 /* 5-0x8 available */
-#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
+#define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
 #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
-- 
2.31.1
