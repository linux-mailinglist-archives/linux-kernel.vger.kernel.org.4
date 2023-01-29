Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA5667FF71
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 14:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjA2NkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjA2Nj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:39:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD01E9E3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 05:39:44 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E932A1EC0513;
        Sun, 29 Jan 2023 14:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674999579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=S3E6d9bggce99ZWFbZqTLHy0NqUgzppz5mF+ID7UngE=;
        b=edBMKuJW9KpqldI2iKRcOWXcPGZwm7rNOt72wioCvU7kmiGOoNJ9u50uU/n7M4qrDEEMnX
        7aVZPJcpr5vi6AWPKs0dDfR2qSecr8AGZPnkkjClQIawGkzYee+BWIowG6Ip+xzhRrFhwf
        t/zroLHsB7UOBTAkpPAIoXA9QqTPsqY=
Date:   Sun, 29 Jan 2023 14:39:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.2-rc6
Message-ID: <Y9Z3FMceYzCQ1IXA@zn.tnic>
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

please pull a bunch of urgent x86 fixes for 6.2.

The SEV-SNP patch looks a bit largish and perhaps, at a first glance, not really
urgent material but the intent behind it is to fail gracefully when booting
older kernels on newer hypervisors when latter support features which those
older kernels do not know of yet.

Therefore, it should go to stable so sending it now is as good a time as any.

Please pull,
thanks.

---

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc6

for you to fetch changes up to 27b5de622ea3fe0ad5a31a0ebd9f7a0a276932d1:

  x86/build: Move '-mindirect-branch-cs-prefix' out of GCC-only block (2023-01-22 11:36:45 +0100)

----------------------------------------------------------------
- Start checking for -mindirect-branch-cs-prefix clang support too now that LLVM
  16 will support it

- Fix a NULL ptr deref when suspending with Xen PV

- Have a SEV-SNP guest check explicitly for features enabled by the hypervisor
  and fail gracefully if some are unsupported by the guest instead of failing in
  a non-obvious and hard-to-debug way

- Fix a MSI descriptor leakage under Xen

- Mark Xen's MSI domain as supporting MSI-X

- Prevent legacy PIC interrupts from being resent in software by marking them
  level triggered, as they should be, which lead to a NULL ptr deref

----------------------------------------------------------------
David Woodhouse (1):
      x86/pci/xen: Set MSI_FLAG_PCI_MSIX support in Xen MSI domain

Juergen Gross (1):
      acpi: Fix suspend with Xen PV

Nathan Chancellor (1):
      x86/build: Move '-mindirect-branch-cs-prefix' out of GCC-only block

Nikunj A Dadhania (1):
      x86/sev: Add SEV-SNP guest feature negotiation support

Thomas Gleixner (2):
      x86/i8259: Mark legacy PIC interrupts with IRQ_LEVEL
      x86/pci/xen: Fixup fallout from the PCI/MSI overhaul

 Documentation/x86/amd-memory-encryption.rst | 36 +++++++++++++++
 arch/x86/Makefile                           |  2 +-
 arch/x86/boot/compressed/ident_map_64.c     |  6 +++
 arch/x86/boot/compressed/misc.h             |  2 +
 arch/x86/boot/compressed/sev.c              | 70 +++++++++++++++++++++++++++++
 arch/x86/include/asm/acpi.h                 |  8 ++++
 arch/x86/include/asm/msr-index.h            | 20 +++++++++
 arch/x86/include/uapi/asm/svm.h             |  6 +++
 arch/x86/kernel/i8259.c                     |  1 +
 arch/x86/kernel/irqinit.c                   |  4 +-
 arch/x86/pci/xen.c                          |  2 +
 drivers/acpi/sleep.c                        |  6 ++-
 12 files changed, 160 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
