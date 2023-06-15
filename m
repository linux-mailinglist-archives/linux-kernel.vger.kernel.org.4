Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEF6731655
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbjFOLSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343808AbjFOLSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB43271F;
        Thu, 15 Jun 2023 04:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A24762544;
        Thu, 15 Jun 2023 11:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5524C433C0;
        Thu, 15 Jun 2023 11:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686827878;
        bh=1uYU6LpiCcuTJ/wma2POx8xMt4BZqFeI+ixT4aEcTbA=;
        h=From:To:Cc:Subject:Date:From;
        b=fHWFLirMyS5uj+mCayXhH0iRKX3b7wwkV7i3dsKljEK6E56E9MD/11rP/YrvCfQ6b
         gJff3FPTVv6OtMfJV5Kklhx34qJhQqK9gu50+eRbKX7LTHtofIkuoZzwi+mtXO5s/Q
         nbjyMYdV0T0j+NzMiBjgxgI0T3DF5Z4EuH3UBKR2LnU5t55KLkanQsz4frz8iIXnKV
         hMlHkK9ohD9lL5naXCYejqMHJul3UnrxX2im9DGsPcoHiaukww1r2oZGzGEZLDkqtJ
         QknJ9OzQhrk2bNePnmBtVlKxiPjg0f+9VmLuTJg4AIUMPc3M3XRrfN7GLkkm1x6W/1
         jh58hCHDk2zOA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-snps-arc@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] kbuild: make modules_install copy modules.builtin(.modinfo)
Date:   Thu, 15 Jun 2023 20:17:43 +0900
Message-Id: <20230615111743.883891-1-masahiroy@kernel.org>
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

Josh Triplett reports that initramfs-tools needs modules.builtin and
modules.builtin.modinfo to create a working initramfs for a non-modular
kernel.

If this is a general tooling issue not limited to Debian, I think it
makes sense to change modules_install.

This commit changes the targets as follows when CONFIG_MODULES=n.

In-tree builds:
  make modules          -> no-op
  make modules_install  -> install modules.builtin(.modinfo)

External module builds:
  make modules          -> show error message like before
  make modules_install  -> show error message like before

Link: https://lore.kernel.org/lkml/36a4014c73a52af27d930d3ca31d362b60f4461c.1686356364.git.josh@joshtriplett.org/
Reported-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index cc3fe09c4dec..f18d59c81241 100644
--- a/Makefile
+++ b/Makefile
@@ -1545,6 +1545,8 @@ modules_sign_only := y
 endif
 endif
 
+endif # CONFIG_MODULES
+
 modinst_pre :=
 ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
 modinst_pre := __modinst_pre
@@ -1555,18 +1557,18 @@ PHONY += __modinst_pre
 __modinst_pre:
 	@rm -rf $(MODLIB)/kernel
 	@rm -f $(MODLIB)/source
-	@mkdir -p $(MODLIB)/kernel
+	@mkdir -p $(MODLIB)
+ifdef CONFIG_MODULES
 	@ln -s $(abspath $(srctree)) $(MODLIB)/source
 	@if [ ! $(objtree) -ef  $(MODLIB)/build ]; then \
 		rm -f $(MODLIB)/build ; \
 		ln -s $(CURDIR) $(MODLIB)/build ; \
 	fi
 	@sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.order
+endif
 	@cp -f modules.builtin $(MODLIB)/
 	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
 
-endif # CONFIG_MODULES
-
 ###
 # Cleaning is done on three levels.
 # make clean     Delete most generated files
@@ -1908,6 +1910,13 @@ help:
 	@echo  '  clean           - remove generated files in module directory only'
 	@echo  ''
 
+__external_modules_error:
+	@echo >&2 '***'
+	@echo >&2 '*** The present kernel disabled CONFIG_MODULES.'
+	@echo >&2 '*** You cannot build or install external modules.'
+	@echo >&2 '***'
+	@false
+
 endif # KBUILD_EXTMOD
 
 # ---------------------------------------------------------------------------
@@ -1944,13 +1953,10 @@ else # CONFIG_MODULES
 # Modules not configured
 # ---------------------------------------------------------------------------
 
-modules modules_install:
-	@echo >&2 '***'
-	@echo >&2 '*** The present kernel configuration has modules disabled.'
-	@echo >&2 '*** To use the module feature, please run "make menuconfig" etc.'
-	@echo >&2 '*** to enable CONFIG_MODULES.'
-	@echo >&2 '***'
-	@exit 1
+PHONY += __external_modules_error
+
+modules modules_install: __external_modules_error
+	@:
 
 KBUILD_MODULES :=
 
-- 
2.39.2

