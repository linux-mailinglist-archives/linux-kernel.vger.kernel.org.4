Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917A4660518
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjAFQvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjAFQvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:51:44 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB473D5D6;
        Fri,  6 Jan 2023 08:51:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EFE8A425F5;
        Fri,  6 Jan 2023 16:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673023902; bh=EPFvEd87CFEOl6kkAh31MhZn8AnrKlMWs4KTdbvU0qY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tJVNipEmFVCS3k7gPlntUC9ZFz1KmnJqvVQp0CY2BvJ198REA1+4Mg967S/e3jKvC
         UIzTJHiAWZxWZNrDxNkC90yzw/WLc5jGkamhCJIwjhFgqDDyFJZHZh/COqz+tqYVXE
         tHtyhwgW0K4+FsocQIFIXJzuQmTgW9UxI6ZjH8AvH1RpaiUBaMX7qJt2L7k8v2nKt9
         SUb/NgFXD64/EUBoLCsJpD0msJYSvtn5iUzbOWt03o2oPO4acpPxPbT1sAOto8tm4n
         k2J4oDgbssxZhRtcgzrWabPbyqLahILGmduJciDdApkDeGtntJbbHuajkmEukSMMUc
         7LnjOrXE8p6LA==
Message-ID: <ced5bfbc-79f8-156a-32d5-27fe2be67236@marcan.st>
Date:   Sat, 7 Jan 2023 01:51:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 4/5] arm64: dts: apple: t600x: Add PWM controller
Content-Language: en-US
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230106135839.18676-1-fnkl.kernel@gmail.com>
 <20230106135839.18676-5-fnkl.kernel@gmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230106135839.18676-5-fnkl.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 22.58, Sasha Finkelstein wrote:
> Adds PWM controller and keyboard backlight bindings for M1 Pro/Max MacBook Pros
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  arch/arm64/boot/dts/apple/t600x-die0.dtsi      |  9 +++++++++
>  arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
> index 1c41954e3899..7065045dc43a 100644
> --- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
> +++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
> @@ -154,6 +154,15 @@ i2c5: i2c@39b054000 {
>  		status = "disabled";
>  	};
>  
> +	fpwm0: pwm@39b030000 {
> +		compatible = "apple,t6000-fpwm", "apple,s5l-fpwm";
> +		reg = <0x3 0x9b030000 0x0 0x4000>;
> +		power-domains = <&ps_fpwm0>;
> +		clocks = <&clkref>;
> +		#pwm-cells = <2>;
> +		status = "disabled";
> +	};
> +

We usually keep device nodes sorted by address, so this is out of order
and should come before i2c (at least). No need to respin just for this
though, I can fix it when I apply it, so:

Acked-by: Hector Martin <marcan@marcan.st>

Maintainers: as we usually ask, please merge only the driver commit (#2)
via the PWM tree, we'll take care of DTs/MAINTAINERS/bindings via
asahi-soc so we can avoid serializing/blocking other DT changes.

- Hector
