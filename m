Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864CC6A4D75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjB0Vmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjB0Vml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:42:41 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08F9166E3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:42:40 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i34so31643142eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pF1j/L5vcGNedAFcqAPgWkFtpGwjYImsiIMrNw4zJE=;
        b=cmg1GhtUWNg0amzNtPEbxGednqlpD557j0u1IKcgpmkITfq1Oz+tJFYMC7p/x9OU2y
         BOq4SpMn1KAijc2tVeaXciy6iOU2QgbCagR7gL8AooFNzjPQ7VA/U4ECwps8/S8+SWo6
         QZmy1bmdHLI9lhRQIke5WNcjRWT0KjR+Shju29zGYbglgTk4Yz6q8jTghwmiPHc6+OSF
         gy/UOuYfWPdlp6WJSvi1JWsY95llVhIzW/lG1W5/nhTijoHKWbfRKYHdp/l311P3BCzu
         zzx3icxL/Kz9IVvW7AO12c7BjX1z4zBfUnLokT3yk4lq8llJ0NAfOeqAKBxJb6pNYlj0
         OIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pF1j/L5vcGNedAFcqAPgWkFtpGwjYImsiIMrNw4zJE=;
        b=t3jUEipl0HRYP4XQx9Woei9V/CZEy180N+jXRAS0rY9EpxsnYUhy4ZBIfms8fyxmlZ
         abRmIaBrcgyX2gefFKLJrXSWnsRXxWT/4dkBT8btqmmO92bKlqgYLEt15jP+tK1lRPuh
         IhtdyA1BusVV6H9Tk0KupLe83PLGZ0Vzlp5F+Kl9ucf7VOGy0rNNIAYcy0l1uF4bWU/E
         bmdEFxBVS90l7SwTuG7XTtSCaEAtJFonagx8ezpKTHkt91iRqaJ58Blv/VokIPBaZ4EF
         jL/x6oVDGcgabRPH53MmvXexNwisu77YB8/GbRk5LZ9siWGE5Az6PTW0WiWzRn51yRtu
         S1Iw==
X-Gm-Message-State: AO0yUKXRrR/F4cp3E+Etg+DPcJvvLvmcr/pd4fJipjOckO86mybuZDaN
        J+plvNKPLSAEOnSDTH5Fr20=
X-Google-Smtp-Source: AK7set+SHic5PlVPa0PeP9RtaugqvXfIG224So+n+xk6rcAlubCuUE4yJg2fTshm8DbBatHRcZnDXQ==
X-Received: by 2002:a17:906:d158:b0:8b1:2f0e:e3a4 with SMTP id br24-20020a170906d15800b008b12f0ee3a4mr222842ejb.26.1677534159118;
        Mon, 27 Feb 2023 13:42:39 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id rh4-20020a17090720e400b008c801141d58sm3681327ejb.109.2023.02.27.13.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 13:42:38 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/rmap: use atomic_try_cmpxchg in set_tlb_ubc_flush_pending
Date:   Mon, 27 Feb 2023 22:42:28 +0100
Message-Id: <20230227214228.3533299-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old in
set_tlb_ubc_flush_pending. 86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move instruction in
front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg fails.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/rmap.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 15ae24585fc4..f964c197fc3c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -644,7 +644,7 @@ void try_to_unmap_flush_dirty(void)
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
-	int batch, nbatch;
+	int batch;
 
 	arch_tlbbatch_add_mm(&tlb_ubc->arch, mm);
 	tlb_ubc->flush_required = true;
@@ -662,11 +662,8 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
 		 * overflow.  Reset `pending' and `flushed' to be 1 and 0 if
 		 * `pending' becomes large.
 		 */
-		nbatch = atomic_cmpxchg(&mm->tlb_flush_batched, batch, 1);
-		if (nbatch != batch) {
-			batch = nbatch;
+		if (!atomic_try_cmpxchg(&mm->tlb_flush_batched, &batch, 1))
 			goto retry;
-		}
 	} else {
 		atomic_inc(&mm->tlb_flush_batched);
 	}
-- 
2.39.2

