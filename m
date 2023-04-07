Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EF46DB4A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjDGUEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGUEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:04:21 -0400
X-Greylist: delayed 84665 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Apr 2023 13:04:19 PDT
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [46.30.211.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A6CB443
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=GEymfcvEr6OpW+7lKXhrHlUO1pzbFCdBUiRSiKDq8VQ=;
        b=H0N7zkuxx2RDmVnvXmobY05mWcW+DwZy4b4+y5SPtPtxfj8FG0kP4kMB/8Xvh6ZXqjei4UtRUoi1V
         Uuewr0RF1TtUgbh5D928JwGKjl3yJdfrmPIkUyIZ5iOFHfiABM10pSBysO3q0Prtemze8lSKTZw1ad
         Ip6IR/SMCt2qcx9TOS1WPKI/HTYaH9jf9ocF25HfRo55i7h2VjKMJUfMAAdz0DjxtClwQG+mz3UnHx
         5a87Qh21Axk3qLv4t6MD51Fbw9/arg2GHbDHrGzqKFoCtqLqJS4Y/DiFNZyCrM+v5aXmpzi73y0SZ3
         S1MK8mUV9nZu8iXk8e1+/ZP7HtEnBhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=GEymfcvEr6OpW+7lKXhrHlUO1pzbFCdBUiRSiKDq8VQ=;
        b=x1VIxsS5nyFNRbZpIjO3XfW4Keny72Xht9u/iprZ39y6B+yz2HBVtgywuql2eHtRFzQ0dndifV92s
         6jyOAEECg==
X-HalOne-ID: 3a49eb0a-d57f-11ed-9360-6f01c1d0a443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 3a49eb0a-d57f-11ed-9360-6f01c1d0a443;
        Fri, 07 Apr 2023 20:03:14 +0000 (UTC)
Date:   Fri, 7 Apr 2023 22:03:13 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
Message-ID: <20230407200313.GA1655046@ravnborg.org>
References: <20230406160548.25721-1-rdunlap@infradead.org>
 <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk>
 <20230406203207.GA1534216@ravnborg.org>
 <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk>
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Thu, Apr 06, 2023 at 10:01:16PM +0100, Maciej W. Rozycki wrote:
> Hi Sam,
> 
> > >  This looks completely wrong to me, any ordinary PCI parallel port card 
> > > ought just to work as long as you have PCI (S390 is special I'm told).  
> > > What needs to be done is AFAICT just making `parport_pc_find_nonpci_ports' 
> > > in arch/sparc/include/asm/parport.h SPARC64-specific, i.e.:
> > > 
> > > static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
> > > {
> > > 	return (IS_ENABLED(CONFIG_SPARC64) &&
> > > 		platform_driver_register(&ecpp_driver));
> > > }
> > > 
> > > or suchlike and let the optimiser get rid of all the unwanted unsupported 
> > > stuff.
> > 
> > arch/sparc/include/asm/parport.h is sparc64 specific - and it will
> > result in the wrong result if it is pulled in for sparc32 builds.
> > This is what we see today.
> > 
> > Randy's suggestion is fine, as we avoid building parport support
> > for sparc32. If someone shows up and need parport support
> > for sparc32 then we could look into how to enable it.
> > Until then, we are better helped avoiding building the driver.
> 
>  I disagree.  Why artificially prevent perfectly good hardware from 
> working with a perfectly good driver especially as the fix is just a 
> trivial exercise?  And I offered a solution.

There is no sparc32 with a PC style parallel port, so the parport_pc
have no value for a sparc32 machine.

Some sparc Ultra have PC style parallel ports - but this is sparc64
machines and they are covered.

The sparc32 machines have the parport_sunbpp driver for their parallel
port.

An alternative fix, and better I think, would be to audit all archs
and let the relevant ones select ARCH_MIGHT_HAVE_PC_PARPORT, so we
avoided the ugly "|| (PCI && !S390 && !SPARC32)" case for PARPORT_PC.

	Sam
