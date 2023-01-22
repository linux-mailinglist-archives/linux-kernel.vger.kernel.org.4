Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FEE676D84
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjAVOO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjAVOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:14:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0466D1A960;
        Sun, 22 Jan 2023 06:14:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84D9160C33;
        Sun, 22 Jan 2023 14:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE931C433EF;
        Sun, 22 Jan 2023 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674396881;
        bh=54/WoMZ8YydDCjSCHnhXruffaj7Qo/EOB9FpfM9dfE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKaHTJNU+lxxXBEbp3aV2wH/EkaNYfJE0weeBS2a9lRuj9k8T63GLvWo6LHMY2Tft
         oTXgc7CPLEpt92WRC5w5S8c+73JSshZYcMdQHtoCVHHdcU5SWECLLW/mKJW8L+vanI
         VtuiHWbP5iG6BBFnT0QLXB4fS648rna4lgLV8xGEiYtro0jyDtIpoeb7W+rj/n6kr9
         itpHQkz+yqnSQsocunshqIBDu51acPdu6+dxuCXrBHNXGnMQXHypkt1kKWgWkpkLB+
         2xh0HqQuPQcz/pC7LMwtCwm4+F+EfVFIosNv67uPBjVvRWRchbqkjRhaLGnoF2Xe7D
         Sdos3Z3ba/ktw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 7/7] kbuild: do not re-run setlocalversion for kernelrelease
Date:   Sun, 22 Jan 2023 23:14:27 +0900
Message-Id: <20230122141428.115372-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230122141428.115372-1-masahiroy@kernel.org>
References: <20230122141428.115372-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert:
  - 7b8ea53d7f18 ("makefile: not need to regenerate kernel.release
    file when make kernelrelease")

  - 01ab17887f4c ("Makefile: "make kernelrelease" should show the
    correct full kernel version")

I think the original behavior was better - 'make kernelrelease' should
print $(KERNELRELEASE) used in the last build, not the one that will
be used in the next build. Therefore, it is an error if you run it in
the pristine source tree.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index d0a95277f08a..de402d415d5f 100644
--- a/Makefile
+++ b/Makefile
@@ -281,13 +281,13 @@ clean-targets := %clean mrproper cleandocs
 no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers headers_% archheaders archscripts \
-			 %asm-generic kernelversion %src-pkg dt_binding_check \
+			 %asm-generic kernelrelease kernelversion %src-pkg dt_binding_check \
 			 outputmakefile rustavailable rustfmt rustfmtcheck
 # Installation targets should not require compiler. Unfortunately, vdso_install
 # is an exception where build artifacts may be updated. This must be fixed.
 no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
-			headers_install modules_install kernelrelease image_name
-no-sync-config-targets := $(no-dot-config-targets) %install kernelrelease \
+			headers_install modules_install image_name
+no-sync-config-targets := $(no-dot-config-targets) %install \
 			  image_name
 single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %/
 
@@ -1677,7 +1677,7 @@ help:
 	@echo  '  tags/TAGS	  - Generate tags file for editors'
 	@echo  '  cscope	  - Generate cscope index'
 	@echo  '  gtags           - Generate GNU GLOBAL index'
-	@echo  '  kernelrelease	  - Output the release version string (use with make -s)'
+	@echo  '  kernelrelease	  - Output the release version string used in the last build (use with make -s)'
 	@echo  '  kernelversion	  - Output the version stored in Makefile (use with make -s)'
 	@echo  '  image_name	  - Output the image name (use with make -s)'
 	@echo  '  headers_install - Install sanitised kernel headers to INSTALL_HDR_PATH'; \
@@ -2111,7 +2111,7 @@ checkstack:
 	$(PERL) $(srctree)/scripts/checkstack.pl $(CHECKSTACK_ARCH)
 
 kernelrelease:
-	@$(srctree)/scripts/setlocalversion $(srctree)
+	@echo $(or $(KERNELRELEASE),$(error kernelrelease not valid - run 'make prepare' to update it))
 
 kernelversion:
 	@echo $(KERNELVERSION)
-- 
2.34.1

