Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9991174E323
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGKBPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGKBOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:14:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFDE170E;
        Mon, 10 Jul 2023 18:14:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8ad356f03so33090705ad.1;
        Mon, 10 Jul 2023 18:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038076; x=1691630076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrW7vMiU6ZQ4Vgx18JIyoYqnBVStESkiqVqm2bESiQI=;
        b=gPnSJZMqYT30Hp5QRloTeBIS6H9BPBU69IBaEk4+5Fy6zStNqLF/zj4/Lsa59GPc3Q
         Fa4B95G/mLXInqYGQfDBmwHrbmWepdpLz/tajkkWTKUjeUu5w4uxFJaxwDXDKWSnUivN
         aerYIwloicHSx6Jiulqn3sDQArDY56bZcHDDjeclJ7dcHIzLU4Qx0JQrJmj04lizYbz8
         orODbJO0JiLFUymcGG5+SxXCN2fxKsGBDujqHaemyO6c5eLeelXC6n/IVvJWFOYaD86g
         b+wgHYYUjzvmkOSUYWxJ1PCPDn6zudn5OSUaopuSCD39t7/PRjmVI5YkQVSMuo2zTBhC
         kHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038076; x=1691630076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrW7vMiU6ZQ4Vgx18JIyoYqnBVStESkiqVqm2bESiQI=;
        b=UFw5q6AYIZII37lj5DlqpYSAZES5QcGeddgTCSzZw48ns3DbUkExNX5y40G4hS9k+b
         xzPcLD6JgQdXSM42MBuj/snkbcx9Pnexm4WXvlJTGS0jqe8rQBeq6+wKSNxc0Bez9MSQ
         8ki5ohnHD6PDiJz0gKocxBP9Sa1Xhwm8E5RyydX3J2akaDjQqC2RrOsJUF2ZEDzk9bZO
         ppsmFyDL9MKvwFob5DB3fF5T1q4wIrxoOVfZIRpcZCKUmDBONf9K6P1iQrSdba0umr/a
         emrbsX87pQBL5YRgw8wfzc9d46yhRoNitJg22oGOWnoqBpZKnu8YtuFEVLCy1ad78177
         D4Rw==
X-Gm-Message-State: ABy/qLZgirpWx8NP1GaO3R5QYcsBOQzFawG3gmkKyxHo3wQ3ay8CSKh7
        1hp1+Qyl53jvQfu+3sQUNlE=
X-Google-Smtp-Source: APBJJlGlN1PHt+NmO9XrMhNbKBVq35VVN5wOXHx48ftUF2+n/fYzS8hgXekckoplYcNOlksDtO1m3g==
X-Received: by 2002:a17:902:ce89:b0:1b8:7625:3042 with SMTP id f9-20020a170902ce8900b001b876253042mr13465115plg.10.1689038075896;
        Mon, 10 Jul 2023 18:14:35 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170903279400b001aaecc0b6ffsm511586plb.160.2023.07.10.18.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/34] sched: Add normal_policy()
Date:   Mon, 10 Jul 2023 15:13:28 -1000
Message-ID: <20230711011412.100319-11-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new BPF extensible sched_class will need to dynamically change how a task
picks its sched_class. For example, if the loaded BPF scheduler progs fail,
the tasks will be forced back on CFS even if the task's policy is set to the
new sched_class. To support such mapping, add normal_policy() which wraps
testing for %SCHED_NORMAL. This doesn't cause any behavior changes.

v2: Update the description with more details on the expected use.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/fair.c  | 2 +-
 kernel/sched/sched.h | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9838c82230e1..5ba7e1f2e7c7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7900,7 +7900,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
 	 * is driven by the tick):
 	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (unlikely(!normal_policy(p->policy)) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cd11bf9de7f9..7eee863942f4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -182,9 +182,15 @@ static inline int idle_policy(int policy)
 {
 	return policy == SCHED_IDLE;
 }
+
+static inline int normal_policy(int policy)
+{
+	return policy == SCHED_NORMAL;
+}
+
 static inline int fair_policy(int policy)
 {
-	return policy == SCHED_NORMAL || policy == SCHED_BATCH;
+	return normal_policy(policy) || policy == SCHED_BATCH;
 }
 
 static inline int rt_policy(int policy)
-- 
2.41.0

