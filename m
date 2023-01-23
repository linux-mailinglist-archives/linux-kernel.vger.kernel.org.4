Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC7677E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjAWPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjAWPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:00:29 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A6D10AA5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:00:28 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id g14so13372074ljh.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8OXVqqET23d8P8R69qpaJVVVA99GrD94+chyNKQDIY=;
        b=wyBkSw2oPqo3G89B6ZpS2kEB1NDROP8LQlyni5F4RpasuOn7ATjRDwOnQ/i0ifmrh8
         0hyonsnEs+u3CfpCEJDc1IWqnJvfscPHLtZFAMb+dLt4TJl3Mc017hre7Oa/bu7ROPeh
         qTOaGqp0MLJtXa2qJDQImzc47OCmFxCU1nywE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8OXVqqET23d8P8R69qpaJVVVA99GrD94+chyNKQDIY=;
        b=Ces/mqCilzg6Bf42e0A8C0849BuLsgalGbbGew+PRO4WzQWOtyuv0RopKECs0l9oPB
         Gl1t/iZPuds6lIXPKyGnNEcxRwdy5VJ9NnV9cTDclkJAZV0cDAUbynRDnR8OUCd4zD6M
         TzTFla+0rgmu/CAzoNWkAB7N04oTfM+zF3q+WiJrip1ol1qoRxYGLdqrjnz32qw8VMqy
         GToe73jZC33uW5j/lyx1nwu9w8DlQPOiLJ9tXfsVOu5hFogv7jSKvjT7G25eiwwfkf9q
         YN8Fw5laMEN3N2l1wUNQhXrgg1d4XsSt2wMIlz1XIKwmz0Nu5Lrf9ciVYsrLjv+Y74ZM
         yIMg==
X-Gm-Message-State: AFqh2kr/VeQieVvcBZoB+zYw9xaa4Qk8XefD2u8lWfgde9Gc0hUn+TxQ
        lsCQ5ga+0Bpr1rJcxoPdF8dxdRm8l1ycxLoQyFcZjA==
X-Google-Smtp-Source: AMrXdXsi5MJ1MrfqUVaqrdEIvyJFulxZgssUqiHKkQAorIqz+ie5vwCbCXeEE3EJ5JwW2PdapQf9fQPo4xyOg21yUv4=
X-Received: by 2002:a2e:a485:0:b0:27f:bb8b:7520 with SMTP id
 h5-20020a2ea485000000b0027fbb8b7520mr2155168lji.371.1674486026590; Mon, 23
 Jan 2023 07:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20230119204434.4017605-1-joel@joelfernandes.org> <Y8sU5ADeKpow5aUY@lothringen>
In-Reply-To: <Y8sU5ADeKpow5aUY@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 23 Jan 2023 10:00:14 -0500
Message-ID: <CAEXW_YSN66Ac1i5-4oanbRERc0C3hRD=3dnQNy6CtgCFTzvD0w@mail.gmail.com>
Subject: Re: [PATCH] tick/nohz: Fix cpu_is_hotpluggable() by checking with
 nohz subsystem
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 5:25 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Thu, Jan 19, 2023 at 08:44:35PM +0000, Joel Fernandes (Google) wrote:
> > -static int tick_nohz_cpu_down(unsigned int cpu)
> > +static int tick_nohz_cpu_hotplug_ret(unsigned int cpu)
> >  {
> >       /*
> >        * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
> > @@ -522,6 +522,16 @@ static int tick_nohz_cpu_down(unsigned int cpu)
> >       return 0;
> >  }
> >
> > +static int tick_nohz_cpu_down(unsigned int cpu)
> > +{
> > +     return tick_nohz_cpu_hotplug_ret(cpu);
> > +}
> > +
> > +bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
> > +{
> > +     return tick_nohz_cpu_hotplug_ret(cpu) == 0;
>
> This is still calling the hotplug function for the CPU in order to know if the
> CPU is hotpluggable...
>
> Why not:
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index ba2ac1469d47..a46506f7ec6d 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -532,7 +532,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
>         tick_nohz_full_running = true;
>  }
>
> -static int tick_nohz_cpu_down(unsigned int cpu)
> +bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
>  {
>         /*
>          * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
> @@ -540,8 +540,13 @@ static int tick_nohz_cpu_down(unsigned int cpu)
>          * CPUs. It must remain online when nohz full is enabled.
>          */
>         if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
> -               return -EBUSY;
> -       return 0;
> +               return false;
> +       return true;
> +}
> +
> +static int tick_nohz_cpu_down(unsigned int cpu)
> +{
> +       return tick_nohz_cpu_hotpluggable(cpu) ? 0 : -EBUSY;
>  }
>

Yes, this looks better. I will do it this way. Thanks!

 - Joel
