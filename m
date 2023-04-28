Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336F06F125F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345523AbjD1HaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345510AbjD1HaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:30:17 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB86C268E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:30:14 -0700 (PDT)
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1B89B40007;
        Fri, 28 Apr 2023 07:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682667013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iWBTxT4oyu6/mZM/P/Ah3o6QGBXo1mkLcX+rJvFiAcA=;
        b=IzLGQ+hx3RDpUx5pk5wdyfx3i1Zr4VlVadxAm0pnO83yakXm19TVdjd7Bj2KPBhYH6Y2VJ
        ftjNcXPoZq+hrE5td7RrDjGXB+OkHJmjcsTVlb41I5IFM4eiM4ZjMj42eKGAQdcsommaLp
        Zc2C3X1QZs545xQJe/M3U5QmkQ2i1OehEVD7hG1DZGbtA+qACAcSgObdygtEaO9hXTV2c8
        oJpVExjUo/1REDMA+D1jEnNQLPjKsfaKwB5swEE38mGvXKJmCcZMFySdCOQKrTXsMP2LIE
        mEnCRpby/PKf1y5LWtpklOtfd2CqtLEH9ZZTzPMRKLFwDsom52sKl0CoqBbsEQ==
Date:   Fri, 28 Apr 2023 09:30:10 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Colin Foster <colin.foster@in-advantage.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com
Subject: Re: [PATCH] regmap: don't check for alignment when using reg_shift
Message-ID: <20230428093010.07e61080@pc-7.home>
In-Reply-To: <bb836be3-456c-48fd-9b19-62279fee6b8d@sirena.org.uk>
References: <20230420150617.381922-1-maxime.chevallier@bootlin.com>
        <ZEKwxhJJNkuX7VTr@colin-ia-desktop>
        <bb836be3-456c-48fd-9b19-62279fee6b8d@sirena.org.uk>
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

Hello Mark, Colin,

On Tue, 25 Apr 2023 13:56:23 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Apr 21, 2023 at 08:50:30AM -0700, Colin Foster wrote:
> > On Thu, Apr 20, 2023 at 05:06:17PM +0200, Maxime Chevallier wrote:  
> 
> > > On regmap consumers that require address translation through
> > > up/downshifting, the alignment check in the regmap core doesn't
> > > take the translation into account. This doesn't matter when
> > > downshifting the register address, as any address that fits a
> > > given alignment requirement will still meet it when downshifted
> > > (a 4-byte aligned address will always also be 2-bytes aligned for
> > > example).  
> 
> > > However, when upshifting, this check causes spurious errors, as it
> > > occurs before the upshifting.  
> 
> > I don't follow why upshifting should make a difference to alignment.
> > Assuming it does though, would it make sense to test  
> 
> > map->format.reg_shift > 0  
> 
> > instead of just !map->format.reg_shift?  
> 
> Yeah, I think the question is more when we should run the alignment
> check than if we should have one.  I think running the check after any
> shifting makes sense, we'd be better off reorganising the checks if
> needed than removing them.

In the initial RFC I suggested this [1] approach, which checked for
alignment after shifting, that way we are sure that the alignment check
is done according to the underlying regmap provider's constraints. Maybe
this could be sufficient ?

Thanks,

Maxime

> >   
> > > -	if (!IS_ALIGNED(reg, map->reg_stride))
> > > +	if (!map->format.reg_shift && !IS_ALIGNED(reg,
> > > map->reg_stride)) return -EINVAL;  
> > 
> > In the case of ocelot_spi, we'd want to flag an invalid access to a
> > register like 0x71070003... Before this patch it would return
> > -EINVAL, after this patch it would access 0x71070000.
> > 
> > Colin Foster  

