Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55B65D4ED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjADOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbjADOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:05:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337681ADB4;
        Wed,  4 Jan 2023 06:05:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C805B61749;
        Wed,  4 Jan 2023 14:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696FFC433F2;
        Wed,  4 Jan 2023 14:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672841106;
        bh=t7ngQQQN3uCpv6taEAtH34papy8bHWs3zIWKFrM+v8c=;
        h=From:To:Cc:Subject:Date:From;
        b=Q5xS/8tRXpLmFeZQai64AociTVLzH8VHJqEIDVlRozJFHRD+CP0Ghjspv7dHa11er
         JpFRw/b1fvxOi/75vyzza66qTKBKUPpwjlvOYRDwb5bvkhaAe0QALZimbKo5h+7aS4
         /2cjJjC4ufcspsJLZZjcKQzNEvxlC/ESmMuwb7fKdxBHzOiEmgiSEUhRGAweIUkmpv
         B73OI4kkZAZkgrKet0pi6hnVaqMmYbSf8FyhBHHo9liowTcLNxoO7RfxuwFMBKQxuL
         WEacz895NOTShPdzc2+E1CQdTSDQHPYszwTMSO95D46Wos3ph6X1Ftaoyatr+89CUu
         RCcgftZPKbZUw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Christopher Schramm <debian@cschramm.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] kbuild: readd -w option when vmlinux.o or Module.symver is missing
Date:   Wed,  4 Jan 2023 23:04:59 +0900
Message-Id: <20230104140459.1147626-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 63ffe00d8c93 ("kbuild: Fix running modpost with musl libc")
accidentally turned the unresolved symbol warnings into errors when
vmlinux.o (for in-tree builds) or Module.symver (for external module
builds) is missing.

In those cases, unresolved symbols are expected, but the -w option
is not set because 'missing-input' is referenced before set.

Move $(missing-input back to the original place. This should be fine
for musl libc because vmlinux.o and -w are not added at the same time.

With this change, -w may be passed twice, but it is not a big deal.

Link: https://lore.kernel.org/all/b56a03b8-2a2a-f833-a5d2-cdc50a7ca2bb@cschramm.eu/
Fixes: 63ffe00d8c93 ("kbuild: Fix running modpost with musl libc")
Reported-by: Christopher Schramm <debian@cschramm.eu>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modpost | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 0ee296cf520c..43343e13c542 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -44,6 +44,7 @@ modpost-args =										\
 	$(if $(CONFIG_MODVERSIONS),-m)							\
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
+	$(if $(KBUILD_MODPOST_WARN),-w)							\
 	$(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))					\
 	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N)	\
 	-o $@
@@ -55,10 +56,6 @@ ifneq ($(findstring i,$(filter-out --%,$(MAKEFLAGS))),)
 modpost-args += -n
 endif
 
-ifneq ($(KBUILD_MODPOST_WARN)$(missing-input),)
-modpost-args += -w
-endif
-
 # Read out modules.order to pass in modpost.
 # Otherwise, allmodconfig would fail with "Argument list too long".
 ifdef KBUILD_MODULES
@@ -124,6 +121,10 @@ modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
 
 endif # ($(KBUILD_EXTMOD),)
 
+ifneq ($(missing-input),)
+modpost-args += -w
+endif
+
 quiet_cmd_modpost = MODPOST $@
       cmd_modpost = \
 	$(if $(missing-input), \
-- 
2.34.1

