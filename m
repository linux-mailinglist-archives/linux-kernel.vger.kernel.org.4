Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213EE68D097
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBGH3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjBGH3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:29:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA67836089
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:29:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 68AE860F1F;
        Tue,  7 Feb 2023 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675754956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MDR6p3EEVdt6aI87yhW7ogY5yoUM9JM3hkrFmMLxzCQ=;
        b=tDbv7vnL7LeZnXzm7xPgZ0dgekKLu5Kq2IaGD8+x2/lhyO2fRjp33UC/eYHyw/oto49Z3l
        ui0fwheHnag2U7JLyNI+QwYEdOnhKIZRbuOMWZCJXEj5R9HbI/ooM4AhK751VnRmDKBsfr
        HRJ+nvkd9mP2RgasyzPodZaYgpy8G4g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1160313A8C;
        Tue,  7 Feb 2023 07:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n5fiAsz94WO4UQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 07:29:16 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/6] x86/pat: check for MTRRs enabled in memtype_reserve()
Date:   Tue,  7 Feb 2023 08:28:58 +0100
Message-Id: <20230207072902.5528-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230207072902.5528-1-jgross@suse.com>
References: <20230207072902.5528-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today memtype_reserve() bails out early if pat_enabled() returns false.
The same can be done in case MTRRs aren't enabled.

This will reinstate the behavior of memtype_reserve() before commit
72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when
running on Xen"). There have been reports about that commit breaking
SEV-SNP guests under Hyper-V, which was tried to be resolved by commit
90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case"),
but that again resulted in problems with Xen PV guests.

Fixes: 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when running on Xen")
Fixes: 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/pat/memtype.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index fb4b1b5e0dea..18f612b43763 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -557,8 +557,12 @@ int memtype_reserve(u64 start, u64 end, enum page_cache_mode req_type,
 		return -EINVAL;
 	}
 
-	if (!pat_enabled()) {
-		/* This is identical to page table setting without PAT */
+	/*
+	 * PAT disabled or MTRRs disabled don't require any memory type
+	 * tracking or type adjustments, as there can't be any conflicts
+	 * between PAT and MTRRs with at least one of both being disabled.
+	 */
+	if (!pat_enabled() || !mtrr_enabled()) {
 		if (new_type)
 			*new_type = req_type;
 		return 0;
@@ -627,7 +631,7 @@ int memtype_free(u64 start, u64 end)
 	int is_range_ram;
 	struct memtype *entry_old;
 
-	if (!pat_enabled())
+	if (!pat_enabled() || !mtrr_enabled())
 		return 0;
 
 	start = sanitize_phys(start);
-- 
2.35.3

