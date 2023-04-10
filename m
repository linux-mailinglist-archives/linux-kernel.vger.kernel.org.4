Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE96DCDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDJXLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJXLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:11:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675512118;
        Mon, 10 Apr 2023 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681168299; x=1712704299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QE/4HFRLSaCaZNxPkN+PUASZAUDopLFBbg+1/GEV4Fo=;
  b=XosQKnLAP/x9qtqF44TnXj68UzUu9H0f8Q5n3Ezqxm5cZZ38kl+0vv/6
   19oMGsRQ+9Z67wPAFRqxOKoH8DxO1f/1KENskhsW+vkjV7MdxW1lrolX4
   hopfStNkMw0ommjLxSJ2v7vfdOZRq4nts+qfbloO39n3d6ZvY5Je2/oJK
   0UBjTM1GYuMck/FnOKBz9bHk2tYX/GN1XhzihL0G9AU4EL8/JdFwGTOdO
   q4YFQJAgrKoLmCMBq670DFLkDd9UHjYtwZqWsf+JOs1r5t2U0cOOiyCNd
   I/GWJ4pNH7o4QbmTXIlq4Z0wXnv29rbFARe8Rc4NlLw7z9Y9f7scOch/c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340962482"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="340962482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 16:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757607987"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="757607987"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2023 16:11:38 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v6 00/12] x86: Support Key Locker
Date:   Mon, 10 Apr 2023 15:59:24 -0700
Message-Id: <20230410225936.8940-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112211258.21115-1-chang.seok.bae@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This feature enabling has been stalled due to the decryption
performance issue which took a while to result in a solution. There
was also a question on the userspace utility -- cryptsetup [6].

As posting this version, I wanted to make sure the resolutions are
acknowledgeable with these updates, at first:

* People identified a gap between encryption and decryption speeds
  [1, 2]. Intel has identified the root cause and will make a fix
  available. The fix will ensure that the encryption and decryption
  speeds are comparable with each other.

  This fix requires a microcode update and will go through a formal
  process of release toward the end of the year. As of now, listed
  below are the expected numbers [10] when the issue is fixed. Intel
  will provide the latest information on the request.

  +---------------------------+---------------+-----------------+
  |       Cipher              |   Encryption  |   Decryption    |
  |      (AES-XTS)            |    (MiB/s)    |   (MiB/s)       |
  +===========================+===============+=================+
  | Microcode version (0xa4)  |     1726.5    |      776.3      |
  +---------------------------+---------------+-----------------+
  | With the potential fix    |     2308.7    |     2305.9      |
  +---------------------------+---------------+-----------------+

  The benchmark results came from:
    $ cryptsetup benchmark -c aes-xts -s 256
  which are approximate using memory only (no storage IO).

  The fix is specific to the CPU model [8] which was measured when
  posting v3 [4]. Here is another results from the latest CPU [9]:

  +--------------+---------------+-----------------+
  | Cipher       |   Encryption  |   Decryption    |
  | (AES-XTS)    |    (MiB/s)    |   (MiB/s)       |
  +==============+===============+=================+
  | AES-NI       |     6738.7    |     6851.7      |
  +--------------+---------------+-----------------+
  | AES-KL       |     3425.4    |     3431.7      |
  +--------------+---------------+-----------------+

* Andy questioned the cryptsetup readiness to edit the cipher mode,
  e.g. AES-KL to AES-NI, for decrypting a keylocker-encrypted volume
  on non-keylocker systems [3].

  The cryptsetup changes were prototyped as a proof-of-concept. The
  code and test details can be found in this repository:

    git://github.com/intel-staging/keylocker.git cryptsetup

  Once the enabling code is accepted in the mainline, I will follow-up
  with the DM-crypt [7] folks to add this ability.

The feature is already available on recent Intel client systems. Its
usage along with the threat model and other details can be found in
the v3 cover letter [4].

The code has some updates from the last posting [5]:

- Fix the 'valid_kl' flag not to be set when the feature is disabled.
  This was reported by Marvin Hsu <marvin.hsu@intel.com>. Add the
  function comment about this. (Patch8)
- Improve the error handling in setup_keylocker(). All the error
  cases fall through the end that disables the feature. Otherwise,
  all the successful cases return immediately. (Patch8)
- Call out when disabling the feature on virtual machines. (Patch7)
- Ensure kernel_fpu_end() for the possible error (Patch10)
- Rebased on the upstream -- use the RET macro (Patch11/12)
- Clean up dead code -- cbc_crypt_common() (Patch10)
- Fix a typo (Patch1)

This series is based on the tip tree. The code is also available in
this repository:

  git://github.com/intel-staging/keylocker.git kl

Thanks to Charishma Gairuboyina and Lalithambika Krishnakumar for the
help to update the performance results.

Thanks,
Chang

[1]  https://lore.kernel.org/lkml/YbqRseO+TtuGQk5x@sol.localdomain/
[2]  https://lore.kernel.org/lkml/120368dc-e337-9176-936c-4db2a8bf710e@gmail.com/
[3]  https://lore.kernel.org/lkml/75ec3ad1-6234-ae1f-1b83-482793e4fd23@kernel.org/
[4]  v3: https://lore.kernel.org/lkml/20211124200700.15888-1-chang.seok.bae@intel.com/
[5]  v5: https://lore.kernel.org/lkml/20220112211258.21115-1-chang.seok.bae@intel.com/
[6]  cryptsetup: https://gitlab.com/cryptsetup/cryptsetup
[7]  DM-crypt: https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/dm-crypt.html
[8]  Tiger Lake:
     https://www.intel.com/content/www/us/en/products/docs/processors/embedded/11th-gen-product-brief.html
[9]  Raptor Lake:
     https://www.intel.com/content/www/us/en/newsroom/resources/13th-gen-core.html
[10] Intel publishes information about product performance at
     https://www.Intel.com/PerformanceIndex

Chang S. Bae (12):
  Documentation/x86: Document Key Locker
  x86/cpufeature: Enumerate Key Locker feature
  x86/insn: Add Key Locker instructions to the opcode map
  x86/asm: Add a wrapper function for the LOADIWKEY instruction
  x86/msr-index: Add MSRs for Key Locker internal wrapping key
  x86/keylocker: Define Key Locker CPUID leaf
  x86/cpu/keylocker: Load an internal wrapping key at boot-time
  x86/PM/keylocker: Restore internal wrapping key on resume from ACPI
    S3/4
  x86/cpu: Add a configuration and command line option for Key Locker
  crypto: x86/aes - Prepare for a new AES implementation
  crypto: x86/aes-kl - Support AES algorithm using Key Locker
    instructions
  crypto: x86/aes-kl - Support XTS mode

 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/keylocker.rst               |  98 +++
 arch/x86/Kconfig                              |   3 +
 arch/x86/crypto/Makefile                      |   5 +-
 arch/x86/crypto/aes-intel_asm.S               |  26 +
 arch/x86/crypto/aes-intel_glue.c              | 127 ++++
 arch/x86/crypto/aes-intel_glue.h              |  44 ++
 arch/x86/crypto/aeskl-intel_asm.S             | 633 ++++++++++++++++++
 arch/x86/crypto/aeskl-intel_glue.c            | 216 ++++++
 arch/x86/crypto/aesni-intel_asm.S             |  58 +-
 arch/x86/crypto/aesni-intel_glue.c            | 235 ++-----
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
 arch/x86/kernel/keylocker.c                   | 212 ++++++
 arch/x86/kernel/smpboot.c                     |   2 +
 arch/x86/lib/x86-opcode-map.txt               |  11 +-
 arch/x86/power/cpu.c                          |   2 +
 crypto/Kconfig                                |  36 +
 tools/arch/x86/lib/x86-opcode-map.txt         |  11 +-
 28 files changed, 1642 insertions(+), 214 deletions(-)
 create mode 100644 Documentation/x86/keylocker.rst
 create mode 100644 arch/x86/crypto/aes-intel_asm.S
 create mode 100644 arch/x86/crypto/aes-intel_glue.c
 create mode 100644 arch/x86/crypto/aes-intel_glue.h
 create mode 100644 arch/x86/crypto/aeskl-intel_asm.S
 create mode 100644 arch/x86/crypto/aeskl-intel_glue.c
 create mode 100644 arch/x86/crypto/aesni-intel_glue.h
 create mode 100644 arch/x86/include/asm/keylocker.h
 create mode 100644 arch/x86/kernel/keylocker.c


base-commit: b2e7ae549d84c654744bf70d30a881bfa140a6e3
-- 
2.17.1

