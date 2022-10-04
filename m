Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C385F3DEC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJDIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJDILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C104AD61
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:10:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 66CFC1F8EF;
        Tue,  4 Oct 2022 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LiedMldWeIT3ErqqDfk2VgDsQE5AXBsEeh4EFbNTzw=;
        b=Kudt6qAVVcFkJOkAuDtlSMrvM71HTbTbxuB+3B+NVuLxGW7fZ4xg0xXfu3twTI1wg0dl33
        Jt0fmbE3NNPQrvxDVILMLe1kjP2gfYzxaAHRndHXD3za+lZgCH0GzjIDJZlXQ7yp+uMWi2
        or7dVgON8pJtspwDrifqxuqYIHbVQC8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C377139EF;
        Tue,  4 Oct 2022 08:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vdOACX7qO2MzSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:10:38 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 02/16] x86/mtrr: remove unused cyrix_set_all() function
Date:   Tue,  4 Oct 2022 10:10:09 +0200
Message-Id: <20221004081023.32402-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221004081023.32402-1-jgross@suse.com>
References: <20221004081023.32402-1-jgross@suse.com>
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

The Cyrix CPU specific MTRR function cyrix_set_all() will never be
called, as the struct mtrr_ops set_all() callback will only be called
in the use_intel() case, which would require the use_intel_if member
of struct mtrr_ops to be set, which isn't the case for Cyrix.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/kernel/cpu/mtrr/cyrix.c | 34 --------------------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
index ca670919b561..c77d3b0a5bf2 100644
--- a/arch/x86/kernel/cpu/mtrr/cyrix.c
+++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
@@ -234,42 +234,8 @@ static void cyrix_set_arr(unsigned int reg, unsigned long base,
 	post_set();
 }
 
-typedef struct {
-	unsigned long	base;
-	unsigned long	size;
-	mtrr_type	type;
-} arr_state_t;
-
-static arr_state_t arr_state[8] = {
-	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL},
-	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}
-};
-
-static unsigned char ccr_state[7] = { 0, 0, 0, 0, 0, 0, 0 };
-
-static void cyrix_set_all(void)
-{
-	int i;
-
-	prepare_set();
-
-	/* the CCRs are not contiguous */
-	for (i = 0; i < 4; i++)
-		setCx86(CX86_CCR0 + i, ccr_state[i]);
-	for (; i < 7; i++)
-		setCx86(CX86_CCR4 + i, ccr_state[i]);
-
-	for (i = 0; i < 8; i++) {
-		cyrix_set_arr(i, arr_state[i].base,
-			      arr_state[i].size, arr_state[i].type);
-	}
-
-	post_set();
-}
-
 static const struct mtrr_ops cyrix_mtrr_ops = {
 	.vendor            = X86_VENDOR_CYRIX,
-	.set_all	   = cyrix_set_all,
 	.set               = cyrix_set_arr,
 	.get               = cyrix_get_arr,
 	.get_free_region   = cyrix_get_free_region,
-- 
2.35.3

