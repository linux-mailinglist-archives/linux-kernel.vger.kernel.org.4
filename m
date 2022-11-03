Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F117617657
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKCFub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKCFu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:50:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2776167C3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:50:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso4218676pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 22:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tqq4iqiPBYJJ3mdt9KquYmKxY1vZtBAAJB2JNp407Ak=;
        b=HSQqN9AVu2zGja3ueWjG9fRCGn+YZWng/jhr216FHRYdPp9ynTbFQxH/Nwwuvfeelg
         h2r0LlZmHVpXrhlDk3mkv95fmzA2EohQp+nNsIFLQkKRs+mLJqnlAV8s/ESeMuUVTfRQ
         ERTV4rtQeqvPfsaYWyomv1172LAVsEWDX2nnTJ1fiHn/4HvWHPOXESVD1xqoBjSAT1Be
         D6sOW7KtfvWMZ/qmmwj4+l9g95aEi8BNNMT3fcmJxgXU5MDWlVcGnS1P2rhkCcsysxnN
         mgARjT7fvHsk7Vcusl2E9c9/3v0NKusVICHifwFVwc74+SRBgv30t8d1Xfzadjmk/3Bn
         ZkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqq4iqiPBYJJ3mdt9KquYmKxY1vZtBAAJB2JNp407Ak=;
        b=lkAMWyH5AWyObkvt46OdP8NXyFyEFBVg4xcHwv4yTOPPYFowgZfjPAfCf6HgQtTL7Z
         1lLnYztUMJCMhfwpzqZSg7VPM+3R++ODZtC/PTBy6xR6ZKYjMCe6aEO8EnXpn8ueue7/
         lILEVAM6oCW/KBI8gReIMuJVor5v/CfmlzEADiOIqYeit/iE0rfnPUoSZoEIH/q1Lmlp
         PRQpKSOdWlnpwigJofCxhwis1rFvkl2Q61fuGhM4RC+VdTKgxvsvaBSpuv7QPxuY5G3a
         Ua9Gc27WJwgAMLhDBJk81bN2IQeQumY3CxICpYCdCGBOz8dyTcg2lQdsm/4ikDXKMZMA
         LuPQ==
X-Gm-Message-State: ACrzQf2QCe5mFzlav7cND8hgzmV8fSR7hLNgiUI0GuTB/cxAj/jxt7C/
        rYWZKeiC0/sncv5PHWAHSMBr
X-Google-Smtp-Source: AMsMyM633tSmnT857qtz/X+kw29fK+4EAbXvmYJRfLM2ldyfB280rQAAIgPd1fO/Jj/BzNS+eJDx6w==
X-Received: by 2002:a17:903:2342:b0:17c:ae18:1c86 with SMTP id c2-20020a170903234200b0017cae181c86mr27723709plh.5.1667454625017;
        Wed, 02 Nov 2022 22:50:25 -0700 (PDT)
Received: from thinkpad ([117.193.208.64])
        by smtp.gmail.com with ESMTPSA id i127-20020a625485000000b0056e32a2b88esm1080377pfb.219.2022.11.02.22.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 22:50:23 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:20:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org
Subject: Re: [PATCH v2 12/12] arm64: dts: qcom: sc8280xp-x13s: Add thermal
 zone support
Message-ID: <20221103055014.GA8434@thinkpad>
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-13-manivannan.sadhasivam@linaro.org>
 <90b7e0e0-a354-f64d-8c53-aa80df684a3a@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90b7e0e0-a354-f64d-8c53-aa80df684a3a@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 04:29:05PM +0200, Konrad Dybcio wrote:
> 
> 
> On 29.10.2022 07:14, Manivannan Sadhasivam wrote:
> > Add thermal zone support by making use of the thermistor SYS_THERM6.
> > Based on experiments, this thermistor seems to reflect the actual
> > surface temperature of the laptop.
> > 
> > For the cooling device, all BIG CPU cores are throttle down to keep the
> s/throttle/throttled
> 
> Is it okay to let the 4xA78C run at full throttle in thermal emergencies though?

I don't get it. Can you elaborate?

> > temperature at a sane level.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > index ca77c19c6d0d..96e2fa72f782 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > @@ -29,6 +29,52 @@ backlight {
> >  		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
> >  	};
> >  
> > +	thermal-zones {
> > +		skin-temp-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <0>;
> > +			thermal-sensors = <&pmk8280_adc_tm 5>;
> > +
> > +			trips {
> > +				skin_temp_alert0: trip-point0 {
> > +					temperature = <55000>;
> > +					hysteresis = <1000>;
> > +					type = "passive";
> > +				};
> > +
> > +				skin_temp_alert1: trip-point1 {
> > +					temperature = <58000>;
> > +					hysteresis = <1000>;
> > +					type = "passive";
> > +				};
> > +
> > +				skin-temp-crit {
> > +					temperature = <73000>;
> Ouch, I didn't know we were serving burnt fingers at the cafeteria today :D
> 
> Or maybe this just looks scary.. The laptop looks plastic, so maybe it won't cause instant
> burns?
> 

73c is what the reasonable number I came up with after some experiments. At
this point the temperature won't burn your finger but crossing this surely
would (that's what happening without this series).

Thanks,
Mani

> Konrad
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +
> > +			cooling-maps {
> > +				map0 {
> > +					trip = <&skin_temp_alert0>;
> > +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +				};
> > +
> > +				map1 {
> > +					trip = <&skin_temp_alert1>;
> > +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> >  	vreg_edp_bl: regulator-edp-bl {
> >  		compatible = "regulator-fixed";
> >  

-- 
மணிவண்ணன் சதாசிவம்
