Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B36770B681
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjEVH1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjEVH1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:27:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10817E6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:27:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f606a89795so3254885e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684740436; x=1687332436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye1aYEuIFNfv2NxsNvtn+fUja3/DYESm+lSDId7JG3g=;
        b=fM+/hnIJV7bCdtGbRxg5kYbtSIChX4OadVUC2pc9Vd1xRAXocmoKtL8t9SU6mj/vXu
         S/6kvYBACzXDB8A8oYwQ7Ulcs2IoWyGAEIjqyJctkLyqAk/K/zkpi2sQejz9TajVUr1r
         N6ugp3qec7BJKWublpUzBBUDQVeV16x537tY0LmSjmfMjrPKjGV454r0r0fNuvwV04UJ
         SPNp0I5ZsRiL/nIsLY2KzzqXkl8LTr06dnqvhzn9INcjsQ3+54WT5Kvygel32cSoJFM0
         tHt0BsQ4hBlyctoORNxqGqoMZE8zN8ghGfE218GBOZvyM2Kg+LnX2evBrRecEOfmx1HB
         0TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684740436; x=1687332436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ye1aYEuIFNfv2NxsNvtn+fUja3/DYESm+lSDId7JG3g=;
        b=h3HQUZ85uT7aH16zr5zuzmBGTmCXUp+0PZOrj6PQandeSolg2HX+aw7DG2aLt5UvdX
         jFZ6UqpXaW66/GWq1AM3IWMJg6qY0KxpEx8ruXlOO1VQ4H+TXUSiPQDa0Hsfq3/I+O75
         xoNpCB4XisJnV1l7Uptbir6uahOJf7tKhLYtqRzR8h74vvpTrpyqL3bw2bjvpewxJfwr
         Dn/OFqpoCrIYLYhAp+ctGdZdZFzRKHQKOV/Whlag3beIaufoTrMGEZQxepjUNE+z12QW
         WD4l+GmCTUIvnGS0rs60U2Tie5FAwJNhuihwxYOJc5DJJSFzF0HiUmev+gOnn0Nq+4pp
         BMxA==
X-Gm-Message-State: AC+VfDw/xU74Se8tVegYvgrkuO6FKPHsuCy/vo0wpXI44PVOQGYe6pmv
        eKmqg5rI+6hotwA/kAzjPmOtn0plN98ZTQ==
X-Google-Smtp-Source: ACHHUZ4SbtkKO/UwJfOigndDknmL2Qog0yMPkICRdcXrohQLWFSR7FqbX38hgEnibAap2Ylw9zWmow==
X-Received: by 2002:a1c:4b08:0:b0:3f5:bc8:e398 with SMTP id y8-20020a1c4b08000000b003f50bc8e398mr6850864wma.13.1684740436168;
        Mon, 22 May 2023 00:27:16 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bcb91000000b003f6050d35c9sm1742602wmi.20.2023.05.22.00.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:27:14 -0700 (PDT)
Date:   Mon, 22 May 2023 08:27:14 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 12/31] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
Message-ID: <8c744725-5f58-4656-823b-997a302085f6@lucifer.local>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <fc3c7ca1-6c9c-b6c-f4df-36f24b56139@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc3c7ca1-6c9c-b6c-f4df-36f24b56139@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 10:04:07PM -0700, Hugh Dickins wrote:
> vmalloc_to_page() was using pte_offset_map() (followed by pte_unmap()),
> but it's intended for userspace page tables: prefer pte_offset_kernel().
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/vmalloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9683573f1225..741722d247d5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -703,11 +703,10 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
>  	if (WARN_ON_ONCE(pmd_bad(*pmd)))
>  		return NULL;
>
> -	ptep = pte_offset_map(pmd, addr);
> +	ptep = pte_offset_kernel(pmd, addr);
>  	pte = *ptep;
>  	if (pte_present(pte))
>  		page = pte_page(pte);
> -	pte_unmap(ptep);
>
>  	return page;
>  }
> --
> 2.35.3
>

Looks good to me,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
