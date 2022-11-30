Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C83763DA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiK3Q0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiK3Q0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:26:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DB87CA9D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669825508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OW4fKClhGHajD6zp9BCF2+LLlrB3sbikqsBRGd8LqJE=;
        b=CxTDumZSxnlITyJd4cNUEbGbymA/DA6Wilspadqlzai2KjowDZkJOLDn0sijCn9xKUj+v7
        PTCgUE3bAE78+RAKevQFjcAYJ5qR3SYaRM6xe7VxZUhoNS9fTusjw85u8LQ1e3QJKIRoWK
        RjrlYioAjNlijJ+l0rQBSdh3nBU7sc8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-L9L9TsxZPDaGc-qQz6lviA-1; Wed, 30 Nov 2022 11:25:06 -0500
X-MC-Unique: L9L9TsxZPDaGc-qQz6lviA-1
Received: by mail-qk1-f200.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so38732847qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW4fKClhGHajD6zp9BCF2+LLlrB3sbikqsBRGd8LqJE=;
        b=zEfJfTx3ZoydM71uRGhmWX1YdOGfYW/pE7gMM/pLgUXFTHSWwNwVf9PkCog0W9g04G
         UfVNQvVXNcNWVK+sT+x/yrZqpwRUK6CwDlvArhdf3YNukE5gXu3Q4z4GjHI7AakFQiOg
         biInFhNiv/FJvilsvA2c6pakRo1xpshOhoCdsInc4hdtb6rtYGq62Xb/pZjY73psr9aa
         k224RwsTd0odAkYXGX4qe8FWNHAixrSOmI1rw1DNBPEg47R6zejt64eGx138yJqzvZHe
         FYHEQk0j4CnDJCoTqmBM9zP/yQ5Oijpz5UWZgprbQk0n/wgk+pyJbbUwpZwCjMngwTBd
         WQTw==
X-Gm-Message-State: ANoB5pk7yUdSzVcSXx46jukak33YHAqAqHn04rLnSQME7XltzOQWHsvh
        6a7UgYx9FNdzZuETexCbj5Us865xBLorXImx+b9tCOHD110JnSqXQlG+R+vupIH0ZfrFiTsIsNU
        wHkW7pWmTQnq3Tc4E42QLo3uF
X-Received: by 2002:a37:9647:0:b0:6fa:2e16:b776 with SMTP id y68-20020a379647000000b006fa2e16b776mr53386515qkd.212.1669825506072;
        Wed, 30 Nov 2022 08:25:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7XniJ7VKQOaiBf5ZK8TmNW5rCfJvmhLFhhxgrlHoCHBFPF62lNS79qCLkdHGO2LPPXI7y3qQ==
X-Received: by 2002:a37:9647:0:b0:6fa:2e16:b776 with SMTP id y68-20020a379647000000b006fa2e16b776mr53386491qkd.212.1669825505806;
        Wed, 30 Nov 2022 08:25:05 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bs42-20020a05620a472a00b006b61b2cb1d2sm1485856qkb.46.2022.11.30.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:25:05 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:25:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 03/10] mm/hugetlb: Document huge_pte_offset usage
Message-ID: <Y4eD4EW2sAlb00RO@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-4-peterx@redhat.com>
 <afce1bdf-6b5f-3393-cafa-81148277773d@redhat.com>
 <Y4eAJuZRG0CLP7PW@x1n>
 <b4bad424-9ae3-41e2-d844-6fa63f44be62@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4bad424-9ae3-41e2-d844-6fa63f44be62@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

        On Wed, Nov 30, 2022 at 05:11:36PM +0100, David Hildenbrand wrote:
> On 30.11.22 17:09, Peter Xu wrote:
> > On Wed, Nov 30, 2022 at 11:24:34AM +0100, David Hildenbrand wrote:
> > > On 29.11.22 20:35, Peter Xu wrote:
> > > > huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
> > > > hugetlb address.
> > > > 
> > > > Normally, it's always safe to walk a generic pgtable as long as we're with
> > > > the mmap lock held for either read or write, because that guarantees the
> > > > pgtable pages will always be valid during the process.
> > > > 
> > > > But it's not true for hugetlbfs, especially shared: hugetlbfs can have its
> > > > pgtable freed by pmd unsharing, it means that even with mmap lock held for
> > > > current mm, the PMD pgtable page can still go away from under us if pmd
> > > > unsharing is possible during the walk.
> > > > 
> > > > So we have two ways to make it safe even for a shared mapping:
> > > > 
> > > >     (1) If we're with the hugetlb vma lock held for either read/write, it's
> > > >         okay because pmd unshare cannot happen at all.
> > > > 
> > > >     (2) If we're with the i_mmap_rwsem lock held for either read/write, it's
> > > >         okay because even if pmd unshare can happen, the pgtable page cannot
> > > >         be freed from under us.
> > > > 
> > > > Document it.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >    include/linux/hugetlb.h | 32 ++++++++++++++++++++++++++++++++
> > > >    1 file changed, 32 insertions(+)
> > > > 
> > > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > > index 551834cd5299..81efd9b9baa2 100644
> > > > --- a/include/linux/hugetlb.h
> > > > +++ b/include/linux/hugetlb.h
> > > > @@ -192,6 +192,38 @@ extern struct list_head huge_boot_pages;
> > > >    pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> > > >    			unsigned long addr, unsigned long sz);
> > > > +/*
> > > > + * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
> > > > + * Returns the pte_t* if found, or NULL if the address is not mapped.
> > > > + *
> > > > + * Since this function will walk all the pgtable pages (including not only
> > > > + * high-level pgtable page, but also PUD entry that can be unshared
> > > > + * concurrently for VM_SHARED), the caller of this function should be
> > > > + * responsible of its thread safety.  One can follow this rule:
> > > > + *
> > > > + *  (1) For private mappings: pmd unsharing is not possible, so it'll
> > > > + *      always be safe if we're with the mmap sem for either read or write.
> > > > + *      This is normally always the case, IOW we don't need to do anything
> > > > + *      special.
> > > 
> > > Maybe worth mentioning that hugetlb_vma_lock_read() and friends already
> > > optimize for private mappings, to not take the VMA lock if not required.
> > 
> > Yes we can.  I assume this is not super urgent so I'll hold a while to see
> > whether there's anything else that needs amending for the documents.
> > 
> > Btw, even with hugetlb_vma_lock_read() checking SHARED for a private only
> > code path it's still better to not take the lock at all, because that still
> > contains a function jump which will be unnecesary.
> 
> IMHO it makes coding a lot more consistent and less error-prone when not
> care about whether to the the lock or not (as an optimization) and just
> having this handled "automatically".
> 
> Optimizing a jump out would rather smell like a micro-optimization.

Or we can move the lock helpers into the headers, too.

-- 
Peter Xu

