Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08D6699CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbjAMOPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242022AbjAMONt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:13:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14AFF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:12:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z5so20134306wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwoFVJIW+0bL7iox9o7Mb8U1WD+e1JDaKsR1FcoEM8g=;
        b=MhhrAgOCEacYOqL0IH0/5NYFagxjKcXil2qT+PzY/z6IHGPK6LEnYt7xNEt6Q9tlFu
         XhP/eOXVU7KfBx4MKIwGS5k3DadIIxLYdR5SZQ+EuZ8NF64OIb8s4e43SBd35hr0FcJm
         9yW3MFwcjOZWFus2MWaGvdV5+c82Ae4mhjhzf3aqdukTTqo2VMWPrFKwJhgXCjXpmW65
         bOtLzu9qRbgLQgDZ9RV1CVTveptWR16CeqriY4Hwj46dYCkdWiu2ZdAU7XT1KmwKpuIe
         /3KssFjWpG5vEH5sY3Doxs/3BAi8MhMEz536cReTf4TAbzMQIZMMnCdAmwiXm19uw7gv
         XIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwoFVJIW+0bL7iox9o7Mb8U1WD+e1JDaKsR1FcoEM8g=;
        b=EMO3e3an4CDk8aLKqqF2Z9vz2usOaW7A2iwQshRp3B1uk3X3tXu8McoNfsaxHPYcpJ
         1UH4m4fVA798yX6vox3iVMIy9TjIPcVSHEHVRzKvHIxnBJcAjek9QCfcsfaa7D1xQabB
         n6Oh8NWOF+bCYRfsLX9jwNpICF47e7qQDwEDRU7mMejBTif8pWppWdDUSYQH3DcsRWPq
         ecLtz/gZbJlMw1TLClt/A67DVrkIdix27BpbM0sk5xpHLH9WEylkcBhKSsmjv44zILS2
         Fv+jHxnR3l7CJV0FynsdmEJTfNIJHxuTA+Ww+xxgSAYAuQMxJngMTKEjFxgml6SbqPEY
         Iseg==
X-Gm-Message-State: AFqh2koiEvcZhQ4D2JDFbRXg3D1mquReyXMyQjBceyWEsLo91VYLT9Si
        rdILhS5aFkkO409XiPBmHds2uw==
X-Google-Smtp-Source: AMrXdXsByZ/ShOqB8ggFh/fnZel4FDcWA6Gc3xyRzPI/5sXgXIt0kicRj+cI2vUKOtwmI8v6k+2aQQ==
X-Received: by 2002:a5d:604f:0:b0:2bd:dc5c:7e4c with SMTP id j15-20020a5d604f000000b002bddc5c7e4cmr2431910wrt.15.1673619162861;
        Fri, 13 Jan 2023 06:12:42 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm13869919wrw.91.2023.01.13.06.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:12:42 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v10 3/9] sched/core: Propagate parent task's latency requirements to the child task
Date:   Fri, 13 Jan 2023 15:12:28 +0100
Message-Id: <20230113141234.260128-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113141234.260128-1-vincent.guittot@linaro.org>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 03b8529db73f..012a1f551f4f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4632,6 +4632,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.34.1

