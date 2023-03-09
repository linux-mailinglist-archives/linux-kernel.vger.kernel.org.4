Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C826B1BF0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCIHFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCIHFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:05:07 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43BEA3B40
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:05:06 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y144so927920yby.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678345506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9rHV3+H80sjb9FseoTvNtFIJAiDi3ttjqlwQz/KNDA=;
        b=sDlRlAX5NXeIJ7UDbivSsXRq2S7rVC+G7M6kfa0K0XbrkJSneVX3O/d5fNlEq08xPr
         ASSQHz3dDeCsjljQ17TM/1SWammddKbhnl4dU+j5BlQQsNR8jsLclttRvBMwz1x/kwje
         YVAG/8n2BuVstzet858cTl6zGK9SSfqxSj2moyo7nDnrMy8qbPT83qWvO2joNj4D/GDO
         Rd9Y0J/V7IS/hI0di8FZbv8INklCxAJSTj2uooAj+FduEa0PQ9iSra7NCChiWmhnA4L9
         PMPoLGSIlKbUP9I/UK7qTKYHqEqNLTbFpBwHb6HLGeinpTgvV8AKeljwMrfOKakzcNBZ
         PoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678345506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9rHV3+H80sjb9FseoTvNtFIJAiDi3ttjqlwQz/KNDA=;
        b=t1XAuChANfPlBOFe0aMIcfMkRkWgT5WkemGGkZ4QYYE8KjRwcDMdo8Lg5gcw58wVaG
         Rt+A4YxN847bttLKB0QkzDvsGfnNx59/CLyXHMbTvbyYA1FnoRjKYu860n8FihA4LGoY
         Z5zGov9vP/L5tm4sbE57JGWpzXBkLynsLFjytaKOhUH1CM8GBAJUFV1isaTHBFqxEzj5
         eqyVwUnkgt4oov6EPgA6+9p2p7yWKE2Nw3vwpItnvRz6wyWN2DOtmOn3kUR7XzmNgSFI
         23GPksZf/QGFoygwLETsmkkK0Zapeirc4blXqJifZMzGXqsc/mAkT4AG0/4YnM/XPdLT
         VCkQ==
X-Gm-Message-State: AO0yUKWXYbCxBbK2aOuW8RQFbdYCxejXcZSqP1ZuVgQv6nJKiUvDqHy3
        qwkB88bK7RYZ4RioOo1cRVdSPFE51PsOkZ37ZiPuDs8Gy0wOJQpELA==
X-Google-Smtp-Source: AK7set/r6xpVSnzN6XsKGj2pCkpq1ONQENhZcDgA0dnNCt0nQqxCLlxjbr5D0JZX0dR2RJIqLyDnGLm8OqMwwiDcMSo=
X-Received: by 2002:a5b:f03:0:b0:a74:87b0:4090 with SMTP id
 x3-20020a5b0f03000000b00a7487b04090mr5655128ybr.3.1678345505982; Wed, 08 Mar
 2023 23:05:05 -0800 (PST)
MIME-Version: 1.0
References: <fb8d80434b2148e78c0032c6c70a8b4d@huawei.com> <CANDhNCqfBdh8zUd+LseTTQKpmJ27Uid+ZV_+FNckZPNc2Oy3-w@mail.gmail.com>
 <760bbd9618154505b5f17640d1437afb@huawei.com>
In-Reply-To: <760bbd9618154505b5f17640d1437afb@huawei.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 8 Mar 2023 23:04:55 -0800
Message-ID: <CANDhNCqYrTNjFJd7DPcgu-hpkOzdG=cppq8eTFghi1a1MSFmDA@mail.gmail.com>
Subject: Re: [Question] softlockup in run_timer_softirq
To:     "liujian (CE)" <liujian56@huawei.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 3, 2023 at 2:55=E2=80=AFAM liujian (CE) <liujian56@huawei.com> =
wrote:
> From: liujian (CE)
> > From: John Stultz [mailto:jstultz@google.com]
> > > On Fri, Feb 10, 2023 at 1:51 AM liujian (CE) <liujian56@huawei.com> w=
rote:
> > > > Can we limit the running time of __run_timers() [2]?
> > > >
> > > > Does anyone have a good idea to solve this problem?
> > >
> > > So your patch reminds me of Peter's softirq_needs_break() logic:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/=
?
> > > h=3Dco
> > > re/softirq
> > >
> > > Maybe it could extend that series for the timer softirq as well?
> > >
> > Thank you. Yes.
> > Base on the patchset and the extended patch for timer [1], the soft loc=
kup
> > problem does not occur.
> >
> > By the way, I see this is a very old patchset?  Will this patchset push=
 the main
> > line? @John @Peter
> >
> Hi, peter,
> Do you have an upstream plan for this patchset? Or other ideas.
> I want to use softirq_needs_break() to limit the runtime of timer soft in=
terrupt handler function, wonder if this is appropriate?

My understanding is that the series was proposed but maybe caused some
regressions for the networking softirqs it was initially targeting, so
it's been stalled out.

However, if you utilize the logic to help with the timer softirq
first, that might help land the logic, and then the networking folks
can try to adapt and slowly sort out the regressions.
So I'd suggest if you have the patches working for softirqs and
showing benefit, submit them for review.

I personally was looking at the series for the block softirq (which I
got working against a 5.10 kernel), but unfortunately that code has
since been reworked to use lockless lists for its work items, it's
hard to stop if the need_break signal is set, as once we've dequeued
list entries from the list, we have to run them, as we can't easily
re-add them back in the proper list order. :/   Something I need to
re-visit eventually.

thanks
-john
