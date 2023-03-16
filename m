Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5D6BDCCC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCPXTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjCPXTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:19:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17182BCFFF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679008790; x=1710544790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w27aUi7It9h8nbGZhrTxFUQlsPX0IjHEaDxbMAWRWjM=;
  b=G2GmPz//usTsZG0fP4gZf65IgGSHQyOyoYo7rArYozqUUDFjAIZx3uH2
   9weSOuGM/6sh+b/3zpudRXT4+6njpLaTtbiGS18sd7FLQp4ihvqztR+bA
   750L+8f6IKe5GiNr8ywrn7uKUlL+pyGfo+EWJdSOFWy2IYQswOp6RjnFm
   V6iKPronomR058rlF2FY6hut0mFgp2UNA+90EwB3yTAwD7X1yqSbpC+ob
   iSspzOISR9GyWx3Bjy1xnBhmnVg9r+JpEFng2of9WAx4Qxzw8UTarLXKg
   qSOOtxMkcs+A8Mbhox8ROQ7bPaZQ5GeNU6I8rgFJydmVkktMc6SZ81cE6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="326501731"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="326501731"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 16:19:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="744351234"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="744351234"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Mar 2023 16:19:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcwss-0008sg-0H;
        Thu, 16 Mar 2023 23:19:46 +0000
Date:   Fri, 17 Mar 2023 07:19:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] soundwire: bus: Update sdw_nread/nwrite_no_pm to
 handle page boundaries
Message-ID: <202303170724.NdbQwtQo-lkp@intel.com>
References: <20230316155734.3191577-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316155734.3191577-2-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc2 next-20230316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charles-Keepax/soundwire-bus-Update-sdw_nread-nwrite_no_pm-to-handle-page-boundaries/20230317-000005
patch link:    https://lore.kernel.org/r/20230316155734.3191577-2-ckeepax%40opensource.cirrus.com
patch subject: [PATCH 2/2] soundwire: bus: Update sdw_nread/nwrite_no_pm to handle page boundaries
config: mips-randconfig-r022-20230312 (https://download.01.org/0day-ci/archive/20230317/202303170724.NdbQwtQo-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/6944d7175bd15a9a16a411c57f200d3bcecd3c00
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Charles-Keepax/soundwire-bus-Update-sdw_nread-nwrite_no_pm-to-handle-page-boundaries/20230317-000005
        git checkout 6944d7175bd15a9a16a411c57f200d3bcecd3c00
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/soundwire/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303170724.NdbQwtQo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/soundwire/bus.c:398:10: warning: comparison of distinct pointer types ('typeof (count) *' (aka 'unsigned int *') and 'typeof ((((((int)(sizeof(struct (unnamed struct at drivers/soundwire/bus.c:398:10))))) + (((~(((0UL)))) - ((((1UL))) << (0)) + 1) & (~(((0UL))) >> (32 - 1 - (14))))) + 1) - (addr & ((((int)(sizeof(struct (unnamed struct at drivers/soundwire/bus.c:398:10))))) + (((~(((0UL)))) - ((((1UL))) << (0)) + 1) & (~(((0UL))) >> (32 - 1 - (14))))))) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   size = min(count, (SDW_REGADDR + 1) - (addr & SDW_REGADDR));
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +398 drivers/soundwire/bus.c

   384	
   385	/*
   386	 * Read/Write IO functions.
   387	 */
   388	
   389	static int sdw_ntransfer_no_pm(struct sdw_slave *slave, u32 addr, u8 flags,
   390				       size_t count, u8 *val)
   391	{
   392		struct sdw_msg msg;
   393		size_t size;
   394		int ret;
   395	
   396		while (count) {
   397			// Only handle bytes up to next page boundary
 > 398			size = min(count, (SDW_REGADDR + 1) - (addr & SDW_REGADDR));
   399	
   400			ret = sdw_fill_msg(&msg, slave, addr, size, slave->dev_num, flags, val);
   401			if (ret < 0)
   402				return ret;
   403	
   404			ret = sdw_transfer(slave->bus, &msg);
   405			if (ret < 0 && !slave->is_mockup_device)
   406				return ret;
   407	
   408			addr += size;
   409			val += size;
   410			count -= size;
   411		}
   412	
   413		return 0;
   414	}
   415	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
