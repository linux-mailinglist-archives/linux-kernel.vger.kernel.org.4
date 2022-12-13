Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA764B4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiLMMMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiLMMMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:12:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA117431
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:11:52 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B53591EC049C;
        Tue, 13 Dec 2022 13:11:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670933510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=X5lcL7DyuNwTH+ORfD5m65hr2g7vZ4p3O+iUlWkudm0=;
        b=asbHmtPuHS+spOHhvhidvZutTfzEBR1T7cOiWjUG5brf7ZfbBouKVLSzdsgce6TrOxaZ7q
        m1HqtIFh00LvRvAdDSKbbwJPKeCGJ/p8dL4IfsZp2VyatNOdUsd2YiiOhDyfZiKe1Y5eop
        ltmNqzkDGGWsQcVndPO+uqDh/hneqUU=
Date:   Tue, 13 Dec 2022 13:11:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/boot for v6.2
Message-ID: <Y5hqkAfK7okjRh6n@zn.tnic>
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

please pull a pile of early boot cleanups and fixes for 6.2.

Thx.

---

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_boot_for_v6.2

for you to fetch changes up to 60253f100c5846029f1370e51be6ebaeb160dcec:

  x86/boot: Remove x86_32 PIC using %ebx workaround (2022-11-29 16:26:53 +0100)

----------------------------------------------------------------
- Do some spring cleaning to the compressed boot code by moving the
EFI mixed-mode code to a separate compilation unit, the AMD memory
encryption early code where it belongs and fixing up build dependencies.
Make the deprecated EFI handover protocol optional with the goal of
removing it at some point (Ard Biesheuvel)

- Skip realmode init code on Xen PV guests as it is not needed there

- Remove an old 32-bit PIC code compiler workaround

----------------------------------------------------------------
Ard Biesheuvel (17):
      x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S
      x86/boot/compressed: Move 32-bit entrypoint code into .text section
      x86/boot/compressed: Move bootargs parsing out of 32-bit startup code
      x86/boot/compressed: Move efi32_pe_entry into .text section
      x86/boot/compressed: Move efi32_entry out of head_64.S
      x86/boot/compressed: Move efi32_pe_entry() out of head_64.S
      x86/boot/compressed, efi: Merge multiple definitions of image_offset into one
      x86/boot/compressed: Simplify IDT/GDT preserve/restore in the EFI thunk
      x86/boot/compressed: Avoid touching ECX in startup32_set_idt_entry()
      x86/boot/compressed: Pull global variable reference into startup32_load_idt()
      x86/boot/compressed: Move startup32_load_idt() into .text section
      x86/boot/compressed: Move startup32_load_idt() out of head_64.S
      x86/boot/compressed: Move startup32_check_sev_cbit() into .text
      x86/boot/compressed: Move startup32_check_sev_cbit() out of head_64.S
      x86/boot/compressed: Adhere to calling convention in get_sev_encryption_bit()
      x86/boot/compressed: Only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
      x86/efi: Make the deprecated EFI handover protocol optional

Juergen Gross (1):
      x86/boot: Skip realmode init code when running as Xen PV guest

Uros Bizjak (1):
      x86/boot: Remove x86_32 PIC using %ebx workaround

 arch/x86/Kconfig                        |  17 ++
 arch/x86/boot/compressed/Makefile       |   8 +-
 arch/x86/boot/compressed/efi_mixed.S    | 351 ++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/efi_thunk_64.S | 195 ------------------
 arch/x86/boot/compressed/head_32.S      |   4 -
 arch/x86/boot/compressed/head_64.S      | 303 ++-------------------------
 arch/x86/boot/compressed/mem_encrypt.S  | 152 ++++++++++++--
 arch/x86/boot/cpuflags.c                |  15 +-
 arch/x86/boot/header.S                  |   2 +-
 arch/x86/boot/tools/build.c             |   2 +
 arch/x86/include/asm/realmode.h         |   1 +
 arch/x86/include/asm/x86_init.h         |   4 +
 arch/x86/kernel/setup.c                 |   2 +-
 arch/x86/kernel/x86_init.c              |   3 +
 arch/x86/realmode/init.c                |   8 +-
 arch/x86/xen/enlighten_pv.c             |   2 +
 drivers/firmware/efi/libstub/x86-stub.c |   2 +-
 17 files changed, 553 insertions(+), 518 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi_mixed.S
 delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
