Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05B66D92A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjDFJ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjDFJ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:26:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CBB65B6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:26:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fi11so24236561edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680773167; x=1683365167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=puMz2ATJiXG9YrgWF8JgMsdrOIv8QlsIusgDqJEDrJA=;
        b=O6rPtkSjq80CK4k/eo64pD/whuk5SVDaynqfg+tA7L5UNaHn/qHgR/eP1tRxNlIKyR
         pRUgI1FZclp+oTpNodxu843L263RGfA/HCTmxncmvAL7ayYSCGwKQwTW47E00luMxflE
         na9BTs+maql8CibxkXXB5sbVE7JtxhlpiTxeAk8ATNaUkUo8jx3gmlS/knROk7NBUzGB
         qpvhplIBfRy6pLrtiqlxacM3YWer2kCnWU8TingwNNcV7+SS2QWxVCxn7DDZDYR1R/8S
         RNqn8rjwuQfCq9zVQ8l7HFIm6BYDe23WFr3BHBa5biLaieom8UXmb12Db1AtYpf837Jq
         z7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680773167; x=1683365167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puMz2ATJiXG9YrgWF8JgMsdrOIv8QlsIusgDqJEDrJA=;
        b=pTdqOlGyf4Jcn5ElCZqBCZ9HpV9ECFlJMS1udpyKqoeKH7Ysoi9iWmF/eKptjmsT+X
         QEhsMPK6DYnyF+ZEkq/kQFLqovvAAIht7iLonjH3yd60O1s+4LV7zM/BDvyb6KO+xcDV
         vdN3kD1a+OuGZCMIhyIFVU7g+sIZmPx2oJaOHrJI4RGc5N1EasORoWdx4xiRJ1fERiWO
         OkmFnIxfs4PfHTdvNjaOKG5AY7MYAfa+ljqQrE7f+Ybf91Qge1AJlm5G+AYvVL5Br9b+
         Vnmi7l2FeMiYOiPnmM4XDr0BrLFGv0XqjgOqW6b9XcS7ke71RY/P9eevehOMPiy64/3r
         xg7g==
X-Gm-Message-State: AAQBX9d1VI7guZScHos91vwKreAUiQYx6LdNGtrFVDxwOuZFbM/kiEoS
        5rP6RVNobgEq2UAsQGN3vncUyA==
X-Google-Smtp-Source: AKy350Z7osDqV+tGsqFumKfzrCUxBMuoAwbvUkpMeHy/RSpSPlaqGyT1vCOvmCNDMZ7ZX/x7iVYEBQ==
X-Received: by 2002:a17:907:9723:b0:92f:8324:e3b7 with SMTP id jg35-20020a170907972300b0092f8324e3b7mr5178587ejc.37.1680773167364;
        Thu, 06 Apr 2023 02:26:07 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id re9-20020a170906d8c900b0093dbb008281sm557039ejb.130.2023.04.06.02.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 02:26:06 -0700 (PDT)
Date:   Thu, 6 Apr 2023 12:26:05 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3 0/4] Allow genpd providers to power off domains on
 sync state
Message-ID: <ZC6QLZOldOLNaCSg@linaro.org>
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
 <CAGETcx9f1p2esfyzyfU04EAB1FXh=d9-U81DaGyZNjL_Vti3oQ@mail.gmail.com>
 <ZCVyBuKMvDV0gQPW@linaro.org>
 <CAGETcx-mxzzZ_FU6Agju9gMhFOEDhY6Rj78BnvAVJjNtZhif=w@mail.gmail.com>
 <ZCZolyDL/awnt73K@linaro.org>
 <CAPDyKFprQwBfya-TpaVJfn82LgM9N_iE8npO9r-HzAyJXpb-hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFprQwBfya-TpaVJfn82LgM9N_iE8npO9r-HzAyJXpb-hQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-05 16:11:18, Ulf Hansson wrote:
> Abel, Saravana,
> 
> On Fri, 31 Mar 2023 at 06:59, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > On 23-03-30 12:50:44, Saravana Kannan wrote:
> > > On Thu, Mar 30, 2023 at 4:27 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > > >
> > > > On 23-03-27 17:17:28, Saravana Kannan wrote:
> > > > > On Mon, Mar 27, 2023 at 12:38 PM Abel Vesa <abel.vesa@linaro.org> wrote:
> > > > > >
> > > > > > There have been already a couple of tries to make the genpd "disable
> > > > > > unused" late initcall skip the powering off of domains that might be
> > > > > > needed until later on (i.e. until some consumer probes). The conclusion
> > > > > > was that the provider could return -EBUSY from the power_off callback
> > > > > > until the provider's sync state has been reached. This patch series tries
> > > > > > to provide a proof-of-concept that is working on Qualcomm platforms.
> > > > >
> > > > > I'm giving my thoughts in the cover letter instead of spreading it
> > > > > around all the patches so that there's context between the comments.
> > > > >
> > > > > 1) Why can't all the logic in this patch series be implemented at the
> > > > > framework level? And then allow the drivers to opt into this behavior
> > > > > by setting the sync_state() callback.
> > > > >
> > > > > That way, you can land it only for QC drivers by setting up
> > > > > sync_state() callback only for QC drivers, but actually have the same
> > > > > code function correctly for non-QC drivers too. And then once we have
> > > > > this functionality working properly for QC drivers for one kernel
> > > > > version (or two), we'll just have the framework set the device's
> > > > > driver's sync_state() if it doesn't have one already.
> > > >
> > > > I think Ulf has already NACK'ed that approach here:
> > > > [1] https://lore.kernel.org/lkml/CAPDyKFon35wcQ+5kx3QZb-awN_S_q8y1Sir-G+GoxkCvpN=iiA@mail.gmail.com/
> > >
> > > I would have NACK'ed that too because that's an incomplete fix. As I
> > > said further below, the fix needs to be at the aggregation level where
> > > you aggregate all the current consumer requests. In there, you need to
> > > add in the "state at boot" input that gets cleared out after a
> > > sync_state() call is received for that power domain.
> > >
> >
> > So, just to make sure I understand your point. You would rather have the
> > genpd_power_off check if 'state at boot' is 'on' and return busy and
> > then clear then, via a generic genpd sync state you would mark 'state at
> > boot' as 'off' and queue up a power off request for each PD from there.
> > And as for 'state at boot' it would check the enable bit through
> > provider.
> >
> > Am I right so far?
> 
> I am not sure I completely follow what you are suggesting here.

Please have a look at this:
https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/commit/?h=qcom/genpd/ignore_unused_until_sync_state&id=4f9e6140dfe77884012383f8ba2140cadb62ca4a

Keep in mind that is WIP for now. Once I have something, I'll post it on
mailing list. Right now, there is a missing piece mentioned in that
commit message.

> 
> Although, let me point out that there is no requirement from the genpd
> API point of view, that the provider needs to be a driver. This means
> that the sync_state callback may not even be applicable for all genpd
> providers.

Yes, I'm considering that case too.

> 
> In other words, it looks to me that we may need some new genpd helper
> functions, no matter what. More importantly, it looks like we need an
> opt-in behaviour, unless we can figure out a common way for genpd to
> understand whether the sync_state thing is going to be applicable or
> not. Maybe Saravana has some ideas around this?
> 
> Note that, I don't object to extending genpd to be more clever and to
> share common code, of course. We could, for example, make
> genpd_power_off() to bail out earlier, rather than calling the
> ->power_off() callback and waiting for it to return -EBUSY. Both of
> you have pointed this out to me, in some of the earlier
> replies/discussions too.

The above link basically does this. I hope this is what Saravana has in
mind as well.

> 
> >
> > > > And suggested this new approach that this patch series proposes.
> > > > (Unless I missunderstood his point)
> > > >
> > > > >
> > > > > 2) sync_state() is not just about power on/off. It's also about the
> > > > > power domain level. Can you handle that too please?
> > > >
> > > > Well, this patchset only tries to delay the disabling of unused power
> > > > domains until all consumers have had a chance to probe. So we use sync
> > > > state only to queue up a power-off request to make sure those unused
> > > > ones get disabled.
> > >
> > > Sure, but the design is completely unusable for a more complete
> > > sync_state() behavior. I'm okay if you want to improve the
> > > sync_state() behavior in layers, but don't do it in a way where the
> > > current design will definitely not work for what you want to add in
> > > the future.
> >
> > But you would still be OK with the qcom_cc sync state wrapper, I guess,
> > right? Your concern is only about the sync state callback being not
> > genpd generic one, AFAIU.
> >
> > >
> > > > >
> > > > > 3) In your GDSC drivers, it's not clear to me if you are preventing
> > > > > power off until sync_state() only for GDSCs that were already on at
> > > > > boot. So if an off-at-boot GDSC gets turned on, and then you attempt
> > > > > to turn it off before all its consumers have probed, it'll fail to
> > > > > power it off even though that wasn't necessary?
> > > >
> > > > I think we can circumvent looking at a GDSC by knowing it there was ever
> > > > a power on request since boot. I'll try to come up with something in the
> > > > new version.
> > >
> > > Please no. There's nothing wrong with reading the GDSC values. Please
> > > read them and don't turn on GDSC's that weren't on at boot.
> >
> > Sorry for the typos above, I basically said that for this concern of
> > yours, we can add the 'state at boot' thing you mentioned above by
> > looking at the GDSC (as in reading reg).
> >
> > >
> > > Otherwise you are making it a hassle for the case where there is a
> > > consumer without a driver for a GDSC that was off at boot. You are now
> > > forcing the use of timeouts or writing to state_synced file. Those
> > > should be absolute last resorts, but you are making that a requirement
> > > with your current implementation. If you implement it correctly by
> > > reading the GDSC register, things will "just work". And it's not even
> > > hard to do.
> > >
> > > NACK'ed until this is handled correctly.
> > >
> > > >
> > > > >
> > > > > 4) The returning -EBUSY when a power off is attempted seems to be
> > > > > quite wasteful. The framework will go through the whole sequence of
> > > > > trying to power down, send the notifications and then fail and then
> > > > > send the undo notifications. Combined with point (2) I think this can
> > > > > be handled better at the aggregation level in the framework to avoid
> > > > > even going that far into the power off sequence.
> > > >
> > > > Again, have a look at [1] (above).
> > >
> > > See my reply above. If you do it properly at the framework level, this
> > > can be done in a clean way and will work for all power domains.
> > >
> > > -Saravana
> > >
> > > >
> > > > Ulf, any thoughts on this 4th point?
> 
> Please, see my reply above.
> 
> [...]
> 
> Kind regards
> Uffe
