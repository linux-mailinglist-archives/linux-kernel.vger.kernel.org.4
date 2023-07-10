Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9374DE25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjGJTZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGJTZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:25:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED1FFB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:24:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d805cb33aso6585453a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689017097; x=1691609097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jftu1XapvOLMzEYkqywXgUEUxuMrQszDRi+r4S9T/B8=;
        b=jFKS0dDJt25TajexlB3hdj0BfuVDTTR2cNBPmf6qukrN+1LWfsXoV1T2h3hMn11QA7
         PVdUNSGV8fNwqYlSRRmyhqaLM4ctHU2vDoVaOjgmxwQ1mTesI4qIpka4EGOuxewv/777
         HUwt1q2YZucKXu8Ew9w2AGcbpraL2lrANBy/H87nIkET4S/EVNiN5FxqKhHDkTHIr0AH
         ZRhGfVbts058LX9BW6ssPRYfynYgC9yAmNQ1V5Lu/Nsg0plw43AjSQyyQFRI7RPTBjD9
         VR9T8R8SOgbdiqHefLbmNbw0rrKfrtzs1LNjqjFnJNkDbwm/R0EED27L2yKFN9S4KtaW
         2i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689017097; x=1691609097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jftu1XapvOLMzEYkqywXgUEUxuMrQszDRi+r4S9T/B8=;
        b=Q3/YW+zMJm02Zc1n4xHFrMflYHrSogf2jZiLqTRAXeVUMVSTK2wtcnNDQYltJSRu9k
         KabzV7p/kIBqBjFlEkj8xc7m2v50OgtIIzHdUrDUHA5XWoj6S3nkUtBa7aFNUgAc0p0I
         EEl4BYZAxKbOkK/Xp0S70G3kBxNEq1+cJ9HYGossZMiwbNnQycRtEI06ll5EnOqqDsvn
         sfgQ02KdmGiZqEZvRBetf12R4XyT4uGzuq//B1ydmk9+7lWNpDTj4UQEBHV/xFpCSSMI
         G2c5KrgmwCKuGBf7wD8wz3x5Fdl5vGi89BNmB4IWnw30LVZbYtgh5c8JJioAn/f2IBMD
         w4LQ==
X-Gm-Message-State: ABy/qLZSUNqaJBMgf1EF0hupMRkYVsnDDJS14nv/b5o3xLNpLz/3K8UV
        uQrPdl1PGrrYsBIaWE6Fcq56rE3Co6Qy6Q==
X-Google-Smtp-Source: APBJJlH5IVyTpedE5IkFA68q07QVykSKpgW8fZffI7YRGbCbmTiXrGVpLLobb4Cs4f1LpCQFV5itgQ==
X-Received: by 2002:a17:906:edbb:b0:98d:63c5:d135 with SMTP id sa27-20020a170906edbb00b0098d63c5d135mr750873ejb.54.1689017097267;
        Mon, 10 Jul 2023 12:24:57 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id w15-20020a170906480f00b0096a6be0b66dsm110076ejq.208.2023.07.10.12.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:24:56 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/3] locking/generic: Add generic support for sync_try_cmpxchg and its falback
Date:   Mon, 10 Jul 2023 21:21:54 +0200
Message-ID: <20230710192440.47140-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the generic sync_try_cmpxchg function from the
raw_ prefixed version, also adding explicit instrumentation.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 15 +++++++++-
 include/linux/atomic/atomic-instrumented.h  | 10 ++++++-
 scripts/atomic/gen-atomic-fallback.sh       | 33 +++++++++++----------
 scripts/atomic/gen-atomic-instrumented.sh   |  3 +-
 4 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 18f5744dfb5d..037742c9f97d 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -428,6 +428,19 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 
 #define raw_sync_cmpxchg arch_sync_cmpxchg
 
+#ifdef arch_sync_try_cmpxchg
+#define raw_sync_try_cmpxchg arch_sync_try_cmpxchg
+#else
+#define raw_sync_try_cmpxchg(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = raw_sync_cmpxchg((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif
+
 /**
  * raw_atomic_read() - atomic load with relaxed ordering
  * @v: pointer to atomic_t
@@ -4657,4 +4670,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
+// 2eb1fe994b6dcab645bbb5a642a4aaa9374c5600
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index d401b406ef7c..54d7bbe0aeaa 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -4998,6 +4998,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	raw_try_cmpxchg128_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
+#define sync_try_cmpxchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	kcsan_mb(); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	raw_sync_try_cmpxchg(__ai_ptr, __VA_ARGS__); \
+})
+
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 1568f875fef72097413caab8339120c065a39aa4
+// 2cc4bc990fef44d3836ec108f11b610f3f438184
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index c0c8a85d7c81..d87148d6e588 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -223,14 +223,15 @@ gen_xchg_fallbacks()
 
 gen_try_cmpxchg_fallback()
 {
+	local prefix="$1"; shift
 	local cmpxchg="$1"; shift;
-	local order="$1"; shift;
+	local suffix="$1"; shift;
 
 cat <<EOF
-#define raw_try_${cmpxchg}${order}(_ptr, _oldp, _new) \\
+#define raw_${prefix}try_${cmpxchg}${suffix}(_ptr, _oldp, _new) \\
 ({ \\
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
-	___r = raw_${cmpxchg}${order}((_ptr), ___o, (_new)); \\
+	___r = raw_${prefix}${cmpxchg}${suffix}((_ptr), ___o, (_new)); \\
 	if (unlikely(___r != ___o)) \\
 		*___op = ___r; \\
 	likely(___r == ___o); \\
@@ -259,11 +260,11 @@ gen_try_cmpxchg_order_fallback()
 	fi
 
 	printf "#else\n"
-	gen_try_cmpxchg_fallback "${cmpxchg}" "${order}"
+	gen_try_cmpxchg_fallback "" "${cmpxchg}" "${order}"
 	printf "#endif\n\n"
 }
 
-gen_try_cmpxchg_fallbacks()
+gen_try_cmpxchg_order_fallbacks()
 {
 	local cmpxchg="$1"; shift;
 
@@ -272,15 +273,17 @@ gen_try_cmpxchg_fallbacks()
 	done
 }
 
-gen_cmpxchg_local_fallbacks()
+gen_def_and_try_cmpxchg_fallback()
 {
+	local prefix="$1"; shift
 	local cmpxchg="$1"; shift
+	local suffix="$1"; shift
 
-	printf "#define raw_${cmpxchg} arch_${cmpxchg}\n\n"
-	printf "#ifdef arch_try_${cmpxchg}\n"
-	printf "#define raw_try_${cmpxchg} arch_try_${cmpxchg}\n"
+	printf "#define raw_${prefix}${cmpxchg}${suffix} arch_${prefix}${cmpxchg}${suffix}\n\n"
+	printf "#ifdef arch_${prefix}try_${cmpxchg}${suffix}\n"
+	printf "#define raw_${prefix}try_${cmpxchg}${suffix} arch_${prefix}try_${cmpxchg}${suffix}\n"
 	printf "#else\n"
-	gen_try_cmpxchg_fallback "${cmpxchg}" ""
+	gen_try_cmpxchg_fallback "${prefix}" "${cmpxchg}" "${suffix}"
 	printf "#endif\n\n"
 }
 
@@ -302,15 +305,15 @@ for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128"; do
 done
 
 for cmpxchg in "cmpxchg" "cmpxchg64" "cmpxchg128"; do
-	gen_try_cmpxchg_fallbacks "${cmpxchg}"
+	gen_try_cmpxchg_order_fallbacks "${cmpxchg}"
 done
 
-for cmpxchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local"; do
-	gen_cmpxchg_local_fallbacks "${cmpxchg}" ""
+for cmpxchg in "cmpxchg" "cmpxchg64" "cmpxchg128"; do
+	gen_def_and_try_cmpxchg_fallback "" "${cmpxchg}" "_local"
 done
 
-for cmpxchg in "sync_cmpxchg"; do
-	printf "#define raw_${cmpxchg} arch_${cmpxchg}\n\n"
+for cmpxchg in "cmpxchg"; do
+	gen_def_and_try_cmpxchg_fallback "sync_" "${cmpxchg}" ""
 done
 
 grep '^[a-z]' "$1" | while read name meta args; do
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 8f8f8e3b20f9..592f3ec89b5f 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -169,7 +169,8 @@ for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128" "try_cmpxchg" "try_cmpxchg
 	done
 done
 
-for xchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local" "sync_cmpxchg" "try_cmpxchg_local" "try_cmpxchg64_local" "try_cmpxchg128_local"; do
+for xchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local" "sync_cmpxchg" \
+	    "try_cmpxchg_local" "try_cmpxchg64_local" "try_cmpxchg128_local" "sync_try_cmpxchg"; do
 	gen_xchg "${xchg}" ""
 	printf "\n"
 done
-- 
2.41.0

