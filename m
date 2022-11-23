Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B1636B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiKWUcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiKWUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:31:21 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EEC633D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:29:18 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id e26so6703987uaa.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kLXsXSr0QtnCbQ9haWU7vYJFI/CTwk9Wy76ZUUM5pjI=;
        b=j7CFSGEbyVpo7nAJTcl7vifTrIu1wWdn9vzwkme16ZTA36Ic2uQwGD5mBCwqLyFr08
         09gkP/QvYwauZVNMN/IL0Ng0YE1x+dsYq8LTD999L7CV6BAWJvUKe5GYSVy22x/vLmxb
         HKliLvRYqpaG4y/Hb7HROl/rgQ33wGIjXn6pN4k2np4ciDXKvZ1w+8Xs8GA+mSY6UbcB
         zeNHJWRegwzoX086DeWwm9E62hKNNtYPqhvbCph6qq9+NYFI5DUO6dNgUfmhRtqimbhx
         X3dMCdBH4V3hnBLl6Lrtj0DP5QSP/jGN1BuLmTc5TyBo8+OcST03DvAjkKPtwwYpAi0Q
         XjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLXsXSr0QtnCbQ9haWU7vYJFI/CTwk9Wy76ZUUM5pjI=;
        b=jRhZP3AjT4EHidMTMjxL/Fk+Y5RnPSR1lUz1CgUqPS6UEAtAW1Gh81Etk+7gwStFRo
         iSsrxPixKH5zSKU55bBUs/nP5KsmqHA73ZwauaEDmj1AM9uPnGzYo4wUecyoEXQin0Ww
         jqbCyYL7UZ2z2KSBZ1y0mqgSSY+YQHOkBxc+emvDEA/NIF6z/BcHAuIsMPs46jteDDZV
         q9zck9RkZVMAiiWWqnL4SNu9NrQFZ3xOTjZrd17PVCvm2yOLTQJc8TucAb0Jw/nMozD6
         o8sFktncMbvq5bmongqxJvTyuI9zOd+DUImkPCfG2Twjx25yJ1B9JTlehGd4PWSC4es9
         0bvg==
X-Gm-Message-State: ANoB5pm8ZFAOHy+jqW/p6FlVWez+dB9+SeUqTeGdtZEyjso9jSSuLwrA
        EZQj7fndHtqcZTInqARUPXBRYp1zDElj+xs46d9E
X-Google-Smtp-Source: AA0mqf4qDAlXk6kJtTuQiCzBcCpNPoOzEie3uJLGYf/t26VHDBO9vGh1/SIPwBtlhc13xCagko5dZsY8Uq1gTfpyI+I=
X-Received: by 2002:ab0:374a:0:b0:414:5de7:23ab with SMTP id
 i10-20020ab0374a000000b004145de723abmr6699709uat.52.1669235357288; Wed, 23
 Nov 2022 12:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20221121055345.111567-1-jake.macneal@gmail.com>
 <CANDhNCqCYkv7Ja4RT2_DEPh2zFFL+SD82wru_FC6dupCo6_4RA@mail.gmail.com> <7d95f4bb-01a3-44db-af08-275daa9ffb1e@app.fastmail.com>
In-Reply-To: <7d95f4bb-01a3-44db-af08-275daa9ffb1e@app.fastmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 23 Nov 2022 12:29:05 -0800
Message-ID: <CANDhNCqzLxsAx=XRBdL554SDZ83vQonnppTQPKgB6=RDhw_XjA@mail.gmail.com>
Subject: Re: [PATCH] time: copy tai value (International Atomic Time, in
 seconds) to output __user struct in get_old_timex32().
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jacob Macneal <jake.macneal@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
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

On Wed, Nov 23, 2022 at 11:53 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Nov 23, 2022, at 19:54, John Stultz wrote:
> > On Sun, Nov 20, 2022 at 9:54 PM Jacob Macneal <jake.macneal@gmail.com> wrote:
> >> --- a/kernel/time/time.c
> >> +++ b/kernel/time/time.c
> >> @@ -311,6 +311,7 @@ int get_old_timex32(struct __kernel_timex *txc, const struct old_timex32 __user
> >>         txc->calcnt = tx32.calcnt;
> >>         txc->errcnt = tx32.errcnt;
> >>         txc->stbcnt = tx32.stbcnt;
> >> +       txc->tai = tx32.tai;
> >>
> >
> > This does seem like something that was overlooked.
> >
> > Arnd: There isn't something more subtle I'm missing here, right?
>
> I agree. Looking at the git history, it seems that the tai field
> was added a long time ago in 153b5d054ac2 ("ntp: support for TAI").
> The commit correctly did the conversion for copying the data out
> of the kernel and did not copy the value in because it wasn't
> needed at the time.
>
> I don't see any user of the tai field that gets copied into
> the kernel, so the bug appears harmless, but Jacob's fix is

Oh, right. There is a quirk of the adjtimex ADJ_TAI interface (added
in 153b5d054ac2) where it for some reason used the constant field
instead of the newly added tai field.
So we never should be using the tai field value from userspace (only
writing it out), which might have been the reason it was not copied
over.

> nevertheless correct, as we should not use any uninitialized
> data in a structure that comes from userspace.

Agreed.

thanks
-john
