Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4C628A24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbiKNUKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiKNUKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2671A39B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668456550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6n6zpJl4G/A5VCRLcxo9kc/9ERsyYZ62NHpJBtTugxQ=;
        b=JI5D9uzxnl3BSD+4vHbEBJduzdRd/4r+2ImrRpRWeaDnHIEdMc/bN3rut2Fb4dfIPK0uIV
        sAZU6c9t4vAHnWru5WcM/4CkfxxrKO6QspUPSFZyFVOstqfUxEM5SaoLzavWRJtjomAkW3
        rqXoLMv3jjef5GfCHhuNDlcHGH6OmqU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-LYKq3BnkNfmmgV0O19DxqA-1; Mon, 14 Nov 2022 15:09:08 -0500
X-MC-Unique: LYKq3BnkNfmmgV0O19DxqA-1
Received: by mail-qk1-f199.google.com with SMTP id bm2-20020a05620a198200b006fa6eeee4a9so11959790qkb.14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n6zpJl4G/A5VCRLcxo9kc/9ERsyYZ62NHpJBtTugxQ=;
        b=k8KH9cK9/o1z0lVdEXLV3i3vhW/IRXuHaaeecTbWiygy6JfP/mQmfeycixazln7wqw
         /wyD9n1SEI8xjND0zcHBdOzCLdlJmcfimxBoxCASjXYD7tkwOLNukpGsQ6dF1mrLS5Lv
         QNtNuBXaODT7nkXbC82hGGRHHwBwOTcHrnkrBqzemUMzk4L0KfsGfqDN1P2hAXngYGEY
         pqDtZIuBvOkbO4MotfqNZxg5Ww+uSw+qyjtdB8v1nHaw+RHiTg38dWt9L52CNAVlnjJW
         XyIkpVJwZGxIISw93YMufMtmX1/jqxPsQJtiS1KJ1ykNA5C6D7N+cTXMdMtWALHPvZrS
         d7GQ==
X-Gm-Message-State: ANoB5pnyvBkEP82Q4SSXBvKtXL/K5FnPxXmR0ImUSX0Vaodh8VtcDAIz
        MU+BBraIBazh8/DVud8ZRthihRgcKDDeY0sEITHjYqIfxWJwNnmhhHPmo+iM2slSvgSkfv3fAhP
        Kpm3XTUTLaQdcdzXXaYiXjmHk
X-Received: by 2002:ae9:e416:0:b0:6fa:21ba:b882 with SMTP id q22-20020ae9e416000000b006fa21bab882mr12368623qkc.646.1668456547897;
        Mon, 14 Nov 2022 12:09:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6upwGHutL5OZAEnZpDgA+t9A69V+yZeqyR7wNZmEjKXlTMunsCllTaEmsySgYRdSqy77p31w==
X-Received: by 2002:ae9:e416:0:b0:6fa:21ba:b882 with SMTP id q22-20020ae9e416000000b006fa21bab882mr12368602qkc.646.1668456547589;
        Mon, 14 Nov 2022 12:09:07 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a244300b006eed47a1a1esm6992533qkn.134.2022.11.14.12.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:09:07 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:09:05 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/migrate: Fix read-only page got writable when
 recover pte
Message-ID: <Y3KgYeMTdTM0FN5W@x1n>
References: <20221110203132.1498183-1-peterx@redhat.com>
 <20221110203132.1498183-2-peterx@redhat.com>
 <9af36be3-313b-e39c-85bb-bf30011bccb8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9af36be3-313b-e39c-85bb-bf30011bccb8@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:09:32PM +0100, David Hildenbrand wrote:
> On 10.11.22 21:31, Peter Xu wrote:
> > Ives van Hoorne from codesandbox.io reported an issue regarding possible
> > data loss of uffd-wp when applied to memfds on heavily loaded systems.  The
> > sympton is some read page got data mismatch from the snapshot child VMs.
> > 
> > Here I can also reproduce with a Rust reproducer that was provided by Ives
> > that keeps taking snapshot of a 256MB VM, on a 32G system when I initiate
> > 80 instances I can trigger the issues in ten minutes.
> > 
> > It turns out that we got some pages write-through even if uffd-wp is
> > applied to the pte.
> > 
> > The problem is, when removing migration entries, we didn't really worry
> > about write bit as long as we know it's not a write migration entry.  That
> > may not be true, for some memory types (e.g. writable shmem) mk_pte can
> > return a pte with write bit set, then to recover the migration entry to its
> > original state we need to explicit wr-protect the pte or it'll has the
> > write bit set if it's a read migration entry.
> > 
> > For uffd it can cause write-through.  I didn't verify, but I think it'll be
> > the same for mprotect()ed pages and after migration we can miss the sigbus
> > instead.
> 
> I don't think so. mprotect() handling relies on vma->vm_page_prot, which is
> supposed to do the right thing. E.g., map the pte protnone without
> VM_READ/VM_WRITE/....

I've removed that example when I posted v3, feel free to have a look.

> 
> > 
> > The relevant code on uffd was introduced in the anon support, which is
> > commit f45ec5ff16a7 ("userfaultfd: wp: support swap and page migration",
> > 2020-04-07).  However anon shouldn't suffer from this problem because anon
> > should already have the write bit cleared always, so that may not be a
> > proper Fixes target.  To satisfy the need on the backport, I'm attaching
> > the Fixes tag to the uffd-wp shmem support.  Since no one had issue with
> > mprotect, so I assume that's also the kernel version we should start to
> > backport for stable, and we shouldn't need to worry before that.
> > 
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: stable@vger.kernel.org
> > Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")
> > Reported-by: Ives van Hoorne <ives@codesandbox.io>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/migrate.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index dff333593a8a..8b6351c08c78 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -213,8 +213,14 @@ static bool remove_migration_pte(struct folio *folio,
> >   			pte = pte_mkdirty(pte);
> >   		if (is_writable_migration_entry(entry))
> >   			pte = maybe_mkwrite(pte, vma);
> > -		else if (pte_swp_uffd_wp(*pvmw.pte))
> > +		else
> > +			/* NOTE: mk_pte can have write bit set */
> > +			pte = pte_wrprotect(pte);
> 
> 
> Any particular reason why not to simply glue this to pte_swp_uffd_wp(),
> because only that needs special care:
> 
> if (pte_swp_uffd_wp(*pvmw.pte)) {
> 	pte = pte_wrprotect(pte);
> 	pte = pte_mkuffd_wp(pte);
> }
> 
> 
> And that would match what actually should have been done in commit
> f45ec5ff16a7 -- only special-case uffd-wp.
> 
> Note that I think there are cases where we have a PTE that was !writable,
> but after migration we can map it writable.

The thing is recovering the pte into its original form is the safest
approach to me, so I think we need justification on why it's always safe to
set the write bit.

Or do you perhaps have solid clue and think it's always safe?

> 
> BTW, does unuse_pte() need similar care?
> 
> new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
> if (pte_swp_uffd_wp(*pte))
> 	new_pte = pte_mkuffd_wp(new_pte);
> set_pte_at(vma->vm_mm, addr, pte, new_pte);

I think unuse path is fine because unuse only applies to private mappings,
so we should always have the W bit removed there within mk_pte().

Thanks,

-- 
Peter Xu

