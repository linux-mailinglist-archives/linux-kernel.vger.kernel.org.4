Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031D57319EC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbjFON1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbjFON1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:27:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5972D273C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:27:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D7A71FB;
        Thu, 15 Jun 2023 06:28:26 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E21B73F64C;
        Thu, 15 Jun 2023 06:27:40 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, keescook@chromium.org, mark.rutland@arm.com,
        paulmck@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH] locking/atomic: scripts: fix ${atomic}_dec_if_positive() kerneldoc
Date:   Thu, 15 Jun 2023 14:27:34 +0100
Message-Id: <20230615132734.1119765-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ${atomic}_dec_if_positive() ops are unlike all the other conditional
atomic ops. Rather than returning a boolean success value, these return
the value that the atomic variable would be updated to, even when no
update is performed.

We missed this when adding kerneldoc comments, and the documentation for
${atomic}_dec_if_positive() erroneously states:

| Return: @true if @v was updated, @false otherwise.

Ideally we'd clean this up by aligning ${atomic}_dec_if_positive() with
the usual atomic op conventions: with ${atomic}_fetch_dec_if_positive()
for those who care about the value of the varaible, and
${atomic}_dec_if_positive() returning a boolean success value.

In the mean time, align the documentation with the current reality.

Fixes: ad8110706f381170 ("locking/atomic: scripts: generate kerneldoc comments")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/atomic/atomic-arch-fallback.h | 6 +++---
 include/linux/atomic/atomic-instrumented.h  | 8 ++++----
 include/linux/atomic/atomic-long.h          | 4 ++--
 scripts/atomic/kerneldoc/dec_if_positive    | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 8cded57dd7a6f..18f5744dfb5d8 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -2520,7 +2520,7 @@ raw_atomic_dec_unless_positive(atomic_t *v)
  *
  * Safe to use in noinstr code; prefer atomic_dec_if_positive() elsewhere.
  *
- * Return: @true if @v was updated, @false otherwise.
+ * Return: The old value of (@v - 1), regardless of whether @v was updated.
  */
 static __always_inline int
 raw_atomic_dec_if_positive(atomic_t *v)
@@ -4636,7 +4636,7 @@ raw_atomic64_dec_unless_positive(atomic64_t *v)
  *
  * Safe to use in noinstr code; prefer atomic64_dec_if_positive() elsewhere.
  *
- * Return: @true if @v was updated, @false otherwise.
+ * Return: The old value of (@v - 1), regardless of whether @v was updated.
  */
 static __always_inline s64
 raw_atomic64_dec_if_positive(atomic64_t *v)
@@ -4657,4 +4657,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 3916f02c038baa3f5190d275f68b9211667fcc9d
+// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index ebfc795f921b9..d401b406ef7c4 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1570,7 +1570,7 @@ atomic_dec_unless_positive(atomic_t *v)
  *
  * Unsafe to use in noinstr code; use raw_atomic_dec_if_positive() there.
  *
- * Return: @true if @v was updated, @false otherwise.
+ * Return: The old value of (@v - 1), regardless of whether @v was updated.
  */
 static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
@@ -3134,7 +3134,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
  *
  * Unsafe to use in noinstr code; use raw_atomic64_dec_if_positive() there.
  *
- * Return: @true if @v was updated, @false otherwise.
+ * Return: The old value of (@v - 1), regardless of whether @v was updated.
  */
 static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
@@ -4698,7 +4698,7 @@ atomic_long_dec_unless_positive(atomic_long_t *v)
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_dec_if_positive() there.
  *
- * Return: @true if @v was updated, @false otherwise.
+ * Return: The old value of (@v - 1), regardless of whether @v was updated.
  */
 static __always_inline long
 atomic_long_dec_if_positive(atomic_long_t *v)
@@ -5000,4 +5000,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 06cec02e676a484857aee38b0071a1d846ec9457
+// 1568f875fef72097413caab8339120c065a39aa4
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index f6df2adadf997..c82947170ddc8 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -1782,7 +1782,7 @@ raw_atomic_long_dec_unless_positive(atomic_long_t *v)
  *
  * Safe to use in noinstr code; prefer atomic_long_dec_if_positive() elsewhere.
  *
- * Return: @true if @v was updated, @false otherwise.
+ * Return: The old value of (@v - 1), regardless of whether @v was updated.
  */
 static __always_inline long
 raw_atomic_long_dec_if_positive(atomic_long_t *v)
@@ -1795,4 +1795,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 029d2e3a493086671e874a4c2e0e42084be42403
+// 4ef23f98c73cff96d239896175fd26b10b88899e
diff --git a/scripts/atomic/kerneldoc/dec_if_positive b/scripts/atomic/kerneldoc/dec_if_positive
index 7c742866fb6b6..04f1aed3cf830 100644
--- a/scripts/atomic/kerneldoc/dec_if_positive
+++ b/scripts/atomic/kerneldoc/dec_if_positive
@@ -7,6 +7,6 @@ cat <<EOF
  *
  * ${desc_noinstr}
  *
- * Return: @true if @v was updated, @false otherwise.
+ * Return: The old value of (@v - 1), regardless of whether @v was updated.
  */
 EOF
-- 
2.30.2

