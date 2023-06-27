Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F373FAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjF0LA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjF0LAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:00:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22921FC7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:00:50 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 586521EC06BB;
        Tue, 27 Jun 2023 13:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687863649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=tNTu6Pvc43JIGHySj2x4ASfX/dpRFgRCaVESW8OczY8=;
        b=gN9qHRAWAwU7hIRbz10Y71fwYpbn1+iyg7AaZAtscaxPsyVCIFKJJDuG1kWCPihN36Vuc6
        9AhtpCbfUADrHahbmi36FmiXa0Rr3mIM5m6xKkOCuVmcvmcL+/Y2NER0AoqV6ll4/eHm8F
        R647KpE4fkkYCkrXQPwee+gMyShaHEE=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VJhc5N-_SW9S; Tue, 27 Jun 2023 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687863645; bh=tNTu6Pvc43JIGHySj2x4ASfX/dpRFgRCaVESW8OczY8=;
        h=Date:From:To:Cc:Subject:From;
        b=CVW3LWR5cegKkvBWoGB5TWjPgfICEbpZRG40qRWYrQrAE6B6b/JdkYimjmU4vCse0
         TnrJiASnr9Z51wH4+SUzOgYs2xxBOKiFiGV7C+hl5r4NRU13D9fFhleRW87sSLn7qr
         cecQC6Oe1nZMdxGGRlZyBgo8SklL9Ua+Lm5KhNs+2uAA0i7oV8D10jvi1ybAidI8vm
         VkOtFKykbdle50I1Mjlh/5MqFPh2IooBGeyo9IJ4IIHPpDS0rSLcAwIqOc7V8ALj8R
         XOyxta7emEC+Xb+Ak6PmVVIa9nXAXKu8ict/gYEqG9bdqv+qa3wMHC4DRhF/Ze0nUO
         rg1lEC/V3SiTC+dxHEqJzH/1hOzaQvoHuUsff/dOdecKCtf94HRHg4yvY69rajC+H5
         SKQKYbSi6LrjLjcroueX3s5mLVujqaGiynHvjqDIzzmbJSQwgIXj9VuhIr+jnO2aRt
         1613pM5a3fUGiUTngJFzFaZ1sd7xSvzBPmvGHZ49YTCYqDcRFCE8/IPnncTA6CfaJr
         IgbxzhZXOJGL/rYOwW68JDJnSDgfXbb33w3GiSiv3q/5e9VOJUIaua66wqNK4UDiIK
         H+vCWbsZUdJ6tBkPsKANUmyYumhps11EhVqUGEufXGR8RlS/PHmSQmzoZy/OFtVMP/
         kGNZOUKGf96tT6/AxPXta0wI=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4C8040E0033;
        Tue, 27 Jun 2023 11:00:42 +0000 (UTC)
Date:   Tue, 27 Jun 2023 13:00:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for 6.5
Message-ID: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
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

please pull the misc pile of updates for 6.5.

Thx.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.5

for you to fetch changes up to 5516c89d58283413134f8d26960c6303d5d5bd89:

  x86/lib: Make get/put_user() exception handling a visible symbol (2023-06-02 10:51:46 +0200)

----------------------------------------------------------------
- Remove the local symbols prefix of the get/put_user() exception
  handling symbols so that tools do not get confused by the presence of
  code belonging to the wrong symbol/not belonging to any symbol

- Improve csum_partial()'s performance

- Some improvements to the kcpuid tool

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      tools/x86/kcpuid: Dump the correct CPUID function in error

Nadav Amit (1):
      x86/lib: Make get/put_user() exception handling a visible symbol

Nathan Chancellor (1):
      x86/csum: Fix clang -Wuninitialized in csum_partial()

Noah Goldstein (1):
      x86/csum: Improve performance of `csum_partial`

Rong Tao (1):
      tools/x86/kcpuid: Add .gitignore

 arch/x86/lib/csum-partial_64.c   | 101 ++++++++----
 arch/x86/lib/getuser.S           |  32 ++--
 arch/x86/lib/putuser.S           |  24 +--
 lib/Kconfig.debug                |  17 ++
 lib/Makefile                     |   1 +
 lib/checksum_kunit.c             | 334 +++++++++++++++++++++++++++++++++++++++
 tools/arch/x86/kcpuid/.gitignore |   1 +
 tools/arch/x86/kcpuid/kcpuid.c   |   7 +-
 8 files changed, 453 insertions(+), 64 deletions(-)
 create mode 100644 lib/checksum_kunit.c
 create mode 100644 tools/arch/x86/kcpuid/.gitignore

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
