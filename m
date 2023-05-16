Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E5B7055EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjEPS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjEPSZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:25:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32066E9D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:25:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9BBCC21FC4;
        Tue, 16 May 2023 18:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684261551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnEOKM6Uzt/actmg7zEiIw7A6rReXqMZszIGv86v3Sc=;
        b=hVKBHkEfp0G9WWvqDJIdHuFRXQZMHBevK/kn/dSawYU4vH2GOG6M/k8315ldc28XvmzHt7
        JVVV+17V5fs2C8MT3gspinafb6B59kjzf+39pBAGAxZXwHkDOEZsIMRYRfYjKtd/j48MOe
        Ucek+oi57i2nKNml/BL1ltcex4CV/Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684261551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnEOKM6Uzt/actmg7zEiIw7A6rReXqMZszIGv86v3Sc=;
        b=tm91uIeD7vPtoub1sk+jMCmayoC3m/C8kJoTmIIOUbi0fGm7KoJe0U8e8lMF9s+yzr6liW
        Ai4d6LArAkKNwxBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD65E138F5;
        Tue, 16 May 2023 18:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mLsJL67KY2TeVQAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 16 May 2023 18:25:50 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v5 3/3] mm,page_owner: Filter out stacks by a threshold counter
Date:   Tue, 16 May 2023 20:25:37 +0200
Message-Id: <20230516182537.3139-4-osalvador@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230516182537.3139-1-osalvador@suse.de>
References: <20230516182537.3139-1-osalvador@suse.de>
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
 lib/stackdepot.c |  5 ++++-
 mm/page_owner.c  | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index c4af2e946500..7053221ce1d8 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -488,6 +488,9 @@ static struct stack_record *stack_depot_getstack(depot_stack_handle_t handle)
 }
 
 #ifdef CONFIG_PAGE_OWNER
+
+extern unsigned long page_owner_stack_threshold;
+
 void *stack_start(struct seq_file *m, loff_t *ppos)
 {
 	unsigned long *table = m->private;
@@ -543,7 +546,7 @@ int stack_print(struct seq_file *m, void *v)
 
 	if (!stack->size || stack->size < 0 ||
 	    stack->size > PAGE_SIZE || stack->handle.valid != 1 ||
-	    refcount_read(&stack->count) < 1)
+	    refcount_read(&stack->count) < page_owner_stack_threshold)
 		return 0;
 
 	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2d97f6b34ea6..28c519fc9372 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -743,6 +743,23 @@ const struct file_operations page_owner_stack_operations = {
 	.release        = seq_release,
 };
 
+unsigned long page_owner_stack_threshold;
+
+int page_owner_threshold_get(void *data, u64 *val)
+{
+	*val = page_owner_stack_threshold;
+	return 0;
+}
+
+int page_owner_threshold_set(void *data, u64 val)
+{
+	page_owner_stack_threshold = val;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
+			&page_owner_threshold_set, "%llu");
+
 static int __init pageowner_init(void)
 {
 	if (!static_branch_unlikely(&page_owner_inited)) {
@@ -755,6 +772,10 @@ static int __init pageowner_init(void)
 
 	debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
 			     &page_owner_stack_operations);
+	debugfs_create_file("page_owner_threshold", 0600, NULL, NULL,
+			    &proc_page_owner_threshold);
+
+	page_owner_stack_threshold = 0;
 
 	return 0;
 }
-- 
2.35.3

