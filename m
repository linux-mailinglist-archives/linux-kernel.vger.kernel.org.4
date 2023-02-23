Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477236A04EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjBWJeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBWJeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:34:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C028521F3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:33:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 635B55BCDA;
        Thu, 23 Feb 2023 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677144812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=giP0u1C+dvPPqTKSG2bWaEcZUpvRoq1LAx6b5DjGt7g=;
        b=CrOhjwUsctZ8k2OdmtHPfxkAFsnDj/8s7qke8cBloqAyCHVlz0A6x2aOq1vUuHoo+7tYwy
        XR7oHjOV5NumvC8Yz2wxHPLdlcv6JF/2Qgc9JUbu/1bv5F9HVkTkuPb3ozTSkcfUFvx7dM
        GxtweXtXQtdNvg0XrdcnaaOfLGeKwZo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23E2D13928;
        Thu, 23 Feb 2023 09:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6WVwB+wy92PGbAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Feb 2023 09:33:32 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 08/12] x86/mtrr: add get_effective_type() service function
Date:   Thu, 23 Feb 2023 10:32:39 +0100
Message-Id: <20230223093243.1180-9-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230223093243.1180-1-jgross@suse.com>
References: <20230223093243.1180-1-jgross@suse.com>
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
index bccd5f23dfe0..1ad08a96989c 100644
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

