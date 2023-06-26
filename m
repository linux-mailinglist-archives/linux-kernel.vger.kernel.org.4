Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F331073D748
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjFZFpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZFpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:45:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8ED134;
        Sun, 25 Jun 2023 22:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FghZag0MvPVCO2SwRKu8zsVllyDwpQI9MXrSIZD04aXIS880HsyYJOEoG3e6hODsIGjX4djiwqMmf7n9dHEayT3QZpxQEDckZgeZZQs+aOTDdIseW57Bgu+xz09dgKiPE16xkTyAZ0EY//lVIXUDmvms8vlVmy1IKc4Qt+gmLEiNg5JrhapGkYjVMow5mP7/XZKx4STB9SRPbhoZyiR68eYE2L0Pn8o7LcP3Puyab/sKgwqXPAVhwNPU85KYDO2Hj5QLUEKA5hQ8qKd6OiG+nPu/0xkFj9+lKC0ODKercHVYvnKMYsM0Rqs63OYICRBemVXtYln+B9mjGYBFqyUr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+FnflVgEmgDeV0N2+XEEVjfNGpTZbYbounI7zsZdog=;
 b=Y1jfsjPBzKtZs+9dqA8DPDkONcNMVaTBuNbTAkTw1h4WFKiMqmrIwrSgsax3xzLAYIwImiaK13CrfV7cxJDJFTefuuMMjHsX0rCPhijUNB4ETojZoqGW78jfXkitRH4yaHdCyV/U9X233CH8ltdIajR1xwMnSAxfbkEEX/5VXDyqir+paKYdfhzWrP8F2POHyUj0PL2qBafZ3s9eX+uHT1NYZlpCgA7+j1ZAVwB4/YA38qWSdNEaR9g1xx0mjpkBjSnYTtC0J8zHOHib8FsjA0UmYhV+k+eXrsgMvGPKuClv+4AZSXlgMfwBCYCh/lTbUhSHN++6b5XS/hfHWnXaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+FnflVgEmgDeV0N2+XEEVjfNGpTZbYbounI7zsZdog=;
 b=dDIiuw2LYA7XSHF2oMXAI3qajFrnoiVyMTh68KQbdkdOBSa720x8wP7odaks41a6xeGk1d7EfcwiwGUrYuWdOFg13+q5ruMFHJux9X68CHaJlmkDANeI3XDmw6RBMa6zRwef5Sm9MvMTdMTc1OSc5/8OfOEWGmsFQkMQ9cQMees=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 05:45:35 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 05:45:35 +0000
Message-ID: <5c077e61-c206-812f-1cb9-d47785e8176f@amd.com>
Date:   Mon, 26 Jun 2023 11:14:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
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
 <b6a503b7-b421-a5c0-1cc8-4f1567b8d9de@amd.com>
 <CAKwvOdmY7qoSG61f7UouWFz+gNN531FhpHbqawrAKCNKNDJHnw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKwvOdmY7qoSG61f7UouWFz+gNN531FhpHbqawrAKCNKNDJHnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::10) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: db32104a-c0cb-40a1-86ad-08db76088fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7V8Banl2+WwhEj5mr2jMCfQsqZR0EZO4J7Kv3pqp3X7/mrzvDSLkwJPSQuAzqacxcYPBSXRXuT+7ETcGfPk6odTTnI/P2k8I8r9z2PSqtsvGlYoTb4jly/DqHWfsA4wQ/Cs/O5yhTYvUqFPA2BICup0Ms2etDqnEgnPSCPL8z2VNDNojmg5T5ovYjBKAjnr/5pnmh9wlOq3FukecZqAAGgh4WDxIyXpbDuffxipDQ2oTzPxxuLZHIC2N0Y9y+7nZ6QgbnMpcIQjLvUU0F4+aVPH3d6yQfCxbjc0TzSSB2sPS9pD1/2CyDg06dOILPqMtoj/JDsGqxNMXpIQLH5xgMaHbDygounolHrsnknfxiMBxsJ790HWW814BalB5Kk2YttXsRsOFhO9Ug7yZ6QlCRCsIzDS6YUJ/LewOVrB5W9IKIRCZ0nG3hyb8U7fuJrg6ySItnYlg8JWw4Bi4EdvK56lcNQvR9S/P09HRv7PIgFFRHanXe1UKjgbODkZLpf9CQSgIJYlpEDLVhnGN2qwIaOe9mBNafnm2HGTUC7lT7UFO8gbPiOA6xMkPAboKWl78Gp/lwTxzZV69ySU+SgmF62gdrEFKbFKOfoqfu3J/iQsZJUP0tx1H4cJaguSMqMm/XXBU8fU3I2Ak51/ANelpzhlpa595Uo52ZABl2jbKcyVq7UqMHFaX/z9clyGdYIT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(8936002)(8676002)(5660300002)(7416002)(36756003)(44832011)(38100700002)(2906002)(478600001)(186003)(6486002)(6666004)(31696002)(54906003)(2616005)(86362001)(966005)(26005)(53546011)(31686004)(6506007)(66476007)(66946007)(6512007)(6916009)(66556008)(83380400001)(4326008)(41300700001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkQvRVNuYWJ6eTMvd1pBQnNOd2FOQzRiemhxRCtWUUlxdkZGaGpORnA0cExn?=
 =?utf-8?B?L3Q2TW05UFpwZzlSaEIxamJxeSs1QmlMZ0NqazBocVlHRVlOb0U0Y3B0UUtN?=
 =?utf-8?B?MlJiVzFpOE0yVGNWcVlRTFladXQzckhXUVZ3bXhRWlhxdWNCUEdUeGQ2U2tN?=
 =?utf-8?B?V2diNmhSNStpdXdTR21vRnZVaFNOcUF4Ulc3bnNpQ045ZjNHUjhQNzhUSXVy?=
 =?utf-8?B?NEhGRmZRNmR2ZmtWRVZmSGdmd3FTQWRkcnJZTU9ITWpRUzk1Zlk3UFZFZ2Vt?=
 =?utf-8?B?OGw1YWl2dFdMVDAza29keko3OWowRXBUK2hZT09WYitWK0pSTDI0TTdaMGRY?=
 =?utf-8?B?dCs2KzRSUzFuMEVUYkxmYnNuYW1LNnk5K3NqbWdZRVR0cUJjSVBvQlZaZmNH?=
 =?utf-8?B?bXd6L1FQYnZmMGxPK1p3SG5uYUlXWEhQeDVxRDhkVW9pRkNucENnTElMRjY2?=
 =?utf-8?B?dDhtaG8xN2JRS3VESkJ6SmdSQVpLejhhU0hpelZrTTBxU3lZSEpDa1N4WlZs?=
 =?utf-8?B?VG4xREw5NFRha1B4QXBhTkxhVFQ0Z0RZZnk1TUQwWU85MlVXeU9Qb090aElv?=
 =?utf-8?B?UmU0cDVVblV2K1U5WXplUDNPMkZTSTRveXp3bzROeTFHK3h3Nm5XM09yd1Rz?=
 =?utf-8?B?dTErdGljVVJHYzVEOGtubEpRMmI3WnVLSnU2VWphMVZmOEhRL3RHTWlXMFFt?=
 =?utf-8?B?Tjc1dkFxZXEyODhTU1ovdVpHYXIrYTBzSjBLUE9ReEZhVDN0a2dDaWRIcmNU?=
 =?utf-8?B?cjN4T3ZycGhoU0x1Skw1SFZqS2tUQURGTTNNUFE3R2plKzNtS0k0ZTNOVEEv?=
 =?utf-8?B?b3Y3bUpuL0lMK0t5ZXRuNm1NclJJdFZKUGF5MnFEL3lBWkoxa2Z4OUNLRkxG?=
 =?utf-8?B?ZTZXZDRWZTQ0SFRFeTNXODBaODJxVnUzaXBnMDNrSC9qMWQ5SE1YMDNCdHFV?=
 =?utf-8?B?K3hSVGhobVhYSVNINEhYNWpvQzJacE5CUDBSZzFmZFZnR2xhUTJUR2xxdG1H?=
 =?utf-8?B?c0VuMThJYW54YzFIeis5TTk3ZExxZW9BYVlVQjh4Q3FseW1oUUkzTE1nREEr?=
 =?utf-8?B?SXRYVWV6RzlYeVdqM0FPUm93TVFEc2VWQmZuVFJPTkwxd1pZL0RoeGk1d0VR?=
 =?utf-8?B?cnh1NnRFODhacC8wSmpod3AvREgvY0lNMWtqd3Bkb2wwUzF0cE1yb1hPTFpv?=
 =?utf-8?B?UG11TmRBSktOMmUxZzBzL2JKU2F1Z0MySFFVUW1VV2c0MHYwRDE1U2kwQ3NO?=
 =?utf-8?B?VFFWYjZ0cDkvQVRBUnYzTTBkclBUeVJmZDlZUGIwQjlUMkJXOWlZOStZVEpS?=
 =?utf-8?B?cnlQQm5IeDdmZXRUTXg0WUdCT1ZVQ2dBaFZ5Z3NWcUlwNXBGeXUzY01IbTJh?=
 =?utf-8?B?WkRQV2J4WmVUejJ5ME5qZnpNc3FrNlV3QTFqc2p5UGRlSjN2blVHSitlUUtV?=
 =?utf-8?B?Nlc0Ti90YW9LWFNsSksxT0xiN0tjNENYc2NxdjZqYVlXdEljRkJHR0Qrd1VN?=
 =?utf-8?B?c2JkaWtHNUlFb0lRbEFidmtWdU9jZGtsbmhVd3NXUE5Ld0ZsYzJ4a2ZMc2h5?=
 =?utf-8?B?QkJWeGRlK05VeTRuVDVBeTRKUWxpcmQvdXM5VEpYUWRyQWg2Ry94VGc0eUd4?=
 =?utf-8?B?cFVUNWdteXp3QnN0VXN6d1pWNWlKUE0yR25DaTVsUU5XckhvT1lsQlhOS0Vp?=
 =?utf-8?B?VDdaWGpiL2NkZEx3eFk0TWo2eHNMaDA3WGtVUFJXcWxwaVBUcjQ3dFowYlg3?=
 =?utf-8?B?aUNEcG1VUFBtcURoeWJDa2dZWkJISmdMbnZva1VBRFZ5N2FHb2h3VW1FWFlo?=
 =?utf-8?B?RWJzWldmaEpDVmE5WTFic3FIeDd4SHAzaWJtZ3VrWkRFSjNETWYzWGVsMkRk?=
 =?utf-8?B?aEZBWjdnajFNYm96QXp5TmpYbFZ4aCtPbmloVlZPWVFFYThvd1ZnWmhadVVU?=
 =?utf-8?B?Wkx0ZG9YMjJoZm9taGp6aTF4bkRKVXZVM1hZZ2poZ3Y2a1oyM1hxQmVqN1Bi?=
 =?utf-8?B?ZzdQOUJkQlcza0FqNlFVeEVlZWJsUUpKSWdZTUJyMG10a3FORzJ2S3BwRzYr?=
 =?utf-8?B?NzBuZG9aeE1XRVNuRkZ6ZGhJajJyZUlJaXo1anZTVWN3RXQ4RXdTMk1NRzNU?=
 =?utf-8?Q?icMJ3f3A0M99oKgRTn9zFBy3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db32104a-c0cb-40a1-86ad-08db76088fbb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 05:45:35.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAlRq8jHBgNqATHPbXAd8vY94ln9fhFtfeVauTEZBqgByeLHyAOBJSA0ftLLAYJgxFQTmjDS6966pkQGgwff2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 23-Jun-23 9:53 PM, Nick Desaulniers wrote:
> On Tue, Oct 11, 2022 at 10:05 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> On 12-Oct-22 9:36 AM, Ravi Bangoria wrote:
>>> On 12-Oct-22 3:02 AM, Nick Desaulniers wrote:
>>>> On Thu, Oct 6, 2022 at 8:56 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>>>
>>>>> +cc: PeterZ
>>>>>
>>>>>>>>>> +Ravi who may be able to say if there are any issues with the precise
>>>>>>>>>> sampling on AMD.
>>>>>>>>>
>>>>>>>>> Afaik cvcles:pp will use IBS but it doesn't support per-task profiling
>>>>>>>>> since it has no task context.  Ravi is working on it..
>>>>>>>>
>>>>>>>> Right.
>>>>>>>> https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com
>>>>>>>
>>>>>>> Cool, thanks for working on this Ravi.
>>>>>>>
>>>>>>> I'm not sure yet whether I may replace the kernel on my corporate
>>>>>>> provided workstation, so I'm not sure yet I can help test that patch.
>>>>>>>
>>>>>>> Can you confirm that
>>>>>>> $ perf record -e cycles:pp --freq=128 --call-graph lbr -- <command to profile>
>>>>>>>
>>>>>>> works with just that patch applied? Or is there more work required?
>>>>>>> What is the status of that patch?
>>>>>>>
>>>>>>> For context, we had difficulty upstreaming support for instrumentation
>>>>>>> based profile guided optimizations in the Linux kernel.
>>>>>>> https://lore.kernel.org/lkml/CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com/
>>>>>>> We'd like to be able to use either instrumentation or sampling to
>>>>>>> optimize our builds.  The major barrier to sample based approaches are
>>>>>>> architecture / micro architecture issues with sample based profile
>>>>>>> data collection, and bitrot of data processing utilities.
>>>>>>> https://github.com/google/autofdo/issues/144
>>>>>>
>>>>>> On existing AMD Zen2, Zen3 the following cmdline:
>>>>>> $ perf record -e cycles:pp --freq=128 --call-graph lbr -- <command to profile>
>>>>>>
>>>>>> does not work. I see two reasons:
>>>>>>
>>>>>> 1. cycles:pp is likely converted into IBS op in cycle mode.
>>>>>>     Current kernels do not support IBS in per-thread mode.
>>>>>>     This is purely a kernel limitation
>>>>>
>>>>> Right, it's purely a kernel limitation. And below simple patch on top
>>>>> of event-context rewrite patch[1] should be sufficient to make cycles:pp
>>>>> working in per-process mode on AMD Zen.
>>>>>
>>>>> ---
>>>>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>>>>> index c251bc44c088..de01b5d27e40 100644
>>>>> --- a/arch/x86/events/amd/ibs.c
>>>>> +++ b/arch/x86/events/amd/ibs.c
>>>>> @@ -665,7 +665,7 @@ static struct perf_ibs perf_ibs_fetch = {
>>>>>
>>>>>  static struct perf_ibs perf_ibs_op = {
>>>>>         .pmu = {
>>>>> -               .task_ctx_nr    = perf_invalid_context,
>>>>> +               .task_ctx_nr    = perf_hw_context,
>>>>>
>>>>>                 .event_init     = perf_ibs_init,
>>>>>                 .add            = perf_ibs_add,
>>>>> ---
>>>>>
>>>>> [1]: https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com
>>>>
>>>> Hi Ravi,
>>>> I didn't see the above diff in
>>>> https://lore.kernel.org/lkml/20221008062424.313-1-ravi.bangoria@amd.com/
>>>> Was there another distinct patch you were going to send for the above?
>>>
>>> Yes Nick. I was planning to send it once the rewrite stuff goes in.
>>
>> Hi Nick,
>>
>> Since you have practical use case, would it be possible to run your workflow
>> with perf rewrite and IBS patches applied? It will help us in finding/fixing
>> more bugs and upstreaming these changes.
> 
> Hi Ravi,
> Sorry, I'm not able to load a custom kernel image on my employer
> provided workstation, and I never got approval to expense hardware for
> testing this otherwise.
> 
> Was there ever any update on this? I'm on 6.1.25 now and still cant run
> $ perf record -e cycles:pp --call-graph lbr <any command to profile>

Per-process precise sampling on AMD platforms should work from 6.2-rc1
onward. However, --call-graph=lbr is not supported on AMD (hw limitation).

Thanks,
Ravi
