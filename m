Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391F06E12F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDMQ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDMQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:59:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF25093D2;
        Thu, 13 Apr 2023 09:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ljj+/ebmVmc9unRqFVXXt18+SaozxGxyXTr0UFfA2wKvlN0yGyV4zVnNcwgXjVFWxbx/+ChKIwblhgp/QmjLhRr+FviobXojAZWBl/TJWgD0f1GXNN9DmRfJYVzH/XHd+LtPIGLjyczpMCmj0mQXi7EEy1QVNLD4VdGO6N2L8j8U8qPuHZtGZLDrAZFzB2QxQXOKmRIXLEc7Bpqqjqe3Hs+oH8ADPWELtbk6E/ji7N6+9glHRNOnVToXwYXx5/q/Ef2VL5Gv8gUa7k7cboOEZZUj6EIPn4qlZwtAahTZhMHdNRL8BT01rwCEok0U8Iab2fLMOKVhysYzIuNwqj0kGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PboNocKDTtwt2BesT9WxTEMFhlDUEroIJOCJqRf4HnE=;
 b=NtAqCwowlbIC1EV3Lz/0c7nksOGmh8CAD8+eS4fWhp9v0peVbfKA9b74MsG0qxmszo+cfJd225uFfGsNkjS7wtljUKT7fPC7eo6UVvCDrfxnrhaYX364JSslM5ukATuWYqK5O1GvDFCNaeXXFjn9Crb1IsQsseVKxwVRpmG4KytAC1gR+dFa8Cq+KL3HS782HXeWrQWacGm7vrtaa5HrBUkRQk8kQA+ea0mTriNyHE9lCR4pqY5hJS9Q15eeVtA7kbtdKACY6dUGKkkB6RVOLWUXh96acM4k1C3kxo2GmXg0df5ZQlkf58p3JAzzkln0gyzTVovdpB5H0rKsArHCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PboNocKDTtwt2BesT9WxTEMFhlDUEroIJOCJqRf4HnE=;
 b=K6bPiLaREqQtzGZZJ/Jz3h8sJ+QKjk7iza7JHSpVzoKOCvYH33kcYgJ21TWcvOlBrC3FI6Hy8G8EyTkln1L4ERCtpTu4kGeMUhAqvCiPKfKN2kRBdxYPbN4hjLqiORyh/GFrHQXoXp2VNMj9woOzn7hfuksxTzEaO39iBWDY4NI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Thu, 13 Apr
 2023 16:59:37 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd%3]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 16:59:37 +0000
Message-ID: <58782dd2-95d1-655d-7355-4170d2c56f05@amd.com>
Date:   Thu, 13 Apr 2023 22:29:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH v3 2/2] perf: Add option for --per-cache aggregation
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, ravi.bangoria@amd.com,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        gautham.shenoy@amd.com, eranian@google.com, puwen@hygon.cn
References: <20230413062006.1056-1-kprateek.nayak@amd.com>
 <20230413062006.1056-3-kprateek.nayak@amd.com>
 <CAP-5=fXkfkMUJiRiqWh0-J1KGkPdGniVq7RRN1HnDm39Xv0LFA@mail.gmail.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAP-5=fXkfkMUJiRiqWh0-J1KGkPdGniVq7RRN1HnDm39Xv0LFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c8032a-6130-46d5-7b43-08db3c407657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mt7Myal+wLAcDAYbLiu4D8jQk2KOa9DxmAvL7VejZq7bNwzNjyvfuMIbcBbjr/N3VJ8mvjG7ZT8pCjODgumYDM4ucSUwaZuYpIaIY7WJDLFa9Ykvx82GiBi+RvNc3fc4NgbN0Z1CNn0LDUgbAH/UBBTksw/0i6o4nV9jR9KREW1Y8MohAhmmL8xzQ6ouNBSJ27mm9ATf9Hn35/Cp29NelnRzCNB1gff/EPaVYBx1LKai2hmZMdu/wU+03L89n+nfZXXWDnlSMcYxq84jIxDdK/XucIMRAIo8IiAu3AOwA1FQe3qa04zrmm5xY0DUYbBjO/VTV0X6oQrd2FXswOaq9BlrtHjDJlKocV/85pXDT1mDulfSSfKjXicLaJBy3sURfn2cJjFSYKoi3gvPAV0mfllKAawyCtTGchneEVRtiCG/dy162KRm0zYXn2xuZMjbUf09nckqO8jSkyKC8HBNonibLZiF5kVn5Qq8+rIFZqmRdkkIssiwj6+hVTHWOQkABr5W6idg+Z0KXfpo/a+VIleF2tsaqtajDIVkRkG36M5sYllhwQDZYrITTX38F9rjS7Qk0DW3qwx2UUl+VtVOLF7eriF6tTVr/AJMp5hTYTmhYSreI/ltcteyvAZ81bf9hTnVKs/RJbMicIygx86ueg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(478600001)(186003)(66476007)(6506007)(53546011)(26005)(6486002)(6512007)(2906002)(316002)(4326008)(66556008)(66946007)(5660300002)(7416002)(107886003)(6916009)(8936002)(8676002)(6666004)(41300700001)(31696002)(38100700002)(36756003)(83380400001)(2616005)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFFBb0xkd0JJaFlPVmhYMzg0YU5iQkdzK1lRZ0VDc2IyR01pVU1CWmxzRUFt?=
 =?utf-8?B?MXhvTUNUYTBnOGJLWVA4QkZUdHQ1eDBINDhUSjdpR0Y3UGJ6cEFGZEptRHNx?=
 =?utf-8?B?QlFSNWF3ZHprbkRiMWxVL3Q4N2wvb0w3TGVTb3ZXd3FmMWNkLzIyaHc2a3V5?=
 =?utf-8?B?MnNXQnlkVGpzL1ozdDNzRXYzOUk3YlUxMnk5RGJvTGxqTHJxenNkejhhYXAr?=
 =?utf-8?B?eHpOKytCbHRSZXhscWZOV1piVUl0c215czRIM2QyUkZsak8yL0lXeVpSYmZS?=
 =?utf-8?B?TWkvZ1IrTy9sOFljRVlDR2ZvMGFkdi83VEpOYU40RXd3RjhJckZENmdBaU5Y?=
 =?utf-8?B?L3ZiRnR0Yy81YTdLZ2lWeVlUdll1eC9PQmFvN21ub1pEczVTYnZOSmFORzBW?=
 =?utf-8?B?a09lV3E0bEtob0lPbS83TCtCRCtuck1ZVGNCaGlKL2xCWkJEYXBYS213OUo2?=
 =?utf-8?B?TTZob0M5RjdiWE1nTDVCaXR4VXUvYTJuaWpJTWZiOWRGUEsvcUYzNm5QUjZh?=
 =?utf-8?B?NDA4elAzUG5RSG00VVFjWjBGT1ZFUTdBc1FPZDYyRnlMbXdFemZUM2tzZDRp?=
 =?utf-8?B?bnlwL29INzVNTUdaWHZSQjRPbTZwNEJ5cWJ5MTEwbU9STXJNRnVkZ05rdlFK?=
 =?utf-8?B?VXNXdmNEb0RIVTQ4VzNUMlpIbWJSWGlFMjkyQW5MV0dLY3c2UmJpendaNVBC?=
 =?utf-8?B?WGxrM3l6UUpadTE0UUxPN0FUTyttUkhVNFJYdGJXOGMxa0g3K1h3VWtyaVNI?=
 =?utf-8?B?bDI0Y1ZQRG8zOHByKy9Lc1hnVVZieHU5SFZmaHlIZThETURtUXhHbElJdVYz?=
 =?utf-8?B?Wm9iMTk2VFBuV2JLUi9FU2hsTHppWCtMUE51UDJRRWI2c1NwL0lWQWRJQ1Y3?=
 =?utf-8?B?Wlp2ejJzeWZPVXVlV1FSTThYdXkwK2FtMExyYlFxNWdxOWxhU0RySGRwMmow?=
 =?utf-8?B?a0Frb3ZhQzRtWWpCcFhwUEVHeGhtbHBoVzIrTWlXVXNQdkVrbE9tN2tGby9U?=
 =?utf-8?B?TGtkUEhITlRPV3A0N2IzSFRJaVNlZXU3dU9ZY3hmYzNiRjQxL3V4RGRFdWN6?=
 =?utf-8?B?eTZIMmJBK2VQS04xWXN0UmZCamZodW1jSFJTRU8xZWppUTRHSUJiQWtZeTlh?=
 =?utf-8?B?d2xUQkw4UklTcFdWcjU4Q0doZVNTd1BNN0ZlZ0tlMGpsRHR2ci9JZzRESzJ4?=
 =?utf-8?B?V3dBaEpjQmJ0R2dXb2EyVFo0Q1hFQlZ3Qi8veFZVaUtURE9nVHFBTG13bFR6?=
 =?utf-8?B?QmJSeE5MbTY0R013Z3hYL0diaWRZS0x4UHYyWmJoZllZMGJPakd5MjhlUzQ5?=
 =?utf-8?B?UFlPcGRVWDN2V0JxZ3l6djZJSFJja051MUFQN0tFbWNIR3Q3bTBuUDRvdy9V?=
 =?utf-8?B?M1RzcmpRbDFLK1hLT3p0YWh6L3ZTNWlxYlptS2pDd09Wd2dMZXNmcUZjZVpW?=
 =?utf-8?B?QUdSUG51ZWVhajFxMWZMMTVNdXZKZnFwUWhoV0JXOFM5aEwvMXpmUzlDQ1hs?=
 =?utf-8?B?bTdIU1RGdUp6b1p2TGl3Q3VGZzE0b2dEYXNBQWpZQTZzTXVaaVM3RlZKbEFs?=
 =?utf-8?B?a1pLbFViMnMxUVhtUnRtUXBnVWJESDlIYm5vbm42NG1HZW9SM2QwQlZXaXM4?=
 =?utf-8?B?UVlValAyNC9zeWgza2FaZ2g1S2JMODBHbkorQkthQjZGMGxuaU1sdGtnTGRE?=
 =?utf-8?B?WDZEV1lmM0pJMkp4OGJjNEFqMmRUKzhkSGFBRGVCVjJGbFlsNWtraUU3U3pv?=
 =?utf-8?B?N2hLQURURkZreDQyRVJvZmVNdWQxYXJMQk52cnZOMXQ2cXNPM3RsQUxBdWFG?=
 =?utf-8?B?VVNFeDNnWVE2Q3NCei92WEcyTnYvdEpBRUNTYjRtQ0JSMjJYT3kwUnNVYTVS?=
 =?utf-8?B?czlZbVZYZTBjczU5bFYvdkZ4ajI0ZDVRVEVkaEFjOHZlMlhYdHdwUjAyRytT?=
 =?utf-8?B?N2lONE1pMHRrT2lEYTduVHlEMGl6aGJVSkJyendLbkdkYnBkQ24wVWl1SkZi?=
 =?utf-8?B?L1Z2Yytabm9pYW50a09Iai9Ndk01dkFjekZvbkJqSDZpM3pzcFpVWFhxbi9n?=
 =?utf-8?B?QVN0SFlqYi9sWTJta3I1U2IzVTJxRzQrcytXb3FaMTNqOFllK2ZwWjg4b3Z2?=
 =?utf-8?Q?ZwAuw/o6FhLZxWOwZeMhirAkW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c8032a-6130-46d5-7b43-08db3c407657
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 16:59:36.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dm8xicAw5JQv6IuhEg3CrX6+YpE+iRdygv+kkF7I+EL8tjIRYpWz2hBa4+GDvp4zB4mKZDn2S5bWhOZ8CmMnyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ian,

Thank you for reviewing the series.

On 4/13/2023 10:18 PM, Ian Rogers wrote:
> On Wed, Apr 12, 2023 at 11:22 PM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Processors based on chiplet architecture, such as AMD EPYC and Hygon do
>> not expose the chiplet details in the sysfs CPU topology information.
>> However, this information can be derived from the per CPU cache level
>> information from the sysfs.
>>
>> perf stat has already supported aggregation based on topology
>> information using core ID, socket ID, etc. It'll be useful to aggregate
>> based on the cache topology to detect problems like imbalance and
>> cache-to-cache sharing at various cache levels.
>>
>> This patch adds support for "--per-cache" option for aggregation at a
>> particular cache level. Also update the docs and related test. The
>> output will be like:
>>
>>   $ sudo perf stat --per-cache=L3 -a -e ls_dmnd_fills_from_sys.ext_cache_remote -- sleep 5
>>
>>    Performance counter stats for 'system wide':
>>
>>   S0-D0-L3-ID0             16         12,644,599      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S0-D0-L3-ID8             16         13,847,598      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S0-D0-L3-ID16            16            223,592      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S0-D0-L3-ID24            16              7,775      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S0-D0-L3-ID32            16             31,302      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S0-D0-L3-ID40            16             17,722      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S0-D0-L3-ID48            16              8,272      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S0-D0-L3-ID56            16              5,765      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S1-D1-L3-ID64            16         18,227,173      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S1-D1-L3-ID72            16         20,926,878      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S1-D1-L3-ID80            16             13,705      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S1-D1-L3-ID88            16             24,062      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S1-D1-L3-ID96            16             27,891      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S1-D1-L3-ID104           16             13,480      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S1-D1-L3-ID112           16             12,656      ls_dmnd_fills_from_sys.ext_cache_remote
>>   S1-D1-L3-ID120           16             21,881      ls_dmnd_fills_from_sys.ext_cache_remote
>>
>> Also support perf stat record and perf stat report with the ability to
>> specify a different cache level to aggregate data at when running perf
>> stat report.
>>
>> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>> Changelog:
>> o v2->v3
>>   - Cache IDs are now derived from the shared_cpus_list making
>>     aggregation possible on older kernels that do not expose the IDs.
>>   - Updated the comments based on the new ID assignment strategy.
>>   - Better handle the case when specifying a level is possible as it is
>>     less than or equal to MAX_CACHE_LVL but it does not exist on the
>>     machine. In such cased ID will be -1.
>>
>>       $ sudo perf stat --per-cache=L4 -a -e cycles -- sleep 5
>>
>>         Performance counter stats for 'system wide':
>>
>>         S0-D0-L4-ID-1           128         51,328,613      cycles
>>         S1-D1-L4-ID-1           128        125,132,221      cycles
>>
>> o v1->v2
>>   - Fix cache level parsing logic. Previously, giving "--per-cache=2" was
>>     considered valid but that was not the intention. Only parse strings
>>     of form LX or lX where x is the cache level and can range from 1 to
>>     MAX_CACHE_LVL.
>> ---
>>  tools/lib/perf/include/perf/cpumap.h          |   5 +
>>  tools/lib/perf/include/perf/event.h           |   3 +-
>>  tools/perf/Documentation/perf-stat.txt        |  16 ++
>>  tools/perf/builtin-stat.c                     | 144 +++++++++++++++++-
>>  .../tests/shell/lib/perf_json_output_lint.py  |   4 +-
>>  tools/perf/tests/shell/stat+csv_output.sh     |  14 ++
>>  tools/perf/tests/shell/stat+json_output.sh    |  13 ++
> 
> I think you can break this patch apart. You can add the feature, then
> enable the CSV test, then the json test, etc. When adding the feature
> you can also probably split the changes of "struct aggr_cpu_id" from
> the display/enablement logic.

I agree this patch is huge. I'll break it down as per your suggestion in
the next version where I also plan to drop the RFC tag.

> Overall it looks good!

Thank you again for taking a look at the series.

> 
> Thanks,
> Ian
> 
>>  [..snip..]
>>

--
Thanks and Regards,
Prateek
