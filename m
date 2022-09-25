Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001A65E91F6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIYKAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 06:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiIYKAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 06:00:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641CC25C54;
        Sun, 25 Sep 2022 03:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA64E60DFB;
        Sun, 25 Sep 2022 10:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0E5C433C1;
        Sun, 25 Sep 2022 10:00:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Fpm8nP0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664100032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQwKz8Q4mOrZejIu/u6IGYD9+wqNWFOpyS9jS1HdV5w=;
        b=Fpm8nP0fyUK9BqpO+w/wSq9lNPRP1OEBEn7zfIkIrIW+ItAzHxynSI7JLh3p2nrqodD5wP
        1nza4xqcPctVHmE6Ev4cfubkOQvQkWxlCWHAVOwAXfpKEVPUDhug1OgCuDvqGapHNz6LfO
        LJtA7X38ov4EWDQN+BltuIaXeIV/4gE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5f6a0196 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 25 Sep 2022 10:00:32 +0000 (UTC)
Date:   Sun, 25 Sep 2022 12:00:29 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v6 09/17] mips: use fallback for random_get_entropy()
 instead of just c0 random
Message-ID: <YzAmvfQcY2/gGwFQ@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-10-Jason@zx2c4.com>
 <alpine.DEB.2.21.2204250113440.9383@angie.orcam.me.uk>
 <YmicjVbkcppfzE1E@zx2c4.com>
 <CAHmME9r-wTkNGVj0sBOM5LVY=jdAw99gne-1g-mwjBnk3q7VqQ@mail.gmail.com>
 <alpine.DEB.2.21.2206241407240.22231@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2206241407240.22231@angie.orcam.me.uk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Maciej,

On Fri, Jun 24, 2022 at 02:25:17PM +0100, Maciej W. Rozycki wrote:
> Hi Jason,
> 
> > > There is lots of optimization potential on a few fronts we've identified
> > > in this thread. Let's save these for a follow-up. I'd rather this
> > > initial one be at least somewhat simple, so that as it gets optimized,
> > > it'll be easy to handle regressions. Also, it probably makes sense for
> > > you to send the patches for these, since you have both the hardware
> > > chops and the hardware itself to assess these ideas. I am interested in
> > > the topic though, so please do CC me.
> > 
> > Everything has been upstream for a little while now, which means
> > development of this can move back to the proper MIPS tree like normal.
> > Did you want to submit some optimizations? Would be happy to look at
> > whatever you have in mind.
> 
>  Thank you for the heads-up!
> 
>  Unfortunately I'm a little stuck at the moment, especially as one of my
> main MIPS machines (a 5Kc Malta system) died mid-May while operating.  It 
> seems to be a faulty CPU core card and the base board may be fine, though 
> I cannot know for sure as I only have one each and I don't have a logic 
> analyser or at least a JTAG probe to peek at the system and see what's 
> going on inside.
> 
>  If anyone knows a source of a replacement Malta, preferably with a 5Kc 
> CoreLV CPU module or another 64-bit hard core card (a number of different 
> ones have been made), then I'll appreciate if you let me know.  I feel 
> rather depressed knowing that many if not most hit the scrapper already 
> while they could still find a good use.  Somehow it is easier to get way 
> more obsolete hardware from 1980/90s just because it was general purpose 
> rather than niche.
> 
>  Otherwise I'll try to get back to this stuff later in the year with 
> whatever I have that still runs, but don't hold your breath.  Sorry!
> 
>   Maciej

Just thought I'd poke you about this, on the off chance that you found
some new hardware and feel like tinkering around with cycle counters
again. Some old MIPS platforms were recently dropped, too, which makes
me wonder whether there's some room for more simplification here.

Jason
