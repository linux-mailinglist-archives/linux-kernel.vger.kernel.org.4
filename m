Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD7F6C0903
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCTCxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCTCx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:53:27 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D924226
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:53:25 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5416698e889so200935657b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679280804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+48VIs2KAq1cIQzJT8apezfWT+F0AwjwYYd/H19XmA=;
        b=iRNMLsscXyCxTabImU86ajmficAN8v/3JNw4ANK74fV2TXtahm2cLWvPpVxF3R3Sbw
         J5+8BhpGmffKGI0rWQiZ00sMai3NbOxwjZ4DcsExintgdsxJvYDVPY1PBtxBJzoy2i5n
         2kqEM0lJCldtWkRaYFUi8xw+gcpbKG5U+Yoa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679280804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+48VIs2KAq1cIQzJT8apezfWT+F0AwjwYYd/H19XmA=;
        b=rFt4gc3a1itvabYow8mhE0augBuBW98IxrBKFKGUvQdYX4JXmbzBZNLLRvvmHyn5Ke
         o0yeq1wIgLz227Ns2mqexOpbllEy9otuZtQONMmJgqiwn0dqloqFc5mlus4yM7MI8BcN
         txex4kEq9SZI2DW2NKZvSL7Qvam2VWy4osREV2zTgFtz7phRgBRMPMAyVhhgFlHMHfv5
         64lRcuw6kd/ElbDz/0DZYiXBxAE9cHuxwkBf2kDCdPM3smWMMHbCiqtMsidlkS3HBzR2
         kPtvNWjinIBjb6odmnmOrMBwGo0J0UYDVF9gZ/iIaHds3wV7BBeqSnzF0a01wp+bIFtP
         N8+g==
X-Gm-Message-State: AO0yUKX8jiU4AWnaSa5Y5bqkL2aFSow9j1jaMezRXY48HGauTNSsnWzO
        Hft/U/TrpYxbPD0WWn06ac9Deh+adtCT++lMMnBHzQ==
X-Google-Smtp-Source: AK7set9OS7kNQQPloCGDUdhflqyyIAuR2dycuPg+TicXiKjl+0tmanu2RGd+7t5QYFXP6U4a0VLZxc0bwmhD8ahVTWk=
X-Received: by 2002:a81:ac1f:0:b0:541:9895:4ce9 with SMTP id
 k31-20020a81ac1f000000b0054198954ce9mr9129205ywh.9.1679280804177; Sun, 19 Mar
 2023 19:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230320024341.3956543-1-qiang1.zhang@intel.com>
In-Reply-To: <20230320024341.3956543-1-qiang1.zhang@intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 19 Mar 2023 22:53:13 -0400
Message-ID: <CAEXW_YTMVF4qhFya5kW=xi5pLGd_gb_n-ZA+8+41iaG1S4YdMg@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Fix some incorrect trace log in rcu_boost and
 rcuc kthreads
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 10:39=E2=80=AFPM Zqiang <qiang1.zhang@intel.com> wr=
ote:
>
> In rcu_boost kthreads, before invoke rcu_wait(), the trace string
> should mark "Start boost kthread@rcu_wait", after rcu_wait() end,
> mark "End boost kthread@rcu_wait". for boost kthread enter idle
> state, the trace should also do same.
> In rcuc kthreads, when the rcu_cpu_has_work is set zero, indicates
> that there are no works to process, the rcuc kthreads will enter
> waiting state, so the trace string should mark "Start @rcu_wait".

Nope. Unfortunately, in this hard to read change log, you are making
the "Start @rcu_wait" up.

The trace clearly says "Start boost kthread @...",

So first of all, don't make things up please based on imagination. Let
us go by the actual trace message precisely and not skip important
words in it.

Now, an interpretation of the trace might be , we print a "Start"
whenever the thread is RUNNING and "End" whenever the thread is
SLEEPING. That makes much more sense so the existing code for the
boost kthread is already correct.

However, I did notice this bit of code in tree.c might have been
causing confusion:

*statusp =3D RCU_KTHREAD_YIELDING;
trace_rcu_utilization(TPS("Start CPU kthread@rcu_yield"));
schedule_timeout_idle(2);
trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
*statusp =3D RCU_KTHREAD_WAITING;

So perhaps a proper fix might be - in this fragment the Start and End
should be swapped instead.

thanks,

 - Joel


>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c        | 2 +-
>  kernel/rcu/tree_plugin.h | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 734c252c1e80..c1915408796f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2465,7 +2465,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
>                         rcu_core();
>                 local_bh_enable();
>                 if (*workp =3D=3D 0) {
> -                       trace_rcu_utilization(TPS("End CPU kthread@rcu_wa=
it"));
> +                       trace_rcu_utilization(TPS("Start CPU kthread@rcu_=
wait"));
>                         *statusp =3D RCU_KTHREAD_WAITING;
>                         return;
>                 }
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 7b0fe741a088..7b622b5196a8 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1114,10 +1114,10 @@ static int rcu_boost_kthread(void *arg)
>         trace_rcu_utilization(TPS("Start boost kthread@init"));
>         for (;;) {
>                 WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING=
);
> -               trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
> +               trace_rcu_utilization(TPS("Start boost kthread@rcu_wait")=
);
>                 rcu_wait(READ_ONCE(rnp->boost_tasks) ||
>                          READ_ONCE(rnp->exp_tasks));
> -               trace_rcu_utilization(TPS("Start boost kthread@rcu_wait")=
);
> +               trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
>                 WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING=
);
>                 more2boost =3D rcu_boost(rnp);
>                 if (more2boost)
> @@ -1126,9 +1126,9 @@ static int rcu_boost_kthread(void *arg)
>                         spincnt =3D 0;
>                 if (spincnt > 10) {
>                         WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD=
_YIELDING);
> -                       trace_rcu_utilization(TPS("End boost kthread@rcu_=
yield"));
> -                       schedule_timeout_idle(2);
>                         trace_rcu_utilization(TPS("Start boost kthread@rc=
u_yield"));
> +                       schedule_timeout_idle(2);
> +                       trace_rcu_utilization(TPS("End boost kthread@rcu_=
yield"));
>                         spincnt =3D 0;
>                 }
>         }
> --
> 2.25.1
>
