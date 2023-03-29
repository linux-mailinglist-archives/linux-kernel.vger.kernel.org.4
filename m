Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33706CEFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC2Qln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC2Qlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:41:40 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2126.outbound.protection.outlook.com [40.107.102.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0370A7;
        Wed, 29 Mar 2023 09:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdYKtJqc+RQ7sVjBh2JtBa48Eg0xlN5/N6uvlskIWBFt0LxHyIxLjbawM0f6pvnBTRvAM8dt1xJKOz7kicU7iM9RwF05PS+wjNSv9MlEn96wY1VUMQlZK/thnY6XRKO7rVvkzRWN3GtqAyhvJqInOEAz3K8uew5SyUznaUH29EQanInq4IkgB/8NzAYKlh1Mjze/sR2thfLFtRfK1kHtN8q1+zP56ivbBuBebYT+W2LrO5aI1J9JH6NG3S2ruyeWwj5jGrwk/+FGm+qdmLo7MxHqV351BAJcKO2cOVfAnHGBbe7eH+YH5NUl/ZV5XOjF7x55J4jnWQAbxfwoh9s9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epRNx8s+4RYcM9QOhhGOUWf3daSORC7SCLn1fGasWDM=;
 b=JYx8nMTjbZ6OU079FKcWAHuishdh2x1nG0ixEXrknF32HaJcXbvRVRbaB81VEsAlxgngEsLzs7Slh/2PWFLuMiUtm6jN3TJs1soD2iNuRQQdGEo8n3sHRiujva1nHQiLmyhkkOO6YpUOt2zEKCwil4xPmWGfSazHbQF+UgYunfH5nTBH/dckrmi5hKON+aQ76TWFn6ybYGV6EPsncMaw0UK5TSdj8+YQDF1eaKPbbR8LyiVEk6w9TIEAZntp1SQNEd38ae2GfrWZ6SlqwtgZT1oPMbpLGwX0HEKa/riXgaY7Rh/ROtacZuwJ3nmMDVKoii98Q4t35/UjLtWf2F6avw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epRNx8s+4RYcM9QOhhGOUWf3daSORC7SCLn1fGasWDM=;
 b=ML9WT1YGN5UIcAnI7APMKIXgbU5mk5kmfVAlfZxahgJxuTZXCWfMjZCnKcizIQa5lbqY4N+QhklXDPotEb/9NUTqAxPv5llBHE9qi0caxF5/9GwWX8tKEDO6vCz1gyA+UeLP7fqz8+ZFx38BiaM87NRuicv7XpictTEKItVeeqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 SN6PR0102MB3613.prod.exchangelabs.com (2603:10b6:805:5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.16; Wed, 29 Mar 2023 16:41:34 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6e60:1252:2c84:191c]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6e60:1252:2c84:191c%2]) with mapi id 15.20.6254.018; Wed, 29 Mar 2023
 16:41:33 +0000
Message-ID: <cce8664c-6d12-0bdf-ff0e-d2f45dfc5804@os.amperecomputing.com>
Date:   Wed, 29 Mar 2023 22:11:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: v4: Re: [PATCH v7 00/15] coresight: Add new API to allocate trace
 source ID values
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>
References: <20230116124928.5440-1-mike.leach@linaro.org>
 <546f218f-3ac9-8fc2-c843-2f2f16882f31@arm.com>
 <5b7df6df-0c2d-6953-0f50-e85745cb1f4b@arm.com>
 <2864f28e-dd2f-5a9c-922f-5c044a864beb@arm.com>
 <e3df35fe-a00d-69ec-32ee-53c949909cab@arm.com>
 <6a71acac-c478-6e5d-3165-4ba9526614db@arm.com>
 <5556dc65-79ef-e8d2-e5b4-046594af78ea@os.amperecomputing.com>
 <ZCQ65pLbikC83Jqf@kernel.org>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <ZCQ65pLbikC83Jqf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:610:b2::22) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|SN6PR0102MB3613:EE_
X-MS-Office365-Filtering-Correlation-Id: edf414aa-f9bc-4dbc-a467-08db307474af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l096xLwmVCVr0mkNAn6NfIrqLCz+KKabyexUbl9ltVhxTwsqwWc2A1RZ5Rmgc5/qYVM+ZqzwwsTpXuUQpWSR6DnqyHF5NnYk1ja9v59LndaTrdGzlK84r+iBjEMfmrIcShM/VFHzs20THH+EwaD7t8ryJts9UKG6IJITsUT1HfII9RlWap41E0GQTGiaD0mJ+YLSpopDHKKl1pki8Xxj8QZx8A9xtksYSrPRTnZmXAxBzCVNeE/zO9xh4qFur+Y4v8hJaba0KZQjTP/Q9CpFdg1VMXYAHvJEH9yzkUWU0U+iu+qAh9bOe4ID9H2kRVNtn+TzRiGUcPoK0YvVxj8CUnEGipXRDTTggsyJt8TGSUIlP1cTrbu3T1ym3Vud/OyxZiiT+NJzZRfeR0oRf9dmS2+LTPu4YSLXNlQA60Pic6o3AwSnktKnh2XJaVPS79aktBNrXxaRrdTfkDOVVoUfU0kw9DvWo4SMOZLxJiSNC/aPHhbEKTO4VN9AZRW5HgFaf2UQnukARDXNKMOBM4KUxf4lT20jRp0vMNk3zoNsc6r02ReLMhRFtUTfW8opGQgRqMu7RJi1Qg+cNO7wQhu0i+qLJSCm3VqOj9a4BvsPc4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(39850400004)(136003)(451199021)(316002)(478600001)(54906003)(31696002)(86362001)(8936002)(5660300002)(66556008)(7416002)(4326008)(38100700002)(66476007)(66946007)(2906002)(8676002)(6916009)(6506007)(41300700001)(186003)(6666004)(53546011)(6512007)(26005)(2616005)(83380400001)(31686004)(6486002)(966005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnJzdzFSTnV6U1hiSmh5Z2ZNUXdtUXhaSS9uYXhWUmtXQ2h6M0JQQjdYQSty?=
 =?utf-8?B?MjlSZDFGQ2NCd09nUDNWOXZZN2txQzV3a0tpTmNTRmo2UlJsZzZRQzJSZ1dB?=
 =?utf-8?B?c1c3c3NqbDNabWQ1UGpwd2VGQTlFV2dDTW5Najg4RlQxNXlOQU91WWlHaVoz?=
 =?utf-8?B?eituZ0FoQnpVSnNSTGdaWnQxY2pwOUFFOHJCNGhyS3N0MDdib05JTDhTTWE4?=
 =?utf-8?B?bDFhRHVFZHh1M051T253bDVYMVdnVzAxRzRXdk4vMXRQRGpNNm43aVhHMkh4?=
 =?utf-8?B?WGwwRVRUMm5jaEVsc29hUG9jOUFZSjE2eEwySGdjUTlpQUpyT3pmTUtjVEE3?=
 =?utf-8?B?dHllWWtkMC9yYmdhWHlZMnkxaEVldm5rNHpVL3dQazJSUmVlL0JUVWdDV3RL?=
 =?utf-8?B?S2tTQzZFeDZacUF4dnNOQXhjTGc0NUZrWDdwL1M3WkJGcHFVc0R5MlVpVm1v?=
 =?utf-8?B?aFpQSWhpc0pvS2UzdFdkVmhBZ2trMFhDMmR1Y0d0aWppOVAySHZqRkRwMHZG?=
 =?utf-8?B?cW5XR2J2TVBsOWZjdllyTHl3QURkYy9DTmIyeDZsVHNWeVFvSGUzVVJGdmtK?=
 =?utf-8?B?Z0ZNaXJYSnZDVElZK3FWMGJhRmp6OGx3Nk1JbVZpc0FtWFQxM1hxeVNyUnVa?=
 =?utf-8?B?azlUZnI2ZjlUdTEzTFdmNlQ1RmlvZGNreVFvU0NhMFRkdmg3TUhlRUcxSzBr?=
 =?utf-8?B?WXdjR1VVS1FYamVTa0ZtNUgrTmQ5aTVWNi92Q3RCd3YzU1d2Um50REFHTysv?=
 =?utf-8?B?Vkx1MU1yZ1VqL0JVYlhDREdUbkhLL3d5WC9wTmd6aEhPdVZwSVJiYWtLUk5Y?=
 =?utf-8?B?aEdsWTgydnl3T1pBWE1HNktMdS9DNVhYdFR5Y2hCTUhlQnFqNUl1NkhjT0sz?=
 =?utf-8?B?Tkc4NGJ6dVdVY1BPMk14VnBkODBvZEM2QlQ1eEkzd3d2YXA5MDVlN0dSOHdn?=
 =?utf-8?B?WEErYWZGRG1OQi9kcFV5VVZacnQ1Wmt6SEc2OEkxZFRvSFhqRmkrRmswR3Vk?=
 =?utf-8?B?NWJBSm1YaUxFSSs4Wkg0UVBJQnp6ckFwNDhBSnNIcit2cFR4V29NUU9SVUlX?=
 =?utf-8?B?S2IyOC96NytVVURCbFI3MTYyWHZmdDJjcjhPRGw5VHc5eUhmVHlkay8yMmZB?=
 =?utf-8?B?UERTQVpIMHpuYnVvTldOSjN5RjBYcmpuNXozK2ZPd1UyKzVXeUYvcGdSd1VQ?=
 =?utf-8?B?ano0Sk5aSWJLQ3czZmhWUFBHRVQxTUJuN2lub1oxRE1qaVJvb1Zmby9oaGxC?=
 =?utf-8?B?OE1leTZOQ3lFWnVDeTIvZDlJbUoyeFBZSWVlQUd0VjZuVHp6TzNhODV2STB1?=
 =?utf-8?B?UEJYckdtR2VuUkcwcGtuck40YXhHWjMxak4ySFhWZmFHOVV2WmJlSUNVRUhL?=
 =?utf-8?B?TGxEeTJrM2dFcm5MV2ZxdjVURXlxdGxZTjN2ak0xOGFKUnpXeTh4c3ZVT3VF?=
 =?utf-8?B?a3M3Y0liZG5HZ2hiSWlFdGp3VHFZbTgyWG1ZWVlEaXVSQU1DcjUyY0lWSXIy?=
 =?utf-8?B?bFRsUWNtR0hmNTJtaHBMZ2JKL3Q0ZThNcUNDQ3dTclhsTC83R0cwYTNkVHBl?=
 =?utf-8?B?eC9FVllRa3NaYlVHclM5SGhPYmFYNjU2bDROdFZ5YVZCNWh3bXE4SFUyeGVG?=
 =?utf-8?B?RVVxNWw4VzJwTlBsdUVKWEt3SGl2cE1OQWZaZkNheHhVZjR2dXJ5ajNQTDMr?=
 =?utf-8?B?YlBacE9lL0oyTWFoNGQzSzllV0E5TEtpSUlqVXY0NkhqRjJXVURTVzRrb1dR?=
 =?utf-8?B?V1lBL0ltVmpNRlB2RUtMOWwzUnBHUjVnMVhBYkZycUUvaVhPblEvd1c4bTVU?=
 =?utf-8?B?cGR2NkQzNkdTUkY5THJQTEV5TGxlTGtqMWFLdzlDY3lJTFZIR1RIY2tSUEdV?=
 =?utf-8?B?WnFOcnBaYnZtS2UrOWVkSGRiLzJUdElHT0ZJdEJQbGhNa1ZVU3Z6eXBJQ3dM?=
 =?utf-8?B?bC95elFPVlNUTFUwMWN3Z1d3R0tOM05oY3VpOGZOUm1CS1EyUVNic094dnhF?=
 =?utf-8?B?M1NqUVRmd1dtK2xnc2p2dmJkc0JaRHEvVlZreUdXV0tUVVM5dTF4bDdXQlFz?=
 =?utf-8?B?NHYzVDRhcEErYm51MHRkc0M0VHlOZTcza21oaEx4RnR3bUI2MkRWRVlvQTEz?=
 =?utf-8?B?L0l0ZlNuaTV1Rk1aS2lheUc3eDl3WjdhZlB4akZpQkRIVXNyZ3p3R2FDUzcr?=
 =?utf-8?Q?RxPtifizPb3z+uM9P6Zj3OA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf414aa-f9bc-4dbc-a467-08db307474af
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:41:33.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZDQgAxJL4YzUcGkofW1LT1pKE+7BcCtEXFVrze7dC0iumPN4twOgjYVxKCHp4wcLd5fXLb0k2FqM/lFlGm/tWhsL0ajr/Bm63SOqKZEqzLW0KJ8kYfqXhGxz1B3yNEv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR0102MB3613
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29-03-2023 06:49 pm, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 29, 2023 at 09:44:47AM +0530, Ganapatrao Kulkarni escreveu:
>> Hi Mike,
>>
>> On 27-02-2023 03:56 pm, Suzuki K Poulose wrote:
>>> Mike,
>>>
>>> Please could you send all the perf tool related patches as a seperate
>>> series, with all the tags to Arnaldo directly at -rc1.
>>>
>>> Please add a cover letter explaining that the kernel changes are
>>> available upstream.
>>
>> Looks like, Perf tool patches corresponding to dynamic trace id are not yet
>> merged in to perf-tools-next.
>>
>> Without these patches, the mainline perf tool breaks for the coresight for
>> higher cores.
> 
> I'm pushing what I have to tmp.perf-tools-next while this + other
> changes goes thru my container set build tests.

Thanks Arnaldo!
> 
> - Arnaldo
>   
>>>
>>> Kind regards
>>> Suzuki
>>>
>>> On 20/02/2023 16:24, Suzuki K Poulose wrote:
>>>> Arnaldo
>>>>
>>>> Gentle ping
>>>>
>>>>
>>>> On 31/01/2023 11:49, Suzuki K Poulose wrote:
>>>>> Hi Arnaldo
>>>>>
>>>>> On 24/01/2023 11:36, Suzuki K Poulose wrote:
>>>>>> Hi Arnaldo
>>>>>>
>>>>>> Gentle ping.
>>>>>>
>>>>>> On 19/01/2023 12:00, Suzuki K Poulose wrote:
>>>>>>> Hi Arnaldo,
>>>>>>>
>>>>>>> On 16/01/2023 12:49, Mike Leach wrote:
>>>>>>>> The current method for allocating trace source ID
>>>>>>>> values to sources is
>>>>>>>> to use a fixed algorithm for CPU based sources of
>>>>>>>> (cpu_num * 2 + 0x10).
>>>>>>>> The STM is allocated ID 0x1.
>>>>>>>>
>>>>>>>> This fixed algorithm is used in both the CoreSight
>>>>>>>> driver code, and by
>>>>>>>> perf when writing the trace metadata in the AUXTRACE_INFO record.
>>>>>>>>
>>>>>>>> The method needs replacing as currently:-
>>>>>>>> 1. It is inefficient in using available IDs.
>>>>>>>> 2. Does not scale to larger systems with many cores and the algorithm
>>>>>>>> has no limits so will generate invalid trace IDs for cpu number > 44.
>>>>>>>>
>>>>>>>> Additionally requirements to allocate additional system IDs on some
>>>>>>>> systems have been seen.
>>>>>>>>
>>>>>>>> This patch set  introduces an API that allows the
>>>>>>>> allocation of trace IDs
>>>>>>>> in a dynamic manner.
>>>>>>>>
>>>>>>>> Architecturally reserved IDs are never allocated, and the system is
>>>>>>>> limited to allocating only valid IDs.
>>>>>>>>
>>>>>>>> Each of the current trace sources ETM3.x, ETM4.x and
>>>>>>>> STM is updated to use
>>>>>>>> the new API.
>>>>>>>>
>>>>>>>> For the ETMx.x devices IDs are allocated on certain events
>>>>>>>> a) When using sysfs, an ID will be allocated on
>>>>>>>> hardware enable, or a read of
>>>>>>>> sysfs TRCTRACEID register and freed when the sysfs reset is written.
>>>>>>>>
>>>>>>>> b) When using perf, ID is allocated on during setup
>>>>>>>> AUX event, and freed on
>>>>>>>> event free. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
>>>>>>>> The ID allocator is notified when perf sessions start and stop
>>>>>>>> so CPU based IDs are kept constant throughout any perf session.
>>>>>>>>
>>>>>>>>
>>>>>>>> Note: This patchset breaks some backward
>>>>>>>> compatibility for perf record and
>>>>>>>> perf report.
>>>>>>>>
>>>>>>>> The version of the AUXTRACE_INFO has been updated to
>>>>>>>> reflect the fact that
>>>>>>>> the trace source IDs are generated differently. This will
>>>>>>>> mean older versions of perf report cannot decode the newer file.
>>>>>>>>
>>>>>>>> Appies to coresight/next
>>>>>>>>
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>>> Mike Leach (15):
>>>>>>>>     coresight: trace-id: Add API to dynamically assign Trace ID values
>>>>>>>>     coresight: Remove obsolete Trace ID unniqueness checks
>>>>>>>>     coresight: perf: traceid: Add perf ID allocation and notifiers
>>>>>>>>     coresight: stm: Update STM driver to use Trace ID API
>>>>>>>>     coresight: etm4x: Update ETM4 driver to use Trace ID API
>>>>>>>>     coresight: etm3x: Update ETM3 driver to use Trace ID API
>>>>>>>>     coresight: etmX.X: stm: Remove trace_id() callback
>>>>>>>>     coresight: trace id: Remove legacy get trace ID function.
>>>>>>>>     perf: cs-etm: Move mapping of Trace ID and cpu
>>>>>>>> into helper function
>>>>>>>>     perf: cs-etm: Update record event to use new Trace ID protocol
>>>>>>>>     kernel: events: Export perf_report_aux_output_id()
>>>>>>>>     perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
>>>>>>>>     coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
>>>>>>>>     coresight: trace-id: Add debug & test macros to
>>>>>>>> Trace ID allocation
>>>>>>>>     coresight: etm3x: docs: Alter sysfs documentation
>>>>>>>> for trace id updates
>>>>>>>
>>>>>>> I have pushed the kernel patches on this series to
>>>>>>> coresight tree next[0].
>>>>>>>
>>>>>>> I will be sending them out to Greg for v6.3. Please
>>>>>>> could you queue the
>>>>>>> perf tool changes in the series ? i.e., Patches 9,10 and 12.
>>>>>>>
>>>>>>>
>>>>>>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?h=next
>>>>>>>
>>>>>>
>>>>>> Please could you pick up the perf tool changes above ?
>>>>>
>>>>> Please could you confirm if you are able to queue the perf tool
>>>>> changes ? Or would you like me route it via coresight tree ?
>>>>>
>>>>> Kind regards
>>>>> Suzuki
>>>>>
>>>>
>>>>
>>>> Suzuki
>>>>
>>>
>>
>> Thanks,
>> Ganapat
>>
>

Thanks,
Ganapat


