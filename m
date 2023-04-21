Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C706EA80E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjDUKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjDUKOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:14:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5F1BBA4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:14:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AD021FDDD;
        Fri, 21 Apr 2023 10:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682072080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPdsIHAkF3dojDaKePRBYhF7VPy8HOJoJzQ2IPR70Ow=;
        b=DdqlQbKRzrk0ecb+luhX0blRgkUDuGYm7WDDLDbPi4vbYnYkhLJT1pTwGhsTuvYWAEJqri
        kt5QbY3sB5G4gVZ9eIoQ6+DLmEsMikliivsd9cqxZT4qwbGlwF7i+ONMsDKtZ/Y2fep0fG
        7oIwPv7A4PDhJeFJjeNvR+3jlGc4xXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682072080;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPdsIHAkF3dojDaKePRBYhF7VPy8HOJoJzQ2IPR70Ow=;
        b=x4vnIpaKeT0Oe6Mjy4yVpvO3QSsS3+iLzk0GjWPcysPnP0FWH94mz8RNdbfDyx1Ki8iouK
        v40Oc8hZwlD9BJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BABC11390E;
        Fri, 21 Apr 2023 10:14:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UDFAKg5iQmRNaAAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 21 Apr 2023 10:14:38 +0000
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
Subject: [PATCH v4 3/3] mm,page_owner: Filter out stacks by a threshold counter
Date:   Fri, 21 Apr 2023 12:14:15 +0200
Message-Id: <20230421101415.5734-4-osalvador@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421101415.5734-1-osalvador@suse.de>
References: <20230421101415.5734-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index e1d05d9adcd1..c6b54199ea26 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -120,6 +120,9 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
 void *stack_start(struct seq_file *m, loff_t *ppos);
 void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
 int stack_print(struct seq_file *m, void *v);
+
+int page_owner_threshold_get(void *data, u64 *val);
+int page_owner_threshold_set(void *data, u64 val);
 #endif
 
 /**
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index d0a4e6ac0bc9..2f1a41f0ae4f 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -502,6 +502,9 @@ static struct stack_record *stack_depot_getstack(depot_stack_handle_t handle)
 }
 
 #ifdef CONFIG_PAGE_OWNER
+
+static unsigned long page_owner_stack_threshold = 0;
+
 void *stack_start(struct seq_file *m, loff_t *ppos)
 {
 	unsigned long *table = m->private;
@@ -557,7 +560,7 @@ int stack_print(struct seq_file *m, void *v)
 
 	if (!stack->size || stack->size < 0 ||
 	    stack->size > PAGE_SIZE || stack->handle.valid != 1 ||
-	    refcount_read(&stack->count) < 1)
+	    refcount_read(&stack->count) < page_owner_stack_threshold)
 		return 0;
 
 	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
@@ -570,6 +573,18 @@ int stack_print(struct seq_file *m, void *v)
 
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
 
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
diff --git a/mm/page_owner.c b/mm/page_owner.c
index b191ad1d41f9..daec789b0b50 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -743,6 +743,9 @@ const struct file_operations page_owner_stack_operations = {
 	.release        = seq_release,
 };
 
+DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
+			&page_owner_threshold_set, "%lu");
+
 static int __init pageowner_init(void)
 {
 	if (!static_branch_unlikely(&page_owner_inited)) {
@@ -755,6 +758,8 @@ static int __init pageowner_init(void)
 
 	debugfs_create_file("page_owner_stacks", S_IRUSR, NULL, NULL,
 			     &page_owner_stack_operations);
+	debugfs_create_file("page_owner_threshold", 0600, NULL, NULL,
+			    &proc_page_owner_threshold);
 
 	return 0;
 }
-- 
2.35.3

