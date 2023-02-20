Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047BB69D2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjBTS0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjBTS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:26:34 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA121C31A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:26:33 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 632821EC04CC;
        Mon, 20 Feb 2023 19:26:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676917592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=1ms2JWYgerTx86Xa7nkcTBP58I8olNgMgYOQi6dhvRw=;
        b=hqbj/G+SoFg83XSNQNsO3PqbGW+WoF6hU2MMBxIdoWS8hN92pNWfi2kkZvR4dUgZt21i3o
        OPHCWD2teQxlxboQcDZ04rbaN+aWDLHc8+NPe4snYcx3AqSehOX3yc3NugO+rKLN59GlOe
        nFfolc8cuN1QJQXuQbP2cnpLBcOABt4=
Date:   Mon, 20 Feb 2023 19:26:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/vdso for v6.3-rc1
Message-ID: <Y/O7WByYDrjPy6sC@zn.tnic>
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

please pull a bunch of x86 vdso improvements for 6.3.

Thx.

---

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vdso_for_v6.3_rc1

for you to fetch changes up to dac0da428f8dfb23666ab4ea54a7768c152b857a:

  x86/vdso: Fix -Wmissing-prototypes warnings (2023-02-07 18:23:17 +0100)

----------------------------------------------------------------
- Add getcpu support for the 32-bit version of the vDSO

- Some smaller fixes

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/vdso: Fix -Wmissing-prototypes warnings

Brian Gerst (1):
      x86/vdso: Move VDSO image init to vdso2c generated code

Sebastian Andrzej Siewior (4):
      x86/cpu: Provide the full setup for getcpu() on x86-32
      x86/vdso: Provide getcpu for x86-32.
      selftests: Emit a warning if getcpu() is missing on 32bit
      x86/vdso: Fake 32bit VDSO build on 64bit compile for vgetcpu

 arch/x86/entry/vdso/Makefile                  |  3 ++-
 arch/x86/entry/vdso/vdso2c.h                  |  6 ++++++
 arch/x86/entry/vdso/vdso32-setup.c            |  9 ---------
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h | 25 +++++++++++++++++++++++++
 arch/x86/entry/vdso/vdso32/vclock_gettime.c   | 27 +--------------------------
 arch/x86/entry/vdso/vdso32/vdso32.lds.S       |  1 +
 arch/x86/entry/vdso/vdso32/vgetcpu.c          |  3 +++
 arch/x86/entry/vdso/vgetcpu.c                 |  3 +--
 arch/x86/entry/vdso/vma.c                     | 19 ++++---------------
 arch/x86/include/asm/processor.h              |  1 -
 arch/x86/include/asm/segment.h                |  8 ++++----
 arch/x86/include/asm/vdso.h                   |  2 +-
 arch/x86/include/asm/vdso/gettimeofday.h      |  2 ++
 arch/x86/include/asm/vdso/processor.h         |  4 ++++
 arch/x86/kernel/cpu/common.c                  |  5 +----
 tools/testing/selftests/x86/test_vsyscall.c   |  7 ++-----
 16 files changed, 57 insertions(+), 68 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vdso32/fake_32bit_build.h
 create mode 100644 arch/x86/entry/vdso/vdso32/vgetcpu.c

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
