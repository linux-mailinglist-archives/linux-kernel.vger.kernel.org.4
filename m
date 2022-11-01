Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9061540D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiKAVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiKAVQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:16:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C5A1DA78
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:15:26 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyanoKD2rsfCIpybUoWfKf; Tue, 01 Nov 2022 22:15:24 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:15:24 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 21/30] mm: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:14:09 +0100
Message-Id: <03f9401a6c8b87a1c786a2138d16b048f8d0eb53.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a serie that axes all usages of strtobool().
Each patch can be applied independently from the other ones.

The last patch of the serie removes the definition of strtobool().

You may not be in copy of the cover letter. So, if needed, it is available
at [1].

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 mm/page_table_check.c | 3 ++-
 mm/usercopy.c         | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 433dbce13fe1..93e633c1d587 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2021, Google LLC.
  * Pasha Tatashin <pasha.tatashin@soleen.com>
  */
+#include <linux/kstrtox.h>
 #include <linux/mm.h>
 #include <linux/page_table_check.h>
 
@@ -23,7 +24,7 @@ EXPORT_SYMBOL(page_table_check_disabled);
 
 static int __init early_page_table_check_param(char *buf)
 {
-	return strtobool(buf, &__page_table_check_enabled);
+	return kstrtobool(buf, &__page_table_check_enabled);
 }
 
 early_param("page_table_check", early_page_table_check_param);
diff --git a/mm/usercopy.c b/mm/usercopy.c
index c1ee15a98633..4c3164beacec 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -12,6 +12,7 @@
 
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -258,7 +259,7 @@ static bool enable_checks __initdata = true;
 
 static int __init parse_hardened_usercopy(char *str)
 {
-	if (strtobool(str, &enable_checks))
+	if (kstrtobool(str, &enable_checks))
 		pr_warn("Invalid option string for hardened_usercopy: '%s'\n",
 			str);
 	return 1;
-- 
2.34.1

