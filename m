Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F373CFC9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFYJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:40:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26249C9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 02:40:45 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF4041EC01B7;
        Sun, 25 Jun 2023 11:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687686043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=kRtQi7wNrDubKlLijND/x6t+NNJHU0ptIA57hbIjIsY=;
        b=Dzb0qA7xeFJ9RwRbs9Ro1cd9fWWbyRp9jiOIfhwm17MAT63uqp7XnT/gGk+8XfwE76KVoz
        2QL8MRIvGnhHZ12OskkkTXwCTpD3l+vGH4tsjQu7IZbzwgP1x0wTkrK98Cd6iDAE8TyR3m
        gWWZeBRHXqFRy79+PDd21jh44BxW5UA=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xf-5WvZ3fCr6; Sun, 25 Jun 2023 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687686041; bh=kRtQi7wNrDubKlLijND/x6t+NNJHU0ptIA57hbIjIsY=;
        h=Date:From:To:Cc:Subject:From;
        b=b2u2lvO7NzdJ3gyXjTucvM7CLsDsLVE89jXcJhCCJfTOwywiqDYwUzm9Z9L4jiDV9
         OTk7oyFg8qyfK/WRzW+98VUSY9zjmTkdCBD2XSWg5HWDHc2IEDgY2c4ZwVaiNDZ9E6
         OQQzo0Cs86zSlln4ZX7uUgkTq+NJbRutudVNjAEKFVHZKzV6athBBV49bdkhSJFRSE
         tp1A36mdBDkRClRFt9q86z7fBGh+ZT53ZX7SpJ8l2z8oRW457DQ836NvlTqXuCUnXs
         wEfOLyAPejfNVGJv8cm1WzeJWT11goY0+YCqFPitA0vBhf0NJsrkot9ksw6mggQmvm
         Wi/UzqKe33WEw95Ygfp0RKM1zyX9ijrwhRBpGfxXV2fH564chOX4bWw3hwX3lCG7aU
         XaeEWQr3X+R1pgwjtxfszQmqMYDzZ7bZPfR6jo1aprYwYAtlncgnPPtUTcZe0hlcXd
         /p7IVtsdJsHvFbKJFIeJ1yhJVPDfWsMtfFY3SbL0a0oihPr5l0Na9gwgIy1WumfmOn
         fkTnHjgk+0B0I3FKSvNhBnSfeoIfOw0oawj0/tGThZDw7kXGbCTOeEAkeIMhypvveY
         P64UVOENyjMy8UT04m4JIVrOlpHihItIp22J4RY2F2lLs0BkEO5C6X5a5Zw0IZhXBa
         P04W7PM9J0XG0P154hNzxwWY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C40D40E01E6;
        Sun, 25 Jun 2023 09:40:38 +0000 (UTC)
Date:   Sun, 25 Jun 2023 11:40:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.4
Message-ID: <20230625094033.GCZJgLkSWnRJfxNXCQ@fat_crate.local>
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

please pull two urgent perf fixes for 6.4.

Thx.

---

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.4

for you to fetch changes up to a6742cb90b567f952a95efa27dee345748d09fc7:

  perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL (2023-06-16 16:46:33 +0200)

----------------------------------------------------------------
- Drop the __weak attribute from a function prototype as it otherwise
  leads to the function getting replaced by a dummy stub

- Fix the umask value setup of the frontend event as former is different
  on two Intel cores

----------------------------------------------------------------
Kan Liang (1):
      perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL

Marc Zyngier (1):
      perf/core: Drop __weak attribute from arch_perf_update_userpage() prototype

 arch/x86/events/intel/core.c | 15 ++++++++++++++-
 include/linux/perf_event.h   |  6 +++---
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
