Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5A6B5200
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjCJUeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCJUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:33:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C17F76E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4562B61D4D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471BBC433A1;
        Fri, 10 Mar 2023 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678480308;
        bh=yMo6mdBxavTxXroIIa/I0/ynsahgXKDKMHjOHkltf0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDBbjZZZOXowJzL/k0G4ozYPUDsri43IgnECnwBjCtR31RJeSMu6eKLZ2RgdXgXLL
         DrLuv40QCYcEUsh0eKHNR6GtyVLeK4hnXnCYXtHWXSHkqilqbKO1dEPSkecGAK4nn7
         n7UcCK99cPPVeWFrkUlueiqbp2K4quxWCNPJBiayd0tBx4OCFF+/8GeVbjqgiNb3Fh
         H/xomz7ZxXjejGVAatuZHoCa/3Xy57oPE+sgfddt+UpL+pIUzKy8FJN6naTga3eUdi
         aKPlMHcoGP/hUXu/+4T/+z8sdn2vyVbc3iUdPNySwtB69TneGDD15ubvLISlC4h+gn
         haex9ypNqUxcw==
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
        Sean Christopherson <seanjc@google.com>
Subject: [RFC][PATCH 1/5] static_call: Make NULL static calls consistent
Date:   Fri, 10 Mar 2023 12:31:13 -0800
Message-Id: <016c1e9cbdf726a885a406ff6baed85087ad1213.1678474914.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678474914.git.jpoimboe@kernel.org>
References: <cover.1678474914.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL static calls have inconsistent behavior.  With HAVE_STATIC_CALL=y
they're a NOP, but with HAVE_STATIC_CALL=n they're a panic.

That's guaranteed to cause subtle bugs.  Make the behavior consistent by
making NULL static calls a NOP with HAVE_STATIC_CALL=n.

This is probably easier than doing the reverse (making NULL static calls
panic with HAVE_STATIC_CALL=y).

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/static_call.h | 53 +++++++------------------------------
 1 file changed, 9 insertions(+), 44 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 141e6b176a1b..8b12216da0da 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -65,20 +65,12 @@
  *
  * Notes on NULL function pointers:
  *
- *   Static_call()s support NULL functions, with many of the caveats that
- *   regular function pointers have.
+ *   A static_call() to a NULL function pointer is a NOP.
  *
- *   Clearly calling a NULL function pointer is 'BAD', so too for
- *   static_call()s (although when HAVE_STATIC_CALL it might not be immediately
- *   fatal). A NULL static_call can be the result of:
+ *   A NULL static call can be the result of:
  *
  *     DECLARE_STATIC_CALL_NULL(my_static_call, void (*)(int));
  *
- *   which is equivalent to declaring a NULL function pointer with just a
- *   typename:
- *
- *     void (*my_func_ptr)(int arg1) = NULL;
- *
  *   or using static_call_update() with a NULL function. In both cases the
  *   HAVE_STATIC_CALL implementation will patch the trampoline with a RET
  *   instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
@@ -92,13 +84,6 @@
  *
  *   where the argument evaludation also depends on the pointer value.
  *
- *   When calling a static_call that can be NULL, use:
- *
- *     static_call_cond(name)(arg1);
- *
- *   which will include the required value tests to avoid NULL-pointer
- *   dereferences.
- *
  *   To query which function is currently set to be called, use:
  *
  *   func = static_call_query(name);
@@ -106,7 +91,7 @@
  *
  * DEFINE_STATIC_CALL_RET0 / __static_call_return0:
  *
- *   Just like how DEFINE_STATIC_CALL_NULL() / static_call_cond() optimize the
+ *   Just like how DEFINE_STATIC_CALL_NULL() optimizes the
  *   conditional void function call, DEFINE_STATIC_CALL_RET0 /
  *   __static_call_return0 optimize the do nothing return 0 function.
  *
@@ -279,10 +264,12 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
-#else /* Generic implementation */
+#else /* !CONFIG_HAVE_STATIC_CALL */
 
 static inline int static_call_init(void) { return 0; }
 
+static inline void __static_call_nop(void) { }
+
 static inline long __static_call_return0(void)
 {
 	return 0;
@@ -298,39 +285,17 @@ static inline long __static_call_return0(void)
 	__DEFINE_STATIC_CALL(name, _func, _func)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
-	__DEFINE_STATIC_CALL(name, _func, NULL)
+	__DEFINE_STATIC_CALL(name, _func, __static_call_nop)
 
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
 	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
 
-static inline void __static_call_nop(void) { }
-
-/*
- * This horrific hack takes care of two things:
- *
- *  - it ensures the compiler will only load the function pointer ONCE,
- *    which avoids a reload race.
- *
- *  - it ensures the argument evaluation is unconditional, similar
- *    to the HAVE_STATIC_CALL variant.
- *
- * Sadly current GCC/Clang (10 for both) do not optimize this properly
- * and will emit an indirect call for the NULL case :-(
- */
-#define __static_call_cond(name)					\
-({									\
-	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
-	if (!func)							\
-		func = &__static_call_nop;				\
-	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
-})
-
-#define static_call_cond(name)	(void)__static_call_cond(name)
+#define static_call_cond(name) (void)static_call(name)
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
-	WRITE_ONCE(key->func, func);
+	WRITE_ONCE(key->func, func ? : (void *)__static_call_nop);
 }
 
 static inline int static_call_text_reserved(void *start, void *end)
-- 
2.39.2

