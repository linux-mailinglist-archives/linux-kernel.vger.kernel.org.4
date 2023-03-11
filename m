Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D862B6B588C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCKFRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCKFRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78806140518;
        Fri, 10 Mar 2023 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0Kfz9ManWhljt3gWTtQeON0UUzOKjwUIYWv5h32VpPw=; b=MnN1/ZLHgS6/DusPEn8slWDfHS
        2uYR5J1cw9XFTdAxvBmp0T5H3IjRvJslb+CP2mKFbo4Jx6ze3QIy9GK6ejC+7gm+vr6Rwl4BA/IF/
        CTjsgTvrAnLnbGCRzKyc55zFZBahioLHJTb/YTef1kDF/JVtOpMFjx4uROYEG8atCZn6TnzhFzWjD
        G1tzhbd1LDFijal17jC4m7Sg67t48rBywMqQ1jREijt4+mGhqmXEvbw7gIYFxzDYKk2gxMspbqVyV
        GNN8wTC/YOp+zEc5RWU2NOAfs2TdO3hT7vBt0jWaBKenj7UII01CdlQ+2ZNZowVyyiEEVP5WuXKbs
        yAAe/NIw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBN4-Bs; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 08/12] module: move finished_loading()
Date:   Fri, 10 Mar 2023 21:17:08 -0800
Message-Id: <20230311051712.4095040-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230311051712.4095040-1-mcgrof@kernel.org>
References: <20230311051712.4095040-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has no functional change, just moves a routine earlier
as we'll make use of it next.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e9c7eb827f0d..c3e5076c0436 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2370,27 +2370,6 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	return module_finalize(info->hdr, info->sechdrs, mod);
 }
 
-/* Is this module of this name done loading?  No locks held. */
-static bool finished_loading(const char *name)
-{
-	struct module *mod;
-	bool ret;
-
-	/*
-	 * The module_mutex should not be a heavily contended lock;
-	 * if we get the occasional sleep here, we'll go an extra iteration
-	 * in the wait_event_interruptible(), which is harmless.
-	 */
-	sched_annotate_sleep();
-	mutex_lock(&module_mutex);
-	mod = find_module_all(name, strlen(name), true);
-	ret = !mod || mod->state == MODULE_STATE_LIVE
-		|| mod->state == MODULE_STATE_GOING;
-	mutex_unlock(&module_mutex);
-
-	return ret;
-}
-
 /* Call module constructors. */
 static void do_mod_ctors(struct module *mod)
 {
@@ -2554,6 +2533,27 @@ static int may_init_module(void)
 	return 0;
 }
 
+/* Is this module of this name done loading?  No locks held. */
+static bool finished_loading(const char *name)
+{
+	struct module *mod;
+	bool ret;
+
+	/*
+	 * The module_mutex should not be a heavily contended lock;
+	 * if we get the occasional sleep here, we'll go an extra iteration
+	 * in the wait_event_interruptible(), which is harmless.
+	 */
+	sched_annotate_sleep();
+	mutex_lock(&module_mutex);
+	mod = find_module_all(name, strlen(name), true);
+	ret = !mod || mod->state == MODULE_STATE_LIVE
+		|| mod->state == MODULE_STATE_GOING;
+	mutex_unlock(&module_mutex);
+
+	return ret;
+}
+
 /*
  * We try to place it in the list now to make sure it's unique before
  * we dedicate too many resources.  In particular, temporary percpu
-- 
2.39.1

