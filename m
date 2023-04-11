Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681406DD396
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDKHG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDKHGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:06:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0210510EC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:06:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v9so12418276pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681196782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dg3py+d1d8voix5Nhdaz+jzbS21GJeHZT0Py1g4YyaM=;
        b=LkxT9gO8/NppwcJwgE57gyk+V86zc0W5i5FL0G1ZCy3FQyPh+mOvkWTXTT+MUvEhnX
         Y6dCNmOUoJFa/UYMXd9IQbwUUHLPupgOhVjGW4cJgYstyM6cQ/CpDWDHJnVaoWpwbzPI
         LEwxvQ1kzRiofohUiVp+Y4Gjtnf7Vp0IJfE3vsh8/Alpn+fIXDEwIcNvBMgOtUD0lVNV
         FWTI6l6nIYvZZG4HsretIdaNeDRl1cwWVe+dSNRn3zNQlnWtXc9ZDcIJUISlR7Ihxqdd
         Ws/GZZzl9xOKehHnkMj/YwiYCddQjoHn61ySi3HK9cNLB2MRHc//r34ElCdu7wP4T8pe
         lmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg3py+d1d8voix5Nhdaz+jzbS21GJeHZT0Py1g4YyaM=;
        b=CmAA4kJCzNHmCgbbtUZF7UiF3m9pLUaNM5kuwADnXjhKeacMXNLTra3rD3II9MHCVY
         CnOPf+LviabtNDqd7KsNuQ6W71S9Nv9QkervkdhNj2xdpas59DsQp8XRUlp8/BT9qSYw
         QsLbFqgEwMdblDDTODFpR+bsr0GMmGl0u+P2eSofBIfCrv/l/EDIfGFRj5XByklQyY0o
         dqiZzGaQH5lAwWMmw8JWcemSYZ2ziWJAyarkbNsQQhQTQWOtlfmvKXz1FWel8nVJATPT
         JlqdQzMwc2NjTae64WWpI5/TKTBcbkVuWYTxEQbe2SdOMQPwDeVbA7ISuYgZ1CufMhuv
         0GNA==
X-Gm-Message-State: AAQBX9ejCw/IwfF17vIx3kjcoONVgwjGccFv8X7F0/risuc8SwUxGaPY
        AKUyKKfDjjceJAJaqY8nshRl
X-Google-Smtp-Source: AKy350ZV5bF2x0y0NqljiX1IQdz7pjKc0oiwRZpHDDEkCTOeAcl4il9uZBO6/2P1eJYS5OQLRRObCg==
X-Received: by 2002:a17:902:6b04:b0:1a2:87a2:c910 with SMTP id o4-20020a1709026b0400b001a287a2c910mr13291521plk.53.1681196782274;
        Tue, 11 Apr 2023 00:06:22 -0700 (PDT)
Received: from thinkpad ([117.248.3.87])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b0019edc1b9eb2sm8969140pls.238.2023.04.11.00.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:06:21 -0700 (PDT)
Date:   Tue, 11 Apr 2023 12:36:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Luca Weiss <luca@z3ntu.xyz>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, quic_kriskura@quicinc.com,
        dianders@chromium.org, linux-clk@vger.kernel.org,
        angelogioacchino.delregno@collabora.com,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET
 support
Message-ID: <20230411070613.GA5333@thinkpad>
References: <20220920111517.10407-1-quic_rjendra@quicinc.com>
 <5c2442d3-1f65-9106-2ef4-d6beec159538@quicinc.com>
 <2619574.X9hSmTKtgW@z3ntu.xyz>
 <2674085.mvXUDI8C0e@z3ntu.xyz>
 <016fd82f-b0a6-d8e8-769f-ddee63d22eb4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <016fd82f-b0a6-d8e8-769f-ddee63d22eb4@quicinc.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:20:47AM +0530, Rajendra Nayak wrote:
> 
> 
> On 4/11/2023 1:05 AM, Luca Weiss wrote:
> > Hi Rajendra,
> > 
> > On Mittwoch, 1. Februar 2023 19:04:37 CEST Luca Weiss wrote:
> > > On Montag, 23. Jänner 2023 05:30:55 CET Rajendra Nayak wrote:
> > > > On 1/22/2023 5:45 AM, Luca Weiss wrote:
> > > > > Hi Rajendra,
> > > > > 
> > > > > On Dienstag, 20. September 2022 13:15:15 CET Rajendra Nayak wrote:
> > > > > > GDSCs cannot be transitioned into a Retention state in SW.
> > > > > > When either the RETAIN_MEM bit, or both the RETAIN_MEM and
> > > > > > RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
> > > > > > takes care of retaining the memory/logic for the domain when
> > > > > > the parent domain transitions to power collapse/power off state.
> > > > > > 
> > > > > > On some platforms where the parent domains lowest power state
> > > > > > itself is Retention, just leaving the GDSC in ON (without any
> > > > > > RETAIN_MEM/RETAIN_PERIPH bits being set) will also transition
> > > > > > it to Retention.
> > > > > > 
> > > > > > The existing logic handling the PWRSTS_RET seems to set the
> > > > > > RETAIN_MEM/RETAIN_PERIPH bits if the cxcs offsets are specified
> > > > > > but then explicitly turns the GDSC OFF as part of _gdsc_disable().
> > > > > > Fix that by leaving the GDSC in ON state.
> > > > > > 
> > > > > > Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> > > > > > Cc: AngeloGioacchino Del Regno
> > > > > > <angelogioacchino.delregno@collabora.com>
> > > > > > ---
> > > > > > v3:
> > > > > > Updated changelog
> > > > > > 
> > > > > > There are a few existing users of PWRSTS_RET and I am not
> > > > > > sure if they would be impacted with this change
> > > > > > 
> > > > > > 1. mdss_gdsc in mmcc-msm8974.c, I am expecting that the
> > > > > > gdsc is actually transitioning to OFF and might be left
> > > > > > ON as part of this change, atleast till we hit system wide
> > > > > > low power state.
> > > > > > If we really leak more power because of this
> > > > > > change, the right thing to do would be to update .pwrsts for
> > > > > > mdss_gdsc to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
> > > > > > I dont have a msm8974 hardware, so if anyone who has can report
> > > > > > any issues I can take a look further on how to fix it.
> > > > > 
> > > > > Unfortunately indeed this patch makes problems on msm8974, at least on
> > > > > fairphone-fp2 hardware.
> > > > > 
> > > > > With this patch in place, the screen doesn't initialize correctly in
> > > > > maybe
> > > > > 80% of boots and is stuck in weird states, mostly just becomes
> > > > > completely
> > > > > blue.
> > > > > 
> > > > > Kernel log at least sometimes includes messages like this:
> > > > > [   25.847541] dsi_cmds2buf_tx: cmd dma tx failed, type=0x39,
> > > > > data0=0x51,
> > > > > len=8, ret=-110
> > > > > 
> > > > > Do you have anything I can try on msm8974? For now, reverting this patch
> > > > > makes display work again on v6.1
> > > > 
> > > > hmm, I was really expecting this to leak more power than break anything
> > > > functionally, Did you try moving to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
> > > > for mdss_gdsc?
> > > 
> > > Hi Rajendra,
> > > 
> > > yes with this change the display init works fine again. Do you think this is
> > > the intended solution then? I also haven't tested really more than this
> > > simple case.
> > > 
> > > Let me know what you think.
> > 
> > Any feedback on this? Would be great to get this fixed sometime soon, quite
> > annoying to carry a patch for this locally.
> 
> Hi Luca, really sorry I seem to have completely missed your previous
> email. Yes, moving the gdsc from PWRSTS_RET_ON to PWRSTS_OFF_ON seems to
> be the right thing to do. The behavior of the RET state was same as that
> of OFF prior to my patch, so the change should ideally make display go
> back to having the same behavior as before.
> I can certainly ack the change if you send in a patch.

I fail to understand how enabling retention state affects a peripheral during
boot. It could've some effect during suspend but an issue during boot fuzzies
me.

- Mani

> thanks,
> Rajendra
> 
> > 
> > Regards
> > Luca
> > 
> > > 
> > > Regards
> > > Luca
> > > 
> > > diff --git a/drivers/clk/qcom/mmcc-msm8974.c
> > > b/drivers/clk/qcom/mmcc-msm8974.c index 26f3f8f06edf..f95e38abde13 100644
> > > --- a/drivers/clk/qcom/mmcc-msm8974.c
> > > +++ b/drivers/clk/qcom/mmcc-msm8974.c
> > > @@ -2389,7 +2389,7 @@ static struct gdsc mdss_gdsc = {
> > >   	.pd = {
> > >   		.name = "mdss",
> > >   	},
> > > -	.pwrsts = PWRSTS_RET_ON,
> > > +	.pwrsts = PWRSTS_OFF_ON,
> > >   };
> > > 
> > >   static struct gdsc camss_jpeg_gdsc = {
> > > 
> > > > > Regards
> > > > > Luca
> > > > > 
> > > > > > 2. gpu_gx_gdsc in gpucc-msm8998.c and
> > > > > > 
> > > > > >      gpu_gx_gdsc in gpucc-sdm660.c
> > > > > > 
> > > > > > Both of these seem to add support for 3 power state
> > > > > > OFF, RET and ON, however I dont see any logic in gdsc
> > > > > > driver to handle 3 different power states.
> > > > > > So I am expecting that these are infact just transitioning
> > > > > > between ON and OFF and RET state is never really used.
> > > > > > The ideal fix for them would be to just update their resp.
> > > > > > .pwrsts to PWRSTS_OFF_ON only.
> > > > > > 
> > > > > >    drivers/clk/qcom/gdsc.c | 10 ++++++++++
> > > > > >    drivers/clk/qcom/gdsc.h |  5 +++++
> > > > > >    2 files changed, 15 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > > > > > index d3244006c661..ccf63771e852 100644
> > > > > > --- a/drivers/clk/qcom/gdsc.c
> > > > > > +++ b/drivers/clk/qcom/gdsc.c
> > > > > > @@ -368,6 +368,16 @@ static int _gdsc_disable(struct gdsc *sc)
> > > > > > 
> > > > > >    	if (sc->pwrsts & PWRSTS_OFF)
> > > > > >    	
> > > > > >    		gdsc_clear_mem_on(sc);
> > > > > > 
> > > > > > +	/*
> > > > > > +	 * If the GDSC supports only a Retention state, apart from ON,
> > > > > > +	 * leave it in ON state.
> > > > > > +	 * There is no SW control to transition the GDSC into
> > > > > > +	 * Retention state. This happens in HW when the parent
> > > > > > +	 * domain goes down to a Low power state
> > > > > > +	 */
> > > > > > +	if (sc->pwrsts == PWRSTS_RET_ON)
> > > > > > +		return 0;
> > > > > > +
> > > > > > 
> > > > > >    	ret = gdsc_toggle_logic(sc, GDSC_OFF);
> > > > > >    	if (ret)
> > > > > >    	
> > > > > >    		return ret;
> > > > > > 
> > > > > > diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> > > > > > index 5de48c9439b2..981a12c8502d 100644
> > > > > > --- a/drivers/clk/qcom/gdsc.h
> > > > > > +++ b/drivers/clk/qcom/gdsc.h
> > > > > > @@ -49,6 +49,11 @@ struct gdsc {
> > > > > > 
> > > > > >    	const u8			pwrsts;
> > > > > >    /* Powerdomain allowable state bitfields */
> > > > > >    #define PWRSTS_OFF		BIT(0)
> > > > > > 
> > > > > > +/*
> > > > > > + * There is no SW control to transition a GDSC into
> > > > > > + * PWRSTS_RET. This happens in HW when the parent
> > > > > > + * domain goes down to a low power state
> > > > > > + */
> > > > > > 
> > > > > >    #define PWRSTS_RET		BIT(1)
> > > > > >    #define PWRSTS_ON		BIT(2)
> > > > > >    #define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
> > 
> > 
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
