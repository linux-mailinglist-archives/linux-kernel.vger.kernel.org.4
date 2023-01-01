Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6665ABDE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 23:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjAAWB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 17:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAWBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 17:01:24 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5BD5B
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 14:01:22 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id j9so12241026qvt.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 14:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AT7tBzzwsdUMveRYM/ySQCoDuiNY1FKohos1PA5Um80=;
        b=QVNO7MeqsnpbI/SVpzo9dARAZvcLug6L3Ei+hu43b8TVCo65tExfg1sAFQryUSkhWl
         lzsXJ4ygJZFP9K2zss790ux5rNMjGNM5X/9twuX9y4Xt/iknIy/kj1aH/vgd/pLwBn70
         HYpaCHH36b7awWbqTxmsXpyyJBHkuJG4RGNMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AT7tBzzwsdUMveRYM/ySQCoDuiNY1FKohos1PA5Um80=;
        b=TdFkToG34KJPQDp8qN8IrGFqmaRlfOb/yxwN/M07ZddR1FyHuPxnwy4oXF9WNiSACb
         pR1jSorgoSb5DwYKECmdw9kHyVr/RTWhWs71J+0Q5FWa6qEI6G0l0uXBHvW2coTgQAG1
         d7ejMNvISaT1hbRjH7SfAKBPfyx8Vh9ONu/R2adDi7UXIPEmXkC9rKy5/exmcyQUHk97
         1yy4oYRTb6JSYo7ZDmuKB56VrIsHvH3z/4SY+9vnF14y7SQzn2Qoi7XPfL36eEXdVIfE
         DC7Vim8ACp2bEh4gwMG5HmWKRIllG41cZRDu0smt3VWqbVLqfcaZdL6Gs1K1F6uHJZKe
         8LWw==
X-Gm-Message-State: AFqh2koQU4MkH4a0BbaPkxvZuBF+0y0hFb2CkQP7A+H3ewi5l14WASSl
        w9mHqw4LtpGD00ude9TarYhFZ+stIW2b2MB6
X-Google-Smtp-Source: AMrXdXs0si0TBqsUthva0od+CNw8etRd/HFZFJCqbHk3mgCNLiIlXargRUG5WrMN1ifUiM1vpCa28g==
X-Received: by 2002:a05:6214:311c:b0:4c6:d886:2680 with SMTP id ks28-20020a056214311c00b004c6d8862680mr53739852qvb.40.1672610480945;
        Sun, 01 Jan 2023 14:01:20 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a298100b006eeb3165565sm19457565qkp.80.2023.01.01.14.01.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 14:01:20 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id p12so12742967qkm.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 14:01:20 -0800 (PST)
X-Received: by 2002:a05:620a:1379:b0:6fc:c48b:8eab with SMTP id
 d25-20020a05620a137900b006fcc48b8eabmr1420328qkl.216.1672610480063; Sun, 01
 Jan 2023 14:01:20 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Jan 2023 14:01:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
Message-ID: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
Subject: Linux 6.2-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the week started so slow due to the holidays that I thought I might
not have any reason to do an rc2 at all, but by the end of the week I
did end up getting a smattering of pull requests, so here we are. It's
tiny, even smaller than usual for an rc2, and honestly, I'd expect
that trend to continue for rc3. A lot of people are still off for
another week on a well-deserved winter holiday, and so I suspect
things will continue to be fairly quiet.

Anyway, last week saw mainly some nvme fixes, some i915 drm work, and
some kvm fixes (and kvm testing fixes). See below for the full
shortlog, and if you're not still in a food coma from the holidays,
please do give this all a good testing.

               Linus

---

Adam Vodopjan (1):
      ata: ahci: Fix PCS quirk application for suspend

Adamos Ttofari (1):
      KVM: x86: ioapic: Fix level-triggered EOI and userspace I/OAPIC
reconfigure race

Adrian Freund (1):
      ACPI: resource: do IRQ override on Lenovo 14ALC7

Andrzej Hajda (1):
      drm/i915: fix TLB invalidation for Gen12.50 video and compute engines

Arnd Bergmann (1):
      x86/calldepth: Fix incorrect init section references

Artem Egorkine (2):
      ALSA: line6: correct midi status byte when receiving data from podxt
      ALSA: line6: fix stack overflow in line6_midi_transmit

Bhaskar Chowdhury (1):
      kconfig: Add static text for search information in help menu

Chengming Zhou (1):
      perf/core: Fix cgroup events tracking

Chris Chiu (1):
      ALSA: hda/realtek: Apply dual codec fixup for Dell Latitude laptops

Christoph Hellwig (9):
      nvme: fix setting the queue depth in nvme_alloc_io_tag_set
      nvme-pci: update sqsize when adjusting the queue depth
      docs, nvme: add a feature and quirk policy document
      nvme: fix the NVME_CMD_EFFECTS_CSE_MASK definition
      nvmet: use NVME_CMD_EFFECTS_CSUPP instead of open coding it
      nvmet: set the LBCC bit for commands that modify data
      nvmet: don't defer passthrough commands with trivial effects to
the workqueue
      nvme: also return I/O command effects from nvme_command_effects
      nvme: consult the CSE log page for unprivileged passthrough

Colin Ian King (1):
      perf/x86/amd: fix potential integer overflow on shift of a int

David Woodhouse (3):
      KVM: x86/xen: Use kvm_read_guest_virt() instead of open-coding it badly
      KVM: x86/xen: Add KVM_XEN_INVALID_GPA and KVM_XEN_INVALID_GFN to uapi
      KVM: x86/xen: Documentation updates and clarifications

Erik Schumacher (1):
      ACPI: resource: do IRQ override on XMG Core 15

Hans de Goede (2):
      ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks
      ACPI: video: Fix Apple GMUX backlight detection

Jani Nikula (2):
      drm/i915/dsi: add support for ICL+ native MIPI GPIO sequence
      drm/i915/dsi: fix MIPI_BKLT_EN_1 native GPIO index

Jens Axboe (3):
      io_uring: finish waiting before flushing overflow entries
      io_uring/cancel: re-grab ctx mutex after finishing wait
      io_uring: check for valid register opcode earlier

John Harrison (1):
      drm/i915/uc: Fix two issues with over-size firmware files

Jun ASAKA (1):
      kbuild: add a missing line for help message

Keith Busch (2):
      nvme-pci: fix mempool alloc size
      nvme-pci: fix page size checks

Klaus Jensen (1):
      nvme-pci: fix doorbell buffer value endianness

Lai Jiangshan (2):
      kvm: Remove the unused macro KVM_MMU_READ_{,UN}LOCK()
      kvm: x86/mmu: Remove duplicated "be split" in spte.h

Like Xu (1):
      KVM: x86/pmu: Prevent zero period event from being repeatedly released

Linus Torvalds (1):
      Linux 6.2-rc2

Lucas De Marchi (1):
      drm/i915: Remove __maybe_unused from mtl_info

Lukas Bulwahn (1):
      MAINTAINERS: adjust entry after renaming the vmx hyperv files

Mario Limonciello (5):
      ACPI: video: Allow GPU drivers to report no panels
      drm/amd/display: Report to ACPI video if no panels were found
      ACPI: video: Don't enable fallback path for creating ACPI
backlight by default
      ACPI: x86: s2idle: Force AMD GUID/_REV 2 on HP Elitebook 865
      ACPI: x86: s2idle: Stop using AMD specific codepath for Rembrandt+

Masahiro Yamada (5):
      arch: fix broken BuildID for arm64 and riscv
      .gitignore: ignore *.rpm
      kbuild: rpm-pkg: add libelf-devel as alternative for BuildRequires
      kbuild: sort single-targets alphabetically again
      fixdep: remove unneeded <stdarg.h> inclusion

Masami Hiramatsu (Google) (2):
      x86/kprobes: Fix kprobes instruction boudary check with CONFIG_RETHUNK
      x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK

Mathieu Desnoyers (1):
      futex: Fix futex_waitv() hrtimer debug object leak on kcalloc error

Matthew Auld (1):
      drm/i915: improve the catch-all evict to handle lock contention

Mel Gorman (1):
      rtmutex: Add acquire semantics for rtmutex lock acquisition slow path

Michal Luczaj (2):
      KVM: x86/xen: Fix memory leak in kvm_xen_write_hypercall_page()
      KVM: x86/xen: Simplify eventfd IOCTLs

Namhyung Kim (1):
      perf/core: Call LSM hook after copying perf_event_attr

Oliver Upton (2):
      KVM: arm64: selftests: Don't identity map the ucall MMIO hole
      KVM: selftests: Mark correct page as mapped in virt_map()

Paolo Bonzini (5):
      KVM: selftests: document the default implementation of
vm_vaddr_populate_bitmap
      KVM: x86/xen: Fix SRCU/RCU usage in readers of evtchn_ports
      KVM: x86: fix deadlock for KVM_XEN_EVTCHN_RESET
      Documentation: kvm: clarify SRCU locking order
      KVM: selftests: restore special vmmcall code layout needed by the harness

Peng Hao (1):
      KVM: x86: Simplify kvm_apic_hw_enabled

Peter Zijlstra (1):
      perf: Fix use-after-free in error path

Ravi Bangoria (1):
      perf core: Return error pointer if inherit_event() fails to find pmu_ctx

Sagi Grimberg (1):
      nvme-auth: fix smatch warning complaints

Samuel Holland (1):
      kbuild: Fix running modpost with musl libc

Sean Christopherson (22):
      KVM: x86: Sanity check inputs to kvm_handle_memory_failure()
      KVM: selftests: Zero out valid_bank_mask for "all" case in
Hyper-V IPI test
      KVM: nVMX: Document that ignoring memory failures for VMCLEAR is
deliberate
      KVM: nVMX: Properly expose ENABLE_USR_WAIT_PAUSE control to L1
      KVM: nVMX: Don't stuff secondary execution control if it's not supported
      KVM: x86/mmu: Don't attempt to map leaf if target TDP MMU SPTE is frozen
      KVM: x86/mmu: Map TDP MMU leaf SPTE iff target level is reached
      KVM: x86/mmu: Re-check under lock that TDP MMU SP hugepage is disallowed
      KVM: x86/mmu: Don't install TDP MMU SPTE if SP has unexpected level
      KVM: selftests: Define literal to asm constraint in aarch64 as
unsigned long
      KVM: selftests: Delete dead code in x86_64/vmx_tsc_adjust_test.c
      KVM: selftests: Fix divide-by-zero bug in memslot_perf_test
      KVM: selftests: Use pattern matching in .gitignore
      KVM: selftests: Fix a typo in x86-64's kvm_get_cpu_address_width()
      KVM: selftests: Rename UNAME_M to ARCH_DIR, fill explicitly for x86
      KVM: selftests: Use proper function prototypes in probing code
      KVM: selftests: Probe -no-pie with actual CFLAGS used to compile
      KVM: selftests: Explicitly disable builtins for mem*() overrides
      KVM: selftests: Include lib.mk before consuming $(CC)
      KVM: selftests: Disable "gnu-variable-sized-type-not-at-end" warning
      KVM: selftests: Use magic value to signal ucall_alloc() failure
      KVM: Delete extra block of "};" in the KVM API documentation

Stefan Metzmacher (1):
      uapi:io_uring.h: allow linux/time_types.h to be skipped

Takashi Iwai (1):
      ALSA: hda/hdmi: Static PCM mapping again with AMD HDMI codecs

Vitaly Kuznetsov (1):
      KVM: x86: hyper-v: Fix 'using uninitialized value' Coverity warning

Yanjun Zhang (1):
      nvme: fix multipath crash caused by flush request when blktrace is enabled

YoungJun.park (1):
      kunit: alloc_string_stream_fragment error handling bug fix

Yu Kuai (1):
      block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq
