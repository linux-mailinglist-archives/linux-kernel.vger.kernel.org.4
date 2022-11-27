Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A9F639C5F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 19:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiK0Sbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 13:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiK0Sbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 13:31:53 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4485BDF69;
        Sun, 27 Nov 2022 10:31:51 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 23CD811ED;
        Sun, 27 Nov 2022 19:31:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669573909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfHh5EwkvsEuQH9VGCwExhDOA5E7QBcDJe9jFMWQ0RI=;
        b=J4doKE8Mfp8wNgXOownzniBUUunsnoQdZqOxo6ua76abg9pzeDkCXJlQ0bFR3ZqEI531QD
        vd+ICxZIkReyHuqsMANxXlmvvblA1wJOt9fYWodZMlC28hHktNAttAtXG314GeSNkB8DzP
        v+H2HLi/bnlYHWoT0DROF3oItzqOXJa7u8XSeGgNmhq1OfNd8OzNSWz4YdiZ3lUTpo2GF1
        TTCa57QRlzKao21eE5jBEMf4YzdD6MI76lTbxczl/iugAar+RqfWLMpJ5sJ4OpNyFXRxu5
        ZvSVIl3P3TlG0Lv3zU55H4a7L8qVAEGYHx+8BfW4ciqkNNSjvv4IasMRgqVGCg==
MIME-Version: 1.0
Date:   Sun, 27 Nov 2022 19:31:48 +0100
From:   Michael Walle <michael@walle.cc>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v3 3/9] gpio: 104-dio-48e: Migrate to the regmap-irq API
In-Reply-To: <Y3ykg1Vc96Px6ovg@fedora>
References: <cover.1669100542.git.william.gray@linaro.org>
 <80fc819bcafe9697b6e02c0750d3cf0ea4ec9e1b.1669100542.git.william.gray@linaro.org>
 <Y3414YhVjqKakddV@smile.fi.intel.com> <Y3ykg1Vc96Px6ovg@fedora>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <3a23df35a35cdba19eeb10c75b5bca97@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[sorry this mail was just delivered now, although it seems
to be sent last Tuesday.]

Am 2022-11-22 11:29, schrieb William Breathitt Gray:
> On Wed, Nov 23, 2022 at 05:01:53PM +0200, Andy Shevchenko wrote:
>> On Tue, Nov 22, 2022 at 02:11:00AM -0500, William Breathitt Gray 
>> wrote:
>> > +	/* Initialize device interrupt state */
>> > +	err = regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
>> > +	if (err)
>> > +		return err;
>> 
>> Use ->init_hw() callback for this.
> 
> In a subsequent patch 7/9 we remove direct gpio_chip registration in
> favor of the i8255 library registration via gpio_regmap. It doesn't 
> look
> like gpio_regmap_register() sets the init_hw() callback.
> 
> Michael, do you see any issues if I introduce init_hw() to
> gpio_regmap_config? Or do you think this IRQ initialization belongs
> somewhere else?

Something like the following?
   gpiochip->init_hw = config.irq_init_hw;

gpiochip doesn't seem to be the correct place, gpiochip_add_irqchip()
is a noop for gpio-regmap, right? So using gpiochip_irqchip_init_hw()
seems wrong.

Maybe make gpio-regmap call it on its own? But really we just connect
the regmap-irq to the gpiochip irqdomain. What is the purpose of the
.init_hw callback? I've looked at other drivers which use regmap-irq
and they all seem to just initialize the hardware in their _probe().

-michael
