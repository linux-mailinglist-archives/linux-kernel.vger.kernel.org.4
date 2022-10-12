Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775255FC89E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJLPo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJLPow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:44:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5668513F66
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:44:51 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m23so2310818lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+jzaw/1bGaoYRyRhKsF12smIIBM2FZP2qOkM8XhIiRI=;
        b=hPQdMj2haIPh32M8UjYJQNS7z+9PSY7xFl3mhC80yfA2AIgTWRKpEW0+JKiPNurCrA
         7wZrLy+AqBWbtgmEbJrmPBY7MWeikGg6rLMPXNJ+KiQE4e6xqyrM9U+BBVgaZTD2huEz
         Q73l5S3Wn6T3yVKZgGyPJrTKn7Py/Jz3VS+vKUTW4UmQ9e/e75RF2wTOumel+msWEivr
         SfgT0+UfzkII0B9qcPU6tMYPyECrGT+LwrF7xa+UwzMXmxnrzGg1WPCdz4Iwiy+5TZYw
         IVFFlwUiZh9+QPqemVJQm29+qnW26/NWPXB0Y3fm3vjlkRZqYaHkArbwhECJSGtoeVIM
         MWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jzaw/1bGaoYRyRhKsF12smIIBM2FZP2qOkM8XhIiRI=;
        b=ZwApzUxWdZW1fmm8Npc0zw1JAuuzNXk1CAbE/kbUxP2kA58P/uvmoa1FSsFygsfRgv
         XjReUgaAN1RhU2P17645HMG2zLDZD+y2+h2j3KfcSGfSq2gPPgmYCnYqM1mlSfAq8a+r
         +v352nYeP9z27tExjVAGT2Du/cEzrCwwJuctl6jYRlUOEPIUexMihgSUP+e7NQ6MQDHf
         6Wp+FFVDVU1CRv+Pg8EzMEDMl9aX+BpcQXf3ZXM2NF+uKhhPesRy9KDV6qUEUK1G/zQi
         7Fk/JTkcFYgw9ViVNh1O/iBQo+3dSiVg/+O6G+MCK4jwHykoOueoGz+/mkrrdkzjQyIE
         Ns2w==
X-Gm-Message-State: ACrzQf1HMAIJy2SUUL5rXCV5ue3dioEQLe4avnueH+MJROj1nDsiIdd/
        0S+MO527DT20SELpBhDCOmGaDZovcPRbqyGTOvJWpg==
X-Google-Smtp-Source: AMsMyM7/vlB0S0ja4otsjxD0zyq+Q9XoePFTLJ0bpuofFlsXGGoB2cCXRD98itGpWgOsQ900ZVKTxLaE79DZSUiRXNE=
X-Received: by 2002:a2e:bd8b:0:b0:26d:fbbe:1f9 with SMTP id
 o11-20020a2ebd8b000000b0026dfbbe01f9mr10308468ljq.266.1665589489581; Wed, 12
 Oct 2022 08:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-4-vincent.guittot@linaro.org> <4d23ef51-6bb9-0410-77cf-5fe44173eee7@amd.com>
In-Reply-To: <4d23ef51-6bb9-0410-77cf-5fe44173eee7@amd.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 12 Oct 2022 17:44:38 +0200
Message-ID: <CAKfTPtBBzGT+AK53QfZ5fHTjBUJ07Haq+vFH2uc__p=8ErYajA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 at 17:07, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> On 9/25/2022 8:09 PM, Vincent Guittot wrote:
> > From: Parth Shah <parth@linux.ibm.com>
> >
> > Introduce the latency_nice attribute to sched_attr and provide a
> > mechanism to change the value with the use of sched_setattr/sched_getattr
> > syscall.
> >
> > Also add new flag "SCHED_FLAG_LATENCY_NICE" to hint the change in
> > latency_nice of the task on every sched_setattr syscall.
> >
> > Signed-off-by: Parth Shah <parth@linux.ibm.com>
> > [rebase and add a dedicated __setscheduler_latency ]
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  include/uapi/linux/sched.h       |  4 +++-
> >  include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
> >  kernel/sched/core.c              | 24 ++++++++++++++++++++++++
> >  tools/include/uapi/linux/sched.h |  4 +++-
> >  4 files changed, 49 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > index 3bac0a8ceab2..b2e932c25be6 100644
> > --- a/include/uapi/linux/sched.h
> > +++ b/include/uapi/linux/sched.h
> > @@ -132,6 +132,7 @@ struct clone_args {
> >  #define SCHED_FLAG_KEEP_PARAMS               0x10
> >  #define SCHED_FLAG_UTIL_CLAMP_MIN    0x20
> >  #define SCHED_FLAG_UTIL_CLAMP_MAX    0x40
> > +#define SCHED_FLAG_LATENCY_NICE              0x80
>
> [1]
>
> >
> >  #define SCHED_FLAG_KEEP_ALL  (SCHED_FLAG_KEEP_POLICY | \
> >                                SCHED_FLAG_KEEP_PARAMS)
> > @@ -143,6 +144,7 @@ struct clone_args {
> >                        SCHED_FLAG_RECLAIM             | \
> >                        SCHED_FLAG_DL_OVERRUN          | \
> >                        SCHED_FLAG_KEEP_ALL            | \
> > -                      SCHED_FLAG_UTIL_CLAMP)
> > +                      SCHED_FLAG_UTIL_CLAMP          | \
> > +                      SCHED_FLAG_LATENCY_NICE)
> >
> >  #endif /* _UAPI_LINUX_SCHED_H */
> > diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
> > index f2c4589d4dbf..db1e8199e8c8 100644
> > --- a/include/uapi/linux/sched/types.h
> > +++ b/include/uapi/linux/sched/types.h
> > @@ -10,6 +10,7 @@ struct sched_param {
> >
> >  #define SCHED_ATTR_SIZE_VER0 48      /* sizeof first published struct */
> >  #define SCHED_ATTR_SIZE_VER1 56      /* add: util_{min,max} */
> > +#define SCHED_ATTR_SIZE_VER2 60      /* add: latency_nice */
> >
> >  /*
> >   * Extended scheduling parameters data structure.
> > @@ -98,6 +99,22 @@ struct sched_param {
> >   * scheduled on a CPU with no more capacity than the specified value.
> >   *
> >   * A task utilization boundary can be reset by setting the attribute to -1.
> > + *
> > + * Latency Tolerance Attributes
> > + * ===========================
> > + *
> > + * A subset of sched_attr attributes allows to specify the relative latency
> > + * requirements of a task with respect to the other tasks running/queued in the
> > + * system.
> > + *
> > + * @ sched_latency_nice      task's latency_nice value
> > + *
> > + * The latency_nice of a task can have any value in a range of
> > + * [MIN_LATENCY_NICE..MAX_LATENCY_NICE].
> > + *
> > + * A task with latency_nice with the value of LATENCY_NICE_MIN can be
> > + * taken for a task requiring a lower latency as opposed to the task with
> > + * higher latency_nice.
> >   */
> >  struct sched_attr {
> >       __u32 size;
> > @@ -120,6 +137,8 @@ struct sched_attr {
> >       __u32 sched_util_min;
> >       __u32 sched_util_max;
> >
> > +     /* latency requirement hints */
> > +     __s32 sched_latency_nice;
> >  };
> >
> >  #endif /* _UAPI_LINUX_SCHED_TYPES_H */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index ada2d05bd894..6a6116ea4c2c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7318,6 +7318,14 @@ static void __setscheduler_params(struct task_struct *p,
> >       p->rt_priority = attr->sched_priority;
> >       p->normal_prio = normal_prio(p);
> >       set_load_weight(p, true);
> > +
> > +}
> > +
> > +static void __setscheduler_latency(struct task_struct *p,
> > +             const struct sched_attr *attr)
> > +{
> > +     if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> > +             p->latency_nice = attr->sched_latency_nice;
> >  }
> >
> >  /*
> > @@ -7460,6 +7468,13 @@ static int __sched_setscheduler(struct task_struct *p,
> >                       return retval;
> >       }
> >
> > +     if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
> > +             if (attr->sched_latency_nice > MAX_LATENCY_NICE)
> > +                     return -EINVAL;
> > +             if (attr->sched_latency_nice < MIN_LATENCY_NICE)
> > +                     return -EINVAL;
> > +     }
> > +
> >       if (pi)
> >               cpuset_read_lock();
> >
> > @@ -7494,6 +7509,9 @@ static int __sched_setscheduler(struct task_struct *p,
> >                       goto change;
> >               if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> >                       goto change;
> > +             if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
> > +                 attr->sched_latency_nice != p->latency_nice)
> > +                     goto change;
> >
> >               p->sched_reset_on_fork = reset_on_fork;
> >               retval = 0;
> > @@ -7582,6 +7600,7 @@ static int __sched_setscheduler(struct task_struct *p,
> >               __setscheduler_params(p, attr);
> >               __setscheduler_prio(p, newprio);
> >       }
> > +     __setscheduler_latency(p, attr);
> >       __setscheduler_uclamp(p, attr);
> >
> >       if (queued) {
> > @@ -7792,6 +7811,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
> >           size < SCHED_ATTR_SIZE_VER1)
> >               return -EINVAL;
> >
> > +     if ((attr->sched_flags & SCHED_FLAG_LATENCY_NICE) &&
> > +         size < SCHED_ATTR_SIZE_VER2)
> > +             return -EINVAL;
> >       /*
> >        * XXX: Do we want to be lenient like existing syscalls; or do we want
> >        * to be strict and return an error on out-of-bounds values?
> > @@ -8029,6 +8051,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
> >       get_params(p, &kattr);
> >       kattr.sched_flags &= SCHED_FLAG_ALL;
> >
> > +     kattr.sched_latency_nice = p->latency_nice;
> > +
> >  #ifdef CONFIG_UCLAMP_TASK
> >       /*
> >        * This could race with another potential updater, but this is fine
> > diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
> > index 3bac0a8ceab2..ecc4884bfe4b 100644
> > --- a/tools/include/uapi/linux/sched.h
> > +++ b/tools/include/uapi/linux/sched.h
> > @@ -132,6 +132,7 @@ struct clone_args {
> >  #define SCHED_FLAG_KEEP_PARAMS               0x10
> >  #define SCHED_FLAG_UTIL_CLAMP_MIN    0x20
> >  #define SCHED_FLAG_UTIL_CLAMP_MAX    0x40
> > +#define SCHED_FLAG_LATENCY_NICE              0X80
>
> Small nit.
> Can you change the "x" in "0X80" to lower case here to make it
> consistent with [1] and other #define in the same file. When building
> tools like perf, I see the following warning:

Yes, that's a typo. It should be 0x80

>
> Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
> diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h
>
> Following is the output of
> diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h
>
> --- tools/include/uapi/linux/sched.h    2022-10-12 14:56:00.925360275 +0000
> +++ include/uapi/linux/sched.h  2022-10-12 14:56:00.917360219 +0000
> @@ -132,7 +132,7 @@
>  #define SCHED_FLAG_KEEP_PARAMS         0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN      0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX      0x40
> -#define SCHED_FLAG_LATENCY_NICE                0X80
> +#define SCHED_FLAG_LATENCY_NICE                0x80
>
>  #define SCHED_FLAG_KEEP_ALL    (SCHED_FLAG_KEEP_POLICY | \
>                                  SCHED_FLAG_KEEP_PARAMS)
> --
>
> >
> >  #define SCHED_FLAG_KEEP_ALL  (SCHED_FLAG_KEEP_POLICY | \
> >                                SCHED_FLAG_KEEP_PARAMS)
> > @@ -143,6 +144,7 @@ struct clone_args {
> >                        SCHED_FLAG_RECLAIM             | \
> >                        SCHED_FLAG_DL_OVERRUN          | \
> >                        SCHED_FLAG_KEEP_ALL            | \
> > -                      SCHED_FLAG_UTIL_CLAMP)
> > +                      SCHED_FLAG_UTIL_CLAMP          | \
> > +                      SCHED_FLAG_LATENCY_NICE)
> >
> >  #endif /* _UAPI_LINUX_SCHED_H */
>
> --
> Thanks and Regards,
> Prateek
