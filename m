Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB756D0A86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjC3P57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjC3P54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997B58E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680191832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FzU8AXRTXgJivs+tA11Cp/oPoX+kOjKqZrLE55Kt59I=;
        b=Ouzclm0Q/0NDePFePrJe2wnvHdH5P5F92D3AjQkcdc0ggtLXLAUOD2ddgVceIZqKa7aqRN
        vfFUFj8Itwo6URucIRqgBaZNzX7FLFbPfBKxFFTJjuz5GnJ3jqp4N8plAXTmzEkMAqa95b
        50SjbaMT7lc8bmwtbQfVy6O7pMWms9M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-xQed2rRMO8uGIXxeMnjr2g-1; Thu, 30 Mar 2023 11:57:10 -0400
X-MC-Unique: xQed2rRMO8uGIXxeMnjr2g-1
Received: by mail-qv1-f71.google.com with SMTP id m3-20020a0cbf03000000b005de7233ca79so6250907qvi.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680191830; x=1682783830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzU8AXRTXgJivs+tA11Cp/oPoX+kOjKqZrLE55Kt59I=;
        b=1PayI5iTRzQ4kxG5o2rEyq8uK6lCudhbtdak+82ByscItNvygEOdJ3VZ7YErfHpkfi
         18qQyr1VK2hZRE3AmaE/6P5oe+k/iAINtzL5cgpbL3d2Tan98DQcrmniRvXN7eM/FZjN
         5FG2btBRPexTAqQwgJWGnL92/AO0Tim07QhZ+JRNOxQ/AtlKSU8fRQTJgipytdPnDU+/
         1bAUOo+km1kodor+gMIGbU3oMVAfKZJm5FuZ7Eq6idvBKL8XaK3r5oXklJCSmSQ1SZDg
         Wjd5XTavQDQrxYFsT6nntqslxbki6DrNtp6Nr+g3QCuH+cHAj9y+5SWXLw9oJrG9J3bz
         GPuw==
X-Gm-Message-State: AAQBX9eV8G//btzwcLgqh6/O3HJmWvyCy3BiovPcbQ85EyAo+jo73nZX
        san7hfOgaCtGPSJV7n2Z6YuwpuhyAISzzS4ldHHENUFbvFgfhOQuOXjgzV7G4AeEvgTRY6VAlZJ
        mQX3wXETyLrQ+tLjvv9mC6yIb
X-Received: by 2002:a05:6214:4005:b0:5ab:af50:eb45 with SMTP id kd5-20020a056214400500b005abaf50eb45mr36584851qvb.3.1680191829823;
        Thu, 30 Mar 2023 08:57:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350bUHv/u4cEzkhenXL/fVSbaDcDmAAen9r5AqRFCkY9s/kGOc+erAurPYz3AFWxQ2vyHx22eMg==
X-Received: by 2002:a05:6214:4005:b0:5ab:af50:eb45 with SMTP id kd5-20020a056214400500b005abaf50eb45mr36584805qvb.3.1680191829398;
        Thu, 30 Mar 2023 08:57:09 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a0d4a00b0074281812276sm13059380qkl.97.2023.03.30.08.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:57:08 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 00/29] selftests/mm: Split / Refactor userfault test
Date:   Thu, 30 Mar 2023 11:56:38 -0400
Message-Id: <20230330155707.3106228-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for the test case bomb]

This patchset splits userfaultfd.c into two tests:

  - uffd-stress: the "vanilla", old and powerful stress test
  - uffd-unit-tests: all the unit tests will be moved here

This is on my todo list for a long time but I never did it for real.  The
uffd test is growing into a small and cute monster.  I start to notice it's
going harder to maintain such a test and make it useful.

A few issues I found when looking at userfaultfd test:

  - We have a bunch of unit tests in userfaultfd.c, but they always need to
    be run only after a stress type.  No way to not do it.

  - We can only run an unit test for one memory type only, if we want to
    do a quick smoke test to check regressions, there's no good way.  The
    best to come currently is "bash ./run_vmtests.sh -t userfaultfd" thanks
    to the most recent changes to run_vmtests.sh on tagging.  Still, that
    needs to run the stress tests always and hard to see what's wrong.

  - It's hard to add a new unit test to userfaultfd.c, we don't really know
    what's happening, not until we mostly read the whole file.

  - We did a bunch of useless tests, e.g. we run twice the whole suite of
    stress test just to verify both syscall and /dev/userfaultfd.  They're
    all using userfaultfd_new() to create the handle, everything should
    really be the same underneath.  One simple unit test should cover that!

  - We have tens of global variables in one file but shared with all the
    tests.  Some of them are not suitable to be a global var from
    maintainance pov.  It enforces every unit test to consider how these
    vars affects the stress test and vice versa, but that's logically not
    necessary.

  - Userfaultfd test is not friendly to old kernels.  Mostly it only works
    on the latest kernel tree.  It's preferrable to be run on all kernels
    and properly report what's missing.

I'll stop here, I feel like I can still list some..

This patchset should resolve all issues above, and actually we can do even
more on top.  I stopped doing that until I found I already got 29 patches
and 2000+ LOC changes.  That's already a patchset terrible enough so we
should move in small steps.

After the whole set applied, "./run_vmtests.sh -t userfaultfd" looks like
this:

===8<===
vm.nr_hugepages = 1024
-------------------------
running ./uffd-unit-tests
-------------------------
UFFDIO_API (with syscall)... done
UFFDIO_API (with /dev/userfaultfd)... done
zeropage on anon... done
zeropage on shmem... done
zeropage on shmem-private... done
zeropage-hugetlb on hugetlb... done
zeropage-hugetlb on hugetlb-private... done
pagemap on anon... pagemap on anon... pagemap on anon... done
wp-unpopulated on anon... done
minor on shmem... done
minor on hugetlb... done
minor-wp on shmem... done
minor-wp on hugetlb... done
minor-collapse on shmem... done
sigbus on anon... sigbus on anon... done
sigbus on shmem... sigbus on shmem... done
sigbus on shmem-private... sigbus on shmem-private... done
sigbus on hugetlb... sigbus on hugetlb... done
sigbus on hugetlb-private... sigbus on hugetlb-private... done
sigbus-wp on anon... sigbus-wp on anon... done
sigbus-wp on shmem... sigbus-wp on shmem... done
sigbus-wp on shmem-private... sigbus-wp on shmem-private... done
sigbus-wp on hugetlb... sigbus-wp on hugetlb... done
sigbus-wp on hugetlb-private... sigbus-wp on hugetlb-private... done
events on anon... events on anon... done
events on shmem... events on shmem... done
events on shmem-private... events on shmem-private... done
events on hugetlb... events on hugetlb... done
events on hugetlb-private... events on hugetlb-private... done
events-wp on anon... events-wp on anon... done
events-wp on shmem... events-wp on shmem... done
events-wp on shmem-private... events-wp on shmem-private... done
events-wp on hugetlb... events-wp on hugetlb... done
events-wp on hugetlb-private... events-wp on hugetlb-private... done
Userfaults unit tests: pass=34, skip=0, fail=0 (total=34)
[PASS]
--------------------------------
running ./uffd-stress anon 20 16
--------------------------------
nr_pages: 5120, nr_pages_per_cpu: 640
bounces: 15, mode: rnd racing ver poll, userfaults: 345 missing (26+48+61+102+30+12+59+7) 1596 wp (120+139+317+346+215+67+306+86)
[...]
[PASS]
------------------------------------
running ./uffd-stress hugetlb 128 32
------------------------------------
nr_pages: 64, nr_pages_per_cpu: 8
bounces: 31, mode: rnd racing ver poll, userfaults: 29 missing (6+6+6+5+4+2+0+0) 104 wp (20+19+22+18+7+12+5+1)
[...]
[PASS]
--------------------------------------------
running ./uffd-stress hugetlb-private 128 32
--------------------------------------------
nr_pages: 64, nr_pages_per_cpu: 8
bounces: 31, mode: rnd racing ver poll, userfaults: 33 missing (12+9+7+0+5+0+0+0) 111 wp (24+25+14+14+11+17+5+1)
[...]
[PASS]
---------------------------------
running ./uffd-stress shmem 20 16
---------------------------------
nr_pages: 5120, nr_pages_per_cpu: 640
bounces: 15, mode: rnd racing ver poll, userfaults: 247 missing (15+17+34+60+81+37+3+0) 2038 wp (180+114+276+400+381+318+165+204)
[...]
[PASS]
-----------------------------------------
running ./uffd-stress shmem-private 20 16
-----------------------------------------
nr_pages: 5120, nr_pages_per_cpu: 640
bounces: 15, mode: rnd racing ver poll, userfaults: 235 missing (52+29+55+56+13+9+16+5) 2849 wp (218+406+461+531+328+284+430+191)
[...]
[PASS]
SUMMARY: PASS=6 SKIP=0 FAIL=0
===8<===

The output may be different if we miss some features (e.g., hugetlb not
allocated, old kernel, less privilege of uffd handle), but they should show
up with good reasons.  E.g., I tried to run the unit test on my Fedora
kernel and it gives me:

===8<===
UFFDIO_API (with syscall)... failed [reason: UFFDIO_API should fail with wrong api but didn't]
UFFDIO_API (with /dev/userfaultfd)... skipped [reason: cannot open userfaultfd handle]
zeropage on anon... done
zeropage on shmem... done
zeropage on shmem-private... done
zeropage-hugetlb on hugetlb... done
zeropage-hugetlb on hugetlb-private... done
pagemap on anon... pagemap on anon... pagemap on anon... done
wp-unpopulated on anon... skipped [reason: feature missing]
minor on shmem... done
minor on hugetlb... done
minor-wp on shmem... skipped [reason: feature missing]
minor-wp on hugetlb... skipped [reason: feature missing]
minor-collapse on shmem... done
sigbus on anon... skipped [reason: possible lack of priviledge]
sigbus on shmem... skipped [reason: possible lack of priviledge]
sigbus on shmem-private... skipped [reason: possible lack of priviledge]
sigbus on hugetlb... skipped [reason: possible lack of priviledge]
sigbus on hugetlb-private... skipped [reason: possible lack of priviledge]
sigbus-wp on anon... skipped [reason: possible lack of priviledge]
sigbus-wp on shmem... skipped [reason: possible lack of priviledge]
sigbus-wp on shmem-private... skipped [reason: possible lack of priviledge]
sigbus-wp on hugetlb... skipped [reason: possible lack of priviledge]
sigbus-wp on hugetlb-private... skipped [reason: possible lack of priviledge]
events on anon... skipped [reason: possible lack of priviledge]
events on shmem... skipped [reason: possible lack of priviledge]
events on shmem-private... skipped [reason: possible lack of priviledge]
events on hugetlb... skipped [reason: possible lack of priviledge]
events on hugetlb-private... skipped [reason: possible lack of priviledge]
events-wp on anon... skipped [reason: possible lack of priviledge]
events-wp on shmem... skipped [reason: possible lack of priviledge]
events-wp on shmem-private... skipped [reason: possible lack of priviledge]
events-wp on hugetlb... skipped [reason: possible lack of priviledge]
events-wp on hugetlb-private... skipped [reason: possible lack of priviledge]
Userfaults unit tests: pass=9, skip=24, fail=1 (total=34)
===8<===

Patch layout:

- Revert "userfaultfd: don't fail on unrecognized features"

  Something I found when I got the UFFDIO_API test below.  Axel, I still
  propose to revert it as a whole, but feel free to continue the discussion
  from the original patch thread.

- selftests/mm: Update .gitignore with two missing tests
- selftests/mm: Dump a summary in run_vmtests.sh
- selftests/mm: Merge util.h into vm_util.h
- selftests/mm: Use TEST_GEN_PROGS where proper
- selftests/mm: Link vm_util.c always
- selftests/mm: Merge default_huge_page_size() into one
- selftests/mm: Use PM_* macros in vm_utils.h
- selftests/mm: Reuse pagemap_get_entry() in vm_util.h
- selftests/mm: Test UFFDIO_ZEROPAGE only when !hugetlb
- selftests/mm: Drop test_uffdio_zeropage_eexist

  Until here, all cleanups here and there.  I wanted to keep going, but I
  found that maybe it'll take a few more days to split the test.  Hence I
  did a split starting from the next one, so we have a working thing first.

- selftests/mm: Create uffd-common.[ch]
- selftests/mm: Split uffd tests into uffd-stress and uffd-unit-tests

  This did the major brute force split of common codes into
  uffd-common.[ch].  That'll be the so far common base for stress and unit
  tests.  Then a new unit test is created.

- selftests/mm: uffd_[un]register()
- selftests/mm: uffd_open_{dev|sys}()
- selftests/mm: UFFDIO_API test

  This patch hides here to start writting the 1st unit test with
  UFFDIO_API, also detection of userfaultfd privileges.

- selftests/mm: Drop global mem_fd in uffd tests
- selftests/mm: Drop global hpage_size in uffd tests
- selftests/mm: Let uffd_handle_page_fault() takes wp parameter
- selftests/mm: Allow allocate_area() to fail properly

  Some further cleanup that I noticed otherwise hard to move the tests.

- selftests/mm: Add framework for uffd-unit-test

  The major patch provides the framework for most of the rest unit tests.

- selftests/mm: Move uffd pagemap test to unit test
- selftests/mm: Move uffd minor test to unit test
- selftests/mm: Move uffd sig/events tests into uffd unit tests
- selftests/mm: Move zeropage test into uffd unit tests

  Move unit tests and suite them into the new file.

- selftests/mm: Workaround no way to detect uffd-minor + wp
- selftests/mm: Allow uffd test to skip properly with no privilege
- selftests/mm: Drop sys/dev test in uffd-stress test
- selftests/mm: Add shmem-private test to uffd-stress

  A bunch of changes to do better on error reportings, and add
  shmem-private to the stress test which was long missing.

Please have a look, any comment welcomed.

Thanks,

Peter Xu (29):
  Revert "userfaultfd: don't fail on unrecognized features"
  selftests/mm: Update .gitignore with two missing tests
  selftests/mm: Dump a summary in run_vmtests.sh
  selftests/mm: Merge util.h into vm_util.h
  selftests/mm: Use TEST_GEN_PROGS where proper
  selftests/mm: Link vm_util.c always
  selftests/mm: Merge default_huge_page_size() into one
  selftests/mm: Use PM_* macros in vm_utils.h
  selftests/mm: Reuse pagemap_get_entry() in vm_util.h
  selftests/mm: Test UFFDIO_ZEROPAGE only when !hugetlb
  selftests/mm: Drop test_uffdio_zeropage_eexist
  selftests/mm: Create uffd-common.[ch]
  selftests/mm: Split uffd tests into uffd-stress and uffd-unit-tests
  selftests/mm: uffd_[un]register()
  selftests/mm: uffd_open_{dev|sys}()
  selftests/mm: UFFDIO_API test
  selftests/mm: Drop global mem_fd in uffd tests
  selftests/mm: Drop global hpage_size in uffd tests
  selftests/mm: Let uffd_handle_page_fault() takes wp parameter
  selftests/mm: Allow allocate_area() to fail properly
  selftests/mm: Add framework for uffd-unit-test
  selftests/mm: Move uffd pagemap test to unit test
  selftests/mm: Move uffd minor test to unit test
  selftests/mm: Move uffd sig/events tests into uffd unit tests
  selftests/mm: Move zeropage test into uffd unit tests
  selftests/mm: Workaround no way to detect uffd-minor + wp
  selftests/mm: Allow uffd test to skip properly with no privilege
  selftests/mm: Drop sys/dev test in uffd-stress test
  selftests/mm: Add shmem-private test to uffd-stress

 fs/userfaultfd.c                              |    6 +-
 tools/testing/selftests/mm/.gitignore         |    5 +-
 tools/testing/selftests/mm/Makefile           |   77 +-
 tools/testing/selftests/mm/gup_test.c         |    5 +-
 tools/testing/selftests/mm/hugepage-mremap.c  |    7 +-
 tools/testing/selftests/mm/hugetlb-madvise.c  |   25 +-
 .../selftests/mm/ksm_functional_tests.c       |    6 +-
 tools/testing/selftests/mm/ksm_tests.c        |    2 +-
 tools/testing/selftests/mm/mrelease_test.c    |   11 +-
 tools/testing/selftests/mm/run_vmtests.sh     |   26 +-
 tools/testing/selftests/mm/thuge-gen.c        |   19 +-
 tools/testing/selftests/mm/transhuge-stress.c |   12 +-
 tools/testing/selftests/mm/uffd-common.c      |  612 ++++++
 tools/testing/selftests/mm/uffd-common.h      |  117 +
 tools/testing/selftests/mm/uffd-stress.c      |  482 +++++
 tools/testing/selftests/mm/uffd-unit-tests.c  |  891 ++++++++
 tools/testing/selftests/mm/userfaultfd.c      | 1903 -----------------
 tools/testing/selftests/mm/util.h             |   69 -
 tools/testing/selftests/mm/vm_util.c          |  166 +-
 tools/testing/selftests/mm/vm_util.h          |   48 +
 20 files changed, 2385 insertions(+), 2104 deletions(-)
 create mode 100644 tools/testing/selftests/mm/uffd-common.c
 create mode 100644 tools/testing/selftests/mm/uffd-common.h
 create mode 100644 tools/testing/selftests/mm/uffd-stress.c
 create mode 100644 tools/testing/selftests/mm/uffd-unit-tests.c
 delete mode 100644 tools/testing/selftests/mm/userfaultfd.c
 delete mode 100644 tools/testing/selftests/mm/util.h

-- 
2.39.1

