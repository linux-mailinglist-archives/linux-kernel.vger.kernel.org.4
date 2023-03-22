Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45C6C415C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCVEAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCVEAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6B347403
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 528A961E67
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A5C433EF;
        Wed, 22 Mar 2023 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457622;
        bh=dXZSCwSD/LB/FwBrcGE2iL96HfH7dZ9DVcvMcF87LjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oSKzXycDKQNaMvn2h8NBJQs2QZSi0Zh4P76GaPXTPlaXwOJ92MTbFHtmKvLg1fPUO
         hmAsQ5LTALa0dyq+apNn1KYtEKywnGn6nYoOwd7SxLof57UX6Tw2qFqYWYtIv23Oyj
         Pvw5wtxTTvbd7UXOIy8hTZsI4eCKXWroqpQZtnuykyOfVpiHBd2F4mbF5HwkoXnyRr
         o9dIG+laLvTs0VRmKAGWVVk4Wq0ud4oS7pn0wMSbkujqwCZyFpyq3NAv77ZmKM9WTs
         noCXFq9ny3o+k688pOnpE6y9YJrPQghaP4YW/orbGeAsiu67vsGNg89jAv1bExRo8M
         FSFlT7TPRcMAA==
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
Subject: [PATCH v2 01/11] static_call: Improve key type abstraction
Date:   Tue, 21 Mar 2023 21:00:07 -0700
Message-Id: <c8bc83b2c70aeaad3ce01d12dc1153981ab693f8.1679456900.git.jpoimboe@kernel.org>
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

Make the static_call_key union less fragile by abstracting all knowledge
about the type bit into helper functions.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/static_call_types.h       |  4 +-
 kernel/static_call_inline.c             | 51 +++++++++++++++++--------
 tools/include/linux/static_call_types.h |  4 +-
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 5a00b8b2cf9f..87c3598609e8 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -63,8 +63,8 @@ struct static_call_key {
 	union {
 		/* bit 0: 0 = mods, 1 = sites */
 		unsigned long type;
-		struct static_call_mod *mods;
-		struct static_call_site *sites;
+		struct static_call_mod *_mods;
+		struct static_call_site *_sites;
 	};
 };
 
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 639397b5491c..41f6bda6773a 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -112,15 +112,21 @@ static inline void static_call_sort_entries(struct static_call_site *start,
 
 static inline bool static_call_key_has_mods(struct static_call_key *key)
 {
-	return !(key->type & 1);
+	return !!(key->type & 1);
 }
 
-static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
+static inline struct static_call_mod *static_call_key_mods(struct static_call_key *key)
 {
 	if (!static_call_key_has_mods(key))
 		return NULL;
 
-	return key->mods;
+	return (struct static_call_mod *)(key->type & ~1);
+}
+
+static inline void static_call_key_set_mods(struct static_call_key *key, struct static_call_mod *mods)
+{
+	key->_mods = mods;
+	key->type |= 1;
 }
 
 static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
@@ -128,7 +134,12 @@ static inline struct static_call_site *static_call_key_sites(struct static_call_
 	if (static_call_key_has_mods(key))
 		return NULL;
 
-	return (struct static_call_site *)(key->type & ~1);
+	return key->_sites;
+}
+
+static inline void static_call_key_set_sites(struct static_call_key *key, struct static_call_site *sites)
+{
+	key->_sites = sites;
 }
 
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
@@ -154,7 +165,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 		goto done;
 
 	first = (struct static_call_mod){
-		.next = static_call_key_next(key),
+		.next = static_call_key_mods(key),
 		.mod = NULL,
 		.sites = static_call_key_sites(key),
 	};
@@ -250,8 +261,7 @@ static int __static_call_init(struct module *mod,
 			 * static_call_init() before memory allocation works.
 			 */
 			if (!mod) {
-				key->sites = site;
-				key->type |= 1;
+				static_call_key_set_sites(key, site);
 				goto do_transform;
 			}
 
@@ -266,10 +276,10 @@ static int __static_call_init(struct module *mod,
 			 */
 			if (static_call_key_sites(key)) {
 				site_mod->mod = NULL;
-				site_mod->next = NULL;
 				site_mod->sites = static_call_key_sites(key);
+				site_mod->next = NULL;
 
-				key->mods = site_mod;
+				static_call_key_set_mods(key, site_mod);
 
 				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
 				if (!site_mod)
@@ -278,8 +288,9 @@ static int __static_call_init(struct module *mod,
 
 			site_mod->mod = mod;
 			site_mod->sites = site;
-			site_mod->next = static_call_key_next(key);
-			key->mods = site_mod;
+			site_mod->next = static_call_key_mods(key);
+
+			static_call_key_set_mods(key, site_mod);
 		}
 
 do_transform:
@@ -406,7 +417,7 @@ static void static_call_del_module(struct module *mod)
 	struct static_call_site *stop = mod->static_call_sites +
 					mod->num_static_call_sites;
 	struct static_call_key *key, *prev_key = NULL;
-	struct static_call_mod *site_mod, **prev;
+	struct static_call_mod *site_mod, *prev;
 	struct static_call_site *site;
 
 	for (site = start; site < stop; site++) {
@@ -416,15 +427,25 @@ static void static_call_del_module(struct module *mod)
 
 		prev_key = key;
 
-		for (prev = &key->mods, site_mod = key->mods;
+		site_mod = static_call_key_mods(key);
+		if (!site_mod)
+			continue;
+
+		if (site_mod->mod == mod) {
+			static_call_key_set_mods(key, site_mod->next);
+			kfree(site_mod);
+			continue;
+		}
+
+		for (prev = site_mod, site_mod = site_mod->next;
 		     site_mod && site_mod->mod != mod;
-		     prev = &site_mod->next, site_mod = site_mod->next)
+		     prev = site_mod, site_mod = site_mod->next)
 			;
 
 		if (!site_mod)
 			continue;
 
-		*prev = site_mod->next;
+		prev->next = site_mod->next;
 		kfree(site_mod);
 	}
 }
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 5a00b8b2cf9f..87c3598609e8 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -63,8 +63,8 @@ struct static_call_key {
 	union {
 		/* bit 0: 0 = mods, 1 = sites */
 		unsigned long type;
-		struct static_call_mod *mods;
-		struct static_call_site *sites;
+		struct static_call_mod *_mods;
+		struct static_call_site *_sites;
 	};
 };
 
-- 
2.39.2

