Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172AC6C5CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjCWCiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCWCiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:38:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897A3590
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679539087; x=1711075087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NVzhAprKO7gzBk6TU2LvPqa0tyYsN5S2OZgjE9c3DBU=;
  b=RgHonZSU76p60iz1b3M+NAewSR0DwNRwpAzKzA7meynMgyOUbCMyLF/s
   ViB7DyCM5s3bNxFq14q7nVvr8vf8lkH1FdnDC8KBgAxJrU+TBnpUAy3+4
   mspOpvIdbtlEphjyRcOEZ2RZ1AlVJP8UYwDIbVfC7oYo9sfCkl1VtiY62
   tpmsG/eaaKWdQCg+0kb/Q33D1wDp2I4B4L6uqGLWSe/wdoXDOhoBGlUJ8
   AgplqdeTnMNh+LCJPmY7Dzlrn0rOmKx/t/wmb3yz2KxTpCghmt7GrzzuD
   IEIYkkq1J6/O/df13zQQl6Ejv02/mXjRxFb1b1k013THMPmks9pU3Yaui
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="338099618"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="338099618"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 19:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="712490028"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="712490028"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Mar 2023 19:38:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfAq5-000Dry-0L;
        Thu, 23 Mar 2023 02:38:05 +0000
Date:   Thu, 23 Mar 2023 10:37:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, chao@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yohan Joung <jyh429@gmail.com>
Subject: Re: [PATCH] f2fs: fix align check for npo2
Message-ID: <202303231039.GKLRE8O5-lkp@intel.com>
References: <20230322131408.1192-1-jyh429@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322131408.1192-1-jyh429@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yohan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yohan-Joung/f2fs-fix-align-check-for-npo2/20230322-211529
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20230322131408.1192-1-jyh429%40gmail.com
patch subject: [PATCH] f2fs: fix align check for npo2
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230323/202303231039.GKLRE8O5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3531dd5850533df89bd45af9fd59ed4693d6d5aa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yohan-Joung/f2fs-fix-align-check-for-npo2/20230322-211529
        git checkout 3531dd5850533df89bd45af9fd59ed4693d6d5aa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303231039.GKLRE8O5-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [fs/f2fs/f2fs.ko] undefined!
>> ERROR: modpost: "__moddi3" [fs/f2fs/f2fs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
