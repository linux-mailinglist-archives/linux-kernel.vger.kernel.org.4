Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB746589D8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiL2HGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiL2HGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:06:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F799FFE;
        Wed, 28 Dec 2022 23:06:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C8A5CE13A1;
        Thu, 29 Dec 2022 07:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71FDC433EF;
        Thu, 29 Dec 2022 07:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672297599;
        bh=lbIPO6x/hNkeFCdHgErSD5W/VheZVVuEEu7dLtY+Qgs=;
        h=From:To:Cc:Subject:Date:From;
        b=NMiBp1Izy2kWzT2ab4F4AwNOqDdRM3qz78qBO6WizMlNguF5UsWLiHjVYe6gcmOO6
         vscpjGYlH9oIYqLYg2nt/BRNCMc85YbWVjN18m3l7kX7l5XpyncfYevBsylo99ddRn
         lNliBJ88ujhErm6FUOlsP0Cp/N0vOXW8+NOLqO+7fB7wP+QbfSWxPOhte2CJj1nY1z
         3mOq1F4JAQP+J/iPQw3O15PcrctTdFYw7D57Iwh+LzX1OK1MI12WI8PgwqJLemGAmS
         cnvWFVCz9qr/+ai3GAlJXu1taULzwhMn7qkG8zF9Ydgvu6Ez61bTNyAIRz5pOy6W/x
         HUdwFjijI4lJA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCH] kbuild: clean up stale file removal
Date:   Thu, 29 Dec 2022 16:06:33 +0900
Message-Id: <20221229070634.900793-1-masahiroy@kernel.org>
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

More than one year has passed since the copied *.[cS] files were
removed from arch/*/boot/compressed/.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/boot/compressed/Makefile |  7 -------
 scripts/remove-stale-files       | 24 +-----------------------
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index 591125c42d49..b5e29f99c02c 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -8,13 +8,6 @@
 OBJECTS := head_32.o misc.o cache.o piggy.o \
            ashiftrt.o ashldi3.o ashrsi3.o ashlsi3.o lshrsi3.o
 
-# These were previously generated files. When you are building the kernel
-# with O=, make sure to remove the stale files in the output tree. Otherwise,
-# the build system wrongly compiles the stale ones.
-ifdef building_out_of_srctree
-$(shell rm -f $(addprefix $(obj)/, ashiftrt.S ashldi3.c ashrsi3.S ashlsi3.S lshrsi3.S))
-endif
-
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
            vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo $(OBJECTS)
 
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index 64b14aa5aebf..cdbdde89a271 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -21,31 +21,9 @@ set -e
 # then will be really dead and removed from the code base entirely.
 
 rm -f arch/powerpc/purgatory/kexec-purgatory.c
-
-# These were previously generated source files. When you are building the kernel
-# with O=, make sure to remove the stale files in the output tree. Otherwise,
-# the build system wrongly compiles the stale ones.
-if [ -n "${building_out_of_srctree}" ]; then
-	for f in fdt_rw.c fdt_ro.c fdt_wip.c fdt.c ashldi3.S bswapsdi2.S font.c lib1funcs.S hyp-stub.S
-	do
-		rm -f arch/arm/boot/compressed/${f}
-	done
-
-	for f in uart-ath79.c ashldi3.c bswapdi.c bswapsi.c
-	do
-		rm -f arch/mips/boot/compressed/${f}
-	done
-
-	for f in firmware.c real2.S
-	do
-		rm -f arch/parisc/boot/compressed/${f}
-	done
-fi
-
 rm -f arch/riscv/purgatory/kexec-purgatory.c
+rm -f arch/x86/purgatory/kexec-purgatory.c
 
 rm -f scripts/extract-cert
 
-rm -f arch/x86/purgatory/kexec-purgatory.c
-
 rm -f scripts/kconfig/[gmnq]conf-cfg
-- 
2.34.1

