Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301376E2C3F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjDNWFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDNWFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:05:44 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F6E3ABB;
        Fri, 14 Apr 2023 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s+IM/+0ZljmoOwrC8aH0N6phZc5Qbyf0wMKHprnzsNQ=; b=c3UxjVFSuQJdID+wTU9Df0cxAG
        9/kq8+F1ioKAvh7UHPGDdjIoJVtqOVEbu2jdTnoFr1EbEGNMjHaqr2x9c+VNA+m77Dstq0E5LHyXd
        t4BRU0ZRdRZXGGSYiX2Gw/aptn6ZBsaCy0wRwHZ5BHNvyRUMpS3cOq3iiWF+385cTD3bGfm/BjqVK
        pCb4Y/8MZMY80sSdFsJlmZUiXGtwvRHakgeU+adT8upqimxo/cD/5FZ4gMFQ2WUk3xvFiCh6mVxg1
        whPTnZ5m8hK4q/sHi/LZUoVQyvJymO/uzYD0aBxu5lzihAWO2aH2XZbFy4N0IlisOeLUBtN1tv0EB
        KSMRImVg==;
Received: from p200300ccff0c0d001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:d00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pnRXz-00075s-Bh; Sat, 15 Apr 2023 00:05:35 +0200
Date:   Sat, 15 Apr 2023 00:05:33 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel
 i2c LED driver
Message-ID: <20230415000533.534ea99b@aktux>
In-Reply-To: <ZDlEsNZ3pTlfxkAz@duo.ucw.cz>
References: <20230414055341.335456-1-andreas@kemnade.info>
        <20230414055341.335456-3-andreas@kemnade.info>
        <ZDlEsNZ3pTlfxkAz@duo.ucw.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Fri, 14 Apr 2023 14:18:56 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > The device provides 6 channels which can be individually
> > turned off and on but groups of two channels share a common brightness
> > register.  
> 
> Yeah, well.. Turn it into 3-channel controller with brightness or
> 6-channel on/off one... You can't really share brightness.
> 
No, I cannot change the hardware, so it is a 6-channel with limitations.
And the devicetree has to describe the hardware and not the driver.

What is discussable is just how the driver should deal with that:

I see 5 possibilities.
a) ignore the shared brightness problem (status quo)
b) never set a brightness other than full on/off
c) ignore one led of each pair (not register it at all{
d) couple also the on/off of the pairs, so present to
   userspace only max. 3 leds.
e) allow full brightness control where independently possible,
   if LEDs are defined where that leads to conflicts,
   register them with max_brightness=1 and use them
   in on/off mode.

My preference were a) or e), the most possible usages.
e) has a cleaner interface to the userspace.

I would not upstream b)

Regards,
Andreas

> > +++ b/drivers/leds/Kconfig
> > @@ -551,6 +551,17 @@ config LEDS_REGULATOR
> >  	help
> >  	  This option enables support for regulator driven LEDs.
> >  
> > +config LEDS_BD2606MVV
> > +	tristate "LED driver for BD2606MVV"
> > +	depends on LEDS_CLASS
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	help
> > +	  This option enables support for BD2606MVV LED driver chips
> > +	  accessed via the I2C bus. It supports setting brightness, with
> > +	  the limitiation that there are groups of two channels sharing
> > +	  a brightness setting, but not the on/off setting.
> > +  
> 
> This driver can be used as a module...
> 
> 
> > +static int
> > +bd2606mvv_brightness_set(struct led_classdev *led_cdev,
> > +		      enum led_brightness brightness)
> > +{
> > +	struct bd2606mvv_led *led = ldev_to_led(led_cdev);
> > +	struct bd2606mvv_priv *priv = led->priv;
> > +	int err;
> > +
> > +	if (brightness == 0)
> > +		return regmap_update_bits(priv->regmap,
> > +					  BD2606_REG_PWRCNT,
> > +					  1 << led->led_no,
> > +					  0);
> > +
> > +	/* shared brightness register */
> > +	err = regmap_write(priv->regmap, led->led_no / 2,
> > +			   brightness);
> > +	if (err)
> > +		return err;  
> 
> Yeah. No.
> 
> Best regards,
> 							Pavel

