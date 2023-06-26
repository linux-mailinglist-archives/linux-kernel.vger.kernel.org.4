Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3999C73E006
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFZNCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFZNCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:02:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0841B1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:02:00 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25CFE1EC0644;
        Mon, 26 Jun 2023 15:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687784519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=uWephuvSJy+v5Wm4KFhe6gjjKrevmg6FvJwZKHDThn4=;
        b=MufrYZF+9USiAGpfdxKaxjKXtxe17jhtliC2mikewcKc0/umuTizNEkW4wNX5BG5dh7HdZ
        GUjQ8bIt62yxCGWGbrZOrlCk/PF3gq/AZtebkrFvmpRyO0EpYALC9dTzATCi4bxQWGU8nO
        F+NGz7pcdtfGMgBhGSPxD2iPs6pSUo8=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cV6YFkJ_rlx6; Mon, 26 Jun 2023 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687784492; bh=uWephuvSJy+v5Wm4KFhe6gjjKrevmg6FvJwZKHDThn4=;
        h=Date:From:To:Cc:Subject:From;
        b=V+VTV0UNjBnqT44M0jiqjs4s7LTgq5b1lVAtzERmke28LUOVGY12PEAF4GCx2Zxii
         d05F4U5G/8q2Efslxfpi7y972cpIEK6EIilVL/w0NGosFPPRnDf07CdFC5j+4nT+YP
         oY9jAjRAzrR3t2t8ngD1SVs4FVFF+vIq08HvFcc92lWVn9HmnRkh8BOhDdsq0EU8EQ
         F/6KBfa6RECSPU03zd0JjG56VfLWxvtrYJYeg5Aldx+spVJKRT12Vvb6jeVlIOzkXg
         kKdsDP6elmdiEu2Ft2Vp14L+F2JGjvzturEe+oNnIyBrYIlN06Hnrf9mSiH0C+I5Pi
         mOIpKgL2IdKIOKw3rIPpSWnu2YUNkpbP0n3BcVsZPAduoJKQ/xLjsZTHjFzRREaUuo
         2k9L7yEYvTnZRPmjleSK0hEqIGxcajNLwxeT8L3hALaBdi9CyzERoX4vAEaIZEZUgK
         0qCEpqjVSGNJZF6Pinda7vM0PFzeqlPat4ZKdscLG6A9bWjY1gUn+27xG6Y5Q6jxF4
         pohM+xuYNIHtCsNXEFsVQH8akQua+GjRLWiAyCx+HX3UyAE6mrkZykaLnfyjqO5Uyc
         q2yng8cXetJUPxhxw18Jjx+nPUpYZvevLjCq38WpZB0gw2AIbV9XaU28enLlICqzIK
         xEIIPuUdlw/Uvs8h+YngY3yA=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CAEA40E01EE;
        Mon, 26 Jun 2023 13:01:29 +0000 (UTC)
Date:   Mon, 26 Jun 2023 15:01:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/alternatives for 6.5
Message-ID: <20230626130124.GCZJmMJKLdnwrwkbzF@fat_crate.local>
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

please pull a bunch of x86 alternatives improvements for 6.5.

Thx.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v6.5

for you to fetch changes up to 2bd4aa9325821551648cf9738d6aa3a49317d7e5:

  x86/alternative: PAUSE is not a NOP (2023-06-14 19:02:54 +0200)

----------------------------------------------------------------
- Up until now the Fast Short Rep Mov optimizations implied the presence
  of the ERMS CPUID flag. AMD decoupled them with a BIOS setting so decouple
  that dependency in the kernel code too

- Teach the alternatives machinery to handle relocations

- Make debug_alternative accept flags in order to see only that set of
  patching done one is interested in

- Other fixes, cleanups and optimizations to the patching code

----------------------------------------------------------------
Borislav Petkov (AMD) (3):
      x86/lib/memmove: Decouple ERMS from FSRM
      x86/alternative: Optimize returns patching
      x86/alternatives: Fix section mismatch warnings

Peter Zijlstra (7):
      x86/alternative: Make debug-alternative selective
      x86/alternative: Support relocations in alternatives
      x86/alternative: Rewrite optimize_nops() some
      x86/alternative: Complicate optimize_nops() some more
      x86/alternatives: Add longer 64-bit NOPs
      x86/nospec: Shorten RESET_CALL_DEPTH
      x86/alternative: PAUSE is not a NOP

Steven Rostedt (Google) (1):
      x86/alternatives: Add cond_resched() to text_poke_bp_batch()

 arch/x86/include/asm/nops.h          |  16 +-
 arch/x86/include/asm/nospec-branch.h |   6 +-
 arch/x86/kernel/alternative.c        | 470 ++++++++++++++++++++++++-----------
 arch/x86/lib/memmove_64.S            |  13 +-
 tools/arch/x86/include/asm/nops.h    |  16 +-
 tools/objtool/arch/x86/special.c     |   8 +-
 6 files changed, 361 insertions(+), 168 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
