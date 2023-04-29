Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7832A6F25EE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjD2TBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjD2TBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565AA1A1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 12:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD2EF60ED1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 19:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91200C433D2;
        Sat, 29 Apr 2023 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682794881;
        bh=NL8xzLoHTzsT7JTBAB6xnrlmNzu+k3vM+JbT266377Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0R2F8X9Nt0WOt+PaaAcHDznR51stshp5ucRSBy5rne1cGXHgnkEQ8vn3XcoQzOJ0
         8AaOM8o1OE2uvXtx75UA9a2RkxBfLMHAqWMaqhRstnUgQzl0V5CunqIUSDq11IBFi0
         g3y28gee+9/5bjGCTG0xMfBFQ5D5Lp1b50q5qaPgUvRkL10A1H/qkMS6aPQ7L/uCl6
         99adC+8+jlpkYpnBo2bAhQbW2g4IyNUf6uxDCbfYJvi7A3fmwjlIGckgIU1thFtGQG
         FyH3Gv1/hjTqga4F15SJoKoQ1GXzJZdBz/Rdnbz1S/yMcSdot2HZ/uYb3BCZVydxFa
         GMbPbwX5oJnFQ==
Date:   Sat, 29 Apr 2023 22:01:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Revert arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZE1pcwi95nPdlKzN@kernel.org>
References: <20230428153646.823736-1-jforbes@fedoraproject.org>
 <ZEv76qfIiJcUvdql@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEv76qfIiJcUvdql@arm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 06:01:30PM +0100, Catalin Marinas wrote:
> + Mike and Andrew
> 
> On Fri, Apr 28, 2023 at 10:36:45AM -0500, Justin M. Forbes wrote:
> > While the ARCH_FORCE_MAX_ORDER changes clarified the descriptions quite
> > a bit, the aarch64 specific change moved this config to sit behind
> > CONFIG_EXPERT. This becomes problematic when distros are setting this to
> > a non default value already. Pushing it behind EXPERT where it was not
> > before will silently change the configuration for users building with
> > oldconfig.  If distros patch out if EXPERT downstream, it still creates
> > problems for users testing out upstream patches, or trying to bisect to
> > find the root of problem, as the configuration will change unexpectedly,
> > possibly leading to different behavior and false results.
> > 
> > Whem I asked about reverting the EXPERT, dependency, I was asked to add

Nit: When

> > the ranges back.
> > 
> > This essentially reverts commit 34affcd7577a232803f729d1870ba475f294e4ea
> > 
> > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/Kconfig | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index b1201d25a8a4..dae18ac01e94 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1516,9 +1516,11 @@ config XEN
> >  # 16K |       27          |      14      |       13        |         11         |
> >  # 64K |       29          |      16      |       13        |         13         |
> >  config ARCH_FORCE_MAX_ORDER
> > -	int "Order of maximal physically contiguous allocations" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
> > +	int "Order of maximal physically contiguous allocations" if ARM64_4K_PAGES || ARM64_16K_PAGES
> >  	default "13" if ARM64_64K_PAGES
> > +	range 11 13 if ARM64_16K_PAGES
> >  	default "11" if ARM64_16K_PAGES
> > +	range 10 15 if ARM64_4K_PAGES
> >  	default "10"
> >  	help
> >  	  The kernel page allocator limits the size of maximal physically
> 
> The revert looks fine to me:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> For the record, the original discussion:
> 
> Link: https://lore.kernel.org/r/CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com

I'm not really happy about this revert because MAX_ORDER is not something
that should be changed easily.
But since hiding it behind EXPERT would silently change lots of existing
builds, I won't object.

Still, I never got the answer _why_ Fedora/RHEL configs use non-default
value. Quite possible something else needs to be fixed rather than having
overgrown MAX_ORDER.

-- 
Sincerely yours,
Mike.
