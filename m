Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ADF72B28D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjFKPvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFKPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:51:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FFBE68;
        Sun, 11 Jun 2023 08:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA0861C0C;
        Sun, 11 Jun 2023 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82E1C433EF;
        Sun, 11 Jun 2023 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686498667;
        bh=M3P3Tt70oSF0U8/09BUo6OTsoFwqdfvzt/GIo8FG5HI=;
        h=From:To:Cc:Subject:Date:From;
        b=n+W+kqhgipjQhbBWZzfaqidf3aqKOK/oETi8tjadKHGBAAYVrtcswAgyfd0GlKAeA
         NfWQRlr+Xo5ueNaRQnJYa78jPB7639OIk9K4yL07oIJkeCQI+icCHSt+lQrCgAchJC
         7AiTvTdVnvYCFp7VLbNdW4n2EO8M9d/uZOrtEKJCw950095tH4AU7OQxwyjDuZ6Wbl
         v19QKzLpcMk6aWyaYhOr89oP7E12h4gx9FAbVaKqvaK/42AjI2Pvtj4Gh2ezllTmIy
         1FjZALS2Ij4XN8eQ9cIZmg8VbSl2QBuXZGXesINi11iHYuKXzj4qdtCwlKyBi06YSx
         b8oWhgxfqHqtQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-snps-arc@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v9 00/11] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
Date:   Mon, 12 Jun 2023 00:50:49 +0900
Message-Id: <20230611155100.2553804-1-masahiroy@kernel.org>
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


My goals:

 - Refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.
   You can still put EXPORT_SYMBOL() in *.S file, very close to the definition,
   but you do not need to care about whether it is a function or a data.
   This removes EXPORT_DATA_SYMBOL().

 - Re-implement TRIM_UNUSED_KSYMS in one-pass.
   This makes the building faster.

 - Move the static EXPORT_SYMBOL check to modpost.
   This also makes the building faster.

This patch set is applicable to linux-next 20230609.

Previous version
v8: https://lore.kernel.org/linux-kbuild/CAK7LNARBVqdWgsPOwGJu87AKNVZvnWjL-bBJ3xJ-2w+fpidZZA@mail.gmail.com/T/#t
v7: https://lore.kernel.org/linux-kbuild/20230608142428.256985-1-masahiroy@kernel.org/T/#mbaddcee18c9a8cf0a9b1f3fc562d09526cb69540
v6: https://lore.kernel.org/linux-kbuild/CAK7LNARjzGnj+sYX=_5yQ+8qoOQ2KB5N-_Ye53Ru3=XicezTYw@mail.gmail.com/T/#t
v5: https://lore.kernel.org/linux-kbuild/CAK7LNARBiOywrMLbR=9N35sk19U0QM3xcPy7d1WqV-eyb4W23w@mail.gmail.com/T/#t
v4: https://lore.kernel.org/linux-kbuild/CAK7LNASDzy9RERN6+q6WgR4ROYZQue=SBqgbcoYuVePByHtk6Q@mail.gmail.com/T/#t
v3: https://lore.kernel.org/all/20220928063947.299333-1-masahiroy@kernel.org/



Masahiro Yamada (11):
  ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard
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
 arch/arc/include/asm/linkage.h    |   8 +-
 arch/ia64/include/asm/Kbuild      |   1 +
 arch/ia64/include/asm/export.h    |   3 -
 arch/ia64/kernel/head.S           |   2 +-
 arch/ia64/kernel/ivt.S            |   2 +-
 include/asm-generic/export.h      |  83 +---------
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/export-internal.h   |  49 ++++++
 include/linux/export.h            | 128 ++++------------
 include/linux/pm.h                |  10 +-
 kernel/module/internal.h          |  12 ++
 scripts/Makefile.build            |  27 +---
 scripts/Makefile.modpost          |   7 +
 scripts/adjust_autoksyms.sh       |  73 ---------
 scripts/basic/fixdep.c            |   3 +-
 scripts/check-local-export        |  70 ---------
 scripts/gen_autoksyms.sh          |  62 --------
 scripts/gen_ksymdeps.sh           |  30 ----
 scripts/mod/modpost.c             | 242 +++++++++++++++++++-----------
 scripts/mod/modpost.h             |   1 +
 scripts/remove-stale-files        |   4 +
 23 files changed, 283 insertions(+), 559 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 delete mode 100755 scripts/check-local-export
 delete mode 100755 scripts/gen_autoksyms.sh
 delete mode 100755 scripts/gen_ksymdeps.sh

-- 
2.39.2

