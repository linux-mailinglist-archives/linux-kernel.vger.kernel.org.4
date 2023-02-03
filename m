Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46375688E48
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBCD4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjBCD4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:56:18 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAB269538
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:56:17 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id b1so4860063ybn.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 19:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9eNoQjkmzzTBjSP8j2kyPWn98DApFbqyEeF3e+z4FH8=;
        b=bWCRRuyuH8l1tqFLxrBEx4TdUexbAmGzwW1yZ+c9xfQJSZiW0/cjIHVSFWGgEK4YsS
         D7zJXgykOQIUy0TMhhYwiVamIU1zBELlMrALodu7vOfhSK9UPNEfzdTE7cbOYsuHA5zY
         IWwQyiY3pr2gwcVYk6aKZHuvuvpLBJb7WifU4zxJ6ucptdRHk0PHO4s5jBaio2niGi5m
         +u8NhkNBmzZQRQuAdfTstGgMpSV8m2ZrnlgmtHBsnEzktlbO+RXXqIyojubNWWwP1B42
         yc4/Tiw/AyLCaoCK4utQKTqYaWrtu5KbUFyqBG9uIwyTP7IkHvEvW2HFbpljR9P9p93u
         Balg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eNoQjkmzzTBjSP8j2kyPWn98DApFbqyEeF3e+z4FH8=;
        b=ERCaRTwBdwEYa/qYRkkuPPNdVbs7Wqjxt4CdnrW+PvXC732sAayLTDH6G2cD+vJspC
         ALYSXABkeJUaJwbW6z2E7RqA4YJtIaMGkF1GIis6NoXBRTUDoWpg3Ae9Jb6xz2pd8lRV
         kA8Sbv9WndECbXapbnmA1eG0ZUNyHXWVQ1EgFv40FwWIGXib0bT8l+wNtSdz0HFXqWUk
         QEQ72JdLz9gOJB80DJx2PgJVjuLY5JaE3wr57049RPaIBraVFtIBeO2FHWjKgs8ZjLjX
         CbwSOB8dD7vaPD2zhV2MntvtIVx6WfN9CcVmkphnRk/ejKTnln6BDkoVwouZKssvi1b/
         x4+A==
X-Gm-Message-State: AO0yUKUsMa79Zlf6KQ77RA+A5o5jvLS9LvO7XZ/AZPOz8n3yj5b/ZJC2
        4K6UyuBMfihV4yGh9ETzvN0Nb7eXd7YDwugy5/QE
X-Google-Smtp-Source: AK7set95UpoR6r7NAvycdCoK6zfQuuoX4P/HjH36oYgmDVxtsiHT1bR+yFa3nhYul600o2eKNpyUzpLtZjwoHwx1ap4=
X-Received: by 2002:a25:800e:0:b0:801:4500:63e with SMTP id
 m14-20020a25800e000000b008014500063emr1287004ybk.332.1675396576538; Thu, 02
 Feb 2023 19:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20230202223409.2812443-1-jstultz@google.com> <20230203020509.GD2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230203020509.GD2948950@paulmck-ThinkPad-P17-Gen-1>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 2 Feb 2023 19:56:05 -0800
Message-ID: <CANDhNCrSCrCgGDaGstS9=3vEqow=iiF5qWOhbzrstMbD5afXAQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] locktorture: Add nested_[un]lock() hooks and
 nlocks parameter
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
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

On Thu, Feb 2, 2023 at 6:05 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Feb 02, 2023 at 10:34:06PM +0000, John Stultz wrote:
> > In order ot extend locktorture to support lock nesting, add
> > nested_lock() and nested_unlock() hooks to the torture ops.
> >
> > These take a 32bit lockset mask which is generated at random,
> > so some number of locks will be taken before the main lock is
> > taken and released afterwards.
> >
> > Additionally, add nlocks module parameter to allow specifying
> > the number of nested locks to be used.
> >
> > This has been helpful to uncover issues in the proxy-exec
> > series development.
> >
> > This was inspired by locktorture extensions originally implemented
> > by Connor O'Brien, for stress testing the proxy-execution series:
> >   https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/
> >
> > Comments or feedback would be greatly appreciated!
>
> I have pulled this in for testing and further review, thank you!
>
> Should either of these files have a locktorture.nlocks=<whatever>
> added?
>
> tools/testing/selftests/rcutorture/configs/lock/LOCK02.boot
> tools/testing/selftests/rcutorture/configs/lock/LOCK05.boot
>
> The first is for mutex_lock and the second for rtmutex_lock.

Potentially? I wasn't aware of these files. Is there some
documentation on the intent behind them?

While the nested locking is useful to cause different lock chains to
test boosting or proxy-execution, I worry they may cause extra noise
that could distract from just thrashing the *mutex lock primitive if
that's the existing intent.

So we might want additional config files for the nested case.

> This did pass a quick "torture.sh --do-none --do-locktorture", which is
> good, but this uses the existing .boot files.

Yeah, probably no effective change in that case.

thanks
-john
