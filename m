Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2826CDC89
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjC2O2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjC2O1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:27:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F145C9EDF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680099657; x=1711635657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oLLT1aUrndTTg1LEVUXifWMAK6vq4Cgd7hs41b0j2og=;
  b=O6BBhLlCu6K5tSbFYKEXewiUq4PJCkfimQutroI7UpMaCijHs0W5H6fu
   yAdO5apLNMXcxBz8MvYugU9Oc9NzZAoWN3o4QC6AnXgQAwm+VC+buxId2
   GoV7bcDUl8/ozxPNsYL+TAP/A5d8yXtvCdv4E+wABPxu869SsnJn+rHsK
   vWMAvHn1QK3Il+Cf7grQra53RkRcY39cqJ2rtOyymrUi3r4vybgQ2aJGl
   LhaPvG0lnqmOla2QmGUFsmmReaBz1rEXIrfETKEonk8IXcwtDykfS+Dm2
   F8bLfRVmgTaszf35G7u4yFBmXJ9/tZW/nFBZ+/zypikD9NEbwGYIoZT0R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="324792155"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="324792155"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="795248317"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="795248317"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2023 07:18:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phWda-000JcS-0D;
        Wed, 29 Mar 2023 14:18:54 +0000
Date:   Wed, 29 Mar 2023 22:17:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: Re: [PATCH v3 4/4] sched/psi: allow unprivileged polling of N*2s
 period
Message-ID: <202303292236.ZXnVaVZr-lkp@intel.com>
References: <20230329074842.16209-5-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329074842.16209-5-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Domenico,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tj-cgroup/for-next vfs-idmapping/for-next linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Domenico-Cerasuolo/sched-psi-rearrange-polling-code-in-preparation/20230329-155205
patch link:    https://lore.kernel.org/r/20230329074842.16209-5-cerasuolodomenico%40gmail.com
patch subject: [PATCH v3 4/4] sched/psi: allow unprivileged polling of N*2s period
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20230329/202303292236.ZXnVaVZr-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6c9f1219e1ccea05926017b359e41bfff24e9bd9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Domenico-Cerasuolo/sched-psi-rearrange-polling-code-in-preparation/20230329-155205
        git checkout 6c9f1219e1ccea05926017b359e41bfff24e9bd9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303292236.ZXnVaVZr-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:97:
>> kernel/sched/psi.c:1602:9: error: implicit declaration of function 'psi_open' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return psi_open(file, psi_irq_show);
                  ^
   1 error generated.


vim +/psi_open +1602 kernel/sched/psi.c

52b1364ba0b105 Chengming Zhou 2022-08-26  1599  
52b1364ba0b105 Chengming Zhou 2022-08-26  1600  static int psi_irq_open(struct inode *inode, struct file *file)
52b1364ba0b105 Chengming Zhou 2022-08-26  1601  {
52b1364ba0b105 Chengming Zhou 2022-08-26 @1602  	return psi_open(file, psi_irq_show);
52b1364ba0b105 Chengming Zhou 2022-08-26  1603  }
52b1364ba0b105 Chengming Zhou 2022-08-26  1604  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
