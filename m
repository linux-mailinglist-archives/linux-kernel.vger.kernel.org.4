Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97D762BB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiKPLV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239088AbiKPLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:21:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB0E13FA5;
        Wed, 16 Nov 2022 03:09:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C2A561CCE;
        Wed, 16 Nov 2022 11:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C537C433D6;
        Wed, 16 Nov 2022 11:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668596991;
        bh=2g6REZIoHini1Be2TEM/kcaiFbWvM7rHzkfW8xjPr0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t4cEvNCrHtQORU1hVaQga/pf5JTXCtcIO99NbQnLB/AaTRmcseyxSCA62wsGUxwCl
         Mr8FZgVDcxrCKLrBMBVu5fIejfgCgKu2Pe8VIxqByRucuwUfKE5DCrAHeblNHmAl/P
         q8kXOF3nIeU0irR4SnWdTvcI8hL2rmqEcl15plTK6PoSZj8hbGCB9NNfPxZgLprmFw
         W8H3HMjpqsnlopC0QaDJ81jxYGHmhmCni8ecfKSILe/ltOw375gn4NKDaxx9j/AoOU
         6oacVcgFmd4a2MpTTKmlif9J33FVVEcNdH8y/WYikIJ254hY6kvm16iAmgPpF0GSLF
         DRVJFqwok22yw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovGID-0006iN-6O; Wed, 16 Nov 2022 12:09:21 +0100
Date:   Wed, 16 Nov 2022 12:09:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add soundcard support
Message-ID: <Y3TE4YWPZ2XrO+Ru@hovoldconsulting.com>
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
 <20221115170242.150246-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115170242.150246-4-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 05:02:42PM +0000, Srinivas Kandagatla wrote:
> Add support for SoundCard on X13s. This patch adds support for Headset
> Playback, record and 2 DMICs on the Panel along with the regulators
> required for powering up the LPASS codecs.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 213 ++++++++++++++++++
>  1 file changed, 213 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index b2b744bb8a53..99c3021e8149 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -58,6 +58,16 @@ vreg_misc_3p3: regulator-misc-3p3 {
>  		regulator-boot-on;
>  		regulator-always-on;
>  	};
> +
> +	vph_pwr: vph-pwr-regulator {

Use "regulator-" as a name prefix, and add "vreg_" as label prefix for
consistency:

	vreg_vph_pwr: regulator-vph-pwr {

> +		compatible = "regulator-fixed";
> +		regulator-name = "VPH_VCC3R9";
> +		regulator-min-microvolt = <3900000>;
> +		regulator-max-microvolt = <3900000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>  };

Johan
