Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BC6DB65E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDGWTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDGWTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:19:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2092.outbound.protection.outlook.com [40.107.94.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC4CA1A;
        Fri,  7 Apr 2023 15:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqUtL2uq49dR3/NDB+LkPN/CaETuFTDLJXLz2WYEAgctC18hStkWNsAw/wJPhYjSMMgUdAfm0T/5zO4dGHFJbdh/CovYdhzCvdnZDS9pr/FzDvtnl3GYBnnK3o9jP6qTCXZG89zTy7weQJ7HYIh1vDYje+RkN6JPJu9AjF66GYZmnBYTZjvVr2dlbh45VMAfK1wsB3PL7BtOX1UlB+kO20HoFoS9C5M9vk9xsEptqFtaMUKc6Oe4xOTH7xJE7KHmddVCfq5XHZNdw4v3YZYPf+UZ3DYLskVaCv3YXwPocW9pckIoyUy+vJIAyratioJOyzkzYQ6/57cxQsWrGLLnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx1zANWmzLDidC4hshp1weuEhtyhKCVDrbKN/1eS6NI=;
 b=ZlCd63aJYVnyDoUHjZ0FYj48ZfcMudTWMbHsJtYz0aQ+D13HKN/vfjjuR7d/SYQvq28QtV62XX43skAWyGGAItAtxDm/LangVvlmromuFCk5rtpXBGT+zp+olpz/oEbjQpnXPZ6d3AyVNQRo85Y1ePrR+TedfLsbed+NTTCl3mGT7qfw0ereFJ3l7AYTbo4eP9QU7+5tsY2vhYBVCgQGDjZIgwxBi+D4u6ov06v8HhW4KATLJHP3W01tGTOBPVVbqu/sPKElusYqrgk4gwdqPblN520EraVxWevpE0u27eQ2Y+khUrLZlaGMoxoejzg2W6KLE9ng8CH+gG83yWt1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx1zANWmzLDidC4hshp1weuEhtyhKCVDrbKN/1eS6NI=;
 b=AO32WRTOmQps3XVXqtTPXGnLGoq5VCvfB3zhRV57qI7Y/2HUJ3et5IsCzFB1jUdgfNtetkpnFnlKtcmF32qTLDZsmCJSBjAmt+7kK97F41WDnASLecmeeudtOdV70u5lpGzxIwNcjb3NbyQ44GepeUrEWbp7/bGg2sCBYF+AuJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 BL0PR01MB5011.prod.exchangelabs.com (2603:10b6:208:6b::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.28; Fri, 7 Apr 2023 22:19:31 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a%4]) with mapi id 15.20.6298.018; Fri, 7 Apr 2023
 22:19:30 +0000
Message-ID: <3e239024-91d8-ea06-25a4-631496576319@os.amperecomputing.com>
Date:   Fri, 7 Apr 2023 15:19:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     viresh.kumar@linaro.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
 <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
 <d08222bf-fa05-3e3b-18dd-d24ced6c1536@os.amperecomputing.com>
 <4bda6b02-cc50-fa47-c9b6-acda4cf201a8@arm.com>
 <cd79df5b-68c4-4825-6c29-e560989a1130@os.amperecomputing.com>
 <195c95b2-f47c-f3d0-5663-97dd4c929ea4@arm.com>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <195c95b2-f47c-f3d0-5663-97dd4c929ea4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:610::24)
 To BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|BL0PR01MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: f58b87ad-3f13-4b4c-e843-08db37b62826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFwIB8/xuHdrZUrGa7hJtu2MsovhUIh5Mms52z5kmHGkOEjEpsisHWuJeBoXM1dpb/e7OHIChuGbO+DJtnutqGwcyEiAefKaxTtPt3P3NHuJftD6xaLPPLQHuXac1BcyayhtDPd1Wcqb5FxuvOJxuuwHH/90TPdkTcsyfxMsx4afUtCpTH5vOfwz6xaJhZ3Ido7bQZTxbPlG9gBJnJZ05zZPqYeqnMX6OK3pfbYPb0CdbjoS4kFinYyw2TlgUSW3WiOxkV5kWqoFhWyUxDWeT7ESliTE22okrwHKBc9naMScylEj3XsqGxP+uGPjQFbGqtHUjmVt+FpWb95aG/tF1PhabQAqR1eqhMnc8k5IAody5bG93D+ksLNHlh4dxgWzS2/s3xkSEN/QOed04ipcejRK5MMnN+rOarRemAxRBAmCXoFFAVDosiAqb4Ee9de9prJU2euDqrpBFClA+Sk07hraYLu5Y+WpkYqikuDS+t3RHMT+K+NBRT1EKKnDPJexYuKSZAw3OndZzo+zDFElr+mCf2Z9T0BoiTvF15aNthJpiMFBsbxV3fwcGB9NPL2VikAijdmmhkQXHWyK7PvMYETHHbRwqhyeJOx0t3tlJAEVCmV+MANMYhPxW7rBTcl0dm0RBAxcm+5iuWljUHPhqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(451199021)(38350700002)(5660300002)(86362001)(83380400001)(6506007)(53546011)(31696002)(2616005)(6512007)(38100700002)(66946007)(8936002)(186003)(66556008)(8676002)(66476007)(26005)(316002)(52116002)(6486002)(6666004)(6916009)(41300700001)(4326008)(478600001)(31686004)(2906002)(66899021)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VldKajFodUZpWDVvQTFseE9QYzRxaW5POHBVbEsxV3VDM1B5SEwrU25ra1RQ?=
 =?utf-8?B?dDYzcWlvR3ZGNCtXWXNtUUNvYkxaS1doaHBjWmZpdG5qRkpSd0hCVTJsWFFa?=
 =?utf-8?B?L3dxRGUyUStBbHpCTE1VdmE4cklDS0tDT0crMlNTOU5JeWhYR0ZFOEYzSVNH?=
 =?utf-8?B?SUNqNWJ5aGt0RFBtWTgvR2grbHZ4QzA1RGswbHpjVXdidlRFcjV1Y0Y0SXdU?=
 =?utf-8?B?dCtMcVVydWhpL3VTellSUEVqaDZFZFRHTGlFdlpweUY0NldtYXVYSXVMSWk5?=
 =?utf-8?B?UWJMWUJwc3Axc0YxSVJPKzBCbG16MHNJS0tjRVkzT2FGZU9IVlFUb3BlNkdM?=
 =?utf-8?B?SWgyK1IybzkrMC9tOHFZUCtlT2dFcStQTStRNjBZR0ZlTHFMUW5oSkY3UE1V?=
 =?utf-8?B?NWdVZGhQSUVTdmdxSEpXVHpxK1BvQkszNXhMNnRIK0pYVEpSU21KU2RBWUpo?=
 =?utf-8?B?d0c2QWlGdk1wL2RmMVRTNGdlejFteFY4cm51bnFabUlqYXNrM2hXZTVGZFpV?=
 =?utf-8?B?aHdBWUZSNTBRRkFVTCtvVlZoS25kQU9iZitablZvNzYxWnhlbWRhZ1FYOTlS?=
 =?utf-8?B?UDRmR2QzNHdFZksvVWY0c1JQK3ZrUVE0d2lxL0VidVpObXdGSGRoTzhvRmRN?=
 =?utf-8?B?ZkllZjRJcEE5c1VFMDF1dnVCa1lLSFlpMFZsWlgrV2k0bXE0L2dhOWZ6R2VU?=
 =?utf-8?B?TlpFbHl6cUl0WmJheTVmeTVyUG5ra0lRbnpuUXlVdW9uOHlPUXhSSzU2ZWhs?=
 =?utf-8?B?RUJ3L0NCcGhpRDVOR2lwQnFuWG1xR1NVTWlndVJhOGpCMC9WN1QzVERVRzBw?=
 =?utf-8?B?RmUzV0JVZHpnV1BQVWViNkgvS2svaGFtR1JGT256WjZHV0Nxa3lIL2JGbG8x?=
 =?utf-8?B?aldKY0dETEYxVURwSHByUjZFOStvVWtBNzJ2RHVPUE5HOVY4Y29meFVRZmNR?=
 =?utf-8?B?dzN3UXA3NXpERG80VmpTR0NKQ0ZqMjUzcmloendaWE0vRitPYXVVbzhYWE91?=
 =?utf-8?B?SnpBUU5VcTUzcE9FVG0vaDhEeDNnRGJuZmxaSlhWNGxWRSt6VldBQ20rWjNR?=
 =?utf-8?B?L3ZBVjhFWkQrYkUwbUtTTVVzSGVhK2ZvK2NtaEpFNVZuNlpJQWdEcENjYW5s?=
 =?utf-8?B?dVM4M1BKOWJ3bmNaWklEdjZuS2ZVM01VUkRYMXpHcFdqcWtMbGg0QWVIeGFE?=
 =?utf-8?B?NEp3cTdQY2UvdHMzSW5rVHFSSjJRS0VOamZZc2xrU2tBb2tVRFZLQzJLRXIv?=
 =?utf-8?B?Ti9pUEo3NVQ0U0MyY2tVNGczd2dMbTZpOGZ4RDVzbXppY2xOd3dScEM0enU2?=
 =?utf-8?B?bjRCREFRUEJZRHhhcHRtL1poQVNlQnkydVd4YWt5anViSU16YlB5M2ZKTm5i?=
 =?utf-8?B?YWo4aWJkVmFoM3lvenh6eUM3ZWwxdDFkdEhFQXNRdE5RdUVUa3F6NmdzZHVJ?=
 =?utf-8?B?Y0dJRlRpdU1waTd5SitkdUtvNHlKclVHdmVpN0QyWm4vTEtNYWYzYmc1T1NH?=
 =?utf-8?B?WHhacnd0MFRQTVAvdDdNZ2Q3dzV3M2VDKzZNZXJNM2hJQ0c5b0h1SnIvd2VH?=
 =?utf-8?B?UWpTbm9XZGt0eE92ZHNkMDUza3hiSWc2MERIdmlPRC9wTDFJTlhiYnVCNGU2?=
 =?utf-8?B?YmF0YXlhcnMrOVRnV3lmNlhPOVQ2OXdRZWZkdkNZcVgxUHZWM1VYdnN3ZXd6?=
 =?utf-8?B?bjFKUXNkbzZnL0xYb3VibGR4TE8wK2xzbklBV2RFM0FZb2NhYnRjcmNOSi9N?=
 =?utf-8?B?Rm5pOTNWeFRiREFRRGlXTWMwUml1cDkvcW1QcUgvRHBYSExyQ2ZsSTZzUHNL?=
 =?utf-8?B?WHFWc1YwZjNzMUpSTy9XY2lLS1d0TTBxWlBUU0FaOXRZM1BWTndyVjNZakF5?=
 =?utf-8?B?T1RySDlIRlk5U3F1cGx4Uy9IUE15SnRnOEpGa2M4T1c5bmRRY1ZWY0FBb1NJ?=
 =?utf-8?B?dVF6b2dhK1hLdUN6K1g3QXhTZkdhTFpqK1NGa0MvU3p3dU43ZnEvU0FnYmVN?=
 =?utf-8?B?LzMvSUZQWTFBd2trRWROMzQ0Nmt0YWhtcEpXWWFRbnFNL3RnbjZzUkN2STFx?=
 =?utf-8?B?SlFWaUZpNW8wWHJ1Rm5sRWRtaUpnRWxsTW1hQno0cXk2YU01emIxbzBLM2hY?=
 =?utf-8?B?ZHdFMzdxNHplTEF2a1R6YitZN1lISVEzTG9qbUIyeDZFOEpRb1IyR29TNm5m?=
 =?utf-8?Q?RYKqG1isOzHKUQ6fVQbBF/M=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58b87ad-3f13-4b4c-e843-08db37b62826
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 22:19:30.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaZLdcc+s12v5gWeiGFQYIcLE5vNqMpi3ql11yDY8oIsuan6t72JoHg6AY7wdvPoZwcx8wuBIChK8QkYU3mxGeX0BVSb+6LVgKCGuHYmWmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB5011
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/23 1:31 AM, Pierre Gondois wrote:
> Hello Yang,
>
> On 4/6/23 23:52, Yang Shi wrote:
>>
>>
>> On 4/5/23 10:57 AM, Pierre Gondois wrote:
>>>
>>>
>>> On 4/4/23 21:07, Yang Shi wrote:
>>>>
>>>>
>>>> On 3/29/23 11:43 AM, Rafael J. Wysocki wrote:
>>>>> On Tue, Mar 28, 2023 at 9:39 PM Yang Shi
>>>>> <yang@os.amperecomputing.com> wrote:
>>>>>> When testing CPPC cpufreq on our platform, we noticed the error may
>>>>>> be quite
>>>>>> high and the high error may happen quite often.  For example, on a
>>>>>> platform
>>>>>> with a maximum frequency of 2.8GHz when the CPUs were fully loaded
>>>>>> (100% load),
>>>>>> we saw cpuinfo_cur_freq may show 4GHz, it means the error is >
>>>>>> 40%.  And the
>>>>>> high error (> 1%) happened 256 times out of 2127 samples (sampled
>>>>>> every 3
>>>>>> seconds) in an approximate 2hrs test.
>>>>> The description above is a bit cryptic IMV.  For example, it is not
>>>>> particularly clear what "high error" means.
>>>>>
>>>>>> We tried to enlarge the delay, and tested with 100us, 1ms and
>>>>>> 10ms.  The
>>>>>> below is the results.
>>>>>>
>>>>>> 100us:
>>>>>> The highest error is 4GHz, 22 times out of 3623 samples
>>>>>>
>>>>>> 1ms:
>>>>>> The highest error is 3.3GHz, 3 times out of 2814 samples
>>>>>>
>>>>>> 10ms:
>>>>>> No high error anymore
>>>>>>
>>>>>> Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to
>>>>>> avoid
>>>>>> high measurement errors.
>>>>>>
>>>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>>>> ---
>>>>>>     drivers/cpufreq/cppc_cpufreq.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>>>> index 022e3555407c..c2bf65448d3d 100644
>>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>>> @@ -851,7 +851,7 @@ static unsigned int
>>>>>> cppc_cpufreq_get_rate(unsigned int cpu)
>>>>>>            if (ret)
>>>>>>                    return ret;
>>>>>>
>>>>>> -       udelay(2); /* 2usec delay between sampling */
>>>>>> +       mdelay(10); /* 10msec delay between sampling */
>>>>> This function can be called with interrupts off, so it cannot spin
>>>>> for 10 ms.
>>>>
>>>> Per Pierre's comment, the delay may still be ms. Is it still too 
>>>> long? A
>>>> quick look at the code shows cpufreq_quick_get() is the only caller 
>>>> with
>>>> irq off IIRC. So can we have another callback for it, for example,
>>>> get_quick() which does spin for shorter time (for example, keep 2us
>>>> delay). Then have ->get() callback use longer delay?
>>>
>>> -
>>> According to the same ACPI 6.5 s8.4.6.1.2.5 "Time Window Register"
>>> paragraph,
>>> and assuming we are in the 'Autonomous Selection is not enabled' case,
>>> the OS is supposed to write (not read) the delta between successive
>>> reads of the
>>> counter, so using this field as is would be bending the definition I
>>> think.
>>>
>>> -
>>> It is correct that the "Time Window Register" field specifies a value
>>> in ms,
>>> but it seems a long time to wait for with irqs off.
>>
>> AFAIK, our platforms don't support "Time Window Register".
>>
>>>
>>> -
>>> Theoretically, the perf/ref counters should accumulate to allow 
>>> computing
>>> a correct frequency. Is it possible to know how these counters are
>>> accessed ?
>>> Is it through PCC channels and there is some undesired delay between 
>>> the
>>> reads of the perf/ref counters ?
>>
>> The counters are implemented via mmio instead of PCC channels. So the
>> cpc_read() calls should go to ACPI_ADR_SPACE_SYSTEM_MEMORY IIRC.
>>
>>>
>>> -
>>> About making the delay:
>>>      max(cppc_cpufreq_get_transition_delay_us(), Time Winder Register)
>>> I think it would be good to know why the values of the counters
>>> don't accumulate correctly, ideally by getting a trace where a 
>>> frequency
>>> above the maximum frequency is computed, and with the timestamps at 
>>> which
>>> the counters are read.
>>> If the values are coming from PCC channels / the firmware, it might be
>>> difficult
>>> to get.
>>
>> I wrote a bpftrace script to trace the below data:
>>       - The CPU number
>>       - The frequency
>>       - The start and end timestamp of the first cppc_get_perf_ctrs() 
>> call
>>       - The duration/latency of the first cppc_get_perf_ctrs() call
>>       - The start and end timestamp of the second 
>> cppc_get_perf_ctrs() call
>>       - The duration/latency of the second cppc_get_perf_ctrs() call
>>
>> The typical logs look like below.
>> Good
>> CPU: 1
>> Freq: 2801485KHz
>> First:  2489382384  2489387084 4700ns
>> Second: 2489390824  2489394024  3200ns
>> --------------------------------------------------
>> CPU:    2
>> Freq:   2797956KHz
>> First:  2490406524  2490411204  4680ns
>> Second: 2490414764  2490417684  2920ns
>>
>> Bad:
>> CPU:    55
>> Freq:   3969372KHz
>> First:  875659868  875721568  61700ns
>> Second: 875725148  875727708  2560ns
>> --------------------------------------------------
>> CPU: 65
>> Freq: 3829744KHz
>> First:  3854951136  3854995896 44760ns
>> Second: 3854999416  3855002696 3280ns
>> --------------------------------------------------
>> CPU: 21
>> Freq: 4279242KHz
>> First:  240834204  240910484 76280ns
>> Second: 240914264  240916944  2680ns
>>
>>
>> The first line is cpu number, the second line is frequency returned by
>> cppc_cpufreq_get_rate(), the third line is the start and end timestamps
>> and duration of the first cppc_get_perf_ctrs(), the fourth line is the
>> start and end timestamps and duration of the second 
>> cppc_get_perf_ctrs().
>>
>> So per the log I think we can tell basically the longer the duration the
>> higher the error. The 2us delay is not long enough to offset the impact
>> from unexpected latency of reading the counters.
>>
>> In the worst case the frequency is 4279242KHz, comparing 2800000KHz the
>> error is over 50%. So the delay should be 4ms ~ 5ms in order to offset
>> the impact from reading the counters if I do the math correctly.
>>
>> Hope the trace data is helpful to diagnose the problem.
>
>
> Thanks for the data. I was thinking the following was happening:
>
>  cppc_get_perf_ctrs()[0] cppc_get_perf_ctrs()[1]
> /                    \ /                         \
> ref[0]    delivered[0]                    ref[1] delivered[1]
>   |            |                              |                  |
>   v            v                              v                  v
> ----------------------------------------------------------------------> 
> time
>    <-delta[0]-> <-------------2us------------> <----delta[1]---->
>
> If delta[0] is really different from delta[1] like above, then the
> reference and delivered counters would have accumulated during different
> intervals, resulting in a wrong frequency.

Yeah, it looks like so.

> If more/less than 2us elapse between the two cppc_get_perf_ctrs() calls,
> then it shouldn't have any impact. So waiting ~10ms should theoretically
> not solve the issue.

I'm not sure whether the 10ms delay really resolved the issue, but it 
did reduce the magnitude of the error.

BTW, I don't see irq is disabled when reading cpuinfo_cur_freq, so it 
looks like interrupts could easily result in the difference between 
delta[0] and delta[1]. And it seems like the difference matters.

And the counters are accessed through an interconnect on our platform, 
so the interconnect congestion may result in the difference as well.

>
> freq = ref_freq * (delivered[1] - delivered[0]) / (ref[1] - ref[0])
>
> If the counters are accessed through mmio, I don't see anything that 
> would
> make delta[x] vary when calling cppc_get_perf_ctrs(), cf. cpc_read().
> Do you know if the address represents real counters or a place in memory
> representing something else ?

The address does represent real counters.

>
> Would it be possible to try setting the CPU frequency to one unique value
> and get a serie of values like:
> [timestamp, ref_counter_value, deliverd_counter_value]

Could you please elaborate regarding "setting the CPU frequency to one 
unique value"? What value is unique?

>
> This would allow to check that the counters are accumulating at a valid
> pace. Also you said there were frequencies above the maximum value, but
> are there also frequencies below the minimum value ?

I've never seen the frequency below the minimum value.

>
> Regards,
> Pierre

