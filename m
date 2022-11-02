Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7B616C15
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiKBSZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKBSZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:25:11 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E4A29C92
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:25:11 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3701a0681daso139639397b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1kbwkKX+sRp/asQjjFL1Ko1bMveXw+rKnglQsWanHFs=;
        b=WoCBgkCh/p6HxXfamrMPBXHTO77bRvWGttUgmqw+WH/QBssnreuw9HqD/817VzgGi+
         67vdfJFhskGx7uMhIsupnsX34oTJSPeegqCuTWyLSTOLf9cW35kK6YT/TRBbdOYsi7Hv
         fVIHwOXodpfWouv/PyX5z+kMVOqnYpOwWFnLrhUWMwjlSAyIhDvI3C14tr5kcUYLxrZI
         uSBfbtHCxgNfKV77n6RagNUYrNYkKUWec3H7ktXMbRgDiAtyll4ELilPrkoutmmgcppO
         YL+aXIgKbD5yWV9CIlqm94zJfR94shXMlwyM3r0abqm5AvmH8LXlC7FAsXTRUiQTNZSy
         Gvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kbwkKX+sRp/asQjjFL1Ko1bMveXw+rKnglQsWanHFs=;
        b=hRUyMYARpFrl/Jf2XuKDjrt9tjawSihaFepVceIhi7ULaxcoVl1/iBynTwfrj0m1XO
         PnpA+MhakW71/kuFkAlcpBgbDjcxC4lNRsyxyajh/oSqDDi0K9gQLfLldXPYp3CXrUN6
         DGJ8VZ9MPAek1Q412PJJFUeuWVZ0MyMy14ykpN5okEZ0aS1AwwZwGlLBTnJjTq4aPxRJ
         8pFk0rf1PiphJLvATK9IgARDxkI1lb2PH9nQoyUjXpH9dE4sKuTddT+wqK0yeiGwduRa
         V1212lNaexHui/o2NFQg5vDk3IllhBPISZDds7Ud0KSSHQvzKNbfYE0JtFlu10Bvo2KK
         OzaA==
X-Gm-Message-State: ACrzQf3BV/aHLMn3IzuP0spFZrIfZ4gQ9rQ3Wac2EMxaRbh+RCRqqYmu
        xgO/idt9jMtNHYjBrNfS060ymJQjpF7NzAXjHsb5Xg==
X-Google-Smtp-Source: AMsMyM5v/eJW9i50DN+NzVD9ezpb5qYX9pClKltAKgGxNJ4qekRpyxbWDvoTpBtXBXf1CBt9SsO0OKaqyWyjtDUvwQ4=
X-Received: by 2002:a81:4e8f:0:b0:36a:7e82:92a5 with SMTP id
 c137-20020a814e8f000000b0036a7e8292a5mr23866656ywb.395.1667413510115; Wed, 02
 Nov 2022 11:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221030212929.335473-1-peterx@redhat.com> <20221030212929.335473-8-peterx@redhat.com>
In-Reply-To: <20221030212929.335473-8-peterx@redhat.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 2 Nov 2022 11:24:57 -0700
Message-ID: <CADrL8HUJZMGaWtyVCcXUfmU3neTO4Q6e=3Fi5=osiEVH9jRZ=w@mail.gmail.com>
Subject: Re: [PATCH RFC 07/10] mm/hugetlb: Make hugetlb_follow_page_mask() RCU-safe
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Rik van Riel <riel@surriel.com>
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

On Sun, Oct 30, 2022 at 2:29 PM Peter Xu <peterx@redhat.com> wrote:
>
> RCU makes sure the pte_t* won't go away from under us.  Please refer to the
> comment above huge_pte_offset() for more information.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9869c12e6460..85214095fb85 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6229,10 +6229,12 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>         if (WARN_ON_ONCE(flags & FOLL_PIN))
>                 return NULL;
>
> +       /* For huge_pte_offset() */
> +       rcu_read_lock();
>  retry:
>         pte = huge_pte_offset(mm, haddr, huge_page_size(h));
>         if (!pte)
> -               return NULL;
> +               goto out_rcu;
>
>         ptl = huge_pte_lock(h, mm, pte);

Just to make sure -- this huge_pte_lock doesn't count as "blocking"
(for the purposes of what is allowed in an RCU read-side critical
section), right? If so, great! But I think we need to call
`rcu_read_unlock` before entering `__migration_entry_wait_huge`, as
that function really can block.

- James

>         entry = huge_ptep_get(pte);
> @@ -6266,6 +6268,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>         }
>  out:
>         spin_unlock(ptl);
> +out_rcu:
> +       rcu_read_unlock();
>         return page;
>  }
>
> --
> 2.37.3
>
