Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13766C0580
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCSV15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjCSV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A9D1B2D8;
        Sun, 19 Mar 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rChvCtOI+bS071r53S0Y92CdZ3IVoiOFQgMuZLAmWd0=; b=onCTM8KinqfQaar39+8qVCEvgQ
        spNwSEwjv8/VHUw2s0drqkIaihL1eei454VoYQmspSNyHFjwythWJ22TgTChYv/vDeiwDjnbR2pUh
        N2JVTXSDEJaM8jdTH7aSpMUEC1bMtMsbWW8wBS7RTX5jQiCQGyMPMrbVC1PpayJvCIkEjKkGvgC6H
        UnymMJfQFoP7ftazoIFDdEoszFD6QnbPnXqhsd+8AwEMZM3v4ae772u190bqAq7ZOWfw+4FVBcJo/
        ONI0jpMEFCMT5e5ytmpap1ThBo358axDb87nCvZdve7EaZf8FPjHEokYdaSSJutbCdd5yLT/Wf3m+
        ELdH0pjg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0ZA-007TrL-06;
        Sun, 19 Mar 2023 21:27:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 11/12] module: converge taint work together
Date:   Sun, 19 Mar 2023 14:27:45 -0700
Message-Id: <20230319212746.1783033-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319212746.1783033-1-mcgrof@kernel.org>
References: <20230319212746.1783033-1-mcgrof@kernel.org>
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

Converge on a compromise: so long as we have a module hit our linked
list of modules we taint. That is, the module was about to become live.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 52 ++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2f1988137965..f165d93a4ef9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1955,6 +1955,8 @@ static int setup_load_info(struct load_info *info, int flags)
  * These calls taint the kernel depending certain module circumstances */
 static void module_augment_kernel_taints(struct module *mod, struct load_info *info)
 {
+	int prev_taint = test_taint(TAINT_PROPRIETARY_MODULE);
+
 	if (!get_modinfo(info, "intree")) {
 		if (!test_taint(TAINT_OOT_MODULE))
 			pr_warn("%s: loading out-of-tree module taints kernel.\n",
@@ -1993,6 +1995,28 @@ static void module_augment_kernel_taints(struct module *mod, struct load_info *i
 		add_taint_module(mod, TAINT_UNSIGNED_MODULE, LOCKDEP_STILL_OK);
 	}
 #endif
+
+	/*
+	 * ndiswrapper is under GPL by itself, but loads proprietary modules.
+	 * Don't use add_taint_module(), as it would prevent ndiswrapper from
+	 * using GPL-only symbols it needs.
+	 */
+	if (strcmp(mod->name, "ndiswrapper") == 0)
+		add_taint(TAINT_PROPRIETARY_MODULE, LOCKDEP_NOW_UNRELIABLE);
+
+	/* driverloader was caught wrongly pretending to be under GPL */
+	if (strcmp(mod->name, "driverloader") == 0)
+		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
+				 LOCKDEP_NOW_UNRELIABLE);
+
+	/* lve claims to be GPL but upstream won't provide source */
+	if (strcmp(mod->name, "lve") == 0)
+		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
+				 LOCKDEP_NOW_UNRELIABLE);
+
+	if (!prev_taint && test_taint(TAINT_PROPRIETARY_MODULE))
+		pr_warn("%s: module license taints kernel.\n", mod->name);
+
 }
 
 static int check_modinfo(struct module *mod, struct load_info *info, int flags)
@@ -2198,29 +2222,6 @@ static int move_module(struct module *mod, struct load_info *info)
 
 static int check_module_license_and_versions(struct module *mod)
 {
-	int prev_taint = test_taint(TAINT_PROPRIETARY_MODULE);
-
-	/*
-	 * ndiswrapper is under GPL by itself, but loads proprietary modules.
-	 * Don't use add_taint_module(), as it would prevent ndiswrapper from
-	 * using GPL-only symbols it needs.
-	 */
-	if (strcmp(mod->name, "ndiswrapper") == 0)
-		add_taint(TAINT_PROPRIETARY_MODULE, LOCKDEP_NOW_UNRELIABLE);
-
-	/* driverloader was caught wrongly pretending to be under GPL */
-	if (strcmp(mod->name, "driverloader") == 0)
-		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
-				 LOCKDEP_NOW_UNRELIABLE);
-
-	/* lve claims to be GPL but upstream won't provide source */
-	if (strcmp(mod->name, "lve") == 0)
-		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
-				 LOCKDEP_NOW_UNRELIABLE);
-
-	if (!prev_taint && test_taint(TAINT_PROPRIETARY_MODULE))
-		pr_warn("%s: module license taints kernel.\n", mod->name);
-
 #ifdef CONFIG_MODVERSIONS
 	if ((mod->num_syms && !mod->crcs) ||
 	    (mod->num_gpl_syms && !mod->gpl_crcs)) {
@@ -2772,11 +2773,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/*
 	 * We are tainting your kernel if your module gets into
 	 * the modules linked list somehow.
-	 *
-	 * We have a descrepancy though, see the other taints for
-	 * signature and those in check_module_license_and_versions().
-	 *
-	 * We should compromise and converge.
 	 */
 	module_augment_kernel_taints(mod, info);
 
-- 
2.39.1

