Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27572A422
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjFIULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjFIULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:11:31 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704A31A1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:11:30 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-55b38fc0c70so1458945eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686341489; x=1688933489;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNhoN+f5/2l7cZy5Z84aZKirbXfCn9RTJhC9+NCxT+I=;
        b=d/6rBPd74W0HkXu+EUDXKlSN8o5i+l5/F1a2slQZafKk6WIPKC+wuMB7dADlBrLtyM
         poQQG5ScaC8fvmLhUCZ/gWgJ2zRtH2r9BnAWYzXdM4rU7YvJQBRC7IU4TT9rx69EyJvn
         bhsACpIFEGAzoPPyJ+wOA4XH9SOLnaEUZKbWCj3APhoigWRN+ZJyFwpi133I57LqMr49
         EzVmuFEGPpqnoh0Yf5uVi5LN2K4tVOwsnTjiNeOpbpg21u6GsLbyz3+q+XIiA6kykJvi
         3q3m76KPzFg3UA+XER4MD7yzah7yrXozpiQErF+7+qymD5C7n9vsHD+qXqS0M4Q1ntOo
         dKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341489; x=1688933489;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNhoN+f5/2l7cZy5Z84aZKirbXfCn9RTJhC9+NCxT+I=;
        b=GL5uTdRt9oFNIawYLAqe4VsxUWLycpR8M04TZzrxpXG9KpWCTk9iOb1VvL8YJ+2Srm
         a4hv8Ig24ZQlSJpxlbdGiJMtheXrt83VTd3kW/ZIjxYNDOsCVNny1l9hWJNf5AbM5eZf
         k8GK9rYP2FLRPjbXGdoAir+Rvy+5fny0b8+62q5RZJnTf2raa+vwaV8N9FUzoWNMIG9x
         PQmpWxpFjyZTin2OFOyxHALjna32grKVtcDEATRYFJbNi5GTfiiVCx0XU+cc9DJebKrd
         hxlYZ8/YWjYZOZuwbNIuhvbenf4uPln5vwTHRwBUP0PHAYqpMfS5SdUoePw3wyt+OQ4y
         crfw==
X-Gm-Message-State: AC+VfDzes0c2wMju5ov9a+ZYygVMy34bjs5HPPvWCC6sjP0KhjWcMQtg
        qIsSC+C5tvfcTNvcjz2V2vEKDw==
X-Google-Smtp-Source: ACHHUZ4XnN4b9GdYKVqAKytuaB3+barXDfYXv6W/j7Dy4qv6jA09xFIrqfasC+7NO0E7Y5ouP+kt4A==
X-Received: by 2002:a05:6359:1e:b0:129:cd33:9d5f with SMTP id en30-20020a056359001e00b00129cd339d5fmr2065211rwb.28.1686341489426;
        Fri, 09 Jun 2023 13:11:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a74-20020a0dd84d000000b005463e45458bsm808484ywe.123.2023.06.09.13.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:11:29 -0700 (PDT)
Date:   Fri, 9 Jun 2023 13:11:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 28/32] mm/memory: allow pte_offset_map[_lock]() to
 fail
In-Reply-To: <20230609130632.ec6ffe72fc5f7952af4a3e54@linux-foundation.org>
Message-ID: <11a9744a-e7f-33d0-474-c2f2eb7e079@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com> <bb548d50-e99a-f29e-eab1-a43bef2a1287@google.com> <20230609130632.ec6ffe72fc5f7952af4a3e54@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2023, Andrew Morton wrote:
> On Thu, 8 Jun 2023 18:43:38 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> 
> > copy_pte_range(): use pte_offset_map_nolock(), and allow for it to fail;
> > but with a comment on some further assumptions that are being made there.
> > 
> > zap_pte_range() and zap_pmd_range(): adjust their interaction so that
> > a pte_offset_map_lock() failure in zap_pte_range() leads to a retry in
> > zap_pmd_range(); remove call to pmd_none_or_trans_huge_or_clear_bad().
> > 
> > Allow pte_offset_map_lock() to fail in many functions.  Update comment
> > on calling pte_alloc() in do_anonymous_page().  Remove redundant calls
> > to pmd_trans_unstable(), pmd_devmap_trans_unstable(), pmd_none() and
> > pmd_bad(); but leave pmd_none_or_clear_bad() calls in free_pmd_range()
> > and copy_pmd_range(), those do simplify the next level down.
> > 
> > ...
> >
> > @@ -3728,11 +3737,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  			vmf->page = pfn_swap_entry_to_page(entry);
> >  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> >  					vmf->address, &vmf->ptl);
> > -			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
> > -				spin_unlock(vmf->ptl);
> > -				goto out;
> > -			}
> > -
> > +			if (unlikely(!vmf->pte ||
> > +				     !pte_same(*vmf->pte, vmf->orig_pte)))
> > +				goto unlock;
> >  			/*
> >  			 * Get a page reference while we know the page can't be
> >  			 * freed.
> 
> This hunk falls afoul of
> https://lkml.kernel.org/r/20230602092949.545577-5-ryan.roberts@arm.com.
> 
> I did this:
> 
> @@ -3729,7 +3738,8 @@ vm_fault_t do_swap_page(struct vm_fault
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>  					vmf->address, &vmf->ptl);
> -			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
> +			if (unlikely(!vmf->pte ||
> +				     !pte_same(*vmf->pte, vmf->orig_pte)))
>  				goto unlock;
>  
>  			/*

Yes, that's exactly right: thanks, Andrew.

Hugh
