Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3939B68D09B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjBGHaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjBGH3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:29:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FDA3525B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:29:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7003333AEE;
        Tue,  7 Feb 2023 07:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675754979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8efLSwTwFHqSKPYOUuhtVE2c23rg89tSCfxytpWfroA=;
        b=Fns5WTkkkQ6yqDv5E+lCxZqrmv7sKPqKMzeVV0ljqwpWsuYhjG83UIs3erUJ7mKFm/pVnp
        7HoSHoCrjBQU3f7W/Juzu1+E/kX/5V3bnWHVoqSHxcibyBySOaFL9ezuHhWE9r+KrNi8Sp
        kLCOxl88lfOFxtr9fM3JbCva+/LFMfQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D04E13A8C;
        Tue,  7 Feb 2023 07:29:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Noq+BeP94WPpUQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 07:29:39 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 6/6] x86/mtrr: drop sanity check in mtrr_type_lookup_fixed()
Date:   Tue,  7 Feb 2023 08:29:02 +0100
Message-Id: <20230207072902.5528-7-jgross@suse.com>
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

mtrr_type_lookup_fixed() contains a sanity check for the case it is
being called with a start address above 1 MB. As it is static and it
is called only iff the start address is below 1MB, this sanity check
can be dropped.

This will remove the last case where mtrr_type_lookup() can return
MTRR_TYPE_INVALID, so adjust the comment in include/uapi/asm/mtrr.h.

Note that removing the MTRR_TYPE_INVALID #define from that header
could break user code, so it has to stay.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/uapi/asm/mtrr.h   | 6 +++---
 arch/x86/kernel/cpu/mtrr/generic.c | 6 +-----
 2 files changed, 4 insertions(+), 8 deletions(-)

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
index c749ec4436a1..c17cb00aac6a 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -114,16 +114,12 @@ static int check_type_overlap(u8 *prev, u8 *curr)
  *  0xC0000 - 0xFFFFF : This range is divided into sixty-four 4KB sub-ranges
  *
  * Return Values:
- * MTRR_TYPE_(type)  - Matched memory type
- * MTRR_TYPE_INVALID - Unmatched
+ * MTRR_TYPE_(type)  - Memory type
  */
 static u8 mtrr_type_lookup_fixed(u64 start, u64 end)
 {
 	int idx;
 
-	if (start >= 0x100000)
-		return MTRR_TYPE_INVALID;
-
 	/* 0x0 - 0x7FFFF */
 	if (start < 0x80000) {
 		idx = 0;
-- 
2.35.3

