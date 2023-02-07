Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C6068D099
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBGH3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjBGH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:29:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728B6360B3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:29:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5D1960F1F;
        Tue,  7 Feb 2023 07:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675754967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FL8lZ8VzNgVUhkoi8dmft+rrAn+Q6LoB7UFRnauUMu0=;
        b=dVFX1eOAI+AHMp/mXW02giADSuEANXVa3rEQogBIx/Qwagzw60RQaeO9BHKPUtVaTXgtfX
        C4zJ64w+HEu6kN8neiYYSg/4W6pAfUK2jWRY1TqABNawzFK0zT6xMk69o4yH321E9wgtBA
        sAewnLXp/xK10S7tEq5PljbDHH7OAkY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97EE413A8C;
        Tue,  7 Feb 2023 07:29:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cmm0I9f94WPQUQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 07:29:27 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4/6] x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
Date:   Tue,  7 Feb 2023 08:29:00 +0100
Message-Id: <20230207072902.5528-5-jgross@suse.com>
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

mtrr_type_lookup() should always return a valid memory type. In case
there is no information available, it should return the default UC.
At the same time the mtrr_type_lookup() stub for the !CONFIG_MTRR
case should set uniform to 1, as if the memory range would be
covered by no MTRR at all.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/mtrr.h        | 7 +++++--
 arch/x86/kernel/cpu/mtrr/generic.c | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 29ec2d6f0537..c12c73d48f08 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -57,9 +57,12 @@ static inline bool mtrr_enabled(void)
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
index ee09d359e08f..c749ec4436a1 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -262,10 +262,10 @@ u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
 	end--;
 
 	if (!mtrr_state_set)
-		return MTRR_TYPE_INVALID;
+		return MTRR_TYPE_UNCACHABLE;
 
 	if (!(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED))
-		return MTRR_TYPE_INVALID;
+		return MTRR_TYPE_UNCACHABLE;
 
 	/*
 	 * Look up the fixed ranges first, which take priority over
-- 
2.35.3

