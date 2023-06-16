Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2873344D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbjFPPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbjFPPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:08:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989063AB4;
        Fri, 16 Jun 2023 08:08:20 -0700 (PDT)
Date:   Fri, 16 Jun 2023 15:08:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686928098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zo4BHRS0fFM3DRVeEcp3Ohgx+qJzY6kAau/PUgQhPQE=;
        b=f5o9Jl7hceRJsZU6/iFGqosfmB/NM9+kQ21MVe/aP8pttBmO4S5BKnkfZ4SUMT0qutP0f+
        85mW8grcG5OhgOG6537iRwFBsyVr8GE1aNXP+XiFGjZjprmNPQZgjMgj7uTLIQnAEgbHSf
        nMBzfg32Y2zH60hnCaLrS6H3eiFXh+J+5KpLJBw0zHqkCfSxN+19ofXGLAlE7RnGtouhia
        yT27xNfRrvx9NzdnnFVRRkMZckaEXFYv7wueFwO/GSjKKkmaCllwl2Sz7VODANzcL+W8M9
        7m6SwfOxUBm2jRbeeivIQof7jgROFB9m8rIFnnkVEO9BeXdupsCTNVj5QMWZ5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686928098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zo4BHRS0fFM3DRVeEcp3Ohgx+qJzY6kAau/PUgQhPQE=;
        b=hYZk3m7eGYTydA+bysyv7wKERNLpidQZ+1ufuM4lQTcOSHcj4P+L20nVYGD+wsKlV4fDnp
        YnFRC9e36YGEDKCw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: scripts: fix
 ${atomic}_dec_if_positive() kerneldoc
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230615132734.1119765-1-mark.rutland@arm.com>
References: <20230615132734.1119765-1-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168692809794.404.8967719378203068298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b33eb50a92b0a298fa8a6ac350e741c3ec100f6d
Gitweb:        https://git.kernel.org/tip/b33eb50a92b0a298fa8a6ac350e741c3ec100f6d
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Thu, 15 Jun 2023 14:27:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 16:46:30 +02:00

locking/atomic: scripts: fix ${atomic}_dec_if_positive() kerneldoc

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20230615132734.1119765-1-mark.rutland@arm.com
---
 include/linux/atomic/atomic-arch-fallback.h | 6 +++---
 include/linux/atomic/atomic-instrumented.h  | 8 ++++----
 include/linux/atomic/atomic-long.h          | 4 ++--
 scripts/atomic/kerneldoc/dec_if_positive    | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 8cded57..18f5744 100644
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
index ebfc795..d401b40 100644
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
index f6df2ad..c829471 100644
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
index 7c74286..04f1aed 100644
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
