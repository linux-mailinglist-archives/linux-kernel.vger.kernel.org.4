Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033B95F0C07
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiI3MvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiI3Muj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:50:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69883DAF1B;
        Fri, 30 Sep 2022 05:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3K6HPpDOsu+Zkw4r78GAYIaWBPBd7IXeIaqocR6lJZ3AUN5EjCIXii1kgXznpRJKrMW0GW0ZdndcelKFEXvzLvQOGVbQfGsiIjBTyGDSuchRLVD7yHb+q54dOjbCGfY+fv1cemDs8lTi2bNin2W0so8uPc06JWn5xWajeBErXYqEHWejH9ecRC6TkqfGjJIruoE+pXOnMToAz77e5bgs5qRmQZaEhzl2hlRu40LyTNV61t6ym0rZoE5EU2JmcS11qsuVpdXgIzgm4ocH7dfwWyrsezo/q6ujWnjm0JXqqH2iX733PZuqPLYWYE6BPqWWd+SjZase5sgnJfSq5Sh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQE93/JpoU05GeFUftXvvmlhEkL+90efQz0htPV2+88=;
 b=c+TYX6GS4NIb8/vY3w76t7evuFy7K4cM7fBbroHQWtwOutADg7u9BsY+yDI88I+MmlXxKqYK8f4j+5SQlkJtQMeNK70XFKdS3vtUTd3qs8/1gmnWI+tp1tFKmQ8Ppo+c5I4KSMtg4zdDg4yXki6u/J/3xodmt76Gv5eD0huQ0/yonDKnrib94RUzpT+HWZyJq80DoHiif058ItyhN0+QuHh/1IaK5IyzBAr9NQrMCSQmwOLw0oZ8LIbKyo/avM+sIyE4+guhM5CUieiT4qXDevO80lYu6A1k/NmRYI+afG/FVZjI02gjk77/aKNhidSGTtBbH/WNZQUv/EN3YihsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQE93/JpoU05GeFUftXvvmlhEkL+90efQz0htPV2+88=;
 b=anxi7Gqnuj8sf2eoYGPp2I5a9NB4Gybyiq/CcFeowCohWyxWuHwAoAtBBy7mG0BPRhTfQDFS/zM3GBlqGBXkPBBQj8RkS8bqRuCjYYH61LpW8DjXtrAtoDefbmkuMf48J/9j694Nc4hQataF/pO9Sfl/2hNkx7x2exycJsDzzr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 12:50:34 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::2eac:da0d:9d7c:e20e]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::2eac:da0d:9d7c:e20e%7]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 12:50:32 +0000
Message-ID: <a36ffee0-b0d5-5941-8d98-cc8e9b100a50@amd.com>
Date:   Fri, 30 Sep 2022 18:20:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 01/15] perf/mem: Introduce
 PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Content-Language: en-US
To:     kajoljain <kjain@linux.ibm.com>, peterz@infradead.org,
        acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        irogers@google.com, jmario@redhat.com, leo.yan@linaro.org,
        alisaidi@amazon.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-2-ravi.bangoria@amd.com>
 <bf4ec1cb-49a4-f5cd-8fd0-c70b287180c0@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <bf4ec1cb-49a4-f5cd-8fd0-c70b287180c0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebef85b-c9a7-404f-3b91-08daa2e25c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8D0oPSWx7Mq93eF5+nu3HDXM+QwciABR1etaGQHXaxPh9x7aWb/thcBUigeBs/aLuKu+8Idl6zBU+Tu+4d+OqQvKw9wvleecrNJ+PBerUNI/CmK/Yq3RJ+LAGqMwOy1qx9Wi65ilWLK3iBxaH7IxDKiWovxXF+NdLxrpAU23uetxT9VbDvj+SGcbAaEyXjTNqWn92j4ElQgGmw7b1e9RxjUI2Fvm/3Wmw5h1oGmtPc2uDGzaiTvITaL9ORolysjJZ5N0bU6T2PC/tAX5zWIyB2r7zOhgxXXXjy2Zmgv534/D+ReBG+f0TNRGCmTRPPE2bYxljbMCTCd+plM8kvjW5rx5DbtDmXF54GIZlqdAN4o6G48LcV4e832kx6AvJhNHQSVIy38lgrOglJDTAeVTXvd0wsMhFzYWZ7gWuEbrPmkCCGRU30IsWcPINb1dXphlXEhZqNfMo1GRZDaSHch34wjsr41CKuVNdWGPbkt9EodUb3O6kp+xEO4baq4Bt/0D95uTcZrgT2WbaltV7lRqVfKfDZPIklBijryxReSEF2JtKJl5tx2tKndbDiuO00A8piTchBlImG606VnJ/dngayiXtPEh45ClyGARZYjwv2FYBkQ68mN6T4AdDkOCm8LlqRvazfp1r61kjinn2nDnR/d5LGrU5C1/OQMT2uMadzzuN/FX6tsTdVKXqiyKurXtetU/Rb99ss6jP+xfARNDabD/iXliXtPU5//XgwgbX+iF88plcUQ/gFT96xCVfYEA8Llw5wRqXfwtIaD+MxzicfRZu1ZQGZG0b5AhdL43r8AuI8xpMioBhjRu2F9Bag4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(55236004)(26005)(6512007)(186003)(7416002)(5660300002)(83380400001)(2616005)(44832011)(66946007)(66476007)(66556008)(31696002)(4326008)(2906002)(6486002)(316002)(6506007)(8676002)(86362001)(6666004)(478600001)(53546011)(38100700002)(8936002)(36756003)(41300700001)(31686004)(83133001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejBBOXF6cUswTUZYYVd0QTI4ZFhQYS9wVkZtd2dadU0rdDhpcjFiVXFtak1U?=
 =?utf-8?B?NFluT092dWFmc0psbktqVzRTQnV1dWoxVkcrSjVWeStSTjhlYWlPNEh4b2g4?=
 =?utf-8?B?ZGpvb1k5WkF0alV6NHJvbHZ6ci9FemdBSU9GaW5mVWRqQ0RlSTRRbHdNd3hC?=
 =?utf-8?B?eHkwMVR1alFZUHByd3c0QUFEQ2s5ZFE1TTY3dUJXY3BRaGZ0eHV2NGxGeTVx?=
 =?utf-8?B?VWxnOWM1ZWJ5aDllMitLVmFWOFNrOXB5UlVHZElYRkNld1ZNTkIxU2R1T1kw?=
 =?utf-8?B?TnhDQkZqUTFEL3JjNEIyeFJhOUZOblZPRWFtOVRvMUdPbWx2UXZwbEw3ZENs?=
 =?utf-8?B?d3RXU3lHcmUrWlpOb3YyU3lNOXR0Z2VlcnpxTkVEWWJnQWVkVjZXMUw3ZW13?=
 =?utf-8?B?TCsxSGIrbXY1MkhxQy85cUo2amZCUHZJRE9OUkRDL2xJR3FFSXJUM3NUMHdh?=
 =?utf-8?B?ZnRkMkZhc3FGUTI0c3FmMGxpb1FDR2FJSjc1dmJDNnByS1doV0lPd2R3a0tr?=
 =?utf-8?B?bVY2VnJ2dGdmL21Nd1dGU2pmdDZGT3VDZXhSOVZzSmFwekoxL2NkVVdGY2Uv?=
 =?utf-8?B?R0h5c3poR3poTmJ0Zm45M1NyWktDaklNcmt2S0pmYUVQK3o4TE9yQUg3ZWxE?=
 =?utf-8?B?R2g3RXhiRnFSRzhBMW01T1hiNkJMZ04vWmpXc0RkWm55dnRGUlpZQXBqbjhL?=
 =?utf-8?B?NCtvVDBIRmR5YVpEcU1nYit3ZFhCaHdPODhaZzRHazJGSFhiOUp6N0VJM1dy?=
 =?utf-8?B?Q0JSeTAyS090NzBRa3FrQmFaMFBtVlVFTFhsMTNsVW5QZGtUbkt4ekdkOUVo?=
 =?utf-8?B?WlVKK0szdDcrOEsxZVNNMVRHL2oyOVZyUm1ic01BeFJ5VlFvRnZFYXd0N3lw?=
 =?utf-8?B?dnNXRWpuaGlRUCtXeWhsK3BwSnJLamFuT3hOcnFoRzlzNEpIdlBaclZMWEht?=
 =?utf-8?B?aWVNd00rZXZmQWdHNlkrOE1rMHRKWjVzQzhRYkNyU0dBWFhkZ1N3Z3g2N21N?=
 =?utf-8?B?NUJldUtBRzJhaEFveXNWOTFtZE50b3dneVQ0Vk9EbnkzSVNVdmE3SzVpV0lL?=
 =?utf-8?B?QUs1Y1lkbEFuZlRjQU9SOE9Pc2syeFVpdXpNdDhwejl2WlZxYUNoa0FZS21V?=
 =?utf-8?B?Y3E4UXpiTVErS2hCY25neGlqekdVVHh0cENDb1Z4ZjB5UFdVMytmVGEzd2hP?=
 =?utf-8?B?NldJTi9VRVJKb0Z2aEFjUnMvY2NWQkpoNVVONXMyUHRFNzhRVE9HeW9id3Fp?=
 =?utf-8?B?eHBEVWw4Y3doR0JNQ2lpNVVkNGh1T29qMnJKRWV6bUhnTHBKVUx1N1VVV1M2?=
 =?utf-8?B?K0U3cVk1cDlEbDlROFE1ek5JTTNzVHRUS1g5V2gzUkx6cGhOQzlYWHVLVzZ1?=
 =?utf-8?B?cDZoQW5mVmF4WDNlVEQ0WGQyTERMVHlRb1ZFRWx6aDRqNHNMWERadzJPaVp4?=
 =?utf-8?B?QStOVUJsaDVFc1Y4MjNZM2c0ajIydGpKbmVmZ1B3TjJRZ3g0S3EvWVE4Mm5t?=
 =?utf-8?B?OXNXZG5HVzJ3RjE5eXY3NUxWOTJEMUxEZTBobjMyYWxFTmJNR1BTSzRtSWJJ?=
 =?utf-8?B?ODNQZlZqQzl4ZzdDQVBBVnhhUGhTY281YmRPTTBxczg5MkwrTjgrQlNQcDVS?=
 =?utf-8?B?R1FWbThrazRZM3JXTC9Zd0dnWWlZa2R3Ukg2b1VjRTY3SG5aSkhTYmRTdlE3?=
 =?utf-8?B?S3dGK29rOVZTMkNsSTQvYXZkRjdSZzNYcTdXbGhOYkhCTFg4WG9RUjJhWEpT?=
 =?utf-8?B?OUY0Y1RISFFYUjB0VFo4MzF0U2ttVXRncHpFWmNjUTdRVXZVejc2TTR5Q1dN?=
 =?utf-8?B?OFcyL2tOYTloQzJrWUdSZldSVXhOU1U3WXU3LzZ6eXY3ckpXcks0VldsWnJH?=
 =?utf-8?B?S0Z0SEVVZUZIa3hPazZuTXRHY1E3WlNiNEJvMTZnMTY4d3h5dUMxekFYZjJV?=
 =?utf-8?B?MkdrckRZOFAzMGY0aW5xeUkzcmR6TlowQVlPbVhMM3kzY0I4clZqV1h2dTk0?=
 =?utf-8?B?V3NRK2wxWWI0Z0wvTGtEM3JBZk5BaU9KY1o5Mm56WEdtbWJsUS9jSkVFdy95?=
 =?utf-8?B?MmtlL0wvUXZlTGxpeVdFaE5qM0V1dWtiU0x3VklZK241ajF0WmxiSThIcDAz?=
 =?utf-8?Q?uWL54JPm6E8gyDLSfBaKdhYCU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebef85b-c9a7-404f-3b91-08daa2e25c2b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 12:50:32.3210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tni1Au21jsE3yehQVc5U0kCno7x4CMTff3++YAC2hY2BwM9kfXcQTShLNmU5Nm5G2k4uXFtz8nEsoX9t1vL84w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Sep-22 4:18 PM, kajoljain wrote:
> 
> 
> On 9/28/22 15:27, Ravi Bangoria wrote:
>> PERF_MEM_LVLNUM_EXTN_MEM which can be used to indicate accesses to
>> extension memory like CXL etc. PERF_MEM_LVL_IO can be used for IO
>> accesses but it can not distinguish between local and remote IO.
>> Introduce new field PERF_MEM_LVLNUM_IO which can be clubbed with
>> PERF_MEM_REMOTE_REMOTE to indicate Remote IO accesses.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  include/uapi/linux/perf_event.h | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index e639c74cf5fb..4ae3c249f675 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -1336,7 +1336,9 @@ union perf_mem_data_src {
>>  #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
>>  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
>>  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
>> -/* 5-0xa available */
>> +/* 5-0x8 available */
>> +#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
> 
> Hi Ravi,
>     Here we are adding entry explicitly for accesses to Extension memory
> like CXL. In future if we want to extend it for cache or other accesses
> , we again need to add new entries.
> Can we rather add single entry say PERF_MEM_LVLNUM_EXTN and further can
> use reserved bits to specify memory/cache?

Is everybody okay with this:

#define PERF_MEM_LVLNUM_EXTN	0x09 /* CXL */

And a 3 bit variable to define what type of cxl that would be:

#define PERF_MEM_EXTN_CXL_ANY	0x1
#define PERF_MEM_EXTN_CXL_MEM	0x2
#define PERF_MEM_EXTN_CXL_CACHE	0x2
#define PERF_MEM_EXTN_CXL_IO	0x3

Peter, Shall I send this as addon patch series or are you okay reverting
current patches?

Thanks,
Ravi
