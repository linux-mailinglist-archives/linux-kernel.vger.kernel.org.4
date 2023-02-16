Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC08699FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBPW12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBPW1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:27:25 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D4B3B232
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:27:23 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id v189so2049590vkf.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676586442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RIIagYEPOZjsPtFjlj+Npxy7tYezVym+nY7h8CxULgM=;
        b=XbgTu8Kc8j1zKle2ISwgCQgirsgjy0fBjz/z1i2OOa80knGR86DHz9w78U7Vh0JKFe
         amvuDtw5vj7dq/dofItCAM8daEFZds6SpGAqj9Oy31CZawFzJmEvjE6uuDWUF5oPZODi
         cQSnxUQNSalM1sNv04yQZqmTCRlcoD5UoXvLyfL9cyFAReuNzLePAaNorxVM7v8Tf6xX
         SmYugxB4igpEwRc7N58WCOajCO9ZkIjMNFwy6w3NT0tsNN6AN2YcbcbXpHr89vjBSOYZ
         ThkVLsl/uPs7Eoaw/Ec6ck0FhTs7DbuqWWDwFAOJ+FkAJ+tkP6rFHwAyoiFt1hys4BGX
         Vu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676586442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIIagYEPOZjsPtFjlj+Npxy7tYezVym+nY7h8CxULgM=;
        b=T0OQh0tQZr5s3iKIK4REGM7bxiMcNljy1sOuXwCvqHnuEdOAgbUjFyeX56XMRlhyHg
         r/JzIoMuD7jcNkDce4pni7eovcqhX/rwVlwxQDf1IIobNLyiocsQeJnj3WPbx4uykY3t
         MEBmY4R6/VyH2jy87pmReni7+QQ3vyjFyH9gxqFwMMRHP5U0sLHRuEk7PJRa0cM5J5PQ
         o3YUMXZ6A03T6ZAcePTv9bDV2vBeYqdKhdATDEe92/Uy1WNBqs9t8xRT3D+bPLCf9yGU
         PFxVG706CTHOeUvtIqitJ9bK80Xyu7iD7vObz/CC79NX1i3FGRarqrDN2Nq1bL4bL98n
         TNwA==
X-Gm-Message-State: AO0yUKWrnXWNiISCRDg4dBX2fq0E1dUzKedaNNoRvAtsQccqHgk45Sw+
        +EtEX0N5NPlnZKl47ss5M7ELGaa/jTafComfOiX2cQ==
X-Google-Smtp-Source: AK7set8+nYkrawdpOMwYuT/GH/1xErNmKd9P/0AexHtu6RVh1nwi3E/PBA3Iv0RdDvIxOXzJuk83s9r/k2LQuAUGNcQ=
X-Received: by 2002:a05:6122:1385:b0:401:8b0a:8aa6 with SMTP id
 m5-20020a056122138500b004018b0a8aa6mr1090547vkp.12.1676586442407; Thu, 16 Feb
 2023 14:27:22 -0800 (PST)
MIME-Version: 1.0
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 16 Feb 2023 14:27:11 -0800
Message-ID: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
Subject: RFC for new feature to move pages from one vma to another without split
To:     Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Brian Geffon <bgeffon@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>
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

I) SUMMARY:
Requesting comments on a new feature which remaps pages from one
private anonymous mapping to another, without altering the vmas
involved. Two alternatives exist but both have drawbacks:
1. userfaultfd ioctls allocate new pages, copy data and free the old
ones even when updates could be done in-place;
2. mremap results in vma splitting in most of the cases due to 'pgoff' mism=
atch.

Proposing a new mremap flag or userfaultfd ioctl which enables
remapping pages without these drawbacks. Such a feature, as described
below, would be very helpful in efficient implementation of concurrent
compaction algorithms.


II) MOTIVATION:
Garbage collectors (like the ones used in managed languages) perform
defragmentation of the managed heap by moving objects (of varying
sizes) within the heap. Usually these algorithms have to be concurrent
to avoid response time concerns. These are concurrent in the sense
that while the GC threads are compacting the heap, application threads
continue to make progress, which means enabling access to the heap
while objects are being simultaneously moved.

Given the high overhead of heap compaction, such algorithms typically
segregate the heap into two types of regions (set of contiguous
pages): those that have enough fragmentation to compact, and those
that are densely populated. While only =E2=80=98fragmented=E2=80=99 regions=
 are
compacted by sliding objects, both types of regions are traversed to
update references in them to the moved objects.

A) PROT_NONE+SIGSEGV approach:
One of the widely used techniques to ensure data integrity during
concurrent compaction is to use page-level access interception.
Traditionally, this is implemented by mprotecting (PROT_NONE) the heap
before starting compaction and installing a SIGSEGV handler. When GC
threads are compacting the heap, if some application threads fault on
the heap, then they compact the faulted page in the SIGSEGV handler
and then enable access to it before returning. To do this atomically,
the heap must use shmem (MAP_SHARED) so that an alias mapping (with
read-write permission) can be used for moving objects into and
updating references.

Limitation: due to different access rights, the heap can end up with
one vma per page in the worst case, hitting the =E2=80=98max_map_count=E2=
=80=99 limit.

B) Userfaultfd approach:
Userfaultfd avoids the vma split issue by intercepting page-faults
when the page is missing and gives control to user-space to map the
desired content. It doesn=E2=80=99t affect the vma properties. The compacti=
on
algorithm in this case works by first remapping the heap pages (using
mremap) to a secondary mapping and then registering the heap with
userfaultfd for MISSING faults. When an application thread accesses a
page that has not yet been mapped (by other GC/application threads), a
userfault occurs, and as a consequence the corresponding page is
generated and mapped using one of the following two ioctls.
1) COPY ioctl: Typically the heap would be private anonymous in this
case. For every page on the heap, compact the objects into a
page-sized buffer, which COPY ioctl takes as input. The ioctl
allocates a new page, copies the input buffer to it, and then maps it.
This means that even for updating references in the densely populated
regions (where compaction is not done), in-place updation is
impossible. This results in unnecessary page-clear, memcpy and
freeing.
2) CONTINUE ioctl: the two mappings (heap and secondary) are
MAP_SHARED to the same shmem file. Userfaults in the =E2=80=98fragmented=E2=
=80=99
regions are MISSING, in which case objects are compacted into the
corresponding secondary mapping page (which triggers a regular page
fault to get a page mapped) and then CONTINUE ioctl is invoked, which
maps the same page on the heap mapping. On the other hand, userfaults
in the =E2=80=98densely populated=E2=80=99 regions are MINOR (as the page a=
lready
exists in the secondary mapping), in which case we update the
references in the already existing page on the secondary mapping and
then invoke CONTINUE ioctl.

Limitation: we observed in our implementation that
page-faults/page-allocation, memcpy, and madvise took (with either of
the two ioctls) ~50% of the time spent in compaction.


III) USE CASE (of the proposed feature):
The proposed feature of moving pages from one vma to another will
enable us to:
A) Recycle pages entirely in the userspace as they are freed (pages
whose objects are already consumed as part of the current compaction
cycle) in the =E2=80=98fragmented=E2=80=99 regions. This way we avoid page-=
clearing
(during page allocation) and memcpy (in the kernel). When the page is
handed over to the kernel for remapping, there is nothing else needed
to be done. Furthermore, since the page is being reused, it doesn=E2=80=99t
have to be freed either.
B) Implement a coarse-grained page-level compaction algorithm wherein
pages containing live objects are slid next to each other without
touching them, while reclaiming in-between pages which contain only
garbage. Such an algorithm is very useful for compacting objects which
are seldom accessed by application and hence are likely to be swapped
out. Without this feature, this would require copying the pages
containing live objects, for which the src pages have to be
swapped-in, only to be soon swapped-out afterwards.

AFAIK, none of the above features can be implemented using mremap
(with current flags), irrespective of whether the heap is a shmem or
private anonymous mapping, because:
1) When moving a page it=E2=80=99s likely that its index will need to chang=
e
and mremapping such a page would result in VMA splitting.
2) Using mremap for moving pages would result in the heap=E2=80=99s range
being covered by several vmas. The mremap in the next compaction cycle
(required prior to starting compaction as described above), will fail
with EFAULT. This is because the src range in mremap is not allowed to
span multiple vmas. On the other hand, calling it for each src vma is
not feasible because:
  a) It=E2=80=99s not trivial to identify various vmas covering the heap ra=
nge
in userspace, and
  b) This operation is supposed to happen with application threads
paused. Invoking numerous mremap syscalls in a pause risks causing
janks.
3) Mremap has scalability concerns due to the need to acquire mmap_sem
exclusively for splitting/merging VMAs. This would impact parallelism
of application threads, particularly during the beginning of the
compaction process when they are expected to cause a spurt of
userfaults.


IV) PROPOSAL:
Initially, maybe the feature can be implemented only for private
anonymous mappings. There are two ways this can be implemented:
A) A new userfaultfd ioctl, =E2=80=98MOVE=E2=80=99, which takes the same in=
puts as the
=E2=80=98COPY=E2=80=99 ioctl. After sanity check, the ioctl would detach th=
e pte
entries from the src vma, and move them to dst vma while updating
their =E2=80=98mapping=E2=80=99 and =E2=80=98index=E2=80=99 fields, if requ=
ired.

B) Add a new flag to mremap, =E2=80=98MREMAP_ONLYPAGES=E2=80=99, which work=
s similar
to the MOVE ioctl above.

Assuming (A) is implemented, here is broadly how the compaction would work:
* For a MISSING userfault in the =E2=80=98densely populated=E2=80=99 region=
s, update
pointers in-place in the secondary mapping page corresponding to the
fault address (on the heap) and then use the MOVE ioctl to map it on
the heap. In this case the =E2=80=98index=E2=80=99 field would remain the s=
ame.
* For a MISSING userfault in =E2=80=98fragmented=E2=80=99 regions, pick any=
 freed page
in the secondary map, compact the objects corresponding to the fault
address in this page and then use MOVE ioctl to map it on the fault
address in the heap. This would require updating the =E2=80=98index=E2=80=
=99 field.
After compaction is completed, use madvise(MADV_DONTNEED) on the
secondary mapping to free any remaining pages.


Thanks,
Lokesh
