Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD10D5E5350
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIUSqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIUSqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0538DA2A80;
        Wed, 21 Sep 2022 11:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E0ED6329B;
        Wed, 21 Sep 2022 18:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA781C433C1;
        Wed, 21 Sep 2022 18:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663785968;
        bh=wQYUGUyqzwJsJO/RsNaU0FisMh34F4MXdG+St95jVqE=;
        h=Date:From:To:Cc:Subject:From;
        b=RXZREq02msg/nsxCzBqwwOSmIv3HyMK69Qxg6sIItJPhh+/+0QuDAOLwlmdouwavg
         /oy/p7KbsKdl22+utCwKiehAgFXxRA6ZT4LVxROeLWPEv+gRT3BfAxHsxBe6+bvXJA
         0xTcI1xfBzxoP3YC7WOlFthNzemO6SPy6mn46upu1qzZlD7jfIueTjrVFco+81+Yog
         IFOHyvNxqk21YfCLU5E2ERsRnypQQDYpIpxvoPmpe8uJTMoit5AesDDbJDpSWooP10
         b3lK9YCgB50IQamXR7s83gW/O36aWwT5fxP6qoyMkvHQwqx12AfN+RACNav7fECjo1
         ktiO4fkxxET/g==
Date:   Wed, 21 Sep 2022 13:46:03 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] mm/pgtable: Fix multiple -Wstringop-overflow warnings
Message-ID: <Yytb67xvrnctxnEe@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual size of the following arrays at run-time depends on
CONFIG_X86_PAE.

427         pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
428         pmd_t *pmds[MAX_PREALLOCATED_PMDS];

If CONFIG_X86_PAE is not enabled, their final size will be zero. In that
case, the compiler complains about trying to access objects of size zero
when calling functions where these objects are passed as arguments.

Fix this by sanity-checking the size of those arrays just before the
function calls. Also, the following warnings are fixed by these changes
when building with GCC-11 and -Wstringop-overflow enabled:

arch/x86/mm/pgtable.c:437:13: warning: ‘preallocate_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:440:13: warning: ‘preallocate_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:462:9: warning: ‘free_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:455:9: warning: ‘pgd_prepopulate_user_pmd’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:464:9: warning: ‘free_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/203
Link: https://github.com/KSPP/linux/issues/181
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/x86/mm/pgtable.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 8525f2876fb4..5116df6a308c 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -434,10 +434,12 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	mm->pgd = pgd;
 
-	if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
+	if (sizeof(pmds) != 0 &&
+			preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
 		goto out_free_pgd;
 
-	if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
+	if (sizeof(u_pmds) != 0 &&
+			preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
 		goto out_free_pmds;
 
 	if (paravirt_pgd_alloc(mm) != 0)
@@ -451,17 +453,22 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	spin_lock(&pgd_lock);
 
 	pgd_ctor(mm, pgd);
-	pgd_prepopulate_pmd(mm, pgd, pmds);
-	pgd_prepopulate_user_pmd(mm, pgd, u_pmds);
+	if (sizeof(pmds) != 0)
+		pgd_prepopulate_pmd(mm, pgd, pmds);
+
+	if (sizeof(u_pmds) != 0)
+		pgd_prepopulate_user_pmd(mm, pgd, u_pmds);
 
 	spin_unlock(&pgd_lock);
 
 	return pgd;
 
 out_free_user_pmds:
-	free_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS);
+	if (sizeof(u_pmds) != 0)
+		free_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS);
 out_free_pmds:
-	free_pmds(mm, pmds, PREALLOCATED_PMDS);
+	if (sizeof(pmds) != 0)
+		free_pmds(mm, pmds, PREALLOCATED_PMDS);
 out_free_pgd:
 	_pgd_free(pgd);
 out:
-- 
2.34.1

