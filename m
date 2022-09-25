Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0558E5E93B2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiIYOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiIYOlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:41:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7B92E6A0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c11so6659190wrp.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=g+vXRBBqadahqyZybKZY8U1Su9Fe7IsjjckgHlRaHyY=;
        b=ZLms5hFb/jMOK439ZrX1sSwiGCETd0lgRNblA6iGtcnhGlcZXSLxoN7/e9x01Ht/Ol
         ubu0LKwgcCxNayU3FR4KgljEf577uw6hiWWs7FtxG2Bdfe0qM0BAyc/2HbeKp3ypz/z7
         4EpfYOJQlVpY/jy6P+hrllcvU5z37HpmStG08mII6xDZHjQrwqyz1IftJBwSeSxlNBYK
         PdUOpISuqlW8dbgjgdAXAG/1RYGmcW3kysVmr+BL2/OeYbn/N4q2xnXvGRMbFz6teuRf
         yfhRXr0uu0LjlEV/4By+th+ejrv1WmqJH7lq4Br7vc2ZGjfE8IvHjY6fiyhi24Dkv6hY
         YUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=g+vXRBBqadahqyZybKZY8U1Su9Fe7IsjjckgHlRaHyY=;
        b=jcvmFNnwKos7FRCKLJnkpFVc2/JjqjpdxdPsmMRTTKkthX9nckdK5EiwlMA91SkIqA
         aEZ+r5/31+5vtT12ioDstDm96qC8VqvC/jgrnE05I0v9sBbwCHufZ9PkE5Er5VgxYCjA
         IS7Qt12ir+LatTFeQ9cKSJ5TDAZe2xdeTIavteTAnB4SMzkoyW0kQM67jIJw0oZJnF4a
         Hy9R3gK0wTvX8O0C//bn9Sv2mSpdQdFcuMZqQZZogJM1JymU53XUFpQzNRk+njkEnpLq
         NewUgXndGVv+PDQbHIGmFMrJGpEgrPpdAg+inweBvsdCa/dSZ3hJFCj7Rog4XPO3qB7o
         /1LQ==
X-Gm-Message-State: ACrzQf3eL7OzmN9yHpw4g4yefnifTO1yuX8XZVs42jPpQxbE/XoEW7u+
        MdWpuWAkylkl8OgnxJGLzI8fZw==
X-Google-Smtp-Source: AMsMyM7pIOq3LeafdXwIqfk3WII8jVRxxYMLI+qQ4zZdyobRrthJvmSbgMllsIFIP/aN4lhmDalMYw==
X-Received: by 2002:a05:6000:1f8e:b0:22a:ff55:ea48 with SMTP id bw14-20020a0560001f8e00b0022aff55ea48mr10242604wrb.121.1664116883592;
        Sun, 25 Sep 2022 07:41:23 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm20774761wms.1.2022.09.25.07.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 07:41:22 -0700 (PDT)
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
Subject: [PATCH v5 6/7] sched/core: Support latency priority with sched core
Date:   Sun, 25 Sep 2022 16:39:07 +0200
Message-Id: <20220925143908.10846-7-vincent.guittot@linaro.org>
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

Take into account wakeup_latency_gran() when ordering the cfs threads.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 74e42d19c1ce..e524e892d118 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11443,6 +11443,10 @@ bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 	delta = (s64)(sea->vruntime - seb->vruntime) +
 		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
 
+	/* Take into account latency prio */
+	delta -= wakeup_latency_gran(sea, seb);
+
+
 	return delta > 0;
 }
 #else
-- 
2.17.1

