Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C2634FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiKWFmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKWFmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:42:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3142BF1DAC;
        Tue, 22 Nov 2022 21:42:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VST4R6jlp7Tgouth/LoH1zvu1Jb4Ixq6TAcw5nc0FGk6XtjQ/h5Gmc3/YePOrS2IFo8fM/d0o9h7afX2CwNz5DuZag2XGjmPrXTNfCaXPJ7I4/0+egxDaaEN1qQ5TODKbpObU3jcSKpDBtNo+C0MRyo/hg8Qi3wkl68jD6MXdZcb9Ba6XIrYoTQq1ST1/5H0yjewDbBJk4lE2e4R614BttMz+rZUB0rbkxwDKnDrKp5rqhYoTK+Sqi+sKkPgjKsYiSvBAO2yZMrNT/qAY4wrXFlc18OaDwVOGGDSgW+hKkrsNnVtfCMp/5SPyu/0aXZLDmDP5+kusyXPSt2idwTXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpPjnFB/8FacUG1eI10JHf0h8Bmlxmd9Ihd39FY+AsQ=;
 b=YU0gNKVv8gELJ1pxCGz7jW14VvL+unKw5CKWjnJf3xpwJWWecVgIGH3vdP0DDSmre1vN7zJD2AJj72O4h3FkB5InWCKP+Mq0vNKJiPGShJj6ZbqeK5CXeTjJ9kQNiNQ3cT09pacvA9WzoqmRMSyI+Edt+P2dU9GnFIULo1IjR8EPDLenGRXzaqfbk53WoQ2oGsYMQhIZE4sUSHHIbGG9D9gnAY+M00FPzplaAJuN4R7ePWBazCOjKuWSzeskEbouAJnnJMPO85vpovcdNaqS13CRw2r75n1d+y+dB1CbNQNrY9D2bdmm4bG1T+aK1Zl+PSWCJbAz0BUwS7HwtKbK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpPjnFB/8FacUG1eI10JHf0h8Bmlxmd9Ihd39FY+AsQ=;
 b=VnlJkYcSfHtxzvMcFAHOCKmDKPARv1pip2VvHkJxsp9HYXqm/1E44yetpMlXh2oKYafLPHm4AQeLuwwxgQ6DvRZTU+TrUvIxBFV9LX99Kja032l2qVEnfEJ1wSuvXoVv608tO144hDbgD48JhCcI3KkbJuoDklCsGtOMcsI1Nok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 05:42:03 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 05:42:03 +0000
Message-ID: <cc0050ba-0eff-fead-f739-b1dda011cd25@amd.com>
Date:   Wed, 23 Nov 2022 11:11:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arch/x86/events/amd/core.c: Return -ENODEV when CPU does
 not have PERFCTL_CORE bit
From:   Sandipan Das <sandipan.das@amd.com>
To:     Liang Yan <lyan@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221027133511.161922-1-lyan@digtalocean.com>
 <Y1/Gvs0xkk/W0Nro@hirez.programming.kicks-ass.net>
 <a9677c3e-1f2b-a18f-97f5-9cc1a216ed9c@amd.com>
 <f5793630-f13d-42d3-c045-276311230682@digitalocean.com>
 <923336bd-9669-88fd-9c18-159f2b6c4b00@amd.com>
Content-Language: en-US
In-Reply-To: <923336bd-9669-88fd-9c18-159f2b6c4b00@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::7) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH0PR12MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2906da-f00f-4c62-133c-08dacd15729b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWWfYF9eef+7IqmrYhT5sRT32L/D60exDw9DVDzGKLY9zTXgYFk8QTnt8dpyNRimgl5VEsUBS5vjNhC0p7aW/B4eJ1aHNY8N0EXmN+IOJiavdFdCCF8txvD2wGpiJifgh+eL7nu+oSYJKaOp8GCI/NPMx4E5AXqfd+fBVMMDTS+YB0S14t4I9hWWP7Fb8CEdmQ3tE0SNe+xkwpB7+PrUl7nil7HhYnTOYXduoAvL58PpA3eyDCercVMsImrFUxjjMuKikgtlmXMhOS7kGI9iB1yTznbFV6iK424PE9qxw79xCobZ7TTBGDdMjJwFj2KQbfl77r/tI2ytZpmPZ0DusP/6eKog5HGvPYw60HDpmui5zOJ0KOoUjZ54KcI5toRUK2LEK1i/OLGFqPU9FpCSCSTkAGQsDOtIclKQT8HWqFmxAzxVIAX/gC7/3Au/pYajwjZ6VUoyUydixbvy+0IMetQDdosFubjnbPhGTrj46VX5uN0N0Yh3EeJ6tmN9KvjIAVwe6fR5EFqAo6tXvyCfg+R6QYc85u6dP60AIx16bnJlJwqFxf68zEipdAv0YnZhPw7SqcWkd4xGhyYmpZDR/17txdko9QxETh4NbRWagt3UknIluTVHiIyMfQ97YNkNgXtL8Cx0JosL5S85p+QONYCIGk0qbpVz/qUO5Oj9Zs4n224fWIls78zWTdFKu9DqFi7i4vQJ+stBrdLkHao4dMgf+iAj7clv3hUD0eRCMDcBmQA2Lh5sobnccg+coo6H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199015)(31696002)(66556008)(36756003)(86362001)(2616005)(41300700001)(53546011)(66946007)(5660300002)(66476007)(186003)(6666004)(8676002)(8936002)(7416002)(26005)(478600001)(44832011)(6512007)(966005)(316002)(6486002)(6506007)(54906003)(6916009)(38100700002)(4326008)(2906002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L05Cb3BPYkw5UldBVzYxalFFVndYYmZQaHJsaHJNbE9KWi82N2pFTmY0aHBI?=
 =?utf-8?B?ODZxUUp0UFVCOFFPTWRXMUxvUmV3QjRxSWdqdEVFeTVBL1lXS2ZxMHBremtX?=
 =?utf-8?B?S3pHYjhvekRVRmpBNFhNNk8yemx1UnZOeXhrMGMxZitveHlweEtDcUozU2xY?=
 =?utf-8?B?cVk5R2x6WGc0YXAzVXc5L0psaXdCdzBhWW5Md2YyUm04akNWTFJPRHJYRlN3?=
 =?utf-8?B?cUpCK0ZEMUdsNDFSdkE1aTNpaHlBNDJwV0srUE5LNUFyVkRnMUh4eXVQdHpB?=
 =?utf-8?B?a2J5TFVJTU9wY21oVGFIV2RQL3lvN2dXWjFSMWZZb29WeGI5SVNXclhYR2pF?=
 =?utf-8?B?blJvdzN5cWdLS2dUQ3p0anh2SjBaMUV6by9JRitKOUFxb01yUWo5OVBITHRp?=
 =?utf-8?B?V3JOdllSNHBoQ2NLTnNuTnNGMnAyckRETE5FQVcvWmh0UlFERlUydnZraU1O?=
 =?utf-8?B?dUhBWVVEMURMcXZCcUoyTmlNZnZxTVJ2Vm9EZ2tFWkE5WFhMTHZhdFBpQUVH?=
 =?utf-8?B?QlpYZndqN3VlanhCV2xBUDYyd1Rna0tvYjVrdVdiRkZzbmxmK3hzRTBZbzdU?=
 =?utf-8?B?R01oN2lLbmU1MVRyNC9vVitsR2tmN3ZPRDdrNUhQLzV1bm5uRGhTeDllTlhk?=
 =?utf-8?B?aGQvdE13cFNiYTFkN1RDSUMweHRYNzR6VnMxS1RuUjl1WklveFNiREpYRndz?=
 =?utf-8?B?SjFJRDJ6NFZ6cjkwdWswRDZlamJFY0w0MFVhbzRQY1NlK3p3Z0pkRjlNSWF4?=
 =?utf-8?B?NmtLOW9YaEpiYnBOT0t5eTVxQW5xbXBQNkFqNEo4WE56U3VzU1JpZ0FZcnJX?=
 =?utf-8?B?NWxWZCtRYlJ0ZXFDeWFZTTltVms5RWJsS24xVlhHeE40YU9GS3k4ZHhsOXpr?=
 =?utf-8?B?TFhUYk1GbFQ5MkRiVjBjUEF6MHJnbnZ0UkM3ZTdGazh2SlR0U2NqaFhqSHQ0?=
 =?utf-8?B?RWZrM1Uza0lzUUdvY25NQlVFcTkyQWg2UnRnUGxXbzBFZ0hKbEcxalFnRlQ5?=
 =?utf-8?B?aUJGT0dxTW1BTDNYRGI0UDRwMVdwc05VNjdyNlc1UDV0MWhoVksybjQwcDRw?=
 =?utf-8?B?dy9Dbm52WXgrTk9PVERJZGhnTHRCS1gxbzlQSHZUZ1hHbmE4d2lNQnF6ZHRJ?=
 =?utf-8?B?Y216QmtuUkZMamlYWXNpTGdQcW93QzZuR1YyYzhBaHpvTkd3bS93YVZ5bmJM?=
 =?utf-8?B?eGRteTF5a1dheHhxSGxXQlMwdHVuZnR3NERsZEc0TlF2K2w4czVTYUVFWEhk?=
 =?utf-8?B?VlNEa2tCc2lRdlRNSUw2TkM1RlU4TlNyVFV5Sys3Q3pKanhjVEZUREtWQW1k?=
 =?utf-8?B?ZmdTNVY1VzRWc2VnWU1ybVdmVUdEQkNHRTg2cEdCZHZ1ZmJiekxPVklZcER1?=
 =?utf-8?B?ODhRZlRPc0xCbzF6ekV0WldMdVpFSGF4bEJhREtjM0dQcTZPSlE5UGhCYlBk?=
 =?utf-8?B?Y1JyZnhVM09QOEFxSXlKVkYxR2NNNUFBRmtVTjJlWXpyUkM0b01UenJxa1Jq?=
 =?utf-8?B?akxpcUtpTzhpMEd2Qy9tNkJHL2JzNHNVeUk1K2pvOGdVMmdnRUxscjA2M044?=
 =?utf-8?B?V2kzNGhIK0lQOXdjdU5razJUZS94NFZPTmhIdFBZRWwyRGVwMzRwMDI1MTlL?=
 =?utf-8?B?TXZHNi9LbjhUYUhLWnRhNGdyK3BIbVBwMlFvbE1CSVlBU1hNdW1pRU0xUGVO?=
 =?utf-8?B?eVRUUGRhN0ZOOGtMTjRFWFphQ0tqdHlGWTdQYVNsblVOcEdGOG14ZW1Qajh3?=
 =?utf-8?B?ZHlHZTMwOU11WnoxRmtOZmN3NmM4a2UvWENoTjJLQUgxOVM3a1VLYWZMSlVu?=
 =?utf-8?B?SnhVUmhMOSs1SmlNNzFzRHRHbW04cEFPcFZlOHUxTnhjdmRqbzhpMkVlUzZa?=
 =?utf-8?B?RURKczJjQXgwU2JRNWVCWGdycllWN2lkdHhzcy9aeUdrWkFTb242dFlveFpL?=
 =?utf-8?B?aVFZaGc0MjIwOEdCYU9SL2RSV01PWitLOE9UOEdKakhuaDVaU0sxZXB3OEQ5?=
 =?utf-8?B?WGZndll3U1JEVzVKVXltRHVQUnB5VEVUT1N1RURkNW1yVWQ3bVpHK3dXYzU2?=
 =?utf-8?B?V2Z6TU0zMHBkZUFmWGFvY3VWZjhWSkpQWjdRQVFqR3l1M0haQkpPd2RGV1VQ?=
 =?utf-8?Q?Z+kN2OICnw5kQc90w/lCa7zw+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2906da-f00f-4c62-133c-08dacd15729b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 05:42:03.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so+FNkx11ZBuV8chML64l/fyXHphBfxAiez/wh8V7Nl2lQBzBYBB4g47gHiyDeezbbLRYbY2pyREx401Ujy99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2022 4:22 PM, Sandipan Das wrote:
> On 11/13/2022 4:03 AM, Liang Yan wrote:
>>
>> On 10/31/22 10:28, Sandipan Das wrote:
>>> Hi Liang, Peter,
>>>
>>> On 10/31/2022 6:29 PM, Peter Zijlstra wrote:
>>>> On Thu, Oct 27, 2022 at 09:35:11AM -0400, Liang Yan wrote:
>>>>> After disabling cpu.perfctr_core in qemu, I noticed that the guest kernel
>>>>> still loads the pmu driver while the cpuid does not have perfctl_core.
>>>>>
>>>>> The test is running on an EPYC Rome machine.
>>>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# lscpu | grep perfctl
>>>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~#
>>>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
>>>>> [    0.732097] Performance Events: AMD PMU driver.
>>>>>
>>>>> By further looking,
>>>>>
>>>>> ==> init_hw_perf_events
>>>>>      ==> amd_pmu_init
>>>>>          ==> amd_core_pmu_init
>>>>>              ==>
>>>>>                  if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>>>>>             return 0;
>>>>>
>>>>> With returning 0, it will bypass amd_pmu_init and return 0 to
>>>>> init_hw_perf_events, and continue the initialization.
>>>>>
>>>>> I am not a perf expert and not sure if it is expected for AMD PMU,
>>>>> otherwise, it would be nice to return -ENODEV instead.
>>>>>
>>>>> New output after the change:
>>>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
>>>>> [    0.531609] Performance Events: no PMU driver, software events only.
>>>>>
>>>>> Signed-off-by: Liang Yan <lyan@digtalocean.com>
>>>> Looks about right, Ravi?
>>>>
>>>>> ---
>>>>>   arch/x86/events/amd/core.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>>>>> index 8b70237c33f7..34d3d2944020 100644
>>>>> --- a/arch/x86/events/amd/core.c
>>>>> +++ b/arch/x86/events/amd/core.c
>>>>> @@ -1335,7 +1335,7 @@ static int __init amd_core_pmu_init(void)
>>>>>       int i;
>>>>>         if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>>>>> -        return 0;
>>>>> +        return -ENODEV;
>>>>>   
>>> There are four legacy counters that are always available even when PERFCTR_CORE
>>> is absent. This is why the code returns 0 here. I found this to be a bit confusing
>>> as well during PerfMonV2 development so I wrote the following patch but forgot to
>>> send it out.
>>
>>
>> Hi Sandipan,
>>
>> Thanks for the classification.
>> Do these legacy counters belong to the AMD PMU property from a VM perspective? I mean, if I want to disable PMU for an AMD vcpu for some reason, is it possible to disable perfctr_core and the four counters, or is this not logical since the four counters could not be disabled from the bare-metal level?
>> I asked because I saw 'pmu' could be disabled for Intel and ARM, but it seems not for AMD.
>>
> 
> From what I see, the four legacy counters are not tied to any processor
> properties (e.g. CPUID bits). Disabling "perfctr-core" only brings the
> number of supported core counters down to 4 from 6. So guests exhibit
> the same behaviour as bare-metal where the legacy counters are used if
> CPUID 0x80000001[ECX].PerfCtrExtCore is not set.
> 
> The "pmu" property only overrides guest CPUID. Hence it is not possible
> to prevent the discovery of the legacy counters using that.
> 

Following up on this:

KVM has an "enable_pmu" parameter which when disabled can turn off guest PMC
access completely.

Here's how it works:

Upon setting enable_pmu=0, the PMC MSR interceptions fail. The SVM code also
takes care of clearing the PerfCtrExtCore bit for the guest CPUID (see
svm_set_cpu_caps() in arch/x86/kvm/svm/svm.c).

During PMU initialization, check_hw_exists() from arch/x86/events/core.c tests
if all the required PMC MSRs are accessible by reading them. For a guest, this
fails due to an exception and stops hardware PMU initialization. At this point,
the guest kernel continues with just software events.

>> Also, could you please list the four legacy counters here?
>>
> 
> The MSRs for the four legacy counters are:
>   0xc001000[0..3] known as PERF_LEGACY_CTL[0..3], alias of PERF_CTL[0..3]
>   0xc001000[4..7] known as PERF_LEGACY_CTR[0..3], alias of PERF_CTR[0..3]
> 
> You can find more details in the Processor Programming Reference (PPR) that
> is appropriate for the AMD processor that you are using. PPRs can be found
> at: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
>>
>>
>>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>>> index 262e39a85031..d3eb7b2f4dda 100644
>>> --- a/arch/x86/events/amd/core.c
>>> +++ b/arch/x86/events/amd/core.c
>>> @@ -1345,6 +1345,14 @@ static int __init amd_core_pmu_init(void)
>>>       u64 even_ctr_mask = 0ULL;
>>>       int i;
>>>   +    /*
>>> +     * All processors support four PMCs even when X86_FEATURE_PERFCTR_CORE
>>> +     * is unavailable. They are programmable via the PERF_LEGACY_CTLx and
>>> +     * PERF_LEGACY_CTRx registers which have the same address as that of
>>> +     * MSR_K7_EVNTSELx and MSR_K7_PERFCTRx. For Family 17h+, these are
>>> +     * legacy aliases of PERF_CTLx and PERF_CTRx respectively. Hence, not
>>> +     * returning -ENODEV here.
>>> +     */
>>>       if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>>>           return 0;
>>>
>>>
>>> If this looks good to you, I will post it.
>>>
>>> - Sandipan
>>>
> 

