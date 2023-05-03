Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1776F4EE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjECCmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECCmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:42:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594C2CC
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683081769; x=1714617769;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=26p2THghE9aibjjGhMNvzag15THGKpX4Dl1KLQtwCLU=;
  b=ny25kVOz+zAveWPamXYezn2DHCYx/17AsuE9W+5U7ZMEvsniZWAGw1y9
   CwtsMBdaqW5SG4gTfnHILmIG7ZfMXhhYanD13gkWABJjccGipgY4UX4ku
   8ksNW/hrozd96i7trKxhxkI8tyXefHARGurJilcL/quQGAfKMT97Dho5N
   Jn3W4nThB9FsF/Rn1mfAzhQyOmLAB9mXP6LKFu99zPgUEkyeKH9CiaAgP
   RE37ediENXUQM1cpMJhxft8dST4U1pelAKDVBColZ9F3SmyMiBB9+f4Cg
   4vaHhZC9l7IoJUJ8qhV7s99fr5ecAA1MHe/4Ru7gilqupcu58A1NE4koM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="350625585"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="350625585"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 19:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="696401701"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="696401701"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2023 19:42:47 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pu2S6-0001R1-2Y;
        Wed, 03 May 2023 02:42:46 +0000
Date:   Wed, 3 May 2023 10:42:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/trace/blktrace.c:491:9: warning: 'strncpy' specified bound 32
 equals destination size
Message-ID: <202305031045.HuKUEqHq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   348551ddaf311c76b01cdcbaf61b6fef06a49144
commit: 334ef6ed06fa1a54e35296b77b693bcf6d63ee9e init/Kconfig: make COMPILE_TEST depend on !S390
date:   2 years, 5 months ago
config: s390-randconfig-r002-20230503 (https://download.01.org/0day-ci/archive/20230503/202305031045.HuKUEqHq-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=334ef6ed06fa1a54e35296b77b693bcf6d63ee9e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 334ef6ed06fa1a54e35296b77b693bcf6d63ee9e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305031045.HuKUEqHq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/blktrace.c: In function '__trace_note_message':
   kernel/trace/blktrace.c:148:63: warning: parameter 'blkcg' set but not used [-Wunused-but-set-parameter]
     148 | void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
         |                                                 ~~~~~~~~~~~~~~^~~~~
   kernel/trace/blktrace.c: In function 'do_blk_trace_setup':
>> kernel/trace/blktrace.c:491:9: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
     491 |         strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/fscache.h:533,
                    from fs/fscache/internal.h:28,
                    from fs/fscache/main.c:16:
   include/trace/events/fscache.h: In function 'perf_trace_fscache_netfs':
>> include/trace/events/fscache.h:208:21: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
     208 |                     strncpy(__entry->name, netfs->name, 8);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/perf.h:66:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      66 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:79:30: note: in expansion of macro 'PARAMS'
      79 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/fscache.h:196:1: note: in expansion of macro 'TRACE_EVENT'
     196 | TRACE_EVENT(fscache_netfs,
         | ^~~~~~~~~~~
   include/trace/events/fscache.h:206:13: note: in expansion of macro 'TP_fast_assign'
     206 |             TP_fast_assign(
         |             ^~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:102:
   include/trace/events/fscache.h: In function 'trace_event_raw_event_fscache_netfs':
>> include/trace/events/fscache.h:208:21: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
     208 |                     strncpy(__entry->name, netfs->name, 8);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:695:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     695 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:79:30: note: in expansion of macro 'PARAMS'
      79 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/fscache.h:196:1: note: in expansion of macro 'TRACE_EVENT'
     196 | TRACE_EVENT(fscache_netfs,
         | ^~~~~~~~~~~
   include/trace/events/fscache.h:206:13: note: in expansion of macro 'TP_fast_assign'
     206 |             TP_fast_assign(
         |             ^~~~~~~~~~~~~~


vim +/strncpy +491 kernel/trace/blktrace.c

9908c30997b8a7 kernel/trace/blktrace.c Li Zefan                 2009-04-14  474  
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  475  /*
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  476   * Setup everything required to start tracing
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  477   */
a428d314ebcf65 kernel/trace/blktrace.c Omar Sandoval            2017-01-31  478  static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
d0deef5b14af7d kernel/trace/blktrace.c Shawn Du                 2009-04-14  479  			      struct block_device *bdev,
171044d449611c block/blktrace.c        Arnd Bergmann            2007-10-09  480  			      struct blk_user_trace_setup *buts)
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  481  {
cdea01b2bf98af kernel/trace/blktrace.c Davidlohr Bueso          2015-10-30  482  	struct blk_trace *bt = NULL;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  483  	struct dentry *dir = NULL;
ff14417c0a00c9 kernel/trace/blktrace.c Rasmus Villemoes         2015-06-25  484  	int ret;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  485  
85e0cbbb8a7953 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  486  	lockdep_assert_held(&q->debugfs_mutex);
a67549c8e56862 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  487  
171044d449611c block/blktrace.c        Arnd Bergmann            2007-10-09  488  	if (!buts->buf_size || !buts->buf_nr)
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  489  		return -EINVAL;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  490  
0497b345e7d067 block/blktrace.c        Jens Axboe               2008-10-01 @491  	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
0497b345e7d067 block/blktrace.c        Jens Axboe               2008-10-01  492  	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  493  
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  494  	/*
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  495  	 * some device names have larger paths - convert the slashes
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  496  	 * to underscores for this to work as expected
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  497  	 */
ff14417c0a00c9 kernel/trace/blktrace.c Rasmus Villemoes         2015-06-25  498  	strreplace(buts->name, '/', '_');
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  499  
1b0b283648163d kernel/trace/blktrace.c Luis Chamberlain         2020-06-05  500  	/*
1b0b283648163d kernel/trace/blktrace.c Luis Chamberlain         2020-06-05  501  	 * bdev can be NULL, as with scsi-generic, this is a helpful as
1b0b283648163d kernel/trace/blktrace.c Luis Chamberlain         2020-06-05  502  	 * we can be.
1b0b283648163d kernel/trace/blktrace.c Luis Chamberlain         2020-06-05  503  	 */
c3dbe541ef7775 kernel/trace/blktrace.c Jan Kara                 2020-06-05  504  	if (rcu_dereference_protected(q->blk_trace,
85e0cbbb8a7953 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  505  				      lockdep_is_held(&q->debugfs_mutex))) {
1b0b283648163d kernel/trace/blktrace.c Luis Chamberlain         2020-06-05  506  		pr_warn("Concurrent blktraces are not allowed on %s\n",
1b0b283648163d kernel/trace/blktrace.c Luis Chamberlain         2020-06-05  507  			buts->name);
1b0b283648163d kernel/trace/blktrace.c Luis Chamberlain         2020-06-05  508  		return -EBUSY;
1b0b283648163d kernel/trace/blktrace.c Luis Chamberlain         2020-06-05  509  	}
1b0b283648163d kernel/trace/blktrace.c Luis Chamberlain         2020-06-05  510  
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  511  	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  512  	if (!bt)
ad5dd5493a55e4 kernel/trace/blktrace.c Li Zefan                 2009-03-27  513  		return -ENOMEM;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  514  
ad5dd5493a55e4 kernel/trace/blktrace.c Li Zefan                 2009-03-27  515  	ret = -ENOMEM;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  516  	bt->sequence = alloc_percpu(unsigned long);
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  517  	if (!bt->sequence)
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  518  		goto err;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  519  
313e458f81ec38 block/blktrace.c        Rusty Russell            2009-02-20  520  	bt->msg_data = __alloc_percpu(BLK_TN_MAX_MSG, __alignof__(char));
64565911cdb57c block/blktrace.c        Jens Axboe               2008-05-28  521  	if (!bt->msg_data)
64565911cdb57c block/blktrace.c        Jens Axboe               2008-05-28  522  		goto err;
64565911cdb57c block/blktrace.c        Jens Axboe               2008-05-28  523  
bad8e64fb19d3a kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  524  	/*
85e0cbbb8a7953 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  525  	 * When tracing the whole disk reuse the existing debugfs directory
85e0cbbb8a7953 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  526  	 * created by the block layer on init. For partitions block devices,
bad8e64fb19d3a kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  527  	 * and scsi-generic block devices we create a temporary new debugfs
bad8e64fb19d3a kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  528  	 * directory that will be removed once the trace ends.
bad8e64fb19d3a kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  529  	 */
fa01b1e9733fd5 kernel/trace/blktrace.c Christoph Hellwig        2020-09-03  530  	if (bdev && !bdev_is_partition(bdev))
bad8e64fb19d3a kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  531  		dir = q->debugfs_dir;
bad8e64fb19d3a kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  532  	else
6ac93117ab009d kernel/trace/blktrace.c Omar Sandoval            2017-01-31  533  		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  534  
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  535  	/*
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  536  	 * As blktrace relies on debugfs for its interface the debugfs directory
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  537  	 * is required, contrary to the usual mantra of not checking for debugfs
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  538  	 * files or directories.
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  539  	 */
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  540  	if (IS_ERR_OR_NULL(dir)) {
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  541  		pr_warn("debugfs_dir not present for %s so skipping\n",
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  542  			buts->name);
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  543  		ret = -ENOENT;
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  544  		goto err;
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  545  	}
b431ef837e3374 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  546  
6da127ad0918f9 block/blktrace.c        Christof Schmitt         2008-01-11  547  	bt->dev = dev;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  548  	atomic_set(&bt->dropped, 0);
a404d5576bbe58 kernel/trace/blktrace.c Jan Kara                 2013-09-17  549  	INIT_LIST_HEAD(&bt->running_list);
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  550  
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  551  	ret = -EIO;
939b366977d29b block/blktrace.c        Arnaldo Carvalho de Melo 2009-02-03  552  	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
939b366977d29b block/blktrace.c        Arnaldo Carvalho de Melo 2009-02-03  553  					       &blk_dropped_fops);
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  554  
02c62304e6af60 block/blktrace.c        Alan D. Brunelle         2008-06-11  555  	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
02c62304e6af60 block/blktrace.c        Alan D. Brunelle         2008-06-11  556  
171044d449611c block/blktrace.c        Arnd Bergmann            2007-10-09  557  	bt->rchan = relay_open("trace", dir, buts->buf_size,
171044d449611c block/blktrace.c        Arnd Bergmann            2007-10-09  558  				buts->buf_nr, &blk_relay_callbacks, bt);
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  559  	if (!bt->rchan)
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  560  		goto err;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  561  
171044d449611c block/blktrace.c        Arnd Bergmann            2007-10-09  562  	bt->act_mask = buts->act_mask;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  563  	if (!bt->act_mask)
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  564  		bt->act_mask = (u16) -1;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  565  
9908c30997b8a7 kernel/trace/blktrace.c Li Zefan                 2009-04-14  566  	blk_trace_setup_lba(bt, bdev);
d0deef5b14af7d kernel/trace/blktrace.c Shawn Du                 2009-04-14  567  
d0deef5b14af7d kernel/trace/blktrace.c Shawn Du                 2009-04-14  568  	/* overwrite with user settings */
d0deef5b14af7d kernel/trace/blktrace.c Shawn Du                 2009-04-14  569  	if (buts->start_lba)
171044d449611c block/blktrace.c        Arnd Bergmann            2007-10-09  570  		bt->start_lba = buts->start_lba;
d0deef5b14af7d kernel/trace/blktrace.c Shawn Du                 2009-04-14  571  	if (buts->end_lba)
171044d449611c block/blktrace.c        Arnd Bergmann            2007-10-09  572  		bt->end_lba = buts->end_lba;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  573  
171044d449611c block/blktrace.c        Arnd Bergmann            2007-10-09  574  	bt->pid = buts->pid;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  575  	bt->trace_state = Blktrace_setup;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  576  
c3dbe541ef7775 kernel/trace/blktrace.c Jan Kara                 2020-06-05  577  	rcu_assign_pointer(q->blk_trace, bt);
a6da0024ffc19e kernel/trace/blktrace.c Jens Axboe               2017-11-05  578  	get_probe_ref();
cbe28296eb1ac4 kernel/trace/blktrace.c Li Zefan                 2009-03-20  579  
6ac93117ab009d kernel/trace/blktrace.c Omar Sandoval            2017-01-31  580  	ret = 0;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  581  err:
6ac93117ab009d kernel/trace/blktrace.c Omar Sandoval            2017-01-31  582  	if (ret)
ad5dd5493a55e4 kernel/trace/blktrace.c Li Zefan                 2009-03-27  583  		blk_trace_free(bt);
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  584  	return ret;
2056a782f8e7e6 block/blktrace.c        Jens Axboe               2006-03-23  585  }
171044d449611c block/blktrace.c        Arnd Bergmann            2007-10-09  586  

:::::: The code at line 491 was first introduced by commit
:::::: 0497b345e7d067109e0dd9bf9f4978a6847ee13b blktrace: use BLKTRACE_BDEV_SIZE as the name size for setup structure

:::::: TO: Jens Axboe <jens.axboe@oracle.com>
:::::: CC: Jens Axboe <jens.axboe@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
