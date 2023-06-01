Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7348C719A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjFAKtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjFAKtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:49:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC818119
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:49:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30ae967ef74so656420f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685616553; x=1688208553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6i9C4EP8AHVTuV3ZMe99mOFKpU+CtVbrRAVY/z6F08=;
        b=oc+kSwOejXR3o5/TWUq6wGiMZH/wU0no+eCTXLchWMtnXgaiUV33WezN5EA/yl+X5F
         LEVZkkU++l0Bj45+pvR8elTDVufgCbeLTHLjbgcKs35VWnaaW/9VVmSAGWQEmVLP0Lts
         DcEXgeZt5UgqblJvZ9VM+jfWObwaYWAIba9D7HSLT5bFrYTJS92ttbJcV9yh1oNZ6mI5
         3FrbFhOl1cm6ahXz5UmCcaJGBD0cNV9H7HNXkJ8JSvaXkFy3YmKlwRMGPo5X2iJa8oGz
         QhWyEt7hTdqUnJD0Hx/u60zbwkk+FB4H10l4xarKuWGyZBYTKP6aUk5MAg7ZAxt7YQGZ
         Bg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685616553; x=1688208553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6i9C4EP8AHVTuV3ZMe99mOFKpU+CtVbrRAVY/z6F08=;
        b=C+Dh16jaAwAa7Z7JrYYGVv81Ki7Yzwe+KBB/gWWzvGe0NuV5KrQKRHbVmiftEetZHo
         Cj5L9zlVv3pvAkE9i0NN+O4no9nCYTIvVYErTq7IskKG8rrWtUxTjySBGgmBjFBoSj1Y
         8PPe0Fx2CKTTZsMVfVzQlTs0mW0ie01C9Zv2Xv7koqaRPtiBDE/f7UVNPxl+Lw5V81MJ
         lMx5eX1F2e9mhWHWeuV+l3okq/oe6Rbx7iK8GRbHOnV11wC+8mg6ThrS+CUMkJIm8guK
         G/Bqso2r3hLL4qbOHK3+yUUSQACGiyAu3M9W6RbbMA7sRD+6qyuVJCOU1AJo2Iz2/T6F
         Aq2Q==
X-Gm-Message-State: AC+VfDwI8fjIJgkRMMkGH9wvLTWWRlfHfM5zskGUzZcZld1veAgsOXoR
        O2rEmsmJcw7bECqHtZDkLgC0bw==
X-Google-Smtp-Source: ACHHUZ7fq/bLvbnOkM6SF0YMAS3rD6jeKKObv8mxqEWBcWmJbEXGSPr9VwRL/vKvivqbJrKzXyOFDQ==
X-Received: by 2002:a5d:5412:0:b0:30a:e66f:7571 with SMTP id g18-20020a5d5412000000b0030ae66f7571mr1828931wrv.4.1685616553144;
        Thu, 01 Jun 2023 03:49:13 -0700 (PDT)
Received: from linaro.org ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b0030af1d87342sm10037872wrp.6.2023.06.01.03.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:49:12 -0700 (PDT)
Date:   Thu, 1 Jun 2023 13:49:11 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Add missing interconnect path
 to USB HC
Message-ID: <ZHh3pyQprqKDn+TS@linaro.org>
References: <20230601103817.4066446-1-abel.vesa@linaro.org>
 <34cd6db8-9f05-23cc-cd41-7fd48ec1a286@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34cd6db8-9f05-23cc-cd41-7fd48ec1a286@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-01 12:42:22, Konrad Dybcio wrote:
> 
> 
> On 1.06.2023 12:38, Abel Vesa wrote:
> > The USB HC node is missing the interconnect paths, so add them.
> > 
> > Fixes: 7f7e5c1b037f ("arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes")
> For context, it's a fix in the context of "we should prooobably have
> this if we want to fix the icc driver to include sync state".

Fair enough...

> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> 
> 
> sidenote:
> 
> on recent SoCs there's also an USB-IPA path:
> 
> aggre1_noc MASTER_USB3_0 <-> &config_noc SLAVE_IPA_CFG

AFAIK, support for IPA on SM8550 is not added yet.

We can worry about this 3rd path when IPA support for this platform is
upstreamed.

> 
> I don't think we really make use of that upstream today or whether it
> would make enabling IPA necessary (to enable the clocks and reach the
> IPA hardware), but it's something to think about.
> 
> Konrad
> >  arch/arm64/boot/dts/qcom/sm8550.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > index 75cd374943eb..4991b2e962d1 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > @@ -2793,6 +2793,10 @@ usb_1: usb@a6f8800 {
> >  
> >  			resets = <&gcc GCC_USB30_PRIM_BCR>;
> >  
> > +			interconnects = <&aggre1_noc MASTER_USB3_0 0 &mc_virt SLAVE_EBI1 0>,
> > +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
> > +			interconnect-names = "usb-ddr", "apps-usb";
> > +
> >  			status = "disabled";
> >  
> >  			usb_1_dwc3: usb@a600000 {
