Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C55C646632
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLHA6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLHA6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:58:21 -0500
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950238B1B1;
        Wed,  7 Dec 2022 16:58:20 -0800 (PST)
Received: from 1p35Ev-000CZe-TS by out3a.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1p35Ex-000CeU-Vi; Wed, 07 Dec 2022 16:58:19 -0800
Received: by emcmailer; Wed, 07 Dec 2022 16:58:19 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3a.electric.net with esmtps  (TLS1.2) tls TLS_DHE_RSA_WITH_SEED_CBC_SHA
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1p35Ev-000CZe-TS; Wed, 07 Dec 2022 16:58:17 -0800
Received: from tsdebian (unknown [75.164.86.214])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 6DF976350;
        Wed,  7 Dec 2022 17:58:37 -0700 (MST)
Message-ID: <1670461096.7839.1.camel@embeddedTS.com>
Subject: Re: [PATCH] spi: spi-gpio: Don't set MOSI as an input if not 3WIRE
 mode
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark@embeddedts.com
Date:   Wed, 07 Dec 2022 16:58:16 -0800
In-Reply-To: <Y5EzD8AaAj0EGnvH@sirena.org.uk>
References: <20221207230853.6174-1-kris@embeddedTS.com>
         <Y5ElXqDduIZhIiAm@sirena.org.uk> <1670459801.7091.1.camel@embeddedTS.com>
         <Y5EzD8AaAj0EGnvH@sirena.org.uk>
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
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=jBOzkw5MaNFhq/JFw7J9yLSH4ULiuio9lwiaduZfN8g=;b=bJumYaoIckcXrlzlEXYEvbhOYKaRMmHaUng3J12nzZ+ZCWpvlUFwzPw1wrnbhWIJnBTupm8DKqdsmipZJINkyU4/ChaSLBomzDaSm6NA4ldWan+HY5qGZX04IZ0AbUmcPL/gdOYq7k1CwPCFc/5viN6D0Zzl8u5QlQHf4H6SZ1skPHV6VFQoehEJpX9AD3D+tTtrRL+FZjvUzxbovigw0/5Qe7k1AWezHXzvdrxUmfr5UgwjsO0/MgwUTgc6gfK/GYsSAtvAj6pWVp1tUBrTj/HVpcJPCmrbth+hf6RK+y/vk0eutrUyUBaPVX/v6cAFPJAiZ87aKbVxrI8R0E0wJQ==;
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

On Thu, 2022-12-08 at 00:42 +0000, Mark Brown wrote:
> On Wed, Dec 07, 2022 at 04:36:41PM -0800, Kris Bahnsen wrote:
> > On Wed, 2022-12-07 at 23:44 +0000, Mark Brown wrote:
> > > A cleaner fix which is probably marginally more performant would be to
> > > make the setting of spi_gpio_set_direction() conditional on SPI_3WIRE -
> > > then we won't call into the function at all when not doing 3 wire,
> > > avoiding the issue entirely.
> > That makes sense to me. I was operating under the assumption that 3WIRE
> > mode could be switched in to at a later time via ioctl(), but with the
> > death of spidev that is presumably no longer a concern.
> 
> Ugh, right, spidev.  Really even with spidev devices should probably
> have the mode configured beforehand (I'm not sure pinmux will do the
> right thing on most platforms...) but now I check it's part of the ABI
> so we can't get rid of it and therefore your current patch probably is
> what we need.  No need to reroll, sorry for the noise :/

No need to apologize, thanks for the followup. I'm not terribly
familiar with SPI internals in Linux so I'm not sure how deep that
rabbit hole goes. Let me know if you change your mind, I will happily
whip something else up.

> 
> I'm not sure why you think spidev is dying, it does still exist and
> devices use it?

"The death of spidev" _as a generic interface_.

A number of our products provide a generic pin header with SPI
available for customer use. We've been told when we RFC'ed dts files
to support our platforms that spidev isn't acceptable on these
headers and the downstream developer must add their own as needed.
Which, many of our customers use devices that don't have drivers
anyway, so we still have to assist them in getting spidev functional
in one way or another. It's just a sore spot for us.
