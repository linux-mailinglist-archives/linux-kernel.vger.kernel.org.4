Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6800B6A32ED
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjBZQxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjBZQxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:53:45 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91761B772
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:53:44 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 3120C831C8;
        Sun, 26 Feb 2023 16:53:41 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677430424;
        bh=oMEGAK6ZcuquAYnSKZpKSdMu7CUNw9o2Zlj5wN7zR4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CiLRx/f0KGjMkTA+yVX3K4FSI1KGHN0UJ6igB0kzDWV9298ntqmq/XS4zGs0LSJcQ
         WVx+0+z/uAxIrLRvkDZfPHYFMdogerGEyJf4KcWFxoyTmqiA1tb/LwVItXpJW+Yl6E
         6aU4ufRrFLBQLcP95thn1if3wb5m2gkPmpdsAqiD9NwJp+Cnfapq2UOvKQncyjum+Q
         8XD5Yo1xR0PXS3XwekP+qoh9gOrwDd/xTPs0tMpHzfX5M1a9WMPT4ND4V7vI+AUjWD
         e+vZGjk9qHHxkH9+/OIP1Ku3KY1ipAwftKNCBRqM+6+sKs9u8N5dQpZvitNDNj0XF3
         AEh80AtFD4zNw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v1 1/2] workqueue: Simplify a pr_warn() call in wq_select_unbound_cpu()
Date:   Sun, 26 Feb 2023 23:53:20 +0700
Message-Id: <20230226165321.24825-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226165321.24825-1-ammarfaizi2@gnuweeb.org>
References: <20230226165321.24825-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_warn_once() to achieve the same thing. It's simpler.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 kernel/workqueue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed4854a4..3f1fabea000f4408 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1392,15 +1392,13 @@ static bool is_chained_work(struct workqueue_struct *wq)
  */
 static int wq_select_unbound_cpu(int cpu)
 {
-	static bool printed_dbg_warning;
 	int new_cpu;
 
 	if (likely(!wq_debug_force_rr_cpu)) {
 		if (cpumask_test_cpu(cpu, wq_unbound_cpumask))
 			return cpu;
-	} else if (!printed_dbg_warning) {
-		pr_warn("workqueue: round-robin CPU selection forced, expect performance impact\n");
-		printed_dbg_warning = true;
+	} else {
+		pr_warn_once("workqueue: round-robin CPU selection forced, expect performance impact\n");
 	}
 
 	if (cpumask_empty(wq_unbound_cpumask))
-- 
Ammar Faizi

