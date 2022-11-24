Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C1A638031
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiKXUbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:31:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995DD68C69;
        Thu, 24 Nov 2022 12:31:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D495B828FF;
        Thu, 24 Nov 2022 20:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB9BC433D6;
        Thu, 24 Nov 2022 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669321862;
        bh=VYogHO/QzC0Ie7JtQNRyLU+4odaED0lO+ZqrQ2anQ4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4JIUPPb4GNyqmaugd+1VesUVg/rY2YBuh9jPZSEa9LfSEQzH3zDygt0HPqdzet2M
         Dp4c/55O2yCFMpzlwelwJsAnq/cWVHvGVHOAbVO908xeu84LN7567KgsRaE4IVVlI4
         irQCMsnXsSJ21jNJaw6RWjzOUpRxJ6RKhWjRfpd9wRYv71gwQVQAvT0UvpbAXv+eDr
         jBzcX+3BhUu0qt/DvQCSNER8QfDrEQGt+TJ9slcZjWNwkaVshc7is4iQ3Zq0vSzdZc
         hcrepLOFcnDEx3g9ybGBdkV9QmYuTZxJxy7F+stexs8bO96+DDGYQXJXkj+qDrkXGn
         djLsL9V97W7iw==
Date:   Thu, 24 Nov 2022 22:30:41 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Conor Dooley <conor@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        openrisc@lists.librecores.org, Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Tony Lindgren <tony@atomide.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 00/12] Introduce CONFIG_SLUB_TINY and deprecate SLOB
Message-ID: <Y3/UccT+hJ/6/v4c@kernel.org>
References: <20221121171202.22080-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171202.22080-1-vbabka@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:11:50PM +0100, Vlastimil Babka wrote:
> Hi,
> 
> this continues the discussion from [1]. Reasons to remove SLOB are
> outlined there and no-one has objected so far. The last patch of this
> series therefore deprecates CONFIG_SLOB and updates all the defconfigs
> using CONFIG_SLOB=y in the tree.
> 
> There is a k210 board with 8MB RAM where switching to SLUB caused issues
> [2] and the lkp bot wasn't also happy about code bloat [3]. To address
> both, this series introduces CONFIG_SLUB_TINY to perform some rather
> low-hanging fruit modifications to SLUB to reduce its memory overhead.
> This seems to have been successful at least in the k210 case [4]. I
> consider this as an acceptable tradeoff for getting rid of SLOB.
> 
> The series is also available in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-tiny-v1r2
> 
> [1] https://lore.kernel.org/all/b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz/
> [2] https://lore.kernel.org/all/a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com/
> [3] https://lore.kernel.org/all/Y25E9cJbhDAKi1vd@99bb1221be19/
> [4] https://lore.kernel.org/all/6a1883c4-4c3f-545a-90e8-2cd805bcf4ae@opensource.wdc.com/
> 
> Vlastimil Babka (12):
>   mm, slab: ignore hardened usercopy parameters when disabled
>   mm, slub: add CONFIG_SLUB_TINY
>   mm, slub: disable SYSFS support with CONFIG_SLUB_TINY
>   mm, slub: retain no free slabs on partial list with CONFIG_SLUB_TINY
>   mm, slub: lower the default slub_max_order with CONFIG_SLUB_TINY
>   mm, slub: don't create kmalloc-rcl caches with CONFIG_SLUB_TINY
>   mm, slab: ignore SLAB_RECLAIM_ACCOUNT with CONFIG_SLUB_TINY
>   mm, slub: refactor free debug processing
>   mm, slub: split out allocations from pre/post hooks
>   mm, slub: remove percpu slabs with CONFIG_SLUB_TINY
>   mm, slub: don't aggressively inline with CONFIG_SLUB_TINY
>   mm, slob: rename CONFIG_SLOB to CONFIG_SLOB_DEPRECATED
> 
>  arch/arm/configs/clps711x_defconfig           |   3 +-
>  arch/arm/configs/collie_defconfig             |   3 +-
>  arch/arm/configs/multi_v4t_defconfig          |   3 +-
>  arch/arm/configs/omap1_defconfig              |   3 +-
>  arch/arm/configs/pxa_defconfig                |   3 +-
>  arch/arm/configs/tct_hammer_defconfig         |   3 +-
>  arch/arm/configs/xcep_defconfig               |   3 +-
>  arch/openrisc/configs/or1ksim_defconfig       |   3 +-
>  arch/openrisc/configs/simple_smp_defconfig    |   3 +-
>  arch/riscv/configs/nommu_k210_defconfig       |   3 +-
>  .../riscv/configs/nommu_k210_sdcard_defconfig |   3 +-
>  arch/riscv/configs/nommu_virt_defconfig       |   3 +-
>  arch/sh/configs/rsk7201_defconfig             |   3 +-
>  arch/sh/configs/rsk7203_defconfig             |   3 +-
>  arch/sh/configs/se7206_defconfig              |   3 +-
>  arch/sh/configs/shmin_defconfig               |   3 +-
>  arch/sh/configs/shx3_defconfig                |   3 +-
>  include/linux/slab.h                          |   8 +
>  include/linux/slub_def.h                      |   6 +-
>  kernel/configs/tiny.config                    |   5 +-
>  mm/Kconfig                                    |  38 +-
>  mm/Kconfig.debug                              |   2 +-
>  mm/slab_common.c                              |  16 +-
>  mm/slub.c                                     | 415 ++++++++++++------
>  24 files changed, 377 insertions(+), 164 deletions(-)

For the series

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

-- 
Sincerely yours,
Mike.
