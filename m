Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC17C6C05C5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCSVt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCSVtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:49:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4712BE8;
        Sun, 19 Mar 2023 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/I7PkqiaJ7cvsv6QfoYBZBie1XYAgt8HAKL9Z+MGT0c=; b=XaW6cprtXgJZd5vp0qZa6RgAQ8
        qXGqeTLagGV8UADCUbSDQtkGocZaShmHOpfJuUowrxqMYfPffLDm5h8IUU8ShyDzbHY1c9+00nDWf
        oUHl88nu2u1+Y+gvlw480489v7vVvr5GfKXUQ5FQeKLc+gh87iSvaAa0EsSKk9E2FsivrdU1lK9M7
        wZXk0X5j/JbcXzXUo86TRmfIhRT3SbZm+iACvwEd5uQeLClpE/taaOmj0+N+dpzTKAwnCKBh47MgF
        PfoRm8Uds7+obrvS5oAjTP2nHb/LNASGqMIgH+xKrQ2IfgZRivo0V3yHS2zRRLhRS9lxdqMQeoMd3
        uVxCa8IQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0u8-007WjS-0N;
        Sun, 19 Mar 2023 21:49:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [RFT 2/5] module: extract patient module check into helper
Date:   Sun, 19 Mar 2023 14:49:23 -0700
Message-Id: <20230319214926.1794108-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319214926.1794108-1-mcgrof@kernel.org>
References: <20230319214926.1794108-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 560d00e60744..3644438ff96e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2628,6 +2628,43 @@ static bool finished_loading(const char *name)
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
@@ -2636,41 +2673,14 @@ static bool finished_loading(const char *name)
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
@@ -2678,7 +2688,6 @@ static int add_unformed_module(struct module *mod)
 
 out:
 	mutex_unlock(&module_mutex);
-out_unlocked:
 	return err;
 }
 
-- 
2.39.1

