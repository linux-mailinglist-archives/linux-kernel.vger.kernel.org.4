Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8145D5B73A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiIMPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiIMPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:08:51 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3A87675B;
        Tue, 13 Sep 2022 07:31:24 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d82so11920735pfd.10;
        Tue, 13 Sep 2022 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uE2k8DemtXQoFgIyx0axivRuuEaQewLGGBhI5xQfpoo=;
        b=ABby8htyK4p5z9pS9ijVFXTHBZtbRC+kbrxb6x6zZ4tgRINFOL9NZ16LZk0wtyIShs
         37xkjsS5y0QFnGgF0m8gpKKWoM4F4fsVczYuBF0eHOOkHirw/+7HC9RzfGKuZ97unX2N
         9QH2pzP8o6ZJaN+qG6FRKDZN4M14P1B4wAJq28gMBSCt7cmXOeIpPsV3K067tcTlE9+L
         b4FAoDoHODOfCmviN4bfQ+wYEhK0O9QxO75TMXNEIMPecKhuBalU9XfKw3NG4ZFZCOcm
         s2kJLrqmw/Hhjszh43JsGlHgqtQ5ZNe1g+WHBWcYyj8UhrrEFliYeYFDoLja4CqGMcUs
         w46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uE2k8DemtXQoFgIyx0axivRuuEaQewLGGBhI5xQfpoo=;
        b=FN8Ol64z8eg70BydvM2hLU5oVT2GHuBe1ivp0nJL66SM5VEppw37aKw7vnzy2NNPsF
         l0hl2n65TWVtP+nVsqRxMcNgkcDge+hrs0fP/xDTSuKbjmHt9puuPPozcAFv2uS/mroe
         KOYM0mTkLwe/8yWTtRlaSjHV7BO7hrsSIWuiQEV5AktnBRu5ClKZkCek7wxRXSmsjd9O
         spz1hdjA3C24FMf8aJTA8hqq/ZxmzO/p3xyJhmQ/AWKlbdg3+QP+r85FSt1xPWeyZ5Ug
         bVfviNuZC4QJLqtZ0wETbRJOFyBS9MEPuDtCN9OxdRKNjmx5OrdYT5k9ibAaayt58S4c
         8IBQ==
X-Gm-Message-State: ACgBeo19pcwBXW8AEqChsMIwE/Ik6kMBM9kCjorGe7hlhHjmCBe1GPVW
        LwuWRT+QALJdJppBuvFLUdg=
X-Google-Smtp-Source: AA6agR5AsU2rLelzEvOegvduVc5Ahp8yRB4ULphBkQexoW8BtQKEFO3AYtdT5xjYzHZYqGfKGNqPxw==
X-Received: by 2002:a05:6a00:ac4:b0:535:c08:2da7 with SMTP id c4-20020a056a000ac400b005350c082da7mr33345721pfl.69.1663079327532;
        Tue, 13 Sep 2022 07:28:47 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b0017824e7065fsm6640367plg.180.2022.09.13.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:28:46 -0700 (PDT)
Date:   Tue, 13 Sep 2022 22:28:41 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
Message-ID: <YyCTmZocN/CY4Pg6@sol>
References: <20220909121329.42004-1-brgl@bgdev.pl>
 <20220909121329.42004-3-brgl@bgdev.pl>
 <YxykorLetCjAls/Z@sol>
 <CAMRc=Me46b+Fjz_AAbZZVbaELjY6NGVfNE6mwueiKRTpYe98rA@mail.gmail.com>
 <Yx8Bj0+4STpklMc2@sol>
 <CAMRc=Me=QxXRgZKyirj23r4hEN9bzcPSM6N4z=0yGgAZheh=Qg@mail.gmail.com>
 <Yx/nG5YsyCa+VXoj@sol>
 <CAMRc=MfoZQV-aHKSkAw6d_jPPbjn==oR0LA=irjuWLGzQiRP-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfoZQV-aHKSkAw6d_jPPbjn==oR0LA=irjuWLGzQiRP-w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 10:54:26AM +0200, Bartosz Golaszewski wrote:
> On Tue, Sep 13, 2022 at 4:12 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Mon, Sep 12, 2022 at 11:56:17AM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Sep 12, 2022 at 11:53 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > >
> > > [snip]
> > >
> > > > >
> > > > > Using -1 sounds good but I've just realized there's a different
> > > > > problem. A process holding a file descriptor may fork and both the
> > > > > parent and the child will keep the same file descriptors open. Now
> > > > > we'll have two processes (with different PIDs) holding the same GPIO
> > > > > lines (specifically holding a file descriptor to the same anonymous
> > > > > inode).
> > > > >
> > > > > This already poses a problem for this patch as we'd need to return an
> > > > > array of PIDs which we don't have the space for but also is a
> > > > > situation which we haven't discussed previously IIRC - two processes
> > > > > keeping the same GPIO lines requested.
> > > > >
> > > > > I don't have any good idea on how to address this yet. One thing off
> > > > > the top of my head is: close the parent's file descriptor from kernel
> > > > > space (is it even possible?) on fork() (kind of like the close() on
> > > > > exec flag).
> > > > >
> > > > > I need to think about it more.
> > > > >
> > > >
> > > > I thought the O_CLOEXEC was set on the request fds exactly to prevent this
> > > > case - only one process can hold the request fd.
> > > >
> > >
> > > O_CLOEXEC means "close on exec" not "close on fork". When you fork,
> > > you inherit all file descriptors from your parent. Only once you call
> > > execve() are the fds with this flag closed *in the child*.
> > >
> >
> > Ah, ok.
> > You want to pass request fd ownership from parent to child??
> > Why not lock ownership to the parent, so O_CLOFORK, were that
> > available?
> >
> 
> Because what if we want to request a line and then daemonize i.e. fork
> and exit in parent? It makes much more sense to keep the lines
> requested in the child IMO.
> 

Then you are doing it backwards - daemonize first ;-).

Generally speaking, doesn't transfer of resource ownership to the forked
child create havoc in multi-threaded apps? i.e. one thread requests a
resource, another forks.  The parent thread unknowingly loses ownership,
and the forked child process only starts with a replica of the forking
thread.

> During the BoF at Linux Plumbers it was suggested to use
> /proc/$PID/fdinfo to expose the information about which lines are
> requested but I can't figure out a way to do it elegantly.
> 

Yeah, missed that :-(.

Makes sense.

As each request fd can contain multiple lines on a particular chip,
you would need to identify the gpiochip and the offsets for that request.
So two fields - the gpiochip path, and the list of offsets.

Is that already too clunky or am I missing something?

Cheers,
Kent.
