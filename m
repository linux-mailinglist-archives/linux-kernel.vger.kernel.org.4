Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E69F6193A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiKDJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiKDJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:34:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E4A26565
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:34:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF5191F8C8;
        Fri,  4 Nov 2022 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667554455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uL2I7PHjAFL8wwyrnZLGiRmIfuUYeK00tu0Z3hdbT3k=;
        b=DUQ8gDjB3AbF7aAFYp3cf73rrg7rxISxQVeKrFk9UMeDmSEnJr0x88quAbrXTReruO23Up
        nGm6Us5KaFkT3xbbaotZldg3Se0q9CkRtBsQuFiSzTroeGdXfyizEkFCh9Pj20vRO61zep
        ruzmGb6fhZm1+EgfQxmnZoe9I7tMMmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667554455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uL2I7PHjAFL8wwyrnZLGiRmIfuUYeK00tu0Z3hdbT3k=;
        b=8gpZar+FBkFd8Tjn016GU3FcGMaGjV6S9jhIbQtaLCw+FxLyOi665XxaLoCzzVIcFUOHhV
        ej1iy+tCaLfJ3rBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DB401346F;
        Fri,  4 Nov 2022 09:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MJNsApXcZGP3BQAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 04 Nov 2022 09:34:13 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 3/3] mm,page_owner: Filter out stacks by a threshold counter
Date:   Fri,  4 Nov 2022 10:33:54 +0100
Message-Id: <20221104093354.6218-4-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221104093354.6218-1-osalvador@suse.de>
References: <20221104093354.6218-1-osalvador@suse.de>
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

We want to be able to filter out the output on a threshold basis,
in this way we can get rid of a lot of noise and focus only on those
stacks which have an allegedly high counter.

We can control the threshold value by a new file called
'page_owner_threshold', which is 0 by default.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h |  3 +++
 lib/stackdepot.c           | 17 ++++++++++++++++-
 mm/page_owner.c            |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index ca048a79bf7c..c998b8024534 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -70,6 +70,9 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
 void *stack_start(struct seq_file *m, loff_t *ppos);
 void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
 int stack_print(struct seq_file *m, void *v);
+
+int page_owner_threshold_get(void *data, u64 *val);
+int page_owner_threshold_set(void *data, u64 val);
 #endif
 
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 97e5dce40f4b..b70d081d7c61 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -569,6 +569,9 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
 EXPORT_SYMBOL_GPL(stack_depot_save_action);
 
 #ifdef CONFIG_PAGE_OWNER
+
+static unsigned long page_owner_stack_threshold = 0;
+
 void *stack_start(struct seq_file *m, loff_t *ppos)
 {
 	unsigned long *table = m->private;
@@ -624,7 +627,7 @@ int stack_print(struct seq_file *m, void *v)
 
 	if (!stack->size || stack->size < 0 ||
 	    stack->size > PAGE_SIZE || stack->handle.valid != 1 ||
-	    refcount_read(&stack->count) < 1)
+	    refcount_read(&stack->count) < page_owner_stack_threshold)
 		return 0;
 
 	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
@@ -637,4 +640,16 @@ int stack_print(struct seq_file *m, void *v)
 
         return 0;
 }
+
+int page_owner_threshold_get(void *data, u64 *val)
+{
+        *val = page_owner_stack_threshold;
+        return 0;
+}
+
+int page_owner_threshold_set(void *data, u64 val)
+{
+        page_owner_stack_threshold = val;
+        return 0;
+}
 #endif
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 3808c0985060..3e05ebd25ba0 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -694,6 +694,9 @@ const struct file_operations page_owner_stack_operations = {
 	.release        = seq_release,
 };
 
+DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
+                        &page_owner_threshold_set, "%lu");
+
 static int __init pageowner_init(void)
 {
 	if (!static_branch_unlikely(&page_owner_inited)) {
@@ -706,6 +709,8 @@ static int __init pageowner_init(void)
 
 	debugfs_create_file("page_owner_stacks", S_IRUSR, NULL, NULL,
 			     &page_owner_stack_operations);
+	debugfs_create_file("page_owner_threshold", 0600, NULL, NULL,
+			    &proc_page_owner_threshold);
 
 	return 0;
 }
-- 
2.35.3

