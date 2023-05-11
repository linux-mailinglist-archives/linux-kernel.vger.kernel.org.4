Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A8E6FF1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbjEKM6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbjEKM6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:58:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9791C268B
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:58:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f315712406so284627705e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683809900; x=1686401900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mU6P1e5+4Xl8Bpy2fjdcYeE81cfd4b/6UBOEOmWNG6w=;
        b=kgx9Gt4BXZh5aRNkCN33QpSN6nItFvh8EUJX9XC62edw0kMW0sMq4sO/fTpPRiS9HQ
         xr8v2ax803lyFIp7Qo//NYBD4xH5ipWs8BiGsB9fhJ1JXKwhBKip5AkW8W2EnD2ZWLvI
         SZKne4t8kEEFO5ebEEjSsmgHltZiTg4uiWYGMoAfawnU8oGbUaaitPIBhjOOqtSFsoNA
         5F/pP53939UA+Wiz3G9BxJrHw2EPxWRhti2CYwsYUvdTetIfsb57a1sqPL91CG9NWwdY
         ONzIJBzvQpfjYdcJwqrRQdwSjqX36eXJhYTHKEdSPhcR6ipF4h4ZJ59YRzNVSrfvIMKG
         TKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683809900; x=1686401900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU6P1e5+4Xl8Bpy2fjdcYeE81cfd4b/6UBOEOmWNG6w=;
        b=YNrZVoNIPdX/O6qatL8J3OZ2o3a0cN9d74Iezz9QjDWrMB1cDYMxfbUY7RDGYtsnTN
         35ftsxAKPTEz9VfHKLOQCY1xYVbmSxHTTScKnVX/gB5X84OwzLzkIRYru0k7cmeIqk80
         +x6Ph/NfFt7wS6WcKKv35q4BdkVrIu82WQ/QXGd5cIk/4tJz+n49WKWoseGw2rWmMfSx
         VOcIojp/A1bpluBhSfRvg0a6mtxUuOu8PYQjYqJJVCdP586uREokw0Ga1PHFq8G5clbY
         s/KxcJEwIUVe9ZlTZ3nR2op7+/P8Zrz5WJsH1kLhK/yfX0pvcMvHW/nv5tIUzVwVB3yG
         eigw==
X-Gm-Message-State: AC+VfDwin0e8mT9+G6GjMA6VkGEvY6c3f0Mg4khzIlQ4Ijp/JwGEsjI7
        ewbJc9OrkH7s/j5YTcy1kPt0zw==
X-Google-Smtp-Source: ACHHUZ5pru7jo+OrktILu9OGEvB3oapcBP6a97zjnrxab9iWoPW9uVlzcCQgeDmLs/AhOTHwp77zKA==
X-Received: by 2002:adf:e904:0:b0:306:2d81:341d with SMTP id f4-20020adfe904000000b003062d81341dmr18873867wrm.24.1683809899942;
        Thu, 11 May 2023 05:58:19 -0700 (PDT)
Received: from linaro.org ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id p26-20020a05600c205a00b003f4f1b884b3sm39829wmg.20.2023.05.11.05.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:58:19 -0700 (PDT)
Date:   Thu, 11 May 2023 15:58:17 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for
 disabling unused clocks
Message-ID: <ZFzmaavGYy4isU7J@linaro.org>
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
 <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org>
 <Y/OV3CF0ootyooDJ@linaro.org>
 <Y/OfjbxI1tHYJHNv@linaro.org>
 <CAGETcx_mD3pbAmT5FDZaVAsKb_2PAnrHL8B_6gSR=+a0O4kHfQ@mail.gmail.com>
 <Y/PALlrQpwPlum9M@linaro.org>
 <CAGETcx_TZN3=GKrEf5fy_tA=JnOfw7m-N=+hD=qhe_yRRpngPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_TZN3=GKrEf5fy_tA=JnOfw7m-N=+hD=qhe_yRRpngPw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-21 11:58:24, Saravana Kannan wrote:
> On Mon, Feb 20, 2023 at 10:47 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > On 23-02-20 09:51:55, Saravana Kannan wrote:
> > > On Mon, Feb 20, 2023 at 8:28 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > > >
> > > > On 23-02-20 17:46:36, Abel Vesa wrote:
> > > > > On 23-02-17 21:38:22, Stephen Boyd wrote:
> > > > > > Quoting Abel Vesa (2022-12-27 12:45:27)
> > > > > > > There are unused clocks that need to remain untouched by clk_disable_unused,
> > > > > > > and most likely could be disabled later on sync_state. So provide a generic
> > > > > > > sync_state callback for the clock providers that register such clocks.
> > > > > > > Then, use the same mechanism as clk_disable_unused from that generic
> > > > > > > callback, but pass the device to make sure only the clocks belonging to
> > > > > > > the current clock provider get disabled, if unused. Also, during the
> > > > > > > default clk_disable_unused, if the driver that registered the clock has
> > > > > > > the generic clk_sync_state_disable_unused callback set for sync_state,
> > > > > > > skip disabling its clocks.
> > >
> > > Hi Abel,
> > >
> > > We have the day off today, so I'll respond more later. Also, please cc
> > > me on all sync_state() related patches in the future.
> > >
> >
> > Sure thing.
> >
> > > I haven't taken a close look at your series yet, but at a glance it
> > > seems incomplete.
> > >
> > > Any reason you didn't just try to revive my series[1] or nudge me?
> > > [1]- https://lore.kernel.org/lkml/20210407034456.516204-3-saravanak@google.com/
> >
> > This patchset is heavily reworked and much more simpler as it relies
> > strictly on the sync_state being registered by the clock provider.
> 
> It's simpler because it's not complete. It for sure doesn't handle
> orphan-reparenting. It also doesn't make a lot of sense for only some
> clock providers registering for sync_state(). If CC-A is feeding a
> clock signal that's used as a root for clocks in CC-B, then what
> happens if only CC-B implements sync_state() but CC-A doesn't. The
> clocks from CC-B are still going to turn off when CC-A turns off its
> PLL before CC-B registers.

I gave your patchset a try and it breaks the uart for qcom platforms.
That is because your patchset enables the clock on __clk_core_init and
does not take into account the fact that 'boot enabled' clocks should be
left untouched. This also means the orphan-reparenting enabling should
be dropped as well.

As for the second part, related to providers that might not have a
registered sync_state(), your patchset sets the clock core generic
one. This is also wrong because it doesn't take into account the fact
that there might be providers that need to do their own stuff on
sync_state() and should do that by registering their own implementation
of it.

Therefore, I'll respin your patchset and use only the skipping of
disabling the unused clocks, but I'll drop all the enable on init and orphan
reparenting changes.

> 
> Nack for this patch.
> 
> Also, unless there's a strong objection, let's go back to my patch
> please. It's way more well tested and used across different SoCs than
> this patch. Also, I'm pretty sure the orphan handling is needed for
> qcom SoC's too.
> 
> -Saravana
> 
> >
> > I saw your patchset a few months ago but then forgot about its
> > existence. That's also why I forgot to nudge you. Sorry about that.
> >
> > >
> > > At the least, I know [1] works on all Android devices (including
> > > Qualcomm SoCs) released in the past 2-3 years or more. If [1] works
> > > for you, I'd rather land that after addressing Stephen's comments
> > > there (I remember them being fairly easy to address comments) instead
> > > of whipping up a new series that's not as well used. I just got busy
> > > with other things and addressing more fundamental fw_devlink TODOs
> > > before getting back to this.
> > >
> > > Hi Bjorn,
> > >
> > > I see in another reply you've said:
> > >
> > > Applied, thanks!
> > >
> > > [1/2] clk: Add generic sync_state callback for disabling unused clocks
> > >       commit: 26b36df7516692292312063ca6fd19e73c06d4e7
> > > [2/2] clk: qcom: sdm845: Use generic clk_sync_state_disable_unused callback
> > >       commit: 99c0f7d35c4b204dd95ba50e155f32c99695b445
> > >
> > > Where exactly have you applied them? I hope you haven't applied the
> > > clk.c changes to some tree that goes into 6.3.
> >
> > I think it is already part of Bjorn's Qualcomm clocks pull request.
> >
> > >
> > > -Saravana
> > >
> > > > > >
> > > > > > How does that avoid disabling clks randomly in the clk tree? I'm
> > > > > > concerned about disabling an unused clk in the middle of the tree
> > > > > > because it doesn't have a driver using sync state, while the clk is the
> > > > > > parent of an unused clk that is backed by sync state.
> > > > > >
> > > > > >    clk A -->  clk B
> > > > > >
> > > > > > clk A: No sync state
> > > > > > clk B: sync state
> > > > > >
> > > > > > clk B is left on by the bootloader. __clk_disable_unused(NULL) is called
> > > > > > from late init. Imagine clk A is the root of the tree.
> > > > > >
> > > > > >     clk_disable_unused_subtree(clk_core A)
> > > > > >       clk_disable_unused_subtree(clk_core B)
> > > > > >         if (from_sync_state && core->dev != dev)
> > > > > >           return;
> > > > > >       ...
> > > > > >       clk core A->ops->disable()
> > > > > >
> > > > > > clk core B is off now?
> > > > >
> > > > > Yes, that is correct. But the same thing is happening currently if the
> > > > > clk_ignore_unused in not specified. At least with this new approach, we
> > > > > get to leave unused clocks enabled either until sync_state is called or forever.
> > > > > All the provider has to do is to implement a sync_state callback (or use
> > > > > the generic one provided). So the provider of clk A would obviously need
> > > > > a sync state callback registered.
> > > > >
> > > > > >
> > > > > > Also sync_state seems broken right now. I saw mka mentioned that if you
> > > > > > have a device node enabled in your DT but never enable a driver for it
> > > > > > in the kernel we'll never get sync_state called. This is another
> > > > > > problem, but it concerns me that sync_state would make the unused clk
> > > > > > disabling happen at some random time or not at all.
> > > > >
> > > > > Well, the fact that the sync state not being called because a driver for
> > > > > a consumer device doesn't probe does not really mean it is broken. Just
> > > > > because the consumer driver hasn't probed yet, doesn't mean it will
> > > > > not probe later on.
> > > > >
> > > >
> > > > CC'ed Saravana
> > > >
> > > > > That aside, rather than going with clk_ignore_unused all the time on
> > > > > qcom platforms, at least in a perfect scenario (where sync state is
> > > > > reached for all providers) the clocks get disabled.
> > > > >
> > > > > >
> > > > > > Can the problem be approached more directly? If this is about fixing
> > > > > > continuous splash screen, then I wonder why we can't list out the clks
> > > > > > that we know are enabled by the bootloader in some new DT binding, e.g.:
> > > > > >
> > > > > >     clock-controller {
> > > > > >             #clock-cells = <1>;
> > > > > >             boot-handoff-clocks = <&consumer_device "clock cells for this clk provider">;
> > > > > >     };
> > > > > >
> > > > > > Then mark those as "critical/don't turn off" all the way up the clk tree
> > > > > > when the clk driver probes by essentially incrementing the
> > > > > > prepare/enable count but not actually touching the hardware, and when
> > > > > > the clks are acquired by clk_get() for that device that's using them
> > > > > > from boot we make the first clk_prepare_enable() do nothing and not
> > > > > > increment the count at all. We can probably stick some flag into the
> > > > > > 'struct clk' for this when we create the handle in clk_get() so that the
> > > > > > prepare and enable functions can special case and skip over.
> > > > >
> > > > > Well, that means we need to play whack-a-mole by alsways adding such clocks to
> > > > > devicetree.
> > > > >
> > > > > >
> > > > > > The sync_state hook operates on a driver level, which is too large when
> > > > > > you consider that a single clk driver may register hundreds of clks that
> > > > > > are not related. We want to target a solution at the clk level so that
> > > > > > any damage from keeping on all the clks provided by the controller is
> > > > > > limited to just the drivers that aren't probed and ready to handle their
> > > > > > clks. If sync_state could be called whenever a clk consumer consumes a
> > > > > > clk it may work? Technically we already have that by the clk_hw_provider
> > > > > > function but there isn't enough information being passed there, like the
> > > > > > getting device.
> > > > >
> > > > > Actually, from the multitude of clocks registered by one provider, the
> > > > > ones already explicitely enabled (and obvisously their parents) by thier
> > > > > consumer are safe. The only ones we need to worry about are the ones that
> > > > > might be enabled by bootloader and need to remain on. With the sync state
> > > > > approach, the latter mentioned clocks will either remain on indefinitely
> > > > > or will be disabled on sync state. The provider driver is the only level
> > > > > that has a registered sync state callback.
> > > > >
> > > > > >
> > > > > > > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > > > > > > index 842e72a5348f..cf1adfeaf257 100644
> > > > > > > --- a/include/linux/clk-provider.h
> > > > > > > +++ b/include/linux/clk-provider.h
> > > > > > > @@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
> > > > > > >                 void __iomem *reg, u8 shift, u8 width,
> > > > > > >                 u8 clk_divider_flags, const struct clk_div_table *table,
> > > > > > >                 spinlock_t *lock);
> > > > > > > +void clk_sync_state_disable_unused(struct device *dev);
> > > > > >
> > > > > > This is a weird place to put this. Why not in the helper functions
> > > > > > section?
> > > > >
> > > > > Sure this can be moved.
> > > > >
> > > > > >
> > > > > > >  /**
> > > > > > >   * clk_register_divider - register a divider clock with the clock framework
> > > > > > >   * @dev: device registering this clock
