Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C5464E293
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiLOUwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLOUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:52:02 -0500
X-Greylist: delayed 596 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 12:52:00 PST
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 895C350D65;
        Thu, 15 Dec 2022 12:52:00 -0800 (PST)
Received: from [192.168.0.17] (cpc76482-cwma10-2-0-cust177.7-3.cable.virginm.net [86.14.20.178])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 6E33E14022A;
        Thu, 15 Dec 2022 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1671136923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNzr3o3XBuM2ARVluiGzk/KlaWpCEtA4u+GM+9nASXg=;
        b=KHp22PgWnM9kvRlxQ5yyv0xxQzwQfmrnv16OPKxTfn2i6+xgMDM29SWpe9RqwpZZyQJD/+
        3EBjAp2ts0EHbZHIeBdf0grX/HOYu/9sYQ0ryokm68xhkvf9X7CX4b9a4S9iy9zdHbEhKn
        TncaFG9uHHoCekbZ1dDvfLY+MRXt8+s=
Message-ID: <78769cf4-84cc-5195-57b8-823d9fc33794@postmarketos.org>
Date:   Thu, 15 Dec 2022 20:42:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] arm64: dts: rockchip: fix input enable pinconf on rk3399
Content-Language: en-US
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com
References: <20221215101947.254896-1-arnaud.ferraris@collabora.com>
From:   Caleb Connolly <kc@postmarketos.org>
In-Reply-To: <20221215101947.254896-1-arnaud.ferraris@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/12/2022 10:19, Arnaud Ferraris wrote:
> When the input enable pinconf was introduced, a default drive-strength
> value of 2 was set for the pull up/down configs. However, this parameter
> is unneeded when configuring the pin as input, and having a single
> hardcoded value here is actually harmful: GPIOs on the RK3399 have
> various same drive-strength capabilities depending on the bank and port
> they belong to.
> 
> As an example, trying to configure the GPIO4_PD3 pin as an input with
> pull-up enabled fails with the following output:
> 
>    [   10.706542] rockchip-pinctrl pinctrl: unsupported driver strength 2
>    [   10.713661] rockchip-pinctrl pinctrl: pin_config_set op failed for pin 155
> 
> (acceptable drive-strength values for this pin being 3, 6, 9 and 12)
> 
> Let's drop the drive-strength property from all input pinconfs in order
> to solve this issue.
> 
> Fixes: ec48c3e82ca3 ("arm64: dts: rockchip: add an input enable pinconf to rk3399")
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>

Reviewed-by: Caleb Connolly <kc@postmarketos.org>

> ---
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 92c2207e686c..59858f2dc8b9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -2221,13 +2221,11 @@ pcfg_input_enable: pcfg-input-enable {
>   		pcfg_input_pull_up: pcfg-input-pull-up {
>   			input-enable;
>   			bias-pull-up;
> -			drive-strength = <2>;
>   		};
>   
>   		pcfg_input_pull_down: pcfg-input-pull-down {
>   			input-enable;
>   			bias-pull-down;
> -			drive-strength = <2>;
>   		};
>   
>   		clock {

-- 
Kind Regards,
Caleb (they/them)
