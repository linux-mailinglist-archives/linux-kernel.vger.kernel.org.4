Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ECE6774FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 06:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAWFmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 00:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWFmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 00:42:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC412052;
        Sun, 22 Jan 2023 21:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674452522; x=1705988522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D5ZVsnzfS0IsUQd28/HSjk63wo2zAOeT9wlqvkhHaLk=;
  b=gngYeTsOvVuR7oDHOiRpm+7k+kYxE9OCovy0cNpnIbqqT1U0PxSTGDD7
   4GsCEzrg5ntTWmTK93FiynDz4dAbGhzU/cCJFgFbaSg2ViKUTgTVWw3YE
   KqRUfJ38oEi27ckzhRM2oXcW6DzkpC5L7IPPtrWuL7D/KmovtjbAbqLnT
   dMXfOTrNUEjLHHLjqO1NOQ0IWJ+IORg1P5FsLIuhq0HMxbQxXFSTMN+yZ
   M3AyawXgv1MMjoYdTlmE+BImfEZta8Vau+M12FMxV6Tr5P7gaGQU4NDbh
   iRaT+unebekxJNaYcddbwhwl0KSaeD1zQMP/vBEfEuVolXxsvEx2+mXc8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="353237163"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="353237163"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 21:42:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="730054622"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="730054622"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jan 2023 21:41:58 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJpaf-0005S0-21;
        Mon, 23 Jan 2023 05:41:57 +0000
Date:   Mon, 23 Jan 2023 13:41:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Kaher <akaher@vmware.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 1/8] eventfs: introducing struct tracefs_inode
Message-ID: <202301231320.vExYuIWP-lkp@intel.com>
References: <1674407228-49109-1-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674407228-49109-1-git-send-email-akaher@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ajay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
patch link:    https://lore.kernel.org/r/1674407228-49109-1-git-send-email-akaher%40vmware.com
patch subject: [PATCH 1/8] eventfs: introducing struct tracefs_inode
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230123/202301231320.vExYuIWP-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/926ba0e4029baa4bbc7c283854148d1769642d50
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
        git checkout 926ba0e4029baa4bbc7c283854148d1769642d50
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/tracefs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/tracefs/inode.c:130:15: warning: no previous prototype for function 'tracefs_get_inode' [-Wmissing-prototypes]
   struct inode *tracefs_get_inode(struct super_block *sb)
                 ^
   fs/tracefs/inode.c:130:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct inode *tracefs_get_inode(struct super_block *sb)
   ^
   static 
>> fs/tracefs/inode.c:402:16: warning: no previous prototype for function 'tracefs_start_creating' [-Wmissing-prototypes]
   struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
                  ^
   fs/tracefs/inode.c:402:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
   ^
   static 
>> fs/tracefs/inode.c:440:16: warning: no previous prototype for function 'tracefs_failed_creating' [-Wmissing-prototypes]
   struct dentry *tracefs_failed_creating(struct dentry *dentry)
                  ^
   fs/tracefs/inode.c:440:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct dentry *tracefs_failed_creating(struct dentry *dentry)
   ^
   static 
>> fs/tracefs/inode.c:448:16: warning: no previous prototype for function 'tracefs_end_creating' [-Wmissing-prototypes]
   struct dentry *tracefs_end_creating(struct dentry *dentry)
                  ^
   fs/tracefs/inode.c:448:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct dentry *tracefs_end_creating(struct dentry *dentry)
   ^
   static 
   4 warnings generated.


vim +/tracefs_get_inode +130 fs/tracefs/inode.c

   129	
 > 130	struct inode *tracefs_get_inode(struct super_block *sb)
   131	{
   132		struct inode *inode = new_inode(sb);
   133		if (inode) {
   134			inode->i_ino = get_next_ino();
   135			inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
   136		}
   137		return inode;
   138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
