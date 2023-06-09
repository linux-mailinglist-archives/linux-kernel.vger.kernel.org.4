Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEED2728F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 07:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjFIFax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 01:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFIFau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 01:30:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C907E4E;
        Thu,  8 Jun 2023 22:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCDCgYYcC80NSi/g/Kvr7Z+EL42BfQWuiOLNopAYvrTjDEm2QD6NZXdw7NY9jCvCUnQimKnFO5zb5qLO+pLpvx1TfMsHqeIo1RhyFM4Uq/FRmukcbBokoBR3A0Vd3Ueb87exx87kF4Ow9i1xjVcoBNQzzap1y1FXXz09ggwVNY609GAfKTpFuqxx9wQQ0RsJLD0h038Fqq/tUfZtZyzlu8SOtD5OOtK7TbhSBiU1hN4Sqa6htb/7R0SMVn0aNjropIQnczzNlxJEQemh8xK03JlCEuUd2rsiF5obZ3L2eustgSECYzLtkFTIdG6wS7xPB54dP95beHIIb7FRJFLFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULSyCCuYi9vs/qlEogmlmiqgZGb3rgD82dGnmVeb6Vs=;
 b=RaaTFXrsBubRDPPdivHBv+sFsQybLgTymGGvF+7wAPRnddFi3r+qTmzYuolFeFuP4qOftUxNGzc4Z17w0TZRhOjmszGHMBtZi6vq8uf1QJwUJetGdEZlwXpj1VQm3A32khoIFGqXmtH9BfA53QjJHOsWKkcfc7M16A+BMtkohGA3uitUl+SYBQMNQS7WiisILBJ3IbH+0aGsv2jXV5bzofS1q7G1ULIW1JovWdpn5vNvUgXG4iA7EO2j/dT4nIYm05SwOLFnejVgq6qqUeb0/+7WNIWcuwLw3dNSsUGW3IBkL2U7+vF+dgcfnWPJCSMvEZZoq64wUuUNcW7CJdDuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULSyCCuYi9vs/qlEogmlmiqgZGb3rgD82dGnmVeb6Vs=;
 b=GowAsD++Urh1RqR3m46ce09AOhHp3Y5fOtGT29/DG5nLsEqoGAuCcJvvEn6J/KLPj1KEug6HYqNlvOy8/ZUekBytr+qPKLXPbpBRlJ8nbbD+MglsiLcow/7+0POEes6ojbITtO2WDty4MvGn/Bnk4iRttb+u+WikaL3/nf+03mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 05:30:44 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 05:30:44 +0000
Message-ID: <7c7d9279-25b0-328e-af41-66c2096febaa@amd.com>
Date:   Fri, 9 Jun 2023 11:00:28 +0530
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
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fXg-4NWOhOoTCfNm3aWp_rd6PWcq5NyZ7xwinbuDPUtZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e30617-3fe1-4c49-8242-08db68aaabf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESt6fCeJPkK3OxAbfGT8Z1ZzLFif/d/Q24GX9uZ+X1y/tiLs0gK77KSKv5d/twBAMBNNyy7MEH0zxVjYR6+LpKWSWdMuzx20fJwyalrYXjiglr4r0sr20owRxMBIyEFqTbDF8SWm9Ia+EbpfIV24+y6uiCT932i78pp2DzWUhyVD/G7bOdaMw3bn0HtP0ZtebQLy6OIo9FZ6cf4dGy0Y589PvJq0PKsFXbGWKXeqSkMJHibDGd1gNltavbF1GKSou5x+46dzOc269jhRF6G/aBC+nkv/Woc1ViGrmwn7z0GwDBn3R2weOCtpTfoDE8eHAJ9N7mDWE71k8JbP4ps1EoZaYu3RDlk+EqzXwxlljLgLCXICxtGxp7O053guNvmi4wgEIhmxEYS/lTZCiYqmO6dIfPq7z9d+4sOS0Q1VkusHDyDOVqAEiW2a2o7BhyVXmdsux9X4t9ZFbqT36GuOn/XwuVpTiY3/u5TjqNaeSFfeHlJPhgZADwJ4VgaxHoVfATuUljLRijKMBBxpGnPl/5Ug1JGroaqU2O6upxHwyLB47VbIKC4yosm+3gQAyRn5YfIyUl1b3+go/d9aP1qOasD9fOX6JfiP0A/FFpTSZiV9GcMe2UXnWVIfZ0WSlazod4EeCJ4YpoqLAsrzIoc/Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(6512007)(6506007)(53546011)(26005)(31686004)(186003)(2616005)(966005)(83380400001)(6666004)(2906002)(66556008)(66946007)(66476007)(16799955002)(6486002)(7416002)(44832011)(5660300002)(8936002)(38100700002)(7406005)(8676002)(86362001)(31696002)(36756003)(54906003)(41300700001)(478600001)(316002)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkVJcUwxcmlZdWxEd0ZUeWt4UVFjZEl0OVkxSisxQmxuV1B1RTd5dG9BeFRo?=
 =?utf-8?B?dGdGdzJrWXE1M1VqdWUyWU1WbWFaM0VHZUMvMHpYSU1HTzdxVHJLTHpxZnVn?=
 =?utf-8?B?UllVUzdWZkd6SFFneTlnSEtYb3JQNTAvaEpKTmVXOTYvS3lUMGpQYzRLMGMr?=
 =?utf-8?B?bDljc1RYemZtbmtKUDZkVW90WXBaNnFDL0toc1lycG15RkRQSC9YQkJBZ1FD?=
 =?utf-8?B?NzRsT29tUVo3Z01GMlVUbk9kdDFmK0NjR3RkZ2ExbUM0ZXlxb3VVNUZUUVYz?=
 =?utf-8?B?cDgxb2Z4MWo4WnlieTZFRFN4TUNTTXpVNUdzNDFVL0ZsVkhPSytBRVR1K1Yr?=
 =?utf-8?B?Q1BLVW90d3FoVkZJOXFHMGZOM3pmdUZKL3lMMW5WVUYzcjMwODF4SElhK0pQ?=
 =?utf-8?B?b2w4NHJMTXlOM3d1aTBRMmlvZjJCTWxSc3RzWG9ZbVFCZ1gxclpVb1RETFN6?=
 =?utf-8?B?UW1oZW9yM1AxOU4xSU9hc2N5T3B6c2RJRk5oemRHRU1jSWl6ZWFWQU9GdFlw?=
 =?utf-8?B?UERjSm5jR21UUjltNlZhaVQ0eGQveDBPd3BzdUlmNUlDcSt5cCtNRDQ2cENU?=
 =?utf-8?B?OUJWbk9vZXBjRDBqZmJSWWpnSDAzYllzcytYWFhuandXdDhvbzhveEh3YjE2?=
 =?utf-8?B?bGtNS3BUelgyRnBIUjladklpbUQvRUl4bmlyenVkU2RNdkZSQzUxK3VrRjZh?=
 =?utf-8?B?dnVmc24xNkVnbHZUUGVPNnFXQ284VmZCYm0ycHFIOVdsbzhqK201TUhneGlK?=
 =?utf-8?B?SWp0VXU1NHNTNUhNK1BlYTF6bHorUGpNU3IzQ1V2djBORG1WYWxWS2t2RUxl?=
 =?utf-8?B?SWU0ZkwrR2xLMEFqc1RxRCtHNEZIcWpiNjYwbEJzUUc0eS82RTdmT05ld2Fx?=
 =?utf-8?B?ZWV0TUVZMEVqcnpxVlVmbGJDWUllOHVlU3p3OGxJdU0yYk1mUzluUGt6MmRI?=
 =?utf-8?B?Zmd6OEk1a1BlMzQyM0JGY1RrS3hBVGdjSjQyNnppQ2VKSzhWU3hGTWN0K2pv?=
 =?utf-8?B?cUs3aUMzdnFyRVBvd2lPcWx5dnNGMExuQVltRGhVaWU1ODBhbmwzOHBtbUlG?=
 =?utf-8?B?Wks0cVJPcFNSYkVZQWUzZUlKMzlhVkdjeXZiVTRudnN2ZVE4dmI4WTl4OHNt?=
 =?utf-8?B?YWF3Yzc5YnZWOXg3RDEyZlpHV1lUZ2tsSG9ac3ZWeTN3ZlFCYUxTdUkyQjNO?=
 =?utf-8?B?Tms0U1ExL0grZ0lxbnJubkFMK3MvdnI0YmY3ZGZSTUZYdGFSZVFVdlhVcmxT?=
 =?utf-8?B?b09qakVHbFk4bWM3SmlTRERCL2prdFgxM3JDY0NmMzRMcklveFVFVmlqd1FO?=
 =?utf-8?B?c1VQLzBndXRxSjhzL3pLaThSeFJEbXNWaFY4TUZqUW5GNVM3UDFhenRBeWpk?=
 =?utf-8?B?T1J0ak45WEdKV25xWUJOazNBNkpJL0dEeS9TbjRLVnQ0SVd5bDhKRFloWjVi?=
 =?utf-8?B?QndaKzZ1eDhMQWFlRFk5d2ZnaU1PZ09pUlp4OVc5UUtQeW8xM1lvUXdjNE5o?=
 =?utf-8?B?TTV2M3Vnayt0akk0OXc1ZmxhVU1pcnNuQ3BmTEV6ZlNLK01ITEtUckFvOWJn?=
 =?utf-8?B?ODRNeGwrZGhHNTFrVXNGU0RHOGtQdVhvc0x1emxEOWw0Z2NwRzJFdmp2M0d6?=
 =?utf-8?B?ZXVjQ0ZDeit2aU5XQ01weVd0ZlZxWHZ4UTRRRGY3bkVWMk9QckMyTlhveGQy?=
 =?utf-8?B?NWZYbXkyOGtlSnVtQUZWSkcrQjFXeVd4cVFDUkxqSkNybmlVQkxyZ2t0b2k2?=
 =?utf-8?B?UkFxZlJvS2hUUXZMNGMvQ0FKM1dISDlGdWJ2WFlZZ09WTG9yT2RXS29qMGFy?=
 =?utf-8?B?dFdqNDNxWllNYUNxVXZ2S2JFY2Y5SVhRcktoZWNkdDBjaDVmYlhtNFUreGlm?=
 =?utf-8?B?TzJlZ3FWZk9qWVhVbXhaVjBIb0VTSEdFdHZwTzZMUkg0a0diTytjYzN1Smxl?=
 =?utf-8?B?NGIvOEdoWGE2T1U4QTdwSXM0MXZ0ekoyUEtJME9uZkd3b2lOWXZSYUtSVVRq?=
 =?utf-8?B?NDdtdmdHdWJDWWFZa0pXR0NKeStneEhIWDc2UmdIemE5TGx6NXVKVTJISTVL?=
 =?utf-8?B?ajhOUG1yb05SNC9BZ0I2blZRWG8xNFJyS2l5OVRwM2tSOEJiTVZ6MTJZdEhE?=
 =?utf-8?Q?rVY+ttXhz4vTzcWXg1oNtEIP1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e30617-3fe1-4c49-8242-08db68aaabf4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 05:30:44.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uE2YXhGb/Whfi5WM755x+l4ydXEYVRlRIulq9dUNGxhZEb0UQ0d+hdPjg66nNt7j2GP5n6He7l061FNd1Ks/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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

On 09-Jun-23 10:10 AM, Ian Rogers wrote:
> On Thu, Jun 8, 2023 at 9:01 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Hi Ian,
> 
> Hi Ravi,
> 
>> On 27-May-23 12:52 PM, Ian Rogers wrote:
>>> Split the pmus list into core and other. This will later allow for
>>> the core and other pmus to be populated separately.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---
>>>  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
>>>  1 file changed, 38 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>> index 58ff7937e9b7..4ef4fecd335f 100644
>>> --- a/tools/perf/util/pmus.c
>>> +++ b/tools/perf/util/pmus.c
>>> @@ -12,13 +12,19 @@
>>>  #include "pmu.h"
>>>  #include "print-events.h"
>>>
>>> -static LIST_HEAD(pmus);
>>> +static LIST_HEAD(core_pmus);
>>> +static LIST_HEAD(other_pmus);
>>
>> AMD ibs_fetch// and ibs_op// PMUs are per SMT-thread and are independent of
>> core hw pmu. I wonder where does IBS fit. Currently it's part of other_pmus.
>> So, is it safe to assume that other_pmus are not just uncore pmus? In that
>> case shall we add a comment here?
> 
> I'm a fan of comments. The code has landed in perf-tools-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmus.c?h=perf-tools-next
> Do you have any suggestions on wording? I've had limited success
> adding glossary terms, for example, offcore vs uncore:
> https://perf.wiki.kernel.org/index.php/Glossary#Offcore
> I think offcore is a more interconnect related term, but I'd prefer
> not to be inventing the definitions. I'd like it if we could be less
> ambiguous in the code and provide useful information on the wiki, so
> help appreciated :-)

Does this look good?

/*
 * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
 *             directory contains "cpus" file. All PMUs belonging to core_pmus
 *             must have pmu->is_core=1. If there are more than one PMUs in
 *             this list, perf interprets it as a heterogeneous platform.
 * other_pmus: All other PMUs which are not part of core_pmus list. Does not
 *             matter whether it is a per SMT-thread or outside of the core in
 *             hw. i.e. PMUs belonging to other_pmus must have pmu->is_core=0
 *             but pmu->is_uncore could be 0 or 1.
 */
static LIST_HEAD(core_pmus);
static LIST_HEAD(other_pmus);

Thanks,
Ravi
