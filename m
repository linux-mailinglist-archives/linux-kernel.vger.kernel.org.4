Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7466611C7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 22:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjAGVUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 16:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjAGVUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 16:20:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8FB7E4;
        Sat,  7 Jan 2023 13:20:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E9FF60BC7;
        Sat,  7 Jan 2023 21:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5482AC433F2;
        Sat,  7 Jan 2023 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673126429;
        bh=YElGyz6l5ZcYNhvjI8IBAD2Fy1zN10N4toXct3WSyF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UaQJcrIP7SIkmWhcydRGrylrzfOhENBrb7nb6Dum05ZMBMgEta8csV7uyMLV2UICI
         7hpOsOaEJD8f/43u81pTYlrpC/ocx3QyXquxhEGpnP0zwiOxSkyYL+URc+eTrgQGxq
         6vIuVwt81JvTQxp8fThZrELvAqbdAfB9+RXuXlH8ouTx+2Q+dalV+Z8ipAJzvRKb0C
         em/uEmqX34ai/TLN4Bn1LV3b8eIj6Fmgvc3LTsC2mR17rWi4rd/L8EEP0YkmEbhj1U
         7GwogCqi8idR+KHG8XR70+1rWg77VnYig8WYbyZsqryOkypinssx4pJfBlO296TB+a
         Xa8XxJC+uNH2Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/2] kbuild: do not export LDFLAGS_vmlinux to decompressor Makefiles
Date:   Sun,  8 Jan 2023 06:20:19 +0900
Message-Id: <20230107212019.2575770-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230107212019.2575770-1-masahiroy@kernel.org>
References: <20230107212019.2575770-1-masahiroy@kernel.org>
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

Commit 3ec8a5b33dea ("kbuild: do not export LDFLAGS_vmlinux") unexported
LDFLAGS_vmlinux because LDFLAGS_vmlinux in the top Makefile and the one
in arch/*/boot/compressed/Makefile are unrelated to each other. It is
just the decompressors, arch/*/boot/compressed/vmlinux just happen to
have the same base name.

Commit 5d4aeffbf709 ("kbuild: rebuild .vmlinux.export.o when its
prerequisite is updated") accidentally exported it again.

The issue reported so far is $(NM) error message when building the
ARM decompressor with GNU Make >= 4.4. This was fixed by refactoring
arch/arm/boot/compressed/Makefile.

The error message fixed by 3ec8a5b33dea is very likely to happen in the
current cleaning code, but it would still be possible on systems with a
huge number of CPUs.

Anyway, LDFLAGS_vmlinux should not be exported to the decompressor
Makefiles.

Fixes: 5d4aeffbf709 ("kbuild: rebuild .vmlinux.export.o when its prerequisite is updated")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dfba294ae790..146cdf195e56 100644
--- a/Makefile
+++ b/Makefile
@@ -549,7 +549,7 @@ LDFLAGS_MODULE  =
 CFLAGS_KERNEL	=
 RUSTFLAGS_KERNEL =
 AFLAGS_KERNEL	=
-export LDFLAGS_vmlinux =
+LDFLAGS_vmlinux =
 
 # Use USERINCLUDE when you must reference the UAPI directories only.
 USERINCLUDE    := \
@@ -1248,6 +1248,11 @@ vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
 	@:
 
 PHONY += vmlinux
+# LDFLAGS_vmlinux flags from the top Makefile and arch/*/Makefile should be
+# exported for building the top vmlinux, but not for building decompressors.
+# They have the same base name (arch/*/boot/compressed/vmlinux), but the
+# decompressor Makefiles should not inherit LDFLAGS_vmlinux.
+vmlinux: export LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
 vmlinux: vmlinux.o $(KBUILD_LDS) modpost
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux
 
-- 
2.34.1

