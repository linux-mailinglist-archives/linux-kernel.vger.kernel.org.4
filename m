Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6026B588D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCKFRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCKFRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A2E140526;
        Fri, 10 Mar 2023 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Qx3kvl1TA4Gbwo8RtYmlV05hbgAF2Z4QTvWxKXzU3KI=; b=Lx0vzaE2gzcfyPXU87+uHWfN+Y
        90v1y+KP0yZoxipqzRWBcWtgoRuSG83wO1BXpUk1NK/kBtsO0laf1BZabvPqgtVOf3RMAPWe2R+3S
        ihr/nhf+EDH14m4AnAY8ODpFxgmxMi3hl8dYTSTGXXZphiVH3PrFzA3Dc62GK1WCF/goMx6N8cjOX
        9qs2v8ReG3OG7mma51jBbkP99UJ+wGadbYmhhv0vkCmpaQ26vjH4w8/IAUi7eR58yADoCIgCwHfrW
        +66lnZSBe+u3N7fn5MY1wjGUbsuknXjgRa5fpJ/ytxd3lPEePTHhuHwX7xW9T9SDVxkEVFbyV879u
        1EeSfW5g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBMq-37; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 02/12] module: move get_modinfo() helpers all above
Date:   Fri, 10 Mar 2023 21:17:02 -0800
Message-Id: <20230311051712.4095040-3-mcgrof@kernel.org>
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

Instead of forward declaring routines for get_modinfo() just move
everything up. This makes no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 100 +++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 52 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5f1473eb34e0..6d6e6a6184b5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1016,9 +1016,55 @@ int try_to_force_load(struct module *mod, const char *reason)
 #endif
 }
 
-static char *get_modinfo(const struct load_info *info, const char *tag);
+/* Parse tag=value strings from .modinfo section */
+static char *next_string(char *string, unsigned long *secsize)
+{
+	/* Skip non-zero chars */
+	while (string[0]) {
+		string++;
+		if ((*secsize)-- <= 1)
+			return NULL;
+	}
+
+	/* Skip any zero padding. */
+	while (!string[0]) {
+		string++;
+		if ((*secsize)-- <= 1)
+			return NULL;
+	}
+	return string;
+}
+
 static char *get_next_modinfo(const struct load_info *info, const char *tag,
-			      char *prev);
+			      char *prev)
+{
+	char *p;
+	unsigned int taglen = strlen(tag);
+	Elf_Shdr *infosec = &info->sechdrs[info->index.info];
+	unsigned long size = infosec->sh_size;
+
+	/*
+	 * get_modinfo() calls made before rewrite_section_headers()
+	 * must use sh_offset, as sh_addr isn't set!
+	 */
+	char *modinfo = (char *)info->hdr + infosec->sh_offset;
+
+	if (prev) {
+		size -= prev - modinfo;
+		modinfo = next_string(prev, &size);
+	}
+
+	for (p = modinfo; p; p = next_string(p, &size)) {
+		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
+			return p + taglen + 1;
+	}
+	return NULL;
+}
+
+static char *get_modinfo(const struct load_info *info, const char *tag)
+{
+	return get_next_modinfo(info, tag, NULL);
+}
 
 static int verify_namespace_is_imported(const struct load_info *info,
 					const struct kernel_symbol *sym,
@@ -1544,56 +1590,6 @@ static void set_license(struct module *mod, const char *license)
 	}
 }
 
-/* Parse tag=value strings from .modinfo section */
-static char *next_string(char *string, unsigned long *secsize)
-{
-	/* Skip non-zero chars */
-	while (string[0]) {
-		string++;
-		if ((*secsize)-- <= 1)
-			return NULL;
-	}
-
-	/* Skip any zero padding. */
-	while (!string[0]) {
-		string++;
-		if ((*secsize)-- <= 1)
-			return NULL;
-	}
-	return string;
-}
-
-static char *get_next_modinfo(const struct load_info *info, const char *tag,
-			      char *prev)
-{
-	char *p;
-	unsigned int taglen = strlen(tag);
-	Elf_Shdr *infosec = &info->sechdrs[info->index.info];
-	unsigned long size = infosec->sh_size;
-
-	/*
-	 * get_modinfo() calls made before rewrite_section_headers()
-	 * must use sh_offset, as sh_addr isn't set!
-	 */
-	char *modinfo = (char *)info->hdr + infosec->sh_offset;
-
-	if (prev) {
-		size -= prev - modinfo;
-		modinfo = next_string(prev, &size);
-	}
-
-	for (p = modinfo; p; p = next_string(p, &size)) {
-		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
-			return p + taglen + 1;
-	}
-	return NULL;
-}
-
-static char *get_modinfo(const struct load_info *info, const char *tag)
-{
-	return get_next_modinfo(info, tag, NULL);
-}
-
 static void setup_modinfo(struct module *mod, struct load_info *info)
 {
 	struct module_attribute *attr;
-- 
2.39.1

