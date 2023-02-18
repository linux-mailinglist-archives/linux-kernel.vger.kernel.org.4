Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CF269B755
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 02:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBRBKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 20:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBRBKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 20:10:46 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A14CCBA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:10:43 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id q20so963509ilc.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ue1lMsoprr2ErBJHCanJ4kxr4Tbf1Q6clHNnM5+twY=;
        b=MaPE7eNCeDtjj7lvxv5iY8sHQkz3Dg9eePVjJhYmFLnVftdXTHUVMmm9jQUfZ9C8UL
         Eqj5bVqaYiiSnzz++oxqRtMAGkcOHem2Qtd/MIOXL6WeAWL1AvR93ZCAFsXfMtkMbj8+
         FH4qBJFQQNJeiaD7mLy6R04FXG37cok9VQmrSU4rgPjFzewQMKdgplJm7wbzcKfrfj5V
         sTIcjSuJT8wi4vZpnSI5twWE6hQFMdDT45x3lcOM4IOY82dz2Zj6lcrsqw+/rD7EHe8M
         SGxjvc4Wk7es9Oo7dqaeW0ms2nhKftVI+WMrO+/OI1dY9f/azJPhklH+m98k6hmEdYh/
         2NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ue1lMsoprr2ErBJHCanJ4kxr4Tbf1Q6clHNnM5+twY=;
        b=UoGUz2rRRxMUhxyQQRGdg0WztacvwSbq/Uxp0mbd/fHUwoW+nQ9u4q8ElxaDf4BgdE
         qytwXkv4RmvqWVyk48oYJGDOt0EOWKgPP9Fxk10fGaLUNeqrnkWoRGbIH7kVHLCrCobh
         esGWJYTUPlVsUPnOlGebQEsW1fLE2MVpeDHCBJNIdnCqiQcShiyQm4Khbp3ErYQQa35a
         JCCHsQcxc2WKmR46pX/9Ej633ZAik03+6W9UdKr9eM4bkutyZeI0Sjc2lLeyLAW7lwn/
         22GXynSiEyNiOx/S7YlKRgn2ZWlu99+eRTVywSueTkEnjGErgs4szHVTd0udKpDXpbIq
         5Uqw==
X-Gm-Message-State: AO0yUKW6qNZ4yIC3RMqFLcYVE97e+3QSwIl3LU+DY6eAFYuLyNmQwoYZ
        NppEy5KK7TQbKBSNCJG3kPMqee9mba++dVyb5pq5rw==
X-Google-Smtp-Source: AK7set/xG/fW0zYQg+pZoFZLwPiwJfXn0Br3o2PaJdcb7CRH0wHWdqz4zPq6AEPXf0UwzKpx5lRtJfSn22TcQpLtUMc=
X-Received: by 2002:a05:6e02:130e:b0:315:3bc0:354 with SMTP id
 g14-20020a056e02130e00b003153bc00354mr740021ilr.1.1676682643043; Fri, 17 Feb
 2023 17:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-5-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-5-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 17 Feb 2023 17:10:31 -0800
Message-ID: <CAHS8izOoc=XPGiDZ0DgAcFPcnjZeZTiXXyZ5aNT=hgNhH0phRg@mail.gmail.com>
Subject: Re: [PATCH v2 04/46] hugetlb: only adjust address ranges when VMAs
 want PMD sharing
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
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 17, 2023 at 4:28=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> Currently this check is overly aggressive. For some userfaultfd VMAs,
> VMA sharing is disabled, yet we still widen the address range, which is
> used for flushing TLBs and sending MMU notifiers.
>
> This is done now, as HGM VMAs also have sharing disabled, yet would
> still have flush ranges adjusted. Overaggressively flushing TLBs and
> triggering MMU notifiers is particularly harmful with lots of
> high-granularity operations.
>
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: James Houghton <jthoughton@google.com>

Acked-by: Mina Almasry <almasrymina@google.com>

>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 540cdf9570d3..08004371cfed 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6999,22 +6999,31 @@ static unsigned long page_table_shareable(struct =
vm_area_struct *svma,
>         return saddr;
>  }
>
> -bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
> +static bool pmd_sharing_possible(struct vm_area_struct *vma)
>  {
> -       unsigned long start =3D addr & PUD_MASK;
> -       unsigned long end =3D start + PUD_SIZE;
> -
>  #ifdef CONFIG_USERFAULTFD
>         if (uffd_disable_huge_pmd_share(vma))
>                 return false;
>  #endif
>         /*
> -        * check on proper vm_flags and page table alignment
> +        * Only shared VMAs can share PMDs.
>          */
>         if (!(vma->vm_flags & VM_MAYSHARE))
>                 return false;
>         if (!vma->vm_private_data)      /* vma lock required for sharing =
*/
>                 return false;
> +       return true;
> +}
> +
> +bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
> +{
> +       unsigned long start =3D addr & PUD_MASK;
> +       unsigned long end =3D start + PUD_SIZE;
> +       /*
> +        * check on proper vm_flags and page table alignment
> +        */
> +       if (!pmd_sharing_possible(vma))
> +               return false;
>         if (!range_in_vma(vma, start, end))
>                 return false;
>         return true;
> @@ -7035,7 +7044,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm=
_area_struct *vma,
>          * vma needs to span at least one aligned PUD size, and the range
>          * must be at least partially within in.
>          */
> -       if (!(vma->vm_flags & VM_MAYSHARE) || !(v_end > v_start) ||
> +       if (!pmd_sharing_possible(vma) || !(v_end > v_start) ||
>                 (*end <=3D v_start) || (*start >=3D v_end))
>                 return;
>
> --
> 2.39.2.637.g21b0678d19-goog
>
