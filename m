Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86F16EFA11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjDZS31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDZS3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:29:25 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA74495;
        Wed, 26 Apr 2023 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kFhUT9deVkPno3Q0meiZoeVjv8fm14gpU8+QGcR0u6U=; b=sI7ZBvMPEapatwzcxQora07MzP
        n+zAT4y8oJMUT9gn56vrTOpOidYi+RTEtb3RQNJfhQkoe8lhLSjvE4Vaphsz/C5wnXcHxSGfFHVkJ
        6QE+CNg/2FR27Cx+ZJdVIgVCBKQcGGLKG9DOjet7p3S9KpPevzMJPPVEX+Gr9e+QDmzQ3is8zxToe
        R3FrdrA3zxL0X424lRT+RRY2NehdBE+lbluJDjjkyHWt32sNt4+TQdb7m1YcL+F1G2gZiJv1mwG5J
        cFvrXGJZMHhaYARcEXUAteW83ekIc0UPQvsXdhfxON8isvtLVDUI0Pw9xbOzWQm3aAK5fPDzgtsic
        Ol38XKuQ==;
Received: from p200300ccff09c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff09:c200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1prjt8-0007og-2C; Wed, 26 Apr 2023 20:29:10 +0200
Date:   Wed, 26 Apr 2023 20:29:08 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     andy.shevchenko@gmail.com
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230426202908.17b55974@aktux>
In-Reply-To: <ZEkCg-WqwBHVZwHC@surfacebook>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
        <20230425201117.457f224c@aktux>
        <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
        <20230425212040.5a4d5b09@aktux>
        <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
        <20230425215848.247a936a@aktux>
        <20230426071910.GE14287@atomide.com>
        <20230426093920.3e9b5c61@aktux>
        <ZEkCg-WqwBHVZwHC@surfacebook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 13:52:51 +0300
andy.shevchenko@gmail.com wrote:

> Wed, Apr 26, 2023 at 09:39:20AM +0200, Andreas Kemnade kirjoitti:
> > On Wed, 26 Apr 2023 10:19:10 +0300
> > Tony Lindgren <tony@atomide.com> wrote:  
> > > * Andreas Kemnade <andreas@kemnade.info> [230425 19:58]:  
> > > > On Tue, 25 Apr 2023 22:36:37 +0300
> > > > Aaro Koskinen <aaro.koskinen@iki.fi> wrote:  
> > > > > On Tue, Apr 25, 2023 at 09:20:40PM +0200, Andreas Kemnade wrote:    
> > > > > > Aaro Koskinen <aaro.koskinen@iki.fi> wrote:      
> 
> ...
[...]
> > I think the reason for the patch (besides of cleaning up warnings) is that
> > dynamic allocation seems to start at 512, static at zero.
> > If both are there, like registering twl_gpio between omap gpiochip 4 and 5,
> > dynamic allocation seems just to start after the last static number,
> > calling for trouble.
> > 
> > If dynamic alloc would just start at 512 in that case too, no problem would appear.
> > As said I have not bisected it to an exact commit yet.
> > So if we need to move backward, we should IMHO first fix that allocation thing.  
> 
> I agree.
> 
> As PoC can the reported add the following lines
> 
> 	if (gdev->base < GPIO_DYNAMIC_BASE)
> 		continue;
>  
> after https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L190
> and test your idea?
> 
> 
yes,
looking at git blame
7b61212f2a07a ("gpiolib: Get rid of ARCH_NR_GPIOS")

would probably have been the correct Fixes-tag for for that patch (and
will be for the new approach to fix it) and its intention was exactly
what we are talking about.

I will test.

Regards,
Andreas
