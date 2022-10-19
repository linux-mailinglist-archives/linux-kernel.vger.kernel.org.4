Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5C36044CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiJSMPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiJSMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:13:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D531C2EBE;
        Wed, 19 Oct 2022 04:50:26 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JBg3R9021989;
        Wed, 19 Oct 2022 11:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7hjEOMncCWhZkRF5tg8yY/63l53HLEO0IFqP5nSxpkQ=;
 b=ct40l6SeK5x8teiYqgI1D7IfBoEJELZ4K2mVPR/sMBilDo7WhShIUWC/WOZJUWbc4Wul
 QImFcGEp661C08u5B6btzek2crIJjS08IdzdaDyVWJgMz3uNVonAP0CTilWk2SvbCJLZ
 xLG1ESdfZtTdpIX4vP2vPJafn1s1WD7+pMJ8T/mHy2OQh6oiyalO4tzp4/P9L5aIcjPx
 jz5KHnSMEzw4fK2OpdPMEG/txCHIwd022hrsE8InniqR03EA4rRtzFQ2F0etvTEnh1sO
 qy9t310d2v+N7oNE6dCfQHXouEeSHLjkmov+7fDHBmdmMDBGsz1mIE+dAFUd6shjofUX yA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kagkd86yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 11:49:13 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JBZPPD009515;
        Wed, 19 Oct 2022 11:49:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3k7mg9598f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 11:49:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JBn97L1508034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 11:49:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED4FC42041;
        Wed, 19 Oct 2022 11:49:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9370F4203F;
        Wed, 19 Oct 2022 11:49:06 +0000 (GMT)
Received: from [9.43.105.184] (unknown [9.43.105.184])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 11:49:06 +0000 (GMT)
Message-ID: <e391aeec-08b6-12e4-42e1-e556860e49c5@linux.ibm.com>
Date:   Wed, 19 Oct 2022 17:19:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] mm: hugetlb: support for shared memory policy
Content-Language: en-US
To:     Albert Huang <huangjie.albert@bytedance.com>,
        mike.kravetz@oracle.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <Y0mUt84TctGP3BtT@monkey>
 <20221019092928.44146-1-huangjie.albert@bytedance.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20221019092928.44146-1-huangjie.albert@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3S300k1xCbj7N6iWwsXWodnhJLvSQhRw
X-Proofpoint-GUID: 3S300k1xCbj7N6iWwsXWodnhJLvSQhRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_06,2022-10-19_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 2:59 PM, Albert Huang wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> 
> implement get/set_policy for hugetlb_vm_ops to support the shared policy
> This ensures that the mempolicy of all processes sharing this huge page
> file is consistent.
> 
> In some scenarios where huge pages are shared:
> if we need to limit the memory usage of vm within node0, so I set qemu's
> mempilciy bind to node0, but if there is a process (such as virtiofsd)
> shared memory with the vm, in this case. If the page fault is triggered
> by virtiofsd, the allocated memory may go to node1 which depends on
> virtiofsd. Although we can use the memory prealloc provided by qemu to
> avoid this issue, but this method will significantly increase the
> creation time of the vm(a few seconds, depending on memory size).
> 
> after we hooked up hugetlb_vm_ops(set/get_policy):
> both the shared memory segments created by shmget() with SHM_HUGETLB flag
> and the mmap(MAP_SHARED|MAP_HUGETLB), also support shared policy.
> 
> v1->v2:
> 1、hugetlb share the memory policy when the vma with the VM_SHARED flag.
> 2、update the documentation.
> 
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> ---
>  .../admin-guide/mm/numa_memory_policy.rst     | 20 +++++++++------
>  mm/hugetlb.c                                  | 25 +++++++++++++++++++
>  2 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
> index 5a6afecbb0d0..5672a6c2d2ef 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -133,14 +133,18 @@ Shared Policy
>  	the object share the policy, and all pages allocated for the
>  	shared object, by any task, will obey the shared policy.
>  
> -	As of 2.6.22, only shared memory segments, created by shmget() or
> -	mmap(MAP_ANONYMOUS|MAP_SHARED), support shared policy.  When shared
> -	policy support was added to Linux, the associated data structures were
> -	added to hugetlbfs shmem segments.  At the time, hugetlbfs did not
> -	support allocation at fault time--a.k.a lazy allocation--so hugetlbfs
> -	shmem segments were never "hooked up" to the shared policy support.
> -	Although hugetlbfs segments now support lazy allocation, their support
> -	for shared policy has not been completed.
> +	As of 2.6.22, only shared memory segments, created by shmget() without
> +	SHM_HUGETLB flag or mmap(MAP_ANONYMOUS|MAP_SHARED) without MAP_HUGETLB
> +	flag, support shared policy. When shared policy support was added to Linux,
> +	the associated data structures were added to hugetlbfs shmem segments.
> +	At the time, hugetlbfs did not support allocation at fault time--a.k.a
> +	lazy allocation--so hugetlbfs shmem segments were never "hooked up" to
> +	the shared policy support. Although hugetlbfs segments now support lazy
> +	allocation, their support for shared policy has not been completed.
> +
> +	after we hooked up hugetlb_vm_ops(set/get_policy):
> +	both the shared memory segments created by shmget() with SHM_HUGETLB flag
> +	and mmap(MAP_SHARED|MAP_HUGETLB), also support shared policy.
>  
>  	As mentioned above in :ref:`VMA policies <vma_policy>` section,
>  	allocations of page cache pages for regular files mmap()ed
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 87d875e5e0a9..fc7038931832 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4632,6 +4632,27 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_NUMA
> +int hugetlb_vm_op_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return 0;
> +
> +	return mpol_set_shared_policy(&HUGETLBFS_I(inode)->policy, vma, mpol);
> +}
> +
> +struct mempolicy *hugetlb_vm_op_get_policy(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +	pgoff_t index;
> +
> +	index = ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
> +	return mpol_shared_policy_lookup(&HUGETLBFS_I(inode)->policy, index);
> +}
> +#endif
> +
>  /*
>   * When a new function is introduced to vm_operations_struct and added
>   * to hugetlb_vm_ops, please consider adding the function to shm_vm_ops.
> @@ -4645,6 +4666,10 @@ const struct vm_operations_struct hugetlb_vm_ops = {
>  	.close = hugetlb_vm_op_close,
>  	.may_split = hugetlb_vm_op_split,
>  	.pagesize = hugetlb_vm_op_pagesize,
> +#ifdef CONFIG_NUMA
> +	.set_policy = hugetlb_vm_op_set_policy,
> +	.get_policy = hugetlb_vm_op_get_policy,
> +#endif
>  };
>  
>  static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,


How is the current usage of 

/* Set numa allocation policy based on index */
hugetlb_set_vma_policy(&pseudo_vma, inode, index);

enforcing the policy with the current code? Also if we have get_policy()

Can we remove the usage of the same in hugetlbfs_fallocate()
after this patch? With shared policy we should be able to fetch
the policy via get_vma_policy()?

A related question does shm_pseudo_vma_init() requires that mpolicy_lookup? 

-aneesh


