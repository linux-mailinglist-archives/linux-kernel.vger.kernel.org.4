Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761B361EEBA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiKGJWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiKGJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:22:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912CC1742B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:22:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E3CA60F7E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B630AC433C1;
        Mon,  7 Nov 2022 09:22:36 +0000 (UTC)
Date:   Mon, 7 Nov 2022 09:22:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>,
        Mark Brown <broonie@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 04/13] mm/slab: Allow kmalloc() minimum alignment
 fallback to dma_get_cache_alignment()
Message-ID: <Y2jOWXz0rdM/+jfx@arm.com>
References: <20221106220143.2129263-5-catalin.marinas@arm.com>
 <202211070812.BhGKB0Hd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211070812.BhGKB0Hd-lkp@intel.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 08:50:31AM +0800, kernel test robot wrote:
> url:    https://github.com/intel-lab-lkp/linux/commits/Catalin-Marinas/mm-dma-arm64-Reduce-ARCH_KMALLOC_MINALIGN-to-8/20221107-060303
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20221106220143.2129263-5-catalin.marinas%40arm.com
> patch subject: [PATCH v3 04/13] mm/slab: Allow kmalloc() minimum alignment fallback to dma_get_cache_alignment()
> config: parisc-randconfig-r003-20221106
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/309bc52a1ed9665a1b9d32bcf094918ceb6af519
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Catalin-Marinas/mm-dma-arm64-Reduce-ARCH_KMALLOC_MINALIGN-to-8/20221107-060303
>         git checkout 309bc52a1ed9665a1b9d32bcf094918ceb6af519
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    mm/slab_common.c: In function '__kmalloc_minalign':
> >> mm/slab_common.c:866:52: error: 'io_tlb_default_mem' undeclared (first use in this function)
>      866 |             cache_align < ARCH_KMALLOC_MINALIGN || io_tlb_default_mem.nslabs)
>          |                                                    ^~~~~~~~~~~~~~~~~~
>    mm/slab_common.c:866:52: note: each undeclared identifier is reported only once for each function it appears in

Thanks for this. It looks like I didn't test the series with
CONFIG_SWIOTLB disabled.

-- 
Catalin
