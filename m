Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C0073CC72
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 20:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjFXSmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 14:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjFXSmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 14:42:47 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB4C273D;
        Sat, 24 Jun 2023 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687632119; bh=eN0XWTl7RfDHYLHR5QCiltkIlDC96O/391olzbyd6qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=da6JduTUoxoszKkVxVXY+j4YYyoyjONHX5J/Laxd8qNa2RFLtGZEfC2GT6w0QlICf
         yZVG8PK1uBbfu0MXyy2qAWhfL8HAlg/K17Dsz7WE8FdYI7mnZ6UgW3jOra5B39mO5v
         bX7c6IleGWinbf3KjQmZqLbdJxYs4UCpZRIgo4dY=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id EC3256015C;
        Sun, 25 Jun 2023 02:41:58 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH v2 6/9] LoongArch: Remove all -G0 switches from CFLAGS
Date:   Sun, 25 Jun 2023 02:40:52 +0800
Message-Id: <20230624184055.3000636-7-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230624184055.3000636-1-kernel@xen0n.name>
References: <20230624184055.3000636-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

In GCC, -G stands for "small data threshold", that instructs the
compiler to put data smaller than the specified threshold in a dedicated
"small data" section (called .sdata on LoongArch and several other
arches).

However, benefiting from this would require ABI cooperation, which is
not the case for LoongArch; and current GCC behave the same whether -G0
(equal to disabling this optimization) is given or not. So, remove -G0
from CFLAGS altogether for one less thing to care about. This also
benefits LLVM/Clang compatibility where the -G switch is not supported.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/Makefile      | 4 ++--
 arch/loongarch/vdso/Makefile | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index a27e264bdaa5..366771016b99 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -46,8 +46,8 @@ ld-emul			= $(64bit-emul)
 cflags-y		+= -mabi=lp64s
 endif
 
-cflags-y			+= -G0 -pipe -msoft-float
-LDFLAGS_vmlinux			+= -G0 -static -n -nostdlib
+cflags-y			+= -pipe -msoft-float
+LDFLAGS_vmlinux			+= -static -n -nostdlib
 
 # When the assembler supports explicit relocation hint, we must use it.
 # GCC may have -mexplicit-relocs off by default if it was built with an old
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 4c859a0e4754..ee4abcf5642e 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -25,7 +25,7 @@ endif
 cflags-vdso := $(ccflags-vdso) \
 	-isystem $(shell $(CC) -print-file-name=include) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
-	-O2 -g -fno-strict-aliasing -fno-common -fno-builtin -G0 \
+	-O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
-- 
2.40.0

