Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F730646083
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiLGRoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLGRoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3963C55A9D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670434992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BI2sBISV5n/atZjIhhG2oh9+l7Gn19Q27lhdGuaz4OU=;
        b=NPTSf1Yue6cu6ed8tQpJHxqx79mBI4RfzuclO0MfN1JGc8b8ZF6R9RLWxfppwZ4K9BsXYn
        mNgfmLADcb0jrS9K4JFh6nb45FZDoWBT49VgAV4XrTml0wf6qA0mnOa67a/pc1+l1i8u8H
        qEwvABVoR9xeuMFfH0AAZaJ77uyGx2E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-205-NiIKJsnbOsKImcxMDDiWQQ-1; Wed, 07 Dec 2022 12:43:11 -0500
X-MC-Unique: NiIKJsnbOsKImcxMDDiWQQ-1
Received: by mail-qv1-f69.google.com with SMTP id mr7-20020a056214348700b004c6806b646dso37919769qvb.14
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 09:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI2sBISV5n/atZjIhhG2oh9+l7Gn19Q27lhdGuaz4OU=;
        b=BpV8M49klBc/Rqb2tcrOO+uBx8rDHtssV+YLgkXAGGw740zY5UUMtJX0xgy6IKdFc5
         5g8+swF2QoTSNNTD4YmCRnNhKE2zB9jwSW9BVMi7Rbaweb7x63Z8yhgnClhP3B8UFcPd
         P0c79wFyGRXgHGMjijLEzeeougx9CbeOWKNJVHCC9KRus7EXJgZWUa87dz7fj/1i/Mes
         +YkEdST/iwFwHDYH8Hv73w95/9tlommDCnOH4wse83n0fiPwFcb7tAONNi4zZEL8xmZY
         AIERDFrKxyPTB2Rz4PXXdo2JMadp6cq05w37UXhyjIQLC9h5oW4kOnB6ibsdy1HLefC9
         41fw==
X-Gm-Message-State: ANoB5plE6O9/pVtVyA/IWAg/JDCe8Yj+fWweHR/4irmPWIYqNLqKvUXs
        zQSrehRfV/c2EQ9UnNf3D104Rny2K/sF9CtBCd6iMyhyqCA08A/v3w5yZiaC8IA1bYZlKvrI0pg
        KwWJ5O1Q/L/Is4bQT67/vLmPh
X-Received: by 2002:ac8:7ee5:0:b0:3a7:e548:5e89 with SMTP id r5-20020ac87ee5000000b003a7e5485e89mr1000399qtc.49.1670434990426;
        Wed, 07 Dec 2022 09:43:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4d+EufGLGREcPsFWlGAU+hmLGz8C3Wk5z/u5dwOva9RfrXnjMYejlPQklEIf8mXpcXOLjUWA==
X-Received: by 2002:ac8:7ee5:0:b0:3a7:e548:5e89 with SMTP id r5-20020ac87ee5000000b003a7e5485e89mr1000383qtc.49.1670434989910;
        Wed, 07 Dec 2022 09:43:09 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id s22-20020a05620a0bd600b006fc3fa1f589sm17789807qki.114.2022.12.07.09.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:43:09 -0800 (PST)
Date:   Wed, 7 Dec 2022 12:43:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ives van Hoorne <ives@codesandbox.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@goole.com>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH RFC] mm/userfaultfd: enable writenotify while
 userfaultfd-wp is enabled for a VMA
Message-ID: <Y5DQrHqc7RPYWpIA@x1n>
References: <20221202122748.113774-1-david@redhat.com>
 <Y4oo6cN1a4Yz5prh@x1n>
 <690afe0f-c9a0-9631-b365-d11d98fdf56f@redhat.com>
 <19800718-9cb6-9355-da1c-c7961b01e922@redhat.com>
 <Y45duzmGGUT0+u8t@x1n>
 <92173bad-caa3-6b43-9d1e-9a471fdbc184@redhat.com>
 <22d8e8ac-d75-a66-2650-b4d59f89855e@google.com>
 <Y4+xpCRQCazCymdS@x1n>
 <be1a2244-24a8-480a-a38b-e4ebb9868ce5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be1a2244-24a8-480a-a38b-e4ebb9868ce5@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:32:17PM +0100, David Hildenbrand wrote:
> > 
> > David, would you please repost a new patch for this one and copy Ives to
> > make sure it'll work for him in his systems?
> 
> Yes, will do. I think has was already cc'ed.
> 
> > 
> > I'd suggest to drop the mprotect example, I'll reply later on that to the
> > other email but I still don't know whether it's a good example for a reader
> > to understand the problem.
> 
> Yes, can do.
> 
> > 
> > No reproducer needed for numa I think - I guess Ives's test case would be
> > far enough to verify it if possible.  I also hope what Ives saw was the
> > numa balancing issue you reported, so maybe it'll resolve all problem he
> > has.  Then with that verified and queued we can drop the mm/migrate patch.
> 
> I tried writing a numa hinting reproducer, but so far I assume that it's
> with current code not (easily) possible for shmem.
> 
> We'd have to call change_prot_numa() in order to protnone these PTEs. That
> can either happen via
> 
> a) mbind() with MPOL_MF_LAZY. However, user space is currently not able
>    to set that flag (dead code ...).
> b) task_numa_work(). However, vma_policy_mof() seems to always fail on
>    shmem and prevent us from reaching that code. Reason is that shmem
>    implements vm_ops->get_policy, and it seems to be impossible to get
>    MPOL_F_MOF set. At least I haven't found an easy way or I am missing
>    something.
> 
> So numa hinting might not immediately explain the lost write faults.
> 
> ... but are there other ways to reach do_numa_page(), even without active
> NUMA hinting? I found at least one:
> 
> 
>   map = mmap(NULL, size, PROT_WRITE, MAP_SHARED|MAP_ANON, -1, 0);
>   memset(map, 0, size);
>   uffd_wp_range(map, size);
> 
> On upstream during the next write fault, we'll end up in do_numa_page() and
> simply remap the page writable due to vm_page_prot, not triggering a write
> fault. I can see the "numa_hint_faults" counter in /proc/vmstat increasing
> accordingly, so we're really in do_numa_page().

Seems true.  I think fundamentally it's because numa hint rely on PROT_NONE
as the hint, and it explicitly checks against mprotect(PROT_NONE) using the
accessible check:

	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
		return do_numa_page(vmf);

I'm not sure whether we should also add a pte_uffd_wp(vmf->orig_pte) here
to mask out the uffd-wp cases.

So far it seems the outcome is not extremely bad - PROT_WRITE only mappings
are rare in real life, and also with the protnone recovery code (and along
with the vm_page_prot patch coming) we'll be able to still recover the pte
into a uffd-wp-ed pte without PROTNONE bit set.  But I don't have a solid
clue yet on what's the best.

> 
> 
> PROT_WRITE on shmem with uffd-wp is completely non-functional as it seems.
> It seems to work with anon memory. And with my patch, it also works with
> shmem.

There are definitely two problems: (1) unexpected hints to numa even if
it's not, and (2) correct recover of uffd-wp bit when numa hint wants to
recover the old pte.  Yes I think it somehow verified that this patch will
also fix the numa recovery path.

> 
> Attaching a simple reproducer (uffd-wp-prot-write.c).
> 
> 
> 
> Independent of uffd-wp on shmem, we seem to be missing propagating the
> uffd-wp bit when splitting the huge zeropage. So uffd-wp'ing the huge
> zeropage and then splitting it loses the uffd-wp markers. :/

For this one, thanks for the reproducer.  I'm not extremely sure whether
it's a bug.

Firstly, I think your reproducer should just work well with shmem, afaiu,
because shmem is based on pte markers and it should only work on pte level
(not pmd).  The huge zero pmd should got split right after wr-protected.
So the reproducer shouldn't go wrong on shmem at all with/without any
recent fix.  Let me know otherwise.

For anon, I'm not sure it's a bug, because there's a semantic difference on
anon/shmem.  The thing is losing wr-protect on the zero page is the same as
losing wr-protect on a page that is not mapped.  For anon currently we
can't track a page that is not mapped and we skip those ranges (being zero
when read).  So fundamentally I am not sure whether it'll be an issue for
existing anon uffd-wp users because if it is then it's more than zero
pages.

I know that such a semantic difference between anon and shmem is not good
at all, but just to say maybe that worth another discussion.

Thanks,

> 
> Fix seems easy and I just tested my possible fix. Attaching a simple
> reproducer (uffd-wp-huge-zero.c).
> 
> -- 
> Thanks,
> 
> David / dhildenb

> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdint.h>
> #include <stdbool.h>
> #include <inttypes.h>
> #include <string.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <errno.h>
> #include <poll.h>
> #include <pthread.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <sys/ioctl.h>
> #include <linux/memfd.h>
> #include <linux/userfaultfd.h>
> 
> static size_t pagesize;
> static int uffd;
> static int pagemap_fd;
> 
> #define SIZE (1024*1024*1024ull)
> #define barrier() __asm__ __volatile__("": : :"memory")
> 
> volatile bool uffd_triggered;
> 
> static void uffd_wp_range(char *start, size_t size, bool wp)
> {
> 	struct uffdio_writeprotect uffd_writeprotect;
> 
> 	uffd_writeprotect.range.start = (unsigned long) start;
> 	uffd_writeprotect.range.len = size;
> 	if (wp) {
> 		uffd_writeprotect.mode = UFFDIO_WRITEPROTECT_MODE_WP;
> 	} else {
> 		uffd_writeprotect.mode = 0;
> 	}
> 	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &uffd_writeprotect)) {
> 		fprintf(stderr, "UFFDIO_WRITEPROTECT failed: %d\n", errno);
> 		exit(1);
> 	}
> }
> 
> static void *uffd_thread_fn(void *arg)
> {
> 	static struct uffd_msg msg;
> 	ssize_t nread;
> 
> 	while (1) {
> 		struct pollfd pollfd;
> 		int nready;
> 
> 		pollfd.fd = uffd;
> 		pollfd.events = POLLIN;
> 		nready = poll(&pollfd, 1, -1);
> 		if (nready == -1) {
> 			fprintf(stderr, "poll() failed: %d\n", errno);
> 			exit(1);
> 		}
> 
> 		nread = read(uffd, &msg, sizeof(msg));
> 		if (nread <= 0)
> 			continue;
> 
> 		if (msg.event != UFFD_EVENT_PAGEFAULT ||
> 		    !(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP)) {
> 			printf("FAIL: wrong uffd-wp event fired\n");
> 			exit(1);
> 		}
> 
> 		/* un-protect */
> 		uffd_triggered = true;
> 		uffd_wp_range((char *)(uintptr_t)msg.arg.pagefault.address, pagesize, false);
> 	}
> 	return arg;
> }
> 
> static int setup_uffd(char *map, size_t size)
> {
> 	struct uffdio_api uffdio_api;
> 	struct uffdio_register uffdio_register;
> 	pthread_t thread;
> 
> 	uffd = syscall(__NR_userfaultfd,
> 		       O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> 	if (uffd < 0) {
> 		fprintf(stderr, "syscall() failed: %d\n", errno);
> 		return -errno;
> 	}
> 
> 	uffdio_api.api = UFFD_API;
> 	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
> 	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
> 		fprintf(stderr, "UFFDIO_API failed: %d\n", errno);
> 		return -errno;
> 	}
> 
> 	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
> 		fprintf(stderr, "UFFD_FEATURE_WRITEPROTECT missing\n");
> 		return -ENOSYS;
> 	}
> 
> 	uffdio_register.range.start = (unsigned long) map;
> 	uffdio_register.range.len = size;
> 	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
> 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) < 0) {
> 		fprintf(stderr, "UFFDIO_REGISTER failed: %d\n", errno);
> 		return -errno;
> 	}
> 
> 	pthread_create(&thread, NULL, uffd_thread_fn, NULL);
> 
> 	return 0;
> }
> 
> int main(void)
> {
> 	const size_t size = SIZE;
> 	char *map, *cur;
> 
> 	pagesize = getpagesize();
> 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> 	if (pagemap_fd < 0) {
> 		fprintf(stderr, "Opening /proc/self/pagemap failed\n");
> 		return 1;
> 	}
> 
> 	map = mmap(NULL, size, PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
> 	if (map == MAP_FAILED) {
> 		fprintf(stderr, "mmap() failed\n");
> 		return -errno;
> 	}
> 
> 	if (madvise(map, size, MADV_NOHUGEPAGE)) {
> 		fprintf(stderr, "MADV_HUGEPAGE failed\n");
> 		return -errno;
> 	}
> 
> 	/* Populate all pages ... */
> 	memset(map, 0, size);
> 
> 	if (setup_uffd(map, size))
> 		return 1;
> 
> 	/* ... and write-protect them using uffd-wp. */
> 	uffd_wp_range(map, size, true);
> 
> 	/* Test if all faults trigger. */
> 	for (cur = map; cur < map + size; cur += pagesize) {
> 		uffd_triggered = false;
> 		barrier();
> 
> 		/* Trigger a write fault. */
> 		*cur = 1;
> 
> 		barrier();
> 		if (!uffd_triggered) {
> 			printf("FAIL: uffd-wp did not trigger\n");
> 			return 1;
> 		}
> 	}
> 
> 	printf("PASS: uffd-wp triggered\n");
> 	return 0;
> }

> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdint.h>
> #include <stdbool.h>
> #include <inttypes.h>
> #include <string.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <errno.h>
> #include <poll.h>
> #include <pthread.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <sys/ioctl.h>
> #include <linux/memfd.h>
> #include <linux/userfaultfd.h>
> 
> static size_t pagesize;
> static int uffd;
> static int pagemap_fd;
> 
> #define SIZE (128*1024*1024ull)
> #define barrier() __asm__ __volatile__("": : :"memory")
> 
> volatile bool uffd_triggered;
> 
> static void uffd_wp_range(char *start, size_t size, bool wp)
> {
> 	struct uffdio_writeprotect uffd_writeprotect;
> 
> 	uffd_writeprotect.range.start = (unsigned long) start;
> 	uffd_writeprotect.range.len = size;
> 	if (wp) {
> 		uffd_writeprotect.mode = UFFDIO_WRITEPROTECT_MODE_WP;
> 	} else {
> 		uffd_writeprotect.mode = 0;
> 	}
> 	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &uffd_writeprotect)) {
> 		fprintf(stderr, "UFFDIO_WRITEPROTECT failed: %d\n", errno);
> 		exit(1);
> 	}
> }
> 
> static void *uffd_thread_fn(void *arg)
> {
> 	static struct uffd_msg msg;
> 	ssize_t nread;
> 
> 	while (1) {
> 		struct pollfd pollfd;
> 		int nready;
> 
> 		pollfd.fd = uffd;
> 		pollfd.events = POLLIN;
> 		nready = poll(&pollfd, 1, -1);
> 		if (nready == -1) {
> 			fprintf(stderr, "poll() failed: %d\n", errno);
> 			exit(1);
> 		}
> 
> 		nread = read(uffd, &msg, sizeof(msg));
> 		if (nread <= 0)
> 			continue;
> 
> 		if (msg.event != UFFD_EVENT_PAGEFAULT ||
> 		    !(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP)) {
> 			printf("FAIL: wrong uffd-wp event fired\n");
> 			exit(1);
> 		}
> 
> 		/* un-protect */
> 		uffd_triggered = true;
> 		uffd_wp_range((char *)(uintptr_t)msg.arg.pagefault.address, pagesize, false);
> 	}
> 	return arg;
> }
> 
> static int setup_uffd(char *map, size_t size)
> {
> 	struct uffdio_api uffdio_api;
> 	struct uffdio_register uffdio_register;
> 	pthread_t thread;
> 
> 	uffd = syscall(__NR_userfaultfd,
> 		       O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> 	if (uffd < 0) {
> 		fprintf(stderr, "syscall() failed: %d\n", errno);
> 		return -errno;
> 	}
> 
> 	uffdio_api.api = UFFD_API;
> 	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
> 	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
> 		fprintf(stderr, "UFFDIO_API failed: %d\n", errno);
> 		return -errno;
> 	}
> 
> 	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
> 		fprintf(stderr, "UFFD_FEATURE_WRITEPROTECT missing\n");
> 		return -ENOSYS;
> 	}
> 
> 	uffdio_register.range.start = (unsigned long) map;
> 	uffdio_register.range.len = size;
> 	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
> 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) < 0) {
> 		fprintf(stderr, "UFFDIO_REGISTER failed: %d\n", errno);
> 		return -errno;
> 	}
> 
> 	pthread_create(&thread, NULL, uffd_thread_fn, NULL);
> 
> 	return 0;
> }
> 
> int main(void)
> {
> 	const size_t size = SIZE;
> 	char *map, *cur;
> 
> 	pagesize = getpagesize();
> 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> 	if (pagemap_fd < 0) {
> 		fprintf(stderr, "Opening /proc/self/pagemap failed\n");
> 		return 1;
> 	}
> 
> 	map = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
> 	if (map == MAP_FAILED) {
> 		fprintf(stderr, "mmap() failed\n");
> 		return -errno;
> 	}
> 
> 	if (madvise(map, size, MADV_HUGEPAGE)) {
> 		fprintf(stderr, "MADV_HUGEPAGE failed\n");
> 		return -errno;
> 	}
> 
> 	if (setup_uffd(map, size))
> 		return 1;
> 
> 	/* Populate the shared zeropage, hopefullt also the huge one.*/
> 	madvise(map, size, MADV_POPULATE_READ);
> 
> 	/* ... and write-protect all pages using uffd-wp. */
> 	uffd_wp_range(map, size, true);
> 
> 	/*
> 	 * Discard every second odd page, this will split any huge zero
> 	 * THP and will hopefully keep the PTE protected using uffd-wp.
> 	 *
> 	 * Any mechanism to PTE-map the THP would do.
> 	 */
> 	for (cur = map + pagesize; cur < map + size; cur += 2 * pagesize)
> 		madvise(cur, pagesize, MADV_DONTNEED);
> 
> 	/*
> 	 * Test every second even page (-> all remaining ones) if we get our
> 	 * uffd-wp events.
> 	 */
> 	for (cur = map; cur < map + size; cur += 2 * pagesize) {
> 		uffd_triggered = false;
> 
> 		barrier();
> 		/* Trigger a write fault. */
> 		*cur = 1;
> 		barrier();
> 
> 		if (!uffd_triggered) {
> 			printf("FAIL: uffd-wp did not trigger\n");
> 			return 1;
> 		}
> 	}
> 
> 	printf("PASS: uffd-wp triggered\n");
> 	return 0;
> }


-- 
Peter Xu

