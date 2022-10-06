Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FFF5F654E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJFLjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJFLjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:39:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021235282D;
        Thu,  6 Oct 2022 04:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh1c8mVVfZIqQBn0ay9K/M4wuUOISySWW00WQ2uWN4hiWW5nu72fTf4nHoGIKxQRuA3UE2o1ia5c7vPDnVVSEaNWv0u9Ug7sSGx5gQ4kuU5we/Ikr8pB+BKwZgwFt5i/cz7Lv2HY3oHO18i7vzZ1EXpIOUybsuEOLWfkRH8xQo0ArSRJKHlJn26JzGzwum8emIrZFDcRp4tqY/2oj8IUt43mhSBbE93WG+pplg9MAzdBzaqq3x+mqbxOl8zQ5F4bYMLBAMc9ivDvnruwghXCMLK6rbbW2hxqnrGtAVbkdSf0KHXF85klMD/DOv+BHlnKbzwDgDMO/CYntbQFGSqL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZshY31Iph5Qx0IKrBiw6q4mQ12pgXyDG0nzGC9UEKnY=;
 b=bMPt0Ikguz4HEGCx7xj2IRKlNM35R/9GbkJ5tm3YoYlDIuDh/fLqzOiswZsY7aDlhMBE37OCeKhzFRb9CfuPTV2YfJOUXnqvxL/BplKRchC5q78e3Vc5IJ8FQTDNod3CsTbk8wko5CyzVANrGiXUBznsjJpVMJhIIEmm4qcrh8oKz2uPjJ9qX+FG89IPFhU079pcdaXa15FgresbAGljSzkXuw90XNMdR8uKeFRjWTFnJ9q5uq3jsVAdREChhcGFQe90AWEiiNwlbdKZX/YauxLgUb1LYoUPZAKxpO3/86gpJiQDqxtFyz4o4H05QS10pBe0+Xvq2HesMJuqWPVZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZshY31Iph5Qx0IKrBiw6q4mQ12pgXyDG0nzGC9UEKnY=;
 b=nUusy2SBp/qtBS3OkLOx4/xpAEo/vYhMP8biF8SCdaSeL9DxIx0LnfkoCG1X7oTHrgmlRPi8plvkjKBVulgiO9i0dw+O2RejXSj3Mbcb+t78atrZ1hs0PgY9+QEJ4KjGsYyuoud75rE89/GCtX0bv7LWeStq/cy72h60kpQtgj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 6 Oct
 2022 11:39:14 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::4a1c:7d22:b1b:1adc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::4a1c:7d22:b1b:1adc%6]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 11:39:14 +0000
Message-ID: <585535bf-47d0-178c-706a-3d71bfc31f68@amd.com>
Date:   Thu, 6 Oct 2022 17:08:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 01/15] perf/mem: Introduce
 PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
        acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        irogers@google.com, jmario@redhat.com, leo.yan@linaro.org,
        alisaidi@amazon.com, ak@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, kajoljain <kjain@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-2-ravi.bangoria@amd.com>
 <bf4ec1cb-49a4-f5cd-8fd0-c70b287180c0@linux.ibm.com>
 <a36ffee0-b0d5-5941-8d98-cc8e9b100a50@amd.com>
 <88c920de-5af6-c7b0-d6a8-6c365491dd3e@linux.intel.com>
 <f6268268-b4e9-9ed6-0453-65792644d953@amd.com>
 <d428b526-a592-2ea5-dad8-d6eae72eb118@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <d428b526-a592-2ea5-dad8-d6eae72eb118@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::33) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 902a00ed-0365-44bb-eb7d-08daa78f64e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+621cf9OEfXQZme+j1Xftl5iZ28KHSCnVTVngR93PNarZvzQ+vcfnIDsQ88OWqfU3l0yxnTJ4FC7J3O0YV4rC74NaPqtNX0alodMVDFnCEP7VCdC7dfHdRjrK8owZ5+xRxNlnuZeMoLb9VaPPC1OWmIoyRaXjWLDUArFpL9SIG1adU6Ujz13znRFtxVJUK7zFrVkgd5y7HpnM2XLkoIbz0nJ7Lf8x55gBtEEsEp2WFQg0qCUo+vo086wz7QplLwDACL69yzzvDyjKOkFNLMvUAMpQYxV0/EBYY99xJXVaJIkZ22T18r3+5QNOVGazAVKihuqgGIS92GonBlUD7Ewi/qW4g9hBilsW1FIokaFrZ7rgvF4eGLR3HFW6rnlNVwwztCSPQ73CFiPeJIB1TzGYzBymcEpXzi4XIOOz4ihVFR19AhjoAEaaSfcGs+unyTWihhhpbDgV+rjleBaRTT+TiALOoGaXA/XelvVNTwEMVJCSEbYVbE6hQsfqYk1GG+9xcPB8UwHmpXH4oKsRpsFWbIWHzCyGJw+4JyPVfl5hhtlDtFf8Srjg9alXJdid/Id10wTl0L83lgE67pl7crhM2GOq6lhVmzDOvoJVAf/zQMuGMtb4wibYQtiD12cO75HpPhyB+TwIK9hzOu7bmeWQqCeYc2l2YSn5a8bMygJ2iW9IEcgQH9OIyV3NtxQMkcs+OC8MG/kobd4Tbukkd6eB46cy11DpF+vZTZOxH1v8LLHeYmPQ+bj2+Y6YJ0EyCyV+B6BFRhpeybiH2cXP+/anKMKa1liNtAs+aMeHM4qMvE3Z8lkahUlB4Gm4kb0TZ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(36756003)(31686004)(38100700002)(7416002)(8936002)(2906002)(5660300002)(2616005)(83380400001)(31696002)(186003)(6512007)(53546011)(6506007)(478600001)(6486002)(26005)(6666004)(54906003)(66946007)(316002)(41300700001)(86362001)(44832011)(8676002)(4326008)(66476007)(66556008)(83133001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNyd2xUT0pweTkweG9La2RmQ20vR3ZMWEJpNU9HTVpmd0liTy9BQ05ZaGk1?=
 =?utf-8?B?RG9aVlpXWU9NdGxtR1cvalJpQVZGMThOM3l3NzdzOW9weVp0d0V4K2xTZ3Rh?=
 =?utf-8?B?blZxc2xCMkZISVBDUUtnMGZRV1dFbGNIKzhMMlBCSlFIMGFZQVNHaW9xK1FM?=
 =?utf-8?B?TGxvSUVxd3VIWTdsLzBVTmp4bEVlQ3hzMkVzT3V6VkdxeHhnRUVoV0FzbVBt?=
 =?utf-8?B?ZzZ2VXB5ekdLWnZ0TzNvMXBxTk9FSDVLZzZQMGtGTnBPU2pzQ0o3N0RmbEg2?=
 =?utf-8?B?emVzeXc1SklBYjdpaFRDemVMc1M2Zm1aN0JkMkVRRWNGUjZtcjBiOTZwR0lW?=
 =?utf-8?B?aWxhU293N0k4dVRYN0ZQRWVkejN5cEg0azJ5a2cvYi9xZ3RmZ1RpY0F3MTNy?=
 =?utf-8?B?bEdENng2VkhRSFR5REdFMGx5SHJPbUF1T0NoemtpbE1Dc21TdUh0TDUvM0dx?=
 =?utf-8?B?MmR1NW1Xckpqb1YwbnMyaHBDZjh5Wm1qN3ovQWJFdDUzdFNJT1FSY0UzbEp5?=
 =?utf-8?B?Rk41YWkxTnFleXR3YjQ0Z1Q4dDFTM0JJaXJmUFdyUTdBKzRaNFBlKzZuZXlR?=
 =?utf-8?B?RmJiVVVQZHJkanZ5Mmp5ajB5OEFaVTNsWXZyY3BabUZVcXAzTFJNQUlqdVB2?=
 =?utf-8?B?bUUvYVVaYzgyUHlyeEh0d2hRdFFPdEwzMzVMdnVDYU1Zb1dRbDNjM2grR1dO?=
 =?utf-8?B?S0dOVlA1enJYdkUyNERtOFhVZkdtVkRyWkovdlp3UDJRem9iQkZzTDdrSUR0?=
 =?utf-8?B?VzNveWg5VitKdVVpZzdybk43Q29PRVFRaVRrU0VjSTVCVGliRjFGMThkWlJr?=
 =?utf-8?B?OVdWb0xZd1plTkN3MTN6QjMxN0FGY21nYmRwNm5FQS9iMVJEVmZlN2xpd3gw?=
 =?utf-8?B?M3dxR1dEcVhicXB3eGRWZDVXVVNEU3YycFZxQy96RHEzZWZqWVFpeHpnL2V6?=
 =?utf-8?B?TlIrL3JkbjdpSHNrcDNJbG83bWE0bnRUVnA4ZEt0OFY3V0d2WXl0bjFaZ0x3?=
 =?utf-8?B?bXQvWGFBaUM3UmVsVllsTWlaVDR6U2t3a2JUVEphU1dTRXJHb21XQ0VSL09r?=
 =?utf-8?B?eXAzU3VTLzZla0M3OEM0eFI0eDhUTU8xNGdKNlBSYWladC82U054UDNIQzhv?=
 =?utf-8?B?T2QrY3ZoSExXRFI2cUpZZlVDTkh6RHpwbk5aM0xhNmZGRXBNOVJweUwvdDlw?=
 =?utf-8?B?K2tSKytZN09pZEhRKzBHd1B6U3MzTmJsWkR1L2VyM09aZDRIVkJua1hQdHRL?=
 =?utf-8?B?aXN4MEtGRHdpcXB4cDQzMnZkWUFtVjc5MFRRYklNVGlTUnZkVkJLeGJjdlF4?=
 =?utf-8?B?cWs1ZnBCMFo0eVpuRTdSSHlnS2Y1RS80eWYvNFY0dll1bWNHNjhMcHhrNnhk?=
 =?utf-8?B?a2NPQ3l1SzI2cktKZkR4YzlRTDg1N1dCS2ZVdEhTQlRDVEROcWdnN3paVnY1?=
 =?utf-8?B?eFJvWW8xMnhtaHQ4dEFvS3JjWjl1UkcxMkFGWE1UMzlrUlAzckJSWVpLQkhl?=
 =?utf-8?B?YUdBQWVlYmFtL2hZVncyYjlvZ0E1RERObEQ4bVdkb08vZ0hBNmZzemNod1Vo?=
 =?utf-8?B?UHQxL2FnL2V4S2tQczVMLzkrN1pPOFduOTg0UVc0L3QyV2lvWWYrU01PK3Bm?=
 =?utf-8?B?UjVwMk9DSW9xZXU0dG9WOS9VbGg5aHBZU0JhNjBZTFcxWlZSNWRUSzZrRFds?=
 =?utf-8?B?VFhGRHpIOUpiWEpXaFM1Y3FGVmtJdnhROEZoMlVHMXhoemw0RCt0QmNJQlRh?=
 =?utf-8?B?VFZRMEtYVm1UTTFCZG5OQzlmTDhzREtQbG1KWm41SlNSbldKVEljNndaTGsy?=
 =?utf-8?B?bXZpOEhFUWdnMkpwaERqZzM5SmNtUitrZFA0S0p1V253Wi9oc1EzRDNwQ1Ro?=
 =?utf-8?B?d0FZcmNVUFFqV3dsWlczNWNGMHREbkJSdlFpZ3NQSUhzOVRtakNxM2g4Sitq?=
 =?utf-8?B?WDBHc3JjV3d3ZUhBaHQzSjBYUTVIUU1jaUNxaUJRdDFMRGZ2d2E5RlRaTWx4?=
 =?utf-8?B?QzNIRW1NMHltVE5Pd29JTnIraFJ3b1FnWXQ0U3lIemJtM0c5TVkzSWJjRStL?=
 =?utf-8?B?M09tWjZURXRVTmprV2RJTG5udG9KUGtURHBYOFhZdUwrN3RRd0o2SE5vZ2s3?=
 =?utf-8?Q?zfdsZ89UZqs3H9Jm8A3ZmoG+7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902a00ed-0365-44bb-eb7d-08daa78f64e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 11:39:14.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Sq8Bgvfs65ACxdS23Obl4tnO6gD3ER60vYf7SVvKgVXHsnshgvLPQzri2kWVRVga/FIea633DyJAQKhKKFM+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Oct-22 6:45 PM, Liang, Kan wrote:
> 
> 
> On 2022-10-01 2:37 a.m., Ravi Bangoria wrote:
>> On 30-Sep-22 7:47 PM, Liang, Kan wrote:
>>>
>>>
>>> On 2022-09-30 8:50 a.m., Ravi Bangoria wrote:
>>>> On 30-Sep-22 4:18 PM, kajoljain wrote:
>>>>>
>>>>>
>>>>> On 9/28/22 15:27, Ravi Bangoria wrote:
>>>>>> PERF_MEM_LVLNUM_EXTN_MEM which can be used to indicate accesses to
>>>>>> extension memory like CXL etc. PERF_MEM_LVL_IO can be used for IO
>>>>>> accesses but it can not distinguish between local and remote IO.
>>>>>> Introduce new field PERF_MEM_LVLNUM_IO which can be clubbed with
>>>>>> PERF_MEM_REMOTE_REMOTE to indicate Remote IO accesses.
>>>>>>
>>>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>>>>> ---
>>>>>>  include/uapi/linux/perf_event.h | 4 +++-
>>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>>>>>> index e639c74cf5fb..4ae3c249f675 100644
>>>>>> --- a/include/uapi/linux/perf_event.h
>>>>>> +++ b/include/uapi/linux/perf_event.h
>>>>>> @@ -1336,7 +1336,9 @@ union perf_mem_data_src {
>>>>>>  #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
>>>>>>  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
>>>>>>  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
>>>>>> -/* 5-0xa available */
>>>>>> +/* 5-0x8 available */
>>>>>> +#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
>>>>>
>>>>> Hi Ravi,
>>>>>     Here we are adding entry explicitly for accesses to Extension memory
>>>>> like CXL. In future if we want to extend it for cache or other accesses
>>>>> , we again need to add new entries.
>>>>> Can we rather add single entry say PERF_MEM_LVLNUM_EXTN and further can
>>>>> use reserved bits to specify memory/cache?
>>>>
>>>> Is everybody okay with this:
>>>>
>>>> #define PERF_MEM_LVLNUM_EXTN	0x09 /* CXL */
>>>
>>> I think a generic name, PERF_MEM_LVLNUM_EXTN, only make sense, when it
>>> wants to include all the types of the Extension memory, e.g., CXL, PMEM,
>>> HBM, etc. Then we can set this bit and the corresponding CXL bits to
>>> understand the real source. Is it the case here?
>>>
>>> But if it's only for the CXL, I think it's better to use a dedicated
>>> name, PERF_MEM_LVLNUM_CXL. (as we did for PMEM, PERF_MEM_LVLNUM_PMEM).
>>> If so, I don't think we need the PERF_MEM_EXTN_CXL_ANY.
>>
>> Ok. For now, I think below is good enough? Later we can introduce new
>> variable to provide type of cxl device.
>>
>>
>> From 5deb2055e2b5b0a61403f2d5f4e5a784b14a65e3 Mon Sep 17 00:00:00 2001
>> From: Ravi Bangoria <ravi.bangoria@amd.com>
>> Date: Sat, 1 Oct 2022 11:37:05 +0530
>> Subject: [PATCH] perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to
>>  PERF_MEM_LVLNUM_CXL
>>
>> PERF_MEM_LVLNUM_EXTN_MEM was introduced to cover CXL devices but it's
>> bit ambiguous name and also not generic enough to cover cxl.cache and
>> cxl.io devices. Rename it to PERF_MEM_LVLNUM_CXL to be more specific.
> 
> Looks good to me.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks Kan.

Peter, can you please include this patch along with the series?

Arnaldo, I'll respin tool side of patches with this change.

Thanks,
Ravi
