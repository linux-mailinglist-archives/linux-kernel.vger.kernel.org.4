Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2CE5FF27D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJNQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJNQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E7B160876;
        Fri, 14 Oct 2022 09:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4386561A44;
        Fri, 14 Oct 2022 16:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35147C433D6;
        Fri, 14 Oct 2022 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665766065;
        bh=cLR8ePClxu7r6FSNCP7kyiWhxmge9wqnLbJPcYpGyas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8Pjm5YFs+Br8fZuKp1A3kcBqmsQG347nFptRBnsv4a20ZXRRGskvi3ls4exoSIzX
         g9RTNrvhZj/uXQ7UduPuPlWwGcHRNMv0USY3joUb+lMc0XUWhj0WZ9kGyCxV9pgJ0i
         h1ThOR0+gzgv2eDvG1pHIvOMRrsRAXMX/XDqAdpKYsYVj+hfhPUUalgDoj5XbSlHPc
         TQR07weUUh8VXegaPF4y7pJbOpegElXqJr6fe4ZiXRirf+ZtivfEz0jTgzwucnrx3/
         /EZQIeKhtYIkwaBxudaTnas/kTxYgvARwP2xL5ZJJt9uF/q+87Lvj1n9QjvEF5L60i
         087+7symjfSFw==
Date:   Fri, 14 Oct 2022 09:47:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Flax <flatmax@flatmax.com>
Subject: Re: [PATCH] of: Define of_match_ptr() with PTR_IF() to avoid unused
 variable warnings
Message-ID: <Y0mSrxar/QwNAESd@dev-arch.thelio-3990X>
References: <20221013195153.2767632-1-nathan@kernel.org>
 <767d768e-70e5-4a94-accb-3384a3bfd582@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767d768e-70e5-4a94-accb-3384a3bfd582@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 10:10:39AM +0200, Arnd Bergmann wrote:
> On Thu, Oct 13, 2022, at 9:51 PM, Nathan Chancellor wrote:
> > 
> > -#define of_match_ptr(_ptr)	NULL
> >  #define of_match_node(_matches, _node)	NULL
> >  #endif /* CONFIG_OF */
> > 
> > +#define of_match_ptr(_ptr)	PTR_IF(IS_ENABLED(CONFIG_OF), (_ptr))
> > +
> 
> I think this is counterproductive, as it means we cannot use
> of_match_ptr() for its intended purpose any more, it will
> now cause a build failure for any driver that references a
> match table inside of an #ifdef.

Ack, I obviously had not considered this before sending the change,
shows how much compile testing it got ;)

> Ideally we should be able to find the misuse of this macro with
> coccinelle and have it automatically generate patches that just remove
> it from drivers.
> 
> A first-level approximation would be this oneliner:
> 
> git grep -wl of_match_ptr | xargs git grep -wL CONFIG_OF | xargs sed -i "s:of_match_ptr(\([\ \#\>\"a-zA-Z0-9_-]*\)):\1:"
> 
> which takes care of 535 files that don't reference CONFIG_OF at all.
> There are 496 more files that use of_match_ptr() as well but also
> guard something inside of CONFIG_OF. Most of these are just
> incorrectly copy-pasted from older drivers and should not have an
> #ifdef in them to make the of_match_ptr() work, but they are not actually
> usable without CONFIG_OF.
> 
> Historically, we added the #ifdef at the time when we supported hundreds
> of boards without DT and only a couple of boards with DT, so having the
> extra #ifdef was a way of ensuring that the DT conversion would not add
> a few extra bytes of .data to each driver. Now we support thousands of
> boards with DT and only a few dozen without DT, so this is all pointless.

Ack to all of this but it sounds like this will be a bit of a larger
project than I am interested in picking up right now so consider this
patch retracted with an open invitation for someone else to continue
this clean up.

Cheers,
Nathan
