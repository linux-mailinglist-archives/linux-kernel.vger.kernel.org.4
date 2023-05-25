Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3B571039A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjEYEBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEYEAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:00:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789AB18C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:00:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso662094a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684987248; x=1687579248;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbPhjGSXQJp1Mv0ZtInpjnht/26Ks3SJwp4Da2PXbgI=;
        b=PAFnqy+zovgTMggMbCtkEyMgICd3xzu80qdhmXtsZ3KCNdSp2pQ7eY5IHVAbg8160C
         42vlSPU30SH66yRm42PTD3NQ3p1y0UJe2tz5cFi1Jwq57mvjL9azA9xmldhetdJbdb8q
         EYREzRv3IwAbUFa/qUVD4txtrJxoZuRAvpnbv332ipFfT3OAMgnm8lZ2xu39hCJCMSp2
         4BOo9qcnv88ZsSVj/dg7Q0tVlb2H9YHDqy1PrXeOzAB3tsqGN8yyHmhqlHCePg11CbXc
         zzZQqHjx2PNCuL+NjQAy+DdvijiaPW66ZCK6R4GfyZTJ+5cXStEehjg4QO5nKuMO+/Z9
         gWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684987248; x=1687579248;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbPhjGSXQJp1Mv0ZtInpjnht/26Ks3SJwp4Da2PXbgI=;
        b=k032lu14aqMrdYgvIaFAl5HE2LB0JcuTWe9QrZeT9rgcmmCg5y2Uwnc2wLujzXpJXE
         BEFj02sXeu7spQoGQggWtSQ88sJFq23KEu5MtnJOcigUF+lch+IY7e3HOHyhqRR2GevU
         hcDbuMVsP4QeqSidFMym0aGz9IVPgeaU51yrGKCKER3y/fsttQja4iCWpxrNGf2P/2lF
         OfMEOxTtz2f2yLvJ7ww6ck4SSryl2HsGi4wgrv3c9Az4tv3nbHzXqTn3JNKYCdnxCnfh
         ml+pkTHCcd6QfUrLXuwh8LXh/pSDx5IZ35vFo26jOS1Ow28UoKdhXBud6KTEh4diiIOo
         D5oQ==
X-Gm-Message-State: AC+VfDwT7O03/eqHfqHqdcwalsmqIYNAyFrxg3lMKzc5Tll/da7Wao4X
        MzXmgFmjDWxE29WeP6Eux/M=
X-Google-Smtp-Source: ACHHUZ6s1npl1bYCzYgOakwTY2MoDRaFk8LblQjNAAYweSSl710voBr5XeeEG9PsjCDMzsGflsvpHA==
X-Received: by 2002:a17:902:d509:b0:1ab:7c4:eb24 with SMTP id b9-20020a170902d50900b001ab07c4eb24mr316884plg.22.1684987247726;
        Wed, 24 May 2023 21:00:47 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b001aaf92130afsm251661plg.116.2023.05.24.21.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 21:00:46 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, qiang.zhang1211@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: Do not set CPU_INTENSIVE worker flags with wq_cpu_intensive_thresh_us=0
Date:   Thu, 25 May 2023 12:00:38 +0800
Message-Id: <20230525040038.12346-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system start with workqueue.cpu_intensive_thresh_us=0, for running
per-cpu worker, the CPU_INTENSIVE flag will be set unconditionally in
wq_worker_tick(), this commit therefore disable set CPU_INTENSIVE and
directly return when workqueue.cpu_intensive_thresh_us=0.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---

[   17.359725] workqueue: process_srcu hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
[   19.752679] workqueue: gc_worker hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
[   19.796721] workqueue: gc_worker hogged CPU for >0us 8 times, consider switching to WQ_UNBOUND
[   21.992637] workqueue: wait_rcu_exp_gp hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
[   27.143632] workqueue: kfree_rcu_monitor hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
[   27.143647] workqueue: kfree_rcu_monitor hogged CPU for >0us 8 times, consider switching to WQ_UNBOUND
[   38.472708] workqueue: reg_todo hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND

 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c4f4ca0bd2af..eaea5386859e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1152,6 +1152,7 @@ void wq_worker_tick(struct task_struct *task)
 	 * We probably want to make this prettier in the future.
 	 */
 	if ((worker->flags & WORKER_NOT_RUNNING) || READ_ONCE(worker->sleeping) ||
+						!wq_cpu_intensive_thresh_us ||
 	    worker->task->se.sum_exec_runtime - worker->current_at <
 	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
 		return;
-- 
2.17.1

