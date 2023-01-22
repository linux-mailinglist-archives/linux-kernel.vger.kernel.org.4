Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0948677212
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjAVTiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVTio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:38:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136E51B564;
        Sun, 22 Jan 2023 11:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674416323; x=1705952323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BZM7vuH6STT3Ve/rMwCUnlQwbdmg0Mjjxx28NFQhJNU=;
  b=SqYyBrKEMMSDtr0Rub0p/OENPyWmLWOp1qP0f7qT44iG1DNSboIhykBP
   cddtLTNrRWlv1o8aKbAgEWTc/vbQLCdOgETo68dXAJFlGd3B9IFF0wxvf
   Bo5IOAiILkXhPH0/pTQ7lm37KFRP82lHwvgC+6ais2Gdp1PukTSuvJgzO
   IbSJz0tf195gQWGfY9Ms/n15MQTd+/gsJP4lmM27Q00BAg/mLo1OrPJpm
   +99mkLWj8++2Gs9KiQMfTXUQUDOvxl3H7cwzVfo1LCH3CdTUzjxj2n8H+
   /4m0dZCczKarYynO7RRosKR0aEjL4uzvDny3wF7m53t+O7GfVL4PqeENl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="328022452"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="328022452"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 11:38:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="724809546"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="724809546"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jan 2023 11:38:38 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJgAm-0005Cq-3D;
        Sun, 22 Jan 2023 19:38:36 +0000
Date:   Mon, 23 Jan 2023 03:38:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Kaher <akaher@vmware.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 6/8] eventfs: adding eventfs lookup, read, open functions
Message-ID: <202301230340.oZWnhDJu-lkp@intel.com>
References: <1674407228-49109-6-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674407228-49109-6-git-send-email-akaher@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
patch link:    https://lore.kernel.org/r/1674407228-49109-6-git-send-email-akaher%40vmware.com
patch subject: [PATCH 6/8] eventfs: adding eventfs lookup, read, open functions
config: arc-defconfig (https://download.01.org/0day-ci/archive/20230123/202301230340.oZWnhDJu-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bdfb24dc39f183eda75dc7c6ad54798181ad4a94
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
        git checkout bdfb24dc39f183eda75dc7c6ad54798181ad4a94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/tracefs/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/tracefs/event_inode.c:48:16: warning: no previous prototype for 'eventfs_create_file' [-Wmissing-prototypes]
      48 | struct dentry *eventfs_create_file(const char *name, umode_t mode,
         |                ^~~~~~~~~~~~~~~~~~~
   fs/tracefs/event_inode.c:117:16: warning: no previous prototype for 'eventfs_create_dir' [-Wmissing-prototypes]
     117 | struct dentry *eventfs_create_dir(const char *name, umode_t mode,
         |                ^~~~~~~~~~~~~~~~~~
>> fs/tracefs/event_inode.c:192:6: warning: no previous prototype for 'eventfs_post_create_dir' [-Wmissing-prototypes]
     192 | void eventfs_post_create_dir(struct eventfs_file *ef)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> fs/tracefs/event_inode.c:291:5: warning: no previous prototype for 'dcache_dir_open_wrapper' [-Wmissing-prototypes]
     291 | int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/eventfs_post_create_dir +192 fs/tracefs/event_inode.c

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
   117	struct dentry *eventfs_create_dir(const char *name, umode_t mode,
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
   159	/**
   160	 * eventfs_set_ef_status_free - set the ef->status to free
   161	 * @dentry: dentry who's status to be freed
   162	 *
   163	 * eventfs_set_ef_status_free will be called if no more
   164	 * reference remains
   165	 */
   166	void eventfs_set_ef_status_free(struct dentry *dentry)
   167	{
   168		struct tracefs_inode *ti_parent;
   169		struct eventfs_inode *ei_parent;
   170		struct eventfs_file *ef;
   171	
   172		ti_parent = get_tracefs(dentry->d_parent->d_inode);
   173		if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
   174			return;
   175		ei_parent = ti_parent->private;
   176	
   177		list_for_each_entry(ef, &ei_parent->e_top_files, list) {
   178			if (!strcmp(ef->name, dentry->d_name.name)) {
   179				ef->created = false;
   180				ef->dentry = NULL;
   181				break;
   182			}
   183		}
   184	}
   185	
   186	/**
   187	 * eventfs_post_create_dir - post create dir routine
   188	 * @eventfs_file: eventfs_file of recently created dir
   189	 *
   190	 * Files with-in eventfs dir should know dentry of parent dir
   191	 */
 > 192	void eventfs_post_create_dir(struct eventfs_file *ef)
   193	{
   194		struct eventfs_file *ef_child;
   195		struct tracefs_inode *ti;
   196	
   197		/* fill parent-child relation */
   198		list_for_each_entry(ef_child, &ef->ei->e_top_files, list) {
   199			ef_child->d_parent = ef->dentry;
   200		}
   201	
   202		ti = get_tracefs(ef->dentry->d_inode);
   203		ti->private = ef->ei;
   204	}
   205	
   206	/**
   207	 * eventfs_root_lookup - lookup routine to create file/dir
   208	 * @dir: directory in which lookup to be done
   209	 * @dentry: file/dir dentry
   210	 * @flags:
   211	 *
   212	 * Used to create dynamic file/dir with-in @dir, search with-in ei
   213	 * list, if @dentry found go ahead and create the file/dir
   214	 */
   215	
   216	static struct dentry *eventfs_root_lookup(struct inode *dir,
   217						  struct dentry *dentry,
   218						  unsigned int flags)
   219	{
   220		struct tracefs_inode *ti;
   221		struct eventfs_inode *ei;
   222		struct eventfs_file *ef;
   223		struct dentry *ret = simple_lookup(dir, dentry, flags);
   224	
   225		ti = get_tracefs(dir);
   226		if (!(ti->flags & TRACEFS_EVENT_INODE))
   227			return NULL;
   228	
   229		ei = ti->private;
   230		list_for_each_entry(ef, &ei->e_top_files, list) {
   231			if (strcmp(ef->name, dentry->d_name.name))
   232				continue;
   233	
   234			if(ef->created)
   235				continue;
   236	
   237			ef->created = true;
   238	
   239			if (ef->ei)
   240				ef->dentry = eventfs_create_dir(ef->name, ef->mode, ef->d_parent,
   241								ef->data, ef->fop, ef->iop, 0);
   242			else
   243				ef->dentry = eventfs_create_file(ef->name, ef->mode, ef->d_parent,
   244								 ef->data, ef->fop, 0);
   245	
   246			if (IS_ERR_OR_NULL(ef->dentry)) {
   247					ef->created = false;
   248			} else {
   249				if (ef->ei)
   250					eventfs_post_create_dir(ef);
   251				ef->dentry->d_fsdata = ef;
   252				dput(ef->dentry);
   253			}
   254			break;
   255		}
   256		return ret;
   257	}
   258	
   259	/**
   260	 * eventfs_release - called to release eventfs file/dir
   261	 * @inode: inode to be released
   262	 * @file: file to be released (not used)
   263	 */
   264	static int eventfs_release(struct inode *inode, struct file *file)
   265	{
   266		struct tracefs_inode *ti;
   267		struct eventfs_inode *ei;
   268		struct eventfs_file *ef;
   269	
   270		ti = get_tracefs(inode);
   271		if (!(ti->flags & TRACEFS_EVENT_INODE))
   272			return -EINVAL;
   273	
   274		ei = ti->private;
   275		list_for_each_entry(ef, &ei->e_top_files, list) {
   276			if (ef->created)
   277				dput(ef->dentry);
   278		}
   279		return dcache_dir_close(inode, file);
   280	}
   281	
   282	/**
   283	 * dcache_dir_open_wrapper - eventfs open wrapper
   284	 * @inode: not used
   285	 * @file: dir to be opened (to create it's child)
   286	 *
   287	 * Used to dynamic create file/dir with-in @file, all the
   288	 * file/dir will be created. If already created then reference
   289	 * will be increased
   290	 */
 > 291	int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
   292	{
   293		struct tracefs_inode *ti;
   294		struct eventfs_inode *ei;
   295		struct eventfs_file *ef;
   296		struct inode *f_inode = file_inode(file);
   297		struct dentry *dentry = file_dentry(file);
   298	
   299		ti = get_tracefs(f_inode);
   300		if (!(ti->flags & TRACEFS_EVENT_INODE))
   301			return -EINVAL;
   302	
   303		ei = ti->private;
   304		list_for_each_entry(ef, &ei->e_top_files, list) {
   305			if (ef->created) {
   306				dget(ef->dentry);
   307				continue;
   308			}
   309	
   310			ef->created = true;
   311	
   312			inode_lock(dentry->d_inode);
   313			if (ef->ei) 
   314				ef->dentry = eventfs_create_dir(ef->name, ef->mode, dentry,
   315								ef->data, ef->fop, ef->iop, 1);
   316			else
   317				ef->dentry = eventfs_create_file(ef->name, ef->mode, dentry,
   318								 ef->data, ef->fop, 1);
   319			inode_unlock(dentry->d_inode);
   320	
   321			if (IS_ERR_OR_NULL(ef->dentry)) {
   322				ef->created = false;
   323			} else {
   324				if (ef->ei)
   325					eventfs_post_create_dir(ef);
   326				ef->dentry->d_fsdata = ef;
   327			}
   328		}
   329		return dcache_dir_open(inode, file);
   330	}
   331	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
