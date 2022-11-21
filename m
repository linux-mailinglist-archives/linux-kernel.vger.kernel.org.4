Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5488B6330C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiKUXkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKUXka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:40:30 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0B5B703B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:40:29 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b13-20020a056a000a8d00b0057348c50123so5393319pfl.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFCg8eQyxJ3YiwHQJTueCjvpRWd24CEedZt1FgDbs2A=;
        b=c3e7dEfzyHyyb2tymFn9lfTQ7lWoHc+TnQZBFgbp6eHBJ/M9ppJj1ZVo0YqrNdnsgg
         ioCId1IFXcAJJJHKX7CVtomhNqR071qP367AZjRFHxlSnGtENoI6znHuhT+AgIpRPdDJ
         Qxt/GW5+d0cPRh1nlhM6opcCifMSoAVLIBUWoydKUAeqsKUUXItmNxuk2W1NmReVP9yT
         ajekZU0yAt5c2Iffh3jq+ftXKOzKqBcWCNQ+d5FqAjEs6tZTwXl2aaKCFAZjRwxsaq5S
         8hfzg98BUZrT5TFaHuo3cXz8DK1Y9COBbhYa2cv4IXd4CFs+6mN4LM/pqBd49qAhbWEn
         55BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFCg8eQyxJ3YiwHQJTueCjvpRWd24CEedZt1FgDbs2A=;
        b=HHBTW3qWIN/qbJia/fZyTzgRRVqZvjifgjP/AVZp3mpQE/O/XXGaAxKu4Ojq1ZVbhZ
         GctfNokxe/Vhj52NEb3OSzATXM2VcmbuxTkUBNjglsWzmzVRzoMRI943LLS/8xpvr0cI
         eRblf0YMk9Xjr19f+G6AKY/H013cQEnYTDxqm0dQVeLywKtDRee7lxXNXJ0A5URkGFQt
         3kEb5VXiLSXechVYl+6JYfVTUfBW6jFeR7WCVoRxNmrac3/fVfD7a75GKDXKmQhKguzn
         hzm8uspKYvGybKWUG8v+BjxwYMN7MnAIE0jO5oxYMLJZhYu3xHJqs/+NSxg/iqDVAEuV
         NXiA==
X-Gm-Message-State: ANoB5pn5H2lah1h8/H95HyT+1hf68NBG6Or5EWgV0e9CbVetfKycDu4V
        DADnlAM+ulMYLp7DVbt75B+TjO0EAClJ
X-Google-Smtp-Source: AA0mqf43ZnvPS3T3OgvIZVEV8SrAehRfExGRAijdCF4ppQi8XcXG2CrGAAiXoX2EIOpResh4wRnE+KtSrf85
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:460b:b0:218:8a84:aeca with SMTP id
 w11-20020a17090a460b00b002188a84aecamr16961664pjg.63.1669074029391; Mon, 21
 Nov 2022 15:40:29 -0800 (PST)
Date:   Mon, 21 Nov 2022 15:40:20 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121234026.3037083-1-vipinsh@google.com>
Subject: [PATCH v2 0/6] Add Hyper-v extended hypercall support in KVM
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

This patch series adds Hyper-V extended hypercall support. All
hypercalls will exit to userspace if CPUID.0x40000003.EBX BIT(20) is
set.

v2:
- Intorduced ASSERT_EXIT_REASON macro and replaced all occurences of
  TEST_ASSERT for vcpu exit reason.
- Skip hyperv_extended_hypercalls test if extended hypercalls are not
  supported by the kernel.
- Rebased with latest KVM queue.
- Addressed all of the comments in patch 6 of v1.

v1: https://lore.kernel.org/lkml/20221105045704.2315186-1-vipinsh@google.com/

RFC: https://lore.kernel.org/lkml/20221021185916.1494314-1-vipinsh@google.com/

Vipin Sharma (6):
  KVM: x86: hyper-v: Use common code for hypercall userspace exit
  KVM: x86: hyper-v: Add extended hypercall support in Hyper-v
  KVM: selftests: Test Hyper-V extended hypercall enablement
  KVM: selftests: Replace hardcoded Linux OS id with HYPERV_LINUX_OS_ID
  KVM: selftests: Make vCPU exit reason test assertion common.
  KVM: selftests: Test Hyper-V extended hypercall exit to userspace

 arch/x86/kvm/hyperv.c                         | 43 +++++----
 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../testing/selftests/kvm/aarch64/psci_test.c |  4 +-
 .../testing/selftests/kvm/include/test_util.h | 10 ++
 .../selftests/kvm/include/x86_64/hyperv.h     |  4 +
 .../selftests/kvm/include/x86_64/processor.h  |  3 +
 .../kvm/lib/s390x/diag318_test_handler.c      |  3 +-
 .../selftests/kvm/s390x/sync_regs_test.c      | 15 +--
 .../selftests/kvm/set_memory_region_test.c    |  6 +-
 tools/testing/selftests/kvm/x86_64/amx_test.c |  8 +-
 .../kvm/x86_64/cr4_cpuid_sync_test.c          |  8 +-
 .../testing/selftests/kvm/x86_64/debug_regs.c |  2 +-
 .../selftests/kvm/x86_64/flds_emulation.h     |  5 +-
 .../selftests/kvm/x86_64/hyperv_clock.c       |  9 +-
 .../selftests/kvm/x86_64/hyperv_evmcs.c       |  8 +-
 .../kvm/x86_64/hyperv_extended_hypercalls.c   | 94 +++++++++++++++++++
 .../selftests/kvm/x86_64/hyperv_features.c    | 23 +++--
 .../testing/selftests/kvm/x86_64/hyperv_ipi.c |  6 +-
 .../selftests/kvm/x86_64/hyperv_svm_test.c    |  7 +-
 .../selftests/kvm/x86_64/hyperv_tlb_flush.c   | 14 +--
 .../selftests/kvm/x86_64/kvm_clock_test.c     |  5 +-
 .../selftests/kvm/x86_64/kvm_pv_test.c        |  5 +-
 .../selftests/kvm/x86_64/monitor_mwait_test.c |  9 +-
 .../kvm/x86_64/nested_exceptions_test.c       |  5 +-
 .../selftests/kvm/x86_64/platform_info_test.c | 14 +--
 .../kvm/x86_64/pmu_event_filter_test.c        |  6 +-
 tools/testing/selftests/kvm/x86_64/smm_test.c |  9 +-
 .../testing/selftests/kvm/x86_64/state_test.c |  8 +-
 .../selftests/kvm/x86_64/svm_int_ctl_test.c   |  8 +-
 .../kvm/x86_64/svm_nested_shutdown_test.c     |  7 +-
 .../kvm/x86_64/svm_nested_soft_inject_test.c  |  6 +-
 .../selftests/kvm/x86_64/svm_vmcall_test.c    |  6 +-
 .../selftests/kvm/x86_64/sync_regs_test.c     | 25 +----
 .../kvm/x86_64/triple_fault_event_test.c      |  9 +-
 .../selftests/kvm/x86_64/tsc_scaling_sync.c   |  6 +-
 .../kvm/x86_64/ucna_injection_test.c          | 22 +----
 .../selftests/kvm/x86_64/userspace_io_test.c  |  6 +-
 .../kvm/x86_64/userspace_msr_exit_test.c      | 22 +----
 .../kvm/x86_64/vmx_apic_access_test.c         | 11 +--
 .../kvm/x86_64/vmx_close_while_nested_test.c  |  5 +-
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c |  7 +-
 .../vmx_exception_with_invalid_guest_state.c  |  4 +-
 .../x86_64/vmx_invalid_nested_guest_state.c   |  4 +-
 .../kvm/x86_64/vmx_nested_tsc_scaling_test.c  |  6 +-
 .../kvm/x86_64/vmx_preemption_timer_test.c    |  8 +-
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |  6 +-
 .../selftests/kvm/x86_64/xapic_ipi_test.c     |  6 +-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    |  7 +-
 .../selftests/kvm/x86_64/xen_vmcall_test.c    |  5 +-
 50 files changed, 211 insertions(+), 310 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c

-- 
2.38.1.584.g0f3c55d4c2-goog

