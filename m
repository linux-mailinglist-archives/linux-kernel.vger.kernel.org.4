Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1051466A535
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjAMVjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjAMVjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:39:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E78EA4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:39:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b5so1073957wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3T8MxbgSdvCZWZbC6/MDpVm95aqJIIRd85jHr1PonM=;
        b=M6gDdpFiozHZk80GaW26bXTAk9Cw+PjbT+1K44PhKPgz/bEnK/uNKhvcPCG9L1U8HY
         XfepmZRwdcBJ/ug2WLCC2zxXG9PwUKOxXDW/t3lLbn4sM8TbE1J+GWpgWSun9Wnlr4cZ
         iCORNnOVmiDF0S4tMbIQ58FNvEeQPTtVFVbEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3T8MxbgSdvCZWZbC6/MDpVm95aqJIIRd85jHr1PonM=;
        b=u5/PvUV89skD0fPRMwzvH1vNwBIq1A64uOWpAXJeJHY1MjjUuhtvA9Sp/0RL5drBxm
         CvdG1n2y14M6Sf2rIksEWlYSxAMgop7aS1qbbmWAGXw4nVA523ix7AbArA9oVOx3k0E2
         rxNmkOJAixfdB400gMqzCc6W5AdCrU/MTlMEGwiRjuu3npd/WwXNFJMIjAl2ThkVUJFI
         5jc/fg490l/K1OOvNyvQQAxjzyOu431lPAwkuyNu8SQsw26CLp+ragZKpca1G8msSRuW
         iw8XWDVwz8yrXXNvjfXzzKdrWdJmQ9OWvdGbm/RDhT4xX7glEkTATjyh/+0Gm23/fpJa
         VkXA==
X-Gm-Message-State: AFqh2koeUz/M/9XzN3eSoMSc2QRw1pJkiv7lwwEz6HgQa6XAArdx3T5u
        qrlQRrTfvzuigo+2YX8Z8S+CiFOg6VUOvXXVH+gWL4fruSUKp4X113Lp/YAA+OXLTAKl8kLgF4l
        CnXV+3jS+VoE9+hW4OiJkWSguaU/I6BwA04nh7tyMEZfqVLMB90CTVFT+hzgZKHHfdsHz43LTba
        5juupUqz0UJMDHPL7AC3wORsc=
X-Google-Smtp-Source: AMrXdXvlMI4DsJ8R492xfP3fN5zBO8tes6MxNy/Bct75Vb+fJ5GFozm3v4fx7gR/DclIAAQNNhFnRA==
X-Received: by 2002:a5d:56c1:0:b0:2ba:cd91:5ae7 with SMTP id m1-20020a5d56c1000000b002bacd915ae7mr17275676wrw.47.1673645988608;
        Fri, 13 Jan 2023 13:39:48 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:2dd5:e78e:71c0:661b])
        by smtp.gmail.com with ESMTPSA id e7-20020a056000120700b00241dd5de644sm19841461wrx.97.2023.01.13.13.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:39:48 -0800 (PST)
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
        aksecurity@gmail.com, ilay.bahat1@gmail.com
Subject: [PATCH v4 3/3] x86 mm, x86 architecture (32-bit and 64-bit): arch/x86/mm/kaslr.c: Adds 64bits version of prandom_seed_state
Date:   Fri, 13 Jan 2023 23:39:45 +0200
Message-Id: <295dceed7bef2391f86e751b9bfc9a34347062e4.1673470326.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1673470326.git.david.keisarschm@mail.huji.ac.il>
References: <cover.1673470326.git.david.keisarschm@mail.huji.ac.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>

The memory randomization of the virtual address space of kernel memory regions
(physical memory mapping, vmalloc & vmemmap) inside arch/x86/mm/kaslr.c
is based on the function prandom_bytes_state which uses the prandom_u32 PRNG.

However, the seeding here is done by calling prandom_seed_state,
which effectively uses only 32bits of the seed, which means that observing ONE
region's offset (say 30 bits) can provide the attacker with 2 possible seeds
(from which the attacker can calculate the remaining two regions)

Hence, we implemented an adjusted version of prandom_seed_state, inside kaslr.c
so it takes advantage of all the seed's 64 bits. With this implementation,
enumerating over the seed is quite unfeasible, and attacking the linearity requires ~113
bits which we don't get with two exposed region offsets (but rather up to 30
bits each).

Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
---
Changes since v3:
* We took a different approach, and replaced the invocation of
  prandom_bytes_state, to a revised version which is more secure.

Changes since v2:
* edited commit message.


 arch/x86/mm/kaslr.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 557f0fe25..5fd73d5ad 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -59,6 +59,29 @@ static inline unsigned long get_padding(struct kaslr_memory_region *region)
 {
 	return (region->size_tb << TB_SHIFT);
 }
+static inline void _kaslr_prandom_seed_state(struct rnd_state *state, u64 seed)
+{
+	u32 i = ((seed >> 32) ^ (seed << 10) ^ seed) & 0xffffffffUL;
+	// To take advantage of all 64 bits of the seed
+	u32 j = ((seed>>32) ^ (seed<<10)) & 0xffffffffUL;
+	state->s1 = __seed(i,   2U);
+	state->s2 = __seed(j,   8U);
+	/* Ensure no obvious linear relation with the previous states */
+	state->s3 = __seed(next_pseudo_random32(i+j),  16U);
+	state->s4 = __seed(next_pseudo_random32(j-((i>>16)^(i<<16))), 128U);
+
+	/* Calling RNG ten times to satisfy recurrence condition */
+	prandom_u32_state(state);
+	prandom_u32_state(state);
+	prandom_u32_state(state);
+	prandom_u32_state(state);
+	prandom_u32_state(state);
+	prandom_u32_state(state);
+	prandom_u32_state(state);
+	prandom_u32_state(state);
+	prandom_u32_state(state);
+	prandom_u32_state(state);
+}
 
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
@@ -113,7 +136,8 @@ void __init kernel_randomize_memory(void)
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
 		remain_entropy -= get_padding(&kaslr_regions[i]);
 
-	prandom_seed_state(&rand_state, kaslr_get_random_long("Memory"));
+	_kaslr_prandom_seed_state(&rand_state, kaslr_get_random_long
+				   ("Memory"));
 
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++) {
 		unsigned long entropy;
-- 
2.38.0

