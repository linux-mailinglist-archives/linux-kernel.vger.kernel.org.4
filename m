Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C1F73FEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjF0Ooc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjF0OoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:44:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0DD359C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:43:34 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EEB431EC00D9;
        Tue, 27 Jun 2023 16:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687876964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=mPB3CFrNDFKdeVPXrIlyac+fNvDbz8kLEdIWR4K8JC4=;
        b=KeznV1EBT03mLWmVHY7UcgQzX5WQIkARu9BmuFyDKrK5CMN0GslQdNjmkMdgC0ddZB5z6d
        PC1QrtQYOBNomdIQvJfS9PfvsL2o9sd+bb+Z+Raz+6aA5iY6fjoqGKl7FBP3Mh3JgmB8Ka
        lBuc/mUqzcnC13IiLv6100joFJZWYi0=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lCiYozgeCOJm; Tue, 27 Jun 2023 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687876960; bh=mPB3CFrNDFKdeVPXrIlyac+fNvDbz8kLEdIWR4K8JC4=;
        h=Date:From:To:Cc:Subject:From;
        b=G6BpBQy5/aOXH4vvB1pHUl5x1yb7bSNXU3Qp1wxbcnd0eTyG8N4Qd6rACSOkBubyn
         NMZh/g2OmL53j6d9GyenFCrTzMP6TQd9v/uQHpAgmTQMxG8SAJsqtVcvyqNCv2t1wt
         cPUe58r8f6GFf70A6dVS32IAn7tlJg7VZgTPmG4IMQetCZDTTh99NDXpWKAb7xStxx
         eVxBeuMcBIs9pMqen2K/YJ7ruj8QESN+UR3iIgbcCPsjRzCMxSSIt/jauVxpFdtrSR
         OxwM5I/C4amfZ5ATTXxsQMJ5twSRAabRWebdZYDelbjRFmBosgWcoFjIt8wsrzrGV1
         w2GPkGF0zHY4rbiUNBHRQo67kCrTg7skdAmCeOZfyRv1idRM7uCKv2+Dw4Lw2zCu+B
         OMUSuW95E/B8bTENko5i1oh7PdCFLiAYEW5yeRrazKKF4mIDV1f3g4bwPhSz5mdvQx
         8hiQPSLSbVg0Pol10Oy7pQR/GpXlQlXzPAO0qaLMUIiHxph2yxNgDEZ34YPvDoUe9u
         Vuq4sSy8qJT4UUT/OtQMIF3b+OjPx8wB7mrSX/iBkVlRzEFajNRDSNN50CygO4MqwV
         Twmk7c9xDhZlwQrvaQEYpnRMCZNy2x49P0qE8sjmV+cATkowiUdISNZ5qW8Dtk/Mgl
         6bm1+VIgEKpk3NXS/HcoNEf0=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAB7A40E0187;
        Tue, 27 Jun 2023 14:42:37 +0000 (UTC)
Date:   Tue, 27 Jun 2023 16:42:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for 6.5
Message-ID: <20230627144233.GIZJr1WWNaTGk7xfFf@fat_crate.local>
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

please pull a couple of SEV cleanups for 6.5.

Thx.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.5

for you to fetch changes up to da86eb9611840772a459693832e54c63cbcc040a:

  x86/coco: Get rid of accessor functions (2023-05-09 12:53:16 +0200)

----------------------------------------------------------------
- Some SEV and CC platform helpers cleanup and simplifications now that
  the usage patterns are becoming apparent

----------------------------------------------------------------
Borislav Petkov (AMD) (3):
      x86/coco: Mark cc_platform_has() and descendants noinstr
      x86/sev: Get rid of special sev_es_enable_key
      x86/coco: Get rid of accessor functions

 arch/x86/coco/core.c               | 10 +++++-----
 arch/x86/coco/tdx/tdx.c            |  2 +-
 arch/x86/hyperv/ivm.c              |  2 +-
 arch/x86/include/asm/coco.h        | 19 +------------------
 arch/x86/include/asm/sev.h         | 11 +++++++----
 arch/x86/kernel/sev.c              |  5 -----
 arch/x86/mm/mem_encrypt_identity.c |  2 +-
 7 files changed, 16 insertions(+), 35 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
