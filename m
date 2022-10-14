Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A365FED47
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJNLlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJNLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:41:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B71BE1E2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:41:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mpkxl1STpz4x1G;
        Fri, 14 Oct 2022 22:41:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1665747707;
        bh=2CAXROmdXXHnzNjRew8XdikNXQgXjSxX5epQMzVUkgM=;
        h=From:To:Cc:Subject:Date:From;
        b=TLtHq9LnOVtJzTL4fSS/iWYAdVooPFHmAd0/2hX5wtLyCj5P0mdQPVr7HI+9w6+Z4
         SrNu3DRZBEq1eCvS719/jaQtoYlg4kWdnO5HeMcFlrG7zhyTocksSJyet1cGT7Brky
         0CWEZVNh6YRcnWBc4VXDR1b1NXXc8RCo8nB0GSMDlDM1LW7UEauNxz7XzWic9ut/Ux
         bEajJVj1L1HYzLdBi11noVahuPEAq+5UfKEzgS+ZCKsNyJ8LIxB2TgtMW6BsBpHCkm
         DOmJvO07DU6Kw12PV3v79usgo0oZgvsGHku9RMYdozRd63Ybns6MMir7QB04o0PqGz
         TqRHKK1a9lnKw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-2 tag
Date:   Fri, 14 Oct 2022 22:41:42 +1100
Message-ID: <874jw6my2x.fsf@mpe.ellerman.id.au>
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

Please pull powerpc fixes for 6.1:

The following changes since commit ae5b6779fa8724628bbad58126a626d0cd599414:

  powerpc: Fix 85xx build (2022-10-11 10:13:34 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-2

for you to fetch changes up to 90d5ce82e143b42b2fdfb95401a89f86b71cedb7:

  powerpc/pseries: Fix CONFIG_DTL=n build (2022-10-13 22:30:07 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.1 #2

 - Fix 32-bit syscall wrappers with 64-bit arguments of unaligned register-pairs.
   Notably this broke ftruncate64 & pread/write64, which can lead to file corruption.

 - Fix lost interrupts when returning to soft-masked context on 64-bit.

 - Fix build failure when CONFIG_DTL=n.

Thanks to: Nicholas Piggin, Jason A. Donenfeld, Guenter Roeck, Arnd Bergmann, Sachin Sant.

- ------------------------------------------------------------------
Nicholas Piggin (3):
      powerpc/32: fix syscall wrappers with 64-bit arguments of unaligned register-pairs
      powerpc/64s/interrupt: Fix lost interrupts when returning to soft-masked context
      powerpc/pseries: Fix CONFIG_DTL=n build


 arch/powerpc/include/asm/syscalls.h      |  16 +++
 arch/powerpc/kernel/Makefile             |   1 +
 arch/powerpc/kernel/interrupt_64.S       |  15 +-
 arch/powerpc/kernel/sys_ppc32.c          |  38 +++--
 arch/powerpc/kernel/syscalls/syscall.tbl |  16 ++-
 arch/powerpc/platforms/pseries/Makefile  |   3 +-
 arch/powerpc/platforms/pseries/dtl.c     | 151 ++++++++++----------
 7 files changed, 149 insertions(+), 91 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmNJSsUACgkQUevqPMjh
pYBBOg//aOMrUh9f40AMV7EOln4mk8c28nrpbl2JOIJ0CHuEbD4RJOTD/1Ndfg/2
5p/zR5Dz3T7NgZtwOM0Zyokl1OV4o76riwq3DR4eYDlclYNErOsv0OLFcsx4mymn
gfqRrMf8DIVu7dyGBRK9JY+zXFswa0pYlctnDC6Ron2D1/eQtLrMVpGGuXs3QKR5
nsqssaD/0lyQqG6K4vCk5pKx53fNi3uGiN1mjBAwVkAwy7xFvSoedQ3xg7UtE69j
ee2tBFQAHHLgkcXX50wlQSiry5lH+FAbgiXJhNsf6YrwwJ11Hs6llVAVO+X6olQv
h3STKbkCcP6HG1ZAq/+0w8ivzJ7EbqOG3h9lDDCp5kmK5D4uO8DPs6+lBEhcjPmf
DeVM+AiUCCNzc2NNw8Q94HO8YTQRa/5o2VIbNPXdVvowJkBFNbdrOH/uiJx/FXBw
+x2nMvWu/PwQCR9//Sju/71ULm+qKhw/p8IAarTBRGLG+HF1Drm/aCcxX00INcNI
mbrUoR8fHDtVI6osdI0hjMrAyyuYGS8Bqg55J/O4aOz3AwhiI8JRennA6zLrKm/a
KADqIdMvhwmH+hjLZPUoLjQf/WbjJUt17IXtBWEv8kZB/tmdeXr/7Cn/IEGaMFDg
MuDL5aMkS/Y7Ve784+etgG8f8H04HrW4PuZSL71iltaF5eg2R0U=
=UegA
-----END PGP SIGNATURE-----
