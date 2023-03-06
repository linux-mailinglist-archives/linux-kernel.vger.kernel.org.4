Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F736AC856
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCFQjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCFQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:38:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3839B84
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:37:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E29B21E64;
        Mon,  6 Mar 2023 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678120513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DUOEsA+UNBr/vO361m2bPY9yhOH/7VFzmsusEs0LhE=;
        b=Pnly3Qe54P15pQsm2Gv3mdlsTA+CmSfI+mxgNBvgPwAwFC9OyyDO0YvJw1Bra3RgzqdXUA
        /eSZnKUVSwejcla2/oigzvVqA++wpOjmGXu/x/TmRkNEXjdSrnqDeiBg9c+2GaTbHDmmb5
        9+SwcLb+0Cj2CbdamNUnmZ+UyrxTBjU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4FC713A66;
        Mon,  6 Mar 2023 16:35:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RcSdMkAWBmSLUwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 06 Mar 2023 16:35:12 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 08/12] x86/mtrr: add get_effective_type() service function
Date:   Mon,  6 Mar 2023 17:34:21 +0100
Message-Id: <20230306163425.8324-9-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230306163425.8324-1-jgross@suse.com>
References: <20230306163425.8324-1-jgross@suse.com>
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

Add a service function for obtaining the effective cache mode of
overlapping MTRR registers.

Make use of that function in check_type_overlap().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
---
 arch/x86/kernel/cpu/mtrr/generic.c | 39 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e25a44c2c950..d271e0c73775 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -78,31 +78,30 @@ static u64 get_mtrr_size(u64 mask)
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

