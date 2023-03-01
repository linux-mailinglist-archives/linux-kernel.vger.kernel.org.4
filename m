Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65C16A7720
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCAWxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAWxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:53:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B64F1B2E3;
        Wed,  1 Mar 2023 14:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677711226; x=1709247226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TbdI4Y4Wwsm9UOJ+PB3HFSYFJE1MwNlUpSEMRYtwwsg=;
  b=Z6wIdYGrJkI7l8ASPmJ+GedPxjowkV2QHRjTRjF/YRJDl2hzguj3zB/z
   Q2ePOQzudSK1dHUcm7XIetaEveePrAHNHjTjT7frM1nadJTdV2/DnlK/J
   KTBDaAlN+Ilpa6w46fhOJcuiuVrNzhK5iVcwhqCLkZnoXD9v0v0Oj2fXz
   wSFLay4LbNrJXLqlL7RSA/niLPzjzcTN8rpSIfqITMml8LoAJtOMkG3jA
   o8Jt4rYXikM2Iwa17AF0LzHGSXkqLFOhhoj7g0WlJoU+gj0rXlBO/5KMH
   q67ZyCJyCaNTYC8nDhs8pOkj4HZfRtrf0b2g2+S/7kJg+r0AZBFZCWFWo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="362129302"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="362129302"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 14:53:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674730270"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="674730270"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2023 14:53:38 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXVKL-0006Th-0z;
        Wed, 01 Mar 2023 22:53:37 +0000
Date:   Thu, 2 Mar 2023 06:53:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@redhat.com, dipenp@nvidia.com, treding@nvidia.com,
        mwen@igalia.com, fmdefrancesco@gmail.com, arnd@arndb.de,
        bvanassche@acm.org, ogabbay@kernel.org, axboe@kernel.dk,
        mathieu.poirier@linaro.org, linux@zary.sk, masahiroy@kernel.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        jacek.lawrynowicz@linux.intel.com, benjamin.tissoires@redhat.com,
        devicetree@vger.kernel.org, furong.zhou@linux.intel.com,
        andriy.shevchenko@intel.com, linus.walleij@linaro.org,
        Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Subject: Re: [PATCHv3 2/4] wiegand: add Wiegand bus driver
Message-ID: <202303020615.0F00suDa-lkp@intel.com>
References: <20230301142835.19614-3-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301142835.19614-3-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.2 next-20230301]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230301-223030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230301142835.19614-3-m.zatovic1%40gmail.com
patch subject: [PATCHv3 2/4] wiegand: add Wiegand bus driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230302/202303020615.0F00suDa-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c62b833f42989e355d82cd20b7803e0228e33792
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230301-223030
        git checkout c62b833f42989e355d82cd20b7803e0228e33792
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/wiegand/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303020615.0F00suDa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/wiegand/wiegand.c:441:27: error: initialization of 'void (*)(struct device *)' from incompatible pointer type 'int (*)(struct device *)' [-Werror=incompatible-pointer-types]
     441 |         .remove         = wiegand_remove,
         |                           ^~~~~~~~~~~~~~
   drivers/wiegand/wiegand.c:441:27: note: (near initialization for 'wiegand_bus_type.remove')
   cc1: some warnings being treated as errors


vim +441 drivers/wiegand/wiegand.c

   436	
   437	static struct bus_type wiegand_bus_type = {
   438		.name		= "wiegand",
   439		.match		= wiegand_match_device,
   440		.probe		= wiegand_probe,
 > 441		.remove		= wiegand_remove,
   442	};
   443	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
