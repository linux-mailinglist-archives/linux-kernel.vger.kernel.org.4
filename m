Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407AF6F5F12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjECTZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjECTZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:25:50 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA2B5FDF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:25:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DC45562E1A88;
        Wed,  3 May 2023 21:25:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NgIMzGpBMDA5; Wed,  3 May 2023 21:25:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9056362E1A8B;
        Wed,  3 May 2023 21:25:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kIWJ4Yhy4vqi; Wed,  3 May 2023 21:25:46 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7688D62E1A88;
        Wed,  3 May 2023 21:25:46 +0200 (CEST)
Date:   Wed, 3 May 2023 21:25:46 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1396818281.2692347.1683141946452.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v6.4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: UBzrUyVu13WtK84om5FO5dxIQ5FWlA==
Thread-Topic: UML changes for v6.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc1

for you to fetch changes up to 6032aca0deb9c138df122192f8ef02de1fdccf25:

  um: make stub data pages size tweakable (2023-04-20 23:08:43 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Make stub data pages configurable
- Make it harder to mix user and kernel code by accident

----------------------------------------------------------------
Johannes Berg (6):
      um: add __weak for exported functions
      um: hostfs: define our own API boundary
      um: don't export printf()
      um: further clean up user_syms
      um: prevent user code in modules
      um: make stub data pages size tweakable

 arch/um/include/shared/as-layout.h  |   3 +-
 arch/um/kernel/skas/clone.c         |   5 +-
 arch/um/kernel/skas/mmu.c           |   6 +--
 arch/um/kernel/um_arch.c            |  10 ++--
 arch/um/os-Linux/skas/process.c     |   6 +--
 arch/um/os-Linux/user_syms.c        | 104 ++++++------------------------------
 arch/um/scripts/Makefile.rules      |   4 +-
 arch/x86/um/shared/sysdep/stub_32.h |   8 +--
 arch/x86/um/shared/sysdep/stub_64.h |   8 +--
 arch/x86/um/stub_segv.c             |   2 +-
 fs/Makefile                         |   2 +-
 fs/hostfs/Makefile                  |   6 ++-
 fs/hostfs/hostfs_user_exp.c         |  28 ++++++++++
 13 files changed, 78 insertions(+), 114 deletions(-)
 create mode 100644 fs/hostfs/hostfs_user_exp.c
