Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA426CD1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjC2FcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjC2FcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:32:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97C53C04;
        Tue, 28 Mar 2023 22:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4WklghmhRoXLW11BvhMQXmcUtv91pDbajk9xVWUSoKw=; b=Rc1W4XBsmzSM4fsephNuxA5+Hc
        hN1F7QwRigICSNV8c1+dRaLlmHSl15upfOraFBq7OwpG+Irgc3a7wongSfIqAiZZfSOn9Vsx1o0J4
        LQXqgi70HEADX3OtaFpqZPnDiPLnoNMo1bW9+0Uh/P8BBqyznnMRKUmfZrU49Pb7DA5POilNBpkbE
        OhzYrkOlMapvraFlDXnKzTlsgNgPpRBElg4Ini3Te0CJpdITvxeakGC1tf+zXJvpBOWnRn+z0YUHg
        w9LEXdbu+FKrCjDM1jpzTRuCtqNiEhzDAzbDQB+ZOFhsRGAege8eJEtU1q3Ewz1uUm3tlCAcO86kL
        /ZFLa/6Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phOPW-00GgRm-2Z;
        Wed, 29 Mar 2023 05:31:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, mcgrof@kernel.org
Subject: [PATCH 5/7] modules/kmod: replace implementation with a sempahore
Date:   Tue, 28 Mar 2023 22:31:47 -0700
Message-Id: <20230329053149.3976378-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329053149.3976378-1-mcgrof@kernel.org>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplfy the concurrency delimiter we user for kmod with the semaphore.
I had used the kmod strategy to try to implement a similar concurrency
delimiter for the kernel_read*() calls from the finit_module() path
so to reduce vmalloc() memory pressure. That effort didn't provid yet
conclusive results, but one thing that did became clear is we can use
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
index b717134ebe17..fd7c461387f8 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -40,8 +40,7 @@
  * effect. Systems like these are very unlikely if modules are enabled.
  */
 #define MAX_KMOD_CONCURRENT 50
-static atomic_t kmod_concurrent_max = ATOMIC_INIT(MAX_KMOD_CONCURRENT);
-static DECLARE_WAIT_QUEUE_HEAD(kmod_wq);
+static CONCURRENCY_LIMITER(kmod_concurrent_max, MAX_KMOD_CONCURRENT);
 
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
+	ret = down_timeout(&kmod_concurrent_max, MAX_KMOD_ALL_BUSY_TIMEOUT);
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

