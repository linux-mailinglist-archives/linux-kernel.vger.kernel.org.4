Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7DB6F436D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjEBML3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjEBMLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:11:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DF459FA
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:10:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E2142225C;
        Tue,  2 May 2023 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683029439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOpgBV0+omk7fDWKz1A1GeqrS6LU5ZyU3wjqQk4HBv4=;
        b=aRpPaRY7wbWUOC22ExpKgXITJImcgArvtXJ6bzrgqUDF+b/R9yrYhp3sOqag5LMiNu/PsH
        CFNLiWWRXDtSb4qTVhDFOsv4M1gOi3nPpfrHiGUfQ9UTebzktfP3kk+adioMMemYpadqOr
        CTSGhp5BMwnOu9vsxNVxCsBXOmammhU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A9C1139C3;
        Tue,  2 May 2023 12:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hQwMBb/9UGQOMAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 02 May 2023 12:10:39 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mikelley@microsoft.com, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 10/16] x86/mtrr: add get_effective_type() service function
Date:   Tue,  2 May 2023 14:09:25 +0200
Message-Id: <20230502120931.20719-11-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230502120931.20719-1-jgross@suse.com>
References: <20230502120931.20719-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a service function for obtaining the effective cache mode of
overlapping MTRR registers.

Make use of that function in check_type_overlap().

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V3:
- new patch
---
 arch/x86/kernel/cpu/mtrr/generic.c | 39 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index cd887327ba3a..44e035a8e9fb 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -86,31 +86,30 @@ static u64 get_mtrr_size(u64 mask)
 	return size;
 }
 
+static u8 get_effective_type(u8 type1, u8 type2)
+{
+	if (type1 == MTRR_TYPE_UNCACHABLE || type2 == MTRR_TYPE_UNCACHABLE)
+		return MTRR_TYPE_UNCACHABLE;
+
+	if ((type1 == MTRR_TYPE_WRBACK && type2 == MTRR_TYPE_WRTHROUGH) ||
+	    (type1 == MTRR_TYPE_WRTHROUGH && type2 == MTRR_TYPE_WRBACK))
+		return MTRR_TYPE_WRTHROUGH;
+
+	if (type1 != type2)
+		return MTRR_TYPE_UNCACHABLE;
+
+	return type1;
+}
+
 /*
  * Check and return the effective type for MTRR-MTRR type overlap.
- * Returns 1 if the effective type is UNCACHEABLE, else returns 0
+ * Returns true if the effective type is UNCACHEABLE, else returns false
  */
-static int check_type_overlap(u8 *prev, u8 *curr)
+static bool check_type_overlap(u8 *prev, u8 *curr)
 {
-	if (*prev == MTRR_TYPE_UNCACHABLE || *curr == MTRR_TYPE_UNCACHABLE) {
-		*prev = MTRR_TYPE_UNCACHABLE;
-		*curr = MTRR_TYPE_UNCACHABLE;
-		return 1;
-	}
-
-	if ((*prev == MTRR_TYPE_WRBACK && *curr == MTRR_TYPE_WRTHROUGH) ||
-	    (*prev == MTRR_TYPE_WRTHROUGH && *curr == MTRR_TYPE_WRBACK)) {
-		*prev = MTRR_TYPE_WRTHROUGH;
-		*curr = MTRR_TYPE_WRTHROUGH;
-	}
+	*prev = *curr = get_effective_type(*curr, *prev);
 
-	if (*prev != *curr) {
-		*prev = MTRR_TYPE_UNCACHABLE;
-		*curr = MTRR_TYPE_UNCACHABLE;
-		return 1;
-	}
-
-	return 0;
+	return *prev == MTRR_TYPE_UNCACHABLE;
 }
 
 /**
-- 
2.35.3

