Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9145B7621
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiIMQJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiIMQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:08:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326341ADB6;
        Tue, 13 Sep 2022 08:04:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t70so11578131pgc.5;
        Tue, 13 Sep 2022 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qV3ZGmg1zNQF4NJliVmvkbfSsBnZ+qmZ9I0fy9mjfDg=;
        b=Am8VQWNiEG3xriXjdc32ndwsblSx0UVSaTSVuBMIwm9hzxumvl790rss94dNC8Paei
         o2cvxSn8jbpu/rrDWwsylkollhwpIIoXmWDuxbW5M951GbeA02baNogJCkrrOHbEGEXh
         Vd23b4CDl43hYehyV8cRCxg5MF9/gEZGLXFbjMtu4T532GbUhpk5ZYg+Ipf/guLMqb2n
         5gWJhEe9Wy7lgQjjwILWoPpZNwS7G71iWU2OF6n9LaeS5Ek7qCY+SZLSkxrFIzNP0hId
         KSSaWY+jRcdwfZjRRc5lP4yzdOjLMc5FgxFbEE3IXl8ptWifsMIJWhL98DSZq6i4QvbH
         iaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qV3ZGmg1zNQF4NJliVmvkbfSsBnZ+qmZ9I0fy9mjfDg=;
        b=PDvSVa/oOMrZnRKPPdzctpjdakxXzGLDDNA+BDadfBgkSFr8GxaTxTxbcQE/7SYetS
         OqyIY+wyvTH7K6iXivT40asFL//RoNd4qpFNvwwi/7Uk+HSuTd+ECZ+AoEUGhvQiK7cm
         92//Uev/xd91JENRk/C5EYNt/JPmdh83IGAbsJaBxVDIePrw8VU3+phCzLVxnQi/+vDu
         pStGWU8mSYiGaHad79uOSqfUJFuTLwpc53wSWJp3FdYcVxMWQQ2S5M6jfCNaow/7BruA
         Y9F90zcVitWJ4OAqkkHfMjCUuBl/uE/1aOOeDXF1azc+dWY09KNN3ZfkdXlv8PeErm6k
         eN3Q==
X-Gm-Message-State: ACgBeo2yaYuiIZIrzRwcQT4dVKkzG7uFVDAXwYzOc0EwPimJGrKsGypw
        bvO0siu6wQohl8mTWe1uqE25eI9XADU=
X-Google-Smtp-Source: AA6agR6Qb2iWpcwBbB2Y6hbo8TDAlczOrUIUoBnM2YzfRTdt0fFm9tlDBwjC45xa7uK1dcuWSS7aQw==
X-Received: by 2002:a17:902:e402:b0:176:e82f:3f4 with SMTP id m2-20020a170902e40200b00176e82f03f4mr32073796ple.107.1663080946817;
        Tue, 13 Sep 2022 07:55:46 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id y6-20020aa793c6000000b00540b979c493sm8009767pff.55.2022.09.13.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:55:46 -0700 (PDT)
Date:   Tue, 13 Sep 2022 22:55:41 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
Message-ID: <YyCZ7TN8fyVyuWXY@sol>
References: <20220909121329.42004-1-brgl@bgdev.pl>
 <20220909121329.42004-3-brgl@bgdev.pl>
 <YxykorLetCjAls/Z@sol>
 <CAMRc=Me46b+Fjz_AAbZZVbaELjY6NGVfNE6mwueiKRTpYe98rA@mail.gmail.com>
 <Yx8Bj0+4STpklMc2@sol>
 <CAMRc=Me=QxXRgZKyirj23r4hEN9bzcPSM6N4z=0yGgAZheh=Qg@mail.gmail.com>
 <Yx/nG5YsyCa+VXoj@sol>
 <CAMRc=MfoZQV-aHKSkAw6d_jPPbjn==oR0LA=irjuWLGzQiRP-w@mail.gmail.com>
 <YyCTmZocN/CY4Pg6@sol>
 <CAMRc=MdBRGW0skXOgPbZy=w4EiWcyKmKwKSZuAj+k4EtbPmvdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdBRGW0skXOgPbZy=w4EiWcyKmKwKSZuAj+k4EtbPmvdg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 04:35:08PM +0200, Bartosz Golaszewski wrote:
> On Tue, Sep 13, 2022 at 4:28 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Tue, Sep 13, 2022 at 10:54:26AM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Sep 13, 2022 at 4:12 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > > > On Mon, Sep 12, 2022 at 11:56:17AM +0200, Bartosz Golaszewski wrote:
> > > > > On Mon, Sep 12, 2022 at 11:53 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > > >
> > > > >
> > > > > [snip]
> > > > >
> > > > > > >
> > > > > > > Using -1 sounds good but I've just realized there's a different
> > > > > > > problem. A process holding a file descriptor may fork and both the
> > > > > > > parent and the child will keep the same file descriptors open. Now
> > > > > > > we'll have two processes (with different PIDs) holding the same GPIO
> > > > > > > lines (specifically holding a file descriptor to the same anonymous
> > > > > > > inode).
> > > > > > >
> > > > > > > This already poses a problem for this patch as we'd need to return an
> > > > > > > array of PIDs which we don't have the space for but also is a
> > > > > > > situation which we haven't discussed previously IIRC - two processes
> > > > > > > keeping the same GPIO lines requested.
> > > > > > >
> > > > > > > I don't have any good idea on how to address this yet. One thing off
> > > > > > > the top of my head is: close the parent's file descriptor from kernel
> > > > > > > space (is it even possible?) on fork() (kind of like the close() on
> > > > > > > exec flag).
> > > > > > >
> > > > > > > I need to think about it more.
> > > > > > >
> > > > > >
> > > > > > I thought the O_CLOEXEC was set on the request fds exactly to prevent this
> > > > > > case - only one process can hold the request fd.
> > > > > >
> > > > >
> > > > > O_CLOEXEC means "close on exec" not "close on fork". When you fork,
> > > > > you inherit all file descriptors from your parent. Only once you call
> > > > > execve() are the fds with this flag closed *in the child*.
> > > > >
> > > >
> > > > Ah, ok.
> > > > You want to pass request fd ownership from parent to child??
> > > > Why not lock ownership to the parent, so O_CLOFORK, were that
> > > > available?
> > > >
> > >
> > > Because what if we want to request a line and then daemonize i.e. fork
> > > and exit in parent? It makes much more sense to keep the lines
> > > requested in the child IMO.
> > >
> >
> > Then you are doing it backwards - daemonize first ;-).
> >
> > Generally speaking, doesn't transfer of resource ownership to the forked
> > child create havoc in multi-threaded apps? i.e. one thread requests a
> > resource, another forks.  The parent thread unknowingly loses ownership,
> > and the forked child process only starts with a replica of the forking
> > thread.
> >
> 
> Yeah, sounds like a bad idea.
> 
> > > During the BoF at Linux Plumbers it was suggested to use
> > > /proc/$PID/fdinfo to expose the information about which lines are
> > > requested but I can't figure out a way to do it elegantly.
> > >
> >
> > Yeah, missed that :-(.
> >
> > Makes sense.
> >
> > As each request fd can contain multiple lines on a particular chip,
> > you would need to identify the gpiochip and the offsets for that request.
> > So two fields - the gpiochip path, and the list of offsets.
> >
> > Is that already too clunky or am I missing something?
> >
> 
> It's worse than that - we don't know the character device's filesystem
> path in gpiolib. Nor should we, as we can be in a different fs
> namespace when checking it than in which we were when we opened the
> device (which is also another concern for storing the path to the
> character device in struct gpiod_chip - unless we specify explicitly
> that it's the path that was used to open it). Since we don't know it -
> we can only get it from the file descriptor that the requesting
> process got after calling open() on the GPIO device. But this fd may
> have been closed in the meantime. I think I opened a can of worms with
> this one. :)
> 

Forgot that we don't have the path readily available in the kernel -
would device name suffice?

Cheers,
Kent.
