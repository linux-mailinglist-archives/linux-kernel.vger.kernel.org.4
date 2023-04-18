Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287926E6C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjDRSZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjDRSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:25:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CAF659B;
        Tue, 18 Apr 2023 11:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byNKH9fMr3lXMhVx2dDEIyF75WFfGqRNZTq8Ej77P6TPSgkwng30/rAw1wZdEOv9LBUPk0cOwEyLeO6ZNRWatkZat6YChKz73suOhATFrfZpKaXhcz+aPScU6dDmm4o6S4PCu5QssIYZyHa/oW2VrLIL9ab/IAXb3dj57NivZdkyjnqwDIecMOljasY1sn+bEoUP1qZuR2jFuaRTnCcUSWnQ3VwEy5kmRtRqivKplXo0lerToDdibwUw+tSr8S8UBI6ShJbkWFNo0NxUlKkgA72EHBPkg7nw7jb7ImjsXzDRDYGotttZ1Ym+YBGy4bB2WGAzoG8CqxU8HxzbMaUobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mlx5iXVX8pBfl7lUzXyaJ4ZiLsLnzPXyXY4mvdiHdRo=;
 b=BeRBAizxZLsRfpe4iSrxCMT3PXsP8aUlFG0dKr0bTeVjLDcWPwuUYSG4IPtuhsmkFXduCIc5fajry5o6nPF61nRr8Fq6+DcAVjPdSZ7xN97XUaw6CROvzI1fLJe8ByUGlfAB1c5jySKvqjEeoPzHbWrCMtvePO3n2fAaukPZj3slTkwat6BnNVV1G3yMbJZsI/UqzFH+JK06VZ+Nncr7+hYuYGDQZX+jstoT3RM81if2ePX6DA2Oki15q4wdtfDd76mSaegYkc+56ZFep+DQcW4YCg8QP5ceuG3VjpivQMTSN4GHAiqVnVccfS6tqdOjlNR2W9okM7JENCrHLBReRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlx5iXVX8pBfl7lUzXyaJ4ZiLsLnzPXyXY4mvdiHdRo=;
 b=m7YbzEy49obnOjsBtgVZ+C/C4esiX4h2bDWfa7ZFAX+nwpNNj4RxcGnySNUxnlHBDQDMEGyLSsDrkvD0BKXHz9+EWh8MphvHkwta+sX0+DzDC8iWtmFgzIPdkftGlJNnKFlDuBI3aFgUwY5Y9cyDoFE51MwynOZsb9U2jvbRFoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 CY4PR01MB2646.prod.exchangelabs.com (2603:10b6:903:e9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20; Tue, 18 Apr 2023 18:25:00 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a%5]) with mapi id 15.20.6319.020; Tue, 18 Apr 2023
 18:24:59 +0000
Message-ID: <7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com>
Date:   Tue, 18 Apr 2023 11:24:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
From:   Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
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
 <3e239024-91d8-ea06-25a4-631496576319@os.amperecomputing.com>
 <d287eff6-77bd-693c-96d3-87d8981b7f96@arm.com>
Content-Language: en-US
In-Reply-To: <d287eff6-77bd-693c-96d3-87d8981b7f96@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0037.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::12) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|CY4PR01MB2646:EE_
X-MS-Office365-Filtering-Correlation-Id: 179c12d2-95d0-4cd7-c9d2-08db403a381b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sARpKeoouEmGkDMQ+1UqH/Xu0XobeZ+74Lrqb/Y/+gTLady2tV3FFaV5XjUgpU8nss2atMML0rnzUpN8p+9ZB9myhb8DCVqoakHQgdTPZveNLyoXMzEYhWipglLEwOIuXHrzsf6dZdw9NVg9bNAAmYpHgzpqOkXbv/K84oxqxT0AYkhIBdO/SrLoUIgRbSYGKpxBZ98kJQtO4p+NswzSdAlF17jwdp81fBH0Qw/fFgl4gUA1UKNS0L/7KK0P/rhVOWsLOSD/AFngIVH18ZzbR0bxi2kCmXwl5jxaqvO+VWNylz6dfuvovibhaBYDAN6L0vl2x+Byi3hh8w7e8RK7Tkg7BAGB/j5j4cfzWSj7xIsoxHW/RoIqrfIAyFOm+EP+zFJvDBKwC4tmCb8AWPXmaAJeUQ1ynHQ2ubPAe/+hUACm6/pPbplh7NOsrCFTz+z9PsWo9pAC0ZAH1eLmuRrRuW+sR9elRFUQV4qrvJlfJhltV0S14ppVc5gz0ewg7WWgUkJSVc2snisvonlyZl1D2KIhbP6gWd30+MCyG5mjPP/uLZReN1lFpUXA61SFr7ked681I2Dm7TWgY6HdtbWM+bTQpQtUKsyTOn2KeAKWc+WS1B+oyE5nIhiAlSb0zLlh23YH7an1N5VEoJgqzfuG6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39850400004)(366004)(396003)(376002)(451199021)(186003)(2906002)(30864003)(66899021)(478600001)(2616005)(6666004)(52116002)(6486002)(41300700001)(316002)(6512007)(31686004)(83380400001)(66476007)(66556008)(66946007)(4326008)(6916009)(26005)(53546011)(5660300002)(6506007)(86362001)(31696002)(38350700002)(8676002)(38100700002)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVNelUxeXJ0bTNVWHRTMThMQlVqUlRBcTJ4dW5QOXhTaTdJc3pzOTRyckVx?=
 =?utf-8?B?MWVhVUVOQ3RoV2J1YjVYWWpEcDZkRU1aWDkwd2p0TVZ5eHpTOFU0djZUOVdI?=
 =?utf-8?B?SjUvTWtySkJtY0srMGR6OWdaYTNIVEhSb0RXNEZQRTNCa0kwb09XNEY3akkv?=
 =?utf-8?B?bmZMYkF1MDFtWFhKYlc1Wi9rQm1yNkprWDlsNy9UdFVBMUsrRjNtamVTMGpM?=
 =?utf-8?B?SGlaK3BrVUM5MUViUEdnL01YYWwxcVM2RzRvYzlVNXRiWkZYcnk1MEVyai9k?=
 =?utf-8?B?MU90RldDVVVhZkFhL1g0T2hTcTJ5Uzc2K0pmaDdCQytVNlZpcDJ3Qnk1YzZh?=
 =?utf-8?B?YzErbzVadHg5SUdyRStWeDQ0S0txWmlNbmo5c09xczNocUllWWlpODNmMTNi?=
 =?utf-8?B?cUM1eldFU2hiSFdCWXk5MHB2NVBOellkN3pjMVlEUFh4bUtPVk9QSjlZV0xK?=
 =?utf-8?B?YzVxRmNhUDJ3bnFiaHBnL2tnNC92UWlQYzRJTzB1VWhaMXBxVTJ6ZXF1c1ly?=
 =?utf-8?B?aEp0MC9QNW84dDVLcERjSUFESHN6OFYvWXR5WGovVk5RaGs2KzJrVFRtem4r?=
 =?utf-8?B?clNkeXhHcHdGUUo2SExkcGd1NXN0M0IyVzZwNnlLUmRrVzR2WUkrQjZMSFlK?=
 =?utf-8?B?MFlXbFA5RFJuaEJDYjRzYWxIck8vNXBZTnl4cEpWTFRPWmM5c0ZwaVBLOHFB?=
 =?utf-8?B?TnhFQ3RKc29HVnBvcHdESDBsTDFnUmdWUXMwU3lNeVhsbkpnb0VkeFdRYUI4?=
 =?utf-8?B?TnpGSVJjeFk4eEM3ekk5SUswU0g4ZlZTS3liRHRGUERFdkVKL3NiL0RoNjRl?=
 =?utf-8?B?TTI0cFJyVVVhOHg1eU9UYUMwbXg4SzZ2Z0ViSlBvSG5xb1BtcGNWUlk4Z2ht?=
 =?utf-8?B?dThENXlHUng1QmZ3cUp1VHpWVWs3eXlBTGRwdnY0Z1JRTyt4WE1RWGR2OUNL?=
 =?utf-8?B?aHRpSEozakkzcGYwZWRkVEZVaUVwYVdOOHErYTFEczQ2TEloYkZBOHY0Z2Jt?=
 =?utf-8?B?UkY0WDA2RVVKV1ZzeUc1WXhJckRYdnY4UC8rL0Y1S24vT0ZpMjUrS2pHdEdO?=
 =?utf-8?B?cVM4TnhQZWhmcHQvOUVkclVEWC9nQXkydXgvOVdTRUh6RWZaOE4vQ3lBZVhy?=
 =?utf-8?B?YktQcGxSa2JFdWxuRjVVajA4SmRxbUlzSlB4bW1yZHpuOUZrMDRJbUdINnha?=
 =?utf-8?B?TDlxVHJ2ZjFHY0tuVGV4eXc0dlVGKzkya0M1d3dMb3ZhMU9wbmhLc0ZudU95?=
 =?utf-8?B?SDY0RTVnemJLTkZHbG9hUlR3eVNBTkNGWllFUnBGR05oTmRVOHhaYWtxdE5U?=
 =?utf-8?B?ZzRwWFcvNFdrdzdYOEh2Y29ocTJYdWhvLzdva2RQOEpKZmVLMllHaTkzeGlQ?=
 =?utf-8?B?VzArMDBJa1FaaEYrVDRSSmY0dE9mcTRlMm4xakV3L2VETURQbitPRVN2OUVC?=
 =?utf-8?B?R1l4dHh3MTAycXVWUDRQMWc2UXVlTythRGo3bXJpLzVVNlVjTGpaR2ROOHZB?=
 =?utf-8?B?WkR5WHdKNnMzbmRSVm5DQmUraTZoMU9zc2tPYThIVmJQanRlK2hUdFZLUjh3?=
 =?utf-8?B?b0dRVUcxM2pucVJOMjlCWitudHpyVzl2b3pQa2xVT25Gd3c1azRyaWRjTXdH?=
 =?utf-8?B?bjRYOXMrNzdnMU1IdzJuaGhCTHF5QTlyajg1L1hoc0NZcTkxaG5ZMmJoOU1l?=
 =?utf-8?B?QzZpQWhYWDN6WEg5T2ROQTdFc3liL3B6TThQOTlpU0g0UVFlTzNrSGMxK3ZL?=
 =?utf-8?B?ZVp0blhyLzhYZGtvYStqNzZwVkFNNnljbmZIdXVTQ1g0UDJRKzU3dVptbHRS?=
 =?utf-8?B?ZlVHMGFDdlpNQkkxeUt1RGVOMVI4U2xpRmFFOENWMWpDYit4WDlhTTdCM0t2?=
 =?utf-8?B?b1VxK2FOc1FBM2VHVnpYUktLME8yY0E2TWNEVDd1ekRXbFQ4dEx5ZTlldE5s?=
 =?utf-8?B?S1FMMnppaFFQbFJvYzJQbVFoZTdRdVQ5eCs0Z1hIbExlYXZjY1JrOUdsREJh?=
 =?utf-8?B?UEIwaFZRM0tNNkhtWlc0aGtYVmdDQ0NHZjI0ZTNTekxsSmdXL2dsaGkxeFdB?=
 =?utf-8?B?dkJhY2RrUHBQOTIwcmFBbVlBU0FCQW04RzRDLzd2Z0RsUVp4UnZseDBQYWcx?=
 =?utf-8?B?ZTdUblJzU0ZPR256SzZKWGNxQjBQKzd6S3FLL0U3bE5QdktKbXFLb0U0UDMr?=
 =?utf-8?Q?N8iYP+sIGX7yjHOfr8gszlY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179c12d2-95d0-4cd7-c9d2-08db403a381b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 18:24:59.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AiggSM2D6XvP6Zm/svL0HxdvZ2XUSfQgq7grlLZdZFXvt1+6rt+RtW8ymsaMc26wbZslf8lMF2wGczT/7cNJJGWp7PGhBxWQc4veBg3iyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2646
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/23 1:51 AM, Pierre Gondois wrote:
> Hello Yang,
>
>>>>>
>>>>> -
>>>>> According to the same ACPI 6.5 s8.4.6.1.2.5 "Time Window Register"
>>>>> paragraph,
>>>>> and assuming we are in the 'Autonomous Selection is not enabled' 
>>>>> case,
>>>>> the OS is supposed to write (not read) the delta between successive
>>>>> reads of the
>>>>> counter, so using this field as is would be bending the definition I
>>>>> think.
>>>>>
>>>>> -
>>>>> It is correct that the "Time Window Register" field specifies a value
>>>>> in ms,
>>>>> but it seems a long time to wait for with irqs off.
>>>>
>>>> AFAIK, our platforms don't support "Time Window Register".
>>>>
>>>>>
>>>>> -
>>>>> Theoretically, the perf/ref counters should accumulate to allow
>>>>> computing
>>>>> a correct frequency. Is it possible to know how these counters are
>>>>> accessed ?
>>>>> Is it through PCC channels and there is some undesired delay between
>>>>> the
>>>>> reads of the perf/ref counters ?
>>>>
>>>> The counters are implemented via mmio instead of PCC channels. So the
>>>> cpc_read() calls should go to ACPI_ADR_SPACE_SYSTEM_MEMORY IIRC.
>>>>
>>>>>
>>>>> -
>>>>> About making the delay:
>>>>>       max(cppc_cpufreq_get_transition_delay_us(), Time Winder 
>>>>> Register)
>>>>> I think it would be good to know why the values of the counters
>>>>> don't accumulate correctly, ideally by getting a trace where a
>>>>> frequency
>>>>> above the maximum frequency is computed, and with the timestamps at
>>>>> which
>>>>> the counters are read.
>>>>> If the values are coming from PCC channels / the firmware, it 
>>>>> might be
>>>>> difficult
>>>>> to get.
>>>>
>>>> I wrote a bpftrace script to trace the below data:
>>>>        - The CPU number
>>>>        - The frequency
>>>>        - The start and end timestamp of the first cppc_get_perf_ctrs()
>>>> call
>>>>        - The duration/latency of the first cppc_get_perf_ctrs() call
>>>>        - The start and end timestamp of the second
>>>> cppc_get_perf_ctrs() call
>>>>        - The duration/latency of the second cppc_get_perf_ctrs() call
>>>>
>>>> The typical logs look like below.
>>>> Good
>>>> CPU: 1
>>>> Freq: 2801485KHz
>>>> First:  2489382384  2489387084 4700ns
>>>> Second: 2489390824  2489394024  3200ns
>>>> --------------------------------------------------
>>>> CPU:    2
>>>> Freq:   2797956KHz
>>>> First:  2490406524  2490411204  4680ns
>>>> Second: 2490414764  2490417684  2920ns
>>>>
>>>> Bad:
>>>> CPU:    55
>>>> Freq:   3969372KHz
>>>> First:  875659868  875721568  61700ns
>>>> Second: 875725148  875727708  2560ns
>>>> --------------------------------------------------
>>>> CPU: 65
>>>> Freq: 3829744KHz
>>>> First:  3854951136  3854995896 44760ns
>>>> Second: 3854999416  3855002696 3280ns
>>>> --------------------------------------------------
>>>> CPU: 21
>>>> Freq: 4279242KHz
>>>> First:  240834204  240910484 76280ns
>>>> Second: 240914264  240916944  2680ns
>>>>
>>>>
>>>> The first line is cpu number, the second line is frequency returned by
>>>> cppc_cpufreq_get_rate(), the third line is the start and end 
>>>> timestamps
>>>> and duration of the first cppc_get_perf_ctrs(), the fourth line is the
>>>> start and end timestamps and duration of the second
>>>> cppc_get_perf_ctrs().
>>>>
>>>> So per the log I think we can tell basically the longer the 
>>>> duration the
>>>> higher the error. The 2us delay is not long enough to offset the 
>>>> impact
>>>> from unexpected latency of reading the counters.
>>>>
>>>> In the worst case the frequency is 4279242KHz, comparing 2800000KHz 
>>>> the
>>>> error is over 50%. So the delay should be 4ms ~ 5ms in order to offset
>>>> the impact from reading the counters if I do the math correctly.
>>>>
>>>> Hope the trace data is helpful to diagnose the problem.
>>>
>>>
>>> Thanks for the data. I was thinking the following was happening:
>>>
>>>   cppc_get_perf_ctrs()[0] cppc_get_perf_ctrs()[1]
>>> /                    \ /                         \
>>> ref[0]    delivered[0]                    ref[1] delivered[1]
>>>    |            | |                  |
>>>    v            v v                  v
>>> ---------------------------------------------------------------------->
>>> time
>>>     <-delta[0]-> <-------------2us------------> <----delta[1]---->
>>>
>>> If delta[0] is really different from delta[1] like above, then the
>>> reference and delivered counters would have accumulated during 
>>> different
>>> intervals, resulting in a wrong frequency.
>>
>> Yeah, it looks like so.
>>
>>> If more/less than 2us elapse between the two cppc_get_perf_ctrs() 
>>> calls,
>>> then it shouldn't have any impact. So waiting ~10ms should 
>>> theoretically
>>> not solve the issue.
>>
>> I'm not sure whether the 10ms delay really resolved the issue, but it
>> did reduce the magnitude of the error.
>>
>> BTW, I don't see irq is disabled when reading cpuinfo_cur_freq, so it
>> looks like interrupts could easily result in the difference between
>> delta[0] and delta[1]. And it seems like the difference matters.
>
> Ok, maybe disabling irqs would have an impact ?

Yes, I ran some tracing to try to capture what happened when we saw high 
error. And it seems like IRQs is one of the contributing factors. 
Interconnect congestion is also a contributing factor. The below trace 
data supported the conclusion.

4081929KHz
# tracer: function_graph
#
#     TIME        CPU  DURATION                  FUNCTION CALLS
#      |          |     |   |                     |   |   | |
13378.411863 |     0)               |  cppc_cpufreq_get_rate 
[cppc_cpufreq]() {
13378.411864 |     0)               |    cpufreq_cpu_get() {
13378.411865 |     0)               |      _raw_read_lock_irqsave() {
13378.411865 |     0)   0.680 us    | preempt_count_add();
13378.411867 |     0)   2.020 us    | }
13378.411868 |     0)               | _raw_read_unlock_irqrestore() {
13378.411868 |     0)   0.520 us    | preempt_count_sub();
13378.411869 |     0)   1.340 us    | }
13378.411869 |     0)   5.160 us    | }
13378.411870 |     0)   0.440 us    | cpufreq_cpu_put();
13378.411871 |     0)               |    cppc_get_perf_ctrs() {
13378.411872 |     0)               |      cpc_read.isra.0() {
13378.411874 |     0)               |        irq_enter_rcu() {
13378.411874 |     0)   0.460 us    | preempt_count_add();
13378.411875 |     0)   0.660 us    | irqtime_account_irq();
13378.411876 |     0)   2.480 us    | }
13378.411877 |     0)               |        do_interrupt_handler() {
13378.411877 |     0)   ==========> |
13378.411877 |     0) + 49.260 us   | gic_handle_irq();
13378.411877 |     0)   <========== |
13378.411928 |     0) + 51.000 us   | }
13378.411928 |     0)               |        irq_exit_rcu() {
13378.411929 |     0)   0.540 us    | irqtime_account_irq();
13378.411929 |     0)   0.420 us    | preempt_count_sub();
13378.411930 |     0)   0.640 us    | ksoftirqd_running();
13378.411931 |     0) + 16.680 us   | do_softirq_own_stack();
13378.411948 |     0)   0.440 us    | idle_cpu();
13378.411949 |     0) + 21.200 us   |        }
13378.411950 |     0) + 77.480 us   |      }
13378.411950 |     0)   0.740 us    |      cpc_read.isra.0();
13378.411951 |     0)   0.440 us    |      cpc_read.isra.0();
13378.411952 |     0)   0.660 us    |      cpc_read.isra.0();
13378.411953 |     0) + 81.980 us   |    }
13378.411954 |     0)               |    __delay() {
13378.411954 |     0)   0.580 us    | arch_timer_evtstrm_available();
13378.411956 |     0)   2.460 us    |    }
13378.411956 |     0)               |    cppc_get_perf_ctrs() {
13378.411957 |     0)   0.540 us    | cpc_read.isra.0();
13378.411958 |     0)   0.520 us    | cpc_read.isra.0();
13378.411959 |     0)   0.420 us    | cpc_read.isra.0();
13378.411959 |     0)   0.440 us    |      cpc_read.isra.0();

The above trace data captured IRQ when cppc_cpufreq_get_rate() returns 
4081929KHz.

3052367KHz
# tracer: function_graph
#
#     TIME        CPU  DURATION                  FUNCTION CALLS
#      |          |     |   |                     |   |   | |
19177.226497 |     0)               |  cppc_cpufreq_get_rate 
[cppc_cpufreq]() {
19177.226498 |     0)               |    cpufreq_cpu_get() {
19177.226499 |     0)               |      _raw_read_lock_irqsave() {
19177.226499 |     0)   0.600 us    |        preempt_count_add();
19177.226500 |     0)   1.820 us    |      }
19177.226501 |     0)               | _raw_read_unlock_irqrestore() {
19177.226502 |     0)   0.480 us    |        preempt_count_sub();
19177.226502 |     0)   1.260 us    |      }
19177.226503 |     0)   4.780 us    |    }
19177.226503 |     0)   0.420 us    |    cpufreq_cpu_put();
19177.226504 |     0)               |    cppc_get_perf_ctrs() {
19177.226505 |     0)   0.720 us    |      cpc_read.isra.0();
19177.226506 |     0)   1.180 us    |      cpc_read.isra.0();
19177.226508 |     0)   0.400 us    |      cpc_read.isra.0();
19177.226508 |     0)   0.600 us    |      cpc_read.isra.0();
19177.226509 |     0)   5.240 us    |    }
19177.226510 |     0)               |    __delay() {
19177.226510 |     0)   0.520 us    | arch_timer_evtstrm_available();
19177.226512 |     0)   2.420 us    |    }
19177.226513 |     0)               |    cppc_get_perf_ctrs() {
19177.226513 |     0)   0.540 us    |      cpc_read.isra.0();
19177.226514 |     0)   0.540 us    |      cpc_read.isra.0();
19177.226515 |     0)   0.400 us    |      cpc_read.isra.0();
19177.226516 |     0)   0.440 us    |      cpc_read.isra.0();
19177.226516 |     0)   3.660 us    |    }
19177.226517 |     0)   0.780 us    |    cppc_cpufreq_perf_to_khz 
[cppc_cpufreq]();
19177.226518 |     0) + 23.320 us   |  }

The above trace data shows some cpc reading took a little bit longer 
than usual. I suspected it was caused by interconnect congestion.


So it looks like IRQ is the major contributing factor of high error 
(4xxxxxx KHz), interconnect congestion is the major contributing factor 
of low error (3xxxxxx KHz).

So I did the below test:
1. Disable IRQ: The high errors were gone (> 3700000KHz), but low errors 
were still seen.
2.10us delay: The high errors were still seen.
3. Disable IRQ + 10us delay: all the errors were gone.

I think the test result also supports the tracing data.


I also got some confusion about calling cppc_cpufreq_get_rate() with irq 
disabled. Rafael thought 10ms delay is too long because the function may 
be called with irq disabled. But a deeper look at the function shows it 
should *NOT* be called with irq disabled at all.

First, if pcc channel is used, cpc reading may take over 100ms, it is 
way larger the proposed 10ms delay.
Second, reading from cpc channel needs to take a semaphore, so it may 
sleep. But sleep with IRQ disabled is not allowed.
Third, if the counters are implemented by AMU, cpc_read_ffh() needs to 
send IPI so it requires IRQ enabled.

>
>>
>> And the counters are accessed through an interconnect on our platform,
>> so the interconnect congestion may result in the difference as well.
>>
>>>
>>> freq = ref_freq * (delivered[1] - delivered[0]) / (ref[1] - ref[0])
>>>
>>> If the counters are accessed through mmio, I don't see anything that
>>> would
>>> make delta[x] vary when calling cppc_get_perf_ctrs(), cf. cpc_read().
>>> Do you know if the address represents real counters or a place in 
>>> memory
>>> representing something else ?
>>
>> The address does represent real counters.
>
> Oh ok, is it possible to know what is there ?

AFAIK, it is memory mapped access to the core's AMU counters.

>
>>
>>>
>>> Would it be possible to try setting the CPU frequency to one unique 
>>> value
>>> and get a serie of values like:
>>> [timestamp, ref_counter_value, deliverd_counter_value]
>>
>> Could you please elaborate regarding "setting the CPU frequency to one
>> unique value"? What value is unique?
>
> I meant having the CPUs using only on frequency. The following should 
> work:
> cat /sys/devices/system/cpu/cpu[X]/cpufreq/scaling_min_freq > 
> /sys/devices/system/cpu/cpu[X]/cpufreq/scaling_max_freq
>
>>
>>>
>>> This would allow to check that the counters are accumulating at a valid
>>> pace. Also you said there were frequencies above the maximum value, but
>>> are there also frequencies below the minimum value ?
>>
>> I've never seen the frequency below the minimum value.
>
> Maybe this is because the CPUs are running at their maximum frequency,
> so when the computed frequency is below the actual running frequency,
> it still doesn't go below the minimum frequency.
> Meaning that if the CPUs were limited to their lowest frequency (with
> the command above), maybe the get_rate() function would return values
> in a range [[1]:[2]]:
> - [1]: frequency below the lowest frequency
> - [2]: frequency above the lowest frequency, but below the maximum
>   frequency of 2.8GHz

Yes, with writing scaling_min_freq to scaling_max_freq, I can see the 
frequency was lower than min freq (1000000KHz) occasionally.

>
> Would it be possible to do the following:
>
> # Shut down all the CPUs except the last one just to have less logs
> for i in /sys/devices/system/cpu/cpu[0-9]* ; do echo 0 > $i/online ; done
>
> cd /sys/kernel/debug/tracing
>
> # Add a kprobe to cppc_cpufreq_get_rate to get the computed freq
> echo 'r:myretprobe cppc_cpufreq_get_rate $retval:u32' >> 
> /sys/kernel/debug/tracing/kprobe_events
> echo 1 > events/kprobes/enable
>
> # Setup ftrace to trace cppc_cpufreq_get_rate() calls
> # (and maybe see if something undesired happens in the call)
> echo function_graph > current_tracer
> echo funcgraph-abstime > trace_options
> echo cppc_cpufreq_get_rate > set_graph_function
>
> # Do the tracing
> echo 1 > tracing_on
> # Wait a bit for a call to cppc_cpufreq_get_rate() to happen
> echo 0 > tracing_on
>
> Also adding the following in cppc_perf_from_fbctrs() should allow
> tracking the counter values:
> trace_printk("get_cntrs: ref0=%lx ref1=%lx del0=%lx del1=%lx",
>     fb_ctrs_t0->reference, fb_ctrs_t1->reference,
>     fb_ctrs_t0->delivered, fb_ctrs_t1->delivered);

Sorry I forgot to ask whether I shall run the tracing for the lower than 
min frequency case or not? Since the latency of reading cpc is quite 
small (sub microsecond), so it is quite sensitive to extra 
latency/delay. It seems like the overhead of tracing is not negligible.

I got some data with higher than max frequency.

Good:
  159.077799 |     0)               |  /* get_cntrs: ref0=1513476688 
ref1=1513482268 del0=329890515 del1=329905431 */
  159.607913 |     0)               |  /* get_cntrs: ref0=1137490668 
ref1=1137496188 del0=3198347141 del1=3198362993 */

Bad:
4965.786566 |     0)               |  /* get_cntrs: ref0=766025872 
ref1=766034192 del0=2288598970 del1=2288624170 */
5251.933966 |     0)               |  /* get_cntrs: ref0=2472241696 
ref1=2472250376 del0=1156772954 del1=1156799208 */

Hopefully this is helpful.

>
> Regards,
> Pierre

