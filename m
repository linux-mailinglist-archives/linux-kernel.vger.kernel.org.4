Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A5F6FDF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbjEJNtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbjEJNtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81F56593;
        Wed, 10 May 2023 06:49:18 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XViNzfd5xAkKF5mLkhXibI0XnA+ycP8R25hf457i/k=;
        b=IOFCWpVBj9DdfdpK7PspMJ4tOQC9XzWGQkQgX2GZND2dHStl/cayt6hYMB3cKnyvVZnW15
        zIjNJF1jkFaNiLfmtF2Y+lraFarUNWjDJjAn2qDDG8OngH59666UuE3OkOngy94WejNeWo
        QeFFxXQPNUANu8v9hpBVrcWbrZU9X/JJKWvDqWIiMunf8OA8It11vyTXxeK9t75adxP8cf
        2X0byLkIXwO4YDwCM8cf0ATJjmrvv274FYUShOLlp5N0/AKj+V9shq3AlT7M4T+cgb5MXx
        XS6X6T+yLs+LlQPDJabvFTNfFvNR/KLExJEvdqcxondWAiF95UZWlR9S4dRhWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XViNzfd5xAkKF5mLkhXibI0XnA+ycP8R25hf457i/k=;
        b=86Y8xB43lU4Vq/MfF1QhX1m4cL4zdprsfKA6mPs1xAO9JEpEIFaL/uesLJGdBBV4RURVMD
        4bE6IfG32tGV6DDA==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/sched: Remove SD_ASYM_PACKING from the SMT domain flags
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-11-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-11-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655119.404.3317182786366775106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     995998ebdebd09b85c28cc46068d8a0744113837
Gitweb:        https://git.kernel.org/tip/995998ebdebd09b85c28cc46068d8a0744113837
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:46 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:37 +02:00

x86/sched: Remove SD_ASYM_PACKING from the SMT domain flags

There is no difference between any of the SMT siblings of a physical core.
Do not do asym_packing load balancing at this level.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406203148.19182-11-ricardo.neri-calderon@linux.intel.com
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce..a335abd 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -552,7 +552,7 @@ static int x86_core_flags(void)
 #ifdef CONFIG_SCHED_SMT
 static int x86_smt_flags(void)
 {
-	return cpu_smt_flags() | x86_sched_itmt_flags();
+	return cpu_smt_flags();
 }
 #endif
 #ifdef CONFIG_SCHED_CLUSTER
