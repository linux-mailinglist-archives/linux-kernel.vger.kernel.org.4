Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD570FC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjEXRKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjEXRKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:10:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F81130;
        Wed, 24 May 2023 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684948217; x=1716484217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=81gnBmdY+U7xfe837vfBU6KLieNoX+Gj0y/Y+DROwhg=;
  b=hitSJlfoQ6ozM0Kk9By08uqIP67yKbFdm7BtijsNJgFI/HSPciFCaX8P
   fm0odnw1V2q6qopYp4+uzHDhGBl2gDJtkVlVTLKUKPJ4SFdCvrtJ+FzUc
   +XKiYKUDADZSiw7CBjRlq46B/7zsonZfoWeK4CvAXm9KLvkjCYdjdCsSk
   XnkyQky2HIwSQ+d6EOEPMXNNp3n3emFqtM1W4X0BMh2ZfdIqSeuwYHvK/
   YC+qxSyngoybx4NDKnFLaZK/GPocM5seoa/KPXtjHdRvnSeX/eqS/1bue
   2mOFN1axdI1RVWu8E83Pe3qxpo730viM7a3TLxtIkIUrgSbFJO3yp/CmK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338206637"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="338206637"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:09:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="704427331"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="704427331"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2023 10:09:49 -0700
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
Subject: [PATCH v7 00/12] x86: Support Key Locker
Date:   Wed, 24 May 2023 09:57:05 -0700
Message-Id: <20230524165717.14062-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410225936.8940-1-chang.seok.bae@intel.com>
References: <20230410225936.8940-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The previous posting [v6] was intended to deliver the hardware
performance update primarily by revamping the old series. Then,
multiple feedbacks were received. This revision thus incorporates the
changes to address them. So, the primary goal here is to meet those
reviewers' expectations at first.

The series has two parts of changes -- the x86 core and its crypto
library. In this revision, much more changes were made on the latter.
Also, overall changelogs were revisited to be more reviewable.

Here is the overview of those feedbacks/changes (skip some trivial):

Part 1. Crypto Library (PATCH10-12):

  PATCH12: AES-KL driver
  - Merge all the AES-KL patches. (Eric Biggers)
  - Make the driver for the 64-bit mode only. (Eric Biggers)
  - Rework the key-size check code (Eric Biggers)
  - Adjust the Kconfig change (Robert Elliott)
  - Update the changelog. (Eric Biggers)
  - Adjust the ASM code to return a proper error code. (Eric Biggers)

  PATCH11: AES-NI rework
  - Inline the helper code to avoid the indirect call. (Eric Biggers)
  - Rename the filename: aes-intel* -> aes-helper*. (Eric Biggers)
  - Don't export symbols yet here. Instead, do it when needed later.
  - Improve the coding style (Eric Biggers)

  PATCH10: the AESNI-XTS field type fix
  - Add as a new patch. (Eric Biggers)

Part 2. The X86 Core (PATCH1-9):

  PATCH09: a chicken bit and a Kconfig option
  - Rebase on the upstream: commit a894a8a56b57 ("Documentation:
    kernel-parameters: sort all "no..." parameters")

  PATCH08: the wrapping key recovery
  - Limit the symbol export only when needed.

  PATCH07: the wrapping key load at boot-time
  - Use memzero_explicit() instead of memset(). (Robert Elliott)
  - Improve the function prototype. (Eric Biggers and Dave Hansen)

  PATCH01: documentation
  - Rebase on the upstream -- commit ff61f0791ce9 ("docs: move x86
    documentation into Documentation/arch/"). (Nathan Huckleberry)

This version can be also found here:
    git://github.com/intel-staging/keylocker.git kl-v7

[v6] -- the last posting:
    https://lore.kernel.org/lkml/20230410225936.8940-1-chang.seok.bae@intel.com/

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
  crypto: x86/aes - Prepare for a new AES implementation
  crypto: x86/aes-kl - Implement the AES-XTS algorithm

 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/arch/x86/index.rst              |   1 +
 Documentation/arch/x86/keylocker.rst          |  97 +++
 arch/x86/Kconfig                              |   3 +
 arch/x86/crypto/Kconfig                       |  22 +
 arch/x86/crypto/Makefile                      |   3 +
 arch/x86/crypto/aes-helper_asm.S              |  22 +
 arch/x86/crypto/aes-helper_glue.h             | 161 +++++
 arch/x86/crypto/aeskl-intel_asm.S             | 580 ++++++++++++++++++
 arch/x86/crypto/aeskl-intel_glue.c            | 216 +++++++
 arch/x86/crypto/aesni-intel_asm.S             |  55 +-
 arch/x86/crypto/aesni-intel_glue.c            | 242 +++-----
 arch/x86/crypto/aesni-intel_glue.h            |  17 +
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
 27 files changed, 1573 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/arch/x86/keylocker.rst
 create mode 100644 arch/x86/crypto/aes-helper_asm.S
 create mode 100644 arch/x86/crypto/aes-helper_glue.h
 create mode 100644 arch/x86/crypto/aeskl-intel_asm.S
 create mode 100644 arch/x86/crypto/aeskl-intel_glue.c
 create mode 100644 arch/x86/crypto/aesni-intel_glue.h
 create mode 100644 arch/x86/include/asm/keylocker.h
 create mode 100644 arch/x86/kernel/keylocker.c


base-commit: 3a128547bd4425cdef27c606efc88e1eb03a2dba
-- 
2.17.1

