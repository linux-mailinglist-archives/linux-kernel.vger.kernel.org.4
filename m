Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDF05FCBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJLTpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJLTpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:45:25 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAEF20193
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:45:23 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o2so3969361qkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQM5wV6XpR4edsco6nT6p0x8TORjKYO8fmyDh9krb5U=;
        b=J+eAM2KsHmqTO4j410J1EjDASf5Uzw0DD4qQEpfhwST+BqmGmEHItRTxjseh6B50CP
         yAKDZ/WE/H/btF4jEOaIUPnu4XukuMM4xSE9As+6fpLhtuYuHek4oMjR+hgykg0GFLNu
         bwXvGU9XW5XR7up1ZA8rN0CnZlmraSFNKUETd8J13dEBuVR5myKAkdGaUgSOzRoxAq1u
         /odOfqdo1sN6NB8f33GyPz74ceWm7Kh0OPGc8WvoFZccepqVxtlITXuVSV1WD+oWkaTB
         vCbssZXzZ82MnqhPRORMJ6j7WwjaUTCiYtCXxx/aoBIFMM7fxli8gotkLqKXKbIO/Q1e
         B6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQM5wV6XpR4edsco6nT6p0x8TORjKYO8fmyDh9krb5U=;
        b=rjqxZIyXNg55fG/is1UU5CXe0+fL9mt4YN4uvUz1lXI4RC0r8+T2epe0kepZ+1PSf7
         RQNi7Li7ttkUFt0mNwVRWl+XVrNIcbK3S20F2BNG84M/0E2DeoQpUgKNIuohpFeN5n0c
         2+MB9C3tqBOHL+fHEVodYyGkli1xX0bnQjbr18ATk8V7L2jRP8z8zt0Lb0o7Po0uThZN
         FNOYSwbcdIAwhQDi0QrcWE1Urv0L7xUk47uAc9miQoHGSOEkptzSwjP7xzv1TFVyXJ+A
         BU0VHK1PF05W0TyxFnZ6R1AqIUnRoBjLNPhGWXscB5kf3GFK53iC85muaN+q7A9YgSls
         Cszw==
X-Gm-Message-State: ACrzQf1O+3BMt86OUJZh2Zl9D7rCtDhEYEKIiHNeQBtKkFN1lYW6KqJP
        Xl2o8wfaNCrBx5T+q3w50VhAgQktEaWM1A==
X-Google-Smtp-Source: AMsMyM5/2tmKQ1gLVp8CBNyys8UCJDepHy9YOo87yOfZthX2AlQGwxPLn/J3N7AhaNHAuXZPCHKSCA==
X-Received: by 2002:a05:620a:1a23:b0:6ee:7b21:95f1 with SMTP id bk35-20020a05620a1a2300b006ee7b2195f1mr7278006qkb.296.1665603922279;
        Wed, 12 Oct 2022 12:45:22 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v8-20020a05620a440800b006ecc5f5635dsm7275583qkp.113.2022.10.12.12.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:45:21 -0700 (PDT)
Date:   Wed, 12 Oct 2022 12:45:06 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
In-Reply-To: <20221012081526.73067-1-huangjie.albert@bytedance.com>
Message-ID: <5f7ef6ee-6241-9912-f434-962be53272c@google.com>
References: <20221012081526.73067-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022, Albert Huang wrote:

> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> 
> implement these two functions so that we can set the mempolicy to
> the inode of the hugetlb file. This ensures that the mempolicy of
> all processes sharing this huge page file is consistent.
> 
> In some scenarios where huge pages are shared:
> if we need to limit the memory usage of vm within node0, so I set qemu's
> mempilciy bind to node0, but if there is a process (such as virtiofsd)
> shared memory with the vm, in this case. If the page fault is triggered
> by virtiofsd, the allocated memory may go to node1 which  depends on
> virtiofsd.
> 
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>

Aha!  Congratulations for noticing, after all this time.  hugetlbfs
contains various little pieces of code that pretend to be supporting
shared NUMA mempolicy, but in fact there was nothing connecting it up.

It will be for Mike to decide, but personally I oppose adding
shared NUMA mempolicy support to hugetlbfs, after eighteen years.

The thing is, it will change the behaviour of NUMA on hugetlbfs:
in ways that would have been sensible way back then, yes; but surely
those who have invested in NUMA and hugetlbfs have developed other
ways of administering it successfully, without shared NUMA mempolicy.

At the least, I would expect some tests to break (I could easily be
wrong), and there's a chance that some app or tool would break too.

I have carried the reverse of Albert's patch for a long time, stripping
out the pretence of shared NUMA mempolicy support from hugetlbfs: I
wanted that, so that I could work on modifying the tmpfs implementation,
without having to worry about other users.

Mike, if you would prefer to see my patch stripping out the pretence,
let us know: it has never been a priority to send in, but I can update
it to 6.1-rc1 if you'd like to see it.  (Once upon a time, it removed
all need for struct hugetlbfs_inode_info, but nowadays that's still
required for the memfd seals.)

Whether Albert's patch is complete and correct, I haven't begun to think
about: I am not saying it isn't, but shared NUMA mempolicy adds another
dimension of complexity, and need for support, that I think hugetlbfs
would be better off continuing to survive without.

Hugh

> ---
>  mm/hugetlb.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0ad53ad98e74..ed7599821655 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4678,6 +4678,24 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_NUMA
> +int hugetlb_vm_op_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
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
> @@ -4691,6 +4709,10 @@ const struct vm_operations_struct hugetlb_vm_ops = {
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
> -- 
> 2.31.1
