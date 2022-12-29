Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431E065909E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiL2S5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiL2S5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:57:47 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FFD13EB7;
        Thu, 29 Dec 2022 10:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672340256;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=og/5NweM9CpQZmCLz/mFb+oKie8+YSeYfWJcuhS3+Cc=;
    b=nfGk9s7G9qViIcRKLecFQyR38KGkA8V2nPSZtgtVA0OdctYm+LuT8lvsQSJmXthNZh
    1dQSJLLO1JgOAKIzMnvcfcT92adMv8YT+mqW7LcM0juyZTGZXx0mobeJreMM+9vLm5VR
    Uy6GongJZC7GwPwRXvAy1H5LXi4wOQcA2cH4CBZOYuij8MbGVn2iMW2UIDMK46a+63zR
    av6kzqtxl2Sg22hr2VBTPS9kjbVNJKhMdGrhfo4oxCIaKaszEecwBpwm6bwVbDM6mEiX
    OTTarXF2563KsiSqdi88QLW7sTxdx8fzhluEf5UwkP6kuMUxFrO2H9xMAMvEtkdte7n0
    XCCw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWyvDI"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yBTIvZXjA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 29 Dec 2022 19:57:35 +0100 (CET)
Date:   Thu, 29 Dec 2022 19:57:29 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add qcom,dp-manual-pullup
 description
Message-ID: <Y63jBu38L/5cQ75S@gerhold.net>
References: <20221229183410.683584-1-bryan.odonoghue@linaro.org>
 <20221229183410.683584-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229183410.683584-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 06:34:09PM +0000, Bryan O'Donoghue wrote:
> The original Qualcomm driver for the HighSpeed USB PHY contains a flag
> which tells the driver that the controller and PHY do not connect to VBUS.
> 
> In this case an external IC such as a Type-C port manager supplies VBUS and
> the VBUS signal is not routed to the SoC. This means we cannot detect the
> presence or absence of VBUS and cannot take action based on it.
> 
> Document the downstream boolean qcom,dp-manual-pullup to allow the HS PHY
> implement the necessary logic.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

AFAIK it is not possible to route VBUS directly to the controller on
these SoCs so this property would likely be added to the SoC dtsi
(i.e. msm8916.dtsi and msm8939.dtsi) and used by all boards.

This means we could just bind this behavior to the existing SoC-specific
compatible (i.e. of_device_is_compatible(..., "qcom,usb-hs-phy-msm8916"))
and avoid having an extra property.

Thoughts?

Thanks,
Stephan

> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> index aa97478dd0161..c55a59df71ad0 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> @@ -80,6 +80,13 @@ properties:
>              the address is offset from the ULPI_EXT_VENDOR_SPECIFIC address
>          - description: value
>  
> +  qcom,dp-manual-pullup:
> +    type: boolean
> +    description: This flag indicates to the HS USB PHY driver that it should
> +                 enable or disable an internal pullup when powering on or
> +                 powering off the HS PHY instead of toggling the value when VBUS
> +                 is absent or present.
> +
>  required:
>    - clocks
>    - clock-names
> -- 
> 2.34.1
> 
