Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20256C14FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjCTOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCTOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D54697
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679323296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lSMB6cdmr6XyOr+cjJxLrfI2j1ikkNVrD7zJD465Tpo=;
        b=GtP+zgrYJSqKdSSCOxAytaYZOSNBly48jT5Dnj1xzZDIk9wQnRa3bB4VVbkK5NpymagFK0
        R0xkOZbtOB6ahjbE6PMimZbRIQKEwFu2QH91dRxilAqn+8sJGO8/8KN6xhBOITpBTZSSeU
        vbIRaKlJQ/TIcZtsNlPGtM+sunxLIQs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-CDqHUA0WOWKAfYix48WwFg-1; Mon, 20 Mar 2023 10:41:35 -0400
X-MC-Unique: CDqHUA0WOWKAfYix48WwFg-1
Received: by mail-qk1-f197.google.com with SMTP id 198-20020a370bcf000000b007468cffa4e2so845741qkl.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSMB6cdmr6XyOr+cjJxLrfI2j1ikkNVrD7zJD465Tpo=;
        b=zqouKscFMKbRxy2gK6AWwjowTfnizcyruPww2594CN8vrN7OpDW6wc/FDe7m/1Htu6
         TMT7F7wJRNzxgukuSaft1fdemWqvMdmrD7Wg8B52lvHzK2uotA8bpwx8LjcHVM5eQNph
         3qnuvsENpnK78x0qGCRorGJ1X+nG2+0jAx91l68v2vZpXGRH5FMe5nIoDCTAF1MxsfB4
         4VJ3+FO+mbAr/wPjphZakar3Vrtzt7RFLVEFz/a/mLkGgyZ36OvehzJAOehfQu3OMDnT
         8PhRncyYOvM18o75k/5vnhx7fIXO8u4Rk9lTbmWIrx+mMzA86W4XL8iNV1zvmTXuljBM
         Tkfw==
X-Gm-Message-State: AO0yUKXxUq6DFuz3uCR5MBfRGSXjEG0Yrc4gz/90gM6FmjQ6/K8J8tWq
        Waxjrp6llypLjzMQDDyJA2eNsiOjieIIDaK+9u1OVjUmxKbGlZZKb2mMjbOsGUuTrRLajzhuahj
        7V2vpZiIDOMCccFvaSy9x1HVh
X-Received: by 2002:ad4:5961:0:b0:532:141d:3750 with SMTP id eq1-20020ad45961000000b00532141d3750mr25071512qvb.2.1679323294634;
        Mon, 20 Mar 2023 07:41:34 -0700 (PDT)
X-Google-Smtp-Source: AK7set8zT8F3mCZxJvFU1T+Bzz6l8oCAXcJ/whdF6bkxNT6JJHOQlaqkWO7BSiw6JRofpeTwOd1B7w==
X-Received: by 2002:ad4:5961:0:b0:532:141d:3750 with SMTP id eq1-20020ad45961000000b00532141d3750mr25071487qvb.2.1679323294317;
        Mon, 20 Mar 2023 07:41:34 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b00745c2b29091sm179229qkp.93.2023.03.20.07.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:41:33 -0700 (PDT)
Date:   Mon, 20 Mar 2023 10:41:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <ZBhwnCNn27z0r5w+@x1n>
References: <20230309223711.823547-1-peterx@redhat.com>
 <20230309223711.823547-2-peterx@redhat.com>
 <cf338070-246e-25d3-e624-53f4beda8158@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf338070-246e-25d3-e624-53f4beda8158@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:21:13AM +0100, David Hildenbrand wrote:
> 
> >    (1) With huge page disabled
> >    echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
> >    ./uffd_wp_perf
> >    Test DEFAULT: 4
> >    Test PRE-READ: 1111453 (pre-fault 1101011)
> >    Test MADVISE: 278276 (pre-fault 266378)
> 
> Thinking about it, I guess the biggest slowdown here is the "one fake
> pagefault at a time" handling.

I think so, though I assume the idea here is to avoid any faulting.

> 
> >    Test WP-UNPOPULATE: 11712
> > 
> >    (2) With Huge page enabled
> >    echo always > /sys/kernel/mm/transparent_hugepage/enabled
> >    ./uffd_wp_perf
> >    Test DEFAULT: 4
> >    Test PRE-READ: 22521 (pre-fault 22348)
> >    Test MADVISE: 4909 (pre-fault 4743)
> >    Test WP-UNPOPULATE: 14448
> > 
> > There'll be a great perf boost for no-thp case, while for thp enabled with
> > extreme case of all-thp-zero WP_UNPOPULATED can be slower than MADVISE, but
> > that's low possibility in reality, also the overhead was not reduced but
> > postponed until a follow up write on any huge zero thp, so potentially it
> > is faster by making the follow up writes slower.
> > 
> > [1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
> > [2] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
> > [3] https://lore.kernel.org/all/d0eb0a13-16dc-1ac1-653a-78b7273781e3@collabora.com/
> > [4] https://github.com/xzpeter/clibs/blob/master/uffd-test/uffd-wp-perf.c
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   Documentation/admin-guide/mm/userfaultfd.rst | 17 ++++++
> >   fs/userfaultfd.c                             | 16 ++++++
> >   include/linux/mm_inline.h                    |  6 +++
> >   include/linux/userfaultfd_k.h                | 23 ++++++++
> >   include/uapi/linux/userfaultfd.h             | 10 +++-
> >   mm/memory.c                                  | 56 +++++++++++++++-----
> >   mm/mprotect.c                                | 51 ++++++++++++++----
> >   7 files changed, 154 insertions(+), 25 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> > index 7dc823b56ca4..c86b56c95ea6 100644
> > --- a/Documentation/admin-guide/mm/userfaultfd.rst
> > +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> > @@ -219,6 +219,23 @@ former will have ``UFFD_PAGEFAULT_FLAG_WP`` set, the latter
> >   you still need to supply a page when ``UFFDIO_REGISTER_MODE_MISSING`` was
> >   used.
> > +Userfaultfd write-protect mode currently behave differently on none ptes
> > +(when e.g. page is missing) over different types of memories.
> > +
> > +For anonymous memory, ``ioctl(UFFDIO_WRITEPROTECT)`` will ignore none ptes
> > +(e.g. when pages are missing and not populated).  For file-backed memories
> > +like shmem and hugetlbfs, none ptes will be write protected just like a
> > +present pte.  In other words, there will be a userfaultfd write fault
> > +message generated when writting to a missing page on file typed memories,
> 
> s/writting/writing/
> 
> > +as long as the page range was write-protected before.  Such a message will
> > +not be generated on anonymous memories by default.
> > +
> > +If the application wants to be able to write protect none ptes on anonymous
> > +memory, one can pre-populate the memory with e.g. MADV_POPULATE_READ.  On
> > +newer kernels, one can also detect the feature UFFD_FEATURE_WP_UNPOPULATED
> > +and set the feature bit in advance to make sure none ptes will also be
> > +write protected even upon anonymous memory.
> > +
> 
> [...]
> 
> >   /*
> >    * A number of key systems in x86 including ioremap() rely on the assumption
> > @@ -1350,6 +1364,10 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> >   			      unsigned long addr, pte_t *pte,
> >   			      struct zap_details *details, pte_t pteval)
> >   {
> > +	/* Zap on anonymous always means dropping everything */
> > +	if (vma_is_anonymous(vma))
> > +		return;
> > +
> >   	if (zap_drop_file_uffd_wp(details))
> >   		return;
> > @@ -1456,8 +1474,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >   				continue;
> >   			rss[mm_counter(page)]--;
> >   		} else if (pte_marker_entry_uffd_wp(entry)) {
> > -			/* Only drop the uffd-wp marker if explicitly requested */
> > -			if (!zap_drop_file_uffd_wp(details))
> > +			/*
> > +			 * For anon: always drop the marker; for file: only
> > +			 * drop the marker if explicitly requested.
> > +			 */
> 
> So MADV_DONTNEED a pte marker in an anonymous VMA will always remove that
> marker.

Yes.

> Is that the same handling as for MADV_DONTNEED on shmem or on
> fallocate(PUNCHHOLE) on shmem?

Same as PUNCHHOLE for shmem, while DONTNEED for shmem will retain the
marker.  Here the idea is we drop the marker if the user wants to drop the
page, no matter what type of memory is underneath.

> 
> > +			if (!vma_is_anonymous(vma) &&
> > +			    !zap_drop_file_uffd_wp(details))
> >   				continue;
> 
> Maybe it would be nicer to have a zap_drop_uffd_wp_marker(vma, details) and
> have the comment in there. Especially because of the other hunk above.
> 
> So zap_drop_file_uffd_wp(details) -> zap_drop_uffd_wp_marker(vma, details)
> and move the anon handling + comment in there.

Yes we can.

Actually here I always thought DROP_MARKER is too specific and the caller
will be confused on when to pass it in.

After introduction of ZAP_FLAG_UNMAP for hugetlb, I think we can also have
another more generic flag ZAP_FLAG_TRUNCATE only set during truncations,
then here the old DROP_MARKER can be replaced by "TRUNCATE | UNMAP".

> 
> 
> >   		} else if (is_hwpoison_entry(entry) ||
> >   			   is_swapin_error_entry(entry)) {
> > @@ -3624,6 +3646,14 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
> >   	return 0;
> >   }
> > +static vm_fault_t do_pte_missing(struct vm_fault *vmf)
> > +{
> > +	if (vma_is_anonymous(vmf->vma))
> > +		return do_anonymous_page(vmf);
> > +	else
> > +		return do_fault(vmf);
> 
> No need for the "else" statement.

I don't see much difference in this specific context, but I'm fine to drop
it too.

> 
> > +}
> > +
> >   /*
> >    * This is actually a page-missing access, but with uffd-wp special pte
> >    * installed.  It means this pte was wr-protected before being unmapped.
> > @@ -3634,11 +3664,10 @@ static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
> >   	 * Just in case there're leftover special ptes even after the region
> >   	 * got unregistered - we can simply clear them.
> >   	 */
> > -	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
> > +	if (unlikely(!userfaultfd_wp(vmf->vma)))
> >   		return pte_marker_clear(vmf);
> > -	/* do_fault() can handle pte markers too like none pte */
> > -	return do_fault(vmf);
> > +	return do_pte_missing(vmf);
> >   }
> 
> [...]
> 
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 231929f119d9..455f7051098f 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -276,7 +276,15 @@ static long change_pte_range(struct mmu_gather *tlb,
> >   		} else {
> >   			/* It must be an none page, or what else?.. */
> >   			WARN_ON_ONCE(!pte_none(oldpte));
> > -			if (unlikely(uffd_wp && !vma_is_anonymous(vma))) {
> > +
> > +			/*
> > +			 * Nobody plays with any none ptes besides
> > +			 * userfaultfd when applying the protections.
> > +			 */
> > +			if (likely(!uffd_wp))
> > +				continue;
> > +
> > +			if (userfaultfd_wp_use_markers(vma)) {
> >   				/*
> >   				 * For file-backed mem, we need to be able to
> >   				 * wr-protect a none pte, because even if the
> > @@ -320,23 +328,46 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
> >   	return 0;
> >   }
> > -/* Return true if we're uffd wr-protecting file-backed memory, or false */
> > +/*
> > + * Return true if we want to split huge thps in change protection
> 
> "huge thps" sounds redundant. "if we want to PTE-map a huge PMD" ?

Sure.

> 
> > + * procedure, false otherwise.
> 
> 
> In general,
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks,

-- 
Peter Xu

