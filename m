Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1649B66398C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjAJGyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAJGyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:54:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1666329
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:54:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0DAFB4DF19;
        Tue, 10 Jan 2023 06:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673333669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EY5VTFqEZnBurGAFOn7Hf0q4d99CjK26BXkX9qKxYzI=;
        b=uCasEm8pmLDgbmNRkOO2o0yoCwC7zvpOG0NPvrbSwLbuuhPWzB8Y+xF4BgoTJNpEq4fNEl
        cVL/mwX0zuB609+SoTlHs2FvOyGoa97lYSQ/H9iAnpAJ0KtmnvKMbpy6N627DNzF03jEpU
        VaKzrQAXDZLB0BG5xT8xAo2QysnUvOE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B049113338;
        Tue, 10 Jan 2023 06:54:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z5GqKaQLvWN4YQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 10 Jan 2023 06:54:28 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mikelley@microsoft.com, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/pat: fix pat_x_mtrr_type() for MTRR disabled case
Date:   Tue, 10 Jan 2023 07:54:27 +0100
Message-Id: <20230110065427.20767-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
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

Since commit 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly
reflect state when running on Xen") PAT can be enabled without MTRR.

This has resulted in problems e.g. for a SEV-SNP guest running under
Hyper-V, when trying to establish a new mapping via memremap() with
WB caching mode, as pat_x_mtrr_type() will call mtrr_type_lookup(),
which in turn is returning MTRR_TYPE_INVALID due to MTRR being
disabled in this configuration. The result is a mapping with UC-
caching, leading to severe performance degradation.

Fix that by handling MTRR_TYPE_INVALID the same way as MTRR_TYPE_WRBACK
in pat_x_mtrr_type().

Fixes: 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when running on Xen")
Reported-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/pat/memtype.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 46de9cf5c91d..fb4b1b5e0dea 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -387,7 +387,8 @@ static unsigned long pat_x_mtrr_type(u64 start, u64 end,
 		u8 mtrr_type, uniform;
 
 		mtrr_type = mtrr_type_lookup(start, end, &uniform);
-		if (mtrr_type != MTRR_TYPE_WRBACK)
+		if (mtrr_type != MTRR_TYPE_WRBACK &&
+		    mtrr_type != MTRR_TYPE_INVALID)
 			return _PAGE_CACHE_MODE_UC_MINUS;
 
 		return _PAGE_CACHE_MODE_WB;
-- 
2.35.3

