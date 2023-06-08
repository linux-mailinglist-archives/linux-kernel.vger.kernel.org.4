Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E8727748
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjFHGdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjFHGdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:33:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78F270B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:33:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so115633a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686206019; x=1688798019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwSmBGENtB9L+r5dkVtr2aEZeow7KKO4JZwDEcpVetc=;
        b=IEHwjTXzJVuYe7DYM3MMNxTEdlSl/A+mPuD9qso7opHwllbtTs1HRB7CkpqkgdJLYq
         zB+AvmDeMSnS/vMohpOGjFyxEG4+4lnIpqXql5aNQyRaRArkLbtZVtZ4OXGwgIkWRV3T
         elnobLx9QVU9+PLQ3xtgwLIJo1oboYZKE3U/HKNQJ16AnyZjQlV/4oqLNRE5Fux7Ho20
         OjNUd6O6YlQO0RY2JNaBg5k0euSmsBFJcfqya/3OoQuL/UWrW9h0wFUg+aeY8QKwaRH0
         6sS1iUkpASJIpRqLgeSErBuefw05ikTuyoZ4fn+N0I8mCEmkrWb2pNpH5Qlj2V3F5gc7
         kkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206019; x=1688798019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwSmBGENtB9L+r5dkVtr2aEZeow7KKO4JZwDEcpVetc=;
        b=mEPkzN90wyGxsWUMPCx9iJl6Qsa1AFQg8pw35kwklbnKbOezWy322OfwLHLtoFOYB6
         kbcNdhpoMX3wi04aVbdeyvG8KTxClPzYIF7Czhx0tfRizw/JTe/A9SY0x6dPpS2kYJwl
         BqVA9i5s7hz0qgY7Or3IJrB5P1OhxVPD/j7cr5Cg7H7GJZRy42sOPxzAX6KjfTdfNG9N
         reTPh8hjWJOsqafRH7CpxQtmECIl7uccdAVjEqQJ9p7F4h90gXuIgE5ClB4etbqnj6Jm
         M9poDB3RZhGZca8kR1bp20sp6MGktKTJUuuXM5Cek+NNXonnLHny1lq5izX1i0GsrrE0
         +vyQ==
X-Gm-Message-State: AC+VfDyGUQ5kDGTUGXqiTh+WgZTbKXreeL6/ce6mhloxacMNOKFhipqc
        aTrgqAn2vW5sOnOeK9k6Mdxfmg==
X-Google-Smtp-Source: ACHHUZ4nloOJkDga2G1MXrbXuhlMwBysk/Y1/2p/Y17/8yja5JwUCBsJmbIDo0dRfLfuqmRLt447zA==
X-Received: by 2002:a17:90a:9cd:b0:256:7000:3789 with SMTP id 71-20020a17090a09cd00b0025670003789mr7066599pjo.9.1686206019152;
        Wed, 07 Jun 2023 23:33:39 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c15-20020a17090abf0f00b0025645d118adsm542039pjs.14.2023.06.07.23.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 23:33:38 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v4 2/4] sched/core: Avoid double calling update_rq_clock() in __balance_push_cpu_stop()
Date:   Thu,  8 Jun 2023 14:33:10 +0800
Message-Id: <20230608063312.79440-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230608063312.79440-1-jiahao.os@bytedance.com>
References: <20230608063312.79440-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WARN_DOUBLE_CLOCK warning is triggered during cpu offline.
------------[ cut here ]------------
rq->clock_update_flags & RQCF_UPDATED
WARNING: CPU: 17 PID: 138 at kernel/sched/core.c:741
update_rq_clock+0xaf/0x180
Call Trace:
 <TASK>
 __balance_push_cpu_stop+0x146/0x180
 ? migration_cpu_stop+0x2a0/0x2a0
 cpu_stopper_thread+0xa3/0x140
 smpboot_thread_fn+0x14f/0x210
 ? sort_range+0x20/0x20
 kthread+0xe6/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30

To avoid this warning, we remove update_rq_clock() from
the __migrate_task() function. And in order to avoid
missing rq clock update, add update_rq_clock() call before
migration_cpu_stop() calls __migrate_task().

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..1fd87657f521 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2398,7 +2398,6 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 	if (!is_cpu_allowed(p, dest_cpu))
 		return rq;
 
-	update_rq_clock(rq);
 	rq = move_queued_task(rq, rf, p, dest_cpu);
 
 	return rq;
@@ -2456,10 +2455,12 @@ static int migration_cpu_stop(void *data)
 				goto out;
 		}
 
-		if (task_on_rq_queued(p))
+		if (task_on_rq_queued(p)) {
+			update_rq_clock(rq);
 			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
-		else
+		} else {
 			p->wake_cpu = arg->dest_cpu;
+		}
 
 		/*
 		 * XXX __migrate_task() can fail, at which point we might end
-- 
2.37.0 (Apple Git-136)

