Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A961F602BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJRMm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiJRMmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:42:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A3FC1D9F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:42:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z97so20241983ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yMP6fIsH3iK8GvA/5hVJOpgVRfJnpqAP6lVmWiyWygE=;
        b=f+yELfdZ47XzJ+BJzeb7htVmv1joFeJ0NqAak3zL6TROI4B11piQZ2iVrsJcg+5F31
         gAXNnWkUOREl4sLTvoKD18xGUjkyuYK0LuWBnA8g17PMusFAqNYjbqhQFW15fGAh382g
         dp8ZCnrIOq6F6W47+MkAOhaAJm3WNgTX5kPolUG3mcOiEuVxB8FD6toXYuhPhGpXf60f
         Z8uoxnRDs8Nx69yZkmqiitDM4W6hGAu/QxBVmJI2FdjwAeifjFhZP384qxt9RdMp3voA
         95sLDELZHhIihTc1Oz8Z02WUrjzGr3J13dbyNWxijVCFX//MVHs2PxeIN5eQkQehdb0K
         PFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMP6fIsH3iK8GvA/5hVJOpgVRfJnpqAP6lVmWiyWygE=;
        b=uH0X+WikEmLcSFvMReimhhX45V+SNXE2QIo15EA4OuqVFgs3tnfmIC26uvnn6Xkxm3
         5nBEmRBbdzhAl2khDiqG05xv2PBDjs0V83BeH4Bi2krBH5LYEbTtSOxURrZBqzO4XjU3
         8EJm+EXZ9iyh8e0pgDxB4QaGWEk19HRKzFL+HTG1MixqUmhyaA0QK+mZh3JtmaVsulSE
         8wNXq8OIDq8IANS/TCpr4CG1qylPA65NpKHvlI56BY/BYyexpb4ZCWQYhyYEtht+axPn
         EJGesvkbEQf0nAtXEsgiaaBas0gs+EZOizr2QKyACrBcdFYY8v+oXgZTGOTe9yv46r/4
         iWhw==
X-Gm-Message-State: ACrzQf2pV2Ick31AgOAwgrHqw4rk7FNx7GSFDgSacmcPX+h9XyvIdqD1
        0MUPKviOMhdH7EdROi13PsGlWnYswF5JBRnsobopgEEgXAg=
X-Google-Smtp-Source: AMsMyM5mAjPZvG/k4IHFmA9D7OeQo3AejAZ5I9SIzubNLQsvefoJ2et+wacsozv8bDL9L/QS7q5q7YfBOAy70BbaqoQ=
X-Received: by 2002:a05:6402:27d4:b0:45d:a69e:336d with SMTP id
 c20-20020a05640227d400b0045da69e336dmr2416594ede.298.1666096971346; Tue, 18
 Oct 2022 05:42:51 -0700 (PDT)
MIME-Version: 1.0
From:   JaeJoon Jung <rgbi3307@gmail.com>
Date:   Tue, 18 Oct 2022 21:42:39 +0900
Message-ID: <CAHOvCC6-8sPD8yNy3AjHNzCkmqi+RYhtPNDs5ACe1-MMtOD3KA@mail.gmail.com>
Subject: [core-scheduling] Modify prio_less() with in CONFIG_SCHED_CORE
To:     Peter Zijlstra <peterz@infradead.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Since the priority of sched_class can be determined by pointer operation,
the prio_less() function can be modified as follows.
With this fix, the __task_prio() function is not needed.
Please review.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..24b86773da04 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -154,21 +154,6 @@ __read_mostly int scheduler_running;

 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);

-/* kernel prio, less is more */
-static inline int __task_prio(struct task_struct *p)
-{
-       if (p->sched_class == &stop_sched_class) /* trumps deadline */
-               return -2;
-
-       if (rt_prio(p->prio)) /* includes deadline */
-               return p->prio; /* [-1, 99] */
-
-       if (p->sched_class == &idle_sched_class)
-               return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
-
-       return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
-}
-
 /*
  * l(a,b)
  * le(a,b) := !l(b,a)
@@ -179,22 +164,18 @@ static inline int __task_prio(struct task_struct *p)
 /* real prio, less is less */
 static inline bool prio_less(struct task_struct *a, struct
task_struct *b, bool in_fi)
 {
-
-       int pa = __task_prio(a), pb = __task_prio(b);
-
-       if (-pa < -pb)
-               return true;
-
-       if (-pb < -pa)
-               return false;
-
-       if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
-               return !dl_time_before(a->dl.deadline, b->dl.deadline);
-
-       if (pa == MAX_RT_PRIO + MAX_NICE)       /* fair */
-               return cfs_prio_less(a, b, in_fi);
-
-       return false;
+        int less = a->sched_class - b->sched_class;
+
+        if (less) {
+                return (less > 0) ? true : false;
+        } else {
+                if (a->sched_class == &fair_sched_class)
+                       return cfs_prio_less(a, b, in_fi);
+                else if (a->sched_class == &dl_sched_class)
+                       return !dl_time_before(a->dl.deadline, b->dl.deadline);
+                else
+                        return (a->prio - b->prio > 0) ? true : false;
+        }
 }

Thanks,
JaeJoon Jung.
