Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17F974ADCC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjGGJ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGGJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:29:50 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3984D1BE8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688722189;
  x=1720258189;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=vmoHkaxzOc3W5AxZzvRg6PaJA6l2pLh+CK3MdeJgboY=;
  b=IOmnOa31JrhhQHJDSKKnfpYl2YhvnPeJi3WuY8tXrW3aYK+l/hQjURmK
   01IEdRkd3O8AKyXWCYdWbDi40q7YHb1qy8y9AB5EfBp+9X6cX24mZoV/8
   hMk944Mn7erm6uqmNX2QFNLpSNVAFmAyIpXTNyZG/iYuJ5fZrUpkX1qdZ
   YIuto1IsHPSPtGbnKtHgNWv4bMnr5Yr/LvS6Oy06EuFYUZiUnXmJM8DKK
   sc5CI9jcKDODvqxgI4427bdUeAH3Vkmp0PX7pUaKnF7KzVEjhjvbdL1aL
   yJZDpRBNgkToKn0mBcq6x30Y+RZ5pD68CT1fDczlQLd8sY7FCb5Y0hHll
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 7 Jul 2023 11:29:36 +0200
Subject: [PATCH] signal: Print comm and exe name on fatal signals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230707-fatal-comm-v1-1-400363905d5e@axis.com>
X-B4-Tracking: v=1; b=H4sIAP/ap2QC/x2NQQqEMAwAvyI5G6itePAr4iHGVAPaSiuyIP59q
 8cZGOaGLEklQ1/dkOTSrDEUaOoKeKWwCOpcGKyxznTOoKeTNuS479h0jtm2xrKfoQQTZcEpUeD
 1TXyM7auPJF5/32MYn+cP0t/SSnMAAAA=
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Vineet Gupta" <vgupta@kernel.org>, Tejun Heo <tj@kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the print-fatal-signals message more useful by printing the comm
and the exe name for the process which received the fatal signal:

Before:

 potentially unexpected fatal signal 4
 potentially unexpected fatal signal 11

After:

 buggy-program: pool: potentially unexpected fatal signal 4
 some-daemon: gdbus: potentially unexpected fatal signal 11

comm used to be present but was removed in commit 681a90ffe829b8ee25d
("arc, print-fatal-signals: reduce duplicated information") because it's
also included as part of the later stack trace.  Having the comm as part
of the main "unexpected fatal..." print is rather useful though when
analysing logs, and the exe name is also valuable as shown in the
examples above where the comm ends up having some generic name like
"pool".

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 kernel/signal.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 2547fa73bde51..fe1ce5f003784 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -22,8 +22,10 @@
 #include <linux/sched/cputime.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/tty.h>
+#include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/coredump.h>
 #include <linux/security.h>
@@ -1255,7 +1257,17 @@ int send_signal_locked(int sig, struct kernel_siginfo *info,
 static void print_fatal_signal(int signr)
 {
 	struct pt_regs *regs = task_pt_regs(current);
-	pr_info("potentially unexpected fatal signal %d.\n", signr);
+	struct file *exe_file;
+
+	exe_file = get_task_exe_file(current);
+	if (exe_file) {
+		pr_info("%pD: %s: potentially unexpected fatal signal %d.\n",
+			exe_file, current->comm, signr);
+		fput(exe_file);
+	} else {
+		pr_info("%s: potentially unexpected fatal signal %d.\n",
+			current->comm, signr);
+	}
 
 #if defined(__i386__) && !defined(__arch_um__)
 	pr_info("code at %08lx: ", regs->ip);

---
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230630-fatal-comm-163cc2402cfd

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

