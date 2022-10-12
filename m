Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4555FC00D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJLFFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJLFFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:05:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E49121E37;
        Tue, 11 Oct 2022 22:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAdgJZ53dWl7ExQn+GvGKFgTcdilxB7Aepg7OoPLBEA4ofk4XPTzcvexQ+vid5YCCDvReKDjeUazXgy8t9oKFnmNUoqKVUP5uIUbKPhV9FdzSfOs5ln4D3xw5DEVPXUGcwQ6ywhW2EAfU45D4DN3N1QbmSrn5kjFKD3NfM90ajzVrKGmjxqWeUzTuQiiQEDduICsdfZrL6PChxo+cMHbqOt81JmZdRJxL8W7VWXGbX47NlFYT5ixbX0lqxruM+VcqynPptV6Q0CKtYsOh8iyrxjzcTfCaozWDgMMCVBpz8T6fhl4yXYQT8+8VdvNrxgzxV2X4Hw4tzh1KaowhnZ/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHQ+sjLGQ66c0EgrQ3r6Gbr3ZGFqlmAcG4LolrVgjsQ=;
 b=oB+fJ9LVrMKx5SKNQ90C2U0Q98iIW1Fwjh0hfaDy+kTEGykjAyplDL1+x6o3RK0cZy7pwSz7vUNezPQY80l+KrxUxNVqW2xKE0BU4X3GvuThnnD6ffZEjnyu2NfqkWzzOY0Ki50V4zDQ1CuDrgMigkYs6BKa1noxnWY15VlX7MYAixtSRnuqO/uNHeif0Co3aThEH2+R8NhNvaqs4VeIerME08iNF8r3NaiOxeYamNLnitS+ZvUFid6/Q7wWNWE9uHG5uLb1R82elIZzkqxA3CNGsWskwjruju9gX+jBuHUhs6+apEN5/3jhPuiel85+AeEtMfDAFZEE1jJaZErKow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHQ+sjLGQ66c0EgrQ3r6Gbr3ZGFqlmAcG4LolrVgjsQ=;
 b=dQU8TzC0kBa+bGRd3+nG9mjtpuKW9cBi9VwgG8Bi1JWJdeh6aivnt6XkntgdirtoWMG3y9wx2o8buQjuZk/Aua0SwdRSkpI0//iJ0hLAexEqDcNsVhhmPGJY6j0G55tIftdbjSAS74nA4c2gjK5VXz0JlALpiTnnXpqsvrstkFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.19; Wed, 12 Oct 2022 05:05:00 +0000
Received: from DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::2cb0:a266:14b4:cc08]) by DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::2cb0:a266:14b4:cc08%5]) with mapi id 15.20.5676.030; Wed, 12 Oct 2022
 05:05:00 +0000
Message-ID: <b6a503b7-b421-a5c0-1cc8-4f1567b8d9de@amd.com>
Date:   Wed, 12 Oct 2022 10:34:47 +0530
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
 <85aabdc8-07cd-3285-1f3f-605f9ebbab18@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <85aabdc8-07cd-3285-1f3f-605f9ebbab18@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::30) To DS0PR12MB6584.namprd12.prod.outlook.com
 (2603:10b6:8:d0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6584:EE_|DM6PR12MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: e00e6398-a5a1-4734-235c-08daac0f508d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHE4eZ+RSDDc4ADsWgNxMltoh1ZHCRKll1rXf+Oi3r0QnqBSY7TjOvyS5ueYBIVzQzggFXV0yl4AwvkWGFyAJvrjLCCFtlD7M3ukgnDW2QYpYPzGSeVwiqwDm8HJ6SkHYP61tOtr8gmpBoNdon3chDE5Gj9LDlrXS5xFzOWoS5ne2mJVT4z9JqIiz6Q81siLdKt/bAo8fHu9TSOykmZJeaHV/cpiJF0FH9jpj0ytLBndXxaV27ben9Khn7668MuOxcpDU05RqxEQMtV+6s2YNS6R+4wRtwtbGL4NQLJhLkuwGvnEbfH/RJ+eq9h/GgEtobryBQGTAT515/Ango5rgNKNKQ2ng7G8OG3Mx01g0yPiPqqS74YIf/+AF6V0lS2uskGXdjmlhX8FDwG6NBKcbccMkoH3UMi5UfxO8plm+x3jWJ802PBqN6Zt1nBEmkqoUs6b0yv5c36019529Oq+lKcjqPafSgqGU1xr5xteA/8E3G82czbp4CnRelhtXfEx2NnWtGzCz4I80TPUp/YsC8rLkvSkMLo0jz5OGXhMest2rvnVCUa1WPH/bJU9EWI/MmC4PWCBdPEOwEk0xVHCeVWm+AQqPhlH7Qfnn4j++Rbvv+4Nnl0BzEs/4/vVg1LMhWC9Va3u9Lt2Q0ZdLTPWGd3kPqo+1lO90YwriPS4LIITufaOTJs0onEjYNxhX9VZz1CU9KgZ68ve3+ML3jK0ZVaSRYkSL9XVquc0n9gBy7OKXfkmaJqzi7K1b99clxJETqYyRYIwrA2E8DzAmyT8PLDVd10w+P4pmN2Mfa7WBjAVDXGxIRp/xu7IwPnPKISy36PrSkYXkj0psaLrDR2JUdRmsu+J9oQUhJWMHzQrwPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6584.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(8936002)(5660300002)(4326008)(66946007)(7416002)(31686004)(44832011)(316002)(54906003)(6916009)(53546011)(6506007)(6486002)(966005)(38100700002)(6512007)(2616005)(186003)(26005)(478600001)(2906002)(66556008)(66476007)(86362001)(8676002)(6666004)(41300700001)(83380400001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktYaDYwSVdPL3JpR1JtdmZIdlYrOUlTVkRyTHhENzl0SXhKaWg2cSsvZStY?=
 =?utf-8?B?bDVwZkM2a0pvaVcwRS9rbVk2clZwMEhDZGRuenRmc2pYM1V1TVl4RmdacUF2?=
 =?utf-8?B?WENlTjhURTFacS9ya1JZaWxvOGtPWlJLQVhEZ1VNVHNHSFFvR0pzS0EwMlZR?=
 =?utf-8?B?NFB3TlJ2WHZwdmhRcmszS2dNeHk1bmhqNGVuV0J3M2FtMDhmZWplWi9TZUwy?=
 =?utf-8?B?SUNCN2hUL1BXalBzSjl5cUUvWkQrc1dsZmFNSHBBZXNzNFRIZ2dRK3dFNFJz?=
 =?utf-8?B?NHFrQ2JmRWtBMm8yQVZtZmFVUFJVM09EOWpvUm9iTitadThRRnhOSE9sdit0?=
 =?utf-8?B?M0QrWU5tM2NxbTJsM3NzNU9MbjVia3o2UzIyVXF0bG9DL2pPWkhISkpoRkQ5?=
 =?utf-8?B?ejBpSUFaSGFWTGhBWUpDVDlFWUJvR092dktwQ3IyUU9id3FFNjRaRWtmelN3?=
 =?utf-8?B?UEI4RisvN2hiZUlRcmI1VFo5N0M5YWQxdGg0NFFlZ2FPaEZXVktaYXNWa2Vj?=
 =?utf-8?B?WkNxbUxlK0psM0xLeWJyajRVcUhhR1c5cVpZUTdGbWVNTU9lSDZEbXB2VDdm?=
 =?utf-8?B?aGN0UUQ4N0ZYaDNZaEZLNlV4RDcvN2J0K2JkYzc4RnNFM3pEUXAxckZUTHhy?=
 =?utf-8?B?a0dQZmhmWHE4QmlreEpSaEFaMG1EVURvcllZaW5CZ09UaEF0c1kzaUJsTFZm?=
 =?utf-8?B?M0RaNHBIVnk4Q0QrVjdvQUFwVVp0Um5KakZuUzc4ZS9ySCs2RG1TYnN2RFgy?=
 =?utf-8?B?azFoejZXTVJya1dXMnQ3MkRTUXlROHVIVHIzK1VEL2tnU3BIQWJGUU92TkRu?=
 =?utf-8?B?VGZPNk9LTGFXbWhoSjJwR09pVUVTUWZmeXJpRmk4TlF2TGtjU0owYjVLWStG?=
 =?utf-8?B?ZjNkMjJpSkVnVDNocmlYNTk3QWZjcG55dmxDZkpPK0l3YlNReXNRZk9sYUdR?=
 =?utf-8?B?T0xxNy83ekpYOFZhZFQ3Rmh4dldTZFlSc0pqRENwbWo5eHRSWVo5eUwzbGYx?=
 =?utf-8?B?L3l5LzdLZFAxSHRna29meWVweDlSTzdkNThNamFzWFVGTGtXMnRGb09jSlZE?=
 =?utf-8?B?U3BidnJ1WWV1a1gyT0tyRU9GcjZ2OUNCWEF3M1VFckoyK0dnbThWejBCUnkw?=
 =?utf-8?B?b0l4aHdjTnlIRWxGRENwMXZhb25iRUQrVjNFOWZlVkkreVU5eTQ3NmVXM3la?=
 =?utf-8?B?RVN2di85dUhCZmFFWlNjNmx3T3JnUGxPK3lmQWJaS2NLWDUvTENLTDhpL0ZX?=
 =?utf-8?B?RURuRnZvNjZKRFg4TWpsYlVuN21lcDduK0hpTUgzZnlGS0ZFUUxiR1JHQXV4?=
 =?utf-8?B?dG13SnZiRWF6SkFHdHIvWGRVUW95SHBYOE5QeUJPMVRNejNkTUxPS1UzbHlQ?=
 =?utf-8?B?VUVUalZHZGFFdkZzcEFpdittandna3pvWUZ2QkRnQnR3SnZxRXQxdkRyblcr?=
 =?utf-8?B?ZHZyTW5nb0RONEJiMExsc2JCRHdyZlBycE9iem44OGRGRGs5N2FidUVNOGtI?=
 =?utf-8?B?T05iU2JJd2xLSE96K3Ewd1R3TVdSMUlURWlEUmMyNE5LU05NRXhvbXJ6cW1R?=
 =?utf-8?B?ZzZEcHIzQ1NRRWxtSkhJM29mMWxNL2xEZTVQam1YT3BNUHN4RjdZWnFCdEY3?=
 =?utf-8?B?ZkZOaEJCanlaZHhLNjlldUtxRUErLzJKM2tJNks3bVYzaitaUDk0Qm9mRTdI?=
 =?utf-8?B?RTBPemFHeTZteVNaREErODVZOU9COXVDMEROUk5Lb0NWQm01dzJxZVg1aCtY?=
 =?utf-8?B?a3FoU3ZwUnFHTjFCMEZGMExtcEhCVFJMdnhxb3VwTnFCNEdJb3NyNmQ1djFq?=
 =?utf-8?B?QTIyMit5djlpUWR1d09UTDNxclJGRGtwWXY4ZE1lekJpeVJrV1RpUG0yQ3VF?=
 =?utf-8?B?NnJhQTdvUnk2NERMemlKR3Z0K1BDdzYzcWFXQzhCK0Mvbi9YMEdWOXF4MUxD?=
 =?utf-8?B?YzMrWm8zUWZselVHWXcwdG5YeFgyKythK1JvNHJ5ZWZLWDJGYysxSmhJdVFW?=
 =?utf-8?B?QVA2enBHNXlDcjN4MTdjWFVWMHlQWHJUQmxjMjNxcXVhTHNkeGJ4aGpIOTdI?=
 =?utf-8?B?UlR4K0hCZVRwTlNlTVJpZ1dtc3pTRE5PMUVuZUVidXRDWXNsNFhESHFQWndD?=
 =?utf-8?Q?WwGFT5jq0tS5bzDqndXyh1uuM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00e6398-a5a1-4734-235c-08daac0f508d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6584.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 05:05:00.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tnpqLCuhrL8QYD4XhzdabFz7uXgAGVjb1oH2WPWz8dyMM2a2Ef5vqPk5ywpKOQRVRULGuGNWH9j2R7R/zvSgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-Oct-22 9:36 AM, Ravi Bangoria wrote:
> On 12-Oct-22 3:02 AM, Nick Desaulniers wrote:
>> On Thu, Oct 6, 2022 at 8:56 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>
>>> +cc: PeterZ
>>>
>>>>>>>> +Ravi who may be able to say if there are any issues with the precise
>>>>>>>> sampling on AMD.
>>>>>>>
>>>>>>> Afaik cvcles:pp will use IBS but it doesn't support per-task profiling
>>>>>>> since it has no task context.  Ravi is working on it..
>>>>>>
>>>>>> Right.
>>>>>> https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com
>>>>>
>>>>> Cool, thanks for working on this Ravi.
>>>>>
>>>>> I'm not sure yet whether I may replace the kernel on my corporate
>>>>> provided workstation, so I'm not sure yet I can help test that patch.
>>>>>
>>>>> Can you confirm that
>>>>> $ perf record -e cycles:pp --freq=128 --call-graph lbr -- <command to profile>
>>>>>
>>>>> works with just that patch applied? Or is there more work required?
>>>>> What is the status of that patch?
>>>>>
>>>>> For context, we had difficulty upstreaming support for instrumentation
>>>>> based profile guided optimizations in the Linux kernel.
>>>>> https://lore.kernel.org/lkml/CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com/
>>>>> We'd like to be able to use either instrumentation or sampling to
>>>>> optimize our builds.  The major barrier to sample based approaches are
>>>>> architecture / micro architecture issues with sample based profile
>>>>> data collection, and bitrot of data processing utilities.
>>>>> https://github.com/google/autofdo/issues/144
>>>>
>>>> On existing AMD Zen2, Zen3 the following cmdline:
>>>> $ perf record -e cycles:pp --freq=128 --call-graph lbr -- <command to profile>
>>>>
>>>> does not work. I see two reasons:
>>>>
>>>> 1. cycles:pp is likely converted into IBS op in cycle mode.
>>>>     Current kernels do not support IBS in per-thread mode.
>>>>     This is purely a kernel limitation
>>>
>>> Right, it's purely a kernel limitation. And below simple patch on top
>>> of event-context rewrite patch[1] should be sufficient to make cycles:pp
>>> working in per-process mode on AMD Zen.
>>>
>>> ---
>>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>>> index c251bc44c088..de01b5d27e40 100644
>>> --- a/arch/x86/events/amd/ibs.c
>>> +++ b/arch/x86/events/amd/ibs.c
>>> @@ -665,7 +665,7 @@ static struct perf_ibs perf_ibs_fetch = {
>>>
>>>  static struct perf_ibs perf_ibs_op = {
>>>         .pmu = {
>>> -               .task_ctx_nr    = perf_invalid_context,
>>> +               .task_ctx_nr    = perf_hw_context,
>>>
>>>                 .event_init     = perf_ibs_init,
>>>                 .add            = perf_ibs_add,
>>> ---
>>>
>>> [1]: https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com
>>
>> Hi Ravi,
>> I didn't see the above diff in
>> https://lore.kernel.org/lkml/20221008062424.313-1-ravi.bangoria@amd.com/
>> Was there another distinct patch you were going to send for the above?
> 
> Yes Nick. I was planning to send it once the rewrite stuff goes in.

Hi Nick,

Since you have practical use case, would it be possible to run your workflow
with perf rewrite and IBS patches applied? It will help us in finding/fixing
more bugs and upstreaming these changes.

Thanks,
Ravi
