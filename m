Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1361939F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiKDJeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKDJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:34:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E622BDC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:34:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C2FE51F8B6;
        Fri,  4 Nov 2022 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667554452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06k17Kzb8I50UujN65615D+OfTo3VSRSefXLgWtXH4s=;
        b=REMbrl1azfOylp4pAnJt1FL6ZrrasKRv5lozVitWbG2UHqREoEBIF9GKRdfjQsD57D2svL
        91z2mW8bta4V4blD0Kipp2nS2ajmH+IaDYaGy5Ww/NqmRa8DKIQ3USjuAZ7krdSYoH42MB
        l5/FyUmXRDlT5BZlv2SCY2rZVipQhkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667554452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06k17Kzb8I50UujN65615D+OfTo3VSRSefXLgWtXH4s=;
        b=vLH12hbo4td915aOcm9kAB3t3BajZdE4D3pmeF2CdDKx7OiOv3kzGVpUpIkwW1rjLXYFYt
        19mmpa0C1bJlKpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 535FB1346F;
        Fri,  4 Nov 2022 09:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0LWDD5LcZGP3BQAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 04 Nov 2022 09:34:10 +0000
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
Subject: [PATCH v3 2/3] mm, page_owner: Add page_owner_stacks file to print out only stacks and their counte
Date:   Fri,  4 Nov 2022 10:33:53 +0100
Message-Id: <20221104093354.6218-3-osalvador@suse.de>
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

We might be only interested in knowing about stacks <-> count
relationship, so instead of having to fiddle with page_owner
output and screen through pfns, let us add a new file called
'page_owner_stacks' that does just that.
By cating such file, we will get all the stacktraces followed by
its counter, so we can have a more global view.

Signed-off-by: Oscar Salvador <osalvador@suse.de
---
 include/linux/stackdepot.h |  5 +++
 lib/stackdepot.c           | 73 ++++++++++++++++++++++++++++++++++++++
 mm/page_owner.c            | 29 +++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 4e3a88f135ee..ca048a79bf7c 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -66,6 +66,11 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
 					     unsigned int nr_entries,
 					     gfp_t gfp_flags,
 					     enum stack_depot_action action);
+#ifdef CONFIG_PAGE_OWNER
+void *stack_start(struct seq_file *m, loff_t *ppos);
+void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
+int stack_print(struct seq_file *m, void *v);
+#endif
 
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index a806ef58a385..97e5dce40f4b 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -33,6 +33,8 @@
 #include <linux/types.h>
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
 
 #define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
 
@@ -565,3 +567,74 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
 	return __stack_depot_save(entries, nr_entries, alloc_flags, true, action);
 }
 EXPORT_SYMBOL_GPL(stack_depot_save_action);
+
+#ifdef CONFIG_PAGE_OWNER
+void *stack_start(struct seq_file *m, loff_t *ppos)
+{
+	unsigned long *table = m->private;
+	struct stack_record **stacks, *stack;
+
+	/* First time */
+	if (*ppos == 0)
+		*table = 0;
+
+	if (*ppos == -1UL)
+		return NULL;
+
+	stacks = &stack_table[*table];
+	stack = (struct stack_record *)stacks;
+
+	return stack;
+}
+
+void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
+{
+	unsigned long *table = m->private;
+	unsigned long nr_table = *table;
+	struct stack_record *next = NULL, *stack = v, **stacks;
+	unsigned long stack_table_entries = stack_hash_mask + 1;
+
+	if (!stack) {
+new_table:
+		/* New table */
+		nr_table++;
+		if (nr_table >= stack_table_entries)
+			goto out;
+		stacks = &stack_table[nr_table];
+		stack = (struct stack_record *)stacks;
+		next = stack;
+	} else {
+		next = stack->next;
+	}
+
+	if (!next)
+		goto new_table;
+
+out:
+	*table = nr_table;
+	*ppos = (nr_table >= stack_table_entries) ? -1UL : *ppos + 1;
+	return next;
+}
+
+int stack_print(struct seq_file *m, void *v)
+{
+	char *buf;
+	int ret = 0;
+	struct stack_record *stack =v;
+
+	if (!stack->size || stack->size < 0 ||
+	    stack->size > PAGE_SIZE || stack->handle.valid != 1 ||
+	    refcount_read(&stack->count) < 1)
+		return 0;
+
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	ret += stack_trace_snprint(buf, PAGE_SIZE, stack->entries, stack->size, 0);
+	scnprintf(buf + ret, PAGE_SIZE - ret, "stack count: %d\n\n",
+		  refcount_read(&stack->count));
+	seq_printf(m, buf);
+	seq_puts(m, "\n\n");
+	kfree(buf);
+
+        return 0;
+}
+#endif
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 8730f377fa91..3808c0985060 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -668,6 +668,32 @@ static const struct file_operations proc_page_owner_operations = {
 	.read		= read_page_owner,
 };
 
+static void stack_stop(struct seq_file *m, void *v)
+{
+	return;
+}
+
+static const struct seq_operations page_owner_stack_op = {
+	.start  = stack_start,
+	.next   = stack_next,
+	.stop   = stack_stop,
+	.show   = stack_print
+};
+
+static int page_owner_stack_open(struct inode *inode, struct file *file)
+{
+	return seq_open_private(file, &page_owner_stack_op,
+				sizeof(unsigned long));
+}
+
+
+const struct file_operations page_owner_stack_operations = {
+	.open           = page_owner_stack_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+};
+
 static int __init pageowner_init(void)
 {
 	if (!static_branch_unlikely(&page_owner_inited)) {
@@ -678,6 +704,9 @@ static int __init pageowner_init(void)
 	debugfs_create_file("page_owner", 0400, NULL, NULL,
 			    &proc_page_owner_operations);
 
+	debugfs_create_file("page_owner_stacks", S_IRUSR, NULL, NULL,
+			     &page_owner_stack_operations);
+
 	return 0;
 }
 late_initcall(pageowner_init)
-- 
2.35.3

