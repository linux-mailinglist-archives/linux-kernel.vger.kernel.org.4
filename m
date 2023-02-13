Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2FB694FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBMStA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBMSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:48:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A0E07E;
        Mon, 13 Feb 2023 10:48:35 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:48:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314113;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9b+Byo62pKbQj/k6bgSFis9WZ9wu30fro/AnJgLkOXw=;
        b=RZ1OMgRrfq6Xxy23hHrVzeAH9ufILm00sTvAObQHPSguQn06LA1DGhnpOWmVTLAmadoJO3
        aWQa4DmktpVcxcZVxGck9MMxS7npRb8sUJMcg/rrSBJ1Woyo66OclF+p442uX6knDu8kdz
        QFQ8na4WbWBkcmxtq2uRpSpWl8lleobLjFVR+UDofW+EjLwE1XINrBiWr8U0etcTe9jpo+
        rzv6QKNlCSK2aosLaYpOibjjx2AA+cZBJBU2gXXMFJAgctbE5D4/bycY32nihsVLMVY8Vm
        hxUiNMh4lKq2Hb7wa526wFXWra8SCGMtPfySCvSwolMcMDZPUUrufoW7aqOWCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314113;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9b+Byo62pKbQj/k6bgSFis9WZ9wu30fro/AnJgLkOXw=;
        b=8NkPDS8GsY8hURi+83+QpKzDSg4mc/hPy51SOikFWc0rAsd5ogflJwR6IL9RBMhqRQztxQ
        Xz8KbVeVaDvMrtBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Improve read-back-delay message
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167631411351.4906.13640037074294664636.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f092eb34b33043152bfb8a4ca01db9a06728261d
Gitweb:        https://git.kernel.org/tip/f092eb34b33043152bfb8a4ca01db9a06728261d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 13 Dec 2022 13:57:28 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 03 Jan 2023 20:43:45 -08:00

clocksource: Improve read-back-delay message

When cs_watchdog_read() is unable to get a qualifying clocksource read
within the limit set by max_cswd_read_retries, it prints a message
and marks the clocksource under test as unstable.  But that message is
unclear to anyone unfamiliar with the code:

clocksource: timekeeping watchdog on CPU13: wd-tsc-wd read-back delay 1000614ns, attempt 3, marking unstable

Therefore, add some context so that the message appears as follows:

clocksource: timekeeping watchdog on CPU13: wd-tsc-wd excessive read-back delay of 1000614ns vs. limit of 125000ns, wd-wd read-back delay only 27ns, attempt 3, marking tsc unstable

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Feng Tang <feng.tang@intel.com>
---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index a3d19f6..b599149 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -260,8 +260,8 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, 
 			goto skip_test;
 	}
 
-	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd read-back delay of %lldns, attempt %d, marking unstable\n",
-		smp_processor_id(), cs->name, wd_delay, nretries);
+	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd excessive read-back delay of %lldns vs. limit of %ldns, wd-wd read-back delay only %lldns, attempt %d, marking %s unstable\n",
+		smp_processor_id(), cs->name, wd_delay, WATCHDOG_MAX_SKEW, wd_seq_delay, nretries, cs->name);
 	return WD_READ_UNSTABLE;
 
 skip_test:
