Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81E65F2EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJCKpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJCKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:45:40 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0135072E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 03:45:34 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:d9a7:8e4b:c2c3:1759])
        by andre.telenet-ops.be with bizsmtp
        id TNlY2800227BRao01NlYJA; Mon, 03 Oct 2022 12:45:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ofIx1-000Yas-Ok; Mon, 03 Oct 2022 12:45:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ofIx1-00AE1R-8Z; Mon, 03 Oct 2022 12:45:31 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.1
Date:   Mon,  3 Oct 2022 12:45:29 +0200
Message-Id: <20221003104529.2437138-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.1-tag1

for you to fetch changes up to dc63a086daee92c63e392e4e7cd7ed61f3693026:

  m68k: Rework BI_VIRT_RNG_SEED as BI_RNG_SEED (2022-09-28 22:16:44 +0200)

----------------------------------------------------------------
m68k updates for v6.1

  - Fix forward secrecy of RNG seed boot record handling,
  - Make RNG seed boot record handling generic for all m68k platforms
    using bootinfo,
  - Defconfig updates,
  - Minor fixes and improvements.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v6.0-rc2

Greg Ungerer (1):
      m68k: Allow kexec on M68KCLASSIC with MMU enabled only

Jason A. Donenfeld (2):
      m68k: Process bootinfo records before saving them
      m68k: Rework BI_VIRT_RNG_SEED as BI_RNG_SEED

Wolfram Sang (1):
      m68k: Move from strlcpy with unused retval to strscpy

 arch/m68k/Kconfig                          |  2 +-
 arch/m68k/configs/amiga_defconfig          |  4 ++--
 arch/m68k/configs/apollo_defconfig         |  4 ++--
 arch/m68k/configs/atari_defconfig          |  4 ++--
 arch/m68k/configs/bvme6000_defconfig       |  4 ++--
 arch/m68k/configs/hp300_defconfig          |  4 ++--
 arch/m68k/configs/mac_defconfig            |  4 ++--
 arch/m68k/configs/multi_defconfig          |  4 ++--
 arch/m68k/configs/mvme147_defconfig        |  4 ++--
 arch/m68k/configs/mvme16x_defconfig        |  4 ++--
 arch/m68k/configs/q40_defconfig            |  4 ++--
 arch/m68k/configs/sun3_defconfig           |  4 ++--
 arch/m68k/configs/sun3x_defconfig          |  4 ++--
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  9 ++-------
 arch/m68k/include/uapi/asm/bootinfo.h      |  7 +++++++
 arch/m68k/kernel/setup_mm.c                | 19 ++++++++++++++++---
 arch/m68k/virt/config.c                    | 11 -----------
 17 files changed, 50 insertions(+), 46 deletions(-)

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
