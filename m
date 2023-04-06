Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9626DA132
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjDFT2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbjDFT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:28:26 -0400
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B7540DC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=HLHJe/pcy2/bBEBBSRuFq11kLkFpNBIK96wm2MVUcKA=;
        b=WkDEm+nZYCTKHcmsuRr1Ev/Zq0QLxhWsG+BAADCKHaWzspohoOgHwMRQCiw9+Jq2hgrcRmSOnMAKE
         kGKVWhudMwa+YkkFa7kXA90IHqglxHV1sUTN3vCCeAYvtCK/bVrqbV9U1YW0o7MJ3S3ZGiC+QW7XuL
         g1C6h2Ex6X2tTY5HWwRmNmfNrkN+V6MXAyz3IyMsaQ4pW0D5qbUVqiQ61Lx0S9LdYgLZmRB3MjIR2Y
         UtGA6OC+2PHn0zmL94bhBT1qCOJxdgcnTHWOqIW7OLFF/LUnwAjGygJyLfgl42QHgT9srAqYqzqly0
         lIam8dx2vS1gUcfxO9wFZErkjJb67xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=HLHJe/pcy2/bBEBBSRuFq11kLkFpNBIK96wm2MVUcKA=;
        b=kS1/agKGuYJ4mM8yrbEEvQpfNVQP43X0AA1Gg35LVlpmERN8oXNItjlUPCovILva3X+TpJ9jqiWHt
         nXvVhLVAg==
X-HalOne-ID: 2eef4e88-d4b1-11ed-82ab-13111ccb208d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id 2eef4e88-d4b1-11ed-82ab-13111ccb208d;
        Thu, 06 Apr 2023 19:28:21 +0000 (UTC)
Date:   Thu, 6 Apr 2023 21:28:19 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
Message-ID: <20230406192819.GA1527307@ravnborg.org>
References: <20230406160548.25721-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406160548.25721-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 09:05:48AM -0700, Randy Dunlap wrote:
> arch/sparc/kernel/ebus.o is only built for SPARC64.
> ns87303_lock is only built for SPARC64.
> arch/sparc/include/asm/parport.h says that it is for sparc64.
> Various documentation on the internet says that ebus is for UltraSPARC
> systems (64-bit).
> 
> Therefore don't allow PARPORT_PC to be built for SPARC32.
> 
> Fixes these build errors on SPARC32:
> 
> ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
> ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
> ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
> ERROR: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!
> ERROR: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!
> ERROR: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!
> ERROR: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!
> ERROR: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!
> 
> Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: linux-parport@lists.infradead.org
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/parport/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/parport/Kconfig b/drivers/parport/Kconfig
> --- a/drivers/parport/Kconfig
> +++ b/drivers/parport/Kconfig
> @@ -42,7 +42,7 @@ if PARPORT
>  
>  config PARPORT_PC
>  	tristate "PC-style hardware"
> -	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390)
> +	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390 && !SPARC32)
>  	help
>  	  You should say Y here if you have a PC-style parallel port. All
>  	  IBM PC compatible computers and some Alphas have PC-style
