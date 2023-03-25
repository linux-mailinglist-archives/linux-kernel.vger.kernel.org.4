Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3015D6C7606
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCXCyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXCyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:54:17 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BB293E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 19:54:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 86E3C1A00888;
        Fri, 24 Mar 2023 10:54:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gD0FfV6nSDOI; Fri, 24 Mar 2023 10:54:15 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 96B141A00815;
        Fri, 24 Mar 2023 10:54:15 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, aurxenon@lunos.org
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] alpha: kernel: module: Adding branch statements after allocating memory for kmalloc
Date:   Sun, 26 Mar 2023 03:25:30 +0800
Message-Id: <20230325192530.3298-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=3.8 required=5.0 tests=DATE_IN_FUTURE_24_48,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After looking at the process_reloc_for_got function and where it is
called, I decided to use a branch statement to increase the robustness
of the pointer g.

If pointer g allocation fails, when 'chains [i]. next' is executed, it
can avoid crashes caused by wild pointers.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/alpha/kernel/module.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/module.c b/arch/alpha/kernel/module.c
index cbefa5a77384..8c97f10347a7 100644
--- a/arch/alpha/kernel/module.c
+++ b/arch/alpha/kernel/module.c
@@ -47,11 +47,15 @@ process_reloc_for_got(Elf64_Rela *rela,
 		}
 
 	g = kmalloc (sizeof (*g), GFP_KERNEL);
-	g->next = chains[r_sym].next;
-	g->r_addend = r_addend;
-	g->got_offset = *poffset;
-	*poffset += 8;
-	chains[r_sym].next = g;
+	if (g) {
+		g->next = chains[r_sym].next;
+		g->r_addend = r_addend;
+		g->got_offset = *poffset;
+		*poffset += 8;
+		chains[r_sym].next = g;
+	}
+	else
+		chains[r_sym].next = NULL;
 
  found_entry:
 	/* Trick: most of the ELF64_R_TYPE field is unused.  There are
-- 
2.18.2

