Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52246672B59
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjARWea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjARWe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:34:29 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61055CFC8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:34:27 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bf43so526210lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qIyF+TLh63sFETTbADGjZbXxzqLCPo1XlBKdL830OE=;
        b=OddL8xIsa85SIi+6/ASkZktVljH02QnK8RJTYbc/3pXq3fCaC7Rxqlhvbm7oMEC+FM
         BDkXwMUrvvNJkTU6D/xVpKnKJpz/7S2LzgD2bk0ag6hLgiddzDqaIWlK2JsCmbEzNelM
         I5elnDY85lSTRkfzBIvPTu0LbGHhoRkX0gZVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qIyF+TLh63sFETTbADGjZbXxzqLCPo1XlBKdL830OE=;
        b=gLaahGEQQ1rB8/mg4yUI7+nJHMGnlr/VC7QH9uy/0R3fQQXr2HdYu+nUnhRphstptA
         xM8q+pqad5owi0tKmHtXpWyM5uqMKQBR4umqo78L33dadxTuyIIdtlCB7cz1EXTZqpKG
         P8MbYktWO6mJha88KDbQim80A6hWJ0f8/GxXA/V0pDYO6OE7Ig4kxEgcXs5yqGTtlOTG
         nJx/88wD/0CnatspHqbSU8HQj5xi65+DJF3MWw+EX1WLdyVAV4yZhiJpssenm0PhnE+o
         gxGuzz9feOYT8sG7flnpJ8LVGs3Eoqgf+QMu/dj6c8kvKkI5iyP8yy+rNazeZjiNjzH7
         F9Ew==
X-Gm-Message-State: AFqh2koICAz/O1K0zSamh2NVBWs4DAfUxivcfkXanm52LW5lH60A9o9e
        6TTHhP0ROORzKZON8cs9xu8VX0E6W0NX4wYlrCcvAA==
X-Google-Smtp-Source: AMrXdXumfMYoFquw57PbwkvIhJ708dlixL/3hhgXrqsOHBxhwFrsnTJTGXRN8LdynqDPxFxFcRzGJxy7pU6o/8/bf/E=
X-Received: by 2002:ac2:55a1:0:b0:4b5:7374:90a9 with SMTP id
 y1-20020ac255a1000000b004b5737490a9mr374530lfg.145.1674081266151; Wed, 18 Jan
 2023 14:34:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Jan 2023 16:34:25 -0600
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VeBBFTZBjZNhMUBO1uTNKBwcgZM6ehnw3BGmervE7jXA@mail.gmail.com>
References: <1672193785-11003-1-git-send-email-quic_khsieh@quicinc.com>
 <1672193785-11003-3-git-send-email-quic_khsieh@quicinc.com> <CAD=FV=VeBBFTZBjZNhMUBO1uTNKBwcgZM6ehnw3BGmervE7jXA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 18 Jan 2023 16:34:25 -0600
Message-ID: <CAE-0n50JB211OhA7pqj6U3rfBeeS0ofzY_moE77REmY2awo7bA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drm/msm/dp: enhance dp controller isr
To:     Doug Anderson <dianders@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@gmail.com, agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2023-01-18 10:29:59)
> Hi,
>
> On Tue, Dec 27, 2022 at 6:16 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> > +
> >         if (isr & DP_INTR_AUX_ERROR) {
> >                 aux->aux_error_num = DP_AUX_ERR_PHY;
> >                 dp_catalog_aux_clear_hw_interrupts(aux->catalog);
> > +               ret = IRQ_HANDLED;
> >         }
>
> The end result of the above is a weird mix of "if" and "else if" for
> no apparent reason. All except one of them just updates the exact same
> variable so doing more than one is mostly useless. If you made it
> consistently with "else" then the whole thing could be much easier,
> like this (untested):

Totally agreed. I even asked that when I posted the RFC[1]!

"Can we also simplify the aux handlers to be a big pile of
if-else-if conditions that don't overwrite the 'aux_error_num'? That
would simplify the patch below."

> > @@ -425,17 +464,15 @@ void dp_aux_isr(struct drm_dp_aux *dp_aux)
> >
> >         /* no interrupts pending, return immediately */
> >         if (!isr)
> > -               return;
> > +               return IRQ_NONE;
> >
> >         if (!aux->cmd_busy)
> > -               return;
> > +               return IRQ_NONE;
> >
> >         if (aux->native)
> > -               dp_aux_native_handler(aux, isr);
> > +               return dp_aux_native_handler(aux, isr);
> >         else
> > -               dp_aux_i2c_handler(aux, isr);
> > -
> > -       complete(&aux->comp);
> > +               return dp_aux_i2c_handler(aux, isr);
>
> Personally, I wouldn't have done it this way. I guess that means I
> disagree with Stephen. I'm not dead-set against this way and it's fine
> if you want to continue with it. If I were doing it, though, then I
> would always return IRQ_HANDLED IF dp_catalog_aux_get_irq() returned
> anything non-zero. Why? Officially if dp_catalog_aux_get_irq() returns
> something non-zero then you know for sure that there was an interrupt
> for this device and officially you have "handled" it by acking it,
> since dp_catalog_aux_get_irq() acks all the bits that it returns. That
> means that even if dp_aux_native_handler() or dp_aux_i2c_handler()
> didn't do anything with the interrupt you at least know that it was
> for us (so if the IRQ is shared we properly report back to the IRQ
> subsystem) and that it won't keep firing over and over (because we
> acked it).

I'm primarily concerned with irq storms taking down the system. Can that
happen here? If not, then returning IRQ_NONE is not really useful. The
overall IRQ for DP looks to be level, because the driver requests the
IRQ that way. The aux interrupt status bits look to be edge style
interrupts though, because the driver acks them in the handler. I guess
that means the edges come in and latch into the interrupt status
register so the driver has to ack all of them to drop the IRQ level for
the overall DP interrupt? If the driver only acked the bits it looked at
instead of all interrupt bits in the register, then the level would
never go down for the IRQ if an unhandled interrupt bit was present like
'DP_INTR_PLL_UNLOCKED'. That would mean we would hit spurious IRQ
handling very quickly if that interrupt bit was ever seen.

But the driver is acking all interrupts, so probably trying to work
IRQ_NONE into this code is not very useful? The only thing it would
catch is DP_INTR_PLL_UNLOCKED being set over and over again, which seems
unlikely. Of course, why is this driver unmasking interrupt bits it
doesn't care about? That may be leading to useless interrupt handling in
this driver if some interrupt bit is unmasked but never looked at. Can
that be fixed in another patch?

>
> NOTE: I still like having the complete() call in
> dp_aux_native_handler() and dp_aux_i2c_handler() and, to me, that part
> of this patch is worthwhile. That makes it more obvious that the code
> is truly expecting that complete to be called for all error cases as
> well as transfer finished.
>

I think it may be required. We don't want to allow DP_INTR_PLL_UNLOCKED
to complete() the transfer.

[1] https://lore.kernel.org/all/CAE-0n5100eGC0c09oq4B3M=aHtKW5+wGLGsS1jM91SCyZ5wffQ@mail.gmail.com/
