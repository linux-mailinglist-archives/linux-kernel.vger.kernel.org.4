Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F348970AEB8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjEUQFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjEUQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B1AC7;
        Sun, 21 May 2023 09:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E863760DE9;
        Sun, 21 May 2023 16:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC57DC433D2;
        Sun, 21 May 2023 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685114;
        bh=G3drc7In4D1VhMoTc5Lfa7NiaqWtPZnS/8G0QWUohGM=;
        h=From:To:Cc:Subject:Date:From;
        b=p1ijQ+zARm7LoKfY65ZFtMu7Q8ga38E80NWgFuV7jj7qRULguwqCPqtEuW0HXHq1N
         AmkwuOgCJlx9eN8P4/yhxpZ0OphqpxZuTLdUQgXG46v6fOj76m5qb7pdRcfAQ041EX
         Ege574MPrvQZ7VTyUL4wRF9KrU9dOZjegaoUrBxiH3j3bl6FZV9iluSD6dU95zo0nz
         xQQbbRDaV+kaqPnKc1gdtZDH1Yme/6NcJMizqs7000mXeDgnu9K122BcjLywI8/KGL
         YT/wJ9xpAOu6WEi8PbnSldOZYPHDJSkbEUr7DMIDMqZE+LhElp1HR/nAvmyzLvhMSN
         wV2/B9AgIvp8A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 00/20] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
Date:   Mon, 22 May 2023 01:04:05 +0900
Message-Id: <20230521160426.1881124-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

This patch set is applicable to
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild

Previous version
v5: https://lore.kernel.org/linux-kbuild/CAK7LNARBiOywrMLbR=9N35sk19U0QM3xcPy7d1WqV-eyb4W23w@mail.gmail.com/T/#t
v4: https://lore.kernel.org/linux-kbuild/CAK7LNASDzy9RERN6+q6WgR4ROYZQue=SBqgbcoYuVePByHtk6Q@mail.gmail.com/T/#t
v3: https://lore.kernel.org/all/20220928063947.299333-1-masahiroy@kernel.org/


Masahiro Yamada (20):
  Revert "modpost: skip ELF local symbols during section mismatch check"
  modpost: fix section mismatch message for R_ARM_ABS32
  modpost: detect section mismatch for R_ARM_MOVW_ABS_NC and
    R_ARM_MOVT_ABS
  modpost: remove unused argument from secref_whitelist()
  modpost: refactor find_fromsym() and find_tosym()
  modpost: unify 'sym' and 'to' in default_mismatch_handler()
  modpost: replace r->r_offset, r->r_addend with faddr, taddr
  modpost: remove is_shndx_special() check from section_rel(a)
  modpost: pass struct module pointer to check_section_mismatch()
  kbuild: generate KSYMTAB entries by modpost
  ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
  modpost: check static EXPORT_SYMBOL* by modpost again
  modpost: squash sym_update_namespace() into sym_add_exported()
  modpost: use null string instead of NULL pointer for default namespace
  kbuild: implement CONFIG_TRIM_UNUSED_KSYMS without recursion
  modpost: merge fromsec=DATA_SECTIONS entries in sectioncheck table
  modpost: merge bad_tosec=ALL_EXIT_SECTIONS entries in sectioncheck
    table
  modpost: remove *_sections[] arrays
  modpost: merge two similar section mismatch warnings
  modpost: show offset from symbol for section mismatch warnings

 .gitignore                        |   1 -
 Makefile                          |  19 +-
 arch/ia64/include/asm/Kbuild      |   1 +
 arch/ia64/include/asm/export.h    |   3 -
 arch/ia64/kernel/head.S           |   2 +-
 arch/ia64/kernel/ivt.S            |   2 +-
 arch/um/os-Linux/user_syms.c      |   9 +-
 include/asm-generic/export.h      |  83 +-----
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/export-internal.h   |  49 ++++
 include/linux/export.h            | 119 ++------
 include/linux/pm.h                |   8 +-
 kernel/module/internal.h          |  12 +
 scripts/Makefile.build            |  19 +-
 scripts/Makefile.modpost          |   7 +
 scripts/adjust_autoksyms.sh       |  73 -----
 scripts/basic/fixdep.c            |   3 +-
 scripts/check-local-export        |  70 -----
 scripts/gen_ksymdeps.sh           |  30 --
 scripts/mod/modpost.c             | 454 +++++++++++++++---------------
 scripts/mod/modpost.h             |   6 +-
 scripts/remove-stale-files        |   2 +
 22 files changed, 345 insertions(+), 628 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 delete mode 100755 scripts/check-local-export
 delete mode 100755 scripts/gen_ksymdeps.sh

-- 
2.39.2

