Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66196CD115
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjC2EPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjC2EPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:15:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2131.outbound.protection.outlook.com [40.107.220.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4619D;
        Tue, 28 Mar 2023 21:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/toRv11gpE+gZlKWNio3Nx8lSAt2D9vgh55j09wx2bnlCEh1AAdu0y37KCnF6DmlcfvDEV0ULNGSSau1ps5jPkQezHuK77zi0sw3x4tPxPmp0m1VgCs7fsbPPwR+IF4cq0K4e1jJppnCLzbFuxaXLtSCIewOFNu+ZL77igG17wMtcRzvCMqEMp0KSwxvvppilfJwvXFCAmZR9b7hE7oFIb2niJVRKxHLLqf3ShMvMAfiwr54KzkXQ1bJmqoAQdq6PgyIIgTabzAO3kBkkNPGhShg4oLjbJBOqaNzfW8qw8d60/A/PYXZ6I4vghBmcUXeNoWjoq/VTypyUz4uRNeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyI0i45asMf1yJmUi8YH9Me4vCMBXAo7kfLVlvgBe88=;
 b=S0sBpz4S9Fyjngk40QG66WTB5nsivpNOZkhgagXRRG9k5GBUrXCeTvWlXqwgvzMjkEGvTpIPH4zJIp06mfOkUBBRgzMdCrNTBLdOllQObe724GNweJC+7uIlJMjzSp/wKqR9AFtMCoHmqkmPymcg1o2I485a7fbuGCjqQ1+tOu2pXaBhLKVeFRpLNPk8b9W6khWcz9HumVN1mHmXTPmui3W2xqgJDdroMc1IchuD2FA6N/9/S3Pc7XvCymBS/bTlTlCDzFVeU9RV+scSPRVUgrFru5uPmpY7X7SpSYt/yaleN7xBOTlSQODJUSaCUUnk1fAcEPaKZq6etncOMlvWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyI0i45asMf1yJmUi8YH9Me4vCMBXAo7kfLVlvgBe88=;
 b=r1KwXRGAk+VbNvgi6UeJ9EfftaG6JCc7mRfcZ9fUkLh8BLeCUH3GB5p58fI4xeCjo1y3v8Izh5pHBeZcDOkSR5LM0cPb+qQYwrcwn7OesIjaoES+JN9wIvsraW1jUriu1YfZKQjI3/hC61QCMwiKpNgOWvMy25M5gHkaM3m6mRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BYAPR01MB5349.prod.exchangelabs.com (2603:10b6:a03:11c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20; Wed, 29 Mar 2023 04:14:56 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6e60:1252:2c84:191c]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6e60:1252:2c84:191c%2]) with mapi id 15.20.6254.018; Wed, 29 Mar 2023
 04:14:56 +0000
Message-ID: <5556dc65-79ef-e8d2-e5b4-046594af78ea@os.amperecomputing.com>
Date:   Wed, 29 Mar 2023 09:44:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: v4: Re: [PATCH v7 00/15] coresight: Add new API to allocate trace
 source ID values
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>
References: <20230116124928.5440-1-mike.leach@linaro.org>
 <546f218f-3ac9-8fc2-c843-2f2f16882f31@arm.com>
 <5b7df6df-0c2d-6953-0f50-e85745cb1f4b@arm.com>
 <2864f28e-dd2f-5a9c-922f-5c044a864beb@arm.com>
 <e3df35fe-a00d-69ec-32ee-53c949909cab@arm.com>
 <6a71acac-c478-6e5d-3165-4ba9526614db@arm.com>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <6a71acac-c478-6e5d-3165-4ba9526614db@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:59::30) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BYAPR01MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f0bc45-ca02-42a8-2a97-08db300c273e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUGN+4lliefKB9ZOdlj45LutrxvOvIkEG4ET5NKUCuTqn7qiNsstKx6A38Y07G41D6aLCZVrvCS2O2YA7ZRejuHr//PaZ1+OJ1dRZkldNQbtYkqUzWFzlruQVdzfuKqZMNx+/ZCgNMLI2QIijlsvSvsy02kqiviQeSEfGTjTu/+mU7SP+gfCKzfFF6ZtkXUW6qP2jOwlWak9jtysnOee5CotqrpP0KI7aJCZ7dw66+wZZDieUQCMSlMqOS3YXworMlQ5ES0C1dUac7ljoIk7+/1qzxIX4RWNO581SEkln1LMadU0WkLiE+2JQS/lWSWjMzvko2gtdVXRSILhR/156Iv3d9+Sf9aMnjpL0/SmyLDfOoiJNs7WvGh10vEeJOOGkkPtPhNCzU9DrO5fGP2OEjPmXuzlRIK8mWcAybdxyW02hTex1t+Ab80P1RGMFi/mrq72DpAnytEsrFjQXhYqTKZLBBwEPkFxAcFTDc4ADbWeC/T9v8iKWUImYUoofuUDTvz9Fj3EQA9+t8bTjTMMadZSSFALao0FVWN8W4D8RmTOnZkOrWi+8XUMxAUX50pIv8Ca1xw2hY4PZXcLKNQ2/oPHr445LIYVajssB4OJAz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(376002)(346002)(366004)(396003)(451199021)(31686004)(83380400001)(53546011)(6666004)(6512007)(86362001)(6506007)(478600001)(110136005)(316002)(2906002)(26005)(186003)(6486002)(966005)(2616005)(31696002)(38100700002)(41300700001)(66556008)(66476007)(66946007)(8936002)(4326008)(5660300002)(8676002)(7416002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUZscjRJYzViNzlYT2x3YUxzNHdVWDBWQjgwcEIzNkE4TFZTZG0wakxXY2dJ?=
 =?utf-8?B?aUZYbjJ5VWg5UGlzZ2ViU0s4V1dhcmJrdkNNNmI4VzRwRVhQcUVheEpwc0V2?=
 =?utf-8?B?L0NteE9lZmNzWGNKZTRPaHE0TVBCWFYwVk9QZGUxMlZkSVZKa0hQQ3FlY1pB?=
 =?utf-8?B?bkRzTlViZGxESHhIQWY5NkdQWitaZGNCQUpKME4wdzc3QWJlVGJzTm95eUJK?=
 =?utf-8?B?dEZvZmdiN3lhemc4akxDSWIzU1U3L3lVK2lVVWFkM1pBelNGaWp1b1RndEIz?=
 =?utf-8?B?bnZ2NVZiVkd2ZkdvSysvMFpSQTNqeklxUEVyaGpOTlRXMXJETEg0UW4reDFF?=
 =?utf-8?B?SlJ2eXBrSHlxRUR2aVord0FDUE1HcGgzZ1IrZlRkMXFqcjdYd0s2bDExM0hJ?=
 =?utf-8?B?d2NLcDJBVklCemYxN3pZN1lDSWM4VGhSYVlvKy82SVNQZXhDQlZaNmFZVGV2?=
 =?utf-8?B?L1BDYmlqUWJoekYzR0MwbU1CZXFXSGJsMEVPdEVJcG5Qeno4bGs3bVVYWCtU?=
 =?utf-8?B?ZUVTcmRqWmRzUS9JT1QxVlo5THhUZno0REx5bkRVSG9mS3RDL1liaEF5TU1k?=
 =?utf-8?B?bFFtaU9uT2IrNW52Z2FXbmgzL1F1b3JLTHI3MEtYV1JkMjIxbDlmb1VURmUw?=
 =?utf-8?B?Rldqbjc4eCt2SVNaTDlnNGM2WjJJZGtsS3hHZXBmdVZZSjVXbnJpamNFRjli?=
 =?utf-8?B?dEhaUTFsbC9qRlpRMHBEQUR4dkQrWGpxR3loc1ZLNncvOGpqWms4K2lkV0lW?=
 =?utf-8?B?c3pacVNmU1ZBaTArZnpRckl1S3lIbFl3UEp2WXc5d2V3bVBQMEpyUVAwd2Uy?=
 =?utf-8?B?OS9KOEZ2MXptOHlmSVZkYVdjTkJvZjh1TlNvbm5hY1RoS2gwODhJSXJMQStt?=
 =?utf-8?B?UUhWTmlrQlFrVEtFV1JzNHU2TmlYcXpwY0tMdlNDeUQ5S0VlOGZ4aEJiUzVF?=
 =?utf-8?B?WmJpM0xucWtnYkVydHQrVGJBZjE2UVVpemhhczZ0WUt3ZDZyU2lBaXY3MFBN?=
 =?utf-8?B?cHhjU0xlV3dDdTQ3b3VsMmxuNk1xZzVwRGVuWUxvY1BkanBtdXhxVGpmL2FF?=
 =?utf-8?B?QzVyMHpyQVk4ZFJURmVvVXJQR0JmVFV0WDlCcG5pYnY3ZTc3SGo1TWV1MUM0?=
 =?utf-8?B?RnNlb1BuVndndTBacDJnemFvcTZiM21VN09Xd3hvTkQyU3ZBNEZRY0wwaTVP?=
 =?utf-8?B?eitwRUdvM2ZxemdCQjdQZW1sUzY0Vk1aQ01wNW01b3loRG1OTUFpS1ljc21X?=
 =?utf-8?B?eTgwSm1RWit1ZkE1R3ZsbVZMSmRZTlRYSERZVnkyUi9ZM3doTUxsWXdBWjhy?=
 =?utf-8?B?SVJBS0Rpc3pkc3RWdk1UT2xMUEpyZ0R1L2oxYk5BUUR1dkxDTGJ6NjlvenJX?=
 =?utf-8?B?QmdNb1RnQU9rU1JlY0xoc0RnVFZvOWhGSlRGZXFvR0FBRk0vaWQwR1Z4alBy?=
 =?utf-8?B?TWpwMW54aVlsK3RiZE1VM2U2b3MwYWZ2OTZjRk5vMExZelBxZnVwSU1ZTjJ2?=
 =?utf-8?B?Uk5CQnhVUVBiU0FPSFRIbzM3K2haVldzOG10MmxETzJsMlVOSUNVQjYyeHky?=
 =?utf-8?B?NllEK0IyTVlyK2tOYkZRUmxKTXM0ZFdUQTZmbllPbWhzeWFYYndhRTkrM3lp?=
 =?utf-8?B?bFdNYWk4OHg5M1ZpY2FxbndxM0paWmczY2tXRm0ySDkycTMrL1FhNERXdEth?=
 =?utf-8?B?d2RUMDNwV1BqUXBPKzNWTkhrcWsweVpmK3A1UFdlRVIxL0lkb1dEYXhIWTNy?=
 =?utf-8?B?RWpZNXdkU1l2blBZTFhPZUp4dXlyMlphMVlaNEt0K1BlZnljWis1TTdxdGVU?=
 =?utf-8?B?UEdiaGZvdVY3QlM3YVdXOVZjSlRKaldnVC9zWkduWWFRVmJ5ejBhYlM0bWhU?=
 =?utf-8?B?amdVaUNCM2xUMEdCU3FTNytZdFhla0NOc1pQYUNCdXNBQnkyaFV4MjkzTkpy?=
 =?utf-8?B?YnBvdTkxUVhyWHowVnRtVUJ5NTFBNmNHZ3ZmcDVobkxQZ01tQ0Z3U29JREJj?=
 =?utf-8?B?UTljQnZyN3JFMmltTkZ1am8rTWFLbytFbEk1YjF2endHeXpBc2prOUgvR291?=
 =?utf-8?B?REZsZDEvaVdha1ZybDdSSFEyU3dRUnNhaHZrcE4xTS9DcUtzbS8zQlF1Nldn?=
 =?utf-8?B?UnYzZGxFa1MvMEl6clpMWHByNTJrTlBnQi90cHFpOXliZW9IS3REbHdrMitS?=
 =?utf-8?Q?YziHfNEJGWMsPqhOldigTBc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f0bc45-ca02-42a8-2a97-08db300c273e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 04:14:56.0750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IA9pTRN1PIAzUsFv11/1qXen0rr1HXGwZwuI/aNvHI6kT+o+uVPE4TQLiAqU2NoZwhXDIDrhbZFCDk3mei473UZ288hAUzZhUfZDXrtFV1GbRlUrWfcooNyv9wa/pv9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5349
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 27-02-2023 03:56 pm, Suzuki K Poulose wrote:
> Mike,
> 
> Please could you send all the perf tool related patches as a seperate
> series, with all the tags to Arnaldo directly at -rc1.
> 
> Please add a cover letter explaining that the kernel changes are
> available upstream.

Looks like, Perf tool patches corresponding to dynamic trace id are not 
yet merged in to perf-tools-next.

Without these patches, the mainline perf tool breaks for the coresight 
for higher cores.

> 
> Kind regards
> Suzuki
> 
> On 20/02/2023 16:24, Suzuki K Poulose wrote:
>> Arnaldo
>>
>> Gentle ping
>>
>>
>> On 31/01/2023 11:49, Suzuki K Poulose wrote:
>>> Hi Arnaldo
>>>
>>> On 24/01/2023 11:36, Suzuki K Poulose wrote:
>>>> Hi Arnaldo
>>>>
>>>> Gentle ping.
>>>>
>>>> On 19/01/2023 12:00, Suzuki K Poulose wrote:
>>>>> Hi Arnaldo,
>>>>>
>>>>> On 16/01/2023 12:49, Mike Leach wrote:
>>>>>> The current method for allocating trace source ID values to 
>>>>>> sources is
>>>>>> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 
>>>>>> 0x10).
>>>>>> The STM is allocated ID 0x1.
>>>>>>
>>>>>> This fixed algorithm is used in both the CoreSight driver code, 
>>>>>> and by
>>>>>> perf when writing the trace metadata in the AUXTRACE_INFO record.
>>>>>>
>>>>>> The method needs replacing as currently:-
>>>>>> 1. It is inefficient in using available IDs.
>>>>>> 2. Does not scale to larger systems with many cores and the algorithm
>>>>>> has no limits so will generate invalid trace IDs for cpu number > 44.
>>>>>>
>>>>>> Additionally requirements to allocate additional system IDs on some
>>>>>> systems have been seen.
>>>>>>
>>>>>> This patch set  introduces an API that allows the allocation of 
>>>>>> trace IDs
>>>>>> in a dynamic manner.
>>>>>>
>>>>>> Architecturally reserved IDs are never allocated, and the system is
>>>>>> limited to allocating only valid IDs.
>>>>>>
>>>>>> Each of the current trace sources ETM3.x, ETM4.x and STM is 
>>>>>> updated to use
>>>>>> the new API.
>>>>>>
>>>>>> For the ETMx.x devices IDs are allocated on certain events
>>>>>> a) When using sysfs, an ID will be allocated on hardware enable, 
>>>>>> or a read of
>>>>>> sysfs TRCTRACEID register and freed when the sysfs reset is written.
>>>>>>
>>>>>> b) When using perf, ID is allocated on during setup AUX event, and 
>>>>>> freed on
>>>>>> event free. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
>>>>>> The ID allocator is notified when perf sessions start and stop
>>>>>> so CPU based IDs are kept constant throughout any perf session.
>>>>>>
>>>>>>
>>>>>> Note: This patchset breaks some backward compatibility for perf 
>>>>>> record and
>>>>>> perf report.
>>>>>>
>>>>>> The version of the AUXTRACE_INFO has been updated to reflect the 
>>>>>> fact that
>>>>>> the trace source IDs are generated differently. This will
>>>>>> mean older versions of perf report cannot decode the newer file.
>>>>>>
>>>>>> Appies to coresight/next
>>>>>>
>>>>
>>>> ...
>>>>
>>>>>> Mike Leach (15):
>>>>>>    coresight: trace-id: Add API to dynamically assign Trace ID values
>>>>>>    coresight: Remove obsolete Trace ID unniqueness checks
>>>>>>    coresight: perf: traceid: Add perf ID allocation and notifiers
>>>>>>    coresight: stm: Update STM driver to use Trace ID API
>>>>>>    coresight: etm4x: Update ETM4 driver to use Trace ID API
>>>>>>    coresight: etm3x: Update ETM3 driver to use Trace ID API
>>>>>>    coresight: etmX.X: stm: Remove trace_id() callback
>>>>>>    coresight: trace id: Remove legacy get trace ID function.
>>>>>>    perf: cs-etm: Move mapping of Trace ID and cpu into helper 
>>>>>> function
>>>>>>    perf: cs-etm: Update record event to use new Trace ID protocol
>>>>>>    kernel: events: Export perf_report_aux_output_id()
>>>>>>    perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
>>>>>>    coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
>>>>>>    coresight: trace-id: Add debug & test macros to Trace ID 
>>>>>> allocation
>>>>>>    coresight: etm3x: docs: Alter sysfs documentation for trace id 
>>>>>> updates
>>>>>
>>>>> I have pushed the kernel patches on this series to coresight tree 
>>>>> next[0].
>>>>>
>>>>> I will be sending them out to Greg for v6.3. Please could you queue 
>>>>> the
>>>>> perf tool changes in the series ? i.e., Patches 9,10 and 12.
>>>>>
>>>>>
>>>>> [0] 
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?h=next
>>>>>
>>>>
>>>> Please could you pick up the perf tool changes above ?
>>>
>>> Please could you confirm if you are able to queue the perf tool 
>>> changes ? Or would you like me route it via coresight tree ?
>>>
>>> Kind regards
>>> Suzuki
>>>
>>
>>
>> Suzuki
>>
> 

Thanks,
Ganapat

