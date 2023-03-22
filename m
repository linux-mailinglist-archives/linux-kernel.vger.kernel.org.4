Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3036C4160
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCVEAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCVEA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F64498BE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD019B81B00
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBB5C433A0;
        Wed, 22 Mar 2023 04:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457625;
        bh=sFv6ysPUwwSbqqWjEUzZkiH5GZXLdn6WWf8JJtLGU/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FZJk/OvUzmqLG/R/sYpJ6Vr6cd1GnPQkyYrekaqKgoZ5rBsnjCby6AB+sj1A0BEdm
         VubwVNbQmJDhiUSbSRGqKopbYYaDbAXY6NgBSOYz3d7ATuiyJqChlBE/A0bMRlRJi+
         sr0RIFPgITofS1+T43065v5YQs6L3DX4ahWtO/hg+z/CzJYIM0t7rNJhmLxmLIsdhO
         MbUka1rwx6N/txtdlG2qJTR6qTacHU3+q06f6H6XT5EhEFxYQNEDdAakAd5HUaLQa2
         o8SdapoGOryqKsXD4VMhPRxOfvhPF+iS6oti4kMGhC70sHYv3B2ukSP9jZicqsK+w9
         6JJlwBTXj3rUA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/11] static_call: Make ARCH_ADD_TRAMP_KEY() generic
Date:   Tue, 21 Mar 2023 21:00:11 -0700
Message-Id: <6a0d8889143580b3eac61ecabca783a5e8ad1bad.1679456900.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679456900.git.jpoimboe@kernel.org>
References: <cover.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's nothing arch-specific about ARCH_ADD_TRAMP_KEY().  Move it to
the generic static_call.h.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/static_call.h |  6 ------
 include/linux/static_call.h        | 11 +++++++++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 343b722ccaf2..52abbdfd6106 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -57,12 +57,6 @@
 #define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)			\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, __static_call_return0)
 
-#define ARCH_ADD_TRAMP_KEY(name)					\
-	asm(".pushsection .static_call_tramp_key, \"a\"		\n"	\
-	    ".long " STATIC_CALL_TRAMP_STR(name) " - .		\n"	\
-	    ".long " STATIC_CALL_KEY_STR(name) " - .		\n"	\
-	    ".popsection					\n")
-
 extern bool __static_call_fixup(void *tramp, u8 op, void *dest);
 
 #endif /* _ASM_STATIC_CALL_H */
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index abce40166039..013022a8611d 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -213,10 +213,17 @@ extern long __static_call_return0(void);
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
-	ARCH_ADD_TRAMP_KEY(name)
+	__STATIC_CALL_ADD_TRAMP_KEY(name)
 #define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
-	ARCH_ADD_TRAMP_KEY(name)
+	__STATIC_CALL_ADD_TRAMP_KEY(name)
+
+/* Unexported key lookup table */
+#define __STATIC_CALL_ADD_TRAMP_KEY(name)				\
+	asm(".pushsection .static_call_tramp_key, \"a\"		\n"	\
+	    ".long " STATIC_CALL_TRAMP_STR(name) " - .		\n"	\
+	    ".long " STATIC_CALL_KEY_STR(name) " - .		\n"	\
+	    ".popsection					\n")
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
-- 
2.39.2

