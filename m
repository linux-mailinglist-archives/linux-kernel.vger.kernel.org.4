Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC374CFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjGJIOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjGJINq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:13:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C038E1;
        Mon, 10 Jul 2023 01:13:45 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976823;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjzAB0fzsGtpLPet2sHs0gH5HogT3zoQ1G1ZId/Omvc=;
        b=QqvMu0qV9yQz/8lmSuyoMvW8CniVz7MqDKJHugsPJRcgH5qJlJXLhUIMyr635+1ttf5H3v
        BehgWj+fNFsXqg/R6SPaQE7bwapE+afek/MADOTgTx1JUon8ZUYnhStWH7tP+VlCbDo5T6
        rslFN5+eRUr38a1Ha7LaMX2s0ZUy8lpR+sJOIeNlxt+Tyh5Gx3h8eoVUCrEg2B4p49KcPY
        35GaHuNAUrTgY+OO5Q11/qNxTYgajh5Y0QslD4wKeHV0JBaTi88jFuGz44Vjhj2kod6Zj9
        ZTeweHKo3qvtJIVyFKz94hS6HG+XHJxivP7LWlojWxDO6TxgT9UWeYFaqZG9Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976823;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjzAB0fzsGtpLPet2sHs0gH5HogT3zoQ1G1ZId/Omvc=;
        b=YPYe8GiwtjZIR+272qfTugkeqbh4LCZA6RFtM6NLfaWx2/c+TLyd86psc58Ych25tSVyMf
        iguhKx0d7waJHsAQ==
From:   "tip-bot2 for Miaohe Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Use recent_used_cpu to test p->cpus_ptr
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Mel Gorman <mgorman@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230620080747.359122-1-linmiaohe@huawei.com>
References: <20230620080747.359122-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Message-ID: <168897682340.404.2001714944772345675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ae2ad293d6be143ad223f5f947cca07bcbe42595
Gitweb:        https://git.kernel.org/tip/ae2ad293d6be143ad223f5f947cca07bcbe42595
Author:        Miaohe Lin <linmiaohe@huawei.com>
AuthorDate:    Tue, 20 Jun 2023 16:07:47 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:30 +02:00

sched/fair: Use recent_used_cpu to test p->cpus_ptr

When checking whether a recently used CPU can be a potential idle
candidate, recent_used_cpu should be used to test p->cpus_ptr as
p->recent_used_cpu is not equal to recent_used_cpu and candidate
decision is made based on recent_used_cpu here.

Fixes: 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20230620080747.359122-1-linmiaohe@huawei.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a739..b3e25be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7174,7 +7174,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
-	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
+	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
 		return recent_used_cpu;
 	}
