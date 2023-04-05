Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D046D7272
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbjDEC10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbjDEC1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:27:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB22106;
        Tue,  4 Apr 2023 19:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/RMOkeKZ0zVnNikzMHEWN3HnVKsZywedzJcQnE8Kj9M=; b=RLyp7bYttyumVn+murwrwhvi31
        +3qkWhkJ2kI9TmWM3OKE6f5ChpxuTHEngDcjji12T/IMnYSN+IXGy8sKTSPy5hCGF68Lo/Vc520DH
        j3tTHdMa1Y4rknjvne+vNfg+V0dXlw0eW1JTCL/3IQ5EWPinq+y4MUR/txof0vH11hmX9VY48q6vq
        2qoC+9lWZKHk6rz98twbsy9s1ZgpnQXM3J1XmwGiqF2I4mSWMiqNiJuT7K8/JgnUUFPQuhYH6vPog
        V5O6r1hoFTeLN5Ps5ndgGpbEXRrCQLmZuH9R4vuPl64r7iT2D5RWHmSgYHjkpHDcmagyJeI4CTunX
        7k7+GZgg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjsrb-003A0U-1r;
        Wed, 05 Apr 2023 02:27:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: [PATCH v2 3/6] module: extract patient module check into helper
Date:   Tue,  4 Apr 2023 19:26:59 -0700
Message-Id: <20230405022702.753323-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230405022702.753323-1-mcgrof@kernel.org>
References: <20230405022702.753323-1-mcgrof@kernel.org>
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
index 98c261928325..8f382580195b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2638,6 +2638,43 @@ static bool finished_loading(const char *name)
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
@@ -2646,41 +2683,14 @@ static bool finished_loading(const char *name)
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
@@ -2688,7 +2698,6 @@ static int add_unformed_module(struct module *mod)
 
 out:
 	mutex_unlock(&module_mutex);
-out_unlocked:
 	return err;
 }
 
-- 
2.39.2

