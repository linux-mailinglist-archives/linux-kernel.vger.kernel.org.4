Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45889733396
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345501AbjFPObr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjFPObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0EF30E3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686925854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=snsqsnadQuWF/iNXR3bJnxKHdcFKcNrpogMxlgD4Nls=;
        b=O4YssD9wPqyVhKi7m31kzB9jhdN+OOVnZIO1kl9qEX/+p77U/NzoItK5Ow/pzPE3EJTy7L
        VGAvgIc4/eipaRWehQOeB1pNbK+rFD4ZgXEZ+eqrMsDsrQA/YsY8BRYxJEv0cIdZ5jFshs
        /dd5OcaNX3HT4GHk7nus0be9BmS0Xi4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-8yNsKBpSOuGotE7_fCU3tQ-1; Fri, 16 Jun 2023 10:30:53 -0400
X-MC-Unique: 8yNsKBpSOuGotE7_fCU3tQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f80e7e15b0so3876425e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686925852; x=1689517852;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snsqsnadQuWF/iNXR3bJnxKHdcFKcNrpogMxlgD4Nls=;
        b=Kgbwzp5bGaHlTBPO2qkZ3TRUzNDVKDhlF18AKuJRAjcJ8I+Nc0F2EXs+bw1gRK4fTA
         O6m0hrVeg9d+3x5zpyv6Ln6/pA2ToLicBxBRKUunL4EK/eoxL4NjGvkvAYrU+uqotZjb
         v+SCbo974iUM9Pe88hbTAu3ltdGTXLYHtV+C//DecK/qLVSI1nmKgrjFxjssM7+F07NB
         3Iv77PjTPZkYyIa9jF7t4HstfnGW7f/IKBMF4XYjUTc9xzGLp8gyRiUJysn5XFka/2DO
         Hz/sE7TLfyfoPXebJyi3VBs4yldCeLCinWME8AHq3PguRCWXXJQNTy489R6lktA6FbRA
         VKRQ==
X-Gm-Message-State: AC+VfDwMDsz4BC+IGPiK3J7Plv0jYLQaZLrw5R4EzEmJW4q/WqC5jMlI
        5IlBY0L7hKLD5fAe/VkchtCOu3y/IbFXhcXLPa6zr1wzj4rKUShnYWuIuWTRaIhacIHi+DyUtNt
        zV6pN5RoLgmvDrtjWHvR5gpW9MXnvpoXJ
X-Received: by 2002:a05:600c:214a:b0:3f1:7581:eaaf with SMTP id v10-20020a05600c214a00b003f17581eaafmr1955982wml.4.1686925851844;
        Fri, 16 Jun 2023 07:30:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Q+qIgBC3R+sBeFi9BRe0PkWqBHG+Tr6POdVXIyQr+OVHicJ4eTktWJm3vMJbTFeuKpv1jeQ==
X-Received: by 2002:a05:600c:214a:b0:3f1:7581:eaaf with SMTP id v10-20020a05600c214a00b003f17581eaafmr1955962wml.4.1686925851497;
        Fri, 16 Jun 2023 07:30:51 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id j29-20020a5d6e5d000000b0030fc280102bsm14106391wrz.90.2023.06.16.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 07:30:51 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [RFC PATCH V3 1/6] sched: Unify runtime accounting across classes
In-Reply-To: <51ad657375206dac0f2609224babafa1c1486d4b.1686239016.git.bristot@kernel.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <51ad657375206dac0f2609224babafa1c1486d4b.1686239016.git.bristot@kernel.org>
Date:   Fri, 16 Jun 2023 15:30:50 +0100
Message-ID: <xhsmhy1kjwkbp.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/23 17:58, Daniel Bristot de Oliveira wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> All classes use sched_entity::exec_start to track runtime and have
> copies of the exact same code around to compute runtime.
>
> Collapse all that.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

This one's been around for a while, John also carries it for PE [1] because it
makes things simpler. We should just get it in :-)

The three-layered if (unlikely(delta_exec <= 0)) is unfortunate, but I think we
can live with it. Tiny factorization appended below, but regardless:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

[1]: http://lore.kernel.org/r/20230601055846.2349566-2-jstultz@google.com

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7fcf558dc4bc..e52e609724482 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -914,6 +914,14 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 	return delta_exec;
 }
 
+static inline void
+account_curr_runtime(struct task_struct *curr, s64 runtime, u64 vruntime)
+{
+	trace_sched_stat_runtime(curr, runtime, vruntime);
+	account_group_exec_runtime(curr, runtime);
+	cgroup_account_cputime(curr, runtime);
+}
+
 /*
  * Used by other classes to account runtime.
  */
@@ -926,10 +934,7 @@ s64 update_curr_common(struct rq *rq)
 	if (unlikely(delta_exec <= 0))
 		return delta_exec;
 
-	trace_sched_stat_runtime(curr, delta_exec, 0);
-
-	account_group_exec_runtime(curr, delta_exec);
-	cgroup_account_cputime(curr, delta_exec);
+	account_curr_runtime(curr, delta_exec, 0);
 
 	return delta_exec;
 }
@@ -955,9 +960,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (entity_is_task(curr)) {
 		struct task_struct *curtask = task_of(curr);
 
-		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
-		cgroup_account_cputime(curtask, delta_exec);
-		account_group_exec_runtime(curtask, delta_exec);
+		account_curr_runtime(curtask, delta_exec, curr->vruntime);
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);

