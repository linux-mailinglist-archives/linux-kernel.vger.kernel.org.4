Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7565D6AE1F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjCGOOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjCGON3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:13:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FCE28227
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACD29B818FA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D588C433A4;
        Tue,  7 Mar 2023 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198128;
        bh=4DGW9eGKgpeMklFY1cuDqUCfnQybL1/dGwNaCUqrdDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SR+HtuolschcP7wXkMAy4zoFJ1gpgbHOegTuQNBBwkD9tkHCB395oYEljPGy+zhXk
         nSFqKTdh3BaGJljGPk7ZGsPU66YCZGqdl2Sjb/qvIazPANm7vWnlTMbsJi1zkWeXH9
         S/AKRXaJBwCeBPB/ml4bklMQZODezZiyVNqgfZnWiSBe/fiEnq56N0yR3xJcmI18zC
         t8nm0yuEOtA8x0c96HIfKzlIH/wbKm7G7Zy66l829WZgNARaYG5Mstj2dGYKTCb6w0
         1dk6gPwiHoXJ9U6EBkyDIKepzzZU4CKsr+4wZH6oBHlo5lSewbh6ubfuWyFvGyqd35
         e1dYpfU8JHUjg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 54/60] arm64: ptdump: Deal with translation levels folded at runtime
Date:   Tue,  7 Mar 2023 15:05:16 +0100
Message-Id: <20230307140522.2311461-55-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878; i=ardb@kernel.org; h=from:subject; bh=4DGW9eGKgpeMklFY1cuDqUCfnQybL1/dGwNaCUqrdDg=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpe9BgHJGzYns1KV9rzumrspbnteh7vdYvPeYd27MX zVB2dUdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIRnQz/9K/GbE2PvVD11szR LuVW3Q6P98qlV5puRU1YZ3jh9G2XlYwMqzW0fjq1TpD3bnNZMm/vvhXrVnH9V/5ZtDmLKaBr5dK XvAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the ptdump code deals with folded PMD or PUD levels at build
time, by omitting those levels when invoking note_page. IOW, note_page()
is never invoked with level == 1 if P4Ds are folded in the build
configuration.

With the introduction of LPA2 support, we will defer some of these
folding decisions to runtime, so let's take care of this by overriding
the 'level' argument when this condition triggers.

Substituting the PUD or PMD strings for "PGD" when the level in question
is folded at build time is no longer necessary, and so the conditional
expressions can be simplified. This also makes the indirection of the
'name' field unnecessary, so change that into a char[] array, and make
the whole thing __ro_after_init.

Note that the mm_p?d_folded() functions currently ignore their mm
pointer arguments, but let's wire them up correctly anyway.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/ptdump.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 8aee5d25f3d8cbe6..0e0ad6a5a12e6f04 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -82,6 +82,7 @@ struct pg_state {
 	struct ptdump_state ptdump;
 	struct seq_file *seq;
 	const struct addr_marker *marker;
+	const struct mm_struct *mm;
 	unsigned long start_address;
 	int level;
 	u64 current_prot;
@@ -178,12 +179,12 @@ static const struct prot_bits pte_bits[] = {
 
 struct pg_level {
 	const struct prot_bits *bits;
-	const char *name;
-	size_t num;
+	char name[4];
+	int num;
 	u64 mask;
 };
 
-static struct pg_level pg_level[] = {
+static struct pg_level pg_level[] __ro_after_init = {
 	{ /* pgd */
 		.name	= "PGD",
 		.bits	= pte_bits,
@@ -193,11 +194,11 @@ static struct pg_level pg_level[] = {
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
 	}, { /* pud */
-		.name	= (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
+		.name	= "PUD",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
 	}, { /* pmd */
-		.name	= (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
+		.name	= "PMD",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
 	}, { /* pte */
@@ -261,6 +262,11 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	static const char units[] = "KMGTPE";
 	u64 prot = 0;
 
+	/* check if the current level has been folded dynamically */
+	if ((level == 1 && mm_p4d_folded(st->mm)) ||
+	    (level == 2 && mm_pud_folded(st->mm)))
+		level = 0;
+
 	if (level >= 0)
 		prot = val & pg_level[level].mask;
 
@@ -322,6 +328,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 	st = (struct pg_state){
 		.seq = s,
 		.marker = info->markers,
+		.mm = info->mm,
 		.level = -1,
 		.ptdump = {
 			.note_page = note_page,
-- 
2.39.2

