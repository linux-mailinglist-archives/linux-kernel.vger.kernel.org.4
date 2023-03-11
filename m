Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D75E6B588F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCKFSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCKFRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A014052F;
        Fri, 10 Mar 2023 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tYsj98dWQ7w+RJ5JNa62BDiT7Z3rKk0MlMBfrIGdxVY=; b=KjPfOGTgevjwLnMl9fuTdtaJLb
        ftgYM18+ET3KUP9eosnUMPh+6AtxB8M6zo0mtQYUOT88TQbms+gSscSKreWOtqz2j6++2VRhlDlKM
        L6dterrWwyq0g4OmKpXS/ERbg2iXBjEBZLDUGyK2BJrFA15ME0/f/WiHaVpT9NxjlPL35lZZUjcOB
        WfLIA7mrOgtIWsep+L8b7MfiJqIJJU681vZi3vub1yKmvMfkKkMjTpv0+khSTuOGD7gNxiQTD1OCd
        pY2jxjqUY5rg3EIarrHaWUnvA0USxDTE19qFJeMl9/ksZ23Sa/pgf6H5+HpP1xyMR3biD5rLupr9s
        c2sKkmHg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBMu-5p; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 04/12] module: add a for_each_modinfo_entry()
Date:   Fri, 10 Mar 2023 21:17:04 -0800
Message-Id: <20230311051712.4095040-5-mcgrof@kernel.org>
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
index 50364707c0cd..3f7c8634cf06 100644
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

