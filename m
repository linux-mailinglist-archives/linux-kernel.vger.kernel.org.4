Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADB56478C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiLHWWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F81B79C81
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670538075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t77lCNIODLpJzB/PzPsfG+a/MQodrWqq6HVKm0HpGEs=;
        b=Dfdwed/d70QreYqoWbMXT4mq+RYY/iu13melmrKD0j1N7IhzX9bXGHsxAZQkmygk2HuigN
        b5ycwL0tR7FtFlDCLlUIIiiwaUG9am9QCMk61tJKCqy//GvZCrnc31xCC6hwybYyvX2E2M
        ZuBG4FFNqd8tse43aN+aqZ2NWv5XpbA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-350-FYEAnqkTOqCVBpGili9uGA-1; Thu, 08 Dec 2022 17:21:14 -0500
X-MC-Unique: FYEAnqkTOqCVBpGili9uGA-1
Received: by mail-qv1-f69.google.com with SMTP id oo9-20020a056214450900b004cfdcb99fa5so444573qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 14:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t77lCNIODLpJzB/PzPsfG+a/MQodrWqq6HVKm0HpGEs=;
        b=mXNv41AQKoRqZ6tczjJFg/wwGa4sv05dpwZa7fDnIo0X4v52k47psHK0kWe2a/PgNa
         x4KGI3VQ8d0uMsdwFatczxB8hKUD0/xAFmt4U4AuOISPnaaP+nzfi05q5sMAj/3n8FD7
         XOZ8kXZK5QHk31y0qdkltOHG4V52AtzXcvW9BKocuzV4tZX08GXCsVKLbDYUM7dR7DEV
         L19DKXtPr4PplK4uZD2TuKqrhD3iN3JaJ6m9S8cGHvQZ4QUsNgGTcErLS1zG48ik1DHo
         y6hgEdI3rnrKvWzZbKOH9RqWqeYEvU1WrxX2Lqu2A4kyoTPNIYS4iRvzpu4P3YoYWn9b
         zaxw==
X-Gm-Message-State: ANoB5pkSBZNoFNO5a6k+tBIE1fRTWSky1srJkufN4rFzbcROQFVVali1
        WLIvfWSftKxuvcjVvzBNVM0I5IH1oiqJX+4ZVuwHuGV0g9Bh98fDQZrSJ9w8VrCtVyuZ2/RLOrc
        IPxIlU9a96nSz9urnHceX6CuT
X-Received: by 2002:a05:6214:440d:b0:4bb:653c:dd05 with SMTP id oj13-20020a056214440d00b004bb653cdd05mr5414976qvb.37.1670538073904;
        Thu, 08 Dec 2022 14:21:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6fI6megs0kZxPJ5INnvc+2dK6YcUrRylUvNWmQb/47bV6nxtreyn6Z08QcI4RBwC1gTsbqNg==
X-Received: by 2002:a05:6214:440d:b0:4bb:653c:dd05 with SMTP id oj13-20020a056214440d00b004bb653cdd05mr5414958qvb.37.1670538073610;
        Thu, 08 Dec 2022 14:21:13 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dt4-20020a05620a478400b006fc9847d207sm19639798qkb.79.2022.12.08.14.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 14:21:12 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:21:00 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 10/10] mm/hugetlb: Document why page_vma_mapped_walk()
 is safe to walk
Message-ID: <Y5JjTPTxCWSklCan@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203158.651092-1-peterx@redhat.com>
 <6a970de6-e3da-f57d-14fd-55f65ddcb27d@nvidia.com>
 <Y5JRhU+9QqoUuSdR@x1n>
 <61751d01-2ba4-efc0-9cb8-eeeb3d70908d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61751d01-2ba4-efc0-9cb8-eeeb3d70908d@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 01:54:27PM -0800, John Hubbard wrote:
> On 12/8/22 13:05, Peter Xu wrote:
> > > > +		/*
> > > > +		 * NOTE: we don't need explicit lock here to walk the
> > > > +		 * hugetlb pgtable because either (1) potential callers of
> > > > +		 * hugetlb pvmw currently holds i_mmap_rwsem, or (2) the
> > > > +		 * caller will not walk a hugetlb vma (e.g. ksm or uprobe).
> > > > +		 * When one day this rule breaks, one will get a warning
> > > > +		 * in hugetlb_walk(), and then we'll figure out what to do.
> > > > +		 */
> > > 
> > > Confused. Is this documentation actually intended to refer to hugetlb_walk()
> > > itself, or just this call site? If the former, then let's move it over
> > > to be right before hugetlb_walk().
> > 
> > It is for this specific code path not hugetlb_walk().
> > 
> > The "holds i_mmap_rwsem" here is a true statement (not requirement) because
> > PVMW rmap walkers always have that.  That satisfies with hugetlb_walk()
> > requirements already even without holding the vma lock.
> > 
> 
> It's really hard to understand. Do you have a few extra words to explain it?
> I can help with actual comment wording perhaps, but I am still a bit in
> the dark as to the actual meaning. :)

Firstly, this patch (to be squashed into previous) is trying to document
page_vma_mapped_walk() on why it's not needed to further take any lock to
call hugetlb_walk().

To call hugetlb_walk() we need either of the locks listed below (in either
read or write mode), according to the rules we setup for it in patch 3:

  (1) hugetlb vma lock
  (2) i_mmap_rwsem lock

page_vma_mapped_walk() is called in below sites across the kernel:

__replace_page[179]            if (!page_vma_mapped_walk(&pvmw))
__damon_pa_mkold[24]           while (page_vma_mapped_walk(&pvmw)) {
__damon_pa_young[97]           while (page_vma_mapped_walk(&pvmw)) {
write_protect_page[1065]       if (!page_vma_mapped_walk(&pvmw))
remove_migration_pte[179]      while (page_vma_mapped_walk(&pvmw)) {
page_idle_clear_pte_refs_one[56] while (page_vma_mapped_walk(&pvmw)) {
page_mapped_in_vma[318]        if (!page_vma_mapped_walk(&pvmw))
folio_referenced_one[813]      while (page_vma_mapped_walk(&pvmw)) {
page_vma_mkclean_one[958]      while (page_vma_mapped_walk(pvmw)) {
try_to_unmap_one[1506]         while (page_vma_mapped_walk(&pvmw)) {
try_to_migrate_one[1881]       while (page_vma_mapped_walk(&pvmw)) {
page_make_device_exclusive_one[2205] while (page_vma_mapped_walk(&pvmw)) {

If we group them, we can see that most of them are during a rmap walk
(i.e., comes from a higher rmap_walk() stack), they are:

__damon_pa_mkold[24]           while (page_vma_mapped_walk(&pvmw)) {
__damon_pa_young[97]           while (page_vma_mapped_walk(&pvmw)) {
remove_migration_pte[179]      while (page_vma_mapped_walk(&pvmw)) {
page_idle_clear_pte_refs_one[56] while (page_vma_mapped_walk(&pvmw)) {
page_mapped_in_vma[318]        if (!page_vma_mapped_walk(&pvmw))
folio_referenced_one[813]      while (page_vma_mapped_walk(&pvmw)) {
page_vma_mkclean_one[958]      while (page_vma_mapped_walk(pvmw)) {
try_to_unmap_one[1506]         while (page_vma_mapped_walk(&pvmw)) {
try_to_migrate_one[1881]       while (page_vma_mapped_walk(&pvmw)) {
page_make_device_exclusive_one[2205] while (page_vma_mapped_walk(&pvmw)) {

Let's call it case (A).

We have another two special cases that are not during a rmap walk, they
are:

write_protect_page[1065]       if (!page_vma_mapped_walk(&pvmw))
__replace_page[179]            if (!page_vma_mapped_walk(&pvmw))

Let's call it case (B).

Case (A) is always safe because it always take the i_mmap_rwsem lock in
read mode.  It's done in rmap_walk_file() where:

	if (!locked) {
		if (i_mmap_trylock_read(mapping))
			goto lookup;

		if (rwc->try_lock) {
			rwc->contended = true;
			return;
		}

		i_mmap_lock_read(mapping);
	}

If locked==true it means the caller already holds the lock, so no need to
take it.  It justifies that all callers from rmap_walk() upon a hugetlb vma
is safe to call hugetlb_walk() already according to the rule of hugetlb_walk().

Case (B) contains two cases either in KSM path or uprobe path, and none of
the paths (afaict) can get a hugetlb vma involved.  IOW, the whole path of 

	if (unlikely(is_vm_hugetlb_page(vma))) {

In page_vma_mapped_walk() just should never trigger.

To summarize above into a shorter paragraph, it'll become the comment.

Hope it explains.  Thanks.

-- 
Peter Xu

