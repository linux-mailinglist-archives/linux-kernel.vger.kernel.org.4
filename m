Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431406D5961
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjDDHW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjDDHWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:22:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A3268B;
        Tue,  4 Apr 2023 00:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2588A62F5C;
        Tue,  4 Apr 2023 07:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18439C433D2;
        Tue,  4 Apr 2023 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680592939;
        bh=zNbuc2c7Q9IWg5uy9hdmHULoUQBr2Hs/BAYhilZF5F4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqHblzUj1z5GNNRhlVv5PjhJZbkNnPlRJpd8BNP9SFM3LozxkSRnpQ6pJHq1734IE
         nD0HzFbv58nu6J/EDvb0/r/dPnGTG4/RX9IFH1dtOkbIUrpX4gBAxv+iMBA5DHcRED
         emlRqtXMUO+8S4B3gXHGAfaZat5oK//B6B2YKi3S5Gq0z1OVXNwTRQKMwaAeo6YUWs
         fVidc4rMbc4aUoxxzgWhlqdgki6r0Y6O3oX30JhcakMQVSnJAF09H5rT22qPoqcLsD
         1rUCPCKRgr6yla1vp2aXejTBBX5r0wagFlZzYRUY3h9pSLxjoBb/Ad/MMOzP9CoNyA
         E21K1u28YAOpQ==
Date:   Tue, 4 Apr 2023 10:22:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Justin Forbes <jforbes@fedoraproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v3 02/14] arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZCvQGJzdED+An8an@kernel.org>
References: <20230325060828.2662773-1-rppt@kernel.org>
 <20230325060828.2662773-3-rppt@kernel.org>
 <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:55:37AM -0500, Justin Forbes wrote:
> On Sat, Mar 25, 2023 at 1:09 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >
> > It is not a good idea to change fundamental parameters of core memory
> > management. Having predefined ranges suggests that the values within
> > those ranges are sensible, but one has to *really* understand
> > implications of changing MAX_ORDER before actually amending it and
> > ranges don't help here.
> >
> > Drop ranges in definition of ARCH_FORCE_MAX_ORDER and make its prompt
> > visible only if EXPERT=y
> 
> I do not like suddenly hiding this behind EXPERT for a couple of
> reasons.  Most importantly, it will silently change the config for
> users building with an old kernel config.  If a user has for instance
> "13" set and building with 4K pages, as is the current configuration
> for Fedora and RHEL aarch64 builds, an oldconfig build will now set it
> to 10 with no indication that it is doing so.  And while I think that
> 10 is a fine default for many aarch64 users, there are valid reasons
> for choosing other values. Putting this behind expert makes it much
> less obvious that this is an option.

That's the idea of EXPERT, no?

This option was intended to allow allocation of huge pages for
architectures that had PMD_ORDER > MAX_ORDER and not to allow user to
select size of maximal physically contiguous allocation.

Changes to MAX_ORDER fundamentally change the behaviour of core mm and
unless users *really* know what they are doing there is no reason to choose
non-default values so hiding this option behind EXPERT seems totally
appropriate to me.
 
> Justin
> 
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >  arch/arm64/Kconfig | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e60baf7859d1..7324032af859 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1487,11 +1487,9 @@ config XEN
> >  # 16K |       27          |      14      |       13        |         11         |
> >  # 64K |       29          |      16      |       13        |         13         |
> >  config ARCH_FORCE_MAX_ORDER
> > -       int "Maximum zone order" if ARM64_4K_PAGES || ARM64_16K_PAGES
> > +       int "Maximum zone order" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
> >         default "13" if ARM64_64K_PAGES
> > -       range 11 13 if ARM64_16K_PAGES
> >         default "11" if ARM64_16K_PAGES
> > -       range 10 15 if ARM64_4K_PAGES
> >         default "10"
> >         help
> >           The kernel memory allocator divides physically contiguous memory
> > --
> > 2.35.1
> >
> >

-- 
Sincerely yours,
Mike.
