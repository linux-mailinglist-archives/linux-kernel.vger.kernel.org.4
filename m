Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5315A616B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKBSGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiKBSGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:06:31 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED3A2EF49
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:06:29 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3691e040abaso173741887b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0CEgw9X5vfyuwIxQqcN7xcNuir05YO/amlYwdnAC9g=;
        b=jd3KIXC0Wu2EC6lt2E6e8osyw7VO19Sg2LkwuZAQ4qagtKZhYV2I4zssMwNkNTol5k
         Wu9tOb4gUJ/jNMJm3GR7wIbmBeOJpPqXEoAgok3s6e5o52CRzVN3HGbHdLNoSoQ+hY7r
         /tBV1B4SisUltG+1QjMwwPIYNPJUqVsLkaU4BmA87QHkySjts5hHQsZ8lIx557FG7Z/u
         Rwa3bmI2f4IhIQfKNggcaKO6rKqU6i7BXc/jKiA7oVgl1XPy5SRIZzfiNF5QhWcNxvh6
         uNjecfOsEL/JXfKjPWiIM3rwP+yuKZ1Is5ZKBgYNR5ZmLmI7yyB7g1MWzJaC/WfiEoIH
         bJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0CEgw9X5vfyuwIxQqcN7xcNuir05YO/amlYwdnAC9g=;
        b=wkiUDuyjdUsr807WbGqGeAqKuB8gotciAtEMLy+kqxqeUvmd3HXy2KXwNCuhhnYQ7I
         Ngy2dvK51jEt3wyyakF2XK3TsIVVKxDFQDF+aQEZl4iVpkD6lSY6M1kuO5m8mgP3M+xk
         PO8wTNhzTHUZGPYQ4kgVgTZlJJs0KQD7k4zm+a9f4L91bmOWct4rlhYEKLyjywbEhxDK
         h0hEu5dBhY8Qo6SeS1WNxor/Vd9/fXBYX92X+yzYlYVw9TL79o7E40+pneiWcz3gO6E9
         R6GaHu9wdVeY0G+vW/p+IXDh4AP8541DrxIvy1gV5XAi1yPPsqLeW76i53BOOydgHxcE
         j41Q==
X-Gm-Message-State: ACrzQf1DNJL8P73rEAQaum4uUXhBQH1286oEExcuDNmtVRFE9CTdqwbr
        x3I8wJ11Esdob++379xf4QPMeQZKxgPaBoc8G0bodw==
X-Google-Smtp-Source: AMsMyM5bBk2ioGe0NmqvZ65KgqUjR5BrZT6NnVCCub3vHX+oK4glVSvyGeBEXDTV1x6ppQboIsconfbATdm+J444dcw=
X-Received: by 2002:a81:8945:0:b0:373:5c0c:9b4a with SMTP id
 z66-20020a818945000000b003735c0c9b4amr3242958ywf.490.1667412389003; Wed, 02
 Nov 2022 11:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221030212929.335473-1-peterx@redhat.com> <20221030212929.335473-5-peterx@redhat.com>
In-Reply-To: <20221030212929.335473-5-peterx@redhat.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 2 Nov 2022 11:06:16 -0700
Message-ID: <CADrL8HWpvAozbfqGyr0=4M6bu-ecQ7mQXb3xzvMTjpCPH3OVcg@mail.gmail.com>
Subject: Re: [PATCH RFC 04/10] mm/hugetlb: Make userfaultfd_huge_must_wait() RCU-safe
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
>  fs/userfaultfd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 07c81ab3fd4d..4e813e68e4f8 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -243,6 +243,9 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>
>         mmap_assert_locked(mm);
>
> +       /* For huge_pte_offset() */
> +       rcu_read_lock();

userfaultfd_huge_must_wait is called after we set the task's state to
blocking. Is it always safe to call rcu_read_lock (and
rcu_read_unlock) in this case? (With my basic understanding of RCU,
this seems like it should be safe, but I'm not sure.)

- James


> +
>         ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
>
>         if (!ptep)
> @@ -261,6 +264,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>         if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
>                 ret = true;
>  out:
> +       rcu_read_unlock();
>         return ret;
>  }
>  #else
> --
> 2.37.3
>
