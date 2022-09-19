Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9DF5BD00D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiISPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:10:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8592A712;
        Mon, 19 Sep 2022 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663600246; x=1695136246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UB13A1XuABk+pdSrOQDK5a/k2hrx2eMwac3alMLt79U=;
  b=n3AWe4mpqo8/kMJclJ10LTgwNja+U24bRiyGC8gBclP1WbcI5yAFI+8k
   HUgKsV9XQkQp/505QOrIVAj74mMEpYh2unEY6ihNlKXsnk1ImRjJ85pGz
   AkQESxuh4e7BZmRa8L0QaDl9fdK859oFpjihJDaXoffDdUo/KiY+uJFQw
   ey24kjdF/86xenrVAw1bwXwCoFMB+R7BGTRyzS7HVQwD7SlAMDLoapnub
   SMnQ9/rH49wvLlfySFqDalT4jKxF6TFuWVP7/l8NY+PcX7hjJh815VJha
   yeh3E1+5f6IDB36ecDDpeRSKFd2gU3jGejPKEC0sJZOlcFE+g4u1AbcEt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="361164046"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="361164046"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 08:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="947257761"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2022 08:10:43 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaIPy-00023A-30;
        Mon, 19 Sep 2022 15:10:42 +0000
Date:   Mon, 19 Sep 2022 23:10:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] crypto: add rsize config to .config only if lib_poly1305
 is set
Message-ID: <202209192252.T6IGLNqC-lkp@intel.com>
References: <20220919060342.26400-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919060342.26400-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

I love your patch! Yet something to improve:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master linus/master v6.0-rc6 next-20220919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukas-Bulwahn/crypto-add-rsize-config-to-config-only-if-lib_poly1305-is-set/20220919-140531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220919/202209192252.T6IGLNqC-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/c1954797e493eabf02f354e290fe380ace0633e4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lukas-Bulwahn/crypto-add-rsize-config-to-config-only-if-lib_poly1305-is-set/20220919-140531
        git checkout c1954797e493eabf02f354e290fe380ace0633e4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/crypto/caam/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/crypto/caam/ctrl.c:15:
   In file included from drivers/crypto/caam/compat.h:41:
>> include/crypto/poly1305.h:56:32: error: use of undeclared identifier 'CONFIG_CRYPTO_LIB_POLY1305_RSIZE'
                   struct poly1305_key opaque_r[CONFIG_CRYPTO_LIB_POLY1305_RSIZE];
                                                ^
   1 error generated.


vim +/CONFIG_CRYPTO_LIB_POLY1305_RSIZE +56 include/crypto/poly1305.h

878afc35cd28bc Eric Biggers       2018-11-16  40  
2546f811ef45fc Martin Willi       2015-07-16  41  struct poly1305_desc_ctx {
2546f811ef45fc Martin Willi       2015-07-16  42  	/* partial buffer */
2546f811ef45fc Martin Willi       2015-07-16  43  	u8 buf[POLY1305_BLOCK_SIZE];
2546f811ef45fc Martin Willi       2015-07-16  44  	/* bytes used in partial buffer */
2546f811ef45fc Martin Willi       2015-07-16  45  	unsigned int buflen;
ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  46  	/* how many keys have been set in r[] */
ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  47  	unsigned short rset;
ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  48  	/* whether s[] has been set */
2546f811ef45fc Martin Willi       2015-07-16  49  	bool sset;
ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  50  	/* finalize key */
ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  51  	u32 s[4];
ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  52  	/* accumulator */
ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  53  	struct poly1305_state h;
ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  54  	/* key */
1c08a104360f3e Jason A. Donenfeld 2020-01-05  55  	union {
1c08a104360f3e Jason A. Donenfeld 2020-01-05 @56  		struct poly1305_key opaque_r[CONFIG_CRYPTO_LIB_POLY1305_RSIZE];
1c08a104360f3e Jason A. Donenfeld 2020-01-05  57  		struct poly1305_core_key core_r;
1c08a104360f3e Jason A. Donenfeld 2020-01-05  58  	};
2546f811ef45fc Martin Willi       2015-07-16  59  };
2546f811ef45fc Martin Willi       2015-07-16  60  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
