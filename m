Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0888960F09C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiJ0Gvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiJ0Gve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:51:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23791E09A8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:51:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bn35so968708ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AKYXXgBtAydXKdFAzRel9mfErgV/uy4WQAoKwXLGOHc=;
        b=bKlg0c/dYbF62yNqK0hm+t5EOgVesPJIGkY3Qx7O18rIoBulW0VHEhOfoZV2oYJ6xP
         Ma+x2PFWbm6uOwZt625XxwVTVv8eCRqKJ/oa+tcBn9Lj8Che0VL37vHeKZuoOy20n1OM
         eL9oxwQ9XNrafID19zRPwQw8CJnTTRx5PqqGYqLujwwaKLkaUK8k83pBPw9EB4U5ox9o
         FwVFeZ+bKfnRlwUMCVSWTv9MAZ4uVk8qHrJnaJ/oa08TEsNY/IQy841X4V5rXDRu8X+O
         01Y04Vprduejl6pQstOjkSBK3Z5N6ELPKKVYNjS6JvFkF586BfHqDyQOZBOKp9/jGY3b
         qjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKYXXgBtAydXKdFAzRel9mfErgV/uy4WQAoKwXLGOHc=;
        b=lIung5DmwlAjpf4jI3RxdXDbTsD519g3KoVsxnjTpB2VjorkeBXWKLHKMJjMHsk5At
         +wsgSWgw4acSSf++s3+/G/XJU2oy8W6ILoP7iqRTBmTQ+4HF2Lhw5vBHOPN7ponI6ynr
         G7sZ+4rdqanYvU+4/DtJtkTkuX066jZoc+l2e5NbV+1rpRI2JxppXEaTtomXcOfFUmmT
         9T9hbZymPNZbre6/NnWqMxLZ9idWsNoib3HB95IdSgGws1IMrVfjfX2LgzmBH5fjSE0i
         X2DT4KbTvNqSrFpoCF41/TOWdRl3R/Yr/ZWRqv5JCeVTKYH23a4h8AfCGjLW46Vvj5hr
         5+Eg==
X-Gm-Message-State: ACrzQf0rUofClhlNJCsFf/phVMFXZln295H3Ydj9LCju/lh5GcGL0Zwm
        ihnX55IiwsaoLY2OTWKSh9O783Cz5OzkPYLbVpg=
X-Google-Smtp-Source: AMsMyM7C6SI30ZYBzIRN4ADrmB3rycvE7rEZLoM6b6GVnxwb1ijrGefU9G8kcFU4o8+P0Tihl5guM5BBx43Qr/f7O3k=
X-Received: by 2002:a05:651c:2121:b0:26f:c9dc:bb06 with SMTP id
 a33-20020a05651c212100b0026fc9dcbb06mr17171569ljq.385.1666853490950; Wed, 26
 Oct 2022 23:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221020011048.156415-1-avagin@gmail.com> <20221020011048.156415-4-avagin@gmail.com>
 <Y1FX6FmPHCsdQn9A@hirez.programming.kicks-ass.net> <Y1Hrg/sqPhuSr+PY@gmail.com>
In-Reply-To: <Y1Hrg/sqPhuSr+PY@gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 26 Oct 2022 23:51:18 -0700
Message-ID: <CANaxB-wvWc6kNWmwhXeuN+YQJ6=tVDx9BJ18tOqMUZx5GfR55Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched: add a few helpers to wake up tasks on the
 current cpu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 5:44 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> On Thu, Oct 20, 2022 at 04:15:04PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 19, 2022 at 06:10:46PM -0700, Andrei Vagin wrote:
> > > Add complete_on_current_cpu, wake_up_poll_on_current_cpu helpers to wake
> > > up processes on the current CPU.
> >
> > There is an astounding lack of *why* in this changelog.
>
> I use them in the next patch to handle seccomp user notify requests
> faster.
>
> The seccomp notify mechanism allows less privileged processes to offload
> specific syscalls to more privileged processes.  In many cases, the
> workflow is fully synchronous. It means a target process triggers a
> system call, the kernel stops it and wakes up a supervisor process that
> handles the system call and returns controls back to the target process.
> In this context, "synchronous" means that only one process is running
> and another one is waiting.
>
> New helpers advices the scheduler to move the wakee to the current CPU.
> For synchronous workflows like described above, these helpers makes
> context switches a few times faster.

Peter,

I've found that I don't understand why WF_SYNC doesn't work in this
case. The test from the last patch shows performance improvements in the
case of WF_CURRENT_CPU, but WF_SYNC doesn't make any difference. I
looked at the code and found that select_task_rq_fair calls
select_idle_sibling, but it doesn't take into account the sync flag.

Does it make sense to do something like this:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4ebe7222664c..c29f758ccfe3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7249,7 +7249,8 @@ select_task_rq_fair(struct task_struct *p, int
prev_cpu, int wake_flags)
                new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
        } else if (wake_flags & WF_TTWU) { /* XXX always ? */
                /* Fast path */
-               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+               if (!(sync && cpu == new_cpu && this_rq()->nr_running == 1))
+                       new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
        }
        rcu_read_unlock();


With this patch, the test shows the same numbers for WF_CURRENT_CPU and WF_SYNC.


Thanks,
Andrei
