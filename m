Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1569012E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBIHX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBIHXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:23:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D35342DF6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:22:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4ECF5C222;
        Thu,  9 Feb 2023 07:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675927377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/TdnBDA6vtZIeltc4dNIeTCjXcEoUw2SXAii0hNOAs=;
        b=rU6L7/gAsZQbnSs8QIonGyYpZQf6gX6EDnm1EQJPpZsDdwU2Vk/eF1pD4eIU7yjHIQbBp3
        ywLutBDNczAAroxue8LtKXBGjwEyucyXXa/ajr7nNHKEYpoTn+EiQKdT0f2AmHHi7S3eHY
        TU2dpIs4JBoXxMC7lMAgUMHReF8NnFg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C97D1339E;
        Thu,  9 Feb 2023 07:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7S87HVGf5GMTeQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 09 Feb 2023 07:22:57 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 6/8] x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
Date:   Thu,  9 Feb 2023 08:22:18 +0100
Message-Id: <20230209072220.6836-7-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209072220.6836-1-jgross@suse.com>
References: <20230209072220.6836-1-jgross@suse.com>
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

mtrr_type_lookup() should always return a valid memory type. In case
there is no information available, it should return the default UC.
At the same time the mtrr_type_lookup() stub for the !CONFIG_MTRR
case should set uniform to 1, as if the memory range would be
covered by no MTRR at all.

In the CONFIG_MTRR case make sure uniform is always set to either 0
or 1. Without mtrr_state_set set it to 0, as it isn't known yet whether
the covered range is uniform or not (in fact there is currently no
caller interested in the uniform value before mtrr_state_set is being
set). With MTRRs disabled uniform can be set to 1.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- always set uniform
- set uniform to 1 in case of disabled MTRRs (Linus Torvalds)
---
 arch/x86/include/asm/mtrr.h        |  7 +++++--
 arch/x86/kernel/cpu/mtrr/generic.c | 12 ++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 0b8f51d683dc..f362c33e3d74 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -53,9 +53,12 @@ void mtrr_generic_set_state(void);
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
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 788bc16888a5..afb59ff2cc00 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -299,11 +299,15 @@ u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
 	/* Make end inclusive instead of exclusive */
 	end--;
 
-	if (!mtrr_state_set)
-		return MTRR_TYPE_INVALID;
+	if (!mtrr_state_set) {
+		*uniform = 0;	/* Uniformity is unknown. */
+		return MTRR_TYPE_UNCACHABLE;
+	}
 
-	if (!(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED))
-		return MTRR_TYPE_INVALID;
+	if (!(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED)) {
+		*uniform = 1;
+		return MTRR_TYPE_UNCACHABLE;
+	}
 
 	/*
 	 * Look up the fixed ranges first, which take priority over
-- 
2.35.3

