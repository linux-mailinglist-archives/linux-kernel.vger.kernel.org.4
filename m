Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449A169F833
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjBVPiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjBVPiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:38:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C63CE39;
        Wed, 22 Feb 2023 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677080264; x=1708616264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GjHMCPdnc/DQBIYCfxd4PyPZOUVK7PxFHa2aAc4wkSI=;
  b=PwhieWXsDAcrANU5JBZYlc3k6giVn7IxYjl6XoExTArQG9sd7WatBJXi
   RjfOmxqwFgn5WlRkwqHoBSI5mBpEZTZ+hvCTp+eVW2at3BqpxtsgrG4JM
   cczcHkwZdivoEgOF4aohsQ8mEXqJLrpyvwnjs0K4Ko006miHNUkIGbd2C
   FiSe2iJXqpf73v+9MwhATyyAMobuVL+F5SGdPdFXiJbvsx3/JfnAnHtX4
   kQbNc5qt9VrFLRy/7AKBT0Z0H/2p156eBH/u9mUh94HsgW2mYEYQWdE3/
   FzqobAdt9opF82QEugZ7RRxsi3wXy42hPAVf/R5LjzpMMW0z6iRF6JvsW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="360438034"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="360438034"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 07:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="846182182"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="846182182"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Feb 2023 07:37:21 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUrBI-0000VJ-0y;
        Wed, 22 Feb 2023 15:37:20 +0000
Date:   Wed, 22 Feb 2023 23:37:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        alistair@popple.id.au, joel@jms.id.au, jk@ozlabs.org,
        andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: Re: [PATCH v5 4/6] fsi: Add I2C Responder SCOM driver
Message-ID: <202302222352.9rPqJxAV-lkp@intel.com>
References: <20230221212622.3897097-5-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221212622.3897097-5-eajames@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.2 next-20230222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/fsi-Move-fsi_slave-structure-definition-to-header/20230222-052904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230221212622.3897097-5-eajames%40linux.ibm.com
patch subject: [PATCH v5 4/6] fsi: Add I2C Responder SCOM driver
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230222/202302222352.9rPqJxAV-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/210010944ddca8e974ec4f5141a00c38eddf5b8e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eddie-James/fsi-Move-fsi_slave-structure-definition-to-header/20230222-052904
        git checkout 210010944ddca8e974ec4f5141a00c38eddf5b8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302222352.9rPqJxAV-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "fsi_master_i2cr_write" [drivers/fsi/i2cr-scom.ko] undefined!
>> ERROR: modpost: "fsi_master_i2cr_read" [drivers/fsi/i2cr-scom.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
