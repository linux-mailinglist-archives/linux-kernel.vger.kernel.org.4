Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED136A2924
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 11:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBYKxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 05:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 05:53:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AD21116B;
        Sat, 25 Feb 2023 02:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677322409; x=1708858409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rd7RPhOXUD6kBL2olbEMUTmKckQZD9AWml1PToeRMq8=;
  b=m5JRShGvSwxdGdYQg6rqHtM+zn2WahgFtNUVj4y0rGkNHj7DVdGUgaM9
   tzelMrwgohsCcfvt98vcHGWKrTmY+MXupjlVpKk/v3rSreqXbqy7q4kRP
   VZHPs5nlZzkiAFfAvMzl3kkQxAZN00wg4rI16fSAAFGOXKL6Jl/JgnLWn
   IbCnO03W4oJFwR+RtGWvhjUD+jyPpW8Q7lkyw3bhJbYsfbxu57hPfrtX1
   jrmNbLIpSzVRG8AP2YuasHUkBiMIr9yVeZ+QdCfuZiwoj6kPxI03JW8no
   SbAX07DYVZY3ufsCZ/B/zHAJhDxwPGMvDp8/gakO0dOB+ku+B1ZzuouSK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="333658384"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="333658384"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 02:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="741922508"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="741922508"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Feb 2023 02:53:27 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVsBC-00037r-1o;
        Sat, 25 Feb 2023 10:53:26 +0000
Date:   Sat, 25 Feb 2023 18:53:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Armin Wolf <W_Armin@gmx.de>, rafael@kernel.org, lenb@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ACPI: EC: Make query handlers private
Message-ID: <202302251843.r0u8s41s-lkp@intel.com>
References: <20230225080458.1342359-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225080458.1342359-4-W_Armin@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20230225/202302251843.r0u8s41s-lkp@intel.com/config)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202302251843.r0u8s41s-lkp@intel.com/

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
