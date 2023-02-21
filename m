Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9049869DBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjBUIYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjBUIYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:24:42 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0681C1EFF4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:24:41 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o12so14171479edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oPBARR1XQLY58c737UTH5eoRSYkaY0yhf7AxAKsB3Ys=;
        b=FTilw8opE7NXkwjgsqlx6udSECCNGFBY5jaRwzj4cGQKeJb5vWv+kxlubSWOd+ugd3
         YUoiba4n0y27qNw2IG7TyFincOVCdOnSS5o8Yt1r6jLDQ5C8uD/cOa/FWgdTkS9ZXfok
         0Vvy9OT547060nJLz8ilID+aiMbTrxQlPVicHnmM06nMDACwhPUPfzJAIymM56uUXkX+
         dI9ixC3Q47KBiisYcvISlL28WTmCHZS2MXFAB87dPSsWVA9CXUtTFR9LRuuwcMtXqet4
         Gvpy0DSSTvGany6XHc+Fn2uEUf/Jdn8z8BXax70b58KSU+SHVNnvXaVDYMvhemsre1kM
         PITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPBARR1XQLY58c737UTH5eoRSYkaY0yhf7AxAKsB3Ys=;
        b=GJAXKdGMS+9Ems/DSAHBjx7eBa1ZIFPCD1kyWhd5eOF/ScnfA6tM3RBjWOpcaCp/Uy
         Mg4DQchM+oqaRt1lEkdFHxWqZ6V5vXqvvgoilzjnBV79D3tNLxUcv88usIqq5fROTYQq
         yoEy3dhbwBOpcwmOGnm8w6haPfH3x+XynJzWC+H1q4LwSRPb7ySLBzNEmLAebuYn8ktO
         NKhHr+D3Lzsk0HPlr2R5Nev8boWjPT+/28EfgjGjYuamhrFfD0RS40g8h95TBVJyMVl6
         Y84U/NMQd6yg+G+41YmEneAhfhp6tSa9LCiTnpIxdxXdhZxDC3EHEj/M0wDmz495znSc
         SyAQ==
X-Gm-Message-State: AO0yUKWJqOL5D4/NSVN4e9eZ4oHO5d6JQRksKGwDoHvxz2Y37ycTrpLY
        lTI9kigtewpSmhzRlUcxvGDG51GVYbbauOu8jwRg4Fhgu6A=
X-Google-Smtp-Source: AK7set92wsZHs0StkibTXHBpXgiS8paznGlOif4P/bhC35luKsT8XnDF1ma7j/vFpwvdwEWrkJLvTn4C10ASjMixMm4=
X-Received: by 2002:a17:906:d966:b0:889:8b2f:75d1 with SMTP id
 rp6-20020a170906d96600b008898b2f75d1mr5350016ejb.10.1676967879345; Tue, 21
 Feb 2023 00:24:39 -0800 (PST)
MIME-Version: 1.0
From:   JaeJoon Jung <rgbi3307@gmail.com>
Date:   Tue, 21 Feb 2023 17:24:27 +0900
Message-ID: <CAHOvCC7yjceArav9Ps0v1EP4CjfkrxbfXFgABK54cdFKNoE8iw@mail.gmail.com>
Subject: [PATCH] kernel/sched/core.c: Modified prio_less().
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
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

The sched_class structure is defined to be sorted by pointer size.
You can see it in the macro definition like this:

kernel/sched/sched.h
#define DEFINE_SCHED_CLASS(name)
const struct sched_class name##_sched_class \
        __aligned(__alignof__(struct sched_class)) \
        __section("__" #name "_sched_class")

include/asm-generic/vmlinux.lds.h
#define SCHED_DATA \
STRUCT_ALIGN(); \
__sched_class_highest = .; \
*(__stop_sched_class) \
*(__dl_sched_class) \
*(__rt_sched_class) \
*(__fair_sched_class) \
*(__idle_sched_class) \
__sched_class_lowest = .;

And in the System.map file,
you can see that they are arranged in memory address order.

System.map
----------------------------------------------------------------
ffffffff8260d520 R __sched_class_highest
ffffffff8260d520 R stop_sched_class
ffffffff8260d5f0 R dl_sched_class
ffffffff8260d6c0 R rt_sched_class
ffffffff8260d790 R fair_sched_class
ffffffff8260d860 R idle_sched_class
ffffffff8260d930 R __sched_class_lowest
----------------------------------------------------------------

This matches the sched class priority.
In the prio_less() function in kernel/sched/core.c,
the less value can be determined by pointer operation as follows.

If the prio_less() function is modified as follows,
the __task_prio() function is not required.

Thanks,


Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 kernel/sched/core.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2a4918a1faa9..75075d92a198 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -151,21 +151,6 @@ __read_mostly int scheduler_running;

 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);

-/* kernel prio, less is more */
-static inline int __task_prio(struct task_struct *p)
-{
- if (p->sched_class == &stop_sched_class) /* trumps deadline */
- return -2;
-
- if (rt_prio(p->prio)) /* includes deadline */
- return p->prio; /* [-1, 99] */
-
- if (p->sched_class == &idle_sched_class)
- return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
-
- return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
-}
-
 /*
  * l(a,b)
  * le(a,b) := !l(b,a)
@@ -176,22 +161,17 @@ static inline int __task_prio(struct task_struct *p)
 /* real prio, less is less */
 static inline bool prio_less(struct task_struct *a, struct
task_struct *b, bool in_fi)
 {
-
- int pa = __task_prio(a), pb = __task_prio(b);
-
- if (-pa < -pb)
- return true;
-
- if (-pb < -pa)
- return false;
-
- if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
- return !dl_time_before(a->dl.deadline, b->dl.deadline);
-
- if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
- return cfs_prio_less(a, b, in_fi);
-
- return false;
+        int less = a->sched_class - b->sched_class;
+        if (less == 0) {
+                if (a->sched_class == &dl_sched_class)
+                        return !dl_time_before(a->dl.deadline, b->dl.deadline);
+
+                else if (a->sched_class == &fair_sched_class)
+                        return cfs_prio_less(a, b, in_fi);
+                else
+                        return false;
+        } else
+                return (less > 0) ? true : false;
 }

 static inline bool __sched_core_less(struct task_struct *a, struct
task_struct *b)
-- 
2.17.1
