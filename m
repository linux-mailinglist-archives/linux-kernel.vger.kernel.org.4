Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07645F6C86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiJFRLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJFRLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:11:46 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA449A4848
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:11:45 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id br14-20020a056a00440e00b00548434985cdso1452427pfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ouKg7TyCIdZkg1NWdjg7eNYnq70p2SefFVvR7Lkt1MY=;
        b=LssfsNIxBXo//o5yVMpFCPXp+s4z3rqFTTa669U5mPMzlNHICB64lUNvNe2dsITMFw
         Z5hy0+V+8v4FKM8yFtcVVvkWpPtswWD5EMQnlhlhQmliDwqu9nWpoSs3oVntKTtNlVK5
         9TzY1wkzZalAmv6/Oe50AJ9w0mAjdMlr6oBlB7k16G2pchn7DbKsf0GBGbMe1RsFpyTc
         up1t/pAmu5noZthukMGLO0MJNofNCloCccV1pR7c52mjQKAVhjuzpZjm1CZKttXKHx6d
         /mwzVXVwGBx2kV5rTzDBBFFmd4gNQuY6dctEY+knF5wbKyxswe1Xwn9yXI7/t0u9ActV
         wfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouKg7TyCIdZkg1NWdjg7eNYnq70p2SefFVvR7Lkt1MY=;
        b=e6u+VB1n35Ay/zmtMUGNogvjFWCnlPp82RIrab2pbXBt6O238aG4VW0RMsrO/Epydu
         EL0Ld4yt1r/Ns5JAEYGiy7OWdED2s6haoXDMh+Y9npPD121sKpcXLPRuKoIjpFKf1L8q
         9C9bb0rjkEjN2Pa2csmJ/SHTJLHXIgFz6KxwXfSQ3uSgo+Ck1GWRpg0dZjdkT2W0Jx5h
         O9Ve/lyDy55RbVnGpQ76o0Nw6jMWvJmmR3hmC/6ft9zv9pTsjsy68E7s8V6szUxFwBTH
         9vGBjQnR6bA0L9RFpJ++wIfk2JwwELFP3fmgWoIl8ZPDb1Wsf60sspII5So7B464ABIP
         NOJQ==
X-Gm-Message-State: ACrzQf0AGt4azyLi2JWr8rYTCpH7t/cen4B3+nHOFcVybDuCV7ylBUSC
        7yc7Wto9X6SO7VhDuFXfnGUhOH1JDQk2
X-Google-Smtp-Source: AMsMyM5NlmMkkHSBr8WvNftrIAfxFk5zNKvA9HEit+kXRza0IekpWLMYKZSPowHl+OOxBmujtveTRzWRdHky
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6a00:1808:b0:542:f4f2:86aa with SMTP
 id y8-20020a056a00180800b00542f4f286aamr478984pfa.28.1665076305334; Thu, 06
 Oct 2022 10:11:45 -0700 (PDT)
Date:   Thu,  6 Oct 2022 10:11:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006171133.372359-1-vipinsh@google.com>
Subject: [PATCH v4 0/4] dirty_log_perf_test CPU pinning
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin vcpus to a host physical cpus in dirty_log_perf_test and optionally
pin the main application thread to a physical cpu if provided. All tests
based on perf_test_util framework can take advantage of it if needed.

While at it, I changed atoi() to atoi_paranoid() in other tests, sorted
command line options alphabetically, and added break between -e and -g
which was missed in original commit.

v4:
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

Vipin Sharma (4):
  KVM: selftests: Add missing break between 'e' and 'g' option in
    dirty_log_perf_test
  KVM: selftests: Put command line options in alphabetical order in
    dirty_log_perf_test
  KVM: selftests: Add atoi_paranoid() to catch errors missed by atoi()
  KVM: selftests: Run dirty_log_perf_test on specific CPUs

 .../selftests/kvm/aarch64/arch_timer.c        |  8 +--
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |  6 +-
 .../selftests/kvm/access_tracking_perf_test.c |  2 +-
 .../selftests/kvm/demand_paging_test.c        |  2 +-
 .../selftests/kvm/dirty_log_perf_test.c       | 64 +++++++++++++------
 .../selftests/kvm/include/perf_test_util.h    |  6 ++
 .../testing/selftests/kvm/include/test_util.h |  2 +
 .../selftests/kvm/kvm_page_table_test.c       |  2 +-
 .../selftests/kvm/lib/perf_test_util.c        | 58 ++++++++++++++++-
 tools/testing/selftests/kvm/lib/test_util.c   | 18 ++++++
 .../selftests/kvm/max_guest_memory_test.c     |  6 +-
 .../kvm/memslot_modification_stress_test.c    |  4 +-
 .../testing/selftests/kvm/memslot_perf_test.c | 10 +--
 .../selftests/kvm/set_memory_region_test.c    |  2 +-
 .../selftests/kvm/x86_64/nx_huge_pages_test.c |  4 +-
 15 files changed, 149 insertions(+), 45 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

