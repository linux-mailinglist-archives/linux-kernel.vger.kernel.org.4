Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA36B401B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCJNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCJNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:19:32 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B295F5A9E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678454363; x=1709990363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=URhNDBxHeyF0aDn2NfxI0fkuymmPtaAJHCBOdeArdO4=;
  b=Im244CfK5oVNjWLUtrIn4HigtV3vlECW4xERLlmpuJmZWBRpY0fg87Mz
   Wg1VAf1Zj7D7+wUdGcDVdaaQ6bLyaNW/go9qkWRMY3SktZ75zhSRMtr8H
   j61Hq+l53CLvcXrM/vk7wdgPzG1obbVlgh8OrTzTOMYHjXzf0IN1pJwar
   hXtALjOo/4qdWMJGTAUpv/rYBu7Y4m6XHJi5oiYm+CniXF2eFa8wO/Qeg
   53sKXZwrKZxDne4ZxA0xjnHBoJsDqNOAHm4JDIhS6+EQGj0acSyaDGpNO
   BdPx1vogTMUNv7ypso2h90XnKfXivybJvCsdl7IFXsPIkxYN1TDCcEHGB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="325075156"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="325075156"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 05:19:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="1007117205"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="1007117205"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2023 05:19:20 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paceV-0003sf-12;
        Fri, 10 Mar 2023 13:19:19 +0000
Date:   Fri, 10 Mar 2023 21:18:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yangtao Li <frank.li@vivo.com>,
        almaz.alexandrovich@paragon-software.com, jack@suse.com,
        dushistov@mail.ru, brauner@kernel.org, ntfs3@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 1/3] fs/ntfs3: use wrapper i_blocksize() in
 ntfs_zero_range()
Message-ID: <202303102147.wS2pINMw-lkp@intel.com>
References: <20230310030821.66090-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310030821.66090-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

I love your patch! Yet something to improve:

[auto build test ERROR on jack-fs/for_next]
[also build test ERROR on vfs-idmapping/for-next linus/master v6.3-rc1]
[cannot apply to next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yangtao-Li/udf-use-wrapper-i_blocksize-in-udf_discard_prealloc/20230310-110943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
patch link:    https://lore.kernel.org/r/20230310030821.66090-1-frank.li%40vivo.com
patch subject: [PATCH 1/3] fs/ntfs3: use wrapper i_blocksize() in ntfs_zero_range()
config: arc-randconfig-r022-20230310 (https://download.01.org/0day-ci/archive/20230310/202303102147.wS2pINMw-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/01c0c800dc0c15141eb3cb9d9e66cfc8b001be70
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yangtao-Li/udf-use-wrapper-i_blocksize-in-udf_discard_prealloc/20230310-110943
        git checkout 01c0c800dc0c15141eb3cb9d9e66cfc8b001be70
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303102147.wS2pINMw-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__divdi3" [fs/ntfs3/ntfs3.ko] undefined!
ERROR: modpost: "__st_r13_to_r22" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r17" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r21_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r19_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r22_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r25" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r24" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r17_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r21" [lib/zstd/zstd_decompress.ko] undefined!
WARNING: modpost: suppressed 6 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
