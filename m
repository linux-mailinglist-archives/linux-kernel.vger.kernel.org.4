Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5BF7210D6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjFCPfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFCPfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 11:35:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB65123;
        Sat,  3 Jun 2023 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685806503; x=1717342503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7lmNG17/a8qDsi0tYtEOKJtLTD3wuHzdHs4MXb+C0eE=;
  b=TjAcRsLgd1cdS8xxL1lsVz50ogiEnpe2ATUQvbULFWg8lvqGWiE0b9lq
   KJjJ5Btdc0itQoCCNs211G53B/qoiJ/iKfh00leH1oSEVV87tgQtTuryI
   TEp2+sePgNhEJebQL5NUjEVoc/OglMJiPd/MDuUppb4Gw4m6TFH9tH8fn
   RwkffJAT/jGkbUz7FPTAYV1E1cV9JS6hDUfffvIXZk2PU2WNSe/ODDg3+
   5kbm1XgnindSuY8bE6dhE3ESV7a+03sQtLT+gX7UraCuIPb5v7S+UyjGN
   iESZkl4bPj0HQispj/zuYUfpYWC0Sca4RTX+D2qbbejOGymMV5V8vIukD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="356097295"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="356097295"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 08:35:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="702274222"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="702274222"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2023 08:35:00 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        chang.seok.bae@intel.com
Subject: [PATCH v8 00/12] x86: Support Key Locker
Date:   Sat,  3 Jun 2023 08:22:15 -0700
Message-Id: <20230603152227.12335-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230524165717.14062-1-chang.seok.bae@intel.com>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Posting V8 here, a brief status of this enabling:

The last two revisions trend to update the crypto code mainly. The
existing AEX-XTS code was improved further before being shared with
the new code. Then, the new implementation was tuned for the AES-XTS
mode which aligns with the claimed use case -- dm-crypt.

But, I'd say some additional change might be still needed.

The overall changes in charge of the last review:

  * PATCH12:
    - Clarify some documentation (Eric Biggers)
    - Simplify (Eric Biggers) and cleanup code

  * PATCH11:
    - Remove dead code.

  * PATCH10:
    - Deduplicate the alignment code (Eric Biggers)

The series can be found in this repo:
    git://github.com/intel-staging/keylocker.git kl-v8

The overall diff was populated in:
    https://raw.githubusercontent.com/intel-staging/keylocker/diff/kl-v8-vs-v7.diff

The feature is already available on recent Intel client systems. The
V3 cover letter covered the usage, the threat model and other details:
    https://lore.kernel.org/lkml/20211124200700.15888-1-chang.seok.bae@intel.com/

And the V6 cover followed up with updating the performance data:
    https://lore.kernel.org/lkml/20230410225936.8940-1-chang.seok.bae@intel.com/

V7 posting:
    https://lore.kernel.org/lkml/20230524165717.14062-1-chang.seok.bae@intel.com/

Thanks,
Chang

Chang S. Bae (12):
  Documentation/x86: Document Key Locker
  x86/cpufeature: Enumerate Key Locker feature
  x86/insn: Add Key Locker instructions to the opcode map
  x86/asm: Add a wrapper function for the LOADIWKEY instruction
  x86/msr-index: Add MSRs for Key Locker wrapping key
  x86/keylocker: Define Key Locker CPUID leaf
  x86/cpu/keylocker: Load a wrapping key at boot-time
  x86/PM/keylocker: Restore the wrapping key on the resume from ACPI
    S3/4
  x86/cpu: Add a configuration and command line option for Key Locker
  crypto: x86/aesni - Use the proper data type in struct aesni_xts_ctx
  crypto: x86/aes - Prepare for a new AES-XTS implementation
  crypto: x86/aes-kl - Implement the AES-XTS algorithm

 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/arch/x86/index.rst              |   1 +
 Documentation/arch/x86/keylocker.rst          |  97 +++
 arch/x86/Kconfig                              |   3 +
 arch/x86/crypto/Kconfig                       |  22 +
 arch/x86/crypto/Makefile                      |   3 +
 arch/x86/crypto/aes-helper_asm.S              |  22 +
 arch/x86/crypto/aes-helper_glue.h             | 161 +++++
 arch/x86/crypto/aeskl-intel_asm.S             | 552 ++++++++++++++++++
 arch/x86/crypto/aeskl-intel_glue.c            | 188 ++++++
 arch/x86/crypto/aesni-intel_asm.S             |  55 +-
 arch/x86/crypto/aesni-intel_glue.c            | 241 +++-----
 arch/x86/crypto/aesni-intel_glue.h            |  16 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/keylocker.h              |  45 ++
 arch/x86/include/asm/msr-index.h              |   6 +
 arch/x86/include/asm/special_insns.h          |  32 +
 arch/x86/include/uapi/asm/processor-flags.h   |   2 +
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/cpu/common.c                  |  21 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/keylocker.c                   | 212 +++++++
 arch/x86/kernel/smpboot.c                     |   2 +
 arch/x86/lib/x86-opcode-map.txt               |  11 +-
 arch/x86/power/cpu.c                          |   2 +
 tools/arch/x86/lib/x86-opcode-map.txt         |  11 +-
 27 files changed, 1507 insertions(+), 211 deletions(-)
 create mode 100644 Documentation/arch/x86/keylocker.rst
 create mode 100644 arch/x86/crypto/aes-helper_asm.S
 create mode 100644 arch/x86/crypto/aes-helper_glue.h
 create mode 100644 arch/x86/crypto/aeskl-intel_asm.S
 create mode 100644 arch/x86/crypto/aeskl-intel_glue.c
 create mode 100644 arch/x86/crypto/aesni-intel_glue.h
 create mode 100644 arch/x86/include/asm/keylocker.h
 create mode 100644 arch/x86/kernel/keylocker.c


base-commit: 054377e4774eee812b7930933d7a354ed5a7ddd6
-- 
2.17.1

