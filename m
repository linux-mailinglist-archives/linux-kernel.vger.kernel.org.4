Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611806ED0BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjDXOzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:55:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0485235AC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:55:08 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 759681EC01E0;
        Mon, 24 Apr 2023 16:55:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682348107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=RMVSpyKcePMAXubBNzaH8kvv2ei3Xony3FQ7Nm/nZVc=;
        b=c8sfRkukLktGEBRzcuG+WlLsPMlMUkymfTqEXBqsisgYF9Uz1BcsTZMtxrT/WtV3eguqt7
        9v/YHrTt5YOMQMxtmyet/UEeXGZXgXWJGXJvnIaQym9s+1OzxNHgVNri6CeyOkBKKej4cA
        79Xr8AxCT3/lzckx2josmGK6nS16l7I=
Date:   Mon, 24 Apr 2023 16:55:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev updates for v6.4-rc1
Message-ID: <20230424145507.GGZEaYS0KOeYeXHYns@fat_crate.local>
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

please pull a bunch of x86 SEV and x86-SEV-related updates for 6.4.

Thx.

---

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.4_rc1

for you to fetch changes up to 812b0597fb4043240724e4c7bed7ba1fe15c0e3f:

  x86/hyperv: Change vTOM handling to use standard coco mechanisms (2023-03-27 09:31:43 +0200)

----------------------------------------------------------------
- Add the necessary glue so that the kernel can run as a confidential
  SEV-SNP vTOM guest on Hyper-V. A vTOM guest basically splits the
  address space in two parts: encrypted and unencrypted. The use case
  being running unmodified guests on the Hyper-V confidential computing
  hypervisor

- Double-buffer messages between the guest and the hardware PSP device
  so that no partial buffers are copied back'n'forth and thus potential
  message integrity and leak attacks are possible

- Name the return value the sev-guest driver returns when the hw PSP
  device hasn't been called, explicitly

- Cleanups

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      crypto: ccp: Get rid of __sev_platform_init_locked()'s local function pointer

Dionna Glaze (2):
      virt/coco/sev-guest: Double-buffer messages
      x86/sev: Change snp_guest_issue_request()'s fw_err argument

Michael Kelley (6):
      x86/ioremap: Add hypervisor callback for private MMIO mapping in coco VM
      x86/hyperv: Reorder code to facilitate future work
      Drivers: hv: Explicitly request decrypted in vmap_pfn() calls
      x86/mm: Handle decryption/re-encryption of bss_decrypted consistently
      init: Call mem_encrypt_init() after Hyper-V hypercall init is done
      x86/hyperv: Change vTOM handling to use standard coco mechanisms

Peter Gonda (1):
      crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

 Documentation/virt/coco/sev-guest.rst   |  20 +++--
 arch/x86/coco/core.c                    |  40 ++++++---
 arch/x86/hyperv/hv_init.c               |  11 ---
 arch/x86/hyperv/ivm.c                   | 142 +++++++++++++++++++++-----------
 arch/x86/include/asm/coco.h             |   1 -
 arch/x86/include/asm/mem_encrypt.h      |   1 +
 arch/x86/include/asm/mshyperv.h         |  16 ++--
 arch/x86/include/asm/sev-common.h       |   4 -
 arch/x86/include/asm/sev.h              |  10 ++-
 arch/x86/include/asm/x86_init.h         |   4 +
 arch/x86/kernel/apic/io_apic.c          |  10 ++-
 arch/x86/kernel/cpu/mshyperv.c          |  15 ++--
 arch/x86/kernel/sev.c                   |  15 ++--
 arch/x86/kernel/x86_init.c              |   2 +
 arch/x86/mm/ioremap.c                   |   5 ++
 arch/x86/mm/mem_encrypt_amd.c           |  10 ++-
 arch/x86/mm/pat/set_memory.c            |   3 -
 drivers/crypto/ccp/sev-dev.c            |  22 +++--
 drivers/hv/ring_buffer.c                |   2 +-
 drivers/hv/vmbus_drv.c                  |   1 -
 drivers/virt/coco/sev-guest/sev-guest.c |  99 +++++++++++++---------
 include/asm-generic/mshyperv.h          |   2 +
 include/uapi/linux/psp-sev.h            |   7 ++
 include/uapi/linux/sev-guest.h          |  18 +++-
 init/main.c                             |  19 +++--
 25 files changed, 311 insertions(+), 168 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
