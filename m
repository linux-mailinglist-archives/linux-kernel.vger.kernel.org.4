Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24E698EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBPIli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBPIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:41:37 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2024255AB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:41:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX/LFgv6VrkhAzDK2tEHuKcuDd/YISpUySxnjiU/3gewmjHsL9qdjyWM0T/R29jA0064tG6AUH9QI5Jg+aa+mzLWfMBn5d6rQh1gOLJfTLtLqBapyhi9Vf1gqD3Nof2cWvnqWrm/m88ea0k4Pk2dfNGZBQK7hLcx1jksJvUExqX+1795WD1xVGPVhZcfzZopSnuy00zb72LwI+CcNJnZTEaQpdCUK7Vsj7odqiIqMvrlxU723+5tbouH/rlHpByNnmUTGRyjn7wUm+60k75UMfoCFc1bEOzDJdsYlA9+mK2e1ParTH9mGoVuHSGQYnbuwqkWx2jyvqqlpdN3029asg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C99sFGY9vUQj+tuWcgMPx65UYXHhOIdbh1DygPoGCGk=;
 b=B9Bc/zw4kWOdpG4LSgR7L48vdG9ylSUossQlFFvMvw9SGCELxEk0diOcqh8aqPz9xSr5BxkUkrtmOpNXhw9pL0L0a/UEdSDzr9EQCKr7TGdcUoaT0CXLQG2XlRwLssl+QtO6FSxGvg/ImIqqOdzGZZzOaIEWUPwUfF8crst+H3QsFvUOwmrWCBc7jBe+VcBNgEJ5z8grOlxx53/edGRTC8Nhbw3VJjiNCn4nvbEyxGIATPaejv8+MvXfz4ty/Lb1ASQnjU1igw6fMIVtTIJdiisojEipnk0d5LCjlvNMnpV//awQMtqzwNe2B27YFcGtc1YlLUp1LUo0s1DalTbuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C99sFGY9vUQj+tuWcgMPx65UYXHhOIdbh1DygPoGCGk=;
 b=DvrtEwCaVyl/D8+0XKWeGpGSBKFxuRFLSMUvANIaxXN+gWT2cxqVfZVVZvPGXD4UJG2KhoGf0NiOg/oYXU9YufHpZ5esSIzFyKIqRfOxHAHbln1uG0F6rItdRPtx5nou7uHJu1l+pCkUJK/2fU37mOP83v9neUtkvqiqwi1BUqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 08:41:34 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05%9]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 08:41:33 +0000
Message-ID: <c3e79d2e-97da-726e-bcaa-0258e3ddfafe@amd.com>
Date:   Thu, 16 Feb 2023 14:11:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
From:   Bharata B Rao <bharata@amd.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        peterz@infradead.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, tglx@linutronix.de,
        yue.li@memverge.com, Ravikumar.Bangoria@amd.com
References: <20230208073533.715-1-bharata@amd.com>
 <878rh2b5zt.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <72b6ec8b-f141-3807-d7f2-f853b0f0b76c@amd.com>
 <87zg9i9iw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1547d291-1512-faae-aba5-0f84c3502be4@amd.com>
Content-Language: en-US
In-Reply-To: <1547d291-1512-faae-aba5-0f84c3502be4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::25) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a627e31-288d-40b2-6372-08db0ff99b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9ovBqB0XDyAhxMXzHoZyYwIVHpa5K1kFhNjOvg27vkeSAfOeecqPhpLKpm4bQwOFCq4EcbqDcGmRBmmggqanoD580xDd5KNSEXzUpUuvOIwI1y+ssvU8dNokR5BKSYMDwqRw2D99SF7wmMY2sgsfehl4Ut5RST3LBzwg2tNtgR/6gW2jw6Dpcre+9SoYzWrwzcOwVQufPFVzHGBXvCM+geUSiXOf3pqMiebB49vMHPtOMjOKRbH9vYvM+jJIfJOmPNmxkorZhJKEpdGFyfMhzMntApCzItdUC5/s3dRSg2YU1Pj+nBC9eu0LllWsLClyiw/UvxJzeEir7B3Ukws4lPrvzdEJlpBQClqXhoq1N9biPgML9qX2IJidLLffgyzkeXolwMDvp6Sfw9Ca/gxn93cEOBLRIQW6RS9wmwx2jPnYudcZzpullMFSEDHQRBkTTr1z6Ff5TBqOuRwuhMIJjHkd8Nan+4i3j0kh6EweZVuiChsg+P4uFuB2Gf1Ma7m1hUUZMdpLfBGk5e3mCMxhsu4XmXShToq2ZwMPFzK6vbtEaGFOwtVWDc6+i9lEV2kPXQWNvVWow4PCGLu1qX3b73wQ3BYPQZWPEI8pICHY7Ig9bKxEy/H8mStmcW/UgrPXO6E4VPwoLdOFTNoHoBYsWrL5ENMHsMwpeLO/vE7nu9Oz5TknFGtw04VI7dixktLpPWUqBJWQI7YesWf7lu57C5VLjRzl/PI0biOnB0b1MY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199018)(6916009)(4326008)(66476007)(66946007)(66556008)(6512007)(8676002)(186003)(2616005)(53546011)(6666004)(26005)(86362001)(83380400001)(31696002)(316002)(36756003)(6486002)(478600001)(38100700002)(6506007)(7416002)(31686004)(2906002)(41300700001)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVpxazBScFY2dHdyRGVyQWhRaDVxaXQ0cXE1eE5CRHFwMHNOVExONFNNb3VJ?=
 =?utf-8?B?M3lsNTE4bE1BQit1QjFTa0FRaEQ2eC9NWEZmREZFRnpCR2FuVFJmZFM1RHp5?=
 =?utf-8?B?S0tFNS9rNy9UMmxRV3dkUUoxa01yM2cyMFIvQzV3WFA1RWZ2bFFoM1FWWCtZ?=
 =?utf-8?B?QVZjNFA2ODZiT2hrSTVXRnpoSjRyNDNnZkU2ZUM1eUEzYm56SW1NTUVSdlFV?=
 =?utf-8?B?dlNrdllNSW1IU1EwM2tGVitFRWdnaHQ4cnRoOFF2TkN4NjdBUSszVy9UODl6?=
 =?utf-8?B?amZXcENpNEZQOEdaalVGQ0ZWSTlmb0xINkNZU2lUSUVVOFdGcmhJSlQ3RUl4?=
 =?utf-8?B?MHd1ZVdoREc2NDZkdGpHaHNCd3paYkxkV01QRUE1NVZ1WHdOS1RsOXF0OEgx?=
 =?utf-8?B?QWZ4NmtRMlJiekZGZ08ycGRyVDFqQVV6M3p6QnI1QjlERWVUaFV2dFhmQitq?=
 =?utf-8?B?UGc0RXJDTmdGZ3o2eXMrZy9FOVhWVzlTY2djNVB6bHREM2ROK1VrR0VYdzJl?=
 =?utf-8?B?bTg5VFVsV2o1c1BmK1FlY0R0R3BFWGxGbWthSjhPWEhPZUJkMi9RQklrS25m?=
 =?utf-8?B?MVhIMUY4Zkttbld0RE40MElwZDRzTzNZNm5WSHJhY1NZQm02ZVRTQkJRbTlN?=
 =?utf-8?B?emtTNU9iVXFyZm15TXJXVDVySzgydUl6K2xMOW53MHJ1MXJVL1pMUDdHdzRm?=
 =?utf-8?B?L1hpakkwVm1RMmRTMTBBS25NbU53NVVJRDNaa05PREJGWklKbXBiZjJDeE9a?=
 =?utf-8?B?VmlQcExBVWpTMXMzM0lZR05WZGFOc0R0MGN4TkNFYUtzVWxjdHBQN1VLbjBw?=
 =?utf-8?B?MkdmeW1QbDJHTCtVUVFiTnBLTVM0R0NuKy9YUGhMUWZ2Q2RHanFQdVlHZjJS?=
 =?utf-8?B?SVhta3JLb3MyZ3ZVa2tPa3hlMGhUMExrSGhkQm9KQnR5ZEJWanpQRDZzVGhW?=
 =?utf-8?B?STF0d1JGc0lpYW5hRVpqZHNOY21GOWZJRjNNekRiVVE0U0p6UFNoZXFlVlc0?=
 =?utf-8?B?eGdLcXdLZW5oemUzMmVxWm1BWGVXZGVadExrbkdPeFBwaEUwWE9Ea3NOcDBH?=
 =?utf-8?B?QTFWalZPc0NZbENnaEEzc0dMQzNuK2NXMkRtbFVVVWQxM1o1VGUyN0RNWjlh?=
 =?utf-8?B?d3o1aG5MVndqM3pkMy9SeE0xcHBhbDFUakNsRHFIMWlBTlhEblMzYUNHNW9O?=
 =?utf-8?B?ZUxUNVdKY3gxakJkOVc4dEVtUkZTbnkybzZoRFBTTThreFc0Wm0wbFhYZGlv?=
 =?utf-8?B?MzQvODBqaEE5ekp5bFdOZVo2V003VHlWczc0aWI5a2dUcjMydGJ6WnR4Q1po?=
 =?utf-8?B?U1ZjZ0dkdFZQZG8zWURLRDhkWUx6TVJlbThLK3JrUTVsRXpPdU5wSEtEU0Rh?=
 =?utf-8?B?ZzRhZ09XYkdlem91MXU1YnB1dXE2SXQydi9TRWp5VktmOEZTV2ROK3ZxZHpS?=
 =?utf-8?B?WmEydDV1SE9UYkR6YW9ZUTlwSzZqc2tzSVNCWTZtZitDSCtKckZvWVBrUzFK?=
 =?utf-8?B?d2s1d0VTcy82T2JsRU4rV3NIVUlJT3RDOVNOdDA1dGplN1BJenRpUlY3YkpI?=
 =?utf-8?B?Z05xYnlSd3VhRWQ0UHVHb1QzVDNkNDNLVHBISTR3MG5nNXl6OEN0cml6NVZz?=
 =?utf-8?B?dm5INVhpVzE1Qytidm9NWXNnbW80MEJFWXZPdWQ4TUV3dDVJYUU0SnQrWUFM?=
 =?utf-8?B?YmFIZEhiRG0vamlpdVVIVEdWNlAzMCthcEZMZ2x5Qzg5N1lrN21qSVFEbFhX?=
 =?utf-8?B?NHJUaytvcDU1V3hlTFJBVGRFUmR0eXBSU3ZPQjJhT1pJdUNyRUE4RlliQ3Br?=
 =?utf-8?B?ank0QkZTVVhRbzVtT1ZxdEw0Z21oc1ZXOS9ZSFJWL0sveTlZR2RFK2VuVll5?=
 =?utf-8?B?L0QyTXlxTm9LdlFCd1B4YUMvWXV2OUVpVzFXcnJvNWRiRmNqNGNXcmFzZG9L?=
 =?utf-8?B?Nzl5MHhEVFVPWDQwc0Y1WkdSR3ZFSE8vd0pCNUN6RnhUNUdHOHJZT1ZYUkZl?=
 =?utf-8?B?SHc5Y2dVeit0SEtoU05nQkFVNkFmTHVWVnJxLzB1VngxdThGcEZiaDc1OHZv?=
 =?utf-8?B?dDRTb0JISHdzQWlUNG05aWIxNFdkbm1yU3BKL0JGczExQVdPeUZHZDRGdjJy?=
 =?utf-8?Q?xrnrCc2TEBJVJ7TX4F53I374x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a627e31-288d-40b2-6372-08db0ff99b0e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 08:41:32.9022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRvVqbCXPNAA6BD4cAaEIKE/942SJV3LGQPPNV9OoFEj9QkxZZtpjVsw88loRLRZateIXSyIY6Oy1LbGAOigFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-Feb-23 10:25 AM, Bharata B Rao wrote:
> On 13-Feb-23 12:00 PM, Huang, Ying wrote:
>>> I have a microbenchmark where two sets of threads bound to two 
>>> NUMA nodes access the two different halves of memory which is
>>> initially allocated on the 1st node.
>>>
>>> On a two node Zen4 system, with 64 threads in each set accessing
>>> 8G of memory each from the initial allocation of 16G, I see that
>>> IBS driven NUMA balancing (i,e., this patchset) takes 50% less time
>>> to complete a fixed number of memory accesses. This could well
>>> be the best case and real workloads/benchmarks may not get this much
>>> uplift, but it does show the potential gain to be had.
>>
>> Can you find a way to show the overhead of the original implementation
>> and your method?  Then we can compare between them?  Because you think
>> the improvement comes from the reduced overhead.
> 
> Sure, will measure the overhead.

I used ftrace function_graph tracer to measure the amount of time (in us)
spent in fault handling and task_work handling in both the methods when
the above mentioned benchmark was running.

			Default		IBS
Fault handling		29879668.71	1226770.84
Task work handling	24878.894	10635593.82
Sched switch handling			78159.846

Total			29904547.6	11940524.51

In the default case, the fault handling duration is measured
by tracing do_numa_page() and the task_work duration is tracked
by task_numa_work().

In the IBS case, the fault handling is tracked by the NMI handler
ibs_overflow_handler(), the task_work is tracked by task_ibs_access_work()
and sched switch time overhead is tracked by hw_access_sched_in(). Note
that in IBS case, not much is done in NMI handler but bulk of the work
(page migration etc) happens in task_work context unlike the default case.

The breakup in numbers is given below:

Default
=======
			Duration	Min	Max		Avg
do_numa_page		29879668.71	0.08	317.166		17.16
task_numa_work		24878.894	0.2	3424.19		388.73
Total			29904547.6

IBS
===
			Duration	Min	Max		Avg
ibs_overflow_handler	1226770.84	0.15	104.918		1.26
task_ibs_access_work	10635593.82	0.21	398.428		29.81
hw_access_sched_in	78159.846	0.15	247.922		1.29
Total			11940524.51

Regards,
Bharata.
