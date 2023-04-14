Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E946E1B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDNFOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjDNFOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:14:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C795B59E7;
        Thu, 13 Apr 2023 22:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=E0LjocQZXclRQB8l3IvaHDmnaUKbJERLnQeMcmNYaaY=; b=DAZ/9FV+DD7XCMmi7Ry/72YGZA
        hStOFcdNHpzcexPjDdDvn4/I3GzlDg3xmazuaJyrD8MDVpXMlJQGDprz6SaDCVp9+OF6Zh+kIOk0L
        DVTpi5+W658yOpIzK2D7xQd6BPHUZ86qlyKhB4VRDhUaVcEi4F2xNwt1tZob++B0ed6NMJxJO8Yeq
        I1D+uJZgTaJeh+2fwBbp2/0RB78r9GhkOL0LJzdu+WBD0Qpb9Pan//1/QzRqloeBRkj4SgEoHqnWN
        q48Bc4ZQoHCCOn+Er3owoW6C7EWltqr7ULK1OlQjTs6+aZi+Sgm1BXgUx1wNDg6K7SP38lypvLfOx
        WHW5aWkg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBks-008KqY-1v;
        Fri, 14 Apr 2023 05:13:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: [PATCH v3 2/2] modules/kmod: replace implementation with a semaphore
Date:   Thu, 13 Apr 2023 22:13:49 -0700
Message-Id: <20230414051349.1986744-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414051349.1986744-1-mcgrof@kernel.org>
References: <20230414051349.1986744-1-mcgrof@kernel.org>
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

Simplify the concurrency delimiter we use for kmod with the semaphore.
I had used the kmod strategy to try to implement a similar concurrency
delimiter for the kernel_read*() calls from the finit_module() path
so to reduce vmalloc() memory pressure. That effort didn't provide yet
conclusive results, but one thing that became clear is we can use
the suggested alternative solution with semaphores which Linus hinted
at instead of using the atomic / wait strategy.

I've stress tested this with kmod test 0008:

time /data/linux-next/tools/testing/selftests/kmod/kmod.sh -t 0008

And I get only a *slight* delay. That delay however is small, a few
seconds for a full test loop run that runs 150 times, for about ~30-40
seconds. The small delay is worth the simplfication IMHO.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/kmod.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index b717134ebe17..5899083436a3 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -40,8 +40,7 @@
  * effect. Systems like these are very unlikely if modules are enabled.
  */
 #define MAX_KMOD_CONCURRENT 50
-static atomic_t kmod_concurrent_max = ATOMIC_INIT(MAX_KMOD_CONCURRENT);
-static DECLARE_WAIT_QUEUE_HEAD(kmod_wq);
+static DEFINE_SEMAPHORE(kmod_concurrent_max, MAX_KMOD_CONCURRENT);
 
 /*
  * This is a restriction on having *all* MAX_KMOD_CONCURRENT threads
@@ -148,29 +147,18 @@ int __request_module(bool wait, const char *fmt, ...)
 	if (ret)
 		return ret;
 
-	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
-		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
-				    atomic_read(&kmod_concurrent_max),
-				    MAX_KMOD_CONCURRENT, module_name);
-		ret = wait_event_killable_timeout(kmod_wq,
-						  atomic_dec_if_positive(&kmod_concurrent_max) >= 0,
-						  MAX_KMOD_ALL_BUSY_TIMEOUT * HZ);
-		if (!ret) {
-			pr_warn_ratelimited("request_module: modprobe %s cannot be processed, kmod busy with %d threads for more than %d seconds now",
-					    module_name, MAX_KMOD_CONCURRENT, MAX_KMOD_ALL_BUSY_TIMEOUT);
-			return -ETIME;
-		} else if (ret == -ERESTARTSYS) {
-			pr_warn_ratelimited("request_module: sigkill sent for modprobe %s, giving up", module_name);
-			return ret;
-		}
+	ret = down_timeout(&kmod_concurrent_max, MAX_KMOD_ALL_BUSY_TIMEOUT * HZ);
+	if (ret) {
+		pr_warn_ratelimited("request_module: modprobe %s cannot be processed, kmod busy with %d threads for more than %d seconds now",
+				    module_name, MAX_KMOD_CONCURRENT, MAX_KMOD_ALL_BUSY_TIMEOUT);
+		return ret;
 	}
 
 	trace_module_request(module_name, wait, _RET_IP_);
 
 	ret = call_modprobe(module_name, wait ? UMH_WAIT_PROC : UMH_WAIT_EXEC);
 
-	atomic_inc(&kmod_concurrent_max);
-	wake_up(&kmod_wq);
+	up(&kmod_concurrent_max);
 
 	return ret;
 }
-- 
2.39.2

