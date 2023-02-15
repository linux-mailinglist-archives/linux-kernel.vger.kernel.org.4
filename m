Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467E76983C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBOSrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBOSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:47:51 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B214D50A;
        Wed, 15 Feb 2023 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676486850; x=1708022850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PWGqVG8PeyF/5CRQAJRpAqDx2RNRCbxSXI/MwuBhgGE=;
  b=LlNE2TO0aXdOSFpxmvd87pK8+mlTVZTeRJP8pC2Re8hpzhI6ZkVbTeFB
   uVud5jabE903KcMBUJi4bINak3V/FST0NRV+nLc3qhnDFiV/vSjYxBTxs
   e2lOlbYiOiXhxteXifJak4c5s//BJdsYcA7X4714fdPRwVFKyL7yyiqbG
   dS9JERG+B6raP827bb1j9++t/drgHVagd8kpHPjt/edxrlwbq/9Le6L6s
   scSv6b6sjvYJh/ve29fg2qptz50MtTwJNYvzb+y76u6SDQGXgBoi4sWjc
   B3sJ2jWsqZ5j3/QNnRRjyrCFlav8VW9R0vSFBsVDO1QGK9/d2h7GZlB+E
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="311875956"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="311875956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 10:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="619649467"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="619649467"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Feb 2023 10:47:00 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSMnz-0009gD-2P;
        Wed, 15 Feb 2023 18:46:59 +0000
Date:   Thu, 16 Feb 2023 02:46:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@kernel.org>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 2/7] drbd: Add peer device parameter to whole-bitmap I/O
 handlers
Message-ID: <202302160243.r4vaCKlw-lkp@intel.com>
References: <20230215163204.2856631-3-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215163204.2856631-3-christoph.boehmwalder@linbit.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I love your patch! Perhaps something to improve:

[auto build test WARNING on a06377c5d01eeeaa52ad979b62c3c72efcc3eff0]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-Rip-out-the-ERR_IF_CNT_IS_NEGATIVE-macro/20230216-003454
base:   a06377c5d01eeeaa52ad979b62c3c72efcc3eff0
patch link:    https://lore.kernel.org/r/20230215163204.2856631-3-christoph.boehmwalder%40linbit.com
patch subject: [PATCH 2/7] drbd: Add peer device parameter to whole-bitmap I/O handlers
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230216/202302160243.r4vaCKlw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e55221e8a69f80303803dab7e079bff7b698ea02
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christoph-B-hmwalder/drbd-Rip-out-the-ERR_IF_CNT_IS_NEGATIVE-macro/20230216-003454
        git checkout e55221e8a69f80303803dab7e079bff7b698ea02
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/block/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302160243.r4vaCKlw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/drbd_genl_api.h:54,
                    from drivers/block/drbd/drbd_int.h:35,
                    from drivers/block/drbd/drbd_nl.c:24:
   include/linux/drbd_genl_api.h:51:33: warning: no previous prototype for 'drbd_genl_cmd_to_str' [-Wmissing-prototypes]
      51 | #define GENL_MAGIC_FAMILY       drbd
         |                                 ^~~~
   include/linux/genl_magic_struct.h:20:25: note: in definition of macro 'CONCAT__'
      20 | #define CONCAT__(a,b)   a ## b
         |                         ^
   include/linux/genl_magic_func.h:212:13: note: in expansion of macro 'CONCAT_'
     212 | const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
         |             ^~~~~~~
   include/linux/genl_magic_func.h:212:21: note: in expansion of macro 'GENL_MAGIC_FAMILY'
     212 | const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
         |                     ^~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_determine_dev_size':
>> drivers/block/drbd/drbd_nl.c:1055:70: warning: pointer type mismatch in conditional expression
    1055 |                 drbd_bitmap_io(device, md_moved ? &drbd_bm_write_all : &drbd_bm_write,
         |                                                                      ^
   drivers/block/drbd/drbd_nl.c:1055:17: error: too many arguments to function 'drbd_bitmap_io'
    1055 |                 drbd_bitmap_io(device, md_moved ? &drbd_bm_write_all : &drbd_bm_write,
         |                 ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_attach':
   drivers/block/drbd/drbd_nl.c:2029:21: error: too many arguments to function 'drbd_bitmap_io'
    2029 |                 if (drbd_bitmap_io(device, &drbd_bmio_set_n_write,
         |                     ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c:2036:21: error: too many arguments to function 'drbd_bitmap_io'
    2036 |                 if (drbd_bitmap_io(device, &drbd_bm_read,
         |                     ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_invalidate':
   drivers/block/drbd/drbd_nl.c:2976:29: error: too many arguments to function 'drbd_bitmap_io'
    2976 |                         if (drbd_bitmap_io(device, &drbd_bmio_set_n_write,
         |                             ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_bmio_set_susp_al':
   drivers/block/drbd/drbd_nl.c:3014:14: error: too few arguments to function 'drbd_bmio_set_n_write'
    3014 |         rv = drbd_bmio_set_n_write(device);
         |              ^~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1078:12: note: declared here
    1078 | extern int drbd_bmio_set_n_write(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_invalidate_peer':
   drivers/block/drbd/drbd_nl.c:3055:52: error: passing argument 2 of 'drbd_bitmap_io' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3055 |                         if (drbd_bitmap_io(device, &drbd_bmio_set_susp_al,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~
         |                                                    |
         |                                                    int (*)(struct drbd_device *)
   drivers/block/drbd/drbd_int.h:1073:23: note: expected 'int (*)(struct drbd_device *, struct drbd_peer_device *)' but argument is of type 'int (*)(struct drbd_device *)'
    1073 |                 int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c:3055:29: error: too many arguments to function 'drbd_bitmap_io'
    3055 |                         if (drbd_bitmap_io(device, &drbd_bmio_set_susp_al,
         |                             ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_new_c_uuid':
   drivers/block/drbd/drbd_nl.c:4152:23: error: too many arguments to function 'drbd_bitmap_io'
    4152 |                 err = drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
         |                       ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1055 drivers/block/drbd/drbd_nl.c

b411b3637fa71f Philipp Reisner     2009-09-25   921  
a425711c6c9c85 Lee Jones           2021-03-12   922  /*
b411b3637fa71f Philipp Reisner     2009-09-25   923   * drbd_determine_dev_size() -  Sets the right device size obeying all constraints
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03   924   * @device:	DRBD device.
b411b3637fa71f Philipp Reisner     2009-09-25   925   *
b411b3637fa71f Philipp Reisner     2009-09-25   926   * Returns 0 on success, negative return values indicate errors.
b411b3637fa71f Philipp Reisner     2009-09-25   927   * You should call drbd_md_sync() after calling this function.
b411b3637fa71f Philipp Reisner     2009-09-25   928   */
d752b2696072ed Philipp Reisner     2013-06-25   929  enum determine_dev_size
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03   930  drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct resize_parms *rs) __must_hold(local)
b411b3637fa71f Philipp Reisner     2009-09-25   931  {
8011e2490907c2 Lars Ellenberg      2015-06-08   932  	struct md_offsets_and_sizes {
8011e2490907c2 Lars Ellenberg      2015-06-08   933  		u64 last_agreed_sect;
8011e2490907c2 Lars Ellenberg      2015-06-08   934  		u64 md_offset;
8011e2490907c2 Lars Ellenberg      2015-06-08   935  		s32 al_offset;
8011e2490907c2 Lars Ellenberg      2015-06-08   936  		s32 bm_offset;
8011e2490907c2 Lars Ellenberg      2015-06-08   937  		u32 md_size_sect;
8011e2490907c2 Lars Ellenberg      2015-06-08   938  
8011e2490907c2 Lars Ellenberg      2015-06-08   939  		u32 al_stripes;
8011e2490907c2 Lars Ellenberg      2015-06-08   940  		u32 al_stripe_size_4k;
8011e2490907c2 Lars Ellenberg      2015-06-08   941  	} prev;
8011e2490907c2 Lars Ellenberg      2015-06-08   942  	sector_t u_size, size;
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03   943  	struct drbd_md *md = &device->ldev->md;
d752b2696072ed Philipp Reisner     2013-06-25   944  	void *buffer;
b411b3637fa71f Philipp Reisner     2009-09-25   945  
b411b3637fa71f Philipp Reisner     2009-09-25   946  	int md_moved, la_size_changed;
e96c96333fe5a4 Philipp Reisner     2013-06-25   947  	enum determine_dev_size rv = DS_UNCHANGED;
b411b3637fa71f Philipp Reisner     2009-09-25   948  
5f7c01249bea67 Lars Ellenberg      2015-06-08   949  	/* We may change the on-disk offsets of our meta data below.  Lock out
5f7c01249bea67 Lars Ellenberg      2015-06-08   950  	 * anything that may cause meta data IO, to avoid acting on incomplete
5f7c01249bea67 Lars Ellenberg      2015-06-08   951  	 * layout changes or scribbling over meta data that is in the process
5f7c01249bea67 Lars Ellenberg      2015-06-08   952  	 * of being moved.
b411b3637fa71f Philipp Reisner     2009-09-25   953  	 *
5f7c01249bea67 Lars Ellenberg      2015-06-08   954  	 * Move is not exactly correct, btw, currently we have all our meta
5f7c01249bea67 Lars Ellenberg      2015-06-08   955  	 * data in core memory, to "move" it we just write it all out, there
5f7c01249bea67 Lars Ellenberg      2015-06-08   956  	 * are no reads. */
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03   957  	drbd_suspend_io(device);
e37d2438d8e5e4 Lars Ellenberg      2014-04-01   958  	buffer = drbd_md_get_buffer(device, __func__); /* Lock meta-data IO */
d752b2696072ed Philipp Reisner     2013-06-25   959  	if (!buffer) {
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03   960  		drbd_resume_io(device);
d752b2696072ed Philipp Reisner     2013-06-25   961  		return DS_ERROR;
d752b2696072ed Philipp Reisner     2013-06-25   962  	}
b411b3637fa71f Philipp Reisner     2009-09-25   963  
8011e2490907c2 Lars Ellenberg      2015-06-08   964  	/* remember current offset and sizes */
8011e2490907c2 Lars Ellenberg      2015-06-08   965  	prev.last_agreed_sect = md->la_size_sect;
8011e2490907c2 Lars Ellenberg      2015-06-08   966  	prev.md_offset = md->md_offset;
8011e2490907c2 Lars Ellenberg      2015-06-08   967  	prev.al_offset = md->al_offset;
8011e2490907c2 Lars Ellenberg      2015-06-08   968  	prev.bm_offset = md->bm_offset;
8011e2490907c2 Lars Ellenberg      2015-06-08   969  	prev.md_size_sect = md->md_size_sect;
8011e2490907c2 Lars Ellenberg      2015-06-08   970  	prev.al_stripes = md->al_stripes;
8011e2490907c2 Lars Ellenberg      2015-06-08   971  	prev.al_stripe_size_4k = md->al_stripe_size_4k;
b411b3637fa71f Philipp Reisner     2009-09-25   972  
d752b2696072ed Philipp Reisner     2013-06-25   973  	if (rs) {
d752b2696072ed Philipp Reisner     2013-06-25   974  		/* rs is non NULL if we should change the AL layout only */
d752b2696072ed Philipp Reisner     2013-06-25   975  		md->al_stripes = rs->al_stripes;
d752b2696072ed Philipp Reisner     2013-06-25   976  		md->al_stripe_size_4k = rs->al_stripe_size / 4;
d752b2696072ed Philipp Reisner     2013-06-25   977  		md->al_size_4k = (u64)rs->al_stripes * rs->al_stripe_size / 4;
d752b2696072ed Philipp Reisner     2013-06-25   978  	}
d752b2696072ed Philipp Reisner     2013-06-25   979  
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03   980  	drbd_md_set_sector_offsets(device, device->ldev);
b411b3637fa71f Philipp Reisner     2009-09-25   981  
daeda1cca91d58 Philipp Reisner     2011-05-03   982  	rcu_read_lock();
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03   983  	u_size = rcu_dereference(device->ldev->disk_conf)->disk_size;
daeda1cca91d58 Philipp Reisner     2011-05-03   984  	rcu_read_unlock();
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03   985  	size = drbd_new_dev_size(device, device->ldev, u_size, flags & DDSF_FORCED);
b411b3637fa71f Philipp Reisner     2009-09-25   986  
8011e2490907c2 Lars Ellenberg      2015-06-08   987  	if (size < prev.last_agreed_sect) {
d752b2696072ed Philipp Reisner     2013-06-25   988  		if (rs && u_size == 0) {
d752b2696072ed Philipp Reisner     2013-06-25   989  			/* Remove "rs &&" later. This check should always be active, but
d752b2696072ed Philipp Reisner     2013-06-25   990  			   right now the receiver expects the permissive behavior */
d01801710265cf Andreas Gruenbacher 2011-07-03   991  			drbd_warn(device, "Implicit shrink not allowed. "
d752b2696072ed Philipp Reisner     2013-06-25   992  				 "Use --size=%llus for explicit shrink.\n",
d752b2696072ed Philipp Reisner     2013-06-25   993  				 (unsigned long long)size);
d752b2696072ed Philipp Reisner     2013-06-25   994  			rv = DS_ERROR_SHRINK;
d752b2696072ed Philipp Reisner     2013-06-25   995  		}
d752b2696072ed Philipp Reisner     2013-06-25   996  		if (u_size > size)
d752b2696072ed Philipp Reisner     2013-06-25   997  			rv = DS_ERROR_SPACE_MD;
d752b2696072ed Philipp Reisner     2013-06-25   998  		if (rv != DS_UNCHANGED)
d752b2696072ed Philipp Reisner     2013-06-25   999  			goto err_out;
d752b2696072ed Philipp Reisner     2013-06-25  1000  	}
d752b2696072ed Philipp Reisner     2013-06-25  1001  
155bd9d1abd604 Christoph Hellwig   2020-09-25  1002  	if (get_capacity(device->vdisk) != size ||
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1003  	    drbd_bm_capacity(device) != size) {
b411b3637fa71f Philipp Reisner     2009-09-25  1004  		int err;
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1005  		err = drbd_bm_resize(device, size, !(flags & DDSF_NO_RESYNC));
b411b3637fa71f Philipp Reisner     2009-09-25  1006  		if (unlikely(err)) {
b411b3637fa71f Philipp Reisner     2009-09-25  1007  			/* currently there is only one error: ENOMEM! */
8011e2490907c2 Lars Ellenberg      2015-06-08  1008  			size = drbd_bm_capacity(device);
b411b3637fa71f Philipp Reisner     2009-09-25  1009  			if (size == 0) {
d01801710265cf Andreas Gruenbacher 2011-07-03  1010  				drbd_err(device, "OUT OF MEMORY! "
b411b3637fa71f Philipp Reisner     2009-09-25  1011  				    "Could not allocate bitmap!\n");
b411b3637fa71f Philipp Reisner     2009-09-25  1012  			} else {
d01801710265cf Andreas Gruenbacher 2011-07-03  1013  				drbd_err(device, "BM resizing failed. "
8011e2490907c2 Lars Ellenberg      2015-06-08  1014  				    "Leaving size unchanged\n");
b411b3637fa71f Philipp Reisner     2009-09-25  1015  			}
e96c96333fe5a4 Philipp Reisner     2013-06-25  1016  			rv = DS_ERROR;
b411b3637fa71f Philipp Reisner     2009-09-25  1017  		}
b411b3637fa71f Philipp Reisner     2009-09-25  1018  		/* racy, see comments above. */
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1019  		drbd_set_my_capacity(device, size);
8011e2490907c2 Lars Ellenberg      2015-06-08  1020  		md->la_size_sect = size;
b411b3637fa71f Philipp Reisner     2009-09-25  1021  	}
d752b2696072ed Philipp Reisner     2013-06-25  1022  	if (rv <= DS_ERROR)
d752b2696072ed Philipp Reisner     2013-06-25  1023  		goto err_out;
b411b3637fa71f Philipp Reisner     2009-09-25  1024  
8011e2490907c2 Lars Ellenberg      2015-06-08  1025  	la_size_changed = (prev.last_agreed_sect != md->la_size_sect);
b411b3637fa71f Philipp Reisner     2009-09-25  1026  
8011e2490907c2 Lars Ellenberg      2015-06-08  1027  	md_moved = prev.md_offset    != md->md_offset
8011e2490907c2 Lars Ellenberg      2015-06-08  1028  		|| prev.md_size_sect != md->md_size_sect;
b411b3637fa71f Philipp Reisner     2009-09-25  1029  
d752b2696072ed Philipp Reisner     2013-06-25  1030  	if (la_size_changed || md_moved || rs) {
d752b2696072ed Philipp Reisner     2013-06-25  1031  		u32 prev_flags;
24dccabb390412 Andreas Gruenbacher 2010-12-12  1032  
fcb096740a13c8 Lars Ellenberg      2014-01-27  1033  		/* We do some synchronous IO below, which may take some time.
fcb096740a13c8 Lars Ellenberg      2014-01-27  1034  		 * Clear the timer, to avoid scary "timer expired!" messages,
fcb096740a13c8 Lars Ellenberg      2014-01-27  1035  		 * "Superblock" is written out at least twice below, anyways. */
fcb096740a13c8 Lars Ellenberg      2014-01-27  1036  		del_timer(&device->md_sync_timer);
d752b2696072ed Philipp Reisner     2013-06-25  1037  
5f7c01249bea67 Lars Ellenberg      2015-06-08  1038  		/* We won't change the "al-extents" setting, we just may need
5f7c01249bea67 Lars Ellenberg      2015-06-08  1039  		 * to move the on-disk location of the activity log ringbuffer.
5f7c01249bea67 Lars Ellenberg      2015-06-08  1040  		 * Lock for transaction is good enough, it may well be "dirty"
5f7c01249bea67 Lars Ellenberg      2015-06-08  1041  		 * or even "starving". */
5f7c01249bea67 Lars Ellenberg      2015-06-08  1042  		wait_event(device->al_wait, lc_try_lock_for_transaction(device->act_log));
5f7c01249bea67 Lars Ellenberg      2015-06-08  1043  
5f7c01249bea67 Lars Ellenberg      2015-06-08  1044  		/* mark current on-disk bitmap and activity log as unreliable */
d752b2696072ed Philipp Reisner     2013-06-25  1045  		prev_flags = md->flags;
5f7c01249bea67 Lars Ellenberg      2015-06-08  1046  		md->flags |= MDF_FULL_SYNC | MDF_AL_DISABLED;
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1047  		drbd_md_write(device, buffer);
d752b2696072ed Philipp Reisner     2013-06-25  1048  
5f7c01249bea67 Lars Ellenberg      2015-06-08  1049  		drbd_al_initialize(device, buffer);
5f7c01249bea67 Lars Ellenberg      2015-06-08  1050  
d01801710265cf Andreas Gruenbacher 2011-07-03  1051  		drbd_info(device, "Writing the whole bitmap, %s\n",
b411b3637fa71f Philipp Reisner     2009-09-25  1052  			 la_size_changed && md_moved ? "size changed and md moved" :
b411b3637fa71f Philipp Reisner     2009-09-25  1053  			 la_size_changed ? "size changed" : "md moved");
20ceb2b22edaf5 Lars Ellenberg      2011-01-21  1054  		/* next line implicitly does drbd_suspend_io()+drbd_resume_io() */
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03 @1055  		drbd_bitmap_io(device, md_moved ? &drbd_bm_write_all : &drbd_bm_write,
e55221e8a69f80 Andreas Gruenbacher 2023-02-15  1056  			       "size changed", BM_LOCKED_MASK, NULL);
d752b2696072ed Philipp Reisner     2013-06-25  1057  
5f7c01249bea67 Lars Ellenberg      2015-06-08  1058  		/* on-disk bitmap and activity log is authoritative again
5f7c01249bea67 Lars Ellenberg      2015-06-08  1059  		 * (unless there was an IO error meanwhile...) */
d752b2696072ed Philipp Reisner     2013-06-25  1060  		md->flags = prev_flags;
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1061  		drbd_md_write(device, buffer);
d752b2696072ed Philipp Reisner     2013-06-25  1062  
d752b2696072ed Philipp Reisner     2013-06-25  1063  		if (rs)
d01801710265cf Andreas Gruenbacher 2011-07-03  1064  			drbd_info(device, "Changed AL layout to al-stripes = %d, al-stripe-size-kB = %d\n",
d752b2696072ed Philipp Reisner     2013-06-25  1065  				  md->al_stripes, md->al_stripe_size_4k * 4);
b411b3637fa71f Philipp Reisner     2009-09-25  1066  	}
b411b3637fa71f Philipp Reisner     2009-09-25  1067  
8011e2490907c2 Lars Ellenberg      2015-06-08  1068  	if (size > prev.last_agreed_sect)
8011e2490907c2 Lars Ellenberg      2015-06-08  1069  		rv = prev.last_agreed_sect ? DS_GREW : DS_GREW_FROM_ZERO;
8011e2490907c2 Lars Ellenberg      2015-06-08  1070  	if (size < prev.last_agreed_sect)
e96c96333fe5a4 Philipp Reisner     2013-06-25  1071  		rv = DS_SHRUNK;
d752b2696072ed Philipp Reisner     2013-06-25  1072  
d752b2696072ed Philipp Reisner     2013-06-25  1073  	if (0) {
d752b2696072ed Philipp Reisner     2013-06-25  1074  	err_out:
8011e2490907c2 Lars Ellenberg      2015-06-08  1075  		/* restore previous offset and sizes */
8011e2490907c2 Lars Ellenberg      2015-06-08  1076  		md->la_size_sect = prev.last_agreed_sect;
8011e2490907c2 Lars Ellenberg      2015-06-08  1077  		md->md_offset = prev.md_offset;
8011e2490907c2 Lars Ellenberg      2015-06-08  1078  		md->al_offset = prev.al_offset;
8011e2490907c2 Lars Ellenberg      2015-06-08  1079  		md->bm_offset = prev.bm_offset;
8011e2490907c2 Lars Ellenberg      2015-06-08  1080  		md->md_size_sect = prev.md_size_sect;
8011e2490907c2 Lars Ellenberg      2015-06-08  1081  		md->al_stripes = prev.al_stripes;
8011e2490907c2 Lars Ellenberg      2015-06-08  1082  		md->al_stripe_size_4k = prev.al_stripe_size_4k;
8011e2490907c2 Lars Ellenberg      2015-06-08  1083  		md->al_size_4k = (u64)prev.al_stripes * prev.al_stripe_size_4k;
d752b2696072ed Philipp Reisner     2013-06-25  1084  	}
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1085  	lc_unlock(device->act_log);
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1086  	wake_up(&device->al_wait);
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1087  	drbd_md_put_buffer(device);
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1088  	drbd_resume_io(device);
b411b3637fa71f Philipp Reisner     2009-09-25  1089  
b411b3637fa71f Philipp Reisner     2009-09-25  1090  	return rv;
b411b3637fa71f Philipp Reisner     2009-09-25  1091  }
b411b3637fa71f Philipp Reisner     2009-09-25  1092  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
