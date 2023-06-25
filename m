Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8673CFBE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjFYJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYJ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:29:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F3BB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 02:28:50 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 946BE1EC0882;
        Sun, 25 Jun 2023 11:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687685329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=IsuNgG5ZFUiCMYg0h5b8QUl1BEBIbDhPapDglgyw9Bo=;
        b=P95D/pI5nyCiGz1PyQvSatFM9etZ6Zq2j+pftXindCIct98fzrIPQ36MHxMM3n5hq/pb4b
        fYvnxqvIvP+WAkXLE7MOb8vPY6DyCG3psFgetD7o2sdXxQPddQF3+7YKdT5IQ9pkbGmDe5
        IQ0h8A66/FWSiAX6xI7HbQ3St93NidY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FXWWoWfJ9_lE; Sun, 25 Jun 2023 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687685327; bh=IsuNgG5ZFUiCMYg0h5b8QUl1BEBIbDhPapDglgyw9Bo=;
        h=Date:From:To:Cc:Subject:From;
        b=MS8k8r6Z72eIwv54//mjN6OCXTcdfk6HkaxLXPWboBn3R6xnZUHWa2Y0PDWcDvy9i
         1gXvWIyu6oLmCLAdqqHt4Z57+IkbZUrCjbxZbN0Zhxa0rtbIVAgD0YicOem1+jTHA4
         VvLOGMC6SxbGzM99h/+QAyINJBLgioulm+b9r34RO2p7wugb2DCJhkawxl8zeMaGZe
         nP38PMtxdELGvsX7UzClgwsYIcx3Ce/fos0MMMGoU+VvOHlZTPF3xFIv/oB7aK8iPI
         2ijQzKCgBufpGsLb9UBurxuDjt1mTLzPrkqS6PFryYjxnlyO2r/7ijm48WZxn24KDd
         IZKoN36hjH9HYgVdAnudmf7QEQdAztXxpnsiohH8b6d7aKqhvWRDcvELewEARnDe+h
         mrE9oy+zl++rDZDPjBvCP8PCXNVckD8qdst3TSWRs8kQ3TpexA93TK+5dA4PHTUBu+
         QvOFPIdmjQua6BWR1XLSHcUb/4vU2IOuRrQ6ZYHFwgazg80sashZCskvNdqf1KNQB8
         qU2diHgt34xLiHxwP1d0u46ofMY/VHWXlCaHAmnW7bqNltC744H+h/0bqtjYMIaZ2E
         cKCK0MmB2btJ9CAQ3S5wOczvrQmDzgQhZvwLhUzz3IuNy099wJ585fBNdwmo0GJwsq
         o2zOtxuu4CYzh+76DSSSEwgk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00D7040E0033;
        Sun, 25 Jun 2023 09:28:43 +0000 (UTC)
Date:   Sun, 25 Jun 2023 11:28:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v6.4
Message-ID: <20230625092842.GBZJgIyqJL/FtKW4nU@fat_crate.local>
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

please pull one urgent objtool fix for 6.4.

Thx.

---

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.4

for you to fetch changes up to b9f174c811e3ae4ae8959dc57e6adb9990e913f4:

  x86/unwind/orc: Add ELF section with ORC version identifier (2023-06-16 17:17:42 +0200)

----------------------------------------------------------------
- Add a ORC format hash to vmlinux and modules in order for other tools
  which use it, to detect changes to it and adapt accordingly

----------------------------------------------------------------
Omar Sandoval (1):
      x86/unwind/orc: Add ELF section with ORC version identifier

 arch/x86/Makefile                 | 12 ++++++++++++
 arch/x86/include/asm/Kbuild       |  1 +
 arch/x86/include/asm/orc_header.h | 19 +++++++++++++++++++
 arch/x86/kernel/unwind_orc.c      |  3 +++
 include/asm-generic/vmlinux.lds.h |  3 +++
 scripts/mod/modpost.c             |  5 +++++
 scripts/orc_hash.sh               | 16 ++++++++++++++++
 7 files changed, 59 insertions(+)
 create mode 100644 arch/x86/include/asm/orc_header.h
 create mode 100644 scripts/orc_hash.sh

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
