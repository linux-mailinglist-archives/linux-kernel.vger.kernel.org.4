Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D376C684B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCWM2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjCWM2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C70AF19;
        Thu, 23 Mar 2023 05:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9686A62668;
        Thu, 23 Mar 2023 12:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17BAC433EF;
        Thu, 23 Mar 2023 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679574494;
        bh=I4/FlAcpx/CFBi5Q0ba3/uTIJWxKNhnqFmzABrNRV9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+3p3GMk8QuCt4JKjsi7wha0GUQ1no0qXFsoKyorbTJqbhsWxK0hn5YYvlqQ4lYfQ
         fGSofkJ0GRYjxfvuetCOhBJo2ju8ZazM0UjwE/hUGpSJRW+xAgiofyM20nkI7fprpJ
         5xGxGJnVs/A2ffHt24Y9zuIjmBrZAR1eG+2mkzukIpikvk9/7VN/1Mm9273O80gI9e
         OYmrlvassy5C1exkhhZBBcwQlqtxB69EnQB+PEa7K3m2GD5OjTwTeMJ/TeamgEeBxq
         D2ZLP9JU04pi1vv8crGIcz/aaayVJJkKime3XNLcPPmxGPGcsYQx8+RXCyS78gzUyC
         my8luNBLpwHQA==
Date:   Thu, 23 Mar 2023 12:28:09 +0000
From:   Lee Jones <lee@kernel.org>
To:     Joseph Strauss <jstrauss@mailbox.org>
Cc:     pavel@ucw.cz, jansimon.moeller@gmx.de, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add multicolor support to BlinkM LED driver
Message-ID: <20230323122809.GK2673958@google.com>
References: <20221228010958.9670-1-jstrauss@mailbox.org>
 <20230315161614.GC9667@google.com>
 <20230322232109.zddbr4umzfr76wgf@libretux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230322232109.zddbr4umzfr76wgf@libretux>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023, Joseph Strauss wrote:

> On 23/03/15 04:16PM, Lee Jones wrote:
> > On Tue, 27 Dec 2022, Joseph Strauss wrote:
> >
> > > Added multicolor support to the BlinkM driver, making it easier to
> > > control from userspace. The BlinkM LED is a programmable RGB LED. The
> > > driver currently supports only the regular LED sysfs class, resulting in
> > > the creation of three distinct classes, one for red, green, and blue.
> > > The user then has to input three values into the three seperate
> > > brightness files within those classes. The multicolor LED framework
> > > makes the device easier to control with the multi_intensity file: the
> > > user can input three values at once to form a color, while still
> > > controlling the lightness with the brightness file.
> > >
> > > The main struct blinkm_led has changed slightly. A struct
> > > led_classdev_mc has been added to represent the multicolor sysfs class,
> > > and an additional struct led_classdev pointer has been added for
> > > convenience, which points to the struct led_classdev within struct
> > > led_classdev_mc. The struct led_classdev for the regular sysfs classes
> > > remain. Additionally, a field representing the multicolor LED has been
> > > added to the struct blinkm_data, seperate from the blinkm_leds[3] array.
> > >
> > > In the blinkm_probe function, the multicolor LED class is registered
> > > after the regular LED classes. The blinkm_set_mc_brightness() function
> > > had to be added to calculate the three color components and then set the
> > > fields of the blinkm_data structure accordingly.
> > >
> > > Signed-off-by: Joseph Strauss <jstrauss@mailbox.org>
> > > ---
> > > Changes in v2:
> > > - Replaced instances of the constant 3 with NUM_LEDS, where applicable
> > > - Fixed formatting errors
> > > - Replaced loop inside of blinkm_set_mc_brightness() with equivalent
> > >   statements
> > > - Changed id of multicolor class from 4 to 3
> > > - Replaced call to devm_kmalloc_array() with devm_kcalloc()
> > >
> > >  Documentation/leds/leds-blinkm.rst |  26 +++++-
> > >  drivers/leds/Kconfig               |   1 +
> > >  drivers/leds/leds-blinkm.c         | 143 +++++++++++++++++++++++------
> > >  3 files changed, 137 insertions(+), 33 deletions(-)

[...]

> > +	mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
> > > +	mc_led_info[1].channel = 1;
> > > +	mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
> > > +	mc_led_info[2].channel = 2;
> > > +	mc_led->mcled_cdev.subled_info = mc_led_info;
> > > +	mc_led->mcled_cdev.num_colors = NUM_LEDS;
> > > +
> > > +	mc_led->led_cdev = &mc_led->mcled_cdev.led_cdev;
> > > +	mc_led->led_cdev->brightness = 255;
> > > +	mc_led->led_cdev->max_brightness = 255;
> > > +	mc_led->led_cdev->flags = LED_CORE_SUSPENDRESUME;
> > > +	snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> > > +		 "blinkm-%d-%d-multi",
> > > +		 client->adapter->nr,
> > > +		 client->addr);
> > > +	mc_led->led_cdev->name = blinkm_led_name;
> > > +	mc_led->led_cdev->brightness_set_blocking =
> > > +					blinkm_set_mc_brightness;
> >
> > 100-chars.
> >
>
> I am not sure what you mean by this. The following line is 78
> characters.

No need to wrap.  You have 100-chars to play with.

Review comments pertain to the lines that preceded them.

> > > +
> > >  exit:
> >
> > If you want to submit a patch to get rid of this exit label ...
> >
>
> This exit label existed before my patch and is used in several places. I
> don't quite see what's wrong with it. Would you please clarify?

That's why I asked for a follow-up patch.

gotos are useful when there is a bunch of unwinding/deallocating/freeing
of resources.  This one is pointless.  Just `return err;` instead.

--
Lee Jones [李琼斯]
