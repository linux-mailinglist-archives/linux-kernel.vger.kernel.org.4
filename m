Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D06E75C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjDSI4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjDSI4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64C34220;
        Wed, 19 Apr 2023 01:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7458263B6E;
        Wed, 19 Apr 2023 08:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC62C433EF;
        Wed, 19 Apr 2023 08:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681894601;
        bh=oL3JfeXWUvBPUZYm3G7h4erIKqKht1v9PUQNBf1+rOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BR7WTzhV+iyHBxQ8Oa1rcV4sSIOUSmp0fX0gCgozNiJSx7eQY1V/PMcvXsLGM4MLi
         y4DnDqR7GqUjCxVTLISQvLmr2xZLJnC5y9M53YFeOk0EC55PkeSod5brJmGrM0EGhR
         LG0KfajjZxgU7WsGUQJoVUMk/Ks7yPViz5AWk33QbGZSpDZZ5+Qg4wlnTRsGq7tgaE
         1cVsFasQNA+emk3GBpqmUV+J3vB+6qhs/PLg4X0Yjqqz5dz31oXpgtwJPdVN8f05kZ
         Oj/30StHYGewt51jyd4ViqMaxcXCkBDpbFqe91wYXXx7hb0cja/0MnPVN2RsvZIgYt
         VRrAqyXH2ZrNQ==
Date:   Wed, 19 Apr 2023 11:56:22 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
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
Subject: Re: [PATCH v3 05/14] ia64: don't allow users to override
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZD+stlzr83s6qkJr@kernel.org>
References: <20230325060828.2662773-1-rppt@kernel.org>
 <20230325060828.2662773-6-rppt@kernel.org>
 <02dd2437-32fa-31aa-4ff3-b33a058f2363@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02dd2437-32fa-31aa-4ff3-b33a058f2363@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 02:38:15PM +0800, Kefeng Wang wrote:
> 
> 
> On 2023/3/25 14:08, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > It is enough to keep default values for base and huge pages without
> > letting users to override ARCH_FORCE_MAX_ORDER.
> > 
> > Drop the prompt to make the option unvisible in *config.
> > 
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >   arch/ia64/Kconfig | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> > index 0d2f41fa56ee..b61437cae162 100644
> > --- a/arch/ia64/Kconfig
> > +++ b/arch/ia64/Kconfig
> > @@ -202,8 +202,7 @@ config IA64_CYCLONE
> >   	  If you're unsure, answer N.
> >   config ARCH_FORCE_MAX_ORDER
> > -	int "MAX_ORDER (10 - 16)"  if !HUGETLB_PAGE
> > -	range 10 16  if !HUGETLB_PAGE
> > +	int
> >   	default "16" if HUGETLB_PAGE
> >   	default "10"
> 
> It seems that we could drop the following part?

ia64 can have 64k pages, so with MAX_ORDER==16 we'd need at least 32 bits
for section size
 
> diff --git a/arch/ia64/include/asm/sparsemem.h
> b/arch/ia64/include/asm/sparsemem.h
> index a58f8b466d96..18187551b183 100644
> --- a/arch/ia64/include/asm/sparsemem.h
> +++ b/arch/ia64/include/asm/sparsemem.h
> @@ -11,11 +11,6 @@
> 
>  #define SECTION_SIZE_BITS      (30)
>  #define MAX_PHYSMEM_BITS       (50)
> -#ifdef CONFIG_ARCH_FORCE_MAX_ORDER
> -#if (CONFIG_ARCH_FORCE_MAX_ORDER + PAGE_SHIFT > SECTION_SIZE_BITS)
> -#undef SECTION_SIZE_BITS
> -#define SECTION_SIZE_BITS (CONFIG_ARCH_FORCE_MAX_ORDER + PAGE_SHIFT)
> -#endif
>  #endif
> 

-- 
Sincerely yours,
Mike.
