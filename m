Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A87701DFA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjENP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE42699;
        Sun, 14 May 2023 08:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19FEC60C13;
        Sun, 14 May 2023 15:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D067CC433D2;
        Sun, 14 May 2023 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684078066;
        bh=r1tkmI2iEcOcIELwB2Ima7nyWT8YGyUf3YoSV3HSsU0=;
        h=From:To:Cc:Subject:Date:From;
        b=BhjrHIR+thZMHkL4EKvgyjDGybfhaLUJgiNhy6UwdeTUbLQhYMdnEC8+tGauN57x4
         5wcbEV+2SQDUMH1LJJNqe0tm9aXNwvyk6tG+7SZZ2oJTWZ/Lv0iqZ0kM+nWNgSCS1u
         XacgDl9ukZn3RGRhFgX340Nc8KChwKWgp76mGl6wDur5pSp5ilTuu49viTPSIiaDKL
         oyvXORCnxtWYiRqtUWDJrh7OpKYZG6BTMiqQ5bTAwZMw1Qm17AJ5+YILyee7mpMTB3
         iE51FA+D88JVngz6dCBR1mfiJnwjhp6sH5hl9UgvhH72ajHSaoJ3OI1eWX7GDrLlc7
         rWvmQuM2UKXng==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 00/21] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
Date:   Mon, 15 May 2023 00:27:18 +0900
Message-Id: <20230514152739.962109-1-masahiroy@kernel.org>
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

Previous version
v4: https://lore.kernel.org/linux-kbuild/CAK7LNASDzy9RERN6+q6WgR4ROYZQue=SBqgbcoYuVePByHtk6Q@mail.gmail.com/T/#t
v3: https://lore.kernel.org/all/20220928063947.299333-1-masahiroy@kernel.org/



Masahiro Yamada (21):
  modpost: remove broken calculation of exception_table_entry size
  modpost: remove fromsym info in __ex_table section mismatch warning
  modpost: remove get_prettyname()
  modpost: squash report_extable_warnings() into
    extable_mismatch_handler()
  modpost: squash report_sec_mismatch() into default_mismatch_handler()
  modpost: clean up is_executable_section()
  modpost: squash extable_mismatch_handler() into
    default_mismatch_handler()
  modpost: pass 'tosec' down to default_mismatch_handler()
  modpost: pass section index to find_elf_symbol2()
  modpost: rename find_elf_symbol() and find_elf_symbol2()
  modpost: modpost: refactor find_fromsym() and find_tosym()
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

 .gitignore                        |   1 -
 Makefile                          |  19 +-
 arch/ia64/include/asm/Kbuild      |   1 +
 arch/ia64/include/asm/export.h    |   3 -
 arch/ia64/kernel/head.S           |   2 +-
 arch/ia64/kernel/ivt.S            |   2 +-
 include/asm-generic/export.h      |  83 +----
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/export-internal.h   |  49 +++
 include/linux/export.h            | 119 ++-----
 include/linux/pm.h                |   8 +-
 kernel/module/internal.h          |  12 +
 scripts/Makefile.build            |  19 +-
 scripts/Makefile.modpost          |   7 +
 scripts/adjust_autoksyms.sh       |  73 ----
 scripts/basic/fixdep.c            |   3 +-
 scripts/check-local-export        |  70 ----
 scripts/gen_ksymdeps.sh           |  30 --
 scripts/mod/modpost.c             | 561 ++++++++++++------------------
 scripts/mod/modpost.h             |   1 +
 scripts/remove-stale-files        |   2 +
 21 files changed, 343 insertions(+), 723 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 delete mode 100755 scripts/check-local-export
 delete mode 100755 scripts/gen_ksymdeps.sh

-- 
2.39.2

