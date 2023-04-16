Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4540A6E3A75
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDPRXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDPRX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:23:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DEF2114
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:23:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f09d088fabso5125175e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1681665806; x=1684257806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMFTw1pvxItjp3ciwYSf6r+LAXHguCdDdgCzY+55QH4=;
        b=U9NCl5HIZh6fEfJ9pz2t3CSy0F7aJJA2b52go6GboaHaK0Nvl8FatIydXQtHMDEO13
         pJm354XaCIskjdunlnKPtWU2BZKi8aQJ6MLlynAkrb7llngB+4ehMnGkXWJYfj+UtpdY
         isSnHwge/d3gER2/T7I4JSESSLtlXsKBQjyYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681665806; x=1684257806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMFTw1pvxItjp3ciwYSf6r+LAXHguCdDdgCzY+55QH4=;
        b=VVsKltPLR2fkm3CytlVfpoWeAuvrXZgUijV5ViH6td4F6JLdFs59SOcAHgMuNCMYP4
         yhYfE05pEH21t2wlHhZnzRIttv2Bh7oKIndnogudh8NejwR5UDnI2VXjco2nDy8aBX+O
         yyBd9N0fxqunT9kqPuWKaOZikX7XSgnTzNrCur7iC0KTEYj7ZRIKKF1/mHKByfvXHebw
         OzfYBKI5r9/DZ5sImMPNG+htiZVjzqe8OH5WOtIaQs6IazIQKDFlpkvhi1yg5t5+aTMD
         dkVWd9+2YibbzdEFGY/KRjnWV73RlZ0atRQ20wGxJdmupOXHREPq4vYWa0Q0T0LKbm9I
         C2IA==
X-Gm-Message-State: AAQBX9cski0LbQLjlWAx9WaX00U9aw5bf0z8NrAcozHBCK0px2bqjqWk
        utkEEbSE8PLAVOrclIKXxGVV74M6uNh2gbR6MrGN2cDH11PQOFQ4EZDV42BiDKDGMyTJgwiIvPg
        5f98tSIyZ6p9MplBc/tWBB7SNNT810zr6y/LrZ1NDa0anshnEJ9i4nqI1l5YB3U93oxOi90JmfX
        P0EguG6irpyW0DavoeLCB4MRv+WeVU
X-Google-Smtp-Source: AKy350ZAHhdMLQkyRAe9AOwdG+JqURd6oYHd1JRVmZFgzL/UxyXZwptzPEhB/HGn1IBlQ03s1BwGjw==
X-Received: by 2002:adf:de89:0:b0:2f5:8116:6458 with SMTP id w9-20020adfde89000000b002f581166458mr3617529wrl.66.1681665805947;
        Sun, 16 Apr 2023 10:23:25 -0700 (PDT)
Received: from localhost.localdomain ([94.159.161.55])
        by smtp.gmail.com with ESMTPSA id q17-20020a5d61d1000000b002faaa9a1721sm198112wrv.58.2023.04.16.10.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:23:25 -0700 (PDT)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Jason@zx2c4.com, keescook@chromium.org,
        David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>,
        ilay.bahat1@gmail.com, aksecurity@gmail.com
Subject: [PATCH v6 3/3] arch/x86/mm/kaslr: use siphash instead of prandom_bytes_state
Date:   Sun, 16 Apr 2023 20:23:23 +0300
Message-Id: <20230416172323.13278-1-david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>

The memory randomization of the virtual address space
of kernel memory regions (physical memory mapping, vmalloc & vmemmap) inside
arch/x86/mm/kaslr.c is based on the function prandom_bytes_state which uses
the prandom_u32 PRNG.

However, the seeding here is done by calling prandom_seed_state,
which effectively uses only 32bits of the seed, which means that observing ONE
region's offset (say 30 bits) can provide the attacker with 2 possible seeds
(from which the attacker can calculate the remaining two regions)

In order to fix it,  we have replaced the two invocations of prandom_bytes_state and prandom_seed_state
with siphash, which is considered more secure.
Besides, the original code used the same pseudo-random number in every iteration,
so to add some additional randomization
we call siphash every iteration, hashing the iteration index with the described key.

Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
---
Changes since v5:
* deleted irrelevant changes which were appended accidentally.

Changes since v4:
* replaced the call to prandom_bytes_state and prandom_seed_state,
    with siphash.

Changes since v2:
* edited commit message.

 arch/x86/mm/kaslr.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 557f0fe25..fb551796c 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -25,6 +25,7 @@
 #include <linux/random.h>
 #include <linux/memblock.h>
 #include <linux/pgtable.h>
+#include <linux/siphash.h>
 
 #include <asm/setup.h>
 #include <asm/kaslr.h>
@@ -66,9 +67,14 @@ void __init kernel_randomize_memory(void)
 	size_t i;
 	unsigned long vaddr_start, vaddr;
 	unsigned long rand, memory_tb;
-	struct rnd_state rand_state;
 	unsigned long remain_entropy;
 	unsigned long vmemmap_size;
+	/*
+	 * Create a Siphash key. We use a mask of PI digits to add some
+	 * randomness to the key.
+	 */
+	u64 seed = (u64) kaslr_get_random_long("Memory");
+	siphash_key_t key = {{seed, seed ^ 0x3141592653589793UL}};
 
 	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
 	vaddr = vaddr_start;
@@ -94,7 +100,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+		    CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 
 	/* Adapt physical memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
@@ -105,7 +111,7 @@ void __init kernel_randomize_memory(void)
 	 * boundary.
 	 */
 	vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
-			sizeof(struct page);
+		       sizeof(struct page);
 	kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
 
 	/* Calculate entropy available between regions */
@@ -113,8 +119,6 @@ void __init kernel_randomize_memory(void)
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
 		remain_entropy -= get_padding(&kaslr_regions[i]);
 
-	prandom_seed_state(&rand_state, kaslr_get_random_long("Memory"));
-
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++) {
 		unsigned long entropy;
 
@@ -123,7 +127,12 @@ void __init kernel_randomize_memory(void)
 		 * available.
 		 */
 		entropy = remain_entropy / (ARRAY_SIZE(kaslr_regions) - i);
-		prandom_bytes_state(&rand_state, &rand, sizeof(rand));
+		/*
+		 * Use Siphash to generate a pseudo-random number every
+		 * iteration
+		 *
+		 */
+		rand = siphash_1u64(i, &key);
 		entropy = (rand % (entropy + 1)) & PUD_MASK;
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
-- 
2.37.3

