Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C76656A11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiL0Lvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiL0Lv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:51:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD378767D;
        Tue, 27 Dec 2022 03:51:26 -0800 (PST)
Date:   Tue, 27 Dec 2022 11:51:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672141884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCY749kK+ZEZys2HbS2HaPU3xVhCU0w5ngw71ZMD72M=;
        b=JJ4ykFeB8R6RJWc+16XbuqJ2sWnA7NHiUEIXmhxXVqxZTU5Eq6SQ6f1L/IceBEW2cvcHNX
        vTWe00LQYOHjq2CXnHH9YCOZ1NlKiSqXPCYlNGsdkoplBFBsP/nCEI1c3CZhOwzS/4NfS1
        +r/gcZMsi7lXgw4DsncY4g9WCfSvPG7XST2OiJt2h8e8bQkbydUy+wDJVWp7VRxInmt93O
        BSV1wtAgj1TRVGgANcvzMwi2yd3uua9wV5P4xW4PTcc+r9iIhhkJJOtsbzAK8KED/Q5KqJ
        Q9m+tf/VjTjOy6YRFgj8HxXbUa+Xk0851soSepcsJRN1By2i0oeFFvFuY37GqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672141884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCY749kK+ZEZys2HbS2HaPU3xVhCU0w5ngw71ZMD72M=;
        b=rihS21t3ZlD3eEgwN6Bvmj9Tv7KrVUUh7HGwxha4JWYaU4l8zd0q7afjIEpIaSVFVxyuzz
        RFKZ1baGJ2T7feBQ==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd: fix potential integer overflow on
 shift of a int
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Kim Phillips <kim.phillips@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221202135149.1797974-1-colin.i.king@gmail.com>
References: <20221202135149.1797974-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Message-ID: <167214188379.4906.307380073396005165.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     08245672cdc6505550d1a5020603b0a8d4a6dcc7
Gitweb:        https://git.kernel.org/tip/08245672cdc6505550d1a5020603b0a8d4a6dcc7
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Fri, 02 Dec 2022 13:51:49 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:44:00 +01:00

perf/x86/amd: fix potential integer overflow on shift of a int

The left shift of int 32 bit integer constant 1 is evaluated using 32 bit
arithmetic and then passed as a 64 bit function argument. In the case where
i is 32 or more this can lead to an overflow.  Avoid this by shifting
using the BIT_ULL macro instead.

Fixes: 471af006a747 ("perf/x86/amd: Constrain Large Increment per Cycle events")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Kim Phillips <kim.phillips@amd.com>
Link: https://lore.kernel.org/r/20221202135149.1797974-1-colin.i.king@gmail.com
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index d6f3703..4386b10 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1387,7 +1387,7 @@ static int __init amd_core_pmu_init(void)
 		 * numbered counter following it.
 		 */
 		for (i = 0; i < x86_pmu.num_counters - 1; i += 2)
-			even_ctr_mask |= 1 << i;
+			even_ctr_mask |= BIT_ULL(i);
 
 		pair_constraint = (struct event_constraint)
 				    __EVENT_CONSTRAINT(0, even_ctr_mask, 0,
