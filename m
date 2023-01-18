Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E5367208C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjARPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjARPHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:07:19 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97BB196B2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:07:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v30so50008877edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=de5VSyCSp4LwIkgkLbu8PgcqKtOJrMJR3VqjQzZBt04=;
        b=Tn84+dn0XpHVthmT5dogJZCrr7OsRwjBMD8hbBUwdImvjTCgvCNeA+K4edPl83CnGu
         2ZTUVsS9miwka1IP8rdQnBaK2FLqudjX2Ht/h205Xg2sLCWXlkRTJZ2Fz05i7SPOc7zu
         UiT2s99aNP7pm72NtR9ZlPS0oOCzBaEnu+5a27TOOi3H+1rCaY1+3G80NGB2+hMyH0jf
         KobfxgPJvrH2cvKvJOEqRFAWGtwJOo8YhRqmY76mYm1Er2eRVYPebDkhQZqAu7h3ElgP
         JROiD+bp4Y9u66ioDV4aKzfLZdKVgWRJhWSLxvC7+Bf5qYhSc7LS1Uak1H9soeJrygE6
         R8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=de5VSyCSp4LwIkgkLbu8PgcqKtOJrMJR3VqjQzZBt04=;
        b=TLy5a7/QcpiZ4gM0ypFwT4e7pI0UPd11/r3acriVzx6DF9tFN/oznuhRIJFLpL7Tsy
         baIFDI6k6cViHTa3VW5SZ7kVXCPl2iRO8Bw+cpw2UGc53MY9DYVWyYNA2kWt3EPbqcYK
         5dF8c/VXTvDu1GTOSFTFn+aK6mRF9GaPoniYSsmPMMWMkqwMmvdouDpL2pPVPYc8aJ+2
         FcfR4JyL4tn67SP9UWbGnhUdI/2VWbkmAbDsavPmBMnkQueEz6NhzbQI8oO2qyY8YcrI
         lwVttQKpaxves9ALvfFAmxzAE8VgU76rlENdUHRT0VaFPtNa4NYbSUhg1/eiTSWnXhW0
         eZdw==
X-Gm-Message-State: AFqh2kouywBluueXVmQVFeHkpZBbt4039EQu4Rj3R3ljW7F3i1R4ko9w
        gO97qAucqOPt9c0L9H2JREjKlutl8RR6RA==
X-Google-Smtp-Source: AMrXdXudLdRDYqhpQHhGrnJqyeIGhfS9uYGo6ulHMXCeOy/wijIYzBUb61Mk8xeqHj4fNFA03Qvwbw==
X-Received: by 2002:aa7:c3cf:0:b0:499:5405:9319 with SMTP id l15-20020aa7c3cf000000b0049954059319mr6980786edr.32.1674054432104;
        Wed, 18 Jan 2023 07:07:12 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id m20-20020aa7c2d4000000b00495f4535a33sm14425184edp.74.2023.01.18.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:07:11 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Date:   Wed, 18 Jan 2023 16:07:03 +0100
Message-Id: <20230118150703.4024-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
{set,clear}_bits_ll.  x86 CMPXCHG instruction returns success in ZF
flag, so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails.

Note that the value from *ptr should be read using READ_ONCE to prevent
the compiler from merging, refetching or reordering the read.

The patch also declares these two functions inline, to ensure inlining.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/genalloc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 00fc50d0a640..0c883d6fbd44 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -40,32 +40,30 @@ static inline size_t chunk_size(const struct gen_pool_chunk *chunk)
 	return chunk->end_addr - chunk->start_addr + 1;
 }
 
-static int set_bits_ll(unsigned long *addr, unsigned long mask_to_set)
+static inline int
+set_bits_ll(unsigned long *addr, unsigned long mask_to_set)
 {
-	unsigned long val, nval;
+	unsigned long val = READ_ONCE(*addr);
 
-	nval = *addr;
 	do {
-		val = nval;
 		if (val & mask_to_set)
 			return -EBUSY;
 		cpu_relax();
-	} while ((nval = cmpxchg(addr, val, val | mask_to_set)) != val);
+	} while (!try_cmpxchg(addr, &val, val | mask_to_set));
 
 	return 0;
 }
 
-static int clear_bits_ll(unsigned long *addr, unsigned long mask_to_clear)
+static inline int
+clear_bits_ll(unsigned long *addr, unsigned long mask_to_clear)
 {
-	unsigned long val, nval;
+	unsigned long val = READ_ONCE(*addr);
 
-	nval = *addr;
 	do {
-		val = nval;
 		if ((val & mask_to_clear) != mask_to_clear)
 			return -EBUSY;
 		cpu_relax();
-	} while ((nval = cmpxchg(addr, val, val & ~mask_to_clear)) != val);
+	} while (!try_cmpxchg(addr, &val, val & ~mask_to_clear));
 
 	return 0;
 }
-- 
2.39.0

