Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7335C7034CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbjEOQwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243159AbjEOQwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:52:06 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C05518C;
        Mon, 15 May 2023 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=b+W/F7yXZR7s3otsypsoipKP62aBFg8kZ9xQo9eyh/4=; b=InYa3CgIkshvdnMxAk5ao/bQ0I
        yrBJ1N29URrJWujN6c3ZJ2gLjM0SqV+qzzlN0IalOB5ZQSpqmMBZpCLGJSKGsog38vOCaScX/3yZg
        ZFaJbwZjrnoIMewuE9liNeb/uxQqPFSbQzjnbTXAb6Mq3MA6nymy2yPQdhzFaxPYQO2I=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:48548 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pybQR-0003hf-Mu; Mon, 15 May 2023 12:51:56 -0400
Date:   Mon, 15 May 2023 12:51:55 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Tomasz =?UTF-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20230515125155.bf6d64c292ba96f4f6971ac0@hugovil.com>
In-Reply-To: <2023051551-quickstep-outshine-5526@gregkh>
References: <20230515160206.2801991-1-hugo@hugovil.com>
        <2023051551-quickstep-outshine-5526@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [RFC PATCH] Revert
 "sc16is7xx: Separate GPIOs from modem control lines"
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, 15 May 2023 18:20:02 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, May 15, 2023 at 12:02:07PM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > This reverts commit 679875d1d8802669590ef4d69b0e7d13207ebd61.
> > 
> > Because of this commit, it is no longer possible to use the 16 GPIO
> > lines as dedicated GPIOs on the SC16IS752.
> > 
> > Reverting it makes it work again.
> > 
> > The log message of the original commit states:
> >     "Export only the GPIOs that are not shared with hardware modem
> >     control lines"
> > 
> > But there is no explanation as to why this decision was taken to
> > permanently set the function of the GPIO lines as modem control
> > lines. AFAIK, there is no problem with using these lines as GPIO or modem
> > control lines.
> > 
> > Maybe after reverting this commit, we could define a new
> > device-tree property named, for example,
> > "use-modem-control-lines", so that both options can be supported.
> > 
> > Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control
> > lines")
> 
> Please do not line-wrap these lines.

Ok.

> > 
> 
> Nor is a blank line needed here.

Ok.

> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index 5bd98e4316f5..25f1b2f6ec51 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -306,7 +306,6 @@ struct sc16is7xx_devtype {
> >  	char	name[10];
> >  	int	nr_gpio;
> >  	int	nr_uart;
> > -	int	has_mctrl;
> >  };
> >  
> >  #define SC16IS7XX_RECONF_MD		(1 << 0)
> > @@ -447,35 +446,30 @@ static const struct sc16is7xx_devtype sc16is74x_devtype = {
> >  	.name		= "SC16IS74X",
> >  	.nr_gpio	= 0,
> >  	.nr_uart	= 1,
> > -	.has_mctrl	= 0,
> >  };
> >  
> >  static const struct sc16is7xx_devtype sc16is750_devtype = {
> >  	.name		= "SC16IS750",
> > -	.nr_gpio	= 4,
> > +	.nr_gpio	= 8,
> 
> I think this one line change is all you really need here, right?  the
> otner changes do nothing in this patch, so you should just create a new
> one changing this value.  Oh, and this one:
> 
> >  	.nr_uart	= 1,
> > -	.has_mctrl	= 1,
> >  };
> >  
> >  static const struct sc16is7xx_devtype sc16is752_devtype = {
> >  	.name		= "SC16IS752",
> > -	.nr_gpio	= 0,
> > +	.nr_gpio	= 8,
> 
> right?
> 
> Don't mess with the has_mctrl stuff, that's not relevant here.

Sorry, I just noticed that simply reverting commit 679875d1d880 is not sufficient (and will not compile). We must also revert part of commit:
21144bab4f11 ("sc16is7xx: Handle modem status lines").

The problem is that the commit 679875d1d880 was incomplete, and it was (unfortunately) completed by integrating it in commit 21144bab4f11 ("sc16is7xx: Handle modem status lines"). The relevant change was only these 5 new lines, burried deeply into the second commit: 

@@ -1353,9 +1452,17 @@ static int sc16is7xx_probe(struct device *dev,
                sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
                                     SC16IS7XX_EFCR_RXDISABLE_BIT |
                                     SC16IS7XX_EFCR_TXDISABLE_BIT);
+
+               /* Use GPIO lines as modem status registers */
+               if (devtype->has_mctrl)
+                       sc16is7xx_port_write(&s->p[i].port,
+                                            SC16IS7XX_IOCONTROL_REG,
+                                            SC16IS7XX_IOCONTROL_MODEM_BIT);
+

Therefore, I should also remove these lines if we go forward with a revert of the patch (should I add another tag "Fixes..." in that case?).

And what do you think of my proposal to maybe replace has_mctrl with a device tree property so that both modes can be fully supported?

Thank you,
Hugo.
