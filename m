Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87E874C18E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 10:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjGIINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGIINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 04:13:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C96DB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 01:13:33 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 169E71EC08BF;
        Sun,  9 Jul 2023 10:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688890412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=CIk8dHx1kAtBXWQAlOcRBktVTOAVtAp/RYVHCT7Mhaw=;
        b=WT4xILJkODQiPKoEX/wJX0+EyWpLgK+ZxmxzRwhCgM2b8hlG1yVL+cyNaaImzSUl9HQ7w4
        Rn/fVnaR0+oVwdWDurCzSn7wu3NgqOcqTNTo+6yQt08qOBc6Bj08MbRmzjh98UdCdP459g
        OvoYiM4ie9QAFyB5aMRrG/ktmAmHjIs=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D3a4f-i8exbb; Sun,  9 Jul 2023 08:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688890409; bh=CIk8dHx1kAtBXWQAlOcRBktVTOAVtAp/RYVHCT7Mhaw=;
        h=Date:From:To:Cc:Subject:From;
        b=hYldu/PhQR+HeFSufSJsJkwTysd13NpM2RC8FOmxWJvtwUSGcK6UsvgGNJiirboK4
         iH5sVL7U+V4g2JMg+XhdiMIbTqZ84ntLzuub2HhTHkWVeGnoLwaS3xdp6xEFTB3nw7
         0OevgaWObOuJGRFuuN02W1One+ekMWNDqX/pkF9FS/SE4zeYrv1U+uOMFPQ9innnBR
         tumemCfuLxs2Q9eOQlBtwTAC4BtkALtnmpqyPLp5twj+0AtfuEBRkX7pZFIxxOqZ33
         3gpoKoLQmvL+O3xMvInnI4Cv0iR+PMJaN546OHA6seqkBME/FlkQ/iL5IwcPAYCJfd
         gTaGpmyVtxVZ/9YeuBTcZhpdz3XxNjE6UBgfYq4TnfN4aFsTnr0wcqYya91aucZHnX
         1BCQYAnIdQxepYT7jsvVsIE7e0EocE/VFLOEUL81KTfjqYKg39leIwvzp/DyYwOi/X
         UMz9N5dqcViaYpZKoRKJyfBY9PL5fy+ZrMv3aheUmzCCDXX8nfnRLNm/y3IvKS982D
         bgKWZ46dWTFawY0CLms7BMtAqPE1ECt1H5VBwEsO/JKw7ZUu68uFdp+SKuQDtcGY82
         sdibh2QO1cGUodmJnkP26D0cEjOPPYqazWYdeNl28mUozi3NZX/H9LyUo/Aj3otszv
         xQBZUxuMv4Q1glN03TUrm0Yk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60ABD40E0187;
        Sun,  9 Jul 2023 08:13:26 +0000 (UTC)
Date:   Sun, 9 Jul 2023 10:13:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.5-rc1
Message-ID: <20230709081323.GBZKpsIzizRwSBSzT+@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a simple optimization from IRQ land, for 6.5-rc1.

Thx.

---

The following changes since commit 0017387938993553fe8e08bd9bcf398fb609d136:

  Merge tag 'irq-core-2023-06-26' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-06-26 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.5_rc1

for you to fetch changes up to 67a4e1a3bf7c68ed3fbefc4213648165d912cabb:

  irqdomain: Use return value of strreplace() (2023-06-30 11:13:44 +0200)

----------------------------------------------------------------
- Optimize IRQ domain's name assignment

----------------------------------------------------------------
Andy Shevchenko (1):
      irqdomain: Use return value of strreplace()

 kernel/irq/irqdomain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
