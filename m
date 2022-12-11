Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8406496B3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 23:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLKWRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 17:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiLKWRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 17:17:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CD3DF14
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 14:16:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h10so10310616wrx.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 14:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p9rX14s+h4y1SuQ3mCW9PMi26HVbeJ/xr8u7413PZ4=;
        b=Ewkk6rnjnZvSU3LuAwd4bzx27RRFGN8QxuqDoa/OJEnAVAORO4VWqQEYhQSM8n+2Xm
         Z27ddssgjax3jnypckCl3fqqv6a1+uwZJnebns2S7RPwDFf1yM3Go+uXjR3E6mr2oNvw
         fAL1PZfsN/UhzidzySCKC2dAaE7eSASiEWhAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p9rX14s+h4y1SuQ3mCW9PMi26HVbeJ/xr8u7413PZ4=;
        b=ysBi0RaED4WNn/rSH1CwZhQ7TkErETp/PD2HLzqgxIs/+rTCX7gSFvedyD9aXu3T9E
         rQd6Y6VbMO0DRuYEf69mLfGDJKL53uk8h9pycUtAnI8+S6YIvwetam62XzrJ6PNCpDef
         h+i54myMVj2wVPGaj4Zep3eXXTaLVoHTde8NjIZZRZBA5N5YYKZy+ZIzcDRNSZDa94M9
         Naz7ZfngtoLt2e6M9/A8JQGPIm/n3CFoQnwOIrK1kvudycAGj4DAZiCgm9yNAzb97zCM
         D4XwhEJ7GCJhsTwJMycDGzeGtfTP5yYlw48Rizis9krMP86PcwpTiEjddFad7FUkOGvr
         3EQg==
X-Gm-Message-State: ANoB5pnet8/GnT5xQOgVq0pGT0Z4pCA6URfO8qdHi4J1Bg4TT8Xjc/LW
        ehVAl7TIDD5dW6If6aTtwcqGjg==
X-Google-Smtp-Source: AA0mqf7VD+2uF8zSkzKae34TDCfQTqaFDb9gL1sQvmMaKdmF9DR4P+rCMw32YAl2RZStSK/ZkojrAg==
X-Received: by 2002:adf:e544:0:b0:242:5469:55dd with SMTP id z4-20020adfe544000000b00242546955ddmr8306139wrm.36.1670796989537;
        Sun, 11 Dec 2022 14:16:29 -0800 (PST)
Received: from MacBook-Pro-5.lan ([2a0d:6fc2:218c:1a00:a91c:f8bf:c26f:4f15])
        by smtp.gmail.com with ESMTPSA id d7-20020adffd87000000b002422bc69111sm8605805wrr.9.2022.12.11.14.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 14:16:29 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     David <david.keisarschm@mail.huji.ac.il>, aksecurity@gmail.com,
        ilay.bahat1@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Replace invocation of weak PRNG in arch/x86/mm/kaslr.c
Date:   Mon, 12 Dec 2022 00:16:08 +0200
Message-Id: <b9ab9fa5d7d4d0763566dabe83e445331c970d51.1670778652.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1670778651.git.david.keisarschm@mail.huji.ac.il>
References: <cover.1670778651.git.david.keisarschm@mail.huji.ac.il>
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

We changed the invocation of
 prandom_bytes_state which is
 considered weak to get_random_bytes.
 We also omitted the call to the seeding function,
 since prandom_bytes matintains its own state,
 so there is no need for seeding here anymore.

Signed-off-by: David <david.keisarschm@mail.huji.ac.il>
---
 arch/x86/mm/kaslr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 66c17b449..466111c99 100644
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
-		predictable_rng_prandom_bytes_state(&rand_state, &rand, sizeof(rand));
+		prandom_bytes(&rand, sizeof(rand));
 		entropy = (rand % (entropy + 1)) & PUD_MASK;
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
-- 
2.38.0

