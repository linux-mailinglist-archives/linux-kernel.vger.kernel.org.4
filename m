Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70E6CB09A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjC0VXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjC0VX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:23:29 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC8F1BCE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:23:25 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5456249756bso194956717b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679952204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7nv1JlF+0bi75CT6B5CEJF9Of2I69hnAb+ywlUS2vU=;
        b=b4eFHlCs6CxHOjElr46aOAossg3x+FovHo/VsMuWC/u4u2Omfuw38XTLL0rUujoWuk
         P6/DuyinT6HiPjgCPmdINFD7Ms/3E9yC7PyMN0+WR5Te9gdEW3AEq3ew/wK9PSpYracz
         2WjOdNxRQIhL8ErKA49ZP0AvniBzORupKofCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7nv1JlF+0bi75CT6B5CEJF9Of2I69hnAb+ywlUS2vU=;
        b=V5KjWntKl0jp3rFwPkoitaYdplvO1M3JyUM5GZDYTgcFdug+sR33BmF8CHxs51R8sc
         +myf+M5Je0vPA2Qf6IuvxkUgugWKN0Qf4DrK9GhYa1PsbFch6QY1vO4buBwxsbyMPUJM
         nb4E/txMN+Xism2er3rBJXpxQ/igCjTnGrRrr7g4ab+GQBGymjGSEQMwNgquxngNYRW6
         e6wLyJGfGEK9UTToAF5aLlRA4lPzdrkxVPbFuyEoUWx/8uw1+LRWixB0l8cGel3If2GM
         E0gtOfbCoC3vUJhhm1bfw8aHZCC9evnY4QmInJZ4OoCWU8YxVVf4TRml6M7GYo0QXnGy
         z0Fg==
X-Gm-Message-State: AAQBX9cuXaA2E6R0PPy770cTkYvcECtQ1pyrZR85aUNCmZumqUoToh9E
        ayaoNOzq7fWak4aEtFu7kKbUZTO5u15S5vOW6U15dA==
X-Google-Smtp-Source: AKy350Zhl4C8rpt4h6oo2ciQk9rdhfwCaqjMYrNK861EXtnBYcktOlx2c4heY7MR6Jtjw81kP2OcjwtysrEZwZPyD14=
X-Received: by 2002:a81:a709:0:b0:545:4133:fc40 with SMTP id
 e9-20020a81a709000000b005454133fc40mr5924537ywh.9.1679952204361; Mon, 27 Mar
 2023 14:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230321102748.127923-1-urezki@gmail.com> <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
 <ZBnKKZsSpI8aAk9W@pc636> <PH0PR11MB58805561777B77DC69E87711DA8B9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58805561777B77DC69E87711DA8B9@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 27 Mar 2023 17:23:13 -0400
Message-ID: <CAEXW_YTRG1y3eCUDtWx_kCzHM0B24bi_qEpoBdjBunW58=b+xA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 7:21=E2=80=AFAM Zhang, Qiang1 <qiang1.zhang@intel.c=
om> wrote:
>
> > > From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Sent: Tuesday, March 21, 2023 6:28 PM
> > > [...]
> > > Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
> > >
> > > A call to a synchronize_rcu() can be expensive from time point of vie=
w.
> > > Different workloads can be affected by this especially the ones which=
 use this
> > > API in its time critical sections.
> > >
> >
> > This is interesting and meaningful research. ;-)
> >
> > > For example in case of NOCB scenario the wakeme_after_rcu() callback
> > > invocation depends on where in a nocb-list it is located. Below is an=
 example
> > > when it was the last out of ~3600 callbacks:
> >
>
>
>
> Can it be implemented separately as follows?  it seems that the code is s=
impler
> (only personal opinion)
>
> But I didn't test whether this reduce synchronize_rcu() waiting time

Isn't it broken because you are trying to implement synchronize_rcu()
on top of a different RCU implementation: tasks-RCU? Or did I miss
something?

Also, I think Vlad is trying to improve the existing synchronize_rcu()
by shortcutting the wake up of the sleeper (instead of going through
an async callback which in turn did a wakeup). So he's not changing
the RCU implementation, he is just making it faster.

thanks,

 - Joel


> +static void rcu_poll_wait_gp(struct rcu_tasks *rtp)
> +{
> +       unsigned long gp_snap;
> +
> +       gp_snap =3D start_poll_synchronize_rcu();
> +       while (!poll_state_synchronize_rcu(gp_snap))
> +               schedule_timeout_idle(1);
> +}
> +
> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func);
> +DEFINE_RCU_TASKS(rcu_poll, rcu_poll_wait_gp, call_rcu_poll,
> +                 "RCU Poll");
> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func)
> +{
> +       call_rcu_tasks_generic(rhp, func, &rcu_poll);
> +}
> +EXPORT_SYMBOL_GPL(call_rcu_poll);
> +
> +void synchronize_rcu_poll(void)
> +{
> +       synchronize_rcu_tasks_generic(&rcu_poll);
> +}
> +EXPORT_SYMBOL_GPL(synchronize_rcu_poll);
> +
> +static int __init rcu_spawn_poll_kthread(void)
> +{
> +       cblist_init_generic(&rcu_poll);
> +       rcu_poll.gp_sleep =3D HZ / 10;
> +       rcu_spawn_tasks_kthread_generic(&rcu_poll);
> +       return 0;
> +}
>
> Thanks
> Zqiang
>
>
> > >
> > > <snip>
> > >   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preemp=
t
> > > CBs=3D3613 bl=3D28
> > > ...
> > >   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_pr=
eempt
> > > rhp=3D00000000b2d6dee8 func=3D__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_pr=
eempt
> > > rhp=3D00000000a446f607 func=3D__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_pr=
eempt
> > > rhp=3D00000000a5cab03b func=3D__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_pr=
eempt
> > > rhp=3D0000000013b7e5ee func=3D__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_pr=
eempt
> > > rhp=3D000000000a8ca6f9 func=3D__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_pr=
eempt
> > > rhp=3D000000008f162ca8 func=3Dwakeme_after_rcu.cfi_jt
> > >   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt =
CBs-
> > > invoked=3D3612 idle=3D....
> > > <snip>
> > >
> >
> > Did the results above tell us that CBs-invoked=3D3612 during the time 2=
1950.145313 ~ 21950.152625?
> >
> >Yes.
> >
> >
> > If possible, may I know the steps, commands, and related parameters to =
produce the results above?
> > Thank you!
> >
> >Build the kernel with CONFIG_RCU_TRACE configuration. Update your "set_e=
vent"
> >file with appropriate traces:
> >
> ><snip>
> >XQ-DQ54:/sys/kernel/tracing # echo rcu:rcu_batch_start rcu:rcu_batch_end=
 rcu:rcu_invoke_callback > set_event
> >
> >XQ-DQ54:/sys/kernel/tracing # cat set_event
> >rcu:rcu_batch_start
> >rcu:rcu_invoke_callback
> >rcu:rcu_batch_end
> >XQ-DQ54:/sys/kernel/tracing #
> ><snip>
> >
> >Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing # echo 1=
 > tracing_on; sleep 10; echo 0 > tracing_on
> >Next problem is how to parse it. Of course you will not be able to parse
> >megabytes of traces. For that purpose i use a special C trace parser.
> >If you need an example please let me know i can show here.
> >
> >--
> >Uladzislau Rezki
