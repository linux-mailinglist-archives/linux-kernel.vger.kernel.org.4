Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8DC73CFAD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjFYJUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:20:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9511D2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 02:19:55 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70F1D1EC01B7;
        Sun, 25 Jun 2023 11:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687684794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=QHx6fRrR9gNOxey22bj5Kxfr6macSeoiXGbMCf5HrUM=;
        b=S1gpDjA4zbXmWcIZxhuKp18Vk8zhOacRG3Wy3Mxucb3RlX2AY1fdH5Ylyt/Fk7pjs7DzcR
        XdbJQK/28BRZOq5fxxQ2PubhiDeIKIZhOK9M2JDtIz9gmAzkWevenRSTkEewQlC/TGTPYT
        8F9gscjnaNa3f9HY8t0tD9wMiozCE1M=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bci21QXx0_q7; Sun, 25 Jun 2023 09:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687684791; bh=QHx6fRrR9gNOxey22bj5Kxfr6macSeoiXGbMCf5HrUM=;
        h=Date:From:To:Cc:Subject:From;
        b=Ql5FUkJ/wX22VzvIGipHrWx5WnWmDG3nBg5tDZFSYUbb/ehzCaCBDpSI0y/t49DTB
         1f7RsfTBUvqgxtEia4F/9CzlZLqHebb1CuM8/R4Ze4+vNA3shptxXVdKEdtiFeonjF
         OXu0D0A9JxFu7ANEcH8YP2UWIPA4LaBH8g8RJp1ZNeRXUOsJjBb3IlDMxR75bqCERj
         Z9793vXn9sS8D4ps6klhdNfRyyr6uEHPQ/eKk9NW+vKcPN7jLDFPPpoLMgKnK8UB9V
         rpmgobl7STzm6EqyhFUFnG7DhnTwNjrzKMdAJu/MIW/3qp8tY+JgqYs6UwXinLhMde
         fKtHCz+CBHloaavWYvHIkr0ou1AgjSXR5RzZ0tVu6b8yNCoeLen8LVwmJdST36vIm2
         Pbt2tjOcUaoQQkr/WCGLwxEuhhL/6w3a60EO8G2SaTKw1I3S78cO64v0ZBEgNzqd1p
         jQFGMTgjcT0OKRYLvMso5GhKX3PCRoL+tJwR1obg41N8xwuDCXbKM/eoW6S8kwwpDo
         Ut1ijL9YJjIhuUQYSHwvB/LEGnp7QnIPw7OntXYKOyXG3rDEhdBwRs5KPXUm6iiheB
         8pecrj2DdPejkhRS7NONwb1b8MCWsO7AfYP4xqsh7HNHY4gqQqPnNBiHshgkj7yfiD
         l7g/nZncxBxoKnvymnoU8oJU=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A435140E0034;
        Sun, 25 Jun 2023 09:19:48 +0000 (UTC)
Date:   Sun, 25 Jun 2023 11:19:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.4
Message-ID: <20230625091943.GAZJgGr8IH10VrwHU6@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two final urgent x86 fixes for 6.4.

Thx.

---

The following changes since commit a37f2699c36a7f6606ba3300f243227856c5ad6b:

  x86/head/64: Switch to KERNEL_CS as soon as new GDT is installed (2023-06-02 16:59:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.4

for you to fetch changes up to 85d38d5810e285d5aec7fb5283107d1da70c12a9:

  x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys (2023-06-19 20:59:40 +0200)

----------------------------------------------------------------
- Do not use set_pgd() when updating the KASLR trampoline pgd entry
  because that updates the user PGD too on KPTI builds, resulting in
  memory corruption

- Prevent a panic in the IO-APIC setup code due to conflicting command
  line parameters

----------------------------------------------------------------
Dheeraj Kumar Srivastava (1):
      x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

Lee Jones (1):
      x86/mm: Avoid using set_pgd() outside of real PGD pages

 arch/x86/kernel/apic/x2apic_phys.c | 5 ++++-
 arch/x86/mm/kaslr.c                | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
