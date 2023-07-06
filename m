Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D8D749EDD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjGFOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjGFOWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:22:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DABDDB;
        Thu,  6 Jul 2023 07:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv09HaUmFgH08fpyRyS0NzD8R8nvUsbuev3aIGNzp2+GqxT5Y+Lsvlv/jyyx42ZDNTIVmNxD32Dchuu2Mi3z73HgRUo4pdR0k8gsp7pXk71Hz7d4TVw7i+ZWTbVWGFKqZwaQvKYykashsCHCWMBvm+VlqpiDDZ1s56MI8poBN+iWdKW/LE1lguqhh5e/YxiuryqDFMxTef4w53VekCLMbVjt39n6gNdGQJCN5S7gCjViVzEKFuwRaKpX0bcsgN8MhxdbZdV2d2RwfvcL0DexJW6nyGCD9gLlMoImWnwt3JBCH5cD5n4aS95+6e4x8l0cmFTetOxeDMz1FsiSrLtJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qM6SqfE0/tQD7dty6tZ3kaBe3pqKoMhQuI69TXygGLc=;
 b=b49g/vD0kPTm61QZ8BXHlX3zp8HKKaUKdVixf1tZeoLEDZ6s6DqKaHAZ/T59ku45bFt8BCLUe8XxAH4i674WmQxZob5oQ2gjqU4zg/295ps86lMfYqtlAf+h7qdQQXe/yHmByK2CBqyKqy1kpG6vIUHXSdR7h++7oO5baVmuIZVAY8Mnwo53vG35oQ7NQkw3jvXCN1B6AfXKSiFaxulX489IDLxmv4XzP1FmjcPEd3gVPRf/Ha8ed8N5iGwfsfxJLOrDCdcZuC92n88QV6bNYWnJ0SFDDcjwe2tRmqTWImkw5/7oxZXgx3sFZzMtoYaejwzYo+/vYGsSDy7Qi5YklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qM6SqfE0/tQD7dty6tZ3kaBe3pqKoMhQuI69TXygGLc=;
 b=pBdzyqHtkO4MBTbX5v6uBuhhe+Fqs/a5jOK5FBzCF+YSkdxjHhiIc8dv9k+y7VhwRwjDtEPVj6ygAnv6UVwiDJ9d/GQlUzAeKrXgxGUId3EZIdzWioW6mMmOhCBHiO/v3qb8ciAddBYPh1AWRbk0c6/ns6QmQ/eleKiSiJ0fSXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 14:22:25 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9c4d:b56:ce20:d723]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9c4d:b56:ce20:d723%7]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 14:22:25 +0000
Message-ID: <ce15f15b-2f1d-960c-c20e-131d92e1d750@amd.com>
Date:   Thu, 6 Jul 2023 19:52:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] perf vendor events amd: Fix large metrics
To:     Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        ayush.jain3@amd.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <20230706063440.54189-1-sandipan.das@amd.com>
 <CAP-5=fVdVSL4H1qWLZMiU3H2-bOJ0RkFOfq4Jxz1qw0-8EoYFw@mail.gmail.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fVdVSL4H1qWLZMiU3H2-bOJ0RkFOfq4Jxz1qw0-8EoYFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::16) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7a867e-9f27-4e63-4450-08db7e2c6b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMtGGAZGqjC/Y4yo3MJSoKMlZ5F4m12YXilxrQbiiIQwq3wt1QT4nzeIgH+3l2IbhzZCp9j6KCS+1dS5oeNYRvuWE+dizZlx3of26z1AFy5Zpw0hnokcWZtXg2hY64Gh7M7kZ+wEdHIb/qUDN3ihcnL7BdPEd2P3DY74W0B935j2Qz+rjSJTejIaZbP9qcYm0j3/KZEl8Rc/6Tjiu9jVqczGEOotHpqvQlIAzliRjWOOWsn7JdmaoNd0fZS6CsV2bTbuiiLqFNFdohzt/q4wpNWcpKBBUoO9elyce19sWUpHa+IHJ2CVXv9T+MxtvyYpHgnljURcWZ5jOBsezXZduT6Gbc70Cb1d0kEsZ0aW2jipkFeurIxW/B9YBEjBPR9PO4cLdONXktWh5LvlXTAtzbXZY6z7x5BexgJRRPHcdqQ8RnBpyfF7jLOHqsvy3ilJf01UstL/fk7o2//JP2qwxD6wXnOivv9kU9VsSyo6kPEt4sp92Z7/IVeAggsOq1GQ+5SiQz2GULEnkAF6XgjVY2FR++rCJZ6xwFCaC5iT9tKipbblyR9eJAsKp2KuK/a9l7WuRRwuFdDs4Wkbt0Hu1ErzSDNoQponSvRWy+ThzFFLA81zk+boYu6JkR6jMMpiSZl7dEl/VmPGmsOmLXmnLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(2906002)(41300700001)(7416002)(44832011)(8936002)(36756003)(8676002)(186003)(31696002)(2616005)(31686004)(6506007)(478600001)(5660300002)(26005)(6512007)(6666004)(86362001)(6486002)(316002)(4326008)(6916009)(53546011)(66946007)(66556008)(38100700002)(66476007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnh0SkIvMkdrai9DT05CRHFTdVdITTBaNlFFVmY5bmtkMnB6UUxzMjYzTnNq?=
 =?utf-8?B?N3ZJcVpnRDdSOUlpdUE3SkJERis4M3kzaHlvdjZsVDBYdW1xOHhIajBqK29l?=
 =?utf-8?B?OUJreUlpVUZnMkZibC9yeFVJdzZzOW5taDRrYzU2QW1Ka0ppN1grTzhDd09G?=
 =?utf-8?B?M2hjN2YrL0ZiYUxLMHdNdWxIT0ZGTk5UckY4bnZsK3dwaXdhQ2xsZDhjVDZY?=
 =?utf-8?B?QktnZTdpZDNMbUJyTWhGNHlEalZVaWZnWkZYZ1Fyd1lLRnRCaTkzU21Nd2Uw?=
 =?utf-8?B?SzBBeDlhTy9tQUhrbHRyUFRYN3pObVQ3dGJUd2Zxb2NtNkg0aVlXc1ptZWw2?=
 =?utf-8?B?UjlnSWg2aWlNRXBQZ0t3MzhJU3hlYkJrT0xaWU1LQWhDdHdFNXYzTFJPZ293?=
 =?utf-8?B?cGk3cmJQQzJlcFBHMlJXOU9oMENjVEtKd2lIR1Q5NFc3MGFKUFQ1V3c2WHpY?=
 =?utf-8?B?cGlsdEpub0pqVHJ3aFk5NysvWW9oZ2FBUVhycDJpSFBOR2o1a2xpNDA4aDY2?=
 =?utf-8?B?RFd3SmFMQ2FaMDdCdURkU3BUbjMxclN0eWMwUVRHM0FZZ0xnNU5FZXI4U0Vr?=
 =?utf-8?B?Ynk3QlozdmtLNGQvWVo3ZStTY1N1VGNtaUlyMVpjc1dpYUVSM2VMTHZmSVNZ?=
 =?utf-8?B?SmYwR01ZdkNNeXgxRDcvZHVDWnlLcTczSmM4bmphRmprZ1VEOTBSVHhSbUcy?=
 =?utf-8?B?QjlKRHNYTm9oakVXa1h0QjVVMkRmczhqWW5nZGxDblU2VVNwKzNJamY2ZjdB?=
 =?utf-8?B?WWhhRHhESGJLNkFuZmdWbFE5d3BZWTRURWtnS0RTejF0L0Z4bVF6anZkdzRi?=
 =?utf-8?B?dHpBS1hSNzBQRG41RGM2Z0JSb2hlbTVaMitwTTZ5aGhMT01SRmR0andjV3Az?=
 =?utf-8?B?M1dWeUc4RXBaT3RYK0UvZjBBNndKcG5UYytPNWNCbWdOc3loVmtEMEV0bncx?=
 =?utf-8?B?UERoeUlSS1NSVlArcUZaS3BlR0didmgwbkppdGZKUGk2c2hwZ2J3Y3l3eHBt?=
 =?utf-8?B?a2hQWWhrSlNIeitPTEVxRkN5aWwwN3ZURy9LeS9BOER6VkZHMmcyNzF1WXRV?=
 =?utf-8?B?OHdwQndIcnpQc3BMY2RibzYwMDFSMFF6U2F5UUJjbEUramhGcnQxMTlVbW12?=
 =?utf-8?B?K2pIdW9FczhtZENwOSt3TFJkRkV6ck0rMitvLzY3djd2WWJoMUtaQ0xCcG8w?=
 =?utf-8?B?QmhGU3ZjZGoxcXpaR2FjbXY3a24vS1AyamEzMFF6eWRZRS9OK255ejBINURT?=
 =?utf-8?B?MVVTY2pRZ0VleEs2bWlWVTdUVlJhRGdwYlFycTQ0a2hMRUloeVd1cVFOK2pv?=
 =?utf-8?B?NDc4U2Y3SzMycE9VdDl5K2haQnh4d1M2TzBIK0FKZExtMnIxSmFDMnZDcW4y?=
 =?utf-8?B?KzA1Y0FlWEtBbE9MdkxLY0ZOR0d5UjZydDdUSmF3c3VYWlJ5ZWVNb2pGL05y?=
 =?utf-8?B?Q3JMWEpwU3JreXlWQ0FXY0U2OEI5ZTJHSFpUSzVXb3JFM0JUSVQ2dzBXU2p4?=
 =?utf-8?B?MGV6UHhsSXJTZG5ZczJRMEJmc21JTUpxOVRoOG55TzBPdWh1ZnFjN2NOVk5w?=
 =?utf-8?B?V1VUck5ITzdIWlBOOWl0Y0hDTWtjWDRBdkcvcHR0S1hkUVNNZDNDN1RleTRy?=
 =?utf-8?B?Y0JubWh6elgrUk13OGZKZTFDcUdyd1dGU3dXYURuNHdFRUJOV05HNTlvL1Bm?=
 =?utf-8?B?MUxkaERXM0NLUy8wYmNiL1B3Yld6V3F4UFlIMSt6VHdnR3dPQXJSWUQ2Q0tm?=
 =?utf-8?B?Y3p6ZENaaHZMWXdKUE5LdXIzcmlhL2o3bUFLckRaVkl0NU51NEJFRWJsdWp3?=
 =?utf-8?B?UytYVm4zdUdQSXVxVFlzY1J6WktrRVpoOEZNMVl4RjB5OGI2N1FlRWhSZEVL?=
 =?utf-8?B?K2cxN2hNamhqeDI1RmlyOVRLRnJmczNoUWxZaHQ2QlBLVWJ5M2V3TCtMbSt1?=
 =?utf-8?B?UE1jc2VNbm05djNrWVlxcXdINnJOOWY1T1AvRFVVMHpWajhqU01MVkFLTTNz?=
 =?utf-8?B?eVJiTFMwa1ZNUHgwcExWYVkzRG1scUM4emJFNEIxeXJlclRJUkhhU09acG1k?=
 =?utf-8?B?NGZTU2JYQWxjTENVZ0hONDhqNmJZQmJYbTc2dmlMZDdSKzNHcDVWZTdmbnlp?=
 =?utf-8?Q?la1the9o9Bhp1GvvIOUekF/JV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7a867e-9f27-4e63-4450-08db7e2c6b6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 14:22:25.3114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6j3StGFXFi/Ag9oT5ASEmxWvgur8/xk2J7I+SebZYzPEBsDrKOAhGxbMqEjj3mD4F/rzwbeppNA9Wt7IPX4UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 7/6/2023 7:19 PM, Ian Rogers wrote:
> On Wed, Jul 5, 2023 at 11:34 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> There are cases where a metric requires more events than the number of
>> available counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four
>> data fabric counters but the "nps1_die_to_dram" metric has eight events.
>> By default, the constituent events are placed in a group and since the
>> events cannot be scheduled at the same time, the metric is not computed.
>> The "all metrics" test also fails because of this.
>>
>> Use the NO_GROUP_EVENTS constraint for such metrics which anyway expect
>> the user to run perf with "--metric-no-group".
>>
>> E.g.
>>
>>   $ sudo perf test -v 101
>>
>> Before:
>>
>>   101: perf all metrics test                                           :
>>   --- start ---
>>   test child forked, pid 37131
>>   Testing branch_misprediction_ratio
>>   Testing all_remote_links_outbound
>>   Testing nps1_die_to_dram
>>   Metric 'nps1_die_to_dram' not printed in:
>>   Error:
>>   Invalid event (dram_channel_data_controller_4) in per-thread mode, enable system wide with '-a'.
>>   Testing macro_ops_dispatched
>>   Testing all_l2_cache_accesses
>>   Testing all_l2_cache_hits
>>   Testing all_l2_cache_misses
>>   Testing ic_fetch_miss_ratio
>>   Testing l2_cache_accesses_from_l2_hwpf
>>   Testing l2_cache_misses_from_l2_hwpf
>>   Testing op_cache_fetch_miss_ratio
>>   Testing l3_read_miss_latency
>>   Testing l1_itlb_misses
>>   test child finished with -1
>>   ---- end ----
>>   perf all metrics test: FAILED!
>>
>> After:
>>
>>   101: perf all metrics test                                           :
>>   --- start ---
>>   test child forked, pid 43766
>>   Testing branch_misprediction_ratio
>>   Testing all_remote_links_outbound
>>   Testing nps1_die_to_dram
>>   Testing macro_ops_dispatched
>>   Testing all_l2_cache_accesses
>>   Testing all_l2_cache_hits
>>   Testing all_l2_cache_misses
>>   Testing ic_fetch_miss_ratio
>>   Testing l2_cache_accesses_from_l2_hwpf
>>   Testing l2_cache_misses_from_l2_hwpf
>>   Testing op_cache_fetch_miss_ratio
>>   Testing l3_read_miss_latency
>>   Testing l1_itlb_misses
>>   test child finished with 0
>>   ---- end ----
>>   perf all metrics test: Ok
>>
>> Reported-by: Ayush Jain <ayush.jain3@amd.com>
>> Suggested-by: Ian Rogers <irogers@google.com>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Will there be a PMU driver fix so that the perf_event_open fails for
> the group? That way the weak group would work.
> 

Yes, that's in our plan. Ravi (in CC) and I have discussed about adding
group validation in the event_init() path.

- Sandipan
