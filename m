Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A91B72E34F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbjFMMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbjFMMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:49:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508DE4;
        Tue, 13 Jun 2023 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686660539; x=1718196539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4DIaRf5rR2wt24OZUbm+fHnDkQb9/kC9L8KgnQRTvrM=;
  b=CAHyQW2SOPC5tbRuPxtFuURDFCtdYqkg9UawoA+DxB/UF5YofSOAWIVE
   KlqhER3Dg9QZW8EV2JYEkzygo5Xqte+irRDBFlYQcuDARhIbTj+Wq/kS9
   5L2va+vIWUD7nrrTeBB53TneqBEq16TL1QKnYS+gYBEH1V2T8iSe1O+Z0
   0hMeYrqrJKDMWT90dZPg+SAw93JnJdiUjRhzqXz7DZrpMImw9lGoceaK4
   yZUqJUT16YrtBkfCoPXOgeRCBAHtuVO8eRXhylxUQzpAqyBAy3Bc5iAXb
   q2yd1C7tJNFZzbvlJZE6GyAmqBgOU4VOx5Jkh1AZBXhNVpUC4oBAy71Pl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358316913"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="358316913"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="714785617"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="714785617"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 05:48:56 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q93SB-0001M8-1M;
        Tue, 13 Jun 2023 12:48:55 +0000
Date:   Tue, 13 Jun 2023 20:48:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Oltmanns <frank@oltmanns.dev>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Frank Oltmanns <frank@oltmanns.dev>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 2/2] clk: tests: Add tests for fractional divisor
 approximation
Message-ID: <202306132038.nUB6hmCv-lkp@intel.com>
References: <20230613083626.227476-3-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613083626.227476-3-frank@oltmanns.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.4-rc6]
[also build test ERROR on linus/master]
[cannot apply to clk/clk-next next-20230613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Oltmanns/clk-fractional-divider-Improve-approximation-when-zero-based/20230613-163903
base:   v6.4-rc6
patch link:    https://lore.kernel.org/r/20230613083626.227476-3-frank%40oltmanns.dev
patch subject: [PATCH v2 2/2] clk: tests: Add tests for fractional divisor approximation
config: csky-randconfig-r011-20230612 (https://download.01.org/0day-ci/archive/20230613/202306132038.nUB6hmCv-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout v6.4-rc6
        b4 shazam https://lore.kernel.org/r/20230613083626.227476-3-frank@oltmanns.dev
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306132038.nUB6hmCv-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "clk_fractional_divider_general_approximation" [drivers/clk/clk_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
