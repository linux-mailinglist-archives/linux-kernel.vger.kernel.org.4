Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A9A7019B8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjEMUpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEMUpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071C2D51;
        Sat, 13 May 2023 13:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2E4861558;
        Sat, 13 May 2023 20:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DFCC433D2;
        Sat, 13 May 2023 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010712;
        bh=WefmwDbTlKZwMEUwatpKr0TGAhRypftwwE7L0w+8BHc=;
        h=From:To:Cc:Subject:Date:From;
        b=hLsvgVoklhXVqXeRKMx+a/X53xPra7P2reL7r+xMoleA5sr+x5EaYEUthGmo6WbO+
         Sl4APIkyztPGOBh+9fnOhqDOYvC2XLf321BwjyXCrMrILypIyVtPbNU+r6q+I9jGAu
         tmw6rg2/94dh+mjNllhpyYVfZxufgyO5PWwUmkETgsleRZh/EKBIbDVEVC6G/T9uHX
         afyGfKs9fhxdrRFw7geRc4SffhZGtqWrHK3/dhFF8Qasq7npX5QgZ1FOXWpqliZPmF
         FKqKYJOY/aL85Dfgi12Z8TML4wu2raO7s+Y9k3nihwXyZO4pzFME45frUdtljpeLrh
         PRX3odU897sFA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 00/21] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
Date:   Sun, 14 May 2023 05:44:41 +0900
Message-Id: <20230513204502.1593923-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch set refactors modpost first to make it easier to
add new code.

Main goals:

 - Refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.
   You can still put EXPORT_SYMBOL() in *.S file, very close to the definition,
   but you do not need to care about whether it is a function or a data.
   This removes EXPORT_DATA_SYMBOL().

 - Re-implement TRIM_UNUSED_KSYMS in one-pass.
   This makes the building faster.

 - Move the static EXPORT_SYMBOL check to modpost.
   This also makes the building faster.

Previous version
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
  modpost: simplify find_elf_symbol()
  modpost: rename find_elf_symbol() and find_elf_symbol2()
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
 include/linux/export.h            | 116 ++-----
 include/linux/pm.h                |   8 +-
 kernel/module/internal.h          |  12 +
 scripts/Makefile.build            |  19 +-
 scripts/Makefile.modpost          |   7 +
 scripts/adjust_autoksyms.sh       |  73 ----
 scripts/basic/fixdep.c            |   3 +-
 scripts/check-local-export        |  70 ----
 scripts/gen_ksymdeps.sh           |  30 --
 scripts/mod/modpost.c             | 534 ++++++++++++------------------
 scripts/mod/modpost.h             |   1 +
 scripts/remove-stale-files        |   2 +
 21 files changed, 317 insertions(+), 719 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 delete mode 100755 scripts/check-local-export
 delete mode 100755 scripts/gen_ksymdeps.sh

-- 
2.39.2

