Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3955661201E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ2EpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiJ2EpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:45:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9C422FD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:45:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso11663788pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cMXXcHIJpdgfCG4kb6+eRNUQjVyKYt9c/7vvbgqvAxI=;
        b=C/tu0qOWJARQpN3fLEdgRr7dSfDpf9yG3SR2/GY9PQRughufYGZ9dzpGr/bRHF6IjS
         f2Msprm5/bA1GxS/G2N/ANCQ9jBuyJaT+FrqeMVmB3EqMaQSdZGCkjWwfnbnSLHXAoZ1
         byPEyC1H4w6X6ZMflOId7SKrokFzVpJWt7XK3UFx5zFhzw5kpyu+A9L8xnsya+0Dg5+z
         sJ657P5/Vi++gBf+do6h3BuawEgHCDj29UVk2G+/ErkF1x8dkCRBPFn7xHJHIZEWqyUu
         +zjP0ZBiHPZXyUQ9pKbClr3RyLNMMW19VA/YhZDTMvkPDNHEAQIvDPxc11vV5AuDlRgx
         yq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMXXcHIJpdgfCG4kb6+eRNUQjVyKYt9c/7vvbgqvAxI=;
        b=z/Q+Ke+zicHHbmxeMoFxQnVsBUphCEyioYDirM0qeCO1E/yIoE79McgbuAfnAG1TEe
         phIOdjBVjUQsybV++5b+bMDmF6/3SPxGHwJ6Pk7WUFe2On1RMiLLk3DwqtVNChF54JAE
         q18sW2KCh69Ofu+snDQzn2ZfFKdFZBPgRXCLe/X0U6S8mlX0P9b0n1+epHCZIyWDlyJC
         i2tDtHy2tV9xc6SfOWx6oC/VWOmzWShdjab2nqVGTkif1gXyT+heBf6+sx9w2UZZgzIy
         67Or6Pv6d55B5AMR28ERRx3ZcLZQ6J1h4YK+mZXf7fHbcFKBjS4BzSXe5chsZRDxdTuN
         a+kg==
X-Gm-Message-State: ACrzQf0mpJMzoGE1OwSOiSmbf5W2FJ5c1M73hWSFjl/49+bP433X46Fb
        t33fU2elYq+ndyX+5aE2JYG3
X-Google-Smtp-Source: AMsMyM5yMqiV4qvNeajNznO/K4lRaEUuV+0wpajr6EvNKhNOmn3cdV4wPficSOCXTrfPLg1vTQsCbw==
X-Received: by 2002:a17:903:2014:b0:186:8937:28a6 with SMTP id s20-20020a170903201400b00186893728a6mr2534512pla.39.1667018709223;
        Fri, 28 Oct 2022 21:45:09 -0700 (PDT)
Received: from thinkpad ([59.92.103.167])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b00186b69157ecsm293533plg.202.2022.10.28.21.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 21:45:08 -0700 (PDT)
Date:   Sat, 29 Oct 2022 10:15:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johan+linaro@kernel.org, quic_jprakash@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] arm64: dts: qcom: sc8280xp-x13s: Add PMK8280 VADC
 channels
Message-ID: <20221029044501.GB5362@thinkpad>
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
 <20221027063006.9056-9-manivannan.sadhasivam@linaro.org>
 <0d4af50e-558a-e9cd-1d6f-54c77e0deb86@linaro.org>
 <1f1ecb2c-16d8-4530-9deb-7ef8861a128d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f1ecb2c-16d8-4530-9deb-7ef8861a128d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:04:24AM -0400, Krzysztof Kozlowski wrote:
> On 27/10/2022 10:03, Krzysztof Kozlowski wrote:
> > On 27/10/2022 02:30, Manivannan Sadhasivam wrote:
> >> Add VADC channels for measuring the on-chip die temperature and external
> >> crystal osciallator temperature of PMK8280.
> >>
> >> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> ---
> >>  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> >> index 6aa8cf6d9776..9ac5d5c22832 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> >> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> >> @@ -7,6 +7,7 @@
> >>  /dts-v1/;
> >>  
> >>  #include <dt-bindings/gpio/gpio.h>
> >> +#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> >>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >>  
> >>  #include "sc8280xp.dtsi"
> >> @@ -173,6 +174,23 @@ &pmk8280_pon_resin {
> >>  	status = "okay";
> >>  };
> >>  
> >> +&pmk8280_vadc {
> >> +	status = "okay";
> >> +
> >> +	pmk8280-die-temp@3 {
> > 
> > die-temp@
> 
> Hm, wait, unless this is the die temperature of pmk8280? But then how
> about pmic-die-temp?

Yes, this is the die temperature of PMK8280, so "pmic-die-temp" makes sense.

Thanks,
Mani

> 
> 
> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
