Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7286AE1BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCGOIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjCGOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:07:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3048E84F6F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB546143F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B8CC433A7;
        Tue,  7 Mar 2023 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198034;
        bh=U9Q2LWSJSvk5m1MyFlpjrltj8tlAIY8VDuwltSIfhXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIJ/gOJheON8Aji0qDNhQnEuwDW+QhHyhlXMvKQh6vVAZLh0STmdvxvoH5/BNUnwZ
         xGzDlcNyVp21u+h8JbSnk142i3mHFJukXTNWBJ6aw1RmaIbf8rLIULZPu+HBfwIqhu
         Ux8ZNB//NMLY5KDo0p5ZavKJVmr3r0z2uCpaOLhxGfnaralV01HeefZvtUIfNl66UF
         Zi69BEXLblnsIXv6g0g1R6Cgr2EFgYnoavH/m01/ojo4PxGxFloAymQvQOh3oZ2y/E
         9VjTrQuuUq+CaQ5sGpFJOC4tgF+pBn/SZc9y3PSsOW4sCEDGjuKONibxqN4ZtfGnTg
         qTBMLKqMaZ0IQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 15/60] arm64: kernel: Don't rely on objcopy to make code under pi/ __init
Date:   Tue,  7 Mar 2023 15:04:37 +0100
Message-Id: <20230307140522.2311461-16-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3206; i=ardb@kernel.org; h=from:subject; bh=U9Q2LWSJSvk5m1MyFlpjrltj8tlAIY8VDuwltSIfhXY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdRbG38f/aXp9Pgttn779Utcn/n7TWPZPmGPOFM76wZ uf9NDrbUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSGs7wT/G007ec+QdK2F44 ciTFyzPn5e43fbCWc6/Qed7bqjPFYhkZ1qz0b79+Je8Yw8Lwq7FHlSYy5/5bFOnqlXvia35F9LV kTgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will add some code under pi/ that contains global variables that
should not end up in __initdata, as they will not be writable via the
initial ID map. So only rely on objcopy for making the libfdt code
__init, and use explicit annotations for the rest.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/pi/Makefile      |  6 ++++--
 arch/arm64/kernel/pi/kaslr_early.c | 16 +++++++++-------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index bc32a431fe35e6f4..2bbe866417d453ff 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -28,11 +28,13 @@ quiet_cmd_piobjcopy = $(quiet_cmd_objcopy)
       cmd_piobjcopy = $(cmd_objcopy) && $(obj)/relacheck $(@) $(<)
 
 $(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
-			       --remove-section=.note.gnu.property \
-			       --prefix-alloc-sections=.init
+			       --remove-section=.note.gnu.property
 $(obj)/%.pi.o: $(obj)/%.o $(obj)/relacheck FORCE
 	$(call if_changed,piobjcopy)
 
+# ensure that all the lib- code ends up as __init code and data
+$(obj)/lib-%.pi.o: OBJCOPYFLAGS += --prefix-alloc-sections=.init
+
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index b9e0bb4bc6a9766f..167081b30a152d0a 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -17,7 +17,7 @@
 #include <asm/pgtable.h>
 
 /* taken from lib/string.c */
-static char *__strstr(const char *s1, const char *s2)
+static char *__init __strstr(const char *s1, const char *s2)
 {
 	size_t l1, l2;
 
@@ -33,7 +33,7 @@ static char *__strstr(const char *s1, const char *s2)
 	}
 	return NULL;
 }
-static bool cmdline_contains_nokaslr(const u8 *cmdline)
+static bool __init cmdline_contains_nokaslr(const u8 *cmdline)
 {
 	const u8 *str;
 
@@ -41,7 +41,7 @@ static bool cmdline_contains_nokaslr(const u8 *cmdline)
 	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
 }
 
-static bool is_kaslr_disabled_cmdline(void *fdt)
+static bool __init is_kaslr_disabled_cmdline(void *fdt)
 {
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
 		int node;
@@ -67,17 +67,19 @@ static bool is_kaslr_disabled_cmdline(void *fdt)
 	return cmdline_contains_nokaslr(CONFIG_CMDLINE);
 }
 
-static u64 get_kaslr_seed(void *fdt)
+static u64 __init get_kaslr_seed(void *fdt)
 {
+	static char const chosen_str[] __initconst = "chosen";
+	static char const seed_str[] __initconst = "kaslr-seed";
 	int node, len;
 	fdt64_t *prop;
 	u64 ret;
 
-	node = fdt_path_offset(fdt, "/chosen");
+	node = fdt_path_offset(fdt, chosen_str);
 	if (node < 0)
 		return 0;
 
-	prop = fdt_getprop_w(fdt, node, "kaslr-seed", &len);
+	prop = fdt_getprop_w(fdt, node, seed_str, &len);
 	if (!prop || len != sizeof(u64))
 		return 0;
 
@@ -86,7 +88,7 @@ static u64 get_kaslr_seed(void *fdt)
 	return ret;
 }
 
-asmlinkage u64 kaslr_early_init(void *fdt)
+asmlinkage u64 __init kaslr_early_init(void *fdt)
 {
 	u64 seed, range;
 
-- 
2.39.2

