Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC62373BBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjFWPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjFWPi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:38:56 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D22126;
        Fri, 23 Jun 2023 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Eaai/2aq87jv39+4nAJAoxKbCvsMFKJK4WRa82NziSY=; b=xTJ+PaaHmLU0TXGAu3Lh10OkQS
        PQbBNyqDwbxlG3M5FODc72rEZf1AEvVGVkDdwXzKAlGtemmmisAobREPgMuAobacj5+3ihfqAXDEO
        IpwIhdRXhH4VZ8sCAexv/l037yG7Ku7ioNZj2cMPHq9iDBd7yPpT++8QpNc51o4Fq1Lg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCirq-00HN9f-Td; Fri, 23 Jun 2023 17:38:34 +0200
Date:   Fri, 23 Jun 2023 17:38:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        claudiu.beznea@microchip.com
Subject: Re: net: macb: sparse warning fixes
Message-ID: <fe335672-6b8d-4fb0-81ce-34f029891d39@lunn.ch>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
 <66f00ffc-571b-86b3-5c35-b9ce566cc149@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f00ffc-571b-86b3-5c35-b9ce566cc149@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 03:16:23PM +0200, Nicolas Ferre wrote:
> Hi Ben,
> 
> On 22/06/2023 at 15:05, Ben Dooks wrote:
> > These are 3 hopefully easy patches for fixing sparse errors due to
> > endian-ness warnings. There are still some left, but there are not
> > as easy as they mix host and network fields together.
> > 
> > For example, gem_prog_cmp_regs() has two u32 variables that it does
> > bitfield manipulation on for the tcp ports and these are __be16 into
> > u32, so not sure how these are meant to be changed. I've also no hardware
> > to test on, so even if these did get changed then I can't check if it is
> > working pre/post change.
> 
> Do you know if there could be any impact on performance (even if limited)?

Hi Nicolas

This is inside a netdev_dbg(). So 99% of the time it is compiled
out. The other 1% of the time, your 115200 baud serial port is
probably the bottleneck, not an endianness swap.

	 Andrew
