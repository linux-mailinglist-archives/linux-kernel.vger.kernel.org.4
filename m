Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF9728F71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 07:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbjFIFzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 01:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFIFzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 01:55:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA130D1;
        Thu,  8 Jun 2023 22:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXjWdURWvNnoQOAYpg1naoOpEqUMLlbXgqexUeqweMsmbLFfIUCMOwpNXHIofeKysty6uW2/K+vCxkUEVGKu5JutEryDvVb3MUwhe3xGVKZjlm+uGgMA17xWcGDnfKcZ+jmT4g4iHANUSM9+5j5U+4dzKlbCu0htpFH2D/hQ/hyybIEYNlwcsZasN1zJF7zNMD2COzuQDtp8ndFuG+lVOXaQyms77MG58zpIrqfQqnQSupdLOdjNFHM1MA5m0H8yJdRjfO1d9NnHvyQkE2poGBrzqLBSfBD11Pr3pH8ZvwIGLsgNXzOuEA64BYE5rn3+dd3TfeV6FXDwS2tyBpiEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkmyWtPBvFa6VDq8MaO1+lMTsM7DxuwopT12m3mYNhM=;
 b=OW9ZRvJmSR8h3g3R94vK3hd1E5olb2xkV/ZY+J83iBmGPWyxoMyjiqpBhgaBoxXp1LyPpfU4N2tiz4MrDrXSVIxjqLV1gqsVm6W3KGPg7ZrN1/F2XTA0LXClgxOMWdGTSTH0vKmq143DLsPMgmroOzPUYNgW0APtSURqx2FMBpeqyYsF4l98koqY8swl1Rj/80knDUd7bo5K0Mm2nGmM5mCDcZbYM9P68xqopbmT/C8d7zb4Ab0eTpvSFDPGaPW9Vz4rgLFhQ5uMOJgr332B6MqbI+T7yg1BKkzely/t/MN1XwUCYW3/9qdgxRY7c/Q50H6jlooj/s8ARIz0H1jw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkmyWtPBvFa6VDq8MaO1+lMTsM7DxuwopT12m3mYNhM=;
 b=xvwa71Grun7GrjL7c0qGx+EoEaoDmaNpqtd1oyLHKG4ZqaTR3aI4vd+uwvWxibnd8ArW594dW+1rCin1HAhF4aSp2l9ZRdjiVtz7F6Fcudtmu5kfWt5YosPNs0rYT/vz0cCUPoZZMkwWMfFz/wo3/Kxel/AJIFvzvm0/su1l7s4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 05:55:17 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 05:55:17 +0000
Message-ID: <8a642886-89e0-b43f-d7fb-6831519ee62a@amd.com>
Date:   Fri, 9 Jun 2023 11:25:01 +0530
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
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fUPYjG2J-bxcBf8h1JW34FGQwEbSo4uDbbi+GTGmvGMtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 262445b6-2aa4-4ba7-22cb-08db68ae19e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeeZq0EedDpNYr6li0Ct9Rr2w3dd83I6OpjsT0MlvKsmUxvyHcYO6Fly6ikvo35ALzj2U7wPTBy+iRvNgA9UcIJ1jvdzYd74Gzh5eCf+/Ahw5w0bBx1g4VWLLGS70bvf8MaxP+rWiZNaeHgFfhE9d8uX6Xw5M7WvGLk0hlmT27Akf/s0w3/EfvKZYutilUf/Nf1PGxlRALmMbiPlAJc1geWZUvMIgnKX0yiX6R/MSBuffUk+cyNhZpmmZbCAHOypT6xByq77jot5mzSk6KkkWfgwOp4y4xSqmYvAD6rhGYUIwED/yW4VHEHIK1xdJCtLJqDcGc7nMdnEqMZIgtcTKcbMTrL3cyMak5m03aE6JAFDUM0XmhwHvQXcd98LKUHndgxnhjwxtaTZjIYyTz+lk7DvxUVtdjpn+XDyhfcCFJasMIUZU9yIcS08+fEB3SeT3PGse7IAu1WxhST/lEATni3tmsBiVakuAVNdkcVo0zdgd1P+SZVgGPY94f81C8K9dZqOIVn2BLbvPUcg4gOXErwL0GD+nmsBZFWK40AMZhgEc7xHXS0gTrZfWbmqr/vUQ103xrcuDH13WO0Ltceld7PSZiFzwkFU3LyQB79FYiGOU4sAMBYP1NwHTiDX2d0adtpv8gCKfDWT/f3UzGQXcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(5660300002)(83380400001)(316002)(2616005)(4326008)(66556008)(66476007)(36756003)(44832011)(54906003)(16799955002)(38100700002)(7416002)(6916009)(7406005)(66946007)(478600001)(86362001)(6512007)(6506007)(53546011)(31696002)(26005)(8936002)(8676002)(6666004)(966005)(41300700001)(2906002)(6486002)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2oyUjJEd2lEV1JXRklKRmFZcEd3bFdja3hod3FIYnhpcWFUSW5ydVBYcEtI?=
 =?utf-8?B?TVpDeG9qV3JIanZvRW9SWjE1VHZ0T3poOS83eFdJK0tOSUJwelZOdXE1cGQ3?=
 =?utf-8?B?LzlXTnhJcGk3YjdhUm1qZ1QyQVVzdlNYdW9ScVFWY0pwUHVGYi9BdktsU0ZX?=
 =?utf-8?B?ZStLc1hLZHU0Ri9lRTRkMVFjZ2JZY2pIT3ZneTNiTERjTUdGS0Qrb0F3d2or?=
 =?utf-8?B?RHVjeHhlWTlXZXhES04vcFhicGxxYlN0SDNTbkZXdXFsZzFqZTdzNzlscHJ3?=
 =?utf-8?B?ZjhZV2hIdlg1ZnM2SEp0N09Ib2pyTmkybzE4OFE0UGxiMlRQMDUvQndiaGtR?=
 =?utf-8?B?RHBkNjZjZDBEUnBNSEJpV2U2dExlRWJXWDdnUnIybWVkcHMrTllLL25xT2ZL?=
 =?utf-8?B?R3Z4ZlR1MXpTK3RDMElxK0t2UWlEc0NxUjl2ajFhUVMvV1hSQWVLVVZCdFBM?=
 =?utf-8?B?a2owNE0wVGlzNytCSCtPRUxNSkxubVo1UDhUMUE4MHoyVURYS3NZQnY1VXFO?=
 =?utf-8?B?VFIwS05NMkdRbGpvQlM2d3B0TWROc2NiTzBFR2JNZUltQ3ZndUJJcTV2ZXdR?=
 =?utf-8?B?SE1CbkVaRDJ5R3grdVd5eG5xQUlUdWFHT3dUaU5tTHRhMDkzUWcwZHljcnEx?=
 =?utf-8?B?eHEwL3VsMzVMd2g3eWdRMmNUcUxSaEczdnhEdkNuVnJleW5WYzhJdCtSNmhy?=
 =?utf-8?B?MVlEYjE3WEdEQytlMW1XakFXSXhra1FPRjFNWFVDRkFSN2RnWDVYbFdDazJj?=
 =?utf-8?B?MDlyZWNnci9MOC85YTJLZzRlUkdpTldpczlhTUx5SG5BV2l2Yk43eXJDdm5m?=
 =?utf-8?B?QUdlelRvazhGYUp4UjMwUFRXTllyYWEwTDVDL2IreHlGNnNkSFZZQm1wWGxL?=
 =?utf-8?B?Q0NXNVBmL3NLM1BNcWN3R2M3Qlk1eEhGbWtUL1pwN2t1ZkxURVhQcHpKdEJ2?=
 =?utf-8?B?cVZqZnQ2NERvUWFXV1dURnltOFBRNnJBNmZ0dE5tbXltYmN5RUQ2Z2l4QWlD?=
 =?utf-8?B?MnFSNURpeGxDY2VYd1lrOG44VmExRXlXRkVFNGtGZ0FhYjBZZ1kxOGJaRFBo?=
 =?utf-8?B?R2JVdFhSRm05KzZXTC9MbllxQU5TQUdQekRJTU1nV1J0eDYvbVJydWxIdjR1?=
 =?utf-8?B?UXhhbERSV29WL09TYjlJaElyc0hIMFg4QmZ3eXc2Vm9KV2RQTTRWU1hOaDMw?=
 =?utf-8?B?N3U1ZGtTRzViZS9lcHU4VmNUcmtxTHFsTkgzZnZLMkZpSUpRNHF3a2ZObENP?=
 =?utf-8?B?c2JmZ1F0cE0xZFUyZGU2YmFzaExCcGdaRDdiU3plcnRNWmVCUjVIcUZsT2V2?=
 =?utf-8?B?Mm40bnd6RGE5NDZpMkptSWFzNnNWYzZ1V3pWTFVFcWZicWxUOWwxVTRoMnpv?=
 =?utf-8?B?QkpwV0FMVFNzV01QNktkN2wxTTdtOGtpV1FPK3djVW16NnAxeE8xN1hRMUxY?=
 =?utf-8?B?UnNUNThjcjRSVEtoelJSOWlESUlVZmx0ZTJmN25tUFQ1K2FjVWlPRlJ1TjVk?=
 =?utf-8?B?LzdOZGU2N0sycmI4ck12V3Q5V3BOdnJGeFFJWElUV0Evc3JJYXI2bWlCSXB2?=
 =?utf-8?B?Ujg3b05UWlV6MzVPRXRSZG90d3QwZC8xcE9VU3hoZWk4dmtZMXJkQnNwNmto?=
 =?utf-8?B?YTFwa1ZvbExoVi9xc2JXNFcxWC9UU0lHc0RMK0pMSjQzRVpwZzE4anNjblJ5?=
 =?utf-8?B?UVdyc1VFRUZuTk1vYnU1ZEg4bml2RWhoSUlPZ2ZpN3FaL3JISTBORkhDY2hm?=
 =?utf-8?B?eHppUDNnM0hqeHpXK0MvM1hzanJZZHdXVE1YZEtCajR1UFNTYVNadFQyd3ov?=
 =?utf-8?B?SHVwOWhsWjJXb0xPYjdCZFdlS0JUdk50V3JlUStpUHhRYmI2ZHFDQ2YvUTYv?=
 =?utf-8?B?TmM1Q1hOTng0enZyeTNhdDBYVjBkVjlHOHJyMTBxa204UklRa2ZsbmxWVWlG?=
 =?utf-8?B?N3ZHbFd3amt5b1ZpMUxBS0RmQnVOSkRMVVFuQXJMeGZTYXRWeVVOL3p2WnJI?=
 =?utf-8?B?dy9IbnJJVVlFenZOTThBUVd4UHRvUE5vQ0RKdkFLNDJ5L252VGltdzZBWlFW?=
 =?utf-8?B?ZVN4NnZvMVdyQzZtRTFnZXBQU20rY0lWOFA0Q3RsclV4VUY3eUtZZGNWNFMw?=
 =?utf-8?Q?YUJYwtiJNFvgCDn2UzgkpVEqW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262445b6-2aa4-4ba7-22cb-08db68ae19e3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 05:55:17.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpBWcf3BZT9/6Rhiyui7iezgdBacUZzSuNHlB76ZiDVtAYuGSNw3qncrQjuDJaQfghn8FxGehv/rX3K9la9ezQ==
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

On 09-Jun-23 11:05 AM, Ian Rogers wrote:
> On Thu, Jun 8, 2023 at 10:30 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> On 09-Jun-23 10:10 AM, Ian Rogers wrote:
>>> On Thu, Jun 8, 2023 at 9:01 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>>
>>>> Hi Ian,
>>>
>>> Hi Ravi,
>>>
>>>> On 27-May-23 12:52 PM, Ian Rogers wrote:
>>>>> Split the pmus list into core and other. This will later allow for
>>>>> the core and other pmus to be populated separately.
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>>>> ---
>>>>>  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
>>>>>  1 file changed, 38 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>>>> index 58ff7937e9b7..4ef4fecd335f 100644
>>>>> --- a/tools/perf/util/pmus.c
>>>>> +++ b/tools/perf/util/pmus.c
>>>>> @@ -12,13 +12,19 @@
>>>>>  #include "pmu.h"
>>>>>  #include "print-events.h"
>>>>>
>>>>> -static LIST_HEAD(pmus);
>>>>> +static LIST_HEAD(core_pmus);
>>>>> +static LIST_HEAD(other_pmus);
>>>>
>>>> AMD ibs_fetch// and ibs_op// PMUs are per SMT-thread and are independent of
>>>> core hw pmu. I wonder where does IBS fit. Currently it's part of other_pmus.
>>>> So, is it safe to assume that other_pmus are not just uncore pmus? In that
>>>> case shall we add a comment here?
>>>
>>> I'm a fan of comments. The code has landed in perf-tools-next:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmus.c?h=perf-tools-next
>>> Do you have any suggestions on wording? I've had limited success
>>> adding glossary terms, for example, offcore vs uncore:
>>> https://perf.wiki.kernel.org/index.php/Glossary#Offcore
>>> I think offcore is a more interconnect related term, but I'd prefer
>>> not to be inventing the definitions. I'd like it if we could be less
>>> ambiguous in the code and provide useful information on the wiki, so
>>> help appreciated :-)
>>
>> Does this look good?
>>
>> /*
>>  * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
>>  *             directory contains "cpus" file. All PMUs belonging to core_pmus
>>  *             must have pmu->is_core=1. If there are more than one PMUs in
>>  *             this list, perf interprets it as a heterogeneous platform.
> 
> 
> Looks good but a nit here. It is heterogeneous from point-of-view of
> PMUs, there are ARM systems where they are heterogenous with big an> little cores but they have a single homogeneous PMU driver. The perf
> tool will treat them as homogeneous.

In that case number of entries in core_pmus list would still be 1 right?

Thanks,
Ravi
