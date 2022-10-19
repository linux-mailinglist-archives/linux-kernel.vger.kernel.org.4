Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3A260444A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiJSMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiJSL7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:59:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22E914D8C1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666179474; x=1697715474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=enPVCriAHpbY9aJu5B+Y9dtDkLWyR6WIVOpp3YAHcwc=;
  b=W6XL3TFC1xYjxOf84sFrb89Lw0BL10agmLYsFuuAyrwUdUsnI7uYxZ9L
   CzMLWm7TFUGJXJoa1yHWcgAXxJIqD7himSF86L0ztUaTB0Ap7i2oW4/+e
   VECeukAkxk8Tz1ie7NuPxmzTscIvS7F4p4lUKLvt5Ywr1ApyuSq67+UHs
   h8EGh/PH93Ts7JNx/CXpO+E+416eFCC17MLIOrT9ky1LPNNyVcr5o8aqb
   BLy1KTNUXfhMGvX5Cb2uHNPX+FSRRMBrWTtpBK9lgDBt8cTqPddNFzksC
   EU5SyqYbiqLkmeoTAuEYASwR0DZi3XuKG/QX/9GirxebEDkIdm7BWFqkd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="308054292"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="308054292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 03:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="692312605"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="692312605"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 19 Oct 2022 03:13:31 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com
Subject: [PATCH v4 0/5] Enable LKGS instruction
Date:   Wed, 19 Oct 2022 02:50:30 -0700
Message-Id: <20221019095035.10823-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 tools/arch/x86/include/asm/cpufeatures.h |  1 +
 tools/arch/x86/lib/x86-opcode-map.txt    |  1 +
 12 files changed, 76 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/include/asm/gsseg.h

-- 
2.34.1

