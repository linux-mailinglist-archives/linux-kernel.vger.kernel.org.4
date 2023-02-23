Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE916A1040
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjBWTLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjBWTLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:11:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FDE5679A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:10:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id p8so11686599wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe0Uu935GUv7Os5h4xnlj3hjmH+1d59YLoRXBZZGIAY=;
        b=O5L/+yHrHJewBHNYaYMbLKYpHrKb8Xzmc5mPSGmWCTUeJrXKrVIEt9GIBqBDR8jLs9
         ynu5wPnOjt62g7XREb/nchkcilMGJO5EVs4VNmOhKaEnQqJjyC59CW5xU7hF4xm9Kvzg
         SW9uMaGjdZaOO459sH7YCj0eTFqrJB/aKntYiF/greT67lZ0krZdefFpCMiDsQVBIPct
         X9J1b07w2ceDMTaDURJK39Vm3CYaoE0V3kH3z5ZK0iS4XIixTZsGrqXbUNsigjWCjoeq
         M3QYnDlmMTjwujqbLDLMCmu1b7d/755D9YDgEvxSq+E7CEbiWbnxv7d2mhK4wUqYOjt1
         iKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oe0Uu935GUv7Os5h4xnlj3hjmH+1d59YLoRXBZZGIAY=;
        b=FcribIiV8P4r4WQe6qePTynIG23PO1/uckSNIn4ptHOwxOypj0H9OV3ezDO/qqB0J8
         IHtKnerZUGp44kmINxXoaDsRNLRoAdykVPYZ6BrCBEbaDgYrb/i9fMDYmXKL0QqdFvlt
         Arj5De3nkIrdVz7bi3oOrmUeyWroONYahgaSOe+LYXv55xvSOis041oivKZa/Hct8bgX
         Mk+chZLEbeyu+A96nxKvDc/PnU+NCSWpghHCARp58XJe2XCW492t8VPKsMXybnhRUuFf
         AMK242xFX2vOdRN3N369FoBP9zEYCqAGBnixVRHOv+71rk9m8groN79U9a+l2xcA6i5o
         De+w==
X-Gm-Message-State: AO0yUKWZTc443ljnFZuDO4oy7VkQA9NQa4BAz9gDc4JjqLEyo+JngNKm
        HRY4G0Hj9Ja6lgM66GZgD/hs0Q==
X-Google-Smtp-Source: AK7set96DpUpc8Hz/quQD+izLeGyOtgvPquIgErpX9Ec6Y1qBZvnxhj2dEmIniQ2GWaJEOZ96ffgPg==
X-Received: by 2002:adf:fb49:0:b0:2c5:3cfa:f7dc with SMTP id c9-20020adffb49000000b002c53cfaf7dcmr12039916wrs.7.1677179449339;
        Thu, 23 Feb 2023 11:10:49 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a6f0:4ee9:c103:44cb])
        by smtp.gmail.com with ESMTPSA id k2-20020adff282000000b002c6e8cb612fsm9844481wro.92.2023.02.23.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:10:48 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     tj@kernel.org, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v11 3/8] sched/core: Propagate parent task's latency requirements to the child task
Date:   Thu, 23 Feb 2023 20:10:36 +0100
Message-Id: <20230223191041.577305-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223191041.577305-1-vincent.guittot@linaro.org>
References: <20230223191041.577305-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
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
index 4580fe3e1d0c..28b397f9698b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4681,6 +4681,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.34.1

