Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18982707110
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjEQSrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEQSrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:47:02 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2109.outbound.protection.outlook.com [40.107.100.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC386171A;
        Wed, 17 May 2023 11:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8FURW91Ou9lD9vZyBsCR+OyIHPUiF/jPVKN1ZUpVeCUBuIxJGc/4ypcnpbjkgPT2Fz6etOZJsiG6VU3AdZt+Esp5f5L/Lz+1tV4CLEiJYFdIdvI4zcO8Dr4nTS6s5vLHHODsEuz5gyPyedYfxPxd6Vr2JqOL4aAuOIeM3pET7r4e5OQqlMZY2Mzd3Fafx1t2tRz9JkbVa/u/Ceh3AS+WxD5tnW5RcrMyFKUSmwQZnYyc9aKHoh9r7gpQvvD+JUmzA0ZIrGtg09Eze8JnO6HQ8SPorAg2n5vHeTyu0vrsHCSBSt5WLece+v5RHKRIrgcC4nctb8DgjeMMyAZhpWYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jwk5sdu2r1XQw/Thhonmb0ignVWwQGaF8KnTBdNgus=;
 b=ZYvY1Yslj1bwJbLg78t+6/lqj3Hj6CnZzYBcDkEETNv3Uu56wVOQTdVvl4+HVOU+8+gs8mV025WHrRI3eTB/hh1bI/LZ4jEQMMsvMyiB6KQBYy8T2nTg255b7nIMxvuXbBw2Y0HbU1BaqdKGmltY4VukAZI36hyV1LMYJdCGNMyX1RGue3S/ZkVozYDB2Zwp/oJND7O4p4LrAn1Uzmpn7VcJ1M6ZIwK2lYzPSnOkesGh9nPw1uh5Ht9IJeJs1gcZgYXgFwrt55G4Sz7FVagk0V9d6zyGKA1M1T1l3V+4A65DSGsmBKtCdL0FrXtSIZxbiPdD3P1t6E074lnYJMmksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jwk5sdu2r1XQw/Thhonmb0ignVWwQGaF8KnTBdNgus=;
 b=A5Vo8NjYjhajzTab8lsUIJAZ3OJTjlDWuJPtOyx9s0M4kgpYB+J1adQecygyEMeFC57tphIlry5sePYKpjVxcm6muaMUpe273XstSOGMzzjZoULc9A5A0FaI+VTd8fqewuripYixYNiP44ZiEUGPSpNi2Ijp2ls0SC5DGADMTRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 SA0PR01MB6187.prod.exchangelabs.com (2603:10b6:806:ed::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Wed, 17 May 2023 18:46:57 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 18:46:57 +0000
Message-ID: <7caa9878-c910-06f2-6eee-64cc55d8a207@os.amperecomputing.com>
Date:   Wed, 17 May 2023 11:46:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: keep target core awake when reading
 its cpufreq rate
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Zeng Heng <zengheng4@huawei.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        wangxiongfeng2@huawei.com, xiexiuqi@huawei.com,
        liwei391@huawei.com, linux-acpi@vger.kernel.org,
        weiyongjun1@huawei.com, lenb@kernel.org, viresh.kumar@linaro.org,
        rafael@kernel.org
References: <20230516133248.712242-1-zengheng4@huawei.com>
 <a1075da1-4ff1-4a8b-2902-3954db717ded@arm.com>
 <cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:610:5a::36) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|SA0PR01MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 2532e3a9-3655-437d-5a4a-08db570716e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gsWZUt547keQW8pbBW622cBC+djUOE4QaiPldRXJy53wUCvI3w5ltQ+M2AQI1JFTHh/85wDrVJlbTgXAEVXzz6YaSfH6aAhiGHTyTs+7mhpg8gfqOe/hJo9AUcr01/5SmAAk6Iuhlli2tHn2yZnCgPUh3kEIXjrMIvddm3yfwv0Vy/tEfPvuTQRl7IOVhzCD6Qq2F17Sh3OOVeEViF1wJRauJyWm+FTFy2ZBRkeHUThMw+cz5o9Ge5cy7NN5i8NtRxkMLMt3M3OHWWq6n7LzHa7dx84bPjpd9BlxS32nA5Fd0nN1jmG05ldrdE+5PlyeICSYZHHK7meKSls1vRDvnGppaQhwScyY2mDA8iBfLYfgpiP/XevVFyecA39F8l7EdgCAsSfPJRR7iu8RKgoOL5RYHz9InxssuccJOBOMjX9XmAuUjf4fxz+dwVYAck1nApTHUnT+horHNVoprj9IBVPPTZwWzo9DlhO/1D8n+G0Jj/AuEiMh6y4BASBLVUdJc54tHpcH8J1bucL9Sj9PYfwyNFvI/NThCNXZk8JyUA1nfBfjNmjVOJR7YEoH8migEsVOzG7azUnBhUOSnjAJpm8EM1ge6I3O1c0FcIH+oF99Ti0tmADOHmnAzACJ2BgoI3PpP7FAKqiYbbDb/ZspA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(346002)(376002)(366004)(396003)(451199021)(31686004)(8676002)(53546011)(2616005)(26005)(6506007)(8936002)(6512007)(83380400001)(7416002)(41300700001)(478600001)(186003)(966005)(6486002)(66476007)(66946007)(6666004)(38350700002)(316002)(5660300002)(110136005)(4326008)(86362001)(52116002)(2906002)(31696002)(38100700002)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bldOUkQ3U0s3dG9aYXpSUG9kS1pmOXZwamFHTE1XV09ZRjZrYUtWN3ZpWU5m?=
 =?utf-8?B?dlhMY1g1UnBCQkhGR3lWaFMvckFHdWZPZVBYWXIzN1I4aFgzQkZPWE5oWjBC?=
 =?utf-8?B?ZFQ4Q0VveG05WTQxbkI5VUgxZk8ydS93SytQbFZEeGRra28rM3RZT0Y5YlR6?=
 =?utf-8?B?SEJtOUgrQ2ZwajNyWVhFWXdkQkVORUx4bnpRRVAvNjJiUFFEY0o4MVg2Snpm?=
 =?utf-8?B?QkQwWlBWOU0vWWc4VVlGUXpKcU9OWFBhcUxyN0h1OTROdzVmVlVSdmZVQlpX?=
 =?utf-8?B?S0doMlYxd0RrNDkrRlc1T0gyWTVaTWJ5SktJMmxLL05uZVpUR0I4cXJtbDdh?=
 =?utf-8?B?OVl2RnVJcDdjZkhwTTVoM2VuR09ZYzNpWGJha0RGWHMyTnd6N3dPVEppandz?=
 =?utf-8?B?ZkRkSm9PMVdzZFZOcU5QdEhCQ3ZFeWNXNW1sdTB6bTRUYlBXVXF3cHFVYXRl?=
 =?utf-8?B?SjE0ZStFcy9obldPc3FxL05nZFc4MkhiK2pnTFMrK2lsbnRMNFVXc0xjc1lY?=
 =?utf-8?B?UXZ0RFIvcHU2M1lyZk5rSjNFVXl1QTRmangveDcrTW9lcHVjejNOMnhYL1Ar?=
 =?utf-8?B?bzhOc2pOZHVUM25ySkN5bk9id3BHTU9Kc1NRc0VoN3ZpbHZDT2dUUGRuYkVx?=
 =?utf-8?B?eGtQeEdlbjhSSThNRkcwNklWR3VKeUEwd29HSHJzVllDZTRkSjZTL2tvWFMr?=
 =?utf-8?B?aThETVR3aXRiaVpwQ2dVdWN5VHR6UFV3dGw1M2xQRkZQY1Zsajh0ZFJkQUZo?=
 =?utf-8?B?a2JOTWRtbk5nVUMybUVlbzUwQTViT0pBUTllQTJVVmdxSWZlVi8zNkhPaXA0?=
 =?utf-8?B?RVhQcWZMUjlKb0hvZzZPS08wVEd4WGJtZDlveTc3empxalJRUlZ2aXVPMUUw?=
 =?utf-8?B?bm15SzFueVVSdjl4UUI0R29iUEQ3bisydFB6bUxUUGgvQ1FDd2RVTFZEdlhz?=
 =?utf-8?B?MTc0Z2p1aTN3aG9sSzQ0UGpqRVZHTTI2RWl3N2hSOFI0Y0I4NjBlS2grQ3g1?=
 =?utf-8?B?dVMzSnVtODB1YnJSSDZpMlVlN3g4WmFxOG9SNjlTTHlFMnhka2Y5OTQ3RWg4?=
 =?utf-8?B?RHRaMlpwTlZPR0JiMlBRMnhwVlpxN0taM3pObFRkUUZxdURVVWZSSU0zRHli?=
 =?utf-8?B?OFNsbldMa1FCVnYxeG9URmUzY2Z3T1h3ckhoVG9KaFI5ekI4aUlGM21iK0E1?=
 =?utf-8?B?ejBhU0dxOWMvcVJFdWFQNUtQZ0pTQnlieHlkUmRSK1k1QjFTd1oxb0M4MUNr?=
 =?utf-8?B?OVBXdnNFOUhsK1Zab1A1aittRktHRldscTNZdTNEMkhEdDBsODVXRHkxdVV0?=
 =?utf-8?B?TTBRU2oyVFZIVjBranljQy9DOXNadUR0Nkw5UlRFaGVIeHVZei9rV21EYW1i?=
 =?utf-8?B?UW51NXdQb1FQWDdlNlM1NmFnSS92T0JKY0ZQMUtJeVRDMkpwSzdFTWxDcWVR?=
 =?utf-8?B?eW5NSDNyV0FuT1Y3T3lxVTl2Yk9HMTVxc2ZwV3BmWmVZZ2Urb3BFV2krNEg1?=
 =?utf-8?B?aXlpVVE0SEJVRGZheVkvdWdqQmR3ZWMwb0xSNHFaOFMyUDZsZEw1QlRDL3RS?=
 =?utf-8?B?djNEcTF2L2RWdnVEdUNUZ0orSTJSMkJWSmVYWE9NeFpxSndGZ1h6cEFTMFRR?=
 =?utf-8?B?TFMzWkxHZEEwSnc4c3pCdzJ4Q1dWQkpWaUV1THBLVXByMkp6TEx4eTUvaW00?=
 =?utf-8?B?aFNWZGY0ZzVLVGVlRFhaVzhVQll6Z1dONTFRTWVUVVRJdTQyUVhQVmxlYkU2?=
 =?utf-8?B?a042Z0wybTRzZGZkV3dEMXpueGVIYnhhVzdTMnQ5UXc2WkVtL0dQaDA2V1BF?=
 =?utf-8?B?VXJITEIrQ2JSSWtjU2RVVVNQZ1N3L1pOVXdocC9JS0t3czYwcUpUbldFdkVD?=
 =?utf-8?B?ME9TWGJhRzhsNnpwayszR2kwSHJLNUlUczFxRkRxeXQ1SGl1ZmNQM2lsQStN?=
 =?utf-8?B?SlpIL3huNE9GM1hROHZlMzl2aGU1RmxMcGI3NVlMdzAxVk9IdW5oRndaYjVD?=
 =?utf-8?B?SUg0eHZKSndYRkZMenpidlpCSlJXdFBYNGlmOXpQTnRZOW9zNHF6RjkxZmRP?=
 =?utf-8?B?M09oSHdXejJabm12SEVWNGEwZGFiRzVGdjlzOXlMa29ld3duMStnVXFXSjlw?=
 =?utf-8?B?SHZ0OGdYdS9DQUs2ZjFTeXJhZkxtYjh2MmNQRnRuYVE5NndOWm9mNWZmUjdl?=
 =?utf-8?Q?/kYDumEKgBttx0yllL2QhXo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2532e3a9-3655-437d-5a4a-08db570716e6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:46:56.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9qMvKPfa+JgrMi642oGSIpCYu3qbAD7R6Gw4HISGJxwIAs3DCF66Kgnrmvlw66loKbNsY7/W3aC1E5r54L8UxYuzjP4RcCo/bchR+jo0g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6187
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 8:03 AM, Sumit Gupta wrote:
>
>
> On 17/05/23 13:47, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> +Ionela, Sumit, Yang,
>>
>> Hello Zeng,
>>
>> I think solutions around related issues were suggested at:
>>
>> [1] 
>> https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
>> [2] 
>> https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
>> [3] https://lore.kernel.org/all/ZEl1Fms%2FJmdEZsVn@arm.com/
>>
>> About this patch, it seems to mean that CPPC counters of CPUx are always
>> accessed from CPUx, even when they are not AMUs. For instance CPPC
>> counters could be memory mapped and accessible from any CPU.
>> cpu_has_amu_feat() should allow to probe if a CPU uses AMUs or not,
>> and [2] had an implementation using it.
>>
>> Another comment about PATCH 2/2 is that if the counters are accessed
>> through FFH, arm64 version of cpc_read_ffh() is calling
>> counters_read_on_cpu(), and a comment in counters_read_on_cpu() seems
>> to specify the function must be called with interrupt enabled.
>>
>> I think the best solution so far was the one at [3], suggested by 
>> Ionela,
>> but it doesn't seem to solve your issue. Indeed, it is not checked 
>> whether
>> the counters are AMU counters and that they must be remotely read (to
>> have the CPU awake),
>>
>> Regards,
>> Pierre
>>
>
> I think the solution in [1] is simple and solves all the three cases.
> Also, it provides better accuracy between the set and get frequency as 
> compared to [3].

I don't think [1] patches work for our case. We use mmio instead of AMU. 
Increasing delay could help to mitigate it somehow, buyt 25us is not 
good enough for our case. IIRC the fix proposed by Ionela works for both 
yours and mine.

>
> This can be merged and can later still be improved in Upstream.
>
> If OK, I can send new version by changing the patch to apply for all 
> ARM SoC's with AMU and not specific to Tegra.
>
> Thank you,
> Sumit Gupta
>
>>
>> On 5/16/23 15:32, Zeng Heng wrote:
>>> As ARM AMU's document says, all counters are subject to any changes
>>> in clock frequency, including clock stopping caused by the WFI and WFE
>>> instructions.
>>>
>>> Therefore, using smp_call_on_cpu() to trigger target CPU to
>>> read self's AMU counters, which ensures the counters are working
>>> properly during calculation.
>>>
>>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 30 +++++++++++++++++++-----------
>>>   1 file changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index 022e3555407c..910167f58bb3 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -837,9 +837,24 @@ static int cppc_perf_from_fbctrs(struct 
>>> cppc_cpudata *cpu_data,
>>>       return (reference_perf * delta_delivered) / delta_reference;
>>>   }
>>>
>>> +static int cppc_get_perf_ctrs_smp(void *val)
>>> +{
>>> +     int cpu = smp_processor_id();
>>> +     struct cppc_perf_fb_ctrs *fb_ctrs = val;
>>> +     int ret;
>>> +
>>> +     ret = cppc_get_perf_ctrs(cpu, fb_ctrs);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     udelay(2); /* 2usec delay between sampling */
>>> +
>>> +     return cppc_get_perf_ctrs(cpu, fb_ctrs + 1);
>>> +}
>>> +
>>>   static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>>   {
>>> -     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>> +     struct cppc_perf_fb_ctrs fb_ctrs[2] = {0};
>>>       struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>>>       struct cppc_cpudata *cpu_data = policy->driver_data;
>>>       u64 delivered_perf;
>>> @@ -847,19 +862,12 @@ static unsigned int 
>>> cppc_cpufreq_get_rate(unsigned int cpu)
>>>
>>>       cpufreq_cpu_put(policy);
>>>
>>> -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>>> -     if (ret)
>>> -             return ret;
>>> -
>>> -     udelay(2); /* 2usec delay between sampling */
>>> -
>>> -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>> +     ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_smp, fb_ctrs, 1);
>>>       if (ret)
>>>               return ret;
>>>
>>> -     delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>>> -                                            &fb_ctrs_t1);
>>> -
>>> +     delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs,
>>> +                                            fb_ctrs + 1);
>>>       return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>>>   }
>>>

