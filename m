Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C291F677763
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjAWJ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:27:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF071EFEF;
        Mon, 23 Jan 2023 01:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674466027; x=1706002027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NpUqyU6biI7wZgPzFh9DchqCbpASiYwHtB7RD6JPEm8=;
  b=hgsM4aUCww8Nu/d5Q6nqPGG/IrIlKsBwh9rhfkOFX3jkl3YVHVlDuDQv
   SyO0wkFzkRuzh3KfrzPWsHhrVmqamcFDZsKC44clCCYFaANZ2Ew9mjGuU
   8llz0P7dioq+N3CG1yuiU0IiBZF0XGGwHX7v8MagCnnVhwfWH6/9xQMeV
   xp3/7D/6mIvyMK4zdWHeJsjaqpcn/QMt2J559NQrpEO0YRemCVUf1faVA
   HsVRUZEwgeUmOVczgoE0kqQ/ovpTyVRNacC/4utOPfjp82d6h43AGJ75b
   x7r6ezwOMpJGcADOsi0zZw03PvDzRqge2M3r5L6SAzYdYxdaDzFai9Sog
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="313897170"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="313897170"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 01:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="804024045"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="804024045"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2023 01:27:03 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJt6U-0005Ya-2V;
        Mon, 23 Jan 2023 09:27:02 +0000
Date:   Mon, 23 Jan 2023 17:26:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Kaher <akaher@vmware.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 5/8] eventfs: adding functions to create eventfs files
 and directories
Message-ID: <202301231745.XMv1eJAp-lkp@intel.com>
References: <1674407228-49109-5-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674407228-49109-5-git-send-email-akaher@vmware.com>
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
[also build test WARNING on v6.2-rc5 next-20230123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
patch link:    https://lore.kernel.org/r/1674407228-49109-5-git-send-email-akaher%40vmware.com
patch subject: [PATCH 5/8] eventfs: adding functions to create eventfs files and directories
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20230123/202301231745.XMv1eJAp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/950ac8561471b622eac5555b4a7502bcd8c20663
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
        git checkout 950ac8561471b622eac5555b4a7502bcd8c20663
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/tracefs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> fs/tracefs/event_inode.c:48:15: sparse: sparse: symbol 'eventfs_create_file' was not declared. Should it be static?
>> fs/tracefs/event_inode.c:117:15: sparse: sparse: symbol 'eventfs_create_dir' was not declared. Should it be static?
   fs/tracefs/event_inode.c:162:31: sparse: sparse: symbol 'eventfs_root_dir_inode_operations' was not declared. Should it be static?

vim +/eventfs_create_file +48 fs/tracefs/event_inode.c

    23	
    24	/**
    25	 * eventfs_create_file - create a file in the tracefs filesystem
    26	 * @name: a pointer to a string containing the name of the file to create.
    27	 * @mode: the permission that the file should have.
    28	 * @parent: a pointer to the parent dentry for this file.  This should be a
    29	 *          directory dentry if set.  If this parameter is NULL, then the
    30	 *          file will be created in the root of the tracefs filesystem.
    31	 * @data: a pointer to something that the caller will want to get to later
    32	 *        on.  The inode.i_private pointer will point to this value on
    33	 *        the open() call.
    34	 * @fops: a pointer to a struct file_operations that should be used for
    35	 *        this file.
    36	 *
    37	 * This is the basic "create a file" function for tracefs.  It allows for a
    38	 * wide range of flexibility in creating a file.
    39	 *
    40	 * This function will return a pointer to a dentry if it succeeds.  This
    41	 * pointer must be passed to the tracefs_remove() function when the file is
    42	 * to be removed (no automatic cleanup happens if your module is unloaded,
    43	 * you are responsible here.)  If an error occurs, %NULL will be returned.
    44	 *
    45	 * If tracefs is not enabled in the kernel, the value -%ENODEV will be
    46	 * returned.
    47	 */
  > 48	struct dentry *eventfs_create_file(const char *name, umode_t mode,
    49					   struct dentry *parent, void *data,
    50					   const struct file_operations *fop,
    51					   bool anon)
    52	{
    53		struct tracefs_inode *ti;
    54		struct dentry *dentry;
    55		struct inode *inode;
    56	
    57		if (security_locked_down(LOCKDOWN_TRACEFS))
    58			return NULL;
    59	
    60		if (!(mode & S_IFMT))
    61			mode |= S_IFREG;
    62	
    63		if (WARN_ON_ONCE(!S_ISREG(mode)))
    64			return NULL;
    65	
    66		dentry = eventfs_start_creating(name, parent);
    67	
    68		if (IS_ERR(dentry))
    69			return dentry;
    70	
    71		inode = tracefs_get_inode(dentry->d_sb);
    72		if (unlikely(!inode))
    73			return eventfs_failed_creating(dentry);
    74	
    75		inode->i_mode = mode;
    76		inode->i_fop = fop;
    77		inode->i_private = data;
    78	
    79		ti = get_tracefs(inode);
    80		ti->flags |= TRACEFS_EVENT_INODE;
    81	
    82		if (anon)
    83			d_instantiate_anon(dentry, inode);
    84		else
    85			d_instantiate(dentry, inode);
    86	
    87		fsnotify_create(dentry->d_parent->d_inode, dentry);
    88		return eventfs_end_creating(dentry);
    89	}
    90	
    91	/**
    92	 * eventfs_create_dir - create a dir in the tracefs filesystem
    93	 * @name: a pointer to a string containing the name of the file to create.
    94	 * @mode: the permission that the file should have.
    95	 * @parent: a pointer to the parent dentry for this file.  This should be a
    96	 *          directory dentry if set.  If this parameter is NULL, then the
    97	 *          file will be created in the root of the tracefs filesystem.
    98	 * @data: a pointer to something that the caller will want to get to later
    99	 *        on.  The inode.i_private pointer will point to this value on
   100	 *        the open() call.
   101	 * @fop: a pointer to a struct file_operations that should be used for
   102	 *        this dir.
   103	 * @iop: a pointer to a struct inode_operations that should be used for
   104	 *        this dir.
   105	 *
   106	 * This is the basic "create a dir" function for eventfs.  It allows for a
   107	 * wide range of flexibility in creating a dir.
   108	 *
   109	 * This function will return a pointer to a dentry if it succeeds.  This
   110	 * pointer must be passed to the tracefs_remove() function when the file is
   111	 * to be removed (no automatic cleanup happens if your module is unloaded,
   112	 * you are responsible here.)  If an error occurs, %NULL will be returned.
   113	 *
   114	 * If tracefs is not enabled in the kernel, the value -%ENODEV will be
   115	 * returned.
   116	 */
 > 117	struct dentry *eventfs_create_dir(const char *name, umode_t mode,
   118					  struct dentry *parent, void *data,
   119					  const struct file_operations *fop,
   120					  const struct inode_operations *iop,
   121					  bool anon)
   122	{
   123		struct tracefs_inode *ti;
   124		struct dentry *dentry;
   125		struct inode *inode;
   126	
   127		if (security_locked_down(LOCKDOWN_TRACEFS))
   128			return NULL;
   129	
   130		WARN_ON(!S_ISDIR(mode));
   131	
   132		dentry = eventfs_start_creating(name, parent);
   133	
   134		if (IS_ERR(dentry))
   135			return dentry;
   136	
   137		inode = tracefs_get_inode(dentry->d_sb);
   138		if (unlikely(!inode))
   139			return eventfs_failed_creating(dentry);
   140	
   141		inode->i_mode = mode;
   142		inode->i_op = iop;
   143		inode->i_fop = fop;
   144		inode->i_private = data;
   145	
   146		ti = get_tracefs(inode);
   147		ti->flags |= TRACEFS_EVENT_INODE;
   148	
   149		inc_nlink(inode);
   150		if (anon)
   151			d_instantiate_anon(dentry, inode);
   152		else
   153			d_instantiate(dentry, inode);
   154		inc_nlink(dentry->d_parent->d_inode);
   155		fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
   156		return eventfs_end_creating(dentry);
   157	}
   158	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
