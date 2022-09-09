Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9EE5B32AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiIIJCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiIIJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE758B5D;
        Fri,  9 Sep 2022 02:00:33 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcHTIwkRKn1PHYN4ydzXBtTeH3dujxbaJdbkuMoH+Jk=;
        b=YNOHxDrHimfTR4Ia51HeLUbrwUSw7BWk72gZQytuBZn/tr7PQ/FuCX3MMuTSoJcEb846jr
        WBh4GxfJp3YiQk6Jd58nwN/3NlT6NMsN57IagwCYXqCeMmnZwVyd0/z6HDQIweb/7ipaDy
        DfcQkFjbp9bh9m1wo86sXwrwdLn9eRxChEE9Atw74zQEop1GmADTY5ccclzDgiXiFTOKN4
        lM8TXCX8EnkwYnJhRctohYB2hrPbqI4jYUDl+yWr5P6NHltwLyP2PJbhbfAqg4/96goaJb
        CvC+S+fCYmsi3dK3HsubROsd3CXxfyxvrSp3URrCta7KyFtpF4ctL7UUIv4uLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcHTIwkRKn1PHYN4ydzXBtTeH3dujxbaJdbkuMoH+Jk=;
        b=jRZ+ANO1XaECRIO/HS3ig0kOuYIUQ2nrm7sViULOJkxAhAvh7MRSAJCoGjrMVntHza+RKP
        iVcsNSdweq8ieFDw==
From:   "tip-bot2 for Abel Wu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Avoid double search on same cpu
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Don <joshdon@google.com>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907112000.1854-3-wuyun.abel@bytedance.com>
References: <20220907112000.1854-3-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Message-ID: <166271403055.401.954858010764010883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b9bae70440d21e106fbc098803b5a190df65f2e0
Gitweb:        https://git.kernel.org/tip/b9bae70440d21e106fbc098803b5a190df65f2e0
Author:        Abel Wu <wuyun.abel@bytedance.com>
AuthorDate:    Wed, 07 Sep 2022 19:19:57 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:46 +02:00

sched/fair: Avoid double search on same cpu

The prev cpu is checked at the beginning of SIS, and it's unlikely
to be idle before the second check in select_idle_smt(). So we'd
better focus on its SMT siblings.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Don <joshdon@google.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20220907112000.1854-3-wuyun.abel@bytedance.com
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9657c7d..1ad79aa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6355,6 +6355,8 @@ static int select_idle_smt(struct task_struct *p, int target)
 	int cpu;
 
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
+		if (cpu == target)
+			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
