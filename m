Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927FC5BF8AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiIUIMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIUIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:12:32 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F50487094
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:12:32 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id b136so6954800yba.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=yMP6fIsH3iK8GvA/5hVJOpgVRfJnpqAP6lVmWiyWygE=;
        b=OtLKSLekEe83VW0HHA+Z1P+31edmiC7w5LgdH0kmBcXqAWTy3V8oqXw4WJagZYElrM
         6WmztvrZ+tfHWX88pLIfnPdvWRSNwjnsjOkFhxo2xpbCGrvkRH+LAs+Mtslrba0q+ME9
         pDaDqZ4P9UCS6H5xEfj722VCW2I+L7seXw0hdNNhuUc49fuyk56XQWgsL7muNgvlBnta
         2s1EO7O3bWYNfnlAn2YPK/RBIbKiFBOXpYAIs3MbF8js9gFwrAuGQb5o1LSzm8ndArj1
         tRwHQ0jZG/3iuRF1L4D2RGZmFUVABTPd8AnupiB1ApGd8J9edb8HNaXizNUBd0iQRtC1
         Hc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=yMP6fIsH3iK8GvA/5hVJOpgVRfJnpqAP6lVmWiyWygE=;
        b=OeWukZD1lbiIqFDIBUM1kPhPHkXYnpJhjlooXBgSMUnZ8XizFdzkmLq8FEP/FQ2A1X
         KIQEINFAeDfOjPUcY8NdFTgi+tCnGBL/i3ht5VA3Gve3LzdahGzivW36i60S+aPxjcNm
         BFFxwEk06Ttc30cbv+wdo/l09zE6p6dLOPKDH6umj+538mTwUGCwLqf8jjiIHGsxwYgH
         J8llGtrpP8+xKwv19D4RAa64UP85BzD666zPpzIqEQsn0Fpe1W134a7KpDBs0vVXqA3I
         hppXl2QJxJoldrqEXOw1et1gUQ9TJMk7KS1TLtyh/ZWydA+9lHjsifCVR++JZDLGy5ns
         dSsw==
X-Gm-Message-State: ACrzQf3y85RGlo7EXA2fVe6+z2nx2u2VuhrROk40WwZChUVjiGtzsCbg
        rhqNV5GZ1bLz5/p7fFEYZsnvAxO5vZfBNyAMQg4=
X-Google-Smtp-Source: AMsMyM5M5QQFOZ8QlVYQq4CF+D1hmgstZ1hbisOqxlm830qNaqa7SxTt2euTjkxDvlrSnJqjyAFS7LNxX7Bk7Xa9/ys=
X-Received: by 2002:a25:8152:0:b0:68b:1162:4312 with SMTP id
 j18-20020a258152000000b0068b11624312mr22896378ybm.289.1663747951428; Wed, 21
 Sep 2022 01:12:31 -0700 (PDT)
MIME-Version: 1.0
From:   JaeJoon Jung <rgbi3307@gmail.com>
Date:   Wed, 21 Sep 2022 17:12:20 +0900
Message-ID: <CAHOvCC6JxwF51=-HHNS9wbv38H6MZ=rLjVDH7o_WGAQ6OFoTqw@mail.gmail.com>
Subject: [core-scheduling] Modify prio_less() with in CONFIG_SCHED_CORE on v5.19.x
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
