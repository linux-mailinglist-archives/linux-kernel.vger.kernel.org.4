Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8019626A02
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKLOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKLOkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:40:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70AE1C415
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 06:40:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso6946776pjc.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bIZDCVzPPjeVdKIk8F8Uv0L3duOYsMu0/eWhzix57vE=;
        b=SgtHZqh9wD+qbdxjkCbxLhKl2gLUkSUxEOoQ/Yiftl9N9XRaN42vlI0WUcwXwfVXTn
         J6E2JYQ8k4+o0ExPP46zeFzPP9gkSID52C1MH3BDWFsznZDOQ22cUReZmwSGEONfC0jr
         CTZwDa+yLcLl/rugWxr0sFDXiAq1CrC8GZ5m01Am09CHbV6Yu0LL67moMmJdL4jX3wG3
         yR9xJ6ITd0obGZcqR+FCEawTV3cFC1OcWkRcu4hQ+KsLl7XO+MjVPvJnrX7k6fuNitoM
         9oEiK5THRlXDHQ1pysOPZt5UNwvGmEtyepvH59+xxN5ItKPE0WQEeGCdNOF7NbnZ6G11
         s8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIZDCVzPPjeVdKIk8F8Uv0L3duOYsMu0/eWhzix57vE=;
        b=axWcVqLWIGdDJql5wZtByg5L34fieUb/8SR4VfU4SowJKdGT+2nUhx98BWxaa3lMf9
         4+1aDNMUPvNDn41l9A+QMM0OnFA2n+FnMFZQzQFJOaznjjFirV41if1FX2Ua6taVRSch
         lJ/LHvUSnQgptxb+1lzSMbhcwxrFxtM4y8s+l2KQHGQ1JhFXa/ajDYJo+73RLFZVV/5z
         a5Gvd/zZh7MQEpeBop3CM7x9KKdLHl+GuC3slYFDNWgifyzrJf+A1HZsO8uVUuHo5kBo
         zxXDNUeqMDjnViZiTg9FU8+I0WPaeEls3R/VM0OlAuG01S9l78ZtHm1mWBUklidoqScA
         dbkg==
X-Gm-Message-State: ANoB5pmgsLxqtbG9xSknMfUFjtFGoMWgwNXt4i6uRfgNutztsqZEN7+o
        6CCHpM5X7SfYWyzJgoq/h89r
X-Google-Smtp-Source: AA0mqf4V0MvKh/F4vjxhQra+NmLToI21qXSfrRqdxC8PQ11CWY9xPpq9a08b0yLlvng1AqaZ7MEfvA==
X-Received: by 2002:a17:902:7247:b0:186:6f97:fe90 with SMTP id c7-20020a170902724700b001866f97fe90mr6684390pll.75.1668264003242;
        Sat, 12 Nov 2022 06:40:03 -0800 (PST)
Received: from thinkpad ([2409:4072:6d03:e3e3:883:ee9e:a771:761d])
        by smtp.gmail.com with ESMTPSA id d187-20020a6236c4000000b0056bdb5197f4sm3386924pfa.35.2022.11.12.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 06:40:02 -0800 (PST)
Date:   Sat, 12 Nov 2022 20:09:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] arm64: dts: qcom: sc8280xp-crd: enable WiFi
 controller
Message-ID: <20221112143537.GA140906@thinkpad>
References: <20221110103558.12690-1-johan+linaro@kernel.org>
 <20221110103558.12690-7-johan+linaro@kernel.org>
 <20221110113513.GA18247@thinkpad>
 <Y254AvMKyDQ+tY0q@hovoldconsulting.com>
 <20221111204021.myjms5c2rntu4a76@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111204021.myjms5c2rntu4a76@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:40:21PM -0600, Bjorn Andersson wrote:
> On Fri, Nov 11, 2022 at 05:27:46PM +0100, Johan Hovold wrote:
> > On Thu, Nov 10, 2022 at 05:05:13PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Nov 10, 2022 at 11:35:55AM +0100, Johan Hovold wrote:
> > > > Enable the Qualcomm QCNFA765 Wireless Network Adapter connected to
> > > > PCIe4.
> > > > 
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 65 +++++++++++++++++++++++
> > > >  1 file changed, 65 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > > > index 5b9e37a16f9f..ab5b0aadeead 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > > > @@ -81,6 +81,22 @@ vreg_misc_3p3: regulator-misc-3p3 {
> > > >  		regulator-always-on;
> > > >  	};
> > > >  
> > > > +	vreg_wlan: regulator-wlan {
> > > > +		compatible = "regulator-fixed";
> > > > +
> > > > +		regulator-name = "VCC_WLAN_3R9";
> > > > +		regulator-min-microvolt = <3900000>;
> > > > +		regulator-max-microvolt = <3900000>;
> > > > +
> > > > +		gpio = <&pmr735a_gpios 1 GPIO_ACTIVE_HIGH>;
> > > > +		enable-active-high;
> > > > +
> > > > +		pinctrl-names = "default";
> > > > +		pinctrl-0 = <&hastings_reg_en>;
> > > 
> > > Hastings is the family name of QCA639x WLAN chipsets. I don't think it would be
> > > applicable here. Please use "wlan_reg_en" as that matches the convention used
> > > throughout this file.
> > 
> > The pin name here comes from the schematics, which is what we should use
> > for naming when we can.

If hastings is what mentioned in the schematics then it is fine (I can see that
now). For a moment I thought it came from downstream...

Thanks,
Mani

> > 
> 
> Following the naming in the schematics is the right thing to do.
> 
> Regards,
> Bjorn

-- 
மணிவண்ணன் சதாசிவம்
