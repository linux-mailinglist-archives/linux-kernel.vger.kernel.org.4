Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18068C3DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBFQwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjBFQwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:52:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92511199CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:51:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 321BCB81334
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 16:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F0AC433D2;
        Mon,  6 Feb 2023 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675702304;
        bh=0OloNxP9hVllqC85ULVDk1S0qdr5ldTzPUoIOsiVYYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uY2RheL5KeuzG8d3c3tMYeP9i4kvj9OlnGtFu/xslryic5y3qVYwSfKziF9FHuFam
         7oTp/1eLBokMidTPigGYOJtcU/0PeLUKI6ihvffIh9AiVIDiLP/BpuS59j5yw24bdD
         OVktbKqmKy98v9NQowSkgs5Aqkvv/mjz6OO1YBQjKqr8460bB0oEvWbTkfAgUkutq2
         q24E9y1NCLPKOiFVYzGXg9Hr6DkbaADvbjolkrxAcvLr0yy241FEQ+oC2Zt+v2B1TT
         qa2sM19rjR3bECHPKafSwvwv8EEGHnBYM9QIMF3n3Uma+eP2mh+uXEfn831FQWlgMh
         0Wx/ku5CSNjLQ==
Date:   Mon, 6 Feb 2023 09:51:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Jason A. Donenfeld" <zx2c4@kernel.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: arch/x86/crypto/curve25519-x86_64.c:609:3: error: inline
 assembly requires more registers than available
Message-ID: <Y+EwHnWsubeQ0qjh@dev-arch.thelio-3990X>
References: <202302062324.HhzEZCF7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302062324.HhzEZCF7-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 11:52:01PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d2d11f342b179f1894a901f143ec7c008caba43e
> commit: 07b586fe06625b0b610dc3d3a969c51913d143d4 crypto: x86/curve25519 - replace with formally verified implementation
> date:   3 years ago
> config: x86_64-buildonly-randconfig-r006-20230206 (https://download.01.org/0day-ci/archive/20230206/202302062324.HhzEZCF7-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07b586fe06625b0b610dc3d3a969c51913d143d4
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 07b586fe06625b0b610dc3d3a969c51913d143d4
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/crypto/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/crypto/curve25519-x86_64.c:954:6: warning: variable 'carry' set but not used [-Wunused-but-set-variable]
>            u64 carry;
>                ^
>    arch/x86/crypto/curve25519-x86_64.c:951:6: warning: variable 'carry0' set but not used [-Wunused-but-set-variable]
>            u64 carry0;
>                ^
> >> arch/x86/crypto/curve25519-x86_64.c:609:3: error: inline assembly requires more registers than available
>                    "  movq 0(%1), %%rdx;"                                       /* f[0] */
>                    ^
> >> arch/x86/crypto/curve25519-x86_64.c:609:3: error: inline assembly requires more registers than available
>    2 warnings and 2 errors generated.

https://github.com/ClangBuiltLinux/linux/issues/1589

Intel folks, this can probably just be sent to our list from now on.

Cheers,
Nathan
