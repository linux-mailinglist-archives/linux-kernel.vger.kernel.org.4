Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D275F66B42F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjAOVfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjAOVfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:35:12 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076181632F
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:35:11 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o7so27841102ljj.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=391zf2b5ENaKFkCj6QTLOk5UN8b8armr47ewORXci1I=;
        b=qrY7GorZ2uAyWw8gyWUH04gaIjRAb54N1FQ2Ifu965qgJyTnD9Xan+FI+1qTrvxbK0
         pN5yb1cT1YDzU1nnd51INMBhFK+SHUTRm1HQQVdewSUwXZpmlJkkd/lCyTT7618sl+DT
         WFfiNfHGO1CFd4YBgHMlW3gp15sGd+gr7DKpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=391zf2b5ENaKFkCj6QTLOk5UN8b8armr47ewORXci1I=;
        b=tE8BbAp/l+hFzswnSYdtoeIsi+qKsvGgGduvC4RvV8IEK4L2gMEw/0Sz7c06FXlk0X
         Lcu1DB2QNWxEWZjIKnMN7W97PzEUWUDqLBnSxeMq07LZlSYUjxdoCnm/8VGbZgxkbzSg
         L2ziZOzinbQQbWwD16U2xn5X9a4Rg0KimMFExG3FKgkvGJBGXbNhlQ0TGphs9ZrvrQzP
         yrR+yGirA2xVfAjks9Nrphmukv9HcdND+p81M3krojcljqmKDrBy3cozFSjj2mo9TVIo
         l45ipYRdaMFyWXINJbZK0go31yFmlvsIIGRoqOTrnJ8F0ItMHOIL4PMF/blSwT/GP6zI
         /cgg==
X-Gm-Message-State: AFqh2koxzKbknLOzTwAkEHzxpWEzu7+Tbr4PtfCd8/VhHiFkP9fD1icT
        yQmWXcX6g0B0/2a9qatHK8C/pDSUFYA9MKSH4Y22wA==
X-Google-Smtp-Source: AMrXdXvdYUOIvgaM/UeqVwSFKCLoUWOMuCGIpAaN0CT3tYDyEawaZgtyhzd+Cw9PjEaik5HsrET7og7aLaKefubmKSI=
X-Received: by 2002:a2e:be89:0:b0:27f:b85b:3e26 with SMTP id
 a9-20020a2ebe89000000b0027fb85b3e26mr3669361ljr.382.1673818508782; Sun, 15
 Jan 2023 13:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20230112005223.2329802-1-joel@joelfernandes.org> <20230115162504.08ef72b0@rorschach.local.home>
In-Reply-To: <20230115162504.08ef72b0@rorschach.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 15 Jan 2023 16:34:58 -0500
Message-ID: <CAEXW_YSNurO-hK+q2amP6wa96jr0KkZ_ggF+5x_sTHESC9vpNw@mail.gmail.com>
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and suspend
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        fweisbec@gmail.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 4:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 12 Jan 2023 00:52:22 +0000
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
>
> > -- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -144,8 +144,45 @@ bool rcu_gp_is_normal(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_gp_is_normal);
> >
> > -static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
> > +static atomic_t rcu_async_hurry_nesting = ATOMIC_INIT(1);
> > +/*
> > + * Should call_rcu() callbacks be processed with urgency or are
> > + * they OK being executed with arbitrary delays?
> > + */
> > +bool rcu_async_should_hurry(void)
> > +{
> > +     return !IS_ENABLED(CONFIG_RCU_LAZY) ||
> > +            atomic_read(&rcu_async_hurry_nesting);
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_async_should_hurry);
> > +
> > +/**
> > + * rcu_async_hurry - Make future async RCU callbacks not lazy.
> > + *
> > + * After a call to this function, future calls to call_rcu()
> > + * will be processed in a timely fashion.
> > + */
> > +void rcu_async_hurry(void)
> > +{
> > +     if (IS_ENABLED(CONFIG_RCU_LAZY))
> > +             atomic_inc(&rcu_async_hurry_nesting);
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_async_hurry);
> >
>
> Where do you plan on calling these externally, as they are being
> marked exported?
>
> If you allow random drivers to enable this, I can see something
> enabling it and hitting an error path that causes it to never disable
> it.

You mean, just like rcu_expedite_gp() ?

> I wouldn't have EXPORT_SYMBOL_GPL() unless you really know that it is
> needed externally.

At the moment it is not called externally but in the future, it could
be from rcutorture. If you see rcu_expedite_gp(), that is exported
too. I was just modeling it around that API.

thanks,

 - Joel

>
> -- Steve
>
>
> > +/**
> > + * rcu_async_relax - Make future async RCU callbacks lazy.
> > + *
> > + * After a call to this function, future calls to call_rcu()
> > + * will be processed in a lazy fashion.
> > + */
> > +void rcu_async_relax(void)
> > +{
> > +     if (IS_ENABLED(CONFIG_RCU_LAZY))
> > +             atomic_dec(&rcu_async_hurry_nesting);
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_async_relax);
> > +
> > +static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
