Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2BC73FEF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjF0OsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjF0Or7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:47:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6794644BA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:46:06 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F3D61EC0178;
        Tue, 27 Jun 2023 16:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687877161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=Rq+NtS/H+qSb0WLkIziZljpm/ZqEYTg/+PSGZ+wJxf4=;
        b=BAIXEe9Cm9P3j3/h2gF8k13a4cZfZzG2zGr+mz7le6DGJMX6d10neoQVFYTo0UXt6ALBM7
        wcyjRIowhcd+pSpoDX6FByrW31fWng7ZPUeRwbcIrr3Zcx76pHZk8L2GZsAuuxfGWt6cy4
        HWZ6N1X9tKI4lBdy4btiUUeqQpyGHvA=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1NB_SoNHx4Tq; Tue, 27 Jun 2023 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687877158; bh=Rq+NtS/H+qSb0WLkIziZljpm/ZqEYTg/+PSGZ+wJxf4=;
        h=Date:From:To:Cc:Subject:From;
        b=g/aox48J4wP0syTgAoq79Q9aNPVVQXGS8D5f+Gjp6S+lZaSVPoQYWI4B5PawLJ37L
         PRaMRdlgnlukKC+qhU71v8lm3D5ftbqwUk8z5MLHekTJuGEJ5zN1xSbxHkU6qVLmXY
         j7boysoTfq6zfKQmJREp0S6WA2lgSnDvIwYOU3ajZfcUsZ8kugjyZCHGKN8YkA7DQI
         EKT7lhgn07rZYADAONQacXKzp07tgnHjwGskjvJJ0OOd8TFPBDD8L7qBEbqRq1lTx+
         RefefIu9mYo3PjJLA9AZKU74dR9140vXG+QeTb7Lo7ESjnyIHRQEP+8R84+QdQPQkk
         avC8ZroZNFzYK38iaqXqizge5kN3d/0XGGWyg8pfM41Q8ke6ysr/mTi8tykSk3KkiH
         u8GOcxmJnFpHjGvReDCHrWSIhwcda/g2FZYcNigiQX9tn7ia2m/1YER56X7ax1pgOq
         Fus+2DfvsBNqMHp1i5rekdmoQeY8/DR+S1wTAUnGLx1Mi8Mol9FlYcktMVfDfHFOUL
         owDEbyXQr6MGTdP6WDZUK40dg8BlPCa0i/PEvxpuLxgZZsSJ+bzefwBy4OBM6BdrIs
         SJ6PAa0/xHNP2QW8HvZlQ9BKgf/ityhltG5Y3TgxwcmkRqjIAdE8ig13S2+cUQHoWK
         VmfpYdBIf+5ZctqvDH9Il8Hs=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 318DD40E0187;
        Tue, 27 Jun 2023 14:45:55 +0000 (UTC)
Date:   Tue, 27 Jun 2023 16:45:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sgx for 6.5
Message-ID: <20230627144554.GJZJr2Iltg+EaduWjo@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single SGX fix for 6.5.

Thx.

---

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v6.5

for you to fetch changes up to 1e327963cfab0e02eeeb0331178d6c353c959cd6:

  x86/sgx: Avoid using iterator after loop in sgx_mmu_notifier_release() (2023-06-13 16:21:01 +0200)

----------------------------------------------------------------
- A fix to avoid using a list iterator variable after the loop it is
  used in

----------------------------------------------------------------
Jakob Koschel (1):
      x86/sgx: Avoid using iterator after loop in sgx_mmu_notifier_release()

 arch/x86/kernel/cpu/sgx/encl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
