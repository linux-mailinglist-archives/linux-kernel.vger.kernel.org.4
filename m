Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBEB64B79D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiLMOmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiLMOma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:42:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884F2035C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:42:29 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB9881EC06D9;
        Tue, 13 Dec 2022 15:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670942548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=2/YHTH1z8aQnJmokEIXMyvC5DfxjhIA5wP2OyBsYsKU=;
        b=oXKPGCIImKZ0U+2HCiepeE1+9JVCKBz7Qx4z9QwMOV099oE9ROlNvSHVyl7nofTo26Y+rQ
        zFoPmYLswV11soxwWb7VHSQkGS7L4VotMcYD/6yv/Bb5P8vgj+HRPF036uh5p2uRjtHkoK
        q1RlPppT5iKcKAH2FVcJugd3lNpPBew=
Date:   Tue, 13 Dec 2022 15:42:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for v6.2
Message-ID: <Y5iPT6W7GkNx5qai@zn.tnic>
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

please pull a pile of x86/microcode fixes for 6.2.

The IFS stuff goes through tip because the IFS driver uses the same
structures and similar functionality as the microcode loader and it made
sense to route it all through this branch so that there are no conflicts.

Thx.

---

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.2

for you to fetch changes up to be1b670f61443aa5d0d01782e9b8ea0ee825d018:

  x86/microcode/intel: Do not retry microcode reloading on the APs (2022-12-05 21:22:21 +0100)

----------------------------------------------------------------
- Add support for multiple testing sequences to the Intel In-Field Scan
driver in order to be able to run multiple different test patterns.
Rework things and remove the BROKEN dependency so that the driver can be
enabled (Jithu Joseph)

- Remove the subsys interface usage in the microcode loader because it
is not really needed

- A couple of smaller fixes and cleanups

----------------------------------------------------------------
Ashok Raj (3):
      platform/x86/intel/ifs: Add metadata support
      x86/microcode/intel: Do not print microcode revision and processor flags
      x86/microcode/intel: Do not retry microcode reloading on the APs

Borislav Petkov (5):
      x86/microcode: Rip out the subsys interface gunk
      x86/microcode: Simplify init path even more
      x86/microcode: Kill refresh_fw
      x86/microcode: Do some minor fixups
      x86/microcode: Drop struct ucode_cpu_info.valid

Jithu Joseph (16):
      platform/x86/intel/ifs: Remove unused selection
      platform/x86/intel/ifs: Return a more appropriate error code
      platform/x86/intel/ifs: Remove image loading during init
      platform/x86/intel/ifs: Remove memory allocation from load path
      x86/microcode/intel: Reuse find_matching_signature()
      x86/microcode/intel: Use appropriate type in microcode_sanity_check()
      x86/microcode/intel: Reuse microcode_sanity_check()
      x86/microcode/intel: Add hdr_type to intel_microcode_sanity_check()
      x86/microcode/intel: Use a reserved field for metasize
      platform/x86/intel/ifs: Use generic microcode headers and functions
      platform/x86/intel/ifs: Add metadata validation
      platform/x86/intel/ifs: Remove reload sysfs entry
      platform/x86/intel/ifs: Add current_batch sysfs entry
      Documentation/ABI: Update IFS ABI doc
      Revert "platform/x86/intel/ifs: Mark as BROKEN"
      platform/x86/intel/ifs: Add missing kernel-doc entry

 Documentation/ABI/testing/sysfs-platform-intel-ifs |  30 +--
 arch/x86/include/asm/cpu.h                         |   2 +
 arch/x86/include/asm/microcode.h                   |   4 +-
 arch/x86/include/asm/microcode_intel.h             |   5 +-
 arch/x86/kernel/cpu/intel.c                        | 144 +++++++++++++-
 arch/x86/kernel/cpu/microcode/amd.c                |   5 +-
 arch/x86/kernel/cpu/microcode/core.c               | 205 ++++---------------
 arch/x86/kernel/cpu/microcode/intel.c              | 165 ++--------------
 drivers/platform/x86/intel/ifs/Kconfig             |   4 -
 drivers/platform/x86/intel/ifs/core.c              |  23 ++-
 drivers/platform/x86/intel/ifs/ifs.h               |  30 ++-
 drivers/platform/x86/intel/ifs/load.c              | 218 ++++++++++++---------
 drivers/platform/x86/intel/ifs/runtest.c           |  10 +-
 drivers/platform/x86/intel/ifs/sysfs.c             |  41 ++--
 14 files changed, 410 insertions(+), 476 deletions(-)



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
