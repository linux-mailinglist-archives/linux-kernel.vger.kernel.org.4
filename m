Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC36921AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjBJPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjBJPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:10:25 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79635FF28
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:10:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV7xbJYfHtswz1Ik0iGRKoQHXIGArRdwpCKybsFbjTNTtmfSuWh7qE5LvTL4Jyri5fyM+LGOBhzoxgwBdmfZuWFyX86D53V1ijTEnGim2lcAAwfHs9ee1UVvVLXc9JXAgAgdQtFz/L9qwblExBD77XPsUxJRIjU27FY0G2/WyWy1dWxgAXw5XDhjj3Kff9wLLNufTSJV3mg0THJB0OWwEgeIqegsqf3Yrnjpz8hs0XlztETdxtO8+bjB/z5rZBG2l6TiAAAxKDSf6dNu1trfC88B9PH3gNoov9Vgfg3N0+UMs5BAG8774Nr+QLtKIZW296m73sUZjUaxWKjTsJMzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdwMWGxWlkxAayFG5S2QM8X6wQkyv7d0CIuv6HiCmAE=;
 b=XUWfUQXkH1ikepm25PJpeVeJxJqGtjmJ5ek2YFuBfUbmdiAEQhprZjXSdhQlPag7g7RJsi2XrTIecHi8uePyoiVXf6XeX/PmZ7Bfl0Cnr3BwnD85TI+JRKw+5hTOOr+qz2qF3Qo1pKhHKRrlgZzW27Oc6RW/Eqdb0pGPlVNYYl/a+vbA17jZdNHWrRCaC1p7g7xut7YspvtsxvQenTJNjRvMkiNQsyu0W2Wo87gVOsvMICKrR/z67PDuFfY3eSUHSbKR8go3pVUidN1tqHnRLPQ2JGiLbp5vFYYUMahAgCRyqGTCPGuX4jiQHDJXoMIxtAie4CBkghCAJV9uwUvHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdwMWGxWlkxAayFG5S2QM8X6wQkyv7d0CIuv6HiCmAE=;
 b=W2FUr0yi3Kxib+M25STRrFtUg3nIpdvu4q8oWOVrTBrhad7lK8YLxEx8qEEHQUcgtAK30xYkgS+XeQQ1FNNkeF/amUvSg6Dv3UUWqcGthP0I8vci6ndPH/8cAVJPCvSGF+wgmpPJm63mvj9K4cFL06czcxKCTAiKFZxctrUj0NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 15:10:21 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05%9]) with mapi id 15.20.6086.021; Fri, 10 Feb 2023
 15:10:20 +0000
Message-ID: <b7c3407f-beed-c80d-a2f4-52acdb59dff5@amd.com>
Date:   Fri, 10 Feb 2023 20:40:07 +0530
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
 <e0a8ff65-b0f9-1f63-a3a0-2986eb79846f@amd.com>
 <fbd1cf44-3643-4274-5a42-3516d4842830@intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <fbd1cf44-3643-4274-5a42-3516d4842830@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd6f52a-c62b-4077-7951-08db0b78ed0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QXUOoGTGaSSsnjsFODpsJ2NN3plbBfHHEFiM580AWErvUGtIAhYKXsd1w9gzBrW6Mhj+Ons8NOc8pmTVEL+wYT0gmIJrmdc8Mq8CELf7QmrZEj6caweJNMdejzpmM5e7JfU45dFqDxgYaTJlqFnRJOO/qO3gmcalJ+UI9JPq8steT9f+d2JYLO7c+4Yu+nkBkQorl/cxVTrrMXhaJPGv8r3q2+HMsbMnDxmqigK9LGAdzDQd+iOiHHKoRWGp7FOQVOobN1BKgwZpR4hoiwF1EFLxuCLjxIm6Iygi9hLAwJpAGL8Gu/dSzqGd2OTyC6c9P7c8auksgxWEStibSPyNUK6iB4xtM5PZ87RdWIy076dqjd0E+f3vR20XOIpa/ZU+nKHaqGscD5T0OcN8O09rHGSOYwJhKTGmrW75OHIxH922IH3+nCyMY1a8nVe6KNt0uof59NhvqTZAATYZzysbT3aVXG+LoTq25WwFpHeLzSjmPS8xKBpovLKwSq8pWOUaGWkPTnbVCbEeG+JwB9swOKkd/cqygG44QZnltpAc5eMMg0g1eeAnumhNxJPqgY2iQWygeCIbfbd8/+OYbqQfClY57bMxmxcFrIAgAGL+FlhJKxVasoRIdjl7AOAzpQMuWvZSucAa3hJresl9c4usaJtvaNIsC7pOEP04fDecH2zONwAg8qPbhshZJqgDfvdPTZW3/ZlrNwB53Cj4UTzVsQSItbkemknyg7NyUASXy476moiKW8u06ZpUqrr1Au+NvzXYQPJuMetjYCO337j/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(83380400001)(6666004)(4326008)(41300700001)(6506007)(53546011)(66556008)(38100700002)(2906002)(478600001)(86362001)(66946007)(66476007)(31696002)(6486002)(7416002)(8936002)(5660300002)(8676002)(186003)(6512007)(36756003)(26005)(316002)(31686004)(2616005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjA2aUZhYWQ4cUM4dDlKcS9rYXdGRmdLZjYrSWFRbjZSajdaWUU0eVBwMnl0?=
 =?utf-8?B?SDdEU1RJSU82YzVwS1liMFRMcFc0a3YrTG8yYUF3cmFPMmk5VDNtY2dYNnY1?=
 =?utf-8?B?R2wyM1lEMWJtaHJYT094T2VNdWhWNFdFWFoxS3dwd25ZOGdYd0VkUVBUS3c1?=
 =?utf-8?B?dHBhMkpXL3Y1anhnbFJ2dmRxZ2RKVGJUSDNQWkVGUnVlUzlUNCsxYjM5VjNE?=
 =?utf-8?B?RFlOKzB5TzhaVnBhZTRWQlNvdDVNd1ZmSlViSFI5NmF5UHlwZHBOY1pSR0cr?=
 =?utf-8?B?NWgvRExzUis0YkdTQ3VkYTM4emFDRkxMV3hUVlVBclBSekJ1UTR5SUVJOGh3?=
 =?utf-8?B?VjJLanZaTm10dllNMTc4aG42T2hGSXA3WGo5UEJydVBRYXdoa0pNMHBUbVRO?=
 =?utf-8?B?L2pzOXQyL29jRE9FYzdtb3BtWU13ZDdyQVVmNTdsR0NkTHZpbkdqc3F1SnpZ?=
 =?utf-8?B?YjE0KzI5SkNyeEdYSENhUWdkOWQ5b2IzRjJxTVNyKzhZdmk4eGdrdlNuT0Ir?=
 =?utf-8?B?YXlrSjBocjB4VlJpQmZKUitOaDN1R3JQZldlRmIvM1RBMmJFUTM1a0RQYitY?=
 =?utf-8?B?MGUyRjZyNGxmQ2lPWkw5cjh4SWs0WE5zRytwd0ZoYmtWYzRvV0gyMUFSRlgz?=
 =?utf-8?B?VVljZFB3T2QxUVVXRW53MDZaWFRlUHB3bzBWZ2RkWDRYOFhJdTRKTWRuaGk1?=
 =?utf-8?B?U0l4ZDh1MU1WU1JTQXJVSkh6TUVxSVBRY0VjcXpjUmZ4SjQ5Yyt1d0htcWZN?=
 =?utf-8?B?SlNZa1ZyMytXT0dFaXdtSHBSMmpOUUZFbWxOTUlZSmxPa2Z1Yy9TalBiZ3J0?=
 =?utf-8?B?aGNBM2txaEpqYXRhdU5ST3NRSERpRXNMTlFsKzBkTW5aY2ZXSjBQL1Zvd2w4?=
 =?utf-8?B?Y29MU0NVZlY5NGc3Y3dCWW1lTXczNjlXallWR2lJamJWcUJKU3docjdlNnhE?=
 =?utf-8?B?OUE1Q2E4dTVOTWE2S2M3YjVEYktRZ0dhUXBxaXY0T0ttYUVpSkVPbm1jMFVF?=
 =?utf-8?B?WDJBVnRuK0paczlHeXVFS2U2azNwTnF5UmlQMEtBQ1ZKMys2SGxWUThtcDVh?=
 =?utf-8?B?WGwxUmgzZ1FXcVE0OVpJY1JJOHRLb0hGZVNnczBrZEdYTER6eWM2cG5FZGdj?=
 =?utf-8?B?TzE3SmJKbzlOZ0MrYlVmRi9Vd1VGNDhPbDVFUEtjL2U3MjRVZUptV1J3cm1p?=
 =?utf-8?B?Yy9ucmp5YlFPbER5K3RrOWFjSFU0cjUxMVcvcGRhejhTVkN2Y3VodnRPdkNr?=
 =?utf-8?B?c21FbXcrdEpnT1VjTkw4VGt3S0lkd2tuUEhwTDh2b1NpR3ZaQll1QjVLTDJz?=
 =?utf-8?B?bHdtRk5oMHUvWjRXRzNDVEpKQW9WYVhxbWhqOEdxVDBSRm1UNVc3MVNmdFJp?=
 =?utf-8?B?dHI5eHFja3BxYlBuekU3VHlGRnY0NnBxTG91ZHVqaEhqU2pkcFlRWHMrVDFx?=
 =?utf-8?B?QXZNblhXTElpc1ZsZ3VWUTlWaUFORU14b2prMDgxd3JwT0xHSHp1SGVnZ3Iz?=
 =?utf-8?B?R3BIaVMybEpkdVNldS9XQnYyWlhMeVIweTQrK3lhSU1KakYzRE9sVFo4WTFy?=
 =?utf-8?B?SzBHNTVuVjZpT2wwaVdhUlJKcXIrajUzSXI3d2lHdHRVS0ZETUxYbTRrT210?=
 =?utf-8?B?ZHAzcWJwR1VQYlhDQ1RrQ2xWMUJiVGQyTVg1eFFSVEY4eVNOQkJsMEJ3TUZt?=
 =?utf-8?B?RVExTnFhNFRVdEdrUDNqcHp6bG4xaVZwdDhwdXZ6RDJaSUJpR2ZjTit6V1kw?=
 =?utf-8?B?dmlrZy9pUjdabnZPR0VBR21YK2RJbWxaSUlCUFc4Sk9pUjN3TFN1WjlqcE9G?=
 =?utf-8?B?cFYxRVBxUkVIbUdNQ1RjdGRxOVhxQUpEMUdxS3hsZDZQUGRmMEl0c0ltbXNN?=
 =?utf-8?B?bCs1N25Ed3JHVG9RV25UVXUvQ043QmJxcVhwaklmclppNG0rZVdwZ1FSa3R3?=
 =?utf-8?B?Q2dXMUsxT0pGTWxrZHJLY1hLTmU5Y0wzUjR3WnZrci9RcWdEQk5tMG5rcUpx?=
 =?utf-8?B?L3B1Q0R1WXM4UTRQM3FTbGxMSk1nTUpUeGRTNkx4aFFRYjRkR1AvVEFFYTM1?=
 =?utf-8?B?ZmN6VkhPck04SmhLeVVnQ0ZDalB1QkxUQXdyOTVqaktqMkx2b1lZL1N3WHdY?=
 =?utf-8?Q?7TvFmJhsLnf/DLDKUp27fsCh8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd6f52a-c62b-4077-7951-08db0b78ed0e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 15:10:20.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXtfFR7D7Xo/ZESIk0xOBhGvX33JHv6QsMregKeMbCqLnsryJ5LR0aCG1OSyY6qsTn4Ty8/uX+iL7wfGLhZ13Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/2023 10:10 AM, Dave Hansen wrote:
> On 2/9/23 20:28, Bharata B Rao wrote:
>> On 2/9/2023 7:58 PM, Dave Hansen wrote:
>>> On 2/8/23 22:04, Bharata B Rao wrote:
>>>>> First, IIRC, Intel PEBS at the time only gave guest virtual addresses in
>>>>> the PEBS records.  They had to be translated back to host addresses to
>>>>> be usable.  That was extra expensive.
>>>> Just to be clear, I am using IBS in host only and it can give both virtual
>>>> and physical address.
>>> Could you talk a little bit about how IBS might get used for NUMA
>>> balancing guest memory?
>> IBS can work for guest, but will not provide physical address. Also
>> the support for virtualized IBS isn't upstream yet.
>>
>> However I am not sure how effective or useful NUMA balancing within a guest
>> is, as the actual physical addresses are transparent to the guest.
>>
>> Additionally when using IBS in host, it is possible to prevent collection
>> of samples from secure guests by using the PreventHostIBS feature.
>> (https://lore.kernel.org/linux-perf-users/20230206060545.628502-1-manali.shukla@amd.com/T/#)
> I was wondering specifically about how a host might use IBS to balance
> guest memory transparently to the guest.  Now how a guest might use IBS
> to balance its own memory.

When guest memory accesses are captured by IBS in the host, IBS provides
the host physical address. Hence IBS based NUMA balancing in the host
should be able to balance guest memory transparently to the guest.

Regards,
Bharata.
