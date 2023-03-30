Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FB86D0C31
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjC3RFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjC3RFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA70C644;
        Thu, 30 Mar 2023 10:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A12B620BB;
        Thu, 30 Mar 2023 17:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB164C4339C;
        Thu, 30 Mar 2023 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680195938;
        bh=dl+pD6CWVBgH90is4aDu0oHOzvp7o6CFpKFTzbh3qio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvKLL9Uy608+ysCmsFjzYAbG56HJVL+Mm7dMziQu9WdfNewKu/EHK2vUqGjcjK4uc
         nwJ1/WIUMEZk/YXYTYzenMYFARurjDzDCGtLPUndSZeUDMTUAlvJJOLBeWgcHXgvTi
         rDrCB/kncXqfeVMzVgX8hN2WCbjqdiWsVBa+ZZYWu2dfM4tg7U3fUrdu/SErsUQsjJ
         cPjTGhECIe1CHmZ3HSTE26ys/gSEbGmDeNHp6AHFCNm5jIMKcCsxf/xi9vNR6beCr9
         bfXt4k0QY01y3lf9Le+tU7UnHq0svuFOxL/JOAHU7necOqNPiKEqwEK0L2++0c0AAA
         sqfJPnS6OKlzQ==
Date:   Thu, 30 Mar 2023 18:05:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, ChiYuan Huang <cy_huang@richtek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alice Chen <alice_chen@richtek.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: mt6370: fix CONFIG_LINEAR_RANGES select
Message-ID: <20230330170533.GA548901@google.com>
References: <20230328131222.1390091-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328131222.1390091-1-arnd@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> CONFIG_LINEAR_RANGE does not exist, but selecting is silently ignored.
>
> ERROR: modpost: "linear_range_get_selector_within" [drivers/leds/rgb/leds-mt6370-rgb.ko] undefined!
>
> Fixes: 55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/leds/rgb/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Beaten to it I'm afraid:

https://lore.kernel.org/r/20230323105410.10396-1-lukas.bulwahn@gmail.com

> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index 7d86bb26c54b..360c8679c6e2 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -29,7 +29,7 @@ config LEDS_QCOM_LPG
>  config LEDS_MT6370_RGB
>  	tristate "LED Support for MediaTek MT6370 PMIC"
>  	depends on MFD_MT6370
> -	select LINEAR_RANGE
> +	select LINEAR_RANGES
>  	help
>  	  Say Y here to enable support for MT6370_RGB LED device.
>  	  In MT6370, there are four channel current-sink LED drivers that
> --
> 2.39.2
>

--
Lee Jones [李琼斯]
