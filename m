Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0775FFF2F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJPMbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJPMbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:31:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B010331DC2;
        Sun, 16 Oct 2022 05:31:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 65BAA33A43;
        Sun, 16 Oct 2022 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665923476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fb+yTSMK3jSZs82B8z4U15J58ZeLRAv+ql0OMM3ibe0=;
        b=dWNXiW4xhEUBvjoCNF1MGYqLIjJ8eRdtHvra0XKja8by17o1yRyDmBjpVeEJ2nGOKPXXca
        5+z/V6wdRRnju3MucKRNIHmf+PNHch7qZsJxTjVdDSm1P7kcFnkNEq/4U4ZyqQH6aPiSpD
        k57gbxuBI50O89ItIbXQujOIucMyOuM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40A6113A36;
        Sun, 16 Oct 2022 12:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6CvJDpT5S2MyMAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Sun, 16 Oct 2022 12:31:16 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     mcgrof@kernel.org
Cc:     pmladek@suse.com, david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3 1/4] module: Correct wake up of module_wq
Date:   Sun, 16 Oct 2022 14:30:28 +0200
Message-Id: <20221016123031.3963-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221016123031.3963-1-petr.pavlu@suse.com>
References: <20221016123031.3963-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module_wq wait queue has only non-exclusive waiters and all waits
are interruptible, therefore for consistency use wake_up_interruptible()
to wake its waiters.

Suggested-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d02d39c7174e..a12e177ea81f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -764,7 +764,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
-	wake_up_all(&module_wq);
+	wake_up_interruptible(&module_wq);
 	return 0;
 out:
 	mutex_unlock(&module_mutex);
@@ -2522,7 +2522,7 @@ static noinline int do_init_module(struct module *mod)
 		schedule_work(&init_free_wq);
 
 	mutex_unlock(&module_mutex);
-	wake_up_all(&module_wq);
+	wake_up_interruptible(&module_wq);
 
 	return 0;
 
@@ -2538,7 +2538,7 @@ static noinline int do_init_module(struct module *mod)
 	klp_module_going(mod);
 	ftrace_release_mod(mod);
 	free_module(mod);
-	wake_up_all(&module_wq);
+	wake_up_interruptible(&module_wq);
 	return ret;
 }
 
@@ -2879,7 +2879,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Unlink carefully: kallsyms could be walking list. */
 	list_del_rcu(&mod->list);
 	mod_tree_remove(mod);
-	wake_up_all(&module_wq);
+	wake_up_interruptible(&module_wq);
 	/* Wait for RCU-sched synchronizing before releasing mod->list. */
 	synchronize_rcu();
 	mutex_unlock(&module_mutex);
-- 
2.35.3

