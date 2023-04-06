Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD36DA4E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbjDFVxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbjDFVxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:53:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F35FCF;
        Thu,  6 Apr 2023 14:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhu9wExuSN8gUU9SwtjK9ctGvH/aQnTHM4i42cAsOpRtEFyZrKKUYLVSGJRO6uRC0slWuB8suui7ljAEhBmzYSxdT7+BIV0k1GoCRYd+Hq+ezf/ojuDcDxHsejbUyv9xWvflfg1r5VZcV8jP1HIcjphW/OpHI5F+64A1YK0QQ1NbRu90bv3ZWh0fT6mL7kB/Gy1eHz4fgUSpjlzxGzTWSetO3VbUH8yYpqG2v0tAv9P2mtXbeQXKAFyAjHv3MYa40RmEh3cIc1Loopb9VNKYb3+0hpf+yVXobhyTZmAPquW6uSPZUf99L7+VHyNrB6PnVMi5gc27lr9p8/k5wU3U6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwbdrNR8R1JTvKXZe8K3iFihli2LU6JidWMDzcNdY4c=;
 b=ABcnHNyenzXbImKXmYzUn7YGd9yTD5wrmBSScaYuE3LA/R+GWH7KIkhoemDDJdrDTerlE12c+604jQpCODl2PDARveDSKkukewRn05YFVrLVIeHTDXibzZpsPE0DkzisWiHLYtQJ0zmkEXuDEKsGbGProZeTTCLq+SaKzq5USpJD+qcRfomWYKQYSuogbJ6ibtggAbvlkRW7Ys/y4Qsm1bkjj6X4dZwB3ww36XhSJJ/MXCVYll4db3cfIy2A+MuB/zmy8NWG7kHRGjaNaFzjgPcp6X1q0T802lVg1HWvMSsarpogMMz0bG8p6s971rloJe18gZ82oIwk+K6TQScrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwbdrNR8R1JTvKXZe8K3iFihli2LU6JidWMDzcNdY4c=;
 b=KL+ODjMSi7nXYzgNJ7E0oRE8nd7OYvFnnsYRmnZaPSLCJaQf41w2/mS0t9oQOMvEVryu5DdkhWt8E4AKoVxXq6xh3TUQNIcwrELkNvMJqGRlSa1Z/PcfbLWhdyi2bCJUMw0EbNjFP0jXTYNrp0HeJPcJPf5xAJbZm2+rDlWvi+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 SN7PR01MB7992.prod.exchangelabs.com (2603:10b6:806:34a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.27; Thu, 6 Apr 2023 21:52:54 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26%3]) with mapi id 15.20.6277.030; Thu, 6 Apr 2023
 21:52:53 +0000
Message-ID: <cd79df5b-68c4-4825-6c29-e560989a1130@os.amperecomputing.com>
Date:   Thu, 6 Apr 2023 14:52:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     viresh.kumar@linaro.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
 <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
 <d08222bf-fa05-3e3b-18dd-d24ced6c1536@os.amperecomputing.com>
 <4bda6b02-cc50-fa47-c9b6-acda4cf201a8@arm.com>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <4bda6b02-cc50-fa47-c9b6-acda4cf201a8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:610:57::38) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|SN7PR01MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f79384b-5824-4f53-9774-08db36e94609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsUAqmm1BHYhpUCJVpGUEzKzHe0H4oD+URh23ZUkaPnoA6Na12U8W8ADhgQ4hdrWjTfOGRDP4ZPPNAftOHdvu/J/fo+aFuaIVTnckIkD5PFHgE9AjaNx6kzkkGOdiIpldUMAO05+eKiMCnrPnkNPUQprbFj6lUgIxB7MFZjtFeoCHdeufg8oDUV33CXKpUu/ymmUhGAHwltHcceV7IvYDymwV1lXKEsSmdaknRjjZdpTLO8uqel6z1WFEXJRdfO5K+yRm6/EjMviYXDwA6uoADthnz1ijzLQlWbgrrTas+NRPf9ehW+f6wIzHnrMoMd1SEPRylu/qTIoNm0bj6iCgP+9Qm1eNzDyY2gssyxyrj125OsgmVCYCElsLvyOCZOj9UdNLt6t44ocv9zSGhLgjVUKLk88JNOD83JDofWDc3JCp4j3sdvxXm77Jr6wJbXUvKDCq9E0EZTWpwfXCU+QH2uvsxMS1fG24WsSHiiI5B5Srd4mfXhJT+1lzkaD+KmXv+vOQhyjUo5po9S0bLSZ3aWYnJvE+jFdpJqZndRrujSVHlG/N641j93jnl+d4/LNcLpI/gE9yRvzGUjYnqOquh6Qb2gIaEJyehvycTVN9pJjSQ11JWEJW6IADfz6evSbgqKdYAbdYCwObb6xOEm4hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39850400004)(451199021)(38350700002)(38100700002)(5660300002)(66476007)(2616005)(31696002)(83380400001)(316002)(478600001)(86362001)(6486002)(53546011)(6506007)(6512007)(26005)(186003)(966005)(8936002)(66556008)(8676002)(110136005)(41300700001)(4326008)(66946007)(31686004)(66899021)(2906002)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2hpYkR0QlVNK0l2cUdNaXZldDJVcG96WVVvRmU0anFPdU1NOFlrVjVFdVNU?=
 =?utf-8?B?OTlHb3ZkZ1BTWDUyb1FDMVR4bHRhVUpjVkJHUGFWemx6aTVsS1lSb1NwTzli?=
 =?utf-8?B?WnRETko0RTRybTdPNmpUemdiYmtCYk4rTnhBcXBIUi9TT1VyWStvY3BRUmxK?=
 =?utf-8?B?SFBwWFdMZU9GNUplRzRxWGd5dXhNTjFISnN6UGsyTDRoOEJGUjlRR0o3SDJp?=
 =?utf-8?B?VzRNczRIMUI5d1NWc2h4NW56VHN6R01NU01iZzlJSzNJNlZzUWdrYlVUVjV2?=
 =?utf-8?B?ZEdtOWpDNFpSMHBTUzFoRi9PRVhreEVickZYUVljK0JGUXNNQzZGR1g5bzA1?=
 =?utf-8?B?R0VYdWs4eEFNVVZsQ0lEWW5razNpZXlmVzJoeU1ZMW9sSkJ3VEFtT1NtOENo?=
 =?utf-8?B?Z0FDNTFLa3JWYll5T09XRUpJTVE3ZzFueUNIZ25odlFMTUNqa1N2MmwrbFBv?=
 =?utf-8?B?UkZhdVpXaFp3T2dWNTNTNm1qSHdEdTdDTXZNQnBDMmZUTWtFak5Ga2dQREN5?=
 =?utf-8?B?VTd6TE8zNnpOei9FbmF3dXd3ZVZjeWhEcEJVczc2SGhORkZvMzlMMHZlTEl6?=
 =?utf-8?B?eVp4K3VFYk45ZXhhdXlWQlI3RlhrdGFtVmZUUnZQT0Q0MUNLd0VZQzJISmxo?=
 =?utf-8?B?bUVPdzdBektqc0FKSHh0cnpXb3Q5ZkFCMG1YUzJQT3NKRCtNY21ZVjMrNEZo?=
 =?utf-8?B?Mk5sUjRBUGNRMHozQWVsWDdJZUJ6NVRZblhhc25iV2IySXg5UlVSK244SHJn?=
 =?utf-8?B?WVR2WjAxWjBOR2FiWHppUjU5Q0tJRkhjbWNrZ3RIVGJUZTRmR1JmVk5pckZa?=
 =?utf-8?B?bCtoN2IxRnJvMUVuRzRsbE1vUXhRbk4rSWwrcUwxcFMxdmJ6SGhXZ1d5ZnMy?=
 =?utf-8?B?Y2FmcVhpOG5xMHVvNTlXb0JaTmMvMzhuMjVPekI5aGdWb213Rzh4TWZPY1Qy?=
 =?utf-8?B?OW44N3pSb1VsQVNlZW9uaVcrYkp5Tmw1OGhoU09ueU51MlVLYVdjVTRNcHdD?=
 =?utf-8?B?U3JCM0hTMXU0MnFyN1BPeXpkSEkwaFppTlk3RVFXS09pTDErS0dNK1RQZS8r?=
 =?utf-8?B?c0xiYmU5QSt4b1pJVWQ0aHlBcmx0M0JaaUo4N2daZVpmZEhJZFZwcE9PbzVi?=
 =?utf-8?B?TmxXOWJ6RCswcnBFeVFXZS8wV29sbllRRloweklUNlVwSHJCc24rZkJ1VmZJ?=
 =?utf-8?B?WFhTZ1NMaVIrRGVzTFUrY1I1azJyQUZ0YUNoMmg4dWc1UjBxMG1MbWphbTJz?=
 =?utf-8?B?VldnVWc5a0tFYy9ia1RoSmVjMnNxVlRLMnhINFZsek9LSVpMQk5HaW5rV2hl?=
 =?utf-8?B?cjA0cWJwMjVQZ2NLVzgwZFFYMlNRNE0vMzduRVFpd1FRSFNuRXN0cHNuN0Ft?=
 =?utf-8?B?Q1NuRUFEQ0Z1SGxBdlhYZlRNcmZLcjY1amtxbTFnUDU0UTh1czdQN2RMTytX?=
 =?utf-8?B?VXBWbjQ1bE5yRmliWERzeDgxSjdzdDd0QkNZLzJyK2M4YjZDNTlBWmhIbHFF?=
 =?utf-8?B?ajk4UHY3UUxNODRvRDFFWXRyT3JRNm5HSnlDdzZFbkY3TkpsdG1wbEgreHFz?=
 =?utf-8?B?WWVPckpldWNxdGswNkZiMzNOZmx1bmFsR1lLNDlWZy85SHpjeVEyUVNnQVho?=
 =?utf-8?B?Y00wd3BabDBhRFErYUFaNHU3aVg5SnZoZGV2SHZHalp6WWFqcTNhTlhoU0Qy?=
 =?utf-8?B?YVg2UEFnejkxOVBwYVU1am0wQlFTV2VySW5lSllhMEh4TmE5Y1M1SG9CT0lG?=
 =?utf-8?B?NTRJN29CNk5aVWlNTnhkZXBIckc5ZjRYdVgrL2tUWXhpZ2UzcEYydVpkaTcr?=
 =?utf-8?B?TEFTVmxDT1YwSlBUTkVxMTd0bWs2MDFDbktxMVNVb2dRSjM4Y1lTeEQ1VFZ6?=
 =?utf-8?B?OGhMUDNhYlpjTmJYcnEwNlg2a3p2RzFtaDd4Z2ZnVlBvR1JhQSt4SjF0WkZC?=
 =?utf-8?B?RDdDQzFjTGxvc3czNVAvY2JDby9yZHBvZUVTbHBidkEzQ3pDeHBvUE8wa05F?=
 =?utf-8?B?UlprTFladWZmYmlkVW42bzFnVGNsU1Q2Q0x5a1AydVhrYUpCTFlySktKQWpC?=
 =?utf-8?B?Q2lUdStGS0VWV2l6MUROYW44ek45QzlxNmNnUUtiaTczdUJGRXpzQTMvNUZH?=
 =?utf-8?B?MWVPa0xlR3JUNjljRFZ2OUsyMU03Mkp3SDdoOGwxUGJ1N29Lb01zNkRUUEUw?=
 =?utf-8?Q?pbbNbyOiZwXxPVJ8ZLEQbF0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f79384b-5824-4f53-9774-08db36e94609
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 21:52:53.4334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EwHFjBB8n4rY6WiMmJJjJyB5puTaZyG4PJyZ/v+x+O84cMJaIkguNXPSlg2kz4yf/ENP2dQduroKhIS9vj7mr8xGs5F7VD4HZOSVvwjgx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB7992
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/23 10:57 AM, Pierre Gondois wrote:
>
>
> On 4/4/23 21:07, Yang Shi wrote:
>>
>>
>> On 3/29/23 11:43 AM, Rafael J. Wysocki wrote:
>>> On Tue, Mar 28, 2023 at 9:39 PM Yang Shi 
>>> <yang@os.amperecomputing.com> wrote:
>>>> When testing CPPC cpufreq on our platform, we noticed the error may 
>>>> be quite
>>>> high and the high error may happen quite often.  For example, on a 
>>>> platform
>>>> with a maximum frequency of 2.8GHz when the CPUs were fully loaded 
>>>> (100% load),
>>>> we saw cpuinfo_cur_freq may show 4GHz, it means the error is > 
>>>> 40%.  And the
>>>> high error (> 1%) happened 256 times out of 2127 samples (sampled 
>>>> every 3
>>>> seconds) in an approximate 2hrs test.
>>> The description above is a bit cryptic IMV.  For example, it is not
>>> particularly clear what "high error" means.
>>>
>>>> We tried to enlarge the delay, and tested with 100us, 1ms and 
>>>> 10ms.  The
>>>> below is the results.
>>>>
>>>> 100us:
>>>> The highest error is 4GHz, 22 times out of 3623 samples
>>>>
>>>> 1ms:
>>>> The highest error is 3.3GHz, 3 times out of 2814 samples
>>>>
>>>> 10ms:
>>>> No high error anymore
>>>>
>>>> Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to 
>>>> avoid
>>>> high measurement errors.
>>>>
>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>> ---
>>>>    drivers/cpufreq/cppc_cpufreq.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 022e3555407c..c2bf65448d3d 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -851,7 +851,7 @@ static unsigned int 
>>>> cppc_cpufreq_get_rate(unsigned int cpu)
>>>>           if (ret)
>>>>                   return ret;
>>>>
>>>> -       udelay(2); /* 2usec delay between sampling */
>>>> +       mdelay(10); /* 10msec delay between sampling */
>>> This function can be called with interrupts off, so it cannot spin 
>>> for 10 ms.
>>
>> Per Pierre's comment, the delay may still be ms. Is it still too long? A
>> quick look at the code shows cpufreq_quick_get() is the only caller with
>> irq off IIRC. So can we have another callback for it, for example,
>> get_quick() which does spin for shorter time (for example, keep 2us
>> delay). Then have ->get() callback use longer delay?
>
> -
> According to the same ACPI 6.5 s8.4.6.1.2.5 "Time Window Register" 
> paragraph,
> and assuming we are in the 'Autonomous Selection is not enabled' case,
> the OS is supposed to write (not read) the delta between successive 
> reads of the
> counter, so using this field as is would be bending the definition I 
> think.
>
> -
> It is correct that the "Time Window Register" field specifies a value 
> in ms,
> but it seems a long time to wait for with irqs off.

AFAIK, our platforms don't support "Time Window Register".

>
> -
> Theoretically, the perf/ref counters should accumulate to allow computing
> a correct frequency. Is it possible to know how these counters are 
> accessed ?
> Is it through PCC channels and there is some undesired delay between the
> reads of the perf/ref counters ?

The counters are implemented via mmio instead of PCC channels. So the 
cpc_read() calls should go to ACPI_ADR_SPACE_SYSTEM_MEMORY IIRC.

>
> -
> About making the delay:
>     max(cppc_cpufreq_get_transition_delay_us(), Time Winder Register)
> I think it would be good to know why the values of the counters
> don't accumulate correctly, ideally by getting a trace where a frequency
> above the maximum frequency is computed, and with the timestamps at which
> the counters are read.
> If the values are coming from PCC channels / the firmware, it might be 
> difficult
> to get.

I wrote a bpftrace script to trace the below data:
     - The CPU number
     - The frequency
     - The start and end timestamp of the first cppc_get_perf_ctrs() call
     - The duration/latency of the first cppc_get_perf_ctrs() call
     - The start and end timestamp of the second cppc_get_perf_ctrs() call
     - The duration/latency of the second cppc_get_perf_ctrs() call

The typical logs look like below.
Good
CPU: 1
Freq: 2801485KHz
First:  2489382384  2489387084 4700ns
Second: 2489390824  2489394024  3200ns
--------------------------------------------------
CPU:    2
Freq:   2797956KHz
First:  2490406524  2490411204  4680ns
Second: 2490414764  2490417684  2920ns

Bad:
CPU:    55
Freq:   3969372KHz
First:  875659868  875721568  61700ns
Second: 875725148  875727708  2560ns
--------------------------------------------------
CPU: 65
Freq: 3829744KHz
First:  3854951136  3854995896 44760ns
Second: 3854999416  3855002696 3280ns
--------------------------------------------------
CPU: 21
Freq: 4279242KHz
First:  240834204  240910484 76280ns
Second: 240914264  240916944  2680ns


The first line is cpu number, the second line is frequency returned by 
cppc_cpufreq_get_rate(), the third line is the start and end timestamps 
and duration of the first cppc_get_perf_ctrs(), the fourth line is the 
start and end timestamps and duration of the second cppc_get_perf_ctrs().

So per the log I think we can tell basically the longer the duration the 
higher the error. The 2us delay is not long enough to offset the impact 
from unexpected latency of reading the counters.

In the worst case the frequency is 4279242KHz, comparing 2800000KHz the 
error is over 50%. So the delay should be 4ms ~ 5ms in order to offset 
the impact from reading the counters if I do the math correctly.

Hope the trace data is helpful to diagnose the problem.

>
> Just for reference, the value of 2us was picked in this thread:
> https://lore.kernel.org/all/ac2eb509-c1b0-521a-07e5-2bf8eaaa55c2@codeaurora.org/T/#u 
>
>
> Regards,
> Pierre
>
>
>>
>>
>>>
>>>>           ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>>>           if (ret)
>>>> -- 
>>

