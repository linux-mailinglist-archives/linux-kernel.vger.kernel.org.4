Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711BC702503
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbjEOGjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbjEOGjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:39:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A6F1BE4
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:39:12 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-52c690f7fa4so8421363a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684132752; x=1686724752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbGpG4ZAOaq7Hlh8d6bFS/m3vJCuvL29YZwPCpli9B8=;
        b=TmDtPDc6nVDFKFdY0PRjJD3KjNUkAvZ/MFPGIZRevSxWptFajvFeIoBK2AmZdC0qMD
         wKGjXMjTq2bKBbovs8tI6qlAWuTS2oYndwwu+LXCvAzpAV4XUzV6cBAPWg6qTteyGOtZ
         oB1y0LDUJMcWmcnVCuQJxOf8UajkJqTqdV2VqD3xSUzygn7AZiCcaAyvCBuarO6S+rA1
         TJ2ZG4PtNX6fIDF5cDwKPUSQFPJUHPV1daBPtT5g41QhQ8AIyXrMzkKW8DwCIqXeP8sC
         nIqeQqyhhZY8SX1Fa+AmQVTv6cNvHASROdvY3wMIFwGlCmOwfUQr5erweC/qWrL/MHJ9
         0qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684132752; x=1686724752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbGpG4ZAOaq7Hlh8d6bFS/m3vJCuvL29YZwPCpli9B8=;
        b=WXGhnurCWLeSCeK+AqgV/3y1UnyAm8DvdW6dEIjxqC/xLtONEY856Kmk2GbNIW8qvB
         uGNlBLrf/zu8dyaYGDdN6LhKDPibRZ0gXi7LpFu3irpT6NM2aHzVmFMPrmg4j0Yt6JCE
         3dsnQX5J53dQSB60ErT0FS/CFsc1PTMQe/mezvCKc2JXCayRPeldaLq/cA+YzQA1ldS+
         9MK9Pv4zQ+QMoS19wy7EcoDnTeH9u2OXLF1wxyiyno0kSgv5ZgqdfABB45yZbZvKOFXc
         xOgiAdOT1/sCkNIERwMVVSIHHFrVPIWZguVmQZ/pMavC5JZjPYNvDIehOhgjYzL0TGKA
         Lv3g==
X-Gm-Message-State: AC+VfDygKtI5GsPurw91nJ7hOe0wmfLIs5mS5kPsgJImFpvq4ap/LOpj
        NTHW4sZhnMlqnP+yaCClWOvHLQ==
X-Google-Smtp-Source: ACHHUZ7NmT+/XeKqGzRqzeiSXbR4pJq7H5vS8ddiqiGOZvkXjqATL7VtaxhoQ4R8wT3+MxrtBUroFw==
X-Received: by 2002:a17:902:b696:b0:1aa:f203:781c with SMTP id c22-20020a170902b69600b001aaf203781cmr28759823pls.44.1684132751752;
        Sun, 14 May 2023 23:39:11 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902a5c100b001ab01598f40sm12608543plq.173.2023.05.14.23.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:39:11 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 2/4] sched/core: Avoid double calling update_rq_clock() in __balance_push_cpu_stop()
Date:   Mon, 15 May 2023 14:38:46 +0800
Message-Id: <20230515063848.77947-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230515063848.77947-1-jiahao.os@bytedance.com>
References: <20230515063848.77947-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
---
 kernel/sched/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 944c3ae39861..2bcf6a8e71fc 100644
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
2.37.0

