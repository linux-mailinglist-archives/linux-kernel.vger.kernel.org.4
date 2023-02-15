Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877C3697EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBOOvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBOOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:51:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D738B7A;
        Wed, 15 Feb 2023 06:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676472659; x=1708008659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bwfn9iLSdbAEiFOdAhEpJrxKbpghfRzY7pn4NQ6Y3GY=;
  b=lhvLG27SfpSkGtns1W42aT2VPZe20YtISkHr7+P+5pdQMHfouTzwZdR4
   VtxmGNHnbyBkUVsSY7WBXsVpepTa7Zw6ZpX4jfq6u75lo/brTa73fwLSb
   t6Gbif6LFpahBoceVZsxQ4qPrFcLagBqveImQEhC+TfVyQ5yM1HpRyHYX
   iRHuXuby1ZOBtggnpXluT5iR/3IoBCKT0x09Oitz/g6H6bducppDMoYlx
   /UAHHLNEfxNhh8rVP4SWjws8l/qn5k1Jqr14+6Hun5tns6/gkXZPrwmDo
   DkmiOU/YiKH5VAydxXwxxDlrvMSRZBGENX1XyoNlGckyn+m6D9v500T1m
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="331442778"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="331442778"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 06:50:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="699994163"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="699994163"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Feb 2023 06:50:55 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSJ7R-0009Sn-21;
        Wed, 15 Feb 2023 14:50:49 +0000
Date:   Wed, 15 Feb 2023 22:50:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Willem-Jan de Hoog <arinc9.unal@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
Subject: Re: [PATCH 1/2] firmware: bcm47xx_nvram: allow to read from buffered
 nvram data
Message-ID: <202302152222.wtVZ1npH-lkp@intel.com>
References: <20230206100502.20243-2-wdehoog@exalondelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206100502.20243-2-wdehoog@exalondelft.nl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willem-Jan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc8 next-20230215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Willem-Jan-de-Hoog/firmware-bcm47xx_nvram-allow-to-read-from-buffered-nvram-data/20230206-180737
patch link:    https://lore.kernel.org/r/20230206100502.20243-2-wdehoog%40exalondelft.nl
patch subject: [PATCH 1/2] firmware: bcm47xx_nvram: allow to read from buffered nvram data
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230215/202302152222.wtVZ1npH-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/763f6661565b50b967e4f22e41cf46d27e14e58f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Willem-Jan-de-Hoog/firmware-bcm47xx_nvram-allow-to-read-from-buffered-nvram-data/20230206-180737
        git checkout 763f6661565b50b967e4f22e41cf46d27e14e58f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/ethernet/broadcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302152222.wtVZ1npH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/broadcom/bgmac.c:15:
   include/linux/bcm47xx_nvram.h:56:2: error: expected identifier or '(' before ':' token
      56 | }:
         |  ^
   In file included from include/linux/ethtool.h:19,
                    from include/linux/phy.h:16,
                    from drivers/net/ethernet/broadcom/bgmac.c:16:
>> include/uapi/linux/ethtool.h:125:49: warning: 'struct ethtool_cmd' declared inside parameter list will not be visible outside of this definition or declaration
     125 | static inline void ethtool_cmd_speed_set(struct ethtool_cmd *ep,
         |                                                 ^~~~~~~~~~~
   include/uapi/linux/ethtool.h: In function 'ethtool_cmd_speed_set':
   include/uapi/linux/ethtool.h:128:11: error: invalid use of undefined type 'struct ethtool_cmd'
     128 |         ep->speed = (__u16)(speed & 0xFFFF);
         |           ^~
   include/uapi/linux/ethtool.h:129:11: error: invalid use of undefined type 'struct ethtool_cmd'
     129 |         ep->speed_hi = (__u16)(speed >> 16);
         |           ^~
   include/uapi/linux/ethtool.h: At top level:
   include/uapi/linux/ethtool.h:132:52: warning: 'struct ethtool_cmd' declared inside parameter list will not be visible outside of this definition or declaration
     132 | static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
         |                                                    ^~~~~~~~~~~
   include/uapi/linux/ethtool.h: In function 'ethtool_cmd_speed':
   include/uapi/linux/ethtool.h:134:19: error: invalid use of undefined type 'const struct ethtool_cmd'
     134 |         return (ep->speed_hi << 16) | ep->speed;
         |                   ^~
   include/uapi/linux/ethtool.h:134:41: error: invalid use of undefined type 'const struct ethtool_cmd'
     134 |         return (ep->speed_hi << 16) | ep->speed;
         |                                         ^~


vim +125 include/uapi/linux/ethtool.h

607ca46e97a1b6 David Howells    2012-10-13  124  
607ca46e97a1b6 David Howells    2012-10-13 @125  static inline void ethtool_cmd_speed_set(struct ethtool_cmd *ep,
607ca46e97a1b6 David Howells    2012-10-13  126  					 __u32 speed)
607ca46e97a1b6 David Howells    2012-10-13  127  {
85a624403c77c3 Jesse Brandeburg 2016-10-13  128  	ep->speed = (__u16)(speed & 0xFFFF);
607ca46e97a1b6 David Howells    2012-10-13  129  	ep->speed_hi = (__u16)(speed >> 16);
607ca46e97a1b6 David Howells    2012-10-13  130  }
607ca46e97a1b6 David Howells    2012-10-13  131  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
