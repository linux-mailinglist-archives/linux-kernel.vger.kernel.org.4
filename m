Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD29772AA83
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 11:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjFJJNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjFJJNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 05:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF753AA7;
        Sat, 10 Jun 2023 02:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A2661EFC;
        Sat, 10 Jun 2023 09:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADBEC433D2;
        Sat, 10 Jun 2023 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686388409;
        bh=H/Vfs0aEFdgQkIfSQThXTUsI3RD7onVbhwTrQTiazIE=;
        h=From:To:Cc:Subject:Date:From;
        b=nYYM3CA9Zn2yQwmIpZrpUWHKbgAvhbKUDWBzQgLon8OAJ6l68R/AZp0JckEm6rNUd
         oJZEM7jal5mQbAyPfy+TQ164XW6h9bXXxwgKETgAa/VaC5yGZDOumOsKrdCsnhZ3RG
         7rY6W1NqkKqsYUR6eQ3QN2iADX1wVhK2Qbl90f0HyJ+2ws/94/a16RQM01gVnMzHR3
         BKGrSw+Op/gW4GX77RIJhOUncR0TflbCcovc5IRDc/Rx8IXhVbBdQFw47jKdDPNGom
         ETSIs4mzB3HRGNk13MYCCE94wEH+/lRA8k76Pk00F8fpw2/2ZoQna/bQUdQeDaYE3R
         wF4IsRJQbaSHw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v8 00/11] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
Date:   Sat, 10 Jun 2023 18:13:09 +0900
Message-Id: <20230610091320.1054554-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch set refactors modpost first to make it easier to
add new code.

My goals:

 - Refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.
   You can still put EXPORT_SYMBOL() in *.S file, very close to the definition,
   but you do not need to care about whether it is a function or a data.
   This removes EXPORT_DATA_SYMBOL().

 - Re-implement TRIM_UNUSED_KSYMS in one-pass.
   This makes the building faster.

 - Move the static EXPORT_SYMBOL check to modpost.
   This also makes the building faster.

This patch set is applicable to linux-next 20230608.

V7 fixed build errors reported for Xtensa.

Previous version
v7: https://lore.kernel.org/linux-kbuild/20230608142428.256985-1-masahiroy@kernel.org/T/#mbaddcee18c9a8cf0a9b1f3fc562d09526cb69540
v6: https://lore.kernel.org/linux-kbuild/CAK7LNARjzGnj+sYX=_5yQ+8qoOQ2KB5N-_Ye53Ru3=XicezTYw@mail.gmail.com/T/#t
v5: https://lore.kernel.org/linux-kbuild/CAK7LNARBiOywrMLbR=9N35sk19U0QM3xcPy7d1WqV-eyb4W23w@mail.gmail.com/T/#t
v4: https://lore.kernel.org/linux-kbuild/CAK7LNASDzy9RERN6+q6WgR4ROYZQue=SBqgbcoYuVePByHtk6Q@mail.gmail.com/T/#t
v3: https://lore.kernel.org/all/20220928063947.299333-1-masahiroy@kernel.org/


Changes in v8:
  - Fix the definition of ____EXPORT_SYMBOL() to v7.
    It seems to cause a regression for xtensa. (reported by 0day bot)

Changes in v7:
  - New patch
  - Fix sparse warning reported by 0day bot
    https://lore.kernel.org/linux-kbuild/202305280830.Rj5ltc9M-lkp@intel.com/
  - Remove *.usyms
 - New patch

Changes in v6:
  - Fix build error on UML
  - Make the symbol name in the warning more precise

Changes in v5:
  - Fix build error on ARM
  - Clean up more

Changes in v4:
  - Version 3 did not work if a same name symbol exists in a different compilation unit
    Fix it.

Changes in v3:
  - Move struct kernel_symbol to kernel/module/internal.h

Changes in v2:
  - Use KSYMTAB_FUNC and KSYMTAB_DATA for functions and data, respectively
    This distinction is needed for ia64.

Masahiro Yamada (11):
  Revert "[PATCH] uml: export symbols added by GCC hardened"
  modpost: pass struct module pointer to check_section_mismatch()
  kbuild: generate KSYMTAB entries by modpost
  ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
  modpost: check static EXPORT_SYMBOL* by modpost again
  modpost: squash sym_update_namespace() into sym_add_exported()
  modpost: use null string instead of NULL pointer for default namespace
  kbuild: implement CONFIG_TRIM_UNUSED_KSYMS without recursion
  modpost: merge two similar section mismatch warnings
  modpost: show offset from symbol for section mismatch warnings
  linux/export.h: rename 'sec' argument to 'license'

 .gitignore                        |   2 -
 Makefile                          |  22 +--
 arch/ia64/include/asm/Kbuild      |   1 +
 arch/ia64/include/asm/export.h    |   3 -
 arch/ia64/kernel/head.S           |   2 +-
 arch/ia64/kernel/ivt.S            |   2 +-
 arch/um/os-Linux/user_syms.c      |   7 -
 include/asm-generic/export.h      |  83 +----------
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/export-internal.h   |  49 +++++++
 include/linux/export.h            | 126 ++++------------
 include/linux/pm.h                |  14 +-
 kernel/module/internal.h          |  12 ++
 scripts/Makefile.build            |  27 +---
 scripts/Makefile.modpost          |   7 +
 scripts/adjust_autoksyms.sh       |  73 ----------
 scripts/basic/fixdep.c            |   3 +-
 scripts/check-local-export        |  70 ---------
 scripts/gen_autoksyms.sh          |  62 --------
 scripts/gen_ksymdeps.sh           |  30 ----
 scripts/mod/modpost.c             | 233 +++++++++++++++++++-----------
 scripts/mod/modpost.h             |   1 +
 scripts/remove-stale-files        |   4 +
 23 files changed, 268 insertions(+), 566 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 delete mode 100755 scripts/check-local-export
 delete mode 100755 scripts/gen_autoksyms.sh
 delete mode 100755 scripts/gen_ksymdeps.sh

-- 
2.39.2

