Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC79C69D263
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjBTRwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBTRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:52:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719BEC17D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:52:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 99so2194423pjz.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YwTsoCMa/V1gTYYuSA5z69FEgzpv/tbR2gZTYmJ/z78=;
        b=Z/sNe6AaCnui9Dkw4fJQwf7vTmzNoOcVOGW8Hi5pSg+9UnjvOKXAghHJ89onXLOnei
         sNsEgVmiKBCZ3uB9PQE3WTN0D4gbbp38MIRXvIliU2R4Vu14HpAja8xPGkvKfuXJjGF4
         wnsZurMIExzKmDRbMa8UvEbGgCLxtsFcKV3xxfC+WqeUb7K1YgfzeaDAkEEs+uhOyrFc
         WF66lyIv/0MzQ2Z0+rbo99jXPEy/uM4cHj7A/DTxUVh+gArTUYXtTVtahPE3UcKW3qVM
         b/w/AVuVKBeMB3GJLtdIeJz3TnXT5nYh63plBs2qzM8UWbJd8xruiwU5hSFGhAEsmbAw
         KlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwTsoCMa/V1gTYYuSA5z69FEgzpv/tbR2gZTYmJ/z78=;
        b=cxnVKlgRCmcFpS03etxvzCSKdv0QVx4eZU7cNuQ6PTYOKKfqYZrO5cmkzGjgq/t8Y+
         URVH15NakfaBWTqRk1HRm6kemI+TRgRiy0SUf7GKlaIsmY8ITKvhSlJOLNn4kP/9WDmq
         6WkiDAQDMln+0pcbaM1sLRGhoKA+ZlXbRqOHmsdtsc+W8lIt/kLlkR0r3U/XCeXl0qHw
         dyt+OGW90DelTl8nUngLlhUB0IkqWo7e4n2x90gC0c8dlTUPIl6XRbPOXxCZfWlIg9cw
         nGO07aK/PIhxvRZ/zvZXE3c4dJEBisV1JzrzAz4PDCl1fPTjy/ZlJVpQ6IahT1NHw87+
         OOvw==
X-Gm-Message-State: AO0yUKVgTA3Ke3jtJLAA4U5oD2UzBM8NCbME/rZPnhNY/cAr/OYH1rvt
        ZuQTmS+vyQSYZGmm1+NHQSY/5QGw5l/thnQN7ZwyzQ==
X-Google-Smtp-Source: AK7set9HH2AB7Up4oqzxC3/XWL+VahulJhrsTM4J84LjshRnQWtPViLHfZ5qKaU3rd1y1pW4jDXXVSJb1ng73RXEbP8=
X-Received: by 2002:a17:90b:48cf:b0:236:8e3e:1cd7 with SMTP id
 li15-20020a17090b48cf00b002368e3e1cd7mr1389946pjb.111.1676915551451; Mon, 20
 Feb 2023 09:52:31 -0800 (PST)
MIME-Version: 1.0
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
 <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org> <Y/OV3CF0ootyooDJ@linaro.org>
 <Y/OfjbxI1tHYJHNv@linaro.org>
In-Reply-To: <Y/OfjbxI1tHYJHNv@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 20 Feb 2023 09:51:55 -0800
Message-ID: <CAGETcx_mD3pbAmT5FDZaVAsKb_2PAnrHL8B_6gSR=+a0O4kHfQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for disabling
 unused clocks
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 8:28 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 23-02-20 17:46:36, Abel Vesa wrote:
> > On 23-02-17 21:38:22, Stephen Boyd wrote:
> > > Quoting Abel Vesa (2022-12-27 12:45:27)
> > > > There are unused clocks that need to remain untouched by clk_disable_unused,
> > > > and most likely could be disabled later on sync_state. So provide a generic
> > > > sync_state callback for the clock providers that register such clocks.
> > > > Then, use the same mechanism as clk_disable_unused from that generic
> > > > callback, but pass the device to make sure only the clocks belonging to
> > > > the current clock provider get disabled, if unused. Also, during the
> > > > default clk_disable_unused, if the driver that registered the clock has
> > > > the generic clk_sync_state_disable_unused callback set for sync_state,
> > > > skip disabling its clocks.

Hi Abel,

We have the day off today, so I'll respond more later. Also, please cc
me on all sync_state() related patches in the future.

I haven't taken a close look at your series yet, but at a glance it
seems incomplete.

Any reason you didn't just try to revive my series[1] or nudge me?
[1]- https://lore.kernel.org/lkml/20210407034456.516204-3-saravanak@google.com/

At the least, I know [1] works on all Android devices (including
Qualcomm SoCs) released in the past 2-3 years or more. If [1] works
for you, I'd rather land that after addressing Stephen's comments
there (I remember them being fairly easy to address comments) instead
of whipping up a new series that's not as well used. I just got busy
with other things and addressing more fundamental fw_devlink TODOs
before getting back to this.

Hi Bjorn,

I see in another reply you've said:

Applied, thanks!

[1/2] clk: Add generic sync_state callback for disabling unused clocks
      commit: 26b36df7516692292312063ca6fd19e73c06d4e7
[2/2] clk: qcom: sdm845: Use generic clk_sync_state_disable_unused callback
      commit: 99c0f7d35c4b204dd95ba50e155f32c99695b445

Where exactly have you applied them? I hope you haven't applied the
clk.c changes to some tree that goes into 6.3.

-Saravana

> > >
> > > How does that avoid disabling clks randomly in the clk tree? I'm
> > > concerned about disabling an unused clk in the middle of the tree
> > > because it doesn't have a driver using sync state, while the clk is the
> > > parent of an unused clk that is backed by sync state.
> > >
> > >    clk A -->  clk B
> > >
> > > clk A: No sync state
> > > clk B: sync state
> > >
> > > clk B is left on by the bootloader. __clk_disable_unused(NULL) is called
> > > from late init. Imagine clk A is the root of the tree.
> > >
> > >     clk_disable_unused_subtree(clk_core A)
> > >       clk_disable_unused_subtree(clk_core B)
> > >         if (from_sync_state && core->dev != dev)
> > >           return;
> > >       ...
> > >       clk core A->ops->disable()
> > >
> > > clk core B is off now?
> >
> > Yes, that is correct. But the same thing is happening currently if the
> > clk_ignore_unused in not specified. At least with this new approach, we
> > get to leave unused clocks enabled either until sync_state is called or forever.
> > All the provider has to do is to implement a sync_state callback (or use
> > the generic one provided). So the provider of clk A would obviously need
> > a sync state callback registered.
> >
> > >
> > > Also sync_state seems broken right now. I saw mka mentioned that if you
> > > have a device node enabled in your DT but never enable a driver for it
> > > in the kernel we'll never get sync_state called. This is another
> > > problem, but it concerns me that sync_state would make the unused clk
> > > disabling happen at some random time or not at all.
> >
> > Well, the fact that the sync state not being called because a driver for
> > a consumer device doesn't probe does not really mean it is broken. Just
> > because the consumer driver hasn't probed yet, doesn't mean it will
> > not probe later on.
> >
>
> CC'ed Saravana
>
> > That aside, rather than going with clk_ignore_unused all the time on
> > qcom platforms, at least in a perfect scenario (where sync state is
> > reached for all providers) the clocks get disabled.
> >
> > >
> > > Can the problem be approached more directly? If this is about fixing
> > > continuous splash screen, then I wonder why we can't list out the clks
> > > that we know are enabled by the bootloader in some new DT binding, e.g.:
> > >
> > >     clock-controller {
> > >             #clock-cells = <1>;
> > >             boot-handoff-clocks = <&consumer_device "clock cells for this clk provider">;
> > >     };
> > >
> > > Then mark those as "critical/don't turn off" all the way up the clk tree
> > > when the clk driver probes by essentially incrementing the
> > > prepare/enable count but not actually touching the hardware, and when
> > > the clks are acquired by clk_get() for that device that's using them
> > > from boot we make the first clk_prepare_enable() do nothing and not
> > > increment the count at all. We can probably stick some flag into the
> > > 'struct clk' for this when we create the handle in clk_get() so that the
> > > prepare and enable functions can special case and skip over.
> >
> > Well, that means we need to play whack-a-mole by alsways adding such clocks to
> > devicetree.
> >
> > >
> > > The sync_state hook operates on a driver level, which is too large when
> > > you consider that a single clk driver may register hundreds of clks that
> > > are not related. We want to target a solution at the clk level so that
> > > any damage from keeping on all the clks provided by the controller is
> > > limited to just the drivers that aren't probed and ready to handle their
> > > clks. If sync_state could be called whenever a clk consumer consumes a
> > > clk it may work? Technically we already have that by the clk_hw_provider
> > > function but there isn't enough information being passed there, like the
> > > getting device.
> >
> > Actually, from the multitude of clocks registered by one provider, the
> > ones already explicitely enabled (and obvisously their parents) by thier
> > consumer are safe. The only ones we need to worry about are the ones that
> > might be enabled by bootloader and need to remain on. With the sync state
> > approach, the latter mentioned clocks will either remain on indefinitely
> > or will be disabled on sync state. The provider driver is the only level
> > that has a registered sync state callback.
> >
> > >
> > > > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > > > index 842e72a5348f..cf1adfeaf257 100644
> > > > --- a/include/linux/clk-provider.h
> > > > +++ b/include/linux/clk-provider.h
> > > > @@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
> > > >                 void __iomem *reg, u8 shift, u8 width,
> > > >                 u8 clk_divider_flags, const struct clk_div_table *table,
> > > >                 spinlock_t *lock);
> > > > +void clk_sync_state_disable_unused(struct device *dev);
> > >
> > > This is a weird place to put this. Why not in the helper functions
> > > section?
> >
> > Sure this can be moved.
> >
> > >
> > > >  /**
> > > >   * clk_register_divider - register a divider clock with the clock framework
> > > >   * @dev: device registering this clock
