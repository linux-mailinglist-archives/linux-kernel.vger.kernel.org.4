Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF0615417
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKAVRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiKAVQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:16:12 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A101EEC8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:15:34 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyanoKD2rsfCIpybcoWfMO; Tue, 01 Nov 2022 22:15:33 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:15:33 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 28/30] x86/xen: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:14:16 +0100
Message-Id: <e91af3c8708af38b1c57e0a2d7eb9765dda0e963.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
 arch/x86/xen/enlighten_pv.c | 3 ++-
 arch/x86/xen/setup.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 05170fc19083..9e1ac6a281e4 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -23,6 +23,7 @@
 #include <linux/start_kernel.h>
 #include <linux/sched.h>
 #include <linux/kprobes.h>
+#include <linux/kstrtox.h>
 #include <linux/memblock.h>
 #include <linux/export.h>
 #include <linux/mm.h>
@@ -113,7 +114,7 @@ static __read_mostly bool xen_msr_safe = IS_ENABLED(CONFIG_XEN_PV_MSR_SAFE);
 static int __init parse_xen_msr_safe(char *str)
 {
 	if (str)
-		return strtobool(str, &xen_msr_safe);
+		return kstrtobool(str, &xen_msr_safe);
 	return -EINVAL;
 }
 early_param("xen_msr_safe", parse_xen_msr_safe);
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index cfa99e8f054b..0abccdab5bc6 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -7,6 +7,7 @@
 
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/kstrtox.h>
 #include <linux/mm.h>
 #include <linux/pm.h>
 #include <linux/memblock.h>
@@ -85,7 +86,7 @@ static void __init xen_parse_512gb(void)
 	arg = strstr(xen_start_info->cmd_line, "xen_512gb_limit=");
 	if (!arg)
 		val = true;
-	else if (strtobool(arg + strlen("xen_512gb_limit="), &val))
+	else if (kstrtobool(arg + strlen("xen_512gb_limit="), &val))
 		return;
 
 	xen_512gb_limit = val;
-- 
2.34.1

