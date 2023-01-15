Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099B266B0CF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjAOLrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjAOLrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:47:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA1383EF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 03:47:04 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82D101EC042F;
        Sun, 15 Jan 2023 12:47:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673783223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=YPCuiaE055g9mi64rxAcWZLPpUh37N9riDGk1asu3RQ=;
        b=XNl7uEMPCDUExzlurGGoxXRUzfwnIoDNP3yKBh2oSpdi5wv4jgcR0ikSoDkQE2yO/U9Umv
        ME4EKhHscGIxYlA4omzbFkOJGMwnkud/tsqWoi8/W2prsACZ8Yj9BjzAyYzY82tpKmpoXW
        0Ro2HUrJlWVCyF7UKoUE4ldHcfuaVYY=
Date:   Sun, 15 Jan 2023 12:46:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.2-rc4
Message-ID: <Y8Pnsx1k3TN/GWlc@zn.tnic>
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

Thx.

---

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc4

for you to fetch changes up to 26ce6ec364f18d2915923bc05784084e54a5c4cc:

  x86/mm: fix poking_init() for Xen PV guests (2023-01-12 11:22:20 +0100)

----------------------------------------------------------------
- Make sure the poking PGD is pinned for Xen PV as it requires it this way

- Fixes for two resctrl races when moving a task or creating a new monitoring
  group

- Fix SEV-SNP guests running under HyperV where MTRRs are disabled to not return
  a UC- type mapping type on memremap() and thus cause a serious slowdown

- Fix insn mnemonics in bioscall.S now that binutils is starting to fix
  confusing insn suffixes

----------------------------------------------------------------
Juergen Gross (2):
      x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case
      x86/mm: fix poking_init() for Xen PV guests

Peter Newman (2):
      x86/resctrl: Fix task CLOSID/RMID update race
      x86/resctrl: Fix event counts regression in reused RMIDs

Peter Zijlstra (1):
      x86/boot: Avoid using Intel mnemonics in AT&T syntax asm

 arch/x86/boot/bioscall.S               |  4 +--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 49 +++++++++++++++++++++++-----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 ++++++++-
 arch/x86/mm/init.c                     |  4 +++
 arch/x86/mm/pat/memtype.c              |  3 ++-
 5 files changed, 52 insertions(+), 20 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
