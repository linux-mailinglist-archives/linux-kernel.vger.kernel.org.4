Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C536DFB83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDLQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A797C121
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jbVuWVrNA4Y82werU02xGsjVWlMrEEeBcIXir594iGg=;
        b=Qm4IFLx74OVM6hl0Q82X9BaKD2m3ZyQFhor0KLX0hQ5b16opEH6iYnCDIXzZesMob4Ou22
        ewxsekf2Bod8MqTbqOID+WpaKYHmNYeNih6kHvJninDWDobPofwueqoJBGjxc9X3y71Tfc
        etr/OjMmstUc0lU6g//eUt4DJZURNBI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-xu_DFDFMM0WVxiz88wqKjA-1; Wed, 12 Apr 2023 12:39:25 -0400
X-MC-Unique: xu_DFDFMM0WVxiz88wqKjA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74a9035256eso54210485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317565; x=1683909565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbVuWVrNA4Y82werU02xGsjVWlMrEEeBcIXir594iGg=;
        b=gD5eAOwHltyhVzRwNLKGkb9BBvFM8Y4F1efJ9I7zJGHyUu2KFwnNixAYT9jMlfp7Ms
         Y/pA+LxVp/V+asx5dt7m2VXaX/bDjgtxovV91Cf6631ozha6mnfvRuKRgjOV6KI4yFDE
         MEkt5go6JJpbeE26g4UnvkQxxPfMQyrNIqa9AdKQsu1iNkWBI7neVCHmpnN0Ael4afof
         eTQc53so6q6JFnJCqOM0uyR59unMd/1V7XzXRhjEZBOivRlQ+rbxzHNuJzXqA1l+6UK9
         6EE1BI0UQez9EyzFlszgmQlVEXbl2G4aQ2xPB2EyYiqswsM1OiUHDvDJOcW9QBRvm8v8
         n5Tg==
X-Gm-Message-State: AAQBX9d8dFdpnn6nbXwMJ67R4eoB5RC6yblbFl9wTqJELaVbwUZygQ8R
        GdT8ad5fVuwc6pvws817eqSycnSVIisRj9MfgHAzf/lp37WTX9B6q0Ya1Z5XM8tfkEvj5l3UErj
        V3X17V96iaPhjoI4O7zz3llN1
X-Received: by 2002:a05:6214:509e:b0:5ab:8be1:6182 with SMTP id kk30-20020a056214509e00b005ab8be16182mr4367423qvb.5.1681317564571;
        Wed, 12 Apr 2023 09:39:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350awfrfDOwbC1SoYt2gc7Jgm/47T8HO6IjP5bSBTGbcEqmHoxssKaL6zk8+c6sI1+tGaHbW4yg==
X-Received: by 2002:a05:6214:509e:b0:5ab:8be1:6182 with SMTP id kk30-20020a056214509e00b005ab8be16182mr4367388qvb.5.1681317564076;
        Wed, 12 Apr 2023 09:39:24 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id u13-20020a0cc48d000000b005ead602acfesm2669536qvi.35.2023.04.12.09.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:39:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com
Subject: [PATCH v2 00/31] selftests/mm: Split / Refactor userfault test
Date:   Wed, 12 Apr 2023 12:38:51 -0400
Message-Id: <20230412163922.327282-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Added r-bs
- Leverage kselftests.h helpers [David]
- Fixed up zeropage test to detect uffdio_register.ioctls to decide whether
  to test UFFDIO_ZEROPAGE or not [MikeK, Axel, David]
  - renamed uffd_register_detect_zp() to uffd_register_detect_zeropage [MikeR]
- Added patch "selftests/mm: Add uffdio register ioctls test" to test all
  combinations of uffdio_register.ioctls
- Added patch "selftests/mm: Rename uffd_stats to uffd_args" [MikeR]
- Cosmetic changes here and there

v1: https://lore.kernel.org/r/20230330155707.3106228-1-peterx@redhat.com

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
Testing UFFDIO_API (with syscall)... done
Testing UFFDIO_API (with /dev/userfaultfd)... done
Testing register-ioctls on anon... done
Testing register-ioctls on shmem... done
Testing register-ioctls on shmem-private... done
Testing register-ioctls on hugetlb... done
Testing register-ioctls on hugetlb-private... done
Testing zeropage on anon... done
Testing zeropage on shmem... done
Testing zeropage on shmem-private... done
Testing zeropage on hugetlb... done
Testing zeropage on hugetlb-private... done
Testing pagemap on anon... done
Testing wp-unpopulated on anon... done
Testing minor on shmem... done
Testing minor on hugetlb... done
Testing minor-wp on shmem... done
Testing minor-wp on hugetlb... done
Testing minor-collapse on shmem... done
Testing sigbus on anon... done
Testing sigbus on shmem... done
Testing sigbus on shmem-private... done
Testing sigbus on hugetlb... done
Testing sigbus on hugetlb-private... done
Testing sigbus-wp on anon... done
Testing sigbus-wp on shmem... done
Testing sigbus-wp on shmem-private... done
Testing sigbus-wp on hugetlb... done
Testing sigbus-wp on hugetlb-private... done
Testing events on anon... done
Testing events on shmem... done
Testing events on shmem-private... done
Testing events on hugetlb... done
Testing events on hugetlb-private... done
Testing events-wp on anon... done
Testing events-wp on shmem... done
Testing events-wp on shmem-private... done
Testing events-wp on hugetlb... done
Testing events-wp on hugetlb-private... done
Userfaults unit tests: pass=39, skip=0, fail=0 (total=39)
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
- selftests/mm: Rename uffd_stats to uffd_args
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

- selftests/mm: Add uffdio register ioctls test

  One more patch to test uffdio_register.ioctls.

Please have a look, any comment welcomed.

Thanks,

Peter Xu (31):
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
  selftests/mm: Rename uffd_stats to uffd_args
  selftests/mm: Let uffd_handle_page_fault() take wp parameter
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
  selftests/mm: Add uffdio register ioctls test

 fs/userfaultfd.c                              |    6 +-
 tools/testing/selftests/mm/.gitignore         |    5 +-
 tools/testing/selftests/mm/Makefile           |   78 +-
 tools/testing/selftests/mm/gup_test.c         |    5 +-
 tools/testing/selftests/mm/hugepage-mremap.c  |    7 +-
 tools/testing/selftests/mm/hugetlb-madvise.c  |   25 +-
 .../selftests/mm/ksm_functional_tests.c       |    6 +-
 tools/testing/selftests/mm/ksm_tests.c        |    2 +-
 tools/testing/selftests/mm/mrelease_test.c    |   11 +-
 tools/testing/selftests/mm/run_vmtests.sh     |   26 +-
 tools/testing/selftests/mm/thuge-gen.c        |   19 +-
 tools/testing/selftests/mm/transhuge-stress.c |   12 +-
 tools/testing/selftests/mm/uffd-common.c      |  618 ++++++
 tools/testing/selftests/mm/uffd-common.h      |  117 +
 tools/testing/selftests/mm/uffd-stress.c      |  481 +++++
 tools/testing/selftests/mm/uffd-unit-tests.c  |  970 +++++++++
 tools/testing/selftests/mm/userfaultfd.c      | 1903 -----------------
 tools/testing/selftests/mm/util.h             |   69 -
 tools/testing/selftests/mm/vm_util.c          |  176 +-
 tools/testing/selftests/mm/vm_util.h          |   50 +
 20 files changed, 2481 insertions(+), 2105 deletions(-)
 create mode 100644 tools/testing/selftests/mm/uffd-common.c
 create mode 100644 tools/testing/selftests/mm/uffd-common.h
 create mode 100644 tools/testing/selftests/mm/uffd-stress.c
 create mode 100644 tools/testing/selftests/mm/uffd-unit-tests.c
 delete mode 100644 tools/testing/selftests/mm/userfaultfd.c
 delete mode 100644 tools/testing/selftests/mm/util.h

-- 
2.39.1

