Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F687740A21
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 09:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjF1H61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:58:27 -0400
Received: from mail-bn8nam04on2076.outbound.protection.outlook.com ([40.107.100.76]:33312
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231373AbjF1HzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:55:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8YSWjknk3gHv/QVrMdMPXJRuFPk3rF5ue7LSrNBUHRlUnhsXCRq73Od1d1BgmlLALHGfSx0Fl6GeC6QYUbhyc8lOCM0mxMZNYLbqeVYzQ1P/aEX04V0Y3et3QRikB/XfnQ+qH5Mt+0IxKFiAIgbu7TLXKloH3+7aku2rMipafbzPik1sddO8ZxdO9rhE99w4ZdkE3fM8j1YKehmMVhn6VSptGtGKSlv9anWmSWxb7tEggDr9UXdX5e1RPkO1LIm+9qlQa49NjdZb21t4R8d8g8AbWp8tfm6bQ8kGnapHqKZtYpQtpIC59sk1MYbveT4roMqhUS72QJIfwCFsRgJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTbxjH4GIdEZ0eDdU7Lj6XDYM5SUITh+EE1RCmwwHSE=;
 b=cBu4mJerCGHUK39s7FQYXddDVVnUFMtXQjFLmAX7piMJWooMbbig3+VEl4A2fKpn0ZrA24uLnBHUEaKsLIOsva+IcIcZq8DEkOk1ncbEdUbvs9Ly1zYt7kNfzm2kTnsuELfjsQFM0NoQqx1N9aXoGdnlz14HxNR+V9waXz/FF3trRgq1/4DrCBzC1tMnKY6ommReOAp+bnA6xM0R4VlD0+Y1z3+FuScb7TrGtXHYpxsVtp2XkeBcqafuGoqxaKpsYyXucSMWxrAMUIm/qpyPzWOdXsHgAGozyDDcKZkegH2qd9p8L0BWVQRgBwCOBkgCA3VfGB4GaIdFELIUfUGpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTbxjH4GIdEZ0eDdU7Lj6XDYM5SUITh+EE1RCmwwHSE=;
 b=em4T4/XCtdmvIVg6XYp5ctJ1Wvz4aEgoMcUPI56dEskghV71oaj7fNWXx853UPaCcpFM5qUEjkumk/HwzuUwZh88S2q2bq9wbt8/iR0790jqwV/HvIDx9SK7GtgsJkeeU4espKoKLkvdpNdZlunwMKIeG9cYH3bjtL4fPeKABv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 04:50:36 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 04:50:36 +0000
Message-ID: <aa2ef58a-f02b-8c9d-2b62-8587f3b091bc@amd.com>
Date:   Wed, 28 Jun 2023 10:19:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf evsel amd: Fix IBS error message
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, peterz@infradead.org, irogers@google.com,
        jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230626103958.834-1-ravi.bangoria@amd.com>
 <CAM9d7cgL2+jHtyy6k19NbmW1cD+RGRkwUANDk8xH3oGqxB0qqQ@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cgL2+jHtyy6k19NbmW1cD+RGRkwUANDk8xH3oGqxB0qqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::25) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b49651-d83f-4190-f49e-08db77933654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crReek1yES7h5GjTizDFRDWiUBH5RMycbkVpi2Gxb5fRcnWwjoLd1S7lpMpkVKEjmkh4bnXz0UkE+75vm28c6QGl6/CWCoisYzJSfy6B7xjBNNSqpUUhc/wCscTuUko2eKkRDR6+CYusapHfB/I1SmA4vHLYmipdSElxAQbwXRtllof8gZv3pb1gJLeFIl3BEDSgYUu2uZO3q6iNaw/zpWRqmEVi3D1okfcSerVbPTpPZ80USBWht8fjSpLknAVZDYUkJmpj1q4VvlO9ycQMxUs6OS3VtD/Qy6bhEKa6gLptCdp/kMZSfnka2nH9SPPF4hbPtg454LXW8m+nWG2gBSS9xndqC4kHCKuzPLMy7d3VrGS1VHy0UxzCy0sf7Ipxxhh0axuT+T+tgLDc1NHKGeWdo/6PT4pY1tWNwx9GUA4aZCtwNHUHEhBcsf2+CbGpqBBdpRQp8b21yvG6qMKskvUa2RdPz7kNwVOKQ7NG0kYkTnwrjmYFfsGuxlwGWlblMLOB/PPAQPty8GgaX14TRn/s7gomBIkZuJi8HTNw3ktxLLM6qemIs6aCNcceinBPWmEtdv+a2qD6Pw9ej1Q+T2mRGXLTxTAaif7InczpKndl/IV0yIYhP6/LKaoxgND2jEawdDyIwgsB6ql3MTO81Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(6512007)(31686004)(36756003)(44832011)(86362001)(41300700001)(6916009)(4326008)(66556008)(66946007)(31696002)(316002)(66476007)(8936002)(38100700002)(8676002)(966005)(5660300002)(6506007)(53546011)(6486002)(186003)(15650500001)(83380400001)(6666004)(2906002)(2616005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTBvZEpJcWpRQURyd0VUdDlZbUF4WkFBZmlrMUVCczZnWWZlSGFUN3BzM3lC?=
 =?utf-8?B?S0l1RU9pSW1JYUVqZStnZjlUMGFBaE04U3FlWlRHWWdFZTJsN0NMTUZUZ1p4?=
 =?utf-8?B?RlowSDRlVFQwZE1GdkcxczQ4Q0tnQlZiWkJVNW94KzVDYW5uYi9abWNOM3cw?=
 =?utf-8?B?aUxrREZKSE1HWVVvUWlhSmhER1BLVG1tY2xVZlBoVFZBU01DZEtWOXQ2MXlm?=
 =?utf-8?B?N3VVUnNnRGlGeWNzVmYzWUtWYWFYeVFoSlpMYm83Nks2eHBMQUZ3RWhBTU9B?=
 =?utf-8?B?aU9LbWxpQ2ZzSDJLbnI2UENyaVFLbkZMOThGWDl4R1JmaUliTmFnelJuM2hj?=
 =?utf-8?B?d25PQzl2YlJsZE9KT1ZwdTVvenJ2WmpHejZyOUJZcXR3SzNtbUp0aTlnUkJP?=
 =?utf-8?B?UkxOYlZoei9aNHRSNXBxek53UXRnNFpLaEtLK2JML0I2WjdEU25UdERoVlBj?=
 =?utf-8?B?RHZDQ2FXcHMzZEtIeXNwMldNY2VlYU55bi85bEZMTHFsS1ZEU1lOb0ZnSy9V?=
 =?utf-8?B?TU40eUFRTUpEZnY1K1FNLzZra1YrWW50Tk5oMGNIU2NsZmVvbVgxdGRCbFdi?=
 =?utf-8?B?UzFqdndoNzBGME5jb0Y3UTFTUFVTdmYxbVZaK0tSR3J3QTRiYTl3RG9TYmYz?=
 =?utf-8?B?alBzWjUrM1EyTTY4ZVdNQjM3K2t0dlI4NDMrVEREUjVVZWpycUlFRk4rM0U4?=
 =?utf-8?B?bHZBQ1pXQzMvU28xaWZtSkI1Sm1mZC83STdSUDF0bVl3L2Y5M05Xd09pOEdx?=
 =?utf-8?B?YllJUjZHYjlnRm01SEIxSExYQUZseE5WbjJOaVFtYmhSeThTeklkKzhJRFpX?=
 =?utf-8?B?WXJkaTBUVU9oeS8wVks2WmxoQnBmT0M5V0tYQUhWUmkxT095V21jRWZPMXdm?=
 =?utf-8?B?ajZIRUtxNjNYSjM0TnNmMDd1MmNNMjh6ejljN2JOOTF1NlJobTNYdFVkTzVS?=
 =?utf-8?B?WnVmc3VJaHdTeGZQVVVEQUwraDBoTklITzhEMjFBUTVkS29tY29RNVNmQ05I?=
 =?utf-8?B?RXVLelhoNTNQWTAra1p3WXRJNyt3bmgxZy9ua3N3QVI5bWpjcVFoSURkMHhv?=
 =?utf-8?B?QkxwQzB3SjFveEtPZXRscEpqOHk2TTAyVTlFMFIvWWZ5a1RsM0QxeDhZOCtQ?=
 =?utf-8?B?aFFPTkhZcUNuT0xHeHZ4eUVtTHJjdUlxbzNBaWp4SVJxdXNwQWNmck1GbjU1?=
 =?utf-8?B?M0tPZnVkTFQyeDVJd1hVbmlWTlcwZDFNUUdtYTNmTmZEdDR6TGlkN1pIQmRo?=
 =?utf-8?B?clFzY1VYeGQ5d2pxWjE4ajUzTzFxc0xIbjU1ck1ibWw2YmJzU21CMm1JU2Vm?=
 =?utf-8?B?TzRoK01ZSEFkcmpwcWFLZXhabXVvMkUwS09aRWdRQUVpa3ZqS21YS1kybkZ0?=
 =?utf-8?B?Qldsd2VpVzJTWndYVnRoQnRCMWFBa2NjMDI3SEVYeUpxay91QXcrbjFJRlFB?=
 =?utf-8?B?UEVNaDFzN0dCS0FuYjVITElYUzl5elludlpSYVk2SjlTbEhmM0prYTBvSUhO?=
 =?utf-8?B?OEw2aTFzVytkSW8wV0VTOUhXMUV2a1F0SUcxTFBMZFgzckltS1FjaXZvMVQw?=
 =?utf-8?B?RzJFUnl0NXc3NTZiM1ZsNEFtNEwrRkQyK1pQMkpnTjBST3R2cG5YcHAyQ0Rm?=
 =?utf-8?B?ekZnZ0M4Q3NSM2JmNmd5T21KYm5CL1FndG1FQzBHRHlacTFqSDlPMFltTHY1?=
 =?utf-8?B?cFRUYWltNnAvNkNna3QwZnhRT1ErYy81eTc0TkpCeVorTlFWYndJa0prWHdE?=
 =?utf-8?B?K2ZBbmR2THZ3R0VMSkZtZWVUaytlRFI0d1huT2JFRURYbGdGRmErRkxxOFFt?=
 =?utf-8?B?ajVybVgwbDBtNkFGMXlEeE1IeWhEdlB5VDI1cTBPVEwrbU00dFdGS05ZNzlT?=
 =?utf-8?B?WDhxYVNVRXQrbFMyckRvVlZPNmtHYUpEa3d4WGluTHllZ3FuakRxNFhDclZi?=
 =?utf-8?B?eWc2VEJWQlVGZDN3K2dvaEs5ZFNJeUVveDhHYWxGUEJ4WEhWdUgzRmY5Q29W?=
 =?utf-8?B?UmNoM2FKT3pheE1wVnVMbmM5Q0pONEtoK1NieThNSEFmc0JjRm9yNThMZHJI?=
 =?utf-8?B?bTZoYVg2ZVBFL29qZmVzZDh0SzNkbGFWTjErK2swc3VWc01aaFczSFpuNDJJ?=
 =?utf-8?B?SzE1YStiY05Yc1kwNVd5c2FxNDN2bHBVVkZBcmpReFhwVXVnOTQyblI1Y0ZE?=
 =?utf-8?Q?YrlKyJUu3eIf2Ggaj4nBAic1vnrryeqcuDEIbeZDaCPR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b49651-d83f-4190-f49e-08db77933654
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 04:50:36.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzytF5NnSiR5QvFaPdzzEFtqv6koL2J1bN1816naSxLiu3ralCj6BQ+4GhkD9OAshQtrG2dF8nrqpaqwMP9JXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-Jun-23 4:34 AM, Namhyung Kim wrote:
> Hi Ravi,
> 
> On Mon, Jun 26, 2023 at 3:40 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> AMD IBS can do per-process profiling[1] and is no longer restricted to
>> per-cpu or systemwide only. Remove stale error message. Also, checking
>> just exclude_kernel is not sufficient since IBS does not support any
>> privilege filters. So include all exclude_* checks. And finally, move
>> these checks under tools/perf/arch/x86/ from generic code.
>>
>> Before:
>>   $ sudo ./perf record -e ibs_op//k -C 0
>>   Error:
>>   AMD IBS may only be available in system-wide/per-cpu mode.  Try
>>   using -a, or -C and workload affinity
>>
>> After:
>>   $ sudo ./perf record -e ibs_op//k -C 0
>>   Error:
>>   AMD IBS doesn't support privilege filtering. Try again with
>>   exclude_{kernel|user|hv|idle|host|guest}=0.
> 
> Can we have more user-friendly messages like below?
> 
>  "Try again without the privilege modifiers like 'k' at the end."
Sure.

> 
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>> v1: https://lore.kernel.org/r/20230621062359.201-1-ravi.bangoria@amd.com
>> v1->v2:
>>   - Check all exclude_* flags not just exclude_kernel
>>   - Move AMD specific checks under tools/perf/arch/x86/
>>
>>  tools/perf/arch/x86/util/evsel.c | 25 +++++++++++++++++++++++++
>>  tools/perf/util/evsel.c          | 30 +++++++++---------------------
>>  tools/perf/util/evsel.h          |  1 +
>>  3 files changed, 35 insertions(+), 21 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
>> index 512c2d885d24..9a7141c5a4ea 100644
>> --- a/tools/perf/arch/x86/util/evsel.c
>> +++ b/tools/perf/arch/x86/util/evsel.c
>> @@ -102,3 +102,28 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
>>                 }
>>         }
>>  }
>> +
>> +int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size)
>> +{
>> +       if (!x86__is_amd_cpu())
>> +               return 0;
>> +
>> +       if (!evsel->core.attr.precise_ip &&
>> +           !(evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3)))
>> +               return 0;
>> +
>> +       /* More verbose IBS errors. */
>> +       if (evsel->core.attr.exclude_kernel || evsel->core.attr.exclude_user ||
>> +           evsel->core.attr.exclude_hv || evsel->core.attr.exclude_idle ||
>> +           evsel->core.attr.exclude_host || evsel->core.attr.exclude_guest) {
>> +               return scnprintf(msg, size, "AMD IBS doesn't support privilege filtering. Try "
>> +                                "again with exclude_{kernel|user|hv|idle|host|guest}=0.");
>> +       }
>> +
>> +       if (!evsel->core.attr.sample_period) {
>> +               return scnprintf(msg, size, "AMD IBS doesn't support counting mode. Try "
>> +                                "again with sample_{period|freq} with non-zero value.");
> 
> Is this for perf stat?   We don't allow zero period for perf record.
> 
>   $ perf record -F 0 true
>   frequency and count are zero, aborting
> 
> Then maybe it can say: "IBS doesn't support perf stat, Use perf record."

Ok. Let me skip this since generic code is already covering it.

Thanks,
Ravi
