Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734FA6172BA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiKBXgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKBXgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:36:23 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CAB10B5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:28:21 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id my9-20020a17090b4c8900b002130d29fd7cso2491297pjb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GVDwppNIFdZzJ3NvjqFlD7joUhec8NX65u/knBoNMXg=;
        b=iAmWVTx2FcvRNQjboZ95OYvgHeARovhhj/XWis2M8EXKH4EqTeUeKq3i/KxZvqw6pv
         E4ZnNH/nmAb++1YmMNNJqr/+su8lFsP8OLv7TIu+6HuSkTdqRZdkfmNhCLd3U9OlmqOE
         iaPsPyJcuEWKxVEojfeQV9am1y7TEoAuminOZHXtFF7GQHWbHPOa6tdZxlCoG+G35fA7
         Frry4FNpK4C3IXGcCeTqEUjVN0MVOlisiS099C09nf5u/GDbMC2DfaWp96uSaf6znd+t
         cAt6TWXA6SEPPe/TsIMyMQXi+vhEzmRToldR9q1R7FSbHZX/TggyYhmd8zhXz3thnTAk
         tg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVDwppNIFdZzJ3NvjqFlD7joUhec8NX65u/knBoNMXg=;
        b=ZsQM1CcWVT74PV6yPyaziCKEzp+02FkyefKtDqWQYcQt+hoXFQv3tUfRRNbALadQvF
         iB0jx5krPWU4eDyOR+o8rKJ3Lys+Y8DiIfcD06NqfqJO2GlEhnXpfE/B431smUJygqQz
         IbGo002DGN5NwEbViX/kLPYUNow97t5k3V8CPU9tUPgT4MmzqEiGAWe2lax4joPICnoi
         wcsKKqciUJPwfghpm7FOaA/UGpM8P/f+vcLDQ/PPktjmrpo6AY8ztOnCf1X83QnmyOtO
         YuGDg7SEwypoOHXtfQnHh1TcQlbS7pCX9rxHf7DZRlxtSMapbmEMmRE78Hq4CYX2xUrd
         Kwbw==
X-Gm-Message-State: ACrzQf2nDy8PuP5gxS9NVqMVlvIYEY65sal5V2ii10a4JjC/yccfzmoj
        DAFjno1MSPvpFB7+iJOXY67w98C9e0Kj
X-Google-Smtp-Source: AMsMyM6G+ShkBFVO0eXFxVRRKu7DiQlGMXEwN6jAUk8LEYzc5kmUIe1dGMOeJj+gbYLJGskWbcG3h2NR6ODQ
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:902:7c04:b0:186:abd0:9401 with SMTP id
 x4-20020a1709027c0400b00186abd09401mr27640671pll.64.1667431660724; Wed, 02
 Nov 2022 16:27:40 -0700 (PDT)
Date:   Wed,  2 Nov 2022 16:27:30 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102232737.1351745-1-vipinsh@google.com>
Subject: [PATCH v8 0/7] dirty_log_perf_test vCPU pinning
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin vCPUs to a host physical CPUs (pCPUs) in dirty_log_perf_test and
optionally pin the main application thread to a physical cpu if
provided. All tests based on perf_test_util framework can take advantage
of it if needed.

While at it, I changed atoi() to atoi_paranoid(), atoi_positive,
atoi_non_negative() in other tests, sorted command line options
alphabetically in dirty_log_perf_test, and added break between -e and -g
which was missed in original commit when -e was introduced.

v8:
- Changed atoi_positive() and atoi_non_negative() to accept variable name also.
- Moved atoi_positive() and atoi_non_negative() definition to test_util.h
- Removed new line character from TEST_ASSERT() statements.
- Using official SZ_1G from sizes.h header file in max_guest_memory_test.c
- Shortened test args name in memslot_modification_stress_test.c

v7: https://lore.kernel.org/lkml/20221031173819.1035684-1-vipinsh@google.com/
- Moved pinning APIs from perf_test_util.c to kvm_util.c.
- Missed one atoi() call in aarch64/debug-exceptions.c, changed it to
  atoi_positive().

v6: https://lore.kernel.org/lkml/20221021211816.1525201-1-vipinsh@google.com/
- Updated the shortlog of Patch 5.
- Changed formatting of help text of -c in dirty_log_perf_test

v5: https://lore.kernel.org/lkml/20221010220538.1154054-1-vipinsh@google.com/
- Added atoi_postive() and atoi_non_negative() APIs for string parsing.
- Using sched_getaffinity() to verify if a pCPU is allowed or not.
- Changed Suggested-by to add only person came up with original idea of
  pinning.
- Updated strings and commit messages.

v4: https://lore.kernel.org/lkml/20221006171133.372359-1-vipinsh@google.com/
- Moved boolean to check vCPUs pinning from perf_test_vcpu_args to
  perf_test_args.
- Changed assert statements to make error more descriptive.
- Modified break statement between 'e' and 'g' option in v3 by not copying
  dirty_log_manual_caps = 0 to 'e'.

v3: https://lore.kernel.org/lkml/20220826184500.1940077-1-vipinsh@google.com
- Moved atoi_paranoid() to test_util.c and replaced all atoi() usage
  with atoi_paranoid()
- Sorted command line options alphabetically.
- Instead of creating a vcpu thread on a specific pcpu the thread will
  migrate to the provided pcpu after its creation.
- Decoupled -e and -g option.

v2: https://lore.kernel.org/lkml/20220819210737.763135-1-vipinsh@google.com/
- Removed -d option.
- One cpu list passed as option, cpus for vcpus, followed by
  application thread cpu.
- Added paranoid cousin of atoi().

v1: https://lore.kernel.org/lkml/20220817152956.4056410-1-vipinsh@google.com


Vipin Sharma (7):
  KVM: selftests: Add missing break between -e and -g option in
    dirty_log_perf_test
  KVM: selftests: Put command line options in alphabetical order in
    dirty_log_perf_test
  KVM: selftests: Add atoi_paranoid() to catch errors missed by atoi()
  KVM: selftests: Use SZ_1G from sizes.h in max_guest_memory_test.c
  KVM: selftests: Shorten the test args in
    memslot_modification_stress_test.c
  KVM: selftests: Add atoi_positive() and atoi_non_negative() for input
    validation
  KVM: selftests: Allowing running dirty_log_perf_test on specific CPUs

 .../selftests/kvm/aarch64/arch_timer.c        | 25 ++------
 .../selftests/kvm/aarch64/debug-exceptions.c  |  2 +-
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |  6 +-
 .../selftests/kvm/access_tracking_perf_test.c |  2 +-
 .../selftests/kvm/demand_paging_test.c        |  4 +-
 .../selftests/kvm/dirty_log_perf_test.c       | 64 +++++++++++++------
 .../selftests/kvm/include/kvm_util_base.h     |  4 ++
 .../selftests/kvm/include/perf_test_util.h    |  4 ++
 .../testing/selftests/kvm/include/test_util.h | 18 ++++++
 .../selftests/kvm/kvm_page_table_test.c       |  4 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 54 ++++++++++++++++
 .../selftests/kvm/lib/perf_test_util.c        |  8 ++-
 tools/testing/selftests/kvm/lib/test_util.c   | 19 ++++++
 .../selftests/kvm/max_guest_memory_test.c     | 21 +++---
 .../kvm/memslot_modification_stress_test.c    | 22 +++----
 .../testing/selftests/kvm/memslot_perf_test.c | 24 ++-----
 .../selftests/kvm/set_memory_region_test.c    |  2 +-
 .../selftests/kvm/x86_64/nx_huge_pages_test.c |  5 +-
 18 files changed, 191 insertions(+), 97 deletions(-)

-- 
2.38.1.273.g43a17bfeac-goog

