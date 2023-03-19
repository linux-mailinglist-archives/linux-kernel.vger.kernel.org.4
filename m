Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD956C05A5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCSVfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCSVfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:35:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0591111648;
        Sun, 19 Mar 2023 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=neDHB/WWg2awqij4jXWtBpsjGCoiwuHAl9xglimyywE=; b=303stu8OCdpqCRilISbltHeAbN
        LpTSgDaE73qLea6KutAQ3oKdfbr8JPNYVogqTx3IOrthWjMROrxivKnnu1cUVPu9BTvOlIKg2gOEv
        q9vnUiOcxcaPRFIEiSg2L7Yzc2cdJ9USoj0KkKNxiLbxAZBrs6z9vtHbR3YNUYRsnHIBZmowoRpfK
        ZonETc28eQOqhVd0MonM8f6CF6ZoZebs6j5WKq9Dxovs7FzAXDEDcDzS4CNaf70R0GsZ4rzobZmfi
        64OCq5KvbAUXf079T14gUbGkW3QfwOeUHyKynwIr4BDOyUOgAc9JhaUPEarUTOJYBk+dLAQypb8tW
        /8JxAy9w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0gp-007Vmt-1W;
        Sun, 19 Mar 2023 21:35:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 2/5] module: add stop-grap sanity check on module memcpy()
Date:   Sun, 19 Mar 2023 14:35:39 -0700
Message-Id: <20230319213542.1790479-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319213542.1790479-1-mcgrof@kernel.org>
References: <20230319213542.1790479-1-mcgrof@kernel.org>
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

The integrity of the struct module we load is important, and although
our ELF validator already checks that the module section must match
struct module, add a stop-gap check before we memcpy() the final minted
module. This also makes those inspecting the code what the goal is.

While at it, clarify the goal behind updating the sh_addr address.
The current comment is pretty misleading.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e1a9dd51c036..fbe62d1625bc 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2213,7 +2213,8 @@ static int move_module(struct module *mod, struct load_info *info)
 {
 	int i;
 	void *ptr;
-	enum mod_mem_type t;
+	enum mod_mem_type t = 0;
+	int ret = -ENOMEM;
 
 	for_each_mod_mem_type(type) {
 		if (!mod->mem[type].size) {
@@ -2249,9 +2250,26 @@ static int move_module(struct module *mod, struct load_info *info)
 
 		dest = mod->mem[type].base + (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
 
-		if (shdr->sh_type != SHT_NOBITS)
+		if (shdr->sh_type != SHT_NOBITS) {
+			/*
+			 * Our ELF checker already validated this, but let's
+			 * be pedantic and make the goal clearer. We actually
+			 * end up copying over all modifications made to the
+			 * userspace copy of the entire struct module.
+			 */
+			if (i == info->index.mod &&
+			   (WARN_ON_ONCE(shdr->sh_size != sizeof(struct module)))) {
+				ret = -ENOEXEC;
+				goto out_enomem;
+			}
 			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
-		/* Update sh_addr to point to copy in image. */
+		}
+		/*
+		 * Update the userspace copy's ELF section address to point to
+		 * our newly allocated memory as a pure convenience so that
+		 * users of info can keep taking advantage and using the newly
+		 * minted official memory area.
+		 */
 		shdr->sh_addr = (unsigned long)dest;
 		pr_debug("\t0x%lx %s\n",
 			 (long)shdr->sh_addr, info->secstrings + shdr->sh_name);
@@ -2261,7 +2279,7 @@ static int move_module(struct module *mod, struct load_info *info)
 out_enomem:
 	for (t--; t >= 0; t--)
 		module_memory_free(mod->mem[t].base, t);
-	return -ENOMEM;
+	return ret;
 }
 
 static int check_export_symbol_versions(struct module *mod)
-- 
2.39.1

