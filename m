Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C46A909A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 06:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCCFyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 00:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCCFy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:54:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A82E24C9D;
        Thu,  2 Mar 2023 21:54:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByKJEYnQMflrqH+MpteDxC7RRATn6XxAe7yaSHSzsdMDGVQlCDwi0bnacBIaTVHNE+Uua1tjEo23mXVYLY06z7/fpRUMqGHNeFPZoKJ7Hzosuzyx/mhfL8aBjUgRq4pjP0Rra6vz/cW7quCoNiwc6DOycEmTOG6lroTQ9ixsWHZxK2qrtw7p/rhkZf8Y8PkBR0ItVgbQg4YplX5j9hortAznuHsWYb+ci8nFrnGUhqsa2HvPTg5kL/XRGCSJasuHqIvlx/FeG17fzNv1kh1i8+Xoeno/M+yQltu+Mb28qXlRH4q9zosKlkGDYlI6KdhcHBw23ux5l6HLV6g1LDXFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6YfJGZBki6D/FwYSbD7A/ZvQWROYJnFtUG5gYHvJTg=;
 b=BKeK6Voc7bTfJLZNCaJu06IOzxfafHvEYHBM/HnhJMP+FUdmV0d2ldjE53ijn5P+3VEb1dSNIB2+wtL/vhsRjoMExzIkPghtnig3h26B7YudUhGdaltvZ7phKXYozSuACuvsVxN8eVFJoKWcyQ7QwyP28Fq4Vi5Vw+Gggr2JvyoL6kQGQFRXM2L50YXxvwBLYMBJGnLJRQ4dnEoxpukzyc0aQU5KjMaoxXpWktvjR6DrWX/CPOskjx6iFy0Ic/xoSlgDQhcr628RF8/ZUqi8n256UMreHQNj/8ZBT8ScR4bPI/0YwKf/GJ7iDAVdFgtOu2DSohinCLXwpcHA193xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6YfJGZBki6D/FwYSbD7A/ZvQWROYJnFtUG5gYHvJTg=;
 b=in2o16clJ0iIuiHYGzu5fB4GtmM4tyIIc4vt+AibOzmOQrH14R3e50TJWYN8K50KEzmhv+MxqMJ9GKfd27UfSKfazCKGA3cZD6StrySoZcC09RQ2VKhFuLcFwA9xPTTRIZ01nFbgQwHSWOQB6U9P6KYeV1fPnzmiQh902HrPWOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 05:54:22 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%8]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 05:54:21 +0000
Message-ID: <c5f1c3c2-6de3-a40d-9cf0-c1c7638acfc3@amd.com>
Date:   Fri, 3 Mar 2023 11:24:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] perf/ibs: Fix interface via core pmu events
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     peterz@infradead.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230302092109.367-1-ravi.bangoria@amd.com>
 <20230302092109.367-2-ravi.bangoria@amd.com>
 <CAM9d7cjEvjcYwjA+HfsDHKDX8FGZCECTZ8vDMPHBUSqfQSCOfA@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cjEvjcYwjA+HfsDHKDX8FGZCECTZ8vDMPHBUSqfQSCOfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::11) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: c296f560-0239-4af2-3906-08db1babbc13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8W/RSWNwq4IsIaKK7ipfp2HoyBH2lldiBrnTyPNBbx1yvBcJlPqTGGu170QPo92tXXXMGYYMyT4UMd4zT4Sli6j17q3sv2/pAxuE0/JjgY0lhO9xDH+ALa8hkAUbCbaAfhONg4h1ioVP9NvEDXFc6h165RHxw9suBnWHneSunWjGPKBJW+anPNVtS4l82USNKa8pccCQfCfq+sP8V8/chrDUphxZ1X+DsZXahSHeyqxkaY3H1D2Q3Ffgs+w5oZXS6wLZekwk68wgxj9sqSWez9Z+i7rlyeuSZpY4Ukg8WhKGMSVh8n5+aVj68YA0ys/eH8Ueynz+FK8sHarEY9v95b5IULsLCdGXsMhxeDMzTmrUVWYZLBHxLHT7busS+KxE9kaLFT5SMqC0OnesrIva8wyntEV+6+cW/U/G7pu8v7vsOHxpsVj+YmPHb3KR6Lt/6O9xDZvByU3KfaN6oP6Wugmw3yA56JeTfNXc7xBxHvgYV06jEIqJoJ6sGog6nyPyJEyhQtdVSMS3PjV9QMU0pNxBrL2bR3krD13bHJi+YUV+ysc4ltGrHjwoTIEOnhCLBcAv6/wOxFRezrd0I21eLa1+mKKaLUz7GjIQtkOLVDpKqgmte6mTGqEc9tvgRodKrVXVmownlcV6MGOcqqMM49YT8YNQvVq4dYiUPjAez+Dbr7SKZSLZxhh8aUM9Q+3yQf0lbWKqWXmFp5+j7B1Zm4Hoj7YH/PxcpYmfzGgjujo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(7416002)(5660300002)(8936002)(36756003)(44832011)(86362001)(31696002)(6666004)(6486002)(2616005)(478600001)(6512007)(6506007)(6916009)(8676002)(66476007)(4326008)(38100700002)(41300700001)(316002)(66946007)(186003)(66556008)(26005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXA5NEkwZjRFY2xrTEdJNloxMmh2czlSdWtybXZJb21hclNDV1dwTTNrR1FI?=
 =?utf-8?B?aUZnRDZocS9hNkJqY0xwVWl3WEZpMDNsUHhtaVE4SFBnTGVvbmtHT2VrdmJv?=
 =?utf-8?B?eGtQckM4b2diYUtrTW9KY3JyQS9MTWdwNEJxMWFkbUYrcUdRZnFCb0JuYVVO?=
 =?utf-8?B?V1lRRGJyWVpNVmZJR2dISmpNdzR0OS8xdHFiWERCRGZ2Y0ZEN1RNRHVEbE5C?=
 =?utf-8?B?Tm5HamJ1bzhsczBqSUI0Mnhqb0FHaklxalBMMHg1TTNVeXdkV2J6YlRSc1VB?=
 =?utf-8?B?bkpNK0ovNGN5bTV4QTh1MWxnZmVaM1VWUkJzU1NBdGUwVnJkK0VmYjlESDdu?=
 =?utf-8?B?YjlQL0dWeXdia3lWbWZQNm5UVUtpNFFFTWJnanVGZVZpYWhxdFVIYTZOM2xF?=
 =?utf-8?B?V3YzNkRpNEJSZWlKYzV1c3JHSERoTVNkRG9pWS8rSG5yaFVOa2U4K1U1UkV0?=
 =?utf-8?B?eXFzOFBHVzVJT21JU0JZN3c5Mk1LSUtsWkJSVFVFQ0FvbjR2YnIyVGJEWm5n?=
 =?utf-8?B?bjdQODI5K21SZ0t0bTNXcHZFNEQ2Q1NQTG5GNXFFRlcwYTNFdnBuOW1wTlVh?=
 =?utf-8?B?cUtXdWFrOUdzSXo2bmoxOXBRdmV5NXR1N2psU1l6aG8zQ3JtTTN6RDNnbEVO?=
 =?utf-8?B?bkV3ZVlIS21mQmFGa0xMZGJSOEZybTE1MlhLdXdoeCtMNGxJL011Z0JRMTlE?=
 =?utf-8?B?dHFYQmtYdGlneGlzTW5GMnR6RUFpMHFYVW8ycFNzbWlxQnFtdDBvaGtISXVx?=
 =?utf-8?B?TVRYMHFWdHl0S2RiTHg5KzJPMnV5QlJxVmpNVTIrcTY2dmNpdCtYdXZVNXp2?=
 =?utf-8?B?aHFWQ0ppZFYvYXFyWCt4UjQwSFhKbE9rNG10LzhUcjA2Qmhta0lFejZyL1hz?=
 =?utf-8?B?LzNiaEwzT0lMQUN6R0ZjZXYybWNWekZTMUdTNEFxWXFmR1RBQmwyMHR6S21W?=
 =?utf-8?B?VVpvSkxOb3BpQkZWdEs2RzBNUmE3cjdBblFDV0NGQ05YbFFqQU5INW93NHEr?=
 =?utf-8?B?blpMbWMvV09yejE1VFZXUjFuc3NaWmFiWDhxLy9KMERxUjRlVm9Xc0I4Tzkw?=
 =?utf-8?B?SEZ6SjFxTWFaQUxyWFprZ2pmVDI4cFp4OTU1YU5OalU5L1ZJWjdHYmw4QklJ?=
 =?utf-8?B?WWdIckVSSEN2WWc1NWszVjZNbjRRLzgrakZpbGpTVGVjTWQzQ1puWnZ4aGw2?=
 =?utf-8?B?M2hTejdaWCtIcmxBNVBLTmNwdlhjMVNlM28vTDRPNTlyVVdLMkFGVnV6T1lu?=
 =?utf-8?B?eVNyOUVTcWtvU1ZocDd0S25KeXZRMDVDc1Jyb085ckdUcVREb0dLS2hiNlFx?=
 =?utf-8?B?QU05TFZQc3l4UUgrdlMrRXhaVm9uWCtUZFZUU1o3bXpySDlUN2IxWm1MWnVj?=
 =?utf-8?B?c3dhand6dFh2VWhPTmovTDcwMkRaRkNWRktzNks1OWo5VXdZakdEdm44S2hE?=
 =?utf-8?B?U3NVVExnNm13WFdHZXZyRFA2ZmNkSFl2ekx1VjVnaXFuN3NSaGxBVDFpbmwz?=
 =?utf-8?B?OEEzUlVZYllEcGxSTGszWmFOR1N0aDhmeTFpK09iclJKbk9RRzhTek9ROGU5?=
 =?utf-8?B?WlB5dk1RN3hhOS9iVERLUndSTVJEMUJXKytjTEFmUE11WWtiZ0NNNGxFWERs?=
 =?utf-8?B?WnNHbytnZGtLMmFGamlNU3BNTFBSbHQ1NzE4V25aZDRjalduTC9VdmJFSWls?=
 =?utf-8?B?NFRaT2R5d21lNW5rRWtqdmNkODVTZzE2QVUzdHoxSVF4RFlFRnc5elUwelRQ?=
 =?utf-8?B?VmhDUWRPd21JQUlqeTRVQ1pudFNtSmNHV2M0TFpqUmduWlhqYzZxbWZjVmts?=
 =?utf-8?B?WndpaUlWT3V3L1lPbW1GKzlmQjFFVWRLZC95djRqWE0rTlJ3bTF3emJ5WDlt?=
 =?utf-8?B?RXJmaDg2RGtyZDRnRkJ5QUo1SG1WMXFmMmJpa1J0Z1dVNi9hc01Fb1VIclla?=
 =?utf-8?B?a0hqdHA5clkzQUhZYzMzRk55V1NiU0gvQzRvWGlucHJtVkgrcDdBZzNsK0Ex?=
 =?utf-8?B?Zjh0dVEwUlZqbFJoaUNiSnhCaWg3UExzb0k1Ykt2TXdkazZUb3ZrRS92VkJn?=
 =?utf-8?B?V1ZER09HVzVpb083NWkyTmNOditteHA3WlFtdmNaZ3JQYWg1VXBNRnNBUzBn?=
 =?utf-8?Q?tUNhAIK62N8CuJBBGbC1PMLef?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c296f560-0239-4af2-3906-08db1babbc13
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 05:54:21.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKsTahKi+KxnxOfLJv3UGf5JzFcT/fqr9J8qVuWmCpA2ZCcZcbD/6Q3XCwXFnuh/RzJov4fVJPGfODkE3JaYjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index a5a51dfdd622..c3f59d937280 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -11633,9 +11633,13 @@ static struct pmu *perf_init_event(struct perf_event *event)
>>                         goto fail;
>>
>>                 ret = perf_try_init_event(pmu, event);
>> -               if (ret == -ENOENT && event->attr.type != type && !extended_type) {
>> -                       type = event->attr.type;
>> -                       goto again;
>> +               if (ret == -ENOENT) {
>> +                       if (event->attr.type != type && !extended_type) {
>> +                               type = event->attr.type;
>> +                               goto again;
>> +                       }
>> +                       if (pmu->capabilities & PERF_PMU_CAP_FORWARD_EVENT)
>> +                               goto try_all;
> 
> Wouldn't it be better to use a different error code to indicate
> it's about precise_ip (or forwarding in general)?  Otherwise
> other invalid config might cause the forwarding unnecessarily..

That would make things easier and we might not need this new capability.
Most appropriate error codes seems ENOENT, EOPNOTSUPP and EINVAL but all
are already used for other purposes. Any other suggestions?

Thanks,
Ravi
