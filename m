Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D074728F9E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjFIGC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjFIGCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:02:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3395C13D;
        Thu,  8 Jun 2023 23:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXgmGPN9n4RrIuZTC9GlLiDjvfMm76WEF+gj02xqFpnUQnoADNhKkISXI2bP0fEFum0ueu/6DWZ3WjYKF5ycn6b8Ch0gA95i87GcQEBvG7fCjkvB+QYLSorkCWB/0iiduMUt8NQs/tUD31IOjVDLGKOm2nKuwyJcHp2Mr1258As9L1+fmlOBb0owM1tiyh+sFAGWf5hXYoQQCsyDU3gvSiiCDbxxLZgY97SvPDYekisdMcxjllMcaP10D9eb/nK30IgmaAcxMCAb0jXvgictInPuNFcS/OqDj29GE0zjHYVMfLDj5wmK8m2jEj2xrkcU61z+s68kNC5Ie0B8mAAdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcPYhJZ2FVjFIHDXICuKBat1K5L0/4fSxzPQIvJ/tn4=;
 b=UxV8CxUi/9sNKMzE/OWWv2ANBP7c5WX1xTW1dPmzHnCK9baxTGhGm3USuD5pUaMKoGz4CYZMT8n4XGUNC4ifv76MWbnnPDWwEiMmCNI+YZY4I6+LzuW79x/gY6rt8sAImvRr1ll4HKrMLUMtgpn7UECnkNSBH0WnS0FCztPyG2j9wijCZzv04eBt84KBnosMmxnBHFjk8ZVHJjKiQ41Bbz8aHWc/CmZtzM7dpOXqKhwyQNuOxN9aPRkn5gBaRFOP98PB5PsgRopyJDk969HDjxCcL8hzWdJniMzaJ9218EsAGhrzmXRHeLiH9kGYpMSO5wFLduuIma57u1E4nIvj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcPYhJZ2FVjFIHDXICuKBat1K5L0/4fSxzPQIvJ/tn4=;
 b=r4bkFEl+RTwm0v+QVCstAutSXCJwqB2BInAA3a8FM3hZVIIHRTkl3aUVcN89q6S4h2YI5D6YxXY2vou8vysimH1QxTyzCkD8ivd/HN+OwfjcY7QJJO1AEDvdXkHYLFJo1qISbj8ciDgv0Fd+N0lSWlZKd2VNmqqoZCGLjwFibro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 06:02:47 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 06:02:47 +0000
Message-ID: <14b8d80e-9289-969c-7d9e-e9a94d85dee7@amd.com>
Date:   Fri, 9 Jun 2023 11:32:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 28/34] perf pmus: Split pmus list into core and other
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230527072210.2900565-1-irogers@google.com>
 <20230527072210.2900565-29-irogers@google.com>
 <b8efdc75-253c-ad88-f82f-90c626a26592@amd.com>
 <CAP-5=fXg-4NWOhOoTCfNm3aWp_rd6PWcq5NyZ7xwinbuDPUtZg@mail.gmail.com>
 <7c7d9279-25b0-328e-af41-66c2096febaa@amd.com>
 <CAP-5=fUPYjG2J-bxcBf8h1JW34FGQwEbSo4uDbbi+GTGmvGMtg@mail.gmail.com>
 <8a642886-89e0-b43f-d7fb-6831519ee62a@amd.com>
 <CAP-5=fUOPWd51gihOtytS6-FvTt6jnMGFSA9nsfmGYMSN4E21Q@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fUOPWd51gihOtytS6-FvTt6jnMGFSA9nsfmGYMSN4E21Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c612b3-d478-49a3-a44c-08db68af2634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAdRwWzREgf1KP6TbyDG03LYYC8A7Q5eY0wm5St/OpZWoVSICmmV3vdWP3rMKU8ocb35gIXd6lYs1o9PEu5LqAQ4Fz0yszbiZmE9VT6xjBhNkXPcP4/NJnQzUAN7XV0BYQfRT96e2WK4oymIQOmv7eC/GiZ2/BsS2lQe/kqPUy+/CLpPXrzjnTlBVgjvJexSbqm6bAXo6IdXMa1nSDuMZKgfybIf7Yb0kzlF6JNQ+txd0tR84CMGStoyXAgENIQk0Je3dWkUPxFKT34xQmTmTRIhX9bVJXLgZW8j8l43c1frIe7S5VzVnxfe3V8sdYO4eJeI6LuwM+FmX8BDjfx/TvIlSgNiINpzmMZAgQZmlXcrx4G7/dHH95HzxwVSQYdwXulUSYV69yuLrVYiBJFLn4HnFi9E8zT6Hp7j4xaTPrnSDqR+DxLUt74xM+px4ceVz9WOpRUlSQouLZnjGxgPeuix7XC5fXkuTHgXH+im/ZkjZVRQdi0Wo1LvlZmj7N1LbabD0Pj+BK3L1ZqTjE1fEE+wR2kI3RBCvx6QH4e6loZEGByQSWN94mdgHuSYcANJUUGBZGF+xQAZ1oDWlykhg0dNFC6J1bgR1OYyycoI1pceUiuhBFJunoSLqxsEuXldaR5uTouf0oAgxaY6TEEMhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(5660300002)(83380400001)(316002)(2616005)(4326008)(66556008)(66476007)(36756003)(44832011)(54906003)(16799955002)(38100700002)(7416002)(6916009)(7406005)(66946007)(478600001)(86362001)(6512007)(6506007)(53546011)(31696002)(26005)(8936002)(8676002)(6666004)(966005)(41300700001)(2906002)(6486002)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXE0VktMc0dKa2ttZ3MwZGxucVpwVmZyd3hrQ3NvYkw3VldFeXRFYjhhQWtj?=
 =?utf-8?B?enQ0SDhZVGRlSzZycGQ2VDVZeTFPdlRJYm9Nek9JR3RHNHFVRXVNZC9KczJJ?=
 =?utf-8?B?Vng4WUtSSDI4Z1laSGlvSFkvOTU5V2Q2NUhScUZhUmZSM2lXVSs5SmdvOE5h?=
 =?utf-8?B?dlFjbi9UT3d6UG1yUEUyekoyL1BWMUNQOHJPYmNleWxWYStCenNnVnN4TFQy?=
 =?utf-8?B?VUZRMEtLZVlXT1lyNjBDOWlQY3p2TWZCVDNhWUdoa0c3SUY2QzE5YUFNaXlF?=
 =?utf-8?B?cDdsWVdvUHB4MUNFNDZiVGltV0hSaUVqd3JVWndIMkJFMnRvdWtMbFBjUWgw?=
 =?utf-8?B?V1hXUlp1YVZkQW14bXhyY1FMVnBGNFBDR0FqUjFXcGtad1c3alR2NmpVaTJB?=
 =?utf-8?B?MlFJRVBUYnhwSHBkZ3FkVmthYWtrdEtzMHFheUxLSC92aXQ3eW1ZL3VvM1FQ?=
 =?utf-8?B?RzNMTDFHRXFEb0VDa05WcVp3NTdrUVBIdWwraW5sTzlab1cyWXkxanVPbitm?=
 =?utf-8?B?UVMwZVdSaTZpYzJ5UWUxY3Y0TFdGSElvYUpiZkVUMDBuZklLTi9VM0FHa0dj?=
 =?utf-8?B?UVlZbVM3Z25PWXlUQXkvNmJqUUFLS1M3NW5rUnNEWndWSUJsU09XUmRVK3FH?=
 =?utf-8?B?cW9OSHpqckd0d0M3eStxMlpzY1VxSHpUOUtQWXB3YS9pakZvM2Z1Ymc3eVZh?=
 =?utf-8?B?QWwxT0RRTy9ZelZlSGF2OHVqdmxtSzdYKzF2eWFxSDZscFUxSUdpOThibCtN?=
 =?utf-8?B?Rno0RGRUdnFPVGRzZDd6OExKemcyNXExL0ZDdXFFN2J1ZDJhSE1EVWhrbmc2?=
 =?utf-8?B?R012bEgwWmxPSmZOdzY5Q1IvQXpWWW1abUJFSFVROXkyZDNrcFBsMmJXREpE?=
 =?utf-8?B?UUNiVndsVDNSbmhvenFUN2RrdUFZS1V2V2ZFT3dJSU5RVFEzUHZSSmNqQUJG?=
 =?utf-8?B?ZnBMVkgwMStUVVRacnZKWThTUVZmKy9GMjMzMjBGZ2xKUHhCdkc4NlJqRGNP?=
 =?utf-8?B?SENNU3pMeVdsbW5QU2pULzYrWWprSkl0d0VZSmcyMWo0S1BXNjFNa3JyeXdo?=
 =?utf-8?B?R1Bnblloc3hLb0xhL3lhdGxXdm94UWgva01MdVhaZGM0V2ZyeTlqQndjai9i?=
 =?utf-8?B?b2Z6VHpBTXM4Rk1Jb2JvTmk4Zyt0YkV5eUJUWjlwYXFQMTEwZFlQdlFzaFpB?=
 =?utf-8?B?N1BJMTFHd3ovTHNPYWcwUmp0YTVFN3ZJdGpIY2RnajVLVk1aZE80L1ZMQ2JU?=
 =?utf-8?B?SU1COC9XREMzYURWK3BJUm9TbXc1Q1ZCblNuQlF0SGJ4WFk3UllIYldCM1pN?=
 =?utf-8?B?czJ2MVppT3NqK0FuanZZdjlFL1VtdDRGOVR2enRJb1BqeFBCRlNGZ0VlWHdL?=
 =?utf-8?B?Rk1tWSsrMUxFMjhnd05rQytGeHNUTVBoQlhPY1ZXL3JnK1ZhV21wU2pUeG1Z?=
 =?utf-8?B?ZWQxbFdsMmFXYXZVOGc1cjFkRU9ZZnd3VnRGbGtRMlhaNy83OU1UUFdENU1M?=
 =?utf-8?B?RklVSFRYS3o5aXQxWHBMS0Vnb3dFckxBdXlLeVRkQzhYa29mY3dGa0txUUNH?=
 =?utf-8?B?ak1nbktOU24yaWhhVlZ6ZC80aTJ2a01qUWJDUWRsY3NvcXBrZWNPQWFGaHZn?=
 =?utf-8?B?L3lNRVNIVzVJMG5uMTVhcDBHaFVRbk1pTEg3L1JQbFFYN2RWbWFmWXlQbUlV?=
 =?utf-8?B?UFZCekZveFo5SXVydVFxR0NZWkhpY0Nsa2RvMjhhNXVUV3JhOVNSd09GZitn?=
 =?utf-8?B?Nis1SXcwb1JmQ2RXUWNpVzd3dmdtZGJxUHkzdStRZTNoVHROWi9TazVFR1ZB?=
 =?utf-8?B?dU53R09IOW56R3p0THdFa3k0cXl6VEtiSThJOE43cllpNDAvdGM1TGt4L2Fx?=
 =?utf-8?B?RE9pY1F1S2lEMGRPZkhGVjhrVE82RERIQzhsVE9TYmh1ckc0QWxKUUxXd1hP?=
 =?utf-8?B?Qmg4WVJXS3E3a0dRSWRDSlUvaWp0dEJvMi9JQWFGRElhMER4RGJqZzErYTFu?=
 =?utf-8?B?SWhjS3JseGIraEUzOExMbDZQWnBDbWw5NXBWOHdJQWVoNWJ0eHlLcENmcHRF?=
 =?utf-8?B?R2ZwdGljVmlibjhZQW5vWVFvYTRDcTJWTGk1c2NDdFdrNHRiTXVGUG84RmlT?=
 =?utf-8?Q?hwicTs15AWrvqFwmYeSxCfsqX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c612b3-d478-49a3-a44c-08db68af2634
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 06:02:47.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ahfjCgVjlVoLRI+bVy0Ygorw23CcLIGniopi+hrdK7/MxMdB4eHJP6iTyryxcsZVJNSIkSrXXVC+hN/RNZzJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-Jun-23 11:30 AM, Ian Rogers wrote:
> On Thu, Jun 8, 2023 at 10:55 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> On 09-Jun-23 11:05 AM, Ian Rogers wrote:
>>> On Thu, Jun 8, 2023 at 10:30 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>>
>>>> On 09-Jun-23 10:10 AM, Ian Rogers wrote:
>>>>> On Thu, Jun 8, 2023 at 9:01 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>>>>
>>>>>> Hi Ian,
>>>>>
>>>>> Hi Ravi,
>>>>>
>>>>>> On 27-May-23 12:52 PM, Ian Rogers wrote:
>>>>>>> Split the pmus list into core and other. This will later allow for
>>>>>>> the core and other pmus to be populated separately.
>>>>>>>
>>>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>>>>>> ---
>>>>>>>  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
>>>>>>>  1 file changed, 38 insertions(+), 14 deletions(-)
>>>>>>>
>>>>>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>>>>>> index 58ff7937e9b7..4ef4fecd335f 100644
>>>>>>> --- a/tools/perf/util/pmus.c
>>>>>>> +++ b/tools/perf/util/pmus.c
>>>>>>> @@ -12,13 +12,19 @@
>>>>>>>  #include "pmu.h"
>>>>>>>  #include "print-events.h"
>>>>>>>
>>>>>>> -static LIST_HEAD(pmus);
>>>>>>> +static LIST_HEAD(core_pmus);
>>>>>>> +static LIST_HEAD(other_pmus);
>>>>>>
>>>>>> AMD ibs_fetch// and ibs_op// PMUs are per SMT-thread and are independent of
>>>>>> core hw pmu. I wonder where does IBS fit. Currently it's part of other_pmus.
>>>>>> So, is it safe to assume that other_pmus are not just uncore pmus? In that
>>>>>> case shall we add a comment here?
>>>>>
>>>>> I'm a fan of comments. The code has landed in perf-tools-next:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmus.c?h=perf-tools-next
>>>>> Do you have any suggestions on wording? I've had limited success
>>>>> adding glossary terms, for example, offcore vs uncore:
>>>>> https://perf.wiki.kernel.org/index.php/Glossary#Offcore
>>>>> I think offcore is a more interconnect related term, but I'd prefer
>>>>> not to be inventing the definitions. I'd like it if we could be less
>>>>> ambiguous in the code and provide useful information on the wiki, so
>>>>> help appreciated :-)
>>>>
>>>> Does this look good?
>>>>
>>>> /*
>>>>  * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
>>>>  *             directory contains "cpus" file. All PMUs belonging to core_pmus
>>>>  *             must have pmu->is_core=1. If there are more than one PMUs in
>>>>  *             this list, perf interprets it as a heterogeneous platform.
>>>
>>>
>>> Looks good but a nit here. It is heterogeneous from point-of-view of
>>> PMUs, there are ARM systems where they are heterogenous with big an> little cores but they have a single homogeneous PMU driver. The perf
>>> tool will treat them as homogeneous.
>>
>> In that case number of entries in core_pmus list would still be 1 right?
> 
> Right. Heterogeneous platform, homogeneous PMU, single core PMU.

Thanks for the clarification. I'll send a patch.

Ravi
