Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243296A6E2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCAOSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCAOSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615EE44BF;
        Wed,  1 Mar 2023 06:17:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F25612EA;
        Wed,  1 Mar 2023 14:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C93C433EF;
        Wed,  1 Mar 2023 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677680275;
        bh=qQgUmqLZ5CagKEtT4vnz4bnoe/03JhuYy6/fuVoHVEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXNV7oS7yvU6ChHD/ZpV4ukjq+QSSyqR9CBOC099Rm9WVGYunWlTqyXTtUXtR7/Qe
         VT+4FxPM5PlpVqTaYb2v95lUuLIlsKz6yp8kTduZ/hzI+QXIEuEr8dpSmn137Gywg/
         AiVHgRDAmIctQSUtkBubfpngudBfSionf4F6JbfS3GUhQeJHkZU/aRg8G5qx+BSicy
         mkrryqQ7N8nJQdoIteAZYpvjCDqbXl5gNPrKyAuAfJXrj/Djf24UqgG9ZyAdFU1sVP
         DzV4jK35VDy+4dclObXjCkH+5DiIqa5loJyol5be6TESvbfajZfDg6qZDYdleG0E86
         EjX/u/Q5WIvQw==
Date:   Wed, 1 Mar 2023 14:17:49 +0000
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2 2/2] leds: add aw20xx driver
Message-ID: <Y/9ejXZWqXhF64gT@google.com>
References: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
 <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
 <Y/5xBGFC3b9Chdtb@duo.ucw.cz>
 <Y/8TTRtoFMJhMWV1@google.com>
 <Y/8g4QfOJhjc4WMb@amd.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/8g4QfOJhjc4WMb@amd.ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023, Pavel Machek wrote:

> Hi!
> 
> > > > +config LEDS_AW200XX
> > > > +	tristate "LED support for Awinic AW20036/AW20054/AW20072"
> > > > +	depends on LEDS_CLASS
> > > > +	depends on I2C
> > > > +	help
> > > > +	  This option enables support for the AW20036/AW20054/AW20072 LED driver.
> > > > +	  It is a 3x12/6x9/6x12 matrix LED driver programmed via
> > > > +	  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> > > > +	  3 pattern controllers for auto breathing or group dimming control.
> > > 
> > > I'm afraid this should be handled as a display, not as an array of
> > > individual LEDs.
> > 
> > Just for my own information, where do we draw the line on this?
> 
> Not sure.
> 
> > Is 4x4 okay?  How about 6x6?
> 
> I'd say "As soon as it is 2-dimensional". Even 3x2 array is a display.
> 
> If the LEDs are independend, and it makes sense to display disk
> activity on one and CPU activity on second... that's for LED
> subsystem.
> 
> When userspace needs to know where are the LEDs spatially located, and
> when you start putting synchronized animations over the LEDs... well,
> then maybe that's a display.
> 
> 6x9 is definitely a display. We won't put 1920x1080 phone display into
> drivers/leds just because it is OLED...

Got it, thank you Pavel.

-- 
Lee Jones [李琼斯]
