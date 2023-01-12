Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2CE666BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbjALHoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjALHoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:44:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6723E3F45B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673509461; x=1705045461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5bdLaL9GU2RwLB3Lz5X0TADw/y+Uxo5/E0WnDJifRaI=;
  b=S9S05tsiMu9tHCITP0SKQSN9m3gGqNCbzNMGjLglO7CLIOSlZSluebFE
   i7AJUjJseQ9GJWWvsiN/hLDoIrMlLDx4gHiHnOxGQ2JpMvJazbEzoH+Zn
   ZsqGZygyVl/jjCr+Gqf+28bU6U59FeQOB/PUIAfHIdCYhkWRJCyF+GcNN
   fR68FbFZEDl375ZlwOOmvH2KvcyRRCd9mO/9uXIgun8+rG+h3TtUCDFAN
   HO84AZ4zHwEv3H53C044eI+GAEj6v93mix9jymqayPiYQbalkSsn0wphW
   NcDU8NNV9MZGCNW8ApNNDj8EJsmNHh0AkkcmI8H+naid681YdS/wsa5M5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321328667"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="321328667"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:44:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="635283900"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="635283900"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga006.jf.intel.com with ESMTP; 11 Jan 2023 23:44:20 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: [PATCH v6 0/5] x86: Enable LKGS instruction
Date:   Wed, 11 Jan 2023 23:20:27 -0800
Message-Id: <20230112072032.35626-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKGS instruction is introduced with Intel FRED (flexible return and event
delivery) specification. As LKGS is independent of FRED, we enable it as
a standalone CPU feature.

LKGS behaves like the MOV to GS instruction except that it loads the base
address into the IA32_KERNEL_GS_BASE MSR instead of the GS segment’s
descriptor cache, which is exactly what Linux kernel does to load user level
GS base.  Thus, with LKGS, there is no need to SWAPGS away from the kernel
GS base.

Changes since v5:
* Recommend to search for the latest FRED spec instead of providing
  a FRED spec URL, which is likely to be unstable (Borislav Petkov).
* Remove reviewers' SOBs (Borislav Petkov).

Changes since v4:
* Clear the LKGS feature from Xen PV guests (Juergen Gross).

Changes since v3:
* We want less ASM not more, thus keep local_irq_{save,restore}() inside
  native_load_gs_index() (Thomas Gleixner).
* For paravirt enabled kernels, initialize pv_ops.cpu.load_gs_index to
  native_lkgs (Thomas Gleixner).

Changes since v2:
* Add "" not to show "lkgs" in /proc/cpuinfo (Chang S. Bae).
* Mark DI as input and output (+D) as in v1, since the exception handler
  modifies it (Brian Gerst).

Changes since v1:
* Use EX_TYPE_ZERO_REG instead of fixup code in the obsolete .fixup code
  section (Peter Zijlstra).
* Add a comment that states the LKGS_DI macro will be replaced with "lkgs %di"
  once the binutils support the LKGS instruction (Peter Zijlstra).

H. Peter Anvin (Intel) (5):
  x86/cpufeature: add the cpu feature bit for LKGS
  x86/opcode: add the LKGS instruction to x86-opcode-map
  x86/gsseg: make asm_load_gs_index() take an u16
  x86/gsseg: move load_gs_index() to its own new header file
  x86/gsseg: use the LKGS instruction if available for load_gs_index()

 arch/x86/entry/entry_64.S                |  2 +-
 arch/x86/include/asm/cpufeatures.h       |  1 +
 arch/x86/include/asm/gsseg.h             | 66 ++++++++++++++++++++++++
 arch/x86/include/asm/mmu_context.h       |  1 +
 arch/x86/include/asm/special_insns.h     | 21 --------
 arch/x86/kernel/cpu/common.c             |  1 +
 arch/x86/kernel/paravirt.c               |  1 +
 arch/x86/kernel/signal_32.c              |  1 +
 arch/x86/kernel/tls.c                    |  1 +
 arch/x86/lib/x86-opcode-map.txt          |  1 +
 arch/x86/xen/enlighten_pv.c              |  1 +
 tools/arch/x86/include/asm/cpufeatures.h |  1 +
 tools/arch/x86/lib/x86-opcode-map.txt    |  1 +
 13 files changed, 77 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/include/asm/gsseg.h

-- 
2.34.1

