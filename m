Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104B9659AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiL3RQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3RQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:16:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BFB2654;
        Fri, 30 Dec 2022 09:16:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3DA86181A;
        Fri, 30 Dec 2022 17:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B68FC433EF;
        Fri, 30 Dec 2022 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672420582;
        bh=EjjJYlDGDYCeAbL7B91JnbZs5ulwNKec7qPkIMCdOvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLn77BkYgZHJjz375jHL6HGSvBeJ1aI/IBmmoKjVVWEEDDKKLsjEK2SsN9XYimbYi
         bjRAmiJp25ARsoy2dOFjrqZxbH+RcFEaUmUgXZKm5gOPqoaKV11T7OCYQ+tN/BNMUw
         Jd5FlVE2Eknoj6Rk8k88/bwM8Au0J88/owbTTwLyphdRA2prmsfeJvGG6253aROfUQ
         nUNsrxAYP/x+kA3+VDigcc5JnAUXEPA5Sqvre1xzZIgJyZUDfQThM3RG63W9rrExOf
         WLpwP1SM2IAT9+Ydkd3asy4aNDTymnstCLVzfKHSh2icxkoublQaiHYFFaEHJyE2sF
         YJfzY4n3/lTjw==
Date:   Fri, 30 Dec 2022 11:16:19 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] arm64: dts: qcom: sc8280xp: remove GCC from CX power
 domain
Message-ID: <20221230171619.om5mfvsp7gwatvu6@builder.lan>
References: <20221230155502.115205-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230155502.115205-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 04:55:02PM +0100, Krzysztof Kozlowski wrote:
> Bindings do not allow power-domain property in GCC clock controller and
> documentation does not indicate that GCC is part of VDD_CX.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Maybe the bindings should be fixed? Maybe this was added as workaround?
> Anyway looking at documentation I do not see such relation, except
> downstream vdd_cx-supply (which is the same as in other SoCs and we do
> not represent it in upstream).

The GCC itself is powered by CX and the GDSC power-domains exposed by
GCC are powered by CX.

It's fairly recently that we started attempting to scale CX - and
attempted to suspend things. But this is probably how it should be
represented on all platforms.


So let's fix the binding instead.

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 1d1420c8720c..d14663c9f34c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -799,7 +799,6 @@ gcc: clock-controller@100000 {
>  				 <&pcie4_phy>,
>  				 <0>,
>  				 <0>;
> -			power-domains = <&rpmhpd SC8280XP_CX>;
>  		};
>  
>  		ipcc: mailbox@408000 {
> -- 
> 2.34.1
> 
