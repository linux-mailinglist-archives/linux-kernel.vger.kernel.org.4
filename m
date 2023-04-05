Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A094E6D7270
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbjDEC1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbjDEC1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:27:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CB926A4;
        Tue,  4 Apr 2023 19:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Uqmhy/9B7e+b9++KAwscH/EUKyozA37q6pM2lTfdg70=; b=Fdz2wgwVgvdRKm6Kqj5WWQtJhA
        Nr1fqb2X4v2AY1i9kpKnf8cC7l+kYK/BFJTZPMjM/cFEx9jprMFVQ+FeMRZ5jUn2FmJRPgw00k/1C
        QCCZh/fUboJuUiuLlPl5wPHbkMMOTiloaemmfC8O5qmlxX39PnvQNHpa1R1Wvtk5tg28SmlJopNKC
        XhB1USGVZC5MbSb0RT98TXoDFNuFIur5f7FfMS1Laba7pQL7MLi9xYEu3L2qvCbQwr1kDT8pEepmO
        3pmUtldAXo4ND8BROJDvFJqbbWxGNZBaHAXTFIOmv8pmlmwz2y/fPaUnh5u/DbH4qDCa9qTxjoR1E
        RawITC0A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjsrb-003A0L-1g;
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
Subject: [PATCH v2 2/6] module: move finished_loading()
Date:   Tue,  4 Apr 2023 19:26:58 -0700
Message-Id: <20230405022702.753323-3-mcgrof@kernel.org>
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

This has no functional change, just moves a routine earlier
as we'll make use of it next.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d8bb23fa6989..98c261928325 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2454,27 +2454,6 @@ static int post_relocation(struct module *mod, const struct load_info *info)
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
@@ -2638,6 +2617,27 @@ static int may_init_module(void)
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
2.39.2

