Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794BA6B5891
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCKFSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjCKFRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9914052B;
        Fri, 10 Mar 2023 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8q3uBRgYTBxQf0UmjMKtoxjIBw/L6feX+juCAJ35hgI=; b=Oyl71dYJ9qFUi+q5p2VcJul0tM
        ZBRmlGLKJ9mymmLjGW0bRvUMzDGuBPGDHYlWhQ4hltD+UY91QtkhPBSb27F3nWCgDHgir99wU6EVa
        omTLv4RMHJT64CTjVKUVPwcXuxi/dLXuBK48JXPFoWtVbA93wXRcwc0XEDQg5mD0fK/ZkVfzgdxK3
        Ay1098NxnT9gK5Ts644ycAPgJosGfyWxUe9Ujcg9cDKWvZ/kx3AfyUsXjdYbmJ6wz9bms39qWravQ
        We7GU1A12qC/VgpXNhXViIkK6PIikLijeOmWN4w9/1eLThfvnNBiT7NCI7Nxz8y7SYY4nzjQGJcNr
        P1B/4h5g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBN0-93; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 06/12] module: move early sanity checks into a helper
Date:   Fri, 10 Mar 2023 21:17:06 -0800
Message-Id: <20230311051712.4095040-7-mcgrof@kernel.org>
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

Move early sanity checkers for the module into a helper.
This let's us make it clear when we are working with the
local copy of the module prior to allocation.

This produces no functional changes, it just makes subsequent
changes easier to read.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 16770942f33a..32c92fb69c05 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2682,6 +2682,31 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 	return 0;
 }
 
+/* Module within temporary copy, this doesn't do any allocation  */
+static int early_mod_check(struct load_info *info, int flags)
+{
+	int err;
+
+	/*
+	 * Now that we know we have the correct module name, check
+	 * if it's blacklisted.
+	 */
+	if (blacklisted(info->name)) {
+		pr_err("Module %s is blacklisted\n", info->name);
+		return -EPERM;
+	}
+
+	err = rewrite_section_headers(info, flags);
+	if (err)
+		return err;
+
+	/* Check module struct version now, before we try to use module. */
+	if (!check_modstruct_version(info, info->mod))
+		return ENOEXEC;
+
+	return 0;
+}
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -2725,26 +2750,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err)
 		goto free_copy;
 
-	/*
-	 * Now that we know we have the correct module name, check
-	 * if it's blacklisted.
-	 */
-	if (blacklisted(info->name)) {
-		err = -EPERM;
-		pr_err("Module %s is blacklisted\n", info->name);
-		goto free_copy;
-	}
-
-	err = rewrite_section_headers(info, flags);
+	err = early_mod_check(info, flags);
 	if (err)
 		goto free_copy;
 
-	/* Check module struct version now, before we try to use module. */
-	if (!check_modstruct_version(info, info->mod)) {
-		err = -ENOEXEC;
-		goto free_copy;
-	}
-
 	/* Figure out module layout, and allocate all the memory. */
 	mod = layout_and_allocate(info, flags);
 	if (IS_ERR(mod)) {
-- 
2.39.1

