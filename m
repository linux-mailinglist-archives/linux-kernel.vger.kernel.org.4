Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1426FFE5E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbjELBWF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 21:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELBWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:22:03 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175CDD8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:22:02 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so16541355e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683854520; x=1686446520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgDasLco+GdQigUb5/W4HcjSSrbAxz78vnk519zrggE=;
        b=Ui06g4FuiYq+9rzRy1UZmWYQHakVhmjbrK4qZE2OalU2udeBPONNc/nb/g32F9oUN/
         6doOk6DSCcoqA24DCcR/OSc92WOIx/TldsAextp3nRLj+iv9lIN16m5SHwYit/jEPo7w
         N4NHC4de/5GLsOieONvETK/mTSN5hxWWL95UdBRyjlFltagxSxk5iiGH8ebfNKUzoFvX
         WtTG3aSOtYi4cmWf2fjH+k2YGqVB0nk6Sd8mYB+MTDfC8pZAPvDwmo75HWHXfwSUp7Oy
         eAj+Kj4U+EHXFVE77+UpqZ0KTzjEAuIXJt986kH76cSdvKQZo3cgPy94q+GhPwrKexZM
         ru1w==
X-Gm-Message-State: AC+VfDxI4SR8gcQK2Js8gwrwjx7kzJ/nQ9SD+LFTwemWqU6qMGtZ1cZd
        uRW459AsCFi92YKYqKnlcnfLC16yhv5VbpZbADc=
X-Google-Smtp-Source: ACHHUZ7PoWysg1C6XFqbJMqj83ij9E5wdlNdYaO6v43lnPKq4/pQeAVHhsckm1FDV/dDoHAPx1IufEzHqOdpk5AOPYo=
X-Received: by 2002:a05:600c:22c4:b0:3f4:ed25:8aa9 with SMTP id
 4-20020a05600c22c400b003f4ed258aa9mr2373124wmg.36.1683854520227; Thu, 11 May
 2023 18:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230425181827.219128101@linutronix.de> <20230425183312.932345089@linutronix.de>
 <ZFUXrCZtWyNG3Esi@lothringen> <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx>
 <878rdy32ri.ffs@tglx> <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx>
 <87ednpyyeo.ffs@tglx> <CANaxB-wV9iUT6=Y9nZCWbJhiscMrnAQh4fUXs7Tb8pr=-HwSYQ@mail.gmail.com>
 <cc8aa6a4-a187-f3ad-fec9-05f037a3886d@virtuozzo.com> <87r0rnciqo.ffs@tglx>
In-Reply-To: <87r0rnciqo.ffs@tglx>
From:   Andrey Vagin <avagin@openvz.org>
Date:   Thu, 11 May 2023 18:21:48 -0700
Message-ID: <CANaxB-xFs2ZYnFBTtQsZxAGAJ6o9cgWM=k=d_EBXuOK5djLgkA@mail.gmail.com>
Subject: Re: [RFD] posix-timers: CRIU woes
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <areber@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 2:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, May 11 2023 at 11:17, Pavel Tikhomirov wrote:
> > On 10.05.2023 16:16, Andrey Vagin wrote:
> >>>
> >>> So because of that half thought out user space ABI we are now up the
> >>> regression creek without a paddle, unless CRIU can accomodate to a
> >>> different restore mechanism to lift this restriction from the kernel.
> >>>
> >> If you give us a new API to create timers with specified id-s, we will
> >> figure out how to live with it. It isn't good to ask users to update
> >> CRIU to work on new kernels, but here are reasons and event improvements
> >> for CRIU, so I think it's worth it.
> >
> > I agree, any API to create timers with specified id-s would work for new
> > CRIU versions.
>
> The real question is whether this will cause any upheaval when a new
> kernel meets a non-updated CRIU stack.


It depends on what you mean by upheaval. We found that CRIU can be stuck
in a busy loop with the new changes. I suggest thinking about how to
work around this case and make sure that CRIU reports an error. The
error should minimize the time that users will need to spend to find the
reason and ways to resolve the problem.

One of the ways to fix the problem is to return indexes in a backward
direction from INT_MAX to zero. But in the kernel, user indices can be
converted back to "normal" values:
kernel_timer_id = INT_MAX - user_timer_id;

I have one idea of how to make these changes without breaking CRIU. CRIU
does a few special things. First, it does all timer operations from a
thread leader.  Second, it calls timer_settime only after creating all
timers. Third, it calls timer_delete for the last timer only. Any of
these events can be a trigger to switch to the new algo of allocating
timer id-s, but new processes allocate indices according to old rules.
It seems unfortunate that a real application will create a set of very
sparse indices without triggering one of these events.
I don't think that it is worth doing something like this, but if we want to
strictly follow the rules, it is the choice.

>
> You know the UABI regression rules of the kernel...

There is no rule without exceptions... With all pros and cons, we may
consider this case as an exception. From our side, we will try to make
everything to minimize the impact. Here are steps off the top of my
head:
* releasing the criu fix before the kernel release.
* update packages in Linux distros (Debian, Ubuntu, Fedora, and
  others that we will find).
* send an announcement to the criu mailing list and to users that we know.
* add the error to FAQ.
* create a GitHub issue with a full description.

Thanks,
Andrei
