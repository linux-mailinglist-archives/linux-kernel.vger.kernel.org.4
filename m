Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB472B2DA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 18:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjFKQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFKQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 12:30:33 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C23E56;
        Sun, 11 Jun 2023 09:30:31 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686501029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbSQRgFkxJkOPOWTloWRdlbJ87X+3povzOv9QKqLcjk=;
        b=dTpCWIYp5u7mc6RwO2o27PM8fuz/JUZlx0HpZPaYG+XVoPKuoGe8VqDzBxwoG7wgSyuBYB
        azM/SFAbIxgqYOdxKkztr8kQG/tw2JCLNtasB4ZwyhFLKe3VPRu+5nkldwc2M7ZpjdhfS0
        FtZBUEeV01ubsj7Pepcys+6CZC0ThfLkw6PLuDl98wE1gaswK+gCaaToDnUc+t0u8gMkQt
        MAUy4mIued6z67rbOb5YUDMoLOSmOKDjDiZNzgwB3X1ur7/sIanZsZASSqxOm3NRWXJLcP
        pEEF8KntxeH6FC4uFe0c231Jar+rZJLLO5Ir18BJkXJ9O0xmbBLfsQ2pTieNQg==
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00AB1E0002;
        Sun, 11 Jun 2023 16:30:25 +0000 (UTC)
Date:   Sun, 11 Jun 2023 18:30:24 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <simon.horman@corigine.com>,
        alexis.lothore@bootlin.com
Subject: Re: [PATCH net-next] net: altera_tse: fix init sequence to avoid
 races with register_netdev
Message-ID: <20230611183024.6e6fd46a@pc-7.home>
In-Reply-To: <ZIXrYupBmpviSEW3@shell.armlinux.org.uk>
References: <20230611104019.33793-1-maxime.chevallier@bootlin.com>
        <ZIXrYupBmpviSEW3@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 11 Jun 2023 16:42:26 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Sun, Jun 11, 2023 at 12:40:19PM +0200, Maxime Chevallier wrote:
> > As reported here[1], the init sequence in altera_tse can be racy should
> > any operation on the registered netdev happen after netdev registration
> > but before phylink initialization.
> > 
> > Fix the registering order to avoid such races by making register_netdev
> > the last step of the probing sequence.
> > 
> > [1]: https://lore.kernel.org/netdev/ZH9XK5yEGyoDMIs%2F@shell.armlinux.org.uk/
> > 
> > Fixes: fef2998203e1 ("net: altera: tse: convert to phylink")
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> > This patch targets net-next as it fixes a commit that is in net-next
> > too.  
> 
> While it fixes the order in which stuff is registered, it introduces
> a new bug - register_netdev() is what atomically allocated a netdev
> name, and you use the netdev name when creating the PCS MII bus:
> 
> 	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii", ndev->name);
> 
> This needs to change, because this will end up being "eth%d-pcs-mii".
> 
> I am at a loss why you didn't realise this (or in fact recognise that
> there are other issues) given that I sent you three patches fixing
> this mess.
> 

Hmpf your patches went un-noticed, sorry... I'll base later work on that.

I will also followup with a similar series for dwmac-socfpga

Best regards,

Maxime
