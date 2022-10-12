Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B465FCBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJLTyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJLTyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:54:38 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71372189
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:54:36 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d14so9336064ilf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nIZK921kgx58UdIyVC5ayIJBJbNqULB9uu6tsSeumyA=;
        b=JGZDcUzJP7GvU3lcTwaBlSH0DdoDDbn3M6ccuZ2yUn3bHouMHUlk/eP0MaDhqbE4xO
         zXdJPa/5SOiFHfks0kXR0CwvF5mIzznqToOT55cjbD2Pu3g8zO6H+J5V7L5NBbONPbfZ
         fd4/vy8qzCEoetISe+lXuv4T4jna282pgC8UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIZK921kgx58UdIyVC5ayIJBJbNqULB9uu6tsSeumyA=;
        b=P7f1NVB1rKrDghjZYHZWn6dmCcBnOI3HkvNN0iTSIlKKzbkP7EAMhmoW4vvRsg5h7N
         FuD61Y9f2+hx7tfDCxXFh5wbo/YhLirJAazkuzv2Lrl158OBkdqThXaaqcjIseizbB06
         UrjvZmsDmG9apNjgoI4371pQVI2VK6aHThKdUKk+YqGzGpvXCH/4zVsm+Spe1RrfSTog
         bKnY/FC8S9bWrWNXuvlsHECJ8QCYc5kqilK5BGFM8jfiM12roBUPBWFwGs0rmw936TFm
         vemjGzAb+Erx8OivgOn3yRQbDLR/4mjZN1HpvFxEGQTgCzMbMii/sVmdm4X+PzfxZ7hN
         ykag==
X-Gm-Message-State: ACrzQf2NlauZE3f68XkP6W6kj0nSXEClTtGW+8hNqIq+0F8H5oyWPHhV
        jeFrYMLMxNiBNi72gRdJ9lC2WtOpKednNTMSio8+7w==
X-Google-Smtp-Source: AMsMyM54rwa+Cp1yIX8hwMtKzNITA9Rk1ufq2G5CcQCpwUxNxjtG5QHDz6FvStyqJctn6j7lFDS7wsw95fA2PpTDcx0=
X-Received: by 2002:a92:d686:0:b0:2fa:6226:6247 with SMTP id
 p6-20020a92d686000000b002fa62266247mr15896122iln.79.1665604475795; Wed, 12
 Oct 2022 12:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221011180142.2742289-1-joel@joelfernandes.org>
 <20221011180142.2742289-3-joel@joelfernandes.org> <20221011231053.GA1052831@lothringen>
In-Reply-To: <20221011231053.GA1052831@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 12 Oct 2022 15:54:25 -0400
Message-ID: <CAEXW_YSsEQ8krr9ckCOmO1B=C+Oy+8j_BtetQeNu1McH5nSuQg@mail.gmail.com>
Subject: Re: [PATCH v8 02/13] rcu: Make call_rcu() lazy to save power
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 7:10 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Tue, Oct 11, 2022 at 06:01:31PM +0000, Joel Fernandes (Google) wrote:
> > @@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
> >       raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
> >
> >       /*
> > -      * Bypass wakeup overrides previous deferments. In case
> > -      * of callback storm, no need to wake up too early.
> > +      * Bypass wakeup overrides previous deferments. In case of
> > +      * callback storm, no need to wake up too early.
> >        */
> > -     if (waketype == RCU_NOCB_WAKE_BYPASS) {
> > +     if (waketype == RCU_NOCB_WAKE_LAZY &&
> > +         READ_ONCE(rdp->nocb_defer_wakeup) == RCU_NOCB_WAKE_NOT) {
>
> No need for READ_ONCE() here.
>
> > +             mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
> > +             WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> > +     } else if (waketype == RCU_NOCB_WAKE_BYPASS) {
> >               mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
> >               WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> >       } else {
> > @@ -611,6 +682,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >       unsigned long flags;
> >       bool gotcbs = false;
> >       unsigned long j = jiffies;
> > +     bool lazy = false;
> > +     long lazy_ncbs;
>
> Looks like lazy_ncbs can be declared withing the loop, as well as bypass_cbs.
>
> Anyway, apart from such boring cosmectics:
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks, I folded the cosmetic suggestions with the Ack and pushed it to:
https://github.com/joelagnel/linux-kernel.git (branch rcu-next-oct.12.22)

thanks,

 - Joel
