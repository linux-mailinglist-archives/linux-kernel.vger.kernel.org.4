Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938DA691795
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjBJE3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjBJE3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:29:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9B06B371
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:29:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3+FDn4Q21idHSdo7GPj6fG8Ohnw1vK2OKL0b9D+zzt9IDnum+tEmwN15t87hA1tt6TGha2TsUqmTFDFWZt4CRZFNvdVy3gKjmZboqsCii5lGZ8McfmpW4PQATszhEJiS/7LpLzGspX3wCwp6G09dn296jS008kt7ovVlANMnLwwZgDYZJFsGfE6uLeCXFRNUkcU2+4kAX6QvdVU4UOhTlFQfKUcqZyQcff7ClnXyzLB0Zv7w4ZRbocwKt3WoQX6S1XztIMkFSKe1shLrjTFbkRJ+3C7WMRjo3HvH9M/ug6m8yZHsXvp5b8ZaCmQU+IXVAZmsXyFMrsC3kzfpkarbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhEAriU3tZgU79/oxsD6M6VZbQQ2WN8lzM0cT1xmL5w=;
 b=Jup3n0VC6V5hvh7ACGD+hT653cd8wUhZ7ayYjnb+Sj+2FTOa+e9TQmbthT81nY1pQ8a4S2KK85mcG0b9bg73+tUVPfXEQJMFzJ1rJtsJSHnyn/ncCaLRB7YXTyGJDzhip3TFRTB879w0kJ3GuIGJfgwBo8uYGWAXPiKgV0z6drvWrqQWg7+7XmsJh8hfMHFL/CovBIcKGRtKg+IwulELeaFpYPgPjv6zhNxARE/Co7Wy04m62nn+SojutEUpTuvE6d7ytjvH6UQ5rjSk3kHI8XoTCKT3xkxxdr5hbLfvHrak+aM6z5t6pMtb7sECQqTPqkLPa+thZL+p102KChx7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhEAriU3tZgU79/oxsD6M6VZbQQ2WN8lzM0cT1xmL5w=;
 b=YyQaV96pCrLdh7xNeNSbz4GZPPfnOx57jhe3EEQIM5ebd8KsVUpMwhAHfFAGF5d4H4jJqI9uI9v2BMU6qt/Nrb2DlG8Fn2CpAqJFJJWDEZgBgmaau8RHRqCDoW+ad7+Z5ii1qPU2sK/33nazbRA3XICnhDzB2RcByjRtQQwezvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 04:29:10 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05%9]) with mapi id 15.20.6086.021; Fri, 10 Feb 2023
 04:29:10 +0000
Message-ID: <e0a8ff65-b0f9-1f63-a3a0-2986eb79846f@amd.com>
Date:   Fri, 10 Feb 2023 09:58:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        tglx@linutronix.de, yue.li@memverge.com,
        Ravikumar.Bangoria@amd.com, ying.huang@intel.com
References: <20230208073533.715-1-bharata@amd.com>
 <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
 <4808d3fa-bb68-d4c8-681f-0b2770d78041@intel.com>
 <369bef08-92cc-9b55-823f-1fe780532967@amd.com>
 <9848226e-2574-b8e0-4fb4-316957f57fb5@intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <9848226e-2574-b8e0-4fb4-316957f57fb5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 71cb9491-7e52-4bf8-4fcd-08db0b1f5a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H279/G98hFVzHpvVTrjGf0ihpbDMb+MGndPjEvES86QNGR6jnSYPbU0gCZISR+opD9uxRtJVZn8fSKXDYaMVJt7/cYy8s73OdBSW805XA2wLv2BQt5EePhwY2GMl8yTGy3VlsX3TIuLys0LbeSKCAo7EtD4MuPDnVuTCKNR1bxbRzXHJMdcD8VFigMcZX2phe5WhxJH0VkygT9N0B4IEx2tPZ9VbykdNWze0zZINY2k1LmHoj+XAC2YoPrz8+J+N2iUZWbrrZ7jGKZ0TF1bZ3+1Yh4HAEpHEHNU121Kl2S6kjHaLK6/zbQtdyjzn9X1dgiorMue0yZAC5x5nZ2GeGPrIRdgqsCOLz9KeF2dH4SqyJ+0FQ2/32FEr73nTWpBAmyu5cbl2hEzPWjVfrK28+O1yIClP1e4cxZW9H0fDiKNLWM4kYiN4bqo8F320rTbXi2KJkPlzqT8JqnhQEddD58TjFpeuSvb0JyXNTrxUxrl9lXgqP/VQZbVXyGNi5UegsW1Y5G+3zusQCTv77lFyaxc7zb0NPg9oB6xv5bBHoE0aA1MPBM4MkShe5aVzEV1h750Hrzyb+3q46oZ4Ee/bhdEEtW0eoWBbkJirTfobTaRJkxLIbl2DAidhzgwTlDUM3SCT0ksm6NlEANZMNQhlzkBAP98o0LHN8cFamvGVws/m96+Wz9LNVIbHrSjkvisX6HsGH5WPuaO6NZIujAGDXMKC+kLNtUfI3NdpxM3VZwU1wSubZHTt37Wo0svz0xxPXDdlgHbJAtw0UMXrPPiUfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199018)(31686004)(36756003)(86362001)(2906002)(7416002)(8936002)(5660300002)(4744005)(4326008)(31696002)(66946007)(66476007)(8676002)(66556008)(41300700001)(110136005)(316002)(6666004)(6486002)(2616005)(6506007)(26005)(53546011)(38100700002)(6512007)(186003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnZzdkQyeENLejRLWUwrelJyRm5hb0t5cnExYTlGdVI0WmszZWh1ejFJWXZQ?=
 =?utf-8?B?Lzh3dmRlMTdwcG1VOVJabm9JZExhTThKZDF1YmcweXF1ekxxNmROcFJQaFVy?=
 =?utf-8?B?Um5KaDJ6WG1ORGUvcVdiUGRjczBrQVk2V0tnS2p6OFd6bmVuaTJPczJZWjFI?=
 =?utf-8?B?WStObHFRcVlQRUUzUnhXRlRMSUhOdjVJbnovWkp6bzFjZ1prZjZwaDFQQVJh?=
 =?utf-8?B?UUFoU0Q2VjViQS9nT28vYmRJTXg5S2lNbWdEdEVtZEp5TkRVZU0yTWNaWnBD?=
 =?utf-8?B?OVhiM0xURTRIRmJkR0ZObVFGWHVIVU9LL1VHaW5YRHpJbjNlYlk2Nk0zMzh2?=
 =?utf-8?B?Y1hrWWZKdjNpdVFYNU1ycDNRRnROL3B5OUM2UVg2a0ZPN1lRN1N3UnBlN1dT?=
 =?utf-8?B?ekliSVhobVhXR2RZQ3lTRXlCenkrNEtxeEtZNk5XRVZmTXhzR0lVb1JjL0RP?=
 =?utf-8?B?V0pmQzFEY1g2QUM0ekpaclBUc1c2WVRQTmJJUXlhRm40blR0V3NjYWFRV3RK?=
 =?utf-8?B?WnppbkE1QkNIM3RINHg2NHg5Z3VzZVZabGZPeVpiOTlWTk42bXZ5VUlQU0dm?=
 =?utf-8?B?UEp6V2tNOFE1d1NJamh6ZHRyMVNmK0FLclRlUEhzMkZzTm9Dam8wblhIMDhu?=
 =?utf-8?B?NS9IRWpVb09lQTRRdm1wNHlOQVpuNGs2Y3JQbi9hT2pEQ0pWc2kvbVI4OExT?=
 =?utf-8?B?RGtYVTBqYnFtMWdKNzBkSGhqcFFxdjNYSSsrNGtqRW90VmhWSFhCZDI5Q0tH?=
 =?utf-8?B?Qm1EWHEzc0pJTUdGVUdHMjNvQ1F2YklWWEUzWnBrM3JUNHJTdFFQdTV4UnhE?=
 =?utf-8?B?eDN6dXVDNXZXczJmOW12aTRkcWp1aGU2cVpJeC9STkcwUE5nbTdHbU5wTXFS?=
 =?utf-8?B?aWJpZ1BESHllU3kza2JZVktaRkI3SWd0RVcrcU1OR0hGSWlGQnRQbUhlRXFp?=
 =?utf-8?B?OW1aNVI3RTFhRG14RVIySlhQVjFJaHIzZWQyYVk5VndXL1Q5UWFSNTZpZkZE?=
 =?utf-8?B?UDVHODA3WHB2dExPbURjWHJ0d0hzZWZtampUQ1Z2L2RmcllHUVpNeFJmQjMv?=
 =?utf-8?B?TkJsbXpNemd0NGw1TnBRS0Jubm1yTWEzZGNGTllmTyt2RGpFSk9zeENsanFD?=
 =?utf-8?B?UVhZYmlxSVcwYk8weFlTNnp1bkZ3NlJiemdlTkgxWG54VCsyQmJtcW5rNzJE?=
 =?utf-8?B?L05EUStmL2ppMHE1VGduSWUxNlgzSGQzaUdoZ1FzR2RycUxqU2ZXWG9NUEFG?=
 =?utf-8?B?dVlIY01wRXc1MnpLOEY2R0tETHVCMlJLWGhpVUNreXZjaDcweEo0SjFJUEVq?=
 =?utf-8?B?ZU4wemo2KzYyWFk0bmpoS1k4SUVpaWo1Qi9EMGxhUVhhZ0RoR05zK3BRdTJ1?=
 =?utf-8?B?L1IraWNBc0ZEVWFjcWxVR3N4aGdZL0dqTFYwem0yK2ZmTXRMejRtZjJFalVN?=
 =?utf-8?B?ODZUSXE3VHlrRnNMM09zbXhUcWVLT3QwZ3lDMFcwSHRvOUt1Q1MzT3pFdXZ1?=
 =?utf-8?B?RWhsdHhQMG03MUhER29GRkdZVnVGaFkvSVc5U2owQTVzNDBadVVzbm90cUlx?=
 =?utf-8?B?QWZjdklka21qMmxBaUZwOFc3N25SWFRnNWhSSUk0TkswbEdwbjVmQTdIeENz?=
 =?utf-8?B?OWFYZ0pFQ3YrQ3l1aThTcmtjdUJsMlBaQkg0SXdHRTlsdzlaYnFpWmowTjBS?=
 =?utf-8?B?aDNjNlhXWllzdWtRbjF3YzUrWDA4V21TL3M5c0g0d3dRcVhVMHd3Yzc4S3V0?=
 =?utf-8?B?K2w4YzYwa09sUHdXMEZiWFBJZmx4TEc1NTRPaHNKUk9KQWFBeVdlaWNHOEEr?=
 =?utf-8?B?bE1BcVM1Sy9JckxBSVJwWlplRkZyQTF4U2QyWmFJUklDdFppQkRvSWFaejlT?=
 =?utf-8?B?R1VmRWF6ekZYcVF5Q2VLNW9aUFJMaDBZcHZxazFiYnlac0lJU2RzMjc2QkU3?=
 =?utf-8?B?T2t3blN6aHNDNHZqZ3dwd2JSU3QwcnJVeU5zdTRYd056UnczVUFLaDVtWEVr?=
 =?utf-8?B?R3NWWDlFRE96ZWtTZk1PQXBHL0xTenRZbGNSWHc3bjAzNkVwMXZPUS93Uk10?=
 =?utf-8?B?cnRvNTNNeTBYZVh2NDBpbjBEKzR0M0w2d1hZa1pMWTZvVE5RVnhvZ205Uzd6?=
 =?utf-8?Q?MTM+i+cfFbjSIOrJ+qkh9Yc2P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cb9491-7e52-4bf8-4fcd-08db0b1f5a8e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 04:29:09.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i47mjXHS39ZagPsZrbgHePqH+ZRz3JpiDlSR1qj95/9okEv/f6U/WvJc8Zcj8ZdTvxyZQKdXblMBwjpT709VOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/2023 7:58 PM, Dave Hansen wrote:
> On 2/8/23 22:04, Bharata B Rao wrote:
>>> First, IIRC, Intel PEBS at the time only gave guest virtual addresses in
>>> the PEBS records.  They had to be translated back to host addresses to
>>> be usable.  That was extra expensive.
>> Just to be clear, I am using IBS in host only and it can give both virtual
>> and physical address.
> 
> Could you talk a little bit about how IBS might get used for NUMA
> balancing guest memory?

IBS can work for guest, but will not provide physical address. Also
the support for virtualized IBS isn't upstream yet.

However I am not sure how effective or useful NUMA balancing within a guest
is, as the actual physical addresses are transparent to the guest.

Additionally when using IBS in host, it is possible to prevent collection
of samples from secure guests by using the PreventHostIBS feature.
(https://lore.kernel.org/linux-perf-users/20230206060545.628502-1-manali.shukla@amd.com/T/#)

Regards,
Bharata.
