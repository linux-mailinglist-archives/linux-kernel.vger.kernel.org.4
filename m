Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE516EE79C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjDYSjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjDYSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:39:05 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DD116188;
        Tue, 25 Apr 2023 11:39:04 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-14-243-nat.elisa-mobile.fi [85.76.14.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Q5W444p60zyTl;
        Tue, 25 Apr 2023 21:38:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1682447941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5p9uScfzPk19gpQyn98pBN+cq88pJ1CZ5tq+PDyx8xI=;
        b=R8XdVGegLNF17OUTXmYHWlHiOTwEb6K2P66fJzV1wjS8DSaCqCmg5TnomTit0RU1jJBNJk
        qG6r58Yp/9GqDqsZTKFxjJC9SIBNYl4phyjVukiXF7GpF5/FJiofudltuAQh+MYRXsFJEj
        TnxhyxL73Wp+4kMd0sm1RGDNxop0Hj0=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1682447941; a=rsa-sha256; cv=none;
        b=rh28xABjjHYjzxM5SVzGr3mvqznSGJHPm3dV1F8BObX43J2atey5NQ2Jnt4Pqq+acTZWMT
        XbmqIC7Z4CuT3teUmVJgP3Nwi5q0exJOcXqGAvVKz96hRPCYEEn1mNYwu3xe7myJsxdTKY
        vQOtKVwNoz7dHTWACMdsWw+52be4ZVA=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1682447941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5p9uScfzPk19gpQyn98pBN+cq88pJ1CZ5tq+PDyx8xI=;
        b=RM1pu4Ixe11UObTKhIJjPggzWgOSCEQrerpw21QSrVtw7F70Jd1Ov7vQb7QuESJCF/4oK7
        QmETYlxmOyglFd9VOLhphZNA4GGyfegLvK7uG+5eMboHdtCMwbSJFfvuKm3EjmNO3iOY/o
        ishz2JsYpc4cEtSPKUto7OUnwJcFHCE=
Date:   Tue, 25 Apr 2023 21:38:57 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
 <20230425201117.457f224c@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425201117.457f224c@aktux>
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

On Tue, Apr 25, 2023 at 08:11:17PM +0200, Andreas Kemnade wrote:
> On Tue, 25 Apr 2023 20:32:41 +0300
> Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > It seems GPIOs on OMAP1 boards are somewhat broken after:
> > 
> > commit 92bf78b33b0b463b00c6b0203b49aea845daecc8
> > Author: Andreas Kemnade <andreas@kemnade.info>
> > Date:   Fri Jan 13 21:59:22 2023 +0100
> > 
> >     gpio: omap: use dynamic allocation of base
> > 
> > E.g. on OSK1 the ethernet IRQ cannot (omap_gpio.0) no longer be requested:
> > 
> > [    0.277252] Error requesting gpio 0 for smc91x irq
> > 
> > Also the tps65010 (still using static allocation) will now conflict:
> > 
> > [    0.400726] gpio gpiochip5: Static allocation of GPIO base is deprecated, use dynamic allocation.
> > [    0.400848] gpio gpiochip5: (tps65010): GPIO integer space overlap, cannot add chip
> > [    0.400970] gpiochip_add_data_with_key: GPIOs 208..214 (tps65010) failed to register, -16
> > [    0.401092] tps65010 i2c-tps65010: can't add gpiochip, err -16
> > 
> > I think this change should be reverted until the board files and other
> > gpiochips are fixed accordingly.
> > 
> well, then just fix that tps65010 thing. 
> 
> that change is itself a regression fix for exactly the same kind of error.

Which commit introduced that regression? Also, the changelog mentions
it happens only with "unusual" probe order. Now, all the ordinary cases
for OMAP1 are broken.

And it's not just that tps65010 thing. E.g. 770 fails to boot as well
and it doesn't use it; and reverting 92bf78b33b0b fixes that one as
well. AFAIK it's because all the gpio_request()s in OMAP1 board files
stopped now working.

A.
