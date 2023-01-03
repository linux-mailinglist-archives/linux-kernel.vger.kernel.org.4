Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA53F65BE47
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbjACKg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjACKg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:36:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE03E65;
        Tue,  3 Jan 2023 02:36:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AC786120E;
        Tue,  3 Jan 2023 10:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DDCC433EF;
        Tue,  3 Jan 2023 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672742183;
        bh=0l/jEazf659tayPyid3sUc0mwvJhC0Rmy66HOeL2yxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URV1bAvIz0cQgJWx769mY3qmM/vyf06WDUw9ZvBtTdjh/3yTzWc/AzK01qMyyv6xJ
         SKQhCqgPdJy9K7/PKjqWe7T4WsRAqC0xVjVUu9bHoUMSJesTqoKpAF8R+aq74LGg5m
         9L/qc0nKGs7LkBk2xt6y+pq23dFIqO1NHVZSJ+c1XgPqPSLdeMmpk03p55q9YVccyD
         d7uk0hJPXdFM0kecNRgan0kSukwN9M57+pTTWWsYSDjZmjFz8sQt+NghNGHLZNSVwE
         i2xCyL2oZF/BKgLnZc3/wNDwJ05tvF/3EEta9gj859U+45NIRkEf3118EqAEEp1lHP
         2reSboTVlugNw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCeex-0004Bk-8E; Tue, 03 Jan 2023 11:36:43 +0100
Date:   Tue, 3 Jan 2023 11:36:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sm8450-hdk: move wcd938x codec
 node
Message-ID: <Y7QFO8lHSexucASN@hovoldconsulting.com>
References: <20230103103141.15807-1-johan+linaro@kernel.org>
 <20230103103141.15807-6-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103103141.15807-6-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:31:40AM +0100, Johan Hovold wrote:
> The wcd938x codec is not a memory-mapped device and does not belong
> under the soc node.
> 
> Move the node to the root node to avoid DT validation failures.
> 
> While at it, clean up the node somewhat by reordering properties and
> renaming it 'audio-codec'.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 53 ++++++++++++-------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 4de3e1f1c39c..8ac7265d8c10 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -17,6 +17,32 @@ aliases {
>  		serial0 = &uart7;
>  	};
>  
> +	wcd938x: audio-codec {
> +		compatible = "qcom,wcd9380-codec";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_default>;
> +
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;

Bah, apparently I forgot to move the vendor properties after the
supplies as I had intended. Probably not worth resending the series
over.

> +
> +		reset-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
> +
> +		vdd-buck-supply = <&vreg_s10b_1p8>;
> +		vdd-rxtx-supply = <&vreg_s10b_1p8>;
> +		vdd-io-supply = <&vreg_s10b_1p8>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +
> +		#sound-dai-cells = <1>;
> +	};

Johan
