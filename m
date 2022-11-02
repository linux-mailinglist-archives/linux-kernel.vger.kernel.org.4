Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7354616B77
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiKBSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKBSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:04:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64BA63B1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:04:15 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id z24so26078604ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJ2ZHLozVbrXFGJhHAp4jFnhNvxFiOfSYk2Zw6TLsHw=;
        b=JTa7n5j0LHz9NZAainf6PNxU3H274rfHvdYJLcXpCHUnAIEzpizESke89IFDh1DlOR
         HBNOlF9OvEdrBXENtjwpUjFwtJ1q6iaJBL+cQOB7imGAu813t80YvOERlt5omuXosZbz
         QqfWq/yOUaOH2J7NQyWZ7IuqWwxJuqQGbrOBbN85zYctjeL2JuwJ2c4lF3kM9fSQIWbE
         8c4zooehsjcLP8gA/VO5uXnaYHCEcLNYCWBFqPqcREXU45OpUQ6YTYdyZnh8PMWT+rsQ
         x4V+qpE3sA3cvrCuXYV1bedXdKNexSSRLceZ6szE8Kp+PSdyWTDncjGQO3lWMmDLVLJF
         mruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJ2ZHLozVbrXFGJhHAp4jFnhNvxFiOfSYk2Zw6TLsHw=;
        b=ckI+27szqinxs29xxTtoEMuj825BPN8LJypfIZF6GUAN7lmEte1hgK46Vu3USNV69S
         6PW6/baoIzU0emZWqjZYyckQRdQombZB5J0tCOTcJjrEHf2lmcvKFRgflnzXd5P7E9b9
         GiB1e7a4kxw1BjkAQ0l1Oh9nwNSzGs/y4MN6tKeJZVWmuG6cRbJDIGbKP9bfJBfm3Kv3
         3scsdtFsacgtypfxApW/mR6M1WgewugFcWvzwLrNNN30e2WWHBGuhu2RjdXDOKE6g42a
         Ge6/1Kf6uhAZShRbea+deV6T3euir2SbDG5veH35KW1qFgcsFoYcVFitd/ragmi/SY4S
         q1hg==
X-Gm-Message-State: ACrzQf2xhUupmf/sXOzMQysmX/UefwZ0KNTtmf2nCwqpDogVdzZpJRcY
        TzM91vfkDMYYFehqPAWBhkpnDvfLqVxx+tu0gbYvBg==
X-Google-Smtp-Source: AMsMyM5RtHxJrhKVJQ6JtusxXnazsna/+7dt3u3tmskII5oyy4uyJYEcaghISoOyM71q5BHTw+u7RQwPIxddjdlYaSk=
X-Received: by 2002:a2e:9884:0:b0:277:901:69f with SMTP id b4-20020a2e9884000000b002770901069fmr9713281ljj.169.1667412253713;
 Wed, 02 Nov 2022 11:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221030212929.335473-1-peterx@redhat.com> <20221030213043.335669-1-peterx@redhat.com>
In-Reply-To: <20221030213043.335669-1-peterx@redhat.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 2 Nov 2022 11:04:01 -0700
Message-ID: <CADrL8HUrCkjnBuD7=NJZ5gOBYWBbu=pa0sKp4FMnDH7OhtKvSA@mail.gmail.com>
Subject: Re: [PATCH RFC 09/10] mm/hugetlb: Make hugetlb_fault() RCU-safe
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Oct 30, 2022 at 2:30 PM Peter Xu <peterx@redhat.com> wrote:
>
> RCU makes sure the pte_t* won't go away from under us.  Please refer to the
> comment above huge_pte_offset() for more information.

Thanks for this series, Peter! :)

>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5dc87e4e6780..6d336d286394 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5822,6 +5822,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>         int need_wait_lock = 0;
>         unsigned long haddr = address & huge_page_mask(h);
>
> +       /* For huge_pte_offset() */
> +       rcu_read_lock();
>         ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>         if (ptep) {
>                 /*
> @@ -5830,13 +5832,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>                  * not actually modifying content here.
>                  */
>                 entry = huge_ptep_get(ptep);
> +               rcu_read_unlock();
>                 if (unlikely(is_hugetlb_entry_migration(entry))) {
>                         migration_entry_wait_huge(vma, ptep);

ptep is used here (and we dereference it in
`__migration_entry_wait_huge`), so this looks unsafe to me. A simple
way to fix this would be to move the migration entry check after the
huge_pte_alloc call.

- James

>                         return 0;
>                 } else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
>                         return VM_FAULT_HWPOISON_LARGE |
>                                 VM_FAULT_SET_HINDEX(hstate_index(h));
> -       }
> +       } else
> +               rcu_read_unlock();
>
>         /*
>          * Serialize hugepage allocation and instantiation, so that we don't
> --
> 2.37.3
>
