Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263E66B16C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCHXuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCHXuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:50:01 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA339270D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:49:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so4205013pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678319398;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZg/gAI2YkU9FD4CSdeeX0b3kn41MdaxrRtQfcjPVIE=;
        b=ruoBIGTNhtTkPNcy92eXsRhDULtoR/At/DDjHPc7VWFFGPSeNKoAnitkEhyRheprBX
         Wp966bgDWAZxYDRC3XRCFNlTHrDX/mNWKCNb5RcUfvWSzdNCoPVPs/OFYkYe8S2Vta0Z
         3nKQsKK6NvvMihtonmrQFMF5vNRuIaaONMc6PG098Da7ifle+V2IdBQDfUxvl4nNjo/Z
         c+9D0GA2wi95nZhN3a/uaNUxQW6+UpsV1dd3uX5UY4ZCCh5b0NMhwq5mnYYKekDRjY2f
         +zDEpgK1tkZjWicZmnngm3N72XHXGCVImJRaCPRehUEg+RiTyp2sEENprabJlfObey9U
         G1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678319398;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZg/gAI2YkU9FD4CSdeeX0b3kn41MdaxrRtQfcjPVIE=;
        b=r2YpkzvrEtiQzaDzt2Pgt3wR2X9yqs5CegME6ki3Q+PKVWWSalFC/KoynbkuY3A9h8
         +Br7PU4ghNLG9/DWcwCWSkVtXZia3b1cnA1nE4hylsFAnQ+ovdlLlJFT9pLg6UrZgAE6
         kXukDQIXoIkrtHQCaiXxy0gR7GI2qKoTrUZZdvVLclsqokV6hDES9yJwnzZzJioHmva6
         V6mmlVLqHQLlXRKyb64EDIYoDYRup6zKzEP3kBRzmucwu7KdjqbzIB61Hb9oLOti6YGp
         uSxNItE4pVKBWH5W9IpDpMea2Y8sttxTQBr0hEDibZ6uayn+dUBb05VfunnZYb8n/Zkt
         Z9NA==
X-Gm-Message-State: AO0yUKVjOlbq37p/8ZTiqHg2oOExCC55oMasreHiPcN5Cc7sE9kZDhYr
        KDbAJjWw96lrUr+aZbsr8eTCUG7po0NoQ5zZKIwbjnTouRTFQUtLYsltDuG9
X-Received: by 2002:a17:90a:5d89:b0:230:8d09:962b with SMTP id
 t9-20020a17090a5d8900b002308d09962bmt9732352pji.7.1678319398182; Wed, 08 Mar
 2023 15:49:58 -0800 (PST)
MIME-Version: 1.0
References: <20230308234332.3355689-1-eranian@google.com>
In-Reply-To: <20230308234332.3355689-1-eranian@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Mar 2023 15:49:46 -0800
Message-ID: <CAKwvOd=aJvQEAovKuhB4aGhQiaBYpBj1_WH8Opp-mAiDWNUFsA@mail.gmail.com>
Subject: Re: [PATCH V2] x86/resctrl: robustify __resctrl_sched_in
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, morbo@google.com, jakub@redhat.com,
        james.morse@arm.com, babu.moger@amd.com, ananth.narayan@amd.com,
        vschneid@redhat.com, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just in case the Cc list differs from the original thread, Linus merged:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D7fef099702527c3b2c5234a2ea6a24411485a13a
(So nothing to see here). EOM

On Wed, Mar 8, 2023 at 3:44=E2=80=AFPM Stephane Eranian <eranian@google.com=
> wrote:
>
> When compiling the kernel with clang, there is a problem with the code
> in __rescrtl_sched_in() because of the way the inline function is optimiz=
ed
> when called from __switch_to(). The effect of the problem is that the
> bandwidth restriction driven by the CLOSID is not enforced. The problem i=
s
> easy to reproduce on Intel or AMD x86 systems:
>
> 1. If resctrl filesystem is not mounted:
>   $ mount -t resctrl none /sys/fs/resctrl
>
> 2. Create resctrl group:
>   $ mkdir /sys/fs/resctrl/test
>
> 3. move shell into resctrl group
>   $ echo $$ > /sys/fs/resctrl/test/tasks
>
> 4. Run bandwidth consuming test in background on CPU0
>   $ taskset -c 0 triad &
>
> 5. Monitor bandwidth consumption
>    Using perf to measure bandwidth on your processor
>
> 6. Restrict bandwidth
>   - Intel: $ echo MB:0=3D10 > /sys/fs/resctrl/test/schemata
>   - AMD: $ echo MB:0=3D240 > /sys/fs/resctrl/tests/schemata
>
>  7. Monitor bandwidth again
>
> At 7, you will see that the restriction is not enforced.
>
> The problem is located in the __resctrl_sched_in() routine which rewrites
> the active closid via the PQR_ASSOC register. Because this is an expensiv=
e
> operation, the kernel only does it when the context switch involves tasks
> with different CLOSIDs. And to check that, it needs to access the task be=
ing
> scheduled in. And for that it is using the current task pointer to access
> the task's closid field using current->closid. current is actually a macr=
o
> that reads the per-cpu variable pcpu_hot.current_task.
>
> After an investigation by compiler experts, the problem has been tracked =
down
> to the usage of the get_current() macro in the __resctrl_sched_in() code =
and
> in particular the per-cpu macro:
>
> static __always_inline struct task_struct *get_current(void)
> {
>         return this_cpu_read_stable(pcpu_hot.current_task);
> }
>
> And as per percpu.h:
>
> /*
>  * this_cpu_read() makes gcc load the percpu variable every time it is
>  * accessed while this_cpu_read_stable() allows the value to be cached.
>  * this_cpu_read_stable() is more efficient and can be used if its value
>  * is guaranteed to be valid across cpus.  The current users include
>  * get_current() and get_thread_info() both of which are actually
>  * per-thread variables implemented as per-cpu variables and thus
>  * stable for the duration of the respective task.
>  */
>
> The _stable version of the macro allows the value to be cached, i.e.,
> not forcing a reload.
>
> However in the __switch_to() routine, the current pointer is changed.  If=
 the
> compiler optimizes away the reload, then the resctrl_sched_in will look
> at the previous task instead of the new current task. This explains why w=
e
> are not seeing the bandwidth limit enforced on the benchmark.
>
> Note that the problem was detected when compiling the kernel with clang (=
v14)
> but it could also happen with gcc.
>
> To fix the problem, there are a few solutions.
>
> In V1, we modified the resctrl_sched_in() function to use the this_cpu_re=
ad()
> form of the macro. Given this is specific to the __switch_to routine, we =
do
> not change get_current() but instead invoke the lower level macro directl=
y
> from __resched_sched_in(). This has no impact on any other calls of
> get_current().
>
> In V2, after further discussions with kernel maintainers and LLVM develop=
ers,
> the conclusion that it was the problem is caused by the compiler but that=
 the
> function is not written in a proper manner and that the compiler is just
> exposing the problem. So it is best to change the __resctrl_sched_in()
> function to:
>   (1) be a proper static inline function
>   (2) pass the task pointer of the task scheduled in instead of retrievin=
g
>       it from the current pointer. It makes more sense and follows other
>       sched_in type functions. If you are scheduling something in, then y=
ou
>       need to name what it is, you should not rely on the current pointer=
.
>       This solution was proposed by Linus.
>
> Patch was tested on AMD Zen3 + MBA and I verified that the bandwidth limi=
t
> was now enforced.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Tested-by: Stephane Eranian <eranian@google.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/resctrl.h         | 12 ++++++------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
>  arch/x86/kernel/process_32.c           |  2 +-
>  arch/x86/kernel/process_64.c           |  2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index 52788f79786f..255a78d9d906 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -49,7 +49,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   *   simple as possible.
>   * Must be called with preemption disabled.
>   */
> -static void __resctrl_sched_in(void)
> +static inline void __resctrl_sched_in(struct task_struct *tsk)
>  {
>         struct resctrl_pqr_state *state =3D this_cpu_ptr(&pqr_state);
>         u32 closid =3D state->default_closid;
> @@ -61,13 +61,13 @@ static void __resctrl_sched_in(void)
>          * Else use the closid/rmid assigned to this cpu.
>          */
>         if (static_branch_likely(&rdt_alloc_enable_key)) {
> -               tmp =3D READ_ONCE(current->closid);
> +               tmp =3D READ_ONCE(tsk->closid);
>                 if (tmp)
>                         closid =3D tmp;
>         }
>
>         if (static_branch_likely(&rdt_mon_enable_key)) {
> -               tmp =3D READ_ONCE(current->rmid);
> +               tmp =3D READ_ONCE(tsk->rmid);
>                 if (tmp)
>                         rmid =3D tmp;
>         }
> @@ -88,17 +88,17 @@ static inline unsigned int resctrl_arch_round_mon_val=
(unsigned int val)
>         return val * scale;
>  }
>
> -static inline void resctrl_sched_in(void)
> +static inline void resctrl_sched_in(struct task_struct *tsk)
>  {
>         if (static_branch_likely(&rdt_enable_key))
> -               __resctrl_sched_in();
> +               __resctrl_sched_in(tsk);
>  }
>
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>
>  #else
>
> -static inline void resctrl_sched_in(void) {}
> +static inline void resctrl_sched_in(struct task_struct *tsk) {}
>  static inline void resctrl_cpu_detect(struct cpuinfo_x86 *c) {}
>
>  #endif /* CONFIG_X86_CPU_RESCTRL */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl/rdtgroup.c
> index e2c1599d1b37..884b6e9a7e31 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -314,7 +314,7 @@ static void update_cpu_closid_rmid(void *info)
>          * executing task might have its own closid selected. Just reuse
>          * the context switch code.
>          */
> -       resctrl_sched_in();
> +       resctrl_sched_in(current);
>  }
>
>  /*
> @@ -530,7 +530,7 @@ static void _update_task_closid_rmid(void *task)
>          * Otherwise, the MSR is updated when the task is scheduled in.
>          */
>         if (task =3D=3D current)
> -               resctrl_sched_in();
> +               resctrl_sched_in(task);
>  }
>
>  static void update_task_closid_rmid(struct task_struct *t)
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 470c128759ea..708c87b88cc1 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -212,7 +212,7 @@ __switch_to(struct task_struct *prev_p, struct task_s=
truct *next_p)
>         switch_fpu_finish();
>
>         /* Load the Intel cache allocation PQR MSR. */
> -       resctrl_sched_in();
> +       resctrl_sched_in(next_p);
>
>         return prev_p;
>  }
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 4e34b3b68ebd..bb65a68b4b49 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -656,7 +656,7 @@ __switch_to(struct task_struct *prev_p, struct task_s=
truct *next_p)
>         }
>
>         /* Load the Intel cache allocation PQR MSR. */
> -       resctrl_sched_in();
> +       resctrl_sched_in(next_p);
>
>         return prev_p;
>  }
> --



--=20
Thanks,
~Nick Desaulniers
