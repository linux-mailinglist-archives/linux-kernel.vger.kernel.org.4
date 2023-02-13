Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817D0693BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBMBLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMBLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:11:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273B54C17
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:11:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p26so28183507ejx.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IakcplcyOMI6hcsTU0uVigj1wRCTVwjpSFZg+1qq3Ls=;
        b=E3I1FlWDirT3zSdL+WrzsgzrqX9WnGjCQ/wzr4AK2qor0yzOKCXFCVEYWDF6XU/wtj
         9IxkXw0i8v6b0BnpoXxIu1g/1gT3+wd4EPUyXVA1rp+/xVNPVif9ULxQFAEOurZbgyO3
         8z7gznw7b9qPWm77xuTg/nTPtVXU1g7zZUkNup6ReQTE3H4rZLECA8Pdh9wQgQ0KmISk
         EbxuEihKTI0994DX1amNpf41dxw97ynye6ppjEXGT7cMpfiSWAT2bTHxzx3fqK7CiCVh
         YX1QzU+J5tzFS1kCudIoD8KlOFNeiqoNT2YKj8W3Fu0yG5wR9M6iqsUwJg48EpM8lqhe
         Spuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IakcplcyOMI6hcsTU0uVigj1wRCTVwjpSFZg+1qq3Ls=;
        b=qeM0Ub/aA4imF7XJ3L1IuAbVD9rDBwfa8trsBigR78XDYWQfSs+mj4id5egjOoAUQC
         UcjqWq8rUVv6OUh1K/eDahtr0/HEWid/cneiWpIculfAifTfw6wg5iB7FEvAhSzQk1nQ
         clI+xvArtEdZkwU2U83ApKEbAbNvNfa3OpkefYMLKAQrnTrLun2BDWYZkfnQWu9ixlY1
         1ituHriAZwrMluc5E/65XXVpWClvX/N15DsSzx8zxAkMdxqu3TzTBMXcywQ2ApmDtY1Z
         lRtRF2jZMRf2uhgWus8Uk1QBfZhu8L2lTIdhLyEm/snXefhH8m3qxlkWssY4bE0X5RBS
         VA/Q==
X-Gm-Message-State: AO0yUKVHlTDrgE2O+lmvkQ5u5N3yCJ8R7f0M59Eyr9MCEDtOVCO4p2yK
        RVQ+qhdq3CCJl8l1hYHuFGAk9B5qhqgEOUDxezP9PV2mquE=
X-Google-Smtp-Source: AK7set/GTFEpy2wI+sXZOUkTJ4Mr939C3qJ6cgrM1hihpa1WOiDuI2JX9j5htyj2h6TPlMVfKXq/AxEXfN46wFTBRJ8=
X-Received: by 2002:a17:906:1e0e:b0:87a:56fc:9df1 with SMTP id
 g14-20020a1709061e0e00b0087a56fc9df1mr3693853ejj.3.1676250677668; Sun, 12 Feb
 2023 17:11:17 -0800 (PST)
MIME-Version: 1.0
From:   JaeJoon Jung <rgbi3307@gmail.com>
Date:   Mon, 13 Feb 2023 10:11:04 +0900
Message-ID: <CAHOvCC5Tde6aTtcAeHig1eoAp_9FZGTd4XtFGbmrhy-NoV7zDA@mail.gmail.com>
Subject: [kernel/sched/core.c] Review and Modified of the prio_less() about
 sched class priority.
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
Therefore, in the prio_less() function in kernel/sched/core.c,
the less value can be determined by pointer operation as follows.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f730b6fe94a7..7a64ac8ea3d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -151,21 +151,6 @@ __read_mostly int scheduler_running;

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
@@ -176,22 +161,18 @@ static inline int __task_prio(struct task_struct *p)
 /* real prio, less is less */
 static inline bool prio_less(struct task_struct *a, struct
task_struct *b, bool in_fi)
 {
+        int less = a->sched_class - b->sched_class;

-       int pa = __task_prio(a), pb = __task_prio(b);
+        if (less == 0) {
+                if (a->sched_class == &dl_sched_class)
+                        return !dl_time_before(a->dl.deadline, b->dl.deadline);

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
+                else if (a->sched_class == &fair_sched_class)
+                        return cfs_prio_less(a, b, in_fi);
+                else
+                        return false;
+        } else
+                return (less > 0) ? true : false;
 }

If the prio_less() function is modified as above, the __task_prio()
function is not required.
Please review.
Thanks,
From JaeJoon Jung.
