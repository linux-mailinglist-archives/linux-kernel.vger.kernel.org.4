Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5DB6A55EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjB1JgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjB1JgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:36:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9699029E15;
        Tue, 28 Feb 2023 01:36:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 48BE71FDC2;
        Tue, 28 Feb 2023 09:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677576967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=taaLiLGPxaqufQ2R430/cnXrJjAKnDyXV614KjX4P38=;
        b=sRYmU6Y+9Zjnuojqw1yyR1C1Xp+9gqic7ETrAJ3f22NJo30oigfnbYDwhbX0i9t2VjZoiO
        sW2uWwZ7QfeFSPg9axfWslKerdOqD5BZAFjkeRhprGry1Hbpts70WHkSdwvXa6I0suORvg
        NemgZnzptyk33aeqDm6EmH8/Q88KE/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677576967;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=taaLiLGPxaqufQ2R430/cnXrJjAKnDyXV614KjX4P38=;
        b=8pKw1F7iyYH/ijfXTkoUdIAp9bjuwkUcZT407zpqJ4gKz/BMDqpCi53C+jNZm/ueHSUeNr
        oiwzzXLaHnb/VTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21EE91333C;
        Tue, 28 Feb 2023 09:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mMCXBwfL/WNzOAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 28 Feb 2023 09:36:07 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] tomoyo: replace tomoyo_round2() with kmalloc_size_roundup()
Date:   Tue, 28 Feb 2023 10:35:56 +0100
Message-Id: <20230228093556.19027-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.39.2
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

It seems tomoyo has had its own implementation of what
kmalloc_size_roundup() does today. Remove the function tomoyo_round2()
and replace it with kmalloc_size_roundup(). It provides more accurate
results and doesn't contain a while loop.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 security/tomoyo/audit.c  |  6 +++---
 security/tomoyo/common.c |  2 +-
 security/tomoyo/common.h | 44 ----------------------------------------
 3 files changed, 4 insertions(+), 48 deletions(-)

diff --git a/security/tomoyo/audit.c b/security/tomoyo/audit.c
index 7cf8fdbb29bf..610c1536cf70 100644
--- a/security/tomoyo/audit.c
+++ b/security/tomoyo/audit.c
@@ -271,7 +271,7 @@ char *tomoyo_init_log(struct tomoyo_request_info *r, int len, const char *fmt,
 		/* +18 is for " symlink.target=\"%s\"" */
 		len += 18 + strlen(symlink);
 	}
-	len = tomoyo_round2(len);
+	len = kmalloc_size_roundup(len);
 	buf = kzalloc(len, GFP_NOFS);
 	if (!buf)
 		goto out;
@@ -382,12 +382,12 @@ void tomoyo_write_log2(struct tomoyo_request_info *r, int len, const char *fmt,
 		goto out;
 	}
 	entry->log = buf;
-	len = tomoyo_round2(strlen(buf) + 1);
+	len = kmalloc_size_roundup(strlen(buf) + 1);
 	/*
 	 * The entry->size is used for memory quota checks.
 	 * Don't go beyond strlen(entry->log).
 	 */
-	entry->size = len + tomoyo_round2(sizeof(*entry));
+	entry->size = len + kmalloc_size_roundup(sizeof(*entry));
 	spin_lock(&tomoyo_log_lock);
 	if (tomoyo_memory_quota[TOMOYO_MEMORY_AUDIT] &&
 	    tomoyo_memory_used[TOMOYO_MEMORY_AUDIT] + entry->size >=
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index f4cd9b58b205..969d4aa6fd55 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2094,7 +2094,7 @@ int tomoyo_supervisor(struct tomoyo_request_info *r, const char *fmt, ...)
 		tomoyo_add_entry(r->domain, entry.query);
 		goto out;
 	}
-	len = tomoyo_round2(entry.query_len);
+	len = kmalloc_size_roundup(entry.query_len);
 	entry.domain = r->domain;
 	spin_lock(&tomoyo_query_list_lock);
 	if (tomoyo_memory_quota[TOMOYO_MEMORY_QUERY] &&
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index ca285f362705..a539b2cbb5c4 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -1276,50 +1276,6 @@ static inline struct tomoyo_policy_namespace *tomoyo_current_namespace(void)
 	return tomoyo_domain()->ns;
 }
 
-#if defined(CONFIG_SLOB)
-
-/**
- * tomoyo_round2 - Round up to power of 2 for calculating memory usage.
- *
- * @size: Size to be rounded up.
- *
- * Returns @size.
- *
- * Since SLOB does not round up, this function simply returns @size.
- */
-static inline int tomoyo_round2(size_t size)
-{
-	return size;
-}
-
-#else
-
-/**
- * tomoyo_round2 - Round up to power of 2 for calculating memory usage.
- *
- * @size: Size to be rounded up.
- *
- * Returns rounded size.
- *
- * Strictly speaking, SLAB may be able to allocate (e.g.) 96 bytes instead of
- * (e.g.) 128 bytes.
- */
-static inline int tomoyo_round2(size_t size)
-{
-#if PAGE_SIZE == 4096
-	size_t bsize = 32;
-#else
-	size_t bsize = 64;
-#endif
-	if (!size)
-		return 0;
-	while (size > bsize)
-		bsize <<= 1;
-	return bsize;
-}
-
-#endif
-
 /**
  * list_for_each_cookie - iterate over a list with cookie.
  * @pos:        the &struct list_head to use as a loop cursor.
-- 
2.39.2

