Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35718621F71
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKHWpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiKHWpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:45:40 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BBD63CE5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 14:45:37 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id fz10so9534464qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 14:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b/B2+o8hWx+Vy2/gk8SryrziA/1k8CwLOYbP1F5lrYU=;
        b=AEz/PuzKz1OTr6hELS9WBy2xhyf4RDQLn1+30+wb5nF0GFNeAhvs/xiE5JHHi40EML
         NX4IrbG3OYnWy1jjdRnoM27jllftQGKac/ifgeDJEw55SU83fOMIwXnAW/Cc1Ptm+Jh1
         CV9SUnSYkgw6hPpG631J+NjhTW+1uNQ4dLMM975HmabrQZPsvToPcsgZAdKcJz3ViwZy
         dJuouqQsT44LqcP3zV2p33W8vuGQlSBgSMaLbSJtidUmSd0HA7pu0rBFum7Xb06tdYfQ
         C+N0WkeXno0rBMeoIBe+1Lp4qbAiEK52mc7Eb0pt7FwU0X054E8inZF6z5v2Q5ftIqR8
         BEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/B2+o8hWx+Vy2/gk8SryrziA/1k8CwLOYbP1F5lrYU=;
        b=TqloRLQoIkxAy4+kuVz2j6oTpyPQC7UwtyBk6m3064mnNeAuOmv+p7U28pEiL5e5AD
         torWQZEh0aKmkLiVI2MMaF3tD5ydkGiYTQsCrcE4CymjT3JZnLQWnY/5uNtbIVT2JEWN
         wZe1YFXf8rC0Cwxv4MVSTdR9cqBwtLCt/kUVs/oORajwTpIeARIAScFBo0tYDMkddR6E
         Q3VVz3iINud+WydIVk4qeEBuUUxzzTPjYEbCMXX6JJTsEFnp7cExhMDPiep14kktaA+Q
         pc+deiaRSJ0WbBDtsyBHZYgM+D7T/ZBBszEK4H7CMWKYa6KwMXIfpOwkGskHVUMDi7MQ
         Oofw==
X-Gm-Message-State: ACrzQf1Z5UHOAtWZo85VOkbGsePxLLBmhffnI9XARFhMn5xMAT4wQG62
        p3o04QngEz8NH0h72jQqTxAjODygPpg=
X-Google-Smtp-Source: AMsMyM4dhE7TPiusUYk2EqLFu2wVSrGxvU04Z/e+rpnUpFyNmJ/fAhF0DOME8lvqBGkPlK6UYZsZwQ==
X-Received: by 2002:a05:622a:1243:b0:3a5:4666:4122 with SMTP id z3-20020a05622a124300b003a546664122mr28328441qtx.230.1667947536908;
        Tue, 08 Nov 2022 14:45:36 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id y20-20020a37f614000000b006cfaee39ccesm9769226qkj.114.2022.11.08.14.45.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 14:45:36 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id j130so19054325ybj.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 14:45:35 -0800 (PST)
X-Received: by 2002:a25:23d6:0:b0:6ca:7fd:d664 with SMTP id
 j205-20020a2523d6000000b006ca07fdd664mr56857635ybj.85.1667947535381; Tue, 08
 Nov 2022 14:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20221030220203.31210-1-axboe@kernel.dk> <20221030220203.31210-7-axboe@kernel.dk>
 <Y2rUsi5yrhDZYpf/@google.com> <4764dcbf-c735-bbe2-b60e-b64c789ffbe6@kernel.dk>
 <CA+FuTSdawNGXhW0DEf0-R6--1bDh7qByO=ViD_h=BfRe3XaFkw@mail.gmail.com> <33832500-ddf3-dc2b-a765-046d46031991@kernel.dk>
In-Reply-To: <33832500-ddf3-dc2b-a765-046d46031991@kernel.dk>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Nov 2022 17:44:58 -0500
X-Gmail-Original-Message-ID: <CA+FuTScvn016nJAYHDuu0Y4vq6n7mbx96_NiYF75HfYQrRjPKQ@mail.gmail.com>
Message-ID: <CA+FuTScvn016nJAYHDuu0Y4vq6n7mbx96_NiYF75HfYQrRjPKQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] eventpoll: add support for min-wait
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 5:30 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/8/22 3:25 PM, Willem de Bruijn wrote:
> >>> This would be similar to the approach that willemb@google.com used
> >>> when introducing epoll_pwait2.
> >>
> >> I have, see other replies in this thread, notably the ones with Stefan
> >> today. Happy to do that, and my current branch does split out the ctl
> >> addition from the meat of the min_wait support for this reason. Can't
> >> seem to find a great way to do it, as we'd need to move to a struct
> >> argument for this as epoll_pwait2() is already at max arguments for a
> >> syscall. Suggestions more than welcome.
> >
> > Expect an array of two timespecs as fourth argument?
>
> Unfortunately even epoll_pwait2() doesn't have any kind of flags
> argument to be able to do tricks like that... But I guess we could do
> that with epoll_pwait3(), but it'd be an extra indirection for the copy
> at that point (copy array of pointers, copy pointer if not NULL), which
> would be unfortunate. I'd hate to have to argue that API to anyone, let
> alone Linus, when pushing the series.

I did mean for a new syscall epoll_pwait3. But not an array of
pointers, an array of structs. The second arg is then mandatory for
this epoll_pwait_minwait variant of the syscall.

It would indeed have been nicer to be able to do this in epoll_pwait2
based on a flag. It's just doubling the size in copy_from_user in
get_timespec64.

Btw, when I added epoll_pwait2, there was a reasonable request to
also update the manpages and add a basic test to
tools/testing/selftests/filesystems/epoll. That is some extra work with
a syscall based approach.
