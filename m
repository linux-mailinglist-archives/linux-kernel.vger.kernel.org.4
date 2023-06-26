Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D5B73E729
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjFZSGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFZSGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:06:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399A7E58
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:06:38 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 945441EC041E;
        Mon, 26 Jun 2023 20:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687802796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=q3jz1QA3XKJ+Y5ftjP8jcSE1nX2X7LKmKRtsQU5ifnI=;
        b=cZGXNF9o+NYEO0BMuAnTurand9HMmheyCC/PL7qQIuU8u8gyhLzJUJCBnyRbTpT6r8Y3Az
        wmEjGBmGW5k36aFukaV3onIse6iA9oKiOfEsia3Y2ANCQ7RTjYTGU3ICSouw2a1nvLN0XF
        LChjOsL0ZYVUAr9OX0te/P6La0ol4kQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hnUUyI7ZX5pI; Mon, 26 Jun 2023 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687802793; bh=q3jz1QA3XKJ+Y5ftjP8jcSE1nX2X7LKmKRtsQU5ifnI=;
        h=Date:From:To:Cc:Subject:From;
        b=S0inrIPN6uYNFT5DBC5y8rmnW929eI3aDb9Flj60m/P/AKlDZ2KYeHDkMQcVA+lgY
         E8d5qHVPyBK/Kqxlbu05ZpgO8rZ486WqIUQIHsuIhyj7JD/XDZG+/owo/fY8sh+peu
         hahmj+oOrOMRahEBtVw1oziXAJkpXJEzIQlf5h31E2e84z+PTSK9PnW9cNj3fge/aT
         71DF/4podhSiC4bUDn0CrhjQf3HO5iuPCXa1JUPrFlWn/26u51fWxocnFA1YE05Y77
         nntHmDq7+53pOSPlPwEX/+xqAKfUft/IkjU4dd5nNCQZgJHbkxOrxRHEnhQaOEHXZb
         ROW0fTQTo9ZaLbGQg5o85jWqQ7Am78IRZAlj1MtKF7El1Qx53BRlygOkAeCvxxRVbk
         C+YGbEuChIZMqCbVIgtY+liE8oFRdK/eEmKnDG/8eiqMxnFfJDAcD3UjIbfUI9ta3L
         KiWU38r4Zt59bhmpud2Ksb08m8iK2rBs2BRw9IpLoXC52/51a+P5QlVpS2v+9ybxbI
         How4doFapzcP8PdEEwdCq5pLAddJRvIIe1XPY5dvyrPMsFDtcscAYVIYNY+YEfC4Lz
         G53ACYbvB3gkG7TKemk+3lEy6TxEVrjweutjJ3XFRxeVqRA6s/F6s3gGBmrQwBjKJT
         DA5QKkGOsNp+0MfZpPMQ7tlc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC3A540E0033;
        Mon, 26 Jun 2023 18:06:30 +0000 (UTC)
Date:   Mon, 26 Jun 2023 20:06:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cc for 6.5
Message-ID: <20230626180624.GJZJnToMIWeCuisF7L@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the unaccepted memory support for 6.5. This has been long in
the making but now is good to go.

Thx.

---

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cc_for_v6.5

for you to fetch changes up to 84b9b44b99780d35fe72ac63c4724f158771e898:

  virt: sevguest: Add CONFIG_CRYPTO dependency (2023-06-09 15:53:07 +0200)

----------------------------------------------------------------
- Add support for unaccepted memory as specified in the UEFI spec v2.9.
  The gist of it all is that Intel TDX and AMD SEV-SNP confidential
  computing guests define the notion of accepting memory before using it
  and thus preventing a whole set of attacks against such guests like
  memory replay and the like.

  There are a couple of strategies of how memory should be accepted
  - the current implementation does an on-demand way of accepting.

----------------------------------------------------------------
Arnd Bergmann (1):
      virt: sevguest: Add CONFIG_CRYPTO dependency

Dionna Glaze (1):
      x86/efi: Safely enable unaccepted memory in UEFI

Kirill A. Shutemov (9):
      mm: Add support for unaccepted memory
      efi/x86: Get full memory map in allocate_e820()
      efi/libstub: Implement support for unaccepted memory
      x86/boot/compressed: Handle unaccepted memory
      efi: Add unaccepted memory support
      efi/unaccepted: Avoid load_unaligned_zeropad() stepping into unaccepted memory
      x86/tdx: Make _tdx_hypercall() and __tdx_module_call() available in boot stub
      x86/tdx: Refactor try_accept_one()
      x86/tdx: Add unaccepted memory support

Tom Lendacky (5):
      x86/sev: Fix calculation of end address based on number of pages
      x86/sev: Put PSC struct on the stack in prep for unaccepted memory support
      x86/sev: Allow for use of the early boot GHCB for PSC requests
      x86/sev: Use large PSC requests if applicable
      x86/sev: Add SNP-specific unaccepted memory support

 arch/x86/Kconfig                                 |   4 +
 arch/x86/boot/compressed/Makefile                |   3 +-
 arch/x86/boot/compressed/efi.h                   |  10 +
 arch/x86/boot/compressed/error.c                 |  19 ++
 arch/x86/boot/compressed/error.h                 |   1 +
 arch/x86/boot/compressed/kaslr.c                 |  40 ++--
 arch/x86/boot/compressed/mem.c                   |  86 ++++++++
 arch/x86/boot/compressed/misc.c                  |   6 +
 arch/x86/boot/compressed/misc.h                  |  10 +
 arch/x86/boot/compressed/sev.c                   |  54 ++++-
 arch/x86/boot/compressed/sev.h                   |  23 ++
 arch/x86/boot/compressed/tdx-shared.c            |   2 +
 arch/x86/coco/tdx/Makefile                       |   2 +-
 arch/x86/coco/tdx/tdx-shared.c                   |  71 +++++++
 arch/x86/coco/tdx/tdx.c                          | 102 +--------
 arch/x86/include/asm/efi.h                       |   2 +
 arch/x86/include/asm/sev-common.h                |   9 +-
 arch/x86/include/asm/sev.h                       |  23 +-
 arch/x86/include/asm/shared/tdx.h                |  53 +++++
 arch/x86/include/asm/tdx.h                       |  21 +-
 arch/x86/include/asm/unaccepted_memory.h         |  27 +++
 arch/x86/kernel/sev-shared.c                     | 103 +++++++++
 arch/x86/kernel/sev.c                            | 256 ++++++++++-------------
 arch/x86/platform/efi/efi.c                      |   3 +
 drivers/base/node.c                              |   7 +
 drivers/firmware/efi/Kconfig                     |  14 ++
 drivers/firmware/efi/Makefile                    |   1 +
 drivers/firmware/efi/efi.c                       |  26 +++
 drivers/firmware/efi/libstub/Makefile            |   2 +
 drivers/firmware/efi/libstub/bitmap.c            |  41 ++++
 drivers/firmware/efi/libstub/efistub.h           |   6 +
 drivers/firmware/efi/libstub/find.c              |  43 ++++
 drivers/firmware/efi/libstub/unaccepted_memory.c | 222 ++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c          |  75 +++++--
 drivers/firmware/efi/unaccepted_memory.c         | 147 +++++++++++++
 drivers/virt/coco/sev-guest/Kconfig              |   1 +
 fs/proc/meminfo.c                                |   5 +
 include/linux/efi.h                              |  16 +-
 include/linux/mm.h                               |  19 ++
 include/linux/mmzone.h                           |   8 +
 mm/memblock.c                                    |   9 +
 mm/mm_init.c                                     |   7 +
 mm/page_alloc.c                                  | 173 +++++++++++++++
 mm/vmstat.c                                      |   3 +
 44 files changed, 1448 insertions(+), 307 deletions(-)
 create mode 100644 arch/x86/boot/compressed/mem.c
 create mode 100644 arch/x86/boot/compressed/sev.h
 create mode 100644 arch/x86/boot/compressed/tdx-shared.c
 create mode 100644 arch/x86/coco/tdx/tdx-shared.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h
 create mode 100644 drivers/firmware/efi/libstub/bitmap.c
 create mode 100644 drivers/firmware/efi/libstub/find.c
 create mode 100644 drivers/firmware/efi/libstub/unaccepted_memory.c
 create mode 100644 drivers/firmware/efi/unaccepted_memory.c



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
