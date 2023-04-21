Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A636EA80D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjDUKPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjDUKOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:14:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706FCC16B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:14:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 236311FDDE;
        Fri, 21 Apr 2023 10:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682072078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zE4KUQItN/3/UV4PaOZpW67hAUQM7k7JGXQXpSUX7jM=;
        b=LxPC06RfpZaf/PV59ic/kcvwI8MQ/gLjs6JkYCNJ/RNb4xRaG70GAN+PGm+8H+ryznSgpc
        YrF8dckTbYzILZ5H8nPsp0rNBoS1mIsN58UGleQbLSkmKQt45pkJxWA4xeNLFKhm3E6CSB
        bgDU8rZ29b2J1dRT10rROtiAB8ISjTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682072078;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zE4KUQItN/3/UV4PaOZpW67hAUQM7k7JGXQXpSUX7jM=;
        b=TfOtgFn8V7n2eVcwCSKoDkdsIoC3KMz6ZTBfi4H+A0+FegXVYPQtLSIWwe1Nz6zW8lDvXx
        1QolS+TvzBBDJnBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 542F01390E;
        Fri, 21 Apr 2023 10:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GNpvEQ1iQmRNaAAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 21 Apr 2023 10:14:37 +0000
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
Subject: [PATCH v4 2/3] mm, page_owner: Add page_owner_stacks file to print out only stacks and their counte
Date:   Fri, 21 Apr 2023 12:14:14 +0200
Message-Id: <20230421101415.5734-3-osalvador@suse.de>
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

We might be only interested in knowing about stacks <-> count
relationship, so instead of having to fiddle with page_owner
output and screen through pfns, let us add a new file called
'page_owner_stacks' that does just that.
By cating such file, we will get all the stacktraces followed by
its counter, so we can have a more global view.

Signed-off-by: Oscar Salvador <osalvador@suse.de
---
 include/linux/stackdepot.h |  6 ++++
 lib/stackdepot.c           | 73 ++++++++++++++++++++++++++++++++++++++
 mm/page_owner.c            | 28 +++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index b94d33312839..e1d05d9adcd1 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -116,6 +116,12 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
 					     gfp_t gfp_flags,
 					     bool counter);
 
+#ifdef CONFIG_PAGE_OWNER
+void *stack_start(struct seq_file *m, loff_t *ppos);
+void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
+int stack_print(struct seq_file *m, void *v);
+#endif
+
 /**
  * stack_depot_fetch - Fetch a stack trace from stack depot
  *
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index e99f4ef218ef..d0a4e6ac0bc9 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -28,6 +28,8 @@
 #include <linux/types.h>
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
 
 #define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
 
@@ -499,6 +501,77 @@ static struct stack_record *stack_depot_getstack(depot_stack_handle_t handle)
 	return stack;
 }
 
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
+
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
diff --git a/mm/page_owner.c b/mm/page_owner.c
index b6637524e442..b191ad1d41f9 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -718,6 +718,31 @@ static const struct file_operations proc_page_owner_operations = {
 	.llseek		= lseek_page_owner,
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
@@ -728,6 +753,9 @@ static int __init pageowner_init(void)
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

