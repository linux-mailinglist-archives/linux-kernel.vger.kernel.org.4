Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF76B17D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCIAZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCIAZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:25:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9064B38;
        Wed,  8 Mar 2023 16:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678321512; x=1709857512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9dM7kn4pp6sfTQF2DTxl3EoqHV4XCsiAN4jcbawygdc=;
  b=VJwS7n5wt1cc0WO0/UMJSWyLihv3TNoJpFySAQxNM5JxvJ9G15yIFCzr
   YxdH4vZAZ7AhnkApQNC27Cm0EY1yr8yXnnaCZsTr2An8OHjXaEMQjR45D
   +Y7+RD6Abmw6pHuqhdDL+IhPTSDH9DuPA8iSc4oQS1moDa+wv5eoXhwBB
   OGXOeuWAJ3znElF9+3cu4mlWZ7gpmgMheX+Q+QmmCZAq4DBSp+JFtI3wG
   i0m1QhxcssMX7UIws/DiW0INEGWl5wVX0gt7rWnuDD7WYon0adYx6DKsn
   CZr4zQRMSmIjR4Pvjqgzz5/P7HBLC9HAaREisidmZW2xf2CgQV2Qqv8Lx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="422585947"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="422585947"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 16:25:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="923005680"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="923005680"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2023 16:25:09 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pa45f-0002Vz-2J;
        Thu, 09 Mar 2023 00:25:03 +0000
Date:   Thu, 9 Mar 2023 08:24:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] power: max17040: get thermal data from adc if
 available
Message-ID: <202303090802.G5XRtUbY-lkp@intel.com>
References: <20230308084419.11934-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308084419.11934-5-clamor95@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Svyatoslav,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on krzk-dt/for-next linus/master v6.3-rc1 next-20230308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-power-supply-maxim-max17040-update-properties/20230308-164538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20230308084419.11934-5-clamor95%40gmail.com
patch subject: [PATCH v1 4/4] power: max17040: get thermal data from adc if available
config: xtensa-randconfig-r002-20230308 (https://download.01.org/0day-ci/archive/20230309/202303090802.G5XRtUbY-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7b9bbf6f2b910ef4ffab18022223573e9094f007
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Svyatoslav-Ryhel/dt-bindings-power-supply-maxim-max17040-update-properties/20230308-164538
        git checkout 7b9bbf6f2b910ef4ffab18022223573e9094f007
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303090802.G5XRtUbY-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/xtensa/kernel/entry.o: in function `fast_syscall_spill_registers':
   arch/xtensa/kernel/entry.S:1424:(.exception.text+0x1e3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: make_task_dead
   xtensa-linux-ld: drivers/power/supply/max17040_battery.o: in function `max17040_stop_work':
>> max17040_battery.c:(.text+0x60): undefined reference to `iio_read_channel_raw'
   xtensa-linux-ld: drivers/power/supply/max17040_battery.o: in function `max17040_get_property':
   max17040_battery.c:(.text+0x11e): undefined reference to `iio_read_channel_raw'
>> xtensa-linux-ld: max17040_battery.c:(.text+0x170): undefined reference to `iio_channel_release'
   xtensa-linux-ld: drivers/power/supply/max17040_battery.o: in function `max17040_remove':
>> max17040_battery.c:(.text+0x188): undefined reference to `iio_channel_release'
>> xtensa-linux-ld: max17040_battery.c:(.text+0x260): undefined reference to `iio_channel_get'
   xtensa-linux-ld: drivers/power/supply/max17040_battery.o: in function `max17040_probe':
>> max17040_battery.c:(.text+0x542): undefined reference to `iio_channel_get'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
