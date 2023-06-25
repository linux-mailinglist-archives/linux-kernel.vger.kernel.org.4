Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2634A73CFE5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjFYJ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjFYJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:56:58 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39D122;
        Sun, 25 Jun 2023 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687687011; bh=JmY7+0q0b02U7ojD4bGBn1BjJD3l/ocHesTOn1m7IrI=;
        h=From:To:Cc:Subject:Date:From;
        b=lHIcLxRV31EO3XLmjR57RObdIkhRhuqSV2daXGxGFdzr8Iq414L25wr36nILZt/A4
         du8ASRcbnj7gwij3zaksxQ6syzFfBkKbh8MlbUPcWi/gTPsCkF4weuH1pBVs2AZ8qY
         G3xuhbtKwTsTGOY5lRByH+6EIf/nYiv/WcQbrNpk=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 127CD600B5;
        Sun, 25 Jun 2023 17:56:50 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH v3 0/8] LoongArch: Preliminary ClangBuiltLinux enablement
Date:   Sun, 25 Jun 2023 17:56:36 +0800
Message-Id: <20230625095644.3156349-1-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Hi,

It's been a long time since the LoongArch port was upstreamed to LLVM,
and there seems to be evidence that Linux was successfully built with
Clang inside Loongson roughly around that time; however, a lot has
changed since then, and the Linux/LoongArch codebase now makes use of
more novel features that necessitate further work. (The enablement work
is tracked at [1].)

With this patch series and a patched LLVM/Clang/LLD ([2][3][4][5]), a
working kernel can be built with `make LLVM=1`. Although currently
support for CONFIG_RELOCATABLE and CONFIG_MODULE is still TODO, we've
decided to post the series early to hopefully reduce the rebase
burden. The series contains several useful cleanups anyway.

Regarding how to merge this: because only Patch 8 is outside
arch/loongarch, I'd prefer the series to get merged through Huacai's
tree. The series applies cleanly on top of next-20230622.

Thanks go to the ClangBuiltLinux team, and LoongArch toolchain
maintainers from Loongson and the community alike; without your help
this would come much later, if at all (my free time has been steadily
dwindling this year already).

Your comments are welcome!

[1]: https://github.com/ClangBuiltLinux/linux/issues/1787
[2]: https://reviews.llvm.org/D153609
[3]: https://reviews.llvm.org/D138135
[4]: https://reviews.llvm.org/D150196
[5]: https://reviews.llvm.org/D153707

Changes in v3:

- Squashed the two CFLAGS patches into one, and removed the CC_IS_CLANG
  check in favor of a feature detection approach (Huacai and Ruoyao)
- Removed unnecessary BUILD_BUG_ONs in the invtlb wrappers, and made
  them __always_inline (Ruoyao and Bibo)
- Linked to the explanation regarding the Clang triple's "libc" part
  (Nick)
- Fixed a wrong punctuation in commit message of Patch 4

Changes in v2:

- Merged the two FCSR-related patches, now using the same approach for
  assembly and C (given that the inline asm codepath cannot be removed
  right away), also change terminology: register "class" instead of
  "bank"
- Restored signatures of invtlb wrappers for ease of rebase (potentially
  downstream product kernels?)
- Removed -G0 switches altogether (turned out it's useless upon closer
  look)
- Fix -mabi and -msoft-float handling in the CFLAGS patch; two more LLVM
  patches are now necessary (the [4] and [5] links above) but the
  original and correct CFLAGS arrangement now works

WANG Rui (2):
  LoongArch: Calculate various sizes in the linker script
  LoongArch: extable: Also recognize ABI names of registers

WANG Xuerui (6):
  LoongArch: Prepare for assemblers with proper FCSR class support
  LoongArch: Make the CPUCFG and CSR ops simple aliases of compiler
    built-ins
  LoongArch: Simplify the invtlb wrappers
  LoongArch: Tweak CFLAGS for Clang compatibility
  LoongArch: Mark Clang LTO as working
  Makefile: Add loongarch target flag for Clang compilation

 arch/loongarch/Kconfig                 |  5 ++
 arch/loongarch/Makefile                | 21 +++++---
 arch/loongarch/include/asm/fpregdef.h  |  7 +++
 arch/loongarch/include/asm/gpr-num.h   | 30 +++++++++++
 arch/loongarch/include/asm/loongarch.h | 72 +++++++-------------------
 arch/loongarch/include/asm/percpu.h    |  6 ++-
 arch/loongarch/include/asm/tlb.h       | 43 +++++++--------
 arch/loongarch/kernel/efi-header.S     |  6 +--
 arch/loongarch/kernel/head.S           |  8 +--
 arch/loongarch/kernel/traps.c          |  2 +-
 arch/loongarch/kernel/vmlinux.lds.S    |  7 +++
 arch/loongarch/lib/dump_tlb.c          |  6 +--
 arch/loongarch/vdso/Makefile           |  2 +-
 scripts/Makefile.clang                 |  1 +
 14 files changed, 118 insertions(+), 98 deletions(-)

-- 
2.40.0

