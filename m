Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09E96D1688
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCaE7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCaE7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:59:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43299B775
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:59:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so9276267wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680238745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CtrQ/sfgZJDgAVtBs/XHZ720wUcC9wfbpwW+uTym+Ko=;
        b=bOTAz0PL3Nm9O7Rt3Lrl1sLlxw2eFRlY3TMp3AQiaGqcXU0lYfgBzlQ3ihJ+TeMZpr
         F44R7hj9gsxKYp2UhuO2uQu29qiMb9KGsOdDV4KYcHztEogDIxHa80xo/7J6sghMhX8U
         odB36cHiDlzUvxUpCXi5xgWGqH3CQoNGhCInMNyUez/9S3NDpH3XuyAESfvz12wTMIrS
         MwI1mWQ/milxnUSwPr6soaqIvZpyq0/kJ6YizVUyGAGngaL4dz8dyvruIuPxeYF/Dzjq
         u9+TtDuCQMfLZfueHGXArLWXLwIEVjhc9ua/r82Kx1+xDChQEN/lwncqA4iXA2vkVjec
         srUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680238745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtrQ/sfgZJDgAVtBs/XHZ720wUcC9wfbpwW+uTym+Ko=;
        b=ZyiOyb5WiztsA0O514xy/IWfs81AQQ63W665J3efmEILEMrFdUko+SXIjvFut0J1pa
         ynwiZrtPQg78ywFBNjQgKY1w7InnI0ev4wkbKiSvFhNa7rwi9yiFiNUsQmr2C2YviyKV
         DGz3qfZXM1iW84GHiNjXuIKSvajSSQTr9AFYRZH0ZTmbIzPqkezkddysfj7zd2kQquis
         u6/jgdNMcnmQ7vTfsfjnPxRE7045sLDyy8UzMjRxOlAw+eTr7gFHV73Je/VOcHc2Axu+
         aeMRATBXcIh/FZi+nHrlJ+eF9Y2Hpi0Jkcx8/i4UICnjRUPz+bwQMnrL8+VVZkp49IFT
         XqDA==
X-Gm-Message-State: AAQBX9cyykvneUmlnoRFqO6obRREcXqPS24OWTD6gt0m2OgUJvhqA3A+
        o7Wc/WyZNqqRtdw3lkuZKVTKAw==
X-Google-Smtp-Source: AKy350YvHyoTFCWAhgIVBeZ/OnETAHjbjvoRYM9SxSkQX8AJSQi3qrI+7nICSls4VL0ttgg6vPG3Kw==
X-Received: by 2002:a1c:6a07:0:b0:3f0:310c:e3cf with SMTP id f7-20020a1c6a07000000b003f0310ce3cfmr5092288wmc.37.1680238745511;
        Thu, 30 Mar 2023 21:59:05 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d6386000000b002e558f1c45fsm1064444wru.69.2023.03.30.21.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 21:59:05 -0700 (PDT)
Date:   Fri, 31 Mar 2023 07:59:03 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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
Message-ID: <ZCZolyDL/awnt73K@linaro.org>
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
 <CAGETcx9f1p2esfyzyfU04EAB1FXh=d9-U81DaGyZNjL_Vti3oQ@mail.gmail.com>
 <ZCVyBuKMvDV0gQPW@linaro.org>
 <CAGETcx-mxzzZ_FU6Agju9gMhFOEDhY6Rj78BnvAVJjNtZhif=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx-mxzzZ_FU6Agju9gMhFOEDhY6Rj78BnvAVJjNtZhif=w@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-30 12:50:44, Saravana Kannan wrote:
> On Thu, Mar 30, 2023 at 4:27 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > On 23-03-27 17:17:28, Saravana Kannan wrote:
> > > On Mon, Mar 27, 2023 at 12:38 PM Abel Vesa <abel.vesa@linaro.org> wrote:
> > > >
> > > > There have been already a couple of tries to make the genpd "disable
> > > > unused" late initcall skip the powering off of domains that might be
> > > > needed until later on (i.e. until some consumer probes). The conclusion
> > > > was that the provider could return -EBUSY from the power_off callback
> > > > until the provider's sync state has been reached. This patch series tries
> > > > to provide a proof-of-concept that is working on Qualcomm platforms.
> > >
> > > I'm giving my thoughts in the cover letter instead of spreading it
> > > around all the patches so that there's context between the comments.
> > >
> > > 1) Why can't all the logic in this patch series be implemented at the
> > > framework level? And then allow the drivers to opt into this behavior
> > > by setting the sync_state() callback.
> > >
> > > That way, you can land it only for QC drivers by setting up
> > > sync_state() callback only for QC drivers, but actually have the same
> > > code function correctly for non-QC drivers too. And then once we have
> > > this functionality working properly for QC drivers for one kernel
> > > version (or two), we'll just have the framework set the device's
> > > driver's sync_state() if it doesn't have one already.
> >
> > I think Ulf has already NACK'ed that approach here:
> > [1] https://lore.kernel.org/lkml/CAPDyKFon35wcQ+5kx3QZb-awN_S_q8y1Sir-G+GoxkCvpN=iiA@mail.gmail.com/
> 
> I would have NACK'ed that too because that's an incomplete fix. As I
> said further below, the fix needs to be at the aggregation level where
> you aggregate all the current consumer requests. In there, you need to
> add in the "state at boot" input that gets cleared out after a
> sync_state() call is received for that power domain.
> 

So, just to make sure I understand your point. You would rather have the
genpd_power_off check if 'state at boot' is 'on' and return busy and
then clear then, via a generic genpd sync state you would mark 'state at
boot' as 'off' and queue up a power off request for each PD from there.
And as for 'state at boot' it would check the enable bit through
provider.

Am I right so far?

> > And suggested this new approach that this patch series proposes.
> > (Unless I missunderstood his point)
> >
> > >
> > > 2) sync_state() is not just about power on/off. It's also about the
> > > power domain level. Can you handle that too please?
> >
> > Well, this patchset only tries to delay the disabling of unused power
> > domains until all consumers have had a chance to probe. So we use sync
> > state only to queue up a power-off request to make sure those unused
> > ones get disabled.
> 
> Sure, but the design is completely unusable for a more complete
> sync_state() behavior. I'm okay if you want to improve the
> sync_state() behavior in layers, but don't do it in a way where the
> current design will definitely not work for what you want to add in
> the future.

But you would still be OK with the qcom_cc sync state wrapper, I guess,
right? Your concern is only about the sync state callback being not
genpd generic one, AFAIU.

> 
> > >
> > > 3) In your GDSC drivers, it's not clear to me if you are preventing
> > > power off until sync_state() only for GDSCs that were already on at
> > > boot. So if an off-at-boot GDSC gets turned on, and then you attempt
> > > to turn it off before all its consumers have probed, it'll fail to
> > > power it off even though that wasn't necessary?
> >
> > I think we can circumvent looking at a GDSC by knowing it there was ever
> > a power on request since boot. I'll try to come up with something in the
> > new version.
> 
> Please no. There's nothing wrong with reading the GDSC values. Please
> read them and don't turn on GDSC's that weren't on at boot.

Sorry for the typos above, I basically said that for this concern of
yours, we can add the 'state at boot' thing you mentioned above by
looking at the GDSC (as in reading reg).

> 
> Otherwise you are making it a hassle for the case where there is a
> consumer without a driver for a GDSC that was off at boot. You are now
> forcing the use of timeouts or writing to state_synced file. Those
> should be absolute last resorts, but you are making that a requirement
> with your current implementation. If you implement it correctly by
> reading the GDSC register, things will "just work". And it's not even
> hard to do.
> 
> NACK'ed until this is handled correctly.
> 
> >
> > >
> > > 4) The returning -EBUSY when a power off is attempted seems to be
> > > quite wasteful. The framework will go through the whole sequence of
> > > trying to power down, send the notifications and then fail and then
> > > send the undo notifications. Combined with point (2) I think this can
> > > be handled better at the aggregation level in the framework to avoid
> > > even going that far into the power off sequence.
> >
> > Again, have a look at [1] (above).
> 
> See my reply above. If you do it properly at the framework level, this
> can be done in a clean way and will work for all power domains.
> 
> -Saravana
> 
> >
> > Ulf, any thoughts on this 4th point?
> >
> > >
> > > -Saravana
> > >
> > > >
> > > > I've been doing extensive testing on SM8450, but I've also spinned this
> > > > on my X13s (SC8280XP). Both patches that add the sync state callback to
> > > > the SC8280XP and SM8450 are here to provide context. Once we agree on
> > > > the form, I intend to add the sync state callback to all gdsc providers.
> > > >
> > > > Currently, some of the gdsc providers might not reach sync state due to
> > > > list of consumers not probing yet (or at all). The sync state can be
> > > > enforced by writing 1 to the state_synced sysfs attribute of the
> > > > provider, thanks to Saravana's commit [1] which has been already merged.
> > > >
> > > > [1] https://lore.kernel.org/r/20230304005355.746421-3-saravanak@google.com
> > > >
> > > > V2 (RFC) of this patchset was here:
> > > > https://lore.kernel.org/all/20230320134217.1685781-1-abel.vesa@linaro.org/
> > > >
> > > > Changes since v2:
> > > >  * renamed genpd_queue_power_off_work to pm_genpd_queue_power_off and added
> > > >    comment about its purpose w.r.t. it being exported.
> > > >  * added the qcom_cc generic sync state callback to all providers that
> > > >    register GDSCs, instead of SM8450 and SC8280XP
> > > >
> > > > Changes since v1:
> > > >  * Added the qcom_cc sync state callback which calls in turn the gdsc one
> > > >  * dropped extra semicolon from pm_domain.h
> > > >
> > > > Abel Vesa (4):
> > > >   PM: domains: Allow power off queuing from providers
> > > >   soc: qcom: rpmhpd: Do proper power off when state synced
> > > >   clk: qcom: gdsc: Avoid actual power off until sync state
> > > >   clk: qcom: Add sync state callback to all providers
> > > >
> > > >  drivers/base/power/domain.c            | 18 ++++++++++--------
> > > >  drivers/clk/qcom/apss-ipq6018.c        |  1 +
> > > >  drivers/clk/qcom/camcc-sc7180.c        |  1 +
> > > >  drivers/clk/qcom/camcc-sc7280.c        |  1 +
> > > >  drivers/clk/qcom/camcc-sdm845.c        |  1 +
> > > >  drivers/clk/qcom/camcc-sm6350.c        |  1 +
> > > >  drivers/clk/qcom/camcc-sm8250.c        |  1 +
> > > >  drivers/clk/qcom/camcc-sm8450.c        |  1 +
> > > >  drivers/clk/qcom/common.c              | 19 +++++++++++++++++++
> > > >  drivers/clk/qcom/common.h              |  2 ++
> > > >  drivers/clk/qcom/dispcc-qcm2290.c      |  1 +
> > > >  drivers/clk/qcom/dispcc-sc7180.c       |  1 +
> > > >  drivers/clk/qcom/dispcc-sc7280.c       |  1 +
> > > >  drivers/clk/qcom/dispcc-sc8280xp.c     |  1 +
> > > >  drivers/clk/qcom/dispcc-sdm845.c       |  1 +
> > > >  drivers/clk/qcom/dispcc-sm6115.c       |  1 +
> > > >  drivers/clk/qcom/dispcc-sm6125.c       |  1 +
> > > >  drivers/clk/qcom/dispcc-sm6350.c       |  1 +
> > > >  drivers/clk/qcom/dispcc-sm6375.c       |  1 +
> > > >  drivers/clk/qcom/dispcc-sm8250.c       |  1 +
> > > >  drivers/clk/qcom/dispcc-sm8450.c       |  1 +
> > > >  drivers/clk/qcom/dispcc-sm8550.c       |  1 +
> > > >  drivers/clk/qcom/gcc-apq8084.c         |  1 +
> > > >  drivers/clk/qcom/gcc-ipq806x.c         |  1 +
> > > >  drivers/clk/qcom/gcc-ipq8074.c         |  1 +
> > > >  drivers/clk/qcom/gcc-mdm9615.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8660.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8909.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8916.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8939.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8953.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8960.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8974.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8976.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8994.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8996.c         |  1 +
> > > >  drivers/clk/qcom/gcc-msm8998.c         |  1 +
> > > >  drivers/clk/qcom/gcc-qcm2290.c         |  1 +
> > > >  drivers/clk/qcom/gcc-qcs404.c          |  1 +
> > > >  drivers/clk/qcom/gcc-qdu1000.c         |  1 +
> > > >  drivers/clk/qcom/gcc-sa8775p.c         |  1 +
> > > >  drivers/clk/qcom/gcc-sc7180.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sc7280.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sc8180x.c         |  1 +
> > > >  drivers/clk/qcom/gcc-sc8280xp.c        |  1 +
> > > >  drivers/clk/qcom/gcc-sdm660.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sdm845.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sdx55.c           |  1 +
> > > >  drivers/clk/qcom/gcc-sdx65.c           |  1 +
> > > >  drivers/clk/qcom/gcc-sm6115.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sm6125.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sm6350.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sm6375.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sm7150.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sm8150.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sm8250.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sm8350.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sm8450.c          |  1 +
> > > >  drivers/clk/qcom/gcc-sm8550.c          |  1 +
> > > >  drivers/clk/qcom/gdsc.c                | 26 ++++++++++++++++++++++++++
> > > >  drivers/clk/qcom/gdsc.h                |  6 ++++++
> > > >  drivers/clk/qcom/gpucc-msm8998.c       |  1 +
> > > >  drivers/clk/qcom/gpucc-sc7180.c        |  1 +
> > > >  drivers/clk/qcom/gpucc-sc7280.c        |  1 +
> > > >  drivers/clk/qcom/gpucc-sc8280xp.c      |  1 +
> > > >  drivers/clk/qcom/gpucc-sdm660.c        |  1 +
> > > >  drivers/clk/qcom/gpucc-sdm845.c        |  1 +
> > > >  drivers/clk/qcom/gpucc-sm6115.c        |  1 +
> > > >  drivers/clk/qcom/gpucc-sm6125.c        |  1 +
> > > >  drivers/clk/qcom/gpucc-sm6350.c        |  1 +
> > > >  drivers/clk/qcom/gpucc-sm6375.c        |  1 +
> > > >  drivers/clk/qcom/gpucc-sm8150.c        |  1 +
> > > >  drivers/clk/qcom/gpucc-sm8250.c        |  1 +
> > > >  drivers/clk/qcom/gpucc-sm8350.c        |  1 +
> > > >  drivers/clk/qcom/lcc-ipq806x.c         |  1 +
> > > >  drivers/clk/qcom/lpassaudiocc-sc7280.c |  1 +
> > > >  drivers/clk/qcom/lpasscc-sc7280.c      |  1 +
> > > >  drivers/clk/qcom/lpasscorecc-sc7180.c  |  2 ++
> > > >  drivers/clk/qcom/lpasscorecc-sc7280.c  |  2 ++
> > > >  drivers/clk/qcom/mmcc-apq8084.c        |  1 +
> > > >  drivers/clk/qcom/mmcc-msm8974.c        |  1 +
> > > >  drivers/clk/qcom/mmcc-msm8994.c        |  1 +
> > > >  drivers/clk/qcom/mmcc-msm8996.c        |  1 +
> > > >  drivers/clk/qcom/mmcc-msm8998.c        |  1 +
> > > >  drivers/clk/qcom/mmcc-sdm660.c         |  1 +
> > > >  drivers/clk/qcom/videocc-sc7180.c      |  1 +
> > > >  drivers/clk/qcom/videocc-sc7280.c      |  1 +
> > > >  drivers/clk/qcom/videocc-sdm845.c      |  1 +
> > > >  drivers/clk/qcom/videocc-sm8150.c      |  1 +
> > > >  drivers/clk/qcom/videocc-sm8250.c      |  1 +
> > > >  drivers/soc/qcom/rpmhpd.c              | 19 +++++++------------
> > > >  include/linux/pm_domain.h              |  4 ++++
> > > >  92 files changed, 161 insertions(+), 20 deletions(-)
> > > >
> > > > --
> > > > 2.34.1
> > > >
