Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90F6950A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBMT0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBMT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:26:50 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0B7A5D1;
        Mon, 13 Feb 2023 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676316409; x=1707852409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FGwz8nOw6iKU+c5T1A1dSA/m1F//eesxLf2xx3SqtTQ=;
  b=SEI5zkM3JnUw6iUXdr04M7hFiQymcFWgN8LOmctbym69w71euPylqPwz
   aEhCr8LjWMfubdukWH+zeSRrghBOb/ihokj5R8Lo8SMu1v5+ZyzkEll30
   5un6c3blCfvtbGR9OEsVdfy2cW1AZsVzL1MRqh8LbY9bZOhxJIqTr482y
   8v1IcycO8KZ9z+NYie7o0QSTn7Xm9eGPZWn2HGnTMlklfTGmt3N7hYA/S
   yJkpjYyP+u6XWQvdTw8ojto0envTPAnoHMhoW7B4fAgLLNMAXaoTmSzZH
   M3tj/uqppxJlTC1wfv5hSpOZmU/Xeu9Jk4018vw82xXUs+BYuiwqsajuQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="314618777"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="314618777"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="792833578"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="792833578"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2023 11:26:33 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pReTA-0007yR-14;
        Mon, 13 Feb 2023 19:26:32 +0000
Date:   Tue, 14 Feb 2023 03:25:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: workaround long ioctl busy timeout
Message-ID: <202302140314.idOxiF7x-lkp@intel.com>
References: <8f4a0fc6f2e64ef091784c5cd704c113@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f4a0fc6f2e64ef091784c5cd704c113@hyperstone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2-rc8 next-20230213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-L-hle/mmc-block-workaround-long-ioctl-busy-timeout/20230213-183603
patch link:    https://lore.kernel.org/r/8f4a0fc6f2e64ef091784c5cd704c113%40hyperstone.com
patch subject: [PATCH] mmc: block: workaround long ioctl busy timeout
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230214/202302140314.idOxiF7x-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/94406ad8626aa2d7761fb7eb20a918a4805ea667
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christian-L-hle/mmc-block-workaround-long-ioctl-busy-timeout/20230213-183603
        git checkout 94406ad8626aa2d7761fb7eb20a918a4805ea667
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302140314.idOxiF7x-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mmc_prepare_busy_cmd" [drivers/mmc/core/mmc_block.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
