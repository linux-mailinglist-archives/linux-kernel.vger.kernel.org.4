Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA42A6CABE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjC0Rbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjC0Rbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:31:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D24487;
        Mon, 27 Mar 2023 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679938292; x=1711474292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N47Dok/0bvtGYTzlcpVSGeXSXzuU2L9RxxqI3vxahZQ=;
  b=ilF+8mHLFlHjXnpI3X6/q2CVfQmI74lpmCSOcugWFYO5PtzmkfImoPID
   jsKMAvCQM7ZpJJech8ZIbUV0MwnR1d8sIXI1toDaSvu7Mr52QkS9Vr55w
   mO2SZsgDx3v+p5h3O4U36E4GrYU+xsJbwquzDW+DziIaOw1Vh1lx3bMsf
   kdJzL0VJrjBJbzAt73A+KXF+f3fURHtNdLumtf/ded0vIzFUjx1nhmGh3
   u1WARt9y8dEUWTAxZmUUaoOIoP6L6ObzWjX7WuU3+zb65mUa0oYNf2soV
   o8feQ/5AOeO7UcHblkKZYob3xcDDacwIGzx8iGnei4JzBd20PNcSQR7h+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="339057270"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="339057270"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 10:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686053686"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686053686"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2023 10:31:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgqgh-000HsB-26;
        Mon, 27 Mar 2023 17:31:19 +0000
Date:   Tue, 28 Mar 2023 01:30:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ye Bin <yebin@huaweicloud.com>, djwong@kernel.org,
        linux-xfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] xfs: fix BUG_ON in xfs_getbmap()
Message-ID: <202303280146.XMC4bc3D-lkp@intel.com>
References: <20230327140218.4154709-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327140218.4154709-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on xfs-linux/for-next]
[also build test WARNING on linus/master v6.3-rc4 next-20230327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ye-Bin/xfs-fix-BUG_ON-in-xfs_getbmap/20230327-220330
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20230327140218.4154709-1-yebin%40huaweicloud.com
patch subject: [PATCH] xfs: fix BUG_ON in xfs_getbmap()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230328/202303280146.XMC4bc3D-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ff0f6481a35ee27471d1511047c34f4885e2f5aa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ye-Bin/xfs-fix-BUG_ON-in-xfs_getbmap/20230327-220330
        git checkout ff0f6481a35ee27471d1511047c34f4885e2f5aa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303280146.XMC4bc3D-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/xfs/xfs_bmap_util.c: In function 'xfs_getbmap':
>> fs/xfs/xfs_bmap_util.c:581:1: warning: label 'out_unlock_iolock' defined but not used [-Wunused-label]
     581 | out_unlock_iolock:
         | ^~~~~~~~~~~~~~~~~


vim +/out_unlock_iolock +581 fs/xfs/xfs_bmap_util.c

f86f403794b144 Darrick J. Wong   2016-10-03  396  
6898811459ff52 Dave Chinner      2013-08-12  397  /*
6898811459ff52 Dave Chinner      2013-08-12  398   * Get inode's extents as described in bmv, and format for output.
6898811459ff52 Dave Chinner      2013-08-12  399   * Calls formatter to fill the user's buffer until all extents
6898811459ff52 Dave Chinner      2013-08-12  400   * are mapped, until the passed-in bmv->bmv_count slots have
6898811459ff52 Dave Chinner      2013-08-12  401   * been filled, or until the formatter short-circuits the loop,
6898811459ff52 Dave Chinner      2013-08-12  402   * if it is tracking filled-in extents on its own.
6898811459ff52 Dave Chinner      2013-08-12  403   */
6898811459ff52 Dave Chinner      2013-08-12  404  int						/* error code */
6898811459ff52 Dave Chinner      2013-08-12  405  xfs_getbmap(
232b51948b99df Christoph Hellwig 2017-10-17  406  	struct xfs_inode	*ip,
6898811459ff52 Dave Chinner      2013-08-12  407  	struct getbmapx		*bmv,		/* user bmap structure */
232b51948b99df Christoph Hellwig 2017-10-17  408  	struct kgetbmap		*out)
6898811459ff52 Dave Chinner      2013-08-12  409  {
abbf9e8a450748 Christoph Hellwig 2017-10-17  410  	struct xfs_mount	*mp = ip->i_mount;
abbf9e8a450748 Christoph Hellwig 2017-10-17  411  	int			iflags = bmv->bmv_iflags;
232b51948b99df Christoph Hellwig 2017-10-17  412  	int			whichfork, lock, error = 0;
abbf9e8a450748 Christoph Hellwig 2017-10-17  413  	int64_t			bmv_end, max_len;
abbf9e8a450748 Christoph Hellwig 2017-10-17  414  	xfs_fileoff_t		bno, first_bno;
abbf9e8a450748 Christoph Hellwig 2017-10-17  415  	struct xfs_ifork	*ifp;
abbf9e8a450748 Christoph Hellwig 2017-10-17  416  	struct xfs_bmbt_irec	got, rec;
abbf9e8a450748 Christoph Hellwig 2017-10-17  417  	xfs_filblks_t		len;
b2b1712a640824 Christoph Hellwig 2017-11-03  418  	struct xfs_iext_cursor	icur;
6898811459ff52 Dave Chinner      2013-08-12  419  
232b51948b99df Christoph Hellwig 2017-10-17  420  	if (bmv->bmv_iflags & ~BMV_IF_VALID)
232b51948b99df Christoph Hellwig 2017-10-17  421  		return -EINVAL;
f86f403794b144 Darrick J. Wong   2016-10-03  422  #ifndef DEBUG
f86f403794b144 Darrick J. Wong   2016-10-03  423  	/* Only allow CoW fork queries if we're debugging. */
f86f403794b144 Darrick J. Wong   2016-10-03  424  	if (iflags & BMV_IF_COWFORK)
f86f403794b144 Darrick J. Wong   2016-10-03  425  		return -EINVAL;
f86f403794b144 Darrick J. Wong   2016-10-03  426  #endif
f86f403794b144 Darrick J. Wong   2016-10-03  427  	if ((iflags & BMV_IF_ATTRFORK) && (iflags & BMV_IF_COWFORK))
f86f403794b144 Darrick J. Wong   2016-10-03  428  		return -EINVAL;
f86f403794b144 Darrick J. Wong   2016-10-03  429  
abbf9e8a450748 Christoph Hellwig 2017-10-17  430  	if (bmv->bmv_length < -1)
abbf9e8a450748 Christoph Hellwig 2017-10-17  431  		return -EINVAL;
abbf9e8a450748 Christoph Hellwig 2017-10-17  432  	bmv->bmv_entries = 0;
abbf9e8a450748 Christoph Hellwig 2017-10-17  433  	if (bmv->bmv_length == 0)
abbf9e8a450748 Christoph Hellwig 2017-10-17  434  		return 0;
abbf9e8a450748 Christoph Hellwig 2017-10-17  435  
f86f403794b144 Darrick J. Wong   2016-10-03  436  	if (iflags & BMV_IF_ATTRFORK)
f86f403794b144 Darrick J. Wong   2016-10-03  437  		whichfork = XFS_ATTR_FORK;
f86f403794b144 Darrick J. Wong   2016-10-03  438  	else if (iflags & BMV_IF_COWFORK)
f86f403794b144 Darrick J. Wong   2016-10-03  439  		whichfork = XFS_COW_FORK;
f86f403794b144 Darrick J. Wong   2016-10-03  440  	else
f86f403794b144 Darrick J. Wong   2016-10-03  441  		whichfork = XFS_DATA_FORK;
f86f403794b144 Darrick J. Wong   2016-10-03  442  
abbf9e8a450748 Christoph Hellwig 2017-10-17  443  	xfs_ilock(ip, XFS_IOLOCK_SHARED);
f86f403794b144 Darrick J. Wong   2016-10-03  444  	switch (whichfork) {
f86f403794b144 Darrick J. Wong   2016-10-03  445  	case XFS_ATTR_FORK:
001c179c4e26d0 ChenXiaoSong      2022-07-27  446  		lock = xfs_ilock_attr_map_shared(ip);
932b42c66cb5d0 Darrick J. Wong   2022-07-09  447  		if (!xfs_inode_has_attr_fork(ip))
001c179c4e26d0 ChenXiaoSong      2022-07-27  448  			goto out_unlock_ilock;
6898811459ff52 Dave Chinner      2013-08-12  449  
abbf9e8a450748 Christoph Hellwig 2017-10-17  450  		max_len = 1LL << 32;
f86f403794b144 Darrick J. Wong   2016-10-03  451  		break;
f86f403794b144 Darrick J. Wong   2016-10-03  452  	case XFS_COW_FORK:
001c179c4e26d0 ChenXiaoSong      2022-07-27  453  		lock = XFS_ILOCK_SHARED;
001c179c4e26d0 ChenXiaoSong      2022-07-27  454  		xfs_ilock(ip, lock);
001c179c4e26d0 ChenXiaoSong      2022-07-27  455  
abbf9e8a450748 Christoph Hellwig 2017-10-17  456  		/* No CoW fork? Just return */
001c179c4e26d0 ChenXiaoSong      2022-07-27  457  		if (!xfs_ifork_ptr(ip, whichfork))
001c179c4e26d0 ChenXiaoSong      2022-07-27  458  			goto out_unlock_ilock;
f86f403794b144 Darrick J. Wong   2016-10-03  459  
abbf9e8a450748 Christoph Hellwig 2017-10-17  460  		if (xfs_get_cowextsz_hint(ip))
abbf9e8a450748 Christoph Hellwig 2017-10-17  461  			max_len = mp->m_super->s_maxbytes;
abbf9e8a450748 Christoph Hellwig 2017-10-17  462  		else
abbf9e8a450748 Christoph Hellwig 2017-10-17  463  			max_len = XFS_ISIZE(ip);
f86f403794b144 Darrick J. Wong   2016-10-03  464  		break;
f86f403794b144 Darrick J. Wong   2016-10-03  465  	case XFS_DATA_FORK:
ff0f6481a35ee2 Ye Bin            2023-03-27  466  		lock = XFS_MMAPLOCK_EXCL;
ff0f6481a35ee2 Ye Bin            2023-03-27  467  		xfs_ilock(ip, lock);
efa70be1654978 Christoph Hellwig 2013-12-18  468  		if (!(iflags & BMV_IF_DELALLOC) &&
13d2c10b05d8e6 Christoph Hellwig 2021-03-29  469  		    (ip->i_delayed_blks || XFS_ISIZE(ip) > ip->i_disk_size)) {
2451337dd04390 Dave Chinner      2014-06-25  470  			error = filemap_write_and_wait(VFS_I(ip)->i_mapping);
6898811459ff52 Dave Chinner      2013-08-12  471  			if (error)
ff0f6481a35ee2 Ye Bin            2023-03-27  472  				goto out_unlock_ilock;
efa70be1654978 Christoph Hellwig 2013-12-18  473  
6898811459ff52 Dave Chinner      2013-08-12  474  			/*
efa70be1654978 Christoph Hellwig 2013-12-18  475  			 * Even after flushing the inode, there can still be
efa70be1654978 Christoph Hellwig 2013-12-18  476  			 * delalloc blocks on the inode beyond EOF due to
efa70be1654978 Christoph Hellwig 2013-12-18  477  			 * speculative preallocation.  These are not removed
efa70be1654978 Christoph Hellwig 2013-12-18  478  			 * until the release function is called or the inode
efa70be1654978 Christoph Hellwig 2013-12-18  479  			 * is inactivated.  Hence we cannot assert here that
efa70be1654978 Christoph Hellwig 2013-12-18  480  			 * ip->i_delayed_blks == 0.
6898811459ff52 Dave Chinner      2013-08-12  481  			 */
6898811459ff52 Dave Chinner      2013-08-12  482  		}
6898811459ff52 Dave Chinner      2013-08-12  483  
abbf9e8a450748 Christoph Hellwig 2017-10-17  484  		if (xfs_get_extsz_hint(ip) ||
db07349da2f564 Christoph Hellwig 2021-03-29  485  		    (ip->i_diflags &
abbf9e8a450748 Christoph Hellwig 2017-10-17  486  		     (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)))
abbf9e8a450748 Christoph Hellwig 2017-10-17  487  			max_len = mp->m_super->s_maxbytes;
abbf9e8a450748 Christoph Hellwig 2017-10-17  488  		else
abbf9e8a450748 Christoph Hellwig 2017-10-17  489  			max_len = XFS_ISIZE(ip);
abbf9e8a450748 Christoph Hellwig 2017-10-17  490  
ff0f6481a35ee2 Ye Bin            2023-03-27  491  		lock |= xfs_ilock_data_map_shared(ip);
f86f403794b144 Darrick J. Wong   2016-10-03  492  		break;
efa70be1654978 Christoph Hellwig 2013-12-18  493  	}
6898811459ff52 Dave Chinner      2013-08-12  494  
001c179c4e26d0 ChenXiaoSong      2022-07-27  495  	ifp = xfs_ifork_ptr(ip, whichfork);
001c179c4e26d0 ChenXiaoSong      2022-07-27  496  
f7e67b20ecbbcb Christoph Hellwig 2020-05-18  497  	switch (ifp->if_format) {
abbf9e8a450748 Christoph Hellwig 2017-10-17  498  	case XFS_DINODE_FMT_EXTENTS:
abbf9e8a450748 Christoph Hellwig 2017-10-17  499  	case XFS_DINODE_FMT_BTREE:
abbf9e8a450748 Christoph Hellwig 2017-10-17  500  		break;
abbf9e8a450748 Christoph Hellwig 2017-10-17  501  	case XFS_DINODE_FMT_LOCAL:
abbf9e8a450748 Christoph Hellwig 2017-10-17  502  		/* Local format inode forks report no extents. */
6898811459ff52 Dave Chinner      2013-08-12  503  		goto out_unlock_ilock;
abbf9e8a450748 Christoph Hellwig 2017-10-17  504  	default:
abbf9e8a450748 Christoph Hellwig 2017-10-17  505  		error = -EINVAL;
abbf9e8a450748 Christoph Hellwig 2017-10-17  506  		goto out_unlock_ilock;
abbf9e8a450748 Christoph Hellwig 2017-10-17  507  	}
6898811459ff52 Dave Chinner      2013-08-12  508  
abbf9e8a450748 Christoph Hellwig 2017-10-17  509  	if (bmv->bmv_length == -1) {
abbf9e8a450748 Christoph Hellwig 2017-10-17  510  		max_len = XFS_FSB_TO_BB(mp, XFS_B_TO_FSB(mp, max_len));
abbf9e8a450748 Christoph Hellwig 2017-10-17  511  		bmv->bmv_length = max(0LL, max_len - bmv->bmv_offset);
6898811459ff52 Dave Chinner      2013-08-12  512  	}
6898811459ff52 Dave Chinner      2013-08-12  513  
abbf9e8a450748 Christoph Hellwig 2017-10-17  514  	bmv_end = bmv->bmv_offset + bmv->bmv_length;
abbf9e8a450748 Christoph Hellwig 2017-10-17  515  
abbf9e8a450748 Christoph Hellwig 2017-10-17  516  	first_bno = bno = XFS_BB_TO_FSBT(mp, bmv->bmv_offset);
abbf9e8a450748 Christoph Hellwig 2017-10-17  517  	len = XFS_BB_TO_FSB(mp, bmv->bmv_length);
abbf9e8a450748 Christoph Hellwig 2017-10-17  518  
abbf9e8a450748 Christoph Hellwig 2017-10-17  519  	error = xfs_iread_extents(NULL, ip, whichfork);
6898811459ff52 Dave Chinner      2013-08-12  520  	if (error)
abbf9e8a450748 Christoph Hellwig 2017-10-17  521  		goto out_unlock_ilock;
6898811459ff52 Dave Chinner      2013-08-12  522  
b2b1712a640824 Christoph Hellwig 2017-11-03  523  	if (!xfs_iext_lookup_extent(ip, ifp, bno, &icur, &got)) {
6898811459ff52 Dave Chinner      2013-08-12  524  		/*
abbf9e8a450748 Christoph Hellwig 2017-10-17  525  		 * Report a whole-file hole if the delalloc flag is set to
abbf9e8a450748 Christoph Hellwig 2017-10-17  526  		 * stay compatible with the old implementation.
6898811459ff52 Dave Chinner      2013-08-12  527  		 */
abbf9e8a450748 Christoph Hellwig 2017-10-17  528  		if (iflags & BMV_IF_DELALLOC)
abbf9e8a450748 Christoph Hellwig 2017-10-17  529  			xfs_getbmap_report_hole(ip, bmv, out, bmv_end, bno,
abbf9e8a450748 Christoph Hellwig 2017-10-17  530  					XFS_B_TO_FSB(mp, XFS_ISIZE(ip)));
abbf9e8a450748 Christoph Hellwig 2017-10-17  531  		goto out_unlock_ilock;
6898811459ff52 Dave Chinner      2013-08-12  532  	}
6898811459ff52 Dave Chinner      2013-08-12  533  
abbf9e8a450748 Christoph Hellwig 2017-10-17  534  	while (!xfs_getbmap_full(bmv)) {
abbf9e8a450748 Christoph Hellwig 2017-10-17  535  		xfs_trim_extent(&got, first_bno, len);
6898811459ff52 Dave Chinner      2013-08-12  536  
6898811459ff52 Dave Chinner      2013-08-12  537  		/*
abbf9e8a450748 Christoph Hellwig 2017-10-17  538  		 * Report an entry for a hole if this extent doesn't directly
abbf9e8a450748 Christoph Hellwig 2017-10-17  539  		 * follow the previous one.
6898811459ff52 Dave Chinner      2013-08-12  540  		 */
abbf9e8a450748 Christoph Hellwig 2017-10-17  541  		if (got.br_startoff > bno) {
abbf9e8a450748 Christoph Hellwig 2017-10-17  542  			xfs_getbmap_report_hole(ip, bmv, out, bmv_end, bno,
abbf9e8a450748 Christoph Hellwig 2017-10-17  543  					got.br_startoff);
abbf9e8a450748 Christoph Hellwig 2017-10-17  544  			if (xfs_getbmap_full(bmv))
abbf9e8a450748 Christoph Hellwig 2017-10-17  545  				break;
6898811459ff52 Dave Chinner      2013-08-12  546  		}
6898811459ff52 Dave Chinner      2013-08-12  547  
c364b6d0b6cda1 Darrick J. Wong   2017-01-26  548  		/*
abbf9e8a450748 Christoph Hellwig 2017-10-17  549  		 * In order to report shared extents accurately, we report each
abbf9e8a450748 Christoph Hellwig 2017-10-17  550  		 * distinct shared / unshared part of a single bmbt record with
abbf9e8a450748 Christoph Hellwig 2017-10-17  551  		 * an individual getbmapx record.
c364b6d0b6cda1 Darrick J. Wong   2017-01-26  552  		 */
abbf9e8a450748 Christoph Hellwig 2017-10-17  553  		bno = got.br_startoff + got.br_blockcount;
abbf9e8a450748 Christoph Hellwig 2017-10-17  554  		rec = got;
abbf9e8a450748 Christoph Hellwig 2017-10-17  555  		do {
abbf9e8a450748 Christoph Hellwig 2017-10-17  556  			error = xfs_getbmap_report_one(ip, bmv, out, bmv_end,
abbf9e8a450748 Christoph Hellwig 2017-10-17  557  					&rec);
abbf9e8a450748 Christoph Hellwig 2017-10-17  558  			if (error || xfs_getbmap_full(bmv))
abbf9e8a450748 Christoph Hellwig 2017-10-17  559  				goto out_unlock_ilock;
abbf9e8a450748 Christoph Hellwig 2017-10-17  560  		} while (xfs_getbmap_next_rec(&rec, bno));
abbf9e8a450748 Christoph Hellwig 2017-10-17  561  
b2b1712a640824 Christoph Hellwig 2017-11-03  562  		if (!xfs_iext_next_extent(ifp, &icur, &got)) {
abbf9e8a450748 Christoph Hellwig 2017-10-17  563  			xfs_fileoff_t	end = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
abbf9e8a450748 Christoph Hellwig 2017-10-17  564  
abbf9e8a450748 Christoph Hellwig 2017-10-17  565  			out[bmv->bmv_entries - 1].bmv_oflags |= BMV_OF_LAST;
abbf9e8a450748 Christoph Hellwig 2017-10-17  566  
abbf9e8a450748 Christoph Hellwig 2017-10-17  567  			if (whichfork != XFS_ATTR_FORK && bno < end &&
abbf9e8a450748 Christoph Hellwig 2017-10-17  568  			    !xfs_getbmap_full(bmv)) {
abbf9e8a450748 Christoph Hellwig 2017-10-17  569  				xfs_getbmap_report_hole(ip, bmv, out, bmv_end,
abbf9e8a450748 Christoph Hellwig 2017-10-17  570  						bno, end);
c364b6d0b6cda1 Darrick J. Wong   2017-01-26  571  			}
abbf9e8a450748 Christoph Hellwig 2017-10-17  572  			break;
abbf9e8a450748 Christoph Hellwig 2017-10-17  573  		}
abbf9e8a450748 Christoph Hellwig 2017-10-17  574  
abbf9e8a450748 Christoph Hellwig 2017-10-17  575  		if (bno >= first_bno + len)
abbf9e8a450748 Christoph Hellwig 2017-10-17  576  			break;
6898811459ff52 Dave Chinner      2013-08-12  577  	}
6898811459ff52 Dave Chinner      2013-08-12  578  
6898811459ff52 Dave Chinner      2013-08-12  579  out_unlock_ilock:
01f4f3277556d4 Christoph Hellwig 2013-12-06  580  	xfs_iunlock(ip, lock);
6898811459ff52 Dave Chinner      2013-08-12 @581  out_unlock_iolock:
6898811459ff52 Dave Chinner      2013-08-12  582  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
6898811459ff52 Dave Chinner      2013-08-12  583  	return error;
6898811459ff52 Dave Chinner      2013-08-12  584  }
6898811459ff52 Dave Chinner      2013-08-12  585  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
