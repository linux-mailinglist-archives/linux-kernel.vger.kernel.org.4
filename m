Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907636D4464
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjDCM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjDCM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:28:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE811113CE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:27:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n14so11962813plc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680524876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5olhRivIG/hHd0cpc7oUvrJOToDW8+BEcztjjWShXR4=;
        b=cQF1RNTrilN6uUHe2olsoE50iad/Chq08+390cxaMCE5w0fLa8JXQ1uyr4n/8Bp4z0
         tLsH3+lZHWOZLs+TLr/jnDH/4H9RY3xGd7aoHpQfdx6vF4Jg63FPIb/CqK1F3smAVq3O
         W9p9/Hd9rB/nTL+W249WZPVTCmAKSWg1HWA8GSLPnFxjKdMqsdE4eJ4GBp04LSVJd9qz
         8EIzbCcTGDJ0luCyYfADRSVq/itah9vnswmU5V7BtQTd2hnV6F6qN2ZXw1usjXg96zf2
         Iy0lrYwRIKFosvSNmb8X0muexshj+wwOSD1I4EkFxbrxPicTRtS3FkPG3A2qqofPJleE
         HmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680524876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5olhRivIG/hHd0cpc7oUvrJOToDW8+BEcztjjWShXR4=;
        b=LHZtQqNP19uhc9P8/J924BIZGtlUhNArDpSQIJc8jPVwuW6DbKQUj3FamNi4GKSa1F
         HH8u9rSsgUE1Fi+URLC50kPW5ffdFl7+4+rHRn/HFbghlNR8klJVAX3HeORW1RRYKIfa
         hv4Pj0Hs/mzUW+vfHfbz8YcnlQquzBiNGhHkApiQylFaqmbXKU+KQsSk9QQHIOg0waZ6
         /NmQNjAaUtmUE2khfjlu+jwUooO5ek0FpYO6DUJvlFH+44UNSlB3GFZ1po8CiNkPn2Ui
         kqVZ/Vh6dM53I3Wz16yItu4jHRGMVsq5YORTgz1QLA59CtDjgJqm+8kHBpyv+rodvJxn
         luSw==
X-Gm-Message-State: AAQBX9exXhlmMSZnRaGeXw1yD9DxsZWCr/6uta7/bpWmQ9plysKPt4F2
        7kkooFTR5IPLUbWt3E4RdlEFxxX78zygc6Qnywg=
X-Google-Smtp-Source: AKy350aoV3blvZ+bajGS5QvM2jWNu1IdK2sKSOo4bYShKSuHsClLRLjZpwRlFfMWDsYJmjEAGBNI2A==
X-Received: by 2002:a17:90a:b397:b0:23d:1b82:7236 with SMTP id e23-20020a17090ab39700b0023d1b827236mr42253971pjr.16.1680524876113;
        Mon, 03 Apr 2023 05:27:56 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a1f8500b00240ab3c5f66sm6107802pja.29.2023.04.03.05.27.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Apr 2023 05:27:55 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2] mm: kfence: Improve the performance of __kfence_alloc() and __kfence_free()
Date:   Mon,  3 Apr 2023 20:27:38 +0800
Message-Id: <20230403122738.6006-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __kfence_alloc() and __kfence_free(), we will set and check canary.
Assuming that the size of the object is close to 0, nearly 4k memory
accesses are required because setting and checking canary is executed
byte by byte.

canary is now defined like this:
KFENCE_CANARY_PATTERN(addr) ((u8)0xaa ^ (u8)((unsigned long)(addr) & 0x7))

Observe that canary is only related to the lower three bits of the
address, so every 8 bytes of canary are the same. We can access 8-byte
canary each time instead of byte-by-byte, thereby optimizing nearly 4k
memory accesses to 4k/8 times.

Use the bcc tool funclatency to measure the latency of __kfence_alloc()
and __kfence_free(), the numbers (deleted the distribution of latency)
is posted below. Though different object sizes will have an impact on the
measurement, we ignore it for now and assume the average object size is
roughly equal.

Before patching:
__kfence_alloc:
avg = 5055 nsecs, total: 5515252 nsecs, count: 1091
__kfence_free:
avg = 5319 nsecs, total: 9735130 nsecs, count: 1830

After patching:
__kfence_alloc:
avg = 3597 nsecs, total: 6428491 nsecs, count: 1787
__kfence_free:
avg = 3046 nsecs, total: 3415390 nsecs, count: 1121

The numbers indicate that there is ~30% - ~40% performance improvement.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 mm/kfence/core.c   | 70 ++++++++++++++++++++++++++++++++--------------
 mm/kfence/kfence.h | 10 ++++++-
 mm/kfence/report.c |  2 +-
 3 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 79c94ee55f97..b7fe2a2493a0 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -297,20 +297,13 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
 	WRITE_ONCE(meta->state, next);
 }
 
-/* Write canary byte to @addr. */
-static inline bool set_canary_byte(u8 *addr)
-{
-	*addr = KFENCE_CANARY_PATTERN(addr);
-	return true;
-}
-
 /* Check canary byte at @addr. */
 static inline bool check_canary_byte(u8 *addr)
 {
 	struct kfence_metadata *meta;
 	unsigned long flags;
 
-	if (likely(*addr == KFENCE_CANARY_PATTERN(addr)))
+	if (likely(*addr == KFENCE_CANARY_PATTERN_U8(addr)))
 		return true;
 
 	atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
@@ -323,15 +316,31 @@ static inline bool check_canary_byte(u8 *addr)
 	return false;
 }
 
-/* __always_inline this to ensure we won't do an indirect call to fn. */
-static __always_inline void for_each_canary(const struct kfence_metadata *meta, bool (*fn)(u8 *))
+static inline void set_canary(const struct kfence_metadata *meta)
 {
 	const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
-	unsigned long addr;
+	unsigned long addr = pageaddr;
+
+	/*
+	 * The canary may be written to part of the object memory, but it does
+	 * not affect it. The user should initialize the object before using it.
+	 */
+	for (; addr < meta->addr; addr += sizeof(u64))
+		*((u64 *)addr) = KFENCE_CANARY_PATTERN_U64;
+
+	addr = ALIGN_DOWN(meta->addr + meta->size, sizeof(u64));
+	for (; addr - pageaddr < PAGE_SIZE; addr += sizeof(u64))
+		*((u64 *)addr) = KFENCE_CANARY_PATTERN_U64;
+}
+
+static inline void check_canary(const struct kfence_metadata *meta)
+{
+	const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
+	unsigned long addr = pageaddr;
 
 	/*
-	 * We'll iterate over each canary byte per-side until fn() returns
-	 * false. However, we'll still iterate over the canary bytes to the
+	 * We'll iterate over each canary byte per-side until a corrupted byte
+	 * is found. However, we'll still iterate over the canary bytes to the
 	 * right of the object even if there was an error in the canary bytes to
 	 * the left of the object. Specifically, if check_canary_byte()
 	 * generates an error, showing both sides might give more clues as to
@@ -339,16 +348,35 @@ static __always_inline void for_each_canary(const struct kfence_metadata *meta,
 	 */
 
 	/* Apply to left of object. */
-	for (addr = pageaddr; addr < meta->addr; addr++) {
-		if (!fn((u8 *)addr))
+	for (; meta->addr - addr >= sizeof(u64); addr += sizeof(u64)) {
+		if (unlikely(*((u64 *)addr) != KFENCE_CANARY_PATTERN_U64))
 			break;
 	}
 
-	/* Apply to right of object. */
-	for (addr = meta->addr + meta->size; addr < pageaddr + PAGE_SIZE; addr++) {
-		if (!fn((u8 *)addr))
+	/*
+	 * If the canary is corrupted in a certain 64 bytes, or the canary
+	 * memory cannot be completely covered by multiple consecutive 64 bytes,
+	 * it needs to be checked one by one.
+	 */
+	for (; addr < meta->addr; addr++) {
+		if (unlikely(!check_canary_byte((u8 *)addr)))
 			break;
 	}
+
+	/* Apply to right of object. */
+	for (addr = meta->addr + meta->size; addr % sizeof(u64) != 0; addr++) {
+		if (unlikely(!check_canary_byte((u8 *)addr)))
+			return;
+	}
+	for (; addr - pageaddr < PAGE_SIZE; addr += sizeof(u64)) {
+		if (unlikely(*((u64 *)addr) != KFENCE_CANARY_PATTERN_U64)) {
+
+			for (; addr - pageaddr < PAGE_SIZE; addr++) {
+				if (!check_canary_byte((u8 *)addr))
+					return;
+			}
+		}
+	}
 }
 
 static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp,
@@ -434,7 +462,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 #endif
 
 	/* Memory initialization. */
-	for_each_canary(meta, set_canary_byte);
+	set_canary(meta);
 
 	/*
 	 * We check slab_want_init_on_alloc() ourselves, rather than letting
@@ -495,7 +523,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 	alloc_covered_add(meta->alloc_stack_hash, -1);
 
 	/* Check canary bytes for memory corruption. */
-	for_each_canary(meta, check_canary_byte);
+	check_canary(meta);
 
 	/*
 	 * Clear memory if init-on-free is set. While we protect the page, the
@@ -751,7 +779,7 @@ static void kfence_check_all_canary(void)
 		struct kfence_metadata *meta = &kfence_metadata[i];
 
 		if (meta->state == KFENCE_OBJECT_ALLOCATED)
-			for_each_canary(meta, check_canary_byte);
+			check_canary(meta);
 	}
 }
 
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 600f2e2431d6..2aafc46a4aaf 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -21,7 +21,15 @@
  * lower 3 bits of the address, to detect memory corruptions with higher
  * probability, where similar constants are used.
  */
-#define KFENCE_CANARY_PATTERN(addr) ((u8)0xaa ^ (u8)((unsigned long)(addr) & 0x7))
+#define KFENCE_CANARY_PATTERN_U8(addr) ((u8)0xaa ^ (u8)((unsigned long)(addr) & 0x7))
+
+/*
+ * Define a continuous 8-byte canary starting from a multiple of 8. The canary
+ * of each byte is only related to the lowest three bits of its address, so the
+ * canary of every 8 bytes is the same. 64-bit memory can be filled and checked
+ * at a time instead of byte by byte to improve performance.
+ */
+#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(0x0706050403020100))
 
 /* Maximum stack depth for reports. */
 #define KFENCE_STACK_DEPTH 64
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 60205f1257ef..197430a5be4a 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -168,7 +168,7 @@ static void print_diff_canary(unsigned long address, size_t bytes_to_show,
 
 	pr_cont("[");
 	for (cur = (const u8 *)address; cur < end; cur++) {
-		if (*cur == KFENCE_CANARY_PATTERN(cur))
+		if (*cur == KFENCE_CANARY_PATTERN_U8(cur))
 			pr_cont(" .");
 		else if (no_hash_pointers)
 			pr_cont(" 0x%02x", *cur);
-- 
2.20.1

