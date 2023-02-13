Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6F693D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjBMEzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBMEyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1551C12057
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w14-20020a17090a5e0e00b00233d3b9650eso3255889pjf.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAzQKFN9fphLzkQzVxdl+t+n6lDoHdhoPqbxrAYfAdc=;
        b=kZrZu0bYDptQxePaYYW5IiHENzLnR3Hl5Yn1XhJJL9GBA8lybF2jXV1FzNJJxICLkT
         a76RJFpXxug5ATjloRUOr8I8E6r1tLzdXjGJ0Qsl+Fq7DgOVfV1Tj2I18RmYVVGDny57
         stTv0BaITP2dFVen5rv+DyWUSEmR4p/4j6Do5jXOkmSh2aCjXbc5cneDYp6VKgWxdYeR
         V/IITNgt28T1uNdrYT+/i9jvhEWnIFHLATtGzqhKDcK75PyIrKDukVVcIaz5/ofVGCtN
         JzG6CdfoohdOh1bR5skxW9jJEL8WNm6Yj/noVQmdJFlL81MDGK8ekdk5rZb7EPVZFOCh
         cRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAzQKFN9fphLzkQzVxdl+t+n6lDoHdhoPqbxrAYfAdc=;
        b=1NqsneeDsU7auUl/TEny1Pd/8//MCaiP82jyPm/jhJe0vhyOTEOMHMz/5iNlWc7wkv
         U+U1DTmAVR5A8yyio1WWk3hstMQb+tBI78B+9nn0mZkrQd7oCG8MYw1Uj21y/zZjp8SO
         iDr6rwJXP+Kh+KNn+iRtPu/dIdBjllMcWlIcr14kRUnRfWksKEHaaHFYBrAyNN5KqiOI
         gvHGNKUI/EMH2ebrSb8Oac5lsRz6nWKBDkzApikdbrGy2TjZkktwqT/0h0yvRsJbWNCi
         PCarMRdNVO7Kf9Me/naebmvN94mLQkfBLtSkLarermHwdFfte2ctjRT5mp2OZCgsRnxP
         jLwg==
X-Gm-Message-State: AO0yUKWnkqeRvv7MAcQaxBcRXTx1ik7CS/YPBrAcadVlwVNWrwwRpvr1
        9HFlbfIEnY4EgHUmyAgivYUdmVy1qML2h1Qo
X-Google-Smtp-Source: AK7set+q3tR/PIwP9Bbjl2iUKClzuopM66yTbSa12i2bcSlheS/OuqnmDnzRqlEjdGKp/Rvp7uURng==
X-Received: by 2002:a17:902:ec82:b0:198:f145:504f with SMTP id x2-20020a170902ec8200b00198f145504fmr29915899plg.30.1676264059867;
        Sun, 12 Feb 2023 20:54:19 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:19 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 12/20] riscv mm: manufacture shadow stack pte and is vma shadowstack
Date:   Sun, 12 Feb 2023 20:53:41 -0800
Message-Id: <20230213045351.3945824-13-debug@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv) if
CONFIG_USER_SHADOW_STACK is selected. Creating shadow stack PTE on riscv
means that clearing RWX and then setting W=1.
Additionally this patch implements `arch_is_shadow_stack_vma`. Each arch
can decide which combination of VMA flags are treated as shadow stack.
riscv is choosing to following PTE encodings for VMA flags as well i.e.
VM_WRITE only (no VM_READ or VM_EXEC) means its a shadow stack vma on
riscv.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 8 ++++++++
 arch/riscv/mm/pageattr.c         | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 13b325253c99..11a423e78d52 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -344,6 +344,14 @@ static inline pte_t pte_mkwrite(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+#ifdef CONFIG_USER_SHADOW_STACK
+static inline pte_t pte_mkshdwstk(pte_t pte)
+{
+	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+#endif
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 86c56616e5de..582e17c4dc28 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -233,3 +233,10 @@ bool kernel_page_present(struct page *page)
 	pte = pte_offset_kernel(pmd, addr);
 	return pte_present(*pte);
 }
+
+#ifdef CONFIG_USER_SHADOW_STACK
+bool arch_is_shadow_stack_vma(struct vm_area_struct *vma)
+{
+	return ((vma->vm_flags & (VM_WRITE | VM_READ | VM_EXEC)) == VM_WRITE);
+}
+#endif
\ No newline at end of file
-- 
2.25.1

