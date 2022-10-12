Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386565FBFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 06:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJLEGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 00:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJLEGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 00:06:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0568A1F3;
        Tue, 11 Oct 2022 21:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogiURVz+ChxfHQqH7f+mk2uZ9r2l/O1B6enuPoNcygQcLy9QwUpk1I8QUwm2H1b66zW/i+RlkHcfS5/eaXLwfGuZAXWNjbsedfSFDwC1CtF5N8knw4JbeYAQmLe7hwXhdtq6pbjRW7PiT7J9+CRxNciLemMvJPkvl/quJNPn06YcIKeVXIQZWZm1WVZoShL3kW4H0qBMGn9XYQNhXHwsW9AJ5eWBvJalAKa69BLKpj4R1+swJPwgofEN8J1V0SUcWV475IoyUlDFUWulfw3AcLBhk5OofSVMNbPHNNmbEiDbLaXrUYI1bJLM10iCpC5GqzGxUWRtSry/f4gJT3tH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rsjPRuOLvT1ZU13ZT2aLk8v3whe0EfWPTJbt8eKhVQ=;
 b=KBAvGlgudb3ZeBPFSZgbXJIJYizT/+R76/2cTx7oCQPU2dllmfhLtayUmfjmXvryaDeiB3s9OcvB+5ZEjU6ADyRnv2v7qzUBICWq3pASBDQOfhaUPk9u4Z4q9A1nZn7GO7PCaF//3TrZFanHAT3urUIveirmB3AYSodRed/WhMjfXP3wQ95W47PtXOhzBv8WdM4jMbICNJiDQ5cEGk2mA5PVe3NDwztYs2kbBrBnPIMhJpxJn1QTk8o6LcvCUP+siXVKCx5D/gZwhGWI9QuhGkUIh5OcNp6wav76W1OBY13ds+Grp+wwWFBzrJHlea/0GiwM2j37S+9nEmT4WGfncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rsjPRuOLvT1ZU13ZT2aLk8v3whe0EfWPTJbt8eKhVQ=;
 b=q7EP27KlEHCFlWtw6Py/QdQnErRXqP/z4qV8JF7/TqR5qLPjHG/+GDaR9ntKV5zheeNcqj42cSj3fdYAHej7vxjYflPBy7dxQ7eiI2XeoKGdGBvmeRHRbxg4GhIaeRkXRm6dtLQwLaarL2fVEqGBgYmq4mAS6e3YysDPYq2gvdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) by
 IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:441::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:06:36 +0000
Received: from DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::2cb0:a266:14b4:cc08]) by DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::2cb0:a266:14b4:cc08%5]) with mapi id 15.20.5676.030; Wed, 12 Oct 2022
 04:06:35 +0000
Message-ID: <85aabdc8-07cd-3285-1f3f-605f9ebbab18@amd.com>
Date:   Wed, 12 Oct 2022 09:36:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Slade Watkins <srw@sladewatkins.net>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Kees Cook <keescook@chromium.org>, sandipan.das@amd.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net>
 <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
 <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com>
 <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com>
 <CAKwvOdk6TTNhu_+FdONTXPo9Z8u5D4-5kf-rMN8oK4+6fMyc-w@mail.gmail.com>
 <CABPqkBQVfQFJKCdHXEMGFcupzvy8zq14F52eLW5s9vr2Shmi6w@mail.gmail.com>
 <85822c3c-2254-52cc-e6b1-9c89adb63771@amd.com>
 <CAKwvOdkfEexsE07XXGW3FF+nMt-pR8uv2EA7QzsPbEZsSQBO-Q@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAKwvOdkfEexsE07XXGW3FF+nMt-pR8uv2EA7QzsPbEZsSQBO-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To DS0PR12MB6584.namprd12.prod.outlook.com
 (2603:10b6:8:d0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6584:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 9927839e-3ec8-4432-040c-08daac07277d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SiqJ6DxoOhdClpoZ1DzjWFFtOxMZJc6SkhS1y9G/d72bu8ZJYNsCTqQUUiwfcMfxxaokVScyINVysLuGuvE7BzrE5h25Vh6EQu/QB02I68Onr3dRHAa0xBBQOT0LihX6MCd5jk12dUUduNelwxf7saNdS9EoIDS9GLIQeer7RNw2e/CdKZgxT6TJ1HJvefDcyadaELhTil1MekC6J4oMYrB3/3qMxymowL6DqZwxeINhljs9VcBeMC2TqGDKoY1s6bs8I7iCdu3vYs4CY0nG+7QPe/+ozyQarQTBN8ITuGZVJhstfD9uJiJUjqjoHF1I+H+ekzLgCzSxR5LpDKes72bJm4AbZlNJ3Aq3kHFxGFDFvEuKznsIE/1mYoY8lH3W55b89vRmV45uDHYRHCGMbI/QOrYEntPaK5fYXM5eWqtM2OomGQePBoF61wRga/Ku5ipnvGMEdHHePayyXKchyIvBEMSc4GgB6z0x9JirfTdUQ/dBEHdXG64tJQInTQx4s2C2GvS7U0cwVpz2TvWZCGHw59XVkc/uNm85a/X2pJ+Wf8WeXCCGOdb7BRcIB+AC8RNL9cqAZbABNksxwoQK5ZptpyMf7qMnIvaPjWtHtBFDnNmJNYzm7OoxSv9iM78QJNxG5Qt56ldev6ifBJy9CLP6ReOfTxmtgdJ+6PxRFXrhaEq29JjDUZ+k7naEL6EoTgFrKdia49wuOQK7Xkhj0Uj6N0g26qV0TIXfmY+IwkZ+Pgsu0gEpPDmH2JKrjkbKTLGaTV/w93iGyowOy+GL5Wh4xxo+H8zhc6+0H9dsIIBVvwimSo13KeuI0cnBAC1PxLwbwOePcIn4/8VATGS0mM3R6jjftY7JmU0P6rAAWH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6584.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(6512007)(26005)(31686004)(186003)(316002)(31696002)(38100700002)(966005)(6486002)(54906003)(36756003)(478600001)(6916009)(86362001)(8676002)(6666004)(55236004)(2616005)(6506007)(53546011)(83380400001)(5660300002)(7416002)(4326008)(44832011)(8936002)(66556008)(66946007)(66476007)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2g4RGUxRzJWd25xOVdxM0huZjVVcjNCZ29nWGtsZmp1YXhnb1VscTdGQUx5?=
 =?utf-8?B?TFRmdzF5Y2QwR0FrRVRYUmdpYmFkL1B3aFlZbTRTclJMelE2ODNqalJzSGFE?=
 =?utf-8?B?LzVHc2tvTDZMUW1TRkVUSUhQa3BIUzBuaytsM09vWjBoUWJ5NFQvZmxRR0hP?=
 =?utf-8?B?ckNFWEdQRGxRT25NNytBVkRBNUUrdGhrdGVtUXdHZ2hkRHgwbHNDZHhRSE9n?=
 =?utf-8?B?VFQwa3pLbTkxNklGaXRyQmdDc0tKdmlkZ3phS243Q1lGWEZBd3ZMQWxVUk9C?=
 =?utf-8?B?eStFNTVscS9pWEtsVWNMcUd4TW1NbEtlcXhORncyZW9oNlZLaFJ0eEUvbUdj?=
 =?utf-8?B?d01WL0E5SXpMU284WGhnV0RxZzlFSmlRV3pmMElZN2xLcWJ5WThLQjQ4dEJ5?=
 =?utf-8?B?V2JXa1l4cGdXMThyYm9GMjE2VHV0S3grN0VnQXZ5Tkg2bmpMYVNhNE50MFh4?=
 =?utf-8?B?N05RK2pQa2oyV0VFT1pCdVB1QThndG9VTTJOUHdLMlduR1Z5TWFxb3RueVNP?=
 =?utf-8?B?RkNQVUtqZXRWd1E5N2hPMzFrWGlNWmVkT1VNcWZ2UnNRcUFXamN2bGE2VzdU?=
 =?utf-8?B?alBtZmlTMTA2aU1XZVRGdDN6RVJKUzlvN3dJT2pJUThrRUovdWlhaXA5bnhD?=
 =?utf-8?B?bUFSbzRMZ2FtY0pOMVhhOW12SmNIRkZqOHB3Z0g2Vk05ckt3MFBOc0V0anBu?=
 =?utf-8?B?TGxzRFFZcitiM0JsamdrNlhoWThldlptcW5rM29wbTRRTEhDZTVncDVvK1Mr?=
 =?utf-8?B?WmRYYnMzd2JKQ05NVTBXbWY0VnRhZm9GRVlLWnNUS0hzYVZFdVd2UXp2VlNF?=
 =?utf-8?B?akxGRHZ0ZDBaTkREeWRubWpCNWVLbXkwVTRydkxVMW9GSDJhaGFWdk9HeWo1?=
 =?utf-8?B?dm1zNWppN3dJODVlT3VnazlmZXRzRFkxNXJvNGdRblpsUkxvTDIxcUJBcFhx?=
 =?utf-8?B?aXpWZmF2VS94dzN4dFBvbDk4Tms4bjBQanJUYmNBa05BcWR3NFZoWjB4NGNr?=
 =?utf-8?B?QUQ3S2pWWWw2Wm0wanJUZVhoOWFzaUoxYXdKdE50WTZmd0FZdXpOV0tKOXE5?=
 =?utf-8?B?U2VnSVZFMXlCOTd4aStPQXluRmVvOW9RQTYwSDJQanNhMnJoOXgxS1ZUbFVV?=
 =?utf-8?B?cE9MNGI3UnVyOUgwaWk5U2Mwcmg5amhwd3BocEhLMEVQVmZDT0U2WHNiOWMy?=
 =?utf-8?B?R2lJbTREZUZEbDN4UEhVcE42UUd1VzJ5ZmhtdEdGU1J2L0hadHFOeXFrdytw?=
 =?utf-8?B?T0xRaUpSK2xRNjExTHFpN3JTWVpmYzRRZktvSS80dTBnQ213NkxpZkZpR2pr?=
 =?utf-8?B?MXY0c0IycGZKdm9kYW5sUXpINUM5bE42RFFnVFdjZVA0N0VpZnhWYWwzT2xt?=
 =?utf-8?B?L1pRNlEwWUJkbG1VT3NYNFJka0p1YXBKZ1Q1RmdqZUhKZ09YQk4yZlUwQTJv?=
 =?utf-8?B?SjVnc2crNG5yU1pLejNsN2N3RldsOFlNL3RZeHRSMEZDK0tZRlR6MC9vVUFl?=
 =?utf-8?B?RDdGamtGVzV1SjdhN1hvS3hIczVqYjdrczFNajBoVFNoT2dRNm95ZnRzazgv?=
 =?utf-8?B?bWNvQjdDVUdlYXd0cGZ3bm1RUElWcVN3YkZ6YUw3VHQwb3dEWDNRTVk5VXR4?=
 =?utf-8?B?cnd3aHFUVVFLK2FYRVFkQmh6MS9UQVhYV1l3L3M3VVluSEViaTJVMjZQOCt5?=
 =?utf-8?B?ZWVaU3B3dTRLSncyS3FycGNLc1ZHeGNJUTkxM0ljb1NpYUxnMng0ZTRyd1dE?=
 =?utf-8?B?UzVjZzNwOEFSYmpuYjdJalJZeWVpL0Y3QjM3ajNROENsK0ZNRUxMM2NTVEdB?=
 =?utf-8?B?dWNqRnVESFdiV2VaaCthZ1ZYVUl1TFdjTDI5aHNHTEozd2tNZTZOc3pWdDZC?=
 =?utf-8?B?Qm1kUHRacmJBWTV0clRHNFN1N3BTTUFBMTdWb1JnNW1ja2l4Wm1HZVVMMFVi?=
 =?utf-8?B?QzlmZ01pQXdielI5amJ4eGUwQnRpdGREbU1GMURFUVI5SGhkVHQvNmdKMmM1?=
 =?utf-8?B?U1JILzJZZVo5YU9BNGtOaGpSTkcyRmpoV0tIaE4xc2JRMEtrYU9oT2RWSS80?=
 =?utf-8?B?b2tWNzE5ZGxiVitLanp6QjhSMDZkaFRUMG91V1B0VkhONGw1Y3huOVRLV2Yr?=
 =?utf-8?Q?KG6GqcGmzP7z5/YHnN2+UCkPf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9927839e-3ec8-4432-040c-08daac07277d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6584.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:06:35.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5GtXg10j48z76nhxyTdolACeY5/CUBlQLmJSzucECuALGgcZH2Ybtb0pq3zuCj/2SXnZRPMDFmATPIimcrt2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-Oct-22 3:02 AM, Nick Desaulniers wrote:
> On Thu, Oct 6, 2022 at 8:56 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> +cc: PeterZ
>>
>>>>>>> +Ravi who may be able to say if there are any issues with the precise
>>>>>>> sampling on AMD.
>>>>>>
>>>>>> Afaik cvcles:pp will use IBS but it doesn't support per-task profiling
>>>>>> since it has no task context.  Ravi is working on it..
>>>>>
>>>>> Right.
>>>>> https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com
>>>>
>>>> Cool, thanks for working on this Ravi.
>>>>
>>>> I'm not sure yet whether I may replace the kernel on my corporate
>>>> provided workstation, so I'm not sure yet I can help test that patch.
>>>>
>>>> Can you confirm that
>>>> $ perf record -e cycles:pp --freq=128 --call-graph lbr -- <command to profile>
>>>>
>>>> works with just that patch applied? Or is there more work required?
>>>> What is the status of that patch?
>>>>
>>>> For context, we had difficulty upstreaming support for instrumentation
>>>> based profile guided optimizations in the Linux kernel.
>>>> https://lore.kernel.org/lkml/CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com/
>>>> We'd like to be able to use either instrumentation or sampling to
>>>> optimize our builds.  The major barrier to sample based approaches are
>>>> architecture / micro architecture issues with sample based profile
>>>> data collection, and bitrot of data processing utilities.
>>>> https://github.com/google/autofdo/issues/144
>>>
>>> On existing AMD Zen2, Zen3 the following cmdline:
>>> $ perf record -e cycles:pp --freq=128 --call-graph lbr -- <command to profile>
>>>
>>> does not work. I see two reasons:
>>>
>>> 1. cycles:pp is likely converted into IBS op in cycle mode.
>>>     Current kernels do not support IBS in per-thread mode.
>>>     This is purely a kernel limitation
>>
>> Right, it's purely a kernel limitation. And below simple patch on top
>> of event-context rewrite patch[1] should be sufficient to make cycles:pp
>> working in per-process mode on AMD Zen.
>>
>> ---
>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index c251bc44c088..de01b5d27e40 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -665,7 +665,7 @@ static struct perf_ibs perf_ibs_fetch = {
>>
>>  static struct perf_ibs perf_ibs_op = {
>>         .pmu = {
>> -               .task_ctx_nr    = perf_invalid_context,
>> +               .task_ctx_nr    = perf_hw_context,
>>
>>                 .event_init     = perf_ibs_init,
>>                 .add            = perf_ibs_add,
>> ---
>>
>> [1]: https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com
> 
> Hi Ravi,
> I didn't see the above diff in
> https://lore.kernel.org/lkml/20221008062424.313-1-ravi.bangoria@amd.com/
> Was there another distinct patch you were going to send for the above?

Yes Nick. I was planning to send it once the rewrite stuff goes in.

Thanks,
Ravi
