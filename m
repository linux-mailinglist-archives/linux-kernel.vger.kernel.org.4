Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7400870EB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbjEXCft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjEXCfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:35:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52BCE0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:35:46 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba86ea269e0so946556276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684895746; x=1687487746;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wlph9cB1dhCI97ix8lDyBIocNZ3f9lb+2PkhBnFZ2ZY=;
        b=ItVpWLlriECpQhEznbXeBfDnLY+lB7sBi4HZnDHLCrhniPGxw5w7ZX+8zHEXVkGF7c
         TQ27yGTrm9s2eNnIrbpYXVUJ3sW7diNccw+n/qJQSu1/6oai6fj6I96DFMiuDFNPoxdU
         pGYRnwgUgzLW3Lsebos3GB4nKb02CNMXgI5T8FJUS8BKyuJpgguUWxX5mzap70W2YjpN
         WOyLPl95+nrQGmVYVgww4GL1WjCGtAcrGJ9iXIYo4Ed7/IeTpAKvUiit4Beujrpay+bH
         B5Mju7yr9I5ZMS7yB9xRmsUpCdLsKmivYHFuC/1wGqWF27zqNZPGVZL1V0luIVm6GaY0
         opsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684895746; x=1687487746;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wlph9cB1dhCI97ix8lDyBIocNZ3f9lb+2PkhBnFZ2ZY=;
        b=blKNVydEOIJD184laEVA8Ey2AsXESlBMhIxfiNKxS7xCooyH66rADu4IVtLd3KA3l4
         4vmC6UCgKYRPCifYtmplWeb7Epr/v9lUq2hXyOf4Kfqz/XUgmLg8pWwYZG2XQ/9IzDEi
         +K0o2beFT5H8tJqehy9ikcpWbhoesGnZQtvOe65HWvxJ7+abeKVB8MNdLajWFSKLZs2+
         pIaOT3+o3RLC6exEfXo9+o+wABakGOGekLELihVoh7ksM+aqPVRrSJvplShauijfR8B8
         801QBZgTKpqNCyP6nqxHsVaayd4BIajUm4pWuuKRHRPUWTWmi1CHfhQfYAjnvRLxwVda
         zR2g==
X-Gm-Message-State: AC+VfDzjBcmBwuQiWW2cI408dWUnrEH+p49FDSwfaAtQfvlMi/yxHKUf
        J+foe2j7f+rkrpfIL68p/vfPDQ==
X-Google-Smtp-Source: ACHHUZ7FnGuO/Ia+ZwDLX+K2zSqJ/N35GxIm92w74a3HDYlMDZLC9ZLooXO4bDNAvIn/saKdy0O9Hw==
X-Received: by 2002:a0d:d107:0:b0:561:b4e3:5fc8 with SMTP id t7-20020a0dd107000000b00561b4e35fc8mr16207052ywd.37.1684895745785;
        Tue, 23 May 2023 19:35:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k131-20020a816f89000000b0055a416529bbsm3357518ywc.24.2023.05.23.19.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 19:35:45 -0700 (PDT)
Date:   Tue, 23 May 2023 19:35:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Qi Zheng <qi.zheng@linux.dev>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 05/31] mm/filemap: allow pte_offset_map_lock() to fail
In-Reply-To: <8f6057b5-362b-a0f6-2f2f-579debe48fce@linux.dev>
Message-ID: <fb9a9d57-dbd7-6a6e-d1cb-8dcd64c829a6@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <3e6d4f8-9f4d-fa7e-304e-1494dddd45b@google.com> <8f6057b5-362b-a0f6-2f2f-579debe48fce@linux.dev>
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

On Mon, 22 May 2023, Qi Zheng wrote:
> On 2023/5/22 12:54, Hugh Dickins wrote:
> > filemap_map_pages() allow pte_offset_map_lock() to fail; and remove the
> > pmd_devmap_trans_unstable() check from filemap_map_pmd(), which can safely
> > return to filemap_map_pages() and let pte_offset_map_lock() discover that.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >   mm/filemap.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 28b42ee848a4..9e129ad43e0d 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3408,13 +3408,6 @@ static bool filemap_map_pmd(struct vm_fault *vmf,
> > struct folio *folio,
> >    if (pmd_none(*vmf->pmd))
> >     pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
> >   -	/* See comment in handle_pte_fault() */
> > -	if (pmd_devmap_trans_unstable(vmf->pmd)) {
> > -		folio_unlock(folio);
> > -		folio_put(folio);
> > -		return true;
> > -	}
> > -
> >   	return false;
> >   }
> >   
> > @@ -3501,6 +3494,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> >   
> >    addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> >    vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
> > +	if (!vmf->pte) {
> > +		folio_unlock(folio);
> > +		folio_put(folio);
> 
> Missing:
> 		ret = VM_FAULT_NOPAGE;
> ?

No, not missed.  Here ret is 0, which leads do_read_fault() to try
__do_fault() afterwards.  Whereas VM_FAULT_NOPAGE would send it back
to userspace to retry the whole fault.  Either will work, but I think
the intention of VM_FAULT_NOPAGE here in filemap_map_pages() is to say
"the page you want is now inserted", which is probably not the case.

Hugh
