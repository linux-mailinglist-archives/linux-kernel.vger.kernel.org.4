Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE160CF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiJYOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiJYOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:42:10 -0400
Received: from smtp.cesky-hosting.cz (smtp.cesky-hosting.cz [IPv6:2a00:1ed0:2:0:1:5bef:c8ee:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF36172519;
        Tue, 25 Oct 2022 07:42:07 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at smtp.cesky-hosting.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elrest.cz;
        s=rampa2-202208; t=1666708924;
        bh=PYEMZsYHKT+dgDkbswL32nBIM4jvIDqtH1ZQB5oxgLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2nWdHhQD7eu7Wb8ByqsPWL4jwyQU/WyFlfdQ8Ru+fVoo6Nm9RHUbJFEQTx3skIfB
         hcHg5j1CrP45NcSoHHlehuh7usLdkvg1gfD4dNIUSIdG+op+mJ9vQO73LO1PUhnfOM
         MUCEyoV8mrsQ6faEwpas8Fcw95j+S0Q4bi/sAvijOB0pqfh5+55TndPV3Z22sJW3Jt
         CTN+S4Egexqf/XrXeSFv2O60zBQgvMTg6UtcawgSvmoFWdjghdfBv4nA00XpLxXbeH
         Iad38s4QwS31qYcb+FTpMmaePxsBYGUTbQvlqdxwIOllnr3f/3rhzWxeKiwVPzKMK8
         vIBlmBqsvQXqQ==
Received: from edaa77c5b7e3 (unknown [5.181.92.50])
        (Authenticated sender: tomas.marek@elrest.cz)
        by smtp.cesky-hosting.cz (Postfix) with ESMTPSA id 179143C0;
        Tue, 25 Oct 2022 16:41:58 +0200 (CEST)
Date:   Tue, 25 Oct 2022 16:41:38 +0200
From:   Tomas Marek <tomas.marek@elrest.cz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     mpm@selenic.com, mcoquelin.stm32@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, oleg.karfich@wago.com
Subject: Re: [PATCH 1/2] hwrng: stm32 - fix number of returned bytes on read
Message-ID: <20221025144138.GA8@edaa77c5b7e3>
References: <20221012160924.12226-1-tomas.marek@elrest.cz>
 <20221012160924.12226-2-tomas.marek@elrest.cz>
 <Y1J3QwynPFIlfrIv@loth.rohan.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1J3QwynPFIlfrIv@loth.rohan.me.apana.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 06:41:07PM +0800, Herbert Xu wrote:
> On Wed, Oct 12, 2022 at 06:09:23PM +0200, Tomas Marek wrote:
> >
> > diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
> > index bc22178f83e8..8eaacefd498b 100644
> > --- a/drivers/char/hw_random/stm32-rng.c
> > +++ b/drivers/char/hw_random/stm32-rng.c
> > @@ -49,11 +49,13 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> >  		/* Manage timeout which is based on timer and take */
> >  		/* care of initial delay time when enabling rng	*/
> >  		if (!sr && wait) {
> > -			retval = readl_relaxed_poll_timeout_atomic(priv->base
> > +			int ret;
> > +
> > +			ret = readl_relaxed_poll_timeout_atomic(priv->base
> 
> This would make a lot more sense if you called it err instead of ret.
> 
> But as you're fixing a real bug I'm going to apply your patch as is
> and you can post an incremental patch to improve it.

OK, sounds reasonable. I'll post new patch and rename ret to err.

Thanks for the hint and for the review.

Tomas

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
