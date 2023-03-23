Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD6C6C6557
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCWKks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCWKk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:40:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98FC1D92A;
        Thu, 23 Mar 2023 03:37:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A8C4B82070;
        Thu, 23 Mar 2023 10:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F9CC4339B;
        Thu, 23 Mar 2023 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679567844;
        bh=7HVmHyHcaSnCmEQ9wvlGS5D2gJIf2hovuJXSyaCaqdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPKSP02iJA6KAFPv7bGM4/Se81vulHnHqt8qfWTUhZFZfE1s7yfVR1WI2haHPg+A3
         jWzVvRFZzkglSwote3myrlA5TUDE+Mjiy60hA/JC5FTriwEUlR/LYSMkz7fsTaldFc
         oMQlw0WTXs+ktUIZkgxUF4A7BhNREJZy9IC+pPvHI8Vsp+m2dbErDE2naZmB571znT
         Fxiq15cRjtHrw73FO6Y3VXmv90htiJ2rNj1RicLa12inWDP9wSpUycX7R7yd2Kgx+7
         vrbS8fMpVelSjMFK/gnOL3tvAHj3UliwBTODwab575ZgUsXBaJnqCJoJygIlhUcZOE
         OSTuDUXtdmoRA==
Date:   Thu, 23 Mar 2023 12:37:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 02/14] arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZBwr0bXdtOtKKila@kernel.org>
References: <20230323092156.2545741-1-rppt@kernel.org>
 <20230323092156.2545741-3-rppt@kernel.org>
 <ZBwmxbRJrF8RxZEp@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBwmxbRJrF8RxZEp@arm.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:15:33AM +0000, Catalin Marinas wrote:
> On Thu, Mar 23, 2023 at 11:21:44AM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > It is not a good idea to change fundamental parameters of core memory
> > management. Having predefined ranges suggests that the values within
> > those ranges are sensible, but one has to *really* understand
> > implications of changing MAX_ORDER before actually amending it and
> > ranges don't help here.
> > 
> > Drop ranges in definition of ARCH_FORCE_MAX_ORDER
> > 
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >  arch/arm64/Kconfig | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e60baf7859d1..bab6483e4317 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1489,9 +1489,7 @@ config XEN
> >  config ARCH_FORCE_MAX_ORDER
> >  	int "Maximum zone order" if ARM64_4K_PAGES || ARM64_16K_PAGES
> >  	default "13" if ARM64_64K_PAGES
> > -	range 11 13 if ARM64_16K_PAGES
> >  	default "11" if ARM64_16K_PAGES
> > -	range 10 15 if ARM64_4K_PAGES
> >  	default "10"
> 
> I don't mind rewriting the help text as in the subsequent patch but I'd
> keep the ranges as a safety measure. It's less wasted time explaining to
> people why some random max order doesn't work. Alternatively, we can
> drop the ranges but make this option configurable only if EXPERT.

I like the EXPERT alternative more. I'll add it in v2.
 
> -- 
> Catalin

-- 
Sincerely yours,
Mike.
