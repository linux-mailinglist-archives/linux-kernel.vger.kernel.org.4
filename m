Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42D6C41C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCVFDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCVFDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:03:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407BA14E82
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 22:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1329B81B29
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37E0C4339C;
        Wed, 22 Mar 2023 05:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679461388;
        bh=2KtW1Lnib2feHqEoqkzNfI71iObhYI3VaiAcQaFXJbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVgVWtLMsr4kdVscUtxoc3uxRNMkWoJW7QhRewmKMLEpokp3lC6+4RCsHKZG/X/TM
         ur9kXlShS+fe4vcsxA0zUxFrYpibCEnxYeLPVXDpWWApn1+56qmJvoLEIiQcBBfF4T
         v1y+S7OTlXFOrgO4NME5TyokgYTD4grjZm2mPbaqsduQNT1hS7E2GI+jmta6sjmoiJ
         9w6RWbysbPXtA+fz8+4sxEnRPqKZE71R/883PVvmezNoknKdbP0lROk6HUSoNZRrg6
         HzAoMwUrENCd4kmZCeXZGm9Qk/G92HpR342EAfXQioO/Rtqiz4gH+4uqHfrdkprfk7
         hWQM+4VLHw9MQ==
Date:   Tue, 21 Mar 2023 22:03:06 -0700
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
Subject: [PATCH v2.1 02/11] static_call: Flip key type union bit
Message-ID: <20230322050306.zizbrqc2hwl5s4tj@treble>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <a7f3a10a7dedfd41cc25bdc5bf35e74d3483a684.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7f3a10a7dedfd41cc25bdc5bf35e74d3483a684.1679456900.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
 kernel/static_call_inline.c             | 8 ++++----
 tools/include/linux/static_call_types.h | 4 ++--
 4 files changed, 8 insertions(+), 11 deletions(-)

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
 
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 1328370d3cf6..41f6bda6773a 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -112,7 +112,7 @@ static inline void static_call_sort_entries(struct static_call_site *start,
 
 static inline bool static_call_key_has_mods(struct static_call_key *key)
 {
-	return !(key->type & 1);
+	return !!(key->type & 1);
 }
 
 static inline struct static_call_mod *static_call_key_mods(struct static_call_key *key)
@@ -120,12 +120,13 @@ static inline struct static_call_mod *static_call_key_mods(struct static_call_ke
 	if (!static_call_key_has_mods(key))
 		return NULL;
 
-	return key->_mods;
+	return (struct static_call_mod *)(key->type & ~1);
 }
 
 static inline void static_call_key_set_mods(struct static_call_key *key, struct static_call_mod *mods)
 {
 	key->_mods = mods;
+	key->type |= 1;
 }
 
 static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
@@ -133,13 +134,12 @@ static inline struct static_call_site *static_call_key_sites(struct static_call_
 	if (static_call_key_has_mods(key))
 		return NULL;
 
-	return (struct static_call_site *)(key->type & ~1);
+	return key->_sites;
 }
 
 static inline void static_call_key_set_sites(struct static_call_key *key, struct static_call_site *sites)
 {
 	key->_sites = sites;
-	key->type |= 1;
 }
 
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
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

