Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD3682F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjAaOWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjAaOWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:22:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C24227BE;
        Tue, 31 Jan 2023 06:22:29 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675174947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaxyfrOS31RTeZNddxXD01LyBWyUAGVO4JzeFU3O3jU=;
        b=ufp8S664C4Qend5fynUF/wX1/Y7E+vTNpOiNo8yV2vaXCoQU7Y+4sQRrxSNA40EFfnWbdx
        8we5bIfawc5sXVGqynzDMXLCSrZXrhFOaRGW6zj2rW0PNkpdXUxXfRA6YcNeXCk1qeqncr
        byjPWLwHOfukgeMlEM3K6NKsYba7XifSYSSNY6DGufbahTJgiELHmMNXlIOjQgKAwyYkmc
        wSMg3qxqwHkmoRefCL54bPoWSJMfInhPGgn47FaEsQ6q1cUfHmfDBjZLKUQYwL1mnL3vJ7
        UkrZDvb5vA51BpyHdCm7WrwH29LcOHNNiw+OPQDrLf+GMA8PL0JiRR13V3StUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675174947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaxyfrOS31RTeZNddxXD01LyBWyUAGVO4JzeFU3O3jU=;
        b=uZeDGjuWzftSwD7cRJAUR6vY5qkBBNgg9orBAr54LWKgH/SI8Bsqp/WuZwkfho8ZllPMH/
        ZE6hgjMuXTB5h7BA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/pvclock: Improve atomic update of last_value in
 pvclock_clocksource_read()
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118202330.3740-1-ubizjak@gmail.com>
References: <20230118202330.3740-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <167517494755.4906.5493184196521535283.tip-bot2@tip-bot2>
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

Commit-ID:     5c9da9fe826d4a0d84bb322cca27cc8ad8d23b24
Gitweb:        https://git.kernel.org/tip/5c9da9fe826d4a0d84bb322cca27cc8ad8d23b24
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 26 Jan 2023 16:08:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 31 Jan 2023 15:01:46 +01:00

x86/pvclock: Improve atomic update of last_value in pvclock_clocksource_read()

Improve atomic update of last_value in pvclock_clocksource_read:

- Atomic update can be skipped if the "last_value" is already
  equal to "ret".

- The detection of atomic update failure is not correct. The value,
  returned by atomic64_cmpxchg should be compared to the old value
  from the location to be updated. If these two are the same, then
  atomic update succeeded and "last_value" location is updated to
  "ret" in an atomic way. Otherwise, the atomic update failed and
  it should be retried with the value from "last_value" - exactly
  what atomic64_try_cmpxchg does in a correct and more optimal way.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20230118202330.3740-1-ubizjak@gmail.com
Link: https://lore.kernel.org/r/20230126151323.643408110@infradead.org
---
 arch/x86/kernel/pvclock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index eda37df..5a2a517 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -102,10 +102,9 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 	 */
 	last = atomic64_read(&last_value);
 	do {
-		if (ret < last)
+		if (ret <= last)
 			return last;
-		last = atomic64_cmpxchg(&last_value, last, ret);
-	} while (unlikely(last != ret));
+	} while (!atomic64_try_cmpxchg(&last_value, &last, ret));
 
 	return ret;
 }
