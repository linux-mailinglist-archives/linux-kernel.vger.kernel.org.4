Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1895EB852
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiI0DJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiI0DIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:08:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D598F121E67;
        Mon, 26 Sep 2022 20:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABEB4B81902;
        Tue, 27 Sep 2022 03:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89285C433D6;
        Tue, 27 Sep 2022 03:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664247726;
        bh=12SAPBJkhVO+TvRMsmsiDoZ4q4sir/E7/wJ9rUlr0ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7k6T3OnOQB+abomPP3mQZatR9kgDcL1DuJzShMbFagU122mMbNG4BaUqx99zorYA
         7qd78rNYpBFg8N4r8yD9iqdiB4G/dvfZueo41QevMXuvTh6+wD2eb6RHwh9VGfEYC/
         scIDf+FUL4SUGEr4EvOVfpfGRZSZ6m0fkfAoObgvvO+0cT5W2T2YC573pxhrIE/xQG
         BRbPT5+sNVlxax8bEJ1pYzKUc2nZSqvvAGUOHBUuKqqbmtVmkYAag3Rag+ECqOAibC
         b/AXZxr4ZBAyAIe7b6bjUYvE3hg0nuoWZLTaMG5/uuMWdXJLvCgZuraDTJe9UOwBtf
         LZrno2LAG2fQg==
Date:   Mon, 26 Sep 2022 22:02:03 -0500
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
Message-ID: <20220927030203.tz4j5vuhvrnhti6i@builder.lan>
References: <20220920111517.10407-1-quic_rjendra@quicinc.com>
 <d813e8a5-9eba-b3f7-2eee-cd721d120a30@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d813e8a5-9eba-b3f7-2eee-cd721d120a30@collabora.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 02:39:21PM +0200, AngeloGioacchino Del Regno wrote:
> Il 20/09/22 13:15, Rajendra Nayak ha scritto:
> > GDSCs cannot be transitioned into a Retention state in SW.
> > When either the RETAIN_MEM bit, or both the RETAIN_MEM and
> > RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
> > takes care of retaining the memory/logic for the domain when
> > the parent domain transitions to power collapse/power off state.
> > 
> > On some platforms where the parent domains lowest power state
> > itself is Retention, just leaving the GDSC in ON (without any
> > RETAIN_MEM/RETAIN_PERIPH bits being set) will also transition
> > it to Retention.
> > 
> > The existing logic handling the PWRSTS_RET seems to set the
> > RETAIN_MEM/RETAIN_PERIPH bits if the cxcs offsets are specified
> > but then explicitly turns the GDSC OFF as part of _gdsc_disable().
> > Fix that by leaving the GDSC in ON state.
> > 
> > Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> > v3:
> > Updated changelog
> > 
> > There are a few existing users of PWRSTS_RET and I am not
> > sure if they would be impacted with this change
> > 
> > 1. mdss_gdsc in mmcc-msm8974.c, I am expecting that the
> > gdsc is actually transitioning to OFF and might be left
> > ON as part of this change, atleast till we hit system wide
> > low power state.
> > If we really leak more power because of this
> > change, the right thing to do would be to update .pwrsts for
> > mdss_gdsc to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
> > I dont have a msm8974 hardware, so if anyone who has can report
> > any issues I can take a look further on how to fix it.
> 
> I think that the safest option is to add a PWRSTS_RET_HW_CTRL flag (or similar),
> used for the specific cases of SC7180 and SC7280 (and possibly others) where the
> GDSC is automatically transitioned to a Retention state by HW control, with no
> required software (kernel driver) intervention.
> 
> > 
> > 2. gpu_gx_gdsc in gpucc-msm8998.c and
> >     gpu_gx_gdsc in gpucc-sdm660.c
> > Both of these seem to add support for 3 power state
> > OFF, RET and ON, however I dont see any logic in gdsc
> > driver to handle 3 different power states.
> > So I am expecting that these are infact just transitioning
> > between ON and OFF and RET state is never really used.
> > The ideal fix for them would be to just update their resp.
> > .pwrsts to PWRSTS_OFF_ON only.
> 
> static int gdsc_init(struct gdsc *sc)
> {
> 
> 	...
> 
> 	if (on || (sc->pwrsts & PWRSTS_RET))
> 		gdsc_force_mem_on(sc);
> 	else
> 		gdsc_clear_mem_on(sc);
> 
> 	...
> }
> 
> On MSM8998 and SDM630/636/660, we're reaching that point with a GDSC that is
> left OFF from the bootloader, but we want (at least for 630/660) memretain
> without periph-retain: this is required to make the hypervisor happy.
> 

Forgive me Angelo, but can you please help me understand your concern
here?

Are yous saying that the valid states for 8998/660 are PWRSTS_OFF_ON,
but you also want gdsc_force_mem_on() - with NO_RET_PERIPH?


It seems to me that as Rajendra's patch is written, the gpu_gx_gdsc
won't be affected, because pwrsts != PWRSTS_RET. So this is a question
about the validity of fixing the pwrsts in gpucc-msm8998, rather than
about this patch in itself?

Regards,
Bjorn
