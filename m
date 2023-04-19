Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAE76E82D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDSUkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDSUkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:40:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2124.outbound.protection.outlook.com [40.107.92.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624645B89;
        Wed, 19 Apr 2023 13:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQhp0XBT/7NytXAbTBBFJUJ/nd9wPjSdz8g/L2/Eh2QGGnuBRvAycfqaD94MUP/M6gtD/AuJn2d+5QcefDtEI0ihE7ub2Chv3lFCRUKh4ZCS9WwR+M3SSRwhT5gOX9L7yYRm0jPWDhQQcXlOR5AfiVyF/Hw8/Dq0yC+70bs2taCXOUBwLsJJJ87GBX61+1vjCT5kolb7xfkU+hpi13pWIf5ZCgTaYYCbu5iqJORLmunR/o+TmBU50o5cwAucLbSBO94SNzeceJpxGRA1tHz0wq8ehYaXMiXaEqlKacvkivJjDwsDqwn1bIaqcsjqnvn0IUmc1EMPDDA3bhIeZCcPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjUQKycz3NYtOJWOY02+oGhJuQ6/oRwqUvz6yzX9q18=;
 b=ZNYne3Hv7KoAf8yfLJiDfwG9p4GXZV42BKPbeAZs2uP3wIFBLaUcGxMs3xEfNub/DBahEmdndMoPNK28H4XLUufndiTLQlVpxxaB7AtICs5ifNrG9gX31EM+fTIM1svyh/Fc84SUkROr+wgX3a5hZPqcnkazY1NqwqWLVz+f1CPLgYW/FRZuWYkkxOdG5fMZJNxaF/NWgb4S2vG+cNadvcqeuasbdbT6EZIbobi8/jLP7GO4FMRQOszDqbFW2EFijgBzxvUg+HpEPGTsqG7uR296Rgdrl3Y1DKq3NFXAax+3r2ZdgpZOr25WVWbMmMVuMyqnjpHvTmOX1yejCJkjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjUQKycz3NYtOJWOY02+oGhJuQ6/oRwqUvz6yzX9q18=;
 b=k7rY6V9IOS2iphVvPaMzRpWB5NwzeRY5pjAqkj1XsoLFyPIYqGgXu1oAfZFXQSd7svKpYN2A9b3fJeVr7kg/VeYX2SDkfXVIFjB4DVDzmBEKG3b0QLd8VgvtoBddvR92CXgdIBSmZJOuTJvJZXY8q4FJchLn4+NElLoCrLjjPPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 DM6PR01MB5929.prod.exchangelabs.com (2603:10b6:5:1dc::32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20; Wed, 19 Apr 2023 20:40:29 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a%5]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 20:40:29 +0000
Message-ID: <1ce09fd7-0c1d-fc46-ce12-01b25fbd4afd@os.amperecomputing.com>
Date:   Wed, 19 Apr 2023 13:40:23 -0700
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
 <7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com>
 <a2924821-80b9-e68f-3ae4-7a2c989afc88@arm.com>
Content-Language: en-US
In-Reply-To: <a2924821-80b9-e68f-3ae4-7a2c989afc88@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:610:53::25) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|DM6PR01MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 489a889f-2216-45a0-fb0e-08db41164ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12KZMYh7LhNQh+yxipQ3KJoX6firhaXDQlfUXWTJ5AkQdF9Kfk5Qlyg7afpPPA+sEGd2JPMuSjZ+huenvKfv6E/gfaQpqQCDB6I1URmvs8YI/4SHBiTSYYTVFYLd1ZeotXN8VTP5YivUkORYuVo/9sF+M25mGiNCcAExk8VE46BJ3KpM+1jAL4B+NwwhmfHBSujhtRkDiaZPKUj3PD9+Brp7fp8zOuYoDmNwCGaU2WiX1D8PmB0Bzhwt23ExQjlm3u4BZoH6hJdcD2rK6mPDUYOueWQCrtBpLYgCCt+CkfgXHUxXMUp0U3Bu7RpJe8WUaskq0EqacO0iyZOvGLuF3IIr/jDzN2b8zpd/gRzNToWmjv0ZO9B7jv4xRTrq7V73oK8ACbpULFmmBAcsKvJN+llfbwt+a5N2yA9ryzz4o/uDYrLeXOs9yOF6M5JgDJbqDPnbgi8BciCLVx2ZA0YmV1WNqa6JUn9i3h11F/MZ2FIdihpEXd0dYbFvwJsplCSUcHZq3POspNNRPmvmD9QllkvUuapTULmdTgvL0troa8Ad+WcTkzMhqdqDIWwUViJ7t3CRR5J4zn1Ys/Znuuzd1IzSAERtDH03M/MGgWNvBRpOXdonUxzfqZ3R6SV6LPcJGxNMj5NskX0HBDZX/LJGKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39850400004)(346002)(396003)(366004)(451199021)(186003)(6916009)(4326008)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(52116002)(6666004)(8936002)(8676002)(5660300002)(41300700001)(30864003)(2906002)(86362001)(38100700002)(38350700002)(2616005)(26005)(6512007)(53546011)(6506007)(83380400001)(31696002)(31686004)(66899021)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkpiSHhGb1RVKzlva08waUp0UDJLTE1QYWRwWi9HTDRINjJyME9Sb2VyVzBy?=
 =?utf-8?B?dUFCcUdmODU2b1V0Z3BTSy9sQzhKbkNIZTEvTll4SmRvOG5rUVJVRWVxdTNY?=
 =?utf-8?B?djZIM0FrYkVnV1VVcjZoWXBvWmNyTGxiNzg4YjJ1VGh2R3d4ZGd0dmUwcjNv?=
 =?utf-8?B?LzRnWmxTVkg0QktqelVtbUZkUWxGRWtTeWxKWXovR1JYczVRMjFWbTBpL0JT?=
 =?utf-8?B?OWJ1RndIMTBscGFGU01SU2RIYTlEeVc0RGthbTJDTjEray9tRlMxQm9LNkdv?=
 =?utf-8?B?b2tkVWJQV0s1MENsVkpqdzhaSmdZQ1JDeE1SUVZZVkZHYTlMeVFVU3FlbXNs?=
 =?utf-8?B?RzJ4Zjd0emlNTklFR1duaWw0SHBRaUl6eml6MFdRN1Z5UW1KcEl1MjhlMVg5?=
 =?utf-8?B?bTdXOWtTR2NKYUJiaVg3TXlIV2RhVXFnNk4raUtBRllhdU81dHl2NUVHcHlT?=
 =?utf-8?B?MllWYlNYbTNWMTJWNmNJSFBvUGE0Sk9xaGpQVFE5ZVlBR09ZbnhKVFFPTktv?=
 =?utf-8?B?VmhNT21pVWRvRTcwdVU1RFZVOE5vcC93cU1CalZ4MHFtL1RNcE5HUVhQclRC?=
 =?utf-8?B?VTZMZ0hCUEdMdkFJakxCeWh3UE4zNUZ5cWpXZW13aFRJYWZjOVJIMDZoMnBQ?=
 =?utf-8?B?OGdxbDdlSllPeXIyMHdBRVVjbkZ2OVVvWk1rNTM0Um1VZzdPM1NQTndySHZB?=
 =?utf-8?B?eGVrZzliVkJvSFBMVDlqZWpvTGMvNzdDdlBtRU9RYkFpSCtDdG1MWkY4TmRS?=
 =?utf-8?B?b21uUXN4cjJ3OTYyT0NxbTRTMGRkaUNLZElkaHpOT3RwSjZ0YWYzd3lkMytS?=
 =?utf-8?B?TDA3WEVHMVVUdDFWdW5zSHlaOG9TQ2V5MGg0TFBjQjRwbEV5MUhxNWVOdHU3?=
 =?utf-8?B?WkprRUdyV0lsRXNhVkNXejYyYVZ1dEN3MVZhb1pLamQvTW5mZmRncDNLb0dR?=
 =?utf-8?B?b0FOUGs3TXJzbkhvSUZnK1I2WjAydnB4WDFNcHdGV3pSOFd3dURyaG5UdGJp?=
 =?utf-8?B?ZDRTNG1VaTRCYldFUDlRVVlUT3NPWUtFN0xwa2dFRWFaeXNpOW5WaTlDbDc5?=
 =?utf-8?B?ZmxDeVNpQUxHQ2J6L0xNL0hRZm1nU3BjakE2NGVBb1VXL3VjN3V6SzYyUGds?=
 =?utf-8?B?ckpDellBNnhyZE5DUGk4aXBuVEJTNzZOZklmWXJTbmtTNzZVNTRqeWZVMk91?=
 =?utf-8?B?cnFUaTB2bHdPR0U5N2s1YVl3dHRDaVBmRnVPM0dGK3R6eFBwOTM0NnVtVFZ2?=
 =?utf-8?B?STFreWRKaWdSR25LSDdTMnliNUlXS21VdU1sMWR1VkpLQnBQalVtRFJpSEl3?=
 =?utf-8?B?N3RLVXBXY09FcEF4WFVCUVh3ajI3N1lKbytaTCtMR1NnUmhrRUpYSW83UXY3?=
 =?utf-8?B?NWpDNys4Y1cxZG1uVkQ5V09POElFUmdsbUhmU1hXUmFNU2k4TzlyanNOc3dm?=
 =?utf-8?B?eWJvbWg3S2d6cmpzKzNQYjdpQkRvc0hZalppZnFka01SZUd0SGRqUmNwMUFa?=
 =?utf-8?B?ak5kbGY4bWJDV0xDYVdWSC9TTmtiTUpuQjNnK1BEaTZLd3dpRjYzdmVleWIy?=
 =?utf-8?B?aVNqZWxJOFZENXgvRE92M1pIL2pxd0p0bFkxQTRXNWFXWWF4TS9QV2Q1SDk5?=
 =?utf-8?B?K2l0amFYaU1BRXBHWmtGRzFlQm1FdllWV2RiSU94WDdvRjRKMHF3VnlkK1h4?=
 =?utf-8?B?R0ZURXhaY2RTNWkwSm5sMFVpQVFoWmdvcFBNR2ZCbXZVV05mT21LZlIxMnl1?=
 =?utf-8?B?TEpwbzYwdTlXRlRtQWdSZDh6WDg3VFFBdm5YdEFLamxwRnYrNWFYeHlFOThT?=
 =?utf-8?B?ekVsM2V2bjJTcmMxRmpqUFNuaUJDUnU0QjNJazA0ckNmblIyaEZUV3B3ZWdT?=
 =?utf-8?B?bFVkR3hsQkpSemhLazV5Yk5aeE9zM2RxTG5HOGsvZDcyRUVWSzZQeERQUUZC?=
 =?utf-8?B?VStaeDA1eC9DbnoyNTN3c0VrTjEwTkI4cndINFFtdWQxc1VQdmRTNnQvN21l?=
 =?utf-8?B?OWdld1I1Y1JNVUx6S01jT1ZWb2ZCeVlpOXdwU1N2U3FOL0ZxbStGbDhFaW8z?=
 =?utf-8?B?REhXU2dBakNXandUKys4dVBPSHJLbHlkOHFyZ00yRGxQM281RC9rcUZoL2pz?=
 =?utf-8?B?SmxpUnI4NGZwOG40bXQ3T1JQUGExbjV4UXRPVTZRemE0TisvM2w4bVAyYUhx?=
 =?utf-8?Q?tG2rlJRkewEkKlIpm21O7nE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489a889f-2216-45a0-fb0e-08db41164ff0
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 20:40:29.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvSPLTbgMzGKVoJXQlKJzSGgFHxIHBAJMtOXmgrkRI+8mA1K9Auqc8EZw7hvpU0zDbiEg0oPnv/Avk48VarAV1phTn6PyRYqcB9/164QiAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5929
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/23 2:45 AM, Pierre Gondois wrote:
>
>
> On 4/18/23 20:24, Yang Shi wrote:
>>
>>
>> On 4/11/23 1:51 AM, Pierre Gondois wrote:
>>> Hello Yang,
>>>
>>>>>>>
>>>>>>> -
>>>>>>> According to the same ACPI 6.5 s8.4.6.1.2.5 "Time Window Register"
>>>>>>> paragraph,
>>>>>>> and assuming we are in the 'Autonomous Selection is not enabled'
>>>>>>> case,
>>>>>>> the OS is supposed to write (not read) the delta between successive
>>>>>>> reads of the
>>>>>>> counter, so using this field as is would be bending the 
>>>>>>> definition I
>>>>>>> think.
>>>>>>>
>>>>>>> -
>>>>>>> It is correct that the "Time Window Register" field specifies a 
>>>>>>> value
>>>>>>> in ms,
>>>>>>> but it seems a long time to wait for with irqs off.
>>>>>>
>>>>>> AFAIK, our platforms don't support "Time Window Register".
>>>>>>
>>>>>>>
>>>>>>> -
>>>>>>> Theoretically, the perf/ref counters should accumulate to allow
>>>>>>> computing
>>>>>>> a correct frequency. Is it possible to know how these counters are
>>>>>>> accessed ?
>>>>>>> Is it through PCC channels and there is some undesired delay 
>>>>>>> between
>>>>>>> the
>>>>>>> reads of the perf/ref counters ?
>>>>>>
>>>>>> The counters are implemented via mmio instead of PCC channels. So 
>>>>>> the
>>>>>> cpc_read() calls should go to ACPI_ADR_SPACE_SYSTEM_MEMORY IIRC.
>>>>>>
>>>>>>>
>>>>>>> -
>>>>>>> About making the delay:
>>>>>>>        max(cppc_cpufreq_get_transition_delay_us(), Time Winder
>>>>>>> Register)
>>>>>>> I think it would be good to know why the values of the counters
>>>>>>> don't accumulate correctly, ideally by getting a trace where a
>>>>>>> frequency
>>>>>>> above the maximum frequency is computed, and with the timestamps at
>>>>>>> which
>>>>>>> the counters are read.
>>>>>>> If the values are coming from PCC channels / the firmware, it
>>>>>>> might be
>>>>>>> difficult
>>>>>>> to get.
>>>>>>
>>>>>> I wrote a bpftrace script to trace the below data:
>>>>>>         - The CPU number
>>>>>>         - The frequency
>>>>>>         - The start and end timestamp of the first 
>>>>>> cppc_get_perf_ctrs()
>>>>>> call
>>>>>>         - The duration/latency of the first cppc_get_perf_ctrs() 
>>>>>> call
>>>>>>         - The start and end timestamp of the second
>>>>>> cppc_get_perf_ctrs() call
>>>>>>         - The duration/latency of the second cppc_get_perf_ctrs() 
>>>>>> call
>>>>>>
>>>>>> The typical logs look like below.
>>>>>> Good
>>>>>> CPU: 1
>>>>>> Freq: 2801485KHz
>>>>>> First:  2489382384  2489387084 4700ns
>>>>>> Second: 2489390824  2489394024  3200ns
>>>>>> --------------------------------------------------
>>>>>> CPU:    2
>>>>>> Freq:   2797956KHz
>>>>>> First:  2490406524  2490411204  4680ns
>>>>>> Second: 2490414764  2490417684  2920ns
>>>>>>
>>>>>> Bad:
>>>>>> CPU:    55
>>>>>> Freq:   3969372KHz
>>>>>> First:  875659868  875721568  61700ns
>>>>>> Second: 875725148  875727708  2560ns
>>>>>> --------------------------------------------------
>>>>>> CPU: 65
>>>>>> Freq: 3829744KHz
>>>>>> First:  3854951136  3854995896 44760ns
>>>>>> Second: 3854999416  3855002696 3280ns
>>>>>> --------------------------------------------------
>>>>>> CPU: 21
>>>>>> Freq: 4279242KHz
>>>>>> First:  240834204  240910484 76280ns
>>>>>> Second: 240914264  240916944  2680ns
>>>>>>
>>>>>>
>>>>>> The first line is cpu number, the second line is frequency 
>>>>>> returned by
>>>>>> cppc_cpufreq_get_rate(), the third line is the start and end
>>>>>> timestamps
>>>>>> and duration of the first cppc_get_perf_ctrs(), the fourth line 
>>>>>> is the
>>>>>> start and end timestamps and duration of the second
>>>>>> cppc_get_perf_ctrs().
>>>>>>
>>>>>> So per the log I think we can tell basically the longer the
>>>>>> duration the
>>>>>> higher the error. The 2us delay is not long enough to offset the
>>>>>> impact
>>>>>> from unexpected latency of reading the counters.
>>>>>>
>>>>>> In the worst case the frequency is 4279242KHz, comparing 2800000KHz
>>>>>> the
>>>>>> error is over 50%. So the delay should be 4ms ~ 5ms in order to 
>>>>>> offset
>>>>>> the impact from reading the counters if I do the math correctly.
>>>>>>
>>>>>> Hope the trace data is helpful to diagnose the problem.
>>>>>
>>>>>
>>>>> Thanks for the data. I was thinking the following was happening:
>>>>>
>>>>>    cppc_get_perf_ctrs()[0] cppc_get_perf_ctrs()[1]
>>>>> /                    \ /                         \
>>>>> ref[0]    delivered[0]                    ref[1] delivered[1]
>>>>>     |            | |                  |
>>>>>     v            v v                  v
>>>>> ----------------------------------------------------------------------> 
>>>>>
>>>>> time
>>>>>      <-delta[0]-> <-------------2us------------> <----delta[1]---->
>>>>>
>>>>> If delta[0] is really different from delta[1] like above, then the
>>>>> reference and delivered counters would have accumulated during
>>>>> different
>>>>> intervals, resulting in a wrong frequency.
>>>>
>>>> Yeah, it looks like so.
>>>>
>>>>> If more/less than 2us elapse between the two cppc_get_perf_ctrs()
>>>>> calls,
>>>>> then it shouldn't have any impact. So waiting ~10ms should
>>>>> theoretically
>>>>> not solve the issue.
>>>>
>>>> I'm not sure whether the 10ms delay really resolved the issue, but it
>>>> did reduce the magnitude of the error.
>>>>
>>>> BTW, I don't see irq is disabled when reading cpuinfo_cur_freq, so it
>>>> looks like interrupts could easily result in the difference between
>>>> delta[0] and delta[1]. And it seems like the difference matters.
>>>
>>> Ok, maybe disabling irqs would have an impact ?
>>
>> Yes, I ran some tracing to try to capture what happened when we saw high
>> error. And it seems like IRQs is one of the contributing factors.
>> Interconnect congestion is also a contributing factor. The below trace
>> data supported the conclusion.
>>
>> 4081929KHz
>> # tracer: function_graph
>> #
>> #     TIME        CPU  DURATION                  FUNCTION CALLS
>> #      |          |     |   |                     |   |   | |
>> 13378.411863 |     0)               |  cppc_cpufreq_get_rate
>> [cppc_cpufreq]() {
>> 13378.411864 |     0)               |    cpufreq_cpu_get() {
>> 13378.411865 |     0)               | _raw_read_lock_irqsave() {
>> 13378.411865 |     0)   0.680 us    | preempt_count_add();
>> 13378.411867 |     0)   2.020 us    | }
>> 13378.411868 |     0)               | _raw_read_unlock_irqrestore() {
>> 13378.411868 |     0)   0.520 us    | preempt_count_sub();
>> 13378.411869 |     0)   1.340 us    | }
>> 13378.411869 |     0)   5.160 us    | }
>> 13378.411870 |     0)   0.440 us    | cpufreq_cpu_put();
>> 13378.411871 |     0)               |    cppc_get_perf_ctrs() {
>> 13378.411872 |     0)               |      cpc_read.isra.0() {
>> 13378.411874 |     0)               |        irq_enter_rcu() {
>> 13378.411874 |     0)   0.460 us    | preempt_count_add();
>> 13378.411875 |     0)   0.660 us    | irqtime_account_irq();
>> 13378.411876 |     0)   2.480 us    | }
>> 13378.411877 |     0)               | do_interrupt_handler() {
>> 13378.411877 |     0)   ==========> |
>> 13378.411877 |     0) + 49.260 us   | gic_handle_irq();
>> 13378.411877 |     0)   <========== |
>> 13378.411928 |     0) + 51.000 us   | }
>> 13378.411928 |     0)               |        irq_exit_rcu() {
>> 13378.411929 |     0)   0.540 us    | irqtime_account_irq();
>> 13378.411929 |     0)   0.420 us    | preempt_count_sub();
>> 13378.411930 |     0)   0.640 us    | ksoftirqd_running();
>> 13378.411931 |     0) + 16.680 us   | do_softirq_own_stack();
>> 13378.411948 |     0)   0.440 us    | idle_cpu();
>> 13378.411949 |     0) + 21.200 us   |        }
>> 13378.411950 |     0) + 77.480 us   |      }
>> 13378.411950 |     0)   0.740 us    |      cpc_read.isra.0();
>> 13378.411951 |     0)   0.440 us    |      cpc_read.isra.0();
>> 13378.411952 |     0)   0.660 us    |      cpc_read.isra.0();
>> 13378.411953 |     0) + 81.980 us   |    }
>> 13378.411954 |     0)               |    __delay() {
>> 13378.411954 |     0)   0.580 us    | arch_timer_evtstrm_available();
>> 13378.411956 |     0)   2.460 us    |    }
>> 13378.411956 |     0)               |    cppc_get_perf_ctrs() {
>> 13378.411957 |     0)   0.540 us    | cpc_read.isra.0();
>> 13378.411958 |     0)   0.520 us    | cpc_read.isra.0();
>> 13378.411959 |     0)   0.420 us    | cpc_read.isra.0();
>> 13378.411959 |     0)   0.440 us    |      cpc_read.isra.0();
>>
>> The above trace data captured IRQ when cppc_cpufreq_get_rate() returns
>> 4081929KHz.
>>
>> 3052367KHz
>> # tracer: function_graph
>> #
>> #     TIME        CPU  DURATION                  FUNCTION CALLS
>> #      |          |     |   |                     |   |   | |
>> 19177.226497 |     0)               |  cppc_cpufreq_get_rate
>> [cppc_cpufreq]() {
>> 19177.226498 |     0)               |    cpufreq_cpu_get() {
>> 19177.226499 |     0)               | _raw_read_lock_irqsave() {
>> 19177.226499 |     0)   0.600 us    | preempt_count_add();
>> 19177.226500 |     0)   1.820 us    |      }
>> 19177.226501 |     0)               | _raw_read_unlock_irqrestore() {
>> 19177.226502 |     0)   0.480 us    | preempt_count_sub();
>> 19177.226502 |     0)   1.260 us    |      }
>> 19177.226503 |     0)   4.780 us    |    }
>> 19177.226503 |     0)   0.420 us    |    cpufreq_cpu_put();
>> 19177.226504 |     0)               |    cppc_get_perf_ctrs() {
>> 19177.226505 |     0)   0.720 us    |      cpc_read.isra.0();
>> 19177.226506 |     0)   1.180 us    |      cpc_read.isra.0();
>> 19177.226508 |     0)   0.400 us    |      cpc_read.isra.0();
>> 19177.226508 |     0)   0.600 us    |      cpc_read.isra.0();
>> 19177.226509 |     0)   5.240 us    |    }
>> 19177.226510 |     0)               |    __delay() {
>> 19177.226510 |     0)   0.520 us    | arch_timer_evtstrm_available();
>> 19177.226512 |     0)   2.420 us    |    }
>> 19177.226513 |     0)               |    cppc_get_perf_ctrs() {
>> 19177.226513 |     0)   0.540 us    |      cpc_read.isra.0();
>> 19177.226514 |     0)   0.540 us    |      cpc_read.isra.0();
>> 19177.226515 |     0)   0.400 us    |      cpc_read.isra.0();
>> 19177.226516 |     0)   0.440 us    |      cpc_read.isra.0();
>> 19177.226516 |     0)   3.660 us    |    }
>> 19177.226517 |     0)   0.780 us    | cppc_cpufreq_perf_to_khz
>> [cppc_cpufreq]();
>> 19177.226518 |     0) + 23.320 us   |  }
>
>
> In cppc_get_perf_ctrs(), the cpc registers are read in this order:
> 1- delivered
> 2- reference
> 3- ref_perf
> 4- ctr_wrap
>
> In the following, cpc_read[first][2] represents the second call to 
> cpc_read()
> in the first cppc_get_perf_ctrs() call.
>
> The duration between the 2 cpc_read() calls to get the 'delivered' 
> register
> should be:
> = cppc_get_perf_ctrs[first]() - cpc_read[first][1]() + __delay() +
>   cpc_read[second][1]()
> = 5.24 - 0.72 + 2.24 + 0.54 us
> = 7.3 us
>
> It is assumed here that in both cppc_get_perf_ctrs() calls:
> - the duration between the entry cppc_get_perf_ctrs() and the the 
> first call
>   to cpc_read() is identical
> - the duration between each cpc_read() call is identical
>
> Similarly for the 'reference' register:
> = cppc_get_perf_ctrs[first]() - cpc_read[first][1]() - 
> cpc_read[first][2]() +
>   __delay() + cpc_read[second][1]() + cpc_read[second][2]()
> = 5.24 - 0.72 - 1.18 + 2.24 + 0.54 +0.54 us
> = 6.66 us
>
> So assuming the reference counter is at 1GHz and the delivered counter 
> is at
> 2.8GHz, the computed_freq is:
> = ref_cnt_freq * (delta_cnt_delivered() / delta_cnt_ref())
> = 1GHz * ((2.8GHz * 7.3us) / (1GHz * 6.66us))
> = 2.8 * (7.3 * 6.66) GHz
> = 3.07 GHz
>
> This is approximately what was obtained in the trace above (3.05GHz).
>
> ----
>
> You say that the cause of this is a congestion in the interconnect. I 
> don't
> see a way to check that right now.
> However your trace is on the CPU0, so maybe all the other cores were 
> shutdown
> in your test. If this is the case, do you think a congestion could 
> happen with
> only one CPU ?

No, other CPUs were not shut down in my test. I just ran "yes" on all 
cores except CPU 0, then ran the reading freq script. Since all other 
cores are busy, so the script should be always running on CPU 0.

Since the counters, memory and other devices are on the interconnect, so 
the congestion may be caused by plenty of factors IIUC.

>
> Just 2 other comments:
> a-
> It might be interesting to change the order in which cpc registers are 
> read
> just to see if it has an impact, but even if it has, I m not sure how 
> this
> could be exploitable.
> Just in case, I mean doing that, but I think that b. might be better 
> to try.
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c51d3ccb4cca..479b55006020 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1350,8 +1350,8 @@ int cppc_get_perf_ctrs(int cpunum, struct 
> cppc_perf_fb_ctrs *perf_fb_ctrs)
>                 }
>         }
>
> -       cpc_read(cpunum, delivered_reg, &delivered);
>         cpc_read(cpunum, reference_reg, &reference);
> +       cpc_read(cpunum, delivered_reg, &delivered);
>         cpc_read(cpunum, ref_perf_reg, &ref_perf);
>
>         /*
>
> b-
> In the trace that you shared, the cpc_read() calls in the fist
> cppc_get_perf_ctrs() calls seem to always take a bit more time than in 
> the
> second cppc_get_perf_ctrs() call.
> Would it be possible to collect traces similar as above with 3 or 4 
> calls to
> cppc_get_perf_ctrs() instead of 2 ? It would allow to check whether in 
> the first
> call, accessing the cpc registers takes more time than in the 
> following calls,
> due to cache misses or other reasons.

Cache miss? The counters should be not cached and reading the counters 
should not hit cache IIUC.

> Ideally statistics on the result would be the best, or if you have a 
> trace.dat
> to share containing a trace with multiple cppc_cpufreq_get_rate() calls.

Tried option b, I managed to get histogram:

@hist_first_ns[cat]:
[4K, 8K)          112321 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[8K, 16K)            212 
|                                                    |
[16K, 32K)            25 
|                                                    |
[32K, 64K)            59 
|                                                    |
[64K, 128K)            6 
|                                                    |
[128K, 256K)           9 
|                                                    |

@hist_second_ns[cat]:
[2K, 4K)          112590 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4K, 8K)               4 
|                                                    |
[8K, 16K)              0 
|                                                    |
[16K, 32K)            15 
|                                                    |
[32K, 64K)            18 
|                                                    |
[64K, 128K)            1 
|                                                    |
[128K, 256K)           4 
|                                                    |

The "first" means the first cppc_get_perf_ctrs() call. But the bpftrace 
script can't tell the second, the third and the fourth, so all them are 
shown as "second". Anyway it seems fine. We can tell the first read took 
longer than the later ones for the most time.

And a typical func_graph trace shows:

# tracer: function_graph
#
#     TIME        CPU  DURATION                  FUNCTION CALLS
#      |          |     |   |                     |   |   | |
  4447.171333 |     0)               |  cppc_cpufreq_get_rate 
[cppc_cpufreq]() {
  4447.171334 |     0)               |    cpufreq_cpu_get() {
  4447.171334 |     0)   1.060 us    | _raw_read_lock_irqsave();
  4447.171336 |     0)   0.560 us    | _raw_read_unlock_irqrestore();
  4447.171337 |     0)   3.480 us    | }
  4447.171338 |     0)   0.400 us    | cpufreq_cpu_put();
  4447.171338 |     0)               |    cppc_get_perf_ctrs() {
  4447.171339 |     0)   0.720 us    | cpc_read.isra.0();
  4447.171341 |     0)   0.700 us    | cpc_read.isra.0();
  4447.171342 |     0)   0.380 us    | cpc_read.isra.0();
  4447.171342 |     0)   0.600 us    | cpc_read.isra.0();
  4447.171343 |     0)   4.900 us    | }
  4447.171344 |     0)               |    __delay() {
  4447.171344 |     0)   0.540 us    | arch_timer_evtstrm_available();
  4447.171346 |     0)   2.420 us    | }
  4447.171347 |     0)               |    cppc_get_perf_ctrs() {
  4447.171347 |     0)   0.540 us    | cpc_read.isra.0();
  4447.171348 |     0)   0.520 us    | cpc_read.isra.0();
  4447.171349 |     0)   0.400 us    | cpc_read.isra.0();
  4447.171350 |     0)   0.440 us    | cpc_read.isra.0();
  4447.171350 |     0)   3.660 us    | }
  4447.171351 |     0)               |    __delay() {
  4447.171351 |     0)   0.400 us    | arch_timer_evtstrm_available();
  4447.171353 |     0)   2.400 us    | }
  4447.171353 |     0)               |    cppc_get_perf_ctrs() {
  4447.171354 |     0)   0.540 us    | cpc_read.isra.0();
  4447.171355 |     0)   0.540 us    | cpc_read.isra.0();
  4447.171356 |     0)   0.380 us    | cpc_read.isra.0();
  4447.171356 |     0)   0.420 us    | cpc_read.isra.0();
  4447.171357 |     0)   3.640 us    | }
  4447.171357 |     0)               |    __delay() {
  4447.171358 |     0)   0.380 us    | arch_timer_evtstrm_available();
  4447.171360 |     0)   2.380 us    |    }
  4447.171360 |     0)               |    cppc_get_perf_ctrs() {
  4447.171361 |     0)   0.520 us    |      cpc_read.isra.0();
  4447.171361 |     0)   0.520 us    |      cpc_read.isra.0();
  4447.171362 |     0)   0.400 us    |      cpc_read.isra.0();
  4447.171363 |     0)   0.440 us    |      cpc_read.isra.0();
  4447.171364 |     0)   3.640 us    |    }
  4447.171364 |     0)   0.520 us    |    cppc_cpufreq_perf_to_khz 
[cppc_cpufreq]();
  4447.171365 |     0) + 34.240 us   |  }

It also shows the first reading typically took longer than the later 
ones. The second, the third and the fourth actually took almost same time.

I also tried to read perf_fb_ctrs_t0 twice (so total 3 reads, 2 for t0, 
1 for t1, 2us delay between each read), but I didn't see noticeable 
improvement. 4 reads (2 for t0, 2 for t1) does show some noticeable 
improvement.

>
> Example of code where we do 4 calls to cppc_get_perf_ctrs():
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
> b/drivers/cpufreq/cppc_cpufreq.c
> index 022e3555407c..6370f2f0bdad 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -853,6 +853,20 @@ static unsigned int 
> cppc_cpufreq_get_rate(unsigned int cpu)
>
>         udelay(2); /* 2usec delay between sampling */
>
> +       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> +       if (ret)
> +               return ret;
> +
> +       udelay(2); /* 2usec delay between sampling */
> +
> +       /* Do a third call. */
> +       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> +       if (ret)
> +               return ret;
> +
> +       udelay(2); /* 2usec delay between sampling */
> +
> +       /* Do a fourth call. */
>         ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>         if (ret)
>                 return ret;
>
>>
>> The above trace data shows some cpc reading took a little bit longer
>> than usual. I suspected it was caused by interconnect congestion.
>>
>>
>> So it looks like IRQ is the major contributing factor of high error
>> (4xxxxxx KHz), interconnect congestion is the major contributing factor
>> of low error (3xxxxxx KHz).
>>
>> So I did the below test:
>> 1. Disable IRQ: The high errors were gone (> 3700000KHz), but low errors
>> were still seen.
>> 2.10us delay: The high errors were still seen.
>> 3. Disable IRQ + 10us delay: all the errors were gone.
>>
>> I think the test result also supports the tracing data.
>>
>>
>> I also got some confusion about calling cppc_cpufreq_get_rate() with irq
>> disabled. Rafael thought 10ms delay is too long because the function may
>> be called with irq disabled. But a deeper look at the function shows it
>> should *NOT* be called with irq disabled at all.
>>
>> First, if pcc channel is used, cpc reading may take over 100ms, it is
>> way larger the proposed 10ms delay.
>> Second, reading from cpc channel needs to take a semaphore, so it may
>> sleep. But sleep with IRQ disabled is not allowed.
>
> Yes right, however the semaphore is not taken in between the sequence of
> cpc_read() calls in cppc_get_perf_ctrs(). So maybe the change below 
> should
> be acceptable:

Yeah, we should be able to find a smaller irq disable section.

>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c51d3ccb4cca..105a7e2ffffa 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct 
> cppc_perf_fb_ctrs *perf_fb_ctrs)
>         struct cppc_pcc_data *pcc_ss_data = NULL;
>         u64 delivered, reference, ref_perf, ctr_wrap_time;
>         int ret = 0, regs_in_pcc = 0;
> +       unsigned long flags;
>
>         if (!cpc_desc) {
>                 pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> @@ -1350,10 +1351,14 @@ int cppc_get_perf_ctrs(int cpunum, struct 
> cppc_perf_fb_ctrs *perf_fb_ctrs)
>                 }
>         }
>
> +       local_irq_save(flags);
> +
>         cpc_read(cpunum, delivered_reg, &delivered);
>         cpc_read(cpunum, reference_reg, &reference);
>         cpc_read(cpunum, ref_perf_reg, &ref_perf);
>
> +       local_irq_restore(flags);
> +

cpc_read_ffh() would return -EPERM if irq is disabled.

So, the irq disabling must happen for mmio only in cpc_read(), for example:

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c51d3ccb4cca..f3c92d844074 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -982,6 +982,7 @@ static int cpc_read(int cpu, struct 
cpc_register_resource *reg_res, u64 *val)
         void __iomem *vaddr = NULL;
         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
         struct cpc_reg *reg = &reg_res->cpc_entry.reg;
+       unsigned long flags;

         if (reg_res->type == ACPI_TYPE_INTEGER) {
                 *val = reg_res->cpc_entry.int_value;
@@ -1015,6 +1016,7 @@ static int cpc_read(int cpu, struct 
cpc_register_resource *reg_res, u64 *val)
                 return 
acpi_os_read_memory((acpi_physical_address)reg->address,
                                 val, reg->bit_width);

+       local_irq_save(flags);
         switch (reg->bit_width) {
         case 8:
                 *val = readb_relaxed(vaddr);
@@ -1029,10 +1031,12 @@ static int cpc_read(int cpu, struct 
cpc_register_resource *reg_res, u64 *val)
                 *val = readq_relaxed(vaddr);
                 break;
         default:
+               local_irq_restore(flags);
                 pr_debug("Error: Cannot read %u bit width from PCC for 
ss: %d\n",
                          reg->bit_width, pcc_ss_id);
                 return -EFAULT;
         }
+       local_irq_restore(flags);

         return 0;
  }

>         /*
>          * Per spec, if ctr_wrap_time optional register is 
> unsupported, then the
>          * performance counters are assumed to never wrap during the 
> lifetime of
>
>> Third, if the counters are implemented by AMU, cpc_read_ffh() needs to
>> send IPI so it requires IRQ enabled.
>
> If I'm not mistaken, the CPU calling cpc_read_ffh() might have IRQs 
> disabled,
> it should not prevent it to send IPIs no ?

It can't work with irq disabled. The comment in counters_read_on_cpu() 
says "Abort call on counterless CPU or when interrupts are disabled - 
can lead to deadlock in smp sync call."


And it just returns -EPERM and raise a warning if irq is disabled.

>
>>
>>>
>>>>
>>>> And the counters are accessed through an interconnect on our platform,
>>>> so the interconnect congestion may result in the difference as well.
>>>>
>>>>>
>>>>> freq = ref_freq * (delivered[1] - delivered[0]) / (ref[1] - ref[0])
>>>>>
>>>>> If the counters are accessed through mmio, I don't see anything that
>>>>> would
>>>>> make delta[x] vary when calling cppc_get_perf_ctrs(), cf. cpc_read().
>>>>> Do you know if the address represents real counters or a place in
>>>>> memory
>>>>> representing something else ?
>>>>
>>>> The address does represent real counters.
>>>
>>> Oh ok, is it possible to know what is there ?
>>
>> AFAIK, it is memory mapped access to the core's AMU counters.
>>
>>>
>>>>
>>>>>
>>>>> Would it be possible to try setting the CPU frequency to one unique
>>>>> value
>>>>> and get a serie of values like:
>>>>> [timestamp, ref_counter_value, deliverd_counter_value]
>>>>
>>>> Could you please elaborate regarding "setting the CPU frequency to one
>>>> unique value"? What value is unique?
>>>
>>> I meant having the CPUs using only on frequency. The following should
>>> work:
>>> cat /sys/devices/system/cpu/cpu[X]/cpufreq/scaling_min_freq >
>>> /sys/devices/system/cpu/cpu[X]/cpufreq/scaling_max_freq
>>>
>>>>
>>>>>
>>>>> This would allow to check that the counters are accumulating at a 
>>>>> valid
>>>>> pace. Also you said there were frequencies above the maximum 
>>>>> value, but
>>>>> are there also frequencies below the minimum value ?
>>>>
>>>> I've never seen the frequency below the minimum value.
>>>
>>> Maybe this is because the CPUs are running at their maximum frequency,
>>> so when the computed frequency is below the actual running frequency,
>>> it still doesn't go below the minimum frequency.
>>> Meaning that if the CPUs were limited to their lowest frequency (with
>>> the command above), maybe the get_rate() function would return values
>>> in a range [[1]:[2]]:
>>> - [1]: frequency below the lowest frequency
>>> - [2]: frequency above the lowest frequency, but below the maximum
>>>    frequency of 2.8GHz
>>
>> Yes, with writing scaling_min_freq to scaling_max_freq, I can see the
>> frequency was lower than min freq (1000000KHz) occasionally.
>>
>>>
>>> Would it be possible to do the following:
>>>
>>> # Shut down all the CPUs except the last one just to have less logs
>>> for i in /sys/devices/system/cpu/cpu[0-9]* ; do echo 0 > $i/online ; 
>>> done
>>>
>>> cd /sys/kernel/debug/tracing
>>>
>>> # Add a kprobe to cppc_cpufreq_get_rate to get the computed freq
>>> echo 'r:myretprobe cppc_cpufreq_get_rate $retval:u32' >>
>>> /sys/kernel/debug/tracing/kprobe_events
>>> echo 1 > events/kprobes/enable
>>>
>>> # Setup ftrace to trace cppc_cpufreq_get_rate() calls
>>> # (and maybe see if something undesired happens in the call)
>>> echo function_graph > current_tracer
>>> echo funcgraph-abstime > trace_options
>>> echo cppc_cpufreq_get_rate > set_graph_function
>>>
>>> # Do the tracing
>>> echo 1 > tracing_on
>>> # Wait a bit for a call to cppc_cpufreq_get_rate() to happen
>>> echo 0 > tracing_on
>>>
>>> Also adding the following in cppc_perf_from_fbctrs() should allow
>>> tracking the counter values:
>>> trace_printk("get_cntrs: ref0=%lx ref1=%lx del0=%lx del1=%lx",
>>>      fb_ctrs_t0->reference, fb_ctrs_t1->reference,
>>>      fb_ctrs_t0->delivered, fb_ctrs_t1->delivered);
>>
>> Sorry I forgot to ask whether I shall run the tracing for the lower than
>> min frequency case or not? Since the latency of reading cpc is quite
>> small (sub microsecond), so it is quite sensitive to extra
>> latency/delay. It seems like the overhead of tracing is not negligible.
>>
>> I got some data with higher than max frequency.
>>
>> Good:
>>    159.077799 |     0)               |  /* get_cntrs: ref0=1513476688
>> ref1=1513482268 del0=329890515 del1=329905431 */
>>    159.607913 |     0)               |  /* get_cntrs: ref0=1137490668
>> ref1=1137496188 del0=3198347141 del1=3198362993 */
>>
>> Bad:
>> 4965.786566 |     0)               |  /* get_cntrs: ref0=766025872
>> ref1=766034192 del0=2288598970 del1=2288624170 */
>> 5251.933966 |     0)               |  /* get_cntrs: ref0=2472241696
>> ref1=2472250376 del0=1156772954 del1=1156799208 */
>>
>> Hopefully this is helpful.
>
> Yes, thanks a lot. Using the min or max frequency was not important IMO,
> it was just to avoid having the possibility to have a CPU with a changing
> frequency.
> Just a comment, the first trace was really helpfull, but I think it is
> possible to have a function graph and the counter values as above in
> the same trace.

I wish I could trace more. But the tracing overhead is more noticeable 
and may impact the result. With the trace_printk() I actually already 
saw much fewer high error happened. The higher the error the more useful 
the trace.

>
>
> Thanks again for the experiments,

Thanks for guiding me debug this problem.

> Regards,
> Pierre

