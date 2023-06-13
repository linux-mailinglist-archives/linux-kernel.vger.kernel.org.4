Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995C072DC38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbjFMIUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbjFMIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:20:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F089110F2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:20:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b3c0c47675so19727605ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686644437; x=1689236437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnMCJfZwdw2Doj0IUCtluopHvDDUTBGrdKXsgPSQqls=;
        b=UF/uDbVJYW89qcQrTk/zlrqgqxpn+AmoonOEo0fIr2AvFXqrKe/QRHMh4cQ9dqB6Fa
         Gw3Sq6XrEvG9veeRUNHe/0Iwis/RGbI/hEMCs8al9TIYnVWiuBrkwsYR7CYyyeRfF0+e
         oqE2gn8gvx2gy4X9b/HTRiVdOY/ZW8X7Z7OLKrwyIecX5SxbmiR0kUIy8gSjJGcw0BM3
         Tm8Fa+6tVkEPiBiqyD7u2xNOKmrD+A5c0zcMmuxeKmj/txtaOmnDwioWYLmXCzKT9e8f
         loJAoUFjybqWaNyJ0jR5/w8R/L010v1Xn8546EyFFCmNDLkWmNQFxj67ZIEM6tw6diuE
         +42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644437; x=1689236437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnMCJfZwdw2Doj0IUCtluopHvDDUTBGrdKXsgPSQqls=;
        b=ieBOsYhgqGYLz0y8yOc3OQWtuK8YlggDQUSjMKJwO2CtWlSw5qfQdrXBV6juGL6co1
         4jfWizBNV6JhUUbAUtw7NcFUq9TE7fCQscqnL46/87rWzG/rNM5l8CveAKUzQUTJjXs4
         p7QGqOl2DN7Bqkr6PUmBGgaj3OJark1kC4tTwKU9mV6iDiE47gyo4gJOK3M/7h73s1XF
         2gIXHXDBLb8S8b8AgrGd07rSssdaxeDNURmD7gZjP+zorqcX1T6471p83on0238qe/GR
         RItDJ3eprzdAc1MhwkbbUMqO1CmYlir+AT2ak7GrI+MVvIOkODu9BF6ydeYMaVhTHcV9
         09zQ==
X-Gm-Message-State: AC+VfDxjR/7CGFKAIAyANYBf1yl85+CiflbMJ5jD2iHtrHq0LqQzwFMN
        J8d4qHpZvMlbqyVvk0315KWIHw==
X-Google-Smtp-Source: ACHHUZ4A8GrgRsuqy2KF2IxJvjCA5tBqV8jdl2xb/pRaYocATcckPk3LC/OY3T8bHWeexEySngkahQ==
X-Received: by 2002:a17:902:e547:b0:1b2:461:8d8a with SMTP id n7-20020a170902e54700b001b204618d8amr10182616plf.35.1686644437448;
        Tue, 13 Jun 2023 01:20:37 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001b027221393sm9567834plc.43.2023.06.13.01.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:20:37 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v5 2/4] sched/core: Avoid double calling update_rq_clock() in __balance_push_cpu_stop()
Date:   Tue, 13 Jun 2023 16:20:10 +0800
Message-Id: <20230613082012.49615-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230613082012.49615-1-jiahao.os@bytedance.com>
References: <20230613082012.49615-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index a8be5415daba..1eca36299d8b 100644
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
2.20.1

