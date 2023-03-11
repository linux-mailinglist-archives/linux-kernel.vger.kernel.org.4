Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731876B588B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCKFRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCKFRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F8140520;
        Fri, 10 Mar 2023 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fgKIaEVFe3ZJ+AptWb/si2HEmzuXwtpAjqPKXFiEzog=; b=mc+03uC4v46xoHgDKwIy/jRxpa
        VXDyh/U/I4ik/2yepzo5eX4By8jC4lxxcVTLAhquivmKGobv0wOcjEMdwLCJM4WEpcWrqeOY7O13j
        h27DatHPMaYlZfMXrvuJSzcxKYo7uZlT3ax0I9pEJHkPwhWfaqgzKbPmVyaaquBxpVeI0b3iDMC0O
        5tGKhUeCbVGJo+jnK8WdTpCECyDy4PgEd5SSLzlDyORHXX9wcO4QJt9APOwDWcOcJojq8AAHB4Hu8
        b2he0Fi7jHmXy1uFF6m2sXhSDkGD7oDLrLFewiwKHerM3g7bWGdM1vOx8ZklpVcfnbHt+k+uCnZuj
        K3/injQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBMo-1Z; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 01/12] module: use goto errors on check_modinfo() and layout_and_allocate()
Date:   Fri, 10 Mar 2023 21:17:01 -0800
Message-Id: <20230311051712.4095040-2-mcgrof@kernel.org>
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

Although both routines don't have much complex errors paths we
will expand on these routine in the future, setting up error lables
now for both will make subsequent changes easier to review. This
changes has no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index b4759f1695b7..5f1473eb34e0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1998,7 +1998,7 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 
 	err = check_modinfo_livepatch(mod, info);
 	if (err)
-		return err;
+		goto err_out;
 
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(info, "license"));
@@ -2011,6 +2011,8 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 	}
 
 	return 0;
+err_out:
+	return err;
 }
 
 static int find_module_sections(struct module *mod, struct load_info *info)
@@ -2288,12 +2290,12 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	err = module_frob_arch_sections(info->hdr, info->sechdrs,
 					info->secstrings, info->mod);
 	if (err < 0)
-		return ERR_PTR(err);
+		goto err_out;
 
 	err = module_enforce_rwx_sections(info->hdr, info->sechdrs,
 					  info->secstrings, info->mod);
 	if (err < 0)
-		return ERR_PTR(err);
+		goto err_out;
 
 	/* We will do a special allocation for per-cpu sections later. */
 	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -2327,12 +2329,14 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	/* Allocate and move to the final place */
 	err = move_module(info->mod, info);
 	if (err)
-		return ERR_PTR(err);
+		goto err_out;
 
 	/* Module has been copied to its final place now: return it. */
 	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
 	kmemleak_load_module(mod, info);
 	return mod;
+err_out:
+	return ERR_PTR(err);
 }
 
 /* mod is no longer valid after this! */
-- 
2.39.1

