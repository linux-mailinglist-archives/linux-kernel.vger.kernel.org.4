Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13275E93AD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiIYOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiIYOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:41:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037C11105
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y5so6730927wrh.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=xgZILBJrfBdVYZE/N+pW4Q56k/FtOZrt0ohTpwnzbzE=;
        b=tTH9OXxH0XyodBLjOoQeDn7GlN70ICdhQTxyV2KVUMfvfjTsbGsI4+9PPGUgRsydV6
         Z7vLG+Io4LPU5mmFDXT3bCXi2cQKnMoRRQSWizVp9SXYEZEycGIbX412wIhB/RSUO7pF
         L4zaWZnODe4fxGon8+kdP0aCm0UYqwKG+F3fmcllFsK+S8j0hh+AhIbv709lEHZDU75E
         +ov4eXCJAy+8SrGLeWNp58OxAxOqzrbaytjV4yKwPpXlddq2V5LSbYhahaeCOdIWXNJG
         GGoblvYz9rGYTV/+B77X7Qzt5ZRxvZ/OzbyigtF7ACQ261N9qzIEIgivI4GYTDxwO3nM
         89nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xgZILBJrfBdVYZE/N+pW4Q56k/FtOZrt0ohTpwnzbzE=;
        b=vDnue+LZgCRelSEY5M4pPFkFq/uJVjpAQQWLgkFw3S3hXOdc/KbSOCKYMoAOmo1yO3
         j3s+KeX7UGQUMc9cSCUr/beLgHwm7LVg90Kluy4hMBVYgUFHUrb2ZYNMXBHOO0lum+Qy
         W0ORG3i71PQ7NW6WVvDeYS9fG9alLy1tAjxySs6W+JEqVIebVsAeEKsqRalddVKt+O8Z
         7xrlE0UlOzsO/Utk387eo05YWK9TrceunUaBB+ZKDCP7NBcR9iB2Z83L2woGndej9pgW
         VhrBxemF7W5ysGsPJmCZrG29H7rSqVrtjPyRdQp3xnA/V3gD22CP23BOzw/ehaDiTefZ
         JZkA==
X-Gm-Message-State: ACrzQf1w0K7PIYN6JcoX6aiQgBdr+vYi910yaywBAjVB2VqUBED48Odl
        zwc1Qmnm19QxERmzaUOuRpTgBXQuLJxBaA==
X-Google-Smtp-Source: AMsMyM5Rje3rn7B9bY/c6pQAH2N0ln9osv11EiK4TqfUTb3HKIqQXa2lQMFBafIfqzugO23tmH0xfg==
X-Received: by 2002:a5d:6c62:0:b0:22a:2f59:cb7d with SMTP id r2-20020a5d6c62000000b0022a2f59cb7dmr10791596wrz.405.1664116876293;
        Sun, 25 Sep 2022 07:41:16 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm20774761wms.1.2022.09.25.07.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 07:41:15 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 2/7] sched/core: Propagate parent task's latency requirements to the child task
Date:   Sun, 25 Sep 2022 16:39:03 +0200
Message-Id: <20220925143908.10846-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220925143908.10846-1-vincent.guittot@linaro.org>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parth Shah <parth@linux.ibm.com>

Clone parent task's latency_nice attribute to the forked child task.

Reset the latency_nice value to default value when the child task is
set to sched_reset_on_fork.

Also, initialize init_task.latency_nice value with DEFAULT_LATENCY_NICE
value

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 init/init_task.c    | 1 +
 kernel/sched/core.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..7dd71dd2d261 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,6 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
+	.latency_nice	= DEFAULT_LATENCY_NICE,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4fa4a3ddb4f4..ada2d05bd894 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4559,6 +4559,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.17.1

