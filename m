Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB18763AE60
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiK1RFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiK1REa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:04:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F2E644E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669655060; x=1701191060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+YkMR1rZQaFpNvTpwd9EMap2roQ2lgOxzhGZkaSG75Q=;
  b=dkDtTeYaWjDeE0S+ktMxo59GgGT+L+OjOdOqxbrn2bmzYL3bJhl5X0rX
   7Hg4jXBrsnZpemsSlwPhblJuyu2FLpu+wvrFUuKvlGv01Mz8x65s/D+1K
   IPYUNsSqdm8eSf/4BmAYJPlvVqxuEvYkLKmZMSW0RffVxyuTuywvbtFpB
   dpg3MAn3W+w339cvM3+P9QbxCU2q05Du5U1zvxPcHEwYKYVhrhrG2uqjn
   uw1KjIY1QFBXJScjsDO5PSM3R0BNv0cHx7M04yR+2fgJ62g/Q63yfBoMT
   qxN1GjyGsJp31XWijQckLhl7AZfHWNaLIHnGs63H+yJzIk/IPr2S0nw17
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313591609"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313591609"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="706864616"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="706864616"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 28 Nov 2022 09:04:19 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: [PATCH v5 0/5] x86: Enable LKGS instruction
Date:   Mon, 28 Nov 2022 08:40:23 -0800
Message-Id: <20221128164028.4570-1-xin3.li@intel.com>
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
delivery) specification https://cdrdv2.intel.com/v1/dl/getContent/678938.

LKGS is independent of FRED, so we enable it as a standalone CPU feature.

LKGS behaves like the MOV to GS instruction except that it loads the base
address into the IA32_KERNEL_GS_BASE MSR instead of the GS segment’s
descriptor cache, which is exactly what Linux kernel does to load user level
GS base.  Thus, with LKGS, there is no need to SWAPGS away from the kernel
GS base.

Changes since v4:
* Clear the LKGS feature from Xen PV guests (Juergen Gross).

Changes since v3:
* We want less ASM not more, thus keep local_irq_save/restore() inside
  native_load_gs_index() (Thomas Gleixner).
* For paravirt enabled kernels, initialize pv_ops.cpu.load_gs_index to
  native_lkgs (Thomas Gleixner).

Changes since V2:
* Add "" not to show "lkgs" in /proc/cpuinfo (Chang S. Bae).
* Mark DI as input and output (+D) as in V1, since the exception handler
  modifies it (Brian Gerst).

Changes since V1:
* Use EX_TYPE_ZERO_REG instead of fixup code in the obsolete .fixup code
  section (Peter Zijlstra).
* Add a comment that states the LKGS_DI macro will be repalced with "lkgs %di"
  once the binutils support the LKGS instruction (Peter Zijlstra).

H. Peter Anvin (Intel) (5):
  x86/cpufeature: add the cpu feature bit for LKGS
  x86/opcode: add the LKGS instruction to x86-opcode-map
  x86/gsseg: make asm_load_gs_index() take an u16
  x86/gsseg: move load_gs_index() to its own new header file
  x86/gsseg: use the LKGS instruction if available for load_gs_index()

 arch/x86/entry/entry_64.S                |  2 +-
 arch/x86/ia32/ia32_signal.c              |  1 +
 arch/x86/include/asm/cpufeatures.h       |  1 +
 arch/x86/include/asm/gsseg.h             | 66 ++++++++++++++++++++++++
 arch/x86/include/asm/mmu_context.h       |  1 +
 arch/x86/include/asm/special_insns.h     | 21 --------
 arch/x86/kernel/cpu/common.c             |  1 +
 arch/x86/kernel/paravirt.c               |  1 +
 arch/x86/kernel/tls.c                    |  1 +
 arch/x86/lib/x86-opcode-map.txt          |  1 +
 arch/x86/xen/enlighten_pv.c              |  1 +
 tools/arch/x86/include/asm/cpufeatures.h |  1 +
 tools/arch/x86/lib/x86-opcode-map.txt    |  1 +
 13 files changed, 77 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/include/asm/gsseg.h

-- 
2.34.1

