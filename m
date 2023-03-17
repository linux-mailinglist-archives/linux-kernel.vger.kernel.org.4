Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2916D6BF4CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjCQV6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCQV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:58:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D12ED7D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:58:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r18so5652433wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679090315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E73zG66hPCj2y2LLQHqVtdvTmlQn/mfxXz04vMaqlmQ=;
        b=p0sz2Q/60JExrD8KLivrs4RisQT/t4knswKiVldLNc181jBlMOow+MU/gMnc4CDC16
         g3ISFEdAk7O6o1WyLtOOu7w61OMFjRDGqPRR/1Y84rL1fl9f9dBAroADdsvGkx1pVXP9
         6p+wOqskB3Kyl9nHhD/WfUx6Tv1gSBBHI0KzizJ6fn/kIxUjOhB6kaoVDaeR1b6uQHzb
         suEORJV8evSP7NUNk+sEywUCvlA5pJoutPivMPazdNJx2ogfxvsqQYH8TWVpGyfn+29z
         9EIpmSwCC74XqZaDtXAHCn/yPhr/yV2ow5ve2TmN3mABWz0rk6fE23lFhM+dIm5q50zl
         YXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679090315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E73zG66hPCj2y2LLQHqVtdvTmlQn/mfxXz04vMaqlmQ=;
        b=U1UlMXBeZmwWcOthprNNgNCqPdGXT/siT/uk2dfPUsb+1nXOV0P7p9AmvjsHyM5eV5
         SW1T57MmvcpXKeQanHKLU87egWqjGGtahDWtmiEpvPqIiOq1T/u3ptpx/OBzJuyWbRWi
         cP0ordf+2V/yM1PweSUDzyLlaM8V8rXIRLk34wiZNLmW8ntDoDrEReNdPKzS6MEXvzcZ
         v1QBFb5hpa/REUSaKh0Xwxmz/JyNhJDwNuj5K92eXO693KV3MDK8bUs2GsuWwnOyEOI4
         YbQ+PGkpQrM83H9wtpQPJnpzSBMGW7ojaniHnOGxYidFc530YaeSlgU8AIieGrGsY+G8
         p0HA==
X-Gm-Message-State: AO0yUKXaU+xySDmKtVlW/1yaxlleAwr2onUR50Ex55RfM0uxYPkNMhWi
        tV75a0NzYc4eQC2y4OHmNX0=
X-Google-Smtp-Source: AK7set85J+fF2ekkIZVxIUpMfYu6GSJeUFX4eACMqsfBv9LTucAUS/0tN4bnCc4vBud9r4nwdVk3jg==
X-Received: by 2002:a5d:638b:0:b0:2cf:f312:6e60 with SMTP id p11-20020a5d638b000000b002cff3126e60mr7547549wru.21.1679090315367;
        Fri, 17 Mar 2023 14:58:35 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id c9-20020a5d4cc9000000b002d21379bcabsm2849757wrt.110.2023.03.17.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:58:34 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 2/2] mm: pefer fault_around_pages to fault_around_bytes
Date:   Fri, 17 Mar 2023 21:58:26 +0000
Message-Id: <4995bad07fe9baa51c786fa0d81819dddfb57654.1679089214.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679089214.git.lstoakes@gmail.com>
References: <cover.1679089214.git.lstoakes@gmail.com>
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

All use of this value is now at page granularity, so specify the variable
as such too. This simplifies the logic.

We maintain the debugfs entry to ensure that there are no user-visible
changes.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/memory.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3d85aa7106b0..ae01f541ad30 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4393,13 +4393,13 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static unsigned long fault_around_bytes __read_mostly =
-	rounddown_pow_of_two(65536);
+static unsigned long fault_around_pages __read_mostly =
+	65536 >> PAGE_SHIFT;
 
 #ifdef CONFIG_DEBUG_FS
 static int fault_around_bytes_get(void *data, u64 *val)
 {
-	*val = fault_around_bytes;
+	*val = fault_around_pages << PAGE_SHIFT;
 	return 0;
 }
 
@@ -4411,10 +4411,13 @@ static int fault_around_bytes_set(void *data, u64 val)
 {
 	if (val / PAGE_SIZE > PTRS_PER_PTE)
 		return -EINVAL;
-	if (val > PAGE_SIZE)
-		fault_around_bytes = rounddown_pow_of_two(val);
-	else
-		fault_around_bytes = PAGE_SIZE; /* rounddown_pow_of_two(0) is undefined */
+
+	/*
+	 * The minimum value is 1 page, however this results in no fault-around
+	 * at all. See should_fault_around().
+	 */
+	fault_around_pages = max(rounddown_pow_of_two(val) >> PAGE_SHIFT, 1UL);
+
 	return 0;
 }
 DEFINE_DEBUGFS_ATTRIBUTE(fault_around_bytes_fops,
@@ -4440,18 +4443,18 @@ late_initcall(fault_around_debugfs);
  * This function doesn't cross VMA or page table boundaries, in order to call
  * map_pages() and acquire a PTE lock only once.
  *
- * fault_around_bytes defines how many bytes we'll try to map.
+ * fault_around_pages defines how many pages we'll try to map.
  * do_fault_around() expects it to be set to a power of two less than or equal
  * to PTRS_PER_PTE.
  *
  * The virtual address of the area that we map is naturally aligned to
- * fault_around_bytes rounded down to the machine page size
+ * fault_around_pages * PAGE_SIZE rounded down to the machine page size
  * (and therefore to page order).  This way it's easier to guarantee
  * that we don't cross page table boundaries.
  */
 static vm_fault_t do_fault_around(struct vm_fault *vmf)
 {
-	pgoff_t nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
+	pgoff_t nr_pages = READ_ONCE(fault_around_pages);
 	pgoff_t pte_off = pte_index(vmf->address);
 	/* The page offset of vmf->address within the VMA. */
 	pgoff_t vma_off = vmf->pgoff - vmf->vma->vm_pgoff;
@@ -4486,7 +4489,8 @@ static inline bool should_fault_around(struct vm_fault *vmf)
 	if (uffd_disable_fault_around(vmf->vma))
 		return false;
 
-	return fault_around_bytes >> PAGE_SHIFT > 1;
+	/* A single page implies no faulting 'around' at all. */
+	return fault_around_pages > 1;
 }
 
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
-- 
2.39.2

