Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C9C5F7C41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJGRba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:31:27 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB6BB56F5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:31:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w28so1239873qtv.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OWYwxtvKl4ZT2plplWA9ejpOjEq7eGzyWpaeGqDVko=;
        b=YbMiOiBm3IJaL72OnTcgqay468O68ShBwjRgFqlDFf10/uoPth6IWZ9jMywmq1u4XT
         s7m/YjvhunvVRwjL0OG0/3VL+LQq6rxvMcLV/I2luy+oENrTBb7m60sPrvZ6RHT+SDZT
         1kUijBUH/E4Uthdj4vvC0xgpwHlKL//0e8S1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OWYwxtvKl4ZT2plplWA9ejpOjEq7eGzyWpaeGqDVko=;
        b=KKIbkbTcywVT3UpB8NZXUgHlO9Pt2l/h/7CFrNuBbTTEtGPlE6yuUWhtGQ5NjXXZcn
         ERoiWxvAKI0y6H5xm+wnJs8ZMyAiGXpPFTdvEto6wUHDiwKXfNWKZK7aMVHkUYLepUaQ
         imnOQzSXKg2BIzyuzprpteSZmdmMtlyToXUoh3TBKnkYZxV/Jbg6rH4orbxylt0Th02Z
         eqtBotUrlVW4ZJvGeaoDuzMpIxpaRq3qThYFFw667day83EVGxddnTFtSUZH5nU+40tQ
         DMlcyPZgEfKkXLFcaLw2XIncV24wZRtR6pPVMbcMGJM8l5o6H2bC1V/j/LOLHIOd6fnk
         lojQ==
X-Gm-Message-State: ACrzQf3nHFTKoi8rDlSo6ZNM0KWspSUu0fcJBZgvfgLT6o6fFpLY1or9
        GYesGfVC7xPE2UMbrH1JYuc+mQ==
X-Google-Smtp-Source: AMsMyM61d+LiX2Lq2FQXKSSZ7ktusiUXhDYGfdX0m/g9eQd5iDHVr+O1FGmtT0NJsm+8GZQ/loBDPg==
X-Received: by 2002:a05:622a:1055:b0:393:831d:bb45 with SMTP id f21-20020a05622a105500b00393831dbb45mr4987305qte.197.1665163884917;
        Fri, 07 Oct 2022 10:31:24 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a0ec500b006b953a7929csm2365186qkm.73.2022.10.07.10.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 10:31:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 10/11] scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
Date:   Fri, 7 Oct 2022 13:31:23 -0400
Message-Id: <00F8CD19-98E7-4CEB-AC8E-4E86642E91A7@joelfernandes.org>
References: <Y0BfvzpF1DE10nOg@google.com>
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
In-Reply-To: <Y0BfvzpF1DE10nOg@google.com>
To:     rcu@vger.kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 7, 2022, at 1:19 PM, Joel Fernandes <joel@joelfernandes.org> wrote:=

>=20
> =EF=BB=BFOn Fri, Oct 07, 2022 at 03:18:26AM +0000, Joel Fernandes wrote:
>>> On Tue, Oct 04, 2022 at 02:41:56AM +0000, Joel Fernandes (Google) wrote:=

>>> From: Uladzislau Rezki <urezki@gmail.com>
>>>=20
>>> Slow boot time is seen on KVM running typical Linux distributions due to=

>>> SCSI layer calling call_rcu(). Recent changes to save power may be
>>> causing this slowness. Using call_rcu_flush() fixes the issue and brings=

>>> the boot time back to what it originally was. Convert it.
>>>=20
>>> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>=20
>> And I successfully setup Debian on KVM and verified that this fixes it, s=
o
>> now I have a nice reproducible rig for my
>> 'lazy-callback-doing-a-wakeup-detector' (I wrote half the detector thanks=
 to
>> ideas from Steve, and will finish the other half tomorrow or so).
>>=20
>> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>=20
> Looks like I can catch Vlad's issue with the below patch. Thoughts? Does t=
his
> look reasonable for mainline? (I think so as it is self-contained and the
> debug option is default off, and could be useful down the line).
>=20
> [    6.887033 ] rcu: *****************************************************=

> [    6.891242 ] rcu: RCU: A wake up has been detected from a lazy callback=
!
> [    6.895377 ] rcu: The callback name is: scsi_eh_inc_host_failed
> [    6.899084 ] rcu: The task it woke up is: scsi_eh_1 (61)
> [    6.902405 ] rcu: This could cause performance issues! Check the stack.=

> [    6.906532 ] rcu: *****************************************************=

>=20
>=20
> [   17.127128 ] rcu: *****************************************************=

> [   17.131397 ] rcu: RCU: A wake up has been detected from a lazy callback=
!
> [   17.135703 ] rcu: The callback name is: scsi_eh_inc_host_failed
> [   17.139485 ] rcu: The task it woke up is: scsi_eh_1 (61)
> [   17.142828 ] rcu: This could cause performance issues! Check the stack.=

> [   17.146962 ] rcu: *****************************************************=

>=20
> And thanks to Steve for the binary search code.
>=20
> One thing I found is I have to ignore kworkers because there are times whe=
n a
> work item is queued from a callback and those callbacks don't seem to
> contribute to performance issues. So I am filtering these:
>=20
> [   38.631724 ] rcu: The callback name is: thread_stack_free_rcu
> [   38.635317 ] rcu: The task it woke up is: kworker/3:2 (143)
>=20
> [   39.649332 ] rcu: The callback name is: delayed_put_task_struct
> [   39.653037 ] rcu: The task it woke up is: kworker/0:1 (40)
>=20
> ---8<-----------------------
>=20
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] lazy wake debug
>=20
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> kernel/rcu/Kconfig      |   7 ++
> kernel/rcu/lazy-debug.h | 149 ++++++++++++++++++++++++++++++++++++++++
> kernel/rcu/tree.c       |   9 +++
> 3 files changed, 165 insertions(+)
> create mode 100644 kernel/rcu/lazy-debug.h
>=20
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index edd632e68497..08c06f739187 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -322,4 +322,11 @@ config RCU_LAZY
>      To save power, batch RCU callbacks and flush after delay, memory
>      pressure or callback list growing too big.
>=20
> +config RCU_LAZY_DEBUG
> +    bool "RCU callback lazy invocation debugging"
> +    depends on RCU_LAZY
> +    default n
> +    help
> +      Debugging to catch issues caused by delayed RCU callbacks.
> +
> endmenu # "RCU Subsystem"
> diff --git a/kernel/rcu/lazy-debug.h b/kernel/rcu/lazy-debug.h
> new file mode 100644
> index 000000000000..fc1cc1cb89f0
> --- /dev/null
> +++ b/kernel/rcu/lazy-debug.h
> @@ -0,0 +1,149 @@
> +#include <linux/string.h>
> +#include <linux/spinlock.h>
> +
> +#ifdef CONFIG_RCU_LAZY_DEBUG
> +#include <linux/preempt.h>
> +#include <trace/events/sched.h>
> +
> +static DEFINE_PER_CPU(bool, rcu_lazy_cb_exec) =3D false;
> +static DEFINE_PER_CPU(void *, rcu_lazy_ip) =3D NULL;
> +
> +static DEFINE_RAW_SPINLOCK(lazy_funcs_lock);
> +
> +#define FUNC_SIZE 1024

And I know this array can overflow in the future so I will add checks for th=
at in the code if we are going with this patch.

 - Joel=20


> +static unsigned long lazy_funcs[FUNC_SIZE];
> +static int nr_funcs;
> +
> +static void __find_func(unsigned long ip, int *B, int *E, int *N)
> +{
> +    unsigned long *p;
> +    int b, e, n;
> +
> +    b =3D n =3D 0;
> +    e =3D nr_funcs - 1;
> +
> +    while (b <=3D e) {
> +        n =3D (b + e) / 2;
> +        p =3D &lazy_funcs[n];
> +        if (ip > *p) {
> +            b =3D n + 1;
> +        } else if (ip < *p) {
> +            e =3D n - 1;
> +        } else
> +            break;
> +    }
> +
> +    *B =3D b;
> +    *E =3D e;
> +    *N =3D n;
> +
> +    return;
> +}
> +
> +static bool lazy_func_exists(void* ip_ptr)
> +{
> +    int b, e, n;
> +    unsigned long flags;
> +    unsigned long ip =3D (unsigned long)ip_ptr;
> +
> +    raw_spin_lock_irqsave(&lazy_funcs_lock, flags);
> +    __find_func(ip, &b, &e, &n);
> +    raw_spin_unlock_irqrestore(&lazy_funcs_lock, flags);
> +
> +    return b <=3D e;
> +}
> +
> +static int lazy_func_add(void* ip_ptr)
> +{
> +    int b, e, n;
> +    unsigned long flags;
> +    unsigned long ip =3D (unsigned long)ip_ptr;
> +
> +    raw_spin_lock_irqsave(&lazy_funcs_lock, flags);
> +    if (nr_funcs >=3D FUNC_SIZE) {
> +        raw_spin_unlock_irqrestore(&lazy_funcs_lock, flags);
> +        return -1;
> +    }
> +
> +    __find_func(ip, &b, &e, &n);
> +
> +    if (b > e) {
> +        if (n !=3D nr_funcs)
> +            memmove(&lazy_funcs[n+1], &lazy_funcs[n],
> +                (sizeof(*lazy_funcs) * (nr_funcs - n)));
> +
> +        lazy_funcs[n] =3D ip;
> +        nr_funcs++;
> +    }
> +
> +    raw_spin_unlock_irqrestore(&lazy_funcs_lock, flags);
> +    return 0;
> +}
> +
> +static void rcu_set_lazy_context(void *ip_ptr)
> +{
> +    bool *flag =3D this_cpu_ptr(&rcu_lazy_cb_exec);
> +    *flag =3D lazy_func_exists(ip_ptr);
> +
> +    if (*flag) {
> +        *this_cpu_ptr(&rcu_lazy_ip) =3D ip_ptr;
> +    } else {
> +        *this_cpu_ptr(&rcu_lazy_ip) =3D NULL;
> +    }
> +}
> +
> +static void rcu_reset_lazy_context(void)
> +{
> +    bool *flag =3D this_cpu_ptr(&rcu_lazy_cb_exec);
> +    *flag =3D false;
> +}
> +
> +static bool rcu_is_lazy_context(void)
> +{
> +    return *(this_cpu_ptr(&rcu_lazy_cb_exec));
> +}
> +
> +static void
> +probe_waking(void *ignore, struct task_struct *p)
> +{
> +    if (WARN_ON(!in_nmi() && !in_hardirq() && rcu_is_lazy_context())) {
> +        pr_err("*****************************************************\n")=
;
> +        pr_err("RCU: A wake up has been detected from a lazy callback!\n"=
);
> +        pr_err("The callback name is: %ps\n", *this_cpu_ptr(&rcu_lazy_ip)=
);
> +        pr_err("The task it woke up is: %s (%d)\n", p->comm, p->pid);
> +        pr_err("This could cause performance issues! Check the stack.\n")=
;
> +        pr_err("*****************************************************\n")=
;
> +    }
> +}
> +
> +static void rcu_lazy_debug_init(void)
> +{
> +    int ret;
> +    pr_info("RCU Lazy CB debugging is turned on, system may be slow.\n");=

> +
> +    ret =3D register_trace_sched_waking(probe_waking, NULL);
> +    if (ret)
> +        pr_info("RCU: Lazy debug ched_waking probe could not be registere=
d.");
> +}
> +
> +#else
> +
> +static int lazy_func_add(void* ip_ptr)
> +{
> +    return -1;
> +}
> +
> +
> +static void rcu_set_lazy_context(void *ip_ptr)
> +{
> +}
> +
> +static void rcu_reset_lazy_context(void)
> +{
> +}
> +
> +static void rcu_lazy_debug_init(void)
> +{
> +}
> +
> +#endif
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c20544c4aa29..ad8d4e52ae92 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -67,6 +67,7 @@
>=20
> #include "tree.h"
> #include "rcu.h"
> +#include "lazy-debug.h"
>=20
> #ifdef MODULE_PARAM_PREFIX
> #undef MODULE_PARAM_PREFIX
> @@ -2245,7 +2246,10 @@ static void rcu_do_batch(struct rcu_data *rdp)
>=20
>        f =3D rhp->func;
>        WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> +
> +        rcu_set_lazy_context(f);
>        f(rhp);
> +        rcu_reset_lazy_context();
>=20
>        rcu_lock_release(&rcu_callback_map);
>=20
> @@ -2770,6 +2774,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callba=
ck_t func, bool lazy)
>    }
>=20
>    check_cb_ovld(rdp);
> +
> +    if (lazy)
> +        lazy_func_add(func);
> +
>    if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
>        return; // Enqueued onto ->nocb_bypass, so just leave.
>    // If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.=

> @@ -4805,6 +4813,7 @@ void __init rcu_init(void)
>    rcu_early_boot_tests();
>=20
>    kfree_rcu_batch_init();
> +    rcu_lazy_debug_init();
>    rcu_bootup_announce();
>    sanitize_kthread_prio();
>    rcu_init_geometry();
> --=20
> 2.38.0.rc1.362.ged0d419d3c-goog
>=20
