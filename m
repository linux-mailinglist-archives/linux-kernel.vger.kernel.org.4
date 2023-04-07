Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7217E6DAF33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbjDGPDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbjDGPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:02:49 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39FABDF7;
        Fri,  7 Apr 2023 08:02:01 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E3E2D1C0004;
        Fri,  7 Apr 2023 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680879694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mR/UUPL2IMYCFFGQvAbrgjotcIuS51YMFyDQudOhWV0=;
        b=jodAY8mpmlyxesuWp+fuRfmk88+kdcRqdygU8HwnK3DyHFX9cJHl8ZtPvvy2lLaLbppIPw
        TdCPIzwJ+8qwmt8GPknXs1FkBliysMlRrZKZsifr4wTnInhI0wF4fkCi7sPcDiak4GHLV7
        /AT+VRLJMiz0OJK5yzsNZC+Re/kphwvVz2Mav8sG14P5s66kCNjIOZnuZJxIFF3ZT+iDOt
        7KjCMVm8PHv1HxUpOu5kUlH73+s96CFAyuozPDo9nELg1tBFwqvL1CzQID6x68d68abvlk
        dlBVrkz8VEUGJSO+x9ElZcE2vTH6+kztMrPsEZbmZ0p5zecpm2pV6I2dGIzhxg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH] arm64: dts: marvell: mochabin: enlarge PCI memory window
In-Reply-To: <20230219121418.1395401-1-robert.marko@sartura.hr>
References: <20230219121418.1395401-1-robert.marko@sartura.hr>
Date:   Fri, 07 Apr 2023 17:01:32 +0200
Message-ID: <871qkv4tyr.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

> Armada 7040 uses a rather small 15MB memory window for every PCI adapter,
> however this is not sufficient for Qualcomm QCA6390 802.11ax cards that
> are shipped along with the OpenWrt WLAN model of MOCHAbin as ath11k
> requires at least 16MB of memory.
>
> So, similar to what MACCHIATOBin has been doing for years, lets move
> to using the second PCIe 2 memory window and expand it to 128MB to
> make it future proof.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> index 7ca71f2d7afb..39ce6e25a8ef 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> @@ -455,4 +455,5 @@ &cp0_pcie2 {
>  	phys = <&cp0_comphy5 2>;
>  	phy-names = "cp0-pcie2-x1-phy";
>  	reset-gpios = <&cp0_gpio1 9 GPIO_ACTIVE_LOW>;
> +	ranges = <0x82000000 0x0 0xc0000000 0x0 0xc0000000 0x0 0x8000000>;
>  };
> -- 
> 2.39.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
