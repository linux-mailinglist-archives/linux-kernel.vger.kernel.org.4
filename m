Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A046710A50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbjEYKuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240392AbjEYKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A2F10B;
        Thu, 25 May 2023 03:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 584D964424;
        Thu, 25 May 2023 10:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCC0C433EF;
        Thu, 25 May 2023 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685011808;
        bh=bITUuS/msjqCHswws53qmVLCSN8fQpxyKJDunhlChSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UaV9sjBUaHcoWhvbXo6Rl62e3Xy5H7OrI20SC97t537BRRBA0fLFy6tIyqT5G6Rzs
         3f2ZPeSsZKi+1APyYByZK+fZpTOW5R2sqtChLpDjx1tp6pk9bmu8Vfurh3cg4rJoKB
         kTfZACmlHsOPaOU+iaENPHyJkOSBV9k7V0d9CEsMnjKIU3IgIS/UIL8ozfGZ+TJeAf
         vc+z3n+fGP+0MbWKaz6tO1Ca94k48w1BhJVHOj+hWGRhKCMjwr/NpnHzhKQ27aLhk3
         S3WJkauEhRoyCEJr8llgHIESDbE8ZYkQ0eHg2gScrEZBAgfuTvUFDWPRgAk6iiV7sw
         qD4iaxU4edayA==
Date:   Thu, 25 May 2023 11:50:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andreas Kemnade <andreas@kemnade.info>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM/gpio: Push OMAP2 quirk down into TWL4030 driver
Message-ID: <20230525105003.GF9691@google.com>
References: <20230430-omap2-pdata-quirks-v1-0-e015f3a3ea46@linaro.org>
 <20230430-omap2-pdata-quirks-v1-1-e015f3a3ea46@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230430-omap2-pdata-quirks-v1-1-e015f3a3ea46@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 May 2023, Linus Walleij wrote:

> The TWL4030 GPIO driver has a custom platform data .set_up()
> callback to call back into the platform and do misc stuff such
> as hog and export a GPIO for WLAN PWR on a specific OMAP3 board.
> 
> Avoid all the kludgery in the platform data and the boardfile
> and just put the quirks right into the driver. Make it
> conditional on OMAP3.
> 
> I think the exported GPIO is used by some kind of userspace
> so ordinary DTS hogs will probably not work.
> 
> Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-omap2/omap_device.c  |  1 -
>  arch/arm/mach-omap2/pdata-quirks.c | 41 +-----------------------------
>  drivers/gpio/gpio-twl4030.c        | 52 ++++++++++++++++++++++++++------------

>  include/linux/mfd/twl.h            |  3 ---

Acked-by: Lee Jones <lee@kernel.org>

>  4 files changed, 37 insertions(+), 60 deletions(-)

-- 
Lee Jones [李琼斯]
