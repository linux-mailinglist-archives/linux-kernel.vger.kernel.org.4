Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBBA6A2934
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBYLEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjBYLEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:04:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4C166F3;
        Sat, 25 Feb 2023 03:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677323070; x=1708859070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SJ8d7/b+hm/w2Rgg1CF8/KUOveDmnjsrQ2mqW2c99HA=;
  b=fZX5NUCGzgPgRhg8Ouc9FjsONhMtgy0bDU5a21zELgakipmDda8Ulanx
   oOmFhXWtu+evHQxLi2cjjMOGd16MvOLFon3hSMbMkbQ9VWwa31/sCh+zg
   q3deJCCplQspRl6U8OtFXrndyALGZBEIYaPDGT7zEgFaG+BFbhrKuFbse
   XEshQfWP82pEbdKsf+tJzb1WoMZ+IaIZJnBYujZKRPYbqFs3qKj7JmxtA
   vmZDbDaph+LiyvTMFICCfWjRhQwmzGvDKiy72nMbloOKzIfjGswbR9ndL
   Q/TzNe8eZ9XguwAoQGTuhtEma2e82IX8BanpEPJQymJbnujYyYu9ZkOAW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="335086384"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="335086384"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 03:04:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="703466849"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="703466849"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2023 03:04:27 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVsLq-00038R-39;
        Sat, 25 Feb 2023 11:04:26 +0000
Date:   Sat, 25 Feb 2023 19:03:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Armin Wolf <W_Armin@gmx.de>, rafael@kernel.org, lenb@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ACPI: EC: Make query handlers private
Message-ID: <202302251803.g3ubvi2K-lkp@intel.com>
References: <20230225080458.1342359-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225080458.1342359-4-W_Armin@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.2 next-20230225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Armin-Wolf/ACPI-EC-Add-query-notifier-support/20230225-160641
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230225080458.1342359-4-W_Armin%40gmx.de
patch subject: [PATCH 3/4] ACPI: EC: Make query handlers private
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20230225/202302251803.g3ubvi2K-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a62cb9e29bf040af617070fa775758720d2de12e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Armin-Wolf/ACPI-EC-Add-query-notifier-support/20230225-160641
        git checkout a62cb9e29bf040af617070fa775758720d2de12e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302251803.g3ubvi2K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/ec.c:1083:5: warning: no previous prototype for function 'acpi_ec_add_query_handler' [-Wmissing-prototypes]
   int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit, acpi_handle handle)
       ^
   drivers/acpi/ec.c:1083:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit, acpi_handle handle)
   ^
   static 
   1 warning generated.


vim +/acpi_ec_add_query_handler +1083 drivers/acpi/ec.c

  1082	
> 1083	int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit, acpi_handle handle)
  1084	{
  1085		struct acpi_ec_query_handler *handler =
  1086		    kzalloc(sizeof(struct acpi_ec_query_handler), GFP_KERNEL);
  1087	
  1088		if (!handler)
  1089			return -ENOMEM;
  1090	
  1091		handler->query_bit = query_bit;
  1092		handler->handle = handle;
  1093		mutex_lock(&ec->mutex);
  1094		kref_init(&handler->kref);
  1095		list_add(&handler->node, &ec->list);
  1096		mutex_unlock(&ec->mutex);
  1097		return 0;
  1098	}
  1099	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
