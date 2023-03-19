Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A86C0586
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCSV2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCSV1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB551B2F2;
        Sun, 19 Mar 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ttolxm8RztPeexRc54yX/SDdKM9dpm837Hu569jN01E=; b=BUoFWO0O2aXq46a8vowGSTOmUE
        On2jYQOWQx4biFqN81qiBnYsK4soBT2ivCJNNqXTi+kQjQInI8vOcMtRM4pMnANUiD/35hQ5cQbHy
        hMohMhBn2VfdfgUbXsNftjPJVQitF9K1emCMS/ZGrS/T2wek+DeKrXN68U8dYFIBQn9c5MxBxakhG
        7cG6n85FJysxMlYlQy8imW1jWiN6HGL8trNCyXtx8wso2E7YJhJnf+0p2ssAXuqKo6kDz6i+ziyiG
        Dklap8cLtZiNS8YHUakLbWqNlV33CsK0m8agKvhq512jCc97Y2/eEn+GQf9MogCm8XGSryvGyRYKW
        qsXfIbPQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007Tr3-2P;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 03/12] module: add a for_each_modinfo_entry()
Date:   Sun, 19 Mar 2023 14:27:37 -0700
Message-Id: <20230319212746.1783033-4-mcgrof@kernel.org>
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

Add a for_each_modinfo_entry() to make it easier to read and use.
This produces no functional changes but makes this code easiert
to read as we are used to with loops in the kernel and trims more
lines of code.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/internal.h | 3 +++
 kernel/module/main.c     | 5 +----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 1fa2328636ec..6ae29bb8836f 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -98,6 +98,9 @@ size_t module_flags_taint(unsigned long taints, char *buf);
 
 char *module_next_tag_pair(char *string, unsigned long *secsize);
 
+#define for_each_modinfo_entry(entry, info, name) \
+	for (entry = get_modinfo(info, name); entry; entry = get_next_modinfo(info, name, entry))
+
 static inline void module_assert_mutex_or_preempt(void)
 {
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/module/main.c b/kernel/module/main.c
index ebb5e6b92a48..427284ab31f1 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1075,12 +1075,9 @@ static int verify_namespace_is_imported(const struct load_info *info,
 
 	namespace = kernel_symbol_namespace(sym);
 	if (namespace && namespace[0]) {
-		imported_namespace = get_modinfo(info, "import_ns");
-		while (imported_namespace) {
+		for_each_modinfo_entry(imported_namespace, info, "import_ns") {
 			if (strcmp(namespace, imported_namespace) == 0)
 				return 0;
-			imported_namespace = get_next_modinfo(
-				info, "import_ns", imported_namespace);
 		}
 #ifdef CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 		pr_warn(
-- 
2.39.1

