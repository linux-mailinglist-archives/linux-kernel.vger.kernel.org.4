Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3340463FEB7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiLBDVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiLBDVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:21:46 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34136D78DD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:21:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9UyQuV2wUepJE/ynBGhW/xOp71FOYVvDb8CmG7f+V6c0XnPMCgygvji3zgsoSu83FvqkG+CCCz5Ma9ctOqIIkbltGKbVr8z+nXjoUGGnT7BmKdyE6G9cr6hQQ07bGuQocp1DF8X0ujLgXnCm0P/rll4O/X4xifgdg3H3s/ctkvL5fGsA9+qQnFWnvDyEjrgEBozALHP3CkIwEQSJ3q4Ao9fdLJkBtnnsDRWkBzOTSLkzBHUTfzNT7t4cIJ8EMtFi8yykAU4CFa/enGpD+OD6+4JIiS4JXEzNG2vwUDRyNtOgE5WOvvgaGZM73nbIXwWR7NxgWgbOawj+fFwGwhgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSQa0Y5ydiV+ZbfeiW50HXWlDEcw7LXdcg7ZOAES6aY=;
 b=PdwtSLdscxECQ7E+bXydcz7Ixxm1qUYgXUb0kRTvRF/oISRbsAdECE6HNkrEyn5XFf5QX7qr18mbo/MeQpN7gHA9qBObzYtEb6ULojpO5BkXsL7wGUuOz54ye60ZAVbf4vVvj+IDDQPGLlw77AEPI1qDQ7eGRhBgJxdViIXhbitw6FycPUUa+GnJDekoH/23BOxxi70Pk+3bFLUqXznrLs5rCN6vlBkJ7CxqLPOPOA23v6gP3R4CGdI1CyDVQ4jzo57pqP2ziJz8vYJp14+/uRvJ+R4rbf5deshVzoq0fWdU98wY6eengpRgrogCRZP0NRCDkOMZGtSEx69Jw2VsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSQa0Y5ydiV+ZbfeiW50HXWlDEcw7LXdcg7ZOAES6aY=;
 b=CdI3PiJAx8XBCfjolBpgnalqAQ+lSkbcUCjVa/O7CCe3tDlIo4MnC2A+Dubhfon+sACzG9iJQdtUvvhSAABeqKLtLm3BsUG3Y5XDI8CiUu5dyuNglhR+pr6riD8sYga3ILy6EFy8pVmG1ceek0IE8JSGUtPW938Mt46WdmAwAzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 03:21:38 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20%7]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 03:21:38 +0000
Message-ID: <349903d8-3951-7d85-82e4-2e32e83ba0a3@amd.com>
Date:   Fri, 2 Dec 2022 08:51:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH v2 0/2] sched/fair: Choose the CPU where short task is
 running during wake up
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
References: <cover.1666531576.git.yu.c.chen@intel.com>
 <9b639dbe-15ec-da58-9e11-0b3b76a3fa1d@amd.com>
 <Y4bV+uaqx/P4Q4j+@chenyu5-mobl1>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <Y4bV+uaqx/P4Q4j+@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 6941e003-8430-42ff-20ee-08dad41452be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTZOTjyCdPpcoyw7NgVvUgOrVSlhkq6SHcYKnc4bqbdXtQ9Y3gV2+W24jg8RPqXB40fdedQTfg7e4kmyYH519PbwaY9771oVQFKA1AYAvNJWdbVzgjI+FQ1l/y5jomH6A2MRWMroAdHFrtsrPtGLdMkdnYORX+WR0VjLI54kBt/E8EyH6LZoUsTKDW8MP3zVMuKLPNJ0AL7o1BOiz9BxYbS6BHqqkgZAW63kEPebhhqS8sCB5cuf74tbNvSdBMFvhJA9/yDJqeG4jwAIaaLYxQe/Qy79t2xGcvwpbjUIKTiV5H3ne6msHxP6MDt1Ny/EplHyUfSUjHfDIzBNRepP+uHyrpTco5ZT69DzIriUsjgPNhf0jzEXlmYfATgxrP3mxuzcbOmkT8oQboxqjOaCBBBe0PjCPfj4zR+CH6oVN289jNxiFBfwxFGth1N/EJ6yiq22MyP64jAq7jxhD82+B8go4HrR9OlQs4TShX1MRXnmaKzkl4xN+ZwS6tV/K9GxTol56EVl1CxSd8EoaYqC6i4fsmJpobsNObUTMURoXXrsaQM816CXO0gGQY10DzAwDqs1y3hiLknJkwfhzK2xqwW+Lh7W154Y8eVzsae1QPu11r+RgsasDT24TZBoCVXhQGiY+o8b+RAN6yahXQVg4vGKgotTYcAfRuAi5DQ2mTMCdjBuZ7M5mE57aStSC5fXoBWxYFL6H25DtGC0GXMTeHLMavlggKn0rAAi8nXpvxdu/9ga8skwnLxWsQeY2P2U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199015)(31686004)(83380400001)(86362001)(31696002)(6486002)(966005)(478600001)(36756003)(2906002)(2616005)(38100700002)(6666004)(5660300002)(4326008)(7416002)(26005)(6506007)(53546011)(6512007)(186003)(54906003)(6916009)(66946007)(66556008)(66476007)(4001150100001)(8676002)(41300700001)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZThlWHdqaVhXRldkWXUvUXlnZUUwS2lST1ZZMXRZUnNQY3k1UkdXTXRWZDhG?=
 =?utf-8?B?T0dINUM5MHJRbk9VY2kvMkRYU1V5UG1kdllKVUJUMTZualdhZXZ1UU1ObFZC?=
 =?utf-8?B?RENSWmVidkZ6V3dwMGkwT2d3UWFvSnNIZkgwRDF4ZjVOY0YyNWI4VkIwVGxw?=
 =?utf-8?B?aXlwbnpKSlJWeTlDamd6YStPTWs4bEZsMThwSXgwbWdyS0FRYTlKVjJnTDcy?=
 =?utf-8?B?Si9nTTJITFU0VklYSWxOWnNycldzYm9jVFE2L2d4UW5RWlJTZzNCZ3hPMXVJ?=
 =?utf-8?B?QlhkcU5OT1hvRFlZbXpMTHlMQlhxVEpndWdJbHVSVE85YnhiVlhzZUJYTk9i?=
 =?utf-8?B?c0JHOWZBZ28xY0RyU1NuSFU0M3JmZXNGOUZxRE9JOGtqbkk5YWVIOUxXY1pD?=
 =?utf-8?B?RGVCaER6Vlh4dW1oTjdlMWRVekRIdWFaanRaeXZkUWhZMXlLNmVaQ0RqYlBV?=
 =?utf-8?B?WjdvQzE5Tjhodk1nUXVQU0JNdC9JaE1YRUFwZm5xMEc4QUc2cytXTUxNMkpX?=
 =?utf-8?B?UEVZY2NTTnRSVjRWTHpVOTc0OUs4TmExQVhkMDgyNHVMVGUrK2tLOUlia2FL?=
 =?utf-8?B?TXUwRXFaQTJWQlh6OXhGMXd3YzZIclNENGxnWW83d2RncnBuaGp3eExlTm5h?=
 =?utf-8?B?VmpYSU9paUNqdXN1TTBPUG9YUmQydU9UeW9Ia0NqSlowK1IrZWtPTkNNR2w0?=
 =?utf-8?B?WkZybm0ram0xZElZNGcrSnJ3QlBJVzlxNzJVMnNGaWxaVkxnZWkrYkNvN1Bh?=
 =?utf-8?B?RC93Zzc1SkFkdi80Y080YlFXVUJhZ1dMR0JOUG80b2FzQWplc21KS2lFN0tB?=
 =?utf-8?B?QlEyUFV0TzFMeVp0aVZjNUQ4bUVMbkdYcUVBQktIUjlGa2dxQlhFdWpmaURT?=
 =?utf-8?B?V0o0ZFhlbUt4RzZtVCsxbWFqMExpYmZ4SjdLVkpjSDFERUdDUVBNS2dYcW1X?=
 =?utf-8?B?MncvRUJqaVBydHQ3NmlUZUIyRkZrMCtsZWRkbFJoSFdtaUxQNjlWQm9tb1ll?=
 =?utf-8?B?ekI2R3RqUGFvVDNBUWY0UmcxVThkRzVqTE1QQUczMlFNY0t5UlZSS3kzcmEr?=
 =?utf-8?B?MW9rMlFEbFIzREtDUTB2NzF1LzFlWHNsSEVUTkR1V3JrRTBwZnNxVXBPVVVp?=
 =?utf-8?B?eGRVZTFQTlJFbFdLekhxN051Y20xUko5QWNxM1VqanRsVGEvOEZabTkzZW1y?=
 =?utf-8?B?b2VRZHZBOVJQc3QxcTFRQ2Fyd0VMNm9pTWM0UE1WNHBaYWE0NlhQVm5zVFh1?=
 =?utf-8?B?RjlHZG9lZ2llUjNPWURmWEtJbTdGZHpzaWhNVDJzZnJYbDd3NDVCZ095N1NF?=
 =?utf-8?B?SzUrTHd1aERpVG5CT2l6QzgxbTBDSE9QV2pLNDRlYk8vVklsNXZXOU12MjU2?=
 =?utf-8?B?ZjB4djBqRnRLMFNsRS9pRnlxV29ienFUVkQyclFXRVU2SVJUUzNSbVFKOHow?=
 =?utf-8?B?cXdyWDRYWDljTVRtbTRTem5GMXRnTU9ySjNyUm82UTZsTm5kNWRTTmhWV011?=
 =?utf-8?B?TjlneWlsSU5zMUtFelBacTdPRGxwSXFJOXdLcmJ1Y1ZReURrbUpVOFB6OHNI?=
 =?utf-8?B?SFhQSkt0eGkxWGF4c0hscFJHdnBHclRsTTc4bmJmT2IrZStUR1N6WEQvVG1z?=
 =?utf-8?B?SEJnand1WW9HVkU2OG9PemVVL3FVN05uM1BGcXRNSVdRcmxpeGh5cyt5cng2?=
 =?utf-8?B?eTNETFBXZHN2eEN6SEtVaG5aWkxoRzMzR1ZVTnduUHlmcUVPMkFkTUNvd2M5?=
 =?utf-8?B?VW11LytQclUwUU9PVVB2UnpzUEhLa2pWaTNBODdGUmNtY0VXUjlKRlYxSnlQ?=
 =?utf-8?B?RlgzbTdTdlBaZWIxYUw0bXJWRGt6RFBpRTQwMjJpOW9UaUdKZUZ5Ry9BcnVO?=
 =?utf-8?B?VTNQR1Y4WEZWYThMamxIT2FDSnJXTDRQRXRqRitwcmZabHg5ZjBvUVJuMjlD?=
 =?utf-8?B?NDRjKzNYWmFlVXIxeVppemdxS3ZUU0RLSGtvZzJQTzVQamZ2dmpoek1PbWlV?=
 =?utf-8?B?dTJNSEI0UFZVZWlEZ1BoMXl2blp0dWJhYWFtVnliRVFucW5Zbkt0YUlQRE0r?=
 =?utf-8?B?YnVLVW15Q3B1TDZPUWluRk9MdW5qNGJIdWNueittbHF3Smx5TDR3UTdFc2M4?=
 =?utf-8?Q?CCEDWNp9NwGoahF08U6cCHJ6k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6941e003-8430-42ff-20ee-08dad41452be
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 03:21:38.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtCXUjnfKJORvn5K8Bfdvy3AawzdSEVw0zn5RVvnFkGqJS34bMw4LCXMAzsBZvPCkDnBcWSrallwsfv2b8laYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 11/30/2022 9:33 AM, Chen Yu wrote:
> On 2022-11-22 at 16:01:42 +0530, K Prateek Nayak wrote:
>> Hello Chenyu,
>>
>> I've tested v2 series on an dual socket Zen3 system (2 x 64C/128T) and
>> the results are largely positive.
>>
> Thank you Prateek, and sorry for late response. 

Thank you for taking a look at the report.

>> tl;dr
>>
>> o Hackbench results are mostly similar with tip.
>> o schbench sees improvements to tail latency when the system is
>>   loaded in NPS1 case but I do see one small regression for
>>   128 workers in NPS4 mode.
>> o tbench sees small gains in NPS2 and NPS4 mode
>> o Stream and Spec-JBB results remain same as the tip.
>> o ycsb-mongodb sees small gains in NPS2 and NPS4 mode.
>> o unixbench results see small to moderate gains overall.
>>
>> I'll leave the detailed results below:
>>
>> [..snip..]
>>
>> Note: On the tested kernel, with 128 clients, tbench can
>> run into a bottleneck during C2 exit. More details can be
>> found at:
>> https://lore.kernel.org/lkml/20220921063638.2489-1-kprateek.nayak@amd.com/
>> This issue has been fixed in v6.0 but was not part of the
>> tip kernel when I started testing. This data point has
>> been rerun with C2 disabled to get representative results.
> This reminds me that, previously I tested with Cstates > C1 disabled, and
> with turbo disabled, so as to mitigate possible deviation. May I know if
> all C-states and turbo are enabled in your test besides tbench?

I do run with all C-states and turbo enabled with performance governor.
I can do a parallel run with C2 and turbo disabled to bring down any
possibility of external factors affecting the results. In the past,
we've seen some issues come to light when running with C2 and turbo
enabled so I had stuck to it. Thank you for pointing this out.

>>
>> [..snip..]
>>
>> Except for schbench with 128 workers in NPS4 mode, I do not
>> see any large regressions for the above workloads and I do
>> see small to moderate gains overall for most workload, even
>> the larger ones. I'll try to get data for more workload but
>> overall the idea seems promising. I'll also get some numbers
>> with the changes Peter suggested on Patch 1.
> I spent sometime to dig into the issue which motivates me to propose this
> solution. And it was found that this issue could not be easily solved
> directly because there seems to be an inevitable race condition window, with the
> increasing of CPU number, this race condition is exposed easlier. So
> current patch is an indirect solution to avoid that, I'll send the detail
> in v3. 

I see that v3 is out. Thank you for the detailed explanation and the
visualization of the bottleneck in v3 Patch 2.

>>
>> If there is any specific workload you would like me to run
>> on the test machine, please do let me know.
> Thanks for always helping us to test the patch, I'll send v3 once I get the
> result and we can discuss on that then.

I've queued up runs for v3 with the same set of benchmarks reported
above. I will make a point to include results with C2 and turbo disabled
to reduce external variables.
I'll share the results on v3 in the coming week.
--
Thanks and Regards,
Prateek
