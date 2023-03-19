Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13B06C0579
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCSV1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCSV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACB21B2F4;
        Sun, 19 Mar 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TgcmLQQdyElaRgOFKPmxQnBZLdzQrkkBcxBFD4PRGHw=; b=bxpbjCtQm1SSlUhuFd6bmJaWap
        nJqLlxA+Igeo4aloU/snQFDDS9j9szPzmaX1hzCc/e+QMsLiXj7y3eOqpR24lRfOTxDp8IrBvx2Jy
        q4Y8qLW4R40q05IHiZoe4fJ6z378s73dN9JlSQt8QZogNm7Qlri8ssBXfAZNmXGDulI6Ez1eCBVUs
        X4CRskRlYQBGZnueynO2TVWktXG/b5FIZW6FfsnkN7TSTS7E51feFJh2s6XFej3LWOb4Pnu+x6Nt8
        cpFKVulK8o7aymcFwkGi9IMf670+BJVE+tQmtz5gwbkzjAK7yM5ZPwBve3Zix4H/E7bnnatGnM0v7
        kVkV6idg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007Tr7-2d;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 05/12] module: move check_modinfo() early to early_mod_check()
Date:   Sun, 19 Mar 2023 14:27:39 -0700
Message-Id: <20230319212746.1783033-6-mcgrof@kernel.org>
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

This moves check_modinfo() to early_mod_check(). This
doesn't make any functional changes either, as check_modinfo()
was the first call on layout_and_allocate(), so we're just
moving it back one routine and at the end.

This let's us keep separate the checkers from the allocator.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 933cef72ae13..95fd705328ac 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2273,10 +2273,6 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	unsigned int ndx;
 	int err;
 
-	err = check_modinfo(info->mod, info, flags);
-	if (err)
-		return ERR_PTR(err);
-
 	/* Allow arches to frob section contents and sizes.  */
 	err = module_frob_arch_sections(info->hdr, info->sechdrs,
 					info->secstrings, info->mod);
@@ -2688,7 +2684,11 @@ static int early_mod_check(struct load_info *info, int flags)
 
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(info, info->mod))
-		return ENOEXEC;
+		return -ENOEXEC;
+
+	err = check_modinfo(info->mod, info, flags);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.39.1

