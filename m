Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3844169FDC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjBVVfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBVVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:35:15 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF47A34013
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:35:14 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536bbef1c5eso143663627b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pP7tTtJQ4kJ8PCkgWASPwT1mOmSciO799a0n9qfC8zg=;
        b=UdEXlWO2tnxhh5pDK59xusiwGTpzGWiWEkOnaPcHNohs+/fU6JukUTgnrYhz07UhvL
         rY3iXu6BLvbPGVDOHFidOaYAl5WGdtj5QVj9tB4/vJr8ZEE0o6Q3rDKBc1l/H+hCVItw
         TEhJ+3+2LENCwHYonLrsyjYURXTd/ugQCnB0hGClSc/OpKIDvwolXemY/TrPdAdN3Uah
         7imDJgWfMzNoYxZY/20yyFuFupmq6QEAKsqurjmb7N2Ds7NVYDFCHJ6QfoCEyL/VwAgX
         OvT2Srse3sT0LtPQYy1rWSQfU5vLh0C5RFZhENQYGnRmGnLPvVr597K9zLeUnFExK4jF
         duuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pP7tTtJQ4kJ8PCkgWASPwT1mOmSciO799a0n9qfC8zg=;
        b=AVxHPT0CkJEvkF2LHnN8QwGW5pHbPstaF2XHrDMVsf3PTkYXCcIWd3VpUx6H1RMndJ
         p4TQjYVFBfUxEnETtTxkkt0JFDvWu4lYcMCloAsHHFSQ4ugOgGH+69oMU35IVcjIsgoT
         JDbUGtjklcaqydN9SQYuAdwpegSeoSttMjalZLodI3uPe5lxeDuNX2OF4UhDbP0bUea8
         9UY+N0woFky+RKATSQVwW5fDEy5tBrCQZt/niAPnoRpIiip1V7+61gDB+JTA5kCfPLbs
         5prTYuN3lANb+rBvraoCauYJvxoJWJzqMuTCYGW/seNUhyWw1VyGd1Rz1VGd7v9EO/ug
         oqoQ==
X-Gm-Message-State: AO0yUKX+johWIj+s1b5abpeBegM0zqUpe1y+vO9sBaHO+Uw7bHIOUZ6C
        1y9ZS8fGgdsdJUmZFp+cLyqN3VPlrPVshJbfqhkAac7LVTABp8c=
X-Google-Smtp-Source: AK7set8QqC5HzNlv2xV/Pr/KY1nx129ce1NXGitPTMy6D4Ck51FsrkX4PxVJi+9vio7WvoDIefVt4FgpsQn0byU1Dlo=
X-Received: by 2002:a81:b660:0:b0:533:9ffb:cb13 with SMTP id
 h32-20020a81b660000000b005339ffbcb13mr1321559ywk.3.1677101713721; Wed, 22 Feb
 2023 13:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20230221190238.21285-1-jstultz@google.com> <20230222190718.GR2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230222190718.GR2948950@paulmck-ThinkPad-P17-Gen-1>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 22 Feb 2023 13:35:01 -0800
Message-ID: <CANDhNCq0E1Cii3woBh-pPC9egt3hfxrFtuhiZM55xpiuz4XtWg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] locktorture: Add nested_[un]lock() hooks and
 nlocks parameter
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com, "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 11:07 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> On Tue, Feb 21, 2023 at 07:02:35PM +0000, John Stultz wrote:
> > In order to extend locktorture to support lock nesting, add
> > nested_lock() and nested_unlock() hooks to the torture ops.
> >
> > These take a 32bit lockset mask which is generated at random,
> > so some number of locks will be taken before the main lock is
> > taken and released afterwards.
> >
> > Additionally, add nested_locks module parameter to allow
> > specifying the number of nested locks to be used.
> >
> > This has been helpful to uncover issues in the proxy-exec
> > series development.
> >
> > This was inspired by locktorture extensions originally implemented
> > by Connor O'Brien, for stress testing the proxy-execution series:
> >   https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/
> >
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: kernel-team@android.com
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> > Co-developed-by: Connor O'Brien <connoro@google.com>
> > Signed-off-by: Connor O'Brien <connoro@google.com>
> > Signed-off-by: John Stultz <jstultz@google.com>
>
> I queued this series in place of its precedessor, thank you for the
> update!
>
> Given what I know now, I will set this up for the v6.4 merge window.

Much appreciated! Apologies for the churn, I wasn't sure if you caught
the last iteration or not, so I figured I'd send it out again.

thanks
-john
