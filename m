Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76196701A98
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 00:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEMWjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 18:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMWjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 18:39:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB92101;
        Sat, 13 May 2023 15:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684017561; x=1715553561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KAXdgdOY61L3sPki2Oyvdb5BlEXxSBL8pTPtcZ+z/Vs=;
  b=TrqQCcDFcrsn3yrWEhucYm9GmUWnxkZy8KFKwutP0NqRe+uS3CzJre67
   LvhstZ4juPHkQP9EOxLIptLpLQf6/UcO4HXGt2yEyoMx89Kp9lbHEVqfl
   YsGEhL7BEqNLBS6JfircWFTf88x9fZ+3dmaZ10D6vDhq/o3OaJtrLABhS
   SQhV3Ac0OxuTiRBMOi6PxbSy6GK1HzFBwbZh3Hh4J/yvFVdk79jGa0QVs
   sqQgvj/0LdPiBVA4zcaq7Qiih3mNUHvgQIEdi3Lqz/N7WREM75AWsKcyr
   Nv+zlj8o/bqIE6VY4Zzkat+b4VLZjqUkXVy8uxxrj4QSLNxCwBxqyUnU5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="416633902"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="416633902"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="700535782"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="700535782"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 May 2023 15:39:17 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxxtV-0005i8-0E;
        Sat, 13 May 2023 22:39:17 +0000
Date:   Sun, 14 May 2023 06:38:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: Re: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons
 handling
Message-ID: <202305140640.VLcvhR5G-lkp@intel.com>
References: <20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264@wolfvision.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

kernel test robot noticed the following build errors:

[auto build test ERROR on ac9a78681b921877518763ba0e89202254349d1b]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/Input-ts-virtobj-Add-touchsreen-virtual-object-handling/20230510-215519
base:   ac9a78681b921877518763ba0e89202254349d1b
patch link:    https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264%40wolfvision.net
patch subject: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons handling
config: arm-randconfig-m041-20230514 (https://download.01.org/0day-ci/archive/20230514/202305140640.VLcvhR5G-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/133c0f8c33dc5e70a72e6a7d670e133b6043a7a3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Javier-Carrasco/Input-ts-virtobj-Add-touchsreen-virtual-object-handling/20230510-215519
        git checkout 133c0f8c33dc5e70a72e6a7d670e133b6043a7a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305140640.VLcvhR5G-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/input/touchscreen/st1232.o: in function `st1232_ts_parse_and_report':
>> st1232.c:(.text+0x148): undefined reference to `ts_virtobj_is_button_slot'
>> arm-linux-gnueabi-ld: st1232.c:(.text+0x15e): undefined reference to `ts_virtobj_button_press'
>> arm-linux-gnueabi-ld: st1232.c:(.text+0x16c): undefined reference to `ts_virtobj_mt_on_touchscreen'
>> arm-linux-gnueabi-ld: st1232.c:(.text+0x242): undefined reference to `ts_virtobj_mapped_buttons'
>> arm-linux-gnueabi-ld: st1232.c:(.text+0x266): undefined reference to `ts_virtobj_is_button_slot'
>> arm-linux-gnueabi-ld: st1232.c:(.text+0x276): undefined reference to `ts_virtobj_button_release'
   arm-linux-gnueabi-ld: drivers/input/touchscreen/st1232.o: in function `st1232_ts_probe':
>> st1232.c:(.text+0x42c): undefined reference to `ts_virtobj_map_objects'
>> arm-linux-gnueabi-ld: st1232.c:(.text+0x43c): undefined reference to `ts_virtobj_mapped_touchscreen'
>> arm-linux-gnueabi-ld: st1232.c:(.text+0x44a): undefined reference to `ts_virtobj_get_touchscreen_abs'
   arm-linux-gnueabi-ld: st1232.c:(.text+0x520): undefined reference to `ts_virtobj_mapped_buttons'
>> arm-linux-gnueabi-ld: st1232.c:(.text+0x542): undefined reference to `ts_virtobj_set_button_caps'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
