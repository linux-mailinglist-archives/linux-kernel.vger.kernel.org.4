Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCF5FA418
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJJTXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJJTXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:23:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48512606AB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665429830; x=1696965830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wCdIkn+YX+UrU1fyn+gV+Wg4I8SspZqEi7jGk4S7OMU=;
  b=MqudZyg61TD5ao1AxAPCyQ1ybqqd++EuErIdMDwehuAGO2rqqGuUsfHf
   qIEJsmeGado8oyXgUurjcPAW53U2vuJ5bPNeA9eiodgzrFroeIZlmwXBR
   FPQkGZkmYCxTGoA/xWxKWWA494MUdyO0ezC3rdts1g997BZNSwbG3uNdL
   4TfyGwhFwVnyaTKKINvpjpIaOsSzT35N+v29x4ZtGpr1+JCgQt7OGf95w
   CcqIfqsb48EDvjrSv7aK7wa/e7ji0PjlJNl/L0y7tRN/K7mcvnMrk/NEa
   NvcCrG3ylQEEdHmjRepllQgjhJ4rNbpZpm262v48t5/XFTH3HlFaivJQS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284044526"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="284044526"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 12:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="694762686"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="694762686"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2022 12:23:49 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org
Subject: [PATCH v2 0/6] Enable LKGS instruction
Date:   Mon, 10 Oct 2022 12:01:53 -0700
Message-Id: <20221010190159.11920-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Changes since V1:
* place fixup code into code section "__ex_table" instead of the obsoleted
  "fixup" section.
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
 arch/x86/include/asm/gsseg.h             | 57 ++++++++++++++++++++++++
 arch/x86/include/asm/mmu_context.h       |  1 +
 arch/x86/include/asm/special_insns.h     | 21 ---------
 arch/x86/kernel/paravirt.c               |  1 +
 arch/x86/kernel/tls.c                    |  1 +
 arch/x86/lib/x86-opcode-map.txt          |  1 +
 tools/arch/x86/include/asm/cpufeatures.h |  1 +
 tools/arch/x86/lib/x86-opcode-map.txt    |  1 +
 11 files changed, 87 insertions(+), 27 deletions(-)
 create mode 100644 arch/x86/include/asm/gsseg.h

-- 
2.34.1

