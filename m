Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6D567E972
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjA0P2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjA0P2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:28:15 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471871F91E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:28:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anjujLVH8cnjq0dc2BGS3GCHv2RMFBoqgZnsmsImp4PhCb3Xi8vPIsOawvVfT53fcx0M5kWHOI1Wx7AvADpk/pePU9cDIWHR8t2zmLKs6yVLkq8mUQXZpRtrbCRrfXhkt8A8xh6wu5UXRr6McF+0bFW3NpFu7RIB0X0Mo6OZtphvbRhGmaGMpYn7RIr2qUExWuZCjqjPMKTSgGl8SB66RP+qW8K1dCpATDsM4Lw1bstiBeRcSEHOqMJayhDLliwg/GJI7sBxD3zp0Hshfq0kf39feVNyoNl+gH59QwuNEJfcK2dHHOmbqWT1V4rktEYHbI1SJiR2/JNdr3czzcyBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=111aTzK6f4wRXLn8a3pJAJHmVi70IV4Uq83XQQTO9kE=;
 b=CbInBGsKa91isvT7p9qKDATuROLItnsyQAfaGy3BlEfkFAalfWleXR/8SNGNcpH4fCtJHz2YoEIu/zlaNdBAd1Q9KUp0ux3aBOQm1vb4Jsi8uVkjUHg/zLWsPiXFsHW8ClWBWM9cHqS7UvKpa4SroZDYqTipARPtGZljEEbv1aTvdXeUMRKLkHZDY3RnX0p9Kk2Pcka2H7HIdslGzepwn373RtWzbZp31+ujocd78hDV/jik2TGbOsKKSz+/sXnVnLeYnjRJ4XobvCBL6KtZDb5pL+Ulnvo07FkI1ixQds0iAPT6twfFpZY0jso01duxltNjZ27eWjtSNzt/UCbiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=111aTzK6f4wRXLn8a3pJAJHmVi70IV4Uq83XQQTO9kE=;
 b=LlEh0u3i3FmsYvKJ6nPPbFrI0oM9RMFXXhsA4MpVz2RfH91F/bJ5vS2+DfrsyWZHMr86ZRMFE4frrnKc3LS6bWEe9Q9ETr2RtDWDsCvf2qHK7uLdnQ1ShMEbxiWJgefnUkFGs/CGiDPhKAxDBsNxpcceOyQkSABO3F7Xd369cRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Fri, 27 Jan
 2023 15:28:10 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 15:28:10 +0000
Message-ID: <500591b7-9c36-a769-88aa-0f130256ebc9@amd.com>
Date:   Fri, 27 Jan 2023 20:57:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Content-Language: en-US
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
 <118c2f4a-58d7-de42-1f77-31ac8a4d4701@amd.com>
 <20230127101720.qh2wramyfyyucxhx@suse.de>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20230127101720.qh2wramyfyyucxhx@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::9) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: d498985f-edc2-40ee-0594-08db007b188a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDGE00wv8yYp79Nyc8jyfVQFA68iI/cE8cMYUzdX6HjZmJlMfPoob7CaYq1LN9mxqJw7QeT6kyQNvin7nUrqS9dkv8aNfMBm+V2XPiIlgFGgm5m/vpA/JHLNqkz4okxX6QStF97BtOgBgWxS1kDCznRLADqkmxSkfJESwuiVP0v8O0qsOKG37VWhkCHB71OP/m5y7muN57jLQ3JD3vPoeh2SHiZ5ck5RDWs5vL9pVZd7xRC8i3I+QUgcjMVGwuk2vS1d9OHTUe2oN84HqlslAh7vRfxa517Sv359braZRGP+QyD50rrmSkFxDJJHHQz6tEZgn0i9GQh8W3SIS3tpErKa7gFYpHYg3lGh+ZOHk9NbQ3GL7B2w7WfEdvFhw3MlwNqgLHWWrJ4tVq89Z0r2lQ34XVjG0BD7zWApUoV4MpSmsAwBVb3Sp5YGsnV4Bv4HqQBPyEYthTG1b3Twr/qao3iU5bRNJOVVpteF2JrKYVM7Eu06d8XUC/BytT1Lb35CHmyZAU8SAd4XoTCo/tjmYHcKg6EpVVW4ocMxtFzCnu2ZmxQzF9Klq7Q7V/FEXjsKnVLTaktPV+ZTgqBHYkmAccXmQD5GmT2a6mNH9UQrg88oPTxS7/iRa0ysC3XfWSGqiNwMZN9/2YBaZpQjXclQuMCMQd+hFqqQoyGAbyyigUpa8gSRh9Aj9CX4EJUWAXFcWIZVLkXxAE24WoDyht5NvDZ26M1V86E0+krHGPo8Tcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(5660300002)(6512007)(2906002)(66556008)(6916009)(186003)(8676002)(4326008)(66476007)(8936002)(66946007)(31686004)(41300700001)(83380400001)(478600001)(6666004)(53546011)(6506007)(2616005)(26005)(6486002)(316002)(38100700002)(31696002)(54906003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzNnUUI4UVRIbHREVGpFbHJ3emVSWGcvOUk4UXBDT2FoNDVSVjI1RG5pazg0?=
 =?utf-8?B?TVlibldwTjN4cmFSeVpxcW5oOEhOcW84Rkx0UkdISHZvNloxT0dkWlJrSThZ?=
 =?utf-8?B?Y3lXbnZ5dGlOQVV5RHl1YjB3NW10SW1UQlNmTzVQZFFHQytCeEhqSHYzWUky?=
 =?utf-8?B?TFFtczJzVnQ3MjJZeEExaFpRcmJmbng5UVhnRXZCMlNLbXRXSWpkdGkvZ3Uw?=
 =?utf-8?B?RlNUOWNvTEl2R0kyS2pUZm94WnZzTWJKSnVzUmZ3RmJldVl6d1kxWUxQOUY5?=
 =?utf-8?B?dHUyK0JEU2lPeUsvQnVmL2VRRVFac2FPTWsrbCtPbjdmeDZ3RllKWFozS3Yr?=
 =?utf-8?B?YUY4ZEY3NUVoK0l4VUZlTHJCTEhyNFZPRk56RTZhL3BaMXhRc2RrUzVZQ2hL?=
 =?utf-8?B?S3F5U29hbW91Zkl2aVlRT0QzL05GWDF2TDhHUmdJNm5nWXlzTEwvd3poelQ1?=
 =?utf-8?B?TkxqQ0FSakFKZXBBdVVzam1mZlNWSWVIeXh6akVxTU9ST3NiZzlpN0UwMkxR?=
 =?utf-8?B?bmt6NHd6ZURNeWRvYW5jWnQ1Q1R5STNzT09vbEU2eXJFYVFhanY3ZVk5MnZu?=
 =?utf-8?B?aVBCR1BvQ1pTUVdzRDkxNTU2VndZNk5LZFJHTDNQdG5lWGZyZDBqSnpHcTlk?=
 =?utf-8?B?eTN4UVA0N3VIU0dGOUVicmFaaFRZQTJoNktqTVRKNHFlS1hHeWFINFVMUVdq?=
 =?utf-8?B?RzhVMG9BNHl6T1liN012TE9rMG5Pa2JJMVF0Q1N3WUJFMnBDNmptbTBFYlJW?=
 =?utf-8?B?QmExVDdBU1FqZm4zdm9IUUFxVUw4cTI1UWtLMnJ5UmlxYTNWZHhHRnZMWnFF?=
 =?utf-8?B?OXdlOC96UkJ3N2hiOHlBVVcrZTFYMWpGMm1yZ0FpZ2NqYTVOTW9lWi9wVmhh?=
 =?utf-8?B?ejF6WG9Yem0yck4xelp4N05IS2FDUzRIamhqVzRENm1DcWlreXl4M1dIaTdN?=
 =?utf-8?B?a2dPZVEzN2J2Nm9OaDc3ZGx6eGxDT2tzWEVacDAvQ1pjZi9oWUVtRUNGUXpl?=
 =?utf-8?B?eTVaZlRUZHh5akIvdHIzT1huY2RBM2JpU3pyelVLN2thSnU2dGdRaUk0UmFD?=
 =?utf-8?B?K0lvTCtNc2w3bU0vbnJDVEl1bmtnRzRsUGI1Y04vc1FERzVBdU1uMWlZSUwr?=
 =?utf-8?B?dW05RG1TUFVzYjVJUGN4R3lFTkk5Z1grVllwdS9WQWVvci8rQjF5c2hjNkVr?=
 =?utf-8?B?LzBFUmtmdGJZVS8zejlRRURtdGFNTmwweGx2bGsrSGZBQVJySXJjNjQxWE5S?=
 =?utf-8?B?UkFaMzFrcmpwZVpvdGVnUDRxaXFsb1h4VmVIVWNjazFEdmNHU0FFUDhBU0s3?=
 =?utf-8?B?VjRBaUxJeWZ6Z0VzL01PNDFYaGdMU0dzUmd5OEF6SFdYK0VVQ2pOcm5Qdi9s?=
 =?utf-8?B?ckpiaURlVm9IWEFhdGpta1NWdjl1QzZacHB6OWtZejVBQXM4bmNtd01QQnFC?=
 =?utf-8?B?Y1dmalNTeGxsMGIzWTQydmxuQndQWEFlaFFwWGwwdkhyMlZhY00rYndiN2lQ?=
 =?utf-8?B?YVpWTFJzamtCdHV0WUN3U3FVSllNK1gzTUVzaTdzd1FHZTRxUGw0RkFScDdq?=
 =?utf-8?B?VjMxdlNIVUFwM1F2bW5iR1FnRWlHbmU3OVV0ZW1IQUVwblpEOXVoWFM2R3pm?=
 =?utf-8?B?ZmxZQTFFeXJJdS9jSHRXdWZaNHZVTXlHdHViK0lYWE9aV2FMY0hDUlpqR1dp?=
 =?utf-8?B?eGZzbXRGOCtNTldLOHVId2ZKVlBtYkNPaUJzcHpXcWpNaG1uSlhqVW1ybC9Q?=
 =?utf-8?B?VUZYaGVNcFQxT1JqVGZpTUsyTU1FSTdKWGc0UUxhME1zZy9kSzhUYUVpd0hC?=
 =?utf-8?B?V2VITTZ5c1FQMExQVHVmcXZ4MW9nMlRXdm5pZVVTejNLWWVOaXFWUDdLODBB?=
 =?utf-8?B?MGxnKzVONnpxVnVYUkRmSEUyd29PWFNzWXZTallieUNkeHpsYk9pdTNGa1RI?=
 =?utf-8?B?azkyUGRtaHVNY0V2SVZxQUt6aGsvckdHUGd5VUJXcGkyRVN2TFVlWDY1dEFT?=
 =?utf-8?B?K1k3LzYrMkgzTGZhYXJ4Tm1UOXFudlU5Smg5bnNqS2xxZHllYmRHcFdWNWtF?=
 =?utf-8?B?dE5VZEM5c0JyMGM2ekFRVzcrM2Nwb3ZDSWQ4NmdTZkd2cnFFVEtoOENzQkc5?=
 =?utf-8?Q?X3yP3/BwDfoP9DXIdpL3b4Lzl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d498985f-edc2-40ee-0594-08db007b188a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 15:28:10.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNvvSTxvS0u7P4YQXyJIQWhTWJRQACmmCCe2eZS35H3Bx8EEuAIAewXnC3GatvCfy+Gx7bkJ/j+Uu3FdQQC5pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/2023 3:47 PM, Mel Gorman wrote:
> On Wed, Jan 25, 2023 at 12:48:16AM +0530, Raghavendra K T wrote:
>> looks like we have to additionally handle numab initialization in
>> vm_area_dup() code path. something like below fixed it (copied pasted
>> from tty):
>>
> 
> Yep, it wasn't even boot tested. Better approach is something like this,
> still not actually tested
> 
>   include/linux/mm.h       |  9 +++++++++
>   include/linux/mm_types.h |  7 +++++++
>   kernel/fork.c            |  2 ++
>   kernel/sched/fair.c      | 17 +++++++++++++++++
>   4 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8f857163ac89..481f90dc1983 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -612,6 +612,14 @@ struct vm_operations_struct {
>   					  unsigned long addr);
>   };
>   
> +#ifdef CONFIG_NUMA_BALANCING
> +#define vma_numab_init(vma) do { (vma)->numab = NULL; } while (0)
> +#define vma_numab_free(vma) do { kfree((vma)->numab); } while (0)
> +#else
> +static inline void vma_numab_init(struct vm_area_struct *vma) {}
> +static inline void vma_numab_free(struct vm_area_struct *vma) {}
> +#endif /* CONFIG_NUMA_BALANCING */
> +
>   static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>   {
>   	static const struct vm_operations_struct dummy_vm_ops = {};
> @@ -620,6 +628,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>   	vma->vm_mm = mm;
>   	vma->vm_ops = &dummy_vm_ops;
>   	INIT_LIST_HEAD(&vma->anon_vma_chain);
> +	vma_numab_init(vma);
>   }
>   
>   static inline void vma_set_anonymous(struct vm_area_struct *vma)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 9757067c3053..43ce363d5124 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -526,6 +526,10 @@ struct anon_vma_name {
>   	char name[];
>   };
>   
> +struct vma_numab {
> +	unsigned long next_scan;
> +};
> +
>   /*
>    * This struct describes a virtual memory area. There is one of these
>    * per VM-area/task. A VM area is any part of the process virtual memory
> @@ -593,6 +597,9 @@ struct vm_area_struct {
>   #endif
>   #ifdef CONFIG_NUMA
>   	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
> +#endif
> +#ifdef CONFIG_NUMA_BALANCING
> +	struct vma_numab *numab;	/* NUMA Balancing state */
>   #endif
>   	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>   } __randomize_layout;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9f7fe3541897..5a2e8c3cc410 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -474,6 +474,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>   		 */
>   		*new = data_race(*orig);
>   		INIT_LIST_HEAD(&new->anon_vma_chain);
> +		vma_numab_init(new);
>   		dup_anon_vma_name(orig, new);
>   	}
>   	return new;
> @@ -481,6 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>   
>   void vm_area_free(struct vm_area_struct *vma)
>   {
> +	vma_numab_free(vma);
>   	free_anon_vma_name(vma);
>   	kmem_cache_free(vm_area_cachep, vma);
>   }
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c36aa54ae071..6a1cffdfc76b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3027,6 +3027,23 @@ static void task_numa_work(struct callback_head *work)
>   		if (!vma_is_accessible(vma))
>   			continue;
>   
> +		/* Initialise new per-VMA NUMAB state. */
> +		if (!vma->numab) {
> +			vma->numab = kzalloc(sizeof(struct vma_numab), GFP_KERNEL);
> +			if (!vma->numab)
> +				continue;
> +
> +			vma->numab->next_scan = now +
> +				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
> +		}
> +
> +		/*
> +		 * After the first scan is complete, delay the balancing scan
> +		 * for new VMAs.
> +		 */
> +		if (mm->numa_scan_seq && time_before(jiffies, vma->numab->next_scan))
> +			continue;
> +
>   		do {
>   			start = max(start, vma->vm_start);
>   			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);


Thank you Mel. This looks better now.
Yes we would have moved to mm.h eventually to avoid #if clutter.

Also for PATCH2 function common to memory.c and huge_memory.c would
need the same to handle hugetlb vma as suggested by you.
Working on gathering numbers and PID clear logic now. will post V2 soon.

Thanks
- Raghu
