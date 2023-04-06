Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093D36DA40A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbjDFUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbjDFUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:49:18 -0400
X-Greylist: delayed 964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 13:48:15 PDT
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:403::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F1C83D0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=l8/6w9klaVvdwp2WTXDf2J1p95kDaCAQ65h0eknmbVc=;
        b=rCSQ1WK8yn0jNOJRpqDzuIIvZlrRTbguNr7fODRef03Cb8ib689XUFyCFhWA4VUI/LWMZIG4EehPz
         lBuJLCBe9F6Dv55trN1ow76zqsW0wknQfuhuiyJfzWqvE33d1N++8riH+FrRkY00oYP117gIeIqM4Z
         uWe7PFmEr53NBwNHvceBQAwmQsycJLlXYW5SLv4eSc5Np2Ie+95aEKZJeuHaLz5BI65DdPDLOr7lex
         qK0IUU4kdgEO7Jvq8P5jKQVr8ePqR54oMqBPj5o6JtRwyI4eghJOaR41eg5tWfAo7zPGYSka1Y2ioO
         DbxYY/I+vaaVeJnWIvwemsP3+FxO/Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=l8/6w9klaVvdwp2WTXDf2J1p95kDaCAQ65h0eknmbVc=;
        b=q9Lz+UdHCdnOHDwXE3ZhFiDI6u3IY3PaglloPegr138WLG2XG9Kn4PkExvzhkqabLyuJYHTziGoGh
         hlfiZsLAA==
X-HalOne-ID: 19321619-d4ba-11ed-9908-592bb1efe9dc
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4 (Halon) with ESMTPSA
        id 19321619-d4ba-11ed-9908-592bb1efe9dc;
        Thu, 06 Apr 2023 20:32:09 +0000 (UTC)
Date:   Thu, 6 Apr 2023 22:32:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
Message-ID: <20230406203207.GA1534216@ravnborg.org>
References: <20230406160548.25721-1-rdunlap@infradead.org>
 <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk>
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Thu, Apr 06, 2023 at 08:49:50PM +0100, Maciej W. Rozycki wrote:
> On Thu, 6 Apr 2023, Randy Dunlap wrote:
> 
> > arch/sparc/kernel/ebus.o is only built for SPARC64.
> > ns87303_lock is only built for SPARC64.
> > arch/sparc/include/asm/parport.h says that it is for sparc64.
> > Various documentation on the internet says that ebus is for UltraSPARC
> > systems (64-bit).
> > 
> > Therefore don't allow PARPORT_PC to be built for SPARC32.
> 
>  This looks completely wrong to me, any ordinary PCI parallel port card 
> ought just to work as long as you have PCI (S390 is special I'm told).  
> What needs to be done is AFAICT just making `parport_pc_find_nonpci_ports' 
> in arch/sparc/include/asm/parport.h SPARC64-specific, i.e.:
> 
> static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
> {
> 	return (IS_ENABLED(CONFIG_SPARC64) &&
> 		platform_driver_register(&ecpp_driver));
> }
> 
> or suchlike and let the optimiser get rid of all the unwanted unsupported 
> stuff.

arch/sparc/include/asm/parport.h is sparc64 specific - and it will
result in the wrong result if it is pulled in for sparc32 builds.
This is what we see today.

Randy's suggestion is fine, as we avoid building parport support
for sparc32. If someone shows up and need parport support
for sparc32 then we could look into how to enable it.
Until then, we are better helped avoiding building the driver.

Hence, my ack on the patch from Randy.

	Sam
