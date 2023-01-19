Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942F9674C87
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjATFg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjATFgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8B86923C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8671EB8212A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CFFC433F0;
        Thu, 19 Jan 2023 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674116733;
        bh=ghjfgjQy0BKb/C6LfAEq6+fVqZmZeT2M4t0k/6l5bN4=;
        h=From:To:Cc:Subject:Date:From;
        b=iT/hmlqtrPaMfsfA5C6T3dPUpevSfxmWLR3aEIwMwTorEBT0YyWkjbBVySwBvnvjW
         E0YtHhJMKphZa12C/JftqksZTccO+V48/yojtXFS1nsokX/Y/wcmSg3LeOENbnXJFv
         USf0ejmaS47uyXnTzsHwTCIf8pgY3lAl+SiyrLpBXO36yWTvDJvBj2Aufe4+xesR7e
         H/cuTX+6oB35Qm3kpnseCep2Qlho9iJiHm9t7T3nCbfGC8WFoGG3+P6eCWPtCmNiYC
         wNP/GqaBikzvLYVOt+AED7JsSsRJuc+fCN/H4STyEo0AItUKHH+vb+tMytvbqXLNyQ
         FxVvUPlvYymiw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: [PATCH] powerpc: add crtsavres.o to always-y instead of extra-y
Date:   Thu, 19 Jan 2023 17:24:47 +0900
Message-Id: <20230119082447.152020-1-masahiroy@kernel.org>
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

crtsavres.o is linked to modules, but as commit d0e628cd817f ("kbuild:
doc: clarify the difference between extra-y and always-y") explained,
'make modules' does not build extra-y.

The following command fails:

  $ make ARCH=powerpc LLVM=1 mrproper ps3_defconfig modules
    [snip]
    LD [M]  arch/powerpc/platforms/cell/spufs/spufs.ko
  ld.lld: error: cannot open arch/powerpc/lib/crtsavres.o: No such file or directory
  make[1]: *** [scripts/Makefile.modfinal:61: arch/powerpc/platforms/cell/spufs/spufs.ko] Error 1
  make: *** [Makefile:1924: modules] Error 2

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index c53618c34b70..aa34854bc9f5 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -43,7 +43,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 # so it is only needed for modules, and only for older linkers which
 # do not support --save-restore-funcs
 ifndef CONFIG_LD_IS_BFD
-extra-$(CONFIG_PPC64)	+= crtsavres.o
+always-$(CONFIG_PPC64)	+= crtsavres.o
 endif
 
 obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
-- 
2.34.1

