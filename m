Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58972F66D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbjFNHfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbjFNHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:35:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F31727
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:35:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73AED21857;
        Wed, 14 Jun 2023 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686728114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgJA17a1c7AVDrVoB4HwZlBuwIqmPEUlEc3gzIFv3pY=;
        b=SrM4IiLyt4N7guH1CZIQ0nKGj3L6b9HODrNWAv2YMcYoNAzVz4cSCZUEiGSmZnKipU46r4
        2rb0hubPsFyJGeQAp07phllcBHG8owzj2AAk30x9UBgKykWUiR7mPeWxvtj2r6yf+D8NcY
        MlCT16p+pawSJdSdangqU0dacCuGAAU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20CA01391E;
        Wed, 14 Jun 2023 07:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wH2bBrJtiWQyHwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 14 Jun 2023 07:35:14 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v4 1/2] x86/xen: add prototypes for paravirt mmu functions
Date:   Wed, 14 Jun 2023 09:35:00 +0200
Message-Id: <20230614073501.10101-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230614073501.10101-1-jgross@suse.com>
References: <20230614073501.10101-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paravirt MMU functions called via the PV_CALLEE_SAVE_REGS_THUNK()
macro can't be defined to be static, as the macro is generating a
function via asm() statement calling the paravirt MMU function.

In order to avoid warnings when specifying "-Wmissing-prototypes" for
the build, add local prototypes (there should never be any external
caller of those functions).

Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/mmu_pv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b3b8d289b9ab..e0a975165de7 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -86,6 +86,22 @@
 #include "mmu.h"
 #include "debugfs.h"
 
+/*
+ * Prototypes for functions called via PV_CALLEE_SAVE_REGS_THUNK() in order
+ * to avoid warnings with "-Wmissing-prototypes".
+ */
+pteval_t xen_pte_val(pte_t pte);
+pgdval_t xen_pgd_val(pgd_t pgd);
+pmdval_t xen_pmd_val(pmd_t pmd);
+pudval_t xen_pud_val(pud_t pud);
+p4dval_t xen_p4d_val(p4d_t p4d);
+pte_t xen_make_pte(pteval_t pte);
+pgd_t xen_make_pgd(pgdval_t pgd);
+pmd_t xen_make_pmd(pmdval_t pmd);
+pud_t xen_make_pud(pudval_t pud);
+p4d_t xen_make_p4d(p4dval_t p4d);
+pte_t xen_make_pte_init(pteval_t pte);
+
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
 /* l3 pud for userspace vsyscall mapping */
 static pud_t level3_user_vsyscall[PTRS_PER_PUD] __page_aligned_bss;
-- 
2.35.3

