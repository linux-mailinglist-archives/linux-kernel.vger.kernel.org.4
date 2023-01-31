Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9CA682F14
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjAaOWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjAaOW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:22:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC414229;
        Tue, 31 Jan 2023 06:22:28 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675174947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeesFkyJpgmdoB5mc6HRlpXKR0i4W5Ofb0R0giGU8H4=;
        b=TqArNT8vhNEcdvFwtnSt6tTZWObxOvdbHnh8kpMhdWAehQb+VbqpJSVn/+9BstRuvOFSAm
        KD8Zuyvv7IKRG1iRTJHdQKcPKkJRcGee8ZgfcI6IbvlvpYicCL1Rd8pvhCBycXRLs2bHgn
        kYpxDHlkNlpxG8HJlQW73aaIJ8iQ/aYH31f8hkMla1GOdrXzXEyuT4k+8c7hqPQ9EoYtEP
        qj12qX7wC27xjSCv9eG3sdb9o4YIsiYRgReCCzxj3Qe16ZKPuEkYKIy9idLwV6xU79KaZj
        FvG1PrKeUiuhjO/H/k3TybSm+8Xz5vKg6dI/RvW3P75DDcWNsUiZRdqDEx5ozA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675174947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeesFkyJpgmdoB5mc6HRlpXKR0i4W5Ofb0R0giGU8H4=;
        b=NlzxGtH2f5GmNpUMkjSj4Z6R7Euj4675Uxp2YKjEIsSYVEs1XioHEsgNFZNiiY+21+GoB0
        HDhGy7oaLVtZZcCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle: Fix poll_idle() noinstr annotation
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202301192148.58ece903-oliver.sang@intel.com>
References: <202301192148.58ece903-oliver.sang@intel.com>
MIME-Version: 1.0
Message-ID: <167517494639.4906.1628335276634090502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4d627628d7584f3d3add1d53342d0f01aa878e04
Gitweb:        https://git.kernel.org/tip/4d627628d7584f3d3add1d53342d0f01aa878e04
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Jan 2023 16:08:38 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 31 Jan 2023 15:01:47 +01:00

cpuidle: Fix poll_idle() noinstr annotation

The instrumentation_begin()/end() annotations in poll_idle() were
complete nonsense. Specifically they caused tracing to happen in the
middle of noinstr code, resulting in RCU splats.

Now that local_clock() is noinstr, mark up the rest and let it rip.

Fixes: 00717eb8c955 ("cpuidle: Annotate poll_idle()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/oe-lkp/202301192148.58ece903-oliver.sang@intel.com
Link: https://lore.kernel.org/r/20230126151323.819534689@infradead.org
---
 drivers/cpuidle/cpuidle.c    | 2 +-
 drivers/cpuidle/poll_state.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 500d172..0b00f21 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -426,7 +426,7 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
  * @dev:   the cpuidle device
  *
  */
-u64 cpuidle_poll_time(struct cpuidle_driver *drv,
+__cpuidle u64 cpuidle_poll_time(struct cpuidle_driver *drv,
 		      struct cpuidle_device *dev)
 {
 	int i;
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index d25ec52..bdcfeae 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -15,7 +15,6 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 {
 	u64 time_start;
 
-	instrumentation_begin();
 	time_start = local_clock();
 
 	dev->poll_time_limit = false;
@@ -42,7 +41,6 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 	raw_local_irq_disable();
 
 	current_clr_polling();
-	instrumentation_end();
 
 	return index;
 }
