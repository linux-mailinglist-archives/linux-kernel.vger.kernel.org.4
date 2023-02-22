Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2535169FD9A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjBVVPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBVVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:15:13 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1925E10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:15:11 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id v27so3511356vsa.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677100511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1m4zHkmfDXhrcpX0Sw9engd7Wnt/0n2RMJDfDI6SB8c=;
        b=LGTJs4zuCkaFTTngo/aLavBPfYKhXkG5ilMCj6N6GxB8mCE8r59hqOtBaf6XKXl07W
         IrgfANABWcMOdBoXpKDrfaBM4AkIM/dZWE6VduxNLnPgBvTM5czU98uDknTpv/Ig/jeK
         d2kUBhLcWHKfgykxv6BFnUUKk1gPOjbFws6tf2wUJgTuaFxgIlvpe2gBjouBp/ev00fj
         R/G4ytpAIeH2btcUxD68nYdnG2K/48WjHgdTfp0LE323mArH688CjkxT+ewftD2OiMVH
         YzCNmAuXzIoYEt/IqXZcrymRwX350B3d1H6xhspcfPMdKsVomI1pKsguo1CskglCVQ+f
         VUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677100511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1m4zHkmfDXhrcpX0Sw9engd7Wnt/0n2RMJDfDI6SB8c=;
        b=A1FsxdsfdG1fss+tcbTvEd3tkMBtvII8khjNfpFj+hhW70TiAz9q0g5z/nbJdPYLRV
         9hCqaML4U8VdeHY80bPQ7cEA9HZzjdIJwT0I3PmAc0LvTEXKe90iiVRIYKdUrQaoAvx0
         JtUrInUjYd24YM/JTgChdZwHdiYpu5VhDG7amAwbIB0M7FBk/BTwi5fFnonLxdrM//6c
         GcwvJ5g104iylMK2Dxjx5t/ruGLlVval3VyaTFKAT9Fc+BbcIqhZr4X2/nnB3Vr9zfFb
         Pr9kMSd3o8BAQVllAJPSijbmmNQtAzQXgXFE4rLbidU+LqA3nxysixkMYLEztxxUXqAH
         ZqnA==
X-Gm-Message-State: AO0yUKVtfQmA91SAScUg6ohnqBds3YCrWS0sWnCRxd/xoNxGMtZCQP9y
        AZoXpyOQx4eN0BJd9aZ3WqbplOrx+cCawtJ8rgo47w==
X-Google-Smtp-Source: AK7set9Cr/aHiZ7dglVSYqcXCcOMSjSmXKsbuk5gHI7Cod+yOxVd6a/hpUU+dlK3nafpLtcSaggmUp7ZSqSTIUcOpi4=
X-Received: by 2002:a05:6102:23f6:b0:3c8:6949:ea4c with SMTP id
 p22-20020a05610223f600b003c86949ea4cmr2240794vsc.76.1677100510730; Wed, 22
 Feb 2023 13:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-16-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-16-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 22 Feb 2023 13:14:59 -0800
Message-ID: <CAHS8izPAcFSn-TyZyGr0C3b7Q-0t3GUUjHdB2Q=Z79F8USa5RA@mail.gmail.com>
Subject: Re: [PATCH v2 15/46] hugetlb: add make_huge_pte_with_shift
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

On Fri, Feb 17, 2023 at 4:28 PM James Houghton <jthoughton@google.com> wrote:
>
> This allows us to make huge PTEs at shifts other than the hstate shift,
> which will be necessary for high-granularity mappings.
>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: James Houghton <jthoughton@google.com>
>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f74183acc521..ed1d806020de 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5110,11 +5110,11 @@ const struct vm_operations_struct hugetlb_vm_ops = {
>         .pagesize = hugetlb_vm_op_pagesize,
>  };
>
> -static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> -                               int writable)
> +static pte_t make_huge_pte_with_shift(struct vm_area_struct *vma,
> +                                     struct page *page, int writable,
> +                                     int shift)

Nit: can this be 'unsigned int shift'. Because you're actually passing
it an unsigned int below and there is an implicit cast there. Yes it
will never matter, I know...

>  {
>         pte_t entry;
> -       unsigned int shift = huge_page_shift(hstate_vma(vma));
>
>         if (writable) {
>                 entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_pte(page,
> @@ -5128,6 +5128,14 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
>         return entry;
>  }
>
> +static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> +                          int writable)
> +{
> +       unsigned int shift = huge_page_shift(hstate_vma(vma));
> +
> +       return make_huge_pte_with_shift(vma, page, writable, shift);
> +}
> +
>  static void set_huge_ptep_writable(struct vm_area_struct *vma,
>                                    unsigned long address, pte_t *ptep)
>  {
> --
> 2.39.2.637.g21b0678d19-goog
>
