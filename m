Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD9A72829D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbjFHOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbjFHOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:24:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BBD2D64;
        Thu,  8 Jun 2023 07:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA8364E1C;
        Thu,  8 Jun 2023 14:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F10C433EF;
        Thu,  8 Jun 2023 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686234276;
        bh=k+Mn9weSydYIaCuWNuvDX6AoybHLToDi+9bw3+6L3mE=;
        h=From:To:Cc:Subject:Date:From;
        b=fRrTog57JAttHS7m0CTWO4G3XgAr0HVzUMfMz+Jmj5OZPG0N0DW2sGdctfa4CGO1e
         L6rPljb+N0AK99eRTbYIESp6H+s+AtiYY6qRRcQyvCg86U2BQoRi1UYLk1lM0KmOfK
         AGKQ8hO4xvAjeyBD60CJJKpJJRO6A8qTgK4mFNx5vPy/x0BpHI3Nwsw1NS6XT8iDnH
         ArNDJGpgwarr95RA8NNW82gvmFyAwZbIsleYpLXawNwmtbBR5mblmfZ7XRceO182ys
         PJFSuNqp+b4GeEsh2Nw6PKKVMWIogyCKTroUDzVa7XSYBCwQ233h2/xGDvfoqph3oV
         i98Nwklk4pAiA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 00/11] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
Date:   Thu,  8 Jun 2023 23:24:17 +0900
Message-Id: <20230608142428.256985-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

This patch set is applicable to linux-next 20230608.

Previous version
v6: https://lore.kernel.org/linux-kbuild/CAK7LNARjzGnj+sYX=_5yQ+8qoOQ2KB5N-_Ye53Ru3=XicezTYw@mail.gmail.com/T/#t
v5: https://lore.kernel.org/linux-kbuild/CAK7LNARBiOywrMLbR=9N35sk19U0QM3xcPy7d1WqV-eyb4W23w@mail.gmail.com/T/#t
v4: https://lore.kernel.org/linux-kbuild/CAK7LNASDzy9RERN6+q6WgR4ROYZQue=SBqgbcoYuVePByHtk6Q@mail.gmail.com/T/#t
v3: https://lore.kernel.org/all/20220928063947.299333-1-masahiroy@kernel.org/



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
 include/linux/export.h            | 127 ++++------------
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
 23 files changed, 266 insertions(+), 569 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 delete mode 100755 scripts/check-local-export
 delete mode 100755 scripts/gen_autoksyms.sh
 delete mode 100755 scripts/gen_ksymdeps.sh

-- 
2.39.2

