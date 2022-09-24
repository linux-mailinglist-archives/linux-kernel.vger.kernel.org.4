Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615EF5E8A26
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiIXIZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiIXIZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:25:46 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCC99834E;
        Sat, 24 Sep 2022 01:25:44 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 28O8ORHv029703;
        Sat, 24 Sep 2022 17:24:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 28O8ORHv029703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664007868;
        bh=sMkUufAHfBH0H8k/JIFMju5E/jWE8QckwtzK4cXYTF8=;
        h=From:To:Cc:Subject:Date:From;
        b=m0C5CfoOdkAyiNI1SRjgJjSLjw8gATM4RCnPNqUdbTqBMbGWTIQAJGfEsZU1IGIFQ
         aJ7F1aRA5ZxQDSYPYNkXkZDSHKtq6eW61ydFMeCgOSraxqgQCH1hDSTaSeveJPlCsB
         WVMhkBjC6G7anyXe2pUA2b3h1Lz/pB5ocfjClSskucEIA1UBeePipas8DS/m/W6GqG
         soVivyR65/a5Joe9MuBWXi9XA0YEn0oLMYK/SOcyHX2L9yakn9CArFshYHtqWZZQro
         x5gscvzP4B0m5AqUD6ulZh1qoA/w4NyOAp3UHmmbwr41lV6+hIvW+E52C8x+9+bzQb
         udnFiE86ot/pw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] kbuild: hide error checker logs for V=1 builds
Date:   Sat, 24 Sep 2022 17:24:25 +0900
Message-Id: <20220924082425.3116757-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V=1 (verbose build) shows commands executed by Make, but it may cause
misunderstanding.

For example, the following command shows the outstanding error message.

  $ make V=1 INSTALL_PATH=/tmp install
  test -e include/generated/autoconf.h -a -e include/config/auto.conf || (                \
  echo >&2;                                                       \
  echo >&2 "  ERROR: Kernel configuration is invalid.";           \
  echo >&2 "         include/generated/autoconf.h or include/config/auto.conf are missing.";\
  echo >&2 "         Run 'make oldconfig && make prepare' on kernel src to fix it.";      \
  echo >&2 ;                                                      \
  /bin/false)
    unset sub_make_done; ./scripts/install.sh

It is not an error. Make just showed the recipe lines it has executed,
but people may think that 'make install' has failed.

Likewise, the combination of V=1 and O= shows confusing
"*** The source tree is not clean, please run 'make mrproper'".

Suppress such misleading logs.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a5e9d9388649..833052fcf48a 100644
--- a/Makefile
+++ b/Makefile
@@ -583,7 +583,7 @@ quiet_cmd_makefile = GEN     Makefile
 	} > Makefile
 
 outputmakefile:
-	$(Q)if [ -f $(srctree)/.config -o \
+	@if [ -f $(srctree)/.config -o \
 		 -d $(srctree)/include/config -o \
 		 -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
 		echo >&2 "***"; \
@@ -739,7 +739,7 @@ else # !may-sync-config
 PHONY += include/config/auto.conf
 
 include/config/auto.conf:
-	$(Q)test -e include/generated/autoconf.h -a -e $@ || (		\
+	@test -e include/generated/autoconf.h -a -e $@ || (		\
 	echo >&2;							\
 	echo >&2 "  ERROR: Kernel configuration is invalid.";		\
 	echo >&2 "         include/generated/autoconf.h or $@ are missing.";\
-- 
2.34.1

