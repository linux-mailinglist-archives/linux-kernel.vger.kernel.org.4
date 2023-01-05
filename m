Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383D565E2AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjAEBvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjAEBu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:50:59 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACCA33F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:50:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso292098wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 17:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yqfl4xJm+Wld0bPquuUz0o/yojxexveabYMG4JIRCRw=;
        b=Qok5PnDts10sjUXsNh9QcIsGF42bksh+y/PzDySJHxG0qPjMJGnjJu0D2IBu9Ljw0S
         bKWr6Oqgz24nXkftP02bkHPGE8PGfIlchPKVTQnioZ97vJ913mBvaoPzir/3gmdnj6S6
         p0ml9kjP1sgAvonF5uWIf39mt9iE4GT9DeJ4WxTIHqdXOXm6zVA8Y4SKKWQ3qHgdfGJ6
         6yGt7L2qZyt+ECDwFtr8DARAUHVnH2qTtZKmiwW33+gJILmfie2jXi7MtqyWDrpEpz0k
         sS6J6yd414UxQsb2UE8WdLl74rUmPEEv7VskJ2+2+kzkNqcLSXHpt/wxBVa0neVubM2o
         SQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqfl4xJm+Wld0bPquuUz0o/yojxexveabYMG4JIRCRw=;
        b=qoSxpEn7nS2g2fGH5Ou+D779W5A1O4jEiwHP2f8hRGsGISNmiQIVnjwms/4OeH/7c8
         Ewy4/le9e1k02/9vtjOtRk+A1iZgXj9KtSD2bhYfRNZ9k2tk4jk6tAqB6BQl3S4ciFej
         fMYpm5hv03783JBy5OCDvPQEOa0PBS1fLLxyrVg1QtursbwRbvjrGStbKOSBTXA1g6/1
         okg3P3ftLqoG4e6HHk/0HPlwyTYmI1xLTNJXiZ75i2jb5jUvOGP6ZOMh1pWO3py75+zH
         dN32DkfBwaaieEhLKGeCy1C7Kxe7KBs6nSZ/CjYIrANKJLQ9HAgkg1BTf8+n5lg6UiDn
         VLIw==
X-Gm-Message-State: AFqh2krGPaDG1FnXuObFfIeaIB3c9RKTYk/ZDbo2eDn4vBXdUzNdU1j7
        d85B5S+5bZp7bahtJxvb1tJsxT8ZhUaC+R2kH3wvgw==
X-Google-Smtp-Source: AMrXdXtg7ahs4squVQDsseVSKq1N8Am3Wh9SCbdeRbHyzAK0hNiDqhlUbY8czXt2TEKWbAPu6YgC6GQxpY54u1pUQ9k=
X-Received: by 2002:a05:600c:4b95:b0:3d1:da8c:7869 with SMTP id
 e21-20020a05600c4b9500b003d1da8c7869mr2632215wmp.26.1672883455586; Wed, 04
 Jan 2023 17:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20230104225207.1066932-1-peterx@redhat.com> <20230104225207.1066932-2-peterx@redhat.com>
In-Reply-To: <20230104225207.1066932-2-peterx@redhat.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 5 Jan 2023 01:50:42 +0000
Message-ID: <CADrL8HW0cJn+kuPp5CD1ponepDsBpyfDQEDP3cYjdxcK6uC5Rw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/hugetlb: Pre-allocate pgtable pages for uffd wr-protects
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-stable <stable@vger.kernel.org>
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

On Wed, Jan 4, 2023 at 10:52 PM Peter Xu <peterx@redhat.com> wrote:
>
> Userfaultfd-wp uses pte markers to mark wr-protected pages for both shmem
> and hugetlb.  Shmem has pre-allocation ready for markers, but hugetlb path
> was overlooked.
>
> Doing so by calling huge_pte_alloc() if the initial pgtable walk fails to
> find the huge ptep.  It's possible that huge_pte_alloc() can fail with high
> memory pressure, in that case stop the loop immediately and fail silently.
> This is not the most ideal solution but it matches with what we do with
> shmem meanwhile it avoids the splat in dmesg.
>
> Cc: linux-stable <stable@vger.kernel.org> # 5.19+
> Fixes: 60dfaad65aa9 ("mm/hugetlb: allow uffd wr-protect none ptes")
> Reported-by: James Houghton <jthoughton@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Acked-by: James Houghton <jthoughton@google.com>
