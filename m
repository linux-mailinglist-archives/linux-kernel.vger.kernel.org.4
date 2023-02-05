Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAAC68ADE9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjBEBXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjBEBXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:23:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72855DBD9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 17:23:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P8WqQ1B86z4xG5;
        Sun,  5 Feb 2023 12:23:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1675560194;
        bh=+S+S6flET8zT5WTMl8b0//zYmEAC41UnRzFrIe5j+eA=;
        h=From:To:Cc:Subject:Date:From;
        b=Y9WMHSnJBCuOqidZGw9ThWGyzWJxP3cfWbg9WDBOe/RlKInYwdrj7VsqjEz7ZTXpH
         vAzn+xEIrOlOXDjOdM7SM1LLfhu8HUcpDEUQii/LLwBOWcKwIFK/w3Hhhnx+u+b39C
         VEU8TCQHt8oUdy36lAGULLNBFYWDUQuGIoyR0qwoq5pqBdb5FDItTtrUofYMum82bA
         Hn5ceY3oHHDYpOhtGp5IeeLbVZXSdBacnC/05xjzK2hhGbUzTWzkgYUAvqjyfT7oFV
         uK3NOyqDGBcaY/w0IySRDfjtqEyA6ecKnAGQco4h17SILjhCZkzQXRhN4J0uHUtf2w
         GdIk50dnwYpJQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, sourabhjain@linux.ibm.com, sv@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-4 tag
Date:   Sun, 05 Feb 2023 12:23:13 +1100
Message-ID: <87y1pcewhq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.2.

It's a bit of a big batch for rc6, but just because I didn't send any fixes the last week
or two while I was on vacation, next week should be quieter.

cheers

The following changes since commit f12cd06109f47c2fb4b23a45ab55404c47ef7fae:

  powerpc/64s/hash: Make stress_hpt_timer_fn() static (2023-01-12 10:53:37 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-4

for you to fetch changes up to 1665c027afb225882a5a0b014c45e84290b826c2:

  powerpc/64s: Reconnect tlb_flush() to hash__tlb_flush() (2023-02-02 13:25:47 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.2 #4

 - Fix a few objtool warnings since we recently enabled objtool.

 - Fix a deadlock with the hash MMU vs perf record.

 - Fix perf profiling of asynchronous interrupt handlers.

 - Revert the IMC PMU nest_init_lock to being a mutex.

 - Two commits fixing problems with the kexec_file FDT size estimation.

 - Two commits fixing problems with strict RWX vs kernels running at non-zero.

 - Reconnect tlb_flush() to hash__tlb_flush()

Thanks to: Kajol Jain, Nicholas Piggin, Sachin Sant Sathvika Vasireddy, Sourabh Jain.

- ------------------------------------------------------------------
Michael Ellerman (5):
      powerpc/imc-pmu: Revert nest_init_lock to being a mutex
      powerpc/kexec_file: Fix division by zero in extra size estimation
      powerpc/64s/radix: Fix crash with unaligned relocated kernel
      powerpc/64s/radix: Fix RWX mapping with relocated kernel
      powerpc/64s: Reconnect tlb_flush() to hash__tlb_flush()

Nicholas Piggin (2):
      powerpc/64s: Fix local irq disable when PMIs are disabled
      powerpc/64: Fix perf profiling asynchronous interrupt handlers

Sathvika Vasireddy (2):
      powerpc/85xx: Fix unannotated intra-function call warning
      powerpc/kvm: Fix unannotated intra-function call warning

Sourabh Jain (1):
      powerpc/kexec_file: Count hot-pluggable memory in FDT estimate


 arch/powerpc/include/asm/book3s/64/tlbflush.h |  2 +
 arch/powerpc/include/asm/hw_irq.h             | 43 ++++++++++++++------
 arch/powerpc/kernel/dbell.c                   |  2 +-
 arch/powerpc/kernel/head_85xx.S               |  3 +-
 arch/powerpc/kernel/irq.c                     |  2 +-
 arch/powerpc/kernel/time.c                    |  2 +-
 arch/powerpc/kexec/file_load_64.c             | 11 +++--
 arch/powerpc/kvm/booke.c                      |  5 +--
 arch/powerpc/mm/book3s64/radix_pgtable.c      | 24 +++++++++++
 arch/powerpc/perf/imc-pmu.c                   | 14 +++----
 10 files changed, 77 insertions(+), 31 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmPfBM8ACgkQUevqPMjh
pYAFDQ/8CgBQ+Cf7q1yNm35L+IjA2kLub392pXEPVFf5+81hdib8VdSdLVsngXwZ
e7bwbId16xzLVGB3MDm8MqokCxwWcd3n8RjCMKal408c1qqcdlLHEi52MmQK2e2W
CIfGM5HbrqlEy8y4IfHQZ5W8DdjVh+8EzlfIMYJyyLB6508o1G9BB0ToFo/VtrZH
pB2cnXKLpthZ18l9n6t5z49rSOLukndwJif7Dloi8nTkz4NJ+uD8g1eQEQtiXPmC
KkBc19HWvHkHYGGg6nHCT0nvUEJ6jY4RBzTTyJnRdSrZwMACwiCqHS4p1EoKuU1+
kC7SN2VpJDSpGpxGItxPA+GgtaPuwWy/bY9ffEbRI46qpS2J/W2ChcAPhhdE1roY
IBIPD/p3hiAJNBtK4tpsv0hoErPnOIVKgsAsgKy/4dxojElCGGXn2FqbdFfOmp4u
Vh8vy6ploiiuQZjLB/znNyzD72jjqfyNPAaT05rLIgnAYdOnFYHm7KLoEyxL48gj
nxsDmXen8JWuVvRMpA7magZ4MHmjJ5GOaZfjqEM5d0nFIuQErlYyztQ88QfMX7Gu
TW92hAFe6F5d5FNbN+AG4l/qr6fHJ96ViIED1q+2zNj+Uh/JTMTHk0b/BuSM+6u+
SNeQrlqksha1OlgGtxb5fskdly8lPVytPXgCrWjuvU8K/jaqQN8=
=kk/e
-----END PGP SIGNATURE-----
