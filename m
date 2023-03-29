Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A531F6CD19F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjC2FcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjC2FcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:32:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEBB3C2B;
        Tue, 28 Mar 2023 22:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=C7tEOVKbmd31kJKkSCr8L6PeUYpxvjj7kEhb9lxj2lU=; b=Hq7MpAhblc40y8k1Y4Pqo/enTW
        SslWm7fO+exvvf3HZRxh+bgxhZOS3P1IYnAydKJ5ZTarr8GhRDhxNEnxrSNR8qTIPYRQkgU3YNnx+
        +hKEQpyCrK+p5tnt4YfYVc53F88QARD2q7d7/0iy49zIQ53fg9qMpgODyjglcWGSsnuydP/xVL3Pf
        FSVm+HQx1wkfASdfb4mN3vTxsgy2DNRu5unP+d8hu1QfAr3UlqH/JXn0cVkRXiLoYO4YS6swQky9l
        OqFeYbHv1S5N2op7xH0OmscjuK1xIZLjsk8AFnOHnf/yFLpseFdNdJMXGHqpmE5FhbNXRa3cLgGxL
        JBMH5C3A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phOPW-00GgRW-23;
        Wed, 29 Mar 2023 05:31:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, mcgrof@kernel.org
Subject: [PATCH 2/7] module: extract patient module check into helper
Date:   Tue, 28 Mar 2023 22:31:44 -0700
Message-Id: <20230329053149.3976378-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329053149.3976378-1-mcgrof@kernel.org>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patient module check inside add_unformed_module() is large
enough as we need it. It is a bit hard to read too, so just
move it to a helper and do the inverse checks first to help
shift the code and make it easier to read. The new helper then
is module_patient_check_exists().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 71 +++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index af58e63e5daf..77c2e7a60f2e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2626,6 +2626,43 @@ static bool finished_loading(const char *name)
 	return ret;
 }
 
+/* Must be called with module_mutex held */
+static int module_patient_check_exists(const char *name)
+{
+	struct module *old;
+	int err = 0;
+
+	old = find_module_all(name, strlen(name), true);
+	if (old == NULL)
+		return 0;
+
+	if (old->state == MODULE_STATE_COMING
+	    || old->state == MODULE_STATE_UNFORMED) {
+		/* Wait in case it fails to load. */
+		mutex_unlock(&module_mutex);
+		err = wait_event_interruptible(module_wq,
+				       finished_loading(name));
+		if (err)
+			return err;
+
+		/* The module might have gone in the meantime. */
+		mutex_lock(&module_mutex);
+		old = find_module_all(name, strlen(name), true);
+	}
+
+	/*
+	 * We are here only when the same module was being loaded. Do
+	 * not try to load it again right now. It prevents long delays
+	 * caused by serialized module load failures. It might happen
+	 * when more devices of the same type trigger load of
+	 * a particular module.
+	 */
+	if (old && old->state == MODULE_STATE_LIVE)
+		return -EEXIST;
+	else
+		return -EBUSY;
+}
+
 /*
  * We try to place it in the list now to make sure it's unique before
  * we dedicate too many resources.  In particular, temporary percpu
@@ -2634,41 +2671,14 @@ static bool finished_loading(const char *name)
 static int add_unformed_module(struct module *mod)
 {
 	int err;
-	struct module *old;
 
 	mod->state = MODULE_STATE_UNFORMED;
 
 	mutex_lock(&module_mutex);
-	old = find_module_all(mod->name, strlen(mod->name), true);
-	if (old != NULL) {
-		if (old->state == MODULE_STATE_COMING
-		    || old->state == MODULE_STATE_UNFORMED) {
-			/* Wait in case it fails to load. */
-			mutex_unlock(&module_mutex);
-			err = wait_event_interruptible(module_wq,
-					       finished_loading(mod->name));
-			if (err)
-				goto out_unlocked;
-
-			/* The module might have gone in the meantime. */
-			mutex_lock(&module_mutex);
-			old = find_module_all(mod->name, strlen(mod->name),
-					      true);
-		}
-
-		/*
-		 * We are here only when the same module was being loaded. Do
-		 * not try to load it again right now. It prevents long delays
-		 * caused by serialized module load failures. It might happen
-		 * when more devices of the same type trigger load of
-		 * a particular module.
-		 */
-		if (old && old->state == MODULE_STATE_LIVE)
-			err = -EEXIST;
-		else
-			err = -EBUSY;
+	err = module_patient_check_exists(mod->name);
+	if (err)
 		goto out;
-	}
+
 	mod_update_bounds(mod);
 	list_add_rcu(&mod->list, &modules);
 	mod_tree_insert(mod);
@@ -2676,7 +2686,6 @@ static int add_unformed_module(struct module *mod)
 
 out:
 	mutex_unlock(&module_mutex);
-out_unlocked:
 	return err;
 }
 
-- 
2.39.2

