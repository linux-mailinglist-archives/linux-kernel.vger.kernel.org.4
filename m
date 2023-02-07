Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E668E0C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBGTCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjBGTCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:02:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDED3E0A7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:02:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC074B81ABD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 19:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2CFC433EF;
        Tue,  7 Feb 2023 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675796532;
        bh=lSMpcoGYsjZ3A/sSsABLKEIdxHqvf2/rD9Wt7vnKRlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZzSwgPqEOF9ZwxQGIJMH+LXGDqdDwOxAlCh8eshUUyPm2QeNOjNP2d3sP+USnB/OP
         RFuWUiNivOoR6LDhWL9SPYkqt/xnpzA5jL1X91koxsOZU2ic7R5sKURnLzmDqcJbpV
         wiVFRIeBAVqb3lUvha3VDLLl2kopqxT5mPOAYqIQJlPdvly9A0NcudY2+h2urayRDP
         HZPHBOTw5Apg6h4455rzCZ5gwqjsyhPi4lpkHkDgbtOfMQUp0rWqqgAZqHoa/MOi1p
         B9YXpoYxnjdznDsbEjmrqrf9tG2/lh/OqMw9N3wv7X9j4vc5dWjWXjZEZzDc+9D/gA
         AcHV/yBkBUM+A==
Date:   Tue, 7 Feb 2023 12:02:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: include/linux/fortify-string.h:414:4: error: call to
 '__read_overflow' declared with 'error' attribute: detected read beyond size
 of object (1st parameter)
Message-ID: <Y+KgMv3Coc4gnV2p@dev-arch.thelio-3990X>
References: <202302080231.ZqOmpanX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302080231.ZqOmpanX-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 02:59:05AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   05ecb680708a1dbe6554d6fc17e5d9a8a7cb5e6a
> commit: 925d046e7e52c71c3531199ce137e141807ef740 RDMA/core: Add a netevent notifier to cma
> date:   8 months ago
> config: mips-buildonly-randconfig-r006-20230207 (https://download.01.org/0day-ci/archive/20230208/202302080231.ZqOmpanX-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=925d046e7e52c71c3531199ce137e141807ef740
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 925d046e7e52c71c3531199ce137e141807ef740
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/infiniband/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/infiniband/core/cma.c:9:
>    In file included from include/linux/completion.h:12:
>    In file included from include/linux/swait.h:7:
>    In file included from include/linux/spinlock.h:55:
>    In file included from include/linux/preempt.h:78:
>    In file included from ./arch/mips/include/generated/asm/preempt.h:1:
>    In file included from include/asm-generic/preempt.h:5:
>    In file included from include/linux/thread_info.h:60:
>    In file included from arch/mips/include/asm/thread_info.h:16:
>    In file included from arch/mips/include/asm/processor.h:15:
>    In file included from include/linux/cpumask.h:12:
>    In file included from include/linux/bitmap.h:11:
>    In file included from include/linux/string.h:253:
> >> include/linux/fortify-string.h:414:4: error: call to '__read_overflow' declared with 'error' attribute: detected read beyond size of object (1st parameter)
>                            __read_overflow();
>                            ^
>    1 error generated.

This is tentatively a bug in clang, although I do not see KASAN enabled:

https://github.com/ClangBuiltLinux/linux/issues/1687

I do see CONFIG_UBSAN_BOOL=y though, so this could be a generic
sanitizer problem.

Cheers,
Nathan
