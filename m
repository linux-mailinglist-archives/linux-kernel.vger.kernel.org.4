Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810E96D2EBE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjDAGjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjDAGiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:38:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361D922E97
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:38:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D556219FD;
        Sat,  1 Apr 2023 06:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680331089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3mHtqPo7I900IUU9mKC4TzJ6vMfpxeByTBPYTni3oA=;
        b=vLYErCtxmtJVZB4JAZxlvoZxl0KM5olB0YNHXZ6oMKkVa2hg3jOr9XLg+Ev7hH476WOehs
        5ngjU22Qv75iC/FsbU+NWebMjFNQfy9eQPVUROKkUAKqmxeUcQY78nYMvVSwqbsti4ENwa
        aR+dlCzD+UQ1GXdQk6xc/xmnOxUBUv0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5376F134FB;
        Sat,  1 Apr 2023 06:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5FgKE1HRJ2SJdwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 01 Apr 2023 06:38:09 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v5 13/15] x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
Date:   Sat,  1 Apr 2023 08:36:50 +0200
Message-Id: <20230401063652.23522-14-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230401063652.23522-1-jgross@suse.com>
References: <20230401063652.23522-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtrr_type_lookup() should always return a valid memory type. In case
there is no information available, it should return the default UC.

This will remove the last case where mtrr_type_lookup() can return
MTRR_TYPE_INVALID, so adjust the comment in include/uapi/asm/mtrr.h.

Note that removing the MTRR_TYPE_INVALID #define from that header
could break user code, so it has to stay.

At the same time the mtrr_type_lookup() stub for the !CONFIG_MTRR
case should set uniform to 1, as if the memory range would be
covered by no MTRR at all.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V2:
- always set uniform
- set uniform to 1 in case of disabled MTRRs (Linus Torvalds)
V3:
- adjust include/uapi/asm/mtrr.h comment
---
 arch/x86/include/asm/mtrr.h        | 7 +++++--
 arch/x86/include/uapi/asm/mtrr.h   | 6 +++---
 arch/x86/kernel/cpu/mtrr/generic.c | 4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 6decb18e22ed..b17a66da1237 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -77,9 +77,12 @@ static inline void mtrr_overwrite_state(struct mtrr_var_range *var,
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
 	/*
-	 * Return no-MTRRs:
+	 * Return the default MTRR type, without any known other types in
+	 * that range.
 	 */
-	return MTRR_TYPE_INVALID;
+	*uniform = 1;
+
+	return MTRR_TYPE_UNCACHABLE;
 }
 #define mtrr_save_fixed_ranges(arg) do {} while (0)
 #define mtrr_save_state() do {} while (0)
diff --git a/arch/x86/include/uapi/asm/mtrr.h b/arch/x86/include/uapi/asm/mtrr.h
index 376563f2bac1..4aa05c2ffa78 100644
--- a/arch/x86/include/uapi/asm/mtrr.h
+++ b/arch/x86/include/uapi/asm/mtrr.h
@@ -115,9 +115,9 @@ struct mtrr_state_type {
 #define MTRR_NUM_TYPES       7
 
 /*
- * Invalid MTRR memory type.  mtrr_type_lookup() returns this value when
- * MTRRs are disabled.  Note, this value is allocated from the reserved
- * values (0x7-0xff) of the MTRR memory types.
+ * Invalid MTRR memory type.  No longer used outside of MTRR code.
+ * Note, this value is allocated from the reserved values (0x7-0xff) of
+ * the MTRR memory types.
  */
 #define MTRR_TYPE_INVALID    0xff
 
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 5d502b926dd8..178253d117c6 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -463,13 +463,13 @@ u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
 
 	if (!mtrr_state_set) {
 		*uniform = 0;	/* Uniformity is unknown. */
-		return MTRR_TYPE_INVALID;
+		return MTRR_TYPE_UNCACHABLE;
 	}
 
 	*uniform = 1;
 
 	if (!(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED))
-		return MTRR_TYPE_INVALID;
+		return MTRR_TYPE_UNCACHABLE;
 
 	for (i = 0; i < cache_map_n && start < end; i++) {
 		if (start >= cache_map[i].end)
-- 
2.35.3

