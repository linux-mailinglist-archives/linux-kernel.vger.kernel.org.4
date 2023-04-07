Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79BA6DB571
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjDGUsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDGUsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:48:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3673F7ABA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680900515; x=1712436515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cekn9XPnxvRN4J0lsmc17w8WE3VGfMfFmGP7u4GARE8=;
  b=gLxzNSOAmOGuOpxO2K8fJRNuJqMflYSHTrLjsRi65zy7mWvd8iJDfmn+
   ZQLisAgfV+TtVgFF7XuDLcg+mEY+eQFz5e2RzsEXrUQ7pLE+Xh7Hzd3a+
   y9406wTCtOVAM4uuI9WJJ1X8kwvIfLCEL2S490uvFq76/gEgKeLxns6kc
   b73suhvfIWsQlEvoT4dP6cOC3QTbfCIiLdzmIlyP4EYG07aEzO6MM87FG
   brBXfoZwcfm9dyAaBGzu6DnktfmFqs2sHNwICnxnTFLd81NB7zE2ou8jS
   rAg01tsDYBddYvCgeljYMeuKTAB3UHOx/JfTnCPL/1B9VSPlImgDb+5CT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="429351129"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="429351129"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="720178581"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="720178581"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Apr 2023 13:48:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkt08-000SsA-1w;
        Fri, 07 Apr 2023 20:48:04 +0000
Date:   Sat, 8 Apr 2023 04:47:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Sharma <anupnewsmail@gmail.com>, shaggy@kernel.org,
        r33s3n6@gmail.com, mudongliangabcd@gmail.com,
        liushixin2@huawei.com, wuhoipok@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org,
        syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com,
        anupnewsmail@gmail.com
Subject: Re: [PATCH] fs: jfs: fixed UBSAN: shift-out-of-bounds in dbFree
Message-ID: <202304080405.7pWwoha3-lkp@intel.com>
References: <ZDAhrYVHTVEYIGUM@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDAhrYVHTVEYIGUM@yoga>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kleikamp-shaggy/jfs-next]
[also build test WARNING on linus/master v6.3-rc5 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anup-Sharma/fs-jfs-fixed-UBSAN-shift-out-of-bounds-in-dbFree/20230407-220115
base:   https://github.com/kleikamp/linux-shaggy jfs-next
patch link:    https://lore.kernel.org/r/ZDAhrYVHTVEYIGUM%40yoga
patch subject: [PATCH] fs: jfs: fixed UBSAN: shift-out-of-bounds in dbFree
config: alpha-randconfig-s042-20230403 (https://download.01.org/0day-ci/archive/20230408/202304080405.7pWwoha3-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/b9353aee08c4a798b40d76fd540d524ea1147dfc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anup-Sharma/fs-jfs-fixed-UBSAN-shift-out-of-bounds-in-dbFree/20230407-220115
        git checkout b9353aee08c4a798b40d76fd540d524ea1147dfc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash fs/jfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304080405.7pWwoha3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/jfs/jfs_dmap.c:181:31: sparse: sparse: cast to restricted __le32
>> fs/jfs/jfs_dmap.c:181:31: sparse: sparse: cast from restricted __le64
>> fs/jfs/jfs_dmap.c:295:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] dn_l2nbperpage @@     got restricted __le32 [usertype] @@
   fs/jfs/jfs_dmap.c:295:33: sparse:     expected restricted __le64 [usertype] dn_l2nbperpage
   fs/jfs/jfs_dmap.c:295:33: sparse:     got restricted __le32 [usertype]

vim +181 fs/jfs/jfs_dmap.c

^1da177e4c3f41 Linus Torvalds                2005-04-16  135  
^1da177e4c3f41 Linus Torvalds                2005-04-16  136  /*
^1da177e4c3f41 Linus Torvalds                2005-04-16  137   * NAME:	dbMount()
^1da177e4c3f41 Linus Torvalds                2005-04-16  138   *
^1da177e4c3f41 Linus Torvalds                2005-04-16  139   * FUNCTION:	initializate the block allocation map.
^1da177e4c3f41 Linus Torvalds                2005-04-16  140   *
^1da177e4c3f41 Linus Torvalds                2005-04-16  141   *		memory is allocated for the in-core bmap descriptor and
^1da177e4c3f41 Linus Torvalds                2005-04-16  142   *		the in-core descriptor is initialized from disk.
^1da177e4c3f41 Linus Torvalds                2005-04-16  143   *
^1da177e4c3f41 Linus Torvalds                2005-04-16  144   * PARAMETERS:
^1da177e4c3f41 Linus Torvalds                2005-04-16  145   *	ipbmap	- pointer to in-core inode for the block map.
^1da177e4c3f41 Linus Torvalds                2005-04-16  146   *
^1da177e4c3f41 Linus Torvalds                2005-04-16  147   * RETURN VALUES:
^1da177e4c3f41 Linus Torvalds                2005-04-16  148   *	0	- success
^1da177e4c3f41 Linus Torvalds                2005-04-16  149   *	-ENOMEM	- insufficient memory
^1da177e4c3f41 Linus Torvalds                2005-04-16  150   *	-EIO	- i/o error
2cc7cc01c15f57 Pavel Skripkin                2022-03-19  151   *	-EINVAL - wrong bmap data
^1da177e4c3f41 Linus Torvalds                2005-04-16  152   */
^1da177e4c3f41 Linus Torvalds                2005-04-16  153  int dbMount(struct inode *ipbmap)
^1da177e4c3f41 Linus Torvalds                2005-04-16  154  {
^1da177e4c3f41 Linus Torvalds                2005-04-16  155  	struct bmap *bmp;
^1da177e4c3f41 Linus Torvalds                2005-04-16  156  	struct dbmap_disk *dbmp_le;
^1da177e4c3f41 Linus Torvalds                2005-04-16  157  	struct metapage *mp;
898f706695682b Dongliang Mu                  2022-10-18  158  	int i, err;
^1da177e4c3f41 Linus Torvalds                2005-04-16  159  
^1da177e4c3f41 Linus Torvalds                2005-04-16  160  	/*
^1da177e4c3f41 Linus Torvalds                2005-04-16  161  	 * allocate/initialize the in-memory bmap descriptor
^1da177e4c3f41 Linus Torvalds                2005-04-16  162  	 */
^1da177e4c3f41 Linus Torvalds                2005-04-16  163  	/* allocate memory for the in-memory bmap descriptor */
^1da177e4c3f41 Linus Torvalds                2005-04-16  164  	bmp = kmalloc(sizeof(struct bmap), GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds                2005-04-16  165  	if (bmp == NULL)
^1da177e4c3f41 Linus Torvalds                2005-04-16  166  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds                2005-04-16  167  
^1da177e4c3f41 Linus Torvalds                2005-04-16  168  	/* read the on-disk bmap descriptor. */
^1da177e4c3f41 Linus Torvalds                2005-04-16  169  	mp = read_metapage(ipbmap,
^1da177e4c3f41 Linus Torvalds                2005-04-16  170  			   BMAPBLKNO << JFS_SBI(ipbmap->i_sb)->l2nbperpage,
^1da177e4c3f41 Linus Torvalds                2005-04-16  171  			   PSIZE, 0);
^1da177e4c3f41 Linus Torvalds                2005-04-16  172  	if (mp == NULL) {
898f706695682b Dongliang Mu                  2022-10-18  173  		err = -EIO;
898f706695682b Dongliang Mu                  2022-10-18  174  		goto err_kfree_bmp;
^1da177e4c3f41 Linus Torvalds                2005-04-16  175  	}
^1da177e4c3f41 Linus Torvalds                2005-04-16  176  
^1da177e4c3f41 Linus Torvalds                2005-04-16  177  	/* copy the on-disk bmap descriptor to its in-memory version. */
^1da177e4c3f41 Linus Torvalds                2005-04-16  178  	dbmp_le = (struct dbmap_disk *) mp->data;
^1da177e4c3f41 Linus Torvalds                2005-04-16  179  	bmp->db_mapsize = le64_to_cpu(dbmp_le->dn_mapsize);
^1da177e4c3f41 Linus Torvalds                2005-04-16  180  	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
^1da177e4c3f41 Linus Torvalds                2005-04-16 @181  	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
^1da177e4c3f41 Linus Torvalds                2005-04-16  182  	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
2cc7cc01c15f57 Pavel Skripkin                2022-03-19  183  	if (!bmp->db_numag) {
898f706695682b Dongliang Mu                  2022-10-18  184  		err = -EINVAL;
898f706695682b Dongliang Mu                  2022-10-18  185  		goto err_release_metapage;
2cc7cc01c15f57 Pavel Skripkin                2022-03-19  186  	}
2cc7cc01c15f57 Pavel Skripkin                2022-03-19  187  
^1da177e4c3f41 Linus Torvalds                2005-04-16  188  	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
^1da177e4c3f41 Linus Torvalds                2005-04-16  189  	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
^1da177e4c3f41 Linus Torvalds                2005-04-16  190  	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
^1da177e4c3f41 Linus Torvalds                2005-04-16  191  	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
d7eecb483cc29e Daniel Mack                   2010-01-28  192  	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
^1da177e4c3f41 Linus Torvalds                2005-04-16  193  	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
^1da177e4c3f41 Linus Torvalds                2005-04-16  194  	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
^1da177e4c3f41 Linus Torvalds                2005-04-16  195  	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
fad376fce0af58 Liu Shixin via Jfs-discussion 2022-11-03  196  	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
fad376fce0af58 Liu Shixin via Jfs-discussion 2022-11-03  197  	    bmp->db_agl2size < 0) {
898f706695682b Dongliang Mu                  2022-10-18  198  		err = -EINVAL;
898f706695682b Dongliang Mu                  2022-10-18  199  		goto err_release_metapage;
898f706695682b Dongliang Mu                  2022-10-18  200  	}
898f706695682b Dongliang Mu                  2022-10-18  201  
25e70c6162f207 Hoi Pok Wu                    2022-10-25  202  	if (((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
25e70c6162f207 Hoi Pok Wu                    2022-10-25  203  		err = -EINVAL;
25e70c6162f207 Hoi Pok Wu                    2022-10-25  204  		goto err_release_metapage;
25e70c6162f207 Hoi Pok Wu                    2022-10-25  205  	}
25e70c6162f207 Hoi Pok Wu                    2022-10-25  206  
^1da177e4c3f41 Linus Torvalds                2005-04-16  207  	for (i = 0; i < MAXAG; i++)
^1da177e4c3f41 Linus Torvalds                2005-04-16  208  		bmp->db_agfree[i] = le64_to_cpu(dbmp_le->dn_agfree[i]);
^1da177e4c3f41 Linus Torvalds                2005-04-16  209  	bmp->db_agsize = le64_to_cpu(dbmp_le->dn_agsize);
^1da177e4c3f41 Linus Torvalds                2005-04-16  210  	bmp->db_maxfreebud = dbmp_le->dn_maxfreebud;
^1da177e4c3f41 Linus Torvalds                2005-04-16  211  
^1da177e4c3f41 Linus Torvalds                2005-04-16  212  	/* release the buffer. */
^1da177e4c3f41 Linus Torvalds                2005-04-16  213  	release_metapage(mp);
^1da177e4c3f41 Linus Torvalds                2005-04-16  214  
^1da177e4c3f41 Linus Torvalds                2005-04-16  215  	/* bind the bmap inode and the bmap descriptor to each other. */
^1da177e4c3f41 Linus Torvalds                2005-04-16  216  	bmp->db_ipbmap = ipbmap;
^1da177e4c3f41 Linus Torvalds                2005-04-16  217  	JFS_SBI(ipbmap->i_sb)->bmap = bmp;
^1da177e4c3f41 Linus Torvalds                2005-04-16  218  
^1da177e4c3f41 Linus Torvalds                2005-04-16  219  	memset(bmp->db_active, 0, sizeof(bmp->db_active));
^1da177e4c3f41 Linus Torvalds                2005-04-16  220  
^1da177e4c3f41 Linus Torvalds                2005-04-16  221  	/*
^1da177e4c3f41 Linus Torvalds                2005-04-16  222  	 * allocate/initialize the bmap lock
^1da177e4c3f41 Linus Torvalds                2005-04-16  223  	 */
^1da177e4c3f41 Linus Torvalds                2005-04-16  224  	BMAP_LOCK_INIT(bmp);
^1da177e4c3f41 Linus Torvalds                2005-04-16  225  
^1da177e4c3f41 Linus Torvalds                2005-04-16  226  	return (0);
898f706695682b Dongliang Mu                  2022-10-18  227  
898f706695682b Dongliang Mu                  2022-10-18  228  err_release_metapage:
898f706695682b Dongliang Mu                  2022-10-18  229  	release_metapage(mp);
898f706695682b Dongliang Mu                  2022-10-18  230  err_kfree_bmp:
898f706695682b Dongliang Mu                  2022-10-18  231  	kfree(bmp);
898f706695682b Dongliang Mu                  2022-10-18  232  	return err;
^1da177e4c3f41 Linus Torvalds                2005-04-16  233  }
^1da177e4c3f41 Linus Torvalds                2005-04-16  234  
^1da177e4c3f41 Linus Torvalds                2005-04-16  235  
^1da177e4c3f41 Linus Torvalds                2005-04-16  236  /*
^1da177e4c3f41 Linus Torvalds                2005-04-16  237   * NAME:	dbUnmount()
^1da177e4c3f41 Linus Torvalds                2005-04-16  238   *
^1da177e4c3f41 Linus Torvalds                2005-04-16  239   * FUNCTION:	terminate the block allocation map in preparation for
^1da177e4c3f41 Linus Torvalds                2005-04-16  240   *		file system unmount.
^1da177e4c3f41 Linus Torvalds                2005-04-16  241   *
^1da177e4c3f41 Linus Torvalds                2005-04-16  242   *		the in-core bmap descriptor is written to disk and
^1da177e4c3f41 Linus Torvalds                2005-04-16  243   *		the memory for this descriptor is freed.
^1da177e4c3f41 Linus Torvalds                2005-04-16  244   *
^1da177e4c3f41 Linus Torvalds                2005-04-16  245   * PARAMETERS:
^1da177e4c3f41 Linus Torvalds                2005-04-16  246   *	ipbmap	- pointer to in-core inode for the block map.
^1da177e4c3f41 Linus Torvalds                2005-04-16  247   *
^1da177e4c3f41 Linus Torvalds                2005-04-16  248   * RETURN VALUES:
^1da177e4c3f41 Linus Torvalds                2005-04-16  249   *	0	- success
^1da177e4c3f41 Linus Torvalds                2005-04-16  250   *	-EIO	- i/o error
^1da177e4c3f41 Linus Torvalds                2005-04-16  251   */
^1da177e4c3f41 Linus Torvalds                2005-04-16  252  int dbUnmount(struct inode *ipbmap, int mounterror)
^1da177e4c3f41 Linus Torvalds                2005-04-16  253  {
^1da177e4c3f41 Linus Torvalds                2005-04-16  254  	struct bmap *bmp = JFS_SBI(ipbmap->i_sb)->bmap;
^1da177e4c3f41 Linus Torvalds                2005-04-16  255  
^1da177e4c3f41 Linus Torvalds                2005-04-16  256  	if (!(mounterror || isReadOnly(ipbmap)))
^1da177e4c3f41 Linus Torvalds                2005-04-16  257  		dbSync(ipbmap);
^1da177e4c3f41 Linus Torvalds                2005-04-16  258  
^1da177e4c3f41 Linus Torvalds                2005-04-16  259  	/*
^1da177e4c3f41 Linus Torvalds                2005-04-16  260  	 * Invalidate the page cache buffers
^1da177e4c3f41 Linus Torvalds                2005-04-16  261  	 */
^1da177e4c3f41 Linus Torvalds                2005-04-16  262  	truncate_inode_pages(ipbmap->i_mapping, 0);
^1da177e4c3f41 Linus Torvalds                2005-04-16  263  
^1da177e4c3f41 Linus Torvalds                2005-04-16  264  	/* free the memory for the in-memory bmap. */
^1da177e4c3f41 Linus Torvalds                2005-04-16  265  	kfree(bmp);
^1da177e4c3f41 Linus Torvalds                2005-04-16  266  
^1da177e4c3f41 Linus Torvalds                2005-04-16  267  	return (0);
^1da177e4c3f41 Linus Torvalds                2005-04-16  268  }
^1da177e4c3f41 Linus Torvalds                2005-04-16  269  
^1da177e4c3f41 Linus Torvalds                2005-04-16  270  /*
^1da177e4c3f41 Linus Torvalds                2005-04-16  271   *	dbSync()
^1da177e4c3f41 Linus Torvalds                2005-04-16  272   */
^1da177e4c3f41 Linus Torvalds                2005-04-16  273  int dbSync(struct inode *ipbmap)
^1da177e4c3f41 Linus Torvalds                2005-04-16  274  {
^1da177e4c3f41 Linus Torvalds                2005-04-16  275  	struct dbmap_disk *dbmp_le;
^1da177e4c3f41 Linus Torvalds                2005-04-16  276  	struct bmap *bmp = JFS_SBI(ipbmap->i_sb)->bmap;
^1da177e4c3f41 Linus Torvalds                2005-04-16  277  	struct metapage *mp;
^1da177e4c3f41 Linus Torvalds                2005-04-16  278  	int i;
^1da177e4c3f41 Linus Torvalds                2005-04-16  279  
^1da177e4c3f41 Linus Torvalds                2005-04-16  280  	/*
^1da177e4c3f41 Linus Torvalds                2005-04-16  281  	 * write bmap global control page
^1da177e4c3f41 Linus Torvalds                2005-04-16  282  	 */
^1da177e4c3f41 Linus Torvalds                2005-04-16  283  	/* get the buffer for the on-disk bmap descriptor. */
^1da177e4c3f41 Linus Torvalds                2005-04-16  284  	mp = read_metapage(ipbmap,
^1da177e4c3f41 Linus Torvalds                2005-04-16  285  			   BMAPBLKNO << JFS_SBI(ipbmap->i_sb)->l2nbperpage,
^1da177e4c3f41 Linus Torvalds                2005-04-16  286  			   PSIZE, 0);
^1da177e4c3f41 Linus Torvalds                2005-04-16  287  	if (mp == NULL) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  288  		jfs_err("dbSync: read_metapage failed!");
^1da177e4c3f41 Linus Torvalds                2005-04-16  289  		return -EIO;
^1da177e4c3f41 Linus Torvalds                2005-04-16  290  	}
^1da177e4c3f41 Linus Torvalds                2005-04-16  291  	/* copy the in-memory version of the bmap to the on-disk version */
^1da177e4c3f41 Linus Torvalds                2005-04-16  292  	dbmp_le = (struct dbmap_disk *) mp->data;
^1da177e4c3f41 Linus Torvalds                2005-04-16  293  	dbmp_le->dn_mapsize = cpu_to_le64(bmp->db_mapsize);
^1da177e4c3f41 Linus Torvalds                2005-04-16  294  	dbmp_le->dn_nfree = cpu_to_le64(bmp->db_nfree);
^1da177e4c3f41 Linus Torvalds                2005-04-16 @295  	dbmp_le->dn_l2nbperpage = cpu_to_le32(bmp->db_l2nbperpage);
^1da177e4c3f41 Linus Torvalds                2005-04-16  296  	dbmp_le->dn_numag = cpu_to_le32(bmp->db_numag);
^1da177e4c3f41 Linus Torvalds                2005-04-16  297  	dbmp_le->dn_maxlevel = cpu_to_le32(bmp->db_maxlevel);
^1da177e4c3f41 Linus Torvalds                2005-04-16  298  	dbmp_le->dn_maxag = cpu_to_le32(bmp->db_maxag);
^1da177e4c3f41 Linus Torvalds                2005-04-16  299  	dbmp_le->dn_agpref = cpu_to_le32(bmp->db_agpref);
^1da177e4c3f41 Linus Torvalds                2005-04-16  300  	dbmp_le->dn_aglevel = cpu_to_le32(bmp->db_aglevel);
d7eecb483cc29e Daniel Mack                   2010-01-28  301  	dbmp_le->dn_agheight = cpu_to_le32(bmp->db_agheight);
^1da177e4c3f41 Linus Torvalds                2005-04-16  302  	dbmp_le->dn_agwidth = cpu_to_le32(bmp->db_agwidth);
^1da177e4c3f41 Linus Torvalds                2005-04-16  303  	dbmp_le->dn_agstart = cpu_to_le32(bmp->db_agstart);
^1da177e4c3f41 Linus Torvalds                2005-04-16  304  	dbmp_le->dn_agl2size = cpu_to_le32(bmp->db_agl2size);
^1da177e4c3f41 Linus Torvalds                2005-04-16  305  	for (i = 0; i < MAXAG; i++)
^1da177e4c3f41 Linus Torvalds                2005-04-16  306  		dbmp_le->dn_agfree[i] = cpu_to_le64(bmp->db_agfree[i]);
^1da177e4c3f41 Linus Torvalds                2005-04-16  307  	dbmp_le->dn_agsize = cpu_to_le64(bmp->db_agsize);
^1da177e4c3f41 Linus Torvalds                2005-04-16  308  	dbmp_le->dn_maxfreebud = bmp->db_maxfreebud;
^1da177e4c3f41 Linus Torvalds                2005-04-16  309  
^1da177e4c3f41 Linus Torvalds                2005-04-16  310  	/* write the buffer */
^1da177e4c3f41 Linus Torvalds                2005-04-16  311  	write_metapage(mp);
^1da177e4c3f41 Linus Torvalds                2005-04-16  312  
^1da177e4c3f41 Linus Torvalds                2005-04-16  313  	/*
^1da177e4c3f41 Linus Torvalds                2005-04-16  314  	 * write out dirty pages of bmap
^1da177e4c3f41 Linus Torvalds                2005-04-16  315  	 */
28fd129827b00e OGAWA Hirofumi                2006-01-08  316  	filemap_write_and_wait(ipbmap->i_mapping);
^1da177e4c3f41 Linus Torvalds                2005-04-16  317  
^1da177e4c3f41 Linus Torvalds                2005-04-16  318  	diWriteSpecial(ipbmap, 0);
^1da177e4c3f41 Linus Torvalds                2005-04-16  319  
^1da177e4c3f41 Linus Torvalds                2005-04-16  320  	return (0);
^1da177e4c3f41 Linus Torvalds                2005-04-16  321  }
^1da177e4c3f41 Linus Torvalds                2005-04-16  322  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
