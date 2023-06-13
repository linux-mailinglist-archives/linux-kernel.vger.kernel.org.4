Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5693B72EBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbjFMTLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjFMTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:11:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FFD92;
        Tue, 13 Jun 2023 12:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686683481; x=1718219481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n85A7XX5nbTTFgI8vxPPQTfwXp2EqTftD8XoZuF/4ak=;
  b=UHv3jnMAZTRx5zURAaQm8FAuh4+spUUE2TKLZfH2U+gh1qJ32JcVtvLt
   D0RTvIp7AfzULrFq1S3f/+TKXwoeXskCoezGLm31dq5+fdEHnNDs8xTI6
   nMPQwrnwp3Pf7uTCvMLboVTL6wwrAbAYITrL6c1fnfoFkz4pXA/7SykV+
   Rw/1dYQ4o4yxW/0B9rC0R/QPxKZKTZTj9Zm29aT3v2h4UrRH1gbs2COls
   DyGEwPAcFhhsO900vNG7tXX4gzHmCyR8FbL5GZB9E4m+dvpdU9xzejDXr
   2DBvbjYpuukt05vp1CZkaqcI1tDVXRx1cmHexJ5HMkGcXOghzHz6Ia7rW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="422027724"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="422027724"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 12:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856232720"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="856232720"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2023 12:11:17 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q99QD-0001gs-0V;
        Tue, 13 Jun 2023 19:11:17 +0000
Date:   Wed, 14 Jun 2023 03:10:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] rtc: isl12022: implement support for the
 #clock-cells DT property
Message-ID: <202306140237.9IMWa7cz-lkp@intel.com>
References: <20230613130011.305589-9-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613130011.305589-9-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on robh/for-next linus/master v6.4-rc6 next-20230613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rasmus-Villemoes/rtc-isl12022-remove-wrong-warning-for-low-battery-level/20230613-210308
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20230613130011.305589-9-linux%40rasmusvillemoes.dk
patch subject: [PATCH v2 8/8] rtc: isl12022: implement support for the #clock-cells DT property
config: hexagon-randconfig-r041-20230612 (https://download.01.org/0day-ci/archive/20230614/202306140237.9IMWa7cz-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add abelloni https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
        git fetch abelloni rtc-next
        git checkout abelloni/rtc-next
        b4 shazam https://lore.kernel.org/r/20230613130011.305589-9-linux@rasmusvillemoes.dk
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306140237.9IMWa7cz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __clk_hw_register_fixed_rate
   >>> referenced by rtc-isl12022.c:272 (drivers/rtc/rtc-isl12022.c:272)
   >>>               drivers/rtc/rtc-isl12022.o:(isl12022_probe) in archive vmlinux.a
   >>> referenced by rtc-isl12022.c:272 (drivers/rtc/rtc-isl12022.c:272)
   >>>               drivers/rtc/rtc-isl12022.o:(isl12022_probe) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
