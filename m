Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D055B9299
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiIOCUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIOCUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9D58B998;
        Wed, 14 Sep 2022 19:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 822386162F;
        Thu, 15 Sep 2022 02:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53AFC433D6;
        Thu, 15 Sep 2022 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663208428;
        bh=PSh8JdsejLk3YdJmyNJWTxq/QAvtosFvQb2IPGGebCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Klph75UUbX5hrezxdVrD+ozKMafMT1EM55pCRTfCtjagIsC8BZbilMqEajQuYjdmh
         duLsGHQALOVejTSe8X0vW8+p/j95s06GNRnV0WCa16a+zTqGoZuNfWYvRkcE3Vwn53
         6hIJg4xgX5fwdY1lBh2hkAAmbBcYGLT4GnrIcPNTn/ul22QorzgcUez2wREtpLdCtc
         zbC9qOp3gTQMnrjbt9rQVxI6QHt+VQlQMai8HeQPHH1TGQmJRYZ4CHL8EYsamdp4mI
         4LgvJjWDqg2iZUZ8xhxW15cfU2kvg5epWaFRzUnvRhXoKnAsFM8AGRG84ALm1W6cVf
         s3oehtsmTXLGA==
Date:   Wed, 14 Sep 2022 21:20:25 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, mka@chromium.org,
        johan+linaro@kernel.org, quic_kriskura@quicinc.com,
        dianders@chromium.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add required-opps for USB
Message-ID: <20220915022025.rwqooixqhhuott6n@builder.lan>
References: <20220914053017.23617-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914053017.23617-1-quic_rjendra@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 11:00:17AM +0530, Rajendra Nayak wrote:
> USB has a requirement to put a performance state vote on 'cx'
> while active. Use 'required-opps' to pass this information from
> device tree, and since all the GDSCs in GCC (including USB) are
> sub-domains of cx, we also add cx as a power-domain for GCC.
> Now when any of the consumers of the GDSCs (in this case USB)
> votes on a perforamance state, genpd framework can identify that
> the GDSC itself does not support a performance state and it
> then propogates the vote to the parent, which in this case is cx.
> 
> This change would also mean that any GDSC in GCC thats left enabled
> during low power state (perhaps because its marked with a
> ALWAYS_ON flag) can prevent the system from entering low power
> since that would prevent cx from transitioning to low power.
> Ideally any consumers that would need to have their devices
> (partially) powered to support wakeups should look at making the
> resp. GDSCs transtion to a Retention (PWRSTS_RET) state instead
> of leaving them ALWAYS_ON.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> ---
> * This patch is a follow up based on the discussion on the previously
>   posted version to support USB performance state voting [1]
> 
> * Another patch that this approach depends on is the one to fix the
>   handling of PWRSTS_RET in the GDSC driver [2] so we can have USB
>   GDSC transtion to a RET state instead of marking it ALWAYS_ON
> 
> [1] https://lore.kernel.org/linux-usb/YTduDqCO9aUyAsw1@ripper/
> [2] https://lore.kernel.org/all/20220901101756.28164-1-quic_rjendra@quicinc.com/#t
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index ad04025a8a1a..8a21446738bf 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -828,6 +828,7 @@
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> +			power-domains = <&rpmhpd SC7280_CX>;
>  		};
>  
>  		ipcc: mailbox@408000 {
> @@ -3456,6 +3457,7 @@
>  					  "ss_phy_irq";
>  
>  			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
> +			required-opps = <&rpmhpd_opp_svs>;

The patch looks really good, but don't you need &rpmhpd_opp_nom for the
200MHz assigned to GCC_USB30_PRIM_MASTER_CLK?

Also, how about adding the same to &usb_2, while we're at it?

Regards,
Bjorn

>  
>  			resets = <&gcc GCC_USB30_PRIM_BCR>;
>  
> -- 
> 2.17.1
> 
