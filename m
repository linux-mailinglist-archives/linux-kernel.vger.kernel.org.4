Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB7693D99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBMEy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBMEym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:42 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D11205B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w5so12280340plg.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JFNUn7jw7XrbPRCSrUHiiAgppCfO2t4yElt5XDL04Q=;
        b=MAtbG5JUipDDMVBI03UWeY8vjoTpzFDhlMkb2IIUtB84hOxlG1WyPFh7MJnCD5jfl2
         zjmODVBzL2cx3l1Qs7L7jfh8m/gnDVQInUF+dA+7OKyMVa5Haw7ygFvOQ8YMb5gB2b1K
         UlKt6Pk9ptqgZjApSwCfRHwT68TIIrfBzX5Jl6JawGXdE/pmQdzIpKLWutJX9BdixuK3
         dEg5UDIWG8GC41lON9Ist+iD/fEydT5SZ0c9JGyjv3ArzJbqW9GX9L4shJ7ODsyF8FR3
         RJbtROJ3z2YLeDw7UoqghirtDnhWaLX120PYm1FT5abaJBxaZZknC9F4Um67Xjgs0Ewy
         Rc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JFNUn7jw7XrbPRCSrUHiiAgppCfO2t4yElt5XDL04Q=;
        b=InlXifF59ZWUA5E7lt4Qm5YaeuhuGwpSphqNLLBbAKgk5vvN6SCR8a77xH+Nqscx2s
         I5hE/sWukyVoCUduOVgPZyu9Ho/abWOhXlUcc1KHOaEpC/7eDgZNmR4GjSLw6oghjiar
         xIRJIj5HYGwT+mtb74lLyIIwVx1e58686UU4PfGpXFppODCrCK4TCdidXgxxlRZrKA4Q
         77jjUawfXiXYguxredKxR4i27zXCmJgQhFFNdSjdCneaB9A0YfMvNrl4KMVv2T/pw0He
         xrTYRXB5sPQjC9uopO6srt0dQH2m/vCdTiUZCNYHbAFWfZvdLqq9CxQ0xLqvf2wgCFgj
         NY2g==
X-Gm-Message-State: AO0yUKW7XLlU9dbtZs1+vdl23qbSuoO1mvfDs6dixyye132duxk9F74w
        e6chbIZu7faOJBygrx0bloWQtFfferusCYjt
X-Google-Smtp-Source: AK7set/xGSag1fLoOp9DRLhykiGJTXM3xHC8HavU0BgIlPvd0BoyqCw5ivDdONyysoMRNXPdY5/4ZA==
X-Received: by 2002:a17:902:d0d1:b0:19a:7548:da30 with SMTP id n17-20020a170902d0d100b0019a7548da30mr8231577pln.3.1676264056763;
        Sun, 12 Feb 2023 20:54:16 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:16 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 10/20] riscv mmu: write protect and shadow stack
Date:   Sun, 12 Feb 2023 20:53:39 -0800
Message-Id: <20230213045351.3945824-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`fork` implements copy on write (COW) by making pages readonly in child
and parent both.

ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
Assumption is that page is readable and on fault copy on write happens.

To implement COW on such pages, clearing up W bit makes them XWR = 000.
This will result in wrong PTE setting which says no perms but V=1 and PFN
field pointing to final page. Instead desired behavior is to turn it into
a readable page, take an access (load/store) fault on sspush/sspop
(shadow stack) and then perform COW on such pages. This way regular reads
would still be allowed and not lead to COW maintaining current behavior
of COW on non-shadow stack but writeable memory.

On the other hand it doesn't interfere with existing COW for read-write
memory. Assumption is always that _PAGE_READ must have been set and thus
setting _PAGE_READ is harmless.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 74dbe122f2fa..13b325253c99 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -334,7 +334,7 @@ static inline int pte_special(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -509,7 +509,15 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	volatile pte_t read_pte = *ptep;
+	/*
+	 * ptep_set_wrprotect can be called for shadow stack ranges too.
+	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
+	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
+	 * but we dont want this wrong configuration to be set in page tables.
+	 */
+	atomic_long_set((atomic_long_t *)ptep,
+			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-- 
2.25.1

