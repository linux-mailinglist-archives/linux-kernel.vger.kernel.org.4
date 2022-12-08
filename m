Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B16465FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLHAhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLHAhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:37:15 -0500
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24948DBDE;
        Wed,  7 Dec 2022 16:37:14 -0800 (PST)
Received: from 1p34uW-0001n8-VE by out3c.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1p34uX-0001op-Vc; Wed, 07 Dec 2022 16:37:13 -0800
Received: by emcmailer; Wed, 07 Dec 2022 16:37:13 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3c.electric.net with esmtps  (TLS1.2) tls TLS_DHE_RSA_WITH_SEED_CBC_SHA
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1p34uW-0001n8-VE; Wed, 07 Dec 2022 16:37:12 -0800
Received: from tsdebian (unknown [75.164.86.214])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 17057634E;
        Wed,  7 Dec 2022 17:37:33 -0700 (MST)
Message-ID: <1670459801.7091.1.camel@embeddedTS.com>
Subject: Re: [PATCH] spi: spi-gpio: Don't set MOSI as an input if not 3WIRE
 mode
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark@embeddedts.com
Date:   Wed, 07 Dec 2022 16:36:41 -0800
In-Reply-To: <Y5ElXqDduIZhIiAm@sirena.org.uk>
References: <20221207230853.6174-1-kris@embeddedTS.com>
         <Y5ElXqDduIZhIiAm@sirena.org.uk>
Organization: embeddedTS
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:DHE-RSA-SEED-SHA:128
X-Authenticated_ID: 
X-VIPRE-Scanners: virus_bd;virus_clamav;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=4NKUhY6MkD/bFUkICTfZjmTJpg+nsJAFL1xKv/Q1xYk=;b=ENVbpQtI+2wfNMmYwec/oCpLDwlumTfsMnjQ1wzI0TG1D6PjobQB6P1mOj6C2FkfPtT23VxEYxzmS52H4v91FkLKh8voSiR8WFYvG2+e8SLXWEwlMosR3IqFrjmHXa2ahz8PJaS4cQv2GbIR18GI6ADc5ZPx0vfBjqi9Ea23QH7Hm0+gWBteAq5E4WyW/I7v84qW4MSWjDu6KOZulrMThzupEhXjmmAiNTbAPe4lIGa/qA0Je2/8CjPmDro1vbvobris+BtY885xMlB+FAM15u1l8IXDJdWXj0lObuIqVnuibVeYXGxrVWAJB1AJKKGBwQFFRAzS9BlwkH2P+3/NbA==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-12-07 at 23:44 +0000, Mark Brown wrote:
> On Wed, Dec 07, 2022 at 03:08:53PM -0800, Kris Bahnsen wrote:
> > The addition of 3WIRE support would affect MOSI direction even
> > when still in standard (4 wire) mode. This can lead to MOSI being
> > at an invalid logic level when a device driver sets an SPI
> > message with a NULL tx_buf.
> > 
> > spi.h states that if tx_buf is NULL then "zeros will be shifted
> > out ... " If MOSI is tristated then the data shifted out is subject
> > to pull resistors, keepers, or in the absence of those, noise.
> > 
> > This issue came to light when using spi-gpio connected to an
> > ADS7843 touchscreen controller. MOSI pulled high when clocking
> > MISO data in caused the SPI device to interpret this as a command
> > which would put the device in an unexpected and non-functional
> > state.
> 
> A cleaner fix which is probably marginally more performant would be to
> make the setting of spi_gpio_set_direction() conditional on SPI_3WIRE -
> then we won't call into the function at all when not doing 3 wire,
> avoiding the issue entirely.

That makes sense to me. I was operating under the assumption that 3WIRE
mode could be switched in to at a later time via ioctl(), but with the
death of spidev that is presumably no longer a concern.

I'll get a v2 put together and probably sent in tomorrow. Thanks.

> 
> > As an aside, I wasn't sure how to best put down the Fixes: tags.
> > 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support") introduced the
> > actual bug, but 5132b3d28371 ("spi: gpio: Support 3WIRE high-impedance turn-around")
> > modified that commit slightly and is what this patch actually applies
> > to. Let me know if marking both as fixes is incorrect and I can
> > create another patch.
> 
> That's fine, it doesn't really matter either way.
