Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBBC6AE1D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCGOKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCGOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E49457C3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D5E0B818F7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162C8C433A4;
        Tue,  7 Mar 2023 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198068;
        bh=CV00tA1owwhL5iVLNA3OX5N4V06U/3a14L0hLSw4Z+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Apj8QK2LYxIPN6TPi3s8XsZjMjAzSIMpZAn/Ry+HFYLF8mn+L4PwOdncNL7QppMfI
         /MX112JO4GIYJ0BQNtTObyOHSa5vhXH0hvhLq6UWGgDU8fqINKnxDew4OpG/TFsFAX
         yQOgf48VJpujIsL7479ZKLJ+1YplyNna4lX22nicC4KaC0gV/6wn5I1GxJuqdIKUM2
         waJjr1kebV9uS42NBCaCZ9dbI9pc6Skoj6TRNYqWjsJgoAhC/gpGjJQ3LabzCk5xrg
         HAHIDZ4sYMTysWoMuL2E6cW9h5t0Si7K4i6UfzpcreS8WDb0zxtmdKs5p0qUSItNJi
         dsGljiMawT+3g==
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
Subject: [PATCH v3 29/60] arm64: kaslr: Use feature override instead of parsing the cmdline again
Date:   Tue,  7 Mar 2023 15:04:51 +0100
Message-Id: <20230307140522.2311461-30-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; i=ardb@kernel.org; h=from:subject; bh=CV00tA1owwhL5iVLNA3OX5N4V06U/3a14L0hLSw4Z+0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxaM6dNJ0j9fn1VSuNdiv/y/8yulq9uHsxeWfdtwxO dlhYHmyo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkvTzDP2uZq+s4j4peCPzB sHbatzs7jTKWn111LiPdQO6lkU8Ttx7DT8as1lfHnjkEeJQnzWt8rHG9KujOz9a9G0w/H7o93WP aN14A
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

The early kaslr code open codes the detection of 'nokaslr' on the kernel
command line, and this is no longer necessary now that the feature
detection code, which also looks for the same string, executes before
this code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/pi/kaslr_early.c | 53 +-------------------
 1 file changed, 1 insertion(+), 52 deletions(-)

diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index 167081b30a152d0a..f2305e276ec36803 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -16,57 +16,6 @@
 #include <asm/memory.h>
 #include <asm/pgtable.h>
 
-/* taken from lib/string.c */
-static char *__init __strstr(const char *s1, const char *s2)
-{
-	size_t l1, l2;
-
-	l2 = strlen(s2);
-	if (!l2)
-		return (char *)s1;
-	l1 = strlen(s1);
-	while (l1 >= l2) {
-		l1--;
-		if (!memcmp(s1, s2, l2))
-			return (char *)s1;
-		s1++;
-	}
-	return NULL;
-}
-static bool __init cmdline_contains_nokaslr(const u8 *cmdline)
-{
-	const u8 *str;
-
-	str = __strstr(cmdline, "nokaslr");
-	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
-}
-
-static bool __init is_kaslr_disabled_cmdline(void *fdt)
-{
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
-		int node;
-		const u8 *prop;
-
-		node = fdt_path_offset(fdt, "/chosen");
-		if (node < 0)
-			goto out;
-
-		prop = fdt_getprop(fdt, node, "bootargs", NULL);
-		if (!prop)
-			goto out;
-
-		if (cmdline_contains_nokaslr(prop))
-			return true;
-
-		if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
-			goto out;
-
-		return false;
-	}
-out:
-	return cmdline_contains_nokaslr(CONFIG_CMDLINE);
-}
-
 static u64 __init get_kaslr_seed(void *fdt)
 {
 	static char const chosen_str[] __initconst = "chosen";
@@ -92,7 +41,7 @@ asmlinkage u64 __init kaslr_early_init(void *fdt)
 {
 	u64 seed, range;
 
-	if (is_kaslr_disabled_cmdline(fdt))
+	if (kaslr_disabled_cmdline())
 		return 0;
 
 	seed = get_kaslr_seed(fdt);
-- 
2.39.2

