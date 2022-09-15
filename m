Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A44A5B944B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIOG1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIOG1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:27:37 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D368C47C;
        Wed, 14 Sep 2022 23:27:33 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 28F6QQfj031783;
        Thu, 15 Sep 2022 15:26:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 28F6QQfj031783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663223187;
        bh=QtkJ7suo7OuS5AvfNtMIjGmvXba6qgy8Tf3X051862w=;
        h=From:To:Cc:Subject:Date:From;
        b=EOhVPK1aYgODlg2GYlsKPmndzMhu/4QRcze7pttku4PlcGYyZzZHa//RnzS6k5dQ4
         2xA8lC7w4k+39M3X+Q7BpMUXBHcewcQtjVFImIlha+Pe0bIh5I2gOVi+Ld/utUvFXp
         q/BnD4PXIWgfLuA8k/WiMrnm3WGmpQgMI2hX/colXkt6gvRXtbdK8UDiQ+BEhA9x1W
         Pw/Tf5Fl15Nvxfg7fWBN0pMi49mga+pyuWmJfdncYcjKA1dUXXkLN+pN+EWGzQqnaz
         rnRWMe1KSDJum3QxfbrUOcjY573zOAaPuAYrY6cn1goW0Wci3Tc17vNhPNnqhfAz0r
         2SxP3+SilRxEg==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] kbuild: re-run modpost when it is updated
Date:   Thu, 15 Sep 2022 15:26:23 +0900
Message-Id: <20220915062623.2155851-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modpost generates .vmlinux.export.c and *.mod.c, which are prerequisites
of vmlinux and modules, respectively.

The modpost stage should be re-run when the modpost code is updated.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Drop objtool-args-y conversion

 scripts/Makefile.modpost | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index ceb1d78140e7..7740ce3b29e8 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -38,7 +38,7 @@ __modpost:
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
-MODPOST = scripts/mod/modpost								\
+modpost-args =										\
 	$(if $(CONFIG_MODVERSIONS),-m)							\
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
@@ -48,7 +48,7 @@ MODPOST = scripts/mod/modpost								\
 
 # 'make -i -k' ignores compile errors, and builds as many modules as possible.
 ifneq ($(findstring i,$(filter-out --%,$(MAKEFLAGS))),)
-MODPOST += -n
+modpost-args += -n
 endif
 
 ifeq ($(KBUILD_EXTMOD),)
@@ -99,16 +99,18 @@ module.symvers-if-present := $(wildcard Module.symvers)
 output-symdump := $(KBUILD_EXTMOD)/Module.symvers
 missing-input := $(filter-out $(module.symvers-if-present), Module.symvers)
 
-MODPOST += -e $(addprefix -i ,$(module.symvers-if-present) $(KBUILD_EXTRA_SYMBOLS))
+modpost-args += -e $(addprefix -i ,$(module.symvers-if-present) $(KBUILD_EXTRA_SYMBOLS))
 
 endif # ($(KBUILD_EXTMOD),)
 
 ifneq ($(KBUILD_MODPOST_WARN)$(missing-input),)
-MODPOST += -w
+modpost-args += -w
 endif
 
 modorder-if-needed := $(if $(KBUILD_MODULES), $(MODORDER))
 
+MODPOST = scripts/mod/modpost
+
 # Read out modules.order to pass in modpost.
 # Otherwise, allmodconfig would fail with "Argument list too long".
 quiet_cmd_modpost = MODPOST $@
@@ -117,10 +119,10 @@ quiet_cmd_modpost = MODPOST $@
 		echo >&2 "WARNING: $(missing-input) is missing."; \
 		echo >&2 "         Modules may not have dependencies or modversions."; \
 		echo >&2 "         You may get many unresolved symbol warnings.";) \
-	sed 's/ko$$/o/' $(or $(modorder-if-needed), /dev/null) | $(MODPOST) $(vmlinux.o-if-present) -T -
+	sed 's/ko$$/o/' $(or $(modorder-if-needed), /dev/null) | $(MODPOST) $(modpost-args) $(vmlinux.o-if-present) -T -
 
 targets += $(output-symdump)
-$(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(moudle.symvers-if-present) FORCE
+$(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(moudle.symvers-if-present) $(MODPOST) FORCE
 	$(call if_changed,modpost)
 
 __modpost: $(output-symdump)
-- 
2.34.1

