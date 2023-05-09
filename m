Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C041B6FBC75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjEIB0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjEIB0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:26:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73083EE;
        Mon,  8 May 2023 18:26:37 -0700 (PDT)
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683595595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EH7EJCy+zaOYirnoFTx4j8Sz/5+BcH8LizE4QJejMqI=;
        b=zIbXZrgRQbJHKb8OzPbZ7vMxSTyfY46CvnA/s8gUORRkBMUxa1xGgYRVUF2F/P7zgg8maa
        dxruFxMyxqU4pIXtnvtZalhqhgcp3P1Reuy3pwWGwsnxshkqBzxfosXC99eitBu4Q4V5ko
        SE7twaUCtizq56kWDyhV4YKhKvw4EhF0uLBLu0gvmuJTBP/9u3al/taNNyKNshSItMgtuA
        TuX2o1qOKGMMkJWv7UR2iiCWo29GjH6oO4DO1j/AArqZLlzzTnMrguHrqjPgtOkLFPaZLz
        w0EEjLG8F1qN5B4uYM+MnprGMgpNgheGd4tzd88UBjQ+EfypLDKpw+cXuN+o7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683595595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EH7EJCy+zaOYirnoFTx4j8Sz/5+BcH8LizE4QJejMqI=;
        b=LBDu6RpBg2cbJvicyJUcsmEvUlVyxh2w2toUNuTWgSsO2y9weEgLHVaa3qRxsL2iUrpEbL
        MBZ8CeY5gdnzaoBw==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kbuild@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 0/2] scripts: Resolve gtags empty index generation
Date:   Tue,  9 May 2023 03:26:14 +0200
Message-Id: <20230509012616.81579-1-darwi@linutronix.de>
In-Reply-To: <20230504201833.202494-1-darwi@linutronix.de>
References: <20230504201833.202494-1-darwi@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v2-changelog
------------

Handle review remarks from Masahiro Yamada:

  - scripts/tags.sh: remove the O= language, and focus on the general
    case of the build directory being different from the kernel source
    tree, as specified in kernel Makefile L159.

  - Fix failure when build directory is a subdirectory of the kernel
    source tree.

NEW:

  - Update Documentation/process/changes.rst with new gtags (GNU GLOBAL)
    requirements.

Thanks!

Cover letter / v1
-----------------

https://lkml.kernel.org/r/20230504201833.202494-1-darwi@linutronix.de

make gtags for O= kernel builds is currently broken. For example, when doing:

   make O=../build/ x86_64_defconfig
   make O=../build/ gtags

gtags generates a warning for each kernel source file to be indexed:

   make[1]: Entering directory '/home/darwi/build'
     GEN     gtags
   Warning: '/home/darwi/linux/arch/x86/include/asm/qspinlock.h' is out of source tree. ignored.
   Warning: '/home/darwi/linux/arch/x86/include/asm/hpet.h' is out of source tree. ignored.
   ...
   Warning: '/home/darwi/linux/virt/lib/irqbypass.c' is out of source tree. ignored.
   make[1]: Leaving directory '/home/darwi/build/'

and then generates an empty index:

   $ du -hs ~/build/G*
   16K	/home/darwi/build/GPATH
   16K	/home/darwi/build/GRTAGS
   16K	/home/darwi/build/GTAGS

This series includes a proposed fix. After applying it:

   $ make O=../build/ gtags
   make[1]: Entering directory '/home/darwi/build'
     GEN     gtags
   make[1]: Leaving directory '/home/darwi/build'

   $ du -hs ~/build/G*
   9.1M	/home/darwi/build/GPATH
   506M	/home/darwi/build/GRTAGS
   696M	/home/darwi/build/GTAGS

The generated files can then be integrated with editors or IDEs as
usual.

=>

Ahmed S. Darwish (2):
  scripts/tags.sh: Resolve gtags empty index generation
  docs: Set minimal gtags / GNU GLOBAL version to 6.6.5

 Documentation/process/changes.rst |  7 +++++++
 scripts/tags.sh                   | 14 +++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

base-commit: ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab
--
2.40.0
