Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AFC6E971C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDTOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjDTOav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:30:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2132.outbound.protection.outlook.com [40.107.223.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FF658B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXh+sKFGsThdho3+kVBWOI7U2yeMVz/fYUdeHMAaj5B5pjcEQ3Ocf/AXXIefhD/vehq9MElZijSPlWmrOxHernmi2MHFGCVwemLjP3VNY/3upCVTqOJZAgTO0AwvXZN5m+ZDUnZR95HK8J+rWuk33zJubYEq7ezTUF0BdiIseVh2DRufve5pLth8E5H+VTZ6IB0ULloeMKkyZUaFK5DGDC1sD0Pih3eNtA+l57Q2Pb+onFwNH4ksMssFnG+dBlDbq+/YwJvqEIZ9347LZUJmww0tbvtC3QsEXA9XMmdS8SZLI0CXpnHfaEZipz3yxJz7cVWbp02JcBif0c0sEAG9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkwPc5fxWyZmOB+42WtFDtMgsAqipY1iXwQwno6PQ8Y=;
 b=GIQQpMorxZnvNDWIQGIEVXAwCeJhAfH6WhGqrnU//DF1U3AJNdm01ax/6u1K0mAX3OpWwPuY+LHTc2Gd8L/B+cMo6VXJW9Ez8l7MeZ+vxJC5zL3hwhAXSpvgTt4y8kYMkHozSAFDNB8ACKGqL0A5OL5Cl76rY/i2JZ7DdV/VFyUveB5fMBrR/o6uqnaDmFkuHGQYcBsfcuhSnQSG9eVpQf3d9+t+oIIwgXS44Z/CfhUv4qbDtPZEtwwx/2kisCjMUi1yIhUKKX6bGe3rsSfbmcZWReeoQVQ8xgJ6pX0XoilLN+cfGClQieg+KjDxQqLy53ShLwEzgdTiQvYD3XlfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkwPc5fxWyZmOB+42WtFDtMgsAqipY1iXwQwno6PQ8Y=;
 b=FenkkH4eKNTdigRdBsKW1CadIQfapDgheYe+CWsgUpLAzcEzGedz8K7ougchTtvcjLym/9V45sLqJ72tFHChU7LtvZZ/KeqcijOekIr6pxeQTQxjwgqIl3jRhk7i94ZWhYzLZhzpinilF17IctpoDztWpZGO+0I1WiFVfEZyMbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BN6PR01MB2804.prod.exchangelabs.com (2603:10b6:404:d6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.11; Thu, 20 Apr 2023 14:30:42 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::5cf:2baf:f5ab:ac87]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::5cf:2baf:f5ab:ac87%5]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 14:30:42 +0000
Message-ID: <20f17fa9-d584-e0e5-9017-bd8e6c7fa502@os.amperecomputing.com>
Date:   Thu, 20 Apr 2023 20:00:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf cs-etm: Add support for coresight trace for any
 range of CPUs
Content-Language: en-US
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, acme@kernel.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        scclevenger@os.amperecomputing.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        suzuki.poulose@arm.com
References: <20230419172101.78638-1-gankulkarni@os.amperecomputing.com>
 <d758c5e2-aa32-d829-35ee-a685bdb56f75@arm.com>
 <84eb3363-2ef8-d3f1-4613-805959dbf334@os.amperecomputing.com>
 <91ba66e7-737f-6526-a703-a755e114f9d4@arm.com>
 <dea08376-e66b-bacc-7673-c79fe2a8f889@os.amperecomputing.com>
In-Reply-To: <dea08376-e66b-bacc-7673-c79fe2a8f889@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:610:60::16) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BN6PR01MB2804:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3458b9-e54b-453a-c13a-08db41abd228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYvQ8SBJd2VKGWE/VSy4xKh/rbzbP7aH84RS6Qr/v1Ti/bsKPd5us1nUG02bPJxzN6hISehUNVLEWIkl2XvAPyv6EZ4bZ23lexx6AyogyKw+YS56rkPEbImXQtPBZ9a6X96p2RGclMSq5q10/64e1zKA5dmslWTJ+sg/QQLPTaOS/RqG5d0RpZSPb/+IOdihe+TYrgtQ0JZxGvyzxjJr7pcg443nCLZJLGQ0n4/AH3Jy9wcrVPerI9ldpf1aRoZlyEADblryYy9nk4QDqYa+5pcbiCevaJaG7lfIgcgYMo+sbTgLvFy3epWstZ3pSDuQWNKa7CdrGEt+Zqx21EWUZOoVKfcCsA7SPO3iLTvD6hakr0rmA5HydW6ddMnyxhTrgB9yVWhN0wPSRnvjbUqGtCcuaYCBMrahmSOf+pHPDRl98pP83fPIBVxHAMrdgZYtJ1US2vwTyJAlPpGNHRTIXJO3pWgnreUemJ+n6FNEwMd1Gl4dm1Z2bgXeJk/UCVDpB25XC2rLTzvHE5UUrFqqgZxwuk9A9MT706lpkWg1qs0dZlvp4+mbtyxNNoph/N762IkwFqyiTlTkwEeuWA9Ht14bTfbu3Ev0cYnWqugYaDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39850400004)(396003)(366004)(346002)(451199021)(31686004)(6916009)(4326008)(316002)(966005)(66946007)(66556008)(66476007)(186003)(26005)(6506007)(53546011)(6512007)(38100700002)(2616005)(83380400001)(5660300002)(41300700001)(8676002)(8936002)(478600001)(6666004)(6486002)(86362001)(31696002)(30864003)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU9lZFBtTGx3NExvbEhpT0FDWHI1N3JrbWc1WDZXZUFrT0pXd2hnRzJKNGw4?=
 =?utf-8?B?WEw3LytvbHB0OUl5a0ZJcmZoQmFGNmRnNFNzMzhsYnlLSGR5VkNBZmdzVWZj?=
 =?utf-8?B?cFN1M2RsbVM4RUVmWlRCc2RMNVVlYXpTS1JyUFVEUnUzMlRiM1ZRUFhZZlRD?=
 =?utf-8?B?NWpKaU8xVUVqN0hjczliTkNRNTBCWjQ2YUhqSlRFQUd1Q3ArZWhXcmF1RW9L?=
 =?utf-8?B?Q0dLOG9uNWFKNmlDY0FTQmlPcFUrYk1pdFVDS01jZ1JsYnBxRnFXZ2hhRzFY?=
 =?utf-8?B?cmVDWWNpTlQvR21HWmRjZzBWRHVRWHA3NnVsNjQ4SWh2V1RuYk5CVG8xWmdz?=
 =?utf-8?B?TjdIVVZLRmpVWktOL2Y1UERWT3FPT0FjbjlpVFRTL1JCc3ZaTWxmanFVb09S?=
 =?utf-8?B?NHMvajY5RmZaOGRiWC84eS9aTnlPKzY1RWc5Qkg1NjRPS3UrS05OdXo0TVZQ?=
 =?utf-8?B?UXFueGVTWStJUEpJYnppUEo2alZqZmJUYUpvUHlVNGZGcDM0cnJuMllxS0lN?=
 =?utf-8?B?NTFaT3cwL1Y5VHY3Sno4dlFHcmRpUmlGMlRhUnpFQmphck9YOGtGMWQxTWRH?=
 =?utf-8?B?L2ZlemVHQ0FzTzIxOFkzQk9KN3FlWE5qbys5ZGxFMVV6bTIxSUx4Y2xka21p?=
 =?utf-8?B?NjkwRmp0b1ljSDJCT1ZrVEpkSjVkZGgzWnNZNi9VVTVIZ2VWcE9BZUVIZDJ3?=
 =?utf-8?B?a2VQclFmMCtmOSsyczRQbGtqWjdRK05rRkJ4RWx1NkpxS3A2d2llYnNpV0kv?=
 =?utf-8?B?TzkyVk1vcVAvb2ZwNEhZVWY5bENqeVVmWDZiSTNySVRKOFlSeHZuMmx6VFJB?=
 =?utf-8?B?cGNFenZMTHVIWnFvZGE0bEZoQzdhVExGUmZPcFl1WHhEcnlOWG8xMGFrQVdP?=
 =?utf-8?B?UFphT3ZtalhkSjBqaVdjcGNZYXd4cHE1dWZzOFo2d2wyRnRaNTUyUGtHVDV5?=
 =?utf-8?B?QkZTTkFRYVJHZEhhNVlSbWtBcEt4U1J0YmowTHpTbVk0Mi9Ub1Z3eGFrMFFy?=
 =?utf-8?B?cDVtK0tXL1RNSEFTNWJUQWZhNDh6Zno0YnZodlIvZ0pIS2ZmbGFBNU05QzJo?=
 =?utf-8?B?RGcwVHdSd0RLVjR2THRqYk5QNWVwS3FVdjlDS2Q4d2FSR2JGNzZvaEZnenFS?=
 =?utf-8?B?NTZMV05lQ05BeUI1YVMrMm5sY0p1YmNQVHRZdURSSFlnSGdzZ3h1WklibTc0?=
 =?utf-8?B?bUx6RnBwNDNVY2w2UlMvVFpnbTNtSTdqRWF5SDhhYUJPRVFMeGpYOElpUm4y?=
 =?utf-8?B?WEN5UGFjREg2ZEtPZUZEQ2VyeXlNM2dLUUFWcU1maTRvaVN4TFRqQTNkanA0?=
 =?utf-8?B?ek4xOHdCaERwc3M0MjQwS1d5NzZIY1pwd0RhNUkxeGwvRFFuZXVCZWdQVUhT?=
 =?utf-8?B?SXVDb0dJanI4N2d1REUwRUowRHQyV0N1bHExR1kweUdFSHFmUlpuNDNaVTFq?=
 =?utf-8?B?SEM5R2YzMng1d3lDRTZoNytUVnkzUnVkNlI0UDJreXcwUlRuOTh2eUErV1ZR?=
 =?utf-8?B?dmtQei9BNk1tR0l5ODVOOTdWYkVzZk05NDBHQjhjUnUya0JuOUZmOXdwNTRQ?=
 =?utf-8?B?MmNidkhhb0hXOTYxSC9XcnNUQ1pWSjdTZVZDeWROdUhvTFBpWVZSYUt3dWZG?=
 =?utf-8?B?Y2xlaVREbU1semxaL2hkNFRWT1dVRDJJU1A1T3Q4czBubktUVVZCZHliRFpH?=
 =?utf-8?B?L1B2UGVtSG9OdDhUMUw5bFpvaXBodHZtcjlWUVhsa1ArWlVXcmlMcXJsSkw2?=
 =?utf-8?B?OFVYODd2cG1FTENEQmRJVjZCUGZtZncydUVvRXdBam1wTzhDSnJReW1MajJi?=
 =?utf-8?B?OEpGdHR6T3RVdFlHOUhzM3gxT2h0T0RDZjdOZGhnSGU2YW9LYUFDdWNkN3pR?=
 =?utf-8?B?dDBtck4zNjZQNXp5RVkxejRQMXJGTVNFeEtXM3hKaDNyTGVyRzUzTUVPbDF6?=
 =?utf-8?B?SitqZGpiQnpVTUtSOVJYb1pFcjc5aGdkTTZGeXVKTzNHSTFGRklSamtQRmxX?=
 =?utf-8?B?WDRjQ2Rpbko1TXpmVHp4Ukx2d3FWUVdFZGVyb3JVWmdXN1dMbVhkWjZlekFK?=
 =?utf-8?B?bFIvODNLVHpXbU1JaExZZnZ5OWFFOFd6ZFp0QmVTejd2TmxMUVFLbVRqancw?=
 =?utf-8?B?U1BTNHlMeGRFdllqNTZYZ0paWG9hSVA2N1A5U0tPcGF6bjl1b1dwUkR3TkYz?=
 =?utf-8?Q?obwXnuGsxI87ihi6l1zRRfJGCIOAD/fj72x0OlGf3iAh?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3458b9-e54b-453a-c13a-08db41abd228
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:30:42.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qF3g93y6JGPqg4lJlOL1zKSMVh/mzADE5b8N134bgI6g54YJklJPzU6XrUTWJk5lBmp4OsYpy7p7mN0373Lho5MZqj2pKs/Op2XtcwGnzxdrnQOCPaadYM0vzrxVtP4r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB2804
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 20-04-2023 06:07 pm, Ganapatrao Kulkarni wrote:
> 
> 
> On 20-04-2023 06:00 pm, James Clark wrote:
>>
>>
>> On 20/04/2023 12:47, Ganapatrao Kulkarni wrote:
>>>
>>> Hi James,
>>>
>>> On 20-04-2023 03:13 pm, James Clark wrote:
>>>>
>>>>
>>>> On 19/04/2023 18:21, Ganapatrao Kulkarni wrote:
>>>>> The current implementation supports coresight trace for a range of
>>>>> CPUs, if the first CPU is CPU0.
>>>>>
>>>>> Adding changes to enable coresight trace for any range of CPUs by
>>>>> decoding the first CPU also from the header.
>>>>> Later, first CPU id is used instead of CPU0 across the decoder
>>>>> functions.
>>>>>
>>>>> Signed-off-by: Ganapatrao Kulkarni 
>>>>> <gankulkarni@os.amperecomputing.com>
>>>>> ---
>>>>>    .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 +-
>>>>>    .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
>>>>>    tools/perf/util/cs-etm.c                      | 62 
>>>>> ++++++++++++-------
>>>>>    3 files changed, 42 insertions(+), 27 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>>> b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>>> index 82a27ab90c8b..41ab299b643b 100644
>>>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>>> @@ -724,7 +724,7 @@ cs_etm_decoder__create_etm_decoder(struct
>>>>> cs_etm_decoder_params *d_params,
>>>>>    }
>>>>>      struct cs_etm_decoder *
>>>>> -cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params
>>>>> *d_params,
>>>>> +cs_etm_decoder__new(int first_decoder, int decoders, struct
>>>>> cs_etm_decoder_params *d_params,
>>>>>                struct cs_etm_trace_params t_params[])
>>>>>    {
>>>>>        struct cs_etm_decoder *decoder;
>>>>> @@ -769,7 +769,7 @@ cs_etm_decoder__new(int decoders, struct
>>>>> cs_etm_decoder_params *d_params,
>>>>>        /* init raw frame logging if required */
>>>>>        cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
>>>>>    -    for (i = 0; i < decoders; i++) {
>>>>> +    for (i = first_decoder; i < decoders; i++) {
>>>>>            ret = cs_etm_decoder__create_etm_decoder(d_params,
>>>>>                                 &t_params[i],
>>>>>                                 decoder);
>>>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>>> b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>>> index 92a855fbe5b8..b06193fc75b4 100644
>>>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>>> @@ -90,7 +90,8 @@ int cs_etm_decoder__process_data_block(struct
>>>>> cs_etm_decoder *decoder,
>>>>>                           size_t len, size_t *consumed);
>>>>>      struct cs_etm_decoder *
>>>>> -cs_etm_decoder__new(int num_cpu,
>>>>> +cs_etm_decoder__new(int first_decoder,
>>>>> +            int decoders,
>>>>>                struct cs_etm_decoder_params *d_params,
>>>>>                struct cs_etm_trace_params t_params[]);
>>>>>    diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>>>> index 94e2d02009eb..2619513ae088 100644
>>>>> --- a/tools/perf/util/cs-etm.c
>>>>> +++ b/tools/perf/util/cs-etm.c
>>>>> @@ -55,6 +55,8 @@ struct cs_etm_auxtrace {
>>>>>        u8 has_virtual_ts; /* Virtual/Kernel timestamps in the 
>>>>> trace. */
>>>>>          int num_cpu;
>>>>> +    int first_cpu;
>>>>> +    int last_cpu;
>>>>>        u64 latest_kernel_timestamp;
>>>>>        u32 auxtrace_type;
>>>>>        u64 branches_sample_type;
>>>>> @@ -638,14 +640,13 @@ static void cs_etm__set_trace_param_ete(struct
>>>>> cs_etm_trace_params *t_params,
>>>>>    }
>>>>>      static int cs_etm__init_trace_params(struct cs_etm_trace_params
>>>>> *t_params,
>>>>> -                     struct cs_etm_auxtrace *etm,
>>>>> -                     int decoders)
>>>>> +                     struct cs_etm_auxtrace *etm)
>>>>>    {
>>>>>        int i;
>>>>>        u32 etmidr;
>>>>>        u64 architecture;
>>>>>    -    for (i = 0; i < decoders; i++) {
>>>>> +    for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>>>>>            architecture = etm->metadata[i][CS_ETM_MAGIC];
>>>>>              switch (architecture) {
>>>>> @@ -817,7 +818,7 @@ static void cs_etm__free(struct perf_session
>>>>> *session)
>>>>>        /* Then the RB tree itself */
>>>>>        intlist__delete(traceid_list);
>>>>>    -    for (i = 0; i < aux->num_cpu; i++)
>>>>> +    for (i = aux->first_cpu; i < aux->last_cpu; i++)
>>>>>            zfree(&aux->metadata[i]);
>>>>>          thread__zput(aux->unknown_thread);
>>>>> @@ -921,7 +922,8 @@ static struct cs_etm_queue
>>>>> *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>>>>>         * Each queue can only contain data from one CPU when
>>>>> unformatted, so only one decoder is
>>>>>         * needed.
>>>>>         */
>>>>> -    int decoders = formatted ? etm->num_cpu : 1;
>>>>> +    int first_decoder = formatted ? etm->first_cpu : 0;
>>>>> +    int decoders = first_decoder + (formatted ? etm->num_cpu : 1);
>>>>>          etmq = zalloc(sizeof(*etmq));
>>>>>        if (!etmq)
>>>>> @@ -937,7 +939,7 @@ static struct cs_etm_queue
>>>>> *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>>>>>        if (!t_params)
>>>>>            goto out_free;
>>>>>    -    if (cs_etm__init_trace_params(t_params, etm, decoders))
>>>>> +    if (cs_etm__init_trace_params(t_params, etm))
>>>>>            goto out_free;
>>>>>          /* Set decoder parameters to decode trace packets */
>>>>> @@ -947,8 +949,7 @@ static struct cs_etm_queue
>>>>> *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>>>>>                        formatted))
>>>>>            goto out_free;
>>>>>    -    etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
>>>>> -                        t_params);
>>>>> +    etmq->decoder = cs_etm_decoder__new(first_decoder, decoders,
>>>>> &d_params, t_params);
>>>>>          if (!etmq->decoder)
>>>>>            goto out_free;
>>>>> @@ -2959,11 +2960,11 @@ static int cs_etm__queue_aux_records(struct
>>>>> perf_session *session)
>>>>>     * Loop through the ETMs and complain if we find at least one where
>>>>> ts_source != 1 (virtual
>>>>>     * timestamps).
>>>>>     */
>>>>> -static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
>>>>> +static bool cs_etm__has_virtual_ts(u64 **metadata, struct
>>>>> cs_etm_auxtrace *etm)
>>>>>    {
>>>>>        int j;
>>>>>    -    for (j = 0; j < num_cpu; j++) {
>>>>> +    for (j = etm->first_cpu; j < etm->last_cpu; j++) {
>>>>>            switch (metadata[j][CS_ETM_MAGIC]) {
>>>>>            case __perf_cs_etmv4_magic:
>>>>>                if (HAS_PARAM(j, ETMV4, TS_SOURCE) ||
>>>>> metadata[j][CS_ETMV4_TS_SOURCE] != 1)
>>>>> @@ -2982,13 +2983,14 @@ static bool cs_etm__has_virtual_ts(u64
>>>>> **metadata, int num_cpu)
>>>>>    }
>>>>>      /* map trace ids to correct metadata block, from information in
>>>>> metadata */
>>>>> -static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 
>>>>> **metadata)
>>>>> +static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace 
>>>>> *etm)
>>>>>    {
>>>>>        u64 cs_etm_magic;
>>>>> +    u64 **metadata = etm->metadata;
>>>>>        u8 trace_chan_id;
>>>>>        int i, err;
>>>>>    -    for (i = 0; i < num_cpu; i++) {
>>>>> +    for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>>>>>            cs_etm_magic = metadata[i][CS_ETM_MAGIC];
>>>>>            switch (cs_etm_magic) {
>>>>>            case __perf_cs_etmv3_magic:
>>>>> @@ -3015,12 +3017,13 @@ static int cs_etm__map_trace_ids_metadata(int
>>>>> num_cpu, u64 **metadata)
>>>>>     * If we found AUX_HW_ID packets, then set any metadata marked as
>>>>> unused to the
>>>>>     * unused value to reduce the number of unneeded decoders created.
>>>>>     */
>>>>> -static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64
>>>>> **metadata)
>>>>> +static int cs_etm__clear_unused_trace_ids_metadata(struct
>>>>> cs_etm_auxtrace *etm)
>>>>>    {
>>>>>        u64 cs_etm_magic;
>>>>> +    u64 **metadata = etm->metadata;
>>>>>        int i;
>>>>>    -    for (i = 0; i < num_cpu; i++) {
>>>>> +    for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>>>>>            cs_etm_magic = metadata[i][CS_ETM_MAGIC];
>>>>>            switch (cs_etm_magic) {
>>>>>            case __perf_cs_etmv3_magic:
>>>>> @@ -3049,7 +3052,7 @@ int cs_etm__process_auxtrace_info_full(union
>>>>> perf_event *event,
>>>>>        int event_header_size = sizeof(struct perf_event_header);
>>>>>        int total_size = auxtrace_info->header.size;
>>>>>        int priv_size = 0;
>>>>> -    int num_cpu;
>>>>> +    int num_cpu, first_cpu = 0, last_cpu;
>>>>>        int err = 0;
>>>>>        int aux_hw_id_found;
>>>>>        int i, j;
>>>>> @@ -3068,22 +3071,31 @@ int cs_etm__process_auxtrace_info_full(union
>>>>> perf_event *event,
>>>>>        /* First the global part */
>>>>>        ptr = (u64 *) auxtrace_info->priv;
>>>>>        num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
>>>>> -    metadata = zalloc(sizeof(*metadata) * num_cpu);
>>>>> +
>>>>> +    /* Start parsing after the common part of the header */
>>>>> +    i = CS_HEADER_VERSION_MAX;
>>>>> +
>>>>> +    /*Get CPU id of first event */
>>>>> +    first_cpu = ptr[i + CS_ETM_CPU];
>>>>> +    last_cpu = first_cpu + num_cpu;
>>>>> +
>>>>> +    if (first_cpu > cpu__max_cpu().cpu ||
>>>>> +            last_cpu > cpu__max_cpu().cpu)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    metadata = zalloc(sizeof(*metadata) * last_cpu);
>>>>
>>>> Hi Ganapatrao,
>>>>
>>>> I think I see what the problem is, but I'm wondering if a better fix
>>>> would be to further decouple the CPU ID from the index in the array.
>>>>
>>>> With your change it's not clear what happens with sparse recordings, 
>>>> for
>>>> example 'perf record -e cs_etm// -C 1,3,5'. And it seems like there is
>>>
>>> This patch fixes for any range of CPUs.
>>> Record with sparse list of CPUs will not work with current code still.
>>>
>>
>> Is there a major issue that means sparse can't be done? I'm thinking it
>> would be best to fix both issues with one change while we understand
>> this part rather than a half fix that might have do be completely
>> re-understood and re-done later anyway. Unless there is some big blocker
>> but I can't see it?
>>
>>>> some wastage in the zalloc here for example if only CPU 256 is traced
>>>> then we'd still make 256 decoders but 255 of them would be unused?
>>>>
>>>> I tried to test sparse recordings, but your change doesn't apply to the
>>>> latest coresight/next branch. I did notice that 'perf report -D' 
>>>> doesn't
>>>> work with them on coresight/next (it just quits), but I couldn't see if
>>>> that's fixed with your change.
>>>
>>> My patch is rebased on 6.3-RC7 codebase with Mike's 3 perf patches
>>> related to dynamic id [1] support(queued for 6.4).
>>>
>>> "perf report -D" works for me.
>>
>> I was referring to sparse CPU lists, which I think you mentioned above
>> doesn't work even with this patch.
>>
>>>
>>> [1] https://www.spinics.net/lists/linux-perf-users/msg27452.html
>>>
>>
>> It should be based on the next branch here:
>> git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
> 
> OK.
>>
>>>>
>>>> Would a better fix not be to keep the metadata loops from 0-N and
>>>> instead save the CPU ID in cs_etm_decoder_params or the decoder. That
>>>> way it would support both sparse and not starting from 0 cases? I think
>>>
>>> Yep, I though this initially, it got complicated due to for more
>>> for-loops. I will try again and post V2.
>>>
>>
>> I can't imagine it would need any extra for loops off the top of my
>> head. Just saving the CPU ID in a few structs and using it wherever it's
>> needed instead of the loop index. I imagine most of the loops would
>> actually stay the same rather than be changed like you have in V1.
> 
> Working on V2, I will post it at the earliest.

My codebase is "6.3-RC7 + Mike's patche[1] + Anshuman/Suzuki patches[3]" 
and below diff works for any CPU range and sparse list as well.

I will send the V2 ASAP.

[root@B0-213 perf]# git diff
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 94e2d02009eb..bfed0bb8be98 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -274,6 +274,22 @@ static int cs_etm__metadata_set_trace_id(u8 
trace_chan_id, u64 *cpu_metadata)
                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         })

+
+static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu)
+{
+       int i;
+       u64 *metadata = NULL;
+
+       for (i = 0; i < etm->num_cpu; i++) {
+               if (etm->metadata[i][CS_ETM_CPU] == (u64)cpu) {
+                       metadata = etm->metadata[i];
+                       break;
+               }
+       }
+
+       return metadata;
+}
+
  /*
   * Handle the PERF_RECORD_AUX_OUTPUT_HW_ID event.
   *
@@ -344,7 +360,7 @@ static int cs_etm__process_aux_output_hw_id(struct 
perf_session *session,
         }

         /* not one we've seen before - lets map it */
-       cpu_data = etm->metadata[cpu];
+       cpu_data = get_cpu_data(etm, cpu);
         err = cs_etm__map_trace_id(trace_chan_id, cpu_data);
         if (err)
                 return err;


I tried below commands and works well with this diff.

timeout 8s ./perf record -e cs_etm// -C 0 dd if=/dev/zero of=/dev/null
timeout 8s ./perf record -e cs_etm// -C 1 dd if=/dev/zero of=/dev/null
timeout 8s ./perf record -e cs_etm// -C 1,3,5 dd if=/dev/zero of=/dev/null
timeout 8s ./perf record -e cs_etm// -C 10,3,12 dd if=/dev/zero of=/dev/null
timeout 8s ./perf record -e cs_etm//u -C 0-10 dd if=/dev/zero of=/dev/null
timeout 8s ./perf record -e cs_etm//u -C 10-20 dd if=/dev/zero of=/dev/nu

However I could not be able to apply to next branch of coresight repo
git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git

Then I looked at the code, it does not have Mike's dynamic ID patches[1] 
which are merged to perf/next.
It seems the code is not the latest or it is next for coresight driver only.

I think either patch should be rebased to most-recent kernel 
RC1/RCx(which I did) or perf-tools-next of [2] for perf tool.

[1] https://www.spinics.net/lists/linux-perf-users/msg27452.html
[2] git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
[3] https://www.spinics.net/lists/arm-kernel/msg1059012.html

>>
>>>> the code would be better if it's worded like "i < recorded_cpus" rather
>>>> than "i < cpu" to make it clear that i isn't actually the CPU ID it's
>>>> just an index.
>>>
>>> Yes, makes sense to call it "recorded_cpus".
>>>
>>>>
>>>> Also a new test for this scenario would probably be a good idea.
>>>>
>>>> Thanks
>>>> James
>>>>
>>> Thanks,
>>> Ganapat
> 
> Thanks,
> Ganapat

Thanks,
Ganapat
