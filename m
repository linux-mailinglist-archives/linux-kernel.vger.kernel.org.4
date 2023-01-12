Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3A7668419
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjALUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjALUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:39:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1073D1FA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:09:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay40so13983528wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L+Y11wIGuYqM3WI5W/LJtU3EbjeOxgch9hg5fvLKprA=;
        b=EHveCHrEQM6di4eSOYUn1btRpD7sMd94Bvi9ViJpKA7vkN9kosVxVrfw8UfaPKaW7p
         sAWGmoLAGpNUi6o4VBQiTkStcPlu/rQY7MrC44vezeiiwL9zYXiBU9yXSRMccAK39SIF
         8WRGS7ztDz1uRJ77JocG4wUZC+91enLHst4i8QyGXVT2PzRvsiaaWcjVThWyB6x+H4ZN
         w2BDNvEf8mgti6WQQkDbxZLG8aG2rQyBDOHaV2rSIyngZ+9fEVfKMk85TLURuQldC2xN
         itKHuvGps12X8lmw72CziPs7BqcrgOCAuKejJsTAARdi9z7fUZV8n663jsPv7Zl6N92U
         ZwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+Y11wIGuYqM3WI5W/LJtU3EbjeOxgch9hg5fvLKprA=;
        b=HGCk7VAL0iyur7csw+tHvwUTIOmnRJ6tXjHBFm6JkZs5IN4eXPd9V0FOpuBUBc7WJx
         yRUbBcsNGl8uH4Ghmu7vbA3/HQmY8GqH7NCXD7u0MozQr3aFbD2lz9XPWQaeYKSTHrUl
         f5x0yPwU5YZbW07woC0LuaRlqe8nqJtS73WUu/JMbl3kYqCBdq5OElxi2padFGmxc6bt
         WohhuAkOcsqrhnlkeN8CZyia4gcve/+BCUBc8NUu9sxAn6sDNoZaMBvfjPb2I9/e6IJG
         vGchgpmySpitStnS3PTo+9sqPqmIr/Su/JN0Wxses73akm4UUj0RvBVtOxqBMfX9ApJw
         +YHQ==
X-Gm-Message-State: AFqh2kq9zGrWhCAOPfis1U2N8qx2RVMZbzz+ZyAAekCHSkLPQAj2lhpB
        0UDvc95XTGg1seUJCLOMsLbqju/SxYpa5zb3o0DaRg==
X-Google-Smtp-Source: AMrXdXufgQGH2cEs5Qj5NeuGspAW8MOLszNSVJ+/Ep0+vTsrcrJhgZmp1AMKaWLGQUBrPsSiKKaJiEXHH9XRcZ/ywSM=
X-Received: by 2002:a05:600c:4c22:b0:3cf:f2aa:3dc2 with SMTP id
 d34-20020a05600c4c2200b003cff2aa3dc2mr4165848wmp.175.1673554084644; Thu, 12
 Jan 2023 12:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com> <20230105101844.1893104-40-jthoughton@google.com>
In-Reply-To: <20230105101844.1893104-40-jthoughton@google.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 12 Jan 2023 15:07:53 -0500
Message-ID: <CADrL8HWLCL1p2x1rgvX1Bc5UEupjMqjud0fKGys-TpKUTCeVcw@mail.gmail.com>
Subject: Re: [PATCH 39/46] hugetlb: x86: enable high-granularity mapping
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
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

On Thu, Jan 5, 2023 at 5:19 AM James Houghton <jthoughton@google.com> wrote:
>
> Now that HGM is fully supported for GENERAL_HUGETLB, x86 can enable it.
> The x86 KVM MMU already properly handles HugeTLB HGM pages (it does a
> page table walk to determine which size to use in the second-stage page
> table instead of, for example, checking vma_mmu_pagesize, like arm64
> does).
>
> We could also enable HugeTLB HGM for arm (32-bit) at this point, as it
> also uses GENERAL_HUGETLB and I don't see anything else that is needed
> for it. However, I haven't tested on arm at all, so I won't enable it.

Given that we are using a high bit for VM_HUGETLB_HGM, we can only
support 64-bit architectures. Userfaultfd minor faults is limited to
64-bit architectures for the same reason: VM_UFFD_MINOR uses a bit.

>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3604074a878b..3d08cd45549c 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -126,6 +126,7 @@ config X86
>         select ARCH_WANT_GENERAL_HUGETLB
>         select ARCH_WANT_HUGE_PMD_SHARE
>         select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP  if X86_64
> +       select ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING

This needs `if X86_64` at the end. Will be corrected for v2.

>         select ARCH_WANT_LD_ORPHAN_WARN
>         select ARCH_WANTS_THP_SWAP              if X86_64
>         select ARCH_HAS_PARANOID_L1D_FLUSH
> --
> 2.39.0.314.g84b9a713c41-goog
>
