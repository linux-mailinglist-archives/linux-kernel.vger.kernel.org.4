Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3016AAC3A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCDTwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCDTwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:52:07 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E99411EA6;
        Sat,  4 Mar 2023 11:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677959526; x=1709495526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c83oOAJjGMv0z2lGjoyCx9lkY0zkC4X67gcWtyzD830=;
  b=NOqkEjAqTGesTJVGpo1rz3U5qgdpYvzP0GSX698nqOmOUU1PRWtyJSVB
   nm3CPvwTGEnj6B0goxiKsfxgrgPxxIVgC4iqoW9emCnT/JEKOJGcT7DTx
   GjpdC/CXNznSme2bkk7zSqifZTw50nD81Zb0g0w42uqKI7t3q5stggGIp
   +Av7lLNJsZGdcWZX4F1oLTlmhSbl+5vi9YJ314oFlZcCAksic8V7kGXeg
   Owtmuy36GDaG+t/qlU2H8NQvi7ZEpGUVFUeqXHN68/izVdJdhKuPCsAWy
   HJlUOSxp1mtntVPVB4egvbXj3pCaGcah4pyBbasWaLxkK3+TjRlpjuAQT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="421576443"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="421576443"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 11:52:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="1004944401"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="1004944401"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Mar 2023 11:52:04 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYXvI-0002KP-0q;
        Sat, 04 Mar 2023 19:52:04 +0000
Date:   Sun, 5 Mar 2023 03:51:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Asmaa Mnebhi <asmaa@nvidia.com>
Subject: Re: [PATCH v3] gpio: mmio: handle "ngpios" properly in bgpio_init()
Message-ID: <202303050354.HH9DhJsr-lkp@intel.com>
References: <20230303215814.24783-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303215814.24783-1-asmaa@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Asmaa,

I love your patch! Yet something to improve:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.2 next-20230303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Asmaa-Mnebhi/gpio-mmio-handle-ngpios-properly-in-bgpio_init/20230304-061731
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230303215814.24783-1-asmaa%40nvidia.com
patch subject: [PATCH v3] gpio: mmio: handle "ngpios" properly in bgpio_init()
config: x86_64-randconfig-c002 (https://download.01.org/0day-ci/archive/20230305/202303050354.HH9DhJsr-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3a5c9651e99e80b10d5b205d9860c131bf90b3bc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Asmaa-Mnebhi/gpio-mmio-handle-ngpios-properly-in-bgpio_init/20230304-061731
        git checkout 3a5c9651e99e80b10d5b205d9860c131bf90b3bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303050354.HH9DhJsr-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "gpiochip_get_ngpios" [drivers/gpio/gpio-generic.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
