Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82E73E870
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjFZSZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjFZSZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:25:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E01987
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:24:46 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76B361EC041E;
        Mon, 26 Jun 2023 20:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687803884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=V1tWysda6X3VU0VjYNMzk/Ys+yetNuvxXq2sbISgvEI=;
        b=kpX1aznUiCv/p4bvs18IQafgrWitIADmLj5YGqUVGQNI/2zj0Uns0tclMm6dDzNxPli0vm
        vk6Ke0WCNaIyUNhPqxpb7toKVLmBn+NNTN0WxRLFTseM+cd8PpgtoBYkl1PorAzGdDwsFD
        wRcaYbk1taEHvrOD29fASiUlbXT6fro=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ONF9O9_GaLOd; Mon, 26 Jun 2023 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687803882; bh=V1tWysda6X3VU0VjYNMzk/Ys+yetNuvxXq2sbISgvEI=;
        h=Date:From:To:Cc:Subject:From;
        b=TEJQ47DJ+NQMwEQhG9Q0B0Um+6zJ/q0OAX2bxVi1XFtY+cpQcTET6HgtRbZe1iZbU
         cDbav252Ldvmb1TiHHRJ7BtftQXdgB9S2gbsHJt6OdaXJR9MX0rCM2PHnxuQtLrugd
         7sTeX6QuTFeWspognrs1VVQ1i48YhNCdX0TZ3Ehn87DlLf/qGffQtSGGCLEnVZ2UpQ
         DfMNDuQvlsjBYOB+L/EoF088jYx7tHbSnBYp6GDNmazs/sqYT2r4vVBmMZiPl/xaqc
         wgLbieecvu4IWKtv8MxJd7l5ROjewstE++IrXCUzNf3ycip8MHoQ/P/5lpOJr7wmhm
         J6pvOFoPN+W1F17V5U+36TeDA3vR2LlAw/PA6dNJPPFImR5A9vRhUlZ7ZiHwobaqyz
         ZBmoqi4x57Wh1myjNoxvDyIcfN0up7TslxZue5gui41VUuQCRBGRD8PxAR2Fq7OYcm
         417xAnbLnQu24ePAQvtoNC53juS21Cdh+sPjQMe5UyQD3RtEHV+2nm6jheRvxtfJsq
         G3YXWlNQLPqxkJdzd1Uwm6Yr1lOFqJF+gWJijYlUPh2Cp3YrkBub0ZVKkpVl/vq+b8
         mEFygsAmpdKfbzIQOA8N+1S9lA0giiG6ipH5v1L1aqbcY+l/25B1yxbv/0NCEzmGIj
         g/JM2PpjLWRDyMz4pCd0msXc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05CAE40E019B;
        Mon, 26 Jun 2023 18:24:38 +0000 (UTC)
Date:   Mon, 26 Jun 2023 20:24:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for 6.5
Message-ID: <20230626182434.GKZJnX4kAKZ+ea+hOE@fat_crate.local>
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

please pull a couple of x86/cpu fixes for 6.5.

Thx.

---

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.5

for you to fetch changes up to f220125b999b2c9694149c6bda2798d8096f47ed:

  x86/retbleed: Add __x86_return_thunk alignment checks (2023-05-17 12:14:21 +0200)

----------------------------------------------------------------
- Compute the purposeful misalignment of zen_untrain_ret automatically
  and assert __x86_return_thunk's alignment so that future changes to
  the symbol macros do not accidentally break them.

- Remove CONFIG_X86_FEATURE_NAMES Kconfig option as its existence is
  pointless

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/retbleed: Add __x86_return_thunk alignment checks

Lukas Bulwahn (2):
      x86/Kconfig: Make X86_FEATURE_NAMES non-configurable in prompt
      x86/cpu: Remove X86_FEATURE_NAMES

 arch/x86/Kconfig                  | 12 ------------
 arch/x86/Kconfig.cpu              |  2 +-
 arch/x86/boot/Makefile            |  2 --
 arch/x86/boot/cpu.c               | 13 -------------
 arch/x86/include/asm/cpufeature.h |  5 -----
 arch/x86/kernel/cpu/Makefile      |  4 +---
 arch/x86/kernel/cpu/common.c      |  4 ----
 arch/x86/kernel/vmlinux.lds.S     |  4 ++++
 arch/x86/lib/retpoline.S          |  2 +-
 9 files changed, 7 insertions(+), 41 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
