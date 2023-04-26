Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126796EEF68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjDZHje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbjDZHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:39:28 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139DC30F1;
        Wed, 26 Apr 2023 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PCRmkCmow1uEMGeL57btO0h4Rmd+vf5ns0y/BbWjTBI=; b=lWZxauUDvd1nVRFVftz0jJ83W6
        i0/Z7hxxZz8JwAArPRYDJDODs0fIcak71XzX73MTR77A2Yhi5jPmOqRZjcLhlERP21VVO0UTjXzgD
        8vRSrWFgR6OrMUduIHWO9QtCGoqavmdu902smnaM/PiyEwvswcIAGMDiQ26QSmCik68hzJR6G6aua
        eQUagi/0vGvWT0P7IWAYVaZhKA84OfL6kZjZCSBI6QR/KbPydUJtgOFY9SOYjCLqca+PlnF61e/7w
        YIX2WuC2pTbVIS3ci2rRU93xCaNNlFij8Y0gjxcsJ31HsJQyR0H0zi4i1r2z0Xrx3B88TYwgQe5L2
        Su9siKFg==;
Received: from p200300ccff09c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff09:c200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1prZkI-0006pi-7L; Wed, 26 Apr 2023 09:39:22 +0200
Date:   Wed, 26 Apr 2023 09:39:20 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230426093920.3e9b5c61@aktux>
In-Reply-To: <20230426071910.GE14287@atomide.com>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
        <20230425201117.457f224c@aktux>
        <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
        <20230425212040.5a4d5b09@aktux>
        <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
        <20230425215848.247a936a@aktux>
        <20230426071910.GE14287@atomide.com>
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

Hi,

On Wed, 26 Apr 2023 10:19:10 +0300
Tony Lindgren <tony@atomide.com> wrote:

> Hi,
> 
> * Andreas Kemnade <andreas@kemnade.info> [230425 19:58]:
> > On Tue, 25 Apr 2023 22:36:37 +0300
> > Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> >   
> > > On Tue, Apr 25, 2023 at 09:20:40PM +0200, Andreas Kemnade wrote:  
> > > > Aaro Koskinen <aaro.koskinen@iki.fi> wrote:    
> > > > > Which commit introduced that regression? Also, the changelog mentions
> > > > > it happens only with "unusual" probe order. Now, all the ordinary cases
> > > > > for OMAP1 are broken.
> > > > >     
> > > > did not bisect that to an exact commit.
> > > > Unusual probe order: on the device where I tested it,
> > > > I did not see a completely successful probe.    
> > > 
> > > If you cannot point out a working past commit, there was no regression. If
> > > you fix something that hasn't worked before or has been long time broken,
> > > it must not cause breakage to other current users.
> > >   
> > Well, I did not take the time for a bisect. As we need a less aggressive
> > fix, it seems to be worth doing it. 
> >   
> > > > > And it's not just that tps65010 thing. E.g. 770 fails to boot as well
> > > > > and it doesn't use it; and reverting 92bf78b33b0b fixes that one as
> > > > > well. AFAIK it's because all the gpio_request()s in OMAP1 board files
> > > > > stopped now working.
> > > > >     
> > > > so we break every non-devicetree user of omap-gpio?     
> > > 
> > > It seems so.
> > >   
> > or maybe an if (not_using_devicetree())  
> 
> Not sure what the best way to fix this might be, adding Linus W to Cc too.
> Maybe using gpio line names in the legacy platform data instead of numbers?
> 
> Seems that we should just revert this patch for now and try again after
> the issues have been fixed.
>
I think the reason for the patch (besides of cleaning up warnings) is that
dynamic allocation seems to start at 512, static at zero.
If both are there, like registering twl_gpio between omap gpiochip 4 and 5,
dynamic allocation seems just to start after the last static number,
calling for trouble.

If dynamic alloc would just start at 512 in that case too, no problem would appear.
As said I have not bisected it to an exact commit yet.
So if we need to move backward, we should IMHO first fix that allocation thing.

Regards,
Andreas
