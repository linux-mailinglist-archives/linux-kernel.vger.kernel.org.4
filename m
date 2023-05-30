Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FF9715DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjE3Lnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjE3LnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:43:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D571A8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685446977; x=1716982977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/j2XPaJaSpAAT2OLHC32nT72CyEZ0H84HViXrjePtvA=;
  b=d9VYvITYUWRSlwJqGNJxykM0OugTvZj90cTpusK6J7+RwRx08xZo4ca3
   FrSFknxgoR+CZSSzqZ5kyET5uKHZ6AHTBXsfxv7mMPQrk8lsVRq8N5wKN
   Zh7wZO1f6wa+k4UxQs6jmCSeAA1ELvBLfWeZ4KbmegMp0/9SH83+iQyQ7
   f+opmmU5fKi4nSOtQtx1B8egqOaCLiUpMsw5rCG+v4KOPDSfgN4Uv6r+o
   kloMWNkGidKMpfAbVYGJ2WAAYxWnDgYyjc8QmGB5S8tvmZwVIzHugbPAd
   0dGa2/7G2J23B7WunwCRowz7hXLcqDFrdsgFKdinhuyrXF0LBHL5RJlFc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="383145329"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383145329"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700588581"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="700588581"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2023 04:42:54 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 00/12] Enable Linear Address Space Separation support
Date:   Tue, 30 May 2023 14:42:35 +0300
Message-Id: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1[1]:
- Emulate vsyscall violations in execute mode in the #GP fault handler
- Use inline memcpy and memset while patching alternatives
- Remove CONFIG_X86_LASS
- Make LASS depend on SMAP
- Dropped the minimal KVM enabling patch

Linear Address Space Separation (LASS) is a security feature that intends to
prevent malicious virtual address space accesses across user/kernel mode.

Such mode based access protection already exists today with paging and features
such as SMEP and SMAP. However, to enforce these protections, the processor
must traverse the paging structures in memory.  Malicious software can use
timing information resulting from this traversal to determine details about the
paging structures, and these details may also be used to determine the layout
of the kernel memory.

The LASS mechanism provides the same mode-based protections as paging but
without traversing the paging structures. Because the protections enforced by
LASS are applied before paging, software will not be able to derive
paging-based timing information from the various caching structures such as the
TLBs, mid-level caches, page walker, data caches, etc. LASS can avoid probing
using double page faults, TLB flush and reload, and SW prefetch instructions.
See [2], [3] and [4] for some research on the related attack vectors.

LASS enforcement relies on the typical kernel implemetation to divide the
64-bit virtual address space into two halves:
  Addr[63]=0 -> User address space
  Addr[63]=1 -> Kernel address space
Any data access or code execution across address spaces typically results in a
#GP fault.

Kernel accesses usually only happen to the kernel address space. However, there
are valid reasons for kernel to access memory in the user half. For these cases
(such as text poking and EFI runtime accesses), the kernel can temporarily
suspend the enforcement of LASS by toggling SMAP (Supervisor Mode Access
Prevention) using the stac()/clac() instructions.

User space cannot access any kernel address while LASS is enabled.
Unfortunately, legacy vsyscall functions are located in the address range
0xffffffffff600000 - 0xffffffffff601000 and emulated in kernel.  To avoid
breaking user applications when LASS is enabled, extend the vsyscall emulation
in execute (XONLY) mode to the #GP fault handler.

In contrast, the vsyscall EMULATE mode is deprecated and not expected to be
used by anyone.  Supporting EMULATE mode with LASS would need complex
intruction decoding in the #GP fault handler and is probably not worth the
hassle. Disable LASS in this rare case when someone absolutely needs and
enables vsyscall=emulate via the command line.

As of now there is no publicly available CPU supporting LASS.  The first one to
support LASS would be the Sierra Forest line. The Intel Simics® Simulator was
used as software development and testing vehicle for this patch set.

[1] https://lore.kernel.org/lkml/20230110055204.3227669-1-yian.chen@intel.com/
[2] “Practical Timing Side Channel Attacks against Kernel Space ASLR”,
https://www.ieee-security.org/TC/SP2013/papers/4977a191.pdf
[3] “Prefetch Side-Channel Attacks: Bypassing SMAP and Kernel ASLR”, http://doi.acm.org/10.1145/2976749.2978356
[4] “Harmful prefetch on Intel”, https://ioactive.com/harmful-prefetch-on-intel/ (H/T Anders)

Alexander Shishkin (1):
  x86/vsyscall: Document the fact that vsyscall=emulate disables LASS

Peter Zijlstra (1):
  x86/asm: Introduce inline memcpy and memset

Sohil Mehta (9):
  x86/cpu: Enumerate the LASS feature bits
  x86/alternatives: Disable LASS when patching kernel alternatives
  x86/cpu: Enable LASS during CPU initialization
  x86/cpu: Remove redundant comment during feature setup
  x86/vsyscall: Reorganize the #PF emulation code
  x86/traps: Consolidate user fixups in exc_general_protection()
  x86/vsyscall: Add vsyscall emulation for #GP
  x86/vsyscall: Disable LASS if vsyscall mode is set to EMULATE
  [RFC] x86/efi: Disable LASS enforcement when switching to EFI MM

Yian Chen (1):
  x86/cpu: Set LASS CR4 bit as pinning sensitive

 .../admin-guide/kernel-parameters.txt         |  4 +-
 arch/x86/entry/vsyscall/vsyscall_64.c         | 70 ++++++++++++++-----
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/disabled-features.h      |  4 +-
 arch/x86/include/asm/smap.h                   |  4 ++
 arch/x86/include/asm/string_32.h              | 21 ++++++
 arch/x86/include/asm/string_64.h              | 21 ++++++
 arch/x86/include/asm/vsyscall.h               | 16 +++--
 arch/x86/include/uapi/asm/processor-flags.h   |  2 +
 arch/x86/kernel/alternative.c                 | 12 +++-
 arch/x86/kernel/cpu/common.c                  | 10 ++-
 arch/x86/kernel/cpu/cpuid-deps.c              |  1 +
 arch/x86/kernel/traps.c                       | 12 ++--
 arch/x86/mm/fault.c                           | 13 +---
 arch/x86/platform/efi/efi_64.c                |  6 ++
 tools/arch/x86/include/asm/cpufeatures.h      |  1 +
 16 files changed, 153 insertions(+), 45 deletions(-)

-- 
2.39.2

