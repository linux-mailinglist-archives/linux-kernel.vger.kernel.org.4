Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962A874900E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjGEVoI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 17:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:44:07 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1121997;
        Wed,  5 Jul 2023 14:44:03 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qHAHp-0002CM-9g; Wed, 05 Jul 2023 23:43:45 +0200
Received: from p5b13aeb4.dip0.t-ipconnect.de ([91.19.174.180] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qHAHp-001d9k-26; Wed, 05 Jul 2023 23:43:45 +0200
Message-ID: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.5
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Jul 2023 23:43:44 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.174.180
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

I am being a little late this merge window since it took me a little longer
to thoroughly review the changes which address important issues in the DMA
and IRQ code in arch/sh.

The pull request includes a patch by me to fix a compiler warning in the J2
probing code and a fix by Sergey Shtylyov to avoid using IRQ0 on SH3 and SH4
targets. Masahiro Yamada made some clean-up in the build system to address
reports by the 0day bot.

The most notable changes come from Artur Rojek who addressed a number of issues
in the DMA code, in particular a fix for the DMA channel offset calculation that
was introduced in in 7f47c7189b3e ("sh: dma: More legacy cpu dma chainsawing.")
in 2012! Together with another change to correct the number of DMA channels for
each SuperH SoC according to specification, Artur's series unbreaks the kernel
on the SH7709 SoC allowing Linux to boot on the HP Jornada 680 handheld again.

Last but not least, Guenter Roeck sent in a patch to fix a build regression that
was recently introduced in 99b619b37ae1 ("mips: provide unxlate_dev_mem_ptr() in
asm/io.h").

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.5-tag1

for you to fetch changes up to 7497840d462c8f54c4888c22ab3726a8cde4b9a2:

  sh: Provide unxlate_dev_mem_ptr() in asm/io.h (2023-07-05 19:04:51 +0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.5

- sh: Provide unxlate_dev_mem_ptr() in asm/io.h
- sh: dma: Correct the number of DMA channels for SH7709
- sh: dma: Drop incorrect SH_DMAC_BASE1 definition for SH4
- sh: dma: Fix DMA channel offset calculation
- sh: Remove compiler flag duplication
- sh: Refactor header include path addition
- sh: Move build rule for cchips/hd6446x/ to arch/sh/Kbuild
- sh: Fix -Wmissing-include-dirs warnings for various platforms
- sh: Avoid using IRQ0 on SH3 and SH4
- sh: j2: Use ioremap() to translate device tree address into kernel memory

----------------------------------------------------------------
Artur Rojek (3):
      sh: dma: Fix DMA channel offset calculation
      sh: dma: Drop incorrect SH_DMAC_BASE1 definition for SH4
      sh: dma: Correct the number of DMA channels for SH7709

Guenter Roeck (1):
      sh: Provide unxlate_dev_mem_ptr() in asm/io.h

John Paul Adrian Glaubitz (1):
      sh: j2: Use ioremap() to translate device tree address into kernel memory

Masahiro Yamada (4):
      sh: Fix -Wmissing-include-dirs warnings for various platforms
      sh: Move build rule for cchips/hd6446x/ to arch/sh/Kbuild
      sh: Refactor header include path addition
      sh: Remove compiler flag duplication

Sergey Shtylyov (1):
      sh: Avoid using IRQ0 on SH3 and SH4

 arch/sh/Kbuild                                |  2 ++
 arch/sh/Makefile                              | 26 ++-----------------
 arch/sh/boards/Makefile                       | 19 ++++++++++++++
 arch/sh/drivers/dma/Kconfig                   | 14 +++++-----
 arch/sh/drivers/dma/dma-sh.c                  | 37 +++++++++++++++++----------
 arch/sh/include/asm/io.h                      |  1 +
 arch/sh/include/cpu-sh4/cpu/dma.h             |  1 -
 arch/sh/include/mach-common/mach/highlander.h |  2 +-
 arch/sh/include/mach-common/mach/r2d.h        |  2 +-
 arch/sh/include/mach-dreamcast/mach/sysasic.h |  2 +-
 arch/sh/include/mach-se/mach/se7724.h         |  2 +-
 arch/sh/kernel/cpu/sh2/probe.c                |  2 +-
 arch/sh/kernel/cpu/sh3/entry.S                |  4 +--
 include/linux/sh_intc.h                       |  6 ++---
 14 files changed, 66 insertions(+), 54 deletions(-)

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
