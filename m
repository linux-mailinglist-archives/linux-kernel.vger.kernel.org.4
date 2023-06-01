Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7F371F219
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjFAS3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjFAS3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:29:04 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229DBE47;
        Thu,  1 Jun 2023 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AQcVgfW3AF1zATJmxtuE2HxXTPlWoZL81qZFjeP/IXs=; b=d5L7zlnF/YekEEl7dOGnWtNyPB
        PC8uMiqJm2kA+DBOkGFwx9e8tCYL03larfOOKItCGkhhKojr0c0x6HZIZN5gEqajQX4NTJ9arBqzr
        ARv5gbuiklV6Z36f643DMS4660Jdshy8HerXvQNxoguhp3qkCliV4yCSFdtdqSNhwx70=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42688 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q4n1B-0004uN-JV; Thu, 01 Jun 2023 14:27:26 -0400
Date:   Thu, 1 Jun 2023 14:27:24 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     m.brock@vanmierlo.com
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Message-Id: <20230601142724.4fb197fd315e6d360c0d0457@hugovil.com>
In-Reply-To: <c5c2879e55102a6d517245e6d251290d@vanmierlo.com>
References: <20230601163113.2785657-1-hugo@hugovil.com>
        <20230601163113.2785657-4-hugo@hugovil.com>
        <c5c2879e55102a6d517245e6d251290d@vanmierlo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v5 3/9] serial: sc16is7xx: refactor GPIO controller
 registration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 19:28:01 +0200
m.brock@vanmierlo.com wrote:

> Hugo Villeneuve schreef op 2023-06-01 18:31:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > In preparation for upcoming patch "fix regression with GPIO
> > configuration". To facilitate review and make code more modular.
> > 
> > Cc: <stable@vger.kernel.org> # 6.1.x
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 39 ++++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c 
> > b/drivers/tty/serial/sc16is7xx.c
> > index 0c903d44429c..279d7dcb1447 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1349,6 +1349,26 @@ static int
> > sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
> > 
> >  	return 0;
> >  }
> > +
> > +static int sc16is7xx_setup_gpio_chip(struct device *dev)
> 
> Only one parameter, but...
> 
> > +	ret = sc16is7xx_setup_gpio_chip(dev, mctrl_mask);
> 
> called with two.

Hi Maarten,
sorry about that, I will fix this for V6.

Somehow my automated compile script tested each patch separately, including this one, but the defconfig didn't enable the module sc6is7xx, so the error went unnoticed. I wrongly assumed that "make alldefconfig" enabled all modules, I will instead use "make allyesconfig".

Hugo.
