Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC086D2EB8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjDAGil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjDAGi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:38:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D52B1D908
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:38:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 885F421A48;
        Sat,  1 Apr 2023 06:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680331072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8lUW3P9mpcWjI7lNcX7PnUpBYL4zKefFnDWcjHwwm2k=;
        b=HexWFFQQVN5UN/qYGGwLOJTZXbNlqk67Lpl8/tvSu3uH7ydHzS+4O0feVIQhQJ973OGmFu
        Psqrkxh0wv+Fq+GClVWHorkEtZeRfyGUFk8NUfWidg5ha0oOMlOmIGoGC0+ODkliqiqFeo
        QhdZuv8XWJF+uveQWPaarVoXwuvvc5k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4290B134FB;
        Sat,  1 Apr 2023 06:37:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MbvdDkDRJ2RwdwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 01 Apr 2023 06:37:52 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v5 10/15] x86/mtrr: add get_effective_type() service function
Date:   Sat,  1 Apr 2023 08:36:47 +0200
Message-Id: <20230401063652.23522-11-jgross@suse.com>
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
index 5d60b46187f7..005f07ebb3a3 100644
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

