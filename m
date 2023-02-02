Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1E6878D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjBBJay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjBBJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:30:53 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D5359B72
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:30:51 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u27so1215932ljo.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kn+p2LYYjtrS2RWO9tALAnwisM7EY9rkbYqDL8CmUX4=;
        b=mG4uvBQ1f8SK7Dx3CFWmtwoG+Rj4aAdSiap6UNGiH2Hei1njFX/e0h7WZ9D2SAGmsw
         EwvFXJwkEanu0Qwk5HVBW7M21hq7rqpXA9pG+auTMjE4oznEotqj1L5cDkIiZBLFSU3Q
         MqmwyCFjQUtAkv5nyAj7iVTx0YppLIGN9y/5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kn+p2LYYjtrS2RWO9tALAnwisM7EY9rkbYqDL8CmUX4=;
        b=a0tXtNbve1RPSVxHFJPObNovLgjjMkSI3zXyD6NRoG8gpROsof9xmYNRLx/PK+mMEa
         TvfXFRZ4uwKBaym3a8oL0jJHsFbLkbsiUSgVosfWCjUEpXDddHKOa6cpeYsO0FqoIf6p
         GG5lWOapzhA6ohbFyF0q3v/v+HdydZB3NVabAX/KZkfzigJCoVh+pH0IpnDvQbhHYYdM
         hYdKCh32nZRARleaXvta1QCaJKzXPBVigVrNv9JlTyIZdHOJadLl8AR5f3G1ZjrmwwdU
         YwZrOwjb8IL2Edhx3wcfDPQxlpjFFEbM6Po5MerwozJaim7hvq+CuhYfslNyjh1zy9Hh
         5R1g==
X-Gm-Message-State: AO0yUKV1Ldww5f7iP8TSDeONURwT0+e0SqlgUBJgeY+0SKvUvrlZa7I4
        U0LqK/57FaXyXFUPHIOcG2BpDDyZ+Mq5JG0ESofZAC7wHwHfBv2R
X-Google-Smtp-Source: AK7set8Weqp+jsBne++gh2QsAaLnawWtpoxBWD+Utl/ASFFidXWVAjceHPpovOZGj7yDecthJEi1/4qO+crVsA+3tHs=
X-Received: by 2002:a2e:9c9a:0:b0:28e:8831:e244 with SMTP id
 x26-20020a2e9c9a000000b0028e8831e244mr890177lji.4.1675330250046; Thu, 02 Feb
 2023 01:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20230201034137.2463113-1-stevensd@google.com> <20230201230943.fg2q6fmvu7gggxar@box.shutemov.name>
In-Reply-To: <20230201230943.fg2q6fmvu7gggxar@box.shutemov.name>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 2 Feb 2023 18:30:38 +0900
Message-ID: <CAD=HUj4=okVbwROVTCPb_WndA57WPK6hYE68un_M8miDbhCGNg@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 8:09 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Wed, Feb 01, 2023 at 12:41:37PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > Collapsing memory in a vma that has an armed userfaultfd results in
> > zero-filling any missing pages, which breaks user-space paging for those
> > filled pages. Avoid khugepage bypassing userfaultfd by not collapsing
> > pages in shmem reached via scanning a vma with an armed userfaultfd if
> > doing so would zero-fill any pages.
>
> Could you elaborate on the failure? Will zero-filling the page prevent
> userfaultfd from catching future access?

Yes, zero-filling the page causes future major faults to be lost,
since it populates the pages in the backing shmem. The path for
anonymous memory in khugepaged does properly handle userfaultfd_armed,
but the path for shmem does not.

> A test-case would help a lot.

Here's a sample program that demonstrates the issue. On a v6.1 kernel,
no major fault is observed by the monitor thread. I used MADV_COLLAPSE
to exercise khugepaged_scan_file, but you would get the same effect by
replacing the madvise with a sleep and waiting for khugepaged to scan
the test process.

#define _GNU_SOURCE
#include <inttypes.h>
#include <stdio.h>
#include <linux/userfaultfd.h>
#include <threads.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/ioctl.h>
#include <assert.h>

int had_fault;

int monitor_thread(void *arg) {
  int ret, uffd = (int) (uintptr_t) arg;
  struct uffd_msg msg;

  ret = read(uffd, &msg, sizeof(msg));
  assert(ret > 0);
  assert(msg.event == UFFD_EVENT_PAGEFAULT);

  had_fault = 1;

  struct uffdio_zeropage zeropage;
  zeropage.range.start = msg.arg.pagefault.address & ~0xfff;
  zeropage.range.len = 4096;
  zeropage.mode = 0;

  ret = ioctl(uffd, UFFDIO_ZEROPAGE, &zeropage);
  assert(ret >= 0);
}

int main() {
  int ret;

  int uffd = syscall(__NR_userfaultfd, 0);
  assert(uffd >= 0);

  struct uffdio_api uffdio_api;
  uffdio_api.api = UFFD_API;
  uffdio_api.features = UFFD_FEATURE_MISSING_SHMEM;
  ret = ioctl(uffd, UFFDIO_API, &uffdio_api);
  assert(ret >= 0);

  int memfd = memfd_create("memfd", MFD_CLOEXEC);
  assert(memfd >= 0);

  ret = ftruncate(memfd, 2 * 1024 * 1024);
  assert(ret >= 0);

  uint8_t *addr = mmap(NULL, 2 * 1024 * 1024, PROT_READ | PROT_WRITE,
MAP_SHARED, memfd, 0);
  assert(addr != MAP_FAILED);

  addr[0] = 0xff;

  struct uffdio_register uffdio_register;
  uffdio_register.range.start = (unsigned long) addr;
  uffdio_register.range.len = 2 * 1024 * 1024;
  uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
  ret = ioctl(uffd, UFFDIO_REGISTER, &uffdio_register);
  assert(ret >= 0);

  thrd_t t;
  ret = thrd_create(&t, monitor_thread, (void *) (uintptr_t) uffd);
  assert(ret >= 0);

  ret = madvise(addr, 2 * 1024 * 1024, 25 /* MADV_COLLAPSE */);
  printf("madvise ret %d\n", ret);

  addr[4096] = 0xff;

  printf("%s major fault\n", had_fault ? "had" : "no");

  return 0;
}

> And what prevents the same pages be filled (with zeros or otherwise) via
> write(2) bypassing VMA checks? I cannot immediately see it.

There isn't any such check. You can bypass userfaultfd on a shmem with
write syscalls, or simply by writing to the shmem through a different
vma. However, it is definitely possible for userspace to use shmem
plus userfaultfd in a safe way. And the kernel shouldn't come along
and break a setup that should be safe from the perspective of
userspace.

> BTW, there's already a check that prevent establishing PMD in the place if
> VM_UFFD_WP is set.
>
> Maybe just an update of the check in retract_page_tables() from
> userfaultfd_wp() to userfaultfd_armed() would be enough?

It seems like it will be a little more complicated than that, because
the target VM having an armed userfaultfd is a hard error condition.
However, it might not be that difficult to modify collapse_file to
rollback if necessary. I'll consider this approach for v2 of this
patch.

-David

> I have very limited understanding of userfaultfd(). Sorry in advance for
> stupid questions.
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
