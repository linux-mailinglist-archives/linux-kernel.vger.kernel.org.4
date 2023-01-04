Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A8265DBBE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjADR5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjADR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:57:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874B5B82;
        Wed,  4 Jan 2023 09:57:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42EB9B81896;
        Wed,  4 Jan 2023 17:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EBDC433EF;
        Wed,  4 Jan 2023 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672855065;
        bh=PmrjWVoeterApa/MEtiQPuMHAL+ugShTswEHPjvZuqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVyUZ2D+wYWkxOP4sEsm3PEauHqejuaMi0n2uQhHSRopArwZ82prlwsM2fNVfA77y
         kvVZIPMyRDipl2Tw4F+ro8GrU8OuHMWP1mZlI/Fp1t9s2NcEWRAIdqY046U+beQaO2
         UEjLkFCB7XPJddUfkZ+db0+Z7eBsugyuO/yjaMDVjZ7CsNdWwgRYGC6KLJClj9wSUm
         KkWTPcif5juVaT7qcxaGbYf5QuVqfapOFV7KLYKBIIpPcVHk9cLWLz90fZ597szV5I
         wGZm6V+hMhdgEzpo0iM/m0KxL4ONbfR0AX/abQw2dKlX/nlAO/hg+8FNBYJpc4YL9v
         T+aKQZOERQjSg==
Date:   Wed, 4 Jan 2023 17:57:39 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v3 2/2] mfd: syscon: allow reset control for syscon
 devices
Message-ID: <Y7W+E2/bywt16BqJ@google.com>
References: <20221211025700.1180843-1-jk@codeconstruct.com.au>
 <20221211025700.1180843-3-jk@codeconstruct.com.au>
 <Y7WvXTPxyIGw5y9R@google.com>
 <33f6f9e66c8143515d36d17bf33d95362830f83f.camel@codeconstruct.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33f6f9e66c8143515d36d17bf33d95362830f83f.camel@codeconstruct.com.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023, Jeremy Kerr wrote:

> Hi Lee,
> 
> > > @@ -124,7 +127,17 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> > >                 } else {
> > >                         ret = regmap_mmio_attach_clk(regmap, clk);
> > >                         if (ret)
> > > -                               goto err_attach;
> > > +                               goto err_attach_clk;
> > > +               }
> > > +
> > > +               reset = of_reset_control_get_optional_exclusive(np, NULL);
> > > +               if (IS_ERR(reset)) {
> > > +                       ret = PTR_ERR(reset);
> > > +                       goto err_attach_clk;
> > > +               } else {
> > > +                       ret = reset_control_deassert(reset);
> > > +                       if (ret)
> > > +                               goto err_reset;
> > >                 }
> > 
> > The else is superfluous, right?
> 
> Yep, we could move that reset_control_deassert() out of the else block.
> If there are no other changes, I'll send a v4 with that.

I'd wait a little while to give Arnd a chance to respond.

Might save you a little work.

-- 
Lee Jones [李琼斯]
