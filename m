Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0626DA44F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbjDFVB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbjDFVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:01:33 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63079B766;
        Thu,  6 Apr 2023 14:01:18 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E20EB92009C; Thu,  6 Apr 2023 23:01:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id DB91C92009B;
        Thu,  6 Apr 2023 22:01:16 +0100 (BST)
Date:   Thu, 6 Apr 2023 22:01:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sam Ravnborg <sam@ravnborg.org>
cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
In-Reply-To: <20230406203207.GA1534216@ravnborg.org>
Message-ID: <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk>
References: <20230406160548.25721-1-rdunlap@infradead.org> <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk> <20230406203207.GA1534216@ravnborg.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

> >  This looks completely wrong to me, any ordinary PCI parallel port card 
> > ought just to work as long as you have PCI (S390 is special I'm told).  
> > What needs to be done is AFAICT just making `parport_pc_find_nonpci_ports' 
> > in arch/sparc/include/asm/parport.h SPARC64-specific, i.e.:
> > 
> > static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
> > {
> > 	return (IS_ENABLED(CONFIG_SPARC64) &&
> > 		platform_driver_register(&ecpp_driver));
> > }
> > 
> > or suchlike and let the optimiser get rid of all the unwanted unsupported 
> > stuff.
> 
> arch/sparc/include/asm/parport.h is sparc64 specific - and it will
> result in the wrong result if it is pulled in for sparc32 builds.
> This is what we see today.
> 
> Randy's suggestion is fine, as we avoid building parport support
> for sparc32. If someone shows up and need parport support
> for sparc32 then we could look into how to enable it.
> Until then, we are better helped avoiding building the driver.

 I disagree.  Why artificially prevent perfectly good hardware from 
working with a perfectly good driver especially as the fix is just a 
trivial exercise?  And I offered a solution.

 I don't have a SPARC toolchain handy or I could even try and build it 
(but I'm sure there are many people around who can do it without bending 
backwards).

 NB conversely we have plenty of useless irrelevant stuff presented in 
configration even if it genuinely makes no sense and won't ever be used 
for the given platform (e.g. some Intel CPU management stuff shown for 
RISC-V or even DEC Alpha systems).

  Maciej
