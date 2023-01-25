Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D929867ACAC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjAYIpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjAYIou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:44:50 -0500
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Jan 2023 00:40:17 PST
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9329E53565;
        Wed, 25 Jan 2023 00:40:16 -0800 (PST)
Received: from sas8-92ddc00f49ef.qloud-c.yandex.net (sas8-92ddc00f49ef.qloud-c.yandex.net [IPv6:2a02:6b8:c1b:2988:0:640:92dd:c00f])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id D8C285F39A;
        Wed, 25 Jan 2023 11:33:16 +0300 (MSK)
Received: by sas8-92ddc00f49ef.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id CXKlpM8YBeA1-MrFzk96U;
        Wed, 25 Jan 2023 11:33:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1674635596;
        bh=Iu7kC5v6n5QYhMcI1r9TLZt9aPN3xDWmxLQey5H8/Sc=;
        h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
        b=fBIvUJjSADfV0T9Xa3qtwCwY5pN92MQzDF2KhoQm8bB4GVPvcjCQdTPhlN5+qiUUr
         S++rIecuSu/WVFVwrkjTh15i/Y2pHGTsqHUIpPbGT0cUPmio7Pgj1DtNrR4hGdHn+d
         XfzmtzALnXKiv0CZBuhU/yIjEr71jRACDBQIBqOs=
Authentication-Results: sas8-92ddc00f49ef.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Date:   Wed, 25 Jan 2023 11:33:11 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Hartley Sweeten" <hsweeten@visionengravers.com>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Lukasz Majewski" <lukma@denx.de>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: ep93xx: convert driver to DT
Message-ID: <20230125113311.2aff259d@redslave.neermore.group>
In-Reply-To: <a699e52a-db19-4374-a4bc-a3948ecc43ef@app.fastmail.com>
References: <20230117100845.16708-1-nikita.shubin@maquefel.me>
        <a699e52a-db19-4374-a4bc-a3948ecc43ef@app.fastmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd!

On Tue, 17 Jan 2023 11:15:20 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Jan 17, 2023, at 11:08, Nikita Shubin wrote:
> 
> > 
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id ep93xx_gpio_match[] = {
> > +	{ .compatible = "cirrus,ep93xx-gpio" },
> > +	{ /* end of table */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, ep93xx_gpio_match);
> > +#endif
> > +
> >  static struct platform_driver ep93xx_gpio_driver = {
> >  	.driver		= {
> >  		.name	= "gpio-ep93xx",
> > +		.of_match_table = ep93xx_gpio_match,
> >  	},
> >  	.probe		= ep93xx_gpio_probe,  
> 
> The #ifdef here is wrong and will cause a build failure because
> of the unconditional reference to the variable.
> 
> Just remove the #ifdef/#endif.

Sorry about that - i remember that i should drop it everywhere, which
did for all but ep93xx-gpio, i am dropping match currently, as it will
produce a warning without dt-bindings documentation, it will be
introduced together with the rest of series.

> 
>     Arnd

