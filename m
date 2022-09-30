Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6397B5F079B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiI3JbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiI3JbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23F7C9027;
        Fri, 30 Sep 2022 02:31:04 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4w2bdjCYeWY/jVNN3wkObamE/bPM4WH/dN6XlJz+t6E=;
        b=1H6+C8fbLIJ2U5QskkEIWrl3U36DqPTaX4oKvvnUqjA/FTSXuI6TSoR5cOksFQ35R36zYa
        Lf4H0+UTmOF9IwDh4fmu5ZBRtX7t+vAPGHIUu1rC6vH9LPx5xlsQUsRt3tM/ZA6M3h8wy1
        mnbWVDy4SRLQxC5XjReT9rwmW6ZMcYT9LJzV2zHKRwwvBRyM8zWhL/7nE3do6L2FfKzbmD
        XdmRnILLzka7e0BEkSeIXL29Sn3eb0HCSZ2eiFSJkZvg+AH8QoLjvJMgOYa734oSZp3HOU
        BNAYLzJfNb3gcKfnh2On5Iom56Y6SohgRM4q7WQDFHunYa/Vm0Acf3PTuwxCaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4w2bdjCYeWY/jVNN3wkObamE/bPM4WH/dN6XlJz+t6E=;
        b=XoQemUcmYvPxCY5Z3Qr/EPTq6VSR6CDL1/+09MkQhwdD2C5QYwolQv1uNBF9ix4YCyX4QR
        h5W48n+gYnNgxYAg==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/utils: Fix uninitialized var in get_branch_type()
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sandipan Das <sandipan.das@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928184043.408364-2-eranian@google.com>
References: <20220928184043.408364-2-eranian@google.com>
MIME-Version: 1.0
Message-ID: <166453026135.401.4729222327000204709.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     117ceeb1f4f87331e45a77e71f18303d15ec882e
Gitweb:        https://git.kernel.org/tip/117ceeb1f4f87331e45a77e71f18303d15ec882e
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 28 Sep 2022 11:40:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:56 +02:00

perf/x86/utils: Fix uninitialized var in get_branch_type()

offset is passed as a pointer and on certain call path is not set by the
function. If the caller does not re-initialize offset between calls, value
could be inherited between calls. Prevent this by initializing offset on each
call.

This impacts the code in amd_pmu_lbr_filter() which does:

   for(i=0; ...) {
       ret = get_branch_type_fused(..., &offset);
       if (offset)
          lbr_entries[i].from += offset;
   }

Fixes: df3e9612f758 ("perf/x86: Make branch classifier fusion-aware")
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20220928184043.408364-2-eranian@google.com
---
 arch/x86/events/utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
index 5f5617a..76b1f8b 100644
--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -94,6 +94,10 @@ static int get_branch_type(unsigned long from, unsigned long to, int abort,
 	u8 buf[MAX_INSN_SIZE];
 	int is64 = 0;
 
+	/* make sure we initialize offset */
+	if (offset)
+		*offset = 0;
+
 	to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
 	from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
 
