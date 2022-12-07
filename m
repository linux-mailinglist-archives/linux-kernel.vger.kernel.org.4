Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A726464E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLGXQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLGXQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:16:34 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E4C8930B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:16:32 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id o136so594146vka.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qKhtWKuWhB3DUJ2H/EHTwp1GzrvWCjjlF4j8bshMOGg=;
        b=RWItdZbEx9sodZbYh/mNiehmL8weMOlBg/LJdiWPUbuEkKFHf0IAViiYzIVqNIeDBq
         JuyepTR4HRBjbUtZXabjpqNAi9B9HoYUaLmxKPshiN6I/EutIHREDQC3wJ1z4nve0Oif
         d3//qbWsgckqa1nQ/G6uvB3SQ8XCMoe4vmFR2Ce/ukEXK/CHEt4Wm0hvDLqDBZnbQmqH
         mFdjh7Ez+XvkgML8Z7StJJoaRk9/xj+V8GsFhBkmijvl2L75TsaoTLC6WMLofzSUrp7N
         sE6bHCajUkKunMMRrzObVAfO68dQPZIf/5XQeW8lA8USYxP9WIpBuACEs4qqS0XVV0GM
         5tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKhtWKuWhB3DUJ2H/EHTwp1GzrvWCjjlF4j8bshMOGg=;
        b=GOzZFcXlMbywMMZcenT+hsAVQV1YBwmq1ZU7HfVw+20ACsGC3IOIaCESr3WqKhNnY0
         uhcy6LPd1jGKtzZMgIu6cwzbNv74Y578RIn0ChXhv9hrtsFACj7z2SZoCm7n9Lc5cxpJ
         590YSEOD9hWg81kHivVHw+ZsG9UWX3EZOokv/NOFXx7Vs/CpGAbQ7xEe5adPDNeyB0Id
         HHgbguV7BpMGZk8W2J4AWFgi2TdFrbd+lC6s1XlzTsQviHvAkxQlW+ijnBbHdsKDEbFD
         gPf7gh+WPjOzkD0IH2nPiiIPZPvMbgT51iRx5ERk+49qpBvVTq2JZDZSdY4yGpnSh/5X
         yv8g==
X-Gm-Message-State: ANoB5plPYygd5xgaGosOSXkbf2h49LsYklyLTTZyYXQ5s8XMa8Y3wn9h
        o1XuUtBCLRLXQGXKnW5CuQBHW/KamM/cZCVTP+Y9/w==
X-Google-Smtp-Source: AA0mqf5A5DpDdfJWGB9crw0LgSp4qBZJrveaASusUoBLRh4msF9wZg/3Rjo79pIAegyMmLR1/3R34jfpQmkGjCipZ0s=
X-Received: by 2002:a1f:2348:0:b0:3bd:51f6:1f3 with SMTP id
 j69-20020a1f2348000000b003bd51f601f3mr14369835vkj.35.1670454991528; Wed, 07
 Dec 2022 15:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com> <20221021163703.3218176-4-jthoughton@google.com>
In-Reply-To: <20221021163703.3218176-4-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 7 Dec 2022 15:16:20 -0800
Message-ID: <CAHS8izNh6wNBhMJ-_On2OHrL5-y_75qftFy59AuGbhTe6Gmsuw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/47] hugetlb: remove redundant pte_mkhuge in
 migration path
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Fri, Oct 21, 2022 at 9:37 AM James Houghton <jthoughton@google.com> wrote:
>
> arch_make_huge_pte, which is called immediately following pte_mkhuge,
> already makes the necessary changes to the PTE that pte_mkhuge would
> have. The generic implementation of arch_make_huge_pte simply calls
> pte_mkhuge.
>
> Signed-off-by: James Houghton <jthoughton@google.com>

Acked-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/migrate.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8e5eb6ed9da2..1457cdbb7828 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -237,7 +237,6 @@ static bool remove_migration_pte(struct folio *folio,
>                 if (folio_test_hugetlb(folio)) {
>                         unsigned int shift = huge_page_shift(hstate_vma(vma));
>
> -                       pte = pte_mkhuge(pte);
>                         pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
>                         if (folio_test_anon(folio))
>                                 hugepage_add_anon_rmap(new, vma, pvmw.address,
> --
> 2.38.0.135.g90850a2211-goog
>
