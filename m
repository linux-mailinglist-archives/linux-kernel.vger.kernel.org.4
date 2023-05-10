Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603A86FDF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbjEJNtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjEJNtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338C49D2;
        Wed, 10 May 2023 06:49:10 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nnm6MQtpVSqF2IShOpRrqiPWaeeBNKPEFK6wSQHJWz0=;
        b=zZ23eguRVdavO3k1Y7ryh8jEHQDD6/cu6Mow3S32OCCGNdJTJxZMGMgHnSReeM450CJgLD
        MFCo+3trrkXw8bFaGS79k/Sx/4VFmm3jXVKLMvwthbi8S8jUogtXnHc3RQFVligXa3S5J3
        3M5Ge1sviLlA+kdJ52SzzseWBiPNJbRdOXzknXx1gdZ2yS1PUQh05LQvhsDIUowrx/kQwO
        HAj55uszW3eTNC30sV9rOqeiYzn+dqTarvap8XQa29MCUqiVTJJypdbvjx/GeEebFXmbTv
        dd6SFA4fBZ+elQLl0NK+DRsKD9776Z8WVhfHiJt/CMxzFtjrgMiOuts1y/RoPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nnm6MQtpVSqF2IShOpRrqiPWaeeBNKPEFK6wSQHJWz0=;
        b=OjKpjjQEd3sjAEh/5F0NMQdpj9+tNnMfLAEovzrcR4ENWz8yFcgYfASJXNZkUjeRSQg4Kw
        3qkjnZiqiPnjJjAQ==
From:   tip-bot2 for =?utf-8?b?5pmP6ImzKOmHh+iLkyk=?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Correct printing for rq->nr_uninterruptible
Cc:     Yan Yan <yanyan.yan@antgroup.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230506074253.44526-1-yanyan.yan@antgroup.com>
References: <20230506074253.44526-1-yanyan.yan@antgroup.com>
MIME-Version: 1.0
Message-ID: <168372654853.404.17704354733934460594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

Commit-ID:     a6fcdd8d95f7486150b3faadfea119fc3dfc3b74
Gitweb:        https://git.kernel.org/tip/a6fcdd8d95f7486150b3faadfea119fc3df=
c3b74
Author:        =E6=99=8F=E8=89=B3(=E9=87=87=E8=8B=93) <yanyan.yan@antgroup.co=
m>
AuthorDate:    Sat, 06 May 2023 15:42:53 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:39 +02:00

sched/debug: Correct printing for rq->nr_uninterruptible

Commit e6fe3f422be1 ("sched: Make multiple runqueue task counters
32-bit") changed the type for rq->nr_uninterruptible from "unsigned
long" to "unsigned int", but left wrong cast print to
/sys/kernel/debug/sched/debug and to the console.

For example, nr_uninterruptible's value is fffffff7 with type
"unsigned int", (long)nr_uninterruptible shows 4294967287 while
(int)nr_uninterruptible prints -9. So using int cast fixes wrong
printing.

Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230506074253.44526-1-yanyan.yan@antgroup.com
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0b2340a..066ff1c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -777,7 +777,7 @@ static void print_cpu(struct seq_file *m, int cpu)
 #define P(x)								\
 do {									\
 	if (sizeof(rq->x) =3D=3D 4)						\
-		SEQ_printf(m, "  .%-30s: %ld\n", #x, (long)(rq->x));	\
+		SEQ_printf(m, "  .%-30s: %d\n", #x, (int)(rq->x));	\
 	else								\
 		SEQ_printf(m, "  .%-30s: %Ld\n", #x, (long long)(rq->x));\
 } while (0)
