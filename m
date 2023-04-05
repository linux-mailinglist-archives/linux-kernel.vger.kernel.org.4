Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8316D8507
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjDERjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDERjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:39:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445D26198
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 10:39:47 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i6so43521279ybu.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680716386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn46LGEpZ0M5stJvauaV3sIQJfEZiQ2d5fn4bU/HeCg=;
        b=N6vIgBsXL9Tc+SxUB5qdxhR2+VuiR4GBOHhlJAyH5t5+aJfqWvjAgeCaxXC0JDdqyf
         wRDoQEetY/FS++C5y8k6cInjCt+fkQ0Ej9Nox1oZBDJkTdCexhA3Wyqa48vYNuW5bDn6
         LDhVYDVrtuNATgraPVVuzYMM8jNlqUVS6HJoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680716386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn46LGEpZ0M5stJvauaV3sIQJfEZiQ2d5fn4bU/HeCg=;
        b=5GpVDD5iBF3eV0RpJqcZQ+XMna3r9D6NeWqo1JEVhkU9qUfyDSmi+poV0xLe8eq4Fm
         7gQXUcTkKpF/IDI6KH/OcSp/+oTq994juF88TZj3wWTZm/trcTxjs1OwwKuxZhrSLuFb
         oQm/10lgQN8eEiskrceZ68o4sxKj5P7Jq5p8YXuV4ddIWY5v6OObOSUN8BvUalREf5I1
         wn+0SWZblB+8VNqwNzPLThzRGl6fwwLYxZ7A6yIZuVR2Ny4bBuLAc6iRNty0IIFt/zow
         SaamvlULsJOjB9ro0ggt7jCsXRLHG8xmKw01iDXeP9KNIBE2fd3ZZzttH9U3L//vp1YT
         44ig==
X-Gm-Message-State: AAQBX9ehlByx2ucQLWCRcWY/TYcQYzBpy0urMOSP9M4bTptwphNSuk0h
        ZE8gQIUn9Sdbvw//TNhQZXlop1rNRZWvlNj1GK8/Og==
X-Google-Smtp-Source: AKy350YrxrbAQS47RhEOI1F17SciZMZl03bjJJAdLmUum16T7qBukaaAt9HUe8MxrtuIQLogywUBCx8MUh7dFXE8RXM=
X-Received: by 2002:a25:7605:0:b0:b69:fab9:de39 with SMTP id
 r5-20020a257605000000b00b69fab9de39mr56463ybc.2.1680716386295; Wed, 05 Apr
 2023 10:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
In-Reply-To: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 5 Apr 2023 13:39:35 -0400
Message-ID: <CAEXW_YR5MZhHuDsMVEB8A=80k3sjecp-yTXNLv6XCaq9h2JH2A@mail.gmail.com>
Subject: Re: [PATCH V2] rcu: Make sure new krcp free business is handled after
 the wanted rcu grace period.
To:     Ziwei Dai <ziwei.dai@unisoc.com>
Cc:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuang.wang@unisoc.com,
        yifan.xin@unisoc.com, ke.wang@unisoc.com, xuewen.yan@unisoc.com,
        zhiguo.niu@unisoc.com, zhaoyang.huang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 8:43=E2=80=AFAM Ziwei Dai <ziwei.dai@unisoc.com> wr=
ote:
>
> In kfree_rcu_monitor(), new free business at krcp is attached to any free
> channel at krwp. kfree_rcu_monitor() is responsible to make sure new free
> business is handled after the rcu grace period. But if there is any none-=
free
> channel at krwp already, that means there is an on-going rcu work,
> which will cause the kvfree_call_rcu()-triggered free business is done
> before the wanted rcu grace period ends.
>
> This commit ignore krwp which has non-free channel at kfree_rcu_monitor()=
,
> to fix the issue that kvfree_call_rcu() loses effectiveness.
>
> Below is the css_set obj "from_cset" use-after-free case caused by
> kvfree_call_rcu() losing effectiveness.
> CPU 0 calls rcu_read_lock(), then use "from_cset", then hard irq comes,
> the task is schedule out.
> CPU 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" after =
new gp.
> But "from_cset" is freed right after current gp end. "from_cset" is reall=
ocated.
> CPU 0 's task arrives back, references "from_cset"'s member, which causes=
 crash.
>
> CPU 0                                   CPU 1
> count_memcg_event_mm()
> |rcu_read_lock()  <---
> |mem_cgroup_from_task()
>  |// css_set_ptr is the "from_cset" mentioned on CPU 1
>  |css_set_ptr =3D rcu_dereference((task)->cgroups)
>  |// Hard irq comes, current task is scheduled out.
>
>                                         cgroup_attach_task()
>                                         |cgroup_migrate()
>                                         |cgroup_migrate_execute()
>                                         |css_set_move_task(task, from_cse=
t, to_cset, true)
>                                         |cgroup_move_task(task, to_cset)
>                                         |rcu_assign_pointer(.., to_cset)
>                                         |...
>                                         |cgroup_migrate_finish()
>                                         |put_css_set_locked(from_cset)
>                                         |from_cset->refcount return 0
>                                         |kfree_rcu(cset, rcu_head) // mea=
ns to free from_cset after new gp
>                                         |add_ptr_to_bulk_krc_lock()
>                                         |schedule_delayed_work(&krcp->mon=
itor_work, ..)
>
>                                         kfree_rcu_monitor()
>                                         |krcp->bulk_head[0]'s work attach=
ed to krwp->bulk_head_free[]
>                                         |queue_rcu_work(system_wq, &krwp-=
>rcu_work)
>                                         |if rwork->rcu.work is not in WOR=
K_STRUCT_PENDING_BIT state,
>                                         |call_rcu(&rwork->rcu, rcu_work_r=
cufn) <--- request a new gp
>
>                                         // There is a perious call_rcu(..=
, rcu_work_rcufn)
>                                         // gp end, rcu_work_rcufn() is ca=
lled.
>                                         rcu_work_rcufn()
>                                         |__queue_work(.., rwork->wq, &rwo=
rk->work);
>
>                                         |kfree_rcu_work()
>                                         |krwp->bulk_head_free[0] bulk is =
freed before new gp end!!!
>                                         |The "from_cset" is freed before =
new gp end.
>
> // the task is scheduled in after many ms.
>  |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because css_s=
et_ptr is freed.
>
> v2: Use helper function instead of inserted code block at kfree_rcu_monit=
or().
>
> Fixes: c014efeef76a ("rcu: Add multiple in-flight batches of kfree_rcu() =
work")
> Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>

Please update the fixes tag to:
5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs")

The issue happened when 5f3c8d620447 started looking at multiple
channels at the same time in the same work handler function.

I think a better fix might be to separate out the work handler
functions for each channel separately. That way we get more
parallelism.

but since this is urgent,
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel



> ---
>  kernel/rcu/tree.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8e880c0..7b95ee9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3024,6 +3024,18 @@ static void kfree_rcu_work(struct work_struct *wor=
k)
>         return !!READ_ONCE(krcp->head);
>  }
>
> +static bool
> +need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < FREE_N_CHANNELS; i++)
> +               if (!list_empty(&krwp->bulk_head_free[i]))
> +                       return true;
> +
> +       return !!krwp->head_free;
> +}
> +
>  static int krc_count(struct kfree_rcu_cpu *krcp)
>  {
>         int sum =3D atomic_read(&krcp->head_count);
> @@ -3107,15 +3119,14 @@ static void kfree_rcu_monitor(struct work_struct =
*work)
>         for (i =3D 0; i < KFREE_N_BATCHES; i++) {
>                 struct kfree_rcu_cpu_work *krwp =3D &(krcp->krw_arr[i]);
>
> -               // Try to detach bulk_head or head and attach it over any
> -               // available corresponding free channel. It can be that
> -               // a previous RCU batch is in progress, it means that
> -               // immediately to queue another one is not possible so
> -               // in that case the monitor work is rearmed.
> -               if ((!list_empty(&krcp->bulk_head[0]) && list_empty(&krwp=
->bulk_head_free[0])) ||
> -                       (!list_empty(&krcp->bulk_head[1]) && list_empty(&=
krwp->bulk_head_free[1])) ||
> -                               (READ_ONCE(krcp->head) && !krwp->head_fre=
e)) {
> +               // Try to detach bulk_head or head and attach it, only wh=
en
> +               // all channels are free.  Any channel is not free means =
at krwp
> +               // there is on-going rcu work to handle krwp's free busin=
ess.
> +               if (need_wait_for_krwp_work(krwp))
> +                       continue;
>
> +               // kvfree_rcu_drain_ready() might handle this krcp, if so=
 give up.
> +               if (need_offload_krc(krcp)) {
>                         // Channel 1 corresponds to the SLAB-pointer bulk=
 path.
>                         // Channel 2 corresponds to vmalloc-pointer bulk =
path.
>                         for (j =3D 0; j < FREE_N_CHANNELS; j++) {
> --
> 1.9.1
>
