Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6461A5FE32F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJMUXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMUXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:23:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE49159D4B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665692609; x=1697228609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R7Qd0Li0XI3dC/Bl+p4w1MNx6lbZg4XfSLdkdmtczLg=;
  b=Oqnmny3Xk21wbc7zDqN3vAtTG+EXuVFFwf8QJy3fSsnR7JWS6W0NF3cC
   VjU0qj6f2NLuCy1Tzp8vCL9oqIukkWXio2LJyOc0tI6Dc6dC5KrGnxuqA
   bvdvLKOHnLo15jdcyfmul1De7KahrsxX4GGSTkz8EEUZhddsI8TgsRCx3
   hNjMJYhabmEuF2q5dJvz4C4dqEpN52jZkuudagImZpwAT2HfXGDtDa/WX
   yXXdGVAQtED7Yysa/Hj8JhUMqlyIdZcttAEDewpB/Imrhl0th0Jm07Dnc
   MS15quH0k6TC9Ozgkkk77JknWbZidsJ//FptPI0ik3fOqy3+G6LHp4F5G
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="302808940"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="302808940"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 13:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="690271036"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="690271036"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 13 Oct 2022 13:23:26 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com
Subject: [PATCH v3 0/6] Enable LKGS instruction
Date:   Thu, 13 Oct 2022 13:01:28 -0700
Message-Id: <20221013200134.1487-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Changes since V2:
* add "" not to show "lkgs" in /proc/cpuinfo.
* mark DI as input and output (+D) as in V1, since the exception handler
  modifies it.

Changes since V1:
* use EX_TYPE_ZERO_REG instead of fixup code in the obsolete .fixup code
  section.
* add a comment that states the LKGS_DI macro will be repalced with "lkgs %di"
  once the binutils support LKGS instruction.

H. Peter Anvin (Intel) (6):
  x86/cpufeature: add cpu feature bit for LKGS
  x86/opcode: add LKGS instruction to x86-opcode-map
  x86/gsseg: make asm_load_gs_index() take an u16
  x86/gsseg: move local_irq_save/restore() into asm_load_gs_index()
  x86/gsseg: move load_gs_index() to its own header file
  x86/gsseg: use the LKGS instruction if available for load_gs_index()

 arch/x86/entry/entry_64.S                | 28 +++++++++---
 arch/x86/ia32/ia32_signal.c              |  1 +
 arch/x86/include/asm/cpufeatures.h       |  1 +
 arch/x86/include/asm/gsseg.h             | 56 ++++++++++++++++++++++++
 arch/x86/include/asm/mmu_context.h       |  1 +
 arch/x86/include/asm/special_insns.h     | 21 ---------
 arch/x86/kernel/paravirt.c               |  1 +
 arch/x86/kernel/tls.c                    |  1 +
 arch/x86/lib/x86-opcode-map.txt          |  1 +
 tools/arch/x86/include/asm/cpufeatures.h |  1 +
 tools/arch/x86/lib/x86-opcode-map.txt    |  1 +
 11 files changed, 86 insertions(+), 27 deletions(-)
 create mode 100644 arch/x86/include/asm/gsseg.h

-- 
2.34.1

