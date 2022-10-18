Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A864C603196
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJRRaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRRaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185C67C331;
        Tue, 18 Oct 2022 10:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC658B82081;
        Tue, 18 Oct 2022 17:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7F2C433D6;
        Tue, 18 Oct 2022 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666114212;
        bh=iC7xbLDKxSND0ns2xavGEekUmGJNLfcd6uk0LUkTH8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n0nM45rn4Ww/uIwaSnJVfDH9M9rsWLWz2apOSi9Qog0d44GTiIuKPQ6TOojtDL5sX
         EQ/mHY0vDfnAOqrZjohveCUIiUoj+AyoA73PkUahc6kQ/423yNAUMXfdk4ofqKPPKh
         GwBp8ILDY7V+3p+wxAlV5eCRWDBCsBp2mvUyWJ1gScxFUKFv6EiCKREX6nTvHoBUGq
         LZu2lxmjMaiabQBNzDS1R7H9OZCE0iXO7OUsYa+GuAmecUC9HTRg+VOf3ltPJA68sy
         evXTCy+J7I3BEWH68baBDV/2dryiw4AmxQCJLNnCUkQIH1MHAxm1FFnmysqNS4RM0a
         75sL4hiAQWtPA==
Date:   Tue, 18 Oct 2022 12:30:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH 1/3] sh: remove unused SLOW_DOWN_IO
Message-ID: <20221018173010.GA3813365@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014001911.3342485-2-helgaas@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 07:19:09PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> io.h defines SLOW_DOWN_IO only when CONF_SLOWDOWN_IO is defined, but
> CONF_SLOWDOWN_IO is never defined and is in fact explicitly undefined.
> Remove SLOW_DOWN_IO and related code.
> 
> N.B. 37b7a97884ba ("sh: machvec IO death.") went to some trouble to add
> CONF_SLOWDOWN_IO and SLOW_DOWN_IO, for no obvious reason.  Maybe there was
> some out-of-tree case that used this.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org

Please disregard this patch.  I'll post an updated version that fixes
the build error and removes a little more unused/unnecessary stuff.

> ---
>  arch/sh/include/asm/io.h | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index fba90e670ed4..8d2df499b2fc 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -121,11 +121,6 @@ __BUILD_MEMORY_STRING(__raw_, q, u64)
>  
>  #ifdef CONFIG_HAS_IOPORT_MAP
>  
> -/*
> - * Slowdown I/O port space accesses for antique hardware.
> - */
> -#undef CONF_SLOWDOWN_IO
> -
>  /*
>   * On SuperH I/O ports are memory mapped, so we access them using normal
>   * load/store instructions. sh_io_port_base is the virtual address to
> @@ -145,13 +140,7 @@ static inline void __set_io_port_base(unsigned long pbase)
>  extern void __iomem *__ioport_map(unsigned long addr, unsigned int size);
>  #endif
>  
> -#ifdef CONF_SLOWDOWN_IO
> -#define SLOW_DOWN_IO __raw_readw(sh_io_port_base)
> -#else
> -#define SLOW_DOWN_IO
> -#endif
> -
> -#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p, slow)			\
> +#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p)			\
>  									\
>  static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
>  {									\
> @@ -159,7 +148,6 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
>  									\
>  	__addr = __ioport_map(port, sizeof(type));			\
>  	*__addr = val;							\
> -	slow;								\
>  }									\
>  									\
>  static inline type pfx##in##bwlq##p(unsigned long port)			\
> @@ -169,14 +157,13 @@ static inline type pfx##in##bwlq##p(unsigned long port)			\
>  									\
>  	__addr = __ioport_map(port, sizeof(type));			\
>  	__val = *__addr;						\
> -	slow;								\
>  									\
>  	return __val;							\
>  }
>  
>  #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
>  	__BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)			\
> -	__BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
> +	__BUILD_IOPORT_SINGLE(bus, bwlq, type, _p,)
>  
>  #define BUILDIO_IOPORT(bwlq, type)					\
>  	__BUILD_IOPORT_PFX(, bwlq, type)
> -- 
> 2.25.1
> 
