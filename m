Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F6C5ECA70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiI0RGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiI0RFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:05:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FAC5C351;
        Tue, 27 Sep 2022 10:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3608F6171E;
        Tue, 27 Sep 2022 17:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A005CC433D7;
        Tue, 27 Sep 2022 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664298319;
        bh=RezG0e8yTfUZ/cPhgrgq/ESV4VhaQWW7GClmeDE1snI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZI/Pv9MSA2zEekt9RdVg4J95Uf6OsqYR7yTF1CPjvRu2YLyXF1gHyrIK+HG147ejQ
         zzjOo9FYjOCIIUQbllxILWHSViAlY6bd9fO+5d0ImLb6QMZYkoSwrzJQeuJlNTOF4H
         NT//fRz7tKz4vCZPpxplO/ldzuvgMXgjGSMqYSgEIm3R8SpViwo1MKBIe68Rd620mx
         NJLTdVvsduhEKYXx2wO/bF6T10G8yPTtxd2fm7RqnjsF74rVktYcnDZLGxjJ7fzVeO
         5yBmvU+jUZFt2WPIOUivKZUfg1jioWDElwUTRDT3P7w4EqSNDNig9G38YZtdEK/etQ
         rmDN8KIP2ypJQ==
Date:   Tue, 27 Sep 2022 12:05:16 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        quic_kriskura@quicinc.com, dianders@chromium.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET
 support
Message-ID: <20220927170516.zrkzn3xl7oedzi4l@builder.lan>
References: <20220920111517.10407-1-quic_rjendra@quicinc.com>
 <d813e8a5-9eba-b3f7-2eee-cd721d120a30@collabora.com>
 <20220927030203.tz4j5vuhvrnhti6i@builder.lan>
 <657820a2-f945-ac6a-8a99-47ee511181d8@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657820a2-f945-ac6a-8a99-47ee511181d8@collabora.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:57:59PM +0200, AngeloGioacchino Del Regno wrote:
> Il 27/09/22 05:02, Bjorn Andersson ha scritto:
> > On Tue, Sep 20, 2022 at 02:39:21PM +0200, AngeloGioacchino Del Regno wrote:
> > > Il 20/09/22 13:15, Rajendra Nayak ha scritto:
> > > > GDSCs cannot be transitioned into a Retention state in SW.
> > > > When either the RETAIN_MEM bit, or both the RETAIN_MEM and
> > > > RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
> > > > takes care of retaining the memory/logic for the domain when
> > > > the parent domain transitions to power collapse/power off state.
> > > > 
> > > > On some platforms where the parent domains lowest power state
> > > > itself is Retention, just leaving the GDSC in ON (without any
> > > > RETAIN_MEM/RETAIN_PERIPH bits being set) will also transition
> > > > it to Retention.
> > > > 
> > > > The existing logic handling the PWRSTS_RET seems to set the
> > > > RETAIN_MEM/RETAIN_PERIPH bits if the cxcs offsets are specified
> > > > but then explicitly turns the GDSC OFF as part of _gdsc_disable().
> > > > Fix that by leaving the GDSC in ON state.
> > > > 
> > > > Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> > > > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > > ---
> > > > v3:
> > > > Updated changelog
> > > > 
> > > > There are a few existing users of PWRSTS_RET and I am not
> > > > sure if they would be impacted with this change
> > > > 
> > > > 1. mdss_gdsc in mmcc-msm8974.c, I am expecting that the
> > > > gdsc is actually transitioning to OFF and might be left
> > > > ON as part of this change, atleast till we hit system wide
> > > > low power state.
> > > > If we really leak more power because of this
> > > > change, the right thing to do would be to update .pwrsts for
> > > > mdss_gdsc to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
> > > > I dont have a msm8974 hardware, so if anyone who has can report
> > > > any issues I can take a look further on how to fix it.
> > > 
> > > I think that the safest option is to add a PWRSTS_RET_HW_CTRL flag (or similar),
> > > used for the specific cases of SC7180 and SC7280 (and possibly others) where the
> > > GDSC is automatically transitioned to a Retention state by HW control, with no
> > > required software (kernel driver) intervention.
> > > 
> > > > 
> > > > 2. gpu_gx_gdsc in gpucc-msm8998.c and
> > > >      gpu_gx_gdsc in gpucc-sdm660.c
> > > > Both of these seem to add support for 3 power state
> > > > OFF, RET and ON, however I dont see any logic in gdsc
> > > > driver to handle 3 different power states.
> > > > So I am expecting that these are infact just transitioning
> > > > between ON and OFF and RET state is never really used.
> > > > The ideal fix for them would be to just update their resp.
> > > > .pwrsts to PWRSTS_OFF_ON only.
> > > 
> > > static int gdsc_init(struct gdsc *sc)
> > > {
> > > 
> > > 	...
> > > 
> > > 	if (on || (sc->pwrsts & PWRSTS_RET))
> > > 		gdsc_force_mem_on(sc);
> > > 	else
> > > 		gdsc_clear_mem_on(sc);
> > > 
> > > 	...
> > > }
> > > 
> > > On MSM8998 and SDM630/636/660, we're reaching that point with a GDSC that is
> > > left OFF from the bootloader, but we want (at least for 630/660) memretain
> > > without periph-retain: this is required to make the hypervisor happy.
> > > 
> > 
> > Forgive me Angelo, but can you please help me understand your concern
> > here?
> > 
> > Are yous saying that the valid states for 8998/660 are PWRSTS_OFF_ON,
> > but you also want gdsc_force_mem_on() - with NO_RET_PERIPH?
> > 
> > 
> > It seems to me that as Rajendra's patch is written, the gpu_gx_gdsc
> > won't be affected, because pwrsts != PWRSTS_RET. So this is a question
> > about the validity of fixing the pwrsts in gpucc-msm8998, rather than
> > about this patch in itself?
> > 
> 
> Hello Bjorn,
> 
> my replies were related to this part of the commit description:
> 
> >>> The ideal fix for them would be to just update their resp.
> >>> .pwrsts to PWRSTS_OFF_ON only.
> 
> By updating MSM8998 and SDM660's gpu_gx_gdsc to remove PWRSTS_RET, the gdsc_init()
> flow will change, as in the aforementioned branch, `on` will be false, hence,
> we will clear RETAIN_MEM during the gpu_gx_gdsc initialization, producing side
> effects.
> I agree on the fact that PWRSTS_RET was *not* handled correctly before this commit
> and this alone will not produce any side effects on MSM8998, nor SDM660.
> 
> So yes, this is a discussion about the validity of fixing the pwrsts in
> gpucc-msm8998 and in gpucc-sdm660.c.
> 

Okay, now I understand the context, I will move ahead and merge these
patches then.


And for 8998/660 you're saying that the GDSC is found to be OFF at boot
and in runtime you're going to bounce it between on and off in software,
but you need RETAIN_MEM set?

If that's the case this GDSC can be in all 3 states. But as you can
find in the discussions that lead up to this discussion, we don't have a
way to represent this to the clients (today).

Regards,
Bjorn
