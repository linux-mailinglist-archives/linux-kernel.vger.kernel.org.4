Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16776F12D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345655AbjD1Hur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345985AbjD1Htv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:49:51 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC544A2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:48:37 -0700 (PDT)
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 80FA31BF20E;
        Fri, 28 Apr 2023 07:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682668067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiAtgghwMLCLp7mSE08hfQRojWgcQ8TdcNOl5eIy3As=;
        b=l9NvacfyJNU9T6JFaT/nSElfFHuwxhZbmeFgh5ZWjXXvOpkhUUcRQDWMcjJWnyI99eoVLb
        pdec/7zvrAnNjIgSTB1/0Vey0Z9v1Ji3wzmHd4FEpO9cIF/MQ8S//M0cTvfxA9rfwZ8MsM
        +8JGpTefmntqsm85/xO3krJHO3ey2+bYfl22NNQhdL1mzehqruPgzq8rjxRc1DOIxjsPZ9
        SP0m3vLGvw1AQ/U+tzqX/Nze1cXvbVDK3qrB49I0tvve+OGpHlZG+b893Ld1k0LzaG5GpJ
        AGM6fl98ba543RV32xMnAJ4wlMdJfiYsEySYtH2++NGwW2PDDwgVZpX1V8h+HQ==
Date:   Fri, 28 Apr 2023 09:47:45 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Colin Foster <colin.foster@in-advantage.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com
Subject: Re: [PATCH] regmap: don't check for alignment when using reg_shift
Message-ID: <20230428094745.63677228@pc-7.home>
In-Reply-To: <20230428093010.07e61080@pc-7.home>
References: <20230420150617.381922-1-maxime.chevallier@bootlin.com>
        <ZEKwxhJJNkuX7VTr@colin-ia-desktop>
        <bb836be3-456c-48fd-9b19-62279fee6b8d@sirena.org.uk>
        <20230428093010.07e61080@pc-7.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 09:30:10 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hello Mark, Colin,
> 
> On Tue, 25 Apr 2023 13:56:23 +0100
> Mark Brown <broonie@kernel.org> wrote:
> 
> > On Fri, Apr 21, 2023 at 08:50:30AM -0700, Colin Foster wrote:  
> > > On Thu, Apr 20, 2023 at 05:06:17PM +0200, Maxime Chevallier
> > > wrote:    
> >   
> > > > On regmap consumers that require address translation through
> > > > up/downshifting, the alignment check in the regmap core doesn't
> > > > take the translation into account. This doesn't matter when
> > > > downshifting the register address, as any address that fits a
> > > > given alignment requirement will still meet it when downshifted
> > > > (a 4-byte aligned address will always also be 2-bytes aligned
> > > > for example).    
> >   
> > > > However, when upshifting, this check causes spurious errors, as
> > > > it occurs before the upshifting.    
> >   
> > > I don't follow why upshifting should make a difference to
> > > alignment. Assuming it does though, would it make sense to test
> > >  
> >   
> > > map->format.reg_shift > 0    
> >   
> > > instead of just !map->format.reg_shift?    
> > 
> > Yeah, I think the question is more when we should run the alignment
> > check than if we should have one.  I think running the check after
> > any shifting makes sense, we'd be better off reorganising the
> > checks if needed than removing them.  
> 
> In the initial RFC I suggested this [1] approach, which checked for
> alignment after shifting, that way we are sure that the alignment
> check is done according to the underlying regmap provider's
> constraints. Maybe this could be sufficient ?

Oops I'm missing the actual link, sorry about that :(

[1] :
https://lore.kernel.org/all/20230324093644.464704-3-maxime.chevallier@bootlin.com/

> Thanks,
> 
> Maxime
> 
> > >     
> > > > -	if (!IS_ALIGNED(reg, map->reg_stride))
> > > > +	if (!map->format.reg_shift && !IS_ALIGNED(reg,
> > > > map->reg_stride)) return -EINVAL;    
> > > 
> > > In the case of ocelot_spi, we'd want to flag an invalid access to
> > > a register like 0x71070003... Before this patch it would return
> > > -EINVAL, after this patch it would access 0x71070000.
> > > 
> > > Colin Foster    
> 

