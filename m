Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24256E9872
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjDTPgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDTPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:36:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1575581;
        Thu, 20 Apr 2023 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682005007; x=1713541007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iO/i2tt5DEzt8gruW8+zs93sVMgkJU4X3e0uYovtxx8=;
  b=Xcmt9R/LozyKo+AlCCS4SPBwcVfJgdODNuBGbRQSpqvqUnbK3sDI3WWI
   Ai9hQm5jAvuUV2y3tE+tkWgpzj8oh8jaE5qTq8qItSuygO3ur+XtgZCyi
   Pk71I+UdVneHTCpxXlD4D6ZGboWGAahcA9V5GMYvnzTvu63eq6ITxudyW
   oWQUfYN6nfA+u8pFno9gA26F7D9haAaM4rkPcD6cmSL8H8+RUCOEK6iHD
   z8r/+l/H6W+NV/yuJTfHjNZ7YZI+nY5/GP/kKR3+zH2xNq458Aw/vOLqv
   nSsX+C06jjP1Ux5uqJ9VKQtCex5+fu7ZuFC0nIXEb5M6DKuANcbyNfVlc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348533242"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348533242"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 08:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="756537428"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="756537428"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2023 08:36:44 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppWKx-000fuA-2b;
        Thu, 20 Apr 2023 15:36:43 +0000
Date:   Thu, 20 Apr 2023 23:35:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Song Liu <song@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] md/md-multipath: guard against a possible NULL
 dereference
Message-ID: <202304202346.fddWOoq1-lkp@intel.com>
References: <20230420071851.326726-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420071851.326726-1-d-tatianin@yandex-team.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniil,

kernel test robot noticed the following build errors:

[auto build test ERROR on song-md/md-next]
[also build test ERROR on linus/master v6.3-rc7 next-20230419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniil-Tatianin/md-md-multipath-guard-against-a-possible-NULL-dereference/20230420-152235
base:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
patch link:    https://lore.kernel.org/r/20230420071851.326726-1-d-tatianin%40yandex-team.ru
patch subject: [PATCH] md/md-multipath: guard against a possible NULL dereference
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230420/202304202346.fddWOoq1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3b0e378bb2e165f35044ecb535fb1ed973ea392e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniil-Tatianin/md-md-multipath-guard-against-a-possible-NULL-dereference/20230420-152235
        git checkout 3b0e378bb2e165f35044ecb535fb1ed973ea392e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304202346.fddWOoq1-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/md/md-multipath.c: In function 'multipath_make_request':
>> drivers/md/md-multipath.c:111:14: error: 'map_bh' undeclared (first use in this function); did you mean 'mp_bh'?
     111 |         if (!map_bh)
         |              ^~~~~~
         |              mp_bh
   drivers/md/md-multipath.c:111:14: note: each undeclared identifier is reported only once for each function it appears in


vim +111 drivers/md/md-multipath.c

    99	
   100	static bool multipath_make_request(struct mddev *mddev, struct bio * bio)
   101	{
   102		struct mpconf *conf = mddev->private;
   103		struct multipath_bh * mp_bh;
   104		struct multipath_info *multipath;
   105	
   106		if (unlikely(bio->bi_opf & REQ_PREFLUSH)
   107		    && md_flush_request(mddev, bio))
   108			return true;
   109	
   110		mp_bh = mempool_alloc(&conf->pool, GFP_NOIO);
 > 111		if (!map_bh)
   112			return false;
   113	
   114		mp_bh->master_bio = bio;
   115		mp_bh->mddev = mddev;
   116	
   117		mp_bh->path = multipath_map(conf);
   118		if (mp_bh->path < 0) {
   119			bio_io_error(bio);
   120			mempool_free(mp_bh, &conf->pool);
   121			return true;
   122		}
   123		multipath = conf->multipaths + mp_bh->path;
   124	
   125		bio_init_clone(multipath->rdev->bdev, &mp_bh->bio, bio, GFP_NOIO);
   126	
   127		mp_bh->bio.bi_iter.bi_sector += multipath->rdev->data_offset;
   128		mp_bh->bio.bi_opf |= REQ_FAILFAST_TRANSPORT;
   129		mp_bh->bio.bi_end_io = multipath_end_request;
   130		mp_bh->bio.bi_private = mp_bh;
   131		mddev_check_write_zeroes(mddev, &mp_bh->bio);
   132		submit_bio_noacct(&mp_bh->bio);
   133		return true;
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
