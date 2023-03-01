Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF46A6E5D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCAO0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCAO0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:26:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF003E609;
        Wed,  1 Mar 2023 06:26:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2BB80CE1D26;
        Wed,  1 Mar 2023 14:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05767C433D2;
        Wed,  1 Mar 2023 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677680794;
        bh=BjmTIrIEnZJgrM3eByHsh6KymXaN7KmmKRnfV9KbbSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ocq27FrpYmJINQjh82fKHc7xbZiKYnkQgWtwLNVyi7BTsZ43S8K95MhgifaAW7ExS
         pM1Me5gjc35shCpuayMyFBuxio1R/BOt1wWR+U1B0PgULXxzYFyqcijLrtTPhk2YVF
         DFYJlfdY//KBt+c0KHWPQKcWTYc6Uqxi+xZeN6cgqjIl9a74avUvapmkadg9s3OQj/
         zAyiUWVPiY9VX7CpC0Ac5kRPelBUE3jt/pr5kj4JzTk+5LRm9VAoUHC4m+NixLl5mL
         /6us+B+bUVEDYoQDIGACYbvxYeK+Fg0EAMXI0kpdK7bpUwW/usjJbwCtG1Pmv8cvga
         53RLzut1/QIlQ==
Date:   Wed, 1 Mar 2023 14:26:29 +0000
From:   Lee Jones <lee@kernel.org>
To:     Joseph Strauss <jstrauss@mailbox.org>
Cc:     pavel@ucw.cz, jansimon.moeller@gmx.de, conor@kernel.org,
        christophe.jaillet@wanadoo.fr, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add multicolor support to BlinkM LED driver
Message-ID: <Y/9glWxJR0D3kXf5@google.com>
References: <20221228010958.9670-1-jstrauss@mailbox.org>
 <Y7xHQLlSNisUboCH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7xHQLlSNisUboCH@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

I see that you are active again - please could you prioritise this one.

> On Tue, 27 Dec 2022, Joseph Strauss wrote:
> 
> > Added multicolor support to the BlinkM driver, making it easier to
> > control from userspace. The BlinkM LED is a programmable RGB LED. The
> > driver currently supports only the regular LED sysfs class, resulting in
> > the creation of three distinct classes, one for red, green, and blue.
> > The user then has to input three values into the three seperate
> > brightness files within those classes. The multicolor LED framework
> > makes the device easier to control with the multi_intensity file: the
> > user can input three values at once to form a color, while still
> > controlling the lightness with the brightness file.
> > 
> > The main struct blinkm_led has changed slightly. A struct
> > led_classdev_mc has been added to represent the multicolor sysfs class,
> > and an additional struct led_classdev pointer has been added for
> > convenience, which points to the struct led_classdev within struct
> > led_classdev_mc. The struct led_classdev for the regular sysfs classes
> > remain. Additionally, a field representing the multicolor LED has been
> > added to the struct blinkm_data, seperate from the blinkm_leds[3] array.
> > 
> > In the blinkm_probe function, the multicolor LED class is registered
> > after the regular LED classes. The blinkm_set_mc_brightness() function
> > had to be added to calculate the three color components and then set the
> > fields of the blinkm_data structure accordingly.
> > 
> > Signed-off-by: Joseph Strauss <jstrauss@mailbox.org>
> > ---
> > Changes in v2:
> > - Replaced instances of the constant 3 with NUM_LEDS, where applicable
> > - Fixed formatting errors
> > - Replaced loop inside of blinkm_set_mc_brightness() with equivalent
> >   statements
> > - Changed id of multicolor class from 4 to 3
> > - Replaced call to devm_kmalloc_array() with devm_kcalloc()
> > 
> >  Documentation/leds/leds-blinkm.rst |  26 +++++-
> >  drivers/leds/Kconfig               |   1 +
> >  drivers/leds/leds-blinkm.c         | 143 +++++++++++++++++++++++------
> >  3 files changed, 137 insertions(+), 33 deletions(-)
> 
> Another one for Pavel until I can build some knowledge.
> 
> -- 
> Lee Jones [李琼斯]

-- 
Lee Jones [李琼斯]
