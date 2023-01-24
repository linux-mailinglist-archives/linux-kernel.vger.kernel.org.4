Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EC867A279
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjAXTSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjAXTSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:18:31 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2812F34
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:18:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW1jWvXNsY2gSSn5MrWhv2UdO8LuTEufsi6osNt2IG38yFgeRHOee0c2meWxJXxchJa1A9xKmnA1/aEebDxecKea/jS1NWtspRJjGdgOTV4tC1Ramj+LeenAVMQ7DDDIZNvIp8ne1CqxsYfSnY+ehjWfC7QZeufebdKCo2dgarPK3FQu8gfqK4OmDemNVADlF+AlcNCDlsXJmigdiHKxGbLW3LSZ03t68jjJ9XFcUmlvHBTVl89zRAO8/OFRhHtcFhmY1ZkjTTgeIMWtsMmrs2dDHzur0+Tgm8zxbzN55zekBG1Olp2tcerir6OZfC5RrTjjaMInQ8ObmxbWH9cJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK9ziHX6b7SN37xTENZz2ELxxg4X0BvedyNtB5bnErw=;
 b=iUB0M34jghSCEUVNF0I6vwu5QH/EUKiK1L6z6p/8VPK7oWh4/g36sdxI+8xXCZzWbSq5pDQHIAjLb/IgatR7nca17qQaXu7TsX5Gpux7UwPuQGneegAwTqVMWLl74mwG6n5K0yyR8cmBQsKxYfKh2MqlzCOX9pnBnvcfSv3s3Af3KH54Qxfx92EwQBx5HlV/yMZs+LxekkcBFuFN43eEMVn5JNQkxXcUbDnZxVkX/X83+jinI0JpquMlHdT7MXR/R5tgKqBpAzbr0ZuNYNunz8WBSOvHW3PWBBRQHKs9qX45tV7m4JoX/jzU/GzPs2Wn9Snhj/NriqMAweOkIUey7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK9ziHX6b7SN37xTENZz2ELxxg4X0BvedyNtB5bnErw=;
 b=MoG0tZAE8vpfhmLYnwGfFrtJk+20dYZrFklCf0R+qyhekGUdUTAmJ/PwAgpZLR9ihrbyE9FIJwt0NkusAABeSGk5R4a5ihx275iAkY1QpzZ05mYVOxvjrs8RjcDgX1ob/Gdlkvs4TpQPtYRO1QtajSQff7AqYPjZYJ3ruDWYtiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 19:18:28 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 19:18:28 +0000
Message-ID: <118c2f4a-58d7-de42-1f77-31ac8a4d4701@amd.com>
Date:   Wed, 25 Jan 2023 00:48:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Content-Language: en-US
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Mike Rapoport <rppt@kernel.org>
References: <cover.1673610485.git.raghavendra.kt@amd.com>
 <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
 <20230117145951.s2jmva4v54lfrhds@suse.de>
 <10a06a2f-0dfc-6f36-3b7b-f4fd03153f66@amd.com>
In-Reply-To: <10a06a2f-0dfc-6f36-3b7b-f4fd03153f66@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::6) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 94630efb-4a70-49eb-2dd3-08dafe3fc577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ab3U6V+Ji9E46CDNbAzzvJIMaU7r6Isoi6yss2Vii1SsOXuZCv/0kDPFipMuGjbdgB11KHmtAuE0FXCzQObPnYK2ON6lo3WGONxHxdwCS1iKmQUrGvyzvQcZCu8zCbzoNkDmAstlXNlm+bGVrCOCAyVOlJpjQ5Wc5QVneJU9CQl3wUnzp6hc4tjnAXD9zw7YGQWwCtjfjTVnyBlcmgLvGf0NVgFLyS+nbOe8kQUgZA13tMMiHOgi/3G3lDa8xqt1ZVFwLqx7rZTayVLK75JVYRUQRVtd2f6HD5RfxwUVHkRMcs7IRN4zvngXyJ5ejFcxzYQ4SOpnJOZydO5h1hxebyHdOhnP42SAEyxq46azdbgJHLWp8z4quB5Z47VcPpdl8IVAAFJKDvoHmvSPikPwKsIAmDdhoOBo0BfLuFbIzFy7mWw9Uac2sTXUTsyIWtEQ4nPqd4POV1XsH3WR1OE1kORbwezEc0lmHOVfiRDkPrwV7a/4kcRfU6QteROwh3+XQeH/RBhZ4KXs665RAFe5sAMT4QoFZIdZo14Ske1+sCxE3Jp45LDoTngbuOuYMTxvPCQLoj2i6zwh33Sj/pzrYoOA73aXvUc8kkct57qAWUCsOg6Tc+Uwvcznydm2A32eCQLNzMXXm9DRz/msvrjN9Re7zFHPC7l13aeQItA1uBreUAUT6eOZtYDcfMJp/VGVV38f9rScHa5N35fUKeB4VGyd7mQvlTq/HNXz5Kd0CP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199018)(83380400001)(38100700002)(5660300002)(41300700001)(2906002)(4326008)(8936002)(316002)(6666004)(6512007)(6506007)(26005)(6916009)(53546011)(8676002)(186003)(66476007)(66556008)(54906003)(2616005)(478600001)(36756003)(6486002)(66946007)(31686004)(31696002)(45080400002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXpDWXFWL2lGUnNBclp4NWhOVFIrSnptVVBtcXgxaE9IaWJydDlDUkdIZVdV?=
 =?utf-8?B?ZXVmZGxpRzl4ZXFpZ2FwcFlpYWowMXBVMFBZd3hqb3NSRzNIbC9zOEJnRFpy?=
 =?utf-8?B?Uy9FSm9Sa1JLWHNOTlN5bG1YTnBuakpJRjkrL2NxblB0TWJEQVJ5TUNZQkJi?=
 =?utf-8?B?WFArYnhqSzUxVm5Ed1NDWWh6OWp1SFZ3ZDU2TGVJMStZQTdpSXNrZFd3Z0Fy?=
 =?utf-8?B?ZzduSW9LOXVjVC80R016RDhpb2pOMkZtZXA2R20yUklIQTF1UUNRdTFsR2ZU?=
 =?utf-8?B?a0lNRy9JdExyZWp3WnRNc0lzMFgwQlpvRGVSem5SU1drMURuUGNMcytJN1JS?=
 =?utf-8?B?NEhGOHVwdlJUV0dMMkc4aGVtR2lhNG9zd1hyaG9pMGNCcTVtMk9KRkJzdTVs?=
 =?utf-8?B?cnNBOU41ODhKWTZ5Vms3MGVYaXpJQ1ErWVRSQ3J2NFVYTzhzVkZiclJaalhF?=
 =?utf-8?B?QXhnREJZV2NtUGVORmdERVNXdUo4VmVPTldTaFhPd2lIMm1aMzVGYUx6ZktR?=
 =?utf-8?B?QytLelcvR2NtNEVzdXo4Wm1xNDB4eVkveGhRQ0hYNWJFbVJaRUhIeElSdmpn?=
 =?utf-8?B?OENkOWNQOXhiRjFxT2dkZWpqVnpQOUVSMXlnOEhyTWtsOWdkeDBsSnErelp3?=
 =?utf-8?B?UHJRUStTeUU1U1ZjWjI4ME5jWUdWV3ErQzBMRFI2MnlYZWRkRTdiMW1CeTZa?=
 =?utf-8?B?Z1paaEtlMXZaY3pPODByZURCbEYwKzRhU1JwaEFGTGJHa3c0NWl2ZFY2aXRw?=
 =?utf-8?B?aXAvNSsxeGRRLzhDQTBBL1BGc3o1Nk8yT3JMYm1BcjVkcEdGWXFaWFMyRGdZ?=
 =?utf-8?B?UUtoWERGU21TY1F2WUtra2lTYTNuelhmUVlwaWdQU0t5alpHZmVJZWRpNmhn?=
 =?utf-8?B?VDMzdktSWXoyckJ2SDAxNEtHRldmWmJ6N1JBdnhXdzBKSkVBZzdMSXZsdDZD?=
 =?utf-8?B?K1B0ZlZrUFNyeThwMFBCazZjaDY3WU95YW9JcDNCRXI3aUhyMnVabmFWdjIr?=
 =?utf-8?B?RW9iSEkvNkhDUnB0dkROcFhiYm82V3Vpdk9NZTlTWmhyTjRTeVRLU1hNZUVO?=
 =?utf-8?B?dnhHYmJqTlJaUStmNmgxK1dweXpoL0IxYzFCQnZrUUZtVUVkaktyZ1ZaUER2?=
 =?utf-8?B?VUV1NVgvS0RTNitNU252M2U1WjlYaXZGSU02eWo5UDRqa3kvbmZVdENEYzNr?=
 =?utf-8?B?RkNtSTBUdFp4YkVuUmNuVFdCT09FbmY3c0d1QzRiWVJOMkFmRUxWb21zVXRu?=
 =?utf-8?B?SStDaGZCVnR0THJzR2JaUWM3eW9ldk9KaVNZNFNZbVpHeHZ0KzZHZUkxU3hL?=
 =?utf-8?B?dkhKWEQwZDdUREc4dS9uNXdFWXZVaHVRbEJGdmVqNjNWeXlHMmJNbFU5TG9t?=
 =?utf-8?B?VFhjMnNSRWNORjZhQ29CNmFhbGJYdlJ1QnluemNFaVhpSnZYMUMzb3hnV2pE?=
 =?utf-8?B?SS83WWtDSDdNNmZGR1FxUVhuQ2hsT25LSk9YYzVPU3orUS9FRDV4ZjBxN2o3?=
 =?utf-8?B?N0VIUXc2eWRPMGg2WGtiR2RNTE1haTRya3NUZTZHcCsrSXlSU2I3RDRrY29B?=
 =?utf-8?B?c211RGhWZU5wU05aQUFEanBhUUxkbGR5blljTjZWVld2NTdWeHVTc1MzZ1BB?=
 =?utf-8?B?T3UyYmlSVXFnZG02YkQ0SVV0UWRNMDFhRkM5ci9meXkzRE9PakxreG9TOTRr?=
 =?utf-8?B?Wnl4Q091TExUN1Q5YTJZNFVMRERHZXIvM2ttVFN2ZnA5Zm9mSDlTcDcxb2tT?=
 =?utf-8?B?YWtLYXhJd0pmb0o5TU5aTi8vYnZjSVMvakUzTlJTd2ZZTWtOVk5kT3ZKV014?=
 =?utf-8?B?TjBIV1VNSkhwbTJrZWt6NFk1ZU1uZHFKMTMyM1VzcGJ3OGxSY0RlSmxtREp3?=
 =?utf-8?B?ZEh4ekpsc2dXd0l6RTdIOVIxS3VBN1JucHY0ZEE1RXZqblBLa2lwV291WHZL?=
 =?utf-8?B?cFJFMlVRbnk1RGRJUWFTQUg2cTRTZzFLcWtDem50MXNyaWFWZzJVQ0RRSElJ?=
 =?utf-8?B?Tmpob3BuZkp6TGNET1dib3ZBQTYxdDJyM3NBRTdpZ3BMUWpsNDlmSjdJWlQv?=
 =?utf-8?B?NGFYRURBNWlTTmlVbTJjZFMvaU9QWGRoOGxTMlQ2Z21RSHlDL1RtY2x2WDl1?=
 =?utf-8?Q?YWJIYtjySKm4S6UQ9wYUVSpug?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94630efb-4a70-49eb-2dd3-08dafe3fc577
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 19:18:27.9725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56FruhJdxgp1kZQOp6jpEvQzZIOVtCgC2fFeghNUeKPFFxoAH7wLAFO7HJoT2dmaXfxZ4Zkdm6E7k5xlI9604w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2023 11:15 PM, Raghavendra K T wrote:
> On 1/17/2023 8:29 PM, Mel Gorman wrote:
>> Note that the cc list is excessive for the topic.
>>
> 
> Thank you Mel for the review. Sorry for the long list. (got by
> get_maintainer). Will trim the list for V2.
>
(trimming the list early)
[...]
> 
> Nice idea. Thanks again.. I will take this as a base patch for expansion.
> 
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index f3f196e4d66d..3cebda5cc8a7 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -620,6 +620,9 @@ static inline void vma_init(struct vm_area_struct 
>> *vma, struct mm_struct *mm)
>>       vma->vm_mm = mm;
>>       vma->vm_ops = &dummy_vm_ops;
>>       INIT_LIST_HEAD(&vma->anon_vma_chain);
>> +#ifdef CONFIG_NUMA_BALANCING
>> +    vma->numab = NULL;
>> +#endif
>>   }
>>   static inline void vma_set_anonymous(struct vm_area_struct *vma)
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 3b8475007734..3c0cfdde33e0 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -526,6 +526,10 @@ struct anon_vma_name {
>>       char name[];
>>   };
>> +struct vma_numab {
>> +    unsigned long next_scan;
>> +};
>> +
>>   /*
>>    * This struct describes a virtual memory area. There is one of these
>>    * per VM-area/task. A VM area is any part of the process virtual 
>> memory
>> @@ -593,6 +597,9 @@ struct vm_area_struct {
>>   #endif
>>   #ifdef CONFIG_NUMA
>>       struct mempolicy *vm_policy;    /* NUMA policy for the VMA */
>> +#endif
>> +#ifdef CONFIG_NUMA_BALANCING
>> +    struct vma_numab *numab;    /* NUMA Balancing state */
>>   #endif
>>       struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>>   } __randomize_layout;
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 9f7fe3541897..2d34c484553d 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -481,6 +481,9 @@ struct vm_area_struct *vm_area_dup(struct 
>> vm_area_struct *orig)
>>   void vm_area_free(struct vm_area_struct *vma)
>>   {
>> +#ifdef CONFIG_NUMA_BALANCING
>> +    kfree(vma->numab);
>> +#endif >>       free_anon_vma_name(vma);
>>       kmem_cache_free(vm_area_cachep, vma);
>>   }

while running mmtest kernbench on (256 pcpu), I have hit BUG(),
(not reproducible in normal boot flow otherwise)

[  716.825398] kernel BUG at mm/slub.c:419!
[  716.825736] invalid opcode: 0000 [#146] PREEMPT SMP NOPTI
[  716.826042] CPU: 232 PID: 364844 Comm: cc1 Tainted: G      D W 
    6.1.0-test-snp-host-a7065246cf78+ #44
[  716.826345] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 
2.6.6 01/13/2022
[  716.826645] RIP: 0010:__kmem_cache_free+0x2a4/0x2c0
[  716.826941] Code: ff e9 32 ff ff ff 49 8b 47 08 f0 48 83 28 01 0f 85 
9b fe ff ff 49 8b 47 08 4c 89 ff 48 8b 40 08 e8 a1 c5 cc 00 e9 86 fe ff 
ff <0f> 0b 48 8b 15 63 d6 4d 01 e9 85 fd ff ff 66 66 2e 0f 1f 84 00 00
[  716.827550] RSP: 0018:ffffb0b070547c28 EFLAGS: 00010246
[  716.827865] RAX: ffff990fa6bf1310 RBX: ffff990fa6bf1310 RCX: 
ffff990fa6bf1310
[  716.828180] RDX: 00000000001000e8 RSI: 0000000000000000 RDI: 
ffff98d000044200
[  716.828503] RBP: ffffb0b070547c50 R08: ffff98d030f222e0 R09: 
0000000000000001
[  716.828821] R10: ffff990ff6d298b0 R11: ffff98d030f226a0 R12: 
ffff98d000044200
[  716.829139] R13: ffffd605c29afc40 R14: ffffffff9e89c20f R15: 
ffffb0b070547d58
[  716.829458] FS:  00007f05f4cebac0(0000) GS:ffff994e00800000(0000) 
knlGS:0000000000000000
[  716.829781] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  716.830105] CR2: 00007f05e9cbc002 CR3: 00000040eea7c005 CR4: 
0000000000770ee0
[  716.830432] PKRU: 55555554
[  716.830749] Call Trace:
[  716.831057]  <TASK>
[  716.831360]  kfree+0x79/0x120
[  716.831664]  vm_area_free+0x1f/0x50
[  716.831970]  vma_expand+0x311/0x3e0
[  716.832274]  mmap_region+0x772/0x900
[  716.832571]  do_mmap+0x3c0/0x5e0
[  716.832866]  ? __this_cpu_preempt_check+0x13/0x20
[  716.833165]  ? security_mmap_file+0xa1/0xc0
[  716.833458]  vm_mmap_pgoff+0xd5/0x170
[  716.833745]  ksys_mmap_pgoff+0x46/0x210
[  716.834022]  __x64_sys_mmap+0x33/0x50
[  716.834291]  do_syscall_64+0x3b/0x90
[  716.834549]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  716.834806] RIP: 0033:0x7f05f471ebd7
[  716.835054] Code: 00 00 00 89 ef e8 59 ae ff ff eb e4 e8 62 7b 01 00 
66 90 f3 0f 1e fa 41 89 ca 41 f7 c1 ff 0f 00 00 75 10 b8 09 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 21 c3 48 8b 05 29 a2 0f 00 64 c7 00 16 00 00
[  716.835567] RSP: 002b:00007fff24c27ae8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000009
[  716.835826] RAX: ffffffffffffffda RBX: 0000000000200000 RCX: 
00007f05f471ebd7
[  716.836077] RDX: 0000000000000003 RSI: 0000000000200000 RDI: 
0000000000000000
[  716.836323] RBP: 0000000000000000 R08: 00000000ffffffff R09: 
0000000000000000
[  716.836567] R10: 0000000000000022 R11: 0000000000000246 R12: 
0000000000000038
[  716.836808] R13: 0000000000001fff R14: 0000000000000044 R15: 
0000000000000048
[  716.837049]  </TASK>
[  716.837285] Modules linked in: tls ipmi_ssif binfmt_misc 
nls_iso8859_1 joydev input_leds intel_rapl_msr intel_rapl_common 
amd64_edac edac_mce_amd hid_generic kvm_amd dell_smbios dcdbas wmi_bmof 
dell_wmi_descriptor kvm usbhid hid ccp k10temp wmi ipmi_si ipmi_devintf 
ipmi_msghandler acpi_power_meter mac_hid sch_fq_codel dm_multipath 
scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr efi_pstore ip_tables x_tables 
autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
libcrc32c raid1 raid0 multipath linear mgag200 drm_kms_helper 
syscopyarea sysfillrect sysimgblt fb_sys_fops crct10dif_pclmul 
i2c_algo_bit crc32_pclmul drm_shmem_helper ghash_clmulni_intel nvme 
aesni_intel crypto_simd cryptd tg3 drm nvme_core megaraid_sas ahci 
xhci_pci i2c_piix4 xhci_pci_renesas libahci
[  716.839185] ---[ end trace 0000000000000000 ]---

looks like we have to additionally handle numab initialization in
vm_area_dup() code path. something like below fixed it (copied pasted
from tty):

diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..f5b2e41296c7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -475,12 +475,18 @@ struct vm_area_struct *vm_area_dup(struct 
vm_area_struct *orig)
                 *new = data_race(*orig);
                 INIT_LIST_HEAD(&new->anon_vma_chain);
                 dup_anon_vma_name(orig, new);
+#ifdef CONFIG_NUMA_BALANCING
+               new->numab = NULL;
+#endif
         }
         return new;
  }

Does this look okay? if so I will fold it into V2 spin (in
vma_scan_delay patch, hoping you are okay with this change and do not
see any other changes required)

>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index c36aa54ae071..6a1cffdfc76b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3027,6 +3027,23 @@ static void task_numa_work(struct callback_head 
>> *work)
>>           if (!vma_is_accessible(vma))
>>               continue;
>> +        /* Initialise new per-VMA NUMAB state. */
>> +        if (!vma->numab) {
>> +            vma->numab = kzalloc(sizeof(struct vma_numab), GFP_KERNEL);
>> +            if (!vma->numab)
>> +                continue;
>> +
>> +            vma->numab->next_scan = now +
>> +                msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
>> +        }
>> +
>> +        /*
>> +         * After the first scan is complete, delay the balancing scan
>> +         * for new VMAs.
>> +         */
>> +        if (mm->numa_scan_seq && time_before(jiffies, 
>> vma->numab->next_scan))
>> +            continue;
>> +
>>           do {
>>               start = max(start, vma->vm_start);
>>               end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
>>
> 
