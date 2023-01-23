Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD42967750B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjAWGCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjAWGCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:02:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A07515CBA;
        Sun, 22 Jan 2023 22:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674453724; x=1705989724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=638MAC3PNtpu0Ly4xhpR+s6gvRZbbYi08Qk930tyD7Q=;
  b=DckYnFLcVfIDHeBNvBZOrCJVJNa/K5o1JC1Nl+yDaBVBeKPFCKYuluaZ
   HeDdjfpsCmXU3h5tWA1ouZb9MnqeHxFeFplp4+JtfaQohotZRP9AsoFrO
   RVWMK/iBS5lL6QdtZypXbaZiPHhsD8eOpQxiVynBEBxPqlMXox2xvYvfX
   URTnZfua8S/rAO8mKLuSPqZLtY/XmbM7zH4SA7dWygXQl2vZqcdD4YnNm
   em9xVFYeG5b+cOEoo133aXyTMorErGGXGHZXsXbA0IIesEQ3Xa0lYAll8
   PL9lS74poeY0gmkme7s6X/SktKjXRFWUqB7fglIqPy1/BJ0JkHPpWQBVf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="313872317"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="313872317"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 22:02:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="835355242"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="835355242"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Jan 2023 22:01:59 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJpu2-0005Sc-0S;
        Mon, 23 Jan 2023 06:01:58 +0000
Date:   Mon, 23 Jan 2023 14:01:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Kaher <akaher@vmware.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 1/8] eventfs: introducing struct tracefs_inode
Message-ID: <202301231332.yy4fecm8-lkp@intel.com>
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
[also build test WARNING on v6.2-rc5 next-20230120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
patch link:    https://lore.kernel.org/r/1674407228-49109-1-git-send-email-akaher%40vmware.com
patch subject: [PATCH 1/8] eventfs: introducing struct tracefs_inode
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20230123/202301231332.yy4fecm8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/926ba0e4029baa4bbc7c283854148d1769642d50
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
        git checkout 926ba0e4029baa4bbc7c283854148d1769642d50
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/tracefs/inode.c:130:15: warning: no previous prototype for 'tracefs_get_inode' [-Wmissing-prototypes]
     130 | struct inode *tracefs_get_inode(struct super_block *sb)
         |               ^~~~~~~~~~~~~~~~~
>> fs/tracefs/inode.c:402:16: warning: no previous prototype for 'tracefs_start_creating' [-Wmissing-prototypes]
     402 | struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
         |                ^~~~~~~~~~~~~~~~~~~~~~
>> fs/tracefs/inode.c:440:16: warning: no previous prototype for 'tracefs_failed_creating' [-Wmissing-prototypes]
     440 | struct dentry *tracefs_failed_creating(struct dentry *dentry)
         |                ^~~~~~~~~~~~~~~~~~~~~~~
>> fs/tracefs/inode.c:448:16: warning: no previous prototype for 'tracefs_end_creating' [-Wmissing-prototypes]
     448 | struct dentry *tracefs_end_creating(struct dentry *dentry)
         |                ^~~~~~~~~~~~~~~~~~~~


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
