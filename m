Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0D64B6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiLMOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiLMOBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:01:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6191EAD7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:01:22 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C43141EC06D7;
        Tue, 13 Dec 2022 15:01:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670940080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=RlETWsJF/qf3+oSYZr5dCO2mk2rbFBrnrhMYfaNCAes=;
        b=k8bcraQo9z6aULuwhiNvYc9zSlPpFKhLtPCg301mPiWKAY5rQNJbuV8fD7BG7OK0Bvbctk
        Y47Tx8CayLo6DGYUc8GwQ1F0vYR4EHst4TtaGKYe1LAxXDqw/x86jDANfG3CRQjHuTIjLT
        XDQDl+j6+oIJH/XT3RyribRH9boPYo4=
Date:   Tue, 13 Dec 2022 15:01:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.2
Message-ID: <Y5iFrMDV+YOdncjA@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/cpu pile of changes for 6.2.

Thx.

---

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.2

for you to fetch changes up to 7882b69eb6cdf6288a89d831d95c8547400a8b4d:

  x86/mtrr: Make message for disabled MTRRs more descriptive (2022-12-05 11:08:25 +0100)

----------------------------------------------------------------
- Split MTRR and PAT init code to accomodate at least Xen PV and TDX
guests which do not get MTRRs exposed but only PAT. (TDX guests do not
support the cache disabling dance when setting up MTRRs so they fall
under the same category.) This is a cleanup work to remove all the ugly
workarounds for such guests and init things separately (Juergen Gross)

- Add two new Intel CPUs to the list of CPUs with "normal" Energy
Performance Bias, leading to power savings

- Do not do bus master arbitration in C3 (ARB_DISABLE) on modern Centaur
CPUs

----------------------------------------------------------------
Borislav Petkov (2):
      x86/bugs: Use sysfs_emit()
      x86/cpuid: Carve out all CPUID functionality

Juergen Gross (22):
      x86/mtrr: Add comment for set_mtrr_state() serialization
      x86/mtrr: Remove unused cyrix_set_all() function
      x86/mtrr: Replace use_intel() with a local flag
      x86/mtrr: Rename prepare_set() and post_set()
      x86/mtrr: Split MTRR-specific handling from cache dis/enabling
      x86/mtrr: Move cache control code to cacheinfo.c
      x86/mtrr: Disentangle MTRR init from PAT init
      x86/mtrr: Remove set_all callback from struct mtrr_ops
      x86/mtrr: Simplify mtrr_bp_init()
      x86/mtrr: Get rid of __mtrr_enabled bool
      x86/mtrr: Let cache_aps_delayed_init replace mtrr_aps_delayed_init
      x86/mtrr: Add a stop_machine() handler calling only cache_cpu_init()
      x86: Decouple PAT and MTRR handling
      x86/cacheinfo: Switch cache_ap_init() to hotplug callback
      x86/mtrr: Simplify mtrr_ops initialization
      x86/cpufeatures: Add X86_FEATURE_XENPV to disabled-features.h
      x86/cpu: Remove unneeded 64-bit dependency in arch_enter_from_user_mode()
      x86/cpu: Drop 32-bit Xen PV guest code in update_task_stack()
      x86/cpu: Remove X86_FEATURE_XENPV usage in setup_cpu_entry_area()
      x86/cpu: Switch to cpu_feature_enabled() for X86_FEATURE_XENPV
      x86/pat: Handle TDX guest PAT initialization
      x86/mtrr: Make message for disabled MTRRs more descriptive

Srinivas Pandruvada (1):
      x86/intel_epb: Set Alder Lake N and Raptor Lake P normal EPB

Tony W Wang-oc (1):
      x86/acpi/cstate: Optimize ARB_DISABLE on Centaur CPUs

 arch/x86/include/asm/cacheinfo.h         |  13 +++
 arch/x86/include/asm/cpuid.h             | 141 +++++++++++++++++++++++-
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/entry-common.h      |   4 +-
 arch/x86/include/asm/memtype.h           |   5 +-
 arch/x86/include/asm/msr-index.h         |   1 +
 arch/x86/include/asm/mtrr.h              |  16 +--
 arch/x86/include/asm/processor.h         | 133 +----------------------
 arch/x86/include/asm/switch_to.h         |   7 +-
 arch/x86/kernel/acpi/cstate.c            |  24 +++--
 arch/x86/kernel/cpu/amd.c                |   2 +-
 arch/x86/kernel/cpu/bugs.c               | 105 +++++++++---------
 arch/x86/kernel/cpu/cacheinfo.c          | 179 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c             |   2 +-
 arch/x86/kernel/cpu/hygon.c              |   2 +-
 arch/x86/kernel/cpu/intel_epb.c          |   7 +-
 arch/x86/kernel/cpu/mtrr/amd.c           |   8 +-
 arch/x86/kernel/cpu/mtrr/centaur.c       |   8 +-
 arch/x86/kernel/cpu/mtrr/cyrix.c         |  42 +-------
 arch/x86/kernel/cpu/mtrr/generic.c       | 107 ++----------------
 arch/x86/kernel/cpu/mtrr/mtrr.c          | 173 ++++-------------------------
 arch/x86/kernel/cpu/mtrr/mtrr.h          |  15 +--
 arch/x86/kernel/process_64.c             |   4 +-
 arch/x86/kernel/setup.c                  |  14 +--
 arch/x86/kernel/smpboot.c                |   9 +-
 arch/x86/kernel/topology.c               |   2 +-
 arch/x86/mm/cpu_entry_area.c             |   8 +-
 arch/x86/mm/pat/memtype.c                | 157 ++++++++++-----------------
 arch/x86/power/cpu.c                     |   3 +-
 include/linux/cpuhotplug.h               |   1 +
 30 files changed, 538 insertions(+), 662 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
