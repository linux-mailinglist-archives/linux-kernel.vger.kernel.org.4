Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EDE5B6570
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiIMCMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiIMCMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:12:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281E15282E;
        Mon, 12 Sep 2022 19:12:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e68so10393986pfe.1;
        Mon, 12 Sep 2022 19:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Hn+mJHMNiwK9F3CAgCKdpkiNsLEH3F0KSe5oOf//LD0=;
        b=LQ7kb6G7D79wczAE410wa6pTSjmWIvaO9RrU74/y+TUY4JTs7TsRXMshJvD63XFErs
         YvA5vpBsTh4hNzo8LZPsm3EFBk2RFWuu2GjMSj+hx0b5l5kMk30utcKo3BphY8sxynuS
         M8tCClZbF2tdr12W2KMChNDVEDHl4QEqAjxvG4F80SE1YR+9zCkwMr5wiFyGcBLNhA+C
         aL2V0NV5nsHw+CK6W9XT61ES3DbdNdlv0ebEfP1ocPzGQKOA5EeJYuGgHzGQV4GbfE8A
         BnqhwjvawF9Ijgg2Xi2l0OjzKNXCxEggT9k+1EHLpWsyO6V/mT+ieFG5qcMaVDJqiMTl
         q4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Hn+mJHMNiwK9F3CAgCKdpkiNsLEH3F0KSe5oOf//LD0=;
        b=rNK9SQW4VoYBewQD0BCBwAwPSRGvrsLkFm9rKaDmw6b4nO0nD3eGwmtFH55TomG7+z
         A+FfaFIuCVUeXA30r9oOCttk6PORmljGG3o4h4rKR9vzwvt86yAma0fgd5NUh9p65tSq
         gmUzz+x8IjUTyp7IoRDAXrfrP5wDpjsJWIFEL2XI5L3b0zutBUAon8BgM28LWGhKEbgC
         UrKF8f++Mtq+2SPuFAL+VW6xbxk69FeLTXp2MEWtK3Gki17rxMH3Y6T3PDkxTX/J7rXs
         LO44twflWz6KvTBypyBjAt7zp704hmu2aY+u3kw88DBhIn2eYVoB25LWopgFNVSzIazD
         9CnQ==
X-Gm-Message-State: ACgBeo0oJrHRW57bQJJIRYlbz+ud4Zc8pBAygtcNf/0svjPOaPly8qD4
        3UJ9VgQfvr2H+11peDJ01+Q=
X-Google-Smtp-Source: AA6agR5jYC1rMNAUmtYeVAMUjuWOlwEUMiCtIr1DIenx7Cv5P5CKAnJQFqo1WY+fvZKJN/CeH+6Kdw==
X-Received: by 2002:a65:6854:0:b0:438:b1b5:8769 with SMTP id q20-20020a656854000000b00438b1b58769mr12944080pgt.472.1663035168605;
        Mon, 12 Sep 2022 19:12:48 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id ja4-20020a170902efc400b001768bd49e4esm6846778plb.37.2022.09.12.19.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 19:12:48 -0700 (PDT)
Date:   Tue, 13 Sep 2022 10:12:43 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
Message-ID: <Yx/nG5YsyCa+VXoj@sol>
References: <20220909121329.42004-1-brgl@bgdev.pl>
 <20220909121329.42004-3-brgl@bgdev.pl>
 <YxykorLetCjAls/Z@sol>
 <CAMRc=Me46b+Fjz_AAbZZVbaELjY6NGVfNE6mwueiKRTpYe98rA@mail.gmail.com>
 <Yx8Bj0+4STpklMc2@sol>
 <CAMRc=Me=QxXRgZKyirj23r4hEN9bzcPSM6N4z=0yGgAZheh=Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Me=QxXRgZKyirj23r4hEN9bzcPSM6N4z=0yGgAZheh=Qg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:56:17AM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 12, 2022 at 11:53 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> 
> [snip]
> 
> > >
> > > Using -1 sounds good but I've just realized there's a different
> > > problem. A process holding a file descriptor may fork and both the
> > > parent and the child will keep the same file descriptors open. Now
> > > we'll have two processes (with different PIDs) holding the same GPIO
> > > lines (specifically holding a file descriptor to the same anonymous
> > > inode).
> > >
> > > This already poses a problem for this patch as we'd need to return an
> > > array of PIDs which we don't have the space for but also is a
> > > situation which we haven't discussed previously IIRC - two processes
> > > keeping the same GPIO lines requested.
> > >
> > > I don't have any good idea on how to address this yet. One thing off
> > > the top of my head is: close the parent's file descriptor from kernel
> > > space (is it even possible?) on fork() (kind of like the close() on
> > > exec flag).
> > >
> > > I need to think about it more.
> > >
> >
> > I thought the O_CLOEXEC was set on the request fds exactly to prevent this
> > case - only one process can hold the request fd.
> >
> 
> O_CLOEXEC means "close on exec" not "close on fork". When you fork,
> you inherit all file descriptors from your parent. Only once you call
> execve() are the fds with this flag closed *in the child*.
> 

Ah, ok.
You want to pass request fd ownership from parent to child??
Why not lock ownership to the parent, so O_CLOFORK, were that
available?

Cheers,
Kent.
