Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCADE6C0588
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCSV2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjCSV1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E8D1B2DF;
        Sun, 19 Mar 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=obTOkYQMALUPVKZh8hnISC5FrxebItRSovwj5DZ33rg=; b=flXntIUHiZmULb/iZiq/1sUZ64
        Dt0xEwtDqtrtwPkSei2UCYR5CtIQ7qK2cSLmOscjBRNn1eyzMs8WsQTbyMUTt8QoA2w7B5czTFcVg
        CAMtpdAHzOvVcin/O3G8618cLimOyKr9l/iBEFkppYvrrlBGjb+vd9OxN0WBeuRrlaIwmbYoQQ8bc
        P3WHWHhJqvevgP05PnoUe+uJVEmkR5Ri9GO0BwD7xjsApPaOyANa0dWFi4VWsfmQ5c2ZnJnzoBNvA
        F6uvG7eJUrmNWb5ZLQpRetXnc1f2G4C9zV7wL/xyE6WP8z5H5nZ3BzU92tQhYVbpb6mQh24FS59Ia
        SJbvMI3Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007Tqz-2B;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 01/12] module: move get_modinfo() helpers all above
Date:   Sun, 19 Mar 2023 14:27:35 -0700
Message-Id: <20230319212746.1783033-2-mcgrof@kernel.org>
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

Instead of forward declaring routines for get_modinfo() just move
everything up. This makes no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 100 +++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 52 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index b4759f1695b7..1e739f534100 100644
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

