Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C95EB8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiI0DfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiI0DfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381B8C45B;
        Mon, 26 Sep 2022 20:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C78366158B;
        Tue, 27 Sep 2022 03:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357C1C433C1;
        Tue, 27 Sep 2022 03:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664249701;
        bh=LHKljmUJD6+nBKD9Sl+fyn85qpcLFXl+iKbzyFVtXog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XO0AeookKeEgVecg3h7jlfoTjP2Q2TbtOCOuZIDUwloM6wVTNL1hyPm9Kr+l7LFjr
         2g1OgzFRdMX6ql7uJaIMfTNS05JB0SpnV9PIlCA2dZOlYRrwwF20dOdfCY/nAZL+r5
         CbIp27OYKpSCLEZXHYXNnrkYSgycSVfiqGt/Zvu01geKjFu92+MAHl+2cOsakiFCGA
         pPLWTJilEThS/MMe6mxwbgjZk6avTZBKYPzsx6jnP3L1JkIyCoaSRdTF/XxXCAXCzS
         PSmlno99HDztBnWsqPM+YJpp6+vDppPZ39IHQvpOlBFAToycJMdBzK5ALyZbh7Cxgp
         E4jgWor13+/TA==
Date:   Mon, 26 Sep 2022 22:34:58 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        ohad@wizery.com, linux-arm-msm@vger.kernel.org,
        baolin.wang@linux.alibaba.com, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org, vkoul@kernel.org
Subject: Re: (subset) [PATCH v3 00/15] ARM/hwlock: qcom: switch TCSR mutex to
 MMIO
Message-ID: <20220927033458.q4jzxxlxwkbwybxm@builder.lan>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
 <166310928500.670084.9085382465104729419.b4-ty@kernel.org>
 <3456921e-15cf-90da-44eb-bb378d217daa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3456921e-15cf-90da-44eb-bb378d217daa@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 01:14:54AM +0300, Dmitry Baryshkov wrote:
> On 14/09/2022 01:48, Bjorn Andersson wrote:
> > On Fri, 9 Sep 2022 11:20:20 +0200, Krzysztof Kozlowski wrote:
> > > Switch older Qualcomm SoCs to use MMIO-based method instead of syscon.
> > > 
> > > Not tested on hardware. Please kindly provide tests.
> > > 
> > > Changes since v2
> > > ================
> > > 1. Rebase on current MFD changes.
> > > 2. Add Rb tag.
> > > 3. Split MFD patch to separate patchset:
> > > https://lore.kernel.org/linux-devicetree/20220909091056.128949-1-krzysztof.kozlowski@linaro.org/T/#u
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [05/15] arm64: dts: qcom: ipq6018: add missing TCSR syscon compatible
> >          commit: d30bcfa4408596e8dd3714dfdd90334d2bdc9856
> > [06/15] arm64: dts: qcom: msm8953: add missing TCSR syscon compatible
> >          commit: d07ac9d93ced0f8203230bf1de49b7cc605e1547
> > [07/15] arm64: dts: qcom: qcs404: add missing TCSR syscon compatible
> >          commit: 98460385091fc2e86a296f9643105d8a8777ccc2
> > [08/15] arm64: dts: qcom: msm8996: add missing TCSR syscon compatible
> >          commit: 8a99e0fc8bd3fa9c8be1fc115a2e38f4fd51ccda
> 
> Please revert 08/15, it is incorrect.
> 

I'm not able to see why it is not correct to claim that the tcsr region
is compatible with qcom,tcsr-msm8996? Please let me know and we can
revert this in -rc.

Regards,
Bjorn

> > [11/15] arm64: dts: qcom: ipq6018: switch TCSR mutex to MMIO
> >          commit: f5e303aefc06b7508d7a490f9a2d80e4dc134c70
> > [12/15] arm64: dts: qcom: msm8994: switch TCSR mutex to MMIO
> >          commit: 9e826e05061c61d84217bbe436b4ef0bedbfe458
> > [14/15] ARM: dts: qcom: apq8084: switch TCSR mutex to MMIO
> >          commit: 16ae4e557b2fa9fc7372b4503247aca80a476272
> > [15/15] ARM: dts: qcom: msm8226: switch TCSR mutex to MMIO
> >          commit: 18a4af7a598445af54e1e16a66b7f31669578701
> > 
> > Best regards,
> 
> -- 
> With best wishes
> Dmitry
> 
