Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DE769FD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjBVVSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBVVSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:18:10 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB606E8C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:18:09 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id b20so11312881vsu.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=otM8qhqUgaC56OL8G3qlw4NF5AhDokREGtXy6YgiFWA=;
        b=eXV1cQ6JwcBmeQSYFlVACqwetVMSOPxE6Jd2p8DN0Zt4wzQ+k5F4nq5EKJmGG7k+y1
         2M+CMNn2TEHBOgYstQYyVi+O9HEeEjbTWUKuJOJGDvt/22beOj089cowScL9hMBd71QC
         PVNClTGqmvZwYMqPCi0biRPCZqXfMM6bZDEd0sPO/+uP8I9HHzBvh2nZQge+Odf1sxoB
         CNpQM1JFyKXWHx156KATBlzKC/7mJcI2Ub8AxYq46xGR6wPoIky+K0akrh7zaSlYKZFY
         6o2FftsSRZggVQkYrihHo8gcbD3ULni0gy/CxtKhpV3uDIHLrkB2pDf0mcFNnwic2J32
         L6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otM8qhqUgaC56OL8G3qlw4NF5AhDokREGtXy6YgiFWA=;
        b=XB805i2DD0ASjKRHrDPuQHYp4o0l+7JyARuhCUTNJgpOxdJpRek2iZh+zPjb6ZhKEH
         JpDczFOOLLlpAGbAswOMtTIVksJTyrtX9aoEOkS3Uyq8BZRzdPIMFkzjTvLBp/E2mWbp
         +NQwBuaFWfiQDNApQfDtC6prcjJt/ue14wdjjX3P60PNJe0Jb3S1NCSCPw3j0LYvwyh+
         ZwCu8nEIOTTUhZhCmPUkNMW2ChK3CDb1vvL+YSmiy2ZhqoSZT8Q4gomEkFqamVSZU4yI
         uunk4101DxlLwI8c3UtW8ps1NBinWzOBbZJ5XJ2o7UuXGViV5YclwgGEsG+85IkQzt6k
         oysA==
X-Gm-Message-State: AO0yUKVuwRtmZhECLmmK1rZC5PBnOuvkDPPFxgRmpvibrKcv2utmIY0M
        eGbAQiCrLszgBBUWkFQKCSAXqAFTIX+tu2SdvgwfSQ==
X-Google-Smtp-Source: AK7set9M9yI5gWDrVIc5jaubLhHZ9pdVfZZsdKXZRAudRRYOLYEDgOXrEunt4gpCSfAJkyWSsa2rJruKDiLt8GQXYs8=
X-Received: by 2002:ab0:38d3:0:b0:67a:2833:5ceb with SMTP id
 l19-20020ab038d3000000b0067a28335cebmr2737124uaw.0.1677100688403; Wed, 22 Feb
 2023 13:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-17-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-17-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 22 Feb 2023 13:17:57 -0800
Message-ID: <CAHS8izP9qVOV4ZvDT4vRS0-xvJ2yiQu9Uze-TSJO1f0Oec95hA@mail.gmail.com>
Subject: Re: [PATCH v2 16/46] hugetlb: make default arch_make_huge_pte
 understand small mappings
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
> This is a simple change: don't create a "huge" PTE if we are making a
> regular, PAGE_SIZE PTE. All architectures that want to implement HGM
> likely need to be changed in a similar way if they implement their own
> version of arch_make_huge_pte.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 726d581158b1..b767b6889dea 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -899,7 +899,7 @@ static inline void arch_clear_hugepage_flags(struct page *page) { }
>  static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
>                                        vm_flags_t flags)
>  {
> -       return pte_mkhuge(entry);
> +       return shift > PAGE_SHIFT ? pte_mkhuge(entry) : entry;
>  }
>  #endif
>

How are contig_pte's handled here? Will shift show that it's actually
a contig_pte and not just PAGE_SHIFT? Or is that arm64 specific so it
exists only in the arm64 version of this function? Do we need to worry
about it here?

> --
> 2.39.2.637.g21b0678d19-goog
>
