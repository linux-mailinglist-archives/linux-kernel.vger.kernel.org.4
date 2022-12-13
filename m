Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F325364B34B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiLMKf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiLMKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:35:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A391EE13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:35:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h12so15102135wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJM6rNGnsSsKkdiUVZXoWgZhZ1P+6n693//gXJy6sCg=;
        b=ImrOxdJZ4ry+gv05nHH385ZDSpbyw6yNwCyHb9Ouf1tAsDnAoEC7NE/Pkf9xzcajDF
         1WC2rtDOARBqEHm0IBk8BC507qvOFgIz+ISubOBvngpH82Wnx7G+Y2y+pcB8lKibMFYB
         wzP3lPcUuuFXvypAulFIxjUxaO6y+Ww8TNGUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJM6rNGnsSsKkdiUVZXoWgZhZ1P+6n693//gXJy6sCg=;
        b=CBfmBoBLkQP7tyuz7dFK1dZ++r6wpwbQ3tP0pIILUFGx2BY3M5mBp93AmaS9ruZoMg
         fIIhP5NIEz1BZnnNKnbJ9+/5kbU58/+RIesqs7N4zK6FOftPfMgb6uuwBtKGJGSoApuU
         TffWPESeyk10fkdXKQWF4ch/DAjF3OWLY+cXmIkNqPMe2e7nL29Iwaus9XAELYKKTVyZ
         qkP5F8Oc7aDs5SvURGGtF/1IBmFtduvuomYEKMqiAMHgBZhzJ6SznuGZ49fX/buuGpWR
         +EjENn8k2o2i9ugguVPX6YHydJoWkJ9RZDEpai+1oXWj5paEidvN7j5I7MjSXVx0EVCm
         On3w==
X-Gm-Message-State: ANoB5pn6z/rJU3rZCNRmgQOyz3/gCSbVEybhBSEo1P0Rs8ylQskAaRn+
        8fmHFIG3MIoJYUanmuiThxffTPGsbwj3ApwnrxjJdTWQAyO8eSj2Z52wwkf/kgArDhARhQkRsbJ
        cCuJZZPcelrOtx9Ztp6miQCsLLntHRRucNup6Vl/yl3pCxsMQBLOfZJ3UZbO+jMaTGmcfrTZYHU
        +N2vQwUzM7NWWXpSXPL3IiYjI=
X-Google-Smtp-Source: AA0mqf5+7prvxB1ns5rL2RiclPDy4aLD/HkJ3wtquHbTwD+WQBoIDzHHAJ58XXdcenOUDVB6CEdPOA==
X-Received: by 2002:a5d:6a46:0:b0:242:149c:6d29 with SMTP id t6-20020a5d6a46000000b00242149c6d29mr10543782wrw.16.1670927708804;
        Tue, 13 Dec 2022 02:35:08 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:a0bd:cef2:7a82:b529])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d6b0f000000b002366553eca7sm11295813wrw.83.2022.12.13.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:35:08 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     David <david.keisarschm@mail.huji.ac.il>, aksecurity@gmail.com,
        ilay.bahat1@gmail.com
Subject: [PATCH v2 3/3] Replace invocation of weak PRNG in arch/x86/mm/kaslr.c
Date:   Tue, 13 Dec 2022 12:34:59 +0200
Message-Id: <ae6258c3dd2a769df9c349f0b14de6dadcfa4386.1670890407.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1670890407.git.david.keisarschm@mail.huji.ac.il>
References: <cover.1670890407.git.david.keisarschm@mail.huji.ac.il>
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

From: David <david.keisarschm@mail.huji.ac.il>

We changed the invocation
 of prandom_bytes_state which is
 considered weak to get_random_bytes.
 We also omitted the call to the
 seeding function,
 since get_random_bytes matintains
 its own state,
so there is no need for seeding here anymore.
This is important for the memory initial state
randomization.

Signed-off-by: David <david.keisarschm@mail.huji.ac.il>
---
 arch/x86/mm/kaslr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 0bb083979..9ef8993d5 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -66,7 +66,6 @@ void __init kernel_randomize_memory(void)
 	size_t i;
 	unsigned long vaddr_start, vaddr;
 	unsigned long rand, memory_tb;
-	struct rnd_state rand_state;
 	unsigned long remain_entropy;
 	unsigned long vmemmap_size;
 
@@ -113,8 +112,6 @@ void __init kernel_randomize_memory(void)
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
 		remain_entropy -= get_padding(&kaslr_regions[i]);
 
-	prandom_seed_state(&rand_state, kaslr_get_random_long("Memory"));
-
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++) {
 		unsigned long entropy;
 
@@ -123,7 +120,7 @@ void __init kernel_randomize_memory(void)
 		 * available.
 		 */
 		entropy = remain_entropy / (ARRAY_SIZE(kaslr_regions) - i);
-		prandom_bytes_state(&rand_state, &rand, sizeof(rand));
+		get_random_bytes(&rand, sizeof(rand));
 		entropy = (rand % (entropy + 1)) & PUD_MASK;
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
-- 
2.38.0

