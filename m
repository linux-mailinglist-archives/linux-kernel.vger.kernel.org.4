Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0F6AE1BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCGOIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjCGOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:07:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5127E787
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD1AC6145E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B4CC4339E;
        Tue,  7 Mar 2023 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198039;
        bh=7Sb3pK6D439uyI1XL+ABWWcj41jxBle1rc2gq0YdsQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tixza3fh2iLkW/0IOjwq8L0ccv12ajKwiWMFqjfERXEu7HSt5xQM4RMYD7XEP+u79
         cfhBU+nzvjZBjDx3bgCjXKLyksXOKPU0r00+EubWat9SsXgv5itENFu5pbP8S+Khok
         +i+XwncHtc+7xzoTav3Op9UyxCrW9h3ACRAAPn7/c519u535tcluevGZlBqZfYgX9B
         X+gchjw4P+K9x/PifAighK4hf1I3bqYuN8DvEACQkc6nF/m9Rf3N8Rv/ACT2rD4Wx9
         S2Sixivicqys7VHcN5FR6vb+p1YnTRFtbefl8HAaPlo4LAKcCdMyLzU6vYx2DNRWe+
         A8ZOrhygGINOw==
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
Subject: [PATCH v3 17/60] arm64: idreg-override: Omit non-NULL checks for override pointer
Date:   Tue,  7 Mar 2023 15:04:39 +0100
Message-Id: <20230307140522.2311461-18-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=ardb@kernel.org; h=from:subject; bh=7Sb3pK6D439uyI1XL+ABWWcj41jxBle1rc2gq0YdsQ8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdRd1lZ7VMw4MrKsxPpF5dipOxfnDdPsrv7sykWMHlj du3/JLpKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMpD2b4p/h4qfT+1/9YMlfO CFV51uRQs1Rtrfrtf+2ZbE4/Zc+EOzL89/g4f2FIxvHNs59XOy5bYpC4UCGBU+7KpFPbGLQa2ZJ kGQA=
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

Now that override pointers are always set, we can drop the various
non-NULL checks that we have in the code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/idreg-override.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 434703e4e55cb785..b6e90ee6857eb758 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -196,9 +196,6 @@ static void __init match_options(const char *cmdline)
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
 		int f;
 
-		if (!regs[i]->override)
-			continue;
-
 		for (f = 0; strlen(regs[i]->fields[f].name); f++) {
 			u64 shift = regs[i]->fields[f].shift;
 			u64 width = regs[i]->fields[f].width ?: 4;
@@ -299,10 +296,8 @@ asmlinkage void __init init_feature_override(u64 boot_status)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
-		if (regs[i]->override) {
-			regs[i]->override->val  = 0;
-			regs[i]->override->mask = 0;
-		}
+		regs[i]->override->val  = 0;
+		regs[i]->override->mask = 0;
 	}
 
 	__boot_status = boot_status;
@@ -310,9 +305,8 @@ asmlinkage void __init init_feature_override(u64 boot_status)
 	parse_cmdline();
 
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
-		if (regs[i]->override)
-			dcache_clean_inval_poc((unsigned long)regs[i]->override,
-					    (unsigned long)regs[i]->override +
-					    sizeof(*regs[i]->override));
+		dcache_clean_inval_poc((unsigned long)regs[i]->override,
+				       (unsigned long)regs[i]->override +
+				       sizeof(*regs[i]->override));
 	}
 }
-- 
2.39.2

