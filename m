Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465ED6E949B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjDTMhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjDTMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:37:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1954221
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XO9nc0UVrLlV9KPm1FCt2RifUHM4KJfzfr1Fh4A2t0Yt0fv8O9hsukJuGoVbr1xVUCkaUITAn/I93AQiUY0ymwdKsjA96KaKFcjXBX3VzG4bSFFlV4aSsL0mmARXyHWhFsCb44qe9FhnSbHPja+08v5uaB1PLb6JmKZ5tHg8r9pDMTAm2XBKYyuAjOnHTCG1wvNTOyX1BECTypwd6mwdrr8tHasnlkUhmC9OtIu4rg/KXY8xMr7Iy+npuzVMQ6jko1Bno6fJ0F3EugmKEpJC8aFs0oHiArXovq2Oj/EsaYkslfmaXcOXg94uqVI6sMuEFFZ/5h3BpSowFsl6OAInSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmWdcxjPaKbE+0WFxjpxUXkOPATC3JoEeej3qFFXnMc=;
 b=P2lawpBf4CRqyChFIreWBb7j+uyAAJO+NeiXeTSQLank9xsBOtHmS86mO55/oIdVBKsZpjsOLwWikoTk1sPDFoY7AdhlbqsQcRAEYmunBHyk2J9uDXfRI7SkXB/axG/3y5VWIdp3TemFxOHqo5OGKsLZlueJ6xLjGrgor6rjJ2o91dkyBEl0BZv7UmUAmaO3O0jG12kfwL3ZMPMfYwpASZsTm/N3icizKJkJTUNkSKJoaZBKfB0bWv+RgFmDEBJ7APe3CYApoiY3QFfGHloCQ44AsuaBZd8gB6JUIyL3l9iqPOKoshBOQttYMn1/TtvJq18ZLgUCUkomRt6FfewLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmWdcxjPaKbE+0WFxjpxUXkOPATC3JoEeej3qFFXnMc=;
 b=kP00xQud92zNzeduzVRFMxi/nMbjZNFDr/i7cBx0YdQB+cu0tUhQGThuUnaZExVBxOhGGxcLkIgcL/ROBnL7ZDF/wugk28Al0X3BbEiOOpjPLPVxJbRdfJiePj5/UN1pbARWY0I6WJl8oNwLlj3VB+arTWHiGC67nnYITPjVZu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20; Thu, 20 Apr 2023 12:37:29 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::5cf:2baf:f5ab:ac87]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::5cf:2baf:f5ab:ac87%5]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 12:37:29 +0000
Message-ID: <dea08376-e66b-bacc-7673-c79fe2a8f889@os.amperecomputing.com>
Date:   Thu, 20 Apr 2023 18:07:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf cs-etm: Add support for coresight trace for any
 range of CPUs
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, acme@kernel.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        scclevenger@os.amperecomputing.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com
References: <20230419172101.78638-1-gankulkarni@os.amperecomputing.com>
 <d758c5e2-aa32-d829-35ee-a685bdb56f75@arm.com>
 <84eb3363-2ef8-d3f1-4613-805959dbf334@os.amperecomputing.com>
 <91ba66e7-737f-6526-a703-a755e114f9d4@arm.com>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <91ba66e7-737f-6526-a703-a755e114f9d4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:610:58::35) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|MWHPR0101MB3165:EE_
X-MS-Office365-Filtering-Correlation-Id: 24446540-8098-4bf6-2fa8-08db419c011d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wS7/VqdqIFC719khyUG2GEzLCFINP2WJxkb0f3G+WQdpoqGx3DJXfe6csqCLS9jTisfSFoMV3qaplZ1M6ajFUwu5mxDZHE7Kqdoo5vgRYOrzsCqO9v5SsbIUdqO1LzDbrrZyUS+rZ8Z/IgJW2ct3/fxB2dlHgVBlzpsCSoKH8oyaUyjq/X0vS9EqJ4aIW4OJskJvgMc7ebRttswtVyUqpjvwjdyBqddMLZSH64OzFrRVIzVhl1eQ3cVahJtkH2wIf3hvTprPcWmGN8NZd1jQpAj4bqVopbUg86YufuFjbwv/+wb4T60X+m4nHR4xzCMShxzxyiM75BNp2rQcmzW6LADhqwQ7X15OYdNSEfQZuxisHx2lI8IdbgFUUvY6SiPc/02cB9xDxDQ4S1SHK5BvDOLyoisci9L0GVOvXvYlHRZnbwdQsDeiPifvo7i8i75+ZU7ik3Kn+67hTOLB5Fb+qwuFLgShk2dLnuymDhTmgVn5lWp04P0BY9BkYwzWs8bPI2T5eFQYJx69jYWqL1hhUevSnQvs3i81U8DY5G9QeNzPwP6rLo6+9qisqeFopsaTo1MyrgU+U8tqBrjeF0wcav8eSmdDn8TNlYwOSFW4VUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(366004)(39850400004)(451199021)(5660300002)(2616005)(31696002)(53546011)(6512007)(186003)(26005)(86362001)(6506007)(38100700002)(478600001)(6486002)(4326008)(316002)(8936002)(6666004)(966005)(8676002)(41300700001)(66946007)(6916009)(66556008)(66476007)(31686004)(83380400001)(30864003)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1JaZGpWVjhqR1VWZksxQ0tWa2gwV1JSMWVtK0J5L25DYTQxaE9zbnE0bjR0?=
 =?utf-8?B?Mm9IRnRFajlJc3M0MWRlbGpuLzZhL2tlbkhWQ1VMMnZCVjhPNXdyeHlsWmY2?=
 =?utf-8?B?NWc2amxkeDBsZGlYa0NUUmw4c3FMc0FLUWpZVDdjZFFnN3o3MTBmYzZHckUy?=
 =?utf-8?B?VmwwMURPY1R1TFV0ejA1UmJFNnhENGdacUNwTzRPMFRKNHV3dE91SXJkMkVI?=
 =?utf-8?B?WFZZUkJ6ekgycG5kWGlXNDVReEtzSjQ1djczN3c0SHVtTUxBckpGekw5VVJN?=
 =?utf-8?B?QUo4elY3czlBSzYrU0hPeS95czJ5N2Zuc1VZQUpCSS9xdmpSUG8yL1o0UVds?=
 =?utf-8?B?RjBKaG1nYWNhY1NPWEROaGxOU2ZQUTRoT2w4VnA1bHM0clozYnd3M2tEL1N6?=
 =?utf-8?B?S0lNdHZIeExMQm10dzRlL01iYWVMSGtEbHZCdCtwMjNDNStSbkF0dEhTaGhv?=
 =?utf-8?B?Vm80MkFkNnZBS3NSMGovUWNGdVFmOUNqcW8xZEMvb2lVNkxzRS9nT09HVnpq?=
 =?utf-8?B?LzYwNlVqZmZsUERhVnM1NHloOTF2R3gxMmIrMjlLOHhLZXc1QUY1dUxpdi9O?=
 =?utf-8?B?OCtoMGNTMG0rNGJYWGxJZmZHWjRaZjE1VnE3QjVzOW5ML0ZodVhaUU8relF2?=
 =?utf-8?B?K09DWXd2UDNsbjAyMldoRllaUDYrZW9oZWlFTXFaNEtwLzFDZFBWQXdxamxi?=
 =?utf-8?B?ZVRKTVBsaUlBRTRXMi9GK21ZTTZQcjlpUDk1dDd3YzVpRlVoT09aT2xNQTFO?=
 =?utf-8?B?dUVVcFR0TzkvSThlQUtUbW9CejlPakNST0tHR3dhVmFSQVZvNWd1N2hvTGxT?=
 =?utf-8?B?Mi9sUWJOY3hJZ1RnbytsbGxydEFMcnR5eHlJdzBiMlkvTER0ZTNOVS9kdjJi?=
 =?utf-8?B?K3FiNFdzR3A0ZFN6N3dCMCtsa25ndncxZHdSK01Wc24wNEM4bUhBMlUySGJr?=
 =?utf-8?B?Y3hOSWpwZDFzMlZaalRyaUVMVzY1WEd0d0g2QndoK1VEdEFFcWxySTBnazQ3?=
 =?utf-8?B?SjROYWN3NHc2OG90dGwyUW9GYStERE9uQmtnT1NMVVIxejdSRDlXME55djFQ?=
 =?utf-8?B?R2FDRWgvMzE1bTNsMVc5NDFIZ2lMd1hPMkIvNkZiM0JZQVFCMlNLYlBjWnBO?=
 =?utf-8?B?NUJYaktnbmZFOEd4eEZZTEZGd3ZSdkNseW1pNmRBMkN6bzVJMlBRdHpXS2dN?=
 =?utf-8?B?TUsyVE9ZZlBuSVd6d1I2Rm1IVG5qWi9ra1R2Vy9kZTZDR0h2d2FBZmNMUVgz?=
 =?utf-8?B?dnpUaW00VGJiekhPc3VVU2lnc3o5VlRkQ1lBNllCTXRkaWVEL21rdTNwc1pM?=
 =?utf-8?B?Q0hTTmphYnB0dUNPTWY0R24yYWlaWFlkQ3lNYUY3dTBnRG1hSUFsd29LU3Jt?=
 =?utf-8?B?V2hQY3h1SG9PL3VsRWxxZ1B2alBjM0dYTGNPbmxSVXJqOXpvZFcwdElFV3U1?=
 =?utf-8?B?citzVE5pZW9kNC8xa3MwUmhUcTl6aDFDODdvbUdqN2YrcnA2ampSRVFTL3Bh?=
 =?utf-8?B?QXd4T0UvWC9TWHpBaXhma09Pc0NEL2lUMWw4ZHduOUdPdi9XREkzdVZIR2lh?=
 =?utf-8?B?OXJhRk9kemxSaWlpanB4VE43QnVTbzdZbjhIdXlwcnAzTGFQUldHZXdnSG1q?=
 =?utf-8?B?Z1BpdjRaKyttRWk4azVxWDlMeFdNZHA2aTFsTC9NMWczWjhzUUpCUCtMT2hs?=
 =?utf-8?B?eHdmYWFPSzZWdGYrQ3ZvTmFFTENueXBYZTlYNGk3aEd6b1c4dkNpWlByd1BR?=
 =?utf-8?B?emVuQlNKaG52bGFBZGNhQ3ZwVnQ3Tk13TkU5SG9tZE9VSXhvUTg3cEg3QW5B?=
 =?utf-8?B?djdoTldIcFFYeEpqVGJXRUtjWEtNS3V6UldLb0VoZHBsV3ZUVXFSUlMvcVNL?=
 =?utf-8?B?WlZ5SFFZNEE4djE2SUgvMDhrb3hWVDE3WW5ka3p0cDNQM1g5eHdQazVCWVVR?=
 =?utf-8?B?M3gxcjl4VzhodkFDOFRMRVM0ZzYzTXEwNXpXcGM2dUlrZldoQW9TeWJuNk41?=
 =?utf-8?B?dU82TGZzandHTS8zdURHc09wR3gxSTJWS2dWcyt2bzBJamIyWm8vMVpEWHk2?=
 =?utf-8?B?N3pSUlRXQjdKSEpZUHhCYlRVTUdhK045dkdtL256S2lnSndPbTNuY01SWnkz?=
 =?utf-8?B?N081bHRqRVFqYU4vYWsrTzE3YVlRN0FyYkFUY0dpaW5nZVp1VXIzTEhoSWIv?=
 =?utf-8?Q?2dVaA3ze8bZ8mhfFjQarLdRCduaaYJfAuRBoVk5gPxUy?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24446540-8098-4bf6-2fa8-08db419c011d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 12:37:29.4431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG24tQHfQepWFtg7GWN1R4FDM3sMT3dDfrO0PoQ9QnkAMrl7bvQaDNnSvtz4oJnZZ2E0IuPNsQx4BYUsaiIoHoKvvkXcOajbyEd652FQq0LpDHETkpYTKDsmmBg3nr5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0101MB3165
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20-04-2023 06:00 pm, James Clark wrote:
> 
> 
> On 20/04/2023 12:47, Ganapatrao Kulkarni wrote:
>>
>> Hi James,
>>
>> On 20-04-2023 03:13 pm, James Clark wrote:
>>>
>>>
>>> On 19/04/2023 18:21, Ganapatrao Kulkarni wrote:
>>>> The current implementation supports coresight trace for a range of
>>>> CPUs, if the first CPU is CPU0.
>>>>
>>>> Adding changes to enable coresight trace for any range of CPUs by
>>>> decoding the first CPU also from the header.
>>>> Later, first CPU id is used instead of CPU0 across the decoder
>>>> functions.
>>>>
>>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>>> ---
>>>>    .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 +-
>>>>    .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
>>>>    tools/perf/util/cs-etm.c                      | 62 ++++++++++++-------
>>>>    3 files changed, 42 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>> b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>> index 82a27ab90c8b..41ab299b643b 100644
>>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>> @@ -724,7 +724,7 @@ cs_etm_decoder__create_etm_decoder(struct
>>>> cs_etm_decoder_params *d_params,
>>>>    }
>>>>      struct cs_etm_decoder *
>>>> -cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params
>>>> *d_params,
>>>> +cs_etm_decoder__new(int first_decoder, int decoders, struct
>>>> cs_etm_decoder_params *d_params,
>>>>                struct cs_etm_trace_params t_params[])
>>>>    {
>>>>        struct cs_etm_decoder *decoder;
>>>> @@ -769,7 +769,7 @@ cs_etm_decoder__new(int decoders, struct
>>>> cs_etm_decoder_params *d_params,
>>>>        /* init raw frame logging if required */
>>>>        cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
>>>>    -    for (i = 0; i < decoders; i++) {
>>>> +    for (i = first_decoder; i < decoders; i++) {
>>>>            ret = cs_etm_decoder__create_etm_decoder(d_params,
>>>>                                 &t_params[i],
>>>>                                 decoder);
>>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>> b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>> index 92a855fbe5b8..b06193fc75b4 100644
>>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>> @@ -90,7 +90,8 @@ int cs_etm_decoder__process_data_block(struct
>>>> cs_etm_decoder *decoder,
>>>>                           size_t len, size_t *consumed);
>>>>      struct cs_etm_decoder *
>>>> -cs_etm_decoder__new(int num_cpu,
>>>> +cs_etm_decoder__new(int first_decoder,
>>>> +            int decoders,
>>>>                struct cs_etm_decoder_params *d_params,
>>>>                struct cs_etm_trace_params t_params[]);
>>>>    diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>>> index 94e2d02009eb..2619513ae088 100644
>>>> --- a/tools/perf/util/cs-etm.c
>>>> +++ b/tools/perf/util/cs-etm.c
>>>> @@ -55,6 +55,8 @@ struct cs_etm_auxtrace {
>>>>        u8 has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
>>>>          int num_cpu;
>>>> +    int first_cpu;
>>>> +    int last_cpu;
>>>>        u64 latest_kernel_timestamp;
>>>>        u32 auxtrace_type;
>>>>        u64 branches_sample_type;
>>>> @@ -638,14 +640,13 @@ static void cs_etm__set_trace_param_ete(struct
>>>> cs_etm_trace_params *t_params,
>>>>    }
>>>>      static int cs_etm__init_trace_params(struct cs_etm_trace_params
>>>> *t_params,
>>>> -                     struct cs_etm_auxtrace *etm,
>>>> -                     int decoders)
>>>> +                     struct cs_etm_auxtrace *etm)
>>>>    {
>>>>        int i;
>>>>        u32 etmidr;
>>>>        u64 architecture;
>>>>    -    for (i = 0; i < decoders; i++) {
>>>> +    for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>>>>            architecture = etm->metadata[i][CS_ETM_MAGIC];
>>>>              switch (architecture) {
>>>> @@ -817,7 +818,7 @@ static void cs_etm__free(struct perf_session
>>>> *session)
>>>>        /* Then the RB tree itself */
>>>>        intlist__delete(traceid_list);
>>>>    -    for (i = 0; i < aux->num_cpu; i++)
>>>> +    for (i = aux->first_cpu; i < aux->last_cpu; i++)
>>>>            zfree(&aux->metadata[i]);
>>>>          thread__zput(aux->unknown_thread);
>>>> @@ -921,7 +922,8 @@ static struct cs_etm_queue
>>>> *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>>>>         * Each queue can only contain data from one CPU when
>>>> unformatted, so only one decoder is
>>>>         * needed.
>>>>         */
>>>> -    int decoders = formatted ? etm->num_cpu : 1;
>>>> +    int first_decoder = formatted ? etm->first_cpu : 0;
>>>> +    int decoders = first_decoder + (formatted ? etm->num_cpu : 1);
>>>>          etmq = zalloc(sizeof(*etmq));
>>>>        if (!etmq)
>>>> @@ -937,7 +939,7 @@ static struct cs_etm_queue
>>>> *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>>>>        if (!t_params)
>>>>            goto out_free;
>>>>    -    if (cs_etm__init_trace_params(t_params, etm, decoders))
>>>> +    if (cs_etm__init_trace_params(t_params, etm))
>>>>            goto out_free;
>>>>          /* Set decoder parameters to decode trace packets */
>>>> @@ -947,8 +949,7 @@ static struct cs_etm_queue
>>>> *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>>>>                        formatted))
>>>>            goto out_free;
>>>>    -    etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
>>>> -                        t_params);
>>>> +    etmq->decoder = cs_etm_decoder__new(first_decoder, decoders,
>>>> &d_params, t_params);
>>>>          if (!etmq->decoder)
>>>>            goto out_free;
>>>> @@ -2959,11 +2960,11 @@ static int cs_etm__queue_aux_records(struct
>>>> perf_session *session)
>>>>     * Loop through the ETMs and complain if we find at least one where
>>>> ts_source != 1 (virtual
>>>>     * timestamps).
>>>>     */
>>>> -static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
>>>> +static bool cs_etm__has_virtual_ts(u64 **metadata, struct
>>>> cs_etm_auxtrace *etm)
>>>>    {
>>>>        int j;
>>>>    -    for (j = 0; j < num_cpu; j++) {
>>>> +    for (j = etm->first_cpu; j < etm->last_cpu; j++) {
>>>>            switch (metadata[j][CS_ETM_MAGIC]) {
>>>>            case __perf_cs_etmv4_magic:
>>>>                if (HAS_PARAM(j, ETMV4, TS_SOURCE) ||
>>>> metadata[j][CS_ETMV4_TS_SOURCE] != 1)
>>>> @@ -2982,13 +2983,14 @@ static bool cs_etm__has_virtual_ts(u64
>>>> **metadata, int num_cpu)
>>>>    }
>>>>      /* map trace ids to correct metadata block, from information in
>>>> metadata */
>>>> -static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
>>>> +static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace *etm)
>>>>    {
>>>>        u64 cs_etm_magic;
>>>> +    u64 **metadata = etm->metadata;
>>>>        u8 trace_chan_id;
>>>>        int i, err;
>>>>    -    for (i = 0; i < num_cpu; i++) {
>>>> +    for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>>>>            cs_etm_magic = metadata[i][CS_ETM_MAGIC];
>>>>            switch (cs_etm_magic) {
>>>>            case __perf_cs_etmv3_magic:
>>>> @@ -3015,12 +3017,13 @@ static int cs_etm__map_trace_ids_metadata(int
>>>> num_cpu, u64 **metadata)
>>>>     * If we found AUX_HW_ID packets, then set any metadata marked as
>>>> unused to the
>>>>     * unused value to reduce the number of unneeded decoders created.
>>>>     */
>>>> -static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64
>>>> **metadata)
>>>> +static int cs_etm__clear_unused_trace_ids_metadata(struct
>>>> cs_etm_auxtrace *etm)
>>>>    {
>>>>        u64 cs_etm_magic;
>>>> +    u64 **metadata = etm->metadata;
>>>>        int i;
>>>>    -    for (i = 0; i < num_cpu; i++) {
>>>> +    for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>>>>            cs_etm_magic = metadata[i][CS_ETM_MAGIC];
>>>>            switch (cs_etm_magic) {
>>>>            case __perf_cs_etmv3_magic:
>>>> @@ -3049,7 +3052,7 @@ int cs_etm__process_auxtrace_info_full(union
>>>> perf_event *event,
>>>>        int event_header_size = sizeof(struct perf_event_header);
>>>>        int total_size = auxtrace_info->header.size;
>>>>        int priv_size = 0;
>>>> -    int num_cpu;
>>>> +    int num_cpu, first_cpu = 0, last_cpu;
>>>>        int err = 0;
>>>>        int aux_hw_id_found;
>>>>        int i, j;
>>>> @@ -3068,22 +3071,31 @@ int cs_etm__process_auxtrace_info_full(union
>>>> perf_event *event,
>>>>        /* First the global part */
>>>>        ptr = (u64 *) auxtrace_info->priv;
>>>>        num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
>>>> -    metadata = zalloc(sizeof(*metadata) * num_cpu);
>>>> +
>>>> +    /* Start parsing after the common part of the header */
>>>> +    i = CS_HEADER_VERSION_MAX;
>>>> +
>>>> +    /*Get CPU id of first event */
>>>> +    first_cpu = ptr[i + CS_ETM_CPU];
>>>> +    last_cpu = first_cpu + num_cpu;
>>>> +
>>>> +    if (first_cpu > cpu__max_cpu().cpu ||
>>>> +            last_cpu > cpu__max_cpu().cpu)
>>>> +        return -EINVAL;
>>>> +
>>>> +    metadata = zalloc(sizeof(*metadata) * last_cpu);
>>>
>>> Hi Ganapatrao,
>>>
>>> I think I see what the problem is, but I'm wondering if a better fix
>>> would be to further decouple the CPU ID from the index in the array.
>>>
>>> With your change it's not clear what happens with sparse recordings, for
>>> example 'perf record -e cs_etm// -C 1,3,5'. And it seems like there is
>>
>> This patch fixes for any range of CPUs.
>> Record with sparse list of CPUs will not work with current code still.
>>
> 
> Is there a major issue that means sparse can't be done? I'm thinking it
> would be best to fix both issues with one change while we understand
> this part rather than a half fix that might have do be completely
> re-understood and re-done later anyway. Unless there is some big blocker
> but I can't see it?
> 
>>> some wastage in the zalloc here for example if only CPU 256 is traced
>>> then we'd still make 256 decoders but 255 of them would be unused?
>>>
>>> I tried to test sparse recordings, but your change doesn't apply to the
>>> latest coresight/next branch. I did notice that 'perf report -D' doesn't
>>> work with them on coresight/next (it just quits), but I couldn't see if
>>> that's fixed with your change.
>>
>> My patch is rebased on 6.3-RC7 codebase with Mike's 3 perf patches
>> related to dynamic id [1] support(queued for 6.4).
>>
>> "perf report -D" works for me.
> 
> I was referring to sparse CPU lists, which I think you mentioned above
> doesn't work even with this patch.
> 
>>
>> [1] https://www.spinics.net/lists/linux-perf-users/msg27452.html
>>
> 
> It should be based on the next branch here:
> git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git

OK.
> 
>>>
>>> Would a better fix not be to keep the metadata loops from 0-N and
>>> instead save the CPU ID in cs_etm_decoder_params or the decoder. That
>>> way it would support both sparse and not starting from 0 cases? I think
>>
>> Yep, I though this initially, it got complicated due to for more
>> for-loops. I will try again and post V2.
>>
> 
> I can't imagine it would need any extra for loops off the top of my
> head. Just saving the CPU ID in a few structs and using it wherever it's
> needed instead of the loop index. I imagine most of the loops would
> actually stay the same rather than be changed like you have in V1.

Working on V2, I will post it at the earliest.
> 
>>> the code would be better if it's worded like "i < recorded_cpus" rather
>>> than "i < cpu" to make it clear that i isn't actually the CPU ID it's
>>> just an index.
>>
>> Yes, makes sense to call it "recorded_cpus".
>>
>>>
>>> Also a new test for this scenario would probably be a good idea.
>>>
>>> Thanks
>>> James
>>>
>> Thanks,
>> Ganapat

Thanks,
Ganapat
