Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4B6C415D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCVEAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCVEAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839047816
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E2FD61F34
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2833C433D2;
        Wed, 22 Mar 2023 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457623;
        bh=/ZLm+wrxs/+a1i9Qeb7J2lVK+Z8NtDgtRnyNWD9EKik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhGzl+6tp6p2aIHnYK6VuYlsZHXLK2dZkWI2BXJoYnVP75G2Z+CueGy7ydubG4iMP
         bS7L3DdGct2/BXryFCIUDHFL3OGlhwMmLKZ69nBm8kN45PBzmphOSExrZyxVQ4ReXL
         GhG1BnZlHj312ZUYnEQ29g+5rwOuJkSTUmvt4Z0vfKNpgSMPMjMCP9FLAxjfqZJKE+
         5od/w9oWaqkegqfv6h6kQRTcyMljerNSWk989DL2pQ2vWR0gS+WUzQOZcU5tmJZ+Lv
         tlxGFsu4Ci7j8vQLQpjiOND2gMaJaL2gF0q/LbUGrY9ydPWvk66IW+lVICtmxyPixb
         91wRAm4clwOtQ==
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
Subject: [PATCH v2 02/11] static_call: Flip key type union bit
Date:   Tue, 21 Mar 2023 21:00:08 -0700
Message-Id: <a7f3a10a7dedfd41cc25bdc5bf35e74d3483a684.1679456900.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679456900.git.jpoimboe@kernel.org>
References: <cover.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flip the meaning of the key->type union field.  This will make it easier
to converge some of the DECLARE_STATIC_CALL() macros.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/static_call.h             | 3 ---
 include/linux/static_call_types.h       | 4 ++--
 tools/include/linux/static_call_types.h | 4 ++--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 141e6b176a1b..f984b8f6d974 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -186,7 +186,6 @@ extern long __static_call_return0(void);
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = _func,						\
-		.type = 1,						\
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
@@ -194,7 +193,6 @@ extern long __static_call_return0(void);
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = NULL,						\
-		.type = 1,						\
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
@@ -202,7 +200,6 @@ extern long __static_call_return0(void);
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = __static_call_return0,				\
-		.type = 1,						\
 	};								\
 	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 87c3598609e8..c4c4efb6f6fa 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -61,10 +61,10 @@ struct static_call_site {
 struct static_call_key {
 	void *func;
 	union {
-		/* bit 0: 0 = mods, 1 = sites */
+		/* bit 0: 0 = sites, 1 = mods */
 		unsigned long type;
-		struct static_call_mod *_mods;
 		struct static_call_site *_sites;
+		struct static_call_mod *_mods;
 	};
 };
 
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 87c3598609e8..c4c4efb6f6fa 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -61,10 +61,10 @@ struct static_call_site {
 struct static_call_key {
 	void *func;
 	union {
-		/* bit 0: 0 = mods, 1 = sites */
+		/* bit 0: 0 = sites, 1 = mods */
 		unsigned long type;
-		struct static_call_mod *_mods;
 		struct static_call_site *_sites;
+		struct static_call_mod *_mods;
 	};
 };
 
-- 
2.39.2

