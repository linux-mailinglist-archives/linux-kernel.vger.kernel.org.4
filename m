Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B69E6D9EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbjDFRaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbjDFRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F93B61AE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680802184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vw7f0KoSGuOEjpxfcREMEJkC0VJxGOcWy3MRkdHX1ec=;
        b=baqgEVPcJiTTGMkd3V/a1JWgkf7wMDJOZ8nEwf/wxox9aWzoFZLDA0oJH9894feXZNL0gT
        Lgds2eRo1drlMD7fLix8iABWx1l2+B6zNUuyiuTS0PGkPSzTTI9Z+K4dxX4VZcnwvewBWa
        UOlJBs9h2m/ZUIFwv4/RwXcd8QpK078=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-a6dzz5QEPVKm1fuM7mjzOg-1; Thu, 06 Apr 2023 13:29:43 -0400
X-MC-Unique: a6dzz5QEPVKm1fuM7mjzOg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-746b617d095so9720385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680802180; x=1683394180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vw7f0KoSGuOEjpxfcREMEJkC0VJxGOcWy3MRkdHX1ec=;
        b=xe8Bt3XsHKE4ACCYY75kFfg/v1lpA9WArhXEEANEyg17s06kKwR5gYo0mkn7IJ4rpg
         wjpDimHPgzlhSCp6+5bXDVvrORWUmPLlvJy62MDmsq+FNA1D/X2yWsZRvYV65vhIXKnC
         qhoWzMcdH9LY1JpOKTmnxLrckGEhHvx1EnIT4PmNRL7SsSbTuOrSNiZZlbnv+iDB1/l6
         IpWD/39vdD/vvGNSoz62Ew5GbeWuKp/r1Ta/5XlPTdLqDAc1rFjbobwV4zfIG6h8UaU5
         lKCpP5KFh4+sIxJtCt5ccLhB6dc+rxkHDSt5w319fa4ns8EIDQ7Ro7zOzEyAFm9qQlkv
         9B7w==
X-Gm-Message-State: AAQBX9e4k43F/cTJzR/9hviggAqnfaVAZWqeWdZdsE2e0SeWwzoveqCv
        bEAU3p/zwoPFe52nq+5FWlTIzRlJXwthMiO9LUccjW/zOKTJe9dwfaEla5ms7oVWflJjY2A2G8r
        /MVfdQT3FbHLyjj08zwV1BqAs
X-Received: by 2002:a05:6214:2128:b0:5af:3a13:202d with SMTP id r8-20020a056214212800b005af3a13202dmr9693qvc.4.1680802179563;
        Thu, 06 Apr 2023 10:29:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350a3ZTMB0IatJfT/1sL9nUW8HCwLuqtw/AGwFoByzJVSxapUR7VJ2QRgxl/ae/mjTVqaQiN7lw==
X-Received: by 2002:a05:6214:2128:b0:5af:3a13:202d with SMTP id r8-20020a056214212800b005af3a13202dmr9642qvc.4.1680802179073;
        Thu, 06 Apr 2023 10:29:39 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id bn5-20020a05620a2ac500b0074a1d2a17c8sm626430qkb.29.2023.04.06.10.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 10:29:38 -0700 (PDT)
Date:   Thu, 6 Apr 2023 13:29:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: RFC for new feature to move pages from one vma to another
 without split
Message-ID: <ZC8BgFSFC3cDcAcS@x1n>
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lokesh,

Sorry for a late reply.  Copy Blake Caldwell and Mike too.

On Thu, Feb 16, 2023 at 02:27:11PM -0800, Lokesh Gidra wrote:
> I) SUMMARY:
> Requesting comments on a new feature which remaps pages from one
> private anonymous mapping to another, without altering the vmas
> involved. Two alternatives exist but both have drawbacks:
> 1. userfaultfd ioctls allocate new pages, copy data and free the old
> ones even when updates could be done in-place;
> 2. mremap results in vma splitting in most of the cases due to 'pgoff' mismatch.

Personally it was always a mistery to me on how vm_pgoff works with
anonymous vmas and why it needs to be setup with vm_start >> PAGE_SHIFT.

Just now I tried to apply below oneliner change:

@@ -1369,7 +1369,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
                        /*
                         * Set pgoff according to addr for anon_vma.
                         */
-                       pgoff = addr >> PAGE_SHIFT;
+                       pgoff = 0;
                        break;
                default:
                        return -EINVAL;

The kernel even boots without a major problem so far..

I had a feeling that I miss something else here, it'll be great if anyone
knows.

Anyway, I agree mremap() is definitely not the best way to do page level
operations like this, no matter whether vm_pgoff can match or not.

> 
> Proposing a new mremap flag or userfaultfd ioctl which enables
> remapping pages without these drawbacks. Such a feature, as described
> below, would be very helpful in efficient implementation of concurrent
> compaction algorithms.

After I read the proposal, I had a feeling that you're not aware that we
have similar proposals adding UFFDIO_REMAP.

I think it started with Andrea's initial proposal on the whole uffd:

https://lore.kernel.org/linux-mm/1425575884-2574-1-git-send-email-aarcange@redhat.com/

Then for some reason it's not merged in initial version, but at least it's
been proposed again here (even though it seems the goal is slightly
different; that may want to move page out instead of moving in):

https://lore.kernel.org/linux-mm/cover.1547251023.git.blake.caldwell@colorado.edu/

Also worth checking with the latest commit that Andrea maintains himself (I
doubt whether there's major changes, but still just to make it complete):

https://gitlab.com/aarcange/aa/-/commit/2aec7aea56b10438a3881a20a411aa4b1fc19e92

So far I think that's what you're looking for. I'm not sure whether the
limitations will be a problem, though, at least mentioned in the old
proposals of UFFDIO_REMAP.  For example, it required not only anonymous but
also mapcount==1 on all src pages.  But maybe that's not a problem here
too.

> 
> II) MOTIVATION:
> Garbage collectors (like the ones used in managed languages) perform
> defragmentation of the managed heap by moving objects (of varying
> sizes) within the heap. Usually these algorithms have to be concurrent
> to avoid response time concerns. These are concurrent in the sense
> that while the GC threads are compacting the heap, application threads
> continue to make progress, which means enabling access to the heap
> while objects are being simultaneously moved.
> 
> Given the high overhead of heap compaction, such algorithms typically
> segregate the heap into two types of regions (set of contiguous
> pages): those that have enough fragmentation to compact, and those
> that are densely populated. While only ‘fragmented’ regions are
> compacted by sliding objects, both types of regions are traversed to
> update references in them to the moved objects.
> 
> A) PROT_NONE+SIGSEGV approach:
> One of the widely used techniques to ensure data integrity during
> concurrent compaction is to use page-level access interception.
> Traditionally, this is implemented by mprotecting (PROT_NONE) the heap
> before starting compaction and installing a SIGSEGV handler. When GC
> threads are compacting the heap, if some application threads fault on
> the heap, then they compact the faulted page in the SIGSEGV handler
> and then enable access to it before returning. To do this atomically,
> the heap must use shmem (MAP_SHARED) so that an alias mapping (with
> read-write permission) can be used for moving objects into and
> updating references.
> 
> Limitation: due to different access rights, the heap can end up with
> one vma per page in the worst case, hitting the ‘max_map_count’ limit.
> 
> B) Userfaultfd approach:
> Userfaultfd avoids the vma split issue by intercepting page-faults
> when the page is missing and gives control to user-space to map the
> desired content. It doesn’t affect the vma properties. The compaction
> algorithm in this case works by first remapping the heap pages (using
> mremap) to a secondary mapping and then registering the heap with
> userfaultfd for MISSING faults. When an application thread accesses a
> page that has not yet been mapped (by other GC/application threads), a
> userfault occurs, and as a consequence the corresponding page is
> generated and mapped using one of the following two ioctls.
> 1) COPY ioctl: Typically the heap would be private anonymous in this
> case. For every page on the heap, compact the objects into a
> page-sized buffer, which COPY ioctl takes as input. The ioctl
> allocates a new page, copies the input buffer to it, and then maps it.
> This means that even for updating references in the densely populated
> regions (where compaction is not done), in-place updation is
> impossible. This results in unnecessary page-clear, memcpy and
> freeing.
> 2) CONTINUE ioctl: the two mappings (heap and secondary) are
> MAP_SHARED to the same shmem file. Userfaults in the ‘fragmented’
> regions are MISSING, in which case objects are compacted into the
> corresponding secondary mapping page (which triggers a regular page
> fault to get a page mapped) and then CONTINUE ioctl is invoked, which
> maps the same page on the heap mapping. On the other hand, userfaults
> in the ‘densely populated’ regions are MINOR (as the page already
> exists in the secondary mapping), in which case we update the
> references in the already existing page on the secondary mapping and
> then invoke CONTINUE ioctl.
> 
> Limitation: we observed in our implementation that
> page-faults/page-allocation, memcpy, and madvise took (with either of
> the two ioctls) ~50% of the time spent in compaction.

I assume "page-faults" applies to CONTINUE, while "page-allocation" applies
to COPY here.  UFFDIO_REMAP can definitely avoid memcpy, but I don't know
how much it'll remove in total, e.g., I don't think page faults can be
avoided anyway?  Also, madvise(), depending on what it is.  If it's only
MADV_DONTNEED, maybe it'll be helpful too so the library can reuse wasted
pages directly hence reducing DONTNEEDs.

> III) USE CASE (of the proposed feature):
> The proposed feature of moving pages from one vma to another will
> enable us to:
> A) Recycle pages entirely in the userspace as they are freed (pages
> whose objects are already consumed as part of the current compaction
> cycle) in the ‘fragmented’ regions. This way we avoid page-clearing
> (during page allocation) and memcpy (in the kernel). When the page is
> handed over to the kernel for remapping, there is nothing else needed
> to be done. Furthermore, since the page is being reused, it doesn’t
> have to be freed either.
> B) Implement a coarse-grained page-level compaction algorithm wherein
> pages containing live objects are slid next to each other without
> touching them, while reclaiming in-between pages which contain only
> garbage. Such an algorithm is very useful for compacting objects which
> are seldom accessed by application and hence are likely to be swapped
> out. Without this feature, this would require copying the pages
> containing live objects, for which the src pages have to be
> swapped-in, only to be soon swapped-out afterwards.
> 
> AFAIK, none of the above features can be implemented using mremap
> (with current flags), irrespective of whether the heap is a shmem or
> private anonymous mapping, because:
> 1) When moving a page it’s likely that its index will need to change
> and mremapping such a page would result in VMA splitting.
> 2) Using mremap for moving pages would result in the heap’s range
> being covered by several vmas. The mremap in the next compaction cycle
> (required prior to starting compaction as described above), will fail
> with EFAULT. This is because the src range in mremap is not allowed to
> span multiple vmas. On the other hand, calling it for each src vma is
> not feasible because:
>   a) It’s not trivial to identify various vmas covering the heap range
> in userspace, and
>   b) This operation is supposed to happen with application threads
> paused. Invoking numerous mremap syscalls in a pause risks causing
> janks.
> 3) Mremap has scalability concerns due to the need to acquire mmap_sem
> exclusively for splitting/merging VMAs. This would impact parallelism
> of application threads, particularly during the beginning of the
> compaction process when they are expected to cause a spurt of
> userfaults.
> 
> 
> IV) PROPOSAL:
> Initially, maybe the feature can be implemented only for private
> anonymous mappings. There are two ways this can be implemented:
> A) A new userfaultfd ioctl, ‘MOVE’, which takes the same inputs as the
> ‘COPY’ ioctl. After sanity check, the ioctl would detach the pte
> entries from the src vma, and move them to dst vma while updating
> their ‘mapping’ and ‘index’ fields, if required.
> 
> B) Add a new flag to mremap, ‘MREMAP_ONLYPAGES’, which works similar
> to the MOVE ioctl above.
> 
> Assuming (A) is implemented, here is broadly how the compaction would work:
> * For a MISSING userfault in the ‘densely populated’ regions, update
> pointers in-place in the secondary mapping page corresponding to the
> fault address (on the heap) and then use the MOVE ioctl to map it on
> the heap. In this case the ‘index’ field would remain the same.
> * For a MISSING userfault in ‘fragmented’ regions, pick any freed page
> in the secondary map, compact the objects corresponding to the fault
> address in this page and then use MOVE ioctl to map it on the fault
> address in the heap. This would require updating the ‘index’ field.
> After compaction is completed, use madvise(MADV_DONTNEED) on the
> secondary mapping to free any remaining pages.
> 
> 
> Thanks,
> Lokesh
> 

-- 
Peter Xu

